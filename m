Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75B6ED92E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjDYAKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 20:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDYAKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 20:10:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBE4EE4;
        Mon, 24 Apr 2023 17:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BCBE629FB;
        Tue, 25 Apr 2023 00:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7BCC433D2;
        Tue, 25 Apr 2023 00:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682381442;
        bh=wZyN09T0fe+lRCHquhmAigLJLxkKN0q1pAhmCmC2Xt0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AsJXxRpDkdFrIoLOb4o/24u41BZMDNu74kQ/yMg3xQG9yPih4TuZMvxhF8KnJRf2O
         ouz5OHfzvToSKo1R92qrpfHzJvGX3IQylSPOPI6hoyAdxLlPmu0r+Bm/UHkedWUEHX
         2OKSiRpwPhXmMqZStQN6DHO3WQWWtp0wjJ2Lz5kXK4f55ZVNmMd2+Otcl5/oprxJAV
         G7rnMfYFbPYJnjQDaDb0sGowwbRlgLCiTaKB1AmwJqSdkpTjE4YUK0I8kRMU3a0kde
         cs4u82s50hfJ+Q+YCrqqblYoAKjffC33G1HNrIpw2i/5/5/qU5cd/PPguvOnBN0Dd/
         kUa44uTt7j9rA==
Date:   Tue, 25 Apr 2023 09:10:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Akanksha J N <akanksha@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Message-Id: <20230425091039.9fd523dfdf7be5e800bac4fe@kernel.org>
In-Reply-To: <20230418095557.19061-3-akanksha@linux.ibm.com>
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
        <20230418095557.19061-3-akanksha@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 18 Apr 2023 15:25:57 +0530
Akanksha J N <akanksha@linux.ibm.com> wrote:

> Add new test case kprobe_opt_types.tc which enables and checks
> if each probe has been optimized in order to test potential issues with
> optimized probes.
> The '|| continue' is added with the echo statement to ignore errors that
> are caused by trying to add kprobes to non probeable lines and continue
> with the test.
> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> ---
>  .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> new file mode 100644
> index 000000000000..54e4800b8a13
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
> +        PROBE_TYPE=$(cat /sys/kernel/debug/kprobes/list | grep $FUNCTION_FORK | awk '{print $4}' | awk '{print substr($0,2,length($0)-2)}')

I think we can make it simply;

PROBE=$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)

> +        echo 0 > events/kprobes/enable
> +        echo > kprobe_events
> +        if [ $PROBE_TYPE = "OPTIMIZED" ]; then

and

if echo $PROBE | grep -q OPTIMIZED; then

> +                echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
> +                exit_pass
> +        fi
> +done
> +echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
> +echo "Done"

Hmm, this test does NOT return any error. It always returns success.
I understand that optimization may not be possible within 256 bytes
from the beginning of the function. In that case, you can return
"unresolved", and not echoing "Done" but the reason why it is
unresolved.

Thank you,

> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
