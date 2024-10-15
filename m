Return-Path: <linux-kselftest+bounces-19745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD81499F212
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF6B21311
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A281EC006;
	Tue, 15 Oct 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FeIOaSIW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACF1E6339
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007793; cv=none; b=N9REB4z9dwLC7AY04Mk6dKhTstEkb2T/ep/9KbObvPDGWoZ+lckFi4SOvsNSM/+vP51D6/JBwkGfJnpyvl0fW3wVRX6kc3TD/B7aCYs8XsQF1tyj3PQIk4s33UuxC7g77DjpCtSsrp64d5O8+Hm3j7lH3/U6KN7oWVDs1Ab3aT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007793; c=relaxed/simple;
	bh=SZmQQEvzj1sK3lrhencXT1UrXomSJOeFE0GoLWS9yl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ9hKEDnbhTHTnBZVs35JrNUa8Px7N5XfZLUGJGLJUavLwv2T/0OyoB/EO66PGjMcmjvlEFh7OBqHrJoqrwF/JdOF7GvPnBSX5UdMc9Rm6gq6j+rGq1nNuCn+MD6E4qOWnx7v2G0uvdFhxuJlQEIXgBNVEZMxxqxFRkIoy81yrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FeIOaSIW; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83542d9d7c1so235857039f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729007790; x=1729612590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ajj3sR+OG/fmXMK7n9QfmmmRJDyO3mKj7b+icSfBwGM=;
        b=FeIOaSIWVAZT4KYWVKLxeE+qB6H8zvOzn0GJODrXbGyO3SnkvOP1E/tiAWcE9dlK4c
         9wJb20J8l77tLuRLDBWWW2GKf+9tiSRUt7We7qvg6QAKr6s05Pv2vtQNY2UqIVbS2KB2
         23F5m288V1D/fs+HsSU/Bd98DSmVyTUfRtHtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007790; x=1729612590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajj3sR+OG/fmXMK7n9QfmmmRJDyO3mKj7b+icSfBwGM=;
        b=oSXmkpJWkKBSjaJUN3CpnmSeYS8ZBljhR0XIQ5/1rUX94825TaZjF6DUOxNpSwh5dP
         E/f0CrXePoMr/HEQY4m9n77d79NXqrCXMfcThwBcuERtaCKPQU0My/nvxqLyva0DF/5D
         6RhZ/lJTcDf5S7qjvVcZTbQ1MhpyQQxKUlAOHkZLII6GSIqdJfwanm1A6zpcrw8JjuQz
         bVBA48wQWoB2Yn6e3QTQCug9QJAmFKxr9A5c4JVyPaaGkg2wSYqVBMcOH3Rl6T8ZXYYM
         PKM1wJDIEjKUCDSdWB7MhzRkQRNc9Hh7RUqB8aoZ7ULbgHf46AdCAAl9NZt7FwXt3mhV
         Ix8w==
X-Forwarded-Encrypted: i=1; AJvYcCUvefggAzv5wszgnPPzG205fFLIPDyqtT6ByJRCv5qnW2T8M9ROa9fceJ5+JcQIBsnU3nchm3rjhIdrK44LPJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6ibd6TQW3cPFwUbMbEvMDqB+Eq/nnAsgrGQ08Ihusmz05JSu
	RPi2+aVscxe4mF0G0XlsepEW3SWLVOS7sW4W+A4xiyC+li9t/UF3/A9BbyaNDBM=
X-Google-Smtp-Source: AGHT+IHYoTPL3iz4k8vJd7tepn9pdJV/a5fIUVmq3xceu+F7hF09Pe5IS83gz3y88kzvBDJ62eMmRA==
X-Received: by 2002:a05:6602:6213:b0:83a:712a:6aeb with SMTP id ca18e2360f4ac-83a712a8524mr914309839f.14.1729007790234;
        Tue, 15 Oct 2024 08:56:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc6a612sm373480173.162.2024.10.15.08.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:56:29 -0700 (PDT)
Message-ID: <6dfa4266-bbe7-4c30-a3ee-1ff5a4b28221@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:56:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: ignore output files and clean them in
 Makefile
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
 <20241015010817.453539-3-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015010817.453539-3-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 19:08, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>          cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>          cpufreq/cpufreq_selftest.dmesg_full.txt
>          cpufreq/cpufreq_selftest.txt
>          zram/err.log
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/cpufreq/.gitignore | 1 +
>   tools/testing/selftests/cpufreq/Makefile   | 1 +
>   tools/testing/selftests/zram/.gitignore    | 1 +

Same comment here - two separate patches and include
key people to the email recipients.

>   3 files changed, 3 insertions(+)
>   create mode 100644 tools/testing/selftests/cpufreq/.gitignore
>   create mode 100644 tools/testing/selftests/zram/.gitignore
> 
> diff --git a/tools/testing/selftests/cpufreq/.gitignore b/tools/testing/selftests/cpufreq/.gitignore
> new file mode 100644
> index 000000000000..f684d27f5d91
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/.gitignore
> @@ -0,0 +1 @@
> +cpufreq_selftest.*
> diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
> index c86ca8342222..9b2ccb10b0cf 100644
> --- a/tools/testing/selftests/cpufreq/Makefile
> +++ b/tools/testing/selftests/cpufreq/Makefile
> @@ -3,6 +3,7 @@ all:
>   
>   TEST_PROGS := main.sh
>   TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh special-tests.sh
> +EXTRA_CLEAN := cpufreq_selftest.dmesg_cpufreq.txt cpufreq_selftest.dmesg_full.txt cpufreq_selftest.txt
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
> new file mode 100644
> index 000000000000..b4a2cb6fafa6
> --- /dev/null
> +++ b/tools/testing/selftests/zram/.gitignore
> @@ -0,0 +1 @@
> +err.log

thanks,
-- Shuah

