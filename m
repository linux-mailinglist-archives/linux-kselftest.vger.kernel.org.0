Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4303072DC4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 10:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbjFMIVu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 04:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbjFMIVs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 04:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04573128;
        Tue, 13 Jun 2023 01:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B91C62B41;
        Tue, 13 Jun 2023 08:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA046C433EF;
        Tue, 13 Jun 2023 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686644506;
        bh=OvLFTlujnYmRs+UiOmoVGndpXhBiBH1WD26me7bcPpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dVQatewwwGOGeOvRrgjR3jiRVM+VbW/gBL56ydxMN2py/G7MwL8vIdIq3257EobNS
         6HMf2eEmpGMuiS8QHp2PgVvpVx2KnFewrogZwN9etq315vl/TUM0lSNHre54ugPOya
         Ur8FAAABTzxnGDovO79hiJqorymrJcEoiPWDGWAy+eH5xNs3eQlQuD/bK1ylkRAqMn
         /Crlv22H1x3jJDAiddK+EvqU4OU6d38Xi0Ok4udckOdbWhFkWPckjdexErm0HH5yP4
         gE3juNJ4459F1MzJWZ7LvGWO7RGfMUfEvns7K8fL8rXnP9iVujVLOu8m065eVkeHIg
         YCYO4SPRv+J0w==
Date:   Tue, 13 Jun 2023 17:21:42 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com
Subject: Re: [PATCH v3 10/10] test: ftrace: fix kprobe test for eventfs
Message-Id: <20230613172142.5dfb0511b7875790f6d71f50@kernel.org>
In-Reply-To: <1685610013-33478-11-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-11-git-send-email-akaher@vmware.com>
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

On Thu,  1 Jun 2023 14:30:13 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> kprobe_args_char.tc, kprobe_args_string.tc has validation check
> for tracefs_create_dir, for eventfs it should be eventfs_create_dir.
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 ++--
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> index 285b4770e..523cfb645 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> @@ -34,14 +34,14 @@ mips*)
>  esac
>  
>  : "Test get argument (1)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
> +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1='t'" trace
>  
>  echo 0 > events/kprobes/testprobe/enable
>  : "Test get argument (2)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
> +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> index a4f8e7c53..b9f8c3f8b 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> @@ -37,14 +37,14 @@ loongarch*)
>  esac
>  
>  : "Test get argument (1)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
> +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1=\"test\"" trace
>  
>  echo 0 > events/kprobes/testprobe/enable
>  : "Test get argument (2)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
> +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
> -- 
> 2.40.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
