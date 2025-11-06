Return-Path: <linux-kselftest+bounces-44947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E1C3A967
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A143ACDA8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF630EF7D;
	Thu,  6 Nov 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxyrdjdc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxRNAGsc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDB30DECB
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428396; cv=none; b=M23jbh6RJftIvII8jRysyUtPkcxJAttDwZ+OFjgVdFBqFfZj6qO/OJOFZ89syjz8LY0tlw2E2htCkWXL/xeO/6wsqpS5yQr+/PikUO3SY2yTxO8G01+dnHK/hu+nklhFsObVztA6XNUBs0wXWbS+5KzQUC545yYv6SHlTnFTlhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428396; c=relaxed/simple;
	bh=dQJ7UpGrlfHCXR4jDF4h6g+I9lA0nUsBumN+lVkpg84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=r6gRSNrh8pjPqhNMMJv+8tpRL7uUmHyB/XEYnNlPcoeXXxGkT6hOVZrYy9p0MqBu3frNBolEc8+BilC12y+bx5DMKkH4ADkZegGy5DbFEBjBJZxYAcLq78a+MZSHyMBM0ZONKReYN6QCEX2aqZoXZ/YLBbfHfcASksDEV3QXR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxyrdjdc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxRNAGsc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762428394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
	b=cxyrdjdc/acVKs4Yld/RSf4H6hmRVQ4r3tiC45C/rsr7j/bikdcaDTitGKRnzyyT+UUY3q
	39F/Xbf2Hi1EsYyr6aAFHsvy1pEpjp5QegJrS+vShnSWyyorbm3rX5RE+AMt1WTR3f9jlQ
	0IaIe5Cv1TYWGfNPLF9EQbQgdGtrm1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-dUEVXRiVOI2ZlCL-IIAGiQ-1; Thu, 06 Nov 2025 06:26:33 -0500
X-MC-Unique: dUEVXRiVOI2ZlCL-IIAGiQ-1
X-Mimecast-MFC-AGG-ID: dUEVXRiVOI2ZlCL-IIAGiQ_1762428392
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c521cf2aso615983f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762428392; x=1763033192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
        b=DxRNAGscNsdKU4rAsykkjf7xySlwZcWLuYCoLalPVvdA8G4oQpsKoDVO3DhakDYyO6
         ljTVz+ZHaAmjr19YWoxHKuOkxYKuEqFEtNPyejVAHsoyHtfuI7+DDy2Y5JuvANWr6CRu
         Pg2nkk9L5itwCSE3XwIpeNFBRm+++1jV4C8qJvaNnIAyam5y2Uc0Ry4rekskDm2JSl0n
         19B1TGaYTaLucCo0DGz0g7CfbwjjAKjjC1pYbYlRuSgnpPBjuANwFbhO1W06KJHyEvsU
         JoME8sn8gMiJInv/gPmzfroi9J7s5pVIwqgbywOozSMNpbic/LKR2ma+ib6/K/4TwTl5
         ToSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428392; x=1763033192;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
        b=sPlMXiRB5+wiwFI22YBpULu0/vDXpVKyz6x/oHKOHRicx3NHH+WwNCSH3Xnm/eM5fU
         pwHb4DYNLqM7UWKy98t/Um9/eTb31NbPOKRLgWp9Q2vXXM2iIXQ/jnX6ApAu3Xyeg8VS
         L44oYGo9sQhQd7hUUsS09odw06+69gD8Y7cdlWNie9Xutp91xlQQ/5VMM4sKvuUuHytz
         A0wXUZ+x3kz+L4HlzrBFUrhha+5dn6RLwYDW2XruEr8OCr9MNdUYYcWp5yESKdYrZO4S
         o18ys4SVYsq+wwAp6uwptdGobAyRUUxSv6HoMKAvurxj4iiLZie2IN0oDuCs1FZK1tax
         bYTg==
