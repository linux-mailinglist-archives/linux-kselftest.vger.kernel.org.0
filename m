Return-Path: <linux-kselftest+bounces-45107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A6C40884
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53A7B4E706D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0732A3C6;
	Fri,  7 Nov 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQqvg3tk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm0vsl5C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB72D97A1
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528070; cv=none; b=tyVQnYWtznO3yqkF5MaYNideHJN+1d7uBVh3PIGM8ApvLUWJJcA5WmhF4BHxFGv+J4tdWI7zHqdTJLXcERk6NNRfq5X8nV0FJCp0Fyfxk5nv0p+gFGfZchFoEG3k5Mb7D2NaNj+7XaV6gDG8Cia0RWuoDjfdtbttct0/j9ZPsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528070; c=relaxed/simple;
	bh=E0TnocTKBNnVc3GrPJJgfMEfKP9Lw1C6272/2uJxvxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlTqAkYJIMACkGF/HjJuvHIyafme21LUT2tdTy4aKry3+xBEoemJ6Hkdf3zbzfNCc5Qj2+oKiiOFWNyJdhI70clkA7lzsgrMXpxP7lAeByCleqGbfTfK4F+pjY40Z+Rbx1RIX5jHWAaftVJCrAFClRA4W6XVtzXjGS6BC2rv7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQqvg3tk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm0vsl5C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762528067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNbanbYsfxulMVcZrRqggEQbgzsiO6gl6XfzX4tJ3v4=;
	b=NQqvg3tkY3gXjDW7pbdzdGUVTnuRqFkI8TYl8daUvJvJ3MA1TzT4mR5RpCj8x+1pd48dgE
	RsfsWh4OLnI/axVNBJ9YJ2twPEBk9Pe9lWWGerAySCh2GgTM14A633ws7CZV5ns7J5tQ9u
	GQ5UfX10W2g/HcwW98WeRWwjT4NlAt4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-d5Tf-o0PPiybDG8YovhPcg-1; Fri, 07 Nov 2025 10:07:45 -0500
X-MC-Unique: d5Tf-o0PPiybDG8YovhPcg-1
X-Mimecast-MFC-AGG-ID: d5Tf-o0PPiybDG8YovhPcg_1762528065
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso8715165e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762528065; x=1763132865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNbanbYsfxulMVcZrRqggEQbgzsiO6gl6XfzX4tJ3v4=;
        b=Bm0vsl5CUNg4F20/E6yTU55u9tHFD7N3uSipuotwu3RzGreI5giXAon6HmMQOf9IdB
         ShymX0r+TXCyJ5IEzNAMUewacH/9y014MQxEcCCuTi+rNOEeSN9H87q/TF3Ddp1z81ig
         3fisG363aF+Q3wgz+cyqBQlJYJZt/iyJyesiA2VCM8a6JdGO5xqK7rnHsQnpzqFyitya
         MSitm21oXZuHK1JcTrMRFaNVjDFNFEZYXlwML1hC3VrD05QNZ9NZxvMZ/3GhJhUp0moP
         aL0L56F56VUt0dKf7TUlDYZsL24TggPde7EbJfdgbCZD4yoVq4C65z5o8O/mf1uW1X4B
         ks+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762528065; x=1763132865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNbanbYsfxulMVcZrRqggEQbgzsiO6gl6XfzX4tJ3v4=;
        b=NUuxiTCNj/ySCEWoqEYmosZYTKvhncKVmFLthkrXP0NHjZoMFkaEQ+pNRInrpxLHuv
         g9PFg+7D/bozVo1VFQEj+LoGm92CJQSQ8dpyJlghW9fUi/0XdXxMTGWTsG03hBDMMpqt
         hMiTkoSK7mdUbsrq5cWt5uF9Ty3/ggjplZFD/QD9u8iBmdt9YsNu5VblwYBIccYZPoSU
         EzRiXMxs5fYQAo9P+Qewn54wIw1imnfCGW/7A2ZsbgBiUK0apee5WyAMNdBGtuo4/2sZ
         T+4VZQJB4FM08CUSs9UHCeCwyFne/YIT/q3H/zJ/v1XMacMru2TvR75+EZtMqFPTZ03g
         UfwA==
