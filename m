Return-Path: <linux-kselftest+bounces-44466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F938C22C21
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 01:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545DB18915C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFACA5A;
	Fri, 31 Oct 2025 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euFxyhAh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6038D;
	Fri, 31 Oct 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761868939; cv=none; b=kl+eF5jiIl/wQoVgd7kXiGwVsxl9CwI5/i5l74qdJJhmdXes3d6Orc3CeIl1jZry+VIqZaz7d5a2235lV87n+EORohPfKWuCQBQ2XYULGHjwv+5Nd9p4yKxtmOvo1mnFwI6Wq073IbJeDYuQBiZuzEgT9acQFQ+iCpfRHUV5Kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761868939; c=relaxed/simple;
	bh=+0qSbPlFADwmFuwny6mW8/uzS5Pe58C0fQKvtQ9YcYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+DD0kEchFPMwKJQsd1EGAA9jqqPtgHFmT4a2X03xE8MYIVWa5myzdD4gwKL6+O01Z/ODm98z4zNH29HIrGcI6+DZLXx3MeHcNcnmSnHBvd0iuvfnkDzN4Ki08meCYHVNe5kwjkZk6Q9hKZoVVXktF1UBh3MGL7XKU6XwZGGqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euFxyhAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6292C4CEF1;
	Fri, 31 Oct 2025 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761868938;
	bh=+0qSbPlFADwmFuwny6mW8/uzS5Pe58C0fQKvtQ9YcYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=euFxyhAhRBCdQD0zSW+Zsth/k8NgXN0RMgex6jYHL7X7Pa/q1zj0StnUQBHmg6TOq
	 YwLrP/sRoV8t/cHbsyjtBVltWsDRvffYg4cPXJ1J/stiHDnAKDawzityttEsfoAQu+
	 TA66U+1a0Wn5eNn25I2TFNnSmiEsTEk+X8hUCuoGlMWCvhhNDCiFquol0WNCwoZQPT
	 vu7nQyVHcCYjySTiTihesbPEhH70F+hnY/+A0YAfvc8xjWG3ei32HsMgDGv1NsDPPo
	 tLRY2YHxpT/v5GZ/Ijsg7Y3rJegjst11BO0D7cNO55MFDL47wz5lO5Y6JIb0S0RX2t
	 0X4ans2KWATVg==
Date: Thu, 30 Oct 2025 17:02:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Wang Liang <wangliang74@huawei.com>, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <20251030170217.43e544ad@kernel.org>
In-Reply-To: <aQPxN5lQui5j8nK8@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
	<aQPxN5lQui5j8nK8@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 00:13:59 +0100 Sabrina Dubroca wrote:
> >  set -o pipefail
> >  
> > +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then  
> 
> I guess it's improving the situation, but I've got a system with an
> ethtool that accepts the --json argument, but silently ignores it for
>  -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> output), which will still cause the test to fail later.

And --json was added to -k in Jan 2022, that's pretty long ago.
I'm not sure we need this aspect of the patch at all..
-- 
pw-bot: cr

