Return-Path: <linux-kselftest+bounces-16813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0E9665FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB351C2086B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DDB1B78F1;
	Fri, 30 Aug 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DxXeG8Bn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3A1B81A7
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032744; cv=none; b=WaDbgKZQpyH8FBAC9FJwGHPZvT1kmPCSUevP0K1TV3a9xgEjj2yGWDesQCDQ5eAbPrd/3zK9qTMd00I07hk8v1Vh7jygLZSc2KXEcSN5gBuDZQsKr4XM0wKbGAwm2UcJqotuPg3ha/9GK5dou/7Actwj/b4mhbtFDNVS7JbEx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032744; c=relaxed/simple;
	bh=qegRfOSsqOIYfGp8nOFfAHan0oVJKnXtXhuLbegFNU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBpVQFxdHRfJo0ZPJAA6zTm4FzNzfBwgcnB1Pxuz9TcoaAx2yGt3DeCLzTj7lJsoucitKOB5H7ygg/JrdmwrSyJC2Nu03gxFofCThcXb+x+iEcIZ3BXCD1ZmncFaPpwaDNs2mLcHCAHUgq7SXJi9A+sHuuMMcmACZX2YMGOngU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DxXeG8Bn; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5e2de5d78so109699eaf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725032740; x=1725637540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diHxpaObCuY/Na0aMWkJnZUQW0vAuk4Wy8/UKvM3WNM=;
        b=DxXeG8Bn5xZG5NOrG4X63mhY7BokuxX0HwOnqtopPSJMcmGX4YrMXa2Yuo9sPZlhmG
         Zu+oCSTPBv3ARIgV/k8bPrPwxAJi3rL4DpgPvUGImYmHe6qudGt0Qhd74yY+bAH5Ked/
         RWP7hXR/NVDYTCHs3nYLL+J4o92F+3fK7VWFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032740; x=1725637540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diHxpaObCuY/Na0aMWkJnZUQW0vAuk4Wy8/UKvM3WNM=;
        b=AgzVNWECk9aAGi+gLKXIxcWjPJCCn35hlSYw187AgqZSUDcZ9T9Q2oqYQmmAG7skcV
         bduXo7C02AxMzOv+nnurKqGppU83ke50YgKDCJ+c8rDBAU2Xje9z3MUSsNBlO0Be6zi1
         wEOGbX9n+88mEr7pT1+0Wy9sztJ1fGApKcRXEds+QtiTI6Q1EHda2KYcK6UU2ABPTiOl
         VSLES1FRAoQQ2cDGQHqUNs50nbsvxzELxDtLBaL1/rqvkItJdlETe4k5R1BFYalSNOT6
         aI1sYHtBY5FNcjp1myhBIqbcljbbwTHwNkL3u+0lEvF+HONgZJV7B3LALtlETYcfZc2s
         +TMg==
X-Forwarded-Encrypted: i=1; AJvYcCUXWrxm1P9/HMgjlFkxeItSsCM3sT7cnJBfpe+YDKqUyljioP7D5TtbduLp98wrXy94S8xVCX8ennv54W+CKyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZEDO1CLGb3Wy6Vzi6vgM/ZMWBSW611jwyxcOkc5XSiYC++hO
	mJ7vhaEVL65vfo1Ob+4pOkuGaeM37ZmceOsFgf92xYEvq1aPPAcDLTaHqYLed4BjKbssPUe4rU6
	UVzqameBYm9imVWaTVIoYaWOKhVvzjM+kseeH
X-Google-Smtp-Source: AGHT+IETdqnffGl1wlDVPNZi2RdYF+H4YTFQcXLE/WIaSGCb3cOnhh+mmFpSSN+HbA/bklt1b8l0l6j8VLc29HW02Ts=
X-Received: by 2002:a05:6871:153:b0:25e:c0b:82c5 with SMTP id
 586e51a60fabf-277b0bb9021mr1368078fac.3.1725032740303; Fri, 30 Aug 2024
 08:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214352.963001-1-jeffxu@chromium.org> <20240829214352.963001-2-jeffxu@chromium.org>
 <r4afvwpehewar3eeqp7vn5tx25mld4y5ub7bngwqzeozoibiq7@6crbbgfwbign>
