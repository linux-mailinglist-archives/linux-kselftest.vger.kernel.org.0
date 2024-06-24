Return-Path: <linux-kselftest+bounces-12592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F86915AAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA09B28A49B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF01A2C28;
	Mon, 24 Jun 2024 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw0LFT32"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8151420B0;
	Mon, 24 Jun 2024 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271880; cv=none; b=J4gnt06QHyht5PjolHf5Xv1e3etq2AHJeIz1c3SwmBLTQAqF0OlDBLLE/AnKCV7946c45LXN6e6IMwRf9I2KwJ7+Y2FOe0mwvJ7t6QDFkm/L4Y0oOtm0kUOaPCq4ORuqKtApsxYGG72g9IXILCEDZN0gQPUUSp2wz/fYvpZfXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271880; c=relaxed/simple;
	bh=yjJa80FPCig3MrpVxeocO5/1nbi4alK+u2vhJQANtFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV45xsUhv9UzBtX01rdQN6eLltsjy4eY7jSuqkjzboHUm1cRaS4abXo2H0hh873kAgLKe+XONqmGXjt3jtlOl8oby4yrRSwsqz8XwC+tkzRwyZC10EnaaoUNSODqRx00y8iZaUVyuQdYLCwU/OHTyZNX8ms+Br3u8WrfxlNtc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw0LFT32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A731C2BBFC;
	Mon, 24 Jun 2024 23:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719271879;
	bh=yjJa80FPCig3MrpVxeocO5/1nbi4alK+u2vhJQANtFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dw0LFT32hG/gWzvNuKUj8mOBhvgczvg0mju55EfHqQymXU+F0e0IDGyADHwacDdPi
	 OxfTKOLqmf1A5F8IR/w65hoMvWQ7aShhc+Ma4o0Mt77wmWFRtuLbuofEOgp4khVJHR
	 V5X0A5FV7YtWvONT8cxmi5/kmytr/wPmUNktJVuK1AIXFGpb1bW96GH5H5oOHLASTz
	 je8ErUwbDBOXU+jmBlXoAT+my6/egBdwlzAXGZsyAHl+Phb9yQaiHL3mhVSYQSC+Fq
	 9plnk71OTK/7oHE6AJ1ocMMBj7LPURw026KHT6SuX73BPRSx22kvh3ppww9H0p2knE
	 9k5BZv9XuPnQQ==
Date: Mon, 24 Jun 2024 16:31:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH net] selftests: net: remove unneeded IP_GRE config
Message-ID: <20240624163118.7d825048@kernel.org>
In-Reply-To: <20240624055539.2092322-1-yujie.liu@intel.com>
References: <20240624055539.2092322-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 13:55:39 +0800 Yujie Liu wrote:
> It seems that there is no definition for config IP_GRE, and it is not a
> dependency of other configs, so remove it.
> 
> linux$ find -name Kconfig | xargs grep "IP_GRE"
> <-- nothing
> 
> There is a IPV6_GRE config defined in net/ipv6/Kconfig. It only depends
> on NET_IPGRE_DEMUX but not IP_GRE.
> 
> Fixes: 04fe7c5029cb ("selftests: fill in some missing configs for net")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>

Patch makes sense, that said it's harmless so I'd suggest net-next.

Acked-by: Jakub Kicinski <kuba@kernel.org>

