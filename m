Return-Path: <linux-kselftest+bounces-25558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D688A2566B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297073AAE94
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD6120013D;
	Mon,  3 Feb 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LCbfFJcO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F4200127
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576467; cv=none; b=rFZs7uO/+NtSb6KDqhYTP9LJrQslgWndf49wpDCh46rpraDA/CKNP3n8gVHwGGK7OMI/NJOEOYFn6dwMiTGM3CB5eDXYrWkX4ClwXqumHpnz2zA/rPrpvjFe6LJc1zS85if13zj79pAPCqsoD15jtab7P64ft6X9aIfQ/YLT7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576467; c=relaxed/simple;
	bh=eSmxloYDYU8L7DSmQw+qJpOAKVq/lSAURecTBARj2aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdjElUxrgge0Ew8Je/dAMfVkV95Jrc45RlmJ3SAqMuyzeBj9eCOy68KH5sQ1GxrZPeRwrNoLiTQkklH8XNJyZVcBRgKatKOXt2FkuU0yvtXNTeJCKsKAue0nznV+we3iyNEq85Eq6bFjm4gD2uBh5jp7W4BLhGevkCACK4aLm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LCbfFJcO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43618283dedso43168135e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1738576464; x=1739181264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=96711Zo9CR2XVG17Nter5UiX4vK8kBFFsAbRByM3Gl8=;
        b=LCbfFJcOjseqbaie/9EPKxqNVz8GWV0SGSsJU9/9ALvKv3a6jgEI5gxaWP/sqkOizA
         BnFA+tMQXuRbJNyrZvYklQNRKk7YigpFhN/ElPNnmhXz7BkqWQAXOL8vET0q/NI7VR3i
         la7A+iv7/jyPE2ICOr6r9VQ73F+o9NuUE8hW/6ieSloUhrFoIvyHOJYfHqkOmpoA12cZ
         LeV+lQ59EYArpQTM7wzII22ceEYuaHkL4iDpn897cv+epFCFaaMPZDZw1zixMsmjScNc
         ASPvvmr4FHEduCM/aVbkS8i/x5aa+pnyXbIY9P9gCSZ8PnkQFjI5Fl0SqCxqPp0DWfio
         mCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738576464; x=1739181264;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96711Zo9CR2XVG17Nter5UiX4vK8kBFFsAbRByM3Gl8=;
        b=nEdFu5HsQZMkxrCZm3itSZciGhFGxPTYoVacSdciwe3PUP5GQYffyRtZ2cVCKTFQRY
         n/q+G1twYWF4viIc0+H1HABQgLA0tGopcFB1Upl6hB3TerPz93bCVedOfdf87exqS4qo
         Nc0K6WE/3ejxlphOFr2sRFXeas0xlbP3NkB2aXvdETtTnG3Xpb4syJe2dkmxJEiXAcsh
         iM3V2ISu3TWwEMoauju6Y0FqCng8FPS5dXMVKdKb1GZkQR2yrbkrcnQSehPXGvFpARJg
         hHrNW0vVS0qDwaV6ygVHwzC43Ga6D1h8ha7Rby6yPrF1NlqcA5axMVDGLry3OtCwpX/2
         AEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaxAruztzYvbFJjU2PFU6tdx+xqoXS8ZJYAWBLjuW1pBV1vscBKam6ITTx+CgEi8MbiX+oiau+a3n53y9Gs1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ERJ1L1BxartHdKmMxsv5NaH5J94kOft9ngbLVUIU/kXaMoO7
	cNQb/ka9RY5jY2eSBaSnneRPodD/2jofRATMY3s5DrDSq8lAcHwpc9OdEzpJtAI=
X-Gm-Gg: ASbGnctL/rW7+AkykFkRUXL60hwVhZ6f0WtBs/Io/g5D7J4vnTarKHB83nEWplTLHjr
	ehWNCZJftIhwZPFt+suYjYRdTj8wYeetvMrUw+rSHOPMLTONRhDhXSBC6oD17E0sxHtQOirAOrz
	WxlLcuwwapQvJ7tuwt4gY3L/mCF23uHBgL4t6gKwUI8ktkOp9mx3ZZ+KZtk7L4dSp8d8sxuODhg
	8PjCAE0W0/BS0cR78tiEV9VvwdFQZYKTbRsM5Xoo/nbM2LZo4NA6QSOi5bfOLNB/bj+Axqm06IU
	4J2wqdZGJ2jMo1L0jJd1o+EZ4HVjkGvA+HT4mociZeWoMZuUOVUQ4A==
X-Google-Smtp-Source: AGHT+IFAl7UbKfI1GKffJcPjedN1nuCRKvEEkQnMY9cXhghwcJTAvGfBl5nsP69ucOB3VdXDqNL09Q==
X-Received: by 2002:a05:600c:4e0f:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-438dc421388mr154443835e9.27.1738576463796;
        Mon, 03 Feb 2025 01:54:23 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b4fe:e6fa:32a0:6a72? ([2001:67c:2fbc:1:b4fe:e6fa:32a0:6a72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c11b58esm12003819f8f.42.2025.02.03.01.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 01:54:23 -0800 (PST)
Message-ID: <eb6bd31b-686b-4edc-bcdf-935cb452b271@openvpn.net>
Date: Mon, 3 Feb 2025 10:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 17/25] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-17-1f00db9c2bd6@openvpn.net> <Z6CKYA8ueI-ZGybN@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z6CKYA8ueI-ZGybN@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2025 10:20, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:36 +0100, Antonio Quartulli wrote:
>> +void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
>> +		       const unsigned int len)
>> +{
>> +	struct ovpn_priv *ovpn;
>> +	struct sk_buff *skb;
>> +
>> +	ovpn = peer->ovpn;
>> +	if (unlikely(!ovpn))
>> +		return;
>> +
>> +	skb = alloc_skb(256 + len, GFP_ATOMIC);
>> +	if (unlikely(!skb))
>> +		return;
>> +
>> +	skb_reserve(skb, 128);
>> +	skb->priority = TC_PRIO_BESTEFFORT;
>> +	__skb_put_data(skb, data, len);
>> +
>> +	/* increase reference counter when passing peer to sending queue */
>> +	if (!ovpn_peer_hold(peer)) {
>> +		netdev_dbg(ovpn->dev,
>> +			   "cannot hold peer reference for sending special packet\n");
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>> +	ovpn_send(ovpn, skb, peer);
>> +}
> 
> [...]
>> +static void ovpn_peer_keepalive_send(struct work_struct *work)
>> +{
>> +	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
>> +					      keepalive_work);
>> +
>> +	local_bh_disable();
>> +	ovpn_xmit_special(peer, ovpn_keepalive_message,
>> +			  sizeof(ovpn_keepalive_message));
>> +	local_bh_enable();
>> +	ovpn_peer_put(peer);
> 
> nit: could we simply drop this put and the hold in ovpn_xmit_special?
> ovpn_peer_keepalive_send has a reference on the peer from the WQ, just
> transfer it to ovpn_xmit_special and then ovpn_send. No need to
> pretend to acquire one for ovpn_send's sake and drop the one we got
> from the WQ? (ovpn_xmit_special would need to _put(peer) in case of
> early return)

Ok, will drop both and add a comment to remember the casual reader that 
we already hold a reference (+ put() in error path).

Regards,

> 
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


