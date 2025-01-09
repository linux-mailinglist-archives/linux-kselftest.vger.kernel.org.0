Return-Path: <linux-kselftest+bounces-24111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86277A06F2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A184165C83
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA485214809;
	Thu,  9 Jan 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fzq7nAtk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F72147EF
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408466; cv=none; b=FAMR2U+OrNy5/Y3UsyzrOm/FZRWpsZkRpreGxUcpPglAbStC089bKxRAnhw4jhbz8EpJsqGaBvtQeAHI1Z82NCBM7Nfe0EdWJtz6R4rSLo5xWJQJWUESWfTcPkhpNR/ky1I8SsWZHdNMeSU5klFD6bQ8FlFQ/ls1BIKf60Z0krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408466; c=relaxed/simple;
	bh=Qk38VXpNNITAt7xRhep592aDF5AOkqXBIeZKZMfgj1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHwq8gS4WSKvTTy6mPIR0y5o6hSxbBCKN7iTaE5y4s5qTi6Ao4/oa/E3K+vjKCl2pJykteh5GKWFene8wQvnbwi4bQ61xgibYawVS9D5IkUKoO/mBiHr/80UveBnquUqI2zJ34zjzJshDRimoMnn8zngYpJCfiaK1CqOTToHOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fzq7nAtk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736408464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvMHmhw41jW2VMbkE+Q7qKoGQkCDW1O/R8raW3Ad35s=;
	b=Fzq7nAtk+yva78lKVdQSanr1CqlSzr8ZI4tnyrC3zqQ+f9Fqu0EvtauISutbTstufTx35c
	TjkWqTAF7C0FDQrOdK+cBNHDUMwGNVvOYqSwVV1KTFzqdzu+HGTdPR0AW1kOjErvlLq7dW
	Y9Gwx1zQwFZ4wfJU7ro9fT+pUlHSKF0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-jSh1XH0WOrGJ_1V7hfM7DQ-1; Thu, 09 Jan 2025 02:41:02 -0500
X-MC-Unique: jSh1XH0WOrGJ_1V7hfM7DQ-1
X-Mimecast-MFC-AGG-ID: jSh1XH0WOrGJ_1V7hfM7DQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa683e90dd3so50425266b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 23:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736408461; x=1737013261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvMHmhw41jW2VMbkE+Q7qKoGQkCDW1O/R8raW3Ad35s=;
        b=FQ0IxsXe00M86/zhBtuE5Mxfu65vKmHkeFlY/2ZBRUX9f/IhL57KkmsM9Z9a6n3vYZ
         q3x1YFMndLrUQYq+cVT/5KjMMQz7HvWtc0AXZO4YlUCaQ7UWwwIpsDPJCgivsqTIoqwV
         cN/yo7Oc14zbJJC/M10k7IFr/B05B7QmFMObdNcO2sj+86lVziPlLLc4YAP4O13cfusc
         8nzyZYJ6KMsD7biPEe9SC3cp5ArSQ6JH21vuHp/3tQ3RySentvryz596nhtXNRhF5Suw
         4oiwWrJfrJOe2yDuPr+SuJYUZmPRB/gQpO8tp/hzrPc3Z4cJ3zpcL7NxcM3DoFMgrgcT
         DaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCURGMWk6ynpnL1nNJngeeK4Qkhq9tIO3+2WBmk60a8nLwPXUX6b0YR3MTCPx342BNf2+eYUxxGbGKtkEZIb8TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfbTUArHc3CPmM9IoYfB4vPo06IJbtuWbTHScT6qDzSxBRS3y
	5Z2vpWErmxGuzcZ1ors7+rvyem3uG5I+v5BDJPGZdnzvUais4DEjfDkx9ufmt7aeOyr4/tG1s7D
	BtQfEqrWKIvffNtOnDhTgr55UEsAgWzN7YZwloXvVvYuXMZMp4+kVC/w+8gufbvIlqg==
X-Gm-Gg: ASbGnctEl+CTxbJat2/Hd/iU0UDy+w/Z/ZA3iDux7oTlnOBMSvrQ50OsZkLbBd9j3ch
	lZQRqNtIii7EJM90QCXMUuWmoOkhOzoTTsNwfRElT8bQ43RQY0EpgnbMizxlffq2q+8Ji3PU6fT
	8Vl8C3G1CpWhszYgQFyICwvuBrzNttYIS0gZu1m9XLiq/E2CxKLyMvqi7yBRjehUPMUgQVtk/xc
	Ocj7Gz8nbov9DoEL27oLOsZXgFZsq2hp8ab/itV7gVJWXTey2E=
