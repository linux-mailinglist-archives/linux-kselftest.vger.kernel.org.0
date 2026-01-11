Return-Path: <linux-kselftest+bounces-48676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3EFD0E702
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 10:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34A8300D16E
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966933030C;
	Sun, 11 Jan 2026 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZHESGw4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK2GgtJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927C220F47
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768122971; cv=none; b=RHfsC6PXfF61n2u0VAO4KA86aGl9Izv5hSwtjRmHUywLlfnyTgknwlL3rwRHvQaEsRKb5tJ6dPeEr7qM/SCdtoxt8PoRvU0OfovgNigmtERusdBZhrJ+yA1SF0qZmDZ9pp0TY6nLssOQNcriAuPcjZtSuzivTHxf9kXjKAXQ6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768122971; c=relaxed/simple;
	bh=BZOccm4XxVdjIcV5Tne5ceXK0NuuvIGdkFXUs4hhCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5A5DvkequBV5ZF+SUskEdFaVL/w9frnYvm/1NTj+Ncxq/hjn7H6T42J0zE7xFinGc7Tyei/1bOKCwm9ldsVjZgNptxXoGRo9XU3YwF28oYYMAhVZTOxm4lHYSJ5nxbV3Qd3XhMd/YUouO3JX991pnXRE4TUdGBRg4t3hjWnCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZHESGw4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eK2GgtJY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768122968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WS2+XzdVc7BsmtGzyRzQokn3ZRi3QBRYwnL4Qo9AS50=;
	b=fZHESGw46MqZ/BTH1GEtg6wncEo7GcqVL82wRt2A6LWNsiz7SO0Gsdlp2vGkCyapXKWOvh
	0SVUl3GUodpOPK6w8g64SxV8gb9WFo9VfoW+JKO25f3Y6OtyIJFJph8wMenkakx6xQ5P16
	8HvOhFg10Gz0KDzgh4Rv1Xq182t/EKg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-eIGv6VMvN8qftCQbtnhCRw-1; Sun, 11 Jan 2026 04:16:07 -0500
X-MC-Unique: eIGv6VMvN8qftCQbtnhCRw-1
X-Mimecast-MFC-AGG-ID: eIGv6VMvN8qftCQbtnhCRw_1768122966
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42fdbba545fso2218566f8f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768122966; x=1768727766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WS2+XzdVc7BsmtGzyRzQokn3ZRi3QBRYwnL4Qo9AS50=;
        b=eK2GgtJYRxTqI9k6TKmJPoD82wmLnI3rqB9NyUoDEHY8KJF4aliV39nsigBXoY6pUc
         vfaIyZguYN/6Kmh1oOQy7KHuj6ENMBb1EAShoq3EoukQtBH/MXgyrEnreUym8eIxjWCo
         xF9GiWFSnFmg4kXQt/R18sW3cgt8j11Xw8Kp6YiRxJH6Am4vrIUPnbIx816QBvksQohP
         P7lzmgiGh8o3mc4GpTKNTmnSfikQKqbhm1Us3YgzGH1nTiCE5qiVwlOOtsKsOKNeU/OU
         piBfJu66XJMjh56ZyzqntcvWURH6B4MmPNu8hr6mkykiN74eGI3u5oi5SeKa5mIj+a9V
         C3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768122966; x=1768727766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS2+XzdVc7BsmtGzyRzQokn3ZRi3QBRYwnL4Qo9AS50=;
        b=en9O79FSKPGM0WBY/rf3yx199FlMwH90/0TKZfILI64W4bNV2BjhUMd5wM8QrafFQo
         ihgfeZpsdYC+qbNPdyGB0LuTZs+v8yGD3lA1vnIY6RBckS+x/lOr9MLFc1HnL2V6SDGd
         OmCw7ZzidI7u7XmE/YkO+0tDtSMKYobJ4dU1vyvDGNPzalqROSi/dbn9hWgrmjHD+jEx
         sxE3RHScMR7PfTjIvFmYwxhjk9WwXyoDgiPgB0xbx+yo4IwcU0Syzzb731VVEk2rFf0h
         ay6Dh0IWKxexsd78nC7RWFzTjeAVAxvOGVXn3R1J6EfP0ooG8z6mC9NOCppSkdAilhme
         V2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOxqF4YWmCS54oq328cIG+5V1ojsRuseyotapfdOWlu8EsxRlReFDgb/5IB5a4QencFRWH0hdYLS8bDjIc+NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rX20ChEk32qy52eE2Ux6MQJapIxGoK3v91VYtqfrbLtAXDTK
	JZRIXF9Dx9BaeXDLDTo2SBbsESRxr5ex/PeK/W1J3E0yq3CFSPrEJMitboY0HCCvSyew9dYjTDY
	AI2A3jjOqwAymtQ/lvV+M6IaY+N1edDBYe8NV9hYea0/EcZU9GqbLct1J8S77bTMO+5UrnA==
