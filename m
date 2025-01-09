Return-Path: <linux-kselftest+bounces-24122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B646A073CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63D81889B11
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8251215F6A;
	Thu,  9 Jan 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZzsvayx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E521579C
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420094; cv=none; b=ndbPF6I/qLmVlL+DUpv6oruhJj61o5cTzmmJreKf75X4f+mdeyn7XQevTSbb7AoM+8AEYyBSDR3wsTXGzSYqPzVVan12JAY+o/PfCUtJwZEYbzdiROeQOeJhvZ2fB65ApSf3nK3EeUFfNH9mQ8fZBkghSxSM5v6wnnghBHq8QiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420094; c=relaxed/simple;
	bh=xjYW09EFLzW2yW/rm2jKIbdQTrSIoe4IkZQrwEIOLtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gULlPzjDMqLXISy775IiwWEf/C7956GsMXcdK9t2TZxtd/8ehWgKOozUcmUn5MkM0zpb+oWk4QZfZU7oS0qC7uFf3os+LVaJGmYoBWW9g4k96Wik0Z70zOPMZoHmWQe7Eyv6ZWSJ2G616JO9SsCKer3SQn4MkCEatBd2g3R0AKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZzsvayx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736420092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIj/wFJWJng3DU5tsrpsirFE9no8V87x/TiEdYyqsbI=;
	b=MZzsvayxwmQ1wsDztuwFpRa76Y7GwOP5wJPmKHsiNcJsxbXUaoAqg/1i+nYa2dPQSBO+UN
	HY2SFieU7QJND3kq1y+eqDDJSzZLjSp8vScDiX4s37N+Kf0QWDGHxfyHuQrDBpAxf/9Iy4
	OQFqhYolRq2vdwtTbdTxJAWrFoaIPEc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-DXPtGjrbNTmJudiuJbNwTg-1; Thu, 09 Jan 2025 05:54:50 -0500
X-MC-Unique: DXPtGjrbNTmJudiuJbNwTg-1
X-Mimecast-MFC-AGG-ID: DXPtGjrbNTmJudiuJbNwTg
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf921b8a85so78518266b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 02:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736420089; x=1737024889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIj/wFJWJng3DU5tsrpsirFE9no8V87x/TiEdYyqsbI=;
        b=qjvYKpWWtLVUb+uEVGyI7MdbsCqWFLC/OVN9ULGBh1FWjnrpbQ1GxWO3vEEiapJtXT
         6pUemOJtOWIb3Zu1Je/uqCbUJg2O3lLZwwg6Vb4BqI6KT68HYRXIo2K/4Jh+TPevGb0a
         iMsKIiw0anQHGoiaIW6wmT/nX4pDIE1ZmussIQUTv1CO5/gT5RHo8wliWdW5ALI+7JCg
         /jsi7oSD67E3454SU28wKzVrxqngiKO6/CONfaFvCG2mwH4bC/97PgmcuvQeLZrTPFmT
         Fm3piN2SOdwsX2xzOmIhussjL3pBewZ2BZMEVZBgKL9ngWRX5Mg17gMPxYHNxJ3wM9DF
         W/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUCRhaZ1uRAJEiSUh8Idf/QBa+p4tFXzust1FdCotqeAvjOSmTcRZtmjZMJ8umHXhDvUwi1WmgRMKpCtnxEz1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxqTTi1mXKs7yEc8N//VlIa41vIl23rPCS/RLRM0BRCwwxV9E
	GQs6sOK1pD/GK/5e9ImjgC1SLNAPTz2vlVdPrqFPyWcVaAMDkjiTc7epJj4XOnhuMiOxPshupAo
	GYW/A8seWIRvYhicrNxx8MYdSLpPCYt436wrDoR0HQ2/wyPnQNKNlKMgrbgKlIvT2Aw==
X-Gm-Gg: ASbGncsBIREuWOQRgrjtNu1JCN4UMbhaFqjUwHArndGrKwjVjgGxP2uWnu+odiHs5om
	yWdlSJLLNU/z4jAH0qLeOLrrZWKnVLnwC7OHRb1UWl8Lmu/a4nyib44QmHhRTEV5tNCDw8nIV9M
	FPoErAkArGKR4c55IS/X66DEu6zIOGCetrMQvQL4ePrbkNr12S8BAGk6VQxRHioEmDVp9V1ZbNT
	QKgrmII1frOvpBLVqkxMo1Bd1bPbdC/f2ur5o0loMAI7sE3qQE=
X-Received: by 2002:a17:907:72cb:b0:aab:daf0:3198 with SMTP id a640c23a62f3a-ab2abca7800mr500877166b.40.1736420088901;
        Thu, 09 Jan 2025 02:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExyIT+vLyZuSRO1HYHRpQZAcLjGAM/DPQm1sU+k2N6FecPo+8VNAPHL27tLDu8PEC84rgUxQ==
X-Received: by 2002:a17:907:72cb:b0:aab:daf0:3198 with SMTP id a640c23a62f3a-ab2abca7800mr500875966b.40.1736420088534;
        Thu, 09 Jan 2025 02:54:48 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562e9bsm58983266b.106.2025.01.09.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:54:47 -0800 (PST)
