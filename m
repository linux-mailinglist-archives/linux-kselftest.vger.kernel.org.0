Return-Path: <linux-kselftest+bounces-22158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4679D05E9
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 21:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1132820D7
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D031DB93A;
	Sun, 17 Nov 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YUigP6rx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83917BB6;
	Sun, 17 Nov 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876633; cv=none; b=okO138YWmyUwn+LQsYN7uvPGjKU8Fn7n1CvrGpQB/AN6+I33jz6hmDLhk2ydVYQ0vVNQaq4pU/ASanUfovr6BKM6Pk93JV8YgZ165kKscHtSQRoTmhfXnVW2PiALaXng6LOxxNuH7cXIk9rj8xCJtUbyMv42G7eQiruo+TwAOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876633; c=relaxed/simple;
	bh=kyPpFDnqb7LNLHad0cPKGNxRKPn1cSwcwxAQ9dtIRsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd4j2JRMn7eUsnFeDHxdu7pCV3NfFF3Hzkn+TxN0Kq2B1yvHelFrufkM7nTei5MhSUJmmlRAbMf2d+om5ZwZ2Wb8cdgMu5vbhAI+HjvfVrQOjPQaXA5aXX+rRnz7iSTb1vvb9gn6Vko32ejwFu4tKlYi73mX4aDZyzsXDd0/fOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YUigP6rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875F3C4CECD;
	Sun, 17 Nov 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YUigP6rx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731876630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gSCBJB8RborMmFQHp8hbCfO+7ERT5vDowmtQ5/z6cJs=;
	b=YUigP6rxN++G05bDuSZJJLqTyKWw57RsxRvQfsIHK+TBOAOCfODmQJAqEP06ptQS2XQhZK
	LPD+ldNeclzJw2jAJ+8kJ2PJJpEi1cTn7bvi5ubzV+Dol7SAHMzQcrE2YPAi+nfFyO7lUa
	zqX4f+pe6aJ9ovR8LHIdIvgLZtJlr5c=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 48d6b135 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 20:50:29 +0000 (UTC)
Date: Sun, 17 Nov 2024 21:50:27 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jrife@google.com>
Cc: wireguard@lists.zx2c4.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <ZzpXE8GlhjDYTa5l@zx2c4.com>
References: <20240905200551.4099064-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905200551.4099064-1-jrife@google.com>

Hi Jordan,

Sorry it's taken me a bit to look at this patch. A few notes:

On Thu, Sep 05, 2024 at 03:05:41PM -0500, Jordan Rife wrote:
> With the current API the only way to remove an allowed IP is to
> completely rebuild the allowed IPs set for a peer using
> WGPEER_F_REPLACE_ALLOWEDIPS. In other words, if my current configuration
> is such that a peer has allowed IP IPs 192.168.0.2 and 192.168.0.3 and I
> want to remove 192.168.0.2 the actual transition looks like this.
> 
> [192.168.0.2, 192.168.0.3] <-- Initial state
> []                         <-- Step 1: Allowed IPs removed for peer
> [192.168.0.3]              <-- Step 2: Allowed IPs added back for peer
> 
> This is true even if the allowed IP list is small and the update does
> not need to be batched into multiple WG_CMD_SET_DEVICE requests, as
> the removal and subsequent addition of IPs is non-atomic within a single
> request. Consequently, wg_allowedips_lookup_dst and
> wg_allowedips_lookup_src may return NULL while reconfiguring a peer even
> for packets bound for IPs a user did not intend to remove leading to
> unintended interruptions in connectivity. This presents in userspace as
> failed calls to sendto and sendmsg for UDP sockets. In my case, I ran
> netperf while repeatedly reconfiguring the allowed IPs for a peer with
> wg.
> 
> /usr/local/bin/netperf -H 10.102.73.72 -l 10m -t UDP_STREAM -- -R 1 -m 1024
> send_data: data send error: No route to host (errno 113)
> netperf: send_omni: send_data failed: No route to host

That's a worthwhile point. This indeed fixes a *bug*, beyond being just
a helpful new feature.

> incrementally updated. This patch also bumps WG_GENL_VERSION which can
> be used by clients to detect whether or not their system supports the
> WGALLOWEDIP_F_REMOVE_ME flag.

I'm actually less enthusiastic about this part, but mainly because I
haven't looked closely at what the convention for this is. I was
wondering though - this adds WGALLOWEDIP_A_FLAGS, which didn't exist
before. Shouldn't some upper layer return a relevant value in that case?
And even within the existing flags, for WGPEER_A_FLAGS, for example, old
kernels check to see if there are new flags, for this purpose, e.g.:

        if (attrs[WGPEER_A_FLAGS])
                flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
        ret = -EOPNOTSUPP;
        if (flags & ~__WGPEER_F_ALL)
                goto out;

So I think we might be able to avoid having to bump the version number.
GENL is supposed to be extensible like this.

> +static void _remove(struct allowedips_node *node, struct mutex *lock)

This file doesn't really do the _ prefix thing anywhere. Can you call
this something more descriptive, like "remove_node"?

> -		if (free_parent)
> -			child = rcu_dereference_protected(
> -					parent->bit[!(node->parent_bit_packed & 1)],
> -					lockdep_is_held(lock));
[...]
> +	if (free_parent)
> +		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
> +						  lockdep_is_held(lock));

Thanks for fixing up the ugly extra \n in the original code you copy and
pasted from. I remember the horror of that when I added line breaks in
the original code.

