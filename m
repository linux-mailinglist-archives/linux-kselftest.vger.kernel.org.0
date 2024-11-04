Return-Path: <linux-kselftest+bounces-21387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380929BB8B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 16:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFF91F22122
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936B1BD4E1;
	Mon,  4 Nov 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MAHwzciq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpgEJMuh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC62B9A2;
	Mon,  4 Nov 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733304; cv=none; b=VWcFhhIHLQlgI1DMCOQcNT+BtbkdNvRLfFnrOijJuxZ4B3OojmoaY4t824hJOLnqDE2ts+nK93ybtTichyMiRI8EwRJhjb1IlBYT1REHZ52DwTHNnkRbKimE5VJoCmG4P6eUcy1ymIPXdISEOfEFn7G2CsuCwu6r7ppOgUw9UcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733304; c=relaxed/simple;
	bh=kTYnw999nI/JqFsVK3bbbPIO4nM5nyfIH9Mdw+awRCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNcDMgkgw86K0QwV/NaafKYkdKEqnCmhRZw5qcJlaC3X0qjNR3utVEWH+90HE1hvrgWS0g2hTzr9F6j6SiE3ONYyIrVW6X7y1YQ2dgKzyRpVkxzMhh+lJHSkuOkSiBhYTZyxXaUQMSQQNCVmIhiEMoF40u34ya/gnLKrlVWPf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MAHwzciq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpgEJMuh; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 4282A1D40250;
	Mon,  4 Nov 2024 10:14:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 10:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730733298; x=
	1730736898; bh=3t9S8lMLsxZ1l3HwamcmToJ6jU6n7DJ3ZQs7SNN8Hic=; b=M
	AHwzciqVjMKKlxsMroKfrWYj5+RS/+kjkeRxP22cj4OLrn6yPV4r2GTyrZepKjFa
	1QXM9SqJpzab0QJqVkgKeZZr7Gwjo4pYd+L5zIfE7uJHS+7Hif64oewXF3xhHDSn
	rHO51dzAxxxVepdMHWjPch871rwu1dkmW9bp0U6rgMtANZfI2itHG2qyVMvzbO9u
	T9ssSyhQ7UYU2A5ngyApd81WGxo+V3nFKJC64qeU7uEHU0coHxvvoRAnibr3nLFz
	4buop86n2YKIFKB0Ae4gyeE2EGGrxE/nckXCKBPpVmSzLa+kKbBU5AFZzRz3+Ws5
	P/3wBGJ03FPdsSVOzMoVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733298; x=1730736898; bh=3t9S8lMLsxZ1l3HwamcmToJ6jU6n7DJ3ZQs
	7SNN8Hic=; b=RpgEJMuhNjKezwpkkFC9FefBRL4pCAvhaljD6qj6LsTWeeE5J7n
	lhxLHm2O2q0FO+x9oso698a+cXrD1kCfW92TIA6jswsAcXkjQ/OGZVQq//meigEk
	kt9AOrnVjw5OlMVFp+0FO0q8M18Gs8loPY6nG7HvDE/vfMDkbv/ab0LFtobU5sOk
	g0wWprw3oWfXmAYTYnKBXhoR4vApKoGKa77Gn57mQLfcGzVspWJoKTJCoirwbvZG
	0kmQTO7cYmyJ4VOFEB5N5d5R1eEdb17ye6cf/277l4SryE1QEMbXyKjX1FObU5kl
	cP72/m8V+qdNFA19dptUOaNZ1uW32239qDw==
X-ME-Sender: <xms:8eQoZ_LQsKsq3EqKMGVb7qr5lVLUqJGmIVERuS04WjM8YeOt6soKtg>
    <xme:8eQoZzJ_ELm3eCWgOtnDhPcyqnycdV5RuIstPhqfJKOPFpkFqDFcjaw00kqZOnbuI
    cRyGwd5jQDxDSp2Ses>
X-ME-Received: <xmr:8eQoZ3tsxTPHIYnlVEz93_C0ft-JIOKRMYrUCXhftEk6Lru8oN1rqBWSSjuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhh
    uhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8eQoZ4YezVoEN7itU2VG_p2WoaN59K977P6RyrNVbXfE4zB01eiUyw>
    <xmx:8eQoZ2YnjobwfIBfKcYrHYS0ZetYmM1GDE92pV90O8UE_oJm4UA-Ag>
    <xmx:8eQoZ8AG20jetaub2NhxzGIgym1DE9NDr4zp4XY59mkU_X-tEfUnNA>
    <xmx:8eQoZ0bx7_hf0EqTNLcQ5YUG5SlMJcinK4lbyxsUau4bueTCTbTIxg>
    <xmx:8eQoZ8NpZC-2xPS8DPENXui-NuvkzcESRUmoB-dcrDYthvLLW0pFlWpd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 10:14:57 -0500 (EST)
