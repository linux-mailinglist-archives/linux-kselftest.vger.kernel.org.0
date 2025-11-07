Return-Path: <linux-kselftest+bounces-45047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BCC3E17B
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 02:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1726188B8C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F002F0C48;
	Fri,  7 Nov 2025 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw+9SazG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD120322
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477774; cv=none; b=JnGx4zaZwyzfPTPotoosmngV1PtzoW3oz1BQJgkHPmJcFpW7U059JF5rG3i+mZ64QP49NsnBgc4SiGpJyxWLqbZzYEY+/Wsigzc+PmqlrQi4keIDp3H/5s+xkv5t2J2tqbUZ24IeGfjBaoBa7hi0iaEg+bfi66QmorAcOcQkJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477774; c=relaxed/simple;
	bh=y8GsXoMpZfP1FEGzB5PcqGcDnM/GiApM178nf5o2DdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giFxpG6R6QLKucS8K6uzPfI928xiV8Nrb+q6Ni2k/AyhKFNlZ/SdIIBXg7ftXoHBjJMzSLgGfjfWlqrTJdp8zMWSmuD+fXiahOmWVwPRzVb488zAcM2Gmh+GqSxv08ceKcZhvBImxir+PV/Te5VoN9FhrBhNywqD/RRWd/7S700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw+9SazG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787c9f90eccso341617b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762477772; x=1763082572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvUJ3GAHgLW25cDlFG6h0rQPjnjrIg13OTjYu0f9NLQ=;
        b=hw+9SazGttaxASXszZn24cyY93Dgqbzee8SAZxh+YnQgF0OM+q/iDtOe02Uvp/p5Fe
         k51csJHvzBG006UTm/luMvEFtKOGH4azT1UnlZByYp4K0VH/3A2wZVJyX3F7wp9/gne+
         bSPlgyM2wOwSyJLQmi8tLjIowuDFAYljWRuOGubi/6LPjZZqkNApWnYXSjxMtEUoUJQL
         MHUn56SUjdMvwTK4DQGvHQnrtqA5nYegiwRuKbaWJlQKbeyUrMJKxI3W8hAXzPpEghdZ
         8ycZ9we9manbmrrdvRYNDHxYsBweWKyHvj07jRQOtAbfFSfhetvUCwWfJMY91FEaKpZ4
         Lp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477772; x=1763082572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvUJ3GAHgLW25cDlFG6h0rQPjnjrIg13OTjYu0f9NLQ=;
        b=qCehNt67QU4X4b/13dWJ+6fAUaoz8MFtdyNliPb8kv10fPyx23ChtWFPzSNAF0mBXE
         W596LZF0x+7kIm01DcryzzKa7fidLT5caMwYlnX9p8h2d4Z7yfviPZQT7+lTRsQUKUc0
         aDLvfaj+Vzyv7TbgFUjc2R+cRFrsI0hftgDZgElvmXo9DaD69u5wkeT+Rtras0+eqUmQ
         gYjR1zogCpvHJCh122H5D3GcMYikCypLzsmWnG7IYMj96SIJI6n8AP5GJouRGciuuJP+
         dqsw7Sx/tgCSR+gPXPwL5r85r00yq6Yh2GLb1zF7IIM55IFt5qCTBecme68x4uknj5YU
         omIA==
X-Forwarded-Encrypted: i=1; AJvYcCWP2ARZ6ZeFmBkeEbuQc6p61dP/JAinv0e0qQnuEvv22jAhRWFxOYDWA0ezp39WdZDf5pW52JIO88yC3Drc46I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyA8qQj1QPaV+vaskMwTN8SrjpUh1a9FyShtKDaWI8YArZ4qoU
	xcS1Ae2Ck9TIpB8ln0oxpIMHRuu89HBedvxHWwyUAt3ZuTvj5iCe9Ite
X-Gm-Gg: ASbGnct5WMO+5yB82iXk0l/QX9Ru1YMMnVrJ6mLV2w+k7fkV6CwoKGL+pDXTg9uE16a
	nyY3AosVYLhHjGCcz+3VhspK7e+7r1Og9esqrtXOz4pTbb7JAi1k985eWTt0KWxjKZnouBErG6K
	m0V4K4i+0En7+EID/bsddnOlNLTynavWMX/qyR4wbHeEMZHuWIowlhxa5wDTeGG874lXB7zL4tR
	44DZys/dGLCLEpnRC5NMvsyPdZOFFni73uWtC3gRTqMwhJGpAIA9laN3EkfoZuryLs31SzoEuAp
	/pdTCTK4nvWuakaIVZoPqT4UWTPXkPy++hOYkMcTJ1mg685TCZ6jqaKU2mR5Z02Bl2XkvsEqFyE
	bAsSgKrCrCLkSY72Ep2M8iPdMqFPjdU5zsNOW/Y0NS1LS79WNdjBXjgnq8plv9GOEvy8aVMR06p
	houPaIPAxZbr8iZLqIQyQF6zbuK+FgHF1t1+Nr
X-Google-Smtp-Source: AGHT+IGIiNSL9xH9R1nGKHm9qDA5dUwel2Gn4NDFwi23AY7T7XKy/BbtnkHOptWZ8jTsfq60FDuFzg==
X-Received: by 2002:a05:690c:6808:b0:786:a817:77a0 with SMTP id 00721157ae682-787c5346349mr13381347b3.31.1762477772177;
        Thu, 06 Nov 2025 17:09:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b1598d0asm13031717b3.29.2025.11.06.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:09:31 -0800 (PST)
Date: Thu, 6 Nov 2025 17:09:30 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 01/14] vsock: a per-net vsock NS mode state
Message-ID: <aQ1Gyp87UYnr/VAO@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-1-dea984d02bb0@meta.com>
 <iiakzdk7n7onhu5sncjd7poh5sk34nrtvusbiulsel5uswuekv@p2yzmblg6xx7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iiakzdk7n7onhu5sncjd7poh5sk34nrtvusbiulsel5uswuekv@p2yzmblg6xx7>

On Thu, Nov 06, 2025 at 05:16:29PM +0100, Stefano Garzarella wrote:
> On Thu, Oct 23, 2025 at 11:27:40AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

> > @@ -65,6 +66,7 @@ struct vsock_sock {
> > 	u32 peer_shutdown;
> > 	bool sent_request;
> > 	bool ignore_connecting_rst;
> > +	enum vsock_net_mode net_mode;
> > 
> > 	/* Protected by lock_sock(sk) */
> > 	u64 buffer_size;
> > @@ -256,4 +258,58 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> > {
> > 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> > }
> > +
> > +static inline enum vsock_net_mode vsock_net_mode(struct net *net)
> > +{
> > +	enum vsock_net_mode ret;
> > +
> > +	spin_lock_bh(&net->vsock.lock);
> > +	ret = net->vsock.mode;
> 
> Do we really need a spin_lock just to set/get a variable?
> What about WRITE_ONCE/READ_ONCE and/or atomic ?
> 
> Not a strong opinion, just to check if we can do something like this:
> 
> static inline enum vsock_net_mode vsock_net_mode(struct net *net)
> {
>     return READ_ONCE(net->vsock.mode);
> }
> 
> static inline bool vsock_net_write_mode(struct net *net, u8 mode)
> {
>     // Or using test_and_set_bit() if you prefer
>     if (xchg(&net->vsock.mode_locked, true))
>         return false;
> 
>     WRITE_ONCE(net->vsock.mode, mode);
>     return true;
> }
> 

I think that works and seems worth it to avoid the lock on the read
side. I'll move this over for the next rev.

[...]

Best,
Bobby

