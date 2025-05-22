Return-Path: <linux-kselftest+bounces-33525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3409CAC168A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1D57A84D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7A26FA42;
	Thu, 22 May 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WggiKPvr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44B26FA6E
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952366; cv=none; b=p0EC6oiVUS6CJLidytOrutYkk3qGQNbfQfmZw52Z8ZTd2JhR27TLa/DJdooG4kuWnDGVa6XpI5LPFwAkxw/oU0spFsIR4MXBclg1yFExe5hklLjyV52yLGviHuxl3u0QcfDhF3G2IK/nBmfseZjVe+HWZuf9WBTKe+kR6ZjuP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952366; c=relaxed/simple;
	bh=7NRYbwbYrh3x1KViQ1U6RIE08C8vCKcJ8G+srM/U/p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrJLBvBm23Mpr2m6mGd4EdiAzYbIz7kGfEuMkonGHv9JsAQf48mUW/51oESqtnvcK3255ZBQ7d7QJC/Yfi2gbATkHYlmUZWlgJqLqcp9/dLom2957G38+vQGarG71ugafBZ5vowjOlI4PkIvfLCThgjTcvBsVyc71jyhDOzYA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WggiKPvr; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3da73998419so24484315ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747952364; x=1748557164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2BBhyB5BSe8xiN4xkcpWffnGhtL3C+c766u9Ynb8BA=;
        b=WggiKPvr0tej5qduo7EGEx5EiOEToql8Z6USOF4LOnTBht3mjVPm5TR0Ug6yYxV7zX
         e3FUYoOJ/LsuMKFBSAZGmJvaRtqjHmFFnGmZuJ9/Zq42X+7+vpQx2c6KTWWV63HfRBig
         4PPAU7rjPapl7H9Txq9hZ1B3PUW+at8GShKsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952364; x=1748557164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2BBhyB5BSe8xiN4xkcpWffnGhtL3C+c766u9Ynb8BA=;
        b=aLvshwVQvGFLUOt5ouHqyIA0kr8XnkzpWTKUZWKzRocW4P1Vn/0iGeqfg7BBJN+PtJ
         RGUeLNYKmaonQdizpkkMlLa/3YWEBnfCBT2vhHFrsNh44wKSc13sCsp+xvgXeG2+pq0T
         m19E91yLAf73cRcdoT2dkTEqe1Ts1zU59uhKuf3BcRbojpjBzFDoS3M/SM55P1aNZJ17
         nO5jeiEO8uVtO/OrCeu6TJeGphLdlcCuha/ut2aLeCYCkg2Qs3xPwHJ2dCqbK4yAlOeJ
         vgO55AdNJiB0mhevcgiY5XoGI8uZlctZxvrFBJGCoLdWsGJrFn+YI679D9cSR2/qLBV+
         x+bQ==
X-Gm-Message-State: AOJu0YyTLVkl6vR0OhK03aABKj8Rwj+ojIMQgyuQhRDd1WUbgchquYbE
	CrtztXNLm1FZSTgdI4a/0bJTTRGGwymD6xHTTgwdWvsfRqOfRaMLOtaHxYF/JaGbvy8=
X-Gm-Gg: ASbGncvGVt452QQwrEWvc0SkRMK/O1byDyqZfd6nLxi9mi+NPPF0IVaFh+C1DOSESJ5
	tAykCUgWyawQSHgRiR5iCRxjm0H9d1+fCXlrgDZvIngUcu33w3PIZJV75jnH2OaaHVJmx180FW5
	lR2TsuLLbLLVyg3AiZZRnIrRZ+2R0arJuSiRCclblMkICyd4ggLl0l45lRes0oX+VnE+paKqZsL
	oCz9HkeGdBjvWEI3gxwl5gsx3DF5LUvJSJOZyWZYxoJUvCysZlX/DUZqKysD0R45siuODf2pdnm
	jPIQxJw+ZvybwNgAN0uI/lmdvTnpdl4ggNMYqx9yP8s8L1G3Q/B//0O7Ja8mMLI7usQO69dv
X-Google-Smtp-Source: AGHT+IGIm2be03aa+hk73LqpnK7jFcUNiFbXggRZAdWiAlqqdT6OIX3F0RPmogpvOlodCQDE5M6LuQ==
X-Received: by 2002:a05:6e02:3709:b0:3dc:787f:2bb5 with SMTP id e9e14a558f8ab-3dc93407c47mr9424535ab.19.1747952363816;
        Thu, 22 May 2025 15:19:23 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a460sm3349280173.26.2025.05.22.15.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:19:23 -0700 (PDT)
Message-ID: <73a4b1c9-44b4-4f06-a766-ea7ed391c578@linuxfoundation.org>
Date: Thu, 22 May 2025 16:19:22 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: firmware: Add details in error logging
To: Harshal <embedkari167@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250516153955.111815-1-embedkari167@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250516153955.111815-1-embedkari167@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 09:39, Harshal wrote:
> Specify details in logs of failed cases
> 
> Use die() instead of exit() when write to
> sys_path fails

Please explain why this change is needed?

> 
> Signed-off-by: Harshal <embedkari167@gmail.com>
> ---
>   tools/testing/selftests/firmware/fw_namespace.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
> index 04757dc7e546..deff7f57b694 100644
> --- a/tools/testing/selftests/firmware/fw_namespace.c
> +++ b/tools/testing/selftests/firmware/fw_namespace.c
> @@ -38,10 +38,11 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
>   
>   	fd = open(sys_path, O_WRONLY);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of sys_path failed: %s\n",
>   		    strerror(errno));
>   	if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
> -		exit(EXIT_FAILURE);
> +		die("write to sys_path failed: %s\n",
> +		    strerror(errno));

Hmm. Wrapper scripts key off of the EXIT_FAILURE - how does
the output change with this change?

>   	close(fd);
>   }
>   
> @@ -52,10 +53,10 @@ static void setup_fw(const char *fw_path)
>   
>   	fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of firmware file failed: %s\n",
>   		    strerror(errno));
>   	if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
> -		die("write failed: %s\n",
> +		die("write to firmware file failed: %s\n",
>   		    strerror(errno));
>   	close(fd);
>   }
> @@ -66,7 +67,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>   
>   	if (block_fw_in_parent_ns)
>   		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> -			die("blocking firmware in parent ns failed\n");
> +			die("blocking firmware in parent namespace failed\n");
>   
>   	child = fork();
>   	if (child == -1) {
> @@ -99,11 +100,11 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
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
> @@ -129,8 +130,8 @@ int main(int argc, char **argv)
>   		die("error: failed to build full fw_path\n");
>   
>   	setup_fw(fw_path);
> -
>   	setvbuf(stdout, NULL, _IONBF, 0);
> +
>   	/* Positive case: firmware in PID1 mount namespace */
>   	printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
>   	if (!test_fw_in_ns(fw_name, sys_path, false))

The rest look fine.

thanks,
-- Shuah


