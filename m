Return-Path: <linux-kselftest+bounces-36735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49EAFBFA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 03:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D651AA17AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 01:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466F1D54E2;
	Tue,  8 Jul 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJNPmW+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7574800;
	Tue,  8 Jul 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936770; cv=none; b=sjelkkhKi3iH0djuRgPbqFFwiwjOW5rZdVGKBa86Ysjl8aWbl+q3EylDg/q2V8V8Kcnmoj7RZpRAEDSMrgYsTbUkP6ATHpwLef0SSuzPFjg3p2n0uLPV+m/jknIBPlmDq+7nfd0IUmRHD8LUdJiPFvUNoK0RERVIecwv6xsAZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936770; c=relaxed/simple;
	bh=IqUusqZtaGc+yPH5WcBNX7z/p65MpoEEqy1SvU0vj9E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pmU2NtN38AakAavFTIj4KEFGW28FP5goUEVRqkwx33atJYWZszJ4b0Vti2hA0gixgSF7Ju/x1QDtBqFSjRhGQonDxtx9SwYYhsJwlPP1uMRJvibSUIxGl5E7nBks++FDI9t5RdMFf5Rh1I1pG3677xkJWhwe7lDLML0Ko6K7cYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJNPmW+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AE8C4CEE3;
	Tue,  8 Jul 2025 01:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751936770;
	bh=IqUusqZtaGc+yPH5WcBNX7z/p65MpoEEqy1SvU0vj9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJNPmW+qjpXKSBgIH4/cr7d+UMNOsTGAg/5nLeVOWepZwC1FG0UG6hJZG0jSc5ilA
	 btxItPOHe9YO47Fw74cWFp6zPUMvnabdnKaa5IW77GgBYYqNXMlKcgeLOoT0KeP7G0
	 LlUD+IySF6SvhljFMOGhRFJLHnbMBjJMYAYDwWHV69AuNL24uhXT7K5i1MRjZ5iJLv
	 X/5ZKYF04ztdrIbXG+1W9p/p8CuQt/a5nYl1SuEz1ng+ELOcT8S9yiCHl8G7Um+4vF
	 Ypiqswi83sIhr6pFX7Di70f+9Cupu7metwl+men5HU5/o+k4DrHBtmmj0evC/uJjf9
	 i9Bxggjyaqa5A==
Date: Tue, 8 Jul 2025 10:06:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Handle "(const) char __attribute() *" as
 string ptr type
Message-Id: <20250708100607.a09526bf6712a3b98f7a5464@kernel.org>
In-Reply-To: <175151679513.2149615.16646841903099858271.stgit@mhiramat.tok.corp.google.com>
References: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
	<175151679513.2149615.16646841903099858271.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Jul 2025 13:26:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> With CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y, `__user` is
> converted to `__attribute((btf_type_tag("user")))`. In this case,
> some syscall events have `const char __attribute(...) *` for __user
> string, like below;
> 
> /sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format
> name: sys_enter_openat
> ID: 720
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
> 	field:int dfd;	offset:16;	size:8;	signed:0;
> 	field:const char __attribute__((btf_type_tag("user"))) * filename;	offset:24;

Ahh, sorry, it was "__attribute__()" not "__attribute()".

Anyway, I think we should sanitize the __attribute__ from
format.

Thank you,


	size:8;	signed:0;
> 	field:int flags;	offset:32;	size:8;	signed:0;
> 	field:umode_t mode;	offset:40;	size:8;	signed:0;
> 
> 
> Then the trace event filter failes to set string acceptable flag
> (FILTER_PTR_STRING) and rejects setting string filter;
> 
> # echo 'filename.ustring ~ "*ftracetest-dir.wbx24v*"' >> events/syscalls/sys_enter_openat/filter
> sh: write error: Invalid argument
>  # cat error_log
> [  723.743637] event filter parse error: error: Expecting numeric field
>   Command: filename.ustring ~ "*ftracetest-dir.wbx24v*"
> 
> Handle "(const) char __attribute() *" also as string ptr type.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 3885aadc434d..5e27190a0377 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1488,6 +1488,11 @@ int filter_assign_type(const char *type)
>  	if (strcmp(type, "char *") == 0 || strcmp(type, "const char *") == 0)
>  		return FILTER_PTR_STRING;
>  
> +	/* Ignore attributes */
> +	if (glob_match("char __attribute(*) \\*", type) ||
> +	    glob_match("const char __attribute(*) \\*", type))
> +		return FILTER_PTR_STRING;
> +
>  	return FILTER_OTHER;
>  }
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

