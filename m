Return-Path: <linux-kselftest+bounces-16814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70B9665FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A633A282F49
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9EE1B6558;
	Fri, 30 Aug 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYm89XT/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D771B3B04
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032815; cv=none; b=WaTjogbHQu3o+lo3FvbmF1xjCQfdU9DPST+N4Ef2O78ab5t5x6zchXNJBWKDBw+GOzEPX+jYMwPL3FPIqfQduGLAcBVGLPxZmnb1a2BCKDKgLlwCTVRogcyT+mbaAZsCfMu7+UF1BQPq8SdWUjkmo3eRCOpVDIu+4z0R1CYSLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032815; c=relaxed/simple;
	bh=TLYQmK+4gX5WbU9E7NXCP6yB0z2vPUME2uAjtju5Dkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFQyv0vFSf/uzGxsW9e8tRIQCoX5s7/7AS+LG7/icWdJkWLcU6I1Ec4uyZdMpE6AupWrzawIY7dN1TX7LQl1TIacJJMMOpw1tf9dKH1QHNYEfUjsQACos8hh96EKVVVO/mV82g7IkJpWIbTrnSG+Qf4u17HKHupHQDNO6L7Na2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BYm89XT/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-268e0b13471so129017fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725032813; x=1725637613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8bk6NlnoUxn0Dwk2YP4Jj7Nsfj0s1LGq69qFBq4LJs=;
        b=BYm89XT/9RZ57D8ioxn61LgtVDSSnp1nClzDGe9i5cRLIqppfT1I/Q6m7CvNa0cgVN
         FWLlmm6/dYUtt1hk/A4wNLaokj1KiJoqOspqeFsTLomomgb0KDR+gCrbyRYcqHdirjqZ
         dpU+YK7x2pm6zrBX2y0LOyjALjjpj7s7NgNJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032813; x=1725637613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8bk6NlnoUxn0Dwk2YP4Jj7Nsfj0s1LGq69qFBq4LJs=;
        b=cLP0fiRjOizmsXlVZEXmFo0d+Slc0od/bfpMqZ43ruN/0Jz2XcJYI4AXgjFVC82WJQ
         YKpbQ6/VWTgQvtFCVMTDYVEVGtV8JDsMbhaqpkvIEiMKnMFwD5mZbqQCmhH4zkMlhDbd
         uPQoDKdRGMG3soHGQ4taXX8cVPr/cpbcbMIo+L0p+440rMx6uu6hoZgZ1kTzK8uuA78G
         D9F7iY7Y+s5TKS4Lmw3QERTGCgYiVUp5Gdbx0k64uEHe+2nGghraeZsAjiipsGfi1+8W
         /yZ2Fbx1/u/6Hy3NFbRcHey4vBENRK6J4yGkwrCBt2fEH+sp9jMfpoYCLGnkCkSw8kKP
         0/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUR2xHFdBDn8MXpyBGtm9z+ztF5dyU8kGGezaBmsUxdcgFlY3+nwhT5VnhmEGIGLsD5A6+SqqxEGhLkFIM3ReM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+5QdlWyMdp8TeExLQ/S8jcWzecbp7hkPBYbBZlsaHcmMioDW
	93CIQa8wgjpUOJeJMuFc+7hY3GVDwTXgeKQk8O1uFk++A4NlyJki7k7GXMIgdnkl1UDwiAvafrw
	evaplBE4OWaxkTrKPWHpufRGGAYglNp9VQeIJ3EDjMyAaWB8=
X-Google-Smtp-Source: AGHT+IEAjSF1X499v/FKP2PTPABhbt9CR+HTuwUDdQPyxVSzRisW3oW8eIPO3E4b/V5N3gxkpw61MmKTYe2iyF/kMgY=
X-Received: by 2002:a05:6870:f29c:b0:269:1020:a8a0 with SMTP id
 586e51a60fabf-277b0be0b23mr1403373fac.4.1725032813260; Fri, 30 Aug 2024
 08:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214352.963001-1-jeffxu@chromium.org> <20240829214352.963001-3-jeffxu@chromium.org>
 <ggnces6muodr4q27yuprhyhjovn7vlaj4pdnmte44kg2of62sx@ihwlrb52hsmm>
In-Reply-To: <ggnces6muodr4q27yuprhyhjovn7vlaj4pdnmte44kg2of62sx@ihwlrb52hsmm>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 08:46:41 -0700
Message-ID: <CABi2SkUESzc6yjf5TbfZM7gHDcx4wXC5R8+xtqgYZAmY1fm64A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] selftests/mm: mseal_test add sealed madvise type
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 5:52=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 29, 2024 at 09:43:50PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add a testcase to cover all sealed madvise type.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 108 +++++++++++++++++++++++-
> >  1 file changed, 107 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index adc646cf576c..ae06c354220d 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -2121,6 +2121,107 @@ static void test_seal_madvise_nodiscard(bool se=
al)
> >       REPORT_TEST_PASS();
> >  }
> >
> > +static void test_seal_discard_madvise_advice(void)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     int sealed_advice[] =3D {MADV_FREE, MADV_DONTNEED,
> > +             MADV_DONTNEED_LOCKED, MADV_REMOVE,
> > +             MADV_DONTFORK, MADV_WIPEONFORK};
> > +     int size_sealed_advice =3D sizeof(sealed_advice) / sizeof(int);
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     ret =3D seal_single_address(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     for (int i =3D 0; i < size_sealed_advice; i++) {
> > +             ret =3D sys_madvise(ptr, size, sealed_advice[i]);
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     }
> > +
> > +     REPORT_TEST_PASS();
> > +}
>
> This can replace some of the other 9 discard tests already there, no?
>
No, this  is focused on enumerating all types.

> > +
> > +static void test_munmap_free_multiple_ranges(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 8 * page_size;
> > +     int ret;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     /* unmap one page from beginning. */
> > +     ret =3D sys_munmap(ptr, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* unmap one page from middle. */
> > +     ret =3D sys_munmap(ptr + 4 * page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     size =3D get_vma_size(ptr + page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +     size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +
> > +     /* seal the last page */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr + 7 * page_size, page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +             size =3D get_vma_size(ptr +  1 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  7 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +     }
> > +
> > +     /* munmap all 8  pages from beginning */
> > +     ret =3D sys_munmap(ptr, 8 * page_size);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret);
> > +
> > +             /* verify mapping are not changed */
> > +             size =3D get_vma_size(ptr + 1 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  7 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +             for (int i =3D 0; i < 8; i++) {
> > +                     size =3D get_vma_size(ptr, &prot);
> > +                     FAIL_TEST_IF_FALSE(size =3D=3D 0);
> > +             }
> > +     }
> > +
> > +     REPORT_TEST_PASS();
> > +}
>
> Unrelated munmap change.
will move.

>
> --
> Pedro