X-Forwarded-Encrypted: i=1; AJvYcCVMKrEnZNftprDG/tTBNNqERtqtAiBstrnhcX6jbgKn1hYVbNOtcE6LTgZDzQ6qLHfxm/gum6S0DzyPK4NFjuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEUOmnMieC3AzS/T6kiQSKBemBEvF/4F0TMa/niMHn+J/EIbW
	74azm25h+17H3WUMiJ7rChzdO9XxJfjD76GgJKRUpDz5TN3U/P9kiuGBQVfbyMHkfxT2/cnNlFK
	rGoTUgo9QZMVYSpQqf6ZKLMa/S/hVToEku8ouXnozuLoCJFuuHWt7hbPmalTY25uHOEX+qg==
X-Gm-Gg: ASbGncspK/XvaXDMmiRKHZZetK0EA2r9Z1Il5+xOzWEgWy35vt9NSLYikGaXx+nZs6i
	tcMsXN0PchU7GmLaVfxK83jedIpkK47Xr40shIZnsPtqLyGke4X4K7moD6DNvFKUr+rJGnTGi6k
	SAqlWZGJVxfzRogZ5EUemLPWj7mkpwa4DQrAXaepqUbZK5FH6EEF/qkUVI3wZuvPt0lqroslRIg
	8SzfLjli5f1q0xYVSVRyZVZuNi7VR56DFg9/PojmBXFP53jc0MbA5JfGCl1mu8SpgHl0gjmOvoI
	aYb4ZKnJHhy7qV6FKGAhjZvsfOECwxLME0s3EnAZPqDFoxjvW5gRcf6ZqCfHMYoS63mtiDl9mpO
	mtA==
X-Received: by 2002:a05:6000:2882:b0:426:f10c:c512 with SMTP id ffacd0b85a97d-429e330aacbmr5599541f8f.43.1762428391658;
        Thu, 06 Nov 2025 03:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTk4Fgt0+Mi1XCDO47kQQbIjxqGs2on8RBp/UBF82QmihADe45xfIjJ/TRK2eqLeeu+VVD/w==
X-Received: by 2002:a05:6000:2882:b0:426:f10c:c512 with SMTP id ffacd0b85a97d-429e330aacbmr5599487f8f.43.1762428391189;
        Thu, 06 Nov 2025 03:26:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm4564491f8f.32.2025.11.06.03.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:26:30 -0800 (PST)
Message-ID: <1c79daaf-c092-4c49-a715-52aeb9688b48@redhat.com>
Date: Thu, 6 Nov 2025 12:26:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
 <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Content-Language: en-US
In-Reply-To: <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 12:06 PM, Paolo Abeni wrote:
> On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> No functional changes.
>>
>> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
>> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
>> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>> ---
>>  include/linux/skbuff.h | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index a7cc3d1f4fd1..74d6a209e203 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -671,7 +671,12 @@ enum {
>>  	/* This indicates the skb is from an untrusted source. */
>>  	SKB_GSO_DODGY = 1 << 1,
>>  
>> -	/* This indicates the tcp segment has CWR set. */
>> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
>> +	 * subsequent segment in the same skb has CWR cleared. This cannot be
>> +	 * used on Rx, because the connection to which the segment belongs is
>> +	 * not tracked to use RFC3168 or Accurate ECN, and using RFC3168 ECN
>> +	 * offload may corrupt AccECN signal of AccECN segments.
>> +	 */
> 
> The intended difference between RX and TX sounds bad to me; I think it
> conflicts with the basic GRO design goal of making aggregated and
> re-segmented traffic indistinguishable from the original stream. Also
> what about forwarded packet?

Uhm... I missed completely the point that SKB_GSO_TCP_ECN is TX path
only, i.e. GRO never produces aggregated SKB_GSO_TCP_ECN packets. Except
virtio_net uses it in the RX path ( virtio_net_hdr_to_skb ). Please
clarify the statement accordingly.

/P



