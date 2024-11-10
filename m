Return-Path: <linux-kselftest+bounces-21736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C929C310A
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 07:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93140281DA2
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066614883F;
	Sun, 10 Nov 2024 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ciDAwooz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832A22615;
	Sun, 10 Nov 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731219603; cv=none; b=Oq8xHjCfPVw+1DMhnluJyGlegMVY/TsY+UVqTWt3gzsCrK6Qem+uEYgpGpru018Nvh2wjtcjgYObDz2C119yHXziT9z7JztwdeBVFDnGVX66qEbPf6mJVR0Tna06PQOXz+4J6Syem1y5L7SIVizDLGf/qTMLrqpJgZnjaEHKFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731219603; c=relaxed/simple;
	bh=tL2eRl5csW16vCH4rRx0/Vlxl10ZNnaGvoP6qWw5phg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZdCYOxUqhvDYP/9gbc1DIUPBCottE7ctiiHylAF36RujVepTsYbacbTpQNT6Ee2ag5HnMIOXDejl4xYotEONFsV4EVur2XF+f1yDPIbD17YBV2GgJumkq9v4vWHvnFRYSOgbn+KZ5f7jVryY/EiCZQUaKWWs9z+IuiqoKfEhE2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ciDAwooz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4B9C4CECD;
	Sun, 10 Nov 2024 06:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731219602;
	bh=tL2eRl5csW16vCH4rRx0/Vlxl10ZNnaGvoP6qWw5phg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ciDAwoozsT++uHW1vmYRbx3D6iUintz/XeMvZv8HRwMv0foJiN/lOEaHdAEeyo+7H
	 TzqWfqsap4ySh7lh+4m9lN3gTGRC8BWCxu1dz9BmyzA+SFaHwJ3DJ1HrwcSjsyQZsw
	 nW9ipCax3ZPbGpNOBYffZNUmXR/MvF6uqg4sVn2Y=
Date: Sat, 9 Nov 2024 22:20:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: Donet Tom <donettom@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: hugetlb_dio: Check for initial conditions to
 skip in the start
Message-Id: <20241109222001.f4272214f90c72458c1c09ec@linux-foundation.org>
In-Reply-To: <ddabd00d-7bd8-40f1-9a1b-22a31b07fd8c@collabora.com>
References: <20241101141557.3159432-1-usama.anjum@collabora.com>
	<5883b1c0-13c6-4593-9dd5-17f34c1319fe@linux.ibm.com>
	<13a96176-1bfa-4567-8ce5-a2b75b110afc@linux.ibm.com>
	<ddabd00d-7bd8-40f1-9a1b-22a31b07fd8c@collabora.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Nov 2024 19:13:04 +0500 Muhammad Usama Anjum <Usama.Anjum@collabo=
ra.com> wrote:

> On 11/8/24 3:49 PM, Donet Tom wrote:
>=20
> > I think below changes are required.
> >=20
> > iff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/se=
lftests/mm/hugetlb_dio.c
> > index 60001c142ce9..4b52106b8124 100644
> > --- a/tools/testing/selftests/mm/hugetlb_dio.c
> > +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> > @@ -44,6 +44,9 @@ void run_dio_using_hugetlb(unsigned int start_off, un=
signed int end_off)
> > =A0=A0=A0=A0=A0=A0=A0 if (fd < 0)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ksft_exit_fail_perror("Er=
ror opening file\n");
> > =A0
> > +=A0=A0=A0=A0=A0=A0 /* Get the free huge pages before allocation */
> > +=A0=A0=A0=A0=A0=A0 free_hpage_b =3D get_free_hugepages();
> > +
> > =A0=A0=A0=A0=A0=A0=A0 /* Allocate a hugetlb page */
> >=20
> > =A0=A0=A0=A0=A0=A0=A0 orig_buffer =3D mmap(NULL, h_pagesize, mmap_prot,=
 mmap_flags, -1, 0);
> >=20
> > =A0=A0=A0=A0=A0=A0=A0 if (orig_buffer =3D=3D MAP_FAILED) {
> Please can you send a fixup patch as you have working test setup?
> Otherwise I'll take it up and try to test on working setup before
> posting the fixup patch. Please let me know.

I've removed this patch from mm-hotfixes-stable.

