Return-Path: <linux-kselftest+bounces-22226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EEA9D1E9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 04:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8861F21DB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9113FD83;
	Tue, 19 Nov 2024 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGWzVf9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7D13775E;
	Tue, 19 Nov 2024 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985623; cv=none; b=J/nYG2R5emdrf/B6Qxy3Dl2KSYZ4F9NsyllYHkj7yoySGJR7DnYpoPij/1OiRvUaD+7+RsN3Mk2Fe3116qE2u/q0oL0QshQqpQvBEZiBqGmp9S4Tl9TJs9gSJ+wjbd+WZO1Irjked3EPtpg5MZXfnx2PwkrIcT8JwpVf0UCHdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985623; c=relaxed/simple;
	bh=PGoG8fEB7llM322/jpcOwn3LGAi0gafsk5SM9vL39KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9KUdDdg2Pywl0c/wAu2E7DH5nMKCEX8sNTgvGUmZ/DWaNLS+RDwx9R/DRSGoVlKnr9uib+00w3veqmIB97V8s7WNkAk2YMIr03I8FHs3J45z8Km4wqwr6mRNvA6Gl9VV940/X9STBtscGXroR0mjpZ3XmSFmzGBhnVJ2yyKl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGWzVf9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD48C4CECF;
	Tue, 19 Nov 2024 03:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985622;
	bh=PGoG8fEB7llM322/jpcOwn3LGAi0gafsk5SM9vL39KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oGWzVf9fm47IURqF82sBjxlSLSQaSxQvnftln+sAaadyrOaTpKmG1QB1++Q+XtGq2
	 iqnrNBO0CyTqqEwlU/q+011kC2hwIrbq/6K0SGXImw3qfRg1+XKGoOsssJ5vIMkYcz
	 Z6YQRFxP4izqrZoqEbsdoy+taGRJqRWgfpsrekJKESn6nbT7e6NOHGhh6GN5IbeTmn
	 lzthFeg7CnYNFnEs0XFbrLEZd2ql/Jl9IGwusT5cDv1Qr6Psf8Q5n6XqbkH/peqmPn
	 uwk0TjN/tbOC/IkQ2CmF/L5xISUzVUBpQQlxdujGCk9lYUVk7IvT7QmP1ZZAPQtMkX
	 AVNlOOjcQBmSw==
Date: Mon, 18 Nov 2024 19:07:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/5] net: Improve netns handling in RTNL and
 ip_tunnel
Message-ID: <20241118190700.4c1b8156@kernel.org>
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 22:32:39 +0800 Xiao Liang wrote:
> This patch series includes some netns-related improvements and fixes for
> RTNL and ip_tunnel, to make link creation more intuitive:
> 
>  - Creating link in another net namespace doesn't conflict with link names
>    in current one.
>  - Refector rtnetlink link creation. Create link in target namespace
>    directly. Pass both source and link netns to drivers via newlink()
>    callback.
> 
> So that
> 
>   # ip link add netns ns1 link-netns ns2 tun0 type gre ...
> 
> will create tun0 in ns1, rather than create it in ns2 and move to ns1.
> And don't conflict with another interface named "tun0" in current netns.

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new drivers,
features, code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


