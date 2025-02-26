Return-Path: <linux-kselftest+bounces-27620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B540A46475
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E883A5213
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2001B2236FD;
	Wed, 26 Feb 2025 15:21:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3822221F39;
	Wed, 26 Feb 2025 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583305; cv=none; b=aNjqnC7e43BBsksppHhfbbgFXJfxYhcrJhXiuq33mFRMQZ0J64v3Ug9UFpPuj332uOll0TQ1l8D70tkDaEGtEHk4T+yhMAjANbGF1RXhgnAReKBnRX/BSWZMWz308G0OzNJzzbepN6dXHKFHWByfgUmx7b+/B5DpSBzKavBgqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583305; c=relaxed/simple;
	bh=67CeRvEnNp00FoBhzcmiCD4JfLwcNDyJn1UwXBzzFmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrAeoSSi0NHzqfBe/L3cioZvdXRA/M0fFtVTwCGsHS3Z0tSd/KxDlmXKObSMt/igssGmdAE/Hw1rAoSW/i6CZQy3w4yrts8/VUYwKPp2xSg+LuuF6vs+troBddpPfcIHV9HsxkOHjft3swyYxV/Vj59vmyI5VjeP8a9mKDw8pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8600CC4CED6;
	Wed, 26 Feb 2025 15:21:43 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:22:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/8] tracing: fprobe-events: Log error for exceeding the
 number of entry args
Message-ID: <20250226102223.586d7119@gandalf.local.home>
In-Reply-To: <174055074269.4079315.17809232650360988538.stgit@mhiramat.tok.corp.google.com>
References: <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
	<174055074269.4079315.17809232650360988538.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:19:02 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> index 85f037dc1462..e27305d31fc5 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1230,6 +1230,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	if (is_return && tf->tp.entry_arg) {
>  		tf->fp.entry_handler = trace_fprobe_entry_handler;
>  		tf->fp.entry_data_size = traceprobe_get_entry_data_size(&tf->tp);

Looking at traceprobe_get_entry_data_size(), the setting of the offset and
what it returns is a bit of magic. It's not intuitive and really could use
some comments. This isn't against this patch, but it does make it hard to
review this patch.

> +		if (ALIGN(tf->fp.entry_data_size, sizeof(long)) > MAX_FPROBE_DATA_SIZE) {
> +			trace_probe_log_set_index(2);
> +			trace_probe_log_err(0, TOO_MANY_EARGS);
> +			return -E2BIG;
> +		}
>  	}
>  
>  	ret = traceprobe_set_print_fmt(&tf->tp,


We have this in trace_probe.c:

static int __store_entry_arg(struct trace_probe *tp, int argnum)
{
	struct probe_entry_arg *earg = tp->entry_arg;
	bool match = false;
	int i, offset;

	if (!earg) {
		earg = kzalloc(sizeof(*tp->entry_arg), GFP_KERNEL);
		if (!earg)
			return -ENOMEM;
		earg->size = 2 * tp->nr_args + 1;
		earg->code = kcalloc(earg->size, sizeof(struct fetch_insn),
				     GFP_KERNEL);
		if (!earg->code) {
			kfree(earg);
			return -ENOMEM;
		}
		/* Fill the code buffer with 'end' to simplify it */
		for (i = 0; i < earg->size; i++)
			earg->code[i].op = FETCH_OP_END;
		tp->entry_arg = earg;
	}

	offset = 0;
	for (i = 0; i < earg->size - 1; i++) {
		switch (earg->code[i].op) {
		case FETCH_OP_END:
			earg->code[i].op = FETCH_OP_ARG;
			earg->code[i].param = argnum;
			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
			earg->code[i + 1].offset = offset;

// There's definitely some dependency between FETCH_OP_END, FETCH_OP_ARG
// and FETCH_OP_ST_EDATA that isn't documented. At least not in this file.

			return offset;
		case FETCH_OP_ARG:
			match = (earg->code[i].param == argnum);
			break;
		case FETCH_OP_ST_EDATA:
			offset = earg->code[i].offset;
			if (match)
				return offset;
			offset += sizeof(unsigned long);
			break;
		default:
			break;
		}
	}
	return -ENOSPC;
}

int traceprobe_get_entry_data_size(struct trace_probe *tp)
{
	struct probe_entry_arg *earg = tp->entry_arg;
	int i, size = 0;

	if (!earg)
		return 0;

	for (i = 0; i < earg->size; i++) {
		switch (earg->code[i].op) {
		case FETCH_OP_END:
			goto out;
		case FETCH_OP_ST_EDATA:
			size = earg->code[i].offset + sizeof(unsigned long);

// What makes earg->code[i].offset so special?
// What is the guarantee that code[i + 1].offset is greater than code[i].offset?
// I guess the above function guarantees that, but it's not obvious here.

			break;
		default:
			break;
		}
	}
out:
	return size;
}

Assuming that traceprobe_get_entry_data_size() does properly return the max size.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

