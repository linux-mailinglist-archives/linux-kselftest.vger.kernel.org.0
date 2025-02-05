Return-Path: <linux-kselftest+bounces-25865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B59A29BCB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA311188828D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F6214A8E;
	Wed,  5 Feb 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjZhBnVE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B82144BE;
	Wed,  5 Feb 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790516; cv=none; b=FlPIHL7qlkx3RU2hciqKg9nkLbdGYQz6Clo5YosXEHSBfRp6mIn0uEEEZOmAPM3befosDH11ZzWSFqSuDcpIuxPYtrrdWzSIqo2bBRSi5YcuPSWMNJSfHqB6t1FVyNAZBCrqWlMx2lnH0Hie2t0NQtJRcN3Sw+pGv1HOa5qn028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790516; c=relaxed/simple;
	bh=nEesjhAuTJziUxYVq7v1gWdsPVAbJrLdrW6QwCP71vM=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DW/rTywRnkDIh7JvQP0seAY0EWIGZ89X9EbnXfKoG9GVpQTcEKno0eUDupKSV0prSYj/ldd67q58NT4Z0ZTSgo2NejHPJfqxCEYvxO768asmJxbMH9BGaiKisCcl/qmSxPp3jyfhPaKSbV7DWa6os61ol9Aoy6Z9qD150lzJVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjZhBnVE; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85c4557fce0so47801241.3;
        Wed, 05 Feb 2025 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790514; x=1739395314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA59/b0HqiTbM3mdKAGWxKNjJnBpzxH7nv45X6IYWmY=;
        b=VjZhBnVEL3E5tVFSPq0rvsF50L4DlbE1QAotoBrWaLz4H47k0Z7F7QTlCiEQZufVJX
         hovbdqQbA0JICssqW91Ks9jD9d8m6J0S+il/5w7H0vbpnwyHsqRxz9JaVlTYic7btS7a
         d0DTQKBVd1EL7o8LVRUVweEdeGtc13ntvBA8yRkGVl+K+0aDUjlYWPlgXo91ZVidvifC
         K5qBOIPz3/m2yTfvoEKF756ykco1JLmtqmFQiatLJfsHOc6/6K2yxItxstxfWOBBkIZD
         2X6qv9TsL1QyUeAfup8+iLav25CmH3CkT6BplkEBUjTQqCgL/FdXhIlHvGj4ipRAh5v0
         MIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790514; x=1739395314;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA59/b0HqiTbM3mdKAGWxKNjJnBpzxH7nv45X6IYWmY=;
        b=DrS+ZR5+q/R3SVocOksICHvld+q65PJjufpn9a4Ndx1UisiAlqBpxmsXWBU1K8/xXY
         gFazpZoLZbNTRHd9+Jnoq5Yw4AV25JfLci6orv4rIS+XfzF+lL6Ijxhlzd+F7HwTOPGe
         OhdVyLrS4G/Oke6wGAI0TrzDklL6QEMJTWG14B2UhKvNVkPSf6l7Un1/ysY6BJCfG6EK
         5D4hSpJd+/Zio5Pyuf093X01V+UBfP2YG2pxNUSOfv6RApX+7IANJkjKlOMp27zGkePR
         ar8pFiqOG+PJYQM0sapr0HzsINmrEGkgss/67Z5yw7GhYQEAcTpkaGt4SLUAjVgmVrAM
         sqeA==
X-Forwarded-Encrypted: i=1; AJvYcCUFgb1n+kWhnawWvmdDHTJbTOv1XJP3vp/0TG/Sv270zyIqVqvgYhPUtBnDTZXhuBiNK4562ennoEmiEGhWyZKy@vger.kernel.org, AJvYcCUbgkBPom4+8J5QTZFtfgrIynAAD10yUm9e9BtavFoXO+Eifi09KijHkX+La4nKkhUCqJY=@vger.kernel.org, AJvYcCUsMYzQIRT3HIeY8C1guvA1OpQ6gXY1tvnlOHqLxDbeZGKx01h5f9Vj+KprMbbZNUKlwQwBjP5o@vger.kernel.org, AJvYcCWcag9Y/lpwDEWXECXxdN1p0xzgm4ye8nkOBki5hIE/3B83ZZVMqv4bMUIsIUWnsEjNTPQJc2PxVM8DifgT@vger.kernel.org, AJvYcCXJzEap0qFbbkkdTvEDMiGaq4eo7t7/s86ATIgMnuR+jP9RohzWYJMwsRcatdG+7n0q27tgQyvtFmAh@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXQuWGL4a6pEk31QAWgrEvfd1qxLPlDB6U6RAlEjuqfnc3qZ7
	DEeOjmLXLA112PeN9uKS8/DH/OxJ6byxfrTEThhmm/70dE4lbSZw
X-Gm-Gg: ASbGnctUXZ2mq3N9vOiUx6GcSKxXle/JjbWYpsuOWqbZJC+ny/BmCRliPQHgZCSNTtS
	rHfROrHTlcdNd/+l9prRVVW2oF0wVecg1eDxOYu0CXbBOZcT8SVxn0bU47kxemHuDKDCSqIIvsG
	MtDYUXL9+t3dcVj6OQJ7osNOqb2Y86lcL1LMfc0pHFGQ+4xrqQ8lsyFUiDtkMdom4mMkw5pTmQm
	TiAjREJ/Khx1V4glHsHn7g6h8q1cQI6aJd13AHvqC0VGZP8OUGVrtHHPbjJ2eV2+u266Nx5DrA1
	BGsd/aLpwK2q2JT9PlMC9t+VMSWJ0DYnVT8RH+Ow7pYCe8cGiObhNHsvzUUABFk=
X-Google-Smtp-Source: AGHT+IGMnECoIZSQWPaeSS6dNPkAqETjHSQP+dcqfl8m4ZhiKsez3m+3zBDXaugCYi/i3Eptq/eBDQ==
X-Received: by 2002:a05:6102:3f4c:b0:4b0:ccec:c9de with SMTP id ada2fe7eead31-4ba47ae88c3mr3894330137.24.1738790513631;
        Wed, 05 Feb 2025 13:21:53 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baadae67sm2516649137.15.2025.02.05.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:21:52 -0800 (PST)
Date: Wed, 05 Feb 2025 16:21:52 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> hdr_len is repeatedly used so keep it in a local variable.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> @@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>  		struct iov_iter i;
>  
> -		copylen = vnet_hdr.hdr_len ?
> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
> -		if (copylen > good_linear)
> -			copylen = good_linear;
> -		else if (copylen < ETH_HLEN)
> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
> +		if (copylen < ETH_HLEN)
>  			copylen = ETH_HLEN;

I forgot earlier: this can also use single line statement

    copylen = max(copylen, ETH_HLEN);

And perhaps easiest to follow is

    copylen = hdr_len ?: GOODCOPY_LEN;
    copylen = min(copylen, good_linear);
    copylen = max(copylen, ETH_HLEN);

>  		linear = copylen;
>  		i = *from;
> @@ -697,11 +695,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  
>  	if (!zerocopy) {
>  		copylen = len;
> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
> -		if (linear > good_linear)
> -			linear = good_linear;
> -		else if (linear < ETH_HLEN)
> -			linear = ETH_HLEN;
> +		linear = min(hdr_len, good_linear);
> +		if (copylen < ETH_HLEN)
> +			copylen = ETH_HLEN;

Same

