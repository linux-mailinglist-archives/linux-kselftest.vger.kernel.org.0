Return-Path: <linux-kselftest+bounces-45276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DBFC49BB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 00:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B601882DAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B532302158;
	Mon, 10 Nov 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd+O2xi3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC92BE7B8;
	Mon, 10 Nov 2025 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816977; cv=none; b=COTkaXlFR2pUz3dbmJkz4T9Pr4T/JH6i/FSjDY4ZxBOih6CGg4WEQYXcJDGw2HeYHDYX9dzTQEQqiuwQbyE3AYhmtL0fFn/nq5gEP9HKaD1Itx5XTv50fHQMCW4v2VB0YTXNAWfheLW4djMxaTY9JQO57wtoGuPfkMy4pLShiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816977; c=relaxed/simple;
	bh=QGYurX67GhE6LJ4m/le6ChiewTr24IY3HUNN+0ZWht4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AAkadJNPMjoEUL8qWI+J6iBTnK8UWrmDKRCGu7+SdW4yb33sktD5HSL6qyISxhBuD4EP4ofGl2XqWl1Usd7Ge1rn1urQehG5HrnT6EncXHW0lRw+kf1DZ5eJ/4+Kwk/kO9APq0Xm9+SUhKqG8W9PcshkTIdXCJ+RWJZrzlBV9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd+O2xi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597A0C4CEFB;
	Mon, 10 Nov 2025 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762816976;
	bh=QGYurX67GhE6LJ4m/le6ChiewTr24IY3HUNN+0ZWht4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qd+O2xi3mC33ydo3Nrk2NFszrdqEdSKFTyqsYZ2F3KMDF09vK0wITKmUNXG2wYui+
	 wJ02C1xG9NOdrf1UzyNGY9+GEzIun8HKNqGilIJweqrG7AE7TsRgPHjU7BqSt4WGhx
	 ufX/mVqIYIFPFgfzAOGoYSzWlOnwOUyoX95WUib9JeooG11s4ZDkXO9NhmIEmQRL0z
	 Hb815eW9WurD9/p+yCnuwE5Wz7BQpQn/yjmotbGvRKB/f8dvXpKTVfNDdfK6awwdtT
	 zm6fWZiXfV6uTQk9/K8sshx2cBC5+LyGkBP+TYXMl7OxUuZZsWV2W1ag4vT4V2mZae
	 gZz3rVLyZ/zZA==
Date: Tue, 11 Nov 2025 08:22:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/tracing: Run sample events to clear page
 cache events
Message-Id: <20251111082251.2496db7c20b28184cd8cb759@kernel.org>
In-Reply-To: <20251028122724.4bff9853@gandalf.local.home>
References: <20251028122724.4bff9853@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 12:27:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The tracing selftest "event-filter-function.tc" was failing because it
> first runs the "sample_events" function that triggers the kmem_cache_free
> event and it looks at what function was used during a call to "ls".
> 
> But the first time it calls this, it could trigger events that are used to
> pull pages into the page cache.
> 
> The rest of the test uses the function it finds during that call to see if
> it will be called in subsequent "sample_events" calls. But if there's no
> need to pull pages into the page cache, it will not trigger that function
> and the test will fail.
> 
> Call the "sample_events" twice to trigger all the page cache work before
> it calls it to find a function to use in subsequent checks.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Fixes: eb50d0f250e96 ("selftests/ftrace: Choose target function for filter test from samples")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../selftests/ftrace/test.d/filter/event-filter-function.tc   | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> index c62165fabd0c..003f612f57b0 100644
> --- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> +++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> @@ -20,6 +20,10 @@ sample_events() {
>  echo 0 > tracing_on
>  echo 0 > events/enable
>  
> +# Clear functions caused by page cache; run sample_events twice
> +sample_events
> +sample_events
> +
>  echo "Get the most frequently calling function"
>  echo > trace
>  sample_events
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

