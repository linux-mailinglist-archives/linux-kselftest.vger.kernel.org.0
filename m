Return-Path: <linux-kselftest+bounces-19187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ADA993BDF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 02:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F7B1C240FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208CA79FD;
	Tue,  8 Oct 2024 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaYZKFeH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC129A5;
	Tue,  8 Oct 2024 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347599; cv=none; b=mhoG/ehel8DnQCCgcYuNKekFnV4RZdSwUWqPcB36K0e46L3hPg5awqNOASWjtPKHTxDf+eKL1DI0bdYGynDtYyFljsE6i+Gfhqr4L39Xdhn5X0GRktp+eFvV4shjYR7Gdi+FbXrU+kkBk6fY8P9sd2gB05WPBfENKQAqJrJby6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347599; c=relaxed/simple;
	bh=9BOPaI+WdlC56hU9CaJsn+gbqMBix7pVUylBdkrlr6s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mM/jfrrtdTX2023bOtOumI5eDQoUlq90/LySh5L5mN4NXSa6L79Ywajvbg1YO1CNkTSZ90CbEV5js6flt6a2UnQFEnprFSDp2TSe2dc+lbpQk5cyM/VNhcro57QCt9lPpRBAXyuOJ/ny/vqPZdntwlLvtOTy+rzGHYimLcA/f3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaYZKFeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD5CC4CECD;
	Tue,  8 Oct 2024 00:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728347598;
	bh=9BOPaI+WdlC56hU9CaJsn+gbqMBix7pVUylBdkrlr6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YaYZKFeHDmJ0A39MPZtib7PN5wj+oMusQkkx1rYai7plX1Ia+L9xEtnRRdNCw231h
	 3TLTXlgwMGmsKVor2fINSrZf1Ar9HfsPTK0RACgVuku3/ENaII7ajo/oYBIkAnYeTb
	 F8VSTa4vGG/Hs889bfULG+96n4Ffc5MMaDSs2SHhbIfawBTTvybJjmpV2VNMQQIqgb
	 oiqI6QqZxIoi28ASE37QYCzovkgiaQ04MstkhflWS1ugDlTHq+TACMh/ykMKAYG6qd
	 qQO59aEFnQH11s2fhZmN1bjWRZr3EL7EK9Jd8eKvk2fOUZeMmb6S6qveHw7SOCbCyD
	 u2PPB66Frfd7w==
Date: Tue, 8 Oct 2024 09:33:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
Message-Id: <20241008093314.8b263b6bd2e23c6a8345b65f@kernel.org>
In-Reply-To: <20241004145618.18436d7e@gandalf.local.home>
References: <20241004145618.18436d7e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 14:56:18 -0400
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
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20240821150903.05c6cf96@gandalf.local.home
> 
> - Added comment to why we are doing a sleep 1
> 
> - Now that the fix is in mainline, we can add this to the selftests
> 
>  .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> new file mode 100644
> index 000000000000..1580e4ef9739
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> @@ -0,0 +1,31 @@
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
> +# Let it run for a bit to make sure nothing explodes
> +sleep 1
> +
> +exit 0
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

