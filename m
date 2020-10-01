Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12477280187
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgJAOov (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 10:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbgJAOov (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 10:44:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E878420780;
        Thu,  1 Oct 2020 14:44:49 +0000 (UTC)
Date:   Thu, 1 Oct 2020 10:44:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: check for do_sys_openat2 in
 user-memory test
Message-ID: <20201001104448.427a0eaa@gandalf.local.home>
In-Reply-To: <20201001085641.51130-1-colin.king@canonical.com>
References: <20201001085641.51130-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  1 Oct 2020 09:56:41 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> More recent libc implementations are now using openat/openat2 system
> calls so also add do_sys_openat2 to the tracing so that the test
> passes on these systems because do_sys_open may not be called.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc  | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> index a30a9c07290d..cf1b4c3e9e6b 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> @@ -9,6 +9,8 @@ grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
>  :;: "user-memory access syntax and ustring working on user memory";:
>  echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
>  	> kprobe_events  
> +echo 'p:myevent2 do_sys_openat2 path=+0($arg2):ustring path2=+u0($arg2):string' \
> +	> kprobe_events
> 

This still wont work, because the rest of the code only enables the myevent
event, and not the one you just added.

Did you see this broken before, and this patch fixes it?

-- Steve

 
>  grep myevent kprobe_events | \
>  	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'

