Return-Path: <linux-kselftest+bounces-24712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A677FA14DDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D363A58BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD11FCFE9;
	Fri, 17 Jan 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxFZXHBN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039791FCFCB;
	Fri, 17 Jan 2025 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110552; cv=none; b=o+rzx68xApsktcpjGbftjwUGMRPI8WrprOHE8asm/63HHZHU1yz58jfr1a61KFrhVfRAnaTqJ56zko34n2mztgDIiP5CqdTlGgppeCb34TIvD1aJYXysYxbfTlhtOQoy2aLo3+GU3yNU4Yk2zHn34O07zBxvZ9E/IJK3Nd/kl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110552; c=relaxed/simple;
	bh=tkG3TzeNvEiwvG1Qxi/YPhrVwe6v7iJWNqSDUwELPzA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BXNi34Tewd/buwcAUQVDIjJd3JmzIakAuggn6Z3GpElGdQgBYx6mtNbbrr8mt8cNqG6xKpwTAKhS+7VO/wvgFI4jDPKUnkUkuD4u5dNtAB27C/ezs0prhFEohUkpXmyDgZ/c998DaGyOo2J50El02CMbzr7IXTrwl1LjQVafIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxFZXHBN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b8618be68bso107303385a.3;
        Fri, 17 Jan 2025 02:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110550; x=1737715350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNtqSoB8h2OW6duTMoHIjm4z9+1zxo9SGQm2VEevlOk=;
        b=gxFZXHBN9+6unQSMOKlzmEDGyKgVCJQJS22Jg1EkXC483KVwgWd7s5GpupB122VX8o
         qWabp2oZ+W8krp27kVTjQFsG5JdFko2mCjHnJfMUW83T0HMZf+Bp7LV9ZqdAD3e5M1FI
         s+lw9pfLEoCm4mucwdRd0fsbc6uDqB9YItxp/UINDNMI8mREF6BmCQG9PUfoETS03dY3
         P6X9gPXnKWSa/TkSH1C9dPh7Z2alfg7qXyFbR8rK91iZY9fq1Mju4XRniqrwBBVurs/I
         PMITperWxPxoAH1dA62WyMRWKgaDx0kfaFEdaKkW3Tw5jMc709hAv2QD2+5FV0zZBw8z
         /OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110550; x=1737715350;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNtqSoB8h2OW6duTMoHIjm4z9+1zxo9SGQm2VEevlOk=;
        b=uLKY+W6kQ/QnqiOsDRk1z5btEqQ7Zz8cbmaVbG8oPzY/fHBanxpUmFbmgDzE//N47P
         xa1kO1W6jpdE/hgeakbfqeXKOm1zZztgf3SEDo0HafzKNLo7Q/qeDGWIdSfVZrGLlau0
         3giU3H5tBVkh0cABU0b4Qw97Q9tyCdaJ5d7U5kvTFvGda8WbhNXWqvgZsFP0j5NJBHLP
         GHSnnYzdd4xmy/0vOnxFeZAcoGD3YHcb/lnxm+ralD2MoQQAyMQ5y3t/TjLNs7jBmIuq
         EIDpqtLz9w7/yVlXIM3eR0Mb+x4RBIt1YYqcOLZUMP+2DxttZLf/v641q5uEUUWtoSZB
         J/EA==
X-Forwarded-Encrypted: i=1; AJvYcCU3bUgJuLhWn45Vne/c7+evTVK8U+h/bVEhydhB67kzyp6+YFmA2hnvqfoJoXGWB68D9AohsUDILdRG@vger.kernel.org, AJvYcCVBrJLq6BXJejzlzkLNP4XyNzI/l9lz5hjVx4ViGG1MMepn9WmIckhd0bQNAinG4n6GZtjLwrxP@vger.kernel.org, AJvYcCWts2gxZvwt9/antYWq7Maka+kCvMnBt2UjFXApCHrh5TVa/wk3QqHinknOyAgThUwiqFo=@vger.kernel.org, AJvYcCXZgf8fLpaoMvnOvuDWyS58Uaoayw+l+AWXSGi3ie3cR+6TPSVPjMAQToezym2a45MJrfi2PB5diPUUyN1A6izo@vger.kernel.org, AJvYcCXs0zA3cGod3bAtCWBWoMBPcrcug1NFC5ZJ7k+JQT5IzYTrj5N3PrUb/zOhrE4Qnel0xX/WF6wXOY+nr2ab@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCWbTsssf0sP2x8s9dZXFYqi/AC/itazoZfAjHShNIvYOFnql
	J89j3obmx1yDogOFUC+faL9Tty5C+lukqwuET2NUXDAs3naRQ88CAB1K+e2mx24=
X-Gm-Gg: ASbGncv92ZNgU6SvVhbI7XZBp/8A5VgCl1pZFH/BbVLAjbg7fHlJ4zd7Yr0dmMr6SDh
	lugPB0HelXzKFPvRqhHRoBTROsYR6J8N8Vr25ouEuqCn9FwIenIKORJZ0tik/mu5eUzzCn2G8zc
	7ARIY/ZFEgljG5P+jASrp6nEu5auQPukUoob3x4WoGqEHoxzLp0O40hFy9LgawcZ9PVftv2Sfnv
	e9tFDqESCCQdU18mR+b33fVTJl5LgRNJDvPeN1lGGOy/dQhZ4kEjzZfbZQKwoZJY1oDHNUxKHGo
	DMWssjcV5qBQVbLhNQ403bes2w6N
X-Google-Smtp-Source: AGHT+IHIHo9RSSlJFu6DZuboLZLGVZP/USi97MhEgGDpeR8uuBTSfyde4cbm+4veKsIrh4zh48jzgg==
X-Received: by 2002:a05:620a:4151:b0:7b6:d050:720f with SMTP id af79cd13be357-7be6321c277mr221512885a.22.1737110549817;
        Fri, 17 Jan 2025 02:42:29 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614897d6sm101707685a.62.2025.01.17.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:42:29 -0800 (PST)
Date: Fri, 17 Jan 2025 05:42:28 -0500
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
Message-ID: <678a3414c9b49_3ef8eb29431@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-6-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-6-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 6/9] tun: Extract the vnet handling code
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
> The vnet handling code will be reused by tap.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   2 +-
>  drivers/net/Makefile   |   3 +-
>  drivers/net/tun.c      | 174 +-----------------------------------------------
>  drivers/net/tun_vnet.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  25 +++++++
>  5 files changed, 205 insertions(+), 174 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 910305c11e8a..bc32b7e23c79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23902,7 +23902,7 @@ W:	http://vtun.sourceforge.net/tun
>  F:	Documentation/networking/tuntap.rst
>  F:	arch/um/os-Linux/drivers/
>  F:	drivers/net/tap.c
> -F:	drivers/net/tun.c
> +F:	drivers/net/tun*
>  
>  TURBOCHANNEL SUBSYSTEM
>  M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 13743d0e83b5..bb8eb3053772 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -29,7 +29,8 @@ obj-y += mdio/
>  obj-y += pcs/
>  obj-$(CONFIG_RIONET) += rionet.o
>  obj-$(CONFIG_NET_TEAM) += team/
> -obj-$(CONFIG_TUN) += tun.o
> +obj-$(CONFIG_TUN) += tun-drv.o
> +tun-drv-y := tun.o tun_vnet.o
>  obj-$(CONFIG_TAP) += tap.o
>  obj-$(CONFIG_VETH) += veth.o
>  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o

Let's figure out how to do this. See also comment in 9/9.

Otherwise the rest of the patch looks fine.

