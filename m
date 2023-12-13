Return-Path: <linux-kselftest+bounces-1772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC68106CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BBD2821B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287219C;
	Wed, 13 Dec 2023 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj1K/lmw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27403A31
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 00:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A1C433C7;
	Wed, 13 Dec 2023 00:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702428042;
	bh=yaOwyRdIE6NOk7geX4K1Pt2wgBpMW9U+4MntbxQURCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yj1K/lmw3/ETwXTyAQSKFVJX2kJMUqhNhBGdxKl6cdMPT2LkbWQBAFima855XXjIU
	 F8XcRe+llUb+ob2bgnSv/EQps95hU5ddAvcJSL+XdKJDtbutXD3utC80d6xkVGn77m
	 xFgIv49utMavdx0BC6nvK7KyrtpqPP7Q78/ifBWh0e9Xh5kG62w0WGYsjHMTXIKtSL
	 UQAiYUJdUPaGlXDDgtVLCU1GxBJn1x5rAZvQq54PBUxnN4xOy2XUDxQmUA5FAQrKuy
	 XoHoJ8gd+zYnbEi9RIQ71imytOLyKR/hKF1n4E/l+8S6sKzdMaKto4bPUN4IrSsxQf
	 n4YuThzp87x1Q==
Date: Wed, 13 Dec 2023 09:40:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/ftrace: Add test to exercize function tracer
 across cpu hotplug
Message-Id: <20231213094038.6c9518a2042b84c8388ec6ae@kernel.org>
In-Reply-To: <20231212085607.1213210-1-naveen@kernel.org>
References: <20231212085607.1213210-1-naveen@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Naveen,

On Tue, 12 Dec 2023 14:26:07 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Add a test to exercize cpu hotplug with the function tracer active to
> ensure that sensitive functions in idle path are excluded from being
> traced. This helps catch issues such as the one fixed by commit
> 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> 
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  .../ftrace/test.d/ftrace/func_hotplug.tc      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> new file mode 100644
> index 000000000000..49731a2b5c23
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
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
> +  echo "We can not test cpu hotplug in UP environment"
> +  exit_unresolved
> +fi

This looks good, but can you find the 2nd online CPU before
this test?
I mean, there is a case that cpu1 is already offlined and others
like cpu2 is onlined. So we need to use the 2nd online cpu.

Thank you,

> +
> +echo 0 > tracing_on
> +echo > trace
> +: "Set CPU1 offline/online with function tracer enabled"
> +echo function > current_tracer
> +echo 1 > tracing_on
> +(echo 0 > /sys/devices/system/cpu/cpu1/online)
> +(echo "forked"; sleep 1)
> +(echo 1 > /sys/devices/system/cpu/cpu1/online)
> +echo 0 > tracing_on
> +
> +: "Check CPU1 events are recorded"
> +grep -q -e "\[001\]" trace
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

