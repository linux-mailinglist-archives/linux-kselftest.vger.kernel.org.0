Return-Path: <linux-kselftest+bounces-16816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348C96661F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF22283951
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0B1B653A;
	Fri, 30 Aug 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0IZ2yDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC4EEC3
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033191; cv=none; b=ClTlqg2JY7NAeDuZp0LCgphRow2MxqcKEW5/7C2I3X7XBHpTOQJyn/VomlAAcDlU/tutt2SMwrH0Ck4eYesOhDYAgtFLL9dDmp7N/COFRxmiO8TTWrmmlsWLo/No/4IKDOtYawxf99B7x7T/MnqFfRWs8sYQjLMP5N3CKl5uDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033191; c=relaxed/simple;
	bh=qsW4FlIIfZADyer+mOTLs3Dec7N90OtmhGbZyPEGz2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQRaF+fcItuGh3/F6saloOcliRxSpQva6CqmJiAgNkqxm9EnCDwuiv/5/ZcZbW9Mo+AtbQrMu40Tq8nYkW/GbIp4Me3XBvSN/4cWaYrSXLbHFgzPvWwJACsvhSND0S9vX+yuOAZRuC3h3tvXvkBDn32AqwEnK8548672C9MyLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R0IZ2yDI; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2610c095ea1so168246fac.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725033189; x=1725637989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1kleSOg8vL34NiCGn9nqKVN6gqzoun/xCRiElWIius=;
        b=R0IZ2yDId6zSaB7mdkEf6+MDFzL1AIA7YJXuLm8bCYdxLJuZVAqWCYH6znH7Y1OV33
         v8BNYew4i2zDSf8JP3HOITPK4vbyxPBCRbwD9ZvLct62cdzDZzxaO/hD3EK/TIV5vRtW
         L01TkSPRyNcSV7rLTMTfPLgjR1fu1mN6B7VVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033189; x=1725637989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1kleSOg8vL34NiCGn9nqKVN6gqzoun/xCRiElWIius=;
        b=erEZtDEGCsBZ71KFJlzUkgH8V+O903LNjLiDLGdweH/UESZ+fjnOTZMCNPHimG9T5A
         aonbYz9ypJI1G8nVCJKDXtute/JLYHXFNEOuv0Z0jJgIUwaAQKkB4ednSqHUVhv8hlxy
         LjUDzjYfSZDx1+kmvkmQfBcEClELZ2IIj57Lyy9W+ThaLH5UtDBmCKh0jQc1O2nd5rMR
         sxQl3ln2iY9JuOy+EfktlZG0T4MUngpe1dD/NCGQueRrY3Y5b99dmhVPqJ7y85ra1uPm
         IIBAgb9bZ9POvGH24CQu8F/JDa8/w8cYFRaiSDX5EiFzi/nVtVs+uls+soU5AMosz0sZ
         VqkA==
X-Forwarded-Encrypted: i=1; AJvYcCUcBmyBnKaU1Sdb7Q+g1rtndnumcuYDsDesP9z3Jd/VD6g5SE+pdB7giaIRMWMeZ7YXHeSX2EqZv40bI7s41f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDa5U8FGLm0PuQwFiKtiZhcGzJTiodnxQfx1Xv9QihKKkaLky3
	Ypvpsx3rAJfSpG9IGNOW1mU7gwO073Y+v+bwz91RqgCgdBLyzXHoPzmVXTPrtsvlETpHD4WNsf1
	NpyHz/xFAhztUttHKJc+2EvX5RtvB67+sD5p0
X-Google-Smtp-Source: AGHT+IFZoOc4OSRPXPIUfZBqHojHFqN6vZ6Boo4DEXXuYIpSR8r9zMBaustrBst6g13zZa+5yjghU8cVM0qraZJwXqQ=
X-Received: by 2002:a05:6870:71c6:b0:254:d417:351f with SMTP id
 586e51a60fabf-277b0b79a69mr1381287fac.1.1725033188911; Fri, 30 Aug 2024
 08:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214352.963001-1-jeffxu@chromium.org> <20240829214352.963001-4-jeffxu@chromium.org>
 <q3xvzsnyltr2gdgnecgw74umi2yrjvimkxo7bvgnqb4darakzw@jahjkavgcyfm>
In-Reply-To: <q3xvzsnyltr2gdgnecgw74umi2yrjvimkxo7bvgnqb4darakzw@jahjkavgcyfm>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 08:52:56 -0700
Message-ID: <CABi2SkUtCqLj49rpm4+vB1+SqaT9YAuAVwVj6PpaDbkJStZSVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selftests/mm: mseal_test add more tests for mmap
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Fri, Aug 30, 2024 at 5:57=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 29, 2024 at 09:43:51PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add sealing test to cover mmap for
> > Expand/shrink across vmas.
> > Reuse the same address in !MAP_FIXED case.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 125 +++++++++++++++++++++++-
> >  1 file changed, 124 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index ae06c354220d..d83538039e76 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -2222,6 +2222,122 @@ static void test_munmap_free_multiple_ranges(bo=
ol seal)
> >       REPORT_TEST_PASS();
> >  }
> >
> > +static void test_seal_mmap_expand_seal_middle(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 12 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +     /* ummap last 4 pages. */
> > +     ret =3D sys_munmap(ptr + 8 * page_size, 4 * page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     size =3D get_vma_size(ptr, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 8 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* use mmap to expand. */
> > +     ret2 =3D mmap(ptr, 12 * page_size, PROT_READ,
> > +                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>
> This is not expansion, but overwriting. Expansion is allowed through an a=
djacent mmap + mseal (which will merge the two VMAs).

The mmap is trying to expand the address range beginning from ptr
(size 8 * page_size) to 12 * page_size. This is overwrite + expansion.

>
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +
> > +             size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > +
> > +     REPORT_TEST_PASS();
> > +}
> > +
> > +static void test_seal_mmap_shrink_seal_middle(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 12 * page_size;
> > +     int ret;
> > +     void *ret2;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* use mmap to shrink. */
> > +     ret2 =3D mmap(ptr, 7 * page_size, PROT_READ,
> > +                     MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>
> This is also a partial overwrite.
The mmap is trying to shrink the address range beginning from ptr
(size 12 * page_size) to 8 * page_size. This is overwrite + shrink.

>
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
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
> > +             size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
> > +
> > +     REPORT_TEST_PASS();
> > +}
> > +
> > +static void test_seal_mmap_reuse_addr(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D page_size;
> > +     int ret;
> > +     void *ret2;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr, size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +     }
> > +
> > +     /* use mmap to change protection. */
> > +     ret2 =3D mmap(ptr, size, PROT_NONE,
> > +                     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > +
>
> This is also an overwrite. You're semantically testing the same thing, an=
d testing the same regions of code.

This is not overwriting. MAP_FIXED is not used.

-Jeff

> These 3 tests are all kind of the same thing.
>
> --
> Pedro

