Return-Path: <linux-kselftest+bounces-27617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D66A4642F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FFB189CE18
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8A22330F;
	Wed, 26 Feb 2025 15:10:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00881A01BF;
	Wed, 26 Feb 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582612; cv=none; b=o7/cooAGZTYn2JTtOfl+/Q5XnbxkzhhaQo54i67Hc/dXz4W3NUdWbVB0F6kI3yaF18v6lumH5SuZ3EVAKk8do3KaOUN2R/IqSlo+RMYU8JUHey5KrKw9YkPbXp2KBjj8VvHmjYaCHoyAJCKTDC2dN99DessBHtsMey12Kn5dDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582612; c=relaxed/simple;
	bh=/tbzthtXQ2spNV8JpbzGS3/e0POqAJEmpN9Ki+K+4hA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8C5HD8lIQa1qC2ni7vAnFohxucmjCiaZ9k+09+vHHI2hvC7QpKwP6Ml3rmptRulLIrMQ/eiPJ9oLCPRpCRPCQoRC/gUPEsotg/SPaCEXyxEWscjYr1opd+LGEv7hRrznC8T74B7fE9PrBQr8fwwUwmym5aXKOvt12DFKQYpTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1DDC4CED6;
	Wed, 26 Feb 2025 15:10:11 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:10:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/8] tracing: tprobe-events: Reject invalid tracepoint
 name
Message-ID: <20250226101052.2fa3ce66@gandalf.local.home>
In-Reply-To: <174055073461.4079315.15875502830565214255.stgit@mhiramat.tok.corp.google.com>
References: <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
	<174055073461.4079315.15875502830565214255.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:18:54 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit 57a7e6de9e30 ("tracing/fprobe: Support raw tracepoints on
> future loaded modules") allows user to set a tprobe on non-exist
> tracepoint but it does not check the tracepoint name is acceptable.
> So it leads tprobe has a wrong character for events (e.g. with
> subsystem prefix). In this case, the event is not shown in the
> events directory.
> 
> Reject such invalid tracepoint name.
> 
> The tracepoint name must consist of alphabet or digit or '_'.
> 
> Fixes: 57a7e6de9e30 ("tracing/fprobe: Support raw tracepoints on future loaded modules")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> ---
>  kernel/trace/trace_fprobe.c |   13 +++++++++++++
>  kernel/trace/trace_probe.h  |    1 +
>  2 files changed, 14 insertions(+)

