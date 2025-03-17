Return-Path: <linux-kselftest+bounces-29219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9249A6506A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC02F3B0875
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5323F267;
	Mon, 17 Mar 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FgOcj101"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99523C8CE
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217209; cv=none; b=RgvK60MJ0FiagLEC7BbHpb1u3Vs//hRFtHyrAagVY69bEKq1kd3sqI4x+ao9HyuEjUsJpj/iF5Li2CT0hsz4WYQZf9XC+b4IX0xqkFjhEdFooV9fjyom5OKa9kp2qnrESZ6Z7+tX+oV6ynEpIx2cIMzBecPsHS4h+NeQ2FXqM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217209; c=relaxed/simple;
	bh=7wI0GFr6NEtBefK5vBeM6pSYWVuW1EUTOFVTFysVtfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbEGittUbNG7oZaEo0kjBj6IKqPL9h6UCcMxRGeuoAKfjYevPnns2C2vmMPvpfs/+80IfPhc+Dm6LrYmPDg2EHist2+CcqGonPNd75JHIC2x4QJb9Bql8dQorwOMbAHOissU5DldwbdwbEX7Yw005KuiveXQzQiWyEvMBKX3gf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FgOcj101; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac27cb35309so727874966b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742217205; x=1742822005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cmuHqqWaECn9+fr8TyC+jop8pIhCRJbKxkuWi0YwZ9M=;
        b=FgOcj101/X5dA5I0SLGl40v2IZ5x2h3M4ui5vivkvey58gI23it4URbq6eqCgIH0ja
         2R2b/cOFWA4BwvzkPqcZazsGvxprQYR3v4NgMwVM+4d8wHtxPHuecUFPKsQncMnkfmp/
         YlXFahxqO+yOsNrvpYg635VUy0b9kxfxcpFhxettqElyberyNUIAuOm3mutzUkYkEcdr
         nbkRyP2Pn1A8LuZxYfpGsIB0M0B3vncKSH751SoUMZnTUxGq51z/sZ01iAYVdZjNjd3i
         23JYtfHTKzScEJHVZpxsYBp2AbmH37vHWBDhgwCJbz1+a3zihafz/o0l8/k4XvCP5jJ+
         Ptzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742217205; x=1742822005;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmuHqqWaECn9+fr8TyC+jop8pIhCRJbKxkuWi0YwZ9M=;
        b=wOkQUkLTJG9q7biQdiZL4BXHw9BnfSA/dskUoxdgdBPVbWWo4meQEA+XhoqmxllcPQ
         r9OnK++YGtdbjxtb0XL0csDKkgQJexEj9sKk0L1RzD1a2Pc4qu0RFeQE2HrPzBFUruc8
         9WdwDZ0f13RwK3khHlj5l7Z3vgWci/VzE+39cCALYDLHXz3RC2zUrQIwbxr/fFFDYa9Q
         XKWrwCcJ4eVyqCyrFcohnn60m10wbGy1O2z0aXPGQrsJPpR/rSHruJRJXWt+oM4w0sqj
         wLMkvFYvN9bYwbawSBFgNb3UO0pS+TiK3ebbJSOftsQe5wy8n6hjmgoE+iJyv9cB1q1G
         z+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT3h2ETcecYl78EPJCyHVnt2q8cQDBtv4UbhwRw+5rwbnDz+J9qTiIpwoJYEhC81JvoHQ2Q2OD9tNrEo6WMZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLlFe7jlZkbb3Q7/N9G2ARLqgdzqtMi05+p/+qvEzHEqDZMlEe
	FSVFhihMWA0tTf4S3b4gQ1SpWxlf+MV97s08oTZTuWsfAMsunl0IjZdqDzEYXlc1rlrubyejC56
	1DDJGyHnvCktBJH116jBHB+TAopyFy/G0YYwm9x+43PKp1O+eRjB+KDmsGFY=
