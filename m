Return-Path: <linux-kselftest+bounces-30534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA6AA856BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02B6179587
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7405296152;
	Fri, 11 Apr 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B0yCSpsF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A1293B79
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360705; cv=none; b=pvt7DByyjXwHTOxTphJPGpmrnFDqFbAh5tRefxUkGxwJKmWsZnaMPM24V7Mgo+TcLyA0lChbwm1tY++T+KwENc3bEcXhICqvblA2fcSkJ5GYyRd8E2mCJW1NSd/ZIP2ygjpg9X0Eus3in+BflrrnJ2XRWrm/E+A3gySiH95tecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360705; c=relaxed/simple;
	bh=Epr+eQBTBU+1ATMEcOYwgYpBi+5oAELlBmkst6805Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TahLN5iNBRPmJEPRAXCGMr06gHHI1rRrXpyCn79WIxUviEDdVAsARFm++wrydEVoQnjA8y1HNnwERjyqOaRp0E4eg+BX8m4icioHZFZe0/i4ovFTfHK0vcphlNoyc4Wn4xQ3cccYy+865sAmWzQ2iGaBWxjy4Nnwp9BNgJ/PImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B0yCSpsF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf257158fso12795615e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744360702; x=1744965502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sLffW0MYcqM/kbItIhY6HvWZCj3KnwBnjUOkirxLQ30=;
        b=B0yCSpsFauabFeSmpImWI91WIartpOH5alEONnCw1kOBegi3hhoCX4iuib2tiFKlSP
         BalEWX9Fca/n2N0EWEimJYTzkkAOHI98o8kwImMG9BmPbgCZrrlbBSbQmiIj86ognehR
         Pj453DEfbiOmbqNeD1sRPCHkc+tWpaM3U6dU4jzon+xADOfFZYSb2LLedbPzZGxpsncr
         KNz73O4lK6rGsgOkdKgxZBocN0EtWzKxbrZ23dOqodX6PZxDmuK56P7eN45P0BQWCsRw
         mp4oswBW7RL6JjZ9YWs3FvaIldFA9aUyfeGbvTB/5cFPawKb99CCu/ESbGDVwTS3vW8M
         bzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360702; x=1744965502;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLffW0MYcqM/kbItIhY6HvWZCj3KnwBnjUOkirxLQ30=;
        b=FclSR66RYCSgJhjWSux7gpOlpmKEsL1XoTpIlxd2GlTFB28EsTr/A1S7JTGj8rsRHf
         hRb/gQg9IUkYAmNCaDIUvyHKEEDbCreD8WSwrX/ow6fLufISozsPFyp3W0CZxD7N87V+
         w8RkmIpYVrc0JHUN/AGW+3uTnAbmTgrHztCgbMCzcVrEAnwnUbvW5OJBcqTDoCf5g1b/
         fppJpbHc5Qtis+FA8L41hTQQ9s96I9gcM0l0O09XTfB/NxyoTX9bpOWoSNNWSbMkeGyu
         xPuQFVZwA5Lzrfj4xv2iYP4JshATXIAv03/bn47xIRgd1X3hDQpZ/rYLQKLWWU3jgeNf
         MwTg==
X-Forwarded-Encrypted: i=1; AJvYcCVr/xrHs5crMWiBKcKSe2kH8GV4Bejt8gE9g6FR2Pi705+7thq5Kh9FuaYIHK0vsoNOQFI1zAf43ZBuVYYCIxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBd/cRJSe5lJefVHcOVceHYhiClKe4ACpo9EoztlIngz4bM6C/
	GuCgFDcU04swgeraQPfQxwFUflkJE+mj1CwAxhnAMvaGrrQ3qhgInNvYWcooMBjUeSZ8devXe7R
	lSs2BryPD2Tnot/inkQ7PH8aQ1BCTYqABYtN+KpSl5MLFeQ6GDeBqACOfswM=
X-Gm-Gg: ASbGnctIA5Pe3tVU8cUBBKgC3WwtYqkOeL3s2aPZU/3uSb/esrbkBWxS+HSYwsaxeQG
	I8UMy1glFbZqPM/DrP+xsCdoZ03XzYSMsfxP+fHaf5XqbHuiDgy7sl271u5mTiKoVx3iE0cC8CG
	wMjzzgvvayI3KfAZf6UDrprAfpJv45eUpW7AiWGx9/pslLxtY2lF9barqaINO3vEfJilQWaEzVn
	cZm1sn3Yp+FIV4pz0IhMFkAJRXUZ7CkFM9CfWY1EE91piK4aKYPAVK079SxChD58k5iVmyeXSis
	T+wU4VXab4SaUQ6BFPSV80zVOtXn8ZQcfjlf8VBz8Cx1oMDhFLphCBkSBQZ00WfLnPJwwtJrfJz
	PaoFnOkxQ7zUsBw==
X-Google-Smtp-Source: AGHT+IF99oxdyDqfyn57Lonv1kNPOlFA9HMh6oBiEUe+C+vJOJbIHsy3y4iVXg2sytLFO2/obYxOuQ==
X-Received: by 2002:a05:600c:a08e:b0:43c:eeee:b706 with SMTP id 5b1f17b1804b1-43f3a9aa66dmr13977265e9.24.1744360702027;
        Fri, 11 Apr 2025 01:38:22 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e8be:40be:972d:7ee4? ([2001:67c:2fbc:1:e8be:40be:972d:7ee4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aed49sm78101205e9.34.2025.04.11.01.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:38:21 -0700 (PDT)
Message-ID: <af1a5da4-12dc-47bd-8836-9b7bda0281fd@openvpn.net>
Date: Fri, 11 Apr 2025 10:38:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 04/23] ovpn: keep carrier always on for MP
 interfaces
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-4-a04eae86e016@openvpn.net>
 <20250410200325.5621a4f5@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250410200325.5621a4f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 05:03, Jakub Kicinski wrote:
> On Mon, 07 Apr 2025 21:46:12 +0200 Antonio Quartulli wrote:
>> +	/* carrier for P2P interfaces is switched on and off when
>> +	 * the peer is added or deleted.
>> +	 *
>> +	 * in case of P2MP interfaces we just keep the carrier always on
>> +	 */
>> +	if (ovpn->mode == OVPN_MODE_MP)
>> +		netif_carrier_on(dev);
> 
> Any reason why you turn it during open rather than leaving it be before
> registration? Now the link is down until first open, then it stays up
> even if user closes?

Mh your concern makes sense.
Originally Andrew suggested adding the carrier_on() to _probe(), which I 
interpreted as _open() (I don't think virtual drivers have any _probe() 
hook).

Being the goal to keep the carrier always on for MP ifaces, I'd say I 
should move the carrier_on() call to newlink().
There I can set the carrier on if MP or off if P2P.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