In-Reply-To: <r4afvwpehewar3eeqp7vn5tx25mld4y5ub7bngwqzeozoibiq7@6crbbgfwbign>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 08:45:28 -0700
Message-ID: <CABi2SkWbSdgr3pJKWF-JsFQwNnMV1xC_EX19CWQU_yzfJgHtsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] selftests/mm: mseal_test, add vma size check
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Fri, Aug 30, 2024 at 5:45=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 29, 2024 at 09:43:49PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add check for vma size, prot bits and error return.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 398 ++++++++++++++++++++----
> >  1 file changed, 332 insertions(+), 66 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index e7991e5fdcf3..adc646cf576c 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -170,18 +170,31 @@ static void set_pkey(int pkey, unsigned long pkey=
_value)
> >  static void setup_single_address(int size, void **ptrOut)
> >  {
> >       void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> >
> > -     ptr =3D mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, =
-1, 0);
> > -     *ptrOut =3D ptr;
> > +     *ptrOut =3D (void *)-1;
> > +     ptr =3D mmap(NULL, size + 2 * page_size, PROT_READ, MAP_ANONYMOUS=
 | MAP_PRIVATE, -1, 0);
> > +     if (ptr !=3D (void *) -1) {
>
> MAP_FAILED, not (void *) -1
>
ok.

> > +             /* add 2 page at the beginning and end to avoid auto-merg=
e of mapping */
> > +             sys_mprotect(ptr, page_size, PROT_NONE);
> > +             sys_mprotect(ptr + size + page_size, page_size, PROT_NONE=
);
> > +             *ptrOut =3D ptr + page_size;
> > +     }
> >  }
> >
> >  static void setup_single_address_rw(int size, void **ptrOut)
> >  {
> >       void *ptr;
> >       unsigned long mapflags =3D MAP_ANONYMOUS | MAP_PRIVATE;
> > +     unsigned long page_size =3D getpagesize();
> >
> > -     ptr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0)=
;
> > -     *ptrOut =3D ptr;
> > +     *ptrOut =3D (void *)-1;
> > +     ptr =3D mmap(NULL, size + 2 * page_size, PROT_READ | PROT_WRITE, =
mapflags, -1, 0);
> > +     if (ptr !=3D (void *) -1) {
>
> Same here.
ok.

> > +             sys_mprotect(ptr, page_size, PROT_NONE);
> > +             sys_mprotect(ptr + size + page_size, page_size, PROT_NONE=
);
> > +             *ptrOut =3D ptr + page_size;
> > +     }
> >  }
> >
> >  static int clean_single_address(void *ptr, int size)
> > @@ -226,6 +239,21 @@ bool pkey_supported(void)
> >       return false;
> >  }
> >
> > +bool get_vma_size_supported(void)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     size =3D get_vma_size(ptr, &prot);
> > +     if (size =3D=3D 4 * page_size && prot =3D=3D 0x4)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  static void test_seal_addseal(void)
> >  {
> >       int ret;
> > @@ -419,11 +447,17 @@ static void test_seal_invalid_input(void)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >
> > -     setup_single_address(8 * page_size, &ptr);
> > +     setup_single_address(9 * page_size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > -     ret =3D clean_single_address(ptr + 4 * page_size, 4 * page_size);
> > +
> > +     ret =3D clean_single_address(ptr, page_size);
> >       FAIL_TEST_IF_FALSE(!ret);
> >
> > +     ret =3D clean_single_address(ptr + 5 * page_size, 4 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ptr =3D ptr + page_size;
> > +
> >       /* invalid flag */
> >       ret =3D syscall(__NR_mseal, ptr, size, 0x20);
> >       FAIL_TEST_IF_FALSE(ret < 0);
> > @@ -523,6 +557,7 @@ static void test_seal_mprotect(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -533,9 +568,14 @@ static void test_seal_mprotect(bool seal)
> >       }
> >
> >       ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -547,6 +587,7 @@ static void test_seal_start_mprotect(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -558,9 +599,14 @@ static void test_seal_start_mprotect(bool seal)
> >
> >       /* the first page is sealed. */
> >       ret =3D sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       /* pages after the first page is not sealed. */
> > @@ -577,6 +623,7 @@ static void test_seal_end_mprotect(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -593,9 +640,14 @@ static void test_seal_end_mprotect(bool seal)
> >       /* last 3 page are sealed */
> >       ret =3D sys_mprotect(ptr + page_size, page_size * 3,
> >                       PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr + page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -607,6 +659,7 @@ static void test_seal_mprotect_unalign_len(bool sea=
l)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -618,9 +671,14 @@ static void test_seal_mprotect_unalign_len(bool se=
al)
> >
> >       /* 2 pages are sealed. */
> >       ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       ret =3D sys_mprotect(ptr + page_size * 2, page_size,
> > @@ -636,6 +694,7 @@ static void test_seal_mprotect_unalign_len_variant_=
2(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -646,9 +705,14 @@ static void test_seal_mprotect_unalign_len_variant=
_2(bool seal)
> >
> >       /* 3 pages are sealed. */
> >       ret =3D sys_mprotect(ptr, page_size * 3, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       ret =3D sys_mprotect(ptr + page_size * 3, page_size,
> > @@ -664,6 +728,7 @@ static void test_seal_mprotect_two_vma(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -678,16 +743,26 @@ static void test_seal_mprotect_two_vma(bool seal)
> >       }
> >
> >       ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x6);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       ret =3D sys_mprotect(ptr + page_size * 2, page_size * 2,
> >                       PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr + page_size * 2, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -699,6 +774,7 @@ static void test_seal_mprotect_two_vma_with_split(b=
ool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -719,17 +795,27 @@ static void test_seal_mprotect_two_vma_with_split=
(bool seal)
> >
> >       /* the second page is sealed. */
> >       ret =3D sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT=
_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x6);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       /* the third page is sealed. */
> >       ret =3D sys_mprotect(ptr + 2 * page_size, page_size,
> >                       PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr + 2 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       /* the fouth page is not sealed. */
> > @@ -746,6 +832,7 @@ static void test_seal_mprotect_partial_mprotect(boo=
l seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -758,9 +845,14 @@ static void test_seal_mprotect_partial_mprotect(bo=
ol seal)
> >
> >       /* mprotect first 2 page will fail, since the first page are seal=
ed. */
> >       ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -783,15 +875,15 @@ static void test_seal_mprotect_partial_mprotect_t=
ail(bool seal)
> >       }
> >
> >       ret =3D sys_mprotect(ptr, size, PROT_EXEC);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > -             FAIL_TEST_IF_FALSE(!ret);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> >
> > -     if (seal) {
> > -             FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) >=
 0);
> > +             size =3D get_vma_size(ptr + page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> >               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > -     }
> > +     } else
> > +             FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> >  }
> > @@ -846,6 +938,7 @@ static void test_seal_mprotect_split(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -862,16 +955,34 @@ static void test_seal_mprotect_split(bool seal)
> >
> >       /* mprotect is sealed. */
> >       ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x6);
> > +
> > +             size =3D get_vma_size(ptr + page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >
> >       ret =3D sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_REA=
D);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x6);
> > +
> > +             size =3D get_vma_size(ptr + page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -883,6 +994,7 @@ static void test_seal_mprotect_merge(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -899,9 +1011,18 @@ static void test_seal_mprotect_merge(bool seal)
> >
> >       /* 2 pages are sealed. */
> >       ret =3D sys_mprotect(ptr, 2 * page_size, PROT_READ);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x6);
> > +
> > +             size =3D get_vma_size(ptr + page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       /* last 2 pages are not sealed. */
> > @@ -917,6 +1038,7 @@ static void test_seal_munmap(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -928,9 +1050,14 @@ static void test_seal_munmap(bool seal)
> >
> >       /* 4 pages are sealed. */
> >       ret =3D sys_munmap(ptr, size);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -948,6 +1075,7 @@ static void test_seal_munmap_two_vma(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -962,15 +1090,33 @@ static void test_seal_munmap_two_vma(bool seal)
> >       }
> >
> >       ret =3D sys_munmap(ptr, page_size * 2);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x6);
> > +
> > +             size =3D get_vma_size(ptr + 2 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       ret =3D sys_munmap(ptr + page_size, page_size * 2);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x6);
> > +
> > +             size =3D get_vma_size(ptr + 2 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -1018,33 +1164,75 @@ static void test_seal_munmap_partial_across_vma=
s(bool seal)
> >  {
> >       void *ptr;
> >       unsigned long page_size =3D getpagesize();
> > -     unsigned long size =3D 2 * page_size;
> > +     unsigned long size =3D 12 * page_size;
> >       int ret;
> >       int prot;
> >
> > -     /*
> > -      * Check if a partial mseal (that results in two vmas) works corr=
ectly.
> > -      * It might unmap the first, but it'll never unmap the second (ms=
ealed) vma.
> > -      */
> > -
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> >
> >       if (seal) {
> > -             ret =3D sys_mseal(ptr + page_size, page_size);
> > +             ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> >               FAIL_TEST_IF_FALSE(!ret);
> >       }
> >
> > -     ret =3D sys_munmap(ptr, size);
> > -     if (seal)
> > +     ret =3D sys_munmap(ptr, 12 * page_size);
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +             size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +             size =3D get_vma_size(ptr + 8 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> > +
> > +     ret =3D sys_munmap(ptr, 6 * page_size);
> >       if (seal) {
> > -             FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) >=
 0);
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +             size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> >               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > -     }
> > +
> > +             size =3D get_vma_size(ptr + 8 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     ret =3D sys_munmap(ptr + 6 * page_size, 6 * page_size);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +             size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +             size =3D get_vma_size(ptr + 8 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> >  }
> > @@ -1074,9 +1262,11 @@ static void test_munmap_start_freed(bool seal)
> >       ret =3D sys_munmap(ptr, size);
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> >
> >               size =3D get_vma_size(ptr + page_size, &prot);
> > -             FAIL_TEST_IF_FALSE(size =3D=3D page_size * 3);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else {
> >               /* note: this will be OK, even the first page is */
> >               /* already unmapped. */
> > @@ -1095,6 +1285,7 @@ static void test_munmap_end_freed(bool seal)
> >       unsigned long page_size =3D getpagesize();
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1111,9 +1302,14 @@ static void test_munmap_end_freed(bool seal)
> >
> >       /* unmap all pages. */
> >       ret =3D sys_munmap(ptr, size);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       REPORT_TEST_PASS();
> > @@ -1144,12 +1340,15 @@ static void test_munmap_middle_freed(bool seal)
> >       ret =3D sys_munmap(ptr, size);
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> >
> >               size =3D get_vma_size(ptr, &prot);
> >               FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >
> >               size =3D get_vma_size(ptr + page_size * 3, &prot);
> >               FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else {
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> > @@ -1170,6 +1369,7 @@ static void test_seal_mremap_shrink(bool seal)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1184,6 +1384,10 @@ static void test_seal_mremap_shrink(bool seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D (void *) MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else {
> >               FAIL_TEST_IF_FALSE(ret2 !=3D (void *) MAP_FAILED);
> >
> > @@ -1199,6 +1403,7 @@ static void test_seal_mremap_expand(bool seal)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1216,6 +1421,10 @@ static void test_seal_mremap_expand(bool seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> >
> > @@ -1231,6 +1440,7 @@ static void test_seal_mremap_move(bool seal)
> >       unsigned long size =3D page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1249,10 +1459,12 @@ static void test_seal_mremap_move(bool seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > -     } else {
> > -             FAIL_TEST_IF_FALSE(ret2 !=3D MAP_FAILED);
> >
> > -     }
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D  page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 !=3D MAP_FAILED);
> >
> >       REPORT_TEST_PASS();
> >  }
> > @@ -1264,6 +1476,7 @@ static void test_seal_mmap_overwrite_prot(bool se=
al)
> >       unsigned long size =3D page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1279,6 +1492,10 @@ static void test_seal_mmap_overwrite_prot(bool s=
eal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> >
> > @@ -1292,6 +1509,7 @@ static void test_seal_mmap_expand(bool seal)
> >       unsigned long size =3D 12 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1310,6 +1528,10 @@ static void test_seal_mmap_expand(bool seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 8 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> >
> > @@ -1323,6 +1545,7 @@ static void test_seal_mmap_shrink(bool seal)
> >       unsigned long size =3D 12 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1338,6 +1561,10 @@ static void test_seal_mmap_shrink(bool seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 12 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> >
> > @@ -1352,6 +1579,7 @@ static void test_seal_mremap_shrink_fixed(bool se=
al)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1369,6 +1597,10 @@ static void test_seal_mremap_shrink_fixed(bool s=
eal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
> >
> > @@ -1383,6 +1615,7 @@ static void test_seal_mremap_expand_fixed(bool se=
al)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(page_size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1400,6 +1633,10 @@ static void test_seal_mremap_expand_fixed(bool s=
eal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(newAddr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
> >
> > @@ -1414,6 +1651,7 @@ static void test_seal_mremap_move_fixed(bool seal=
)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1430,6 +1668,10 @@ static void test_seal_mremap_move_fixed(bool sea=
l)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(newAddr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
> >
> > @@ -1443,6 +1685,7 @@ static void test_seal_mremap_move_fixed_zero(bool=
 seal)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1460,9 +1703,12 @@ static void test_seal_mremap_move_fixed_zero(boo=
l seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > -     } else {
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D 0);
> > -     }
> >
> >       REPORT_TEST_PASS();
> >  }
> > @@ -1474,6 +1720,7 @@ static void test_seal_mremap_move_dontunmap(bool =
seal)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1488,6 +1735,10 @@ static void test_seal_mremap_move_dontunmap(bool=
 seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else {
> >               /* kernel will allocate a new address */
> >               FAIL_TEST_IF_FALSE(ret2 !=3D MAP_FAILED);
> > @@ -1503,6 +1754,7 @@ static void test_seal_mremap_move_dontunmap_anyad=
dr(bool seal)
> >       unsigned long size =3D 4 * page_size;
> >       int ret;
> >       void *ret2;
> > +     int prot;
> >
> >       setup_single_address(size, &ptr);
> >       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > @@ -1529,6 +1781,10 @@ static void test_seal_mremap_move_dontunmap_anya=
ddr(bool seal)
> >       if (seal) {
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> >               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> >       } else {
> >               /* remap success and return ptr2 */
> >               FAIL_TEST_IF_FALSE(ret2 =3D=3D  ptr2);
> > @@ -1690,9 +1946,10 @@ static void test_seal_discard_ro_anon_on_pkey(bo=
ol seal)
> >       /* sealing will take effect if PKRU deny write. */
> >       set_pkey(pkey, PKEY_DISABLE_WRITE);
> >       ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> > -     if (seal)
> > +     if (seal) {
> >               FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     } else
> >               FAIL_TEST_IF_FALSE(!ret);
> >
> >       /* base seal still apply. */
>
> FWIW I can't review any of the above. It's still a hard to review patch w=
ith a bunch of unrelated changes
> including VMA size, random errno checks, random vma size checks, etc.
>
The EPERM is the standard error code for modifying the sealed memory.
The vma size and prot is to verify the sealed memory isn't changed
after modifying the sealed memory.

Those are all "must-check" parts of verifying the sealing. Now,
previously with out-of-loop checks, there is no need to check any of
those because once EPERM is returned, nothing will be modified. With
in-loop change, this becomes necessary.  I do not think it is
reasonable to split the case further, i.e. go to the exact same
scenario multiple times to check different attributes of sealing.

Thanks
-Jeff


> Maybe break this down in separate patches.
>
> > @@ -1876,6 +2133,15 @@ int main(int argc, char **argv)
> >       if (!pkey_supported())
> >               ksft_print_msg("PKEY not supported\n");
> >
> > +     /*
> > +      * Possible reasons:
> > +      * - unable to read /proc/pid/maps (unlikely)
> > +      * - parsing error when reading /proc/pid/maps,e.g. len is not ex=
pected.
> > +      *   Is this "TOPDOWN" mapping or format change in /proc/pid/maps=
 ?
>
> Why do we care? I don't think running selftests without a procfs mount is=
 supported in any way...
> Format won't change.
>
> --
> Pedro