X-Received: by 2002:a17:907:6d01:b0:aab:d8de:64ed with SMTP id a640c23a62f3a-ab2ab6fcf85mr565432166b.25.1736408461315;
        Wed, 08 Jan 2025 23:41:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDzuwKOL/SH91ITfaKkGp53CDAvxvv6OgtnJor6T2CNBRRh8F6ch+wN71Fz8qty44wy1eohw==
X-Received: by 2002:a17:907:6d01:b0:aab:d8de:64ed with SMTP id a640c23a62f3a-ab2ab6fcf85mr565430166b.25.1736408460902;
        Wed, 08 Jan 2025 23:41:00 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c91362a2sm42852366b.85.2025.01.08.23.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:41:00 -0800 (PST)
Date: Thu, 9 Jan 2025 02:40:55 -0500
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
Message-ID: <20250109023829-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <20250109023144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109023144-mutt-send-email-mst@kernel.org>

On Thu, Jan 09, 2025 at 02:32:25AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 03:58:45PM +0900, Akihiko Odaki wrote:
> > The specification says the device MUST set num_buffers to 1 if
> > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> 
> How do we know this is v1 and not v0? Confused.

Ah I got it, you assume userspace will over-write it
if VIRTIO_NET_F_MRG_RXBUF is set.
If we are leaving this up to userspace, why not let it do
it always?

> > ---
> >  drivers/net/tap.c      |  2 +-
> >  drivers/net/tun.c      |  6 ++++--
> >  drivers/net/tun_vnet.c | 14 +++++++++-----
> >  drivers/net/tun_vnet.h |  4 ++--
> >  4 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > index 60804855510b..fe9554ee5b8b 100644
> > --- a/drivers/net/tap.c
> > +++ b/drivers/net/tap.c
> > @@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >  	int total;
> >  
> >  	if (q->flags & IFF_VNET_HDR) {
> > -		struct virtio_net_hdr vnet_hdr;
> > +		struct virtio_net_hdr_v1 vnet_hdr;
> >  
> >  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> >  
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index dbf0dee92e93..f211d0580887 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1991,7 +1991,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
> >  	size_t total;
> >  
> >  	if (tun->flags & IFF_VNET_HDR) {
> > -		struct virtio_net_hdr gso = { 0 };
> > +		struct virtio_net_hdr_v1 gso = {
> > +			.num_buffers = __virtio16_to_cpu(true, 1)
> > +		};
> >  
> >  		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> >  		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> > @@ -2044,7 +2046,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >  	}
> >  
> >  	if (vnet_hdr_sz) {
> > -		struct virtio_net_hdr gso;
> > +		struct virtio_net_hdr_v1 gso;
> >  
> >  		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
> >  		if (ret < 0)
> > diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> > index ffb2186facd3..a7a7989fae56 100644
> > --- a/drivers/net/tun_vnet.c
> > +++ b/drivers/net/tun_vnet.c
> > @@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
> >  EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
> >  
> >  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > -		     const struct virtio_net_hdr *hdr)
> > +		     const struct virtio_net_hdr_v1 *hdr)
> >  {
> > +	int content_sz = MIN(sizeof(*hdr), sz);
> > +
> >  	if (iov_iter_count(iter) < sz)
> >  		return -EINVAL;
> >  
> > -	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> > +	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
> >  		return -EFAULT;
> >  
> > -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> > +	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
> >  		return -EFAULT;
> >  
> >  	return 0;
> > @@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
> >  
> >  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> >  			  const struct sk_buff *skb,
> > -			  struct virtio_net_hdr *hdr)
> > +			  struct virtio_net_hdr_v1 *hdr)
> >  {
> >  	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> >  
> > -	if (virtio_net_hdr_from_skb(skb, hdr,
> > +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
> >  				    tun_vnet_is_little_endian(flags), true,
> >  				    vlan_hlen)) {
> >  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> > @@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> >  		return -EINVAL;
> >  	}
> >  
> > +	hdr->num_buffers = 1;
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index 2dfdbe92bb24..d8fd94094227 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
> >  		     struct virtio_net_hdr *hdr);
> >  
> >  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > -		     const struct virtio_net_hdr *hdr);
> > +		     const struct virtio_net_hdr_v1 *hdr);
> >  
> >  int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
> >  			const struct virtio_net_hdr *hdr);
> >  
> >  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
> >  			  const struct sk_buff *skb,
> > -			  struct virtio_net_hdr *hdr);
> > +			  struct virtio_net_hdr_v1 *hdr);
> >  
> >  #endif /* TUN_VNET_H */
> > 
> > -- 
> > 2.47.1


