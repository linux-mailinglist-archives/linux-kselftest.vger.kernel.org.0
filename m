Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963A62813BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJBNIB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 09:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBNIB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 09:08:01 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B1720708;
        Fri,  2 Oct 2020 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601644080;
        bh=tGcvLaxrqDDCepQoPpCJ+QRbLhGUg0YgG7YGHIaSBKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mjHGrQqp0vtUW2aU5vruBq1KCn6u2uX/cyAImLc/BX5abSGSWVW+Rkdo98+vvwo2M
         emrBabeZFa5sWFJnNvdm4EPpvwzXVfQ6wz1xFgZM5PBrqvcZShnv3FKpCvX/peNqUM
         ebNeIxc7z8oJf7W3UeaFD5ukB0DtbUGIUaKZ6Gek=
Date:   Fri, 2 Oct 2020 22:07:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: check for do_sys_openat2 in
 user-memory test
Message-Id: <20201002220756.b62653d1e6aba102521054d2@kernel.org>
In-Reply-To: <20201001085641.51130-1-colin.king@canonical.com>
References: <20201001085641.51130-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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

OK, at first, you need to check the kernel has do_sys_openat2 from
/proc/kallsyms (grep -qw will help you), because it is new syscall.

> +echo 'p:myevent2 do_sys_openat2 path=+0($arg2):ustring path2=+u0($arg2):string' \
> +	> kprobe_events

Also, you need to append (">>") it instead overwrite (">") to kprobe_events.

>  
>  grep myevent kprobe_events | \
>  	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'

And also you have to enable both myevent and myevent2 (if exists) after
this.

Then I think your patch will work correctly.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
