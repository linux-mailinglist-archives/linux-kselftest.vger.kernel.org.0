Return-Path: <linux-kselftest+bounces-22238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960339D215A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560AF282021
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5987E199FAB;
	Tue, 19 Nov 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Vyd5bfff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78115D5B7
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003923; cv=none; b=Zk7iWwg5Z3PU2nmkZr4h8IDhmwCUiwdgbwM20ebudlB+mgf4w+/Z+kpfvzD/qHLUCJudQ8Uppl3jBaFxZ7CPAo/kHQO+fPFrOaPeQMiiF0kTN0XyZuYyPM+x71sGpUZTZT0cwJ9ZIBi0YikCkzLpLVISUQazJ2ZzKemB5hQtVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003923; c=relaxed/simple;
	bh=mZSOgAIJ9NQlBbnjGuNL9GCAEtQvEwE5gZPj8ZsPTmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7WieKgF53YHvYEmBndWgfz/lbKAew74DGfNtkahlGV58o+YuXZ7AVqpUaMA5zIuBXvePlwRh6n2m4jxJESrOmx35L8lmNBFvWEzdTrwpQpQ4L537sBHo7lRU8VstfIn6uSTBBv3QNa42YHAZ7jd0Wjyd9jD+/YgTnIp3mb3HXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Vyd5bfff; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so5290254a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 00:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732003918; x=1732608718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S7sp6JKldxsMXdVOcOzkydJkQRdJp3pYKuEh/Kb4tLA=;
        b=Vyd5bfffGxvxUQ/zNOGmBelb9TMd+YmTN1gnCFpJ9MyRM5jKoFzt/7W4kn4JNvwYOz
         jeV3EidnG9rxywNPM/K4azhHzkpm52hiDCIbORqlSeGA6vCWkcZQ9O2d2SAU/Zdwm0ys
         ZbeIJPjj82kfvkIwUHsVRy5/O12BvOb8/Hzka0MeNSyk99nlmnUDUaWCffHPYvMwEqUm
         xJ2sRMNmFRygJgpQwhqdTbO2jtcWBY7CZqqJbxQ/6IfA79F9IXAD3m+FlYk35tasFxKO
         0OiJ35WsyfmsHRivlNWtp0Nrnjt3OlqublsE5gULzH973KCADOCmXFismbDHaALClJVg
         Q7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732003918; x=1732608718;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7sp6JKldxsMXdVOcOzkydJkQRdJp3pYKuEh/Kb4tLA=;
        b=J0TBCGbZuMIDzGI4ZoRc7YD7PB0x71mG9GvMo8kVSp1njiX/m27meP5N/+5Yp5V3ab
         D58SMas+7KX4LMtpKnw5U9a2KZpyI2Yd23v37VrPNZJWO5sHFrRVBjB2U8vMMwNvXKH0
         AY6NSOQX0iJgtOI7P3l55mNEJUxrDhhBT3JX/6Y/hl864Q+jZObrM3oez4jWL6sA4tyV
         QMceT8sxZ+AU+m6qFKSczJ6Lv+hfe+xOef1eXDO7GQ+nAAxVX21ggGb7h5WbOPEKX6GI
         CwS4jQkrhldX8bk9LobokLa+MXr9BmbiDanYnncevatbJgfO5oRCFWgXCt/xNuBS8SIV
         52MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/23Ig/J+k3q9nsh2HvCcYtAFY4ZF03TTQCB53LDSNTDTOfreaySu3C0FrSMC7+se9MkaCRcP2x0fcNebnENQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6zYgFKMomFNCuU/aB0rT63zhJRClZLTaH7UFLNXWBaLkyql8
	UuFHouEU83K+bT+z5JI5FbxXRj6KDPvx0s0l35xMzRQisr9KyJsF176RO6TpU9Y=
X-Google-Smtp-Source: AGHT+IG020h4UTtFNYY64dTTB51Gnob4K6UqrXp/mnQSuAaHkXnUhr1wcyWGiHeDd682Pnk7dK4/jQ==
X-Received: by 2002:a05:6402:5108:b0:5cf:c303:c598 with SMTP id 4fb4d7f45d1cf-5cfc303c7edmr5890132a12.11.1732003918227;
        Tue, 19 Nov 2024 00:11:58 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:a2be:8cd5:8845:cfce? ([2001:67c:2fbc:1:a2be:8cd5:8845:cfce])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfbddf326esm2461317a12.82.2024.11.19.00.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 00:11:57 -0800 (PST)
Message-ID: <a374cd1d-b395-42d6-b7e8-083bd2d2f5dd@openvpn.net>
Date: Tue, 19 Nov 2024 09:12:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/23] ovpn: add basic netlink support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
 <52a2f654-29e5-4567-b5f8-8362fa55c1e1@gmail.com>
 <a8f3a9ca-698d-4b4e-ab4b-7d8aa651dddc@openvpn.net>
 <a125f933-b985-441e-9fac-49002bc5933a@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <a125f933-b985-441e-9fac-49002bc5933a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/11/2024 03:05, Sergey Ryazanov wrote:
> On 15.11.2024 12:05, Antonio Quartulli wrote:
>> On 09/11/2024 00:15, Sergey Ryazanov wrote:
>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>> @@ -37,7 +41,7 @@ static int ovpn_newlink(struct net *src_net, 
>>>> struct net_device *dev,
>>>>   }
>>>>   static struct rtnl_link_ops ovpn_link_ops = {
>>>> -    .kind = "ovpn",
>>>> +    .kind = OVPN_FAMILY_NAME,
>>>
>>> nit: are you sure that the link kind is the same as the GENL family? 
>>> I mean, they are both deriviated from the protocol name that is 
>>> common for both entities, but is it making RTNL kind a derivative of 
>>> GENL family?
>>
>> I just want to use the same name everywhere and I thought it doesn't 
>> make sense to create a separate define (they can be decoupled later 
>> should see any need for that).
>> But I can add:
>>
>> #define OVPN_RTNL_LINK_KIND OVPN_FAMILY_NAME
>>
>> to make this relationship explicit?
> 
> Can we just leave it as literal? This string is going to be a part of 
> ABI and there will be no chance to change it in the future. So, what the 
> purpose to define it using a macro if it's self-descriptive?

I don't truly have a strong opinion, but the netlink family name is also 
expected to not change anytime soon.

Anyway, I see that using the literal is pretty common across all other 
drivers, therefore I'll go for it as well.

> 
> People also like to define a macro with a generic name like DRV_NAME and 
> use it everywhere. What also looks reasonable.

Yeah, that's exactly how I am using OVPN_FAMILY_NAME.
Anyway, I am switching to literal.

Regards,

> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


