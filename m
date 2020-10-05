Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C032283810
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Oct 2020 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJEOmT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Oct 2020 10:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgJEOmT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Oct 2020 10:42:19 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7881220776;
        Mon,  5 Oct 2020 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601908938;
        bh=E9QRahG5qVN86wh0nx6wPp1I9VVDPz2mLmZBzbC75nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b6LniL6SfP5Rnm5pnC9FhBJ3ge5zyWNuiaJUl+E7C+qT7Hjrm9JX/u7TY7qdILMEZ
         NR+zw4PHDFA0ys83ToDtvSVVArDKSTZKVWiAt+s1MFlkw01RektVWRXFW+dVuBtC2M
         vympOS8yEhpHcgQT5uyzhWs9ndHQs54/Oq0XI9nA=
Date:   Mon, 5 Oct 2020 23:42:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] selftests/ftrace: check for do_sys_openat2 in
 user-memory test
Message-Id: <20201005234213.c8950c218bf9b4629a520e4c@kernel.org>
In-Reply-To: <20201002132501.88992-1-colin.king@canonical.com>
References: <20201002132501.88992-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Fri,  2 Oct 2020 14:25:01 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> More recent libc implementations are now using openat/openat2 system
> calls so also add do_sys_openat2 to the tracing so that the test
> passes on these systems because do_sys_open may not be called.
> 
> Thanks to Masami Hiramatsu for the help on getting this fix to work
> correctly.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

OK, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
> 
> V2: write myevent2 using >> rather than >, also enable and disable
>     myevent2
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_user.tc        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> index a30a9c07290d..d25d01a19778 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> @@ -9,12 +9,16 @@ grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
>  :;: "user-memory access syntax and ustring working on user memory";:
>  echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
>  	> kprobe_events
> +echo 'p:myevent2 do_sys_openat2 path=+0($arg2):ustring path2=+u0($arg2):string' \
> +	>> kprobe_events
>  
>  grep myevent kprobe_events | \
>  	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
>  echo 1 > events/kprobes/myevent/enable
> +echo 1 > events/kprobes/myevent2/enable
>  echo > /dev/null
>  echo 0 > events/kprobes/myevent/enable
> +echo 0 > events/kprobes/myevent2/enable
>  
>  grep myevent trace | grep -q 'path="/dev/null" path2="/dev/null"'
>  
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
