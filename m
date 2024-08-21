Return-Path: <linux-kselftest+bounces-15934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28595A7B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 00:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A131F22E6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECB017A924;
	Wed, 21 Aug 2024 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="3Z9T/u7B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864D16EC1A
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278690; cv=none; b=P3T9mA9+g8Vr8QP8DAVPHXPlJvqZ8Q55KxGvNyt562r/La6WsFIQVVM8NiN8/7SyXMDq9qyg7IGSfM70pMg3/Ff9hXUO6GIRJtWEN2qVWCrI/uRhTosjVOLj3QRM6bZew/h1OoZjceGcgaU+rhFpJ4AxccUWkKMPn5jSdyHMNrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278690; c=relaxed/simple;
	bh=lTWh4pFD1D1BKypveelHOr5cmZ6NSQkm9gZ/MuVgouw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ZpOTNkUanMg0KKF7OLfslVNqvDOp6PClZ13etU+PTgE9I2leea8MRy8V0wUoG5Zpp+63XDc5EF8RceClCoZnDLQqncQorrz0m8SfDhpwLD85hXFZP0G3bGrF7TXoHFZVZ8OF+hn6qx4ZVUKG1TudAi3iha2gV7wq6KrTI/fZqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=3Z9T/u7B; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-69483a97848so2252097b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1724278687; x=1724883487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GA0U69lWqZh9vgiySnbOFG6Yi5OvKjFXU6qSWoDxJ6E=;
        b=3Z9T/u7BQI7qIeZg8T9W5lZEcCJPD2r9PaQ6vRp3259J22q0kLCvwOxMGXV626iEEJ
         BnVKwLG5TRRRD4CnBUmKUZs5CMu1z4WaroiRafiuW7K3Is586FgiSEPRYO/zaMUKfEpX
         YIEgkcId+RnmR++W5Lq3JjL3pybZ0Yjv7z+3xRTEipN+QAvEm8BrAo947qVhzzCNtDVG
         nt5VhniJh6Ayy87YKbtpH90MVE6tGSUH3kbT7Vgb2vJijlUPUtRnHKfGhhnAzPCsATtR
         tbqMDcz7t/+iwfXp00XKszwvQ6AIhI1hCTpiFoyZE/VGL58tro1BRMXGxJr2gvAgJxuS
         Bvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724278687; x=1724883487;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA0U69lWqZh9vgiySnbOFG6Yi5OvKjFXU6qSWoDxJ6E=;
        b=P5qYJq4I+5Jgyp9e2FE5Csw3ozk4a6kKXx/I+cnKTJ6nbSy5YNPPNnFWWB1K0kxKmH
         O/4D1fJIhN1l2nr+jK5mN+///NHKmfFApu7xVtsvfBb9mJ9STzdTwkXlrVjL10Vrwzvf
         po83TZTZoQJhGhlmkHg9TCTcDaA/eLWG4uoJjxOZ+zFtSN1ZVItoAPRTnNf8HHEpYlgX
         sepcftk7IcwjoJuq64XQ7VCaG016DFQiJfbwurzCQ+KemZUF8m4MJPEiP9LMiAS8c1Jp
         3iRNvppwS8r/+OpomuP/TpVSEAoqfa2//pM3tmwz1cl/LShpKDRivyc+aAuqXdGFQxUL
         4+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWiaUQOppvhULIrbBtdm3VQ0beK7hgMympOVU5EYPUvCM4meeOHHVnz451VjTtj6QwS+7hggUIcfmoyw9weCaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfOOBprcCwWRFytFDIZFHVko38Qj8yDzGHnZClVJUPQs3vY4j
	2lR0Y9qoVGwOGsduVwzmrEC/cUYCDpx/fcidsBrwb7Ekho+f/W//jSWiaSl61A263Twdv3QkTRY
	M
X-Google-Smtp-Source: AGHT+IGGJZWDDJ8OGBrJ+D+6QI5DXa4ye9cGQczHj52PhpdGbXIA0HyWT9z9gUssP2NjkA94cd9eUg==
X-Received: by 2002:a05:6a00:10c1:b0:706:6af8:e08a with SMTP id d2e1a72fcca58-71423421f05mr3709454b3a.2.1724278676054;
        Wed, 21 Aug 2024 15:17:56 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340419sm138329b3a.205.2024.08.21.15.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 15:17:55 -0700 (PDT)
