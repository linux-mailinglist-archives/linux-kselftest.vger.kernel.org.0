Return-Path: <linux-kselftest+bounces-7331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22D89AB7B
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90031C20B23
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB1383A6;
	Sat,  6 Apr 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFiaeLE/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F5376E0;
	Sat,  6 Apr 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415797; cv=none; b=Pbmf4vV0o6wOuEBLhac3OATAJIXkyW7h9i2BQbBDPW2M+Xt6tgEs42eIUP/IY6MFUSLiQ2ZOG5PAYiMCIzvkA7DzgZbyODYaO30rANuMTBjOYlCagne69oUqV51QxquU6oS77NSG+bPCb5tI4cYzwpoglJl6yIX9m4GU17QA8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415797; c=relaxed/simple;
	bh=CAq2D4Inwn3Za5vQna+/XQvSndgmRav7iHL7fAy3yyM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pZIJsshov0YnYWmT+pQ19+fwUUqPG3Yd7jEvd1UuHhwbEacuJC0OlEpL38k5j0pY2wpdKE1vBqRowIj5TAldQ+h8Sh/4jKnmyx7szmDacuCYOadxZzTqlgA4VNyMc1B+VCXMpCe/uDIqIIsN65D/cy0Sc5ecalD9bRu66tKxTrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFiaeLE/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430b7b22b17so18051541cf.2;
        Sat, 06 Apr 2024 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712415795; x=1713020595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7oZc1r1+1pQl56GfIW2CdrbD4i8j9cKjnw4MtdeYuc=;
        b=PFiaeLE/RTYRHPtqIkrHGucHcYABPoBZycwxjeaBa+S1DWnGCPvahY9b8Noa75Cvpk
         j5L+dn39bNY3kGEUzHMEQOp1si2vicTnm6F5bXxQB2UIRDz9OaqopeQZh5WIPx8ucccR
         t1FIycd6YILBdPOyT6Ay8DjE1mgDXz8W2eHV3CVSk9NlJ6HVvTPLd6Ao5euxoVaQ3W8Y
         H/Scw1/GOIRnb3vXLKw96Qd7Z1EWeXm2m2l+S/nDeEXOKWV2KKuN+ejLZdT2vO2wA6Jp
         /PsmidNqciw95XoANF6jJmgCizwRGliErU0FoZ4dzD7UbQA8wxTzURUDh7lRj3BnrMN+
         5kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712415795; x=1713020595;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a7oZc1r1+1pQl56GfIW2CdrbD4i8j9cKjnw4MtdeYuc=;
        b=eeQ9/qYvK6ywKZJy5wlPoV9Ltxhfqh+Av23LJLXkD2w/Y+e5VraAWxTytSb5xpHfpy
         3nkic/ewrbBc2iMjer0cVCt1P2lkrxVaE7C6h53ina/OQ+U1awi2g3ge+EteuidyiIIo
         pVGKSKIkQVGf17g4CJI+JLMfyJnpBkg5uI9YH1bQ5l8DfsNHh9TinzDBndtph25oX92f
         4Zw2P/4Dn8RdEERGP2/08sce2GWiLRUJ3A9/flot+M6/0z9sd/zV1m7VGbcb32vQZZ6G
         GIuaHVvbLL15e68IEYiLnEDeMTD4rE1qcffdAf6Rwh7x+LqaeaT5f+hj+RqT47XoxjYJ
         JX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSWsMVm5Mfc76t8FOsdvzVfSo8gx/JKcf3ez/QH9trO4ly/bsgwQYfhy3GjGFZO6L0XYOY7awICKcrfAWoB7ulhcv9DISZQ31n5NpNUvGm8AgdyrTeAWM4wGd8aVyg/l941Eq2wwet7qLEJr6m6CxG44Wdo4FUHKSPa1gDtfTRkr6/0sCM
X-Gm-Message-State: AOJu0YwmXv+w513LGACEsUE6lm8WJiCAPE/Is3JB4ewZo8JyraDTFGGA
	fpeF5kHFDiHQg8C01O49ME2U6+Fw1vtwD7yJXkTMJ32SZnc18SaI
X-Google-Smtp-Source: AGHT+IHxoO6b2MerF1U3CAmgXcBlPetNiGPIdanb85cHChz2yvph3qr1eOxLcgarxaWdzQTe3bNd6Q==
X-Received: by 2002:ac8:7c44:0:b0:434:7944:bafc with SMTP id o4-20020ac87c44000000b004347944bafcmr1289053qtv.16.1712415795225;
        Sat, 06 Apr 2024 08:03:15 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id w22-20020ac843d6000000b0043146d55f0csm416039qtn.60.2024.04.06.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 08:03:14 -0700 (PDT)
Date: Sat, 06 Apr 2024 11:03:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: yan@daynix.com, 
 andrew@daynix.com
Message-ID: <66116432b55ce_16bd4c2943e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240406082513.78692-1-yuri.benditovich@daynix.com>
References: <20240406082513.78692-1-yuri.benditovich@daynix.com>
Subject: Re: [PATCH] net: change maximum number of UDP segments to 128
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yuri Benditovich wrote:
> Earlier commit fc8b2a619469378 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> added check of potential number of UDP segment vs UDP_MAX_SEGMENTS
> in linux/virtio_net.h.
> After this change certification test of USO guest-to-guest
> transmit on Windows driver for virtio-net device fails,
> for example with packet size of ~64K and mss of 536 bytes.
> In general the USO should not be more restrictive than TSO.

Ack

> Indeed, in case of unreasonably small mss a lot of segments
> can cause queue overflow and packet loss on the destination.
> Limit of 128 segments is good for any practical purpose,
> with minimal meaningful mss of 536 the maximal UDP packet will
> be divided to ~120 segments.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

Please mark fixes as [PATCH net] and include a fixes tag:

Fixes: fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")

Otherwise this looks fine to me. UDP_MAX_SEGMENTS exists to block
egregious examples, such as 64K 1B segments. Doubling to 128 to handle
536B MSS is well within the reasonable range.

> ---
>  include/linux/udp.h                  | 2 +-
>  tools/testing/selftests/net/udpgso.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 3748e82b627b..7e75ccdf25fe 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -108,7 +108,7 @@ struct udp_sock {
>  #define udp_assign_bit(nr, sk, val)		\
>  	assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
>  
> -#define UDP_MAX_SEGMENTS	(1 << 6UL)
> +#define UDP_MAX_SEGMENTS	(1 << 7UL)
>  
>  #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
>  
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
> index 1d975bf52af3..85b3baa3f7f3 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -34,7 +34,7 @@
>  #endif
>  
>  #ifndef UDP_MAX_SEGMENTS
> -#define UDP_MAX_SEGMENTS	(1 << 6UL)
> +#define UDP_MAX_SEGMENTS	(1 << 7UL)
>  #endif
>  
>  #define CONST_MTU_TEST	1500
> -- 
> 2.34.3
> 



