Return-Path: <linux-kselftest+bounces-27992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27DDA4B605
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 03:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAB718907B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 02:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDEE1482F5;
	Mon,  3 Mar 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQtCIWiL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5F22611;
	Mon,  3 Mar 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968247; cv=none; b=CwJtj+qXKFQNg1RkTe+pJetqXMetwCXJMc20sngFdeXj+bGRvqY/p8PqvCFZjjfdfXfUxYL8YF0I2yRxuXW0CWagzmW0xa7mIAHDdRU18Qvx5q8lZ4d4caTFvfoi2vVDPaCuc9Q9xeMZQn4WogTqrDvZY6TmWJCO79eLPvyGgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968247; c=relaxed/simple;
	bh=GbrPH0tIFyJAiYao72KxIdzmQ/EXoIRpJp9qNrvdixI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZDNtJX7hEC00L8YpiJShsUtIl/ol8SxJGxsHvld/NcuhBq7Cb/vAsPHg50cfqxrKEbuGq55iwNQLarXF1BDLJExPAIkEu0GwxAU3F6bYcEFx0znniIO2YpjOAFIgHrESf5harhIhuDUAr5olQ9g/3itAO15dK58Z1XUBkjERciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQtCIWiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD73C4CED6;
	Mon,  3 Mar 2025 02:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740968246;
	bh=GbrPH0tIFyJAiYao72KxIdzmQ/EXoIRpJp9qNrvdixI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EQtCIWiL5MabiXwGCiheE9uWuAMeWnsJnos9pCI1omGhXQhXG36kdqDF0lm9+R4Dq
	 1y4pNiEQjZOi1aw/xM5tSF3sYaBXK4P4e/ZjL0JZ2uVq1+HKK/cFU0RJCPeharENer
	 AU2l90DCSlY3L/eb69SXgksK2UzxEM0f32azaWiyJl6bWlOJ8MmG4IZ+AsODqX8Xft
	 xa7eNxq//lCXvKhviI0OIPYJRv+NUQlWCPEeCqMpFTNCgUBPP+KN18eiWDHYagiHOb
	 /Rvz8gd9nPc8YqEkwbwWSJkriepf446cl32r9KTVzmCfsTbWt22IfSz50AZJ/rExil
	 x3Y68xgt/XWJA==
Date: Mon, 3 Mar 2025 11:17:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Hari Bathini
 <hbathini@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/8] tracing: probe-events: Log errro for exceeding the
 number of arguments
Message-Id: <20250303111721.87cd676bacaa29326a575452@kernel.org>
In-Reply-To: <174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
References: <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
	<174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:19:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add error message when the number of arguments exceeeds the limitation.
> 

Hmm, this is not a fix patch so this should be handled as enhancement.
I'll drop this from probes/fixes.

Thanks,

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_eprobe.c |    2 ++
>  kernel/trace/trace_fprobe.c |    5 ++++-
>  kernel/trace/trace_kprobe.c |    5 ++++-
>  kernel/trace/trace_probe.h  |    1 +
>  kernel/trace/trace_uprobe.c |    9 +++++++--
>  5 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 82fd637cfc19..af9fa0632b57 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -913,6 +913,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	}
>  
>  	if (argc - 2 > MAX_TRACE_ARGS) {
> +		trace_probe_log_set_index(2);
> +		trace_probe_log_err(0, TOO_MANY_ARGS);
>  		ret = -E2BIG;
>  		goto error;
>  	}
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index e27305d31fc5..372936163c21 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1201,8 +1201,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  		argc = new_argc;
>  		argv = new_argv;
>  	}
> -	if (argc > MAX_TRACE_ARGS)
> +	if (argc > MAX_TRACE_ARGS) {
> +		trace_probe_log_set_index(2);
> +		trace_probe_log_err(0, TOO_MANY_ARGS);
>  		return -E2BIG;
> +	}
>  
>  	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
>  	if (ret)
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index d8d5f18a141a..8287b175667f 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1007,8 +1007,11 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
>  		argc = new_argc;
>  		argv = new_argv;
>  	}
> -	if (argc > MAX_TRACE_ARGS)
> +	if (argc > MAX_TRACE_ARGS) {
> +		trace_probe_log_set_index(2);
> +		trace_probe_log_err(0, TOO_MANY_ARGS);
>  		return -E2BIG;
> +	}
>  
>  	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
>  	if (ret)
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index c47ca002347a..6075afc8ea67 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -546,6 +546,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
>  	C(BAD_TYPE4STR,		"This type does not fit for string."),\
>  	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
> +	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
>  	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
>  
>  #undef C
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index ccc762fbb69c..3386439ec9f6 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -562,8 +562,14 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  
>  	if (argc < 2)
>  		return -ECANCELED;
> -	if (argc - 2 > MAX_TRACE_ARGS)
> +
> +	trace_probe_log_init("trace_uprobe", argc, argv);
> +
> +	if (argc - 2 > MAX_TRACE_ARGS) {
> +		trace_probe_log_set_index(2);
> +		trace_probe_log_err(0, TOO_MANY_ARGS);
>  		return -E2BIG;
> +	}
>  
>  	if (argv[0][1] == ':')
>  		event = &argv[0][2];
> @@ -582,7 +588,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  		return -ECANCELED;
>  	}
>  
> -	trace_probe_log_init("trace_uprobe", argc, argv);
>  	trace_probe_log_set_index(1);	/* filename is the 2nd argument */
>  
>  	*arg++ = '\0';
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

