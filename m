Return-Path: <linux-kselftest+bounces-15281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F5950FC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 00:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050702857E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA951AB51D;
	Tue, 13 Aug 2024 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IODBnvVC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22449658
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588172; cv=none; b=KEKTspVsLYamYqLeiVqXKg67gDv9+8mH4MSUzQvtMhKqKHCdbR1mTw33DYKB5dVnYD+jrTKdrZYax4vg7ulo0sGoSP8tcz2QjBk1dwWNdHqhuxNPUTXSqf3tswDOztWbqDWwcKLUGQd4P7w8LWF1xDZjAlxFwFVgcvwr46FNlOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588172; c=relaxed/simple;
	bh=DeBM2Jzf7ccIDFSZ1n1rUvgA11CE3Kqq+U6VPxsqQLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPYxwWZm5opPR+ggZmVBcQHVz+7YW82hcEPUQ2lXlyIAHraaEBXI6GpmBV6kqrJ/vQOxJckWiviiiwHuaDzEULy+baEiPpfBOG6qO5BrU5NjpvkdbkLUwAtvu8LSI4SrqJnj9YKe543Evpu+2wG9uceLfKtmDbeBvpUWyYJG5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IODBnvVC; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db1eb76702so4392752b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723588168; x=1724192968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykgogzbyK4rVzg7RHnLmQ4IP974gSr6UIGGUTaoRMNw=;
        b=IODBnvVCtIc/6qEKMLXKfXeo8Chb30o+j1ThuKPSovT3Xc/QgcQmYhDfEpNLz2iSyM
         oS4lG5LMsYSy8cmJRarF0gGV1ptzPpXnh+I3qVThJpqdgkHsGyB8oTI3l0CwqfpKREfg
         sskjDOWrxYluAo+Ot0iffxKHnQ4C/2PULlSkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588168; x=1724192968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykgogzbyK4rVzg7RHnLmQ4IP974gSr6UIGGUTaoRMNw=;
        b=dSXP9Tk00ehszN5zzhoLh59bOXrKITdhjmsyOGzoD7j2DJ1iZLiprZ+5T09CV+/0c0
         vdfgYCY+HOWUmsyKn4dJe3fKjyHb+RfkxUnIyZv3KZ87GMwkXPmBoZCT3vN5YZaH4kdi
         kFs4e+L+KiV0Vx4+bSPF9hagqMUGi8N8d89F/vTRJGOW2kFJxquyrpsacRQKc2VwZXYv
         pHtqR++xkMhLnns2UvcxQ+ol67AIEmlkeX/fBumnzp6fw4ADhW5sjmN8UPbv61T50uHo
         uPQC/YvHa7g1cAhBv3sKcSvGmqHSYsiiZ6ktrADGHAsPykuIVSLPVxih+gRUSoLXGXSk
         0wbg==
X-Forwarded-Encrypted: i=1; AJvYcCV12nDlEE03OOPIdJrNXeYj1xeBl4kZmm+ECdCHopRP51T8E5pG+4uSQZXt5SNhcfRxDkVvaa6pL+E10hqX2NEgrUYdfxna+hWPaaC5aHLy
X-Gm-Message-State: AOJu0YxPXbyfKeXnhGd6KKJ6UvVk89xfoXMBtu2rQvlfcIqfFD6L7uaI
	ScQU23WYGz2ar1xd3iu6iIscxFUdNUi+VcKz2KKK7mNs9fl2IiPtR+IrtheNhO67QJ0aFcHwRQz
	jJYVMPqniwIQZczkObw/RnhEEfoBAl2nXZfr8
X-Google-Smtp-Source: AGHT+IGXHIA4OWX84r+ntsCxm1tIJRtPKmOxukETI3Iw8Kz6QgOTU2Exfj1kzAPmWxXmkmIxn7Epu9zjwMbuYGkdACw=
X-Received: by 2002:a05:6870:56a1:b0:260:ff24:fb32 with SMTP id
 586e51a60fabf-26fe59dc7a3mr1176459fac.1.1723588168189; Tue, 13 Aug 2024
 15:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809082511.497266-1-usama.anjum@collabora.com>
In-Reply-To: <20240809082511.497266-1-usama.anjum@collabora.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 13 Aug 2024 15:29:16 -0700
Message-ID: <CABi2SkWgPoWJY_CMxDru7FPjtQBgv61PA2VoCumd3T8Xq3fjbg@mail.gmail.com>
Subject: Re: [PATCH] selftests: mm: Fix build errors on armhf
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, kernel@collabora.com, 
	stable@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muhammad

On Fri, Aug 9, 2024 at 1:25=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> The __NR_mmap isn't found on armhf. The mmap() is commonly available
> system call and its wrapper is presnet on all architectures. So it
> should be used directly. It solves problem for armhf and doesn't create
> problem for architectures as well. Remove sys_mmap() functions as they
> aren't doing anything else other than calling mmap(). There is no need
> to set errno =3D 0 manually as glibc always resets it.
>
The mseal_test should't have dependency on libc, and mmap() is
implemented by glibc, right ?

I just fixed a bug to switch mremap() to sys_mremap to address an
issue that different glibc version's behavior is slightly different
for mremap().

What is the reason that __NR_mmap not available in armhf ? (maybe it
is another name ?)  there must be a way to call syscall directly on
armhf, can we use that instead ?

