Return-Path: <linux-kselftest+bounces-25270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E33A2036F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 04:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C41885B00
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BAD18F2FB;
	Tue, 28 Jan 2025 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNdWfCrj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC9136672;
	Tue, 28 Jan 2025 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738036279; cv=none; b=fEhMbeGWXMYkDi8PbVmpB+jApIO99Ems0zMcBdIEawWPZDjPdGVyp7xeUI/olNgQyf0gkxuXRVjV3e0X56EbtT3uoYO209+H1AV3dbnDHhFCCcAO3FpOP2+NmrxQbjrBvDyOy07+EKCZalWZ7KG5J/+A9P8BoljXNw9cAdc0cVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738036279; c=relaxed/simple;
	bh=7DHdH3QIB4/aIvYvMzTcfsXzKyQPErbl4wTLrcNA4u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txs6Lp2txgxtlf07C4XkOmRDzXKKw7RGMCduOTLYTMOhQOATokrrRm7nXFwshyswGIGs5uSyxXvpjXsBcardztsKdbbx99mRDiJ6nvtGjvlurhNFmGW5ZK5xnnABWyVSLxNRVu7CkPevZ4ymbb5Obswc81hiaeiHet8a7/oxbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNdWfCrj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21649a7bcdcso86593725ad.1;
        Mon, 27 Jan 2025 19:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738036277; x=1738641077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eE4NK7zi6DRmjZbJJPFVGsr/4GCtOpXvykBa4nzZpdw=;
        b=MNdWfCrjfpcn/CjI38sLzHyDoaqOidPXWolfLZSxurcLdIh4dOtkk96kdV86fWYlUS
         yThRJ8e6l1MCaMkIKi8sc5Dg66dOU0C+bgTsNcyen5JWRte03yj9aj9hHvyC8YLyoguh
         jp2eMZnne6J0UzX9CD5VJQFppcUAVwklIBE9CGvUbA+w34WpopurHXi9G/o1529xBIuI
         jYtFpTfP5HlxnjtpDH2/b5ao4RsWROQupjtYE4EW4unlFitLVCbvMc4XCBiMuo2EXGXV
         LDmwfQF6+kWZCRU7uAScD7xYKwHiCXu5OXQfEPWWw7bcYwet5i9cAqqh65/Se3dk9Gu8
         0bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738036277; x=1738641077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE4NK7zi6DRmjZbJJPFVGsr/4GCtOpXvykBa4nzZpdw=;
        b=E1uXN9+NGf9L5fCXEE/zUg8Ee53hk+orENoW0dA7thVtkr9f/Jho2U6MmMfVjGz6j7
         uwASVfHk9kInZRZl36K4NhOhrrpYIBnXMfSp3Qi771gZgVS3akKnbamXzNfIuyZdfwJJ
         FNgAAAZVmOFJqMbIFqKCm/fXRDCcpjDNjtWRBh2342KTTMlYONEKsQqfz0DBsaIl9Cc4
         xJSa+6LqJyucnJp70HNQi9cCnVXosnOBQ4ptv+uBo3pCNDeqbDPzWWKRnKCLO5T/enRf
         jAVyvTtz3FNW8R7u5RYJZcvMfYlW40NSxAQ1EQkhIrfV7kD5ZZJ+Ir7LD/747Z3gpbqA
         TTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx02XEXX5j8QvfQf5eMBR2C3kWy+SvoZzVIsU5KpzT1Or0ld0txh03MYcmID/u7XDifNc=@vger.kernel.org, AJvYcCVXBX/yVfDqXKZ5whIJ6QOxYNcqZVcnaC8bQVV94CPk7ckfSEudW0M7jFjxrNp8C3+8RU7omJndVurn@vger.kernel.org, AJvYcCVdZLiGQX5B1Zjlh3GTS4TN2wBhXdrx/6S9WZyQDmgYF8sP1JpohgWZmgF50Isxcpmqijt+6xKLLXEHur//@vger.kernel.org, AJvYcCWwpQoDYK71qKMAmSyCKj9R0dAWUXx97pMou+irVsz/5b642QNGAhepPD/dMkmlpJtNGtAqh1Jkkk7Ao1Q9h6J7@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcYz604ax0b7rPzLfhTXZfnCLQR9rdTxFelNkeUYQtWoiw3bU
	hd88imi1F21yxT1JBXVU4VtY42LgVNOIIx6DKFwr5yulRfSWNhU=
X-Gm-Gg: ASbGncv8ZvSodrm8E8P7Nsg9xLET79SYSNZcJxe/DsWgoC8vdd+Omc57Gk8DD0aIt2B
	5xpvd+chzpLAWjQ9qoJIpsmG5wt8k+jTxfGMeMbrDdKpveEXVwqrWeN69sJgy3dhAleVnRFXWNy
	6nRhRpMrpYTHeVtJr9kS9RK60oeYimzUcwTSnCQz+5scUmspvswUD5DsCb4GH4coQHxAITkUeMW
	S5FiPrASnngL0BV9ikb7vISxmcpWSgosm3McmV1JjyqEAFU73X0JxGb5ImbM04UV+DKdY3iDIIq
	x4CnpJW6SxApuHI=
