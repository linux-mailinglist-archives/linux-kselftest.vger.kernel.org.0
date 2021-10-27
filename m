Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A343D622
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 23:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJ0WBU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 18:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhJ0WBT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 18:01:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F01A3610A6;
        Wed, 27 Oct 2021 21:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635371934;
        bh=R8YhZO5s1uz5ekNzWYz3BaLvSkHoIbKUHbDXl3Jhvwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m25vswBwUn9xA7vOoqQN3oL5TwZz4VDAvswlOUoiw1Ssx5b44Me+jdaZfdpoP8V8f
         9sLi0dML9i3lDn68cwc62Z3fHin5Cmfqe2mP7gMDQ2SlryyZWsxoRDNeoIGe9RdqfH
         iZ9MS76NQsiOk5PB0c5g1Kyk9hA6wJzvxoaIWeuW8zTIo3r5u5AI6p1ct31XaX57Z0
         eMXLcMXnGF4b1FhFFMWMN7gg4ElbgZIPJ/zmq0+nZmcEN79PyfQnySTOYiSfV3JBFC
         7wipp0cJjjDnrnL+6q5to7nTXAK8qMhi1CIx+e9wvqcW969yDcSnhxI6uoEMpeDg1Y
         CVIWguIXjuOxQ==
Date:   Thu, 28 Oct 2021 06:58:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
Message-Id: <20211028065849.76b1bd7151e440881298b523@kernel.org>
In-Reply-To: <20211027205919.1648553-3-kaleshsingh@google.com>
References: <20211027205919.1648553-1-kaleshsingh@google.com>
        <20211027205919.1648553-3-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kalesh,

On Wed, 27 Oct 2021 13:59:09 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> If an event trigger references a variable defined in another trigger, it
> has to be removed before the trigger that defines the variable is
> removed.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  tools/testing/selftests/ftrace/test.d/functions | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 000fd05e84b1..bd9e85f4d626 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -22,6 +22,15 @@ reset_trigger_file() {
>  	file=`echo $line | cut -f1 -d:`
>  	echo "!$cmd" >> $file
>      done
> +
> +    # remove triggers with references next
> +    grep -H '\$' $@ |
> +    while read line; do
> +        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> +	file=`echo $line | cut -f1 -d:`
> +	echo "!$cmd" >> $file
> +    done
> +

Why don't you use 'tac'? I love that idea :)
Did you find any issue?

I think the function which cleaning up the tracing file should use
the 'tac' rollback method, because it is natural, simple and robust.
Then the first loop for removing action triggers is not needed anymore.

Thank you,

>      grep -Hv ^# $@ |
>      while read line; do
>          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
