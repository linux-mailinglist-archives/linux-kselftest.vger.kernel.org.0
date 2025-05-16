Return-Path: <linux-kselftest+bounces-33194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9439BAB9EB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21371BC42B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3331A5BA9;
	Fri, 16 May 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdIIpNJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B51A3159;
	Fri, 16 May 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406157; cv=none; b=ccpA19g7lRlciPYazN0qFsTukRqxFYRX1D0VykYV07m4nWqZ1kQ1dB/ysVcLM+j35bfafRD6oDFqWxDgYGe+RJq59efxdQH8KSHTM4PXVuKtDQBhPlGt0qY5NAbv1+XuJLGMFuvoSlgfjm3ClQS5RqWMZjTBPzwohdhPBFhiwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406157; c=relaxed/simple;
	bh=Ogd+hIgVrZ22tEQjOqjzdcAXRUppwTmaITwWTzOe+70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1GC64zJsDI3e+aQmGpUuMMrx1AQckNoDFMZoYYz2ofAPLgd76aX9wxdR2sdMeyS0wCqbqxrPaBNfnO2Ovzss9Ck/aNyOPLV8JktVCOAEll1hXIsvpmaRJhzAxD+YtQqLAa34Jrk+R7nXLOoV/4LQBbaS3pKFTGWhl9KFYnfbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdIIpNJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCD1C4CEE4;
	Fri, 16 May 2025 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747406157;
	bh=Ogd+hIgVrZ22tEQjOqjzdcAXRUppwTmaITwWTzOe+70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BdIIpNJKkY8MJ/0LYqvVEMn8BmgYkgeDMf432/Vx/L8wLvOgbGFcX5cEefi1y9C3R
	 NorcX/F4Xg4J5JDY5cm6HPa8mkNUHjDBHM+9NFlpo5VHx3sY36mrbIRP1HJ9eJPeFP
	 38YePmGhO5+z6YrbMT7cHXZpdwbE0NrcXqZueJQX6HisUMqxZsiV/mrxTfHFjdYnqn
	 sr6T626LI5gx9GzxkMbIMYFmAR9bonAB7g/ZlRK5MH6U6gJanSIyyOdHWddL7+q26c
	 ifkfpkttMGk3uQDqBKZXY5KxEJOhJGtJ/dMRp5y5BBekiJqoObBQlziCNqmYoc3jw3
	 PdPAL2HhcZi/A==
Date: Fri, 16 May 2025 07:35:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: validate team flags propagation
Message-ID: <20250516073556.5983d1d0@kernel.org>
In-Reply-To: <20250515231332.4120071-1-stfomichev@gmail.com>
References: <20250515231332.4120071-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 16:13:32 -0700 Stanislav Fomichev wrote:
> Cover three recent cases:
> 1. missing ops locking for the lowers during netdev_sync_lower_features
> 2. missing locking for dev_set_promiscuity (plus netdev_ops_assert_locked
>    with a comment on why/when it's needed)
> 3. rcu lock during team_change_rx_flags
> 
> Verified that each one triggers when the respective fix is reverted.
> Not sure about the placement, but since it all relies on teaming,
> added to the teaming directory.
> 
> One ugly bit is that I add NETIF_F_LRO to netdevsim; there is no way
> to trigger netdev_sync_lower_features without it.

Seems to consistently fail in NIPA :(
-- 
pw-bot: cr

