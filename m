Return-Path: <linux-kselftest+bounces-28254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02438A4F18A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2279116DD2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A721200B9C;
	Tue,  4 Mar 2025 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fsf5Nm5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29327BF79
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131315; cv=none; b=lZiIbivpKQBwMVk66tviUd0PSHjQs03RT8rVR1FF8T7LtUT9IFi42p01vFvSq6Tvf7j/+2SZ3iWYmohB7Ppb1bewZt0CCA5RNGF8vuUzk/zNce5OpI6zKgnLY2vHHZBamOO9KWjnEmY592Az/1R4YKW1doeGla61o5KQHqP0Uc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131315; c=relaxed/simple;
	bh=b4qtIOrmLh1Z7cVxpxlBsOJOAP3UoysGxLur//SFHGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obDI0Hb3I7WDuuxXw/UZynrhf/US7G2dEYQqpxBRGh9HaG37sqwzgGPlmRdsQJSJItx9Y9ssJT+mGZVv8Z/upCEg1wQTFsFEW3XLa3CTXp0s6rzHs7SqY9oO/kCX3FDumXALLGCKIQqLbceJxiz0mIcr7jnzgFPPKM5Ol65XHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fsf5Nm5P; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf48293ad0so634347866b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 15:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741131311; x=1741736111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tIh8iuivUJc43wpWxKRA9nSxRI/Or2pcqJ7MBjm7lr0=;
        b=fsf5Nm5P85jTjx4WSBWjkbDtxG1CZn1QwGJQZFofC8o+mThWdjT2KyelxK2pRr15St
         BGTI5wL1fKuospEbMgybn0bssyUqHvukwKwqc5YxO14cmCCY0aoyCXiIf7S8XL7QGmKO
         Ffns5f3Aw5IWVt9Ujsk74a5MwVzA+aKRJcVcFZ9aNfFF3psnfeWwPCQOxzAOTGEduSoQ
         F09COMxHWDT9PdKHTW0rJNqgjXm08zjry402fAFTuqrfzKG6GOTgC79P5SO12mmn55Pg
         wmEx5oBCqNZPqkEpITwBNU3fX9UXGXucl7FbauxBluReDKJTRiy4O4ObeuvuYrxSQOhv
         opGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741131311; x=1741736111;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIh8iuivUJc43wpWxKRA9nSxRI/Or2pcqJ7MBjm7lr0=;
        b=Eoj4G0uKqOPC2TBniSJ4xE3mhoaoZR5A1awTA6lqsXC9Udzl+Z53cTDH3SijT6ExZp
         1JzUQYfA0Gq8wUeeobN3YOiU3ubXwRVle3mnDWgsuSIkwzK71ltqYOJAwxj5lotQI8J2
         J6w8P0bSxBA81Y8s2qvyxCFC2MveLknpexNPuA4OwQKVFxaKxa0JicRceKqlb84TlNXR
         IthvVmT8kMw738b5dr7eU/zZ66RtU8iGwl60fcGeMRrj6PBxsQwtuG+tMO2VdrAPTUN0
         DoOGgh2VVhmX/q7z7n+0C1KkwJ0FWvFGiipQdAY9sCHo0+ANT49TBvmIFBLnJJ/Hsban
         CnqA==
X-Forwarded-Encrypted: i=1; AJvYcCXCvbTMxM14KaZQIxDrUUxp7dlgnk/nyS9+oA72B5mjM0E23TgyKkixj6Zoo3PkfN3zXaLOesGysQeyxZJ9urA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCUofx6aWM1s2fzg6kJvCvMaUQeTIOWkvefzUx2mxbhHP99Ps
	bPDslUhv5FPin5ASPgoLea7pZKfFvYwe/GBksa9VzJ4fJdrc7S/FOA9dhz/OlGY=
