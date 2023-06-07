Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134FE726267
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjFGOKr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbjFGOKq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 10:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105461BD9;
        Wed,  7 Jun 2023 07:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9308A63FCF;
        Wed,  7 Jun 2023 14:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27830C433D2;
        Wed,  7 Jun 2023 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686147028;
        bh=S8NK1bnmaHNJATglit6E/b/dEXHn0aN5yLS1rnfSXNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n+AMh7Y7jZngGcm0GpoiL8rjF3nQ78DFhLe8yb8/RLRjdIeMNSOatCg2PkXGemn+2
         +nsrfQfV04Ma0/1JoZqx4GcvlIRB8K4R4ZqQsuGFUU+Cq2QkgQiVMkxybvRNCgb59b
         RJBsbdnV/CNoSxThisjBd/jLDC/HvZDWSv78L+inrisa8MpKM5QDiqDX4G6NffAt3K
         9O4vJO7iRih3YqtNfh5tEZzQW/oaqAoLyrOTpy0t+Yu1i/4eNNkUb2wwFsKS1vOueh
         8DyCdQe6dfqwAwNXU0p3tj1bTXXtSBLgPCsSXXgmPHHVj+tLG5sj+JBLyjHhdWLH9t
         b5fNetmsEFjcA==
Date:   Wed, 7 Jun 2023 23:10:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     beaub@linux.microsoft.com, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com
Subject: Re: [PATCH v3 0/4] tracing/user_events: Add empty arguments events
Message-Id: <20230607231023.6097c4c1060d82c74a4cbfee@kernel.org>
In-Reply-To: <20230606062027.1008398-1-sunliming@kylinos.cn>
References: <20230606062027.1008398-1-sunliming@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue,  6 Jun 2023 14:20:23 +0800
sunliming <sunliming@kylinos.cn> wrote:

> This series patches fix the incorrect trace record for empty arguments
> events and add correspondent selftests.

Looks good for me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for the series.

> 
> V3:
>   Improve modification descriptions to maintain consistent formatting
> 
> v2:
>   Change "i->count" to "i->count !=0 " to prevent compiler optimization
>   Add correspondent selftests
> 
> sunliming (4):
>   tracing/user_events: Fix the incorrect trace record for empty
>     arguments events
>   selftests/user_events: Add ftrace self-test for empty arguments events
>   selftests/user_events: Clear the events after perf self-test
>   selftests/user_events: Add perf self-test for empty arguments events
> 
>  kernel/trace/trace_events_user.c              |  4 +-
>  .../selftests/user_events/ftrace_test.c       | 33 ++++++++
>  .../testing/selftests/user_events/perf_test.c | 82 +++++++++++++++++++
>  3 files changed, 117 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
