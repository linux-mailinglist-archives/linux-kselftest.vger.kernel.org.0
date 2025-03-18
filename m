Return-Path: <linux-kselftest+bounces-29339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB9A66F0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C5518887E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DBA204F65;
	Tue, 18 Mar 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQUxXxi1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14A2046AF
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287987; cv=none; b=DttMq9Wl6b1OE+9YbobRBMxYE/iziLOPJlqFBjoUbdHXZySMBbkhDZwDMslQ3EovSAZ3egY61/em7ioqbtAZ1F8pkGlH4Opcg/+/23lubWs6DpwM9VgC2NYU7ug0HxlcjYEKBzzkpiEQpuHb3AlT9vFFwjtHHilqYcsh2mF0luw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287987; c=relaxed/simple;
	bh=nBqnAgBHS2l95Pjj/TfnmDtdp5MvYiOaOhdplM2mhmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+Yo6PjgytAbiCwHhiTyD+J8MrAvhXuoRR3ZPxWqim+03rCriranFuXi7xxRazmpEJjk2B0/SkOvWlotlmvVEXJP68VF3VS77EZjiJWjL9BZfeSAXdy/1CkfXH3KbrYpnE0QTfHY7BX2dY6oyphtuX9ZIpX0AmSWby8XWyVPtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQUxXxi1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tObLTe69QFxvzolejx3T+2gunDSqNceNELAPgsdaeHE=;
	b=SQUxXxi1LvHvGtYA1AOZV/fmy6+ksZWbKLHTVSj7aR/awDDE9bC8JJhWSkQIMCHOWN+mco
	q4XRiXdlbYXe41eQkGA5BFepuj9qvwMUlVxpTsiCEOFY5vvkloi7EXeLq+Kr5dmU7Lc+IB
	JSFmKN6Jtts6Z3QNMbuQdhEiGr93Of4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-YoZug0PIOzagMWDb2Ms5vA-1; Tue, 18 Mar 2025 04:53:03 -0400
X-MC-Unique: YoZug0PIOzagMWDb2Ms5vA-1
X-Mimecast-MFC-AGG-ID: YoZug0PIOzagMWDb2Ms5vA_1742287982
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so16356425e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287982; x=1742892782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tObLTe69QFxvzolejx3T+2gunDSqNceNELAPgsdaeHE=;
        b=wTehrmY3uZYEc6AfpdOnmhS0pv1KgUTqdvYtvMGx8NUvRsfGZ5klKSxcGUMVOJZfDl
         stZSQ4qopPJgeCEcPdqOtgEhdwMOn84W3J4K4/REBFELU6psyfpnwuLkxiN+ojmO+55/
         76aJs0W/+HD7x3l7iHE6TdsREVTP6XImCIxPfWdB+VfzQPYTVexdDpH2b0cVaQrlIr4I
         F6tyHnV4pnSTaP8y2pa6z3fXwnopNnZM08BdcYCW7coCozK79dTIMdhZaYn6ZK0Eqrnh
         dMvpwZO3GERj0pfDvKYkKWHNdRy6J4mMviFjO3U8ujpupO30M5ZTtWXA4LbJsald4Rt6
         yOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb9DMvSaE/bRxGtxmOqQWeYQtVDEFHXfY/8Z57gMcByoj+F5CsqTHlWTkBCT1D4IkjXjUrjrDVRjaCqIg+KfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJv19ibGQbQXpnAtPZp7yyN3//cWsNHCr62KnIvNAEPb7HcUbE
	tFo8ITCPPnpQNgmDUpf4kUcxoFQQEfnz7FuVLw4Gy698K73O5DHUG705IS4zUVe/XyjZnc96Z22
	2JPWZ1YYLRlIUADY+VXwOztr+QanBk9U6hXIJ9qSkhF8hQS2WyJvkRAlp1Q2ndQqnKg==
X-Gm-Gg: ASbGncvSEAbmwHNG+eNSe+lkdrkRRq+ySygAscLDWhm6SeyF+gv8iQh6D3JLYc4HZUT
	VZaSNDhYdQeyNdeIf0lf3ZvRfam7mAuAJmy2bAqiZcH7L3gjskxiJGFEa5UUAsw8lGhVfhZTKuH
	ZX1+TZmr2htl2dXdMw6Mq2yIQaz2v29I9L9PsGShT1Td8UkHzLdEe5LQmG1mu3EfjjfYXX/6KT7
	OPzpkVvaeUIri9DkbPRbnmhqxuVqjQWxdPC11iY3YT38lSPnpEnmvFfgS7yMVWRscXsXhJg0Oqd
	vZkLdmUE7WFjjZ8c1shVMYWAef3ljOJHty2jlc017x2RbA==
X-Received: by 2002:a05:600c:1910:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-43d3b98e784mr10214035e9.15.1742287982443;
        Tue, 18 Mar 2025 01:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLxkKyNtE11z59H06IZJtl8h4j7bAu1UH3i6QG52S1C4EP04HZjwsPQi3k1NceSqvEw/VDKQ==
X-Received: by 2002:a05:600c:1910:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-43d3b98e784mr10213835e9.15.1742287982025;
        Tue, 18 Mar 2025 01:53:02 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975d65sm17738818f8f.56.2025.03.18.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:53:01 -0700 (PDT)
Message-ID: <5de5943b-5527-49f6-a454-b3c7358cff56@redhat.com>
Date: Tue, 18 Mar 2025 09:52:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-5-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Kuniyuki.

On 3/8/25 10:40 PM, Mina Almasry wrote:
> @@ -931,10 +932,67 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
> +	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
> +					     NETLINK_CB(skb).sk);
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

The above could possibly be a rtnl_net_lock(), right?

(not strictily related to this series) The same for the existing
rtnl_lock() call in netdev-genl.c, right?

/P


