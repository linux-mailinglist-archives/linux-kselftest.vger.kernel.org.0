Return-Path: <linux-kselftest+bounces-9254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352ED8B9330
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 03:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EC21F22402
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 01:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838A134D1;
	Thu,  2 May 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGg66sTp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB611718;
	Thu,  2 May 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614551; cv=none; b=T1Ji81vkC+sJvP3B+w2DpQWoU1Gj3f+T9ZaryqsR7pCotOcLxWqG5g7p3p0pv6Xdtudd6OuKuja4PaTgVUT0F2TVkBTJimKNH5JuahAmwkUxKIKnU3biej2V37DXB0hAE6gdWUECPhx2bHzOoZc4BsP3AppbFGSCjP5hRWQ7Zdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614551; c=relaxed/simple;
	bh=B2Cs5j0PPP0X3MRSQjPRnmXs1lOZLo1ysIlkH+ANaS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPznZZwpXlsmhF/5ptoseBgyp/zhzfcKC+mw/sFyxIa94NqcTIe8ALgDXU2xuedzCCZYpOjeFa9PnTglKgVNSZ7ogFatvIbuTRM9HFNWDJMT5e0Wp4nxjaGX1wYltZGceXA2uYgBwKWFonqe/Ucpm+cXEiVpc1LF2BWQEA5+3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGg66sTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3345BC072AA;
	Thu,  2 May 2024 01:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714614550;
	bh=B2Cs5j0PPP0X3MRSQjPRnmXs1lOZLo1ysIlkH+ANaS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kGg66sTpXYb94CLT9eGKXcBvqDmXGgCPHuPCkVSKHXktUO8mTEEoKhyi5Ji18bZaP
	 ck9V72aIFIEf2ve1b/dQ8DBzkKem0VKhzMk/o9EGqpO9nD/1+aDNWs50ibFK6cFnlu
	 YazhdX6Lhmi4SKB2UZcUQdRC7AUQ70nwP8wd85SwQbjs8MSix17MDCeuLC8tBLybG0
	 AtvlODTHoxoREltKDsegDJw/6kcvYbu9Kjt3y25scLwJZQC5RbwtxV+tFryo3biZou
	 Sly6f75lGCOvems+KVYjYEnCVnnDVAPQ+QPl1vorjbbuAzw5NDQL8L+qIp2RsMwoxu
	 UgIrgJxsxalhg==
Date: Wed, 1 May 2024 18:49:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] selftests: drv-net: add checksum tests
Message-ID: <20240501184909.4389c2e9@kernel.org>
In-Reply-To: <6632ee9092206_37f3af294a7@willemb.c.googlers.com.notmuch>
References: <20240501185432.3593168-1-willemdebruijn.kernel@gmail.com>
	<20240501180657.3eb1ef99@kernel.org>
	<6632ee9092206_37f3af294a7@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 May 2024 21:38:24 -0400 Willem de Bruijn wrote:
> A few more may be in scope eventually: toeplitz, udpgso_bench, gro,
> so_txtime. Move them on a case-by-case basis?

If you plan to use them all in hw tests - no preference,
you can move them all in one fell swoop if you prefer.

> > Should I send a fix for that?  
> 
> Please do. I did not grasp your suggestion well enough to take a
> stab. I may have already spotted the zero conversion test returning
> success, while explicit logging of the stderr output shows otherwise.

On it..

