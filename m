Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED442CDAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Oct 2021 00:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJMWSh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 18:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhJMWSg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 18:18:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836A561163;
        Wed, 13 Oct 2021 22:16:32 +0000 (UTC)
Date:   Wed, 13 Oct 2021 18:16:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Stop tracing before searching
 non-exist event entry
Message-ID: <20211013181630.13a4848a@gandalf.local.home>
In-Reply-To: <163278786632.187921.7275187717663096458.stgit@devnote2>
References: <163278786632.187921.7275187717663096458.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 28 Sep 2021 09:11:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

I'm finally getting through my queue to see this.

> Stop tracing before searching the pattern which is expected to
> not exist on the trace buffer. In some case, it will take too
> long and may not come back eternally because while searching
> the tracing data will be increased by the searching activity.
> 
> I found this with enabling kernel debug options, like kmemleak,
> lockdep etc. and run it on qemu with 2 CPUs. It did not come
> back in 20 minutes and finally I need to interrupt it to stop.

One other option is to bring back the old behavior:

  echo 1 > options/pause-on-trace

Which will stop tracing as the trace file is read.

But either way works for me.

-- Steve

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/ftrace/func_profiler.tc          |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
> index 1dbd766c0cd2..440f4d87aa4b 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
> @@ -56,6 +56,9 @@ clear_trace
>  sleep 1
>  
>  echo "make sure something other than scheduler is being traced"
> +
> +echo 0 > tracing_on
> +
>  if ! grep -v -e '^#' -e 'schedule' trace > /dev/null; then
>  	cat trace
>  	fail "no other functions besides schedule was found"

