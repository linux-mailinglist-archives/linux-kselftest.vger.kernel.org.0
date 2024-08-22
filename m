Return-Path: <linux-kselftest+bounces-15983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1D95AB72
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 04:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EE1F242E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 02:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95829185941;
	Thu, 22 Aug 2024 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DBCjxn5J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111D15B134;
	Thu, 22 Aug 2024 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295139; cv=none; b=Z2oPsx0XTxdfL1Y8PN63Yjba8z8lqYXp9xcvPclJZUj67wDWVPhkmcIVRuPADgLX01SqUS7uqP9SuG1GSGzyrn18VuYS5q6PjRLGUKzID7UZh5NbQsbw4u5lRuwS5N0vuH0xBuFUhpJdFR47fWD3NekxmW/fo+4TFbmHFYknjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295139; c=relaxed/simple;
	bh=9QVy49R6gNHL9cLSRwlvMCQQ2PJFrtE8pdup+rgm8d8=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=XebyVuZRFd0gENv4XntgXOZsv2M1UOrkCrSgDtte6VZ2V6aJhWY3WI1mwnkUopWLRx5p5Qjy6DvCboShuidEcIHk2oyHRw6/39swj0fV+9mLHbU4Y+WkFtXGMoAg7FgjF4IWujRR3Vbx27z7CEY8RYHQdc68vnJzPxY0sogFzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DBCjxn5J; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724295129; bh=3ag1cOHVmxBybWIBowT1HEBR7lBqQ/qgYWUC/34ng/g=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=DBCjxn5JB1TsoivhpC1SqDE6uNZTYHuc/mh9hDIMxEpoqqzpZBXcLv+8OSuyhrnRY
	 AMX6jTqgOJNhGGKEbuWW/8ztIyB8dEpkODSmhbQRQ18+IHpLMQuwH+WRP+WL83LHtU
	 6LtiUkFxXdVj5v7pjXAmGfIyz4IeSKK2kvrEP70g=
Received: from smtpclient.apple ([115.238.42.178])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id D05176EE; Thu, 22 Aug 2024 10:52:05 +0800
X-QQ-mid: xmsmtpt1724295125th7r105br
Message-ID: <tencent_86551D71707162B243861AC9F8EC0573B409@qq.com>
X-QQ-XMAILINFO: N5sfBKY/oC4kp5vgaJMJDoOUXI0Ivw7aTJ/jz8M3cADNSpgDh1jLIMXujDK7Ph
	 RvdaJ28EK8dqVoOm4PlugjQvl6uQATfg+QBjnf0EE5XwSpb5sLioY4kt7bexkWqVU+sY1zKqe59N
	 tFQdM1R2iY9JhhAWE32IVhxxxUP9N4RSzDx54D0FGk6EF28yM6MdnP3p+vsTx40Atan0UI7onR3E
	 h5chnTU2SbkwBXHq4+cYfYOOTTeZo1s4gMkxrLMIM5JWgfiW/AtfcCFMNm5FY+AduT5UnufXfRLL
	 QoLydu4wxNt/EyViOYpPbPWFjFBOHzuABGCj8ZtJX5rgu8+SWE/IQE/jrGgN8k8h2sAL6Ledsm2Q
	 uAhg3MAyCmT5TO2LmR5GUmWvE6qqjao71bQNbk19gDw7NM2m0Lz15XqhyeOduXf7Hh7Mr/5O+UiV
	 CWM/qN2y0zl7Wo+fKM92VgSv0dQFiFMZAzsL327SUoec0+NV8r8K5yZejg+se0miY22Rvb8/8ORs
	 B+i2MRpwM1cqBT3ZF0ckITt3opBEz5rKQi3NOWYkaD3rlv8I6Mxyly8ArMfBI2CaK4hzcEoK2gzy
	 dCSv7qThPEkX3Oww4DzAik5updoqwLcXakcMgfC+w5zOfTl1/ykxSTRe6GDB5d3VhvDGVW6nc4nI
	 Q5XD+yHIoA5bcYgzzotjw95PVshh3gA1yv9leGwuWD8jO2a4w9b/6WFc9BOxK1Dw9fH79bHYcdZ0
	 iiZpp2OCoF73ZK5InR9umkuFw6/vRBC7pl3Hp4hzqLELDPbpdrTmVt/V/iqSWF+g2wBozJS/wLVF
	 1p7/MSLb8OlKn/rBFWOvSe9WjnM0Fzp5AjhpFdHOxVTzP5jrf9ytMwTgRflgkoU4bcMs7jP4l6hk
	 qVu/QSrDB6j0vLw32FSgQMxMLyfuhwEtfAablV76ejjsUwyTwuATMwXQduuBKZt7fbIDty9UQaPH
	 CBNhpwddJLSa801S3ku0nE8gjBxalJ
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <mhng-7d9e2b27-a53d-4579-b78e-0aec038290fb@palmer-ri-x1c9>
Date: Thu, 22 Aug 2024 10:51:54 +0800
Cc: rsworktech@outlook.com,
 Charlie Jenkins <charlie@rivosinc.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org,
 linux-riscv@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <13A56B67-7705-4823-9613-61CFBE5DBDCA@cyyself.name>
