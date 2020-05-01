Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1501C1079
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgEAJmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 05:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgEAJmN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 05:42:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E782076D;
        Fri,  1 May 2020 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588326133;
        bh=jQlyjE3iv7KynkZ7oUm3FBeSOQmFauXtv0A3fLn5pus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ToiFJHkfh6J1G6uFLM0qKnV/qkc4JXrDIlqRQy0xXyZKxdBY7ObZ4cGXSZYlA3E7B
         YYKsapsfF2ng3o0JDztF8dAIPx9vNAP7T8ieojZXI6+tkuol7KcnUzF0ZTjFJnTa05
         15qSrHkh9Eavk+s9FuysC1IQGhAqAQ1IEEsV8Cok=
Date:   Fri, 1 May 2020 18:42:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>, rostedt@goodmis.org,
        mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>
Subject: Re: [PATCH v2 2/2] ftrace/selftest: make unresolved cases cause
 failure if --fail-unresolved set
Message-Id: <20200501184208.2529cac8081a34de0b48617f@kernel.org>
In-Reply-To: <20200219203941.eb0fb66aee13f6d7a47513ac@kernel.org>
References: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
        <1582104810-12983-3-git-send-email-alan.maguire@oracle.com>
        <20200219203941.eb0fb66aee13f6d7a47513ac@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 19 Feb 2020 20:39:41 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 19 Feb 2020 09:33:30 +0000
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> > Currently, ftracetest will return 1 (failure) if any unresolved cases
> > are encountered.  The unresolved status results from modules and
> > programs not being available, and as such does not indicate any
> > issues with ftrace itself.  As such, change the behaviour of
> > ftracetest in line with unsupported cases; if unsupported cases
> > happen, ftracetest still returns 0 unless --fail-unsupported.  Here
> > --fail-unresolved is added and the default is to return 0 if
> > unresolved results occur.
> > 
> 
> OK, this looks good to me. One note, with this change, ftracetest doesn't
> fail even if your test environment is not well prepared anymore.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Hi Shuah,
Could you pick this up?

Po-Hsu Lin seemed to face same problem recently. If this applied, it will be solved.

Thank you,

> 
> Thank you,
> 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/testing/selftests/ftrace/ftracetest | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > index 144308a..19e9236 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -17,6 +17,7 @@ echo "		-v|--verbose Increase verbosity of test messages"
> >  echo "		-vv        Alias of -v -v (Show all results in stdout)"
> >  echo "		-vvv       Alias of -v -v -v (Show all commands immediately)"
> >  echo "		--fail-unsupported Treat UNSUPPORTED as a failure"
> > +echo "		--fail-unresolved Treat UNRESOLVED as a failure"
> >  echo "		-d|--debug Debug mode (trace all shell commands)"
> >  echo "		-l|--logdir <dir> Save logs on the <dir>"
> >  echo "		            If <dir> is -, all logs output in console only"
> > @@ -112,6 +113,10 @@ parse_opts() { # opts
> >        UNSUPPORTED_RESULT=1
> >        shift 1
> >      ;;
> > +    --fail-unresolved)
> > +      UNRESOLVED_RESULT=1
> > +      shift 1
> > +    ;;
> >      --logdir|-l)
> >        LOG_DIR=$2
> >        shift 2
> > @@ -176,6 +181,7 @@ KEEP_LOG=0
> >  DEBUG=0
> >  VERBOSE=0
> >  UNSUPPORTED_RESULT=0
> > +UNRESOLVED_RESULT=0
> >  STOP_FAILURE=0
> >  # Parse command-line options
> >  parse_opts $*
> > @@ -280,7 +286,7 @@ eval_result() { # sigval
> >      $UNRESOLVED)
> >        prlog "	[${color_blue}UNRESOLVED${color_reset}]"
> >        UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
> > -      return 1 # this is a kind of bug.. something happened.
> > +      return $UNRESOLVED_RESULT # depends on use case
> >      ;;
> >      $UNTESTED)
> >        prlog "	[${color_blue}UNTESTED${color_reset}]"
> > -- 
> > 1.8.3.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
