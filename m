Return-Path: <linux-kselftest+bounces-24700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A8A14C15
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7A61886E22
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4C1F91FF;
	Fri, 17 Jan 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK1JSA3d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2DC35960;
	Fri, 17 Jan 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105836; cv=none; b=A4+3k+CB+V2Ot0kqTH6dq3hK/e/lK+eNFjWwbcPjJqaAuj8KqC9fcJ1zE2n/tbJSKan+C6nuqHFgIFavzJNr1kC65RgK+q8AGtJCBEMcUWpdYDjpBrcKS/ULjbJ7oR7YELbh4pRums8vKqiaNghLNUweSjq8zm0H0JuapGkDjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105836; c=relaxed/simple;
	bh=50hALf/6JHENCC8eS76LlBaB8m3rt1/ock6nsrhlS3M=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ef0vX6ptTrO5goRey2vFRbnabjtPkXOo9K9NhBrO/rZPBf2YJsqKoi2iCgU1D+0ytFuuz2e+L97my05zxkqybimyYeeRkvLZX3nGFQPgOeU4IAgDrHd4RRq4gQvoK8ixo2cV+s8q4Nr3hRKWaK/fPf7Rz/x6OmuppYJ5g5Ad3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK1JSA3d; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6e8fe401eso165670185a.2;
        Fri, 17 Jan 2025 01:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105834; x=1737710634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUHC+rmP5s8u9ue7y5NSHcW77KbmtVUiG9NQgfxlEs4=;
        b=gK1JSA3d71BAh5/WdiYgNXp/rFtF1ITAyZ3o5TP8E3SV3PTg5lucma/cUpo973ywSJ
         Y+r64seupyVMNbAtg/9ANlxieTplUYzwXhEecuyuTZ3ywlrGzU67JIe4aV7/MJ9zqwwv
         leOUTYOfjXWAkykNBP0hxKe9elwswsvANFtbiIFWdVzBdO0EC4u5hz6xe6tLosBz+HnI
         2rGGf5uLESKt8sv8vXkgr1ajY2jul4QgEHcnzcc3I6nw2gEGlaGroe8rxLzFFrpI+KSe
         y1MSKBV95qymoYhb2X7xAEepY59F+bWNbDAH7b1mIWke6A2urzOIu4AbvmXdP+ulYvzr
         irag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105834; x=1737710634;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUHC+rmP5s8u9ue7y5NSHcW77KbmtVUiG9NQgfxlEs4=;
        b=m/b07KyYEv7nXOxGNtNzM08BAiIRjiv+1PEiCLqAUtcNRcTEkJuNoy/f4ZAsPhKxyz
         XB5ChqKD4NdEMCSwh+drqzEtQl59Vuvc9axfqITiY3bHtVYDBuJ2LO2dsmhxEOa61fn4
         yINW1PRUzKC0GK6N3NJAm1IbcwaDIKzGd/a9y+Oh+Bgqme91UzpHlt4y6OgkqbErKqJj
         39oDKXdPjiG7hOyv6fbBcRi2ITAqfK7Am5r4CR0NahwGmp26S2PNs86dDy44eOPEwqNe
         gJTv0Xre+GwnI7XP5pziTMM2tMxiGyXyzPUuKDCRbSlBc5HLN4Q3TNL2z3+YeT/tz0MO
         VQsg==
X-Forwarded-Encrypted: i=1; AJvYcCUKo8EJ9KqFE18d18tK92KPJg168iR3Gl396vnfu9lv4mrRWcKMJdbq163Xdzg0ks6r+RHD39wJL5WH@vger.kernel.org, AJvYcCUwadXg4JdoY8ZJU45rYc+kt8G6Vx7FJGocp+0S62n+iuA5BjkqrGtCXtfWLMCpE/WS70wyO4LOsFMsxXxk@vger.kernel.org, AJvYcCWn2ABNmsGinFO0fJImPO34xG9bNLCK0c17UrSyhrgArIbvG2dyimEMs/LVvuOYHHNeipfq4X4MF8UXA8EZ9C3Q@vger.kernel.org, AJvYcCXleG+d8CYFyc15ecLry/zmrqU8IXN4A7an6aUspmlV59q22yukFGDieceopyhECc5NVmh2FmPy@vger.kernel.org, AJvYcCXvdSAf3Ci0H4WaPLfW4kCxD0HBVDyAKri9NdEGxyw3H3cU1EyQqQJPhVb6BVvPeboCW0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoedeMLICSNXRVt3Rg8janOUULWvgPSOUlrNgje2eKc/YGMXkw
	5FGBk+bDp3awVqgQj6W5x93FXYqN6qGtz61SJ73csAKER6VKFidH
X-Gm-Gg: ASbGnculGRZswHaD955WqfZcFm5DRYjkE6TNylY983e9GJQ3cV/+VzUx0L+dceMrC98
	vcXnI357RVDoXDkKgPE9Gp2RNz4FbYL4P9b6QY55VYHGEtr8fycQ3PQW7B0D5H49vSBkmFIM0Ot
	loVyif2lBYcD78f+9kW+sgty/1byub6OA2SrnZfimjGYmaL37aR0+0lgWVOSvd5vsmrKoM+JUk5
	nmtW6wqiukMVXK2YWUrtJI0hnO833sMYTYNlpb3MS1eZEjnL1+QtDWlMdBWI8ltc+QsIyw9pJsX
	pm1vK9OSlowRaTpiJO/PCIWgkzlL
X-Google-Smtp-Source: AGHT+IEMu06W4+1L5IGQzrWbh5FGKq2dzIxGEx4RdrkbuTSxndYZ95YVhigy3GzlsmK1SHrLp3dALg==
X-Received: by 2002:a05:620a:3942:b0:7b6:e9db:3b19 with SMTP id af79cd13be357-7be63287a2bmr335761385a.47.1737105834081;
        Fri, 17 Jan 2025 01:23:54 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc0f877sm9579176d6.31.2025.01.17.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:23:53 -0800 (PST)
Date: Fri, 17 Jan 2025 04:23:53 -0500
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
Message-ID: <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
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
> tun and tap implements the same vnet-related features so reuse the code.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/Kconfig    |   1 +
>  drivers/net/Makefile   |   6 +-
>  drivers/net/tap.c      | 152 +++++--------------------------------------------
>  drivers/net/tun_vnet.c |   5 ++
>  4 files changed, 24 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 1fd5acdc73c6..c420418473fc 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select TAP
>  	help
>  	  TUN/TAP provides packet reception and transmission for user space
>  	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index bb8eb3053772..2275309a97ee 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -29,9 +29,9 @@ obj-y += mdio/
>  obj-y += pcs/
>  obj-$(CONFIG_RIONET) += rionet.o
>  obj-$(CONFIG_NET_TEAM) += team/
> -obj-$(CONFIG_TUN) += tun-drv.o
> -tun-drv-y := tun.o tun_vnet.o
> -obj-$(CONFIG_TAP) += tap.o
> +obj-$(CONFIG_TUN) += tun.o

Is reversing the previous changes to tun.ko intentional?

Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
over this. In particular over making TUN select TAP, a new dependency.

> +obj-$(CONFIG_TAP) += tap-drv.o
> +tap-drv-y := tap.o tun_vnet.o
>  obj-$(CONFIG_VETH) += veth.o
>  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>  obj-$(CONFIG_VXLAN) += vxlan/