X-Gm-Gg: ASbGncsysfHr98OCR9/pOL53gLT9xSB7AO4utttbUCrCiPkarE0MuCr78DgVFVE9QFC
	B5J5cevJpHn8ZsaN/QVqA7+jhPbG0pDsOb3XgKHVJecZU4ur5DkV1hcwiBCXosql36UMfU18A+p
	VD2YzOnhP0+njIZZmgcHg4HT+WTc1TEM+DaIYj4lQ9twEG/2ui/MjQLf/DitkurFSsCnBWcz8Bi
	xCHhwAJK4UjUr9HBPQ1vrrQvBHLW5zzNsOIu8ALW2cnAs9iNFB+A43hkwNv07+3FTJN7f34jQuo
	Tpuu+gjQT27Y+5xvJoW02/l+dgK8DKZHeuoOBSPhXG617D9fWKKW3/aRidqeVeZMpNf4yjTLMco
	KVjM+LZE=
X-Google-Smtp-Source: AGHT+IEynz9NgaiPiOrnil0ZctkBGMDjxMtCDg8JJcR4DlOmkm44qC3owxqgHREci25oeAobfTCYPw==
X-Received: by 2002:a17:907:9725:b0:abf:73ba:fd60 with SMTP id a640c23a62f3a-ac3301fbefcmr1023515166b.29.1742217204702;
        Mon, 17 Mar 2025 06:13:24 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:23e9:a6ad:805e:ca75? ([2001:67c:2fbc:1:23e9:a6ad:805e:ca75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9daf1sm661556666b.166.2025.03.17.06.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 06:13:24 -0700 (PDT)
Message-ID: <729e6413-98fb-439b-ad33-830bb10d1016@openvpn.net>
Date: Mon, 17 Mar 2025 14:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
 <20250312-b4-ovpn-v23-18-76066bc0a30c@openvpn.net> <Z9gZ8l9mrF75M-Ih@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z9gZ8l9mrF75M-Ih@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2025 13:47, Sabrina Dubroca wrote:
> Hello,
> 
> A few comments since it seems you'll have to send one more version
> (otherwise they could be fixed later).
> 
> 2025-03-12, 21:54:27 +0100, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> index 8d267d4c82283d9b5f989478102086ce385195d5..407b5b908be431625a3c258e7887211ef0f4b197 100644
>> --- a/drivers/net/ovpn/netlink.c
>> +++ b/drivers/net/ovpn/netlink.c
> [...]
>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>> +			       struct nlattr **attrs)
>> +{
>> +	struct sockaddr_storage ss = {};
>> +	void *local_ip = NULL;
>> +	u32 interv, timeout;
>> +	bool rehash = false;
>> +	int ret;
>> +
>> +	spin_lock_bh(&peer->lock);
>> +
>> +	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss)) {
>> +		/* we carry the local IP in a generic container.
>> +		 * ovpn_peer_reset_sockaddr() will properly interpret it
>> +		 * based on ss.ss_family
>> +		 */
>> +		local_ip = ovpn_nl_attr_local_ip(attrs);
>> +
>> +		/* set peer sockaddr */
>> +		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
>> +		if (ret < 0) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot set peer sockaddr: %d",
>> +					       ret);
>> +			goto err_unlock;
>> +		}
> 
> Similar to the floating case, this should reset the peer dst_cache? In
> both cases we're updating the remote peer's address and our local
> address.
> 

makes sense.
Then I should probably move the call to dst_cache_reset() to 
ovpn_peer_reset_sockaddr() and slightly adjust 
ovpn_peer_endpoints_update() to avoid a double invocation.

> 
> ...
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> index 0d8b12fd5de4cd6fe15455b435c7d6807203a825..aead1d75400a604a320c886aed5308fb20475da3 100644
>> --- a/drivers/net/ovpn/peer.c
>> +++ b/drivers/net/ovpn/peer.c
> ...
>> @@ -1335,8 +1356,11 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
>>   		netdev_dbg(ovpn->dev,
>>   			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
>>   			   next_run, now, next_run - now);
>> +		/* due to the waiting above, the next_run deadline may have
>> +		 * passed: in this case we reschedule the worker immediately
>> +		 */
>>   		schedule_delayed_work(&ovpn->keepalive_work,
>> -				      (next_run - now) * HZ);
>> +				      (now - next_run) * HZ);
> 
> This whole hunk should be dropped, no? The comment is outdated, and
> the sign swap is confusing me.

ouch right. fix-during-rebase gone slightly wrong.

Thanks!

> 

-- 
Antonio Quartulli
OpenVPN Inc.