References: <mhng-7d9e2b27-a53d-4579-b78e-0aec038290fb@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@dabbelt.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On Aug 22, 2024, at 06:17, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>=20
> On Mon, 19 Aug 2024 18:58:18 PDT (-0700), rsworktech@outlook.com =
wrote:
>> On 2024-08-20 01:00, Charlie Jenkins wrote:
>>> On Mon, Aug 19, 2024 at 01:55:57PM +0800, Levi Zim wrote:
>>>> On 2024-03-22 22:06, Palmer Dabbelt wrote:
>>>>> On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
>>>>>> On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
>>>>>>> On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
>>>>>>>> On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
>>>>>>>>> On riscv it is guaranteed that the address returned by mmap is =
less
>>>>>>>>> than
>>>>>>>>> the hint address. Allow mmap to return an address all the way =
up to
>>>>>>>>> addr, if provided, rather than just up to the lower address =
space.
>>>>>>>>>>> This provides a performance benefit as well, allowing
>>>>>>> mmap to exit
>>>>>>>>> after
>>>>>>>>> checking that the address is in range rather than searching =
for a
>>>>>>>>> valid
>>>>>>>>> address.
>>>>>>>>>>> It is possible to provide an address that uses at most the =
same
>>>>>>>>> number
>>>>>>>>> of bits, however it is significantly more computationally =
expensive
>>>>>>>>> to
>>>>>>>>> provide that number rather than setting the max to be the hint
>>>>>>>>> address.
>>>>>>>>> There is the instruction clz/clzw in Zbb that returns the =
highest
>>>>>>>>> set
>>>>>>>>> bit
>>>>>>>>> which could be used to performantly implement this, but it =
would
>>>>>>>>> still
>>>>>>>>> be slower than the current implementation. At worst case, half =
of
>>>>>>>>> the
>>>>>>>>> address would not be able to be allocated when a hint address =
is
>>>>>>>>> provided.
>>>>>>>>>>> Signed-off-by: Charlie Jenkins<charlie@rivosinc.com>
>>>>>>>>> ---
>>>>>>>>>  arch/riscv/include/asm/processor.h | 27 =
+++++++++++---------------
>>>>>>>>> -
>>>>>>>>>  1 file changed, 11 insertions(+), 16 deletions(-)
>>>>>>>>>>> diff --git a/arch/riscv/include/asm/processor.h
>>>>>>>>> b/arch/riscv/include/asm/processor.h
>>>>>>>>> index f19f861cda54..8ece7a8f0e18 100644
>>>>>>>>> --- a/arch/riscv/include/asm/processor.h
>>>>>>>>> +++ b/arch/riscv/include/asm/processor.h
>>>>>>>>> @@ -14,22 +14,16 @@
>>>>>>>>>=20
>>>>>>>>>  #include <asm/ptrace.h>
>>>>>>>>>=20
>>>>>>>>> -#ifdef CONFIG_64BIT
>>>>>>>>> -#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>>>>>>>> -#define STACK_TOP_MAX        TASK_SIZE_64
>>>>>>>>> -
>>>>>>>>>  #define arch_get_mmap_end(addr, len, flags)            \
>>>>>>>>>  ({                                \
>>>>>>>>>      unsigned long
>>>>>>>>> mmap_end;                    \
>>>>>>>>>      typeof(addr) _addr =3D (addr);                \
>>>>>>>>> -    if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>>>>>>>> is_compat_task())) \
>>>>>>>>> +    if ((_addr) =3D=3D 0 ||                    \
>>>>>>>>> +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    =
\
>>>>>>>>> +        ((_addr + len) > BIT(VA_BITS -
>>>>>>>>> 1)))            \
>>>>>>>>>          mmap_end =3D STACK_TOP_MAX;            \
>>>>>>>>> -    else if ((_addr) >=3D VA_USER_SV57) \
>>>>>>>>> -        mmap_end =3D STACK_TOP_MAX;            \
>>>>>>>>> -    else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D
>>>>>>>>> VA_BITS_SV48)) \
>>>>>>>>> -        mmap_end =3D VA_USER_SV48;            \
>>>>>>>>>      else                            \
>>>>>>>>> -        mmap_end =3D VA_USER_SV39;            \
>>>>>>>>> +        mmap_end =3D (_addr + len);            \
>>>>>>>>>      mmap_end;                        \
>>>>>>>>>  })
>>>>>>>>>=20
>>>>>>>>> @@ -39,17 +33,18 @@
>>>>>>>>>      typeof(addr) _addr =3D (addr);                \
>>>>>>>>>      typeof(base) _base =3D (base);                \
>>>>>>>>>      unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base);   =
 \
