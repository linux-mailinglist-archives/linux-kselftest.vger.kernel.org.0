Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33D3F2410
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 02:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhHTAOI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 20:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237041AbhHTAOF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 20:14:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA5F260F91;
        Fri, 20 Aug 2021 00:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629418408;
        bh=pus9MR59eH5Mwd9j2e5l5ukoPbXa+kXHBqMWOtX26p4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KfwQkwwTgpXDt89tUKWxttTRsteuL+MJcvOLIOSXUzfq+zSc3NHof8dzi4NNtnbWo
         aXu72iugQlWiW6vb7sLJ8JQ4Ix7++yjOvfIJE9Esnrxja37zFGLu7+InzV3YCob9mD
         BuSI6gp6xppjdKrZKaO/3oPbkI+0GNPzvfdAA7OO8o/hhDgCVmb+aLJ5zfYOfUaRLq
         Q6aeRIbM5Qs//YjiZ7Ue9qQBRM0NnLjgBXDLPP3Odo/LfVDNpeeiiPeRdp9h4nN1ri
         EEXrfCRrjp0yJmj//YaUcq+9KWKzvS+RkCkngTfadWi5BGiWbHj2tPYaVD9xgMqjvy
         f6MHvE/G63CtQ==
Date:   Fri, 20 Aug 2021 09:13:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 3/5] selftests/ftrace: Add clear_dynamic_events() to
 test cases
Message-Id: <20210820091325.d5eab4b2c24562f67ab1e205@kernel.org>
In-Reply-To: <20210819152825.348941368@goodmis.org>
References: <20210819152604.704335282@goodmis.org>
        <20210819152825.348941368@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Aug 2021 11:26:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a function to remove all dynamic events from the tracing directory. It
> requires a loop as some of the dynamic events may depend on others being
> removed first. Also add a safety that prevents it from looping infinitely
> due to a bug where an event never gets removed.
> 
> Link: https://lkml.kernel.org/r/20210819041842.696873153@goodmis.org
> 

Thank you for adding this useful function!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../testing/selftests/ftrace/test.d/functions | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index a6fac927ee82..f68d336b961b 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -83,6 +83,27 @@ clear_synthetic_events() { # reset all current synthetic events
>      done
>  }
>  
> +clear_dynamic_events() { # reset all current dynamic events
> +    again=1
> +    stop=1
> +    # loop mulitple times as some events require other to be removed first
> +    while [ $again -eq 1 ]; do
> +	stop=$((stop+1))
> +	# Prevent infinite loops
> +	if [ $stop -gt 10 ]; then
> +	    break;
> +	fi
> +	again=2
> +	grep -v '^#' dynamic_events|
> +	while read line; do
> +	    del=`echo $line | sed -e 's/^.\([^ ]*\).*/-\1/'`
> +	    if ! echo "$del" >> dynamic_events; then
> +		again=1
> +	    fi
> +	done
> +    done
> +}
> +
>  initialize_ftrace() { # Reset ftrace to initial-state
>  # As the initial state, ftrace will be set to nop tracer,
>  # no events, no triggers, no filters, no function filters,
> @@ -93,6 +114,7 @@ initialize_ftrace() { # Reset ftrace to initial-state
>      reset_events_filter
>      reset_ftrace_filter
>      disable_events
> +    clear_dynamic_events
>      [ -f set_event_pid ] && echo > set_event_pid
>      [ -f set_ftrace_pid ] && echo > set_ftrace_pid
>      [ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
> -- 
> 2.30.2


-- 
Masami Hiramatsu <mhiramat@kernel.org>
