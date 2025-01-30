Return-Path: <linux-kselftest+bounces-25452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB1CA2376F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 23:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6C0166138
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304731F1510;
	Thu, 30 Jan 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHFS2WjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549561F1300;
	Thu, 30 Jan 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738277954; cv=none; b=jaqDdOjDERVjc8Rq2Mg43EwWJM/g1bqqHCGOTNWf9OEm4NyONxSbh4Z4llFSJKTtTwO6yZExqMwqNm2SkOW8ZAstOqb4bh/iHAB/pkpCJ0o6wS1j+Zpma0GVa6aSL3BAzSRo/MJaCCc2U6eYGDYKAO0X1Yhav8yAqnxy1RaMwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738277954; c=relaxed/simple;
	bh=jlGPx+Vuc42F4f5ClkPPNCa6niD0NXNghbQUyEZgP+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7NPacH4HUqDfg36e/6vJgbCWVdnapnEjktpsToT2cQrkg5kJvbD4gqtKgQmQd5fsZfwD/lrliLPIkL3hDaC/n3oLsLAMpC6jHexcKkKBPo6N1DM7J5E0/UD8cPikKD0J5b+L9ry6MdBTRN7ODP0T4685X1wriApAeaklf6j4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHFS2WjH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so1895373a91.3;
        Thu, 30 Jan 2025 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738277951; x=1738882751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGwxI5UuKBfMTrMct5qfq/USLHQLhnSYLl8x3SVYSYc=;
        b=FHFS2WjHTOkRBS3G9Jvu7EVNqdW9eLiCEWk+JqftHJvU/PCGamC91HumoPTdj6or0U
         Xx66mDO1oii/t5x+3ZZoriPpLxEafVba3Zd7UGO7Zio7YLMe2IPAGk+4nV1RpO18KqCI
         70qLJ7u8RBekOmwm8ZeiN7MP0dFVfvmYkHVlFWSuebuVlniiu8jomO3d086uF1ScpN60
         zN47zXdFjZ2XcHfTlYMTe/Xz1L2LmZOAqK2lctfnA9PwEwxEexNQlkWq9TaO3SK0g6TA
         PP2UOjCARu97VGr50gOPEiOM8Du9pkjqPHgJEaU3N91FaplkZmePBdIjAMHsle8c+96M
         HYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738277951; x=1738882751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGwxI5UuKBfMTrMct5qfq/USLHQLhnSYLl8x3SVYSYc=;
        b=RHLss3tsT+YzxFdO0g/hgeKTcg/m3VtK8DIp354n5DS8ZcVgcZWoxUNj1K3URzoSCe
         acMuDAM7DeRuZsR5P5+S5JB3vU6hf7yHNWFEQa/AUpsL2prbM6+D3+wtEBXt94PRKUTP
         ykvyMY/N8iaDFYQr3MBftTLrbDUETijRkWfGNCyn0QXbkqiMyPHeTcgW7oymh1Sz/lgQ
         JjkQjN+dVipXR10VETSVKFhoYCFHG+ZS4fEm2ck83BP38yIrcqY0x5p+LL++fgFsaK4N
         RioRE7DDFnsL9NdWJLIKfXCX0Qx2l2Bw1J49ZTkoHZ18r98bJvmu5rGXCsfah1D62aO+
         9imA==
X-Forwarded-Encrypted: i=1; AJvYcCUr//LUE1zjmS0Y/LXQ9Vv1NwjxRMXVDyxHRC8wUNZCGHpjD4olxUAtHBFzCF1tjgzqNs8=@vger.kernel.org, AJvYcCV2OyrbGvBGfDczfGYFd928phAuMeaLnDcrtwqzdUF85XeSbq6CYsjzN8ecN/oWv+nZGdpNnXLpjliUcotLNglj@vger.kernel.org, AJvYcCWZloVfi/jsyECZ1eWeSwDFTz4c+WijXoicUkwHs9HgXLXmD6EC3FJd6AWRg9xdsKrMs9Ea4adhJNeS@vger.kernel.org, AJvYcCXgSguY9ZJ1rsEV4WeKVsP8Ktdy/L7GibVllB5NMvLnrdO9zCCGN4eQc0N/kYLwaYY8bhzN06/JstDb7Idq@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBQpgnIBPCOzFALM7Y4Gcm2EuE6et6om8Xtn9bWuz38U8HNJx
	CSineSDnE42FR8p03P+w2Px3/IFmZmZ7KMGzqCHiRBM6+eoXy8U=