>>>>>>>>> -    if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>>>>>>>> is_compat_task())) \
>>>>>>>>> +    if ((_addr) =3D=3D 0 ||                    \
>>>>>>>>> +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    =
\
>>>>>>>>> +        ((_addr + len) > BIT(VA_BITS -
>>>>>>>>> 1)))            \
>>>>>>>>>          mmap_base =3D (_base);                \
>>>>>>>>> -    else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D
>>>>>>>>> VA_BITS_SV57)) \
>>>>>>>>> -        mmap_base =3D VA_USER_SV57 - rnd_gap; \
>>>>>>>>> -    else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D
>>>>>>>>> VA_BITS_SV48)) \
>>>>>>>>> -        mmap_base =3D VA_USER_SV48 - rnd_gap; \
>>>>>>>>>      else                            \
>>>>>>>>> -        mmap_base =3D VA_USER_SV39 - rnd_gap; \
>>>>>>>>> +        mmap_base =3D (_addr + len) - rnd_gap; \
>>>>>>>>>      mmap_base;                        \
>>>>>>>>>  })
>>>>>>>>>=20
>>>>>>>>> +#ifdef CONFIG_64BIT
>>>>>>>>> +#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>>>>>>>> +#define STACK_TOP_MAX        TASK_SIZE_64
>>>>>>>>>  #else
>>>>>>>>>  #define DEFAULT_MAP_WINDOW    TASK_SIZE
>>>>>>>>>  #define STACK_TOP_MAX        TASK_SIZE
>>>>>>>>>>> I have carefully tested your patch on qemu with sv57. A
>>>>>>> bug that
>>>>>>>> needs
>>>>>>>> to be solved is that mmap with the same hint address without
>>>>>>>> MAP_FIXED
>>>>>>>> set will fail the second time.
>>>>>>>>> Userspace code to reproduce the bug:
>>>>>>>>> #include <sys/mman.h>
>>>>>>>> #include <stdio.h>
>>>>>>>> #include <stdint.h>
>>>>>>>>> void test(char *addr) {
>>>>>>>>     char *res =3D mmap(addr, 4096, PROT_READ | PROT_WRITE,
>>>>>>>> MAP_ANONYMOUS
>>>>>>>>> MAP_PRIVATE, -1, 0);
>>>>>>>>     printf("hint %p got %p.\n", addr, res);
>>>>>>>> }
>>>>>>>>> int main (void) {
>>>>>>>>     test(1<<30);
>>>>>>>>     test(1<<30);
>>>>>>>>     test(1<<30);
>>>>>>>>     return 0;
>>>>>>>> }
>>>>>>>>> output:
>>>>>>>>> hint 0x40000000 got 0x40000000.
>>>>>>>> hint 0x40000000 got 0xffffffffffffffff.
>>>>>>>> hint 0x40000000 got 0xffffffffffffffff.
>>>>>>>>> output on x86:
>>>>>>>>> hint 0x40000000 got 0x40000000.
>>>>>>>> hint 0x40000000 got 0x7f9171363000.
>>>>>>>> hint 0x40000000 got 0x7f9171362000.
>>>>>>>>> It may need to implement a special arch_get_unmapped_area and
>>>>>>>> arch_get_unmapped_area_topdown function.
>>>>>>>>=20
>>>>>>> This is because hint address < rnd_gap. I have tried to let =
mmap_base =3D
>>>>>>> min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). =
However it
>>>>>>> does not work for bottom-up while ulimit -s is unlimited. You =
said this
>>>>>>> behavior is expected from patch v2 review. However it brings a =
new
>>>>>>> regression even on sv39 systems.
>>>>>>>=20
>>>>>>> I still don't know the reason why use addr+len as the =
upper-bound. I
>>>>>>> think solution like x86/arm64/powerpc provide two address space =
switch
>>>>>>> based on whether hint address above the default map window is =
enough.
>>>>>>>=20
>>>>>> Yep this is expected. It is up to the maintainers to decide.
>>>>> Sorry I forgot to reply to this, I had a buffer sitting around =
somewhere
>>>>> but I must have lost it.
>>>>>=20
>>>>> I think Charlie's approach is the right way to go.  Putting my =
userspace
>>>>> hat on, I'd much rather have my allocations fail rather than =
silently
>>>>> ignore the hint when there's memory pressure.
>>>>>=20
>>>>> If there's some real use case that needs these low hints to be =
silently
>>>>> ignored under VA pressure then we can try and figure something out =
that
>>>>> makes those applications work.
>>>> I could confirm that this patch has broken chromium's partition =
allocator on
>>>> riscv64. The minimal reproduction I use is chromium-mmap.c:
>>>>=20
>>>> #include <stdio.h>
>>>> #include <sys/mman.h>
>>>>=20
>>>> int main() {
>>>>     void* expected =3D (void*)0x400000000;
>>>>     void* addr =3D mmap(expected, 17179869184, PROT_NONE,
>>>> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>>>>     if (addr !=3D expected) {
>>> It is not valid to assume that the address returned by mmap will be =
the
>>> hint address. If the hint address is not available, mmap will return =
a
>>> different address.
>>=20
>> Oh, sorry I didn't make it clear what is the expected behavior.
>> The printf here is solely for debugging purpose and I don't mean that
>> chromium expect it will get the hint address. The expected behavior =
is
>> that both the two mmap calls will succeed.
>>=20
>>>>         printf("Not expected address: %p !=3D %p\n", addr, =
expected);
>>>>     }
>>>>     expected =3D (void*)0x3fffff000;
>>>>     addr =3D mmap(expected, 17179873280, PROT_NONE, =
MAP_PRIVATE|MAP_ANONYMOUS,
>>>> -1, 0);
>>>>     if (addr !=3D expected) {
>>>>         printf("Not expected address: %p !=3D %p\n", addr, =
expected);
>>>>     }
>>>>     return 0;
>>>> }
>>>>=20
>>>> The second mmap fails with ENOMEM. Manually reverting this commit =
fixes the
>>>> issue for me. So I think it's clearly a regression and breaks =
userspace.
>>>>=20
>>> The issue here is that overlapping memory is being requested. This
>>> second mmap will never be able to provide an address at 0x3fffff000 =
with
>>> a size of 0x400001000 since mmap just provided an address at =
0x400000000
>>> with a size of 0x400000000.
>>>=20
>>> Before this patch, this request causes mmap to return a completely
>>> arbitrary value. There is no reason to use a hint address in this =
manner
>>> because the hint can never be respected. Since an arbitrary address =
is
>>> desired, a hint of zero should be used.
>>>=20
>>> This patch causes the behavior to be more deterministic. Instead of
>>> providing an arbitrary address, it causes the address to be less =
than or
>>> equal to the hint address. This allows for applications to make
>>> assumptions about the returned address.
>>=20
>> About the overlap, of course the partition allocator's request for
>> overlapped vma seems unreasonable.
>>=20
>> But I still don't quite understand why mmap cannot use an address =
higher
>> than the hint address.
>> The hint address, after all, is a hint, not a requirement.
>>=20
>> Quoting the man page:
>>=20
>>>   If another mapping already exists there, the kernel picks
>>>        a new address that may or may not depend on the hint.  The
>>>        address of the new mapping is returned as the result of the =
call.
>>=20
>> So for casual programmers that only reads man page but not =
architecture
>> specific kernel documentation, the current behavior of mmap on =
riscv64
>> failing on overlapped address ranges are quite surprising IMO.
>>=20
>> And quoting the man page again about the errno:
>>=20
>>>       ENOMEM No memory is available.
>>>=20
>>>       ENOMEM The process's maximum number of mappings would have =
been
>>>              exceeded.  This error can also occur for munmap(), when
>>>              unmapping a region in the middle of an existing =
mapping,
>>>              since this results in two smaller mappings on either =
side
>>>              of the region being unmapped.
>>>=20
>>>       ENOMEM (since Linux 4.7) The process's RLIMIT_DATA limit,
>>>              described in getrlimit(2), would have been exceeded.
>>>=20
>>>       ENOMEM We don't like addr, because it exceeds the virtual =
address
>>>              space of the CPU.
>>>=20
>>=20
>> There's no matching description for the ENOMEM returned here.
>> I would suggest removing "because it exceeds the virtual address
>> space of the CPU." from the last item if the ENOMEM behavior here
>> is expected.
>>=20
>>> This code is unfortunately relying on the previously mostly =
undefined
>>> behavior of the hint address in mmap.
>>=20
>> Although I haven't read the code of chromium's partition allocator to
>> judge whether it should
>> be improved or fixed for riscv64, I do know that the kernel "don't =
break
>> userspace" and "never EVER blame the user programs".
>=20
> Ya, sorry for breaking stuff.
>=20
> The goal here was to move to the mmap flag behavor similar to what =
arm64 and x86 have, as that was done in a way that didn't appear to =
break userspace -- or at least any real userspace programs.  IIRC that =
first test was pretty broken (it actually depended on the hint address), =
but sounds like that's not the case.
>=20
> I think maybe this is just luck: we didn't chunk the address space up, =
we're just hinting on every bit, so we're just more likely to hit the =
exhaustion.  Doesn't really matter, though, as if it's breaking stuff so =
we've got to deal with it.
>=20
> Charlie and I are just talking, and best we can come up with is to =
move to the behavior where we fall back to larger allocation regions =
when there's no space in the smaller allocation region. =20


For this solution, the only difference from the mmap behavior of
x86 and aarch64 is that we will first try to allocate some memory
from an address less or equal to the request address + size. But
for most cases, I think there is no need to do that, especially for
those addresses < BIT(47), as most program works fine on x86-64,
which has 47bit available userspace address space to use. And for
that program that wants an address < BIT(32), we already have
MAP_32BIT now.

I think we can just fix like that patch:
=
https://lore.kernel.org/lkml/tencent_B2D0435BC011135736262764B511994F4805@=
qq.com/

> Charlie's going to try and throw together a patch for that, hopefully =
it'll sort things out.
>=20
>>> The goal of this patch is to help
>>> developers have more consistent mmap behavior, but maybe it is =
necessary
>>> to hide this behavior behind an mmap flag.
>>=20
>> Thank you for helping to shape a more consistent mmap behavior.
>> I think this should be fixed ASAP either by allowing the hint address =
to
>> be ignored
>> (as suggested by the Linux man page), or hide this behavior behind an
>> mmap flag as you said.
>>=20
>>> - Charlie
>>>=20
>>>> See alsohttps://github.com/riscv-forks/electron/issues/4
>>>>=20
>>>>>> - Charlie
>>>> Sincerely,
>>>> Levi
>>>>=20
>>=20
>> I accidentally introduced some HTML into this reply so this reply is
>> resent as plain text.
>>=20
>> Sincerely,
>> Levi



