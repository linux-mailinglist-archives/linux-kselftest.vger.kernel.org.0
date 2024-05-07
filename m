Return-Path: <linux-kselftest+bounces-9612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E298BE86A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302EF1C21C65
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36051649C8;
	Tue,  7 May 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/R6gQKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAE200D2;
	Tue,  7 May 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098309; cv=none; b=KaM0P9ha83VhmV0A+RKWdX5bm0LMPvtnBBQZH9WyVYJHQCE/mTAe5WzUO7CPEp28B5QHalyFZaFVd8Snzu0ReQYLUxH7Xye0SKDGXqezB0T0fVG5yiiXibsUpL6yRFLbcrNgrFIr7Q06b5E8tK1YsYkkOjZLJEz9jjymmaN/Exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098309; c=relaxed/simple;
	bh=p6yW0TaG/xM4tyytfh6Oo3G2KxtjO2msTEHP9QQD62Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pI4NQWw26aVD1Kx4yWAuHMZrY2qrZMCN7lQqvlZRQdvllCzYhI6hcq4DTUtn20wpafe4YrVEleeLq0ul9YC39VYAKifzwS6qcVBBxxbDsJdmbA6iizOYisGo68p9E8P1UTR+BHIYgdRnhdGHn+5jGTpkRKbmC1RU3G9+pyUM46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/R6gQKO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b79451153so27288975e9.2;
        Tue, 07 May 2024 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098306; x=1715703106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5z8V18Dnpirc9fyyvyciAXH4sAcfELurWsmbPRhXHU=;
        b=a/R6gQKO8p4Ch9bOcDh+wECTwLDb1PZF9aU414NExRzl8TAW88FwROGc80MtnOLFtu
         ivmPxBv6c8ZssBLbDun3hfg1ZcIxUMWWZcjoNPmOy75pTcWUej4PBB/V5hhhnlhaZmFa
         CaPV8G9m+jr6ShYSbDtvHoak8AJqq0MNvo1ZTdkgB/W/2HU0anL036TMSQd7FBXwQD0k
         KMn+FNNAHETl7vCkAhFfevyxn1v0QWc2svQrKNB6Lu90/eyBA8oUTs5Ku/OoNq9CzlPz
         nz75Rv51JPe5ORE9PK8PftYpWg43t8su1VNovVzsA0MR2qsRG8QrcfqzR5pEMcnRPG+n
         Rrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098306; x=1715703106;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5z8V18Dnpirc9fyyvyciAXH4sAcfELurWsmbPRhXHU=;
        b=T0dpUH385WRBIrRsD77zKik3wNfSxBEYVgQLXkFIT34/x5/CpRLprCZXkizwSXf1su
         6/8ezjcf/HSC4WgihzpQpRPnUInVFPHaFzvFrI7Xh2UEw7PWcAQ4mzdludNN0c5Pq7q/
         Szc4Hthwduv0wx1IWSE2+HxZzuRhm1OEcBLYc+/3sJ0++WUAA+u1ve8Ifay6SjX7jMrt
         +N2TpCX+KQTUx3yoP7lSCj40fmg9vLrvwXtQNSRwiDSp0H4PU8jfKSMkVjZayvn5VK5p
         5gJZndTdIFLkh3dCczQfQh7FtKucQEkBn8egu1J99lZopRMJUIZTI8MljHob+rxX84Fe
         zrPA==
X-Forwarded-Encrypted: i=1; AJvYcCV3009LBHBJCbDth2DtiWFZ7BwghCbQlQVvDnDL+X0sDBUF/I/Bc6w9V9z9U+3RuDp/HOVN2MzQc6aLcvM1njvaBDRrO5p3vzmeQIAqWUmjmBqW5ohaNlEUXyIO2HYs0G0KrcIdowuqv9Z899iNcuVRR5dCtQ1zdrnt5Pl/zTZwgXhCW6bw
X-Gm-Message-State: AOJu0Yzj5WfqtMlIHU81a4Qx6bEDkYaTaW82ZhjSqteGZ8vYR9mVksHB
	qs6/C+7NJcpIZ2w3m7d2utLmrS6jb3MW7GyKZSC9IVgElRPqPNc5
X-Google-Smtp-Source: AGHT+IE3aTOPJXDP0KK/PPYITI52Y0e7tMKMdYA+WKKF4laAcEI4kgy4I/Kl+IGI/jGY4tbbA1YHNg==
X-Received: by 2002:adf:e543:0:b0:34f:4e40:c05c with SMTP id ffacd0b85a97d-34fca42ee4cmr229591f8f.34.1715098306290;
        Tue, 07 May 2024 09:11:46 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4303000000b0034f145b60ebsm5929171wrq.3.2024.05.07.09.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:11:46 -0700 (PDT)
Message-ID: <47c175ec-2cb0-4262-bfb1-724749624f58@gmail.com>
Date: Tue, 7 May 2024 18:11:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v8 1/3] net: gro: use cb instead of
 skb->network_header
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 alobakin@pm.me, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alexander.duyck@gmail.com
References: <20240506093550.128210-1-richardbgobert@gmail.com>
 <20240506093550.128210-2-richardbgobert@gmail.com>
 <6639095ab4887_516de294d8@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6639095ab4887_516de294d8@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> This patch converts references of skb->network_header to napi_gro_cb's
>> network_offset and inner_network_offset.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h        | 9 +++++++--
>>  net/ipv4/af_inet.c       | 4 ----
>>  net/ipv4/tcp_offload.c   | 3 ++-
>>  net/ipv6/ip6_offload.c   | 5 ++---
>>  net/ipv6/tcpv6_offload.c | 3 ++-
>>  5 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index c1d4ca0463a1..1faff23b66e8 100644
>> --- a/include/net/gro.h
>> +++ b/include/net/gro.h
>> @@ -181,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
>>  	return ptr;
>>  }
>>  
>> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
>> +{
>> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
>> +}
>> +
> 
> The fact that .._receive sets encap_mark, but .._complete must read
> encapsulation, due to the clear in udp_gro_complete, is non-obvious.
> 
> Can you add a comment to clarify this or rename this to
> skb_gro_receive_network_offset?
> 

I'll rename that to skb_gro_receive_network_offset for better clarity,
thanks.

>>  static inline void *skb_gro_network_header(const struct sk_buff *skb)
>>  {
>>  	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
>> -		return skb_gro_header_fast(skb, skb_network_offset(skb));
>> +		return skb_gro_header_fast(skb, skb_gro_network_offset(skb));
>>  
>> -	return skb_network_header(skb);
>> +	return skb->data + skb_gro_network_offset(skb);
>>  }

