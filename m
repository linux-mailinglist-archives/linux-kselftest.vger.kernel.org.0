Return-Path: <linux-kselftest+bounces-28058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B77A4C3B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76131170FDA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78467213E89;
	Mon,  3 Mar 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cpHL34xq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11878F3E
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013130; cv=none; b=muVmtE/+gcjHFfexDvofx+zA3AHRI+cFzePJU57cuTHAKu4/WdfaO2O1kB5TeJdjH86+lRPomASPHhO8nUKhEc40DAh+rOMPP0nTGWf4FQPLY4JPHccXd08MB0KFEN4HivKOxsfVazfEvDMEnY390otgiX2srkXWp3T8KUAzzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013130; c=relaxed/simple;
	bh=kxRrZd4Iu1g3Ar2HC6xOBpvwsjl7MXVzQnlV/fNUQEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acMsmClgWQvITPEQH1wFJ7PAFs3KQXYvh64quDTOZRJeICTCvH//RcoTmIn6uFh4FnyLycYvYwjzrSOb5Vn7S6y2Bdy8W9vjFm9S4D3v+AS4ABY/ghsufPajMvR6dsRjFAKFd4h/Zp50SF5xu+0i9V2zLn9eOdpErqhGkm6jSvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cpHL34xq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso143102366b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 06:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741013125; x=1741617925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2BmXwqganJLn8jq8+b923KGArAolI7ifnS0mWRMdxaY=;
        b=cpHL34xqxtndZQg5NgLZtyQYbjurB2qhzFdaFdG4Lv4VcOn+fbARQTfdmbXiP7CKUm
         pObve5sucTeWJNIpMXn+RUyHqGYhCt8Bm5hEsCfynHjwusk33G+WExHDkQZYUk84f3ut
         oXazGE4s/hHqQ0YZgKRmdSTsV4oqSyPKITvWds7ntd9fLAodp1cA9/U9O8RJOF6fXMHx
         3zfBM5VIaCpilwS/ECddjTs5pMGNUn+NxBGzUCQ086oUp13lsoNsSQKzar/U/vz+H5UV
         9s/BzbpBgsXg8Zyg2kuKuEzzaQcSxFcYYuNn3gFPWpxWyO4FHXzyBPYOETGiBocIl+OZ
         tOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741013125; x=1741617925;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BmXwqganJLn8jq8+b923KGArAolI7ifnS0mWRMdxaY=;
        b=qDXJa+cXzaN7v06thcgd3me4FfH62eY1/klUjFZdsV7IMn0yUVdUyJS3nw4pP67TUO
         raPUu3HAPbGWxFZyjI5wFAqdWmjInPbXNJygm31LMfITFXEA9uWAk8QLOOr1GVwrw8VP
         FHL3hOMxkTgPgjsGtRB7gdtRK64RimDbBu+kxp67Ux3GTeP9n190hTzBB7ST/NYgL8s/
         D/288pYHaCmhQEB8Wmh7d1n/ZltBOx7YfrQhRtTtUptQVS0fokxlUK+9+NxaUQOzCdCH
         G/IYVVlaz9obmiwV4cwBZ2PJnbmou+JsBlU3X3Sl9knugPk3fgCSPpTmltqOLkz7/tKz
         EuCw==
X-Forwarded-Encrypted: i=1; AJvYcCVKmCDQ95vQVqPz8HY2gvjfpk9N1XnTnyKXwL6HlwZ3MdGS6nDo59oh5YoOzPkIdDubVXKuW67zhevfEt0qgQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrhwLUxzTQeIDDVpF4zgc+qQ+sAY70l38D4D4Rg48lVEoqfFU
	YPCKnlpg4DFA/Bydm9QdmMCf5ynbm+KQlBQ0NFJuleXU1nnOlJRBqdV8go9mOmw=
X-Gm-Gg: ASbGncubXRVkVVgaI3BnTObP6SO4/6PDq6skB2kZXxz333DCgZsRsQziPO27JbSX7/N
	vHTprICb1vKsCt3pR6k36PcUJRJpbvpx0rtP9sJcP3Y8nqu/5sGDgBxQakZF71H7+sT/I4K05sb
	G5wBpXN5t/5r+LRj9xCCbtosXboHPvuKHa6MhXrj4XXIaRXRHuq/JLxqRjg9NkYQiyqa9jzde6n
	Gv9obovP/X7qinhmp7Clo4uw58VVTmOBjctCPQXOIPK2nEKUZszVh0fJ/FKyEq7IaxUljdYjQPq
	livbOPIJgSRbIwFMR2WqJV3w/kdIcpR1Z7ylXrgTczeEipLf7PCaiNtERwPJRtaiA/cxqXfJdOt
	Zl2hEJt0=
