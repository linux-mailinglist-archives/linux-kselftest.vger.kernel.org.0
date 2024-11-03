Return-Path: <linux-kselftest+bounces-21346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB79BA402
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 05:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D552B212BD
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E712BEBB;
	Sun,  3 Nov 2024 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbJvURL9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7B70812;
	Sun,  3 Nov 2024 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609882; cv=none; b=PJMpCb11eIaruRzxEOyug2RmeVV2cr2yrlQpklWo/Biu6+Dp6KBJuK9SHUQzuygIRPqsCg5pheNqi18KmyZw7kQYnpukxPiCVxD6vGg7ipDYalcrkgx8w4+2pYV8hPXGNerP/e0D95kyEVdopcwk2mxV2PbdQLHgOUrVU88VnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609882; c=relaxed/simple;
	bh=0tNRT0xSX7XmwNmCgdyMhAikThf/p4Wje8UYd8Iov6M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jGStnaqEKVN5Z8zN/xHB46yeRH/tWFJHH1Noq2xBMwzkQ69ghoDkTUCOpsNdqL4dClYIUAZuQG8DB0hHP7smRoGwHMK7EtZ491VEBt2IERchFyu8+7qncfRUgSb83xsLY4VqxX/80cIX/Sseoe1minfR/V3us8q8zmic7oycSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbJvURL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651A2C4CECD;
	Sun,  3 Nov 2024 04:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730609882;
	bh=0tNRT0xSX7XmwNmCgdyMhAikThf/p4Wje8UYd8Iov6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hbJvURL9eRPIU/g6T+sEX6cu3/Dyz7PJDR7coQCxz43K21RWvdqsaRUcphAQZORl2
	 lc9iBejRtHGX98dTNtGBHSn3FEfCnn9hbwSzBY0DoBTTBmveSR1wRMEfWjPMWtYRLo
	 uRlnuS5DjaU1k9Bs3WnHyXzjIMvepaTZygovC70cxHYfvAnJ8vm79BCnJe5ayaJQJn
	 p8QIjT+73h7qQddW8Ysi/NLk2SOg+h8Ml08beoP5MzOU5DJQX18y6QeARV6fjG4DQl
	 uXl9QyPzsC4fadu2wArDrz2uPr5/UB7BI9aFOIlqBq4NngzYmUwKjAY6YgfhEyRoN8
	 p3RND3mWwDvIA==
Date: Sun, 3 Nov 2024 13:57:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, "Naveen N. Rao" <naveen@kernel.org>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for
 ppc64le
Message-Id: <20241103135758.5a5f8f0870a139ab1a5bc7b8@kernel.org>
In-Reply-To: <20241101191925.1550493-1-hbathini@linux.ibm.com>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 00:49:25 +0530
Hari Bathini <hbathini@linux.ibm.com> wrote:

> For ppc64le, depending on the kernel configuration used, offset 16
> from function start address can also be considered function entry.
> Update the test case to accommodate such configurations.
> 

Hi Hari, so have you met any error on this test case?
Can you share the error result too?

Thank you,

> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc    | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index a16c6a6f6055..c03b94cc5784 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -111,7 +111,11 @@ check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
>  if !grep -q 'kernel return probes support:' README; then
>  check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
>  fi
> +if [ "$(uname -m)" = "ppc64le" ]; then
> +check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
> +else
>  check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
> +fi
>  check_error 'p vfs_read ^hoge'			# NO_BTFARG
>  check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
>  check_error 'r kfree ^$retval'			# NO_RETVAL
> -- 
> 2.47.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

