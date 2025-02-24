Return-Path: <linux-kselftest+bounces-27383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A254A42E41
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D601E3B21D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06223F295;
	Mon, 24 Feb 2025 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR5L7oO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D915530B;
	Mon, 24 Feb 2025 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430112; cv=none; b=a1E2GzafAJfGfhrg8KMFct5cq0EgoAq6I1Z7W8887OrGclTeKrqa9yel7LlM4lyGnOnxcDJIJDviWMOSi5+pdQ+yybkuDu930lQbNVM4ytpBGUGyCsDqiJfvxm1LJIV06yMOpZQhanXXqwaFO3VyXjKLxnX5cotjadDR6XIyJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430112; c=relaxed/simple;
	bh=L/c/t+4leGMdBLaivVIb/ruUCGGyN6yH6eKmpNXGc2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THx8tF9ujs0bvmpCRrpPjeCCywIpIMiDfeLhrcnKq3wERQOzhB7Y4ye//6UcfiK6txlfQl/JklrTd17Zcojj9TpHeiJvkx7dAMbBFOcwVZGEmFmBqhRc7ocJonVIVRA5kOooV+D8uZ+zBRSdxecmLRH+yAXS+ZB5hFsfHQGoF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR5L7oO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDE1C4CED6;
	Mon, 24 Feb 2025 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740430112;
	bh=L/c/t+4leGMdBLaivVIb/ruUCGGyN6yH6eKmpNXGc2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rR5L7oO73pbxW1Tp6OyFl6IPvMI7SeiW5CWBmFL8Wzz0blPqdw2Z9dJGlQZBcYE2H
	 Lo4aKLtD2ewupSzD9DQdovx3VYjWzOCZ02ZXzQ0JG8XbANPxGetyXZ0V7nj0Bab2OH
	 sFq7pkGePnfdHqJps9ZXCitTRpMIqjagtvWy2+MijrizzNiKFE8O374VA/AtPco5vA
	 aLvsB05YypPHldbAKVWOBKQDdn8mBPVPm6hw9MyXmgmZjXVyG1m0Ufa0EuJVpPV3i7
	 KoEG2Ab+CvB9XkOKjtq8peYTxJRjAVPLrVXDIXwbi8O3KFLYd0bZyI49Hzsm5hqeYm
	 yqHnPmtXb5afg==
Date: Mon, 24 Feb 2025 12:48:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Krakauer <krakauer@google.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/net: deflake GRO tests and fix return value
 and output
Message-ID: <20250224124830.7c38608a@kernel.org>
In-Reply-To: <20250223151949.1886080-1-krakauer@google.com>
References: <20250220170409.42cce424@kernel.org>
	<20250223151949.1886080-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Feb 2025 07:19:49 -0800 Kevin Krakauer wrote:
> Thanks for the review! I'll split this up. Do you think it's better as two
> patchsets -- one for stability/deflaking, one for return value and output
> cleanup -- or as a single patchset with several commits?

Should be fine either way, they will both end up in net-next.
One patchset may be easier to merge, as we can't CI-test two
conflicting series on the list.

> > To be clear - are you running this over veth or a real device?  
> 
> Over a veth.
> 
> >> Set the device's napi_defer_hard_irqs to 50 so that GRO is less likely
> >> to immediately flush. This already happened in setup_loopback.sh, but
> >> wasn't added to setup_veth.sh. This accounts for most of the reduction
> >> in flakiness.  
> >
> >That doesn't make intuitive sense to me. If we already defer flushes
> >why do we need to also defer IRQs?  
> 
> Yep, the behavior here is weird. I ran `gro.sh -t large` 1000 times with each of
> the following setups (all inside strace to increase flakiness):
> 
> - gro_flush_timeout=1ms, napi_defer_hard_irqs=0  --> failed to GRO 29 times
> - gro_flush_timeout=5ms, napi_defer_hard_irqs=0  --> failed to GRO 45 times
> - gro_flush_timeout=50ms, napi_defer_hard_irqs=0 --> failed to GRO 35 times
> - gro_flush_timeout=1ms, napi_defer_hard_irqs=1  --> failed to GRO 0 times
> - gro_flush_timeout=1ms, napi_defer_hard_irqs=50 --> failed to GRO 0 times
> 
> napi_defer_hard_irqs is clearly having an effect. And deferring once is enough.
> I believe that deferring IRQs prevents anything else from causing a GRO flush
> before gro_flush_timeout expires. While waiting for the timeout to expire, an
> incoming packet can cause napi_complete_done and thus napi_gro_flush to run.
> Outgoing packets from the veth can also cause this: veth_xmit calls
> __veth_xdp_flush, which only actually does anything when IRQs are enabled.
> 
> So napi_defer_hard_irqs=1 seems sufficient to allow the full gro_flush_timeout
> to expire before flushing GRO.

With msec-long deferrals we'll flush due to jiffies change. At least
that explains a bit. Could you maybe try lower timeouts than 1msec?
Previously we'd just keep partially-completed packets in GRO for up 
to 1msec, now we'll delay all packet processing for 1msec, that's a lot.

