Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB13109046
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 15:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfKYOos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 09:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfKYOor (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 09:44:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73D3207FD;
        Mon, 25 Nov 2019 14:44:46 +0000 (UTC)
Date:   Mon, 25 Nov 2019 09:44:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v3 1/4] selftests/ftrace: Fix to check the
 existence of set_ftrace_filter
Message-ID: <20191125094445.03d0c8df@gandalf.local.home>
In-Reply-To: <157466502067.21973.8795718044691377192.stgit@devnote2>
References: <157466501169.21973.31401747181477687.stgit@devnote2>
        <157466502067.21973.8795718044691377192.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Nov 2019 15:57:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> If we run ftracetest on the kernel with CONFIG_DYNAMIC_FTRACE=n,
> there is no set_ftrace_filter and all test cases are failed,
> because reset_ftrace_filter returns an error.
> Let's check whether set_ftrace_filter exists and remove redundant
> set_ftrace_filter from initialize_ftrace().
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/ftrace/test.d/functions |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 86986c4bba54..19d288cdf336 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -46,6 +46,9 @@ reset_events_filter() { # reset all current setting filters
>  }
>  
>  reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
> +    if [ ! -f set_ftrace_filter ]; then
> +      return 0
> +    fi
>      echo > set_ftrace_filter
>      grep -v '^#' set_ftrace_filter | while read t; do
>  	tr=`echo $t | cut -d: -f2`
> @@ -93,7 +96,6 @@ initialize_ftrace() { # Reset ftrace to initial-state
>      disable_events
>      [ -f set_event_pid ] && echo > set_event_pid
>      [ -f set_ftrace_pid ] && echo > set_ftrace_pid
> -    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*

The above should be changed to:

	[ -f set_ftrace_notrace ] && echo > set_ftrace_notrace

-- Steve


>      [ -f set_graph_function ] && echo | tee set_graph_*
>      [ -f stack_trace_filter ] && echo > stack_trace_filter
>      [ -f kprobe_events ] && echo > kprobe_events

