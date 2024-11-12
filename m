Return-Path: <linux-kselftest+bounces-21838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED49C4B94
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 02:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1642845EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843D8202646;
	Tue, 12 Nov 2024 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZSck34j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7252572;
	Tue, 12 Nov 2024 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374265; cv=none; b=Zz87Nhx8ESRh0iNoPH8W/pxUe3CBO0OZxZmUMo0z+cpN+goz6u9GEB1dpqboWsdYmOrxLL8te8Oks+ygZ7UBLGolBX380mtm4+wXi8d8XcvXPQ6j1SvUvX+W+DLKqBWdv3sovDRuVyngu0wWAuSUgxXC7VLnbFwNxzaeg/ttakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374265; c=relaxed/simple;
	bh=ZdG1VCyXGcU+y+nA0zmhpXDvNCF4CluPlQFAntAsTJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIym4tNYCO5zBGnXO83cu4vqvGDyMaufl33usM/ay5IQH5suWcDSK/SMdLZwvnk+BBiZXD/oLUSwayDwkMlMVdbMOB2A7Zx2cItwFGj2bBSRqGR86IUkYl/FsMhlyEMZo7gCdnheBBX33bbD87k1Kx2+4Yp+Str77ebQINlQ5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZSck34j; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314b316495so42094915e9.2;
        Mon, 11 Nov 2024 17:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731374262; x=1731979062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ne/bd+W1n2p3vHCrrj2V6GGyoT0RefIUjlO96tIN3/w=;
        b=iZSck34jUF7NmN5IrV9kNKe/3MwGkd1Xe+vNFQK8b1SnVMcGcaQ3mzJl1OFXte9r0I
         5jyhzkdub8j0yPeDkJjaNGYZvA48B7Fw15a8EkcuyidCElowNcC3IdsNibQLnPloTSYt
         kEdaZX3I90JKb5a91nAVfLp/yPaoo3IvfY3rMx2f5WQ1JxBjW5EoVf3UFaxoWa3NuvrT
         qf1oFl3J6r0KdrPZLtMm10x0NuJKEU9KrlSeU8SrXf377vZIIzCyvg7ZzEV2K/ryPT70
         ChOGN47zpkVd8O+fU4L8IxxFzH84CsAiHXul2cacBfrmQ/D4BIL3RHIQ195QUChjKkwW
         sbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731374262; x=1731979062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ne/bd+W1n2p3vHCrrj2V6GGyoT0RefIUjlO96tIN3/w=;
        b=ImDCKY2OhYpKDXG5y4m85aDhJcCOwway+M6aFAUNAObCk3SHix1eLAFUMqw//ahklx
         GPO0jc0bzwVMwqEi+1Rt/yH5eGCXWiTLf+JTUOa9+edIUfqSvEIPqomRhSj7JCSXO9fQ
         +P8d6/4CLDD8KY3AEoCFcamlOb0/KTVyJ10GxyHg8pWCIcgnNOJEj+a/MW0xydxFSUMi
         6kl3VkCmZpT6QrA/bv4cu72jApEfdoHOmf11KeCAkdwxivCDi+tojVX3Ax2+2KOeJJzw
         uGmGZVVrUXPvVo5za+OdV6XptNvnGB7MwLn49XmX0a3rRJ4XrFDJ0tFWIsKgG14Pow65
         X5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ydkZv441fP8WUjvJBh2x90BT3lxFPwwLQMV1Vttg2IjUbHb72c/rXHEjZgSnTxJZlxAQi1yzWVxHQWRrlqv0@vger.kernel.org, AJvYcCVsCfkV1ILRLLoaib1n71kZjxaXp3/cU3B5MwTGrQXPE/qBi1/zfgdcRsOGzzFo2KZDGmhvm7O7XfDUH1E=@vger.kernel.org, AJvYcCWvPqNnGMDhmKMTOScYpSXjq1N2o/HepJ++P73XnDeqrv5fbqvpZX4NQtSL2MmOU2xXPWVtqljs@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7DpgUhHP1bXJ/Bi1T12xYqek21npsBUBPI9ci7Gbmcb8iUgA
	I4zHJr2FuNh6M8cDpukUJkAue9xd2XGspB4emjf4VGmB2tA+Xz5u
X-Google-Smtp-Source: AGHT+IEjSvctcngzwW5PzbiL3sp/qwa0x6Z0ktwREcZVjlg9cGCeVrJLDLYFH9bnY8Q/5GT+vrDQYQ==
X-Received: by 2002:a05:600c:a04:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-432b75172d6mr114769695e9.23.1731374262035;
        Mon, 11 Nov 2024 17:17:42 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda036afsm14216406f8f.86.2024.11.11.17.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 17:17:40 -0800 (PST)
Message-ID: <77c2a569-6f6c-41d2-ad85-2b0d71e9bae4@gmail.com>
Date: Tue, 12 Nov 2024 03:18:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 14/23] ovpn: implement peer lookup logic
To: Sabrina Dubroca <sd@queasysnail.net>,
 Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-14-de4698c73a25@openvpn.net> <ZyivdrpZhx4WpMbn@hog>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <ZyivdrpZhx4WpMbn@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.2024 13:26, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:27 +0100, Antonio Quartulli wrote:
>>   struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
>>   					       struct sk_buff *skb)
>>   {
>> -	struct ovpn_peer *peer = NULL;
>> +	struct ovpn_peer *tmp, *peer = NULL;
>>   	struct sockaddr_storage ss = { 0 };
>> +	struct hlist_nulls_head *nhead;
>> +	struct hlist_nulls_node *ntmp;
>> +	size_t sa_len;
>>   
>>   	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
>>   		return NULL;
>>   
>>   	if (ovpn->mode == OVPN_MODE_P2P)
>> -		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
>> +		return ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
>> +
>> +	switch (ss.ss_family) {
>> +	case AF_INET:
>> +		sa_len = sizeof(struct sockaddr_in);
>> +		break;
>> +	case AF_INET6:
>> +		sa_len = sizeof(struct sockaddr_in6);
>> +		break;
>> +	default:
>> +		return NULL;
>> +	}
> 
> You could get rid of that switch by having ovpn_peer_skb_to_sockaddr
> also set sa_len (or return 0/the size).
> 
>> +
>> +	nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &ss, sa_len);
>> +
>> +	rcu_read_lock();
>> +	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead,
>> +				       hash_entry_transp_addr) {
> 
> I think that's missing the retry in case we ended up in the wrong
> bucket due to a peer rehash?

Nice catch! I am also wondering why the 'nulls' variant was selected, 
but there are no nulls value verification with the search respin.

Since we started discussing the list API, why the 'nulls' variant is 
used for address hash tables and the normal variant is used for the 
peer-id lookup?

> 
>> +		if (!ovpn_peer_transp_match(tmp, &ss))
>> +			continue;
>> +
>> +		if (!ovpn_peer_hold(tmp))
>> +			continue;
>> +
>> +		peer = tmp;
>> +		break;
>> +	}
>> +	rcu_read_unlock();
>>   
>>   	return peer;
>>   }

--
Sergey


