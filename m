Return-Path: <linux-kselftest+bounces-42264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE7B9C88A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 01:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884223B19AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 23:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06829D289;
	Wed, 24 Sep 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nst1VxXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1817B418
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756289; cv=none; b=dcRGQBR/3Id8S7nhdl1P2tqoia7pvqSXqmnp2HWNdIwDhVPCOOakljbGzLI90FibctcgSGiod6xQDEQKXWftWral/4mjJ/exXlLMfjOCWnxFdH/UAKGdXi7akEB0hB95bHCvbfZdikGwdzLe+3VRO5LZa41MXncgI5wSCjQKcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756289; c=relaxed/simple;
	bh=Jet9kq8CcDeW5yvSbvCPvhCQfK1lFKgzanZH5IgLSak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbCRY6OpnPvqC1XVqxVjgejPWYN6uqlb7aL4zFWKZ++6GClK4fU0qO+lL0igO4wZ9qhwAF5jmVVGWEZlmE9qm2MmiFOyHNyeqW6/pSCD4UxgTaoRSdRufkY1ZXR/kFlSUpP1EBe+eJtwJCSKIBWdwdAxMJLzuloi1XbMCjPFY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nst1VxXl; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42592472002so1048465ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758756285; x=1759361085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq5rS7xIu7WGCSuxCIQa3Zphf2jLEucbvivd19Lb6wY=;
        b=Nst1VxXlYNlMvSWhwgnAk2oTzSN//QgFfJ8ujbYkSCr8MpT4H/MpsNwzXtGnbHE3Od
         Y+kKZX555IVCAQWqTq47KsNVydKaZ0wQNmoyMsA+32VdNzW3pMZXVx2EIzmBpAOmaqL2
         fQhoUwQdWLVWjeOrtKUwI/4mXwMiTvA8lqJQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756285; x=1759361085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq5rS7xIu7WGCSuxCIQa3Zphf2jLEucbvivd19Lb6wY=;
        b=XZenD1nnuqr5OR3RDZ7n7cctCpx6Lgwe04VBPZ089/hQ6XiOzGpuq30TBZsEaCdst/
         ehr717+N5wZOlfHzWUzH/2C+L9PLY+FVUhPlFNkK13CQwzWiLhIs5+GpfCyjWcNyypVG
         v9vZ2RvYi6lBqE0Y3N7Rn+drqybKa1pEZGyzgvVAHUtnv9ddzNHAXRpOErcQHJ/5OaB4
         ox094j5DvWnX9fumAhqkihSfPLoTCrUvnqmNOz0UhAMdcYGXhqzUiaPjmirvTC/ucMo1
         fSq7oGaVk6EU8Am9qwyINqOz43+vdLtzXPdTVTzaHF46xGrqDSBLBzsPHikj7YAAVq3m
         phgA==
X-Forwarded-Encrypted: i=1; AJvYcCXCzMmmNwJudK7vHMI13nXx4ytcXRW7fnSCzndm6dKHmy7h0ROcgQiquVt7elyHnH2UqAa1ACVqyWcPp2nWKg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfs2p88KXbwhxPBB9POvWd71nvxhNL0F/OSS6ttd6ZGylani4t
	wOz1NXlOYGZNryD3DyHpndffmRVIBB2PMHev4qQ60ciEe7oUGdUep52Pt+qNHYdUkTQ=
X-Gm-Gg: ASbGncuqIHbRssaayYplEj+jeI7GpvUKJI1sKTquZlvUfBjcSb06TEvUWtqc31kGEtA
	BYI1IGno4Q1SfdKaWV8Dpe5XDvUev3EtLkqsWgrqxxD/sCyIrdSYLQ+pqWV/uMFcp+EeTksPYfx
	FjydrUUjy1yorAzhQGUuobk9YKucsdkZ+FfMtDpDhMGLI7M/wkDuTAFOqo8y4nqGT5HjkmmMLpa
	o+Jh+BZVHdag9bUa93MhJrEHuYoZGwJLSCBm+9Bt/8856CsUg5OzVPU9K0/nnwHc6polyYwQFqw
	vkn/x2ZfJfay774KKPBNbDQcGbUhFae0Dz8xHw4P/oRs7qEs3H07N4U72Dhz71ZqQdbYfOO/Kzu
	Ito0Wu5L8HwWoI1CKTJG/nxl6WS5B6vEkgJ4=
X-Google-Smtp-Source: AGHT+IHtbdaGjSQ1EGfQsTrq38djkX8/uDp9qw42nO6KVolXPaXkx0LkjW7ug7t2nqAz5ORH3OQ7cQ==
X-Received: by 2002:a05:6e02:8a:b0:425:7974:fe21 with SMTP id e9e14a558f8ab-4259563dd93mr20006775ab.22.1758756285448;
        Wed, 24 Sep 2025 16:24:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425c0546fd3sm2131295ab.45.2025.09.24.16.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 16:24:44 -0700 (PDT)
Message-ID: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
Date: Wed, 24 Sep 2025 17:24:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log
 binary
To: Madhur Kumar <madhurkumar004@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 03:10, Madhur Kumar wrote:
> Some kselftests generate temporary binaries that are not tracked
> by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove process_log
> during `make kselftest-clean`.
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/acct/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
> index 7e025099cf65..16eb97079e63 100644
> --- a/tools/testing/selftests/acct/Makefile
> +++ b/tools/testing/selftests/acct/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   TEST_GEN_PROGS := acct_syscall
>   CFLAGS += -Wall
> +EXTRA_CLEAN := process_log
>   
> -include ../lib.mk
> \ No newline at end of file

> +include ../lib.mk

Why is this deleted and added back

Please fix the patch and send v2.

thanks,
-- Shuah


