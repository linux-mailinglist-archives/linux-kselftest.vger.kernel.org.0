Return-Path: <linux-kselftest+bounces-22105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1372C9CEFC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCABFB383E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFF1D514F;
	Fri, 15 Nov 2024 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Rmf2rj4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360C1D47AE
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683293; cv=none; b=uNFMn1LtRT8a4Uf9yVqnRG3KBCDt0wm5H/3W2AsClzJ6LaTD7I07aZ1y7xgNoqwhVzekeZBzhYSCDu6ePiWAFwo+GtrAEm/cXuJl85AfiXY9M9AhQFq3vfkBlO5WCbS4yjnQKF/MHAxLWR/YXFqgd1ng99Ypr1Oe1jeTbQM7Ivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683293; c=relaxed/simple;
	bh=XQjM1GvvHQ1WSi2kENKiDh1XY79HfJbCf+GuZF6GAAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkCVh7bsIaRIwntk+mzRXRqC/+LGVj/jSRgjH4fkxXS8Mp6zqICqA2Vhg0cYQbAjvMOLH51hu0KTlQKDlE1GTYAu8kSqYTsbj1RYMULbNp61Shrix86ucN5PlOjgBUYNqSYzIIreP0+pCYvQ7Y3f5M5YOrMBhXJp/a3MFiYVSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Rmf2rj4f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so16530645e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731683290; x=1732288090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l1eVJ+u5gvoiBy0Qi5z7Q2cwYJUTwhtsNR7M5+MGpjw=;
        b=Rmf2rj4fe3bQ/ngifZqZO8qjcqsQjo1OTDwkbdibHPku+yMS+bADmTAW8lj5RSMAPx
         qBT/2m/i3QytW5M28V3GVckj7VGEndceUwW3uyiSATl3k2c4XSXe+2abMNYlWakWTIoJ
         5XaEx4xUL31oJDs7cQuWCNeXFR945Fl2GGloShPO24N82You7zOClNsx2+MwMhJIxAg7
         XqiddMy+ic7J3lrrsA4Kptc/477m5Ck5oy3dsFjkiPe/75EgF4bFU1YIieRqX77JcEFA
         T7GqZ10O1IyebkQt5qbIf9JU9lKylkBfkwF3Zh1yCZera3+gCFydK+X0TTQ6Mt02c+LW
         SVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683290; x=1732288090;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1eVJ+u5gvoiBy0Qi5z7Q2cwYJUTwhtsNR7M5+MGpjw=;
        b=pnBGPGjX11iaDYeNokaBnsgMAfkUHIkGa7jxP4ZWbf40e0QOtVGt61Zs0OyodKWtVX
         19VSidnw7EPDX4wWgnNMk0TQ0+TG3vGzYvAL/XNsNqAA9BjPsv4xOWUu4cMrak6xpETl
         U4Mf9i4ic03wLa+8DvIHFmtPCjEIyBRx0Y9oBKs67tZ/ksYg5gW2Yimcvnj2VMEK3oH4
         BQhOi376PQMWH7GuWbYpwoztT1LzaM9MV5YX+kL6uioOiPWyDGTGSHATkfz8kaQaZvN3
         pB3xyFZgUqj7gDGVvmfD6+ipETtTOPaB+ZQ45URZaPwcD5p0H02IC1DGIlvKMeWax2gw
         vzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPkp29FuzL/91GRvIgdhu7t8SFlff5ssGMh95CWZ/92RgbxmkdUlGWRb99Okk0iY4rPptcblCoCMy+Ni8cSXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDO4KvgktOXG0eYN4vDx2+U9+qK3hu0fMye39BJzOQnvzqd3E
	bvBLlOyyoocrFoSdDBOdsTKDVWcaH+lEyYTO1ER0VNf6xSrbKEvEGVvCub1dAaw=
X-Google-Smtp-Source: AGHT+IHy0UggFmJRQLPotM9I2PDLoXOFlnbr1NHeixCcWpBtFZ0X+Q7HyQTellfVyQE46O8++56qZw==
X-Received: by 2002:a05:600c:1907:b0:430:52ec:1e2b with SMTP id 5b1f17b1804b1-432df791b70mr23882875e9.29.1731683290161;
        Fri, 15 Nov 2024 07:08:10 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1f94asm56070725e9.39.2024.11.15.07.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:08:09 -0800 (PST)
Message-ID: <5fe43b6a-4f16-4a98-b586-51d2964777c0@openvpn.net>
Date: Fri, 15 Nov 2024 16:08:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <2828411f-f2e5-4dfc-80ff-577eb5fd359a@gmail.com>
 <a7009e7e-a1f9-4aa5-ad41-2befc64b5d3e@openvpn.net>
 <4fa316ce-c6f7-41d8-bb47-00c15f76faba@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <4fa316ce-c6f7-41d8-bb47-00c15f76faba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2024 23:10, Sergey Ryazanov wrote:
> On 14.11.2024 17:33, Antonio Quartulli wrote:
>> On 06/11/2024 02:18, Sergey Ryazanov wrote:
>>> Regarding "big" topics I have only two concerns: link creation using 
>>> RTNL and a switch statement usage. In the corresponding thread, I 
>>> asked Jiri to clarify that "should" regarding .newlink 
>>> implementation. Hope he will have a chance to find a time to reply.
>>
>> True, but to be honest at this point I am fine with sticking to RTNL, 
>> also because we will soon introduce the ability to create 'persistent' 
>> ifaces, which a user should be able to create before starting openvpn.
> 
> Could you share the use case for this functionality?

This is better asked to the users mailing list, but, for example, we 
recently had a discussion about this with the VyOS guys, where they want 
to create the interface and have it fit the various 
firewall/routing/chachacha logic, before any daemon is started.

In OpenVPN userspace we already support the --mktun directive to help 
with this specific use case, so it's a long existing use case.

> 
>> Going through RTNL for this is the best choice IMHO, therefore we have 
>> an extra use case in favour of this approach (next to what Jiri 
>> already mentioned).
> 
> In absence of arguments it's hard to understand, what's the "best" 
> meaning. 

well, that's why I added "IMHO" :)

> So, I'm still not sure is it worth to split uAPI between two 
> interfaces. Anyway, it's up to maintainers to decide is it mergeable in 
> this form or not. I just shared some arguments for the full management 
> interface in GENL.

well, doing it differently from all other virtual drivers also requires 
some important reason IMHO.

Anyway, I like the idea that iproute2 can be used to create interfaces, 
without the need to have another userspace tool for that.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


