Return-Path: <linux-kselftest+bounces-15889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BD95A3E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E060E1F21B2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB491B2EC7;
	Wed, 21 Aug 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKg1iK94"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4ED5FEED;
	Wed, 21 Aug 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261332; cv=none; b=U6e+kAtakpyQSh011A2hlD47rUKNHSYTIFovy77wuObK/Z9+y5s5AwwnClRfQxpuA8TedFTsDU0z2cvGzGnBa+lBWjlS0p9sX5TcFsoVj79cPPTUnvzJuN9lylcKfFjZlNYL7NpmrBMCj+Rtr1gTTF9L+PvOsbcOaXrvKLoW5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261332; c=relaxed/simple;
	bh=kPEdUejV3MfKELbnswgmZg1Cvw7fd1rB5I3KMDrhl9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3Hzl4CCv/N7mOLf3o+CpwHPy61kLejt8miIWLlbCHy3F4S6OyU3afl/trQ+HBWfNH+CfDeYjoZ8xx01YXeBAmakoUOE8JK6xI5DPmqKqx2a4IQmK6WnNg7oLD7j1Ga0BbHW07Mas7tI5dWSc2tZ2IwYyMj2fjDYbkDInBtHR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKg1iK94; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4fcf9102c8bso273002e0c.2;
        Wed, 21 Aug 2024 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724261330; x=1724866130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJUfXZNp1ibF0u5btatjwqh4T7on3PeFlzU17jC4Trs=;
        b=FKg1iK94/tXq+IrOCah5eX1y75+N5tXoG9mO8zWzw9Bt/ZUC1M5PuQEL+tLJMNFreJ
         x9TEyRrGvV31CObZ/YjclwOfR2BxHuT1LbtRgUXJoN1rw1ALEDArpSVbKZzmdNsnT1+T
         Im463A1Wktrda7+NujYqUeVjj72xN7XIWVErm493wy3cQsdSivwjPJARHdBBT5e1Ruzx
         r4hG1nxY2RDgrIaCjp92PgshFw99y8Xo+6+7WlTuCMCpUd7+CzTtXB6SkLi1/ahCRUUU
         KEBmeINFz5q1MZ378xr10MgBDZoe69U6Z3iW536mXD/oudq3kah8EuhIrjYriaL1Si6o
         iScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261330; x=1724866130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJUfXZNp1ibF0u5btatjwqh4T7on3PeFlzU17jC4Trs=;
        b=TpFIKhZ9LzTuI0UhCBLUB15nN+sRf2cOZDBU/NoURz0MBNFo1tGmHk31ZjdtkO9tEY
         XrQzD4VtB3QBCnh8u6/2HvcxbAf9bhu9HvT0SxZEzMLllnIg3kaqn9MCWAbfe1rCfxpd
         TM2V0qfeRtGBgI8xWqAkMaQx+pdh0JH0LiXu/uy0jzcMGKKYvmk0tuqwT2pug/Bmjr18
         IoxqMBRmg1HzZ0Ep5spuq2i3WURRoEuYypbT2hEyXXdB2h0t2fdgfanUA2bDwMEW9Gr2
         mrZqWenaJMCoCid0Ew8QEqbnFl20Up34FKt4b6KvpbO2hn39Uyez9PgDis3zqZ2p1CGe
         jI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8H3kh4DdWeyBp6rHTRYopmrMPE7LjVG/REcSdRAHTlONkP/FzaVYn32H1XIRNS59jCux/Nuhoua8DhXk=@vger.kernel.org, AJvYcCVee2wt1YqdGW3HUYiE3Ln9/bmP5faCCY88/6I8CKMamy1LCOSay5o1D1X/+vHBqSJ2DOei3DUh4L97R4KhxHrY@vger.kernel.org
X-Gm-Message-State: AOJu0YxniNyVILoQFVuPhe8zdu0BqSVBzYzLLEgvpjRu7U7TVS/JJdGV
	6Vyx+FAXo1gT7/3R3xPYEmPRhYzwRIwmm8o34uV9Co7FEsEr6A+XArn/rgGBcAplGuYEDDm6VPT
	dGRu/x7/pt2jyV1ceC/S2pu6W7Po=
X-Google-Smtp-Source: AGHT+IGyAeC7+IBJ6/fu09d9M/b2IU20lDn/RAHi2m82VXURQN4bEA0s+Lc6bSExM1DhEAEm43xMBpByuyIwQ6yjZb4=
X-Received: by 2002:a05:6122:35c4:b0:4f2:a973:8ae with SMTP id
 71dfb90a1353d-4fcf1b53051mr3654908e0c.5.1724261329747; Wed, 21 Aug 2024
 10:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com> <CABi2SkWPiGJTv3FEPxD1OJYUAoePab8jG+CSd58UHqEsBeOYbA@mail.gmail.com>
 <CAKbZUD3Siwq4GZdOy-2n_txG2BMQ=m7PypB53sQxeLcBE4xYGA@mail.gmail.com> <CABi2SkXaBv85JF6gTd1w-f_i700YSj5JoK8z605bzd6gbPjKkw@mail.gmail.com>
In-Reply-To: <CABi2SkXaBv85JF6gTd1w-f_i700YSj5JoK8z605bzd6gbPjKkw@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 21 Aug 2024 18:28:38 +0100
Message-ID: <CAKbZUD2ae80KNzqjK5RuB569+ZTv9YoCDgXmrC46P9a5gcxzWg@mail.gmail.com>
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

