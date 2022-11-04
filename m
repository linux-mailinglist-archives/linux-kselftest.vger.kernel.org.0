Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A413A618D88
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 02:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiKDBQO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 21:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKDBQN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 21:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC719039;
        Thu,  3 Nov 2022 18:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18CE661FB8;
        Fri,  4 Nov 2022 01:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF727C433D7;
        Fri,  4 Nov 2022 01:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667524571;
        bh=YxLmpDgWn8gCU1i4xVPVk/YA8YZRM+FhFvMSOiVbJDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g8fWz5skh/NDEC8GhhKp62jCO6kgIAI2NgMghcXl3aumAYUrtnWjsBKWuMiSz6xGc
         J0RRm9kB6S4e28TZUxPg7DafaQ10yUdVQ6BwlfCKlApPqKuhNgvUDOQZaIcWKakiZE
         wYyyjvuMSQGNpvhZtR5OYr2W2M5CPT69t9cJQvMzIgFmVSHvocYqG7JBWU7E//h1A9
         OwEtw9j0jzH1Jc9BzaIU6HIANVgT+mUD+413A6fzW0dojzqKDJ7hSxEtd+dBq1NHlL
         OB91WEJ3dqzz0n74j93h23q82iaOIofyaeuRObbPdbTD8RwjgVIhuY+qHjKCpVbG7S
         9PhPdalCm4fUg==
Date:   Fri, 4 Nov 2022 10:16:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v2 2/2] selftests/ftrace: Convert tracer tests to
 use 'requires' to specify program dependency
Message-Id: <20221104101607.844382ef3dc5e2515febaa21@kernel.org>
In-Reply-To: <ca7a2ba0500e3df69d878c7896015184dc4d9a93.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
        <ca7a2ba0500e3df69d878c7896015184dc4d9a93.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Oct 2022 12:46:10 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Now that we have a good way to specify dependency of tests on programs,
> convert some of the tracer tests to use this method for specifying
> dependency on 'chrt'.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 7 +------
>  tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 7 +------
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
> index 11be10e1bf966a..e8f0fac9a110cc 100644
> --- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
> +++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
> @@ -1,12 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Test wakeup tracer
> -# requires: wakeup:tracer
> -
> -if ! which chrt ; then
> -  echo "chrt is not found. This test requires nice command."
> -  exit_unresolved
> -fi
> +# requires: wakeup:tracer chrt:program
>  
>  echo wakeup > current_tracer
>  echo 1 > tracing_on
> diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> index 3a77198b3c6902..79807656785b0f 100644
> --- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> +++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> @@ -1,12 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Test wakeup RT tracer
> -# requires: wakeup_rt:tracer
> -
> -if ! which chrt ; then
> -  echo "chrt is not found. This test requires chrt command."
> -  exit_unresolved
> -fi
> +# requires: wakeup_rt:tracer chrt:program
>  
>  echo wakeup_rt > current_tracer
>  echo 1 > tracing_on
> -- 
> 2.38.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
