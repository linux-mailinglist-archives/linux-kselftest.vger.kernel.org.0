Return-Path: <linux-kselftest+bounces-12829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC543919AC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 00:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D98B23C12
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 22:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA1190079;
	Wed, 26 Jun 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OA42T2qw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14594168483
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719441573; cv=none; b=AQ6filugMIFi30wR5vTMbUU+AKo1/A7zxCTNUYo/P+AaPdx6aRHK6Cdf8dly07Tj4HF93idXgTSC6wUVmT8t3+J3hDCCGYS737GB9ookPTG21gX8cX+ythzPXlwpjqQb6nsLoqQAMBXX4Qw5CtGl4UtqTW7Hcxk3mEdnpvUx4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719441573; c=relaxed/simple;
	bh=1uIezo0wMTAam0rEHWdA7t2HG7nV3iMMf4wI/YfT9UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ib0nRt1/xYl7w2QAO157+NYhMlPJqMLJ8Nk2MnBinLKvpdQfZ5bECaWCRM61+APhvFqrFIRH4TQomDIoMjkajZq1VzXOQWWcoKcfcBPoYgWi7z+uY4frhwSrvAXSol/guO319Db+nXWhJoo3BWknXQHE+CjggRS78JpQMtuo/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OA42T2qw; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f3c804daf7so8526939f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719441570; x=1720046370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EhaZBkOkQeeYp7tfywSH1lk94wLk79GPO1un5xt6ho=;
        b=OA42T2qwrAtooMcCQiH2FWU4QtlLJRy8L96UYDehKZh8C4tCBQXb8RMa5R2DSD7rrz
         oVmnBOc26TdgJx16frd7klVTBTeYEpnVlMhiBEcL0n7cIMpUCZLwqmvzY1LgubjFdLPy
         OyELIPF90gQUjx1sU0EnKMdoBJfIBItMKsTSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719441570; x=1720046370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EhaZBkOkQeeYp7tfywSH1lk94wLk79GPO1un5xt6ho=;
        b=X1tEW043BTwsYtfB+UrLzQiFfV97oXIA269jIW2yvkjdPT7yiAS9+0Ls9/27R7wAVy
         HvgqSOCVUnyF4FqHlpTg6RN5xBSBElFlv5RaDegdyUUs9/IeuxMgM4ilhBfNFN7iKdxa
         mnC2qSu4szei7zV8xKMbJ5FVZkHPvBW9e5XVsYQH4tS/8cdVJjRJMYOUdfvXWh7Myq1c
         aWgrHP8TlrmBevGOgibBIxa06vVq/vO4ZiYeeFD84YDalYE4pI4nK70S+kJdMtiOlBLu
         N9gXUB7hdsDqla8kv7aK4jgEckdLAbTDqg5EpYc+MUNodVQFRw6nxTGav05ekpgcpRNv
         REYg==
X-Forwarded-Encrypted: i=1; AJvYcCVqm51rWHCFqh3wrUwvTv+WIx63aHA02tE7vh7p2720TwOv007aux0hNcywfedBsBUj6mMuoVHiGahs633mjHLkAobi+daHcbQskqitjzS5
X-Gm-Message-State: AOJu0YxaVdq3rBGQaRyav+rbJe/w6lQx5qCwcgZXUT3+lyd+F595Jeh1
	zQZrh5XDWnVEGqJy+YdZ0CAFNEM6lBKqcmCjjSUfJeWVRFipTsQjq02XThPaPiQ=
X-Google-Smtp-Source: AGHT+IG5DqlLx8NTysbMcAAAWpmS9Y/M+/O3VOaalg3C6t3qWEtTgj5ZYUhxExUDRf25mfY9vLjwgw==
X-Received: by 2002:a05:6602:3305:b0:7f3:a20e:c38f with SMTP id ca18e2360f4ac-7f3a20eca45mr1270775739f.0.1719441570169;
        Wed, 26 Jun 2024 15:39:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb664c02bfsm23422173.79.2024.06.26.15.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 15:39:29 -0700 (PDT)
Message-ID: <c6e845c0-e6ea-4849-bb0c-50024383431f@linuxfoundation.org>
Date: Wed, 26 Jun 2024 16:39:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: acct: Add selftest for the acct() syscall
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240622-kselftest-acct-syscall-v1-1-d270b5be8d37@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240622-kselftest-acct-syscall-v1-1-d270b5be8d37@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/24 11:24, Abdulrasaq Lawani wrote:
> Noticed that there was no selftest for the acct() syscall
> which enables the kernel to record terminated processes
> into a specified file.
> 
> This patch provides a test for the acct() syscall.

Describe the functionality being tested. Add testcases to
test error conditions.
The code doesn't meet coding guidelines for C and also kernel.

Please check other kernel source files and coding standards document.

Use ksft_* function for reporting results. Refer to an existing test
on how to.

> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---
>   tools/testing/selftests/Makefile            |  1 +
>   tools/testing/selftests/acct/.gitignore     |  2 +
>   tools/testing/selftests/acct/Makefile       |  4 ++
>   tools/testing/selftests/acct/acct_syscall.c | 60 +++++++++++++++++++++++++++++
>   4 files changed, 67 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 9039f3709aff..45a58ef5ad92 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +TARGETS += acct
>   TARGETS += alsa
>   TARGETS += amd-pstate
>   TARGETS += arm64
> diff --git a/tools/testing/selftests/acct/.gitignore b/tools/testing/selftests/acct/.gitignore
> new file mode 100644
> index 000000000000..8ab358d81bd2
> --- /dev/null
> +++ b/tools/testing/selftests/acct/.gitignore
> @@ -0,0 +1,2 @@
> +acct_syscall
> +config
> \ No newline at end of file
> diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
> new file mode 100644
> index 000000000000..ff3e238c5634
> --- /dev/null
> +++ b/tools/testing/selftests/acct/Makefile
> @@ -0,0 +1,4 @@
> +TEST_GEN_PROGS := acct_syscall
> +CFLAGS += -Wall
> +
> +include ../lib.mk
> \ No newline at end of file
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> new file mode 100644
> index 000000000000..457b83937cac
> --- /dev/null
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// kselftest for acct() syscall
> +
> +// This tests the acct() syscall, which logs closed processes
> +// until deactivated or when criteria in /proc/sys/kernel/acct is met
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/wait.h>
> +
> +int main(void)
> +{
> +// Create file to log closed processes

Missing tabs for the body of the function.

> +char filename[] = "process_log";
> +FILE *fp;
> +fp = fopen(filename, "w");
> +
> +int i = acct(filename);
> +
> +if (i) {
> +    printf("Test Result: %s\n", strerror(errno));
> +    remove(filename);
> +    fclose(fp);
> +    return 1;
> +}

> +
> +    // Create child process and wait to close
> +pid_t child_pid;
> +
> +child_pid = fork();
> +
> +if (child_pid < 0) {
> +    printf("Process failed\n");
> +    return 1;
> +} else if (child_pid == 0) {
> +    printf("Child process successfully created!\n");
> +} else {
> +    wait(NULL);
> +    fseek(fp, 0L, SEEK_END);
> +    int sz = ftell(fp);
> +    printf("Parent process successfully created!\n");
> +
> +    i = acct(NULL);
> +
> +    if (sz <= 0) {
> +        printf("Child process not logged");
> +        return 1;
> +    }
> +
> +    printf("Test Result: Successfully logged closed process.\n");
> +    remove(filename);
> +    fclose(fp);
> +    return 0;
> +}
> +
> +return 1;
> +}
> thanks,
-- Shuah

