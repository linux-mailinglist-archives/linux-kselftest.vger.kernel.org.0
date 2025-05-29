Return-Path: <linux-kselftest+bounces-34000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627AAAC7EC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC0500A48
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB98165F1A;
	Thu, 29 May 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVD9jU2v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B42110;
	Thu, 29 May 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525669; cv=none; b=kPVOPu3DUqD3JFUdrvNbbyVGga1VYUGw6nnrFVqA+qwQ3DFRVf/HZd0VZs3vvH0L5yZyVpLzotanGj5Tm9X9n/S+zVJ8WLv4UxZYL+JdR/F2fllihe/y4FYo8AbPpt3hAfqXhv9mWdwEaJ+1ifGV3PwZDNPek6K/Rdt0yNFF3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525669; c=relaxed/simple;
	bh=qSwHf/0hRR8r8l/aqMBLXHUG5kVyzYMtHPPbws4VCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQJ4nMeSgdGYeZ+5P7Agl5lKzmq6dCwbEwb2gCxASG1tRrMBvAmT2iOSOzQGGbhuLJrHJ8SGZhKEOCWjLqeJOZzPXnDCK5P5eMP4aisrbhgCrvHtK7rmV8uJ8DSjkZX+/1Vnu3v1a5ouXBPxlowztLz6BWZNCfy7CCKLSHtXino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVD9jU2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11428C4CEEB;
	Thu, 29 May 2025 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748525669;
	bh=qSwHf/0hRR8r8l/aqMBLXHUG5kVyzYMtHPPbws4VCPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVD9jU2vkC5O+czjI4YNGVu7mT3WJ5l1e8/AxzP6UA78OhmfsRKWvsKfnCNug9wVm
	 665A+5vCLR02gv2qgOxgF12Ad1OAN6sZEzJbOYkWnUdX4SXtLLMgHoE8x6KQ2Ggnvp
	 UB2n+u/Unx1LZ/wbOVqWdXvCE6oDWlaeiCOPRZ9r7M0fBUIO39cpLshrREGZ+wn80M
	 GgI9qLMHuEcxeNLNzq/T0ZB//UfNv53r9WOlbmJwtkcuhwvsvjF+PLUbW31eGH8dOc
	 yx+zDOBM/1ZW0i3UevmBnKgTmd6y4Dd0xcthdYHJQEZzIz0WSOwcD2L6+NGhtjp4cw
	 mnEwWjryD3D1Q==
Date: Thu, 29 May 2025 14:34:24 +0100
From: Simon Horman <horms@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Philip Li <philip.li@intel.com>, oliver.sang@intel.com,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: build net/lib dependency in all
 target
Message-ID: <20250529133424.GP1484967@horms.kernel.org>
References: <20250529070536.84491-1-minhquangbui99@gmail.com>
 <20250529103221.GN1484967@horms.kernel.org>
 <da0339d6-b6a3-44d8-8ed4-b99249fa0fd1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da0339d6-b6a3-44d8-8ed4-b99249fa0fd1@gmail.com>

On Thu, May 29, 2025 at 06:04:17PM +0700, Bui Quang Minh wrote:
> On 5/29/25 17:32, Simon Horman wrote:
> > On Thu, May 29, 2025 at 02:05:36PM +0700, Bui Quang Minh wrote:
> > > Currently, we only build net/lib dependency in install target. This
> > > commit moves that to all target so that net/lib is included in in-tree
> > > build and run_tests.
> > Hi,
> > 
> > The above describes what is being done.
> > I think it would be good to also describe why.
> 
> Hi,
> 
> Currently, when building net related selftests, we need to
> 
>     make install
> 
> so that the net/lib is compiled. In case we do
> 
>     make
> 
> or
> 
>     make run_tests
> 
> the net/lib is not compiled. So I move the INSTALL_DEP_TARGETS which is
> net/lib if the selftests is net related to all. As a result, all make/make
> install/make run_tests will have the net/lib compiled.

Thanks for the explanation, it is much appreciated.

I think it would be good to include something along those lines
in the commit message of the patch.

Please note, that if you post a v2, before doing so you should allow 24h to
elapse since the posting of v1.

https://docs.kernel.org/process/maintainer-netdev.html

