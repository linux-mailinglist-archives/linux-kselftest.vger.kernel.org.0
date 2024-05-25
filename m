Return-Path: <linux-kselftest+bounces-10687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F698CEDD9
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 06:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6351F21961
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 04:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346EB2566;
	Sat, 25 May 2024 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4oYl54JU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DFD29B;
	Sat, 25 May 2024 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611302; cv=none; b=fDjN6eiuZJkVOwvGsLrVLLlmw0FvaXXggfhst38x+bcSAtk8+i/WWDYz2XEwjRrW3p52ZhVwoHxSi0po8B9K3Z1HdBJvEaAoqkoZIBPnvYJVRoewhH354YmY5en3cMr0xHPx0Ra8mxEkBT9U1mQ71o1LPpvxtT65FsrbY7gmJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611302; c=relaxed/simple;
	bh=ttlCjFGN1GWY/TRCbxgxdnLzYeRMUvqNwRjJELBMJSw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U8lx9Cz9lbrcnsSz/gOpwS+X1RmtIaRhuxHU7SI1KhZGj6PWzS35AddQwoK/9Q6eBC5yK71PiORw4CKFELAa4DssfzwE6umBMwJx6R3Qc+EqhSpc0gr+eKMWa2PIpFqKBLEHDDM30rp3dsF/bj5mhD72t5+tHaAW9yJb+u+SIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4oYl54JU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716611298;
	bh=ttlCjFGN1GWY/TRCbxgxdnLzYeRMUvqNwRjJELBMJSw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=4oYl54JU9WNgEPcMjvWlTxh2YNyVcBYI0T4zCpnO9XKUTsSh70gOR/xLsl9kjKOpw
	 zzT0I1JMFIcgjNKX5vE9rpJUxInTLle0XlOEb55KyPiNAOuRKfJ/tRjooQOtjWbpH+
	 D/IhPYK9ydHAKMqMqScl+GREoW/lUcKj5Izo6tI5caMTDpb/lszzCbFxWoLqRnM6Bd
	 5B4C9QiJwCgjDfHqcN3TyAAr1RVXODXy+QL6KIcCwaFo5HUiTkiPXl0ds5z2InH9kc
	 D3URgFnWliYDZ0LcrTm9nFHewzfb9wiOUNw2QzzI0ry6MRPOpNxI1KqoGBVnRcv/r/
	 xXj8JHyg8dkrw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C4E53782085;
	Sat, 25 May 2024 04:28:17 +0000 (UTC)
Message-ID: <f03e4933-d835-4080-ac44-f7f17adeca62@collabora.com>
Date: Fri, 24 May 2024 21:28:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Update required config
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
References: <171624961322.252417.15852003285637286674.stgit@devnote2>
 <171624963215.252417.12572658025062192987.stgit@devnote2>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <171624963215.252417.12572658025062192987.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 5:00 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Update required config options for running all tests.
> This also sorts the config entries alphabetically.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/ftrace/config |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
> index e59d985eeff0..048a312abf40 100644
> --- a/tools/testing/selftests/ftrace/config
> +++ b/tools/testing/selftests/ftrace/config
> @@ -1,16 +1,28 @@
> -CONFIG_KPROBES=y
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_DEBUG_INFO_BTF=y
> +CONFIG_DEBUG_INFO_DWARF4=y
> +CONFIG_EPROBE_EVENTS=y
> +CONFIG_FPROBE=y
> +CONFIG_FPROBE_EVENTS=y
>  CONFIG_FTRACE=y
> +CONFIG_FTRACE_SYSCALLS=y
> +CONFIG_FUNCTION_GRAPH_RETVAL=y
>  CONFIG_FUNCTION_PROFILER=y
> -CONFIG_TRACER_SNAPSHOT=y
> -CONFIG_STACK_TRACER=y
>  CONFIG_HIST_TRIGGERS=y
> -CONFIG_SCHED_TRACER=y
> -CONFIG_PREEMPT_TRACER=y
>  CONFIG_IRQSOFF_TRACER=y
> -CONFIG_PREEMPTIRQ_DELAY_TEST=m
> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_KPROBES=y
> +CONFIG_KPROBE_EVENTS=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> +CONFIG_PREEMPTIRQ_DELAY_TEST=m
> +CONFIG_PREEMPT_TRACER=y
> +CONFIG_PROBE_EVENTS_BTF_ARGS=y
>  CONFIG_SAMPLES=y
>  CONFIG_SAMPLE_FTRACE_DIRECT=m
>  CONFIG_SAMPLE_TRACE_PRINTK=m
> -CONFIG_KALLSYMS_ALL=y
> +CONFIG_SCHED_TRACER=y
> +CONFIG_STACK_TRACER=y
> +CONFIG_TRACER_SNAPSHOT=y
> +CONFIG_UPROBES=y
> +CONFIG_UPROBE_EVENTS=y
> 
> 

-- 
BR,
Muhammad Usama Anjum

