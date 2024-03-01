Return-Path: <linux-kselftest+bounces-5678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E468B86DA0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F1F2851F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 03:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76A45978;
	Fri,  1 Mar 2024 03:32:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4541233;
	Fri,  1 Mar 2024 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263952; cv=none; b=GlYwXQwlnCinbHLxtXKBxrisEO3XsjaJ3Dg9ea3uqmAojeShBps2/Y+wmcFhKeNCj0IGwLQevzNfYb65FhYxeK7Ko1RRXHNmMRC3VtyqJ2oseRQ2PzzjgL1W2l9whsZUftdgHOxnrnxPeCkuuX/QkACaJT/RQMvphGeUFit/CCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263952; c=relaxed/simple;
	bh=3md6p1S1+lyjMSHnq4LM35hv71N1S1K5a5XKM3tOm8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8h2gMDKme/lNEbDZh3rZQzs6YPBDy/LS4T4o49i08Txkww0vXeAHqCUCPqFN0rSn3CsaaG2NPk5Z817xKzGLEYMMZfgHa9nhZH069dXZLQRFSr9XtVLJ+v1e8qFHc5lz4e/yiu/G9PBmSVLQ1mOlYqEHm+KrYML9NB5od7HKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561FBC433F1;
	Fri,  1 Mar 2024 03:32:31 +0000 (UTC)
Date: Thu, 29 Feb 2024 22:34:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/7] tracing/fprobe-event: cleanup: Fix a wrong
 comment in fprobe event
Message-ID: <20240229223438.6ee75c8a@gandalf.local.home>
In-Reply-To: <170891988369.609861.16668663308029384207.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<170891988369.609861.16668663308029384207.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 12:58:03 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Despite the fprobe event,  "Kretprobe" was commented. So fix it.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_fprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 7d2ddbcfa377..3ccef4d82235 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -210,7 +210,7 @@ fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
>  }
>  NOKPROBE_SYMBOL(fentry_trace_func);
>  
> -/* Kretprobe handler */
> +/* function exit handler */
>  static nokprobe_inline void
>  __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
>  		   unsigned long ret_ip, struct pt_regs *regs,


