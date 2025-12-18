Return-Path: <linux-kselftest+bounces-47716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2ECCCB0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DC0230B0A56
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071537A3E8;
	Thu, 18 Dec 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEBSD81X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBB37A3E3
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073680; cv=none; b=NgalCFNGjEVWg/dbaV2bHNKVmvkQ/btXDbBKlsi/18VAgxT08o6JqmYdUZX7wBveInw8ZKwnD5hh0RPD+HPquIEEDHOaexc1NOPEj/UZsOznEtIVyGR/n6cSMWbYgHjNKqrpkU0A0p1M9w0r9dBd4ERmQwd7ZpxWJsam46YYUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073680; c=relaxed/simple;
	bh=tfGgeolmEeMub3msQoiEs35SHiGJUXuzVfjUZB+vOIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv2Bnv7iCtjMvb/uVqlfIITaQZ39eRj5JaXMo2EIQ8jJmXVkD1iPtgAgxAzBOGYtPS7zLa/aqsk+2dqBiKpkaHT+3EHaLlkN/RvrU884smKuOFSCFPW4IeTTjnlLMmsCoZhvHxWRT+zbfPo0XxfbNTohSqI+opT22O/TLkNI5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEBSD81X; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso640034fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766073677; x=1766678477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuAkrD2lct9S73QpH6jqf1LLFy31o/vRAKZaXLJid4Y=;
        b=SEBSD81XSGg5OusDDrFvmOJ80CDPf1LipzVLhmQK/frzY2B5pJoG7QFIwnhrU7y33v
         aZX33M8ZoZW4enPDTNTNEoOv4pxOZvVFzCdKTql8gnZaXuljEiMnZ7aiy4C4XnKnPzTi
         +NbeKC0sptS24l61zsxkpqajHlq/YSAkqcTPZmvdPRnaWdIurVtMypqPXhbcTGiMTLnp
         vcOuQyj15iTNS1azZopSwbFPOMABnBPRmBiW/0PWB3LpI/zkhxWn/LYZ3rMeXPqBN1km
         xBhUgw7L7+slKN7nfUGTeG1iul3Y6bt7Dl4SElvXZuucG8UtqEcEBgFDHhTqy8j4204z
         VAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766073677; x=1766678477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuAkrD2lct9S73QpH6jqf1LLFy31o/vRAKZaXLJid4Y=;
        b=dUo91J06fyvjMZD54NnazWkCseCNq0Nzt3JRanncrIcF8dH/6aES6okaq82miqe1wP
         fT8EH0qVijbbvrbWpdA/O6SvMwBkWeN7lvNKwG1bSgUvGvcrygno0dv39xTj/eudWljE
         x0aXCZ6DATPfDT9zR9MAlZtsE4we02PBXqhwU33kfLimKXDb7T9FV5QXLjJ6233bu3z4
         VZWuSUx2lQ/fb7RJLyMr1X72b44JVNebWA4UHU38uZx570M7LqBFe48PfCuvgPGpvgx7
         oke1lmNqCQtKYYjlL7Y+R8rDiLuMEVUej+km+dboqxuDtaZezePN6YUjTsS1Cbdqlnvv
         LgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQOMFwJVR/9PVqXk8fvzr5QO8bUKbtti9eFLExFkY56ytOVScb7HEIKDs7F8Yx8/+/3nMd1QEj4nrHAmIbOxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYZ7lCcnRcqKn+i834s9c4RzlyTWqI9CRQBgt0Eepc/BRuT10
	5zUE0LFnpdOsE2WnQAG8i8FCsGUjrYXZNL+x246mSYt7j0shaRtAFhl1
X-Gm-Gg: AY/fxX7oa6SzurVcj1tIo+YrEcC4dE2Xk1C3JDAE+LRy3LFbNy+3OS5CmnMuyLgYt2S
	p3kDIRWaS3V6v4/fyf60V6WcYXPIWa6FHxduqfWQjuBHHsnmswjFqC1iWO3aumrJYjo9mTSV+t5
	mkP53iiy/I5rg31R1hUVuYXrbfDnxB9GpqdmF1roiu+Qy2soaDu+qj1XJV1wykyhYORWIarVl6B
	ovd9maePaabI0fo2exLph4W/XoGAvjHSdDArsLxh1ZdD0reCK78d8z4pIB7xT3nCqv+4eY66H09
	MbDnJraHFrKu6sVqC7pU4lpo8KFm1KMpmlTd49WKblv2eJBSFVstNeKo1jOG9xmjMBHxV2WmCy3
	YnlqZewXnWQArvemJBvw0XGZ0xcpKFvPd3ExRS3VYOqvItozx3JYlGhkT1f400BtoYszmRDr3k4
	ionPlTZsD9gtDCvmmEmGtCxOe4FFS6BjiZfyVG7XW3Skn2CM/w6laEh8HbS8dboBgdX2Kfraggv
	D/Muw==
X-Google-Smtp-Source: AGHT+IFearGGCMehcaf7l2oGrHLYTG/BJJ+fsXD89fmhah3wKRDfHzTz4sMHeduJJVb5yqsIa+UGaA==
X-Received: by 2002:a05:6820:20b:b0:659:9a49:8f9c with SMTP id 006d021491bc7-65b451ac6admr9680026eaf.21.1766073676871;
        Thu, 18 Dec 2025 08:01:16 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:7186:5ba6:22df:700c? ([2601:282:1e02:1040:7186:5ba6:22df:700c])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-65cff238d6csm1195738eaf.13.2025.12.18.08.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 08:01:11 -0800 (PST)
Message-ID: <3ef6563c-84bd-49d4-a0bb-3dbc36e73318@gmail.com>
Date: Thu, 18 Dec 2025 09:01:08 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Content-Language: en-US
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/25 5:20 AM, Ricardo B. Marlière wrote:
> Currently, the test breaks if the SUT already has a default route
> configured for IPv6. Fix by adding "metric 9999" to the `ip -6 ro add`
> command, so that multiple default routes can coexist.
> 
> Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/testing/selftests/net/fib-onlink-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
> index ec2d6ceb1f08..acf6b0617373 100755
> --- a/tools/testing/selftests/net/fib-onlink-tests.sh
> +++ b/tools/testing/selftests/net/fib-onlink-tests.sh
> @@ -207,7 +207,7 @@ setup()
>  		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
>  	done
>  
> -	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
> +	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64} metric 9999
>  	ip -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
>  
>  	set +e
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251218-rbm-selftests-net-fib-onlink-873ad01e6884
> 
> Best regards,

The intent of selftests is to run them in a clean environment with known
settings. ie, there should not be a conflicting default route.

