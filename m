Return-Path: <linux-kselftest+bounces-37291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48BB049A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C04A6FD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9491279358;
	Mon, 14 Jul 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="do4JLjuw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B8727990C
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529192; cv=none; b=KElSoAHuh6p8veiiEOD/EUqsmTmWG0mthtIO55LmiOE7SF+wbED7JkJSY2yREuvREnJVvdnE312FLPHBSN5t5Ub/JQgGpKwzhbC8ujtiLKJvDUNv50C3O0jcoNSIs2ZlRT7jTEulb0qa6Vs/or2bEtiu8vylMHE3qZcaBTiv53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529192; c=relaxed/simple;
	bh=byOnCqYF64rOy8DAsTZ2BEvHNm98JjJN3Uhts9L1MJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRPmXhT4nN58bPemm4q8p/y/DduZxkGDXWh4mta9Yhaa+R5BGir9uAya0ZUYyWEr8+4li6nfT0ddSD7uXdCViVgHMqct+SSA3I7kdANOHnrMxQ8qzqbqUIXSw4+nmBUMzlsG2+2zBKEA4Y8Ndoq017IjfftgESaqYyElZLP4NZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=do4JLjuw; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df2e7cdc69so13426885ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752529189; x=1753133989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kC1l6xOWOZrwno4uERJ87nCgkRwlplFZ9aXWC5xa/bk=;
        b=do4JLjuwnLkOSyEhTnUxYlJKLNtNDwsCrCKRT3hj0Y8Iqzupey8HwnKsbLSZMxhTOK
         rz5rXk4MhL4uaxFcHVFnp0PszPWrqm2+MSlCLaReDpxtXULdW4DwnEOP/SoyKwwgeWKN
         qGe2VBX3bTkJxWkOE5p50A3gq4EbunXTfIhmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529189; x=1753133989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kC1l6xOWOZrwno4uERJ87nCgkRwlplFZ9aXWC5xa/bk=;
        b=wOqlyxURkAcS3KWzQi9YBBCUyvf7aNg7AgbzR44gGotl85Pyon59Q6P5HKOgRdeuti
         +I7D6izSaoQpNV9iiMoz74du0CcuFiEcGwuQLafgYmZWHbtCZ/6qQCtMAbu2xp8RCy2t
         +c/KyDa/LHcuJjgjeBpsim0GUj/YDj01Tn7vnelSgHVEH3naBeOlgzYd5qGsLg8UEExc
         Zee1urOIUieDbRfmNbbg51najTC45HOWX2JZzit8wZd6P1rRW5SrQ1NfmRtPr5hFIm3v
         gjGh1JMpv1De5np39/ybiHuzupqC5cmpSJzURK0IyQyQdtTWUSzSj6Zx7weRbTdGzDVN
         uvrg==
X-Gm-Message-State: AOJu0YyGCMgv6Dn0WEc/DHEdWGtYLvi2v3KlEmYO8ewPgMsUrecwwnsn
	0+ycduAlK7ItUjDoiPEYjdDK+NCxY46VgaRQvBfm2upu4QjFN7I2pMDNVOsNx+pB/5Q=
X-Gm-Gg: ASbGncta/omkTo++7QRde6s/qNUsmstjLFcVaILcYuOQncGUtJ16+N7ri38+xF//4Qu
	E1/WRrKGo+8FuTkeUHewIW1ZXVcfqDkT38sz/SNPlSl6NH1vU2VHrsWFjvlJzSBJW7/ZKyiE10r
	bAaOrCOH+V0c9mCZPCAJ5tdWL0vPvigD2Oot143XNu2jmm9NMpIdEIekWqMYqYIbdSt1bdb1uzX
	iJMQM0TVX7cF9Y16e8PkAOLLYsSkiKAFqy5gKPd85SkwdSntxPolCxU7pu5cjHKYM7AV+25ia1u
	4izMWA0gSlHZhSpvmCCD/1OoXlWeVnej/Xt4HEDZkaKO3HBQ7UjQ7NlUT48lt9Qkz/PGreRAq9M
	50mAtb8c3waLMFmPlPPBmYwH88LCQfJMBxg==
X-Google-Smtp-Source: AGHT+IH6jaGrJdphEBbSNQ6l2EUhHn4JfelFXsGzhMoppvy4TwsMDBZMZGzkc/4PyNyfNI81NioliQ==
X-Received: by 2002:a05:6e02:2166:b0:3de:12ba:7d6c with SMTP id e9e14a558f8ab-3e2532799e5mr178191295ab.8.1752529188577;
        Mon, 14 Jul 2025 14:39:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620ac53sm33540595ab.41.2025.07.14.14.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 14:39:48 -0700 (PDT)
Message-ID: <934dae5f-88af-41a3-9a0e-3aa5311b8f11@linuxfoundation.org>
Date: Mon, 14 Jul 2025 15:39:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: firmware: Add details in error logging
To: Harshal <embedkari167@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250714212650.17935-1-embedkari167@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250714212650.17935-1-embedkari167@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 15:26, Harshal wrote:
> Specify details in logs of failed cases

How about changing the above to:

Improve error messages adding details on failuires

> 
> Signed-off-by: Harshal <embedkari167@gmail.com>
> ---
> v2:
> - revert back to exit() instead of die() to avoid modifying system behaviour
> 
> v1: https://lore.kernel.org/all/c7c071ed-6a4e-4a9c-ba9d-c745fd42c22f@linuxfoundation.org/
>   tools/testing/selftests/firmware/fw_namespace.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
> index 04757dc7e546..5b0032498ede 100644
> --- a/tools/testing/selftests/firmware/fw_namespace.c
> +++ b/tools/testing/selftests/firmware/fw_namespace.c
> @@ -38,7 +38,7 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
>   
>   	fd = open(sys_path, O_WRONLY);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of sys_path failed: %s\n",

Why not just use sys_path as a input parameter to die()?

>   		    strerror(errno));
>   	if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
>   		exit(EXIT_FAILURE);
> @@ -52,10 +52,10 @@ static void setup_fw(const char *fw_path)
>   
>   	fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of firmware file failed: %s\n",

Why not just use fw_path as a input parameter to die()?

>   		    strerror(errno));
>   	if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
> -		die("write failed: %s\n",
> +		die("write to firmware file failed: %s\n",

Same here

>   		    strerror(errno));
>   	close(fd);
>   }
> @@ -66,7 +66,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>   
>   	if (block_fw_in_parent_ns)
>   		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> -			die("blocking firmware in parent ns failed\n");
> +			die("blocking firmware in parent namespace failed\n");
>   
>   	child = fork();
>   	if (child == -1) {
> @@ -99,11 +99,11 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>   			strerror(errno));
>   	}
>   	if (mount(NULL, "/", NULL, MS_SLAVE|MS_REC, NULL) == -1)
> -		die("remount root in child ns failed\n");
> +		die("remount root in child namespace failed\n");
>   
>   	if (!block_fw_in_parent_ns) {
>   		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> -			die("blocking firmware in child ns failed\n");
> +			die("blocking firmware in child namespace failed\n");
>   	} else
>   		umount("/lib/firmware");
>   
> @@ -129,8 +129,8 @@ int main(int argc, char **argv)
>   		die("error: failed to build full fw_path\n");
>   
>   	setup_fw(fw_path);
> -

Why did you remove this line?

>   	setvbuf(stdout, NULL, _IONBF, 0);
> +

Why is this line added

>   	/* Positive case: firmware in PID1 mount namespace */
>   	printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
>   	if (!test_fw_in_ns(fw_name, sys_path, false))

The rest looks good to me.

thanks,
-- Shuah

