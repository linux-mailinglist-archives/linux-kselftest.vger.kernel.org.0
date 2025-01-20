Return-Path: <linux-kselftest+bounces-24785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79727A16B3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096891886C30
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AB1C5F25;
	Mon, 20 Jan 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIKprOX1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394433981;
	Mon, 20 Jan 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371259; cv=none; b=U+PRax0tax7DNXZXnbWLZX+lJyKi2/kOkfMbxH2PTyBSZrAVLO/OBB5msZ+4s3kxfmZUYeaTfF+hUmaRuGGo2VvjQlNtHQrsCdcVQmlpDiBVYwoj+OtJFgvq23FrIVFmApQYELkJlTq0D0UsV2+irKAiZbQC7Pws93wsppQrmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371259; c=relaxed/simple;
	bh=NY8xOSTb5H82+FIEW3G7ByzU+dpqafjZ58KpUcTCBIM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fPbKqgsA5Qp3auWXi1hSgQj1ywWkjb3l0jaloZvu8Uqkp/7bVlR/5y0WE92vBbMVmtsCNyDjbkqW2DX2XKm0XcTd+6ikNO2tv9W5bfHjGbwiCHfG2GsstgRISz6xMaYvmHEnL1w/Mrv4zCeDQbjXvealaPXKV0xvhFIohqMrHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIKprOX1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a1ee7ff2so37797951cf.0;
        Mon, 20 Jan 2025 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737371257; x=1737976057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ6K6nvdOyUKshD5noQZW6cAKo0Nx9BnvWyFQDdbnYI=;
        b=DIKprOX1TSVhLve+MrzKRiIxbXudZrMDML1z2QSdh6QoIbumyDFeO8GXM/fSHkE0Ia
         nKRr5hjULJdzVfHDj8Xyezzuafy8cL9+depjsE8Y1XQGClIrN+ei7GfLN12m2mOC7yxO
         l2bddC7hcAUoMImBU7ip+AK0jEjCVbW0c/bcpQIqE+AjLUWl97Q5Yqp59puCX3Zds2tG
         4PJ84A31idBN6BzwuOTBCIo8MvUQHz7YfL5Y4z6EUVAtO5cYsfUUIH2ZvIL1i7Hgk2kk
         LEBU+knAHrCMtfwQ7MJFtjSpTTXUkzpHaGJA/F/Kt/p9YpPDLT04kDZDaeFcYMbG3biw
         TNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737371257; x=1737976057;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJ6K6nvdOyUKshD5noQZW6cAKo0Nx9BnvWyFQDdbnYI=;
        b=QucVmq4mLz4heQW89EQjRBx/+o96SDiUxGNTZdQoukZd0Z1QsO8KUwHZothV82lTAI
         YCqzrXFmibt6YiawxptLFZSbDuMmXNuZDYj6XIysJU54fVxgOvFLF3Z2HDC/UDG2qWrF
         r9P5/G1zj7Bwza2WOEbqrhQTYaKWNd5Dzr3tVtoLT83ae/5XWWxKopibWP+tkn9cQ2VW
         53IfjqzXjaYOTvPKealk+5SXlebywAkjMrVeIguRdTS+7EZw8tmefQhqw1Pwt4oR99vJ
         /0OxvEHp5NqbK41eQ6gEX7vAVypIWIu6Izpl4pN8Qz4G6UNtwWyPk97k7MoYxMKrz/t6
         DmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCULmBmKBkk51/0lnbCxR83QPrC+pou68GokdcTfeI9yFBj+8TzDzaAGXw4dtMtkPLchrqk=@vger.kernel.org, AJvYcCUmjO4NF1OK9zCIpyT7G9QSNqeGZXG5B6El8nDIQxXyUniHptjPNj8Ne18tm8sg9sQ1gcgmg5D4mbBbramE5PsI@vger.kernel.org, AJvYcCW6LL4Rjc68VASwy1Zu2oyZji2s+n+pt1e6XwOCQimxLG2hjxmubyUpBwj7KpweU3erYxZnSSLI+69N@vger.kernel.org, AJvYcCWMUnnrDKUCgtRnVj29DacbltYe7nNSpzjdT9PTWV19x4ertsd9rk+CcoEHn4Vbxh2F3+4R/Tai1ggxpFHr@vger.kernel.org, AJvYcCX3nrZ5V3mA8sHJkK/sTWxnRergGIl6x/B1cBi6FBbAm6A6dr8b0WfS7njIso3QpjBc+7lzv0Np@vger.kernel.org
