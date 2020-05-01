Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDDA1C1789
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgEAORW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 10:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbgEAORV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 10:17:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6240620757;
        Fri,  1 May 2020 14:17:20 +0000 (UTC)
Date:   Fri, 1 May 2020 10:17:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 2/3] selftests/ftrace: Pick only the first kprobe event
 to test
Message-ID: <20200501101718.5a15e557@gandalf.local.home>
In-Reply-To: <158834027133.28357.11196486193798517250.stgit@devnote2>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834027133.28357.11196486193798517250.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri,  1 May 2020 22:37:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the kprobe/kprobe_args_type.tc reads out all event logs
> from the trace buffer, the test can fail if there is another
> fork event happens.
> Use head command to pick only the first kprobe event from
> the trace buffer to test the argument types.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> index 1bcb67dcae26..81490ecaaa92 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
>    echo 0 > events/kprobes/testprobe/enable
>  
>    : "Confirm the arguments is recorded in given types correctly"
> -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>    check_types $ARGS $width
>  
>    : "Clear event for next loop"

I think I've manually added this exact change to my tests to keep it from
failing.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
