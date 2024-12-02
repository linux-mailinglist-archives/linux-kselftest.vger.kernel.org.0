Return-Path: <linux-kselftest+bounces-22664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B703A9DFF25
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D45D162A2D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 10:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA511FCF57;
	Mon,  2 Dec 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CLkHwLFE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C841FCCE7
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135998; cv=none; b=DfZS9m/P6m+/BWXULV7i9itBgcGRct/ZwHnRcApQDLWoCf/frOLREdEePwv5NeR1ad3Pg6IfLFlxtur3Y99Z6cdLXSpwis0IKOUqv5RBRcmRC/FqdYRKjyJFFaD9fDHX+mipcAO9v4my97YYnmO1Dmtxldxd5e4SpHoDj1i2t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135998; c=relaxed/simple;
	bh=DYNaZn6TdVJSB3HrT1+ewVokf5PU3016tstmnTWQa0s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GyC8ga5kjkXFD+kvP+aIatmNx4N3TMkBV5G6DAZvUcsu6yfEIpntAQhmh50LJcDv8CqS8SQG1QNXFItF0Dvz9ZbVmgwmXLBoqnaJl8TAdOmROlaMOXcwuLUDx+m+KsYHq/Gb1jZQ9XvNJHEnJiVqIpc9gWP5WyIOqxdwATuu3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CLkHwLFE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385dece873cso1319467f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733135995; x=1733740795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RX2YCHdx4g9Z1WhkvOgdHooa/D9EB/cVjTLy89IFDI=;
        b=CLkHwLFEx4JePpoHo205LaMuj2M1OPXxOTdVZwskT2OnVmW6nj8dG/mzWFEx4j7YtM
         pDxzbuiJgktSXA4sAsWoAt9ZWB6nxERXYt7BnHWwHAIDYnar3MJVgJhxWq++0Pzzi6FS
         V8ab/TEgyMQSdQqGXgBed8fZ96aQrDmLQEgO8UK+vSLLeCiXgMGYgSHlNNZr24TCW3+p
         VdAb7wfdugyjLc8evVZ8px3c+fIoBlLCzJHtieYsbiQH+J+Elxwcgw1l6/+D6XXySkEb
         kmNhZhPURua2omfq0XIkp/p64P7j7tkIHRL2e2tQ78oS+60+TCpI6wqVqvST852pxOkg
         dNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733135995; x=1733740795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8RX2YCHdx4g9Z1WhkvOgdHooa/D9EB/cVjTLy89IFDI=;
        b=g3LGbmeCUMxgoMxJMYIp5qHO7p1HTOK6D32PPJtVlFw8rlO1V9cIk58p+H9MYtzA/3
         5sD+LXkZyNPP3eO/NLGTP1ph/Ooue6Oxd44maaCn9BQ+mTanAqHFyReFQ+Osn+VW5uHT
         EeCpbPEdXwkWA01ufaml/SabE7x6E46asE5lmqMMKBJp6wC+EhU2LEFYik1i0gCN1zXc
         XTkJFlCwQI2AtjxKstxySCbJ0AofEKTkuOeIDZrvz/AS1DaT82A4OkZOXVWIl8F7KrRf
         xzSuCb2vtKMTXtOjlLIbjWLqK9G0SC4kckBaZPnQm93rzLjvfJDw00pr0pJN8nXj+eYu
         L2LA==
X-Forwarded-Encrypted: i=1; AJvYcCWkdAfVv28aHf8jjfSgRYThx7dgJroBUQJMQeJyrBWwnh7lfNYzpLJH1qI4J7F/YE/zslHf0VcDKovssuW5dMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQO2BmIo4SJUkeXXOfBfwbxw8HlOuxF1Nqkduurv9pRqokmXE
	6pK6P9vXCEeflLqEototLdHCMkH10qdMI5vjhj1e4hIiERdPYlq8v/OThPsFMnI=
X-Gm-Gg: ASbGncvFPTdW0LEQlZ6m4KbWp7EHJ4jkePR41KTUiGe80dq0cnY8TGiwwOOW4XOo7vL
	a/Z2O4lQ7O6j+2rHwiBhPSMU5WMyk5VIpximBmJLBCAoVeYPvZ6/bgnefgJy2VHMa1a3PGoFdL2
	ibqeqMeOfA3ozweRSJ0QvPRzES7TrdTP42mkYfF+SwBNyOr3o5rAPwXSfpjTwZYYCHoDCQKZN15
	AZhZYIwYJlOry0h8bksaGdw1a2plrT9oh2EWehiA7bJocRYr7I7x29dpr5tvtS+Yn9SY3hqWs9i
	jDC9cHlPzg==
X-Google-Smtp-Source: AGHT+IEuOgKQVrRqq3CFTMvxvB3bWglZA0FJeYVZhwfg4uT/D5QQjHJ2BfYLevyx6w+QF7nwwpfgBw==
X-Received: by 2002:a05:6000:178d:b0:385:dfab:1643 with SMTP id ffacd0b85a97d-385dfab180cmr10298039f8f.27.1733135994887;
        Mon, 02 Dec 2024 02:39:54 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:5d0b:f507:fa8:3b2e? ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc91sm151245135e9.9.2024.12.02.02.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 02:39:54 -0800 (PST)
Message-ID: <b868dcf1-7c0d-4511-8016-89302e7cb9c4@openvpn.net>
Date: Mon, 2 Dec 2024 11:40:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
From: Antonio Quartulli <antonio@openvpn.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
 <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
 <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
 <e2caab8a-343e-4728-b5a7-b167f05c9bb9@gmail.com>
 <c933e2bf-b19c-4f8b-b2c0-44de50eb4141@openvpn.net>
 <1cf97615-a38d-48c3-9e23-4ba82012b32d@gmail.com>
 <c9185b5b-942d-4927-8171-f3460619aed1@openvpn.net>
 <c62208a4-5396-4116-add1-4ffbc254a09d@gmail.com>
 <cdbeecb8-e468-4925-9ab4-c77accf806b9@openvpn.net>
 <debdfbda-36f8-4c83-bb54-3b48af77e7bd@gmail.com>
 <55d91682-762e-411e-8abc-0790a9d81102@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <55d91682-762e-411e-8abc-0790a9d81102@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2024 09:17, Antonio Quartulli wrote:
[...]
>> It wasn't suggested to destroy the interface in case of interface 
>> becoming non-operational. I apologize if something I wrote earlier 
>> sounded like that. The interface existence stays unquestionable. It's 
>> going to be solid persistent.
>>
>> Back to the proposed rephrasing. If the 'full picture' means forcing 
>> the running state indication even when the netdev is not capable to 
>> deliver packets, then it looks like an attempt to hide the control 
>> knob of the misguiding feature somewhere else.
>>
>> And since the concept of on-purpose false indication is still here, 
>> many words regarding the control plane and a full picture do not sound 
>> good either.
> 

Sergey,

I have played a bit with this and, if I understood your idea correctly, 
the following should be an acceptable design for a P2P interface:

* iface created -> netif_carrier_off
* peer added -> netif_carrier_on
* peer deleted -> netif_carrier_off
* iface goes down -> peer deleted -> netif_carrier_off
* iface goes up -> carrier stays down until peer is added


P2MP interface behaviour is not changed: when interface is brought up 
carrier goes on and it is never turned off.

How does it sound?

My main concern was about bringing the interface down, but this is 
actually not happening. Correct me if I am wrong.

Thanks.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


