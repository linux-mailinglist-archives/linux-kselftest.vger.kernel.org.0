Return-Path: <linux-kselftest+bounces-37357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A6B05DDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E819D3B84E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB02ECD0B;
	Tue, 15 Jul 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eg2xqcb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF592ECD00
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586505; cv=none; b=mXjWFMegkduSb3XnYeqSkwDZxP4WD4Xat8QgDfPX9QgHKHWcIZwtNYKsbtOQ8iG8rnl6P9Unwl9W+Rc6h3hu0Wl9M6ncL1PU2ULu1lh8LXSziOUdKF//vCUDl4YMBZvRcoJgT8fpUhhhvnGoQKNr++NjJNmIUYcHsElBASGMyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586505; c=relaxed/simple;
	bh=FNkrpVUP8aBvhfjNdBg9m90d8eea1ssCdQUMoWqFo0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maB0dGqKnG1e7GVBlsU38gBnmO2pnVgKHhGutO5AlHAb6MKfp1RIibMrbPSszxH3pQW/f2oWHPUT1jcJsR/Tu8YPm6algZNYd/K3/5ktsLaGF3sA6bfeBwlPbP2YnfsSmDKZd9XMNaQtLAGYmiWSDicd8mpCS2Qsi2cVUVeBsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eg2xqcb4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752586502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hna3RjrfnrkuE/vpT4GxFQWfy5w2zHOHWkjX7cFXw9A=;
	b=Eg2xqcb4oNtXckM5xZlZdI+mEgxwRMtGUSQvQKxuQ0UxdnVADeBkK3m0vM+btNu1z5kyVO
	e8JkYWIWlSoTrGfoxhkcfp49fzgpfMzPGnsIS0xIZdMOuwguGoDTs+uF8QBk5IL5GOLJO8
	UNpfSHLpYTgopsPTgu/6q7HrMA/vTzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-uUG7ZO5GNuGZqxSchPBSWA-1; Tue, 15 Jul 2025 09:35:01 -0400
X-MC-Unique: uUG7ZO5GNuGZqxSchPBSWA-1
X-Mimecast-MFC-AGG-ID: uUG7ZO5GNuGZqxSchPBSWA_1752586499
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso20014385e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 06:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586499; x=1753191299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hna3RjrfnrkuE/vpT4GxFQWfy5w2zHOHWkjX7cFXw9A=;
        b=TEirPtg5klYm3aUhImSk0UwwZFEOGDYQsiK+EltuSOa24fJUOTdeWwz4NSubCpoNyB
         ZtQRSWLjt5EcivH7edv4+TZSYIWO6E6Z5xNB2zpElrhrhCroHMqjibt1KqCAg27hz1mQ
         OEnZJWy5ANhpUZyEl+Dn+TCHqVyxkWRqb/sqnucAMHaU6aHVhJw9nUDq98vAWoqKmwpu
         2eNhr1+TPMvoy2ekVfsGNgz/DbTJ/ZN8XtPEUAXPErUQ5Mtk6OEfwEim5/ubzK1CFg3S
         cnekazE5WlvfFmJ+NkxEL62Oe8eyw+VPvGPDdB9CCRNREyR5Z6C9pCDDNkDMWGZtVuaG
         tKmw==
X-Forwarded-Encrypted: i=1; AJvYcCUPq03MfkQ8PosjhesAXzpy4ZWcdGebVoH0fx9PXShHaT7jayZO6srZXI8WuU7cvTMDwiOr90uce2Tml2pGnCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+A/l31SZbrS0yemL+O4LBBFcaz3vdw4+eQIftdbZ1nGhVdy3
	DlRK0szXsnI0+FHbxg+6nvQLKqyPZXb11mAV6m8cwVl12nKZMjx3aE6jkhfqzSzowHLG99ZqN51
	F+TZuWbVRm+J7Ewh8rO4n25c5Uf5ZH78G+VRQRZSTDbj892s0/2PYgDajFMsHTbZ4vvj1+Q==
X-Gm-Gg: ASbGncvivjpchpde+HS+SVwv/lwJBkVPL/jYz8ji3Jsu9FuqdQbM0k8T1hfpZRCgMlG
	TFzxo4ncLiT7W0e7OEvZOBZrU1u+NoslCebB/L0ACDJ4FNrFr1O4fAU7PUyqcbO7VEpQwOyM8vC
	nv1xU3Q9OOJWL43U7zaVZbpTLwu4f+hpOpq0g7hkLlfTThKzj1uJHpnCWayex9h3eMaBgDLWrUp
	+M4iNsewNp0INX4YqbduMGABUHUzD05WBGxW4ZdmKufbkcghNZuH60nfiU3Ye2mTP3qFExkrYuP
	S24+1Ci0s6QvI3lsZ1WiUGJHmXHxr4MGxbVHVAVvA1u1C7ISFkae5aPvVZzzUCUZ994XhaVcrWb
	ocyd8lZ21HF4=
X-Received: by 2002:a05:600c:6295:b0:456:58e:318e with SMTP id 5b1f17b1804b1-4562771c329mr32530705e9.30.1752586499390;
        Tue, 15 Jul 2025 06:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFLt0H3ouwQHrfzti4Gau5tDX0PXneRZR47ct1MkwMEfPNZ/zhgGSAD+eLXD1StfdRkCurLQ==
X-Received: by 2002:a05:600c:6295:b0:456:58e:318e with SMTP id 5b1f17b1804b1-4562771c329mr32530235e9.30.1752586498941;
        Tue, 15 Jul 2025 06:34:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456278a4460sm13752225e9.1.2025.07.15.06.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:34:58 -0700 (PDT)
Message-ID: <cb12d567-6654-48b0-8443-522aaddcc406@redhat.com>
Date: Tue, 15 Jul 2025 15:34:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Gabriel Goller <g.goller@proxmox.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250711124243.526735-1-g.goller@proxmox.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250711124243.526735-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 2:42 PM, Gabriel Goller wrote:
> It is currently impossible to enable ipv6 forwarding on a per-interface
> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
> enable it on all interfaces and disable it on the other interfaces using
> a netfilter rule. This is especially cumbersome if you have lots of
> interface and only want to enable forwarding on a few. According to the
> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
> for all interfaces, while the interface-specific
> `net.ipv6.conf.<interface>.forwarding` configures the interface
> Host/Router configuration.
> 
> Introduce a new sysctl flag `force_forwarding`, which can be set on every
> interface. The ip6_forwarding function will then check if the global
> forwarding flag OR the force_forwarding flag is active and forward the
> packet.
> 
> To preserver backwards-compatibility reset the flag (on all interfaces)
> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
> 
> Add a short selftest that checks if a packet gets forwarded with and
> without `force_forwarding`.
> 
> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
> v6: 
>     * rebase
>     * remove brackts around single line
>     * add 'nodad' to addresses in selftest to avoid sporadic failures

I'm sorry, but it still does not apply. Please rebase again and re-submit.

Thanks,

Paolo


