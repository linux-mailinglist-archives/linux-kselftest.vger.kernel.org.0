Return-Path: <linux-kselftest+bounces-24818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625FBA17552
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 01:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E09169E11
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA1C2FB;
	Tue, 21 Jan 2025 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihj8ENJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07179CF;
	Tue, 21 Jan 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737420647; cv=none; b=krKlcgKTm+LRkOcJM/UI7NL62yuR2WWVIPn1jV+r6/cdodv9r+ecfyct1fYpG696tI0Q1DI0IHu3+E5mDf925uHBSq0L8/FgiLsUmFmdH4ChpqExLzR2bNZKx4ec1AoVpmgInpeiJpzasYAkmmf3SLhlROb8bYHU5dOB9gp7Cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737420647; c=relaxed/simple;
	bh=3WWD4KmoVkjBlzmfCgdFh92t2zv1dTpdIl06JzvCTPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV1H54oTddND1pc0EsFRoIn2xrNh0MaZCffPOgj7UcVLFu3Nq9nx7kP4Qry42zRjhLg35oTYipPF9ZvHGAUmyaocdVciT53tZy1/Jj0HENHB1IX9TmCM8BS8p/4UGLxVk459l/scNj9OPQMJoK2C4fzugoyd2f2tq/o4j3UFIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihj8ENJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29936C4CEDD;
	Tue, 21 Jan 2025 00:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737420646;
	bh=3WWD4KmoVkjBlzmfCgdFh92t2zv1dTpdIl06JzvCTPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ihj8ENJm+EuGnKDpyhundveKgaqoMrWqJeBAKIb+pXEB61SmX/DP0M9G+swWJOVIn
	 ehuHoFKAAyYVfSvwf3Jjwnfeqg+IVMSBXerPvU25IlxAo7MqRDm3STHjgPstkexJ/g
	 5+dFqwvvNf4oZaWfgKw8qSAt/RE7FWugXOgEeScG+rb6x5m79mxyUsnBi9GEvgo6eZ
	 EhyXDsstSeIhBqhmzTUstVU6LVtBfRrHcFK+K4yzhTsGASO6IxgsllFNaUrexdkFVM
	 LC3PdNzeAoJgMFD4XTVdNvdAi+leFBlng72hLW8ce6iAIVh2xKQlJ76FEnlW0cKBhl
	 vL8GMEdhpkppw==
Date: Mon, 20 Jan 2025 16:50:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu
 <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?="
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next, v6 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
Message-ID: <20250120165045.628ac29a@kernel.org>
In-Reply-To: <20250117081600.150863-2-yuyanghuang@google.com>
References: <20250117081600.150863-1-yuyanghuang@google.com>
	<20250117081600.150863-2-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 17:15:59 +0900 Yuyang Huang wrote:
> +  -
> +    name: ifmcaddr-attrs
> +    attributes:
> +      -
> +        name: addr
> +        type: binary
> +        value: 7
> +      -
> +        name: cacheinfo
> +        type: binary
> +        struct: ifacacheinfo
> +        value: 6

There's already a "addr-attrs" attribute set defined..
Oh, wait, wrong file.
I think you should be adding to rt_addr.yaml ?
-- 
pw-bot: cr