X-Gm-Gg: ASbGncuLvPsbBWkKlX/LyJBNSIPKLG2JZJvyuxFIj2DMOYXEfmvYQntbmsA6JmJkHGV
	v46AgjmzXdSVn+KyzTTt5zc2EM+zLNp5ajGwzxyp5IcggevS6rI6dlBk1YheXXJXhpb+Km9PWKP
	iJOPLbDPH3WsZYjFoR6uYsLZvTuCQQvW5WhT8IC/3Mlk8lQP+eVsDEyxIgcx7vFzpa5eWA7EbDd
	leukqYDE0j/lic/lAF6UEGbWG4ZRvuex0avjQ9QRvyB3eYaG3NTS/fI/6jGCK/6PDT824r4FDLz
	6Kbb/vySk5SZCD8=
X-Google-Smtp-Source: AGHT+IF40W/xjpetzz3O9nqgU8Q7OQmYP686oXKV+QTGph5aLVCIwEKwn9kMrNIRQxcVURPqLHdJaw==
X-Received: by 2002:a17:90b:5408:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2f83abbea88mr12329378a91.5.1738277951291;
        Thu, 30 Jan 2025 14:59:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f83bc98ae9sm4936182a91.10.2025.01.30.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 14:59:10 -0800 (PST)
Date: Thu, 30 Jan 2025 14:59:10 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next v2 1/6] net: add devmem TCP TX documentation
Message-ID: <Z5wEPlsRoU6Kx9S-@mini-arch>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130211539.428952-2-almasrymina@google.com>

On 01/30, Mina Almasry wrote:
> Add documentation outlining the usage and details of the devmem TCP TX
> API.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v2:
> - Update documentation for iov_base is the dmabuf offset (Stan)
> ---
>  Documentation/networking/devmem.rst | 144 +++++++++++++++++++++++++++-
>  1 file changed, 140 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> index d95363645331..8166fe09da13 100644
> --- a/Documentation/networking/devmem.rst
> +++ b/Documentation/networking/devmem.rst
> @@ -62,15 +62,15 @@ More Info
>      https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
>  
>  
> -Interface
> -=========
> +RX Interface
> +============
>  
>  
>  Example
>  -------
>  
> -tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
> -the RX path of this API.
> +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an example of
> +setting up the RX path of this API.
>  
>  
>  NIC Setup
> @@ -235,6 +235,142 @@ can be less than the tokens provided by the user in case of:
>  (a) an internal kernel leak bug.
>  (b) the user passed more than 1024 frags.
>  
> +TX Interface
> +============
> +
> +
> +Example
> +-------
> +
> +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an example of
> +setting up the TX path of this API.
> +
> +
> +NIC Setup
> +---------
> +
> +The user must bind a TX dmabuf to a given NIC using the netlink API::
> +
> +        struct netdev_bind_tx_req *req = NULL;
> +        struct netdev_bind_tx_rsp *rsp = NULL;
> +        struct ynl_error yerr;
> +
> +        *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +
> +        req = netdev_bind_tx_req_alloc();
> +        netdev_bind_tx_req_set_ifindex(req, ifindex);
> +        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> +
> +        rsp = netdev_bind_tx(*ys, req);
> +
> +        tx_dmabuf_id = rsp->id;
> +
> +
> +The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
> +that has been bound.
> +
> +The user can unbind the dmabuf from the netdevice by closing the netlink socket
> +that established the binding. We do this so that the binding is automatically
> +unbound even if the userspace process crashes.
> +
> +Note that any reasonably well-behaved dmabuf from any exporter should work with
> +devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
> +this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
> +
> +Socket Setup
> +------------
> +
> +The user application must use MSG_ZEROCOPY flag when sending devmem TCP. Devmem
> +cannot be copied by the kernel, so the semantics of the devmem TX are similar
> +to the semantics of MSG_ZEROCOPY.
> +
> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +
> +Sending data
> +--------------
> +
> +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> +
> +The user should create a msghdr where,
> +
> +iov_base is set to the offset into the dmabuf to start sending from.
> +iov_len is set to the number of bytes to be sent from the dmabuf.
> +
> +The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabuf_id.
> +
> +The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
> +from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_id::
> +
> +       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> +       struct dmabuf_tx_cmsg ddmabuf;
> +       struct msghdr msg = {};
> +       struct cmsghdr *cmsg;
> +       struct iovec iov[2];
> +
> +       iov[0].iov_base = (void*)100;
> +       iov[0].iov_len = 1024;
> +       iov[1].iov_base = (void*)2000;
> +       iov[1].iov_len = 2048;
> +
> +       msg.msg_iov = iov;
> +       msg.msg_iovlen = 2;
> +
> +       msg.msg_control = ctrl_data;
> +       msg.msg_controllen = sizeof(ctrl_data);
> +
> +       cmsg = CMSG_FIRSTHDR(&msg);
> +       cmsg->cmsg_level = SOL_SOCKET;
> +       cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
> +       cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
> +
> +       ddmabuf.dmabuf_id = tx_dmabuf_id;
> +
> +       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;

[..]

> +       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);

Not super important, but any reason not to use MSG_SOCK_DEVMEM as a
flag? We already use it for recvmsg, seems logical to mirror the same
flag on the transmit side?

