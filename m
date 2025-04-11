Return-Path: <linux-kselftest+bounces-30500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D66A851E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 05:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4D14C2C32
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5CB27C176;
	Fri, 11 Apr 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJJyt5NW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE526FA65;
	Fri, 11 Apr 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340854; cv=none; b=i9gBItqhi0v2ZXxh6/QOYyp71wwmBfwfTnHbIAYQqgqgcLmzX9gOrtbDwjxVdaxbVixvtP+J5hU69/yRnvmvyO0msaAxZrJNIr2rFEhHmni/cniKgugjSoHJYjya9ZtmpPwFUcf+WbB36OdNvRaUtPd9XkPMTKZXb5SFrWs/1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340854; c=relaxed/simple;
	bh=q/d5G1A5ErYINEVHEdS+Kp1TEKYUBI8nJNPQ1hWXajg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWf0Zhb8SMYtrUo/O0n/laN2gNF0OM2aif8LVDRcnq5WZ2QtE0tfmKpwTgLGasgk+UtgJjSJZlqX73RurOLgKlJSq+q5VJoE/L+0OpAi+HhJadaAilGx3C2XWobM8U8e9O3QfvMQc/COaB5Of+uw7T5o3OeXZgSSS5Ht6aeRGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJJyt5NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0696DC4CEEA;
	Fri, 11 Apr 2025 03:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744340854;
	bh=q/d5G1A5ErYINEVHEdS+Kp1TEKYUBI8nJNPQ1hWXajg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OJJyt5NWunYLI5VwPqhNMo3XqfhdXvxn8/NorrPfgttzpZXGZmp4x+UsTzkQhiYTx
	 Pb+CP0olEO7RtfA+ldHgN1dXmeE/f9nqyVRNE89jO2iI+Qu9/kMTsJl694Tqg+s1d0
	 BHX0KJff1otG3lzqRaOa0v0GRk5djb6MpeE2dywN2nxAkUldHE10gPkGBC/9Fj7wh3
	 UVQVTTJ+feq78Aldb27RpnBW7Hg04Tdg4KCgDCdHDsvt4DyJ5UJ9aj6VuoEEMFoW4E
	 JEOS9jYN1SlvGxknEVdWYj9KBUgC/VqGSozFa1VQrnPWoBUA7skkXC/yeuJ8ovRBWN
	 AOiysi+FrmEFQ==
Date: Thu, 10 Apr 2025 20:07:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Xiao Liang
 <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v25 07/23] ovpn: implement basic TX path (UDP)
Message-ID: <20250410200733.4fea860f@kernel.org>
In-Reply-To: <20250407-b4-ovpn-v25-7-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
	<20250407-b4-ovpn-v25-7-a04eae86e016@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 21:46:15 +0200 Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index 97f6a249b09fe26cc6d078d80abc955f8d35e821..200036757fcd0a7f2ae554a1e3a3c03915c0e32f 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -185,9 +185,8 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>  		goto sock_release;
>  	}
>  
> -	ovpn_sock->ovpn = peer->ovpn;
> -	ovpn_sock->sock = sock;
>  	kref_init(&ovpn_sock->refcount);
> +	ovpn_sock->sock = sock;

> @@ -31,7 +262,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>  {
>  	struct socket *sock = ovpn_sock->sock;
>  	struct ovpn_socket *old_data;
> -	int ret = 0;
> +	int ret;
>  
>  	/* make sure no pre-existing encapsulation handler exists */
>  	rcu_read_lock();

Some unrelated-looking chunks here

> +			dev_core_stats_tx_dropped_inc(ovpn->dev);

Since you're already using TSTATS could you switch to DSTATS 
to count drops, and leave the core stats for the core ?

