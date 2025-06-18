Return-Path: <linux-kselftest+bounces-35298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D5ADF0D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD98188BDDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6AA2EE98C;
	Wed, 18 Jun 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="3Hk42bHI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E42EE5FF
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259631; cv=none; b=jS9/BD4F++/kTOPgZqKqsFJ3l8tx/jJOx66V1ygiP7BAWewt6FckBqhfgRiXmETCxbiItyiohpvWy+uhhAOjXvORJ91XY/CsSWBHrIoqDSKBS5GCayBIEJkSkxMFI1qkdGJnVvRGhMwGBkB11yW4wDSVzI6yBmnBpospzRNl7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259631; c=relaxed/simple;
	bh=Vn9iBRZx/9vbTN0sjYLHUj8pAqYVdflJQ14VCJDqr/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHzg82IroeTR2glmaSBb1tdvLLvleuZ++tJ0DCOfa8pJNwPQ0gylzYnCuzxdWoriE1YLdfD/K0I4EBmZ1l0A1sKdGn9dO7dxMe3gicyvVIDEzqU5wBNlhZneOHNuk4eemZ5zjA9wffIaF7IcWnY18Kj+sIpT4k1bCSKMI5M0h3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=3Hk42bHI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb2e9fd208so1424994366b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750259628; x=1750864428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+F9qb0WoqT4O8g9mE9Zc/ggeTeVcLZ0CP5p+3+ztus=;
        b=3Hk42bHIdT8jPgeEuQ0o05zRHi6b+0+CdPEkcYgqnYRDXvN+FXh/R0204Ny+Ej3rEj
         2+YiWi0f4mDRssrYmSCmvzftRYaepNx7p0sQAqXEE6bk8EBaDuR1MyX7bg2oi6SbkGIt
         6dR1PbfYcTu79b5GUbyzNeaXQPFaNaM2WOmWPONcfSueOpb4PYzMH4IGyTfKnKy+1Cwm
         jLimWSFuXVv5VlOBu8wmAxBI+4lsU/MFY7JRygZRyRAlGxSgW+d7md9pEd29tBWzpwZD
         HPe8FvSfRARiJRWg4ghHwZZbsQA3QePa6mge04sdEu1Vt4u9CLXqBTAjpVVrKPotjPfj
         3/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259628; x=1750864428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+F9qb0WoqT4O8g9mE9Zc/ggeTeVcLZ0CP5p+3+ztus=;
        b=MklGIzPdFXRjgjqoAcb0RnAr98EqVxGMRX+ImySgv1b/oLYwVqYhn56ipn8oqESDMx
         9NRzEF/n5yv0oLEkWRFsCgfV0ytWWKfc2fSDN52VVAi2U6ff6EDJWLH3wS6ggbxs8Vuc
         bAin7WDXKwfQfp98GiAc8qlq15vjN3xtWqCf0Usvy1bxs+iwUBIEJvc6tFE31SuBrRtt
         nEmbqhHtggyDA8+6jLYQ7i+OcMo1N0KjXys4BzYEMCZZFTemzxu2A7uOsz5NxloI4X0r
         DSC+AancDEDy+5ZBCjBVl9K6B+0zEpU3C23119KFDJP2oxm+b49ylP7g0d0K2XVn0wyc
         gGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6gfpAtT8znoBIIWvLSNudZL2XD7nSJyZ7XjHIy/GguBywOob1oE5sqD6GB6TDPnyw1Eu6yR/pMbwR+7JSSLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqHwQuCmSARJtfztNU9B09t+2KiOkmah805G/4ZwOeKipIq8j
	DLWy/aRwqez1A7rhMeGLye5/h6H553g1cYzMGLDyI+13erYKKJa/41y+CKviNXYu8vQ=
X-Gm-Gg: ASbGncv3Spn0BelkeLRsxrHZluf4CHkiungikGMmg0lR2Y0Zpwaf5WaLNApYF0yxhu4
	OdHrbXZqxCyQzSGOTtD+h0GL+gNhdeeh875F5pdUhKW8MtLtOe9iuGqvF7O3B3Nl2HN7bsa+m/B
	LJUdTxJoql6l3XZTzkb1emjt4oBKEq7JHQ8sD4v/7wxZZNKkNzXILDaDRt4i4YMh18fNKl+Mf8v
	eZWGlWNdOMd9kuw9kK73RnAE7Nzhh8D16LRk+oMlnYOBU9wGIpvbVRthbZywImfUJ/7wLFRFhbd
	EHv2qqrnaTx0Wwn/uXQMI8s2dBG7P1GxPe0ND7+Ge61C7eG097TuirttLUfUUezMfLJ4kogycj0
	rRqwM3Nkm9a63Gm6nmA==
X-Google-Smtp-Source: AGHT+IFP5VYYTJdfIK01Sjykg0ObgRPDVxQKO2zjJ45JW2hF+daM15wGjp6eoU5BXmzHVJq/enFDkw==
X-Received: by 2002:a17:907:3c94:b0:ad5:5210:749c with SMTP id a640c23a62f3a-adfad3cda7dmr1548731566b.22.1750259627178;
        Wed, 18 Jun 2025 08:13:47 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fe907sm1076757366b.93.2025.06.18.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:13:46 -0700 (PDT)
Message-ID: <82caca13-7970-4f44-a68f-1efcf3e9a0f9@blackwall.org>
Date: Wed, 18 Jun 2025 18:13:44 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/6] vxlan: drop sock_lock
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
 louis.peens@corigine.com, shshaikh@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com, horms@kernel.org,
 dsahern@kernel.org, shuah@kernel.org, tglx@linutronix.de, mingo@kernel.org,
 ruanjinjie@huawei.com, idosch@nvidia.com, petrm@nvidia.com,
 kuniyu@google.com, sdf@fomichev.me, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-kselftest@vger.kernel.org, leon@kernel.org
References: <20250616162117.287806-1-stfomichev@gmail.com>
 <20250616162117.287806-3-stfomichev@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250616162117.287806-3-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 19:21, Stanislav Fomichev wrote:
> We won't be able to sleep soon in vxlan_offload_rx_ports and won't be
> able to grab sock_lock. Instead of having separate spinlock to
> manage sockets, rely on rtnl lock. This is similar to how geneve
> manages its sockets.
> 
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c      | 35 ++++++++++++-----------------
>  drivers/net/vxlan/vxlan_private.h   |  2 +-
>  drivers/net/vxlan/vxlan_vnifilter.c | 18 ++++++---------
>  3 files changed, 22 insertions(+), 33 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


