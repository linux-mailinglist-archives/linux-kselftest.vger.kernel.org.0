Return-Path: <linux-kselftest+bounces-27673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B038A4701A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1261F3AD950
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 00:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3927002C;
	Thu, 27 Feb 2025 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="use3T4HU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458F4409;
	Thu, 27 Feb 2025 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615549; cv=none; b=jHYZiAFKFl3kOBTGEjGPy1k8CS5Mm2PpuwF3OQuuznRNjpB22l8KkgRY3N6qdTYEROGp1FOTpNyzQ1aqW93yVNZYaLwExSkQWoqWLpNhQPEGVN/bRDYfkqz8T1WnHT698LWgHLu32Szhn79fUf2uSg6Z3rXR/HZZN3rSHzG4MZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615549; c=relaxed/simple;
	bh=OhHzvRtAXmomXEfK5skVxxdqphjFWcEfIMHsOokDVww=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gAHPVBWJ5JsNHrqpDlgsU6YHIMZKD6y3oRT+KpYKgX0d7wxqKgLlGzMa4cUVu0qdvxjq5K3IWgk80r+PNPCsVHPyVHx71chVMxUvS2dlAdep3nT28yIFDgZFpPk+VHjcFwbE32bWiA2+vvswwZiM4aad40J/WaaoH1S7860maLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=use3T4HU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FCCC4CED6;
	Thu, 27 Feb 2025 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740615549;
	bh=OhHzvRtAXmomXEfK5skVxxdqphjFWcEfIMHsOokDVww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=use3T4HU6zl95+M2MHpIHt7PUv3MfJvJ115DyCeBeI1/s5TnK9LHZ4IZ0QWxu0c3Q
	 JYWrUYZqKP43LaLcAsgVeHg+2liUm5XUfJ1qy/nLCiwrEqNcVqgjL5NzkD+9CxxxZ2
	 nWjYBPipmCtw2KGucjiVuSKjPxK9bm/A6qwEsK1MqLBC08fBx9UZldlCNcgR3Ea1Go
	 E5XPr9pIcKdquUdmMQraKJpm4+3yNV0rXX1tjO7ugwDn4ZeWSSTESdpaX/9Je/OzZA
	 7DVQ+HSXXQl10Rm1R71/NZoaGQgBTw6JdjE7zX4FrC4+eDuItuYaL0sc7eou+OgeJx
	 yo7AxuL+iadpA==
Date: Thu, 27 Feb 2025 09:19:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 4/8] tracing: probe-events: Log errro for exceeding the
 number of arguments
Message-Id: <20250227091904.a072168412d6d94efc5b0852@kernel.org>
In-Reply-To: <516ea911-acc6-47c2-87d5-2df0a18468de@web.de>
References: <174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
	<516ea911-acc6-47c2-87d5-2df0a18468de@web.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 17:13:17 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> …
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -1201,8 +1201,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  		argc = new_argc;
> >  		argv = new_argv;
> >  	}
> > -	if (argc > MAX_TRACE_ARGS)
> > +	if (argc > MAX_TRACE_ARGS) {
> > +		trace_probe_log_set_index(2);
> > +		trace_probe_log_err(0, TOO_MANY_ARGS);
> >  		return -E2BIG;
> > +	}
> >
> >  	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
> …
> 
> May a bit of exception handling code be shared by an additional jump target?
> Will another goto chain become helpful here?

Honestly, I don't want to introduce jump any more.

> 
> 
> How do you think about to avoid a typo in the summary phrase?

Ah, I added too much 'e' :-D Will fix it.

Thanks,

> 
> Regards,
> Markus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

