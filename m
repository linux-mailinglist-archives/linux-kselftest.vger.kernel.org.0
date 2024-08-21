Return-Path: <linux-kselftest+bounces-15874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9695A2AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 18:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161CC1C2177D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194EF14F9CA;
	Wed, 21 Aug 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkuPitu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60675139597;
	Wed, 21 Aug 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257219; cv=none; b=clxvVe6MwQjCfCcJrFLc4yeo70lBZUqPWTuwNTS5WgOkCD/7UqgcKuhz6WvEJzyiX8Q7jhW+mDAeI2IY3pu+5FF7JtLqTeukwENLZNky9hJZxuWHYAmFcCmhyizAKeUUolILxnntqNZ1jKc/sTFd3FMJIkh+6+V/s2FidQdZXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257219; c=relaxed/simple;
	bh=0RN3TRX3yBTaoG3qk4ozEmB+r/7a76UlQuZG8EBldyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPCcHdvIjoPZZ9TqiQ4zx00b5q0bQE+n5z9rQrFVsXdcdW86JquVMvapf2H3OsqXfR/gP7TW8qmjuw4oZ6S+uHf40n6FefTlG5LnpH2TdtdYNQwsBUFOVdmumq/tPUyfzRT6HrW7RXtkOIc7OI81pGwN+T4C2YKgYTblLH/qAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkuPitu4; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5c7f23f22so4181337eaf.0;
        Wed, 21 Aug 2024 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724257216; x=1724862016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhsRhHHgA460KmlvgmMOROdQkEYqdVaGy9dpXTwKETQ=;
        b=QkuPitu4bZ0hE1UXJ8Sx7uT0/cpoWnI9fhRAOF1IZDAumnJ9sGkNqzHzh6khvYzOT8
         5U/J7LK/EUBhzpBpi+RzGNSlLrzhuOEyAb0KtFuA6iJyeRpOylu0QE0E0R1MFQQic6Qi
         IDwgG12VXUd5ieAMByjieZlqcnn5to8zuu5vMYKH1AUM7HLBs7M6ZUjau83nwRJmFYY8
         88X5QscXzTCA7e5xaIHoI2/Xfvdh+fURcarClsT7ROYeB7h5B1CTIuL/3hqP1GDdBwpu
         I4SlaV+7NHCuVKYlQ6RgR/PwDnpDwo1PvdVo9t7VZA2iFSxsnSRTDkuI5Wz//2J9qt2P
         FgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257216; x=1724862016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhsRhHHgA460KmlvgmMOROdQkEYqdVaGy9dpXTwKETQ=;
        b=BOldYwPeDThH6Kz6londHHueFfQuqsJxsx+ITOae/FOb4FMg5tJWTg201QRzBQbbf7
         PBgMA0bBGAo8hRYpunMcsxh5HJd7jickMIH+LC2DMM9eKYIRRkFGPH/Yh/wKBtOTa6p3
         3ve5sg5bAPAIIGbBBqsICqkC2aM1Nes4jXHrupHe3Dg/JK+XoMCI2DemqjVcvUUUz93k
         /nsqeUrm1yOJIeHtTYvBpl1zpzTyVl3aA/FDXhbGC1/gXvbDB2PzfR2vr8GlOWsSG5Ht
         AGikBJnzdqNrOx4WzXQ7PIarExnVpulPRhOgkwE7VqV+PTL02XhlX/pOI6eDxhTfzn6/
         7z7g==
X-Forwarded-Encrypted: i=1; AJvYcCV4EyhPzZVVyP+Fr4V6eiNSwrjGw9zeTxLjauicMzKz/jf4/1f1O/epk0n6Wd6KVBdDQ1iTMEwabG767NY=@vger.kernel.org, AJvYcCVJZQkCevu+ipQXQ3tndSm5pEjRfmwYJEpYdMcByuRAnYFHaAZBlm+ERV3Qer6L0lo0+w5dT7CC3UIlUqRvgujR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GfR8TEz1GJAAGOYoTZQMXD1khCDSw14fk14Wiy8TaOxtoioH
	TJtqSy06Vts1yGOnPFnJy3SAXnTjZgkOgV1x+H2EHIBeNOYr0Xk8tqIbCHYfx9Bwi3Gi4lnXs/l
	68vyu5ft4GJgd9kQc2iWIcumGfPM=
X-Google-Smtp-Source: AGHT+IHxLwEOn+yLKvWv3YQVmoIjzuASNvJuOZVGLBWsX/53u/E9LE77DnAjl+3NmlWimETKSzNaaXnlGkRMLdtn3M4=
X-Received: by 2002:a05:6358:6184:b0:1b1:aca9:9627 with SMTP id
 e5c5f4694b2df-1b59f969251mr390945155d.7.1724257216157; Wed, 21 Aug 2024
 09:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com> <CABi2SkWPiGJTv3FEPxD1OJYUAoePab8jG+CSd58UHqEsBeOYbA@mail.gmail.com>
