Return-Path: <linux-kselftest+bounces-45969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A985C6E286
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E038D3561A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4084353883;
	Wed, 19 Nov 2025 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAxaz9si";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a34AVZsN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526C352928
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550283; cv=none; b=Dq6rKK4j7mel7ZlkQXzHYZ1Ml1emiNWBoUg9zmODNM49i3ZK3ys5Ic8mg/a6KcvFXcDzE3UksK2ROXjZxELUqn1fD6hGE03p5KW2gxpOFqz62buUCleWszc4Guga4khuxqH4t6gFqyK7wuW+x5WbMEKhXFVulg/68TduVZ1KxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550283; c=relaxed/simple;
	bh=QJRpxNJ6nM55oUProzvGLMXrymnGB0HzC7vMJLxqOVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCYxBxJSIrs5YGNJYL4BMo4HOJA3eaRBkGX5vMH1rAVCbxUpBp0jK+DmAYHdS46kJixNpileuPH2IKbSHVkLaoPxfaLfaH1+j5SZ5sJJo12QzR/3LO2ttC4sjaYEAJ2o2gzxV5Qq5hr+N9ityltQNf1QRoo7HjmR4JTIItjgEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAxaz9si; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a34AVZsN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763550280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
	b=XAxaz9siEu3dufMJtmuP2Lkb8OtZenxaH9Ko5MrLjkpsJNqwEpli5c/qSu5vUW5ZFqRrKR
	z7IcJvqDdtkpB/S0pmp8ejyHHLH9Nrte5J03RX7sgcx69Lrrb8Mm9NiJMby06Nj7gu1tXT
	fQIIl68vG83Bjh5SNp1xy8IP2ATt9k8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-0EjHCVs4NAyKm9H2gF2nUQ-1; Wed, 19 Nov 2025 06:04:38 -0500
X-MC-Unique: 0EjHCVs4NAyKm9H2gF2nUQ-1
X-Mimecast-MFC-AGG-ID: 0EjHCVs4NAyKm9H2gF2nUQ_1763550278
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8804823b757so21597976d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763550278; x=1764155078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
        b=a34AVZsNXjM+XWUSGb+JUGfhIezMxetxPfQJ0LdxM7JD1Gl+NCL5TmaahNwA3W51ns
         /EaCg9C+LnFwmXWUyuQ2u/ddDQZ3Y+1dHaj4amrNQcxJQ/ky7nJeUoGMTAsHdzvbLFpy
         t5TW7is2qMykSe024ldj23RxSkrKEUx3Bjrz7O54avbzCBWBc5JsMGjG7C4XNsARb1S1
         OeM7bIuYZlkofsxLfG2rrWrWyGuHCPSGYysxJtoijUYtYMupPQTXmtvRl9VwLAsga2CY
         HZTki6YU50vGVV/0wYNFdWStCDWEzzWEnY/ZaJHzuontkR7MRF3EcBhKTaExzUV08q6C
         wZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763550278; x=1764155078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
        b=nR2p25QqXtVn9pUzfCRh7aWH/JJNzeb4EVKubOaqywKI6WxeoOmBlCNwgJDLixvxkL
         z/tHH6Ks83zbZCHKGm6JVe+P9ngVHemrfZVqy4Lan0GLpSQfewxullilhDcJGfYM0XLo
         J8+fOr4TgOBUaJVyZo3ASDPTyKhHJXCVJvjb6J/Az1FTr54sGM1fHGtggS66CmYydSKR
         snP00XzQp+IJ7y/M5ZMXJAJRWJ7ZBo36k8nWVII6UF/nw/JM63mCQNrmQ2qN5fEFWxaV
         XNergXyTmKdhUUlgGN7Hd4RSwiXGhRMHHj1rW6Lgji7XPRmS2y3UTTA78/2MvOOLJOuv
         oq0g==
X-Forwarded-Encrypted: i=1; AJvYcCUtZJmGPd6GJP4IT/JmXs/RcP0B/OrSt9fGU7XXCR6/lBS5AyqWDt5rTvBLXbQDQoaifsc7II37i2Qgd3m7Xqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9beevZSlWJJ3iOBy9WP8lmdoaw4MXVxYaoRsgD9vY53KEM5r3
	apB7/ngpwz5DgjZrewRUgNZRnRfWNo1pMXRbdeP7qqP6nt2mmmgP+vYXY5d/VWnhm2psmQXS4Lo
	WtEszKnBRv/45fUXokxf/xFiHYFIEAFc0EK0GsbXbWrvvOCMp07yw8Ut2bVoBwNbWl8Ia1A==
