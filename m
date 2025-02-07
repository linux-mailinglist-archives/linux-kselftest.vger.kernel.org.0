Return-Path: <linux-kselftest+bounces-25995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C074A2C34E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B752188C234
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425061EC018;
	Fri,  7 Feb 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XK/cYaOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA71DED70
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933955; cv=none; b=taoqAafahUAou17RyZ82t1MSc4tBDxE7q51yh4TlSitwwqrzqzZ+Fsvt76q5Nwb/YQjzHzH4yvqXTj2HRXm3i90dJiWASudKiB+em2CD6SP1Qj0RhcB9UKC9fl1r7aOrk63GewtM+3A6Urjo/X2JXKE0bBgNonKfo6Q7eJ8zJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933955; c=relaxed/simple;
	bh=V8LDVkl2nRQ6eAdBK40xG1bKfK4P9CzdnIHedeqf3Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W59XVn4GiJns8k+aFpW5ZhQh+/bfligcGWCm8GfF34bJHwzHdEFaB452wngsRj2zQOZR0V7SAitVO8h6LLlcJtZkJanJOyL1vTOE24IXq90q6KuXgkE6O1JNgp1Mdp4gq610601WDPTjRjcaMTjllDxPD6O1ncAeHEivbIw3qRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XK/cYaOa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso13674225e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 05:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1738933951; x=1739538751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ULYqwQI7CRaAqRL8oB/X08x15C2FHRC/9lLiC6I/SiA=;
        b=XK/cYaOaEdxWlPmatP+1cDEoWY86h/rHp6XPTISPoA19PK9HjNN4IPbVCTUMCklbsL
         NZsl9+vVOXScvoSBGykt7UkM25yN2Fe0kSvVKmGp5lWiutfY9Qm4XFyklSyZ33ZOaf0y
         yMrEH6mqigDxcBUqtPhIPJgkmc8SnfWPIOvPJVUdmrheFfWx1C4w7tm1tPdcIMVRTMUZ
         lFQRpn8ntvuD9SjNiJppZeXjMDpI9OtyXXTf9WPml9rS0r/aN+l2tZ/DbSvG9EaTlZ1J
         np4fNTrVnvpNbjYmanOfDXIt5WOw/vGDILpjox8sMa9JQpDQSIFhkdgWyGcKJT0aXWLX
         CW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738933951; x=1739538751;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULYqwQI7CRaAqRL8oB/X08x15C2FHRC/9lLiC6I/SiA=;
        b=qx3nvdMUPkBagbzkWbKvCsFRi7tUibpwA0LPU4xwUHeSUIId2OzpwLByR71TqxTA67
         Z5bQ8R0bC0Yws5JBs41cmct1hGNMrD83nZAPG6qXMuC8ofpMetcd/wrkTxaj+wfNwycj
         DtFdTBspVfu/NAXw1ybOCVrsUt0wfesFBRKTIuj/ErKTVRBTTsgbl9qdabKps+251/jI
         6jhSj1rZvQSHKGygKQCCknuh8XUl+2FKQwsgPlR96qisIYF0nQJz3UFk5T1YZ0OwAcy/
         rpL6usRfuuedxH0M/jiNVojf5vhZypWIHR810B31ZQOwB/EUuwtVBnYPgIWNrwn156mA
         smbA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJKVAs+7ibWiViT9qY2SLpp9/NrxL2lb4bvFAU0NzNeh/wkfKncl/GWDh0s6zq3ExbTG9GtTV618epR8TYc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySurs3Kh6Pczh4EPwlQEVXGkn8Uvw8296C3KPnWZKcJ8G9aH1/
	xykXSPOpb/tF9fRCP4zykfBkZsoyW/eYDmW+I3ZRH4ZiuM9RBPA4MElvJbLp3uI=
