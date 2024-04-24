Return-Path: <linux-kselftest+bounces-8768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F08B0B16
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26411F213D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0F16C6AD;
	Wed, 24 Apr 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E9r6DHmE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559015EFB2
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965607; cv=none; b=PihaUtpnlh0DgsKrmHSlEeuX2/iRPrE7RbSV5zhdH+a/+kbPL5CuDUhlfpcZPdlQUVCFUrl3JcUa1nPAFtgwg3+BjRZuSDaV7q/t9FP4lkPMmTQ6H4dkcPWxfyvFfE/KrmmnV2VY7wIda/6qf9q3CdOqdeyOmNR3cYePRJ3YJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965607; c=relaxed/simple;
	bh=CYZJM9W2Zf94rPUvddceU9zBJpQcu9n/hjV8sSH5eg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0wg18Vv4AlWs73P/T2KXgpdtl+hSupDAfHBjmDFLK9iEKhc0yEkxAC8B3Qtd3z9CDwV9cRPmOoy9lJWbfZ/SrTZyM8vf2oCCuEpxVXw4wvliNalfWo9sKr/EfAHmHf7ZTeMLcronxyNeH4r0Umq6jSUWbyphdXZsaXALxRgYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E9r6DHmE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ae3afb81d8so651334a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713965606; x=1714570406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fab3Tuq9UbIYWyt/yROOhPd6Au0KKupHpH9rbvKSy8M=;
        b=E9r6DHmE6v6IOfd2vxu3BskovFbVVvj0MfjnpPFxdyrKXjcqeVLgmofxM0M72cc8+E
         ys923AUHHZCyrdmJUEhD8E6AO4fp/29Mro6rBqYCj6a3sW7zG7NlM03I2wsMn9dYYB+J
         5y4mD/Xnq2raeASB4bnPtz7dHkiu5NH4UnTYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965606; x=1714570406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fab3Tuq9UbIYWyt/yROOhPd6Au0KKupHpH9rbvKSy8M=;
        b=iGuLPKBC+8YNe6ak3iOAQx35XjY/1uMkLAP9ZmYqWu6IvgSJBJrABKLb1PzskRdaMB
         aGhAlly9AmRpFj8w6UuuiOeusbb8RKBtMDTdE+dsQLRq3tNpLpGrmy+ghQpVGBscmb9g
         FgEYYNjbflPUVjleJm3HgnxAUerbG5C3G/2/ac2/bCqOHHDq2PyJ2wV92daYbwKY+6OY
         S1CYaHhDeHFPVaFRaQZRxxCmVYXdfWzRyquigLOIMPOq1mFIrM34ygNRz90ySs/wUNSR
         orVUyhp5QQFi9hxhWhPfz/IQWDX/sTRH/xy6fmiNGYkCauQKWw3X6r3298Tefh/JTieo
         UQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXiSgjhbT/jiGpX0sYPGiSFcO0aaV8uJ4ei3TxkAp7mrhIw4F3FjvSmFL33cIbDNwFHEJvfoc/0K/3yebo1Drtz5WS+btsZvkLaAiIxehxq
X-Gm-Message-State: AOJu0YxEPs2ZApAVNHrZEJZbm+OERK4xVOGixsmKyy8Gi9r1ePnJmcIa
	IiKeH6V/hu3QRxQLyYkWk3PbkAILaXdBafy6CtC/vzV6HVPYMXb49lqa27jhElg=
X-Google-Smtp-Source: AGHT+IFY24C7A5lVbo4EMu64C08Cj9sss5y8CxkvwTgEPXUiuaAVRDd0iTv9OJBF+htvMtn7t20p9Q==
X-Received: by 2002:a17:902:7610:b0:1e4:3299:2acf with SMTP id k16-20020a170902761000b001e432992acfmr2640139pll.3.1713965605357;
        Wed, 24 Apr 2024 06:33:25 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b001e3cfb853a2sm11919457plr.183.2024.04.24.06.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:33:24 -0700 (PDT)
Message-ID: <89605a09-3d19-427d-a368-374777449c1b@linuxfoundation.org>
Date: Wed, 24 Apr 2024 07:33:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests: Make sh helper and power supply test
 POSIX-compliant
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
 Mike Looijmans <mike.looijmans@topic.nl>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/24 09:32, Nícolas F. R. A. Prado wrote:
> The patches in this series make the ktap sh helper and the power_supply
> selftest POSIX-compliant. Tested with bash, dash and busybox ash.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Nícolas F. R. A. Prado (2):
>        selftests: ktap_helpers: Make it POSIX-compliant
>        selftests: power_supply: Make it POSIX-compliant
> 
>   tools/testing/selftests/kselftest/ktap_helpers.sh                    | 4 ++--
>   tools/testing/selftests/power_supply/test_power_supply_properties.sh | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> ---
> base-commit: 7e74ee01d1754156ed3706b61e793fbd46f5cd7b
> change-id: 20240415-supply-selftest-posix-sh-aee99cf85e8f
> 
> Best regards,

Thank you. Applied the patches to linux-kselftest next for Linux 6.10-rc1

thanks,
-- Shuah



