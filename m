Return-Path: <linux-kselftest+bounces-14594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5FF943965
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 01:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3D1281D40
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDF516D9C8;
	Wed, 31 Jul 2024 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FkWUbCyE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38316C695
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468587; cv=none; b=LZeXekqD4JzJDRSC2eehuBeHoBsaB+g+AKCG0b0+CkaFIykBkQt/3u/hTWILaCaTTRdzZ17M715wZ/bG8pr3q+sv1gcxSLBfvW9RdG6JYe7Y8Gxcljcdy7efkXEBVQyrpi0NhtbqS+v2tkmT2q+Px+2GG2LXDRYyw9QLXfC09Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468587; c=relaxed/simple;
	bh=l5BnPQKOFbdnfAMJdxSyzHuRqpogqgbsYjC9G5+q8A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdPUP7VszIuB/WNWDEIGwY3Wo2nraKOxWD4qSCmVA/0U0DlObqgFmvQPj8CYOxpuD+6bzjYmYzZo2g6XrYd/b7YZCBSpKx+mYGL0ws400Icj6rjAzeiddKfm2yk/FYfpXztV9d70ah9B90jiVy/Vnmhe4kKRsktuOjySoafS/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FkWUbCyE; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f82478b70so34225539f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722468585; x=1723073385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n974tUIyAd2Darui3jtk4mJZZ+4cpbOJjC7okvYcXl4=;
        b=FkWUbCyEgE4ULxyI2/nRU+E9kITuDolmWgU7rVyBq0xONXBM68kJ3s1mr+iHDD87Ta
         mGwB8l6V8G7Io3AWDXhhKzpWGYOPstZrz3QJumSejsi6E8B1Y2L53cN6ob7UPnxeBPF/
         vXT1Tj93ZxkvA6tx4FYfQMWYMsjztLOyoXDzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722468585; x=1723073385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n974tUIyAd2Darui3jtk4mJZZ+4cpbOJjC7okvYcXl4=;
        b=FLYnjBpYAPwV4JakU2Evk/nK7UvVSk/Fxz8xm5NRT9OgmIzb11kWhyZEXifWOX/eEM
         ZkT/N19eWQn0cLgpP4ro0HnOptqRCZCOFrWHz3HLB7BP4/+ju1beJnoPyyUsL1vT2Wuz
         x0d2yYfYpxyDfxUwWrOagDjGRqrJCko9Qqmt7fkGkX2a/VZmXB9g2MAMHQN/B5TZq4E7
         t3VkUwhqT/3AvGMjcwXrb2VQzrpOoHO3Gtuy+XFItZAgogh90Cq88a0dJMPSbizf439/
         Zz2v4XtSOsXK3F4U28yCCfTfWkyBMYIv86kQtXuTyT3LUNC2/VmJw0UAA8nZGcFao2qf
         9Evw==
X-Forwarded-Encrypted: i=1; AJvYcCU8smDZbLkK/wNJ0uVw2Lobjr8dvosEKIpQGgTvrJQBpjmCRgbcasDltGvWQ9ZKt1hDpl1QprduWNlybs+yXw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzt7OsDTreNFP7yekWLe0vdC1h/7czcHB1gmaZ0JzjysI6Cai
	Z2TOB3AR9AtnxLbB5cREDY8b8YW3NrUpxsYlVV40ti5CKVjYI6wbBYoUkOLuntc=
X-Google-Smtp-Source: AGHT+IGyMBUoBR6gGWgryG+0ZZo4ELk+ae9+tBnJ4DYJEnheQDc66nJgcSPAxA2b7Xzg1WChW7Qcng==
X-Received: by 2002:a6b:610e:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81fcc2bcd6emr58424039f.2.1722468584539;
        Wed, 31 Jul 2024 16:29:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8b308e856sm834511173.84.2024.07.31.16.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:29:44 -0700 (PDT)
Message-ID: <c9dcf6e5-281e-405f-b592-7df2d1bd56bd@linuxfoundation.org>
Date: Wed, 31 Jul 2024 17:29:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftest: acct: Add selftest for the acct() syscall
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240723-kselftest-acct-syscall-v3-1-16f332498a9e@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240723-kselftest-acct-syscall-v3-1-16f332498a9e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 04:28, Abdulrasaq Lawani wrote:
> The acct() system call enables or disables process accounting.
> If accounting is turned on, records for each terminating process
> are appended to a specified filename as it terminates. An argument of NULL
> causes accounting to be turned off.
> 
> This patch will add a test for the acct() syscall.
> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---
> Changes in v3:
> - Add geteuid to check if test is ran as root.
> - Simplify error conditions for acct function.
> - Remove unecessary messages.
> - Add more informative messages.
> - Update commit message.
> - Add error test case for file creation failure.
> - Link to v2: https://lore.kernel.org/r/20240630-kselftest-acct-syscall-v2-1-b30bbe2a69cd@gmail.com
> 
> Changes in v2:
> Add testcases to test error conditions.
> Add kselftest function for reporting results.
> 
> - Link to v1: https://lore.kernel.org/r/20240622-kselftest-acct-syscall-v1-1-d270b5be8d37@gmail.com
> ---
>   tools/testing/selftests/Makefile            |  1 +
>   tools/testing/selftests/acct/.gitignore     |  3 ++
>   tools/testing/selftests/acct/Makefile       |  4 ++
>   tools/testing/selftests/acct/acct_syscall.c | 78 +++++++++++++++++++++++++++++
>   4 files changed, 86 insertions(+)
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
> index 000000000000..7e78aac19038
> --- /dev/null
> +++ b/tools/testing/selftests/acct/.gitignore
> @@ -0,0 +1,3 @@
> +acct_syscall
> +config
> +process_log
> \ No newline at end of file
> diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
> new file mode 100644
> index 000000000000..ff3e238c5634
> --- /dev/null
> +++ b/tools/testing/selftests/acct/Makefile
> @@ -0,0 +1,4 @@

Missing SPDX-License-Identifier: GPL-2.0

The rest looks good to me. Please send v4 adding the SPDX
to acct/Makefile

thanks,
-- Shuah

