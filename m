Return-Path: <linux-kselftest+bounces-18494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD69888DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF0C1C20FC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78174142621;
	Fri, 27 Sep 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmSxR155"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A323B0
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453796; cv=none; b=KtNp2gP6FKmQAVafBhv7cKsR/wJ3W8rHhPqverfEsg0eeG5BDAMpeG1vaM+o7a1xSRv6zh5gnG9bi9OexPyIhGHEZ7SCh8UsXYsDjS8704ux5o8RUcScbXets2DGSngD682AoDO9qBQOKqTgnR8xJu3fyfUqVs5vyl+QLf4y/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453796; c=relaxed/simple;
	bh=Wu52U0EBGUW8RDbNXrq7iBFkfNUHVmBD2A0I09aK/XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAtWKETr/Cw6VfQ2pdkZrMkv5nmvkpsL5/JhEMDOIM+SWjpqjfnoxldb7fppNXlJAY97MfChpUy6zVX4JT4sMaaDS1SCC7ximM3JLskziNbNOczYh8ioRNo9zAdt8S0wE+XMO+VnWZlX+Z9zjfRnkCo/IC8hhQ3bUGZdboKgITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bmSxR155; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-831e62bfa98so106598939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727453794; x=1728058594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HR9L1tFGwvsuWLdcZhMfYeFWtiRJ32Evy1PyzIhswm4=;
        b=bmSxR155LpztWLjHuK6OM0XH94QISn4Cqa81heCkCyb5UEC+4TRjr/I2E53cOBwyGX
         42L0hLiGtkq/WGzzGYYaOa+BLvFHkkJGc2Os+T1omyzcbPEgFmiXkB42ab0pef67UTWE
         JVKeSMdgXCc3TRjddUPE7HxeTXc5bw2ZNtiM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453794; x=1728058594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR9L1tFGwvsuWLdcZhMfYeFWtiRJ32Evy1PyzIhswm4=;
        b=A60lb7OEKCtpoEiBOj89SgOqpZCj0TGlOySDq4+DWPbvCDgePOnocgnAcOrm6IRLE5
         z1anEgCCZy8i/AcZs7xqd+/BXIyPCpcDqPZvX+f4krv7ZpaEN82S3K5rxy1fS7ynJVBj
         9i4UQ5ACs7AcotR3h+1pcIcsPk798XuDt3jgN6K0A9TXtnkWsaYoqZWGwumJrKYkZpom
         +tCYyj1z1E5Sy5tk5pLY6rNkbYslMTji18yZNXNqcuwkOxSvVRmtCURk8MEgmGAcKcgc
         CzqvK33hJcqp+alGK0d6TfG9GGMhuG/W0wfrtHOQ3lHaGskkh64YT1ekL8hlEdnu3xBn
         NWuw==
X-Forwarded-Encrypted: i=1; AJvYcCXFEz1BAAEjZekfNcztYb0Ahce45+miq7BGR29w/pmkQhoWB82AmJKGk9EZdkLUvnDE+j64S2D+TB1weNlZGkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xwkEVrvG1Q6sUhdBuur8DJtYwxBnnYGqFJQZe7H8Dnk/DsHb
	VCBvQ/iaRKf+Mmfqa7JehiDedmJjJ++HKvrysdl+u/dlnGY2Je9MZiBMB4llsJU=
X-Google-Smtp-Source: AGHT+IEP5nmUu95Efe+WgHxrtI1tFEnKpgExLNzW4lKixMYXEZzO3I9iY25TPelr+EvCIoR5XQW/Sw==
X-Received: by 2002:a05:6602:2b0b:b0:81f:8f5d:6e19 with SMTP id ca18e2360f4ac-834931ae996mr458104939f.2.1727453793860;
        Fri, 27 Sep 2024 09:16:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835209sm554605173.11.2024.09.27.09.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 09:16:33 -0700 (PDT)
Message-ID: <765e0a55-8bb6-45a7-a32e-73b40f92f7dd@linuxfoundation.org>
Date: Fri, 27 Sep 2024 10:16:32 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] selftests: forwarding: no_forwarding: Fix issue
 related with assigning two different vids to the same interface.
To: =?UTF-8?Q?Kacper_Ludwi=C5=84ski?= <kac.ludwinski@protonmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "petrm@nvidia.com"
 <petrm@nvidia.com>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "shuah@kernel.org" <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <fQknN_r6POzmrp8UVjyA3cknLnB1HB9I_jfaHoQScvvgHr59VfUNRs9IDo4kQHm1uxEp8_Luym2Vi6_aUGJIec3ZPhjY2qnJ57NgLZGA3K4=@protonmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fQknN_r6POzmrp8UVjyA3cknLnB1HB9I_jfaHoQScvvgHr59VfUNRs9IDo4kQHm1uxEp8_Luym2Vi6_aUGJIec3ZPhjY2qnJ57NgLZGA3K4=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/27/24 01:03, Kacper Ludwiński wrote:
> Fix typo.

Remove the above line. It gives the impression that this is
a minor spelling fix when it is not. It is fixing a problem
that prevents the test from running correctly.

> Currently, the second bridge command overwrites the first one.
> Fix this by adding this VID to the interface behind $swp2.
> 
> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
> Signed-off-by: Kacper Ludwinski <kacper@ludwinski.dev>
> ---
>   tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> index 9e677aa64a06..694ece9ba3a7 100755
> --- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
> +++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> @@ -202,7 +202,7 @@ one_bridge_two_pvids()
>   	ip link set $swp2 master br0
> 
>   	bridge vlan add dev $swp1 vid 1 pvid untagged
> -	bridge vlan add dev $swp1 vid 2 pvid untagged
> +	bridge vlan add dev $swp2 vid 2 pvid untagged
> 
>   	run_test "Switch ports in VLAN-aware bridge with different PVIDs"
> 
> --
> 2.43.0
> 

With the above change:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

