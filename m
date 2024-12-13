Return-Path: <linux-kselftest+bounces-23317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAF39F0C6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0508B287953
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0251DFD9F;
	Fri, 13 Dec 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K+C5v8Y3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181DC1DF97D
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093433; cv=none; b=BOl0cNBpGHS8KsF6oOhMmMXt2E0iqAWubc4eqbuE2axqZSUOLE/aXdEB9a3tOylVQCa5JDx8jAxPh5IG/J/5mIbIGikOQ2thhNgcBgJB0yttb1ZIw+FkYf6poRn0Wx7jrKS8prtVUQGMujd9hXtR+pMJl9s13jfEkvjxC/I0eXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093433; c=relaxed/simple;
	bh=Nmi9GyDGQHCmYPBPOfLMTtqurvXheZhg9NmNBo3YxcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHd2hi7VpQhpFJ+2UEZLF7OE7n4ePpuOum8ks8DAOh22CEHC59UnVT37lPaBzmsK/5sWhJlL0a9yFyqobXd16+AZ9UaWf0fO95gQ3Z6fYJ6ZhmdmPNs532dpKdykiES59ixaPQZ9L5Ahm21NJDMB1i0I3CgoeWF86GgznaXAn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K+C5v8Y3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so256130266b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 04:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734093429; x=1734698229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ltuE2+W/QkL0PmrBT7zRDBDtGcXVxn3gh0L5g4K6QKk=;
        b=K+C5v8Y3W75xxgrONXSxelRLWCApWJehMQThBj1A1AywLFKDulVzQJMVa3Oa0aO9pQ
         of2IJ5//2U5fGMSy5XCXGgj+tYEkKEpu6YtHCV8gC9t+vdJGyRKR1rtGp8d4LIIGBeYJ
         eotPoHzGKu4Q1BXPnJTJheGWv0Sooc6ev0Rcsv+bmAq1XeoJTSNyPvAER44uPnuOg8rj
         kY6eUAvvLz3nSTUURECk/sKJLsT1eptTxCVZE5cOJ11HFwJtTcgINPIhPvsT01ISPx8K
         WtIHCS90fL4XfItYWiBCP3bL5uct7WCNfyROdd1akHvmPqvkKZcsY3M1/jXU9DqBGvzC
         dXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093429; x=1734698229;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltuE2+W/QkL0PmrBT7zRDBDtGcXVxn3gh0L5g4K6QKk=;
        b=UPugQFccfRJoi/KXXx+eftysWpZeZM6v0mU6d8G/KmQbre4LaynBj0Ce+wjv28pxOE
         YGekN8epLcut/gswIu67oxz/QYi0mL0Crbr2LDAjO7qk4saKA5JbVKF1fhtG6yZ7sIT4
         cfoijnwNmbnqRO4+xMliY7ZQ14BQX8eW/hnHJWCfj5wVFe1hU2BUaERi82Q3tNFoQlZO
         7hHq5vo98RQYD66AsQ4BfSPj/P+2FdwMcoSgbXIbdB99JRPl2yeAXboK4k3EOOnjfBM4
         xwJacXD26jgagl+ausibuU9wjVEFO2tJ7wtp2AGOTQBsrp0tckp6hJbTpnBPcEWuSnj1
         XVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUACN/nTRGmBckeauEI/naESRqNt6+T7uPMTSeGvg8IN35L//iYiJnSwQ0cPtR8MItjQ8V9dfXFBpZu1SMeP5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAPxRjuZHb4fLbWTF1+WqfhndodRb0c/nS9/PHzMDfwtdHeg4
	lf2bZHABxZ/sM2WQR7i+U3Q/wFe3/1B/uk5oe0I7Kohc4m7NG7036nSd9yzuNjY=
X-Gm-Gg: ASbGnctVIhd8r5m2X3y2SCzQ8yz6/cwxIFJbSixuESELT35sCaCB+WKfmI+90QdS87d
	+pjax7ebKo5SqsJ/r/o9MpMOJ6YY5Ks56z5n8Ne+7dgDuLf52wi91JfRwDl1pKwIK7dKwt8zbB1
	kdNf9GGdvKg1ldHoE6XPyWfTUrpsoeFb8i8jKLtqyvZ45FhoHDiKWNhOj9VzwZ8bGk0CTAtFuCW
	5z4VXlTKe0YYayWcMNl9Z5x6kH90aUMHpBQXrujCVj4TfkF8lwHBBb0zH/Ik/oY10+opCdPX7aC
	haIr7QSroqilLRpuKBg=
X-Google-Smtp-Source: AGHT+IEzo7yOAMIbo+2ZeO9KjOvgByarMKbpvTYUgjdcE+ovUy0pWk7Akq3CzcQvJ/6fvAVrohq13Q==
X-Received: by 2002:a17:906:3145:b0:aa6:3f93:fb99 with SMTP id a640c23a62f3a-aab779d16aamr245324866b.36.1734093429329;
        Fri, 13 Dec 2024 04:37:09 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b5f9:333c:ae7e:f75e? ([2001:67c:2fbc:1:b5f9:333c:ae7e:f75e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa3besm11388409a12.75.2024.12.13.04.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:37:08 -0800 (PST)
Message-ID: <8db525b6-3384-4e12-b16c-47b0a2898f1e@openvpn.net>
Date: Fri, 13 Dec 2024 13:37:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 03/22] ovpn: add basic interface
 creation/destruction/management routines
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-3-314e2cad0618@openvpn.net>
 <CAD4GDZyXK6rBH_ccHkYrA4h71bDkKxVy_B5o-bj0ezzdHTJKxQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CAD4GDZyXK6rBH_ccHkYrA4h71bDkKxVy_B5o-bj0ezzdHTJKxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 13:32, Donald Hunter wrote:
> On Wed, 11 Dec 2024 at 21:32, Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>>   static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>>                          struct nlattr *tb[], struct nlattr *data[],
>>                          struct netlink_ext_ack *extack)
>>   {
>> -       return -EOPNOTSUPP;
>> +       struct ovpn_priv *ovpn = netdev_priv(dev);
>> +       enum ovpn_mode mode = OVPN_MODE_P2P;
>> +
>> +       if (data && data[IFLA_OVPN_MODE]) {
>> +               mode = nla_get_u8(data[IFLA_OVPN_MODE]);
>> +               netdev_dbg(dev, "setting device mode: %u\n", mode);
>> +       }
>> +
>> +       ovpn->dev = dev;
>> +       ovpn->mode = mode;
>> +
>> +       /* turn carrier explicitly off after registration, this way state is
>> +        * clearly defined
>> +        */
>> +       netif_carrier_off(dev);
>> +
>> +       return register_netdevice(dev);
>>   }
>>
>>   static struct rtnl_link_ops ovpn_link_ops = {
>>          .kind = "ovpn",
>>          .netns_refund = false,
>> +       .priv_size = sizeof(struct ovpn_priv),
>> +       .setup = ovpn_setup,
>> +       .policy = ovpn_policy,
>> +       .maxtype = IFLA_OVPN_MAX,
>>          .newlink = ovpn_newlink,
>>          .dellink = unregister_netdevice_queue,
>>   };
> 
> You need to implement .fill_info to add IFLA_OVPN_MODE into get / dump ops.

Ok, I'll add it in v16.

Thanks a lot.
Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


