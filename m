Return-Path: <linux-kselftest+bounces-27621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E873AA464E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3774C164B4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5A22D4E2;
	Wed, 26 Feb 2025 15:29:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5822A1ED;
	Wed, 26 Feb 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583744; cv=none; b=bEdch+9N5ufTb1CraGzW5TrClDXJClLtlLwksuboPvEqhVaAAgykBzwDQnlaTGzJiClcfvA1J5io/Re0mo9ZsMCUKHIHPO/zyiHFowb3udW7eKcyIyJ1HwiLHjqAGBkUZIqol/BhZuBxZdNtafMB8BsbGkHKc+B8sqY6BbiPA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583744; c=relaxed/simple;
	bh=OnHmEnWPvS83Da/aYoWNysSG745r2ceFyNCAqo8yztU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsnTIgOY0mqYz9zayoXYcOFPTVWwqd84Dtn/77VLM8FgGnW3qO+3W2rrxbJc7z73XqIFLgVprlsSJPSSIpgqawbS2X2CUmToas5BaDYsjbvxu4gB7nO7m8mFEe7TDTwH7W1O7n/rPIzUvVHd9JqF7kP90Ipk0VmGYss5jYc+fhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D1CC4CEE4;
	Wed, 26 Feb 2025 15:29:03 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:29:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/8] tracing: probe-events: Log errro for exceeding the
 number of arguments
Message-ID: <20250226102943.5d20a6f7@gandalf.local.home>
In-Reply-To: <174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
References: <174055071644.4079315.12468865615828925878.stgit@mhiramat.tok.corp.google.com>
	<174055075075.4079315.10916648136898316476.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:19:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add error message when the number of arguments exceeeds the limitation.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_eprobe.c |    2 ++
>  kernel/trace/trace_fprobe.c |    5 ++++-
>  kernel/trace/trace_kprobe.c |    5 ++++-
>  kernel/trace/trace_probe.h  |    1 +
>  kernel/trace/trace_uprobe.c |    9 +++++++--
>  5 files changed, 18 insertions(+), 4 deletions(-)


