Return-Path: <linux-kselftest+bounces-27672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2A6A46E32
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 23:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E665167D0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41C26B968;
	Wed, 26 Feb 2025 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWGeZDxQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ACD2561D6;
	Wed, 26 Feb 2025 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607850; cv=none; b=ie+ESvSa+jnj7Nz+BvLhXKTx6TzYtb+jQLwTx320knifichn6HODrQMB2wn79Kh1Rctd5G6hN4zqAptRAUZ6yRO15+dcohoqrqXtmrQ8rtobXxxXFQL7k+zsZYLZhQFml45/f1gJ8JgnNF3czpE9yDgoP7l/gyZ2ktGoqCtgVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607850; c=relaxed/simple;
	bh=8z/EktT9cohwewcwTxovsYIKkMv5C9KelOQJmHXC5vs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QFhJtWKvPbfBsNgrXh5SYj08QwwDvgrQ+BPC9JFu0aeEhyfQgTnK4NUlaV+/8q2QfI3ykfMHqla5pRMkR5PUUHPtNeItMnNsoRRNEd+2Dh7PyEJjELoUhDP4RhR5i1FNrFAWJw9sdsvy7eqQ0GOQHHpHsjscIVvkrLg/lLDCl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWGeZDxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8065C4CED6;
	Wed, 26 Feb 2025 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607849;
	bh=8z/EktT9cohwewcwTxovsYIKkMv5C9KelOQJmHXC5vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWGeZDxQp4p/Ow8Cwd4BbDC5nT+8mq4ln92DLGBjAp31SnHtlHpAU7rCbUV9czI36
	 2V527EiGj4s6ddqK2BzEcb21Bqjw1TLtQIukAikASMtmH4kfTNvRlyidYe1ipXSObp
	 dBZcMHlm85R2BaETFgLPGhhyFqLz0K6DdbAP+gX+hprb52736Jed+ubHvaaep7WgTx
	 4KbsFIHzhlmizU+qNZixL65+KJeUXDsWzi5wcCyoRbGDVTpgAhu5pLOEiYce+XTw2Q
	 gDXbUZ2O9rsqJD3yIdfmqjfuacFYeLozc/GKZThZ57IQs+VzqmOqPUuTKmqFZrfjHM
	 8TEe+lFOl20ZA==
Date: Thu, 27 Feb 2025 07:10:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/8] tracing: fprobe-events: Log error for exceeding the
 number of entry args
Message-Id: <20250227071045.7ead04fb9f467b0a7120c05a@kernel.org>
In-Reply-To: <20250226102223.586d7119@gandalf.local.home>
References: <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
	<174055074269.4079315.17809232650360988538.stgit@mhiramat.tok.corp.google.com>
	<20250226102223.586d7119@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 10:22:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 26 Feb 2025 15:19:02 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > index 85f037dc1462..e27305d31fc5 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -1230,6 +1230,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  	if (is_return && tf->tp.entry_arg) {
> >  		tf->fp.entry_handler = trace_fprobe_entry_handler;
> >  		tf->fp.entry_data_size = traceprobe_get_entry_data_size(&tf->tp);
> 
> Looking at traceprobe_get_entry_data_size(), the setting of the offset and
> what it returns is a bit of magic. It's not intuitive and really could use
> some comments. This isn't against this patch, but it does make it hard to
> review this patch.

Indeed. It is a bit tricky.

> 
> > +		if (ALIGN(tf->fp.entry_data_size, sizeof(long)) > MAX_FPROBE_DATA_SIZE) {
> > +			trace_probe_log_set_index(2);
> > +			trace_probe_log_err(0, TOO_MANY_EARGS);
> > +			return -E2BIG;
> > +		}
> >  	}
> >  
> >  	ret = traceprobe_set_print_fmt(&tf->tp,
> 
> 
> We have this in trace_probe.c:
> 
> static int __store_entry_arg(struct trace_probe *tp, int argnum)
> {
> 	struct probe_entry_arg *earg = tp->entry_arg;
> 	bool match = false;
> 	int i, offset;
> 
> 	if (!earg) {
> 		earg = kzalloc(sizeof(*tp->entry_arg), GFP_KERNEL);
> 		if (!earg)
> 			return -ENOMEM;
> 		earg->size = 2 * tp->nr_args + 1;
> 		earg->code = kcalloc(earg->size, sizeof(struct fetch_insn),
> 				     GFP_KERNEL);
> 		if (!earg->code) {
> 			kfree(earg);
> 			return -ENOMEM;
> 		}
> 		/* Fill the code buffer with 'end' to simplify it */
> 		for (i = 0; i < earg->size; i++)
> 			earg->code[i].op = FETCH_OP_END;
> 		tp->entry_arg = earg;
> 	}
> 
> 	offset = 0;
> 	for (i = 0; i < earg->size - 1; i++) {
> 		switch (earg->code[i].op) {
> 		case FETCH_OP_END:
> 			earg->code[i].op = FETCH_OP_ARG;
> 			earg->code[i].param = argnum;
> 			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
> 			earg->code[i + 1].offset = offset;
> 
> // There's definitely some dependency between FETCH_OP_END, FETCH_OP_ARG
> // and FETCH_OP_ST_EDATA that isn't documented. At least not in this file.

This accumurates the fetching operation on the code. The problem is
limitation of the entry data size. So this scans the entry code and
checks whether the specified function argument is already stored, and
reuse it (return the offset where it is stored). If there isn't,
it stores a pair of FETCH_OP_ARG + FETCH_OP_ST_EDATA at the end of
the code array.

> 
> 			return offset;
> 		case FETCH_OP_ARG:
> 			match = (earg->code[i].param == argnum);
> 			break;
> 		case FETCH_OP_ST_EDATA:
> 			offset = earg->code[i].offset;
> 			if (match)
> 				return offset;
> 			offset += sizeof(unsigned long);
> 			break;
> 		default:
> 			break;
> 		}
> 	}
> 	return -ENOSPC;
> }
> 
> int traceprobe_get_entry_data_size(struct trace_probe *tp)
> {
> 	struct probe_entry_arg *earg = tp->entry_arg;
> 	int i, size = 0;
> 
> 	if (!earg)
> 		return 0;
> 
> 	for (i = 0; i < earg->size; i++) {
> 		switch (earg->code[i].op) {
> 		case FETCH_OP_END:
> 			goto out;
> 		case FETCH_OP_ST_EDATA:
> 			size = earg->code[i].offset + sizeof(unsigned long);
> 
> // What makes earg->code[i].offset so special?
> // What is the guarantee that code[i + 1].offset is greater than code[i].offset?
> // I guess the above function guarantees that, but it's not obvious here.

Yeah, let me explain.

	/*
	 * earg->code[] array has an operation sequence which is run in
	 * the entry handler.
	 * The sequence stopped by FETCH_OP_END and each data stored in
	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
	 * stores the data at the data buffer + its offset, and all data are
	 * "unsigned long" size. The offset must be increased when a data is
	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
	 * code array.
	 */

> 
> 			break;
> 		default:
> 			break;
> 		}
> 	}
> out:
> 	return size;
> }
> 
> Assuming that traceprobe_get_entry_data_size() does properly return the max size.

Yes, maybe we can scan the code array from the end for optimization but it still
needs the explanation.


> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

