Return-Path: <linux-kselftest+bounces-9267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D078B9D34
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BC11C21F1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4715ADB5;
	Thu,  2 May 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahWBPPlL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261215B15B
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663153; cv=none; b=Eg9+820/1E+tYXciAdeF0WAukEu6vLwMhGTY9GscLOmEGwemiM++aHRLMpR6Kq2qs5b0dNANZdros8Aa1LQz8SzVcMX5aaZgA+VGWRAHYjltla+Qj//D0kbkJvwsOVBprnQzgTwyBxxOSRXWfvckhbBUsMUDYXzJ0YO8OTLNbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663153; c=relaxed/simple;
	bh=i3wb7WRtSrVSSajbX7oqK5l2d30q5KzxqpxvbKAkRVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJpjbz2rAqkSs5EbPQKDL9S7hxF8vEXdVJsW3J5ikmreLGqfRSatrcogWBYRgMP5zraQLgFYOCik1NlNssSwtTe6HyUS+LeasiYZ0OiPHGMoTSX+vJ8YaIPIstUkVBsH3LiveD5EaKE7LgI6b4ogK5fjJ9xW/5I54T0zzeEK7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ahWBPPlL; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23d4a841361so1062360fac.2
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714663148; x=1715267948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o45R2QGeOEyfQ95xK5XQm00x5VHsPQPc/6bWyA4205U=;
        b=ahWBPPlLvcUjXnCvtxw2VHPJVC3l6pBrvz2HTcSmF8MgMAMt6OISru7iq6kbEWmjBO
         LGYJTsaensQvBahrBswDtRg6oTvUoxPeM0uH0WwWbpNgCBqsHtoAWIS0OmLhsJQ1doHi
         YUbb5DkWyKtW5+gIwPKVr0bweg0o4YxMAiG6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714663148; x=1715267948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o45R2QGeOEyfQ95xK5XQm00x5VHsPQPc/6bWyA4205U=;
        b=e0d9VIw+64nq9doEloOutg04GaTSeVz83PLaRV+vukiTnsW02x7FprpFLvgcbGa/wk
         3pVH2vD36DmnisDeTqqjw/mxQsWMKy7VXeY3xTabELNJmGy7jRP3htzVVd5ubBMyOEJK
         QcTolHDSzkK+nSueB9rxLkdSsRRzbDo3XIb8CBM1LsHXcO1QdFo060c2Wa1fAmVBdTVl
         s3uqR6GKfN/aukSJDbXPJhP/rLpMXFWzvC3ucRQXo6pUvmUIFqXPwpOsAS/4gxGd543d
         ik1tzWnrDz68c5ZbTcttajo8LRhwKhEsOX1CSk1ofdOrWx2QtuEGlSc8h5p4UwEp5PUS
         EV5g==
X-Forwarded-Encrypted: i=1; AJvYcCWULxU13v9H7kSaw2VDGT+oEG2/rsLQfmpPiqNhL0apnajyobdkPfP3URJCGUt9DbFfgjIwhm8XqX4eACk6Cgx5PVI1zRYSL7dsGDO+p4kb
X-Gm-Message-State: AOJu0YwAmjcEtil5TWEXo4+IrfU4cpLnxgh3XOTM8QRJasRdmKOfEeUU
	1geSXQKVwMfy5HbLYLahCYkw2Bb/4lWmwEkpKOJlTBcfHPSdI83qtKaXP7pueYF6kylA9uWwfn1
	R9PrbZZJa3uDi2l1Znd58pcdVuZFE2kIl+1Fs
X-Google-Smtp-Source: AGHT+IGZNBYIVHtb/1AwZwNwWID7f9m494dnvcnYljPuZKP2INtRDdmwJL40WlRoepIaiIBCVJg7g/XG5VwLYn7u0m4=
X-Received: by 2002:a05:6871:88b:b0:233:60e7:52bf with SMTP id
 r11-20020a056871088b00b0023360e752bfmr144926oaq.50.1714663147835; Thu, 02 May
 2024 08:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-4-jeffxu@chromium.org>
 <f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com>