X-Google-Smtp-Source: AGHT+IHAVJy7KLpojW8TWmlql5y/dSIA4s5XaEQW3g8y6zIpGcUjWmntI7HZ8QA/Igg7m+fa6psmSA==
X-Received: by 2002:a17:907:a810:b0:ac1:e881:89b1 with SMTP id a640c23a62f3a-ac1e8818cc1mr141191466b.30.1741013125157;
        Mon, 03 Mar 2025 06:45:25 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4d41:ca07:21a5:f110? ([2001:67c:2fbc:1:4d41:ca07:21a5:f110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e1d620a8sm82187366b.108.2025.03.03.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:45:24 -0800 (PST)
Message-ID: <2682e274-6be1-4366-a2f6-c870aa9e1252@openvpn.net>
Date: Mon, 3 Mar 2025 15:45:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 15/25] ovpn: implement multi-peer support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-15-93f363310834@openvpn.net> <Z8WpxDpHYzG9pXNl@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8WpxDpHYzG9pXNl@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 14:08, Sabrina Dubroca wrote:
> Hello, a few minor coding style nits on this patch.
> 
> 2025-02-27, 02:21:40 +0100, Antonio Quartulli wrote:
>> @@ -197,9 +254,16 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>>   		netif_carrier_off(dev);
>>   		ovpn->registered = false;
>>   
>> -		if (ovpn->mode == OVPN_MODE_P2P)
>> +		switch (ovpn->mode) {
>> +		case OVPN_MODE_P2P:
>>   			ovpn_peer_release_p2p(ovpn, NULL,
>>   					      OVPN_DEL_PEER_REASON_TEARDOWN);
>> +			break;
>> +		case OVPN_MODE_MP:
>> +			ovpn_peers_free(ovpn, NULL,
>> +					OVPN_DEL_PEER_REASON_TEARDOWN);
>> +			break;
>> +		}
> 
> nit: maybe that switch could be done inside ovpn_peers_free, since
> both places calling ovpn_peers_free do the same thing?
> (it would also be more consistent with the rest of the peer-related
> functions that are wrappers for the _mp/_p2p variant, rather than
> pushing the switch down to the caller)

Yeah, makes sense!

> 
> 
>> +void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sk,
>> +		     enum ovpn_del_peer_reason reason)
>> +{
>> +	struct ovpn_socket *ovpn_sock;
>> +	LLIST_HEAD(release_list);
>> +	struct ovpn_peer *peer;
>> +	struct hlist_node *tmp;
>> +	bool skip;
>> +	int bkt;
>> +
>> +	spin_lock_bh(&ovpn->lock);
>> +	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
>> +		/* if a socket was passed as argument, skip all peers except
>> +		 * those using it
>> +		 */
>> +		if (sk) {
>> +			skip = true;
>> +
>> +			rcu_read_lock();
>> +			ovpn_sock = rcu_access_pointer(peer->sock);
> 
> rcu_dereference, since you're actually accessing ovpn_sock->sock
> afterwards?

Ouch, good catch.

> 
>> +			if (ovpn_sock && ovpn_sock->sock->sk == sk)
>> +				skip = false;
>> +			rcu_read_unlock();
>> +
>> +			if (skip)
>> +				continue;
> 
> 
> The skip/continue logic looks a tiny bit strange to me, maybe this:

Hehe, it's like a double negation. I agree it can be improved.

> 
> 	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
> 		bool remove = true;

does the netdev coding style allow to use locally scoped variables?
Or should I declare everything at the beginning of the function?

I had this rule in mind, but it may have been eliminated by now.

> 
> 		/* if a socket was passed as argument, skip all peers except
> 		 * those using it
> 		 */
> 		if (sk) {
> 			rcu_read_lock();
> 			ovpn_sock = rcu_dereference(peer->sock);
> 			remove = ovpn_sock && ovpn_sock->sock->sk == sk;
> 			rcu_read_unlock();
> 		}
> 
> 		if (remove)
> 			ovpn_peer_remove(peer, reason, &release_list);
> 	}
> 
> 
> (only if you agree it looks better - if it's my opinion against yours,
> ignore me since it's really just coding style/taste)

Yours look simpler/cleaner. I'll go with it.

Thanks!

Cheers,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


