Return-Path: <linux-kselftest+bounces-19477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B29993DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 22:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEFA1F2363B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F21E04B5;
	Thu, 10 Oct 2024 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A2II72d+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A61991D4
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593109; cv=none; b=Pre9zYV98SUnzcBiu8vJ+8dBjJky56CWwO9M8aPwrEAcUdZZ//gVMMVGcy91YPoIvHgOxU5o+XVWFti9RxdVWFdjdHDmCNU6NNIy4tovFrqcdZCOpcpTNl5IEVGKS91RYsQde96AmZ+f5W2AVIaHUvlnRnYJddrBxAJncrgdulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593109; c=relaxed/simple;
	bh=T0I5UjmJOQJJIbk9m/25YnvlDbc6zeA2yj0DV3LU7uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPKnk9Uy1Nu8sEHXZq9tGpgS/lbOj8V+3zq3/3o14pq4eX4WahdGTn5qxcclf42YZtoKLgG1kN2urdLeC22WAy07UiB2q/HLRqTsq1YMVxOISO0aegzJ9mmnF3CaBoeoZtPsm+hJUPwl/5VFq1N3d5gRICbIm043m2BRwaMp4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A2II72d+; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-835426c0fefso43404039f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728593106; x=1729197906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAZSSuU4AY4LM/i+AUIV9y5uNgoAfd3WYw6jsPJQ6yk=;
        b=A2II72d+NYrWHtVbMDzmu0hjW72sbQ7SP8Kq/k7oJ5xcHoTKHh3MDcELTZUHkFkP9p
         tpnn569dZS5cmC0DlYjsI7cZ2qCBQmmQTDqhEguMQ/Rp9kL4bHbIoME1rZIGr/K8mwtJ
         gj0ZuqBFrtKAzI5ZLASeVSHPHDjyztY3FRT1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728593106; x=1729197906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAZSSuU4AY4LM/i+AUIV9y5uNgoAfd3WYw6jsPJQ6yk=;
        b=kFvIF+wVHD0CMh1Ff/hwvDy8m6avUcffRnH/p2E/BCwse3zh8kMMwvF1alc+c9doyB
         ABN4VhJy9Mr7j01i2PWVAKonw5uhsYN0A662i1wp8eemPRj94PcyGovzhF1CCRzWm34X
         6EJ6WqKlU6UZwYrX1zJmQASi3WmSDDRh1gjMk8SyXXoAzTNLVw024fB/EugNyj+O0z4c
         fekUYKMqjz7Vcr/Wud4wsyE7/dln3XKPvYsJvclAub920HPowM2iDUINkkkbyJNdlaqK
         wUb7j8zu9l0oeGapKuECF/D8A9MFS/gQ/PSbNMUtIvPr3diK3oLB1c6iauxgcJzyu3x7
         u6ng==
X-Forwarded-Encrypted: i=1; AJvYcCWbNVE7bl/ImvLG4PsVg5xuUQw8WNQhbP6CNsnkamSkW4qq2cHaizwZT/bwkRo7+EcDZ2iz4+zx0dfDYxP9qWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaQPVwC2EP8KTNsGDtrPqSic1fuQTtbeSqZQQ6FISdVvvtUe9
	NxkfRzKI1ABGtgJ4JH+GLBWI27hGeRbgzVgxCwsDrfXwBBJbm71QFnumuYuS55k=
X-Google-Smtp-Source: AGHT+IGcN/GmadmtTwocCSsKB9AGUqIjUMcPAuMJbJzoDZpQA9VhOP5iHDhIUzJA74ZaNYE+gchffw==
X-Received: by 2002:a05:6602:620a:b0:82c:f7b1:a9fb with SMTP id ca18e2360f4ac-83782bf3c81mr27750939f.5.1728593106223;
        Thu, 10 Oct 2024 13:45:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada84203sm379377173.120.2024.10.10.13.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 13:45:05 -0700 (PDT)
Message-ID: <a34eb4f6-4d8b-421e-a441-18887e2eddfd@linuxfoundation.org>
Date: Thu, 10 Oct 2024 14:45:05 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241004145618.18436d7e@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241004145618.18436d7e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 12:56, Steven Rostedt wrote:
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
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20240821150903.05c6cf96@gandalf.local.home
> 
> - Added comment to why we are doing a sleep 1
> 
> - Now that the fix is in mainline, we can add this to the selftests
> 
>   .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> new file mode 100644
> index 000000000000..1580e4ef9739
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - function profiler with function graph tracing
> +# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
> +
> +# The function graph tracer can now be run along side of the function
> +# profiler. But there was a bug that caused the combination of the two
> +# to crash. It also required the function graph tracer to be started
> +# first.
> +#
> +# This test triggers that bug
> +#
> +# We need function_graph and profiling to to run this test

"to to" -< "to"

I noticed this during my commit checks. Please fix and send v3.

> +
> +fail() { # mesg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo "Enabling function graph tracer:"
> +echo function_graph > current_tracer
> +echo "enable profiler"
> +
> +# Older kernels do not allow function_profile to be enabled with
> +# function graph tracer. If the below fails, mark it as unsupported
> +echo 1 > function_profile_enabled || exit_unsupported
> +
> +# Let it run for a bit to make sure nothing explodes
> +sleep 1
> +
> +exit 0


