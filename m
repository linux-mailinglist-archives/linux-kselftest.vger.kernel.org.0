Return-Path: <linux-kselftest+bounces-48037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0773CEC86D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 21:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F9D1300995A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC77430C639;
	Wed, 31 Dec 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iB5QW+1Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE72046BA
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767211924; cv=none; b=T8gGGLopeLlCKd7C4YVlx1w6XzjBHImtungAVcPmmZuiJsaFogZHee5Kr+ZzP+DHIuoYXRM89RtZA8ZyT+D3LlBqGo9Y36X6f1p3jIZYJl0eAmbwv4RWvsHKzRqqBq+HBDWtXLeVuF9KpyKTSkb70YifejQzBdv/TILyWJQ9O/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767211924; c=relaxed/simple;
	bh=chYuVPceSSUQLGNCMJREAOLJlOeq9U0vQ1l7LBCjlto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYv+dm2O0Wv1wD2NSqdLg8r3CdhDpVHe9YRsw5S77bTYBprWsatFSRq1yme3cuZI4GIBcNMe9GQXKmlKQR3zG6wmfUQQuq2tqWuYQzsNG9hsFAg2gDCxwlFzWOCr75Vrke8iRAu4KNPMpg09bA5JWpvF2U+Sfm6yfrF9p4yuwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iB5QW+1Q; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7c7bfba3996so6628525a34.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 12:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767211920; x=1767816720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+WZyiGKwxtRWmNTgZQCgR1qqjJqDclr/8rtGWc3z3w=;
        b=iB5QW+1Q88fvN2nRzjIlsCVaL4DebrFUYHTik1KxA07FbZGGLqgBaEr8d6KbqB+Rk7
         N0ICfFhRkI8ZWbtHTMvdqJNsb0d1VD1YD8upKC8u7yiyhR36aiJna+tq1af7R9rxJICx
         l1ePGHQbs7mrWXrBbgnG3ir2HdH5HBbTDsNeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767211920; x=1767816720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+WZyiGKwxtRWmNTgZQCgR1qqjJqDclr/8rtGWc3z3w=;
        b=iGbv+puzgsn+hxVkBX74AHBs80+REMBH+yO+n9AT97xu1ZoKQ7wxASQ2q9ev1rlhnK
         At8n9mKUaf8ZX8fF6p3e+l5sFzsg2CF/V7vwbtUDeK/39s3wgVD4Cct1233As7Edj88G
         UAM/fEssdkthpOuolT2ArNtpIjvcT28jlMTB8vPi1HVc+4CUyscrviLmpf+z3hqye6o9
         KSOOk6IQQDj3J9EBKiIUnpxou6liA0i0C8A+dGt1gY5MX/ZAICF9Z1z0Ow3cT8B/L0wg
         KUEdCS3cE33mZps5WNLzSNJtHKN0eYYNp57eiisYlL6cVZUf4TNPRdNC+vVKwBOLAN6F
         KtPw==
X-Forwarded-Encrypted: i=1; AJvYcCU4/P3WB1qle60BJEeqmkqRtAwLrpd1NdDCAdHzzONNkwfHAH84Ul3y/orET0wHGNRg4tKesDX8RMwtE8ZkrCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSETIF8JTtCfJedR5WttKHFNhG22H6mL3SHnANAXf5Rz/xFzsa
	bNrpnQf1kcN1tTRp/n8VndgHFImxnbZVLIZvhFea5Aehfq1mQv2YvfqD8lrMQZNmyxE=
X-Gm-Gg: AY/fxX417fbvJWI0jbePenIjzrPWas5/L60ImrUG6tTvv8rfTnVyaH9ylR7WFM5g6l9
	qMXhJPh87VdLrD9EVLxOgA6coOYwqHAykvF3DKkqbqGA/tYc2YvNufm7mzz2Hm/EzD6XXKYTY18
	Q3S/Z/iKMtpn8Us02stDJCOG6y+b8Bg33MkcN+5f4PXQ2FP0p5P6H/hQx8sUpkjfM7lUUPSIP/o
	DOnRgeNv94YE6PTDwr1MMMXxk9rhIXPP/zy2T7DmSpGRg/K6P7tkGvpo1ItxZgaaTstmeljwkGE
	Mz3X95PIAZ7SQAcgpEAv+HoVCy3CqLf8SbpPGw98RHs/P2XQLS4tFoxImOCN8NvH3EeV4tesg4q
	o4vKjc1W16FZAL0QZVYunYl5Nf0sDgjfRhhuJHCgBCVTymATBAJcjAv7FKY5h8k9JFlJatltSmZ
	BNfdV+2zlhkdqczFWPeGS8iMM=
X-Google-Smtp-Source: AGHT+IFycp4lMAWXXPAYuX6c33J/Nq7Uj0/C23ez/8N5Mi6CXgcyyBo8PU86QL/BpdyTRn+A8KveDg==
X-Received: by 2002:a05:6830:6619:b0:7cb:133b:c07f with SMTP id 46e09a7af769-7cc66a959admr18926399a34.28.1767211920363;
        Wed, 31 Dec 2025 12:12:00 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667f9201sm24997482a34.26.2025.12.31.12.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 12:11:59 -0800 (PST)
Message-ID: <4b780e63-b1cb-4496-8bc0-94c9d051766e@linuxfoundation.org>
Date: Wed, 31 Dec 2025 13:11:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: zram: use bash as script uses bash syntax
To: Kathara Sasikumar <katharasasikumar007@gmail.com>, shuah@kernel.org
Cc: david.hunter.linux@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251205233216.792698-1-katharasasikumar007@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251205233216.792698-1-katharasasikumar007@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 16:32, Kathara Sasikumar wrote:
> The zram_lib.sh script uses bash-specific syntax,
> so the shebang must be /bin/bash instead of /bin/sh.

What errors are you seeing without this change?

> 
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
> ---
>   tools/testing/selftests/zram/zram_lib.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
> index 21ec1966de76..16b108db450b 100755
> --- a/tools/testing/selftests/zram/zram_lib.sh
> +++ b/tools/testing/selftests/zram/zram_lib.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
>   #

thanks,
-- Shuah

