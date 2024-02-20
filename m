Return-Path: <linux-kselftest+bounces-5080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6962085CA23
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 22:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A75D1C22137
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49551152DF6;
	Tue, 20 Feb 2024 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JDaOXDIE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F3151CEE
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465354; cv=none; b=EIJgTTKew3PjB4GBaTZ7CxFK1ps2xp0RXGa874ssJBOIS3KhzdR2hGlB/2dsO1rdLym7TFgNLjFP3ucmkeiyGYhswZBg+e8QZdHql3yDeSmU09Qltuk5JvwWoWtEWphFaLvWQRtTlG9P7JXH/3w+YJK8Nxqmj3MChDgNMk7/ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465354; c=relaxed/simple;
	bh=mtupyzKIl5eBAyObXYu7ClNxTFVklxdyXiEEeWiAjZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GR0vmdRQucHW7WDFiH8wYiOpucPQeGIxzex9zdUqB9mYqbZ8hmL27d63Eb281me3PCBawl+ptopnqTopeEA571WVysqNQjLUZzzDxfmx/ispjhlNMbB1hYFZ71PB/6oTfhzgQf+BBm4cA9cHjQQulRPoa0w4vl1WpuUrsKvvCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JDaOXDIE; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso92475039f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708465352; x=1709070152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YmZq+TqFKLGPsrxtUBc2VJOHI+Gof9vUlvjw7Nb9oM=;
        b=JDaOXDIENlYfpBvMtDuSwXQi+fwhV/VwAo/Mhi8BwN8NgwMvybrZglIcSALwViTXzc
         uVKFsrwi9y9tNX+WqoBHn/RCPqPWNPkmKeaiMkQZQBM+7dCNEW6Uf73s1h6qRcHEd+D4
         jQKfDmPCngpN/SvDI/r2Y55DVR6ByDzmM+Jtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465352; x=1709070152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YmZq+TqFKLGPsrxtUBc2VJOHI+Gof9vUlvjw7Nb9oM=;
        b=Sl0bV/xl0qMz9tsBjp+Dma+p5fzjkXj8Bl4HGpmrt6WcB5cmvIF3bbEQN41J249dOv
         WFxDk1SOzUjxQUzUMsie7oRKJNMpxni5IOermMnLtx6UuU6BtkTaEzaTrssyorPW1ztl
         oqNlEqe1ImsTrFoVeskcaDXsx9y/ViNulFy1VKh3JWZAzZYIGXYr2GIq0x5VBJrZMnrs
         bKB0z0iukAwboJQrm00qIpdNUOC8GPwbvJLcicTigR2nf+nIKqpZDs6HlI4oC9fvVaXn
         pYg84DVAnUp4scppwYcHGRqr3Bt7qv28x4vRb7pE43OLQmhMrmCsdVOLCHs9IMUSpjMz
         gPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnNknD+BzsXZZTb2qyMyumnWCmZqDGYF3mOH5zeO2syMPzLZk1q7r3Xyi8ixFssv0679iQTTHf3yjbBJlP7e4+4KRu9w67mrEF4ggAA3Vv
X-Gm-Message-State: AOJu0Yw9JVElrXL3EUFkOYxg7l4WhXTIe0CF5sXEof3MjHtL4nq3zxnL
	YJHpODjFWIme5bZM0PcqQ4TDKbGDy5gGy6BHoZhHDwk6fEV72ff2r3jYuLXMJWU=
X-Google-Smtp-Source: AGHT+IGTdEv4tR+53aX1QG+WHVi5+VE2vQLF7l6s4x8x85tEGwuTMVQ1weUBlQPOS70VbsvR8ISSPg==
X-Received: by 2002:a5e:970a:0:b0:7c4:9ed9:8e7c with SMTP id w10-20020a5e970a000000b007c49ed98e7cmr12773521ioj.0.1708465351791;
        Tue, 20 Feb 2024 13:42:31 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k24-20020a023358000000b004743a0b8b8csm486095jak.153.2024.02.20.13.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:42:31 -0800 (PST)
Message-ID: <13d43811-8f3b-41ff-8e9a-2bd989bf4047@linuxfoundation.org>
Date: Tue, 20 Feb 2024 14:42:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ftrace: fix typo in test description
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ali Zahraee <ahzahraee@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240131133306.7723-1-ahzahraee@gmail.com>
 <20240201001308.c206e16376a173d4129ba8ab@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240201001308.c206e16376a173d4129ba8ab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 08:13, Masami Hiramatsu (Google) wrote:
> On Wed, 31 Jan 2024 14:33:06 +0100
> Ali Zahraee <ahzahraee@gmail.com> wrote:
> 
>> The typo in the description shows up in test logs and output.
>> This patch submission is part of my application to the Linux Foundation
>> mentorship program: Linux kernel Bug Fixing Spring Unpaid 2024.
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
>> Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
>> ---

Applied to linux-kselftest next for Linux 6.9-rc1

thanks,
-- Shuah