X-Gm-Gg: ASbGncuAZI4HQa/5U0QN9ZieRalSs+EcMOftvcL7GCRpZ1s1xbXMBUzXmGAW2JJsm/S
	yCO7hiIwyw0BPKXx13BTsy/cnhssYFiDkmQs5lbgtRYtXIzbPRDVQ4YlZmoMbMbfKpVrIYSunoA
	oi/EwiPXAQc1KEDp4inC8tCc01tuwm82ifhQIkfXUh5++A6inYQq1Q/E6ItQqJEGHb3837yRNPO
	D3RzGxiEVQfhozq+8Or1/dTndyNtLug+5gW4eHVZIe3m9Q8kOWPHc32wlVBoOopZdzSI/C/HsF9
	g6rPY49X0B45mY/gVevTbSB4TTMveG/WFT5qh72quDof5bBJ3YkV5sISbwpkmdWMJOzXRs96jG9
	0ufD83sqadIHX6Bo5SsmVJcc6QhmgA2Y24eZ9ePY2LlwmwS/TJp5h6bKIooojTw==
X-Received: by 2002:a05:6214:5e88:b0:882:760e:822e with SMTP id 6a1803df08f44-8845ffd1671mr19256006d6.2.1763550278385;
        Wed, 19 Nov 2025 03:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUx18S7QU3TAKJCuch0iU57e5cRCXq8XDSG2cx+/NGC5m+qevE8BVa0OMVsBGaSQSjDNVFOQ==
X-Received: by 2002:a05:6214:5e88:b0:882:760e:822e with SMTP id 6a1803df08f44-8845ffd1671mr19255436d6.2.1763550277970;
        Wed, 19 Nov 2025 03:04:37 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828613962esm132823926d6.0.2025.11.19.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:04:36 -0800 (PST)
Date: Wed, 19 Nov 2025 12:04:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 03/11] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <tfrb7l3cguctjl5jbd7ykon4aqav4ognxndtnohs7ukmvk7wkm@tpaaicknwwhq>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-3-df08f165bf3e@meta.com>
 <vsyzveqyufaquwx3xgahsh3stb6i5u3xa4kubpvesfzcuj6dry@sn4kx5ctgpbz>
 <aR0arw2F/DmbIrzY@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aR0arw2F/DmbIrzY@devvm11784.nha0.facebook.com>

On Tue, Nov 18, 2025 at 05:17:35PM -0800, Bobby Eshleman wrote:
>On Tue, Nov 18, 2025 at 07:10:28PM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 17, 2025 at 06:00:26PM -0800, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

>> > diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>> > index 7eccd6708d66..da7c52ad7b2a 100644
>> > --- a/net/vmw_vsock/vmci_transport.c
>> > +++ b/net/vmw_vsock/vmci_transport.c
>> > @@ -2033,6 +2033,12 @@ static u32 vmci_transport_get_local_cid(void)
>> > 	return vmci_get_context_id();
>> > }
>> >
>> > +static bool vmci_transport_supports_local_mode(void)
>> > +{
>> > +	/* Local mode is supported only when no device is present. */
>> > +	return vmci_transport_get_local_cid() == VMCI_INVALID_ID;
>>
>> IIRC vmci can be registered both as H2G and G2H, so should we filter out
>> the H2G case?
>
>In fact, I'm realizing now that this should probably just be:
>
>static bool vmci_transport_supports_local_mode(void)
>{
>	return false;
>}
>
>
>... because even for H2G there is no mechanism for attaching a namespace
>to a VM (unlike w/ vhost_vsock device open).
>
>Does that seem right?

tl;dr   yes


vmci_transport.c has MODULE_ALIAS_NETPROTO(PF_VSOCK) for historical 
reasons. This means that the module is automatically loaded the first 
time PF_VSOCK is requested by the user if af_vsock is not loaded.

This was the case before vsock was generalized to support multiple 
transports and has remained so for historical reasons.

So today, we can have that module loaded, registered only for F_DGRAM 
but not registered for F_G2H and F_H2G, so maybe it could work for now 
and if the H2G is also not supporting it, maybe is the right thing to 
do. (with a better comment there on the reason why both G2H and H2G 
doesn't support it).

Sorry for the long reply, maybe just `yes` was fine, but I dumped what I 
thought because I feel it might be useful to you.

Thanks,
Stefano