X-Forwarded-Encrypted: i=1; AJvYcCVn2A+2+z6AuwIn6gANSfrsT2ScKv7c99atr6HXloF0CT1a/WxUIGK2ZyUVnOdurY1xm+UDNL0PBRsMXOLMe7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2jfVg2mMYLgNJt9w9uMz2vZbZV+ZrKil45A+/86oWsqN2cfr
	WP/RLsK4o3KRIXkV6lEccjrWV4wmEpZXCgjX8rCNOL1ckoK+VO7WQNmG5EWbd94LzxW2SbA9NW1
	bWvmdDsEYf0+3eXCvCjli3+OffZ8GGVTmhFO1toyWh90oXjiHMXyM8RQCQz6fJO1NcOuOtA==
X-Gm-Gg: ASbGncsGSV1D7SscXtFoaUgyWqDW90Z9EmuH2bEeOABbHVL9v8F74O9etnp2vlZXRzP
	aN8n6kJHl//8JWrXp/u0q0IyxdtevoMXvkPN5lCragUlH+sNNvIFm7Gm9LJt9nVmNYpXwNvZ7pK
	BU53TtJM9O7UH4sTLpgQpGMMW4m59n+h8xmfuVkVIIbPskxvcLb01J3EsrBrjhiNDHaG8JJf0N/
	hUhhiKpP8YAIoME6AyXt5wcU9IoMUjLCyITQRQBXymaSujOQdgKapfG64NO0U/xrhSuTrxSFMBh
	RO1YL0ZhwM8GsNfLNpQKg3YhQEAn3yFveZgo9I26oW1tlDf52JOQa9TsMdNDzVVhxebCFxXS82Q
	ormA0ziuErV5/ES9YUlGO9f2fIXT/QWMd5hiZKBNxaSEB/dvkUzk=
X-Received: by 2002:a05:600c:1d07:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4776bc903e6mr26789345e9.9.1762528064579;
        Fri, 07 Nov 2025 07:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQNTjpNs4/UNPykir5Jo9cymIZysqFSvPmuq5540gA8Si7EGD1eA8R02jdPEwY06PLdnTMig==
X-Received: by 2002:a05:600c:1d07:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4776bc903e6mr26788905e9.9.1762528063975;
        Fri, 07 Nov 2025 07:07:43 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm69515455e9.14.2025.11.07.07.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:07:43 -0800 (PST)
Date: Fri, 7 Nov 2025 16:07:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <g34g7deirdtzowtpz5pngfpuzvr62u43psmgct34iliu4bhju4@rkrxdy7n2at3>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
 <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>

On Fri, Nov 07, 2025 at 06:33:33AM -0800, Bobby Eshleman wrote:
>> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > index dcc8a1d5851e..b8e52c71920a 100644
>> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>> > > 					 info->flags,
>> > > 					 zcopy);
>> > >
>> > > +	/*
>> > > +	 * If there is no corresponding socket, then we don't have a
>> > > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
>> > > +	 */
>> >
>> > So, in virtio_transport_recv_pkt() should we check that `net` is not set?
>> >
>> > Should we set it to NULL here?
>> >
>>
>> Sounds good to me.
>>
>> > > +	if (vsk) {
>> > > +		virtio_vsock_skb_set_net(skb, info->net);
>> >
>> > Ditto here about the net refcnt, can the net disappear?
>> > Should we use get_net() in some way, or the socket will prevent that?
>> >
>>
>> As long as the socket has an outstanding skb it can't be destroyed and
>> so will have a reference to the net, that is after skb_set_owner_w() and
>> freeing... so I think this is okay.
>>
>> But, maybe we could simplify the implied relationship between skb, sk,
>> and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
>> ever referring to sock_net(skb->sk)? I remember originally having a
>> reason for adding it to the cb, but my hunch is it that it was probably
>> some confusion over the !vsk case.
>>
>> WDYT?
>>
>
>... now I remember the reason, because I didn't want two different
>places for storing the net for RX and TX.

Yeah, but if we can reuse skb->sk for one path and pass it as parameter 
to the other path (see my prev email), why store it?

Or even in the TX maybe it can be passed to .send_pkt() in some way, 
e.g.  storing it in struct virtio_vsock_sock instead that for each skb.

Stefano


