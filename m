Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12623B1B7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFWNse (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 09:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhFWNse (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 09:48:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 249C061075;
        Wed, 23 Jun 2021 13:46:16 +0000 (UTC)
Date:   Wed, 23 Jun 2021 09:46:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: fix event-no-pid on 1-core machine
Message-ID: <20210623094614.1aa35179@gandalf.local.home>
In-Reply-To: <20210623134315.77472-1-krzysztof.kozlowski@canonical.com>
References: <20210623134315.77472-1-krzysztof.kozlowski@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

Want to take this in your tree?

-- Steve


On Wed, 23 Jun 2021 15:43:15 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> When running event-no-pid test on small machines (e.g. cloud 1-core
> instance), other events might not happen:
> 
>     + cat trace
>     + cnt=0
>     + [ 0 -eq 0 ]
>     + fail No other events were recorded
>     [15] event tracing - restricts events based on pid notrace filtering [FAIL]
> 
> Schedule a simple sleep task to be sure that some other process events
> get recorded.
> 
> Fixes: ebed9628f5c2 ("selftests/ftrace: Add test to test new set_event_notrace_pid file")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct spelling in commit msg.
> 2. Add Steven's ack.
> ---
>  .../testing/selftests/ftrace/test.d/event/event-no-pid.tc  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
> index e6eb78f0b954..9933ed24f901 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
> @@ -57,6 +57,10 @@ enable_events() {
>      echo 1 > tracing_on
>  }
>  
> +other_task() {
> +    sleep .001 || usleep 1 || sleep 1
> +}
> +
>  echo 0 > options/event-fork
>  
>  do_reset
> @@ -94,6 +98,9 @@ child=$!
>  echo "child = $child"
>  wait $child
>  
> +# Be sure some other events will happen for small systems (e.g. 1 core)
> +other_task
> +
>  echo 0 > tracing_on
>  
>  cnt=`count_pid $mypid`

