Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5EF1C1780
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgEAOPV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 10:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgEAOPV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 10:15:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFF320757;
        Fri,  1 May 2020 14:15:20 +0000 (UTC)
Date:   Fri, 1 May 2020 10:15:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 1/3] selftests/ftrace: Make XFAIL green color
Message-ID: <20200501101518.1039e908@gandalf.local.home>
In-Reply-To: <158834026136.28357.14691721094452323293.stgit@devnote2>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834026136.28357.14691721094452323293.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri,  1 May 2020 22:37:41 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since XFAIL (Expected Failure) is expected to fail the test, which
> means that test case works as we expected. IOW, XFAIL is same as
> PASS. So make it green.

THANK YOU!!!! That's been annoying me for some time ;-)

BIG Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/ftrace/ftracetest |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 063ecb290a5a..72e837d0dfc1 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -273,7 +273,7 @@ eval_result() { # sigval
>        return $UNSUPPORTED_RESULT # depends on use case
>      ;;
>      $XFAIL)
> -      prlog "	[${color_red}XFAIL${color_reset}]"
> +      prlog "	[${color_green}XFAIL${color_reset}]"
>        XFAILED_CASES="$XFAILED_CASES $CASENO"
>        return 0
>      ;;

