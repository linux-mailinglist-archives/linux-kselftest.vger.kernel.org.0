Return-Path: <linux-kselftest+bounces-5679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8A86DA13
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613C31F249A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA245978;
	Fri,  1 Mar 2024 03:32:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96947F4D;
	Fri,  1 Mar 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263969; cv=none; b=BTtmSNGCqq4AXiX1UhFe38j3NiGED2UI5MCspdOZmnAcrcCXPvVUBrKXA/llKyqFr3j7wamwljkMuxuKgHTX4Eev9Vp6RRqs/9/IWZRU0nzJ5nFza++KoFxpj3lbVi1NBq0mY3o5UwwI0/651BPNc7oM70FA67VqiWZeSwTlZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263969; c=relaxed/simple;
	bh=AQMIdAyzr4/b6OZtRBj2E5sPU9N7i0ejYQ2KFr4O1Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olQtZ9zLhkblPIKXFnatZetlvn7kO6qGaUAEe0hvvl/CEFw9kNO64sy5JGZk2im2vc2CNMn9FlQfbZ0bSC3vNaEciPcz4LG+9HtIjc8DVwBPwIohIaYvb7aG52OZ5Orqx0KCkprVYpQJKxlNOmHG/F+R8glTC8Iq+J5EBE+q3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9FDC433F1;
	Fri,  1 Mar 2024 03:32:47 +0000 (UTC)
Date: Thu, 29 Feb 2024 22:34:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/7] tracing/probes: Cleanup probe argument parser
Message-ID: <20240229223455.3ed17549@gandalf.local.home>
In-Reply-To: <170891989362.609861.10050404696043440555.stgit@devnote2>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<170891989362.609861.10050404696043440555.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 12:58:13 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Cleanup traceprobe_parse_probe_arg_body() to split out the
> type parser and post-processing part of fetch_insn.
> This makes no functional change.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_probe.c |  230 ++++++++++++++++++++++++++------------------
>  1 file changed, 137 insertions(+), 93 deletions(-)

