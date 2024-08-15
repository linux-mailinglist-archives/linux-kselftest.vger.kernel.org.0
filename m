Return-Path: <linux-kselftest+bounces-15373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F0952757
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE67CB221AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0EB36124;
	Thu, 15 Aug 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZY4h41A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE42C1A2;
	Thu, 15 Aug 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683470; cv=none; b=ZRwAEvFKOQzkOmvaXJpbgx0/RV3yPq5G7BFXx0kMdx5rDIO6tXVFbzMnQzmN/aG5OrtUH6TuoMBr4GycCmMgU1sBrwtAYn781bHXLnJcoyyBojbYh+NMlFpZjJmfeP5+Pp5laC0BT13AzQmqSGVXxHFxdcwbrxsf2HJ1LlRvB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683470; c=relaxed/simple;
	bh=dvaf4fV4mIC/tt7eWDLq6DrNS1hZ9gdQ6uWtEZfoKZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDkL35FMprzvfZuXsOUREM/vpgd8ZV7xol+6mb5xX7FZpCKEShHq5YehYMKRbMi3fGzoEt5XagaDZaw/neFSY9hFGJcxibkGJLJ/qnLnsp7YGaVJHaELe9tmx8JHRdn/unWCicB/ZqN/CNzSgcAkRG8/69F++ZcQZLipN4lzEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZY4h41A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499CBC116B1;
	Thu, 15 Aug 2024 00:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723683469;
	bh=dvaf4fV4mIC/tt7eWDLq6DrNS1hZ9gdQ6uWtEZfoKZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZY4h41AE//JhEGv/PkhpZmp9c1Tpz+9T0XtO6ktRBaHlzTvneV7O9LtCEjJNlTa1
	 93i1RM0q9anEboU8vBOfP11TdSyh7cRwLgmXVs1+q7+2KEFAk9A4HTDwItitJzDN1+
	 R8haKRrXyu3/YWpt9Aj5YQ7dPX1ELhHXuB+AaYDXAiY84wA6RsgTYpdVkThvqVxHte
	 JShmVyM0+fU1mSPFmOaRHX58/fvDDvcJoEOJM2SSpR3nZnAVzxxPorbz3Wc3xKdOnP
	 ox5N7RAUrzY5n7y85BKRJE/+AoggC59WqSOKa3qYW1+v+ZQxs9RHaPjUgJM4x5nofP
	 zPmfjPlUVsL9Q==
Date: Wed, 14 Aug 2024 17:57:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH net v6 0/2] Enhance network interface feature testing
Message-ID: <20240814175748.35889b6d@kernel.org>
In-Reply-To: <20240814175651.447982cc@kernel.org>
References: <20240814191517.50466-1-jain.abhinav177@gmail.com>
	<20240814175651.447982cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 17:56:51 -0700 Jakub Kicinski wrote:
> On Wed, 14 Aug 2024 19:15:15 +0000 Abhinav Jain wrote:
> > Changes in v6:
> > Use XFAIL for ethtool operations that are unsupported instead of SKIP.  
> 
> One more:
> 
> tools/testing/selftests/net/netdevice.sh:       echo "SKIP: $netdev: set IP address"
> 
> I think the SKIP -> XFAIL conversion should be a separate patch (for
> total of 3 patches in the series).

P.S. and please change the subject to [PATCH net-next], it's a net-next
change, not a net fix.

