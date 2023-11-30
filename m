Return-Path: <linux-kselftest+bounces-906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E07FFC6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9CB281AC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3057253E3E;
	Thu, 30 Nov 2023 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RiYYfKHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDCE1703
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 12:25:39 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35c9cba4fa6so266045ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 12:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701375938; x=1701980738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJRwlgJXY8zfS6Dn3Qyvps6vNutTsbWo0ctzy0xsDTE=;
        b=RiYYfKHsRtWy65F7tPQdF1zFA3tglx05sTafIx0J5SsOn7lB4uR1ysV9LfDIz/AHAx
         Jib6zMm4JWYwJvFOud9V85hNE0So7EoIBpU8eCq9KelK2qyjxalLrJoMaUCcuD1NT5jS
         pYVdpz0gDXBhKyHd2rP5b3m729w5yNXUupBXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375938; x=1701980738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJRwlgJXY8zfS6Dn3Qyvps6vNutTsbWo0ctzy0xsDTE=;
        b=cHCBuJ1uw8Yg0RDlvyyvSk9epaXz+JukQqIGUXrGrmD3w2iUWLEDuMSP9VCK4aaghW
         OlOFMmWoTaQOOLsoJ3LTGKjpKNzfq+OB3cUrkTMsaIpUcrAcD5oGY3nN0YRGCAk7RpYj
         4PyltYUlq7dw73r1gNVaFtp9f3RVcaMxm0DrIfeWadMVMUiJjaCV+vMU6HDy5pMCGNZn
         /iJnH8CQYpArbqO/6576myxMU80FLFNASgGh40fGYIgIy2kApcRYWhZCTq27WrVgS1hO
         QMzmHYitmItFqradiirRw6HKdEnC5//yJnV7Tx6sSDVufJYQVlKpQZHBQxh5UWe/F2o5
         jOSw==
X-Gm-Message-State: AOJu0YwEO2a4/V/6BBm8ApYpPHGhDQGeVDNHar8gOqHnOj0oe04rl9HX
	MiFVkTOvmJaoCo4yam4QZUKfuw==
X-Google-Smtp-Source: AGHT+IEGUJuAhqQgLn7oVdVGifPgt9lHfhIlE4GIM70wiojIb1pXjfhGAMJ+UM2YbwQBa8GA9orUtQ==
X-Received: by 2002:a6b:c403:0:b0:7b3:f2a2:45e with SMTP id y3-20020a6bc403000000b007b3f2a2045emr6228689ioa.2.1701375938620;
        Thu, 30 Nov 2023 12:25:38 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id gu4-20020a0566382e0400b00466c82bce72sm484293jab.56.2023.11.30.12.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 12:25:38 -0800 (PST)
Message-ID: <2845b899-efd8-49db-8ea6-18834e97071e@linuxfoundation.org>
Date: Thu, 30 Nov 2023 13:25:37 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:proc: Resolve 'Unused Result' Warning from
 proc-empty-vm.c
Content-Language: en-US
To: angquan yu <angquan21@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231129034556.5719-1-angquan21@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231129034556.5719-1-angquan21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/28/23 20:45, angquan yu wrote:
> From: angquan yu <angquan21@gmail.com>
> 
> In tools/testing/selftests/proc/proc-empty->because the return value
> of a write call was being ignored. This call was partof a conditional
> debugging block (if (0) { ... }), which meant it would neveractually
> execute.
> 
> This patch removes the unused debug write call. This cleanup resolves
> the compi>warning about ignoring the result of write declared with
> the warn_unused_resultattribute.
> 
> Removing this code also improves the clarity and maintainability of
> the function, as it eliminates a non-functional block of code.
> 
> This is original warning: proc-empty-vm.c: In function
> ‘test_proc_pid_statm’ :proc-empty-vm.c:385:17:
> warning: ignoring return value of ‘write’
> declared with>385 |                 write(1, buf, rv);|
> 
> Signed-off-by: angquan yu <angquan21@gmail.com>
> ---
>   tools/testing/selftests/proc/proc-empty-vm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
> index 5e7020630..d231e61e4 100644
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -383,8 +383,10 @@ static int test_proc_pid_statm(pid_t pid)
>   	assert(rv <= sizeof(buf));
>   	if (0) {
>   		ssize_t written = write(1, buf, rv);
> +
>   		if (written == -1) {
>   			perror("write failed to /proc/${pid}");
> +			return EXIT_FAILURE;
>   		}
>   	}
>   

Hmm. Is this patch based on Linux 6.7-rc3? The code doesn't
match?

thanks,
-- Shuah