In-Reply-To: <f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 2 May 2024 08:18:55 -0700
Message-ID: <CABi2SkXJQzFg-heMr3_Mx_XZ=DFNTQqHjaA3q0v=SbvuykZQhA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] selftest mm/mseal memory sealing
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 4:24=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 15/04/2024 17:35, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > selftest for memory sealing change in mmap() and mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/.gitignore   |    1 +
> >  tools/testing/selftests/mm/Makefile     |    1 +
> >  tools/testing/selftests/mm/mseal_test.c | 1836 +++++++++++++++++++++++
> >  3 files changed, 1838 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index d26e962f2ac4..98eaa4590f11 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -47,3 +47,4 @@ mkdirty
> >  va_high_addr_switch
> >  hugetlb_fault_after_madv
> >  hugetlb_madv_vs_map
> > +mseal_test
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index eb5f39a2668b..95d10fe1b3c1 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -59,6 +59,7 @@ TEST_GEN_FILES +=3D mlock2-tests
> >  TEST_GEN_FILES +=3D mrelease_test
> >  TEST_GEN_FILES +=3D mremap_dontunmap
> >  TEST_GEN_FILES +=3D mremap_test
> > +TEST_GEN_FILES +=3D mseal_test
> >  TEST_GEN_FILES +=3D on-fault-limit
> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >  TEST_GEN_FILES +=3D thuge-gen
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > new file mode 100644
> > index 000000000000..06c780d1d8e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -0,0 +1,1836 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +#include <sys/mman.h>
>
> I'm afraid this is causing a build error on our CI, and as a result we ar=
e not
> running any mm selftests currently.
>
> The error is here:
>
>   CC       mseal_test
> mseal_test.c: In function =E2=80=98test_seal_mremap_move_dontunmap=E2=80=
=99:
> mseal_test.c:1469:50: error: =E2=80=98MREMAP_DONTUNMAP=E2=80=99 undeclare=
d (first use in this
> function)
>  1469 |  ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNM=
AP, 0);
>       |                                                  ^~~~~~~~~~~~~~~~
> mseal_test.c:1469:50: note: each undeclared identifier is reported only o=
nce for
> each function it appears in
> mseal_test.c: In function =E2=80=98test_seal_mremap_move_dontunmap_anyadd=
r=E2=80=99:
> mseal_test.c:1501:50: error: =E2=80=98MREMAP_DONTUNMAP=E2=80=99 undeclare=
d (first use in this
> function)
>  1501 |  ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNM=
AP,
>       |                                                  ^~~~~~~~~~~~~~~~
>
>
> And I think the reason is due to our CI's toolchain's sys/mman.h not incl=
uding
> linux/mman.h where MREMAP_DONTUNMAP is defined.
>
> I think the fix is to explicitly #include <linux/mman.h>, as a number of =
other
> mm selftests do.
>
I will give it a try today.

> I'm not sure if this is still in mm-unstable? If so, it would good to rem=
ove it
> so we can resume our testing.
>
> > +#include <stdint.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <sys/time.h>
> > +#include <sys/resource.h>
> > +#include <stdbool.h>
> > +#include "../kselftest.h"
> > +#include <syscall.h>
> > +#include <errno.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <assert.h>
> > +#include <fcntl.h>
> > +#include <assert.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/vfs.h>
> > +#include <sys/stat.h>
> > +
> > +/*
> > + * need those definition for manually build using gcc.
> > + * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 mseal_tes=
t.c -o mseal_test
> > + */
> > +#ifndef PKEY_DISABLE_ACCESS
> > +# define PKEY_DISABLE_ACCESS    0x1
> > +#endif
>
> If you pull in linux/mman.h directly, you shouldn't need this define as i=
t will
> be pulled in.
>
> > +
> > +#ifndef PKEY_DISABLE_WRITE
> > +# define PKEY_DISABLE_WRITE     0x2
> > +#endif
>
> And this one.
>
> > +
> > +#ifndef PKEY_BITS_PER_KEY
>
> bug: I think you missed the 'P' in PKEY?
>
Will be included in the fix.

> > +#define PKEY_BITS_PER_PKEY      2
> > +#endif
>
> If you #include "pkey-helpers.h" you should get this define.
>
pkey-helpres.h includes some externs (e.g. dprint_in_signal) which
makes it difficult to include.

