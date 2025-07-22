Return-Path: <linux-kselftest+bounces-37850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A795BB0E201
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC493A1DF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A682427AC32;
	Tue, 22 Jul 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOMA9KL7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78A27816E;
	Tue, 22 Jul 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202210; cv=none; b=D3PqgDzOm1o/tQ+sVBJNbUZptNSTbUOA92DsyRUz/2GQTnQroi7i55XMimzlu6AHxIOQo6H9GV6y+8dfH9pKt7ww1ArBOcQE4SW8secemQyLK8RqN7PCqKZuY1TiHnUGg7mayjRGcyYJ6d4SyJhgkflx6oLcdYLuIvNJtmEDui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202210; c=relaxed/simple;
	bh=8IC9X4ZB0VrVik2Ye+ACM6bdPab587yF0W5iK7IqWaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al9PuMvZvpXakDXOybG3Bx2X9jcV9GucUDB5k8quc+sIpguc4BOcG9TuNn1sMMoB/IY9JCHxxJnSDqeTTo1IIe6vRQX7lDjqiZoTVDDI5pgSarWo9G++7P9EX+7A0X+/4EdTUvSsyWWCDYAbdzMEW0JKch26ZJk10L2eOK0Jsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOMA9KL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79C7C4CEEB;
	Tue, 22 Jul 2025 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753202210;
	bh=8IC9X4ZB0VrVik2Ye+ACM6bdPab587yF0W5iK7IqWaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOMA9KL73oysLWi64ODYzAOI47zlxxF4AjjYjCyCOqKPhP/Sj2ZCKmojt2qpPy08o
	 JJtQEE+StXu7Yk7ikwJ1wETIwp+miTppOc/znDjN0+qqi7kHbqOd6gm6o6u1tPFmbt
	 SUWoK0zRwCgE9nJG/eDsd+4sSawSF/yLIZMKtJPAc2b5jVowT7ba42lIyl+BbqWezi
	 FzaSvMGb+z/Ea6hf2CuvcTSJWgWfAhuwkpbK1Ji/rvjJt7tEGR7E9DQGH+8a1OaVGS
	 tXRaWeTOWGS35u/7103m5VMyU8v4m/O1pD9c/oQZfL53rWWa0D1N6cX1dkldLlbdN/
	 mKAAHRNiVCCxQ==
Date: Tue, 22 Jul 2025 17:36:45 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	andrew+netdev@lunn.ch, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net 1/2] macsec: set IFF_UNICAST_FLT priv flag
Message-ID: <20250722163645.GP2459@horms.kernel.org>
References: <20250721165423.990313-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721165423.990313-1-sdf@fomichev.me>

On Mon, Jul 21, 2025 at 09:54:22AM -0700, Stanislav Fomichev wrote:
> Cosmin reports the following locking issue:
> 
>   # BUG: sleeping function called from invalid context at
>   kernel/locking/mutex.c:275
>   #   dump_stack_lvl+0x4f/0x60
>   #   __might_resched+0xeb/0x140
>   #   mutex_lock+0x1a/0x40
>   #   dev_set_promiscuity+0x26/0x90
>   #   __dev_set_promiscuity+0x85/0x170
>   #   __dev_set_rx_mode+0x69/0xa0
>   #   dev_uc_add+0x6d/0x80
>   #   vlan_dev_open+0x5f/0x120 [8021q]
>   #  __dev_open+0x10c/0x2a0
>   #  __dev_change_flags+0x1a4/0x210
>   #  netif_change_flags+0x22/0x60
>   #  do_setlink.isra.0+0xdb0/0x10f0
>   #  rtnl_newlink+0x797/0xb00
>   #  rtnetlink_rcv_msg+0x1cb/0x3f0
>   #  netlink_rcv_skb+0x53/0x100
>   #  netlink_unicast+0x273/0x3b0
>   #  netlink_sendmsg+0x1f2/0x430
> 
> Which is similar to recent syzkaller reports in [0] and [1] and triggers
> because macsec does not advertise IFF_UNICAST_FLT although it has proper
> ndo_set_rx_mode callback that takes care of pushing uc/mc addresses
> down to the real device.
> 
> In general, dev_uc_add call path is problematic for stacking
> non-IFF_UNICAST_FLT because we might grab netdev instance lock under
> addr_list_lock spinlock, so this is not a systemic fix.
> 
> 0: https://lore.kernel.org/netdev/686d55b4.050a0220.1ffab7.0014.GAE@google.com
> 1: https://lore.kernel.org/netdev/68712acf.a00a0220.26a83e.0051.GAE@google.com/
> Link: 2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com

I think that Link: should be followed by a URL

Link: https://lore.kernel.org/netdev/2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com

> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
> Tested-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Hi Stan,

I ran the test provided by patch 2/2.
When run with with a debug kernel using VNG.

It reliably passes with patch 1/2 applied. And fails without patch 1/2 applied.
Where fails means the kernel panics along the lines of the stack trace in
the commit message.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>

...

