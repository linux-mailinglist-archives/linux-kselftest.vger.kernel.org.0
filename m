Return-Path: <linux-kselftest+bounces-13943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10E937B65
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AE4282C13
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69A1465A1;
	Fri, 19 Jul 2024 16:59:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0DF146596;
	Fri, 19 Jul 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408370; cv=none; b=r9BdAl9bdTkaNOm0/L0vfKX4KrGoUZUFYrTLAIng3tXh97pwdZmCmNVdQxuVRw0L/6CmwkvR22zsDFbpwjv4H8zRMZfP/mbzCfqgINzO4gZFRUZDEdd1oNelbpz3LaJeZMFToKFlLwJtlYuqqDleWQIYHvLWXEBL29LbrHnBSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408370; c=relaxed/simple;
	bh=wAhJmP7ZmUfcMiFpSGn3FA46uqGnYG23Pd/99obtHQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiTHTAChcmI5TsgFqDtxM6i6HtJO7SOxyLw6vjmDDlm3icrV7Ugh/KjU6NeFhlDKb8UNaqmyVRWNY2EIXt5HCC0N/pMgAIFc5ZMxqQpLx4b2kDM/YvUhS5RBXNZx13bgxQiCuJaSj+BbRFDMmbv0kJ35LiGIxW/fuTR7OW8zRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280B4C32782;
	Fri, 19 Jul 2024 16:59:29 +0000 (UTC)
Date: Fri, 19 Jul 2024 12:59:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Akanksha J N <akanksha@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, naveen@kernel.org
Subject: Re: [PATCH v1] selftests/ftrace: Skip test for optimized probes on
 PowerPC if Secure Boot is enabled
Message-ID: <20240719125927.515526df@rorschach.local.home>
In-Reply-To: <20240716112651.11345-1-akanksha@linux.ibm.com>
References: <20240716112651.11345-1-akanksha@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 16:56:51 +0530
Akanksha J N <akanksha@linux.ibm.com> wrote:

> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> index 9f5d99328086..87e2f81e46b8 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> @@ -10,6 +10,11 @@ x86_64)
>  arm*)
>  ;;
>  ppc*)
> +lsprop_output=$(lsprop /proc/device-tree/ibm,secure-boot)
> +if echo "$lsprop_output" | grep -q "00000002"; then
> +	echo "Secure Boot is enabled on PowerPC."
> +	exit_unsupported
> +fi

Nit, but the above should be indented.

-- Steve

>  ;;
>  *)
>    echo "Please implement other architecture here"

