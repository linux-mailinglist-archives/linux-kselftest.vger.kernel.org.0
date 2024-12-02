Return-Path: <linux-kselftest+bounces-22711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38009E0D88
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 22:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D11B62413
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F81DE88B;
	Mon,  2 Dec 2024 19:40:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0B1D958E;
	Mon,  2 Dec 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168410; cv=none; b=JopgF1+XZcb3S+v91X0d1E+oKJ0BRbRRZAjVRH1DT7A1iJNwLF5oYFbphragqvSH20bFmBB7Gy14YWdvKQgtMTaEipmystyQDlKXhys4P1OHi9WWXOAcE3xrzOT5bumakUh8n9VNH/bGeeoPdHV/7zPaFcjvsX613g8fzmTxU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168410; c=relaxed/simple;
	bh=OOK/WfhNM0AtvM+0AZ8458URWsZaHBkXQkZQNouT4gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liFKcqFfVYRgYKTxg2WqcSTxiBVH1/LJpMPEc/Z03I3Kf7hIOxBUgPX3qRKHaVT9FKRvWSKyE1/8FABCOzuuA18cibc997Kv35b3XwVh1HfqKV+VfFQH1wc36bmBACIQGGA7VXq0jLTn+Qtw7E61rsJ6bcqyxsoMFQpQTRAcdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E62EC4CED1;
	Mon,  2 Dec 2024 19:40:07 +0000 (UTC)
Date: Mon, 2 Dec 2024 14:41:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "Naveen N. Rao"
 <naveen@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: adjust offset for kprobe syntax
 error test
Message-ID: <20241202144111.75d1bb3b@gandalf.local.home>
In-Reply-To: <20241129202621.721159-1-hbathini@linux.ibm.com>
References: <20241129202621.721159-1-hbathini@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 01:56:21 +0530
Hari Bathini <hbathini@linux.ibm.com> wrote:

> In 'NOFENTRY_ARGS' test case for syntax check, any offset X of
> `vfs_read+X` except function entry offset (0) fits the criterion,
> even if that offset is not at instruction boundary, as the parser
> comes before probing. But with "ENDBR64" instruction on x86, offset
> 4 is treated as function entry. So, X can't be 4 as well. Thus, 8
> was used as offset for the test case. On 64-bit powerpc though, any
> offset <= 16 can be considered function entry depending on build
> configuration (see arch_kprobe_on_func_entry() for implementation
> details). So, use `vfs_read+20` to accommodate that scenario too.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Can you take this through your tree?

Thanks,

-- Steve

> ---
> 
> Changes in v2:
> * Use 20 as offset for all arches.
> 
> 
>  .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index a16c6a6f6055..8f1c58f0c239 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -111,7 +111,7 @@ check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
>  if !grep -q 'kernel return probes support:' README; then
>  check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
>  fi
> -check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
> +check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
>  check_error 'p vfs_read ^hoge'			# NO_BTFARG
>  check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
>  check_error 'r kfree ^$retval'			# NO_RETVAL


