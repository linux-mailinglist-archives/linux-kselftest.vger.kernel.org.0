Return-Path: <linux-kselftest+bounces-21686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3244A9C1FF7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D5B20F85
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD21F4299;
	Fri,  8 Nov 2024 15:03:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553281E3772
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078227; cv=none; b=Nm/gzndPjYWWuYhH6RrT79sI6ZSUaNMuIF5PYtW/BzrwCdqjNyYbFIaonapf9On41DUOfEveoJxP1IIOPhqbEj9zM/rg0FKMpm6U71c0mlt6khIlKShKJ6KvF3dMQxUsWABL5l+ZR54kZYTAJqZQr5+qTKXkhbJHdf3pMBaBRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078227; c=relaxed/simple;
	bh=az3kZxfpnVPbmpenoHmi25d3ThM3WR3/hXnjX+qctpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lurUGT+T1IIPbSTKW5krWlvEOg7SgQtQXXuh7zsiaQqj7KRiAhPTw7jcfumkJL7Wf0Y0nltF6yGAEQwSU5zWFK/DAlQK98qEtooJ+0K9SdWP94aZAviUGrSboWY1EAlT5To42khKGxPU3BMk772SkHNyknOxp9H4GvkxCm/+7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CD9C4CECD;
	Fri,  8 Nov 2024 15:03:45 +0000 (UTC)
Date: Fri, 8 Nov 2024 15:03:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/4] kselftest/arm64: Fix compilation warnings/errors in
 the arm64 tests
Message-ID: <Zy4oT2w63WGXBASQ@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <3f0b7891-7f67-441b-8ba9-ab302ac57792@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0b7891-7f67-441b-8ba9-ab302ac57792@sirena.org.uk>

On Fri, Nov 08, 2024 at 02:58:34PM +0000, Mark Brown wrote:
> On Fri, Nov 08, 2024 at 01:49:16PM +0000, Catalin Marinas wrote:
> > It looks like people started ignoring the compiler warnings (or even
> > errors) when building the arm64-specific kselftests. The first three
> > patches are printf() arguments adjustment. The last one adds
> > ".arch_extension sme", otherwise they fail to build (with my toolchain
> 
> Unfortunately there's a lot of toolchain variance with these warnings so
> a lot of people simply won't see them, you need a fairly fresh toolchain
> to see them, and IIRC GCC and clang warn about different sets of things
> too which doesn't help.  If you look at the set of tests you're updating
> they're all fairly old so will predate the warnings having been added, I
> doubt anyone touched them recently enough to see the warnings.

But we should still fix them ;). I tried both gcc-12 and clang-14 that
come with my Debian stable installation. If we see others, we'll fix
them in time.

Thanks for the reviews.

-- 
Catalin

