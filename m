Return-Path: <linux-kselftest+bounces-1824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E58A1811227
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8321F2123E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358572C18F;
	Wed, 13 Dec 2023 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPj3sNYb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996F2C185
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 12:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C24C433C7;
	Wed, 13 Dec 2023 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702472094;
	bh=gBG7q7d6yeZOd/c1kwWuK1qPKa2vW1p2OK1rECWWvTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TPj3sNYbXok2E+B31zh2s3H/L6aacMNCDhzhZ71Mv0L0tL9xoHx0BF8RiDWrUDX03
	 hlY8FULjAeL+T2oGzyMKlDT4jev8KnS9u6o7reCF2OrDJ43yCpPhC7AafRLQPKDCyD
	 6MV6gOMSt+rrcsaLqALumG+QCDlD5QzvmVpCPS4yXxSfg9PAdCwq/HPtjgrUHO24ya
	 NQ48QfEcUntf7KUcpAlpQauJ8OSmkD0AjD8iv8RR6jw9DQV6sXgIfIXVOhSEQuHkTr
	 exSG4xLITkcmc3yddRyStj0rvF/Z2uD+l957iveD/Y1P9leZv0ZKvmfUHGtiP/8SV9
	 flZoF06HLS96A==
Date: Wed, 13 Dec 2023 21:54:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] selftests/ftrace: Add test to exercize function
 tracer across cpu hotplug
Message-Id: <20231213215450.792f5e6f21eb3e709f4ea05c@kernel.org>
In-Reply-To: <20231213113802.1278600-1-naveen@kernel.org>
References: <20231213113802.1278600-1-naveen@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 17:08:02 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Add a test to exercize cpu hotplug with the function tracer active to
> ensure that sensitive functions in idle path are excluded from being
> traced. This helps catch issues such as the one fixed by commit
> 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
> v2: Add a check for next available online cpu, as suggested by Masami.
> 
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
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

