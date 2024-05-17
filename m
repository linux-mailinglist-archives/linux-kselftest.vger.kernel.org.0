Return-Path: <linux-kselftest+bounces-10339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE18C8316
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 11:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51379282384
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310D1DDDB;
	Fri, 17 May 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFc09+HY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11D1DA3A;
	Fri, 17 May 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937248; cv=none; b=aRQ48wxzAsjgRNhR/LfQAUr4cp4ImJgdTle819NeJxcMzLY+1RMuaMZHvEoZfa/Q2QXtguiLBNxpRQYWLEIlmIsYRw2dATHNTI+BQVxMOi6EpBuZrNQv2yIOWRcpca0nEb8BUtUTYXnWln+3woKVnbrPbxAYrs3sWbH0h983Kx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937248; c=relaxed/simple;
	bh=Xe15mh7B1t2lxZdkig85mHYRwiCQgE6k5nwukrPUuHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFSlIpCd3NSXkg8fF5HX0f+N64JqffEOAwk5g+KrRD+Icps7DjBo6iGBAlP+OrqnuEAqi6svR0vSXNSVKlMBkZF+qo9ll1Ku0i5o3m6zMtK15QsOFGU9Z+7+cHQUwRmtD57S+zT/vjFMGg/utbTbxymgV/H/wjVy6JrJ03bTuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFc09+HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD2DC32782;
	Fri, 17 May 2024 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715937247;
	bh=Xe15mh7B1t2lxZdkig85mHYRwiCQgE6k5nwukrPUuHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFc09+HYu2EXxFwBRdVmAAmwd7rmJNVE6MSHNuShdc34MC9Ua6fr4X+6EXuxzdEB3
	 fIlygF3y6jEdJPwzi244dXqZsoAvTkn+9Nk78+8USk+4tC117jLxXCNVlF4fGZcc4G
	 OWvMh7odNor2vDRXx4ga4eyo6D2g87PrjOAq7qPJPspWYC6B9P+ZipQsm1T8f+onOs
	 7MqWeW+vZh4m1NlcCydUPRT0dvlh2HjRIGb3Z7439Tfh+oeTjTS85MotcLcherjYml
	 1bSFXws/M73u9VpyaewFd3LzJ9zCSL02+8/0tQvwQWZRf6kyDUliAfBRdrGG81zkEq
	 wsiILFdCDQsJA==
Date: Fri, 17 May 2024 10:14:02 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jaehee Park <jhpark1013@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net] selftests/net: use tc rule to filter the na packet
Message-ID: <20240517091402.GD443576@kernel.org>
References: <20240517010327.2631319-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517010327.2631319-1-liuhangbin@gmail.com>

On Fri, May 17, 2024 at 09:03:27AM +0800, Hangbin Liu wrote:
> Test arp_ndisc_untracked_subnets use tcpdump to filter the unsolicited
> and untracked na messages. It set -e before calling tcpdump. But if
> tcpdump filters 0 packet, it will return none zero, and cause the script
> to exit.
> 
> Instead of using slow tcpdump to capture packets, let's using tc rule
> to filter out the na message.
> 
> At the same time, fix function setup_v6 which only needs one parameter.
> Move all the related helpers from forwarding lib.sh to net lib.sh.
> 
> Fixes: 0ea7b0a454ca ("selftests: net: arp_ndisc_untracked_subnets: test for arp_accept and accept_untracked_na")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

I see that, as of writing, the last two runs of this test have succeeded.
Which doesn't seem to have occurred since 9th May. So this does seem
positive, albeit perhaps a bit too soon to call.

Jakub, is there a way to tell how long a test took to execute?
Perhaps it's obvious, but I couldn't see it.

Code changes look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

