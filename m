Return-Path: <linux-kselftest+bounces-15044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DAF94C594
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340DB28123D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA5158DB1;
	Thu,  8 Aug 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TxihxlB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B87156250
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Aug 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148418; cv=none; b=CEQ86T0VcrRCExTwEGO5CF36uMkZlIthzJmpS2zjsMiplk+hZcMY31TmDDaMev+35tu0hQL+CvZxZkYP8CScwjDubyeyzKP3HmgQrWre7MfUYJwLNQ9in5tMl/FTTvs27l/+WFizl9ZS3lGk0XoyMyyP/2pAxpZXHaBXCL3OGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148418; c=relaxed/simple;
	bh=YEe+bkGLX+HfQdKyFd4LwCdbYkyMOdOf27lhBP0tA+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EK9XEELnR7BdGF3vy2miTVXwJhyLDCj1E6hr3pVHsB+sZL3H1KqryGZWXkihqssMaKyEQipZRcVCN7ICcYmazH+anrCPEZFk8gVwHujR0gFXBrp3X8cUZVcV/rGC/0YYUKkV4kLpGr5N983yp/whxWLZEGT1uLQE+GaljovNu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TxihxlB4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3989f6acc90so650675ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2024 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723148416; x=1723753216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2jsmgHrGbMb3u45pfIyI8LsvcVZ97iNNWQ7Q8ut6d0=;
        b=TxihxlB4lPB1xcI+y5v8UA7U5zKaOyieQwtP2MkgGlQclImpnQ0CNP1gj+5i3ROY36
         mM0KIFntrCIYqpE9QdpN/BnhxkNI0G8xNLvn5WGssDC86SRBMtQkN2/jOtY0I2+ImOdb
         ksqWN/6tLs0E0FaKhFBU2kiD8vyZlcJ5DEBlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148416; x=1723753216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2jsmgHrGbMb3u45pfIyI8LsvcVZ97iNNWQ7Q8ut6d0=;
        b=ZTttppcT1ZNh9Ap1KgK+JH8DYXLVfZ4M4+oIzs58pf9NGEGYbd/W+c899b2W02sClw
         FGO5ix1SQNN1k5o9LYcOnLyVpaPU390kp7EX4ZuxGDrqGSNtwVDi88Ntze2QUzzm/r/L
         f5Mb8YjF3bqExJUlDKT+tWCQGPVGjGCiJGfGKEfNVjmRlhbtyKBocpFrArnGJiTaagH6
         drEQhJSmDLPTnNuK0HH6vqj/BEHFVeT966Wrc7FFcpHMt+P1Ge/VsmhMw0D6eg6i4Y9E
         oGT3EMmCeHpV/+nOZneoMy9sH24yveNmOdqycgiWxfp2KWz9jwfmPPz/+z/zUlcNpanf
         3a0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH4Ay3eN27OI3+H1ABJxu75tWZUIpT+f+D4eSgZ4mt9Api+ZB7mvCTs4T+YsckGzzXjFBvR19SRwN0tgGxnab7ZWXrMacE+dhtkY8WYez/
X-Gm-Message-State: AOJu0Yzv1IP6bjoBaaKJ7uz9+FAKempLChWUB8sZq3FTTgtxaujS68g4
	Mnco4bkEHsQw4UkcfCkRhUrApcg9KgVSpTyUKcb795Og4jxk3aFR//jv9QXxWnI=
X-Google-Smtp-Source: AGHT+IHhQH08kFhjcWCEF7YIjkSd6iFv0aSWgPW3aIY3OlTKnEegVaGTebZ9Iyo16sQqzN46BjZEtQ==
X-Received: by 2002:a05:6e02:1a07:b0:39a:ef62:4eb2 with SMTP id e9e14a558f8ab-39b5ed59648mr21755055ab.4.1723148415635;
        Thu, 08 Aug 2024 13:20:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca69620c69sm120466173.145.2024.08.08.13.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 13:20:15 -0700 (PDT)
Message-ID: <ed248abf-4f75-431b-b061-3eab7024e0f4@linuxfoundation.org>
Date: Thu, 8 Aug 2024 14:20:15 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/sched/Makefile: remove relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Artem Savkov <asavkov@redhat.com>, Chris Hyser <chris.hyser@oracle.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240808151621.GA10025@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240808151621.GA10025@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 09:16, Eugene Syromiatnikov wrote:
> The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> relative to current working directory and not the executable directory,
> which will lead in incorrect resolution when the test executables are run
> from elsewhere.  However, the sole sched test (cs_prctl_test)
> does not require any locally-built libraries to run, so the RPATH
> directive can be removed.
> 
> Discovered by the /usr/lib/rpm/check-rpaths script[1][2] that checks
> for insecure RPATH/RUNPATH[3], such as containing relative directories,
> during an attempt to package BPF selftests for later use in CI:
> 
>      ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]
> 
> [1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
> [2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
> [3] https://cwe.mitre.org/data/definitions/426.html
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/sched/Makefile | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
> index 099ee9213557..0e4581ded9d6 100644
> --- a/tools/testing/selftests/sched/Makefile
> +++ b/tools/testing/selftests/sched/Makefile
> @@ -4,8 +4,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>   CLANG_FLAGS += -no-integrated-as
>   endif
>   
> -CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
> -	  $(CLANG_FLAGS)
> +CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) $(CLANG_FLAGS)
>   LDLIBS += -lpthread
>   
>   TEST_GEN_FILES := cs_prctl_test

Wouldn't make sense to fix fix this in selftests main Makefile
instead of changing the all the test makefiles

Same comment on all other files. It would be easier to send
these as series - please mentioned the tests run as well
after this change.

thanks,
-- Shuah