X-Google-Smtp-Source: AGHT+IFDB8vH86L3VCH6mxs2zWmuZXjDaEw3CuiPxfDxVtjVS5KKM1yt/iURsdzQSwN6nIik2SGVkQ==
X-Received: by 2002:a05:6a00:1c9b:b0:725:e015:9090 with SMTP id d2e1a72fcca58-72daf9508a0mr52200721b3a.9.1738036277037;
        Mon, 27 Jan 2025 19:51:17 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72f8a760e2asm8023776b3a.88.2025.01.27.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 19:51:16 -0800 (PST)
Date: Mon, 27 Jan 2025 19:51:15 -0800
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
Message-ID: <Z5hUMyWY7PpCLK2c@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-2-almasrymina@google.com>
 <Z2ZKl_t5e6rutAZ1@mini-arch>
 <CAHS8izOcQRjYYGwA_rx-zvX8dMV=40rzVJvEugY78jzCBHCq=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOcQRjYYGwA_rx-zvX8dMV=40rzVJvEugY78jzCBHCq=A@mail.gmail.com>

On 01/27, Mina Almasry wrote:
> On Fri, Dec 20, 2024 at 8:56 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 12/21, Mina Almasry wrote:
> > > Add documentation outlining the usage and details of the devmem TCP TX
> > > API.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > ---
> > >  Documentation/networking/devmem.rst | 140 +++++++++++++++++++++++++++-
> > >  1 file changed, 136 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> > > index d95363645331..9be01cd96ee2 100644
> > > --- a/Documentation/networking/devmem.rst
> > > +++ b/Documentation/networking/devmem.rst
> > > @@ -62,15 +62,15 @@ More Info
> > >      https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
> > >
> > >
> > > -Interface
> > > -=========
> > > +RX Interface
> > > +============
> > >
> > >
> > >  Example
> > >  -------
> > >
> > > -tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
> > > -the RX path of this API.
> > > +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an example of
> > > +setting up the RX path of this API.
> > >
> > >
> > >  NIC Setup
> > > @@ -235,6 +235,138 @@ can be less than the tokens provided by the user in case of:
> > >  (a) an internal kernel leak bug.
> > >  (b) the user passed more than 1024 frags.
> > >
> > > +TX Interface
> > > +============
> > > +
> > > +
> > > +Example
> > > +-------
> > > +
> > > +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an example of
> > > +setting up the TX path of this API.
> > > +
> > > +
> > > +NIC Setup
> > > +---------
> > > +
> > > +The user must bind a TX dmabuf to a given NIC using the netlink API::
> > > +
> > > +        struct netdev_bind_tx_req *req = NULL;
> > > +        struct netdev_bind_tx_rsp *rsp = NULL;
> > > +        struct ynl_error yerr;
> > > +
> > > +        *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> > > +
> > > +        req = netdev_bind_tx_req_alloc();
> > > +        netdev_bind_tx_req_set_ifindex(req, ifindex);
> > > +        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> > > +
> > > +        rsp = netdev_bind_tx(*ys, req);
> > > +
> > > +        tx_dmabuf_id = rsp->id;
> > > +
> > > +
> > > +The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
> > > +that has been bound.
> > > +
> > > +The user can unbind the dmabuf from the netdevice by closing the netlink socket
> > > +that established the binding. We do this so that the binding is automatically
> > > +unbound even if the userspace process crashes.
> > > +
> > > +Note that any reasonably well-behaved dmabuf from any exporter should work with
> > > +devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
> > > +this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
> > > +
> > > +Socket Setup
> > > +------------
> > > +
> > > +The user application must use MSG_ZEROCOPY flag when sending devmem TCP. Devmem
> > > +cannot be copied by the kernel, so the semantics of the devmem TX are similar
> > > +to the semantics of MSG_ZEROCOPY.
> > > +
> > > +     ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> > > +
> > > +Sending data
> > > +--------------
> > > +
> > > +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> > > +
> >
> > [...]
> >
> > > +The user should create a msghdr with iov_base set to NULL and iov_len set to the
> > > +number of bytes to be sent from the dmabuf.
> >
> > Should we verify that iov_base is NULL in the kernel?
> >
> > But also, alternatively, why not go with iov_base == offset? This way we
> > can support several offsets in a single message, just like regular
> > sendmsg with host memory. Any reason to not do that?
> >
> 
> Sorry for the late reply. Some of these suggestions took a bit to
> investigate and other priorities pulled me a bit from this.
> 
> I've prototyped using iov_base as offset with some help from your
> published branch, and it works fine. It seems to me a big improvement
> to the UAPI. Will reupload RFC v2 while the tree is closed with this
> change.

Great, thanks for the update, looking forward!

