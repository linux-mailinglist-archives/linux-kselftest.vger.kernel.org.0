Return-Path: <linux-kselftest+bounces-27616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3ABA46423
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC1B17F4AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899722257D;
	Wed, 26 Feb 2025 15:08:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B962222AC;
	Wed, 26 Feb 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582537; cv=none; b=ps1/F3sLzXeVtxgShdGdRUyifwQUWRMcSv2oZs/oa/f3dFl7EwqlJw04YuZgLpvAziMz3bPBziW9A0qVW5hDe94sPu7/j1G6GnN6ivuQuEL23VpfHP1bhyk4tC1qzzAvtzkHcxCibkhGeOYYqKIo+RJ4+jn/iNUEUXJ2Fs7yoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582537; c=relaxed/simple;
	bh=wdK2y38U28/EfmbJMUJQ+Hrkq67zILv4mUgCax8zjbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoI0yuwDY9ok1aci4AW6FUxFkzfb7gd3S7SwjNmM+6JbJJAfAblPt+YfZYsKwuuX3xBFxMjSHAd4w/M6xK4wf1psVGmNHMNBUEundFNlIPAWHeCpD6dNMMv2uN7xs/wJpapwHqa/qhjFwSHfekwTqqFdLUPW0P0DpEnyBj8I0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D07AC4CED6;
	Wed, 26 Feb 2025 15:08:56 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:09:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/8] tracing: tprobe-events: Fix a memory leak when
 tprobe with $retval
Message-ID: <20250226100936.50d45e7c@gandalf.local.home>
In-Reply-To: <174055072650.4079315.3063014346697447838.stgit@mhiramat.tok.corp.google.com>
References: <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
	<174055072650.4079315.3063014346697447838.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:18:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix a memory leak when a tprobe is defined with $retval. This
> combination is not allowed, but the parse_symbol_and_return() does
> not free the *symbol which should not be used if it returns the error.
> Thus, it leaks the *symbol memory in that error path.
> 
> Fixes: ce51e6153f77 ("tracing: fprobe-event: Fix to check tracepoint event and return")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_fprobe.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index b8f3c4ba309b..8826f44f69a4 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1056,6 +1056,8 @@ static int parse_symbol_and_return(int argc, const char *argv[],
>  			if (is_tracepoint) {
>  				trace_probe_log_set_index(i);
>  				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> +				kfree(*symbol);
> +				*symbol = NULL;
>  				return -EINVAL;
>  			}
>  			*is_return = true;