Date: Thu, 9 Jan 2025 05:54:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Message-ID: <20250109055425-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <20250109023144-mutt-send-email-mst@kernel.org>
 <20250109023829-mutt-send-email-mst@kernel.org>
 <ad580d7b-2bd1-401e-bb7b-b67ec943918f@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad580d7b-2bd1-401e-bb7b-b67ec943918f@daynix.com>

On Thu, Jan 09, 2025 at 06:38:10PM +0900, Akihiko Odaki wrote:
> On 2025/01/09 16:40, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2025 at 02:32:25AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Jan 09, 2025 at 03:58:45PM +0900, Akihiko Odaki wrote:
> > > > The specification says the device MUST set num_buffers to 1 if
> > > > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> > > > 
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > 
> > > 
> > > How do we know this is v1 and not v0? Confused.
> > 
> > Ah I got it, you assume userspace will over-write it
> > if VIRTIO_NET_F_MRG_RXBUF is set.
> > If we are leaving this up to userspace, why not let it do
> > it always?
> 
> tun may be used with vhost_net, which does not set the field.

I'd fix that in vhost net.


> > 
> > > > ---
> > > >   drivers/net/tap.c      |  2 +-
> > > >   drivers/net/tun.c      |  6 ++++--
> > > >   drivers/net/tun_vnet.c | 14 +++++++++-----
> > > >   drivers/net/tun_vnet.h |  4 ++--
> > > >   4 files changed, 16 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > > index 60804855510b..fe9554ee5b8b 100644
> > > > --- a/drivers/net/tap.c
> > > > +++ b/drivers/net/tap.c
> > > > @@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
> > > >   	int total;
> > > >   	if (q->flags & IFF_VNET_HDR) {
> > > > -		struct virtio_net_hdr vnet_hdr;
> > > > +		struct virtio_net_hdr_v1 vnet_hdr;
> > > >   		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index dbf0dee92e93..f211d0580887 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -1991,7 +1991,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
> > > >   	size_t total;
> > > >   	if (tun->flags & IFF_VNET_HDR) {
> > > > -		struct virtio_net_hdr gso = { 0 };
> > > > +		struct virtio_net_hdr_v1 gso = {
> > > > +			.num_buffers = __virtio16_to_cpu(true, 1)
> > > > +		};
> > > >   		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> > > >   		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> > > > @@ -2044,7 +2046,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> > > >   	}
> > > >   	if (vnet_hdr_sz) {
> > > > -		struct virtio_net_hdr gso;
> > > > +		struct virtio_net_hdr_v1 gso;
> > > >   		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
> > > >   		if (ret < 0)
> > > > diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> > > > index ffb2186facd3..a7a7989fae56 100644
> > > > --- a/drivers/net/tun_vnet.c
> > > > +++ b/drivers/net/tun_vnet.c
> > > > @@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
> > > >   EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
> > > >   int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > > > -		     const struct virtio_net_hdr *hdr)
> > > > +		     const struct virtio_net_hdr_v1 *hdr)
> > > >   {
> > > > +	int content_sz = MIN(sizeof(*hdr), sz);
> > > > +
> > > >   	if (iov_iter_count(iter) < sz)
> > > >   		return -EINVAL;
> > > > -	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> > > > +	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
> > > >   		return -EFAULT;
> > > > -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> > > > +	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
> > > >   		return -EFAULT;
> > > >   	return 0;
> > > > @@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
> > > >   int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> > > >   			  const struct sk_buff *skb,
> > > > -			  struct virtio_net_hdr *hdr)
> > > > +			  struct virtio_net_hdr_v1 *hdr)
> > > >   {
> > > >   	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> > > > -	if (virtio_net_hdr_from_skb(skb, hdr,
> > > > +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
> > > >   				    tun_vnet_is_little_endian(flags), true,
> > > >   				    vlan_hlen)) {
> > > >   		struct skb_shared_info *sinfo = skb_shinfo(skb);
> > > > @@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> > > >   		return -EINVAL;
> > > >   	}
> > > > +	hdr->num_buffers = 1;
> > > > +
> > > >   	return 0;
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
> > > > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > > > index 2dfdbe92bb24..d8fd94094227 100644
> > > > --- a/drivers/net/tun_vnet.h
> > > > +++ b/drivers/net/tun_vnet.h
> > > > @@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
> > > >   		     struct virtio_net_hdr *hdr);
> > > >   int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > > > -		     const struct virtio_net_hdr *hdr);
> > > > +		     const struct virtio_net_hdr_v1 *hdr);
> > > >   int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
> > > >   			const struct virtio_net_hdr *hdr);
> > > >   int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> > > >   			  const struct sk_buff *skb,
> > > > -			  struct virtio_net_hdr *hdr);
> > > > +			  struct virtio_net_hdr_v1 *hdr);
> > > >   #endif /* TUN_VNET_H */
> > > > 
> > > > -- 
> > > > 2.47.1
> > 


