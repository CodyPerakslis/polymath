import java.util.stream.StreamSupport;
import java.util.stream.Stream;

/* Challenge:
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
*/

public class PrimeSum{
  public static void main(String[] args) {
    Sieve s = new Sieve(2000000);
    Stream<Integer> primes = StreamSupport.stream(s, false);
    long result = primes.mapToLong(Integer::intValue).sum();
    System.out.println(result);
  }
}