X-Gm-Gg: ASbGncuquKSmMs/EAgj4fLKsEV/tvldkqsno2cBKiNjxEfz7kwFJzOzrk0/iMvr08rL
	Ek4TQliOXNf8EqCtrnhFTOW618F/IMvzPujTX4JXpKdvVN39hkjic8VS43bgFWnrHYG6eG7VU1C
	+ICGTaWJbpt6Ru5aYbSBL1h5YTVy9Epm4aR8ewWj053JBq2dx9bd5zPrZBMmkcFGkRkVGaNnOa/
	vTEVKkWoTWTW77IGNUBSmWqIwVwQ+gra1iipUYxFTs6vEM0rx4trZn/MdXGvjT2DigL/tnRsUo/
	eynfm9dY6q9y0dtzEhfEkgIQPNMgRv2SRBTrCJNSlsj8rCT6PUxaTlaJ+r27kFXdkb9rVAcdikg
	jjMrGOUk=
X-Google-Smtp-Source: AGHT+IH/1rT9+u6NN0el0qRmg3R3D5M0hLuERvqy+T2pMk4JxVKczv8yuKDiOs32UTOiZWT8upbkdQ==
X-Received: by 2002:a17:907:9692:b0:abf:6166:d0c9 with SMTP id a640c23a62f3a-ac20d852cdfmr102158366b.2.1741131311292;
        Tue, 04 Mar 2025 15:35:11 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2107:3d4f:958a:fa5f? ([2001:67c:2fbc:1:2107:3d4f:958a:fa5f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e9c1c0efsm250023866b.52.2025.03.04.15.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 15:35:10 -0800 (PST)
Message-ID: <8abd4290-cef5-4ea3-bdfc-b872c16efb8a@openvpn.net>
Date: Wed, 5 Mar 2025 00:35:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 09/24] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-9-d3cbb74bb581@openvpn.net> <Z8dOOy9tSpJ1UCiR@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8dOOy9tSpJ1UCiR@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2025 20:02, Sabrina Dubroca wrote:
> 2025-03-04, 01:33:39 +0100, Antonio Quartulli wrote:
>> +struct crypto_aead *ovpn_aead_init(const char *title, const char *alg_name,
>> +				   const unsigned char *key,
>> +				   unsigned int keylen)
> 
> nit: static? I don't see it used outside this file.

ACK.

> 
> 
> [...]
>> +static inline struct ovpn_crypto_key_slot *
>> +ovpn_crypto_key_id_to_slot(const struct ovpn_crypto_state *cs, u8 key_id)
>> +{
>> +	struct ovpn_crypto_key_slot *ks;
>> +	u8 idx;
>> +
>> +	if (unlikely(!cs))
>> +		return NULL;
>> +
>> +	rcu_read_lock();
>> +	idx = cs->primary_idx;
> 
> I'd go with slots[0] and slots[1], since it doesn't really matter
> whether we check the primary or secondary first. It would avoid a
> possible reload of cs->primary_idx (which might be updated
> concurrently by a key swap and cause us to look into the same slot
> twice) -- a READ_ONCE would also prevent that.

Reason for looking into primary first is that we will most likely need 
the primary key to decrypt the incoming traffic.

Secondary is used only during a small (if at all) time window where we 
moved to a new key, but our peer was still sending traffic encrypted 
with the old (secondary) key.

Therefore optimizing for primary-first may make a non-negligible 
difference under heavy load.

Code doesn't get more complex due to this logic, therefore I'd keep this 
version (with READ_ONCE(cs->primary_idx)), unless there is a strong 
argument against it.


Thanks!

> 
>> +	ks = rcu_dereference(cs->slots[idx]);
>> +	if (ks && ks->key_id == key_id) {
>> +		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
>> +			ks = NULL;
>> +		goto out;
>> +	}
>> +
>> +	ks = rcu_dereference(cs->slots[!idx]);
>> +	if (ks && ks->key_id == key_id) {
>> +		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
>> +			ks = NULL;
>> +		goto out;
>> +	}
>> +
>> +	/* when both key slots are occupied but no matching key ID is found, ks
>> +	 * has to be reset to NULL to avoid carrying a stale pointer
>> +	 */
>> +	ks = NULL;
>> +out:
>> +	rcu_read_unlock();
>> +
>> +	return ks;
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


