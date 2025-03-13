Return-Path: <linux-kselftest+bounces-28905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA1AA5F13C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01D717E0E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8214264A7B;
	Thu, 13 Mar 2025 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J82pn6a9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169F1FBC87
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862873; cv=none; b=kh68GZxDI2FGE+PtfPvzINPGg8T18DNQK3jEDWvligBq3EkFQHLoZtXVMBYONXWPgTaTEUilIpL1yP4HTlk4bZOs+4tPyATR+FeacuXsFVlVK/hQVtyLED+Ke2UpO58D6d095qdFh9p5pQTMe2ZICji4PZ74pj1POFR8BTSIc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862873; c=relaxed/simple;
	bh=flFI4F9iJbigAdLeH1msK0WPNSRRKGt+NPtx2Z0lY7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlIrFjfWnLkz+8s8wf759x+Lh7yjGQylNUDLbvwHYH6K8KksJt+HMJrArbgNfa+fOf/VpEDro/dq/chF2nbM/gead1eY/nJQuz396zpDXXhoAIG75udCvUBMFdOJu6vcBXzJCeyj2gsOR5kyLqpUtkp9XunFIRLr/fThavbfwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J82pn6a9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741862870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKlH8svYGZq8nS9wIHoOZaP2tIWMcEGLEEAOkrVCTz8=;
	b=J82pn6a9BqLAFjIB07wt6XutQpavmvmdhT1GYoD1EsY6/V2YBy054F2CC35+Fpp9sFQhAP
	YjcW7mJUeGbeCNUs2nqLInIJbfgq5U9+c/itscgRhfpsa7StOn5g+DEkT9zrbGLs/Y0OyV
	onGN+fMkBqI9gsHWi+9yBPM55yr+Ipw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1nQXIUobPBegWIkdoh9CMg-1; Thu, 13 Mar 2025 06:47:49 -0400
X-MC-Unique: 1nQXIUobPBegWIkdoh9CMg-1
X-Mimecast-MFC-AGG-ID: 1nQXIUobPBegWIkdoh9CMg_1741862868
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d025a52c2so4119825e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 03:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862868; x=1742467668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKlH8svYGZq8nS9wIHoOZaP2tIWMcEGLEEAOkrVCTz8=;
        b=W18jqpBGrrSSLgkUeLRZ80YGo5n6EyXB/cTZw6IrkQsi/g6I8bMLEsiaemQkFxka2J
         SglAucNnvScPe6S7SGxA3xYRH/ZvO/Goodfc0g7VHRH1h/IQmHoLdIbw1LjQHS+RY4GY
         Fxk5DTJsNvaa1r/c6x0V5/6L0OyoSpDdQZ4Wj+nDaZkw2itJPHFgpCxnHsYwI0596/TH
         zXobKeW5/4qPrMxbCS9o7ojDIk1QACikV2rqhxv411ivelQ+YGDEsqb9mIcKl/FTHIEz
         rwAn2riwN8pWh3p0akYMCG4B+wE0fElPFOhcqPZ1zhkm69h8bPZSSFX7YF+kOm1jjXHN
         m2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAeQXplEr694cIAbH9KqxwCg4hrR9dInXg3W5t++Au5+11nQmf5f7CKAv0DTV8qta7SbYG905IVQBfl4Sb4Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJfDV4XF+IMpUSrmfEGncLJxxc1ZEHqD3GXb/+T5t48GVJrzg
	sRBmhWr8ml7hO8nZKSe8T8LycdtsgxtHwkJp7fz9OVhiiuyebzddu/wZhstp+1p7COT/3HA1gyG
	LWGdP+aFt5hKTz/aHfGPoiVI7EA1ipZzXuWzLlPHPmhiWZLdPLNShUAzkjyjjJW0vvg==
X-Gm-Gg: ASbGncvTY+DChteNLh9Fxh1X4GFhHhb2yLMGSKsEGOCS0/VQ/42ZBEu2wIrlPD8w1uz
	69EzqXW9SI8svHGJpvLaHVi86z4v5A4sJehG9YYVhdU1+fDQQOkcRYKrJJxuhqVmpv7YoOHgEl9
	1A/WkcDEoBNNUTsKKnwMDx1flo7uWoV8b8hpVtvAKJfIbtmHMBEuXmsITRf3rM3AZ/IVt8UznAD
	mKGiYhMrw8HPM6F0pSI4Fht9gfo07oZK63XletR/VnfV73xfnOaTdrTQ3eHR0q0SzdsPDJgmSfC
	B98cuc7fBincJoWl5lfZQUi+6I4YKpTnn0DfS7BI
X-Received: by 2002:a05:600c:524c:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-43d05637140mr66351165e9.21.1741862868059;
        Thu, 13 Mar 2025 03:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuof90DCs7eJ3JwItRCIRpwATmH/3XNmF4IhoW7PyjbpLbTIbp4p7z1rZXGN+i2daYNGVW0g==
X-Received: by 2002:a05:600c:524c:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-43d05637140mr66350925e9.21.1741862867674;
        Thu, 13 Mar 2025 03:47:47 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm38333535e9.3.2025.03.13.03.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:47:47 -0700 (PDT)
Message-ID: <87e8bde7-b05e-4a1b-bcef-f6bb3a12315a@redhat.com>
Date: Thu, 13 Mar 2025 11:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/9] net: add get_netmem/put_netmem support
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
 <20250308214045.1160445-3-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-3-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 10:40 PM, Mina Almasry wrote:
> Currently net_iovs support only pp ref counts, and do not support a
> page ref equivalent.
> 
> This is fine for the RX path as net_iovs are used exclusively with the
> pp and only pp refcounting is needed there. The TX path however does not
> use pp ref counts, thus, support for get_page/put_page equivalent is
> needed for netmem.
> 
> Support get_netmem/put_netmem. Check the type of the netmem before
> passing it to page or net_iov specific code to obtain a page ref
> equivalent.
> 
> For dmabuf net_iovs, we obtain a ref on the underlying binding. This
> ensures the entire binding doesn't disappear until all the net_iovs have
> been put_netmem'ed. We do not need to track the refcount of individual
> dmabuf net_iovs as we don't allocate/free them from a pool similar to
> what the buddy allocator does for pages.
> 
> This code is written to be extensible by other net_iov implementers.
> get_netmem/put_netmem will check the type of the netmem and route it to
> the correct helper:
> 
> pages -> [get|put]_page()
> dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
> new net_iovs ->	new helpers
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v5: https://lore.kernel.org/netdev/20250227041209.2031104-2-almasrymina@google.com/
> 
> - Updated to check that the net_iov is devmem before calling
>   net_devmem_put_net_iov().
> 
> - Jakub requested that callers of __skb_frag_ref()/skb_page_unref be
>   inspected to make sure that they generate / anticipate skbs with the
>   correct pp_recycle and unreadable setting:
> 
> skb_page_unref
> ==============
> 
> - callers that are unreachable for unreadable skbs:
> 
> gro_pull_from_frag0, skb_copy_ubufs, __pskb_pull_tail

Why `__pskb_pull_tail` is not reachable? it's called by __pskb_trim(),
via skb_condense().

/P


