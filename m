Return-Path: <linux-kselftest+bounces-28202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80FA4DD91
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 13:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F1F1895F92
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80B201100;
	Tue,  4 Mar 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AefD7he3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B91F3BAD
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090294; cv=none; b=ltMqoNnIKUN/18OqE6Fu39SRCoj/Y19p8Sa6dFesxc6EDblJTc2xdlTz2fIBPGqFPqbtAeXSNYroFV5Cw/c5ECW6dM97xGH+CZnXA811R40tN8wB4tfKXT9UUxfiEZOtfAZ4eXYgQlRs+fxVx66caeh6QM9myybcnHsRIJvpFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090294; c=relaxed/simple;
	bh=F1HSgeocvL7cgCLSczCAVmooQVqdM72CViOzL2cxWb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXwMzFAwk4iQ2+U5KLbrEtIEFW6G12p3a/+A1DxCoHU4KYZoSBPxBXNO/a3F9kL8zTwroatQK7kOj+Y4XBioFXllCOvBYSk/qhaaH5D70TLmmNxoHukIBAZGowZQR04t9psOkd5+4KeTjo7Cf0NQpPDwutJzQu7cAyPQTUyn3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AefD7he3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so5873805a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741090291; x=1741695091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5dj6tuMenxEInNwjhKSB4G2hItvryPwRVb3VHzYL9l8=;
        b=AefD7he3tZxwk0KbLm7yYQnBZNP74Grq/lZwPdR0418QMAAhqSSwsQ3Il1i7L3S2Ht
         LNZhsaPWRJcHs4wpHxs6as9ohweUG9pYgFrWo3zo7gwjDrpB1x+uCLgVJ1XVNdyQlhV+
         n7OvxkJ4nR64YLKLom6jHoP9tzTngMYMuD3Z1Q51IWGRNvYKVMUI9DibaNqt9iTH9g8k
         FLO10/d1KqklItgfZSxNsOfaxWtZeH4aPaNjo6xZFvxbLBOh81cD2AM4X3RM5VJEZlvJ
         5+U8Lt4ahU4uo8qJozT2ySC/a5Nh/OYy5jOKs5umbrEI/dGQdE1V2Ks+3FHjviTxnCEg
         ztxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741090291; x=1741695091;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dj6tuMenxEInNwjhKSB4G2hItvryPwRVb3VHzYL9l8=;
        b=AYIRRzOw2dsXuQ2lCpQ08JtB6whrKSrVyjBMF0+nF2Vml8VP4kQxsdFrWFj7Jtmz9L
         ACT2SLeLWtxCPMkVvJc5IA9cgNgrCKa8+HwHDjhNmoBw/8AFKxpKwPmi8ugmCYkkwzy0
         D6JENbnkpZCruf2usUOCBvEm2ObChp/vZzKBNKPfqagfOSkz3tuxg8QZ1hnaWIsbvHde
         t1h839MZfRCiCwAV9F/FdBZfknd8wcohlp0g8+1LA0HGUevlJ8AISEe98HJW1SUh4fwY
         OIleYhCKUzpqcgH+aRcBzLNKjHi65cCn4KtwPuNJ0xcwAEFT8T1at8CyRpWn/XB5fd3e
         O5EA==
X-Forwarded-Encrypted: i=1; AJvYcCVhmtkukk6qGigaU8LjseNYDi3uq6z0Ud1H8yYwo5OAJYwr2Yp1WcATuhKOYAJYPcQ79dgWlGd/ET8KvI2lGIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/dPd3KTWCp8RL+j9mM8/AcB1+0KUAyAj4EsLpr6hM1OUUSTw
	Y824347Y+K1WGJBNZSxTjEh4nqAH+ErjLkMl23TAkLeaivP3qquCV7kBiBwW8lM=
X-Gm-Gg: ASbGnctYE2Xl9vfEnH8j+RiBLZa5Xzqq7rhPzLy1Pi9Du2WsGHHu8/L86+4LKKyQTFb
	/exsuvOqibOl5+qWyb9HuD23QJF2Av42dNl72mgi7FuFVF36EH09Be+XPo28LHAvlerZYsf6udJ
	sO90gHWomCmHZuuVEe5QXg+sFXnmnR3OTt6h2wlgoGQv6+XASB0p96tNRSbSexwSNqjArdT+M1f
	j9Ur9f+blWUqwSdMIWHcBzoe3XfkN4wO8sDvcAirngT/QDvQDXrp3XBNtLQiPBXTM6fFzlVg7eF
	48UvvD2S/dY6j0h9daork0QlBHiRqcxXxKItspq2JP/FGVR9NJcLK68CmA+rg4wc/Lx3TlKazAQ
	vWADZJRU=
