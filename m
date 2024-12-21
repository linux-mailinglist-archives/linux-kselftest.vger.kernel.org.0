Return-Path: <linux-kselftest+bounces-23715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5679F9E51
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 05:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD36316B703
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE771DEFF9;
	Sat, 21 Dec 2024 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avKXOgtN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265F198E9B;
	Sat, 21 Dec 2024 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734757018; cv=none; b=avFLqQ24gY37xj/IbM+Nb/k/79F/IUEIxF92KcniZxwcrX3DRM6TMhUqItZZI3WECMLR6QUQFeXIy1pU5ms1MqjTJKT7RSFltqeKhZmf/buNv+tBtOlSPANVy9ig3LkyWwAlmi0/KV/+C6byYKJ0vp3QU0OfnV9nWhzLuJLJebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734757018; c=relaxed/simple;
	bh=7FOuw4VW1dXOygL6l/VKO0gU+qDMoRnFHtkKs7ZTQ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGrhGCyu50GDz3qo2fvmhS/UWpjotp5Fj9tgXbhbvi6Jrb7VfpgYV1nhT+nPSNxEaC4CUaDDszTWStE7DLhTonEvFBp0Fh+FC4lKhCVtn+caUAC/IpOsc45Z/WJGYo+3BKRNem9b0r2u9+e7gibJDGO+V6xZKdq0mPCGtNFzwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avKXOgtN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725f3594965so2257903b3a.3;
        Fri, 20 Dec 2024 20:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734757016; x=1735361816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Js+ugt0MaMMBMpUMnM+FoX1wTi5eOGT/5uX13Q4DL5U=;
        b=avKXOgtNRY02BlyfpRbuojatIqcZAF/Gm7RadFiCCAMbXIyHYaaQGkWHEAk9v5BjcU
         KBWQBBuUuLMlIVg5gazMnj/3ctNDPG5uIqULJaAWvr5TAcsY0ZZIK7bN2Gn4uBKe3zmr
         ABo9uNlmRIgUysmCtibdvMO/KZdfuecTsjtVyrSXow7RLLPI/+lfaXWybL/XZ2oDNT+x
         3+GhzCbEcw+m4p/HnmjXJafhJI3icKHh7HAz/HQNxKNm3xvWu1VRM/Q1flcYgXrSZsqz
         s2fTvQPZIlru28RVmpKu0L9AfbhcI5QjFWiX2tD0EaeYM54lUCL9SPBCArhYKh86KzCS
         V8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734757016; x=1735361816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js+ugt0MaMMBMpUMnM+FoX1wTi5eOGT/5uX13Q4DL5U=;
        b=sHdicPftNoXogJ58nFaMPbus1CpLsC2BE30Ta7TXbPl43/6fa9VLmHcSo/3GepbVJh
         Y4+bXt+qRxtLG0aEbgZrX80BPRRvKyMLyUYbqshbdbuQLmoHl9vpi20GnQQZOLjviwZa
         mGO4PX4V5XrummlMVFmqlD89IAWHkegOZmzYU+vR5q8eyg7kTyWYh4e4nMACoOnDa747
         M4PnpfYzR01FIygYsEXO6s955MM6pBfH/BtoTDpLG77teQ1qBdWk41dc06yfg76ORk4i
         uYFxHf2IEVJD7CMcJXIJgl1dRHMMBCg8LdHyW0mXwyNEstrWzOaYhjSTfKvmTniUapE+
         TGjA==
X-Forwarded-Encrypted: i=1; AJvYcCVzx1NiFOkjhmSMmvuY/l+WIF7yduPaF8YOhpVtNjHcRLBYkHKi0BKJmu/1exsW437JusTSGR2ZPEfB@vger.kernel.org, AJvYcCW6t6frCoHje+tlAHfffvGnUy0w1S0xN/NSAz3RPJGXmQRlKj1PlR9u92S1w6vw/6kTPsD5OBtOj/h1zuZ788jZ@vger.kernel.org, AJvYcCWyEenPnjSA0gU496CWxUGrB2EYk36wVW+T0frRoP5nsnPWOoTuYC3Ya2YgLvVtHbvJODg9nx3htF+8+TTm@vger.kernel.org, AJvYcCX5YI8dAw21Us9eybCE9LbBHh5ZMonJ/YK7m+pxkgiRJ7RAN/qhLJpSKDczhTvQz7CQsxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDEe66kjH2b3S3jiEreADMs7e07FmqYMD/Aq+DSDZvkaZ8wTa
	QrAvISu65qeCHggnFDxlaKMHnZ8eHpkVxhfjxSyk7fNkKiddzwk=
X-Gm-Gg: ASbGncs3fDBQED5rfxDggpIAaxRmnn5VU4wh6rsaEP+ZS7qrRL/MRrbGHyjHZumJYie
	vtONvNZhQf2fHSjiiwSXt4oqhEdidm5bOGtfPKOMOzcvZSunnZGS3KH+0oL9jWY+mSMAOxbsSTE
	nKNm6tpiNabl1w7tlEB6eI9Hu9y5uwo+Igj/6CGszGHdNqdBK9zCeDd4pWJVE7rVxhSKb/aVmrm
	GfLMss03RCfn2P+GjqX6WukQWDcz/809xCsYGMtWrNk8qBb46s6kwVg
X-Google-Smtp-Source: AGHT+IGDzYnWBVN+HX6JFj/d4xjvTo76tHC5MRGFofOtmFjioyS7aCaKvbwNNSAd1pzgo/vnymqfvg==
X-Received: by 2002:a05:6a00:21c2:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-72abdeaae11mr7942842b3a.16.1734757016524;
        Fri, 20 Dec 2024 20:56:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd610sm3944287b3a.136.2024.12.20.20.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 20:56:56 -0800 (PST)
Date: Fri, 20 Dec 2024 20:56:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 1/5] net: add devmem TCP TX documentation
Message-ID: <Z2ZKl_t5e6rutAZ1@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-2-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
> Add documentation outlining the usage and details of the devmem TCP TX
> API.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  Documentation/networking/devmem.rst | 140 +++++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> index d95363645331..9be01cd96ee2 100644
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
> @@ -235,6 +235,138 @@ can be less than the tokens provided by the user in case of:
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

[...]

> +The user should create a msghdr with iov_base set to NULL and iov_len set to the
> +number of bytes to be sent from the dmabuf.

Should we verify that iov_base is NULL in the kernel?

But also, alternatively, why not go with iov_base == offset? This way we
can support several offsets in a single message, just like regular
sendmsg with host memory. Any reason to not do that?

> +The user passes the dma-buf id via the dmabuf_tx_cmsg.dmabuf_id, and passes the
> +offset into the dmabuf from where to start sending using the
> +dmabuf_tx_cmsg.dmabuf_offset field::
> +

[...]

> +        char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> +        struct dmabuf_tx_cmsg ddmabuf;
> +        struct msghdr msg = {};
> +        struct cmsghdr *cmsg;
> +        uint64_t off = 100;
> +        struct iovec iov;
> +
> +	iov.iov_base = NULL;
> +	iov.iov_len = line_size;

nit: indent seems to be different (tabs vs spaces)