Thanks
-Jeff


> For reference errors are as following:
>
>   CC       seal_elf
> seal_elf.c: In function 'sys_mmap':
> seal_elf.c:39:33: error: '__NR_mmap' undeclared (first use in this functi=
on)
>    39 |         sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
>       |                                 ^~~~~~~~~
>
> mseal_test.c: In function 'sys_mmap':
> mseal_test.c:90:33: error: '__NR_mmap' undeclared (first use in this func=
tion)
>    90 |         sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
>       |                                 ^~~~~~~~~
>
> Cc: stable@vger.kernel.org
> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 37 +++++++++----------------
>  tools/testing/selftests/mm/seal_elf.c   | 13 +--------
>  2 files changed, 14 insertions(+), 36 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index a818f010de479..bfcea5cf9a484 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -81,17 +81,6 @@ static int sys_mprotect_pkey(void *ptr, size_t size, u=
nsigned long orig_prot,
>         return sret;
>  }
>
> -static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
> -       unsigned long flags, unsigned long fd, unsigned long offset)
> -{
> -       void *sret;
> -
> -       errno =3D 0;
> -       sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> -               flags, fd, offset);
> -       return sret;
> -}
> -
>  static int sys_munmap(void *ptr, size_t size)
>  {
>         int sret;
> @@ -172,7 +161,7 @@ static void setup_single_address(int size, void **ptr=
Out)
>  {
>         void *ptr;
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVA=
TE, -1, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, =
-1, 0);
>         *ptrOut =3D ptr;
>  }
>
> @@ -181,7 +170,7 @@ static void setup_single_address_rw(int size, void **=
ptrOut)
>         void *ptr;
>         unsigned long mapflags =3D MAP_ANONYMOUS | MAP_PRIVATE;
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1=
, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0)=
;
>         *ptrOut =3D ptr;
>  }
>
> @@ -205,7 +194,7 @@ bool seal_support(void)
>         void *ptr;
>         unsigned long page_size =3D getpagesize();
>
> -       ptr =3D sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_=
PRIVATE, -1, 0);
> +       ptr =3D mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIV=
ATE, -1, 0);
>         if (ptr =3D=3D (void *) -1)
>                 return false;
>
> @@ -481,8 +470,8 @@ static void test_seal_zero_address(void)
>         int prot;
>
>         /* use mmap to change protection. */
> -       ptr =3D sys_mmap(0, size, PROT_NONE,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ptr =3D mmap(0, size, PROT_NONE,
> +                  MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         FAIL_TEST_IF_FALSE(ptr =3D=3D 0);
>
>         size =3D get_vma_size(ptr, &prot);
> @@ -1209,8 +1198,8 @@ static void test_seal_mmap_overwrite_prot(bool seal=
)
>         }
>
>         /* use mmap to change protection. */
> -       ret2 =3D sys_mmap(ptr, size, PROT_NONE,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ret2 =3D mmap(ptr, size, PROT_NONE,
> +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         if (seal) {
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
>                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> @@ -1240,8 +1229,8 @@ static void test_seal_mmap_expand(bool seal)
>         }
>
>         /* use mmap to expand. */
> -       ret2 =3D sys_mmap(ptr, size, PROT_READ,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ret2 =3D mmap(ptr, size, PROT_READ,
> +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         if (seal) {
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
>                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> @@ -1268,8 +1257,8 @@ static void test_seal_mmap_shrink(bool seal)
>         }
>
>         /* use mmap to shrink. */
> -       ret2 =3D sys_mmap(ptr, 8 * page_size, PROT_READ,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ret2 =3D mmap(ptr, 8 * page_size, PROT_READ,
> +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         if (seal) {
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
>                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> @@ -1650,7 +1639,7 @@ static void test_seal_discard_ro_anon_on_filebacked=
(bool seal)
>         ret =3D fallocate(fd, 0, 0, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, fd, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ, mapflags, fd, 0);
>         FAIL_TEST_IF_FALSE(ptr !=3D MAP_FAILED);
>
>         if (seal) {
> @@ -1680,7 +1669,7 @@ static void test_seal_discard_ro_anon_on_shared(boo=
l seal)
>         int ret;
>         unsigned long mapflags =3D MAP_ANONYMOUS | MAP_SHARED;
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, -1, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ, mapflags, -1, 0);
>         FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
>
>         if (seal) {
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selfte=
sts/mm/seal_elf.c
> index 7aa1366063e4e..d9f8ba8d5050b 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -30,17 +30,6 @@ static int sys_mseal(void *start, size_t len)
>         return sret;
>  }
>
> -static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
> -       unsigned long flags, unsigned long fd, unsigned long offset)
> -{
> -       void *sret;
> -
> -       errno =3D 0;
> -       sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> -               flags, fd, offset);
> -       return sret;
> -}
> -
>  static inline int sys_mprotect(void *ptr, size_t size, unsigned long pro=
t)
>  {
>         int sret;
> @@ -56,7 +45,7 @@ static bool seal_support(void)
>         void *ptr;
>         unsigned long page_size =3D getpagesize();
>
> -       ptr =3D sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_=
PRIVATE, -1, 0);
> +       ptr =3D mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIV=
ATE, -1, 0);
>         if (ptr =3D=3D (void *) -1)
>                 return false;
>
> --
> 2.39.2
>

