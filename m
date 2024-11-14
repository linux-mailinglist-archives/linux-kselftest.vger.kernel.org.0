Return-Path: <linux-kselftest+bounces-22030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D356A9C8D60
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D46282359
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705574BE1;
	Thu, 14 Nov 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MGB8Qhm4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546654720
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596085; cv=none; b=PpB9IHOg/wThn3RzNjzRaIgXNnRE+lHYD0qLi23aodglTiXC8ZJwtbWys/9+o7lfcgLw0gnRGPtFL8nMC/kfj9ACkMSLgqgPp0I3ulUENiHmaFlSoKwM64x6fbiCAcDixAWlKStBrDVOkVOrdaGJmHE2B7xg5X2oOMWGiLgxVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596085; c=relaxed/simple;
	bh=bcx0humSCVFYEtSbVlRyd7JMd8XlsTkVg2Uwj3r/xTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haf9tC7zNuaWUX9Ya05mDHQ8ihWryaHKipmOAiPJzgR9opzGfh+AAlEAT3mwnpZ1QjOkvSsdiKVExg3+BR7lHIxoNrnv3ClmmT9hnq6FaTpy0gyJvUpbuL4PsLVt4idO2AxEpzNZJo4FLGcZ8alC+WEoCLYBFMlk3iXH1yH1jPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MGB8Qhm4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so963533a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731596082; x=1732200882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vTJ62P8bnJDHamIaIkZp3lwFmYtPHFSpSt18FcDxjPA=;
        b=MGB8Qhm4+wg2/5zWzau81R59aYcfTrA06mQLOM8YXl/Gvv25eCRuPR15VVgzgry78u
         gMvDvkPGyPPgvfDd2nSxCZnqBObLjQeQzf9wnDd+Nyz2PMgiNJpwygTauCv1z1BSYQSN
         bs7uD+bFYWpHX3qAYMPMDprYDa6awE/1/WqIuaZWdYHNi5DgZiuVayepgFImPzDcg8LP
         C88mrliYoOu/4H3IJexp+Ucm6PAZTFMizQ9B8Qeo6Wpz9JJ+cMhIPFFoqvyypJIsqzlo
         nKk1/YodjHN3c0I3aFyuIqjixUj9O+Z/PABVwwpZxIDC/6V7WDoJhCGqcoC0Fp2uT7SH
         FX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731596082; x=1732200882;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTJ62P8bnJDHamIaIkZp3lwFmYtPHFSpSt18FcDxjPA=;
        b=K0WjTuBfhfvzrKm0FtpLYvJiGzIavPYKapCQx5FxryMwxEmL872ptmZk5tMbHhyF8W
         9mdt/Eir1YbHojFXR/9syfMdOUH16qLAwCMQWkwZxlPynI4okN2BF2ZE1sOmvGr7RGE/
         oIb4W78agYyiujavh7S2fErQNQeIP0ruw7r1qLwF+IIfSgGOqafsb2m5MNaYtR9CowXs
         wtONDz33WZ+kbO3v3uRBNc5r/Fyo6wOcJubEAFDjNN5ZhIuigh0y/xVvDFX8wTll7dM3
         +usSA5mHN8+yM1XbWHjsGRk9Bdm1YWpm/OsElYEZ6PVjMytU4HtrCyYPqlFClV424OAC
         r/zw==
X-Forwarded-Encrypted: i=1; AJvYcCVMemMc0iPynvBIPc0bHbjWjH5/JfkYiZYYJqdLpEVGGdIiDoOcB0nuoeFkHKddvCZf5HMiAQ2nPRX1Ds9chJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwV1j76BqTfkhLutbTylJrxSS7gA4yhr5iVS3j7RyJhimPw5GB
	EBKH6Ly+POCGskNj71uY6Qn8mj2LSb39v1Th/JKPU8f22CyZnBuptBHE1ysGIYA=
X-Google-Smtp-Source: AGHT+IGHvdFsxvguyvcyT5nYpLB3OAZ2Am8crWT5azlsbInJeFOAXA6/poO159lBDv4ARSI4+dEptw==
X-Received: by 2002:a05:6402:35c3:b0:5cf:1b53:1bf1 with SMTP id 4fb4d7f45d1cf-5cf77eab559mr2182043a12.15.1731596082207;
        Thu, 14 Nov 2024 06:54:42 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e7c9:910b:dd41:da18? ([2001:67c:2fbc:1:e7c9:910b:dd41:da18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9e168sm668946a12.21.2024.11.14.06.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:54:41 -0800 (PST)
Message-ID: <43b09303-3a0e-4691-8335-4047bc5bfd76@openvpn.net>
Date: Thu, 14 Nov 2024 15:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
 <03c0f957-c150-47b3-805c-9a1d774af03b@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <03c0f957-c150-47b3-805c-9a1d774af03b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/2024 20:52, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
> 
> [...]
> 
>> +static void ovpn_peer_release(struct ovpn_peer *peer)
>> +{
>> +    ovpn_bind_reset(peer, NULL);
>> +
> 
> nit: this empty line after ovpn_bind_reset() is removed in the 
> 'implement basic TX path (UDP)' patch. What tricks git and it produces a 
> sensless diff with 'ovpn_bind_reset(...)' line beeing removed and then 
> introduced again. If you do not like this empty line then remove it 
> here, please :)

Thanks! will make sure it won't be introduced at all.

Regards,

> 
>> +    dst_cache_destroy(&peer->dst_cache);
>> +    netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
>> +    kfree_rcu(peer, rcu);
>> +}
> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