Date: Mon, 4 Nov 2024 16:14:55 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Zyjk781vOqV4kXhJ@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>

2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
> +static int ovpn_nl_peer_precheck(struct ovpn_struct *ovpn,
> +				 struct genl_info *info,
> +				 struct nlattr **attrs)
> +{
> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> +			      OVPN_A_PEER_ID))
> +		return -EINVAL;
> +
> +	if (attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "cannot specify both remote IPv4 or IPv6 address");
> +		return -EINVAL;
> +	}
> +
> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
> +	    !attrs[OVPN_A_PEER_REMOTE_IPV6] && attrs[OVPN_A_PEER_REMOTE_PORT]) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "cannot specify remote port without IP address");
> +		return -EINVAL;
> +	}
> +
> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
> +	    attrs[OVPN_A_PEER_LOCAL_IPV4]) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "cannot specify local IPv4 address without remote");
> +		return -EINVAL;
> +	}
> +
> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
> +	    attrs[OVPN_A_PEER_LOCAL_IPV6]) {

I think these consistency checks should account for v4mapped
addresses. With remote=v4mapped and local=v6 we'll end up with an
incorrect ipv4 "local" address (taken out of the ipv6 address's first
4B by ovpn_peer_reset_sockaddr). With remote=ipv6 and local=v4mapped,
we'll pass the last 4B of OVPN_A_PEER_LOCAL_IPV6 to
ovpn_peer_reset_sockaddr and try to read 16B (the full ipv6 address)
out of that.

> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "cannot specify local IPV6 address without remote");
> +		return -EINVAL;
> +	}


[...]
>  int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
[...]
> +	ret = ovpn_nl_peer_modify(peer, info, attrs);
> +	if (ret < 0) {
> +		ovpn_peer_put(peer);
> +		return ret;
> +	}
> +
> +	/* ret == 1 means that VPN IPv4/6 has been modified and rehashing
> +	 * is required
> +	 */
> +	if (ret > 0) {

&& mode == MP ?

I don't see ovpn_nl_peer_modify checking that before returning 1, and
in P2P mode ovpn->peers will be NULL.

> +		spin_lock_bh(&ovpn->peers->lock);
> +		ovpn_peer_hash_vpn_ip(peer);
> +		spin_unlock_bh(&ovpn->peers->lock);
> +	}
> +
> +	ovpn_peer_put(peer);
> +
> +	return 0;
> +}

>  int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  {
[...]
> +	} else {
> +		rcu_read_lock();
> +		hash_for_each_rcu(ovpn->peers->by_id, bkt, peer,
> +				  hash_entry_id) {
> +			/* skip already dumped peers that were dumped by
> +			 * previous invocations
> +			 */
> +			if (last_idx > 0) {
> +				last_idx--;
> +				continue;
> +			}

If a peer that was dumped during a previous invocation is removed in
between, we'll miss one that's still present in the overall dump. I
don't know how much it matters (I guses it depends on how the results
of this dump are used by userspace), so I'll let you decide if this
needs to be fixed immediately or if it can be ignored for now.

> +
> +			if (ovpn_nl_send_peer(skb, info, peer,
> +					      NETLINK_CB(cb->skb).portid,
> +					      cb->nlh->nlmsg_seq,
> +					      NLM_F_MULTI) < 0)
> +				break;
> +
> +			/* count peers being dumped during this invocation */
> +			dumped++;
> +		}
> +		rcu_read_unlock();
> +	}
> +
> +out:
> +	netdev_put(ovpn->dev, &ovpn->dev_tracker);
> +
> +	/* sum up peers dumped in this message, so that at the next invocation
> +	 * we can continue from where we left
> +	 */
> +	cb->args[1] += dumped;
> +	return skb->len;
>  }
>  
>  int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> +	struct ovpn_struct *ovpn = info->user_ptr[0];
> +	struct ovpn_peer *peer;
> +	u32 peer_id;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
> +		return -EINVAL;
> +
> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
> +			       ovpn_peer_nl_policy, info->extack);
> +	if (ret)
> +		return ret;
> +
> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> +			      OVPN_A_PEER_ID))
> +		return -EINVAL;
> +
> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
> +
> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
> +	if (!peer)

maybe c/p the extack from ovpn_nl_peer_get_doit?

> +		return -ENOENT;
> +
> +	netdev_dbg(ovpn->dev, "%s: peer id=%u\n", __func__, peer->id);
> +	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
> +	ovpn_peer_put(peer);
> +
> +	return ret;
>  }

-- 
Sabrina

