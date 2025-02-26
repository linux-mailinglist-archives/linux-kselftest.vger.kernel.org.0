Return-Path: <linux-kselftest+bounces-27623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3899A46507
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4281882F57
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C401226173;
	Wed, 26 Feb 2025 15:32:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF4225A4F;
	Wed, 26 Feb 2025 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583928; cv=none; b=PHpy0jZfTAegSjt6X16zTmbZ2nrYdz8DEvbLJ9T41VsXrjjLg9QnBdio5GUdpnFjCgHLzBaX7PAEg50hZ8OfVwfUmsKbRIRH5aK01jW1awOrkIU1BJCBfpMwCB7PMZMMCUEas2sf0fuEU4UEYAbPYnVLPCM4VSPBMVtlCltSMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583928; c=relaxed/simple;
	bh=heENjJMwh84tX4G13BOeVR205PPQbLUC4CONA1SFEPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgdLrbIqpiFNsXCjcsnW2PHsEzIJGVAtcRBnMVoz9OhrJfZFO9AGWcc/UyP/5SmssS5057X3haSvmy9qTTi+xEwHrihCbGvSYUibBf5agvvRZAj/7OaJCTTc59W6qgIi0OwDKqo5u2EZv+0YcNERywFUOSlNv3lE7a6CYJYSaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FB9C4CEEA;
	Wed, 26 Feb 2025 15:32:06 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:32:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/8] tracing: probe-events: Remove unused
 MAX_ARG_BUF_LEN macro
Message-ID: <20250226103247.23abdd62@gandalf.local.home>
In-Reply-To: <174055075876.4079315.8805416872155957588.stgit@mhiramat.tok.corp.google.com>
References: <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
	<174055075876.4079315.8805416872155957588.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:19:18 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit 18b1e870a496 ("tracing/probes: Add $arg* meta argument for all
> function args") introduced MAX_ARG_BUF_LEN but it is not used.
> Remove it.
> 
> Fixes: 18b1e870a496 ("tracing/probes: Add $arg* meta argument for all function args")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


>  kernel/trace/trace_probe.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 6075afc8ea67..854e5668f5ee 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -36,7 +36,6 @@
>  #define MAX_BTF_ARGS_LEN	128
>  #define MAX_DENTRY_ARGS_LEN	256
>  #define MAX_STRING_SIZE		PATH_MAX
> -#define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
>  
>  /* Reserved field names */
>  #define FIELD_STRING_IP		"__probe_ip"


