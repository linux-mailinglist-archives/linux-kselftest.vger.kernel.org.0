Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED446F274F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Apr 2023 03:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjD3Bwh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Apr 2023 21:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjD3Bwg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Apr 2023 21:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1661995;
        Sat, 29 Apr 2023 18:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2349460A4E;
        Sun, 30 Apr 2023 01:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFAAC433EF;
        Sun, 30 Apr 2023 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682819554;
        bh=ZhxqaDEN86XmxUi8KbuYL4Tf06ROel7RYWuePCb+syI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=npqsfDHWJpY6BH2oOxznuazADeDTN0eAV0JGypgI7Ab66IfNeEMEteraDFRx2Pczi
         AAuwWb8OQNiWzPUaoiwuHiVoxX67Dg5BGZH+/obIWf+nEjf9Eo6wgGtp8TirTe4Bfk
         pgNNqp11go9cgszpyvlK2k9GzdjuHFCwvTe6EQPPiNAZadVqZp0a8ByoiSeGtxpsZO
         CYrN3roOJpHfDm+GIB8TRa50wbAxp8xAO0RJYoK9zp0D9jgdnJxAu79vvNbTTJvzFL
         GSCpZAiBYK/LSJGZbpNLH+yC/JN8L8VN2yfkOxiqcbSbLCT+YC2WkvscFN3Ah40kbv
         oRfv7PjcphBQw==
Date:   Sun, 30 Apr 2023 10:52:31 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Akanksha J N <akanksha@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com
Subject: Re: [PATCH v3 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Message-Id: <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
In-Reply-To: <20230428163842.95118-3-akanksha@linux.ibm.com>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
        <20230428163842.95118-3-akanksha@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Apr 2023 22:08:42 +0530
Akanksha J N <akanksha@linux.ibm.com> wrote:

> Add new test case kprobe_opt_types.tc which enables and checks
> if each probe has been optimized in order to test potential issues with
> optimized probes.
> The '|| continue' is added with the echo statement to ignore errors that
> are caused by trying to add kprobes to non probeable lines and continue
> with the test.
> 
> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>

Thanks! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> new file mode 100644
> index 000000000000..9f5d99328086
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2023 Akanksha J N, IBM corporation
> +# description: Register/unregister optimized probe
> +# requires: kprobe_events
> +
> +case `uname -m` in
> +x86_64)
> +;;
> +arm*)
> +;;
> +ppc*)
> +;;
> +*)
> +  echo "Please implement other architecture here"
> +  exit_unsupported
> +esac
> +
> +DEFAULT=$(cat /proc/sys/debug/kprobes-optimization)
> +echo 1 > /proc/sys/debug/kprobes-optimization
> +for i in `seq 0 255`; do
> +        echo  "p:testprobe $FUNCTION_FORK+${i}" > kprobe_events || continue
> +        echo 1 > events/kprobes/enable || continue
> +        (echo "forked")
> +	PROBE=$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)
> +        echo 0 > events/kprobes/enable
> +        echo > kprobe_events
> +	if echo $PROBE | grep -q OPTIMIZED; then
> +                echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
> +                exit_pass
> +        fi
> +done
> +echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
> +exit_unresolved
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
