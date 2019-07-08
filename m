Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3283628C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2019 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfGHS4V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Jul 2019 14:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbfGHS4V (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Jul 2019 14:56:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BD621707;
        Mon,  8 Jul 2019 18:56:20 +0000 (UTC)
Date:   Mon, 8 Jul 2019 14:56:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH] selftests/ftrace: avoid failure when trying to probe a
 notrace function
Message-ID: <20190708145618.6649f397@gandalf.local.home>
In-Reply-To: <20190708181933.10286-1-cascardo@canonical.com>
References: <20190708181933.10286-1-cascardo@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon,  8 Jul 2019 15:19:33 -0300
Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:

> Check that the function is on available_filter_functions. If it's not,
> mark the test as unresolved, instead of failing it.
> 

Actually, I sent this out a while ago:

  http://lkml.kernel.org/r/20190322150923.1b58eca5@gandalf.local.home

Does that fix it for you?

-- Steve


> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> index 3fb70e01b1fe..e4dff034da12 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> @@ -26,6 +26,7 @@ test -d events/kprobes2/event2 || exit_failure
>  
>  FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
>  [ "x" != "x$FUNC" ] || exit_unresolved
> +grep -n "$FUNC" available_filter_functions || exit_unresolved
>  echo "p $FUNC" > kprobe_events
>  EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`
>  [ "x" != "x$EVENT" ] || exit_failure

