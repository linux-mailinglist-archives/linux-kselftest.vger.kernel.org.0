Return-Path: <linux-kselftest+bounces-4856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6600857F2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4457F1F267CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C112CD81;
	Fri, 16 Feb 2024 14:22:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF04768F2
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093325; cv=none; b=VAqhuFB8KvrTSGP3H62Pg8kP/QLzEVnaQZVnpZgR/r6hIp2OmZzrpH4CxaeisHmaU+l2/xn60YmoY1G8kPbt3EupDTlrAd6xE/awtH4wxGAMtVf7Sl6rdBI8SZogkHv/mkIaKEJWppAEFGSfhFjkjQxiRikeWsKppZLDUH2gX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093325; c=relaxed/simple;
	bh=gAKMAJJtVFatHXJVQCAW+iTU7bZtPh/yqcHI5+Jdupw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mxo6mTZrRmyzTv9kfILXQJQzWf90bXr8NaNyIipIITXOyH89Wq7j2CO4vF2SDJsGmxUaCo87dHQIR3QL4HPZKDxmo8jXi0gPENpEqSRcnkCfVFx5vNdGuWL3UuSu2tRqHiL2nGnzs+6Byvu+bgeiGZCm0HiTbteFVX+7U3coBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3ADC433C7;
	Fri, 16 Feb 2024 14:22:03 +0000 (UTC)
Date: Fri, 16 Feb 2024 09:23:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RESEND] selftests/ftrace: Add test to exercize function
 tracer across cpu hotplug
Message-ID: <20240216092339.49b535d3@gandalf.local.home>
In-Reply-To: <20240216095626.1234309-1-naveen@kernel.org>
References: <20240216095626.1234309-1-naveen@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 15:26:26 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Add a test to exercize cpu hotplug with the function tracer active to
> ensure that sensitive functions in idle path are excluded from being
> traced. This helps catch issues such as the one fixed by commit
> 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> 
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah, can you take this?

Thanks,

-- Steve

> ---
>  .../ftrace/test.d/ftrace/func_hotplug.tc      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> new file mode 100644
> index 000000000000..ccfbfde3d942
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: ftrace - function trace across cpu hotplug
> +# requires: function:tracer
> +
> +if ! which nproc ; then
> +  nproc() {
> +    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
> +  }
> +fi
> +
> +NP=`nproc`
> +
> +if [ $NP -eq 1 ] ;then
> +  echo "We cannot test cpu hotplug in UP environment"
> +  exit_unresolved
> +fi
> +
> +# Find online cpu
> +for i in /sys/devices/system/cpu/cpu[1-9]*; do
> +	if [ -f $i/online ] && [ "$(cat $i/online)" = "1" ]; then
> +		cpu=$i
> +		break
> +	fi
> +done
> +
> +if [ -z "$cpu" ]; then
> +	echo "We cannot test cpu hotplug with a single cpu online"
> +	exit_unresolved
> +fi
> +
> +echo 0 > tracing_on
> +echo > trace
> +
> +: "Set $(basename $cpu) offline/online with function tracer enabled"
> +echo function > current_tracer
> +echo 1 > tracing_on
> +(echo 0 > $cpu/online)
> +(echo "forked"; sleep 1)
> +(echo 1 > $cpu/online)
> +echo 0 > tracing_on
> +echo nop > current_tracer
> 
> base-commit: 130a83879954a9fed35cf4474d223b4fcfd479fa