X-Gm-Gg: ASbGncvhFVy4jkfKHTU1qNxdmvHxWJleSlMI8h8cE0Juhxtcy4CPrZzPBFRy1B0RxsD
	g3I62zbhlfYAYHWS5gVx1bXGND1XvNUpRRuqZJP4rBNaTwO5B6C8Siki9kIPMdoXwPHxlcp/A0f
	Wztj1vOhj/Z0n1rzv2hspeyRVbOs2gQUuSruMIFZq33rSgHB+cLT/ZglyzPSZTldMqqopWO8IAn
	XY5+noz3cFAKbY2mcXN/gJkX0r8tmKS7gpZnAbOw+Of07S5upjkOMrJUQXjZvJHbZK86+16vKR/
	3w/bGn6emycvUz8e5eIMUiY+ICGYvjnNx26wYJYCsVHfuubybc+OgQ==
X-Google-Smtp-Source: AGHT+IF9wBsCSNNxAMG2g04BTTFcZiuGmMSSq1jpBjzRykjiBDMEmwtMfluBKIAcP83yb2c/VLnsOg==
X-Received: by 2002:a05:600c:4f52:b0:434:b9c6:68f7 with SMTP id 5b1f17b1804b1-439249b2ba4mr23665845e9.26.1738933951145;
        Fri, 07 Feb 2025 05:12:31 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:5aa9:f4c3:dbe3:332c? ([2001:67c:2fbc:1:5aa9:f4c3:dbe3:332c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d7c7sm88973265e9.14.2025.02.07.05.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 05:12:30 -0800 (PST)
Message-ID: <3dca88d7-7037-4721-aae7-35970e97be21@openvpn.net>
Date: Fri, 7 Feb 2025 14:13:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 09/25] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-9-1f00db9c2bd6@openvpn.net> <Z6PdEurGNirlnkoM@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z6PdEurGNirlnkoM@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2025 22:50, Sabrina Dubroca wrote:
> Hi Antonio,
> 
> Another one I should have spotted a long time ago :(

better late than never (I think..)

> 
> 2025-01-13, 10:31:28 +0100, Antonio Quartulli wrote:
>> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>> +		      struct sk_buff *skb)
>> +{
>> +	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
>> +	struct aead_request *req;
>> +	struct sk_buff *trailer;
>> +	struct scatterlist *sg;
>> +	u8 iv[OVPN_NONCE_SIZE];
> 
> You'll have to kmalloc this as well, it gets passed to the crypto API
> and with async crypto, it'll be used after ovpn_aead_encrypt has
> returned.
> 
> [...]
>> +	/* setup async crypto operation */
>> +	aead_request_set_tfm(req, ks->encrypt);
>> +	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
>> +	aead_request_set_crypt(req, sg, sg,
>> +			       skb->len - ovpn_aead_encap_overhead(ks), iv);
>                                                                          ^^
> passed here
> 
> 
>> +	aead_request_set_ad(req, OVPN_AAD_SIZE);
>> +
>> +	/* encrypt it */
>> +	return crypto_aead_encrypt(req);
>> +free_sg:
>> +	kfree(ovpn_skb_cb(skb)->sg);
>> +	ovpn_skb_cb(skb)->sg = NULL;
>> +	return ret;
>> +}
>> +
>> +int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>> +		      struct sk_buff *skb)
>> +{
>> +	const unsigned int tag_size = crypto_aead_authsize(ks->decrypt);
>> +	int ret, payload_len, nfrags;
>> +	unsigned int payload_offset;
>> +	struct aead_request *req;
>> +	struct sk_buff *trailer;
>> +	struct scatterlist *sg;
>> +	u8 iv[OVPN_NONCE_SIZE];
> 
> And same here.
> 
> (maybe something for the todolist: ovpn could copy the alloc trick
> from esp_alloc_tmp, like I did for macsec_alloc_req -- not required,
> but could be nice to avoid many small allocs and all their failure
> checks)
> 

Ouch, you're right. I will pre-allocate iv as well, like I do for sg.

And thanks for the hints, I'll add that to my todo.

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


