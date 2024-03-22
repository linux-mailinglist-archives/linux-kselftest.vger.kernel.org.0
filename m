Return-Path: <linux-kselftest+bounces-6510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA98873BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 20:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88011284622
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2378B57;
	Fri, 22 Mar 2024 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g4iiwuWL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450078B4C;
	Fri, 22 Mar 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135153; cv=none; b=ZpZs/qRYXRNUXaS0weijh+2YhDiHGbvYgUV74KsvkqQ2N0ur1H0YLKZshWp/rRvHgXhOTZqrcAgheUPCqHDnVk8jH6b9VoDv1WPVkpnEMpbssoXy8johywd16QDJhEInBs5EaVAbUh56FyyXmTjVawI0zyltnkvylmmkwkX55mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135153; c=relaxed/simple;
	bh=UG0sBGKvrAEfQYFFsmXHb+05v3Y/kIQQfgrsER2wBIs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OLopPVKZQdhdJ0kKkVNG8z+vLaxIMudnPFqa2rJwanvuj/QFihvbkqW18I1oIxxq6Ouxstnq4y+4WMQguZtT7FRJGraaVzCpgrUPect6fPrfGSdn0AIeBq8pogJAEYKmAgTscMu2J5ozIQUmw2356EV6ZZB3hMpb9iraf2/7lX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g4iiwuWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46402C43390;
	Fri, 22 Mar 2024 19:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711135153;
	bh=UG0sBGKvrAEfQYFFsmXHb+05v3Y/kIQQfgrsER2wBIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g4iiwuWLrGSjXEtWYWuaR5z8kdipiKfD/181Dnwfo23bc19dVMarrZMhO3XiNbnCw
	 Xd387VjPuHN2tdpcmDxrzhir90mPqHX/fPx2UuVB0LY3xhTCOQwf2p5L9vUgnK9wIh
	 entr4Pvh6UALQgn42mLEO0GU9gR6yhezMYWXAxQk=
Date: Fri, 22 Mar 2024 12:19:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [PATCH] selftests/mm: Confirm VA exhaustion without reliance on
 correctness of mmap()
Message-Id: <20240322121912.3bc9e58cfda1b7c92aac9c4f@linux-foundation.org>
In-Reply-To: <d91c8c36-b01d-48f9-b0f6-8faa58edaed0@arm.com>
References: <20240321103522.516097-1-dev.jain@arm.com>
	<20240321145146.a3ce8a1e247371e33a437978@linux-foundation.org>
	<d91c8c36-b01d-48f9-b0f6-8faa58edaed0@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Mar 2024 10:42:47 +0530 Dev Jain <dev.jain@arm.com> wrote:

>=20
> On 3/22/24 03:21, Andrew Morton wrote:
> > On Thu, 21 Mar 2024 16:05:22 +0530 Dev Jain <dev.jain@arm.com> wrote:
> >
> >> Currently, VA exhaustion is being checked by passing a hint to mmap() =
and
> >> expecting it to fail. This patch makes a stricter test by successful w=
rite()
> >> calls from /proc/self/maps to a dump file, confirming that a free chun=
k is
> >> indeed not available.
> > What's wrong with the current approach?
> While populating the lower VA space, mmap() fails because we have=20
> exhausted the space.
>=20
> Then, in validate_lower_address_hint(), because mmap() fails, we confirm=
=20
> that we have
>=20
> indeed exhausted the space. There is a circular logic involved here.
>=20
> Assume that there is a bug in mmap(), also assume that it exists=20
> independent of whether
>=20
> you pass a hint address or not; that for some reason it is not able to=20
> find a 1GB chunk.
>=20
> My idea is to assert the exhaustion against some other method.

Thanks.  I added the above to the changelog.

>=20
> Also, in the following line in validate_complete_va_space():
>=20
>  =A0=A0=A0 =A0=A0=A0 if (start_addr - prev_end_addr >=3D SZ_1GB)
>=20
> I made a small error, I forgot to use MAP_CHUNK_SIZE instead of SZ_1GB.

And the preceding comment might need an edit.  Please send an updated
patch?

