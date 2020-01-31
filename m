Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD414E794
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 04:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgAaDcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 22:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgAaDcI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 22:32:08 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A520220CC7;
        Fri, 31 Jan 2020 03:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580441527;
        bh=nlYIG3x2hYLjyk1ASRbuQlsc9A45GUN4qZZV7DWMAtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hlv/L6/jv5xdgwQbp30Av/aZpGDktDul8FYVSBD1MnI2rRzD7Ei8eEkVqKM2cbExb
         EugUf+MBwTCFytyN6aEkugdnyI1suZr2OCIb57ksGgLG34vuYAcaulrIroCb8aiSUK
         pPAxSOzpFNAXFyWaCkXZkwxlIm0ZjsF8YwTUi3q0=
Date:   Fri, 31 Jan 2020 12:32:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH][RESEND] selftests/ftrace: Have pid filter test use
 instance flag
Message-Id: <20200131123203.5de85bfa6ccf946934963e86@kernel.org>
In-Reply-To: <20200130214527.1ce9a39e@rorschach.local.home>
References: <20200130214527.1ce9a39e@rorschach.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Jan 2020 21:45:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> While running the ftracetests, the pid filter test failed because the
> instance "foo" existed, and it was using it to rerun the test under a
> instance named foo. The collision caused the test to fail as the mkdir
> failed as the name already existed.
> 
> As of commit b5b77be812de7 ("selftests: ftrace: Allow some tests to be run
> in a tracing instance") all a selftest needs to do to be tested in an
> instance is to set the "instance" flag. There's no reason a selftest needs
> to create an instance to run its test in an instance directly.
> 
> Remove the open coded testing in an instance for the pid filter test and
> have it set the "instance" flag instead.
> 

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../selftests/ftrace/test.d/ftrace/func-filter-pid.tc     | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> index 64cfcc75e3c1..f2ee1e889e13 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> @@ -1,6 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: ftrace - function pid filters
> +# flags: instance
>  
>  # Make sure that function pid matching filter works.
>  # Also test it on an instance directory
> @@ -96,13 +97,6 @@ do_test() {
>  }
>  
>  do_test
> -
> -mkdir instances/foo
> -cd instances/foo
> -do_test
> -cd ../../
> -rmdir instances/foo
> -
>  do_reset
>  
>  exit 0
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
