Return-Path: <linux-kselftest+bounces-16222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7095E2B8
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 10:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AA21F217B5
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840B861FFC;
	Sun, 25 Aug 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk4ykh0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725E2BCFF;
	Sun, 25 Aug 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724574962; cv=none; b=EJe88WPnh7DW9yWmBImr91N/g7rAtN9Me3Wg4iBcPTzYaxvjEws3N4qp7HP/xVFzSAmLpIo6FzmCWjz0BfPcdZQez2Xg/pOYJPRX+HfZPnF01h4TWzXofUojPssqMDXKSN7MNaWUMW3CGrWX8eH78VOoyglMT/KdPH5b9GnxsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724574962; c=relaxed/simple;
	bh=G649MelgvhgiF9yNphX0fE6Ui08+UQoEP3VGOe9dlR8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U1Ch8ArvfjiSkZXNi+arFGdPnrXg/785gSHjqiTZCN2xjvMud6n8SfH/SsHH0vd1Y8DO+Ltit3lkPrYcw+nx7AoMif6m4WIFE9WC3599SLgLlrFQ+NzqBW1Rg4Y+/Pv2oRGnJb+VnHbkbKnd7rRqxPlEXIYLA9Jt6j5XwJijcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk4ykh0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43BCC32782;
	Sun, 25 Aug 2024 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724574961;
	bh=G649MelgvhgiF9yNphX0fE6Ui08+UQoEP3VGOe9dlR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kk4ykh0rIsn3SNEQmwo+4cOoGPO29OjLGMB0tjDTqzegzdhTpzsO7nJPhY5B+e8Pt
	 86xqDiVOo2eUcrb6+RXFn5ZST7ldYtWX5rdLCYu3/76irIuK36L2A9smZmW1rswopq
	 GVl0ewR+RzlfjAb5C9QpTA/eCQRXhyNUvdW0ePyYJ0TOp0i/dlJC+R3UjXM9DFGXFU
	 0pM0rhDxxZN6xDQpGbqiTVs8z2dYyPoYs/1vHkZDG6a0OPjbkjX/8wtdh4FUp9fVfK
	 Tm9PkpFYZ4HPqKLLxP9vYl61V90RMz7xJVROMP9sJScST2KYyMjXVL50jJgfM7Yp+S
	 97LEiu6P9CL3g==
Date: Sun, 25 Aug 2024 17:35:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Akanksha J N <akanksha@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] selftests/ftrace: Skip test for optimized probes on
 PowerPC if Secure Boot is enabled
Message-Id: <20240825173557.89c64ab5362b0fa78df2f45a@kernel.org>
In-Reply-To: <20240813034056.74717-1-akanksha@linux.ibm.com>
References: <20240813034056.74717-1-akanksha@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 09:10:56 +0530
Akanksha J N <akanksha@linux.ibm.com> wrote:

> Currently while accessing debugfs with Secure Boot enabled on PowerPC,
> it is causing the kprobe_opt_types.tc test to fail. Below is the snippet
> of the error:
> 
> +++ grep kernel_clone /sys/kernel/debug/kprobes/list
> grep: /sys/kernel/debug/kprobes/list: Operation not permitted
> ++ PROBE=
> + '[' 2 -ne 0 ']'
> + kill -s 37 7595
> ++ SIG_RESULT=1
> + eval_result 1
> + case $1 in
> + prlog '	[\033[31mFAIL\033[0m]'
> + newline='\n'
> + '[' '	[\033[31mFAIL\033[0m]' = -n ']'
> + printf '	[\033[31mFAIL\033[0m]\n'
> 	[FAIL]
> 
> This is happening when secure boot is enabled, as it enables lockdown
> by default. With lockdown, access to certain debug features and
> filesystems like debugfs may be restricted or completely disabled.

Hmm, if the kprobes lockdown causes this problem, all tests which use
kprobes must not run. This seems onlu checks kprobe_opt_types.tc, but
what about other tests?

(Anyway, we don't recommend user to run tests in lockdown environment.)

Thank you,

> 
> To fix this, modify the test to check for Secure Boot status using
> lsprop /proc/device-tree/ibm,secure-boot. And, skip execution of the
> test on PowerPC if Secure Boot is enabled (00000002).
> 
> With this patch, test skips as unsupported:
> === Ftrace unit tests ===
> [1] Register/unregister optimized probe	[UNSUPPORTED]
> 
> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> index 9f5d99328086..925e74d6acc7 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> @@ -10,6 +10,11 @@ x86_64)
>  arm*)
>  ;;
>  ppc*)
> +  lsprop_output=$(lsprop /proc/device-tree/ibm,secure-boot)
> +  if echo "$lsprop_output" | grep -q "00000002"; then
> +    echo "Secure Boot is enabled on PowerPC."
> +    exit_unsupported
> +  fi
>  ;;
>  *)
>    echo "Please implement other architecture here"
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