X-Google-Smtp-Source: AGHT+IEQlP8El5800n3Q00KKuHEtQbRABoEEoJNKwPKADVFTcGjJ/751pJSBpyu1Gwn2UebxhRGzbg==
X-Received: by 2002:a05:6402:50d0:b0:5e5:3610:8b7a with SMTP id 4fb4d7f45d1cf-5e5361091f8mr11636907a12.17.1741090290621;
        Tue, 04 Mar 2025 04:11:30 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:6495:6412:acd9:5225? ([2001:67c:2fbc:1:6495:6412:acd9:5225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d279sm8232896a12.23.2025.03.04.04.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 04:11:30 -0800 (PST)
Message-ID: <07c73e1d-3c9c-46c7-92cd-28d728929d18@openvpn.net>
Date: Tue, 4 Mar 2025 13:11:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 20/24] ovpn: implement key add/get/del/swap via
 netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-20-d3cbb74bb581@openvpn.net> <Z8braoc3yeBY7lcE@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8braoc3yeBY7lcE@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2025 13:00, Sabrina Dubroca wrote:
> 2025-03-04, 01:33:50 +0100, Antonio Quartulli wrote:
>>   int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
> ...
>> +	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
>> +	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
>> +	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
> 
> 
> [...]
>> +static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
>> +			    u32 peer_id, enum ovpn_key_slot slot,
>> +			    const struct ovpn_key_config *keyconf)
>> +{
> ...
>> +	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
>> +	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
>> +	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))
> 
> That's a bit inconsistent. nla_put_u32 matches the generated policy,
> but the nla_get_u{8,16} don't (and nla_get_u16 also doesn't match "u8
> key_id" it's getting stored into).
> 
> [also kind of curious that the policy/spec uses U32 with max values of 1/2/7]

 From 
https://www.kernel.org/doc/html/next/userspace-api/netlink/specs.html#fix-width-integer-types

"Note that types smaller than 32 bit should be avoided as using them 
does not save any memory in Netlink messages (due to alignment)."

Hence I went for u32 attributes, although values stored into them are 
much smaller.

> 
> 
> 
>>   int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
> ...
>> +	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
> 
> 
> 
>>   int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
> ...
>> +	slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);

Right. Since actual values are smaller I sometimes used the smaller macro.

I guess I better convert them all to u32.

> 
> 
> 
> A few more inconsistencies:
> 
> * OVPN_A_IFNAME is defined in the uapi but never used (I guess
>    leftover from genl link creation)

Ouch, I guess you're right about it being a leftover.

> 
> * OVPN_A_PEER_DEL_REASON (u32 vs u8)
> drivers/net/ovpn/netlink-gen.c:52:      [OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
> drivers/net/ovpn/netlink.c:1131:        if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))

Like above, probably better to convert them all to u32.

> 
> * OVPN_A_PEER_LINK_TX_PACKETS/OVPN_A_PEER_LINK_RX_PACKETS (uint vs u32):
> drivers/net/ovpn/netlink-gen.c-57-      [OVPN_A_PEER_LINK_RX_BYTES] = { .type = NLA_UINT, },
> drivers/net/ovpn/netlink-gen.c-58-      [OVPN_A_PEER_LINK_TX_BYTES] = { .type = NLA_UINT, },
> drivers/net/ovpn/netlink-gen.c-59-      [OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_U32, },
> drivers/net/ovpn/netlink-gen.c:60:      [OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_U32, },
> --
> drivers/net/ovpn/netlink.c-618-     /* link RX stats */
> drivers/net/ovpn/netlink.c-619-     nla_put_uint(skb, OVPN_A_PEER_LINK_RX_BYTES,
> drivers/net/ovpn/netlink.c-620-                  atomic64_read(&peer->link_stats.rx.bytes)) ||
> drivers/net/ovpn/netlink.c-621-     nla_put_uint(skb, OVPN_A_PEER_LINK_RX_PACKETS,
> drivers/net/ovpn/netlink.c-622-                  atomic64_read(&peer->link_stats.rx.packets)) ||
> drivers/net/ovpn/netlink.c-623-     /* link TX stats */
> drivers/net/ovpn/netlink.c-624-     nla_put_uint(skb, OVPN_A_PEER_LINK_TX_BYTES,
> drivers/net/ovpn/netlink.c-625-                  atomic64_read(&peer->link_stats.tx.bytes)) ||
> drivers/net/ovpn/netlink.c:626:     nla_put_uint(skb, OVPN_A_PEER_LINK_TX_PACKETS,
> drivers/net/ovpn/netlink.c-627-                  atomic64_read(&peer->link_stats.tx.packets)))
> 
> I guess all the stats should be UINT.

u32 should be enough for packets - but yeah, going UINT is better as I 
don't need to care if it really fits 4B or not.

Will do.

Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.


