Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377FF506198
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbiDSBP1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 21:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiDSBP1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 21:15:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F592D1EB;
        Mon, 18 Apr 2022 18:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2CABBCE1122;
        Tue, 19 Apr 2022 01:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AEAC385A7;
        Tue, 19 Apr 2022 01:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650330761;
        bh=dYIITBV7LIZq0x4mnEZZKy+m3/EegS8p0ZFgHqtlhiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TZUzIhN7iTFjXSim5uzsBAzmPXRuJ0dbTY3KOmEdKHRAZNxn1LK/sYNC215FmBM/G
         cemKSbtBPlwhTF1fXnOTUZeDc4bfLtkLA6bt2l5zQmD541qn9Ql8S68RRANiRSgwM6
         qSxAYzpMzvgJa6QnAkoenJxmhuTRJD1Z0QXOwIGWHJfIL7H+z8oUaRypojftUYwEgc
         JuKRDv0ZSvby18JmfJ1IMpMiNGgRC+BJ1BC66DnA4qNPmzNifU52g3UVnvXRzbVPf6
         0ZvBD0wcL6jY4S4AdmH9UuXuccw/dMZBU4iRY8aucg7PWRKDs4p+vz6ssaSwFdScUt
         KiKx+89hIlV7g==
Date:   Tue, 19 Apr 2022 10:12:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ze Zhang <zhangze@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/2] selftests/ftrace: add mips support for kprobe args
 syntax tests
Message-Id: <20220419101238.affc234023ed6821d8857cfc@kernel.org>
In-Reply-To: <20220418133045.3ddb0032@gandalf.local.home>
References: <20220416114848.25288-1-zhangze@loongson.cn>
        <20220416114848.25288-2-zhangze@loongson.cn>
        <20220418133045.3ddb0032@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 18 Apr 2022 13:30:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 16 Apr 2022 19:48:48 +0800
> Ze Zhang <zhangze@loongson.cn> wrote:
> 
> > This is the mips variant of commit <3990b5baf225> ("selftests/ftrace:
> > Add s390 support for kprobe args tests").

Great! 

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> > 
> > Signed-off-by: Ze Zhang <zhangze@loongson.cn>
> > ---
> >  .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc      | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> > index 47d84b5cb6ca..d4662c8cf407 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> > @@ -36,6 +36,10 @@ s390*)
> >    GOODREG=%r2
> >    BADREG=%s2
> >  ;;
> > +mips*)
> > +  GOODREG=%r4
> > +  BADREG=%r12
> > +;;
> >  *)
> >    echo "Please implement other architecture here"
> >    exit_untested
> 
> This needs an Ack from Masami as well.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
