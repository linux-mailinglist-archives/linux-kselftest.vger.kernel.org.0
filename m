Return-Path: <linux-kselftest+bounces-23171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C379EC9E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 11:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6D1288770
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7831A8406;
	Wed, 11 Dec 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cZ0UTD76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DFB236FB1
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911242; cv=none; b=rzxS5sYPsh1fFQQII46m+bNO1cw2NKWPdj4FIP1zmrbNCnRn3tzZtDQGRUlo60+P1gjxHVONfEXdTC78JcvmjFvB+eKh3i4VXIcS3H+zy3HbWbUYfdgzE5lZmFVs3OKmKhf88RCt3Gak6SqIRQYf+xfsrp88MP51ljjTCuQLx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911242; c=relaxed/simple;
	bh=l2HDRx9s3IYeilf56T9MMX/eWgMp5kRY3lPIhRZpvMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozmw4oqbKleOlXMMah4aGu7JHiN+LIBxY3Eg1pXGfOp0P7bWwYMuzCx4v9mmNulyQBnJOwoBYN+vEWTf/CzuyJZrUEblYowjIs20po0ATVgLg3p2Ax1t2dfPhmgbjhKMga0ykVGcBTO0/5roV8egwSJkr3r8qV7byzfo92jlkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cZ0UTD76; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d161947so3163352f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 02:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733911239; x=1734516039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UMc2ax6F38dbcr0u1xo9DcpAMAHTz5GuKuNJd8GscqI=;
        b=cZ0UTD76I9lPYMeAOnvbrHCjl7Y8zfBdRZLtO4mnk0/DPC8Y18ZiSWV4G8X9jT1OK2
         520uTj3t8o6V3Klr8B5PIDtZx+bdygBJ7OtraTjjHzSZjDaPojK5Aj6O4xOLseKxEG1a
         ziLpYP73iGPnofQHvho9PHhz9hP0oQixOm/cfRszqG8PbtzOZuQ4GweiPuenHXukPh04
         Amh7EUxi07o3YF/ZrCN9/716dZvtzn9VTxiKow34L8BTkyr+N7Z2HqxgkMwzYdZPSU3j
         au7n5HbovaFvg1gUZHva/6cLtcHDhMQu+fYlAuXL7U57tdejEqlqb8rmWaOlnyebMqDX
         P1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911239; x=1734516039;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMc2ax6F38dbcr0u1xo9DcpAMAHTz5GuKuNJd8GscqI=;
        b=VZsB2S9snOgw3EibuBumj5ayqj9qT055VFMJgp2GJ/ePKT5ZyxTAgtocHRn8DyT2TW
         iPxdvMwroMTyCB1NyNtL5D8wm3MnNMu+RqnICx01+oxcMDO67qw2UpChWZ6X9Ip+iUs2
         31o3K5CKlcbVzZbnXpaFyJCFUqo55Te3VqFfTvlVFLwCi8MZdqEzfLWTNh47ZCyF8A4L
         vVMiB/5D1qE5xZTQEuOzuyRpBcqyEFOQX6PsPZkjYNGgb80yiqtaoNDMqAEhlvh4I7aG
         OnF/9DZwJvFC00H+Omdm/RsVJOISMRDC+4nuA6xNYJiARMISnzl4hGY1qMPBz+hXXRPy
         7CbA==
X-Forwarded-Encrypted: i=1; AJvYcCXKBO0pIxCrwpqR/x+n3PIM6/ZU9KoncLLYAPTdtS74ZFozPO2gQb1//qBcjVxLy6yXzn3WI7IMzWp7DI76axk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHksf/nV2nA+xHTmt/nn/r6hYw6oa2gx0wgCF9DrjPWuLkWTB
	zwKTRMrQS06+nMcXAjpbRxp0DORNM1ilPIg2pziHxrvU6ZzRBmso5w3rPSXYjMA=
X-Gm-Gg: ASbGnctAEN289OZscdLMHkTuA/Mh60jhXv4Dx1ZU7bPhRiZpT1JictDbS5qPnvuwJtU
	j8Q71ZER02vMlNwCLTZRjyu4EKwNRZsst320ESRuyo68RvbmT+Kxv9iyf/jnA7RR1YNo2yHgrcI
	RHanQNKA5abuJ9lIExHX5GxgjZwBCksDDv2Y0C8Y6e3BMqVeCpJ1vKchUDZPYk4EcI+6AraZdVV
	VSh7bGymEyxR6oiHTp6dPZlFNwrmrIcBij7TBpDwXPoDnhtQ/cmNonBQNfT791+biZWk5XIHjxy
	ggTAsyEEn0yCrA==
X-Google-Smtp-Source: AGHT+IHcJjJ+FCos6cp/acUTFedh+NmuPc3H1sR775qCVahz0+y7bhu/h2jxV0OaPytf1HoxK6EI5A==
X-Received: by 2002:a05:6000:2ad:b0:386:3918:16a8 with SMTP id ffacd0b85a97d-3864ce54d8amr1878672f8f.13.1733911238681;
        Wed, 11 Dec 2024 02:00:38 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f6e8:f722:d96d:abb? ([2001:67c:2fbc:1:f6e8:f722:d96d:abb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ea3sm902187f8f.28.2024.12.11.02.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:00:38 -0800 (PST)
Message-ID: <cee54e4f-a909-43bb-9a46-b12aca404d08@openvpn.net>
Date: Wed, 11 Dec 2024 11:01:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 22/22] testing/selftests: add test tool and
 scripts for ovpn module
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-22-ea243cf16417@openvpn.net>
 <20241210164715.GB6554@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241210164715.GB6554@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/2024 17:47, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 09:53:31AM +0100, Antonio Quartulli wrote:
>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>> kernel module.
>>
>> [NOTE: it depends on libmedtls for decoding base64-encoded keys]
>>
>> ovpn-cli implements the netlink and RTNL APIs and can thus be integrated
>> in any script for more automated testing.
>>
>> Along with the tool, 4 scripts are provided that perform basic
>> functionality tests by means of network namespaces.
>> These scripts take part to the kselftest automation.
>>
>> The output of the scripts, which will appear in the kselftest
>> reports, is a list of steps performed by the scripts plus some
>> output coming from the execution of `ping`, `iperf` and `ovpn-cli`
>> itself.
>> In general it is useful only in case of failure, in order to
>> understand which step has failed and why.
>>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> ...
> 
>> +/**
>> + * Helper function used to easily add attributes to a rtnl message
>> + */
> 
> Hi Antonio,
> 
> This comment starts with a '/**' but is otherwise not formatted as
> a Kernel doc. Probably it is best to simply start the comment with '/*'.
> 
> Likewise elsewhere in this patch.

Will fix all instances of this issue.

> 
> Flagged by ./scripts/kernel-doc -none

Darn, I have been running kernel-doc only against drivers/net/ovpn.
Thanks for pointing this out.

Regards,

> 
>> +static int ovpn_addattr(struct nlmsghdr *n, int maxlen, int type,
>> +			const void *data, int alen)
> 
> ...

-- 
Antonio Quartulli
OpenVPN Inc.


