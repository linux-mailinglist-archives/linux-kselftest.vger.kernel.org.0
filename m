Return-Path: <linux-kselftest+bounces-22128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45539CFB38
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 00:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8D0B22A84
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 23:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A819645C;
	Fri, 15 Nov 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWd4Fyxc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5216631C;
	Fri, 15 Nov 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731713728; cv=none; b=BOv/nfrJNV5J0AB0LdLgzQ9y8Sau2Kuey+i55pi+Xm9GIRRDEI8aBlpqearghPLCezsISwccNrcFhO5VFsAIKw7OQaR6G+FNbev+CP8gQOEDf626oJidpD+msQUMqf37lL4fNVq7d3IkyBbRljd9KP1o4V6viWjbKmPmC3o7HfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731713728; c=relaxed/simple;
	bh=+0nSqXJMNPJie6Agi0DCflpUksVQqJLNIcznPm67J68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzWJtHq4vv1JbdBbp338G1ATWPxqT0zYhS6MQQ4nBW+a/ydVEA9MP3/VTKSYZdcc8+inR/P3q6DWGf6KtTB4OerM4ajRPMUUzczEFZEQKCcT4h6WyuAAwwuUcJphUvZPdxme75H0BwZKTO4JvJCpePHYHIS2Xi4c4f0qQ1c9+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWd4Fyxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018E7C4CECF;
	Fri, 15 Nov 2024 23:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731713727;
	bh=+0nSqXJMNPJie6Agi0DCflpUksVQqJLNIcznPm67J68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SWd4Fyxcy6vkPAs/DoAyKv+eu9nnqiy9VDr1E7w6DAOPjGk3sTNyu3CQVJ1ftQ1Vl
	 KQx7V76ZwBrflcMdU07dZ08pvCiVuMniy4GhDYMkJ/3vahjg0pawSvaX+3JhHfGywU
	 5B5tE+7wI6tq8XfAriVL28lj/YBhGHcMmGeFVzCIrjSd9YzsgSS8omaH0MLx3DWaMn
	 /8V/Hup5AfF5QtyTL3sde4ia3ZIuFa+PC0Cl0GrtcqcB8u0C+PbGN/aNnGXfwN1oRZ
	 wKyFrTPI/2pLhWCxOGsAbPXDBSZL+32gxSUIudNzbcxe8lV0SDX6LcluNtG1LiyPmb
	 wMVTTXTFPHQrg==
Date: Fri, 15 Nov 2024 15:35:26 -0800
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
Subject: Re: [PATCH net-next v3 4/6] rtnetlink: Decouple net namespaces in
 rtnl_newlink_create()
Message-ID: <20241115153526.3582ebcd@kernel.org>
In-Reply-To: <20241113125715.150201-5-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
	<20241113125715.150201-5-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 20:57:13 +0800 Xiao Liang wrote:
> +/**
> + *	struct rtnl_link_nets - net namespace context of newlink.
> + *
> + *	@src_net: Source netns of rtnetlink socket
> + *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified.
> + */
> +struct rtnl_link_nets {
> +	struct net *src_net;
> +	struct net *link_net;
> +};

Let's not limit ourselves to passing just netns via this struct.
Let's call it rtnl_newlink_args or params.

The first patch of the series got merged independently so you'll
need to respin.
-- 
pw-bot: cr

