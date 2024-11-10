Return-Path: <linux-kselftest+bounces-21737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C869C3111
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 07:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503211F216A6
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE741494A7;
	Sun, 10 Nov 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Df2F3LB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDE13B2A4;
	Sun, 10 Nov 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731220478; cv=none; b=sIN+Mmq6Ich5itN/NRT5B76Mk7KpFHbpbS+Q7RlVk/34SOmLLbLP7Iv6x5xXcme2JaMXLo3KzunQABVELl6XsHqVSy6XxUhaKdzZacGxj3jhDbk40H4nMFTFEBOA19o9Tn/S5tGghL+zv2FJUw1M2Mq5A5gqr/cOtYVyyf2wkEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731220478; c=relaxed/simple;
	bh=P+zouEwL96UEYTvP12h4pj1ZTB5iJ35wVWPueyC/av0=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VMILJocvLcGN+uFsOJxG9AF635Y3M5ud3IPrOXza8DUta2cQ7t07fFhq9u8WpNXn6apS95hugqCUIfQPSzyL/8WqMZkAd1UotKjOXhz6oMnIF9Ivkkdqrd8kKMyjD4JPcG3UrqsgRH4RINMvhu1SQ/2zlsrOxYak1ElAjUtoWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Df2F3LB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB5C4CECD;
	Sun, 10 Nov 2024 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731220477;
	bh=P+zouEwL96UEYTvP12h4pj1ZTB5iJ35wVWPueyC/av0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=Df2F3LB1P500NPM9dDLmAwySFvAEMFBQeJNEyq6FyrJ7oliBN3YcGK7addaUQLjpj
	 vK/Vo2HAwz8/Mkc4cq+Nj8532yDEwqW1eQ247fNrjzwpIj1YzogpjxXUmMxxIrCnPJ
	 EKqT5jWaTMjOWkJNBOpIVu/w+r5hZtyVLbmZaA8c=
Date: Sat, 9 Nov 2024 22:34:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>, Donet Tom
 <donettom@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: hugetlb_dio: Check for initial conditions to
 skip in the start
Message-Id: <20241109223436.3ddeaf1d60e1ade8f562d757@linux-foundation.org>
In-Reply-To: <20241109222001.f4272214f90c72458c1c09ec@linux-foundation.org>
References: <20241101141557.3159432-1-usama.anjum@collabora.com>
	<5883b1c0-13c6-4593-9dd5-17f34c1319fe@linux.ibm.com>
	<13a96176-1bfa-4567-8ce5-a2b75b110afc@linux.ibm.com>
	<ddabd00d-7bd8-40f1-9a1b-22a31b07fd8c@collabora.com>
	<20241109222001.f4272214f90c72458c1c09ec@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Nov 2024 22:20:01 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:

> On Fri, 8 Nov 2024 19:13:04 +0500 Muhammad Usama Anjum <Usama.Anjum@colla=
bora.com> wrote:
>=20
> > On 11/8/24 3:49 PM, Donet Tom wrote:
> >=20
> > > I think below changes are required.
> > >=20
> > > iff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/=
selftests/mm/hugetlb_dio.c
> > > index 60001c142ce9..4b52106b8124 100644
> > > --- a/tools/testing/selftests/mm/hugetlb_dio.c
> > > +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> > > @@ -44,6 +44,9 @@ void run_dio_using_hugetlb(unsigned int start_off, =
unsigned int end_off)
> > > =A0=A0=A0=A0=A0=A0=A0 if (fd < 0)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ksft_exit_fail_perror("=
Error opening file\n");
> > > =A0
> > > +=A0=A0=A0=A0=A0=A0 /* Get the free huge pages before allocation */
> > > +=A0=A0=A0=A0=A0=A0 free_hpage_b =3D get_free_hugepages();
> > > +
> > > =A0=A0=A0=A0=A0=A0=A0 /* Allocate a hugetlb page */
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0 orig_buffer =3D mmap(NULL, h_pagesize, mmap_pro=
t, mmap_flags, -1, 0);
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0 if (orig_buffer =3D=3D MAP_FAILED) {
> > Please can you send a fixup patch as you have working test setup?
> > Otherwise I'll take it up and try to test on working setup before
> > posting the fixup patch. Please let me know.
>=20
> I've removed this patch from mm-hotfixes-stable.

I changed my mind.  Please send any fixup against the previous patch.

