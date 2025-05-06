Return-Path: <linux-kselftest+bounces-32520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3ABAACC5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB2C4E4E81
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66B280CCE;
	Tue,  6 May 2025 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQHntQEu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B94253B56;
	Tue,  6 May 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553233; cv=none; b=OW+daCQ1gZ2lL6axp8pXLR+hN9E6R4v2iEbZQYCGeXLdAwLJOLmKNf3UmE9g/k2+GE/SPt5FrG3DSoedNGc3Lkysuf7aVICKb9AGq4eo3eT5OYUhZvt/Kagv+FepOtLqAwOobsRou3/45XabIPxc0C0+Hch0nouKQdtqewvziJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553233; c=relaxed/simple;
	bh=4kdAXXZi12VF44Cb1DC4z4hso776BAYh+rbTOPp1zk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmuowxqy4z9RO9KzqBATh683DrknR+96dwTSorfM2bOYGes8VXIQVmfgX8wUWhxLtfF01i6F0eLBmrFTOBVvweJ79AgK4706pd4Kl8TLm5b/F298K7lNrnPhI/15TleOqK6NYqmmdb3NmFzNztjevQUDZOlXt71AwgV22mfF3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQHntQEu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22435603572so77714415ad.1;
        Tue, 06 May 2025 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746553231; x=1747158031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjVVfpFT4yP7gJ50hizx3+DZkQqFzjP0uQK38pV2Azs=;
        b=CQHntQEuFEKhqMf1mEeGnK8KyIGbbdBH8ekluZ21ItoS4QMTlDaA93d0JA9tKfDncY
         hSo79oTt+A1PEUtbLt8jYSfdUtzfibRlzPcvTEZu4/lB4Z1JmQ6dwm7r8i7VclYbwuSI
         uXcuOQ0qgMx1Em1XtT2PGYe5UiA5FK0AR4L5/6L3/QUky8HrBJJcLf/XuPx1E1YxBpb4
         cF6DA1JpZcpLfOUHdpY6F54XNcvLo0H4CgW2tyofjGj5dW8LPBzUZR2MRMDorYEDbaUC
         HuO72vKY5QMBHs5VB76FJBV5aIVpTE5BvSXtoAy92bLC29h9vV1yzWViSyyZbMlw9/CS
         afAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746553231; x=1747158031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjVVfpFT4yP7gJ50hizx3+DZkQqFzjP0uQK38pV2Azs=;
        b=b8omHYDP/66IXdWcml9kOmBqMv3SVb1DA3xBDNLgzTOqgBEQdPCWUFo4W9YkL7d40K
         5aajpHsliDiz9Q9bND0VkpkWwe5Ved5bEtDxgiWOwKcbqQ1jReVMYudyy9p2maiHcGZA
         wAq0+lukx8s9cx1Hg7HA4xrwhJZw+5t6s1FwbXsXQ3+k0JGzMToULxatOS/zLLUBm9EU
         7fXj9L0FGN2qC38DMDeNR2XhU2S0SVbn7piOkGZTRTdwwdihVzo3TpDnE3RdEUDSwh0s
         9VqhpWpDor+WyPSK28mE8p3vFicXHJuW/Pi50g6AM/wgHEQQ0U2sHjESoSE42vBPChVY
         4xPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAedvFtOaTcqzdUxZdkvioe3C07SLIcY6bmz2t6ntQOAqG63F6cqj0VEnfXE8KFunZHfUxLk49bLIJbWWZeGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaBj6ZvaHOWYEwcwSfXz37A2a6H2jdRwzWzDerEjvWZq4hscxE
	DsVwz12Lmwx8Y2dQ2FTtRV12Pv1OtwpCAbX+QwKKtmDvLizf1Vw=
X-Gm-Gg: ASbGnct2mt8if5zUg5rBfYQNWBl0XPwTIQ5c8mQhDx+qe7ITrHpRv51Gc+6CVMtvAXx
	9phNBrK3Dz9newnYg8ht+rmS8jFxHeXwFtRAe3FR4B6s6ZENjt1iykxQfs7n+NN0r+9qcmsmZvv
	AFMvN7krNaHg9dJvzR0cuSjvEOT0vy28FvZ4hR4rGXTT56R0jo1zq60vCNPIDaJdZhRqePRY0jw
	u4um4uRbek/RUHRRK+SR/cuafv70YXRzeZlywW+pPA/evm5MDqkhw8t+VgeFacllVadQom44f6O
	uGwu+7eoBBoIo1xF3o98QTrLmt+VfOlGjffIfBwUjzcl2Jam37woHJ6sp2FXI+f86uPclPM3Ftc
	=
X-Google-Smtp-Source: AGHT+IH4KHIBz+2/zNk30aR1k3TNmHE0g432qntdCeusCbGFDtSR7Etf+B2XebP9KGC7atfLW+VWmA==
X-Received: by 2002:a17:902:e5cc:b0:21f:988d:5758 with SMTP id d9443c01a7336-22e5eccb4d9mr1578385ad.35.1746553231122;
        Tue, 06 May 2025 10:40:31 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e1521fc49sm76361545ad.134.2025.05.06.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:40:30 -0700 (PDT)
Date: Tue, 6 May 2025 10:40:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"jiri @ resnulli . us" <jiri@resnulli.us>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Message-ID: <aBpJi3t0RhUj5HPE@mini-arch>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
 <aBpC9_SgUaAA2P0f@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBpC9_SgUaAA2P0f@mini-arch>

On 05/06, Stanislav Fomichev wrote:
> On 05/06, Cosmin Ratiu wrote:
> > __netdev_update_features() expects the netdevice to be ops-locked, but
> > it gets called recursively on the lower level netdevices to sync their
> > features, and nothing locks those.
> > 
> > This commit fixes that, with the assumption that it shouldn't be possible
> > for both higher-level and lover-level netdevices to require the instance
> > lock, because that would lead to lock dependency warnings.
> > 
> > Without this, playing with higher level (e.g. vxlan) netdevices on top
> > of netdevices with instance locking enabled can run into issues:
> 
> Mentioning vxlan is a bit confusing here; it shouldn't let you flip lro (I
> think). Which upper are you testing against?
> 
> Trying to understand if we can cover this case in the selftests.
> netdevsim also doesn't expose F_LRO feature... (yet?)

Ok, yeah, I can see it with the teaming on top of netdevsim and the following
patch applied. Might try to send a testcase to cover this and the promisc part
that I missed.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 2aa999345fe1..af545d42961c 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -881,11 +881,13 @@ static void nsim_setup(struct net_device *dev)
 			 NETIF_F_SG |
 			 NETIF_F_FRAGLIST |
 			 NETIF_F_HW_CSUM |
+			 NETIF_F_LRO |
 			 NETIF_F_TSO;
 	dev->hw_features |= NETIF_F_HW_TC |
 			    NETIF_F_SG |
 			    NETIF_F_FRAGLIST |
 			    NETIF_F_HW_CSUM |
+			    NETIF_F_LRO |
 			    NETIF_F_TSO;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;