On Wed, Aug 21, 2024 at 5:27=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Wed, Aug 21, 2024 at 9:20=E2=80=AFAM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 4:56=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> w=
rote:
> > >
> > > Hi Pedro
> > >
> > > On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@=
gmail.com> wrote:
> > > >
> > > > Add more mseal traversal tests across VMAs, where we could possibly
> > > > screw up sealing checks. These test more across-vma traversal for
> > > > mprotect, munmap and madvise. Particularly, we test for the case wh=
ere a
> > > > regular VMA is followed by a sealed VMA.
> > > >
> > > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/mm/mseal_test.c | 111 ++++++++++++++++++++=
+++++++++++-
> > > >  1 file changed, 110 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testin=
g/selftests/mm/mseal_test.c
> > > > index 259bef4945e9..0d4d40fb0f88 100644
> > > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > > +++ b/tools/testing/selftests/mm/mseal_test.c
> > > > @@ -766,6 +766,42 @@ static void test_seal_mprotect_partial_mprotec=
t(bool seal)
> > > >         REPORT_TEST_PASS();
> > > >  }
> > > >
> > > > +static void test_seal_mprotect_partial_mprotect_tail(bool seal)
> > > > +{
> > > > +       void *ptr;
> > > > +       unsigned long page_size =3D getpagesize();
> > > > +       unsigned long size =3D 2 * page_size;
> > > > +       int ret;
> > > > +       int prot;
> > > > +
> > > > +       /*
> > > > +        * Check if a partial mseal (that results in two vmas) work=
s correctly.
> > > > +        * It might mprotect the first, but it'll never touch the s=
econd (msealed) vma.
> > > > +        */
> > > > +
> > > > +       setup_single_address(size, &ptr);
> > > > +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > > +
> > > > +       if (seal) {
> > > > +               ret =3D sys_mseal(ptr + page_size, size);
> > > you are allocating 2 pages , and I assume you are sealing the second
> > > page, so the size should be page_size.
> > > ret =3D sys_mseal(ptr + page_size, page_size);
> >
> > Yes, good catch, it appears to be harmless but ofc down to straight luc=
k.
> > I'll send a fixup for this and the other mistake down there.
> >
> > >
> > > > +               FAIL_TEST_IF_FALSE(!ret);
> > > > +       }
> > > > +
> > > > +       ret =3D sys_mprotect(ptr, size, PROT_EXEC);
> > > > +       if (seal)
> > > > +               FAIL_TEST_IF_FALSE(ret < 0);
> > > > +       else
> > > > +               FAIL_TEST_IF_FALSE(!ret);
> > > > +
> > > > +       if (seal) {
> > > > +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &p=
rot) > 0);
> > > > +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > To test partial mprotect, the test needs to add the check for the
> > > first page to be changed, Also to avoid the merge,  a PROT_NONE page
> > > can to be added in front.
> >
> > No, I'm leaving partial mprotect to be undefined. It doesn't make
> > sense to constraint ourselves, since POSIX wording is already loose.
> >
> > >
> > > > +       }
> > > > +
> > > > +       REPORT_TEST_PASS();
> > > > +}
> > > > +
> > > > +
> > > >  static void test_seal_mprotect_two_vma_with_gap(bool seal)
> > > >  {
> > > >         void *ptr;
> > > > @@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(boo=
l seal)
> > > >         REPORT_TEST_PASS();
> > > >  }
> > > >
> > > > +static void test_seal_munmap_partial_across_vmas(bool seal)
> > > > +{
> > > > +       void *ptr;
> > > > +       unsigned long page_size =3D getpagesize();
> > > > +       unsigned long size =3D 2 * page_size;
> > > > +       int ret;
> > > > +       int prot;
> > > > +
> > > > +       /*
> > > > +        * Check if a partial mseal (that results in two vmas) work=
s correctly.
> > > > +        * It might unmap the first, but it'll never unmap the seco=
nd (msealed) vma.
> > > > +        */
> > > > +
> > > > +       setup_single_address(size, &ptr);
> > > > +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > > +
> > > > +       if (seal) {
> > > > +               ret =3D sys_mseal(ptr + page_size, size);
> > > ret =3D sys_mseal(ptr + page_size, page_size);
> > >
> > > > +               FAIL_TEST_IF_FALSE(!ret);
> > > > +       }
> > > > +
> > > > +       ret =3D sys_munmap(ptr, size);
> > > > +       if (seal)
> > > > +               FAIL_TEST_IF_FALSE(ret < 0);
> > > > +       else
> > > > +               FAIL_TEST_IF_FALSE(!ret);
> > > > +
> > > > +       if (seal) {
> > > > +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &p=
rot) > 0);
> > > > +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > > To test partial unmap, the test needs to add the check for the first
> > > page to be freed, Also to avoid the merge,  a PROT_NONE page needs to
> > > be in front.
> >
> > I'm not testing partial unmap. Partial unmap does not happen. I have
> > told you this before.
> >
> ok.  Then this test should be as below ? (need to add PROT_NONE page
> before and after)
>   size =3D get_vma_size(ptr, &prot);
>   FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
>   FAIL_TEST_IF_FALSE(prot=3D=3D0x4)

That doesn't work because this region spans two vmas. I'll write
something similar for the fixup.

>
>
> > >
> > > The test_seal_munmap_partial_across_vmas  shows the behavior
> > > difference with in-loop approach and out-loop approach. Previously,
> > > both VMAs will not be freed, now the first VMA will be freed, and the
> > > second VMA (sealed) won't.
> > >
> > > This brings to the line you previously mentioned: [1] and I quote:
> > > "munmap is atomic and always has been. It's required by POSIX."
> >
> > This is still true, the comment was a copy-and-paste mindslip. Please
> > read the email thread. It has been fixed up by Andrew.
> >
> Which thread/patch by Andrew ? Could you please send it to me ? (I
> might missed that)

This thread and this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patche=
s/selftests-mm-add-more-mseal-traversal-tests-fix.patch

--=20
Pedro

