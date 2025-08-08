Return-Path: <linux-kselftest+bounces-38562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D8B1E9B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E51C24AA7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9327BF6F;
	Fri,  8 Aug 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSOS6Tqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80327A12C;
	Fri,  8 Aug 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661452; cv=none; b=tnTy3cTdCr4WzfaypFCR+UqXEP95mCAwbnZ8uUR97RYIJ4az7f5W9lJ2S0aD0b+6pToePt76gFqIHwKu0Gd0hnK6eNL1bmMuMm4yQ7vrXE4h98wTj3R74jk2+nx2La9/S/P3Gasx6J4FBgj0D/BwsblFtAN3KyYEg62uLwyhdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661452; c=relaxed/simple;
	bh=MK5DJOEbqjKPiqztvlyYdDxYWReaTbpXF19G6D/+jAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqPEJoj3SzPqT6rwydl2YELmW/r9up/Kzzx+mqwxOzFWA2OiczDDoFeEhFnOS7+gqvbpnhmI3jaCiqTakXRf8Q+BlCfngo22/oLRA1VhBiERBbvKfOUnyXA+XFwLoVauF/QUwRrjSn+syigKsOtkLeNASBXbSytNes8Or3q1/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSOS6Tqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251DBC4CEED;
	Fri,  8 Aug 2025 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754661451;
	bh=MK5DJOEbqjKPiqztvlyYdDxYWReaTbpXF19G6D/+jAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SSOS6Tqf5pYiqsf0gVpkWJYeG2DjAxRFWKq6XLP6ZD5rhcVcJNQhH0h8TDuKh4tI9
	 WK/1NzsVGUBjpXX9mYX0EEQN7QMsPkaWiTLYytMU40hXE6ZqYbP86L+ZgFTEP1ErAU
	 QvbdgLkX1SMc1Uw5mLFIR5/mHDNayFprA/uvo22CPv+yxJKqyqiczv9Tbk4fDn6ZgC
	 cR8ya/2jTcAO/o2vIjP1igmOpgP/20izZHi4J/wmy3keGL7IPefVv5yF2UdzwfZ5Hm
	 nrMNTZLrFEoU5hMtqxznGH2KIMu4pMd/9u7H/+hiui3LgWoUVPCH0WXWXDMh1om6vY
	 BNMQ83AENZsPQ==
Date: Fri, 8 Aug 2025 06:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, will@willsroot.io,
 savy@syst3mfailure.io
Subject: Re: [PATCH net 1/2] tls: handle data disappearing from under the
 TLS ULP
Message-ID: <20250808065730.602dac6a@kernel.org>
In-Reply-To: <CANn89iLbDQ2Le-7WU2dWvr3bc4J-Jcra-rX935Or4wRXDGVViw@mail.gmail.com>
References: <20250806180510.3656677-1-kuba@kernel.org>
	<CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
	<20250806132034.55292365@kernel.org>
	<CANn89iLbDQ2Le-7WU2dWvr3bc4J-Jcra-rX935Or4wRXDGVViw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Aug 2025 06:51:06 -0700 Eric Dumazet wrote:
> > > Can a 2^32 wrap occur eventually ?  
> >
> > Hm, good point. Is it good enough if we also check it in data_ready?
> > That way we should notice that someone is eating our data before
> > the seq had a chance to wrap?  
> 
> I could not understand what your suggestion was.
> 
> Perhaps store both copued_seq and tp->bytes_received and
> 
> check if (tp->bytes_received - strp->bytes_received) is smaller than 2^31 .
> 
>               if (unlikely(strp->copied_seq != tp->copied_seq ||
>                                (tp->bytes_received -
> strp->bytes_received >= (1ULL < 31)) ||
>                             WARN_ON(tcp_inq(strp->sk) < strp->stm.full_len))) {

Nice, I think that would work.
I was wondering how to solve this yesterday and I realized the extra
condition isn't really needed. We just have to handle the inq < full_len
more carefully and remove the WARN_ON(). I posted a v2.