X-Gm-Gg: AY/fxX5FXwYO+/bl7jNwLhID+XzpdS3p150R2V3k7z8q4ZZRnJdysJmXoAGJR5u+apW
	jLANoN+DX7U7FPjXFuGGzvZNBtohBza5K28ald1T71FVjNn3Hz1kGtJWcHKFy9xmO3oz02Tqnkm
	JM9vShJ9b/rnV8uKOYuIA+rUy8MBG+7cPRsv9rvnQaPsUKzvnKtHOkWwyuuiiurdjuPzlMpXmOD
	D3j5NPo6Y5+BSGRsEjbE3qJFXbdSrgyWp3Cxo0KFJilnSZk3VoqTVQXg36fACa/moqi2spCzQLE
	ir5VeTzOY4m1XABegLHdkHk75wApzuVtOjhsqPrrliE18OEOdWDTFQ5vsFIAmHP58EDo/khxWRK
	zuLiM3etiFlQBfbSX+ZtbZ8tg/ghJBgI=
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr193215365e9.0.1768122966059;
        Sun, 11 Jan 2026 01:16:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1T4RKFHLydRXZSk4hv5pRkHtZL1MUAZhZsWSp+woZTG55Ip7dDXQ0exZCHM77fG+sLNTHpQ==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr193214965e9.0.1768122965611;
        Sun, 11 Jan 2026 01:16:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e13bsm296398485e9.7.2026.01.11.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 01:16:05 -0800 (PST)
Date: Sun, 11 Jan 2026 04:16:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 02/12] vsock: add netns to vsock core
Message-ID: <20260111030617-mutt-send-email-mst@kernel.org>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com>

On Wed, Nov 26, 2025 at 11:47:31PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add netns logic to vsock core. Additionally, modify transport hook
> prototypes to be used by later transport-specific patches (e.g.,
> *_seqpacket_allow()).
> 
> Namespaces are supported primarily by changing socket lookup functions
> (e.g., vsock_find_connected_socket()) to take into account the socket
> namespace and the namespace mode before considering a candidate socket a
> "match".
> 
> This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode that
> accepts the "global" or "local" mode strings.
> 
> Add netns functionality (initialization, passing to transports, procfs,
> etc...) to the af_vsock socket layer. Later patches that add netns
> support to transports depend on this patch.
> 
> dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> modified to take a vsk in order to perform logic on namespace modes. In
> future patches, the net and net_mode will also be used for socket
> lookups in these functions.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---

...

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index adcba1b7bf74..6113c22db8dc 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

...

> @@ -2658,6 +2745,142 @@ static struct miscdevice vsock_device = {
>  	.fops		= &vsock_device_ops,
>  };
>  
> +static int vsock_net_mode_string(const struct ctl_table *table, int write,
> +				 void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	char data[VSOCK_NET_MODE_STR_MAX] = {0};
> +	enum vsock_net_mode mode;
> +	struct ctl_table tmp;

nit: this file should now include linux/sysctl.h for this struct definition I
think?