X-Gm-Message-State: AOJu0YzSj6gswJVJVDYLS+LwMLH/b/L62rnFvaE884EM38cE4ETtKl0d
	khlZHTDjnKvjrMJW5zZxAsVMoZWFNaHsd4YfBRe9Ox4Poht4ikYQ
X-Gm-Gg: ASbGncv6xIuNLJ9B0OoBMHowRwhVIkeye+hFMJWYTnW6321DC6tvZZ2ki8z/gQpc+I7
	SXzKgiVF8PCW7Gi0Njj4A0sj+KbE318epbIQeyNRf8onX6vq1edXxjPnK/Sd/d7FEwnREOTap/E
	RB464PhvWmdZJ4hF9YtIeegwHuk56qHkMvSLXsSeFpEkkCZB0tczy7Pf3TX0bi8/K4eDRVuF+Ok
	D3H/OMLxrvtqkHpFBV/rszkF62bWREOPO44WYgi/9Q857qoaOpI7tyKD6qOR3jN10iHcr77fEdF
	npMZaupi/zmjuDZhnZxBh7R8HsGUvS9qsaOjJRWcsg==
X-Google-Smtp-Source: AGHT+IEm2VfaURgMKTWVUkW8metfum5VkiD89JCWy5iWkkfOq8QOhBxbNhbeIAP1Xgz3v7nvNAsr3w==
X-Received: by 2002:ac8:7fd6:0:b0:46c:78cc:e48 with SMTP id d75a77b69052e-46e12a0c2e0mr144720311cf.9.1737371256783;
        Mon, 20 Jan 2025 03:07:36 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1042efa5sm41216411cf.66.2025.01.20.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:07:35 -0800 (PST)
Date: Mon, 20 Jan 2025 06:07:35 -0500
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
Cc: Willem de Bruijn <willemb@google.com>
Message-ID: <678e2e779985a_19c7372947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 0/9] tun: Unify vnet implementation
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
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> The change to virtio header is preceded by another change that refactors
> tun and tap to unify their virtio-related code.
> 
> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

net-next is closed. But I'll review for when you resend.

> ---
> Changes in v4:
> - s/sz/vnet_hdr_len_sz/ for patch "tun: Decouple vnet handling"
>   (Willem de Bruijn)

Minor, and sorry my bad: len_sz is duplicative, vnet_hdr_sz is common.

> - Reverted to add CONFIG_TUN_VNET.
> - Link to v3: https://lore.kernel.org/r/20250116-tun-v3-0-c6b2871e97f7@daynix.com
> 
> Changes in v3:
> - Dropped changes to fill the vnet header.
> - Splitted patch "tun: Unify vnet implementation".
> - Reverted spurious changes in patch "tun: Unify vnet implementation".
> - Merged tun_vnet.c into TAP.
> - Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com
> 
> Changes in v2:
> - Fixed num_buffers endian.
> - Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com
> 
> ---
> Akihiko Odaki (9):
>       tun: Refactor CONFIG_TUN_VNET_CROSS_LE
>       tun: Avoid double-tracking iov_iter length changes
>       tun: Keep hdr_len in tun_get_user()
>       tun: Decouple vnet from tun_struct
>       tun: Decouple vnet handling
>       tun: Extract the vnet handling code
>       tap: Avoid double-tracking iov_iter length changes
>       tap: Keep hdr_len in tap_get_user()
>       tap: Use tun's vnet-related code
> 
>  MAINTAINERS            |   2 +-
>  drivers/net/Kconfig    |   5 ++
>  drivers/net/Makefile   |   1 +
>  drivers/net/tap.c      | 172 ++++++------------------------------------
>  drivers/net/tun.c      | 200 +++++++------------------------------------------
>  drivers/net/tun_vnet.c | 184 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  25 +++++++
>  7 files changed, 267 insertions(+), 322 deletions(-)
> ---
> base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
> change-id: 20241230-tun-66e10a49b0c7
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>
> 



