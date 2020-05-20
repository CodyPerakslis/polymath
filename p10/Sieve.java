import java.util.Spliterator;
import java.util.function.Consumer;
import java.lang.Math;

/*
Sieve Method as a Spliterator,
which can be turned into a stream of prime numbers.
*/

public class Sieve implements Spliterator<Integer> {
  private int[] sieve;
  private int size;
  private int current;
  private int stopper;

  Sieve() {
    this.size = 0;
    this.current = 0;
    this.stopper = 0;
  }
  Sieve(int size) {
    this.set(size);
  }

  public void set(int size) {
    this.sieve = new int[size-2];
    for (int i=0; i < size-2; i++) {this.sieve[i] = i+2;}
    this.size = size-2;
    this.current = 0;
    this.stopper = (int) Math.round(Math.sqrt(size-2))+1;
  }

  @Override
  public boolean tryAdvance(Consumer<? super Integer> action) {
    int next = getNext();
    if (next > 0) {
      action.accept(next);
      return true;
    }
    return false;
  }

  @Override
  public Spliterator<Integer> trySplit() {return null;}

  @Override
  public long estimateSize() {
    return Long.valueOf(1+this.pi(this.size) - this.pi(this.current));
  }

  @Override
  public int characteristics() {
    return Spliterator.ORDERED
      | Spliterator.DISTINCT
      | Spliterator.NONNULL
      | Spliterator.IMMUTABLE;
  }

  private int getNext() {
    while (this.current < this.size) {
      if (this.sieve[this.current++] > 0) {
        this.clearSieve(this.current-1);
        return this.sieve[this.current-1];
      }
    }
    return -1;
  }

  private void clearSieve(int index) {
    int value = this.sieve[index];
    if (value < this.stopper) {
      for(int i = index+value; i < this.size; i += value) {
        this.sieve[i] = 0;
      }
    }
  }

  private int pi(int x) {
    return (int)Math.round(x/Math.log10(x));
  }

}
