Return-Path: <linux-kselftest+bounces-45265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8EC497E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814073A6FA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9662FC89F;
	Mon, 10 Nov 2025 22:14:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747A242D60;
	Mon, 10 Nov 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812869; cv=none; b=REnYhJC8u9bMMk4m/VdNeN45d41pIo4TldJ2CuTCvsusNX1ps3zFmyB1GsXj/GKXfRatkoXoW6jvfdEO5XbkAkxqIjVxPLGDo5XkFuEvGQGuyT58mfk5UrAKZvvTOd5GLNnHykd+Wi8UMAJ5VqgU/InptZHEddQbpQzKV44kV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812869; c=relaxed/simple;
	bh=xoN2f12F7lMo5nquM1UZ9zuULuDISpE8mgaUqIKx2LM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bf1gQREcxMfrGiyctO6CAR1J3NyUJQXHfWslnYSHL0eCUgZESiMuOnf9TnU+BIrOjX/lmRq8hd1x7qPBdhuMsrZrAloZ+BBC4iA6qiJJyoAywk94DJGSNceLRd5TpiJLJ+9EjZOWLYjnhiqS40Ma4q3gfbl3c5DFHGF7cTbCetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 11B5813A146;
	Mon, 10 Nov 2025 22:14:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 2B83F17;
	Mon, 10 Nov 2025 22:14:23 +0000 (UTC)
Date: Mon, 10 Nov 2025 17:14:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/tracing: Run sample events to clear page
 cache events
Message-ID: <20251110171432.51364be9@gandalf.local.home>
In-Reply-To: <20251028122724.4bff9853@gandalf.local.home>
References: <20251028122724.4bff9853@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2B83F17
X-Stat-Signature: uif9ua8gfmcta616f6icwim19mhjy1tw
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX192kGLJrSGHXaTYd8apAVWEWpEz1+3ctM8=
X-HE-Tag: 1762812863-857667
X-HE-Meta: U2FsdGVkX18SNsLdTYesE/xi5ixyXD0eP+XHsX2vjk0o2uPGNRnvdyDrRcTd2NjKbjKgJdOCwY5GaANwSkjk3TEaQjL/Nf+rPaPXSJmAJ9OSzJbrm8oRGtQp4g6xJr5JWHwN+I3BOMtrB8hPRT80ab0pdhakAM+oNE575uxLrX34TGM3LoD8bC4ad7tRpFlZDnVtg9jXPzWgO47YVqS8PeIgupGVJo+rO0GHVE8k66gb1AZ0Z6GItu3tnpz+xIQJpkRTnd6oCc7BfUr5v7QRfJSttSSmqTmn61IUAwnDwt7if1Eii174KOLQdTpfLIbHScBfZ74E569hS2VmvrzhtBRsxR5T62zCKU4se6BkDi7FZgQ6StoyAqhJSEj+XmGf8uQpKIdfqkLQmz2dhCp33w==


Shuah,

Can you take this through your urgent branch?

-- Steve


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


