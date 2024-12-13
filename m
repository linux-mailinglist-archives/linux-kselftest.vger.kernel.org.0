Return-Path: <linux-kselftest+bounces-23333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA39F131B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF2B1886703
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF91E3DEC;
	Fri, 13 Dec 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ttg4DXlk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E31E32B9
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109199; cv=none; b=mLpy0V5g0V6PvRHm/HPbQPdE1wocuMrtUZbXMnaC0Acd2LIBSvL0VrpcN8QiaTBUCSc9mbUAvcYb75koBRuTtJadfNPdc8EZm+hdKttZinewyqIQ0uD8uo26QEHnknF30T6sy9T7+t9Bhh+Cxo0yMx+KdrasVD1mXk0LrBnKGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109199; c=relaxed/simple;
	bh=D5q+6FCLqWLLJ85MFitx+lnu7jPp6UpZjx2q/w7iV7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxgaeoaXu9u8VW15wjI1KgW6saiJvVidrwhlhlf+QZN9emi6mSiPkp5ef+gRcx6y8bDbqq6pE87iIFnay4CO1NMp6v5aSxUuzYcNQ8yqW0jLvMDRNF+e3fs82SeutbZORwVBi9mBa1CBB3LbPwO+44XkInjNmz5xOyufbh+4k3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ttg4DXlk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so689653a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734109196; x=1734713996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eT6uCDU7W6zklXVj2xFWni1AXdhVUk0J9QH8VWWf8YA=;
        b=Ttg4DXlkELRqjFiBYTm56ples4ibIVg62VpRx8zc4vH2j59lCbrVsOK3dU184swlyM
         O/x/jE5IK4CITMX8pPAHMoDsYSFn9+qPWZKF2arhcW0R5phqw5geXxdspXLJVN9qfS3m
         KBwABhzs8HNwGxr2BPlGryy88eh8g0d2oVwsmPqRC6n0kiPLDgSTzDsGzLW3L5FbtZ0r
         vZCQ+aWEhzkt8uj9F5KMzsVS4WqnVDcKdGrg2mbrcdAk1y0pOxFnCL6/qwDxXXw5Yhj0
         ggD0pAJADWdQ5GpCek7rOxazqzl47iTCWRGxTizRI+8bRq7RHG5KNGvygyF8GT1PSYrL
         mbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109196; x=1734713996;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT6uCDU7W6zklXVj2xFWni1AXdhVUk0J9QH8VWWf8YA=;
        b=IMiLHWXmoMtemnvtZw1bPKTBwxJdMPfi2Dt9H07147uPtF7MRK6enqNsfwZRhxvY6r
         AN2aN+zs3vhA3HwFvRCTYKvtLSK868hsjJQDpYEQT/PoT5Sh+GfNOEYvCnYpxazDuOMw
         kYjMX//d9Y8UO/SfuIPJFk0C9pT0r4tpgkMWd//nwLVRS2DUAFWQG6YRPrf+tjC1uXLq
         36Mm3wZdtr+ym0dQkS3JTlc5eBgowAp4ScVYq+Zcjjh7V/7Fu5WY6kWti9fKkQBm+Jvt
         8KnBunxIpiVRCVFbFyxDF9j+Oas0uQfqdXUdubhhwHLfurP3pW7ai7NHHMaBqr0HSFWF
         EZXA==
X-Forwarded-Encrypted: i=1; AJvYcCUb6bCWnhsNPWknoPmWvVS7xrqOd0pMOPV5oaQaokeib4HFNMc773Di7jo5mnlqv7SDdblZ7g2uLy0xgWy/Yz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BX7Zi+T5B6B1G/611JXN47qYCd+lZ1mjQqCjkdx2tZPcFJxe
	rrnA5gYRmBwStcCNiOMBzwxi6MvgloDexAJoDNhW9LudV4gbPqqsvQAd1KMwCuo=
X-Gm-Gg: ASbGncvHpX/jrcuUyg90yc5sqARpNndkjCR9XWE4yRTat5Fp8ByC9hNOAIFn+TN8/Kd
	VBTi0uOM90qRwB5rl/QZOmkR9taJdUwHUl2nG5sv6bahd1T2TZNFjLcwEv3cOCuCRk9VPnQvUiM
	0bekylcYtsPXugMERkwlpq7wO0H9GpEvhwq+PCFxpsH6K/0k0+cpZDoz3IvMEtoznzr15otcMlQ
	7caLQm5DSN6AKcsCsMLUHVBxjvdL6pi9/2tQs7HzmTqbnvvh7gglXCY3IQeGqvcbJDpmmzCl9a8
	0kwlQ73KNjtFPAMeeOE=
X-Google-Smtp-Source: AGHT+IGvq5gARCsDTDwvtydXjxgAKnMTa84qgXrjvGYS5bvrWzXzgM5Vma1iXTGDL0ZEw4mt5EB9rQ==
X-Received: by 2002:a17:907:7f8a:b0:aa6:7ec4:8bac with SMTP id a640c23a62f3a-aab7795ff10mr429979266b.17.1734109196098;
        Fri, 13 Dec 2024 08:59:56 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b5f9:333c:ae7e:f75e? ([2001:67c:2fbc:1:b5f9:333c:ae7e:f75e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa685669acesm746832466b.189.2024.12.13.08.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 08:59:55 -0800 (PST)
Message-ID: <786716e9-17b9-41bb-80ca-b65def682f5a@openvpn.net>
Date: Fri, 13 Dec 2024 18:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 02/22] ovpn: add basic netlink support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-2-314e2cad0618@openvpn.net>
 <CAD4GDZwT=V5-3aAb7eHah5fjLC3R1CrBCVA5kUFywb+ajOvzDg@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CAD4GDZwT=V5-3aAb7eHah5fjLC3R1CrBCVA5kUFywb+ajOvzDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 17:45, Donald Hunter wrote:
> On Wed, 11 Dec 2024 at 21:32, Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> +        name: peer
>> +        type: nest
>> +        doc: |
>> +          The peer object containing the attributed of interest for the specific
> 
> typo: attributes
> 
>> +          operation
>> +        nested-attributes: peer
> 
> I also spotted that the doc: | construct results in extack messages
> with embedded \n chars in the ynl cli:
> 
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/ovpn.yaml
> --do peer-new --json '{"ifindex": 2 }'
> Netlink error: Invalid argument
> nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> error: -22
> extack: {'miss-type': 'peer', 'miss-type-doc': 'The peer object
> containing the attributed of interest for the specific\noperation\n'}
> 
> We should probably sanitize the strings in the ynl cli, but you can
> specify a flattened block comment in yaml by using the doc: >-
> construct instead.

I believe I have used | because I saw it in other spec files.
We may want to have a look at those too.

> 
>        -
>          name: peer
>          type: nest
>          doc: >-
>            The peer object containing the attributes of interest for the specific
>            operation
> 
> extack: {'miss-type': 'peer', 'miss-type-doc': 'The peer object
> containing the attributes of interest for the specific operation'}

This seems to be what I actually wanted.
I will change all |'s to >- then.

Thanks a lot!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


