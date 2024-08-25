Return-Path: <linux-kselftest+bounces-16224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808E95E418
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 17:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960F91C20A6A
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D481547EB;
	Sun, 25 Aug 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFezltXx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928E61FFC;
	Sun, 25 Aug 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598856; cv=none; b=jphv4ttE5AOYxLFYyfRUf+biSvsEhHCzFRKFvO6suRVqu3UglwPOU/QOoDV1k/eNUJRovSxQ79AJZAdcZsbuxEBBggp2hr4GP/V/ZwYJq9b5K6z578jixmR3JgSHM5qcKKd9zz9vIUxhFiReLjIPE8zKEDx7TsjTx7BrXO0RvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598856; c=relaxed/simple;
	bh=+Ejih42HNI9fRfwQo8o4of4mjbUFyPFvcmlliCErK2s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iAp1sXgwMU4p3DKwc1lWeiB3HXE5nMtpg5c803e7LMIflT8uYeApODL0LvvNJUVBQhUvHz9c+VUzgLGvxsUC2hetqjk//lorb8W1nZEsAN6P7lpos1mKR0Dxkm3Pd91MevcTSbYesIFOFIWSlCM1Qt/Xwt9yEqhRXFDrmWiegXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFezltXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1138EC32782;
	Sun, 25 Aug 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724598855;
	bh=+Ejih42HNI9fRfwQo8o4of4mjbUFyPFvcmlliCErK2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZFezltXxFeIUp1wg4DUNsV8YHR73bAH6SePViAfmXnvi5/Yrtbg0o+KsA5zDV5g4I
	 hwfRNkZ+jmSMDjF+BiWddTeNkRwN2v5q5oaJp1lXS4my04DenrbRKhbbVdFgVGG4ZC
	 imsdS0JuZnl548AEEDdWyIKinDyKmvax1AGrL04C5Ch7sgpoH9ElZfbZKk3SJwDsQi
	 jfYftMG6iaBe/3xC744s7BYgBP6R6SClJyrwknFcmAXcCh4Fy4QdAgJQ6ngznqLx0Z
	 Ypr6jciaZp8GZTt4BVhENnCwPFZahFQn8Rj+sxDhUhq9ckzJflOpMzkBO+eaasIdNo
	 pHqupwcgLGgLw==
Date: Mon, 26 Aug 2024 00:14:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
Message-Id: <20240826001410.76bcc8304e7c3ee188420b5c@kernel.org>
In-Reply-To: <20240821150903.05c6cf96@gandalf.local.home>
References: <20240821150903.05c6cf96@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 15:09:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Masami reported a bug when running function graph tracing then the
> function profiler. The following commands would cause a kernel crash:
> 
>   # cd /sys/kernel/tracing/
>   # echo function_graph > current_tracer
>   # echo 1 > function_profile_enabled
> 
> In that order. Create a test to test this two to make sure this does not
> come back as a regression.
> 
> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2

This looks good to me, but note that this depends on the above fix, unless
that, this may crash the kernel. I think the above fix should be merged in
v6.11-rcX so this may be safe for released kernel.

Thanks,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> new file mode 100644
> index 000000000000..62d44a1395da
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - function profiler with function graph tracing
> +# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
> +
> +# The function graph tracer can now be run along side of the function
> +# profiler. But there was a bug that caused the combination of the two
> +# to crash. It also required the function graph tracer to be started
> +# first.
> +#
> +# This test triggers that bug
> +#
> +# We need function_graph and profiling to to run this test
> +
> +fail() { # mesg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo "Enabling function graph tracer:"
> +echo function_graph > current_tracer
> +echo "enable profiler"
> +
> +# Older kernels do not allow function_profile to be enabled with
> +# function graph tracer. If the below fails, mark it as unsupported
> +echo 1 > function_profile_enabled || exit_unsupported
> +
> +sleep 1
> +
> +exit 0
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