In-Reply-To: <CABi2SkWPiGJTv3FEPxD1OJYUAoePab8jG+CSd58UHqEsBeOYbA@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 21 Aug 2024 17:20:04 +0100
Message-ID: <CAKbZUD3Siwq4GZdOy-2n_txG2BMQ=m7PypB53sQxeLcBE4xYGA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:56=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> Hi Pedro
>
> On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> >
> > Add more mseal traversal tests across VMAs, where we could possibly
> > screw up sealing checks. These test more across-vma traversal for
> > mprotect, munmap and madvise. Particularly, we test for the case where =
a
> > regular VMA is followed by a sealed VMA.
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 111 ++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 110 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index 259bef4945e9..0d4d40fb0f88 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -766,6 +766,42 @@ static void test_seal_mprotect_partial_mprotect(bo=
ol seal)
> >         REPORT_TEST_PASS();
> >  }
> >
> > +static void test_seal_mprotect_partial_mprotect_tail(bool seal)
> > +{
> > +       void *ptr;
> > +       unsigned long page_size =3D getpagesize();
> > +       unsigned long size =3D 2 * page_size;
> > +       int ret;
> > +       int prot;
> > +
> > +       /*
> > +        * Check if a partial mseal (that results in two vmas) works co=
rrectly.
> > +        * It might mprotect the first, but it'll never touch the secon=
d (msealed) vma.
> > +        */
> > +
> > +       setup_single_address(size, &ptr);
> > +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +       if (seal) {
> > +               ret =3D sys_mseal(ptr + page_size, size);
> you are allocating 2 pages , and I assume you are sealing the second
> page, so the size should be page_size.
> ret =3D sys_mseal(ptr + page_size, page_size);

Yes, good catch, it appears to be harmless but ofc down to straight luck.
I'll send a fixup for this and the other mistake down there.

>
> > +               FAIL_TEST_IF_FALSE(!ret);
> > +       }
> > +
> > +       ret =3D sys_mprotect(ptr, size, PROT_EXEC);
> > +       if (seal)
> > +               FAIL_TEST_IF_FALSE(ret < 0);
> > +       else
> > +               FAIL_TEST_IF_FALSE(!ret);
> > +
> > +       if (seal) {
> > +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot)=
 > 0);
> > +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> To test partial mprotect, the test needs to add the check for the
> first page to be changed, Also to avoid the merge,  a PROT_NONE page
> can to be added in front.

No, I'm leaving partial mprotect to be undefined. It doesn't make
sense to constraint ourselves, since POSIX wording is already loose.

>
> > +       }
> > +
> > +       REPORT_TEST_PASS();
> > +}
> > +
> > +
> >  static void test_seal_mprotect_two_vma_with_gap(bool seal)
> >  {
> >         void *ptr;
> > @@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(bool se=
al)
> >         REPORT_TEST_PASS();
> >  }
> >
> > +static void test_seal_munmap_partial_across_vmas(bool seal)
> > +{
> > +       void *ptr;
> > +       unsigned long page_size =3D getpagesize();
> > +       unsigned long size =3D 2 * page_size;
> > +       int ret;
> > +       int prot;
> > +
> > +       /*
> > +        * Check if a partial mseal (that results in two vmas) works co=
rrectly.
> > +        * It might unmap the first, but it'll never unmap the second (=
msealed) vma.
> > +        */
> > +
> > +       setup_single_address(size, &ptr);
> > +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +       if (seal) {
> > +               ret =3D sys_mseal(ptr + page_size, size);
> ret =3D sys_mseal(ptr + page_size, page_size);
>
> > +               FAIL_TEST_IF_FALSE(!ret);
> > +       }
> > +
> > +       ret =3D sys_munmap(ptr, size);
> > +       if (seal)
> > +               FAIL_TEST_IF_FALSE(ret < 0);
> > +       else
> > +               FAIL_TEST_IF_FALSE(!ret);
> > +
> > +       if (seal) {
> > +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot)=
 > 0);
> > +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> To test partial unmap, the test needs to add the check for the first
> page to be freed, Also to avoid the merge,  a PROT_NONE page needs to
> be in front.

I'm not testing partial unmap. Partial unmap does not happen. I have
told you this before.

>
> The test_seal_munmap_partial_across_vmas  shows the behavior
> difference with in-loop approach and out-loop approach. Previously,
> both VMAs will not be freed, now the first VMA will be freed, and the
> second VMA (sealed) won't.
>
> This brings to the line you previously mentioned: [1] and I quote:
> "munmap is atomic and always has been. It's required by POSIX."

This is still true, the comment was a copy-and-paste mindslip. Please
read the email thread. It has been fixed up by Andrew.

--=20
Pedro

