Return-Path: <linux-kselftest+bounces-15043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6639D94C593
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 22:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CC5281327
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D33215687C;
	Thu,  8 Aug 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SzF8wMFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231615534E
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Aug 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148416; cv=none; b=O0+Tim6I/OuKQ/dOPUmT9yO4Q07AAiaWTbAV+VMvh+Y45mr58JSr5FHwstrRQj3t7CwstILs5flwXDJ5UjsII1jREoQe+cUe7VEzMwKDSOuVNX5bYQ/BcONuTalwiz45+aWoXnIhqtuMHJfsvRXIRKQLHlBLDsub9xybomrL9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148416; c=relaxed/simple;
	bh=gHdxTsBtC1FIJogjoVgR3K+UeVWvV8guUElH9Mm/MW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF79fozCkMJ+zITRPAZiFCfugVhQ68M8XeOMmPQswvig6NDKSp/oleRkO/GzOjvBauAtjyBJ3SAjhzGpIoY1gS1lcyw7FDFh9oWXkdtqwTiRMdYzXpzeuVIb3TfWsO64+RKcExeqS9yx6mnUxXpwXqVcFRpVCkP1UqhtjHhobXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SzF8wMFQ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39b3c36d429so776115ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2024 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723148413; x=1723753213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uodkGzl7xHW+w1GEEv07TFHRhIpJPmXbKVPEvtQ8oGg=;
        b=SzF8wMFQ5x5a/ygUBZWwhwKoLXC4b/YGunQbxr/Uljsqyw5DyA/m8Yf7Un1BU6iDgu
         ++/gW7YCIAsw4wfpLIUZc+qeLYqfG2YSWRgQ8Y/0VSOdGFOKbSdV4WytnW3OxBRn+UVb
         mgaV1duLlpb3WG2rXqMOMce9VGyNWtp/ZPJYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148413; x=1723753213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uodkGzl7xHW+w1GEEv07TFHRhIpJPmXbKVPEvtQ8oGg=;
        b=wIW5GqhQphraXMv1TADssyyk+7Ptqrt6jx41QiAqNVoGFCTTy019QN9TJA3IGc1C2b
         zQNcGGdBwTCxJFcXyvcTBLiJn4B4DDdUwQjpsDJQL6fcAjyFpYPFMnbUngH0yVYtIKyG
         zGNexMq750xKMOj1F6dY6zpxq31U0zamMlOYwWzM7UUOpZCeHZyyFYaOjM1w9FgaMif2
         Zl0oAwD9l7936+bNRp0roRg+BikbHXZw9haS9+g2bLH0NInueFIFhhgpTcFLZuCR0MFS
         zW9kwdKgLnCUxF4QrGAW2mIbRjvguJpe4jUIvCkmSiBAZuImhUmm8VEqkO9cpCobNDQT
         FJdw==
X-Forwarded-Encrypted: i=1; AJvYcCV8IG3dpjvyCoF94jWawyAEWPTBWsxh/tzE5ZB9OY0edmWk4Yt89Ps8XFCpwELKIME2/1WUau90+E89xQBokIir4bHWQev1rZXNaWyEf7Hx
X-Gm-Message-State: AOJu0Yy4cq34aH/sNVEQGG/wlARmulcB/8YeTr2zLUdRN9WXGgSseTvS
	+GGawGuIPw7xQIVfGDKWL1GNpcB3YJhnohypsrF7fWsz519aPTABe/ewMAPFr40=
X-Google-Smtp-Source: AGHT+IGeZKWpSvKjenukKSxuGMC3BC23H76EZqgIHLKrtcd11bSET6k/4D2jaLgGi/w8x0PBwnl8uw==
X-Received: by 2002:a05:6e02:1ca4:b0:39a:eba6:69f8 with SMTP id e9e14a558f8ab-39b5ed2e20dmr22609595ab.3.1723148413344;
        Thu, 08 Aug 2024 13:20:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca69620c69sm120466173.145.2024.08.08.13.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 13:20:12 -0700 (PDT)
Message-ID: <3a10db7a-d276-42ce-b050-8867aa3dc69c@linuxfoundation.org>
Date: Thu, 8 Aug 2024 14:20:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq/Makefile: fix relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Artem Savkov <asavkov@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240808151335.GA5495@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240808151335.GA5495@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 09:13, Eugene Syromiatnikov wrote:
> The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> relative to current working directory and not the executable directory,
> which will lead in incorrect resolution when the test executables are run
> from elsewhere.  Changing it to $ORIGIN makes it resolve relative
> to the directory in which the executables reside, which is supposedly
> the desired behaviour.
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
>   tools/testing/selftests/rseq/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 5a3432fceb58..27544a67d6f0 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -6,7 +6,7 @@ endif
>   
>   top_srcdir = ../../../..
>   
> -CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
> +CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=\$$ORIGIN/ \
>   	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
>   LDLIBS += -lpthread -ldl
>   

Wouldn't make sense to fix fix this in selftests main Makefile
instead of changing the all the test makefiles

Same comment on all other files. It would be easier to send
these as series - please mentioned the tests run as well
after this change.

thanks,
-- Shuah


