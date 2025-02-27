Return-Path: <linux-kselftest+bounces-27792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB66A48602
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 18:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4D178097
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842AE1DDC1E;
	Thu, 27 Feb 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fI4QZOX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8771DE4FE
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675087; cv=none; b=hvMR3/5GWJcYt05//LNQ8CbDb5HnbAPTmlhVm4BgJNNigSBq+cScNmvgeNw9H4OFf1DK3CvC4WZWFI5s5N/LSeDr/iRmI+dl7C3ycuSd69eeGPTXtbK9rnTszrTZnSb87SiXFQxiUVOEDjuBp9EF/ybk1xjyzGXlm+AtXxIhOaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675087; c=relaxed/simple;
	bh=4gouhfhaxGfgdJQT2qIfnmuu//pDsJmSVA/PYTeND9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R85EosM4WgAjQnpZyp/2V23W3grBaXH/X16sC6sq+DI82Ne0qMBfm9oB4Sm7qUEOJYv+vF9w3X9l1Vk9DNL5M7Hqz+/ALJRBTD9OAo2UAn1Oa2u1x29LOzfkTedWbC+18zkH72jhGpMaq+8sqXQcpqPuRRglrqO9EjU0U9+5ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fI4QZOX5; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-856295d1f6cso86587239f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740675084; x=1741279884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ic5EBkS7+JFP3KMIJYtrI+hREWqtDoF6xlcqoBHvEdI=;
        b=fI4QZOX5h031J1FhYTfKdSftuW3lwo3bPIjsE6Ert7Y2PJA96rab9OVfRSdYzYPPwL
         C+5SyaoFV+1+cj5sitAMk6OK5qEVn3d9iRlpFt99VVJcPCSnVJlDl8A1lrvrUMz4hpPs
         M41/8ZUCWXucaeBVjBsfYaYzXVy2PeCx8OlJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675084; x=1741279884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic5EBkS7+JFP3KMIJYtrI+hREWqtDoF6xlcqoBHvEdI=;
        b=tQJq97Fpyw/EsYW2BdtmysDH5L4hWhIksxH7vbLNBCVbEGlk1+kl2O5aYhOpmNamOl
         icQF1lgz4J11LHg1X5FY48LU2M+h48zry0DXSAE839wXa3o4TCsOqQF09mqFJlcJB34q
         7ODM3UqAu7Q3gMWMz6pZmK8lyJ/gkTjugYr00dv6UswMQWvA6ZW85vx2zM3fCwLSpAmO
         53cR3igw7V+78gp56jJqd8RLywg1oxfL7pHVm0iL50y5m2x8ElXhkGdhjrFXXFdF3+Za
         9lwYnkwYw8c6Huw3NE0Bb6WCLZ8WYFC/dfebD7/o9TUFxUFDSol71sbv0sMKQerU+mSa
         4Tcw==
X-Forwarded-Encrypted: i=1; AJvYcCW7IzeosKtiiZ3bu6JiwAkf4mD2msKK3XOVrtjcF3CxHi/7erHvf6eZ9OYL199A6cyoTka9yorOMp1bhEWOZdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqYTbUmnP+xGhBnqTRbCVT6MODjNQiSt1RVAaOGPSzqEC1uWZ
	VW+eSS8Ygxx0fq7G4ZK0CEWFQpjkOT9ocKV49dXgSIvX9NuHrl2WF9XP+wVHWPM=
X-Gm-Gg: ASbGnct9OjBBlHhfIEqolARiCM8MAZAwI5990eOEp2Pnx9B99q9b5VjL2zYgfswYnfc
	lKiBxDYxQBulY/OUbsIE+3C2baOFAuMiMM+6wiRmZtPq4rPUBJ5O20oFeelHmosuIUkk5M7ggbv
	xOxhXc/K13Y1EUhSdf73Ee4X7gFPSAwebhUR+RAm6UwF6p38MRg6JDLWYZRnsog5ArKygMGHKFM
	w0pnldP7t3l77ZXzKzbj7gMTKerdXXhauitI4GhQr1THDwFLbZiSa8a/aZzCcrclX2tveDO9rFh
	UQB0MpG0LbwNVgMDN9VVnrfVFxk9HrC4qLXd
X-Google-Smtp-Source: AGHT+IEKP5jXvQi+gty0oL9paLtd6bEvnw21y9vRTtZa86aBrZwrysNK0Dih3A+SeI1kAgbG7udiYQ==
X-Received: by 2002:a05:6602:154c:b0:855:c7a0:1e33 with SMTP id ca18e2360f4ac-8562014a579mr1407018139f.2.1740675084458;
        Thu, 27 Feb 2025 08:51:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85875115643sm38408539f.14.2025.02.27.08.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:51:23 -0800 (PST)
Message-ID: <083e94e0-dc37-4cdd-94a3-db258635a684@linuxfoundation.org>
Date: Thu, 27 Feb 2025 09:51:23 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2 RESEND] update kselftest framework to check for
 required configs
To: Siddharth Menon <simeddon@gmail.com>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
Cc: pmladek@suse.com, mbenes@suse.cz, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250227053322.114215-1-simeddon@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250227053322.114215-1-simeddon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 22:29, Siddharth Menon wrote:
> Currently, kselftests does not have a generalised mechanism to skip
> compilation and run tests when required kernel configuration options
> are disabled.

Skipping compile by default is not what we want to do. Tests are
supposed to compile and run even when config options are not enabled.

There is something wrong if the test doesn't compile when a config
option isn't enabled in the kernel.

> 
> This patch series adresses this issue by checking whether all required
> configs from selftest/<test>/config are enabled in the current kernel
> 
> Siddharth Menon (2):
>    selftests: Introduce script to validate required dependencies
>    selftests/lib.mk: Introduce check to validate required dependencies
> 
>   .../testing/selftests/check_kselftest_deps.pl | 170 ++++++++++++++++++
>   tools/testing/selftests/lib.mk                |  15 +-
>   2 files changed, 183 insertions(+), 2 deletions(-)
>   create mode 100755 tools/testing/selftests/check_kselftest_deps.pl
> 

thanks,
-- Shuah

