Return-Path: <linux-kselftest+bounces-10367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027D8C8CAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 21:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4981C212B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7F13FD9B;
	Fri, 17 May 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpdiRJYE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBB13FD92;
	Fri, 17 May 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973380; cv=none; b=tDq2gu0t2yOQJ7h/7smNOBy3/g5SxrIwz9XiWJIEB4F5dMJreokVdg1oI3RA65IhB5a72qG/4aMjHcJUwRfmaC3A9OGl8wYTMPqVqyTVStrleKdPKiuRuOgh9qqBTTqlpshihtMgsEO2/S0vE+TdXiQCG6j25Z8IKqRyR2ij8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973380; c=relaxed/simple;
	bh=VPJIKN7NUDowBVz/dtCZSneJ0vS4DaX9ktRnbDW/dF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORIlCD1R8FcUdaZnER1kBZug1kgSmhx+rgAuaweEn9f0JEikqkl7ohHmy11+xxNleBPmSpp25Qh2S4l8r4p8G3JnfZNAMH1drVhn6C1Cu4k3aRdp4SrTxHrJ8Y5rp3oaH/9B+0oXbkc9pPx84a6nBNUXdmS5JyOVeiYecbK3JP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpdiRJYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050D2C32789;
	Fri, 17 May 2024 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715973380;
	bh=VPJIKN7NUDowBVz/dtCZSneJ0vS4DaX9ktRnbDW/dF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpdiRJYEpsyT5+6Win0jvl1fYxTa7g4Sb0kBOfRT6OLnqdDWwhrvq2D5wKge8L7QY
	 BT/I90s3ASqB8WOfd5+2q49f+t4wxs5DATNKX8owD6EJ5wnv7AlgOk3I7Hxtj51nKt
	 ZuyA81//Yr4Z1T5KCTgPDCuL11dvWQGzYPn40CEKvFYlDi4k6ZZilvj5/7LkWADpDX
	 R5mXrB6Zdypr9egoBYa2O9anacBOevvRAb5U8bvA2XF7iFllGo5eBBobHbuUT4r5jS
	 fLEQ9U8eijk71xfFgf9yRJ22s2NQJw8W30DWUg6bZ8ORYeMmAPRkwcnJfkF/+g5du6
	 5dWwpQ8vEDmeA==
Date: Fri, 17 May 2024 20:16:14 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jaehee Park <jhpark1013@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net] selftests/net: use tc rule to filter the na packet
Message-ID: <20240517191614.GA475595@kernel.org>
References: <20240517010327.2631319-1-liuhangbin@gmail.com>
 <20240517091402.GD443576@kernel.org>
 <20240517120420.6d2d34a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517120420.6d2d34a2@kernel.org>

On Fri, May 17, 2024 at 12:04:20PM -0700, Jakub Kicinski wrote:
> On Fri, 17 May 2024 10:14:02 +0100 Simon Horman wrote:
> > Jakub, is there a way to tell how long a test took to execute?
> > Perhaps it's obvious, but I couldn't see it.
> 
> It's not obvious, and it was broken. There's an 'info' file with
> extra metadata in the directory with results:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/599300/39-arp-ndisc-untracked-subnets-sh/info
> 
> but it's currently reporting fractional seconds rather than total
> seconds:
> 
> https://github.com/linux-netdev/nipa/commit/fb7c45fd3b68b379b7bceb8f79c8df06aaf53ee0
> 
> Once we have a proper DB (any day now), I'll add it to the JSON output
> so it appears in the web UI.

Great, thanks.

