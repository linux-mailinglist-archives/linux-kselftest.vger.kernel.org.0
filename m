Return-Path: <linux-kselftest+bounces-916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF77FFD9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 22:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D68B20B5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC465917E;
	Thu, 30 Nov 2023 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ojgf22BK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6E11B4
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 13:36:11 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b37a2e6314so17100839f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701380171; x=1701984971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fp9VwMviLQPX+3MgbIIB9b/GRHCxnV7F0fIl1aHZ/II=;
        b=Ojgf22BKf0uNQ8mI1jxosdZFX/3I3k8OAhrRpA61aZ9uxabFApYxdLm9MCbnx/neM5
         b9WW9+nmijBj+emHoaAmFxo2Ot+HjmtHIhlT18QLPzvqKJcCrfY7RrOzRPIzD2De9mLB
         gRNIGChrJ3Zn4Evvb9ao8bjfqPGYA3Ta0wRxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380171; x=1701984971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp9VwMviLQPX+3MgbIIB9b/GRHCxnV7F0fIl1aHZ/II=;
        b=gHmLDPncxJJIL826fbKR3BAy/LfycZi6Of9R2qv+APEowSGVvQbH0EXUUqlFtz8yLV
         n9GIVuyDVjsooHbbrENO1QhnELM1v6xJ+AtxRK6Qq2QneGnINimgQAbDhJqdy4blPudp
         Cx5UGvIagPRPRZTkUmetRDYQW9u9/rdbkQNPCnWzqLs1PgYVmJTU1ChL8XBG2hClTJEK
         haKwXhp+xi6Yd5KOv4FvfwNn6gUcf4ohWD0A4/bCn4TVf+RnlqoHW4MO5XMHoIIwGuce
         geORa0XwWKGiqGzu71sa0upRanymWN8V9ANbtg7HMi42J/lbNabRWxkpzedJkz9Kv5vl
         W+Hg==
X-Gm-Message-State: AOJu0YxqqxTUJG/pqvhhBt0xXG0MhlYkGO5Xv0PnXRzLMa3Xq9Whpp5G
	qqoiWBEEzo0HPv75jqpmSVHs4g==
X-Google-Smtp-Source: AGHT+IFAje2WETdYrzqFGUkr/49oxBQQwP5VhDCh8321mO5Pj1w3J8co5z+7nxeYC4a/pt7umT+5aA==
X-Received: by 2002:a05:6e02:1b05:b0:35d:f2b:4992 with SMTP id i5-20020a056e021b0500b0035d0f2b4992mr3016222ilv.0.1701380171001;
        Thu, 30 Nov 2023 13:36:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e020ec900b0035aeaed5112sm609123ilk.84.2023.11.30.13.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 13:36:10 -0800 (PST)
Message-ID: <89e0378d-f03d-42ef-9495-ada312dd5139@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:36:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:breakpoints: Fix Format String Warning in
 breakpoint_test
Content-Language: en-US
To: angquan yu <angquan21@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231129035726.6273-1-angquan21@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231129035726.6273-1-angquan21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/23 20:57, angquan yu wrote:
> From: angquan yu <angquan21@gmail.com>
> 
> This commit resolves a compiler warning regardingthe
> use of non-literal format strings in breakpoint_test.c.
> 
> The functions `ksft_test_result_pass` and `ksft_test_result_fail`
> were previously called with a variable `msg` directly, which could
> potentially lead to format string vulnerabilities.
> 
> Changes made:
> - Modified the calls to `ksft_test_result_pass` and `ksft_test_result_fail`
> by adding a "%s" format specifier. This explicitly declares `msg` as a
> string argument, adhering to safer coding practices and resolving
> the compiler warning.
> 
> This change does not affect the functional behavior of the code but ensures
> better code safety and compliance with recommended C programming standards.
> 
> The previous warning is "breakpoint_test.c:287:17:
> warning: format not a string literal and no format arguments
> [-Wformat-security]
>    287 |                 ksft_test_result_pass(msg);
>        |                 ^~~~~~~~~~~~~~~~~~~~~
> breakpoint_test.c:289:17: warning: format not a string literal
> and no format arguments [-Wformat-security]
>    289 |                 ksft_test_result_fail(msg);
>        |    "
> 
> Signed-off-by: angquan yu <angquan21@gmail.com>

Thank you foe the fix. Applied to linux-kselftest next Linux 6.8-rc1

thanks,
-- Shuah


