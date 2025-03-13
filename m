Return-Path: <linux-kselftest+bounces-28922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1B5A5F1CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ACDD7ADC4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55926560B;
	Thu, 13 Mar 2025 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVLZfptD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB61EE028
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863544; cv=none; b=NNcKq5zWKD8EnC6os4JtDkuImyvxJ7rYnHqIyz7mdBEqY1rkX6k7tHc5IEwnTqUO1f28p0lwyoLGl8L9GB2hUNFII/2EVbLUTHpv2ypOxJQUw3xSqT7iFS0FLQlLDBqapdydR9XXTSR+MiV2cVnaePjDbhRXkD+xotVXvU4JCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863544; c=relaxed/simple;
	bh=37LJNif6aGyyhlJh5h8ixFPgluvePWafJrCynYtE1IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU+jtQuPRhTCZ17YDXaRrkh1c2UiEp5ML2XFXeiGiH+KUzb8KtGLzygPHcq6WvaVgtaSLjNm0Yt0zT1sfeBxXd4Ijej71Y3jEj8unYCp++AGyYopDKyysARQQrYNjyVntahoXtVcAsQHKuufYDnl6Fj7D5B/NT1hNH3ofq8yV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVLZfptD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741863541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8+KGKdJ4EK24n18Z2V3Wf8YYaN68pwFttwmHD5FeXs=;
	b=iVLZfptD+pn64iyDSyI9HvKJqVIM7VARZHxcm78tK7bXK16d5pvAEVqfSAZ+i/8WL45NFP
	aPWFUwTjTeAcgfyqPAK6tfAFSlncRiHt6fnRxCRDA0tfz23QQmF7w305BVYFt5RPOx90Nj
	Aay6tMPBv48kV7h3ux+IRm/SmWV6868=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-DPMu0T6fMEGXivj6XcD0pA-1; Thu, 13 Mar 2025 06:59:00 -0400
X-MC-Unique: DPMu0T6fMEGXivj6XcD0pA-1
X-Mimecast-MFC-AGG-ID: DPMu0T6fMEGXivj6XcD0pA_1741863539
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so3983735e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 03:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741863539; x=1742468339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8+KGKdJ4EK24n18Z2V3Wf8YYaN68pwFttwmHD5FeXs=;
        b=MG3UjARt/h5Xnud8WWkTBhagoeyUYqZBAEeU/i5uC3KLdoEktRSfAOGoOvc8V6ZIOj
         FSLAfjLzXtsrnpcVintNwuDq9yP94kwZkNKD7UuWFTBJpjrHcapcywi6X42PITX0Q/nT
         wtwFSSMoWwbwwqij7teFijQYxPy056hLjfEL4UyaPzyQXTcCBXXgtqFo8wBI5kLh3jSv
         695OlXboBiCiM2j7hwuXwT7/EL8UapiYT//wKMrNSivlt8c+PIbavBAwWlxQVKSS0yeC
         kINi0wrGOUAXoYot4YRoARB3MbNwDb6lxU7CS+TKg2mCtYIkF3oIthnCa+d5fgKR1nEj
         lc2A==
X-Forwarded-Encrypted: i=1; AJvYcCWz0neXeZSscyF2vNYl0hyL2q0h34x53jfEHQsN4rvEhZ/V2/8dSM40R5/rlc0bQgAaMViElc9BXA7SWJXrsQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDnrNLGXsXKXBzRdXcLI01XS9xVezJqpfLJaz9BAgVjGqnBLT
	lKERkEhWWFRl2wbulKMGDicx++m4kHDwMfzjl/m+Al8J7tQTgWEB1cPMm5pFOqh8ut6FLWobVug
	iPjiGNuWsuol5sFdgzKVvjXnGJ9BAN3Kx6JNoXTMqlnulCiLp4Nmq8qr3gV4zJIROGA==
X-Gm-Gg: ASbGncsvdlxBA/1NIgoJ61xDz1ehj4aNs/gDaSmHdXBo+LZd1yvcZ2eQWmLr+dwGKpt
	WhvRPaQuBvIayMIGIt6KM+4bovJexPyowx5h7N2chAplAeVx8vzmKKgBaiROp30LysnvdmiSByV
	eeoFV0KQUIt/NSzjio9YPnk78ZhYlvgpqFnlPGVBXuefmaCKnVYQuArMTjtiuXZS2bQdsJblsaT
	C8V50dXSCya+zPbr9B1CnM6sxdhwwtKKnZqG3TIRrr/CPTeihFbrn4NUtQ9+9td2DtJCxeAgUza
	A0WmlWGd+7cAAGMpRTqgPxreTf0aT+t7/CeomTkq
X-Received: by 2002:a05:6000:1aca:b0:390:f738:246b with SMTP id ffacd0b85a97d-39132d1cc3fmr19536600f8f.15.1741863538707;
        Thu, 13 Mar 2025 03:58:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl5a/zzB4j/bQzrh0zOYukq0rCxpL/1iN9vmTUtNgl3blwOPgCRfDtKqTKHkVbblM4clhX9A==
X-Received: by 2002:a05:6000:1aca:b0:390:f738:246b with SMTP id ffacd0b85a97d-39132d1cc3fmr19536568f8f.15.1741863538262;
        Thu, 13 Mar 2025 03:58:58 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7582absm49566905e9.17.2025.03.13.03.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:58:57 -0700 (PDT)
Message-ID: <b62ea2ac-aff3-4a00-bc3a-960c28bc5522@redhat.com>
Date: Thu, 13 Mar 2025 11:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/9] net: check for driver support in netmem
 TX
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-9-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-9-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 10:40 PM, Mina Almasry wrote:
> We should not enable netmem TX for drivers that don't declare support.
> 
> Check for driver netmem TX support during devmem TX binding and fail if
> the driver does not have the functionality.
> 
> Check for driver support in validate_xmit_skb as well.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v5: https://lore.kernel.org/netdev/20250227041209.2031104-8-almasrymina@google.com/
> - Check that the dmabuf mappings belongs to the specific device the TX
>   is being sent from (Jakub)
> 
> v4:
> - New patch
> 
> ---
>  net/core/dev.c         | 33 +++++++++++++++++++++++++++++++++
>  net/core/devmem.h      |  6 ++++++
>  net/core/netdev-genl.c |  7 +++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1cb134ff7327..5553947123a0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3868,10 +3868,43 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(skb_csum_hwoffload_help);
>  
> +static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
> +						    struct net_device *dev)
> +{
> +	struct skb_shared_info *shinfo;
> +	struct net_iov *niov;
> +
> +	if (likely(skb_frags_readable(skb)))
> +		goto out;
> +
> +	if (likely(!dev->netmem_tx))

Minor nit: I think the above is actually unlikely. The skb is
unreadable: is supposed to be transmitted on a device supporting
netmem_tx, otherwise we are in exceptional/error path.

No need to repost just for this.

Thanks,

Paolo