Date: Wed, 21 Aug 2024 15:17:55 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Aug 2024 15:17:53 PDT (-0700)
Subject:     Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
In-Reply-To: <MEYP282MB2312A08FF95D44014AB78411C68D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
CC: Charlie Jenkins <charlie@rivosinc.com>, cyy@cyyself.name, alexghiti@rivosinc.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, shuah@kernel.org, corbet@lwn.net, linux-mm@kvack.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
  linux-doc@vger.kernel.org, linux-api@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rsworktech@outlook.com
Message-ID: <mhng-7d9e2b27-a53d-4579-b78e-0aec038290fb@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 19 Aug 2024 18:58:18 PDT (-0700), rsworktech@outlook.com wrote:
> On 2024-08-20 01:00, Charlie Jenkins wrote:
>> On Mon, Aug 19, 2024 at 01:55:57PM +0800, Levi Zim wrote:
>>> On 2024-03-22 22:06, Palmer Dabbelt wrote:
>>>> On Thu, 01 Feb 2024 18:28:06 PST (-0800), Charlie Jenkins wrote:
>>>>> On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
>>>>>> On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
>>>>>>> On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
>>>>>>>> On riscv it is guaranteed that the address returned by mmap is less
>>>>>>>> than
>>>>>>>> the hint address. Allow mmap to return an address all the way up to
>>>>>>>> addr, if provided, rather than just up to the lower address space.
>>>>>>>>>> This provides a performance benefit as well, allowing
>>>>>> mmap to exit
>>>>>>>> after
>>>>>>>> checking that the address is in range rather than searching for a
>>>>>>>> valid
>>>>>>>> address.
>>>>>>>>>> It is possible to provide an address that uses at most the same
>>>>>>>> number
>>>>>>>> of bits, however it is significantly more computationally expensive
>>>>>>>> to
>>>>>>>> provide that number rather than setting the max to be the hint
>>>>>>>> address.
>>>>>>>> There is the instruction clz/clzw in Zbb that returns the highest
>>>>>>>> set
>>>>>>>> bit
>>>>>>>> which could be used to performantly implement this, but it would
>>>>>>>> still
>>>>>>>> be slower than the current implementation. At worst case, half of
>>>>>>>> the
>>>>>>>> address would not be able to be allocated when a hint address is
>>>>>>>> provided.
>>>>>>>>>> Signed-off-by: Charlie Jenkins<charlie@rivosinc.com>
>>>>>>>> ---
>>>>>>>>   arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
>>>>>>>> -
>>>>>>>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>>>>>>>>> diff --git a/arch/riscv/include/asm/processor.h
>>>>>>>> b/arch/riscv/include/asm/processor.h
>>>>>>>> index f19f861cda54..8ece7a8f0e18 100644
>>>>>>>> --- a/arch/riscv/include/asm/processor.h
>>>>>>>> +++ b/arch/riscv/include/asm/processor.h
>>>>>>>> @@ -14,22 +14,16 @@
>>>>>>>>
>>>>>>>>   #include <asm/ptrace.h>
>>>>>>>>
>>>>>>>> -#ifdef CONFIG_64BIT
>>>>>>>> -#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>>>>>>> -#define STACK_TOP_MAX        TASK_SIZE_64
>>>>>>>> -
>>>>>>>>   #define arch_get_mmap_end(addr, len, flags)            \
>>>>>>>>   ({                                \
>>>>>>>>       unsigned long
>>>>>>>> mmap_end;                    \
>>>>>>>>       typeof(addr) _addr = (addr);                \
>>>>>>>> -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>>>>>>> is_compat_task())) \
>>>>>>>> +    if ((_addr) == 0 ||                    \
>>>>>>>> +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
>>>>>>>> +        ((_addr + len) > BIT(VA_BITS -
>>>>>>>> 1)))            \
>>>>>>>>           mmap_end = STACK_TOP_MAX;            \
>>>>>>>> -    else if ((_addr) >= VA_USER_SV57) \
>>>>>>>> -        mmap_end = STACK_TOP_MAX;            \
>>>>>>>> -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>>>>>>>> VA_BITS_SV48)) \
>>>>>>>> -        mmap_end = VA_USER_SV48;            \
>>>>>>>>       else                            \
>>>>>>>> -        mmap_end = VA_USER_SV39;            \
>>>>>>>> +        mmap_end = (_addr + len);            \
>>>>>>>>       mmap_end;                        \
>>>>>>>>   })
>>>>>>>>
>>>>>>>> @@ -39,17 +33,18 @@
>>>>>>>>       typeof(addr) _addr = (addr);                \
>>>>>>>>       typeof(base) _base = (base);                \
>>>>>>>>       unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);    \
>>>>>>>> -    if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
>>>>>>>> is_compat_task())) \
>>>>>>>> +    if ((_addr) == 0 ||                    \
>>>>>>>> +        (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||    \
>>>>>>>> +        ((_addr + len) > BIT(VA_BITS -
>>>>>>>> 1)))            \
>>>>>>>>           mmap_base = (_base);                \
>>>>>>>> -    else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
>>>>>>>> VA_BITS_SV57)) \
>>>>>>>> -        mmap_base = VA_USER_SV57 - rnd_gap; \
>>>>>>>> -    else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
>>>>>>>> VA_BITS_SV48)) \
>>>>>>>> -        mmap_base = VA_USER_SV48 - rnd_gap; \
>>>>>>>>       else                            \
>>>>>>>> -        mmap_base = VA_USER_SV39 - rnd_gap; \
>>>>>>>> +        mmap_base = (_addr + len) - rnd_gap; \
>>>>>>>>       mmap_base;                        \
>>>>>>>>   })
>>>>>>>>
>>>>>>>> +#ifdef CONFIG_64BIT
>>>>>>>> +#define DEFAULT_MAP_WINDOW    (UL(1) << (MMAP_VA_BITS - 1))
>>>>>>>> +#define STACK_TOP_MAX        TASK_SIZE_64
>>>>>>>>   #else
>>>>>>>>   #define DEFAULT_MAP_WINDOW    TASK_SIZE
>>>>>>>>   #define STACK_TOP_MAX        TASK_SIZE
>>>>>>>>>> I have carefully tested your patch on qemu with sv57. A
>>>>>> bug that
>>>>>>> needs
>>>>>>> to be solved is that mmap with the same hint address without
>>>>>>> MAP_FIXED
>>>>>>> set will fail the second time.
>>>>>>>> Userspace code to reproduce the bug:
>>>>>>>> #include <sys/mman.h>
>>>>>>> #include <stdio.h>
>>>>>>> #include <stdint.h>
>>>>>>>> void test(char *addr) {
>>>>>>>      char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
>>>>>>> MAP_ANONYMOUS
>>>>>>>> MAP_PRIVATE, -1, 0);
>>>>>>>      printf("hint %p got %p.\n", addr, res);
>>>>>>> }
>>>>>>>> int main (void) {
>>>>>>>      test(1<<30);
>>>>>>>      test(1<<30);
>>>>>>>      test(1<<30);
>>>>>>>      return 0;
>>>>>>> }
>>>>>>>> output:
>>>>>>>> hint 0x40000000 got 0x40000000.
>>>>>>> hint 0x40000000 got 0xffffffffffffffff.
>>>>>>> hint 0x40000000 got 0xffffffffffffffff.
>>>>>>>> output on x86:
>>>>>>>> hint 0x40000000 got 0x40000000.
>>>>>>> hint 0x40000000 got 0x7f9171363000.
>>>>>>> hint 0x40000000 got 0x7f9171362000.
>>>>>>>> It may need to implement a special arch_get_unmapped_area and
>>>>>>> arch_get_unmapped_area_topdown function.
>>>>>>>
>>>>>> This is because hint address < rnd_gap. I have tried to let mmap_base =
>>>>>> min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
>>>>>> does not work for bottom-up while ulimit -s is unlimited. You said this
>>>>>> behavior is expected from patch v2 review. However it brings a new
>>>>>> regression even on sv39 systems.
>>>>>>
>>>>>> I still don't know the reason why use addr+len as the upper-bound. I
>>>>>> think solution like x86/arm64/powerpc provide two address space switch
>>>>>> based on whether hint address above the default map window is enough.
>>>>>>
>>>>> Yep this is expected. It is up to the maintainers to decide.
>>>> Sorry I forgot to reply to this, I had a buffer sitting around somewhere
>>>> but I must have lost it.
>>>>
>>>> I think Charlie's approach is the right way to go.  Putting my userspace
>>>> hat on, I'd much rather have my allocations fail rather than silently
>>>> ignore the hint when there's memory pressure.
>>>>
>>>> If there's some real use case that needs these low hints to be silently
>>>> ignored under VA pressure then we can try and figure something out that
>>>> makes those applications work.
>>> I could confirm that this patch has broken chromium's partition allocator on
>>> riscv64. The minimal reproduction I use is chromium-mmap.c:
>>>
>>> #include <stdio.h>
>>> #include <sys/mman.h>
>>>
>>> int main() {
>>>      void* expected = (void*)0x400000000;
>>>      void* addr = mmap(expected, 17179869184, PROT_NONE,
>>> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>>>      if (addr != expected) {
>> It is not valid to assume that the address returned by mmap will be the
>> hint address. If the hint address is not available, mmap will return a
>> different address.
>
> Oh, sorry I didn't make it clear what is the expected behavior.
> The printf here is solely for debugging purpose and I don't mean that
> chromium expect it will get the hint address. The expected behavior is
> that both the two mmap calls will succeed.
>
>>>          printf("Not expected address: %p != %p\n", addr, expected);
>>>      }
>>>      expected = (void*)0x3fffff000;
>>>      addr = mmap(expected, 17179873280, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS,
>>> -1, 0);
>>>      if (addr != expected) {
>>>          printf("Not expected address: %p != %p\n", addr, expected);
>>>      }
>>>      return 0;
>>> }
>>>
>>> The second mmap fails with ENOMEM. Manually reverting this commit fixes the
>>> issue for me. So I think it's clearly a regression and breaks userspace.
>>>
>> The issue here is that overlapping memory is being requested. This
>> second mmap will never be able to provide an address at 0x3fffff000 with
>> a size of 0x400001000 since mmap just provided an address at 0x400000000
>> with a size of 0x400000000.
>>
>> Before this patch, this request causes mmap to return a completely
>> arbitrary value. There is no reason to use a hint address in this manner
>> because the hint can never be respected. Since an arbitrary address is
>> desired, a hint of zero should be used.
>>
>> This patch causes the behavior to be more deterministic. Instead of
>> providing an arbitrary address, it causes the address to be less than or
>> equal to the hint address. This allows for applications to make
>> assumptions about the returned address.
>
> About the overlap, of course the partition allocator's request for
> overlapped vma seems unreasonable.
>
> But I still don't quite understand why mmap cannot use an address higher
> than the hint address.
> The hint address, after all, is a hint, not a requirement.
>
> Quoting the man page:
>
>>    If another mapping already exists there, the kernel picks
>>         a new address that may or may not depend on the hint.  The
>>         address of the new mapping is returned as the result of the call.
>
> So for casual programmers that only reads man page but not architecture
> specific kernel documentation, the current behavior of mmap on riscv64
> failing on overlapped address ranges are quite surprising IMO.
>
> And quoting the man page again about the errno:
>
>>       ENOMEM No memory is available.
>>
>>       ENOMEM The process's maximum number of mappings would have been
>>              exceeded.  This error can also occur for munmap(), when
>>              unmapping a region in the middle of an existing mapping,
>>              since this results in two smaller mappings on either side
>>              of the region being unmapped.
>>
>>       ENOMEM (since Linux 4.7) The process's RLIMIT_DATA limit,
>>              described in getrlimit(2), would have been exceeded.
>>
>>       ENOMEM We don't like addr, because it exceeds the virtual address
>>              space of the CPU.
>>
>
> There's no matching description for the ENOMEM returned here.
> I would suggest removing "because it exceeds the virtual address
> space of the CPU." from the last item if the ENOMEM behavior here
> is expected.
>
>> This code is unfortunately relying on the previously mostly undefined
>> behavior of the hint address in mmap.
>
> Although I haven't read the code of chromium's partition allocator to
> judge whether it should
> be improved or fixed for riscv64, I do know that the kernel "don't break
> userspace" and "never EVER blame the user programs".

Ya, sorry for breaking stuff.

The goal here was to move to the mmap flag behavor similar to what arm64 
and x86 have, as that was done in a way that didn't appear to break 
userspace -- or at least any real userspace programs.  IIRC that first 
test was pretty broken (it actually depended on the hint address), but 
sounds like that's not the case.

I think maybe this is just luck: we didn't chunk the address space up, 
we're just hinting on every bit, so we're just more likely to hit the 
exhaustion.  Doesn't really matter, though, as if it's breaking stuff so 
we've got to deal with it.

Charlie and I are just talking, and best we can come up with is to move 
to the behavior where we fall back to larger allocation regions when 
there's no space in the smaller allocation region.  Charlie's going to 
try and throw together a patch for that, hopefully it'll sort things 
out.

>> The goal of this patch is to help
>> developers have more consistent mmap behavior, but maybe it is necessary
>> to hide this behavior behind an mmap flag.
>
> Thank you for helping to shape a more consistent mmap behavior.
> I think this should be fixed ASAP either by allowing the hint address to
> be ignored
> (as suggested by the Linux man page), or hide this behavior behind an
> mmap flag as you said.
>
>> - Charlie
>>
>>> See alsohttps://github.com/riscv-forks/electron/issues/4
>>>
>>>>> - Charlie
>>> Sincerely,
>>> Levi
>>>
>
> I accidentally introduced some HTML into this reply so this reply is
> resent as plain text.
>
> Sincerely,
> Levi

