Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E891C851B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGIuy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 04:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEGIuy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 04:50:54 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76E22073A;
        Thu,  7 May 2020 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588841453;
        bh=7tsWrxdXE3Dkf/fRBkaSA0xfL/Hwp6Oa4BnHtxcuWks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nZhEtho9UjJNo8bQxizkOOO+O9zeVSGktCMqk+19AhjJUTtwfcATxW0dFG8I6857L
         olRw6AFGAq6YbT3cvWWcpKD9opAPHTHiL+OijKC1PjiqKuWnvvMQ/w7AOELG4EwP0b
         EKiKBcYjALAeMbn+ziHUh3OYnTBw+d6xNZw9OoEQ=
Date:   Thu, 7 May 2020 17:50:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, joel@joelfernandes.org
Subject: Re: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as
 unresolved if the test module does not exist
Message-Id: <20200507175049.fba9420a538e6d81a7b48d60@kernel.org>
In-Reply-To: <20200505101445.27063-1-po-hsu.lin@canonical.com>
References: <20200505101445.27063-1-po-hsu.lin@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue,  5 May 2020 18:14:45 +0800
Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> The UNRESOLVED state is much more apporiate than the UNSUPPORTED state
> for the absence of the test module, as it matches "test was set up
> incorrectly" situation in the README file.
> 
> A possible scenario is that the function was enabled (supported by the
> kernel) but the module was not installed properly, in this case we
> cannot call this as UNSUPPORTED.
> 
> This change also make it consistent with other module-related tests
> in ftrace.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  .../testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> index cbd1743..2b82c80e 100644
> --- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> @@ -17,7 +17,14 @@ unsup() { #msg
>      exit_unsupported
>  }
>  
> -modprobe $MOD || unsup "$MOD module not available"
> +unres() { #msg
> +    reset_tracer
> +    rmmod $MOD || true
> +    echo $1
> +    exit_unresolved
> +}
> +
> +modprobe $MOD || unres "$MOD module not available"
>  rmmod $MOD
>  
>  grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
> -- 
> 2.7.4


-- 
Masami Hiramatsu <mhiramat@kernel.org>
