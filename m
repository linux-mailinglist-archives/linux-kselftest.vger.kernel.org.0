Return-Path: <linux-kselftest+bounces-25483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9FA23B0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A69169499
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23B918871F;
	Fri, 31 Jan 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKHaGFiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4A2BB15;
	Fri, 31 Jan 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738314575; cv=none; b=st7NQTqIAJrVvPlqnuik0T4dJlAccK/lYxbjjYI2SIKdHfhVYDZ2QUxg3WO/sHNZgFrzIziSCIS1OD4thKJQD4yhh5FlkAEzQQVforFt4IAgh7l/y0tSXyzHYB0rUD2q8ZBrIGP4/FeyZuwO3BmEH5obR5wPd1mXTFb2X2bbja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738314575; c=relaxed/simple;
	bh=OFkh54zJD2NZ80nIDeuODN8ZbPLuQVqC5NfP5c5+kts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmKIL3qsqSGAvY/7TyP/4qVVz4/lV5O1ZWX2U3X2nucHjh1uOob8zXKQwnnJj0F+xvgtUb19mkq6ACX/6OoWjwi+PcaZapBK0DMhd/B/xu3JfZS/qRxxovBaPdftGdlMambBGjjoZdoYMP4V0K7HiQQf+YOj0icrM2vz5QNoP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKHaGFiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C1CC4CED1;
	Fri, 31 Jan 2025 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738314575;
	bh=OFkh54zJD2NZ80nIDeuODN8ZbPLuQVqC5NfP5c5+kts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKHaGFiH98f0ILT14IAQOj9WeQK3fwh8ZqZrFPqkhT7d7V3gg5a9AtVD7ggDEWU7O
	 55GQdD1QJgbgrnJBkMCqgFajkud1Vdv5mLw0+nQlQl16WslYxZp4PiMcGH4+8pwrHJ
	 mbZdG1nfcR/9pdWTsZmraM6P22/3Cxp4bdtb+t8CJQGgHiwyB1zO8BjcCq+1WQDJqz
	 dkZh4/XawzORyNqsAd62JiwC1OjSQf544cd6yw6utMepLJ5vEMLz60g6B7Fmqa3yjr
	 EFFbf1WP7PZgeudjucPZhdKiPOsjBYd3LUgnkg1jhhg1hCWDTM13Mfj6S+jmYsiUeg
	 f7MZUYN2tPlvg==
Date: Fri, 31 Jan 2025 09:09:27 +0000
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH RFC net-next v2 5/6] net: devmem: Implement TX path
Message-ID: <20250131090927.GB24105@kernel.org>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130211539.428952-6-almasrymina@google.com>

On Thu, Jan 30, 2025 at 09:15:38PM +0000, Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally pipe the binding down to the new
> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

...

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c

> index 0e41699df419..9ba6994e2a05 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c

...

> @@ -911,10 +912,68 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> -/* stub */
>  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return 0;
> +	struct net_devmem_dmabuf_binding *binding;
> +	struct list_head *sock_binding_list;
> +	struct net_device *netdev;
> +	u32 ifindex, dmabuf_fd;
> +	struct sk_buff *rsp;
> +	int err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
> +		return -EINVAL;
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> +	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
> +
> +	sock_binding_list =
> +		genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
> +	if (IS_ERR(sock_binding_list))
> +		return PTR_ERR(sock_binding_list);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_genlmsg_free;
> +	}
> +
> +	rtnl_lock();
> +
> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> +	if (!netdev || !netif_device_present(netdev)) {
> +		err = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
> +					 info->extack);
> +	if (IS_ERR(binding)) {
> +		err = PTR_ERR(binding);
> +		goto err_unlock;
> +	}
> +
> +	list_add(&binding->list, sock_binding_list);
> +
> +	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	genlmsg_end(rsp, hdr);
> +
> +	rtnl_unlock();
> +
> +	return genlmsg_reply(rsp, info);
> +
> +	net_devmem_unbind_dmabuf(binding);

Hi Mina,

It appears that the line above is unreachable.
I guess it was part of an unwind that is no-longer needed
and thus can now be removed.

Flagged by Smatch.

> +err_unlock:
> +	rtnl_unlock();
> +err_genlmsg_free:
> +	nlmsg_free(rsp);
> +	return err;
>  }

...

