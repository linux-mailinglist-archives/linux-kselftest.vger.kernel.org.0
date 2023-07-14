Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64D753BC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 15:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjGNN1N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 09:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGNN1M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 09:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8772690;
        Fri, 14 Jul 2023 06:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C93F61CEC;
        Fri, 14 Jul 2023 13:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D2C433C8;
        Fri, 14 Jul 2023 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689341230;
        bh=4NJD+91XYnIC9eS48LutSS635hRd73LAz4J5eDqTKzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E5fCb06bUeBcojk/JYNpdYnJGsi2c38Q8IUEs0adtduuUzuRELCw6c01vhdyw66Xp
         48tFJGNhGPoD4j+sxNewQhOzVknAnRISFlNdOwTbkr4ibQ05IcGTSacb2j6iHfUseO
         lNYkISeiamCRJS6Llcc7gBOof86A5KAi6iqrYf6byCrHbj5W2+PzHOx1p87Hsf6dsn
         XaXWJHGjJ9XbFHS0XJH9/bjxPFuYinG7fIkeSx15fDNMvxuZXFRTlRojb7SSnToO5m
         n8pIX3U1FjysHUr1OUdaaJBZCMSWFMYnbRSXAHXUxFwidOCabefrVYaTxaA00r52Uy
         PfkuRoAJ3iIDw==
Date:   Fri, 14 Jul 2023 22:27:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ajay Kaher <akaher@vmware.com>, shuah@kernel.org,
        mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 10/10] test: ftrace: Fix kprobe test for eventfs
Message-Id: <20230714222705.bc38f83d857473656a45d441@kernel.org>
In-Reply-To: <20230713223758.31a1e391@rorschach.local.home>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-11-git-send-email-akaher@vmware.com>
        <20230713223758.31a1e391@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 13 Jul 2023 22:37:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 13 Jul 2023 17:03:24 +0530
> Ajay Kaher <akaher@vmware.com> wrote:
> 
> > kprobe_args_char.tc, kprobe_args_string.tc has validation check
> > for tracefs_create_dir, for eventfs it should be eventfs_create_dir.
> > 
> > Signed-off-by: Ajay Kaher <akaher@vmware.com>
> > Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Tested-by: Ching-lin Yu <chinglinyu@google.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> As this patch as is will break when running on older kernels, I was
> wondering if we should do this instead?

+1 since the latest kselftest is used also for checking the older
stable kernels, the test case has to check the environment and
change the parameter (or make it unsupported for new feature)
So below looks good to me.

Thanks,

> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> index 285b4770efad..ff7499eb98d6 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> @@ -34,14 +34,19 @@ mips*)
>  esac
>  
>  : "Test get argument (1)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
> +if grep -q eventfs_add_dir available_filter_functions; then
> +  DIR_NAME="eventfs_add_dir"
> +else
> +  DIR_NAME="tracefs_create_dir"
> +fi
> +echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):char" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1='t'" trace
>  
>  echo 0 > events/kprobes/testprobe/enable
>  : "Test get argument (2)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
> +echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> index a4f8e7c53c1f..a202b2ea4baf 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> @@ -37,14 +37,19 @@ loongarch*)
>  esac
>  
>  : "Test get argument (1)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
> +if grep -q eventfs_add_dir available_filter_functions; then
> +  DIR_NAME="eventfs_add_dir"
> +else
> +  DIR_NAME="tracefs_create_dir"
> +fi
> +echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):string" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1=\"test\"" trace
>  
>  echo 0 > events/kprobes/testprobe/enable
>  : "Test get argument (2)"
> -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
> +echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
>  echo "p:test $FUNCTION_FORK" >> kprobe_events
>  grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
> 
> -- Steve
> 
> > ---
> >  .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 ++--
> >  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> > index 285b4770efad..523cfb64539f 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> > @@ -34,14 +34,14 @@ mips*)
> >  esac
> >  
> >  : "Test get argument (1)"
> > -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
> > +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char" > kprobe_events
> >  echo 1 > events/kprobes/testprobe/enable
> >  echo "p:test $FUNCTION_FORK" >> kprobe_events
> >  grep -qe "testprobe.* arg1='t'" trace
> >  
> >  echo 0 > events/kprobes/testprobe/enable
> >  : "Test get argument (2)"
> > -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
> > +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
> >  echo 1 > events/kprobes/testprobe/enable
> >  echo "p:test $FUNCTION_FORK" >> kprobe_events
> >  grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> > index a4f8e7c53c1f..b9f8c3f8bae8 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> > @@ -37,14 +37,14 @@ loongarch*)
> >  esac
> >  
> >  : "Test get argument (1)"
> > -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
> > +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string" > kprobe_events
> >  echo 1 > events/kprobes/testprobe/enable
> >  echo "p:test $FUNCTION_FORK" >> kprobe_events
> >  grep -qe "testprobe.* arg1=\"test\"" trace
> >  
> >  echo 0 > events/kprobes/testprobe/enable
> >  : "Test get argument (2)"
> > -echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
> > +echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
> >  echo 1 > events/kprobes/testprobe/enable
> >  echo "p:test $FUNCTION_FORK" >> kprobe_events
> >  grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
