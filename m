Return-Path: <linux-kselftest+bounces-19480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE7299945F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3A7283EDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD311E5015;
	Thu, 10 Oct 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3AkH2dR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C21E2830
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595463; cv=none; b=EpSRkDcszeUmpiEhpn1nGExYnvFCZ1+tjZH0XF90Lna0Sj30UY4a5fbVDxPGWhCDub/0YOpD1BEFic01KPf9TVuN1F/qLJv1litTAI5S07ytEjsCp0f/Boqn056F7ytIEsbzMd8oeBBejVGS0RjaWRNUo0z46I5gMIgyOy2ZD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595463; c=relaxed/simple;
	bh=IvXBq22p6qcwQpaq5eTge6FDXANkdgf7r8d8TkHkgHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkKg4GzuSLdsdFrKaouM1YEfchoJ7s9LJRSdZ55nnI31ZcD3HqOfE8CV01jl8tm3TmzImM7vqx80vj4yreiOIH4tZWa+SZPN/B6A4MlaBOBuVDmSyav/rC7f1arNMaPD1h1Tk67fdAfvxShvqrCoctGuE85o0ZdvduqYEdqFmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3AkH2dR; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-835496c8d6fso71629039f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728595459; x=1729200259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnFmO+JO0vAHh3WQGgxd4V2TgjaB2XL1XQA6JbK9oG4=;
        b=a3AkH2dRu5bBnfgc1V8oAhte1wIURt1DzWv5DLVaj0VHLi18xY1OAqOJFYVHTsFzp4
         RiCGH8ZmxHJMKslrf727pIFtVI6vGy5ziIoydridCa6qMvMLsjT6uodrHYCEa10hlZ9n
         8cx28NejJZDLqdU2StoKIjiUTDWvnELyenrPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595459; x=1729200259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnFmO+JO0vAHh3WQGgxd4V2TgjaB2XL1XQA6JbK9oG4=;
        b=jPvkpY0FxYb9wYTKJhlGMzSZQZdO2C71G/lvdTmpjZT3+bjKhVWXJ2w3ANf9Vw7jWk
         g/v03iry9YUj4+bNyPrZjkedYdgmVZkoU3gJxxRX87lj4/vFiwRnnbsd4VgTk0bIqTjE
         iWXZMiv6W00DLdM7i2DveTHVmzJ+b+VLiVy4uYM6njxoTCJpDxKxcb6EkdH7YE9vnokX
         HWP9u/xawqmrWpyRAlrz3PkJmDqHilQxYDtMeHg+gvX0h/WJUXFg0TMZpRkcJAhUYWG5
         yl9j37+Kf4YBjl+g9MuBhGTJuoSSpJmCtDmVVmLaGwSrov7JLu6nr3H3UTbZbR3AbyHi
         xpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2DLTvAIVcVXav3yEnbDObyGaMgBACKa4Nq22COcifztXx2xLOMytvMUUhiKZlGKw4VXDwOjJeKrRET2PX5Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFdDMkEv5yGcveJjpuQp03pL8AF8YVTDnNJQtzdHmsm451fsA
	PGqyCApAYuqr3NkbFc2SVnrjVNk6j85pOk/GUYiFLIP58tvsJQ5gxWxeStFXVWs=
X-Google-Smtp-Source: AGHT+IGd8YjULQ5BgNmgPudrci6pRddPv1aAy6Zho1lX9ktZjptVS9rb0mbIN/F9nZopayfpk8di4Q==
X-Received: by 2002:a92:ca4c:0:b0:3a2:aed1:1285 with SMTP id e9e14a558f8ab-3a3b5c7bd20mr4241855ab.0.1728595459638;
        Thu, 10 Oct 2024 14:24:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaa8cb2sm387245173.123.2024.10.10.14.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 14:24:19 -0700 (PDT)
Message-ID: <0ba33212-d38d-42f1-9864-010e1802a7ac@linuxfoundation.org>
Date: Thu, 10 Oct 2024 15:24:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010165235.35122877@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010165235.35122877@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 14:52, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Masami reported a bug when running function graph tracing then the
> function profiler. The following commands would cause a kernel crash:
> 
>    # cd /sys/kernel/tracing/
>    # echo function_graph > current_tracer
>    # echo 1 > function_profile_enabled
> 
> In that order. Create a test to test this two to make sure this does not
> come back as a regression.
> 
> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v2: https://lore.kernel.org/20241004145618.18436d7e@gandalf.local.home
> 
> - Fixed grammar of comment
> 

Thank you. Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah


