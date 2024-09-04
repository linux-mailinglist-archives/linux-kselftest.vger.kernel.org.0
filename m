Return-Path: <linux-kselftest+bounces-17178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1B96C950
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B031F287C5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE9155730;
	Wed,  4 Sep 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UmFLZqP4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126B14D457
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484194; cv=none; b=Qb/d9YjU2wwnt1ri+yW+7AvLxOKl4boAi63Ydx/5Wi8Nb3vDWKGHvltwbjhrgarw3ho/wjvTTviI6B2sDvhIPex+iOFlL55hbjRwoJbtJfWuJPjh+19gCGc1Xn2v5sdObYFefWMo52QdALJJNiulNWOpiDBWBSp3ZP0mG6/OYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484194; c=relaxed/simple;
	bh=th5iFwBAi8yOaXFpylDbD6g6XyDctJyukgrxCXOBuvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IldVYvfAb6rNcER7MUir/tt++HPVPf0EItR4dYW5O++Wn4Z4BLcLc15Xz0YOAURcjjlz6AVSky3tm2FK3ARfOo+oq6P8amh+g2M/wt2RZQUbSdOn72g1zF0TP6WnDPg5RjqBzfsNg+/whPvZGTCnlGHyHbRmOJ/WqlD91Ih3onA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UmFLZqP4; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82a151a65b8so277216839f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725484191; x=1726088991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/OAnRUIec0MB5MMtbqzH58oYlTd06EXN4oDoez5il8=;
        b=UmFLZqP47zG0MMay/+3BjM9alUNHPaW3Az0vcjV2v8rYhKHqhWv0msdtXEt6cTQNwY
         ZpKt9xXv6wZF3mkci4nqHRZvNkoOegFDrknN35NsbRr9C9pFfchV6S1ADslGCSWm9K5d
         C2OH7wtgNFqw6gtTjVxRpcEuODGzq5lf258jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484191; x=1726088991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/OAnRUIec0MB5MMtbqzH58oYlTd06EXN4oDoez5il8=;
        b=LHvWiM3kNPmce2CI7Pj20Um1RUH2CNYrbS9p1lWD6pya/r8vSnMIxKX0YuxeKF9pka
         0KNRVsVWeIHM6YQzdstvuIwi12FHqSiLWnqtgVsI+MBBhqAVvHTchv88O2WPmrctf5rr
         +0pa1h1kaLp3jpjfdvR+8nanVkrGZtWn0YXYx2z8/BNAzpNwnQvGVsBi3QkKXgWB/o3K
         TMboGRmUr/26XPd2PDprlFB4GU15iaANwdKzklVbdYuNMcp+0UwULEOZg2XjXEmJiEzR
         Ib67bpnS56f9Jn04oOjBTyjYBhfDR8xGmDIA9eAe5uOq9lQhG4ZtVMzEyz+KnRz4QgOA
         2O6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE8R7bM0/7iQ/pOB/i5yrzvbm8HCwZvM9gfq6K+IlkgK/qhYSmUWyKyCjY0V3j7AXgC682emUsOrcgDODWsO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe24x0MUJmji0sVvAl/DgaL7Pibhi3CV2R+HAwXzyh3a6OtiM3
	0mFYlQByjAtG6dN1Pl2vXYGMW3HNxdMwci2s8DfVbBleylkfBKhBgu18etSMJpw=
X-Google-Smtp-Source: AGHT+IEfDe4u4BqHTyGI1mF/XmQ29mH/QL31meG++atpanxeHeLUEhv5iB4KvLNk1QflEYwaT49BGQ==
X-Received: by 2002:a05:6602:3fc8:b0:82a:4033:1f64 with SMTP id ca18e2360f4ac-82a648a08a1mr852385939f.6.1725484190844;
        Wed, 04 Sep 2024 14:09:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ee86d1sm3281241173.169.2024.09.04.14.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:09:50 -0700 (PDT)
Message-ID: <4566ee54-63a1-4b9a-94ba-42625c0ed343@linuxfoundation.org>
Date: Wed, 4 Sep 2024 15:09:49 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix eventfs ownership testcase to find
 mount point
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <172546382097.224182.6471842111781551515.stgit@devnote2>
 <20240904122055.71c4f38c@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240904122055.71c4f38c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 10:20, Steven Rostedt wrote:
> On Thu,  5 Sep 2024 00:30:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Fix eventfs ownership testcase to find mount point if stat -c "%m" failed.
>> This can happen on the system based on busybox. In this case, this will
>> try to use the current working directory, which should be a tracefs top
>> directory (and eventfs is mounted as a part of tracefs.)
>> If it does not work, the test is skipped as UNRESOLVED because of
>> the environmental problem.
>>
>> Fixes: ee9793be08b1 ("tracing/selftests: Add ownership modification tests for eventfs")
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thank you. Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah

