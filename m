Return-Path: <linux-kselftest+bounces-22749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A579E1F68
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29621668ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AE1F758E;
	Tue,  3 Dec 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4KQPcFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486A1F471F
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236486; cv=none; b=rF+lQTRyfH6F7KaBJ9nxzjpSSOJSlLij1jtt2fd+eEcfVtBjDAXuKrj4lP+5IryDKRORMakTjuOgJqNDXZPIQ/+NBNT74EA34GK5Bj5Go87whNBfBd1GcnhT+MhNHR10w3B/sWT4WwO/B/4QcLj1qQLD4UkAs2HcIhs9tuozHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236486; c=relaxed/simple;
	bh=gU5uGWIiPYomCEI0yBgy+uwiwvPmTlkKp/76+gyNy/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La2Km85i4ysXlSk1mFop0tt9t1JHMiZeO6pjyFDXVoIqiIq9kCqnc9SZ6Y2RM7q+2575sTBRELbtEW3ClBB0gWKvrI5+WIbUhQu5zCdv+yWGiRTX6b2SfGCs30+1U3+sL0kgwLr11qITEp3wJe/HAAhrvMG/p0wlzBIVSnp80Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4KQPcFj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733236483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZAKk8offspn+CrsLMVAdR0q4qmaIQ+sB/EB4y+6k2o=;
	b=a4KQPcFjEIAOSHLOdX0bMcAySzmMYAR+HnOY6iGCWpPbtNYOD9JFI5+mBFM1ZF1yv/Qgss
	Xw6Js49IUTmHTgS+6V8e46zUAjmTNjDcvkZiu5MQmSd1Nag212go1Pm68VhiXv0V/TqcpN
	LOv3bea4V845Y50qWdiy1M6hUufkOX0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-7yQVwti6OPm6p-4d9iWe7w-1; Tue, 03 Dec 2024 09:34:42 -0500
X-MC-Unique: 7yQVwti6OPm6p-4d9iWe7w-1
X-Mimecast-MFC-AGG-ID: 7yQVwti6OPm6p-4d9iWe7w
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b67a8cd4d2so718210585a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 06:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236481; x=1733841281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZAKk8offspn+CrsLMVAdR0q4qmaIQ+sB/EB4y+6k2o=;
        b=oscNWX2M7uJ+sA2RM1kZhOcstEdJ6gIAT3+3m4IBnw9fUiiUvfPWjQvTBxmBt/QxsI
         X9Mx+B/IfcvRxge4w3G4FNNRXFNdRBkXywo0HLijBxvbU4wgm9f8o4aHCY4wRNs4BYca
         VVEXUoNeLboiQo7D8G+bMtUHzbwXowLiClwB8ZHH2VPB3cEa30VWWOuQoZa7pF/OVoW1
         9PZChRXSoVAJt/lbXq6jEddigIIx63r5D9kSfz2laR/2DCQT5QeXzJrFag6FVYLE32hq
         hG3GGgdtkPix4sKD+y8ODYQPgWyyEihbVP3PYQpEItNHEanmRduSxjqiVF3ptN8PVqsM
         GE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCURQuzfKhwMF4ACC5PBIJ26b+Bm1oSo/QpyiO6rd3PmPPtKieHIBWFmclbQR211vxImO6+rfLMr1L0Rtk/3By8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiRUUjmLXWveofnTKvFPIXSu8MEPHocUpVluJZNohBcsFtpBm
	7ubdO/lu3+rGHYyErFnqyi2pZIt1Xn9j9ED3piwJ+aqn0QiTqDcc8KdiQ1RPApW97ByAZocKQ6W
	gRHeUxRLBdeSKejhm5gh0Ivor9OTBEf/bKfR7lamv2UoJhG+y6EZGAOgtAUuv59DRUA==
X-Gm-Gg: ASbGncsXx0wEkIo6vFS62ioVEHJDDrV7gY0AY1GiKo4fqL/aTW27jzQpvEOKDQwzvPa
	KI0DPIwjOGlKW2JzgByO/vJfpxKP7zbSRe26eRVPkpw9xncjfQq8idFAEROcxnwDlifswrd5W3s
	WbJktZT2eoIyYb3EmOQJdaW9IOe7Ghf/MkR5+oDChCviovSwRcHwQFnMr97hb+I9+l4kmT84G22
	Hil91FfdlyAgnYGZz3UvydKyMH8JcuWb+pve8RLiyScksj8MFYKwZikIY016mHIxtUR4pdIvXcj
X-Received: by 2002:a05:6214:21ce:b0:6d8:919a:ac43 with SMTP id 6a1803df08f44-6d8b7404d2amr40441386d6.36.1733236480919;
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhgK4e/6IUinGGlgMgRZ5guoSHMdFsmcfdl9enfUkbfdJVlNSUwmvuv0H4sImi572qlr1nLw==
X-Received: by 2002:a05:6214:21ce:b0:6d8:919a:ac43 with SMTP id 6a1803df08f44-6d8b7404d2amr40441096d6.36.1733236480538;
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d898045dcasm37681596d6.102.2024.12.03.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:34:40 -0800 (PST)
Message-ID: <c49582ff-5fe6-4d0a-8d03-7b3297cadd6b@redhat.com>
Date: Tue, 3 Dec 2024 15:34:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/22] ovpn: implement basic RX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-8-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-b4-ovpn-v12-8-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 16:07, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 2a3dbc723813a14070159318097755cc7ea3f216..1bbbaae8639477b67626731c3bd14810a65dfdcd 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -9,15 +9,78 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/skbuff.h>
> +#include <net/gro_cells.h>
>  #include <net/gso.h>
>  
> -#include "io.h"
>  #include "ovpnstruct.h"
>  #include "peer.h"
> +#include "io.h"
> +#include "netlink.h"
> +#include "proto.h"
>  #include "udp.h"
>  #include "skb.h"
>  #include "socket.h"
>  
> +/* Called after decrypt to write the IP packet to the device.
> + * This method is expected to manage/free the skb.
> + */
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	unsigned int pkt_len;
> +	int ret;
> +
> +	/* we can't guarantee the packet wasn't corrupted before entering the
> +	 * VPN, therefore we give other layers a chance to check that
> +	 */
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	/* skb hash for transport packet no longer valid after decapsulation */
> +	skb_clear_hash(skb);
> +
> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
> +	 * interface, based on __skb_tunnel_rx() in dst.h
> +	 */
> +	skb->dev = peer->ovpn->dev;
> +	skb_set_queue_mapping(skb, 0);
> +	skb_scrub_packet(skb, true);
> +
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
> +	skb_probe_transport_header(skb);

This is a no-op after the previous call. You should drop it.

Thanks,

Paolo


