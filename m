Return-Path: <linux-kselftest+bounces-21220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA39B7CDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC22812A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96608126C00;
	Thu, 31 Oct 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NuSRizWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22049641
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385038; cv=none; b=NnAnwkGMoqP2ZPpdAWR6SoJdguDOjg8k2jPiD7lygVWu/gpWb41wi/6hNHZpJIyjECcdp0csnqrJyXhfTxZH2FEuGsKM2fRXZR1injuoay7mtEf2x3Qqkc0CD+tUoWC4Q8dicyiIdC8PgnDztfEOgg0ABXSSzTd/rz5wbTeTVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385038; c=relaxed/simple;
	bh=sf5Edl6OUhWsEI6hsK/f/VAjBnY0HljV6kRGy3xX104=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g321c3F3yf0UUkuhmNRTbYF4RJ0kSz5fPG3gvBLp+3fJA41YVd/Qj1zpR/wH056aaF0Gndg9xJ3LdUHwM+5OlLIYaioYFd4dNdR8QKhhancXdG60/fJ5ms40mzZLSp/bE2e5ktmVsiPCi9wYyAPWPp6LePb2QuGtLVkJrcoRVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NuSRizWg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso137962966b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730385034; x=1730989834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=36vCp20jB6EpXAGLlnLrA4E+EFdE8ahvTSL6cu1oL24=;
        b=NuSRizWgiG6mFdbkidfcnpTNduu34SvzMmoEhy6nkCsosnxRuX3+nW4hXh0oDijA7E
         ROx6NWOqf4mAKTrdl4PyIhgrpITmx+U1MZsYAm5aA5XdSfAWiiapV4eDJ+7gL2fXBNJe
         vurRxpG54fSX4OAL4cEs8cS2w266wEjmPU4iR80+PDUVUL/UxGZRbc1HwHlQGPdugsR7
         /Cicsx9vYn4h1gnX5tU5KA7MHWsHtthvPBFjzxqYxnwGnFko/qwKuk7+k3iGW5RPM/mu
         85TKBPHtQSCxAnpqU+9BAO3gTE2uiYVtu4ZLKDUni53vhas54P0TLWGby2p4h48S0S+C
         yPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385034; x=1730989834;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36vCp20jB6EpXAGLlnLrA4E+EFdE8ahvTSL6cu1oL24=;
        b=mI+26LvQkzfJBJMyJPBcXl0CXVZ5YuA9uZzOPEP+bE3jQ5PApA9TLYvsqWHjo6qJPA
         aXQ8mFUdBYnpgZyRrWMvXAsVjWRAGyJV6BY+CHcXwazh7SW0RGUs4Y476PNVHF8MnQua
         RHSYOaRsJNdOj0Z16HafxlSxBYlomfe7ZifDXFLMlq6VTmvxeKPjFd0+gEKjsZpLEQKm
         FLbOKjEkuLUhZNMDZvAzoQBNVLjg48sFlk2Z/7FMgBjFRgEF0tZtixfNg/mFpx0cxbJN
         VTzeatErQ8+PNyUIrJcuZacEHzemxZptEoXnbuFNDO2GPk1z0BBuHnKQRx8KUUNjHm6F
         9UQw==
X-Forwarded-Encrypted: i=1; AJvYcCVvaTiJ58l/pEk9pu7dmLPAg5Qcs4zZI5dhFLg2v+9GpJ1IhcIA0IdAwyS8mxazJ1jLCaHrtHQjP4rp1aV4PxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0Xz4oZh7So73OjIg/BTMHUuycSIsHJn5tif0NyTGJHhdCLbR
	xtyc6DZxuTkXThWJXasHpEtwHxMLu7VkFWDTZ16mv1jshmA9zNwGtQa3IjOLP5A=
X-Google-Smtp-Source: AGHT+IF5Bg251mik3LoFKpoC9lOkrQj4vtOc8BKiQBo2Rp/7AcrfUz5H7OhmqB9uWxMcp5Yj9wGc0g==
X-Received: by 2002:a17:907:9405:b0:a9a:a3a:6c58 with SMTP id a640c23a62f3a-a9de5ed3e2emr1930012666b.22.1730385034287;
        Thu, 31 Oct 2024 07:30:34 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:634e:2582:d0aa:ee79? ([2001:67c:2fbc:1:634e:2582:d0aa:ee79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4d98sm74941266b.66.2024.10.31.07.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:30:33 -0700 (PDT)
Message-ID: <7d00738e-ad12-41e4-a0f8-eebc30c4fcda@openvpn.net>
Date: Thu, 31 Oct 2024 15:30:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 12/23] ovpn: implement TCP transport
To: sd@queasysnail.net
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-12-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241029-b4-ovpn-v11-12-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 11:47, Antonio Quartulli wrote:
[...]
> +
> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
> +	if (likely(ovpn_opcode_from_skb(skb, 0) == OVPN_DATA_V2)) {
> +		/* hold reference to peer as required by ovpn_recv().
> +		 *
> +		 * NOTE: in this context we should already be holding a
> +		 * reference to this peer, therefore ovpn_peer_hold() is
> +		 * not expected to fail
> +		 */
> +		if (WARN_ON(!ovpn_peer_hold(peer)))
> +			goto err;
> +
> +		ovpn_recv(peer, skb);
> +	} else {

As pointed out by Sabrina, we are indeed sending DATA_V1 packets to 
userspace.
Not a big deal because userspace will likely ignore or drop them.

However, I will change this and mirror what we do for UDP.

Thanks.

Regards,


> +		/* The packet size header must be there when sending the packet
> +		 * to userspace, therefore we put it back
> +		 */
> +		skb_push(skb, 2);
> +		ovpn_tcp_to_userspace(peer, strp->sk, skb);
> +	}
> +
> +	return;



-- 
Antonio Quartulli
OpenVPN Inc.


