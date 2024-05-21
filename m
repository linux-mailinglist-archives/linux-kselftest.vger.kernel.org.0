Return-Path: <linux-kselftest+bounces-10478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A48CB102
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696D41C2148D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE874143C5B;
	Tue, 21 May 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYaiRjdA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D128143890
	for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304208; cv=none; b=D3ISh8TMaoLXpdZexgW3orBLWXDquAR2itN/6pH2r8+JqspzaZTHm0pKnMlr6v9eOrDk+aRrBx5lcC4cmGCuL7OAp/70Uw/ZE8W7PG2mrIXypmMu+vAR8y9IcKZNjbIleyr6eyGcIeWWHxsNK/6VOyKFRGig/Nz7Uig5xFZPpo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304208; c=relaxed/simple;
	bh=/5a3h4M20FUoYZhlXVbMuNxjpi38FtVo4tnwNlycoEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg4VBbsoolPdT9ttMwyYEWJJaTHiFONLD4FJdnUpxHz6jsfIZ7At+Ob+H9Rhv+MCQyq56af32uII9JGZgWItRABsSPIQMDks5AB4YZaonB+7k9QXvZ7oilWZFz9VyRKx+hJkIyuiQM8g0uM+WAr2uxnsakqc60sZpysGPngXcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYaiRjdA; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36c8267792aso1457095ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716304206; x=1716909006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZPbXhzIjF9CTIYlsze2Xc3NxTWVq0EkO8P78eNK6Zw=;
        b=SYaiRjdAwVfXv+VGpEa/G6bRcjZkcTFFpUKGcKeW+aO1l52sv5wN+ouxjmEEbAn8ik
         9pIIC0dEKf8OuNH3JoMp+wX/QqExrRRnC7pkzFQjQbsSeKVqNE/ZXXlrwON7M2MIXobu
         bRbLSMOkLlKRjzSkCSyPhHIzbHDazY+3AN1gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716304206; x=1716909006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZPbXhzIjF9CTIYlsze2Xc3NxTWVq0EkO8P78eNK6Zw=;
        b=MyS4RF7GXoyf3ntsbz6AoMo7foz7MS7bCSzt9+A32ImYBrMrucDi4Kz+XoP9BmkPCi
         LI4jBi3sIeJLLD42gNCFr4ZOIHD82tJKa0XZeg4qIozdB8xeABWe/XvF35aRsoyV2nln
         1GNHuE0RelcurFDg6jcQeZnemdV1pwWyQeWwp3wmNmZdbqtQr/MpO3JGZOUFzcyDORKc
         KaAqlawKdq9Gra4Oe2kEowp7yjDmhBaWFinKawUCasIjeIC4wEvDy2Cb/LWY5jjigvyS
         bLH/OL05jDPR8BS+gLgrc+Wc4wZDzaDyg6qrMLAg2RFD2PsoKbXtRBOLnV5pdtEZKA8+
         TOXw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6u6gzcrV8WK//ZkDmfsNXpafttf8frJhia0C+LNK7dzi8qM1bWwA+GneQY1rGwKyvf209+fcuji4TxWMwOFC5MXFN0gt8tjGMXQFV+34
X-Gm-Message-State: AOJu0Ywhpth0318Xou5FnQQmHZm+41XmpSXfwJBSIH9rnmP4JzIszL5G
	a2PHaQpnW4VcS/e6gJsJvcASGalEWA8SkbBZv/Swv1YcWM/aqpyQ4ZhB0oq3wbfjnDJmyriPDNf
	/u6s=
X-Google-Smtp-Source: AGHT+IESEt4nFF0aT8EhBUwdWsXz0bCKQ0ruhojcanJcimk1/Ix+PO0KtmO3gxLFKazgT5fxv/vXPQ==
X-Received: by 2002:a6b:d203:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e1b5022577mr3286292639f.0.1716304205729;
        Tue, 21 May 2024 08:10:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-48937141644sm7017385173.69.2024.05.21.08.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:10:05 -0700 (PDT)
Message-ID: <2d65388d-753f-423d-9682-60b00fb66879@linuxfoundation.org>
Date: Tue, 21 May 2024 09:10:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/selftests: Fix kprobe event name test for .isra.
 functions
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <shuahkhan@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240520205737.5085e53a@gandalf.local.home>
 <20240521104919.c8fd7a91b4a9c0435d17017b@kernel.org>
 <20240520215148.287e417f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240520215148.287e417f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 19:51, Steven Rostedt wrote:
> On Tue, 21 May 2024 10:49:19 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>>> It is listed twice. This causes the attached kprobe to it to fail which in
>>> turn fails the test. Instead of just picking the function function that is
>>> found in available_filter_functions, pick the first one that is listed
>>> only once in available_filter_functions.
>>>    
>>
>> Looks good to me.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 
> Thanks Masami,
> 
> Shuah, can you take this through your tree?

Yes. I will take this though mine.

thanks,
-- Shuah


