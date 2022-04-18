Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E3505D85
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Apr 2022 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbiDRRdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 13:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbiDRRd2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 13:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F692E9D0;
        Mon, 18 Apr 2022 10:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3595B6135C;
        Mon, 18 Apr 2022 17:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B125AC385A7;
        Mon, 18 Apr 2022 17:30:46 +0000 (UTC)
Date:   Mon, 18 Apr 2022 13:30:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Zhang <zhangze@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/2] selftests/ftrace: add mips support for kprobe args
 syntax tests
Message-ID: <20220418133045.3ddb0032@gandalf.local.home>
In-Reply-To: <20220416114848.25288-2-zhangze@loongson.cn>
References: <20220416114848.25288-1-zhangze@loongson.cn>
        <20220416114848.25288-2-zhangze@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 16 Apr 2022 19:48:48 +0800
Ze Zhang <zhangze@loongson.cn> wrote:

> This is the mips variant of commit <3990b5baf225> ("selftests/ftrace:
> Add s390 support for kprobe args tests").
> 
> Signed-off-by: Ze Zhang <zhangze@loongson.cn>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc      | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> index 47d84b5cb6ca..d4662c8cf407 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> @@ -36,6 +36,10 @@ s390*)
>    GOODREG=%r2
>    BADREG=%s2
>  ;;
> +mips*)
> +  GOODREG=%r4
> +  BADREG=%r12
> +;;
>  *)
>    echo "Please implement other architecture here"
>    exit_untested

This needs an Ack from Masami as well.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
