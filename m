Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2C699E74
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Feb 2023 21:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjBPU7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Feb 2023 15:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBPU7A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Feb 2023 15:59:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72434D606;
        Thu, 16 Feb 2023 12:58:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67A53B829AB;
        Thu, 16 Feb 2023 20:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C464CC433EF;
        Thu, 16 Feb 2023 20:58:55 +0000 (UTC)
Date:   Thu, 16 Feb 2023 15:58:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] selftests: use canonical ftrace path
Message-ID: <20230216155854.424bcdd7@rorschach.local.home>
In-Reply-To: <20230215223350.2658616-3-zwisler@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
        <20230215223350.2658616-3-zwisler@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Feb 2023 15:33:46 -0700
Ross Zwisler <zwisler@chromium.org> wrote:

> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> A few spots in tools/testing/selftests still refer to this older debugfs
> path, so let's update them to avoid confusion.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Care to pull this in through your tree?

-- Steve

> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  tools/testing/selftests/user_events/dyn_test.c    |  2 +-
>  tools/testing/selftests/user_events/ftrace_test.c | 10 +++++-----
>  tools/testing/selftests/user_events/perf_test.c   |  8 ++++----
>  tools/testing/selftests/vm/protection_keys.c      |  4 ++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
> index d6265d14cd51..8879a7b04c6a 100644
> --- a/tools/testing/selftests/user_events/dyn_test.c
> +++ b/tools/testing/selftests/user_events/dyn_test.c
> @@ -16,7 +16,7 @@
>  
>  #include "../kselftest_harness.h"
>  
> -const char *dyn_file = "/sys/kernel/debug/tracing/dynamic_events";
> +const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
>  const char *clear = "!u:__test_event";
>  
>  static int Append(const char *value)
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index 404a2713dcae..a0b2c96eb252 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -16,11 +16,11 @@
>  
>  #include "../kselftest_harness.h"
>  
> -const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
> -const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
> -const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/enable";
> -const char *trace_file = "/sys/kernel/debug/tracing/trace";
> -const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
> +const char *data_file = "/sys/kernel/tracing/user_events_data";
> +const char *status_file = "/sys/kernel/tracing/user_events_status";
> +const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
> +const char *trace_file = "/sys/kernel/tracing/trace";
> +const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
>  
>  static inline int status_check(char *status_page, int status_bit)
>  {
> diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
> index 8b4c7879d5a7..31505642aa9b 100644
> --- a/tools/testing/selftests/user_events/perf_test.c
> +++ b/tools/testing/selftests/user_events/perf_test.c
> @@ -18,10 +18,10 @@
>  
>  #include "../kselftest_harness.h"
>  
> -const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
> -const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
> -const char *id_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/id";
> -const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
> +const char *data_file = "/sys/kernel/tracing/user_events_data";
> +const char *status_file = "/sys/kernel/tracing/user_events_status";
> +const char *id_file = "/sys/kernel/tracing/events/user_events/__test_event/id";
> +const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
>  
>  struct event {
>  	__u32 index;
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 95f403a0c46d..0381c34fdd56 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -98,7 +98,7 @@ int tracing_root_ok(void)
>  void tracing_on(void)
>  {
>  #if CONTROL_TRACING > 0
> -#define TRACEDIR "/sys/kernel/debug/tracing"
> +#define TRACEDIR "/sys/kernel/tracing"
>  	char pidstr[32];
>  
>  	if (!tracing_root_ok())
> @@ -124,7 +124,7 @@ void tracing_off(void)
>  #if CONTROL_TRACING > 0
>  	if (!tracing_root_ok())
>  		return;
> -	cat_into_file("0", "/sys/kernel/debug/tracing/tracing_on");
> +	cat_into_file("0", "/sys/kernel/tracing/tracing_on");
>  #endif
>  }
>  

