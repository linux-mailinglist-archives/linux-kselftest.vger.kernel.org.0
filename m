Return-Path: <linux-kselftest+bounces-25559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED88A25682
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2111A1624CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AF74BED;
	Mon,  3 Feb 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="A1lxCtBy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A200127
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576671; cv=none; b=RK5b+3ABoqkfeLVCrRFoNQRLYYQatu2aCtDhMYjsgGTSYECiHp6p6MJoAgHXPd/y3KN4bAq12DQ0tP6BI3VLVzaQQqJYzBrsCDffSDONVjSapB1Bz9XTvrwRmOSjqNZgG4h+7sQXaVuqIvSBiW+prJ4Ej0V2YsvCac6PhHgTBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576671; c=relaxed/simple;
	bh=3J9JPFbKZAcnsJjiLASnNkOV9pbMine+fJn/Vh57Yd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwN+ckTS7qsTXRFuyhFcZ3hv4LYeGOtVyqkTWOxFNuuyqgddy54Ein7D63aaG5VcFUxdAt8x2GQC2r4ZfP11mpyLzkr4QsXWuH0fJWj8MfVUdgQ1CCVB8b01rm85mlXFJwddc4hubQk68+QqvZxiJES6H0Vq8jQhtGmoCevCkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=A1lxCtBy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e0e224cbso2238645f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1738576668; x=1739181468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xCekcWD5QVOQ/qX+k0IgYcb8XegbhQ9qzP12xPRWLzE=;
        b=A1lxCtBy4/ORz+JHL50X2VuWFnrsiyKdMRGHd/Xk2AtNTBDcQOpeJr1wZt2oKK4yQ2
         qMM8hjrWq9isV7Cv9rgP4hPBdWBLG3WxztLyUx4+WwqyxmBWwdpM2mUlEDwnOr18c+OR
         5iXKwKe6k0u9cXQ6WVlL1ZqZLbZxeTeR1sr8nFlssqbb0j/BG57NcEKs9s2xCsnUV+yF
         StLw5vgS8wO/QFRzL8L2pAEnnEnkGd5VQ8VhbclWHTkMeZEbn0xm+vnR66vVK1rmdawA
         jb9JffTM1lFBPnwAeLYEy5JvOvQuVQaWPTWmQ9qsNZ0O0NW6UlirLK55OzeiK9V3mkqu
         S0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738576668; x=1739181468;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCekcWD5QVOQ/qX+k0IgYcb8XegbhQ9qzP12xPRWLzE=;
        b=v2YXJ5FHnB7z0KUhY6aE9pekEcl4iQuqonuUxx79EPp4n6ZByi9BvJTHrUFA5+4VRu
         Q2vpeTe84xLuEH/Pbl7cWv7DKPUCU9MYlWx+9Nw24ZM278lsb4xUnwxcOcOSZcY8wmTq
         kJYmlP+I83ADGN6BbdLjan8zrtv4LZDXHjajj33xjixvzWaKFOblRHmNTpmUYcyfiI8G
         F6Xk86t+BjRYOlLph4W5Pu1jUQ1T1mMTYpd4wlpRUMb2423CuhUNGlHHgDrQSjCepULT
         KD9ONSUz3xuJT5Bg230G9SrRpbGgjJ2o/SDpRh/roI5CdwKmFdqE/V+z11pkK12/5wVV
         sDrw==
X-Forwarded-Encrypted: i=1; AJvYcCVtur93hOR3d+zlJabLyUO4FHKFdqMJ3/gtBujPLbkBvJHl85encQ4qXBCOfGFZSnU64TCFJ13RF/VdzTzV02o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIsJURL/ZbwM9o+Kvp/L+ULg+DuGPVR/oNkWGZBEW36mlXwlX
	YIkSf/o9upBEX58K4/GVdfYNBVsxuRItJMI9pX4IqrjI5jcZKlFnxTPqHbGScy8wRVteGWgnzLE
	l
X-Gm-Gg: ASbGncsVhGhmqoy8VBa60LP3eI2WcjfESQDt3VirAOwN2OZaEOJhdJDm1RrgUhAY+3G
	KwD638bxlprNo+SP16eDbgp6BGFANu2f6mG/CRhZP6k+Feno5mo8k9uu/lrPdEbygknONKo6VrC
	PaGeiyFVsXyaAETPwVV9QNohK52ii61oou8uyvx3HKk4nd5ocvDz8Z1LhVtRCiafDu3BLaRW2ft
	RUCLz2QicPqzbq3VlKBx4Spayj6wcTV7YRo6ASH1aHC/3B06VQ9m4KMqsAmB6eM27hXz9XRN3bx
	91JqkXa04SMRanpX5H/Iin1hU39jlsIA+/iSzbJLQABx7KOyErODSw==
X-Google-Smtp-Source: AGHT+IGOhzqTSZM1gbvEpAzQbJ5R33devHozuArV3fQ0GpQu7T3Tj7/+HxdAYzOpsyGWp2I3dm+7mA==
X-Received: by 2002:a5d:6c63:0:b0:38b:ef2b:422 with SMTP id ffacd0b85a97d-38c52096052mr16730087f8f.36.1738576668015;
        Mon, 03 Feb 2025 01:57:48 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b4fe:e6fa:32a0:6a72? ([2001:67c:2fbc:1:b4fe:e6fa:32a0:6a72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf364sm12135348f8f.88.2025.02.03.01.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 01:57:47 -0800 (PST)
Message-ID: <2c22945a-1906-43a6-9339-d097242ac5fd@openvpn.net>
Date: Mon, 3 Feb 2025 10:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 08/25] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-8-1f00db9c2bd6@openvpn.net> <Z6CMmJyJwZBuV-lC@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z6CMmJyJwZBuV-lC@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/02/2025 10:30, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:27 +0100, Antonio Quartulli wrote:
>> +/**
>> + * ovpn_opcode_from_skb - extract OP code from skb at specified offset
>> + * @skb: the packet to extract the OP code from
>> + * @offset: the offset in the data buffer where the OP code is located
>> + *
>> + * Note: this function assumes that the skb head was pulled enough
>> + * to access the first byte.
> 
> nit:
>                     "first byte"
> 
>> + *
>> + * Return: the OP code
>> + */
>> +static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 offset)
>> +{
>> +	u32 opcode = be32_to_cpu(*(__be32 *)(skb->data + offset));
> 
> vs 4 bytes actually read?
> 
> Also for ovpn_key_id_from_skb introduced in another patch. I guess
> that's a consequence of switching to those FIELD macros.

Your guess is right. I'll fix the comment.

> 
> 
>> +/**
>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>> + * @sk: socket over which the packet was received
>> + * @skb: the received packet
>> + *
>> + * If the first byte of the payload is DATA_V2, the packet is further processed,
>> + * otherwise it is forwarded to the UDP stack for delivery to user space.
> 
> nit: not consistent with the implementation in the case of DATA_V1 packets

Right, I'll extend the comment.

> 
>> + * Return:
>> + *  0 if skb was consumed or dropped
>> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>> + */
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
> [...]
>> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
>> +	if (unlikely(opcode != OVPN_DATA_V2)) {
>> +		/* DATA_V1 is not supported */
>> +		if (opcode == OVPN_DATA_V1)
>> +			goto drop;
> 

Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.


