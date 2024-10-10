Return-Path: <linux-kselftest+bounces-19463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE95998E05
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 19:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7337DB27B7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694CD198A24;
	Thu, 10 Oct 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DiY/AwjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463219AA68
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579887; cv=none; b=C9d1d5LyuFOKKGhCklGNQEfMMXVt4BDb0YSqaep+ZAv47D5FfKpxgbKbpsYR4N0iwcPPQP4tgAfPkxXzeKLqv/gCRVEqnuwSsbyw6wveeptbJTQYSRPE3ztwGbiI2Sk3t/4rqh+qmGEdLGqRn8cfe/CBYLn7bYLRQJSWRIVjGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579887; c=relaxed/simple;
	bh=i5dx0UhQ/tTF7VQwfxB7kDXoCRCqQDi/mml7CFO95Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQ4hN/osnmrESEl0P2AX2lGtT4Oaa3tL8OgBl2BP4GbAAUCtuKumTK1Xj9WOWHRSUFRJ6K5kKhH8UPNPRnzWgYMRJKIJg3BUa42JXVbON2+rr+1N/GE0vJ4CfY0yp3/whnVgrAiv9xlxze9pz6JAJCa6Bxo0NM2z9Ea2JmokfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DiY/AwjH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso6316145ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728579885; x=1729184685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUDkh/kjwV3Ai2AwiP8Kl7C0pSMOQvoqahsvYlIjyPA=;
        b=DiY/AwjH3vRMI8RIly/8DBpdIklJc4macdRuaz7zn4YVoIczvq2qSJ2bZHOinEBign
         dQD5AUcR9pOO7FMPC7vnLuPVvn0Px1iZBhrTp3Gtl/koseS7A79zSGy+l/lL/3xkK2yO
         XCuRSHMmBBjlLU/bGNozV19ei8CJoBTvwoQ+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728579885; x=1729184685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUDkh/kjwV3Ai2AwiP8Kl7C0pSMOQvoqahsvYlIjyPA=;
        b=KWs70vu3sB9RjUg9+rKTofVfXwrVJTJk4GfOGsj0ngubXgKDLIomRqpDz4CrFTYBa3
         Z6AGE5wdVEs8HcQzhdF1/Urbvrh9gopdiR7BZY/g6QBYl1tpTr7JbbUrZFe5EmHrVGkt
         lv2g4/vSuFny13JyerSRCjIIOlvKs7O0RXNsWkUhal4x/wg6uGFQF5RQbVMZiRVxL90z
         97W1gtFRCYcoTpzxUCKy+WfGOlqfElN4pEpEJFxkOGmuH+tC9SrKMdXhKd1aOSueSOUI
         uVZxpAF9KZNNTqxu1EhwAL0xw70Ggd5KAPlLtYHtXITxtH/WMsoDtYg9tzbzQfcEY5h2
         8ksA==
X-Forwarded-Encrypted: i=1; AJvYcCUAETrOPr2TMPwdcQLHYZE3l9ZuvT9F9UCgeQWvy5A3YnWf3hNtUGSjVfEB7TBdxIDTeOEnw9yDu2e1MDNsWWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yWMTQAybsFH5nZ0QRYkH/bcBobg6DDSPWpbeIwMi/pfRhUYd
	mwcm7F1mGFHeVOi30TqAqWmlc8YlEJt54s+Mzs0EcWnLHGpvIXRiIF8IoRccPqk=
X-Google-Smtp-Source: AGHT+IEmIOQmx+WWs5L52kh0YJyVZPtoP5znB1H5OJDnusEZHA3cnEBsF6SLubdvdK9UJeIt/LZ+bQ==
X-Received: by 2002:a05:6e02:178d:b0:3a3:9337:4ce2 with SMTP id e9e14a558f8ab-3a397cda124mr63977615ab.2.1728579884706;
        Thu, 10 Oct 2024 10:04:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada84990sm311977173.113.2024.10.10.10.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 10:04:44 -0700 (PDT)
Message-ID: <63a7811c-c2cb-472f-bfa1-3b45bc65da10@linuxfoundation.org>
Date: Thu, 10 Oct 2024 11:04:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241004145618.18436d7e@gandalf.local.home>
 <20241008093314.8b263b6bd2e23c6a8345b65f@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008093314.8b263b6bd2e23c6a8345b65f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 18:33, Masami Hiramatsu (Google) wrote:
> On Fri, 4 Oct 2024 14:56:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> Masami reported a bug when running function graph tracing then the
>> function profiler. The following commands would cause a kernel crash:
>>
>>    # cd /sys/kernel/tracing/
>>    # echo function_graph > current_tracer
>>    # echo 1 > function_profile_enabled
>>
>> In that order. Create a test to test this two to make sure this does not
>> come back as a regression.
>>
>> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!
> 
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Steve, Would you like me take this one through my tree?

thanks,
-- Shuah


