Return-Path: <linux-kselftest+bounces-27115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE17A3E648
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 22:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1494422C8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09FD1F78E4;
	Thu, 20 Feb 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxTuacAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD11DF735;
	Thu, 20 Feb 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085444; cv=none; b=YHnUnUo7N873SAN6KRgHyc8bt8TF0gLsSM4o6tuQUdLrhxU95i2VU1FZrZbPA7DxyXKhq4Nq5cBJRBblt+POVkqN75877p8LF8zGzi4A45hyGLmaBiTx66yyCWqwbeozJiWAViNmYiDot+F+unotJn9jRbToW2OizyarLSr840I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085444; c=relaxed/simple;
	bh=KH6yptrVoHjVdEEYO4fzP+SSTQw2pLGG01gPyKQOk7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/WyXQvuRrxTSLFa+ZaZLeFZgmSfEzaIAXxZXFhtthYbtuyFCE3wDFvXUnCLtlbnlqXOTlh5on7rV3a5vdIKXC5BMnGEhhNjmYJvlGzA27bkRuFUQCw7cgs47CZE14tV/abF9TB2YWqHok0w+6uGhj7XwPHjJIVBx1xU7OHAtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxTuacAB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220ec47991aso19266175ad.1;
        Thu, 20 Feb 2025 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085442; x=1740690242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=keV+C7HuG/BR9Xl+0GCyBf7ymrkmWeF1SazpD4+k360=;
        b=ZxTuacABZ5YOwTBQvRN2rrGYtxkZfWVmiPRK2X4akQqyTauoFAcqwVFW9LVY9pxu4F
         fxfWrvm5t4FVR3NlcpNy+QoiJujZHpUvkepdrTQAaJ+sOP1rkSrt5AOF4dbqZ72X3nDD
         ue0b85vp9WQcF15YdLtNxFlvlIsxlyz05HEH0FwRH5CKZ+gxdcpeaRxbufLFrMJkxTko
         jz6jLwz8DdxBfWHNs+BtJGvtDxOHr1gaE6sO7e6dc23eJ3c/A7SMeVCI+9Y7bNJ6nLTE
         5i+wQTRUpXWckXid0swezSbF0mc1X53FCULB3S7ijLIkc0dC4VcQxEKujdoxf5x2ep81
         RLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085442; x=1740690242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keV+C7HuG/BR9Xl+0GCyBf7ymrkmWeF1SazpD4+k360=;
        b=Skf3SS1gxxLpWrQ/OahEcHDQjDuiZTg5uPpTP5/wr+c/uDQy4jUXhJkzvH655GO8uL
         oWMSBBI0T4hVIU86FGTCqVdmXsmU7IOQGD6KuQ4zp4ccdJPbmNbebabQx+HtMdMaGWrr
         FGMKtfqkaDTdzAJU1plJW377OrP0L5ykkVC3p/cnjENOg7nfckOkvz+Hp1MMCI1VwZtj
         HR9sWMX0BhycGgAx2chO1x4++2yimHUSsCSMX5PLgMWcENoLPtl2l9ZkdP7GPO4nLDpV
         RwGtzz21ceBDhHijTTK00wdetgiATXggp3hRPaLoHmHJLQ/Tl1oxkXnOx2FCy0quOC7K
         /Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCK3peQi7+AHFNgoOuycjD4M2xPMBFMZ0nTMMVVpY8fR4S+YFE50SxTySVrSH1ttkIbCsfcaVRedT@vger.kernel.org, AJvYcCWCGGSKF1J2c/9ULQC2rvUqNBzsDOOo20n+Q0rhJwYL5+DZiBLJ9DVCkJIGVrmasnr6DUM=@vger.kernel.org, AJvYcCWHNFAjVVHZqL3YhzCP/cV+hUTzJrTSTqY7l2fcKygFyhFfs6xHfwkBL5iv8AHwuSiORJk2LSWuP4YipWK+@vger.kernel.org, AJvYcCXeB49Ovm+B9kApFnif6TdcL2uU0OsX5u+KLgAsElOjcGOv61wQGOyUhupLfSkFuocFdIgqp71pHQ37hJp+FluH@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYB2ouSLYZhYUj/OA4+OUaDdG2fPgSAGHoasVU5CCpcXwLIkU
	rX1VDoaAtn25XYZT2/uzY3rBaeNgW7WWj/uXBCJA70faEE/cXZw=
X-Gm-Gg: ASbGnctYwGd1LqzxQ97Udlrw9joXKPD7RjqMYAzKqMFpX8gpZy4ayhbWbbSs1k/XCgN
	7oGH3lkmTnQupvDvYL0HQd6Cwp5upOdG1r9o0/IHzQb10M27g3iKnhLtCGMNorzdS2sjfxXGrrr
	5+LjkmqXkFNzi/VG2lI4ZUiPmb8wwrx8p7oyb28sT7TGe1VqJL+ALrMSzV5hpgL4/eLG/QqVdmc
	QpWyaU7C77ckzX4gCgACcNqM3ytBKyUOWwOFgnPZGerTduyr1tk/N3VEYJsVZMVRx2F/t4xMVnb
	XshYbtzlnxOJBK8=
X-Google-Smtp-Source: AGHT+IFWQl3OYv6bwFItuWow2gk/r95ziBtMPww6Leolb64qsq+wq8UcmTTlx891rb3hnwG5aPaoFg==
X-Received: by 2002:a17:902:ea06:b0:215:acb3:3786 with SMTP id d9443c01a7336-2219ff4eccbmr9785315ad.19.1740085442409;
        Thu, 20 Feb 2025 13:04:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d536439bsm125465845ad.81.2025.02.20.13.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:04:01 -0800 (PST)
Date: Thu, 20 Feb 2025 13:04:01 -0800
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
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 5/9] net: add devmem TCP TX documentation
Message-ID: <Z7eYwVrnTjgFV3XF@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-6-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> Add documentation outlining the usage and details of the devmem TCP TX
> API.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

With a few nits below:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

> 
> ---
> 
> v4:
> - Mention SO_BINDTODEVICE is recommended (me/Pavel).
> 
> v2:
> - Update documentation for iov_base is the dmabuf offset (Stan)
> 
> ---
>  Documentation/networking/devmem.rst | 150 +++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> index d95363645331..10928a5f912f 100644
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
> @@ -235,6 +235,148 @@ can be less than the tokens provided by the user in case of:
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
> +	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +
> +It is also recommended that the user binds the TX socket to the same interface
> +the dma-buf has been bound to via SO_BINDTODEVICE.
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifname) + 1);
> +
> +
> +Sending data
> +--------------

               ^^ extra junk

> +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> +
> +The user should create a msghdr where,
> +
> +iov_base is set to the offset into the dmabuf to start sending from.
> +iov_len is set to the number of bytes to be sent from the dmabuf.

nit: maybe bullet point the above?

The user should create a msghdr with the following set of msg_iov:

* iov_base is set to the offset into the dmabuf to start sending from
* iov_len is set to the number of bytes to be sent from the dmabuf

