Return-Path: <linux-kselftest+bounces-18140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE997CCAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD70285813
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F391A0AE0;
	Thu, 19 Sep 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPWtMNiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F119FA86
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764715; cv=none; b=ESIlWasexDCyUo+A3aS35p0+ZW2xNai8e6OIE+9elN09HpJEhRhkZqHELY9kgChVbrdfiAW2/5IRWtE5PdliJj5nvThKKJzIqhZe3bkKVld9+WyAL5Brn+lqbCPYVTt2Gp11aZLgYegmFtBXaLToBbaFPbYdXpJ5FWG0aqvSnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764715; c=relaxed/simple;
	bh=7AjX216hBiSmKK9RQ3EIo0IN0EmiJalVAF6t2hNVh/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXE0dS7qZYKzMGlwit4C2j8ZFM39/Pd5F6UP6TBTiZ96EJgo6HlUHCq3CtxKFdx6i8sZLszESC30Si+9r/CfK3FVeLuG6XuBttF+hcwMgOsctrWAei11/wSgsWwjeACsATU7a7XPfAduEMgw6cVvZ5l46iv/5GK4tZStlqPCFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPWtMNiI; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a626d73efso49117239f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726764712; x=1727369512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCBShzGCYmt7eulcXkzUVoOviOICtP7u8yVZ0cTIMuk=;
        b=aPWtMNiIUWZfJYZdNGHGzHaLYHKaI5iKu7IYiTNhekK+H6rB6vHcsh7+ygz92tV2gq
         A58TuuOZbxVOww2RDZJnod2Nl4OnwgUP23rFPRUwDSGIY2x8m5XVC4pH040Zldkjp5p4
         pHk0LqPTMuH0W7yQ2B0/7q6kbpl64l2z/xeRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726764712; x=1727369512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCBShzGCYmt7eulcXkzUVoOviOICtP7u8yVZ0cTIMuk=;
        b=B9gY91r6lNND1znB9j0YW8DXWR46zv68jaPXlq772h2lrARsgO8c6P3TO0aQSqHMN2
         zTRqgqFf5A0RiUvGKRmh5BlpTzkY3HkyzD8zhPs15u9xPA1g33rVijc/6pfozbIxahfO
         g95tInmESvxlqbD7xz2zmDGUOfaIBE9G6hI5m2BI9/XzhCrA7IhgQ3+VXG7C3Fn7ICNO
         LGXY6i118TZw2Z8V5TOdxHvYbNpJbqNnFHCZyy5zEr3WAVVIPIoaworZ4siW0vjxotZL
         ZXNgZFUUQmDzjoLt1ThIYE7KSMhtEodv/VWPbND9rH4rJSAKJxOCMivzFbw1yuYGFRnB
         z+zg==
X-Forwarded-Encrypted: i=1; AJvYcCViRcW83opVwT//8aSF8Tdrfg9BqxF9nDbDHb80b7xeZ1mMq2XOPvuftQkHe9pI48DbRU18df0eOKqVP9FxzPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKj8nfjBDZahf5jpNXeRjc33f8xIZL7Y4iR1Xr/lJzMNr1P10
	j60WGk7YhbCZFSE8kRlsRfzTVHPUAvXHjNf64KUfsAJ1rV1V+TvGDOYDXrjPWIA+eqoJJ7VtlE6
	4
X-Google-Smtp-Source: AGHT+IHacpHZwRFx0DkVcnOrdSOFOaTGVp1nfqJ+PEWF5NlnSzouCzS7oWHPPlYwjNpL79c1LhcTEQ==
X-Received: by 2002:a05:6602:6417:b0:82a:a7c6:dae1 with SMTP id ca18e2360f4ac-83209e8e844mr10457739f.13.1726764712447;
        Thu, 19 Sep 2024 09:51:52 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf4476sm3080989173.2.2024.09.19.09.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:51:52 -0700 (PDT)
Message-ID: <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
Date: Thu, 19 Sep 2024 10:51:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: fix compile error for
 vdso_test_getrandom
To: Yu Liao <liaoyu15@huawei.com>, shuah@kernel.org
Cc: liwei391@huawei.com, Jason@zx2c4.com, christophe.leroy@csgroup.eu,
 broonie@kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919111841.20226-1-liaoyu15@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240919111841.20226-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 05:18, Yu Liao wrote:
> When building selftests/vDSO:
> $ make -C tools/testing/selftests TARGETS=vDSO
> I hit the following compilation error:
> 
>    vdso_test_getrandom.c:260:17: error: 'CLONE_NEWTIME' undeclared
>    (first use in this function); did you mean 'CLONE_NEWIPC'?
>      260 |  assert(unshare(CLONE_NEWTIME) == 0);
>          |                 ^~~~~~~~~~~~~
> 
> CLONE_NEWTIME is defined in linux/sched.h, so fix this by including
> <linux/sched.h>.
> 
> Fixes: 2aec90036dcd ("selftests: vDSO: ensure vgetrandom works in a time namespace")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>   tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index 72a1d9b43a84..84f2bbb2d5e0 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -19,6 +19,7 @@
>   #include <sys/ptrace.h>
>   #include <sys/wait.h>
>   #include <sys/types.h>
> +#include <linux/sched.h>
>   #include <linux/random.h>
>   #include <linux/compiler.h>
>   #include <linux/ptrace.h>

Do you see this error after installing headers? Installing headers is
a dependency to be able to compile selftests.

thanks,
-- Shuah