> +	call_rcu(&node->rcu, node_free_rcu);
> +	if (!free_parent)
> +		return;
> +	if (child)
> +		child->parent_bit_packed = parent->parent_bit_packed;
> +	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
> +	call_rcu(&parent->rcu, node_free_rcu);
> +}
> +
> +static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
> +		  u8 cidr, struct wg_peer *peer, struct mutex *lock)
> +{
> +	struct allowedips_node *node;
> +
> +	if (unlikely(cidr > bits || !peer))
> +		return -EINVAL;

Reasoning for this is that it copies the logic in add()?

> +	if (!rcu_access_pointer(*trie) ||
> +	    !node_placement(*trie, key, cidr, bits, &node, lock) ||
> +	    peer != rcu_access_pointer(node->peer))
> +		return 0;

What's the reasoning behind returning success when it can't find the
node? Because in that case it's already removed so the function is
idempotent? And you checked that nothing really cares about the return
value there anyway? Or is this a mistake and you meant to return
something else? I can imagine good reasoning in either direction; I'd
just like to learn that your choice is deliberate.

> +
> +	_remove(node, lock);
> +
> +	return 0;
> +}
> +
>  	family = nla_get_u16(attrs[WGALLOWEDIP_A_FAMILY]);
>  	cidr = nla_get_u8(attrs[WGALLOWEDIP_A_CIDR_MASK]);
> +	if (attrs[WGALLOWEDIP_A_FLAGS])
> +		flags = nla_get_u32(attrs[WGALLOWEDIP_A_FLAGS]);

As I mentioned above, you need to do the dance of:

        ret = -EOPNOTSUPP;
        if (flags & ~__WGALLOWEDIP_F_ALL)
                goto out;

So that we can safely extend this later.


>  
>  	if (family == AF_INET && cidr <= 32 &&
> -	    nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in_addr))
> -		ret = wg_allowedips_insert_v4(
> -			&peer->device->peer_allowedips,
> -			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
> -			&peer->device->device_update_lock);
> -	else if (family == AF_INET6 && cidr <= 128 &&
> -		 nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in6_addr))
> -		ret = wg_allowedips_insert_v6(
> -			&peer->device->peer_allowedips,
> -			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
> -			&peer->device->device_update_lock);
> +	    nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in_addr)) {
> +		if (flags & WGALLOWEDIP_F_REMOVE_ME)
> +			ret = wg_allowedips_remove_v4(&peer->device->peer_allowedips,
> +						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]),
> +						      cidr,
> +						      peer,
> +						      &peer->device->device_update_lock);

We get 100 chars now, so you can rewrite this as:

                        ret = wg_allowedips_remove_v4(&peer->device->peer_allowedips,
                                                      nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr,
                                                      peer, &peer->device->device_update_lock);

> + *                    WGALLOWEDIP_A_FLAGS: NLA_U32, WGALLOWEDIP_F_REMOVE_ME if
> + *                                         the specified IP should be removed,

That comma should be a semicolon because what comes after is a complete
sentence, and there's no conjunction.

> + *                                         otherwise this IP will be added if
> + *                                         it is not already present.


> +remove-ip:
> +	gcc -I/usr/include/libnl3 \
> +	    -I../../../../usr/include \
> +	    remove-ip.c \
> +	    -o remove-ip \
> +	    -lnl-genl-3 \
> +	    -lnl-3
>
> +	sock = nl_socket_alloc();
> +	genl_connect(sock);
> +	family = genl_ctrl_resolve(sock, WG_GENL_NAME);
> +	msg = nlmsg_alloc();
> +	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_ECHO,
> +		    WG_CMD_SET_DEVICE, WG_GENL_VERSION);
> +	nla_put_string(msg, WGDEVICE_A_IFNAME, argv[1]);
> +
> +	struct nlattr *peers = nla_nest_start(msg, WGDEVICE_A_PEERS);
> +	struct nlattr *peer0 = nla_nest_start(msg, 0);
> +
> +	nla_put(msg, WGPEER_A_PUBLIC_KEY, CURVE25519_KEY_SIZE, pub_key);
> +
> +	struct nlattr *allowed_ips = nla_nest_start(msg, WGPEER_A_ALLOWEDIPS);
> +	struct nlattr *allowed_ip0 = nla_nest_start(msg, 0);
> +
> +	nla_put_u16(msg, WGALLOWEDIP_A_FAMILY, af);
> +	nla_put(msg, WGALLOWEDIP_A_IPADDR, addr_len, &addr);
> +	nla_put_u8(msg, WGALLOWEDIP_A_CIDR_MASK, cidr);
> +	nla_put_u32(msg, WGALLOWEDIP_A_FLAGS, WGALLOWEDIP_F_REMOVE_ME);
> +	nla_nest_end(msg, allowed_ip0);
> +	nla_nest_end(msg, allowed_ips);
> +	nla_nest_end(msg, peer0);
> +	nla_nest_end(msg, peers);
> +
> +	int err = nl_send_sync(sock, msg);
> +
> +	if (err < 0) {
> +		char message[256];
> +
> +		nl_perror(err, message);
> +		printf("An error occurred: %d - %s\n", err, message);
> +	}
> +
 
I'm not so keen on this, simply because we've been able to do everything
else in that script and keeping with the "make sure the userspace
tooling" paradigm. There are two options:

1. Rewrite netns.sh all in C, only depending on libnl or whatever (which
   I would actually really *love* to see happen). This would change the
   testing paradigm, but I'd be okay with that if it's done well and all
   at once.

2. Add support for this new flag to wg(8) (which I think is necessary
   anyway for this to land; kernel features and userspace support oughta
   be posted at once).


Thanks for the patch. I like the feature and I'm happy you posted this.

Jason

