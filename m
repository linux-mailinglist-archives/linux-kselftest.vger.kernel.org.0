Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314A9164387
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 12:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBSLjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 06:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBSLjp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 06:39:45 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7746224654;
        Wed, 19 Feb 2020 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582112384;
        bh=YYR+RKtVZyrkxF6aGx2mWko7HJEfdWnL5yLEcKFK3CM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bggx/HrbYQdZhNF5nN0aSeWqSteZEh67+L59/TGkkRNDOnT4iDucfkbIAHmCR+Nd2
         5oTRdRkcp/WLJpGSkrfz9CSgY6Uw01sssjnPNJINbMGlXRMfAdKmq6xdCrhf0IINea
         DFwftWSyuvhU/YIv7/xFEYU2H5+O4tPYZkJOxX/o=
Date:   Wed, 19 Feb 2020 20:39:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ftrace/selftest: make unresolved cases cause
 failure if --fail-unresolved set
Message-Id: <20200219203941.eb0fb66aee13f6d7a47513ac@kernel.org>
In-Reply-To: <1582104810-12983-3-git-send-email-alan.maguire@oracle.com>
References: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
        <1582104810-12983-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 19 Feb 2020 09:33:30 +0000
Alan Maguire <alan.maguire@oracle.com> wrote:

> Currently, ftracetest will return 1 (failure) if any unresolved cases
> are encountered.  The unresolved status results from modules and
> programs not being available, and as such does not indicate any
> issues with ftrace itself.  As such, change the behaviour of
> ftracetest in line with unsupported cases; if unsupported cases
> happen, ftracetest still returns 0 unless --fail-unsupported.  Here
> --fail-unresolved is added and the default is to return 0 if
> unresolved results occur.
> 

OK, this looks good to me. One note, with this change, ftracetest doesn't
fail even if your test environment is not well prepared anymore.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 144308a..19e9236 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -17,6 +17,7 @@ echo "		-v|--verbose Increase verbosity of test messages"
>  echo "		-vv        Alias of -v -v (Show all results in stdout)"
>  echo "		-vvv       Alias of -v -v -v (Show all commands immediately)"
>  echo "		--fail-unsupported Treat UNSUPPORTED as a failure"
> +echo "		--fail-unresolved Treat UNRESOLVED as a failure"
>  echo "		-d|--debug Debug mode (trace all shell commands)"
>  echo "		-l|--logdir <dir> Save logs on the <dir>"
>  echo "		            If <dir> is -, all logs output in console only"
> @@ -112,6 +113,10 @@ parse_opts() { # opts
>        UNSUPPORTED_RESULT=1
>        shift 1
>      ;;
> +    --fail-unresolved)
> +      UNRESOLVED_RESULT=1
> +      shift 1
> +    ;;
>      --logdir|-l)
>        LOG_DIR=$2
>        shift 2
> @@ -176,6 +181,7 @@ KEEP_LOG=0
>  DEBUG=0
>  VERBOSE=0
>  UNSUPPORTED_RESULT=0
> +UNRESOLVED_RESULT=0
>  STOP_FAILURE=0
>  # Parse command-line options
>  parse_opts $*
> @@ -280,7 +286,7 @@ eval_result() { # sigval
>      $UNRESOLVED)
>        prlog "	[${color_blue}UNRESOLVED${color_reset}]"
>        UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
> -      return 1 # this is a kind of bug.. something happened.
> +      return $UNRESOLVED_RESULT # depends on use case
>      ;;
>      $UNTESTED)
>        prlog "	[${color_blue}UNTESTED${color_reset}]"
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
