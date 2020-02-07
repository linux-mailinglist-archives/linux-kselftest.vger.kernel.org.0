Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29A155253
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 07:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgBGGPB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Feb 2020 01:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgBGGPB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Feb 2020 01:15:01 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54ED20838;
        Fri,  7 Feb 2020 06:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581056100;
        bh=O5bESTseaJwW695ZKFFk+TiTTw1SgAcOEDih6D0WyrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iow13TH8wCDDAsNZcUPYJfM8e/ru/+X48I2vSj01yefZjfYaDPFO9KOfhxW1lWGnx
         dtUofyDQsy2yOao27YLnMLzVQFU1rCao/bSi1weelLzfko76+dKPrJB/ErvFLjq/s8
         m3U3LGZlPr8Z7DjLEnc1R5eh/aRWc6Y2n7WagP3A=
Date:   Fri, 7 Feb 2020 15:14:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, colin.king@canonical.com
Subject: Re: [PATCH 1/2] ftrace/selftests: workaround cgroup RT scheduling
 issues
Message-Id: <20200207151456.4177c8974b779a45520b93d7@kernel.org>
In-Reply-To: <1581001760-29831-2-git-send-email-alan.maguire@oracle.com>
References: <1581001760-29831-1-git-send-email-alan.maguire@oracle.com>
        <1581001760-29831-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  6 Feb 2020 15:09:19 +0000
Alan Maguire <alan.maguire@oracle.com> wrote:

> wakeup_rt.tc and wakeup.tc tests in tracers/ subdirectory
> fail due to the chrt command returning:
> 
>  chrt: failed to set pid 0's policy: Operation not permitted.
> 
> To work around this, temporarily disable grout RT scheduling
> during ftracetest execution.  Restore original value on
> test run completion.  With these changes in place, both
> tests consistently pass.

OK, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Fixes: c575dea2c1a5 ("selftests/ftrace: Add wakeup_rt tracer testcase")
> Fixes: c1edd060b413 ("selftests/ftrace: Add wakeup tracer testcase")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 063ecb2..3207bbf 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -29,8 +29,26 @@ err_ret=1
>  # kselftest skip code is 4
>  err_skip=4
>  
> +# cgroup RT scheduling prevents chrt commands from succeeding, which
> +# induces failures in test wakeup tests.  Disable for the duration of
> +# the tests.
> +sched_rt_runtime=$(sysctl -n kernel.sched_rt_runtime_us)

OK, but can you 

> +
> +set_sysctl() {
> +  sysctl -qw ${1}=${2} >/dev/null 2>&1
> +}
> +
> +setup() {
> +  set_sysctl kernel.sched_rt_runtime_us -1
> +}
> +
> +cleanup() {
> +  set_sysctl kernel.sched_rt_runtime_us $sched_rt_runtime
> +}
> +
>  errexit() { # message
>    echo "Error: $1" 1>&2
> +  cleanup
>    exit $err_ret
>  }
>  
> @@ -39,6 +57,8 @@ if [ `id -u` -ne 0 ]; then
>    errexit "this must be run by root user"
>  fi
>  
> +setup
> +
>  # Utilities
>  absdir() { # file_path
>    (cd `dirname $1`; pwd)
> @@ -235,6 +255,7 @@ TOTAL_RESULT=0
>  
>  INSTANCE=
>  CASENO=0
> +
>  testcase() { # testfile
>    CASENO=$((CASENO+1))
>    desc=`grep "^#[ \t]*description:" $1 | cut -f2 -d:`
> @@ -406,5 +427,7 @@ prlog "# of unsupported: " `echo $UNSUPPORTED_CASES | wc -w`
>  prlog "# of xfailed: " `echo $XFAILED_CASES | wc -w`
>  prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
>  
> +cleanup
> +
>  # if no error, return 0
>  exit $TOTAL_RESULT
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