> > +
> > +#ifndef PKEY_MASK
> > +#define PKEY_MASK       (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
> > +#endif
>
> And you can use the PKEY_ACCESS_MASK macro that will be pulled in to avoi=
d this
> define too.
>
> Thanks,
> Ryan
>
> > +
> > +#define FAIL_TEST_IF_FALSE(c) do {\
> > +             if (!(c)) {\
> > +                     ksft_test_result_fail("%s, line:%d\n", __func__, =
__LINE__);\
> > +                     goto test_end;\
> > +             } \
> > +     } \
> > +     while (0)
> > +
> > +#define SKIP_TEST_IF_FALSE(c) do {\
> > +             if (!(c)) {\
> > +                     ksft_test_result_skip("%s, line:%d\n", __func__, =
__LINE__);\
> > +                     goto test_end;\
> > +             } \
> > +     } \
> > +     while (0)
> > +
> > +
> > +#define TEST_END_CHECK() {\
> > +             ksft_test_result_pass("%s\n", __func__);\
> > +             return;\
> > +test_end:\
> > +             return;\
> > +}
> > +
> > +#ifndef u64
> > +#define u64 unsigned long long
> > +#endif
> > +
> > +static unsigned long get_vma_size(void *addr, int *prot)
> > +{
> > +     FILE *maps;
> > +     char line[256];
> > +     int size =3D 0;
> > +     uintptr_t  addr_start, addr_end;
> > +     char protstr[5];
> > +     *prot =3D 0;
> > +
> > +     maps =3D fopen("/proc/self/maps", "r");
> > +     if (!maps)
> > +             return 0;
> > +
> > +     while (fgets(line, sizeof(line), maps)) {
> > +             if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, &=
protstr) =3D=3D 3) {
> > +                     if (addr_start =3D=3D (uintptr_t) addr) {
> > +                             size =3D addr_end - addr_start;
> > +                             if (protstr[0] =3D=3D 'r')
> > +                                     *prot |=3D 0x4;
> > +                             if (protstr[1] =3D=3D 'w')
> > +                                     *prot |=3D 0x2;
> > +                             if (protstr[2] =3D=3D 'x')
> > +                                     *prot |=3D 0x1;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +     fclose(maps);
> > +     return size;
> > +}
> > +
> > +/*
> > + * define sys_xyx to call syscall directly.
> > + */
> > +static int sys_mseal(void *start, size_t len)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_mseal, start, len, 0);
> > +     return sret;
> > +}
> > +
> > +static int sys_mprotect(void *ptr, size_t size, unsigned long prot)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_mprotect, ptr, size, prot);
> > +     return sret;
> > +}
> > +
> > +static int sys_mprotect_pkey(void *ptr, size_t size, unsigned long ori=
g_prot,
> > +             unsigned long pkey)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
> > +     return sret;
> > +}
> > +
> > +static void *sys_mmap(void *addr, unsigned long len, unsigned long pro=
t,
> > +     unsigned long flags, unsigned long fd, unsigned long offset)
> > +{
> > +     void *sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> > +             flags, fd, offset);
> > +     return sret;
> > +}
> > +
> > +static int sys_munmap(void *ptr, size_t size)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_munmap, ptr, size);
> > +     return sret;
> > +}
> > +
> > +static int sys_madvise(void *start, size_t len, int types)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_madvise, start, len, types);
> > +     return sret;
> > +}
> > +
> > +static int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
> > +{
> > +     int ret =3D syscall(__NR_pkey_alloc, flags, init_val);
> > +
> > +     return ret;
> > +}
> > +
> > +static unsigned int __read_pkey_reg(void)
> > +{
> > +     unsigned int pkey_reg =3D 0;
> > +#if defined(__i386__) || defined(__x86_64__) /* arch */
> > +     unsigned int eax, edx;
> > +     unsigned int ecx =3D 0;
> > +
> > +     asm volatile(".byte 0x0f,0x01,0xee\n\t"
> > +                     : "=3Da" (eax), "=3Dd" (edx)
> > +                     : "c" (ecx));
> > +     pkey_reg =3D eax;
> > +#endif
> > +     return pkey_reg;
> > +}
> > +
> > +static void __write_pkey_reg(u64 pkey_reg)
> > +{
> > +#if defined(__i386__) || defined(__x86_64__) /* arch */
> > +     unsigned int eax =3D pkey_reg;
> > +     unsigned int ecx =3D 0;
> > +     unsigned int edx =3D 0;
> > +
> > +     asm volatile(".byte 0x0f,0x01,0xef\n\t"
> > +                     : : "a" (eax), "c" (ecx), "d" (edx));
> > +     assert(pkey_reg =3D=3D __read_pkey_reg());
> > +#endif
> > +}
> > +
> > +static unsigned long pkey_bit_position(int pkey)
> > +{
> > +     return pkey * PKEY_BITS_PER_PKEY;
> > +}
> > +
> > +static u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
> > +{
> > +     unsigned long shift =3D pkey_bit_position(pkey);
> > +
> > +     /* mask out bits from pkey in old value */
> > +     reg &=3D ~((u64)PKEY_MASK << shift);
> > +     /* OR in new bits for pkey */
> > +     reg |=3D (flags & PKEY_MASK) << shift;
> > +     return reg;
> > +}
> > +
> > +static void set_pkey(int pkey, unsigned long pkey_value)
> > +{
> > +     unsigned long mask =3D (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)=
;
> > +     u64 new_pkey_reg;
> > +
> > +     assert(!(pkey_value & ~mask));
> > +     new_pkey_reg =3D set_pkey_bits(__read_pkey_reg(), pkey, pkey_valu=
e);
> > +     __write_pkey_reg(new_pkey_reg);
> > +}
> > +
> > +static void setup_single_address(int size, void **ptrOut)
> > +{
> > +     void *ptr;
> > +
> > +     ptr =3D sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVA=
TE, -1, 0);
> > +     assert(ptr !=3D (void *)-1);
> > +     *ptrOut =3D ptr;
> > +}
> > +
> > +static void setup_single_address_rw(int size, void **ptrOut)
> > +{
> > +     void *ptr;
> > +     unsigned long mapflags =3D MAP_ANONYMOUS | MAP_PRIVATE;
> > +
> > +     ptr =3D sys_mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1=
, 0);
> > +     assert(ptr !=3D (void *)-1);
> > +     *ptrOut =3D ptr;
> > +}
> > +
> > +static void clean_single_address(void *ptr, int size)
> > +{
> > +     int ret;
> > +
> > +     ret =3D munmap(ptr, size);
> > +     assert(!ret);
> > +}
> > +
> > +static void seal_single_address(void *ptr, int size)
> > +{
> > +     int ret;
> > +
> > +     ret =3D sys_mseal(ptr, size);
> > +     assert(!ret);
> > +}
> > +
> > +bool seal_support(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +
> > +     ptr =3D sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_=
PRIVATE, -1, 0);
> > +     if (ptr =3D=3D (void *) -1)
> > +             return false;
> > +
> > +     ret =3D sys_mseal(ptr, page_size);
> > +     if (ret < 0)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +bool pkey_supported(void)
> > +{
> > +#if defined(__i386__) || defined(__x86_64__) /* arch */
> > +     int pkey =3D sys_pkey_alloc(0, 0);
> > +
> > +     if (pkey > 0)
> > +             return true;
> > +#endif
> > +     return false;
> > +}
> > +
> > +static void test_seal_addseal(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_unmapped_start(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* munmap 2 pages from ptr. */
> > +     ret =3D sys_munmap(ptr, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* mprotect will fail because 2 pages from ptr are unmapped. */
> > +     ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* mseal will fail because 2 pages from ptr are unmapped. */
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     ret =3D sys_mseal(ptr + 2 * page_size, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_unmapped_middle(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* munmap 2 pages from ptr + page. */
> > +     ret =3D sys_munmap(ptr + page_size, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* mprotect will fail, since middle 2 pages are unmapped. */
> > +     ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* mseal will fail as well. */
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* we still can add seal to the first page and last page*/
> > +     ret =3D sys_mseal(ptr, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_mseal(ptr + 3 * page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_unmapped_end(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* unmap last 2 pages. */
> > +     ret =3D sys_munmap(ptr + 2 * page_size, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* mprotect will fail since last 2 pages are unmapped. */
> > +     ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* mseal will fail as well. */
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* The first 2 pages is not sealed, and can add seals */
> > +     ret =3D sys_mseal(ptr, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_multiple_vmas(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split the vma into 3. */
> > +     ret =3D sys_mprotect(ptr + page_size, 2 * page_size,
> > +                     PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* mprotect will get applied to all 4 pages - 3 VMAs. */
> > +     ret =3D sys_mprotect(ptr, size, PROT_READ);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* use mprotect to split the vma into 3. */
> > +     ret =3D sys_mprotect(ptr + page_size, 2 * page_size,
> > +                     PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* mseal get applied to all 4 pages - 3 VMAs. */
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_split_start(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split at middle */
> > +     ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal the first page, this will split the VMA */
> > +     ret =3D sys_mseal(ptr, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* add seal to the remain 3 pages */
> > +     ret =3D sys_mseal(ptr + page_size, 3 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_split_end(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split at middle */
> > +     ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal the last page */
> > +     ret =3D sys_mseal(ptr + 3 * page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* Adding seals to the first 3 pages */
> > +     ret =3D sys_mseal(ptr, 3 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_invalid_input(void)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(8 * page_size, &ptr);
> > +     clean_single_address(ptr + 4 * page_size, 4 * page_size);
> > +
> > +     /* invalid flag */
> > +     ret =3D syscall(__NR_mseal, ptr, size, 0x20);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* unaligned address */
> > +     ret =3D sys_mseal(ptr + 1, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* length too big */
> > +     ret =3D sys_mseal(ptr, 5 * page_size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* length overflow */
> > +     ret =3D sys_mseal(ptr, UINT64_MAX/page_size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* start is not in a valid VMA */
> > +     ret =3D sys_mseal(ptr - page_size, 5 * page_size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_zero_length(void)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     ret =3D sys_mprotect(ptr, 0, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal 0 length will be OK, same as mprotect */
> > +     ret =3D sys_mseal(ptr, 0);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* verify the 4 pages are not sealed by previous call. */
> > +     ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_zero_address(void)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     int prot;
> > +
> > +     /* use mmap to change protection. */
> > +     ptr =3D sys_mmap(0, size, PROT_NONE,
> > +                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +     FAIL_TEST_IF_FALSE(ptr =3D=3D 0);
> > +
> > +     size =3D get_vma_size(ptr, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* verify the 4 pages are sealed by previous call. */
> > +     ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_twice(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* apply the same seal will be OK. idempotent. */
> > +     ret =3D sys_mseal(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal)
> > +             seal_single_address(ptr, size);
> > +
> > +     ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_start_mprotect(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal)
> > +             seal_single_address(ptr, page_size);
> > +
> > +     /* the first page is sealed. */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* pages after the first page is not sealed. */
> > +     ret =3D sys_mprotect(ptr + page_size, page_size * 3,
> > +                     PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_end_mprotect(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal)
> > +             seal_single_address(ptr + page_size, 3 * page_size);
> > +
> > +     /* first page is not sealed */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* last 3 page are sealed */
> > +     ret =3D sys_mprotect(ptr + page_size, page_size * 3,
> > +                     PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_unalign_len(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal)
> > +             seal_single_address(ptr, page_size * 2 - 1);
> > +
> > +     /* 2 pages are sealed. */
> > +     ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_mprotect(ptr + page_size * 2, page_size,
> > +                     PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_unalign_len_variant_2(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +     if (seal)
> > +             seal_single_address(ptr, page_size * 2 + 1);
> > +
> > +     /* 3 pages are sealed. */
> > +     ret =3D sys_mprotect(ptr, page_size * 3, PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_mprotect(ptr + page_size * 3, page_size,
> > +                     PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_two_vma(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split */
> > +     ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     if (seal)
> > +             seal_single_address(ptr, page_size * 4);
> > +
> > +     ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_mprotect(ptr + page_size * 2, page_size * 2,
> > +                     PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_two_vma_with_split(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split as two vma. */
> > +     ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* mseal can apply across 2 vma, also split them. */
> > +     if (seal)
> > +             seal_single_address(ptr + page_size, page_size * 2);
> > +
> > +     /* the first page is not sealed. */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* the second page is sealed. */
> > +     ret =3D sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT=
_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* the third page is sealed. */
> > +     ret =3D sys_mprotect(ptr + 2 * page_size, page_size,
> > +                     PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* the fouth page is not sealed. */
> > +     ret =3D sys_mprotect(ptr + 3 * page_size, page_size,
> > +                     PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_partial_mprotect(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* seal one page. */
> > +     if (seal)
> > +             seal_single_address(ptr, page_size);
> > +
> > +     /* mprotect first 2 page will fail, since the first page are seal=
ed. */
> > +     ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_two_vma_with_gap(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split. */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* use mprotect to split. */
> > +     ret =3D sys_mprotect(ptr + 3 * page_size, page_size,
> > +                     PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* use munmap to free two pages in the middle */
> > +     ret =3D sys_munmap(ptr + page_size, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* mprotect will fail, because there is a gap in the address. */
> > +     /* notes, internally mprotect still updated the first page. */
> > +     ret =3D sys_mprotect(ptr, 4 * page_size, PROT_READ);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* mseal will fail as well. */
> > +     ret =3D sys_mseal(ptr, 4 * page_size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* the first page is not sealed. */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_READ);
> > +     FAIL_TEST_IF_FALSE(ret =3D=3D 0);
> > +
> > +     /* the last page is not sealed. */
> > +     ret =3D sys_mprotect(ptr + 3 * page_size, page_size, PROT_READ);
> > +     FAIL_TEST_IF_FALSE(ret =3D=3D 0);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_split(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split. */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal all 4 pages. */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* mprotect is sealed. */
> > +     ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +
> > +     ret =3D sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_REA=
D);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mprotect_merge(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split one page. */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal first two pages. */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* 2 pages are sealed. */
> > +     ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* last 2 pages are not sealed. */
> > +     ret =3D sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_REA=
D);
> > +     FAIL_TEST_IF_FALSE(ret =3D=3D 0);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_munmap(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* 4 pages are sealed. */
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +/*
> > + * allocate 4 pages,
> > + * use mprotect to split it as two VMAs
> > + * seal the whole range
> > + * munmap will fail on both
> > + */
> > +static void test_seal_munmap_two_vma(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* use mprotect to split */
> > +     ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     ret =3D sys_munmap(ptr, page_size * 2);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_munmap(ptr + page_size, page_size * 2);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +/*
> > + * allocate a VMA with 4 pages.
> > + * munmap the middle 2 pages.
> > + * seal the whole 4 pages, will fail.
> > + * munmap the first page will be OK.
> > + * munmap the last page will be OK.
> > + */
> > +static void test_seal_munmap_vma_with_gap(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     ret =3D sys_munmap(ptr + page_size, page_size * 2);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     if (seal) {
> > +             /* can't have gap in the middle. */
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     }
> > +
> > +     ret =3D sys_munmap(ptr, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_munmap(ptr + page_size * 2, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_munmap(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_munmap_start_freed(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     /* unmap the first page. */
> > +     ret =3D sys_munmap(ptr, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal the last 3 pages. */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr + page_size, 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* unmap from the first page. */
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +             size =3D get_vma_size(ptr + page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D page_size * 3);
> > +     } else {
> > +             /* note: this will be OK, even the first page is */
> > +             /* already unmapped. */
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +             size =3D get_vma_size(ptr + page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 0);
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_munmap_end_freed(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +     /* unmap last page. */
> > +     ret =3D sys_munmap(ptr + page_size * 3, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal the first 3 pages. */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* unmap all pages. */
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_munmap_middle_freed(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     /* unmap 2 pages in the middle. */
> > +     ret =3D sys_munmap(ptr + page_size, page_size * 2);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* seal the first page. */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* munmap all 4 pages. */
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +
> > +             size =3D get_vma_size(ptr + page_size * 3, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 0);
> > +
> > +             size =3D get_vma_size(ptr + page_size * 3, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 0);
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_shrink(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* shrink from 4 pages to 2 pages. */
> > +     ret2 =3D mremap(ptr, size, 2 * page_size, 0, 0);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(ret2 !=3D MAP_FAILED);
> > +
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_expand(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +     /* ummap last 2 pages. */
> > +     ret =3D sys_munmap(ptr + 2 * page_size, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* expand from 2 page to 4 pages. */
> > +     ret2 =3D mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > +
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_move(bool seal)
> > +{
> > +     void *ptr, *newPtr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +     setup_single_address(size, &newPtr);
> > +     clean_single_address(newPtr, size);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* move from ptr to fixed address. */
> > +     ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, n=
ewPtr);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(ret2 !=3D MAP_FAILED);
> > +
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mmap_overwrite_prot(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* use mmap to change protection. */
> > +     ret2 =3D sys_mmap(ptr, size, PROT_NONE,
> > +                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mmap_expand(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 12 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +     /* ummap last 4 pages. */
> > +     ret =3D sys_munmap(ptr + 8 * page_size, 4 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, 8 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* use mmap to expand. */
> > +     ret2 =3D sys_mmap(ptr, size, PROT_READ,
> > +                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mmap_shrink(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 12 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* use mmap to shrink. */
> > +     ret2 =3D sys_mmap(ptr, 8 * page_size, PROT_READ,
> > +                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_shrink_fixed(bool seal)
> > +{
> > +     void *ptr;
> > +     void *newAddr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +     setup_single_address(size, &newAddr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* mremap to move and shrink to fixed address */
> > +     ret2 =3D mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP=
_FIXED,
> > +                     newAddr);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_expand_fixed(bool seal)
> > +{
> > +     void *ptr;
> > +     void *newAddr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(page_size, &ptr);
> > +     setup_single_address(size, &newAddr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(newAddr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* mremap to move and expand to fixed address */
> > +     ret2 =3D mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIX=
ED,
> > +                     newAddr);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_move_fixed(bool seal)
> > +{
> > +     void *ptr;
> > +     void *newAddr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +     setup_single_address(size, &newAddr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(newAddr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* mremap to move to fixed address */
> > +     ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, n=
ewAddr);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_move_fixed_zero(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /*
> > +      * MREMAP_FIXED can move the mapping to zero address
> > +      */
> > +     ret2 =3D mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP=
_FIXED,
> > +                     0);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D 0);
> > +
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_move_dontunmap(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* mremap to move, and don't unmap src addr. */
> > +     ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMA=
P, 0);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(ret2 !=3D MAP_FAILED);
> > +
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /*
> > +      * The 0xdeaddead should not have effect on dest addr
> > +      * when MREMAP_DONTUNMAP is set.
> > +      */
> > +     ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMA=
P,
> > +                     0xdeaddead);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(ret2 !=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE((long)ret2 !=3D 0xdeaddead);
> > +
> > +     }
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +
> > +static void test_seal_merge_and_split(void)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size;
> > +     int ret;
> > +     int prot;
> > +
> > +     /* (24 RO) */
> > +     setup_single_address(24 * page_size, &ptr);
> > +
> > +     /* use mprotect(NONE) to set out boundary */
> > +     /* (1 NONE) (22 RO) (1 NONE) */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_NONE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     ret =3D sys_mprotect(ptr + 23 * page_size, page_size, PROT_NONE);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     size =3D get_vma_size(ptr + page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 22 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +     /* use mseal to split from beginning */
> > +     /* (1 NONE) (1 RO_SEAL) (21 RO) (1 NONE) */
> > +     ret =3D sys_mseal(ptr + page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     size =3D get_vma_size(ptr + page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     size =3D get_vma_size(ptr + 2 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 21 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +     /* use mseal to split from the end. */
> > +     /* (1 NONE) (1 RO_SEAL) (20 RO) (1 RO_SEAL) (1 NONE) */
> > +     ret =3D sys_mseal(ptr + 22 * page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     size =3D get_vma_size(ptr + 22 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     size =3D get_vma_size(ptr + 2 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 20 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +     /* merge with prev. */
> > +     /* (1 NONE) (2 RO_SEAL) (19 RO) (1 RO_SEAL) (1 NONE) */
> > +     ret =3D sys_mseal(ptr + 2 * page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     size =3D get_vma_size(ptr +  page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D  2 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +     /* merge with after. */
> > +     /* (1 NONE) (2 RO_SEAL) (18 RO) (2 RO_SEALS) (1 NONE) */
> > +     ret =3D sys_mseal(ptr + 21 * page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     size =3D get_vma_size(ptr +  21 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D  2 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +     /* split and merge from prev */
> > +     /* (1 NONE) (3 RO_SEAL) (17 RO) (2 RO_SEALS) (1 NONE) */
> > +     ret =3D sys_mseal(ptr + 2 * page_size, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     size =3D get_vma_size(ptr +  1 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D  3 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     ret =3D sys_munmap(ptr + page_size,  page_size);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +     ret =3D sys_mprotect(ptr + 2 * page_size, page_size,  PROT_NONE);
> > +     FAIL_TEST_IF_FALSE(ret < 0);
> > +
> > +     /* split and merge from next */
> > +     /* (1 NONE) (3 RO_SEAL) (16 RO) (3 RO_SEALS) (1 NONE) */
> > +     ret =3D sys_mseal(ptr + 20 * page_size, 2 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     size =3D get_vma_size(ptr +  20 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D  3 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +     /* merge from middle of prev and middle of next. */
> > +     /* (1 NONE) (22 RO_SEAL) (1 NONE) */
> > +     ret =3D sys_mseal(ptr + 2 * page_size, 20 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +     size =3D get_vma_size(ptr +  page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D  22 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_discard_ro_anon_on_rw(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address_rw(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* sealing doesn't take effect on RW memory. */
> > +     ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* base seal still apply. */
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_discard_ro_anon_on_pkey(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     int pkey;
> > +
> > +     SKIP_TEST_IF_FALSE(pkey_supported());
> > +
> > +     setup_single_address_rw(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     pkey =3D sys_pkey_alloc(0, 0);
> > +     FAIL_TEST_IF_FALSE(pkey > 0);
> > +
> > +     ret =3D sys_mprotect_pkey((void *)ptr, size, PROT_READ | PROT_WRI=
TE, pkey);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* sealing doesn't take effect if PKRU allow write. */
> > +     set_pkey(pkey, 0);
> > +     ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* sealing will take effect if PKRU deny write. */
> > +     set_pkey(pkey, PKEY_DISABLE_WRITE);
> > +     ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* base seal still apply. */
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_discard_ro_anon_on_filebacked(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     int fd;
> > +     unsigned long mapflags =3D MAP_PRIVATE;
> > +
> > +     fd =3D memfd_create("test", 0);
> > +     FAIL_TEST_IF_FALSE(fd > 0);
> > +
> > +     ret =3D fallocate(fd, 0, 0, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, fd, 0);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D MAP_FAILED);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* sealing doesn't apply for file backed mapping. */
> > +     ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     close(fd);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_discard_ro_anon_on_shared(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     unsigned long mapflags =3D MAP_ANONYMOUS | MAP_SHARED;
> > +
> > +     ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, -1, 0);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* sealing doesn't apply for shared mapping. */
> > +     ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +static void test_seal_discard_ro_anon(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +
> > +     setup_single_address(size, &ptr);
> > +
> > +     if (seal)
> > +             seal_single_address(ptr, size);
> > +
> > +     ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_munmap(ptr, size);
> > +     if (seal)
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +     else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     TEST_END_CHECK();
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +     bool test_seal =3D seal_support();
> > +
> > +     ksft_print_header();
> > +
> > +     if (!test_seal)
> > +             ksft_exit_skip("sealing not supported, check CONFIG_64BIT=
\n");
> > +
> > +     if (!pkey_supported())
> > +             ksft_print_msg("PKEY not supported\n");
> > +
> > +     ksft_set_plan(80);
> > +
> > +     test_seal_addseal();
> > +     test_seal_unmapped_start();
> > +     test_seal_unmapped_middle();
> > +     test_seal_unmapped_end();
> > +     test_seal_multiple_vmas();
> > +     test_seal_split_start();
> > +     test_seal_split_end();
> > +     test_seal_invalid_input();
> > +     test_seal_zero_length();
> > +     test_seal_twice();
> > +
> > +     test_seal_mprotect(false);
> > +     test_seal_mprotect(true);
> > +
> > +     test_seal_start_mprotect(false);
> > +     test_seal_start_mprotect(true);
> > +
> > +     test_seal_end_mprotect(false);
> > +     test_seal_end_mprotect(true);
> > +
> > +     test_seal_mprotect_unalign_len(false);
> > +     test_seal_mprotect_unalign_len(true);
> > +
> > +     test_seal_mprotect_unalign_len_variant_2(false);
> > +     test_seal_mprotect_unalign_len_variant_2(true);
> > +
> > +     test_seal_mprotect_two_vma(false);
> > +     test_seal_mprotect_two_vma(true);
> > +
> > +     test_seal_mprotect_two_vma_with_split(false);
> > +     test_seal_mprotect_two_vma_with_split(true);
> > +
> > +     test_seal_mprotect_partial_mprotect(false);
> > +     test_seal_mprotect_partial_mprotect(true);
> > +
> > +     test_seal_mprotect_two_vma_with_gap(false);
> > +     test_seal_mprotect_two_vma_with_gap(true);
> > +
> > +     test_seal_mprotect_merge(false);
> > +     test_seal_mprotect_merge(true);
> > +
> > +     test_seal_mprotect_split(false);
> > +     test_seal_mprotect_split(true);
> > +
> > +     test_seal_munmap(false);
> > +     test_seal_munmap(true);
> > +     test_seal_munmap_two_vma(false);
> > +     test_seal_munmap_two_vma(true);
> > +     test_seal_munmap_vma_with_gap(false);
> > +     test_seal_munmap_vma_with_gap(true);
> > +
> > +     test_munmap_start_freed(false);
> > +     test_munmap_start_freed(true);
> > +     test_munmap_middle_freed(false);
> > +     test_munmap_middle_freed(true);
> > +     test_munmap_end_freed(false);
> > +     test_munmap_end_freed(true);
> > +
> > +     test_seal_mremap_shrink(false);
> > +     test_seal_mremap_shrink(true);
> > +     test_seal_mremap_expand(false);
> > +     test_seal_mremap_expand(true);
> > +     test_seal_mremap_move(false);
> > +     test_seal_mremap_move(true);
> > +
> > +     test_seal_mremap_shrink_fixed(false);
> > +     test_seal_mremap_shrink_fixed(true);
> > +     test_seal_mremap_expand_fixed(false);
> > +     test_seal_mremap_expand_fixed(true);
> > +     test_seal_mremap_move_fixed(false);
> > +     test_seal_mremap_move_fixed(true);
> > +     test_seal_mremap_move_dontunmap(false);
> > +     test_seal_mremap_move_dontunmap(true);
> > +     test_seal_mremap_move_fixed_zero(false);
> > +     test_seal_mremap_move_fixed_zero(true);
> > +     test_seal_mremap_move_dontunmap_anyaddr(false);
> > +     test_seal_mremap_move_dontunmap_anyaddr(true);
> > +     test_seal_discard_ro_anon(false);
> > +     test_seal_discard_ro_anon(true);
> > +     test_seal_discard_ro_anon_on_rw(false);
> > +     test_seal_discard_ro_anon_on_rw(true);
> > +     test_seal_discard_ro_anon_on_shared(false);
> > +     test_seal_discard_ro_anon_on_shared(true);
> > +     test_seal_discard_ro_anon_on_filebacked(false);
> > +     test_seal_discard_ro_anon_on_filebacked(true);
> > +     test_seal_mmap_overwrite_prot(false);
> > +     test_seal_mmap_overwrite_prot(true);
> > +     test_seal_mmap_expand(false);
> > +     test_seal_mmap_expand(true);
> > +     test_seal_mmap_shrink(false);
> > +     test_seal_mmap_shrink(true);
> > +
> > +     test_seal_merge_and_split();
> > +     test_seal_zero_address();
> > +
> > +     test_seal_discard_ro_anon_on_pkey(false);
> > +     test_seal_discard_ro_anon_on_pkey(true);
> > +
> > +     ksft_finished();
> > +     return 0;
> > +}
>

