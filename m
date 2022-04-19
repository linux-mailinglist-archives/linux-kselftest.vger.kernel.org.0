Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1451506197
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 03:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiDSBPR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 21:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiDSBPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 21:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8292F39A;
        Mon, 18 Apr 2022 18:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30DC461472;
        Tue, 19 Apr 2022 01:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3012C385A7;
        Tue, 19 Apr 2022 01:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650330755;
        bh=eVkItMh+1mLEy7bhaGGLN6BKEd31Om/XHl0TDl+JaQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tTEa7fuxI3q8pp2MKNQFuyZWwv/AhsfIFXRyQPDZs+yXCPonynx1pdzTk8jbyijZb
         kRhfy1SJa61+LMawU5xdzvZLsJdZAV21hULf8LVZncrM2+LX1WPC8w4XSJLXpoRdGN
         vpaRtlZhdahP9iDs8KtwUv4VPz3heCriSw8g0nVItgP70vy5FOOGdBoYBnaZATkrHA
         EOStcwmqCcdS3hvBtUQoQC14miN8hkYgaAL9oTxIP7rvhNiuQzB1AMKrsRqswNGaY+
         9KxKsKqwprVT8uxrx5JlGtIuvJKeugqDtqJhLHnlOru7DWYqR5X2kAwK8Q0t4Cb3w9
         xyLEt/xXv/nRA==
Date:   Tue, 19 Apr 2022 10:12:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ze Zhang <zhangze@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2] selftests/ftrace: add mips support for kprobe args
 string tests
Message-Id: <20220419101232.3f56542fdf84af846eaf47fd@kernel.org>
In-Reply-To: <20220418132957.2b7591e9@gandalf.local.home>
References: <20220416114848.25288-1-zhangze@loongson.cn>
        <20220418132957.2b7591e9@gandalf.local.home>
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

On Mon, 18 Apr 2022 13:29:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 16 Apr 2022 19:48:47 +0800
> Ze Zhang <zhangze@loongson.cn> wrote:
> 
> > This is the mips variant of commit <3990b5baf225> ("selftests/ftrace:
> > Add s390 support for kprobe args tests").

Thanks for adding MIPS support!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> > 
> > Signed-off-by: Ze Zhang <zhangze@loongson.cn>
> > ---
> >  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc       | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> > index dc7ade196798..459741565222 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> > @@ -25,6 +25,9 @@ ppc*)
> >  s390*)
> >    ARG1=%r2
> >  ;;
> > +mips*)
> > +  ARG1=%r4
> > +;;
> >  *)
> >    echo "Please implement other architecture here"
> >    exit_untested
> 
> 
> Needs an Ack from Masami, and then Shuah could take it.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
