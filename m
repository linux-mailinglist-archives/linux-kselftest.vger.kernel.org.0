Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874DE6EE419
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 16:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjDYOlh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjDYOlb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 10:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B419A2;
        Tue, 25 Apr 2023 07:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDAF262B0F;
        Tue, 25 Apr 2023 14:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC08C433EF;
        Tue, 25 Apr 2023 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682433689;
        bh=lZk+EFWneQATzI/nj3p2fQd2Dgt+Z7L2bXldLPZN7ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tyDqjLiA/h2M63/HcxIIofyoWsVIe8PRXh1frH+MBnH3pL3LxhcVM6gHkcc86vQ+e
         v2amCqwpWA2iZ9LaZnjatfu96VVon0bjkRDLJ0kibijE+7v+OXAixeaBEy6Qx0T78b
         5IP6BaKn5VpMdYfxAPdSM6dUr44Djy3Ttjp/j7CopJ1heRXEpNcKM54gQxbkGfWFlo
         mG7mGZ6NsEW7t6T/X6HysIHrMgy7So2igThhJIVVzvHuTUtBN0LAk0a+KFsnPCH9eT
         LLTOycxhkMum1rTb9T+Z5HfSes8OqH2d6n3Bm1NnaE9wcSGXs4VRGUNn5Rjb2Zmh2f
         PG4HtbKRzqPAA==
Date:   Tue, 25 Apr 2023 23:41:25 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        shuah@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Message-Id: <20230425234125.51455711c4388481c13be5ad@kernel.org>
In-Reply-To: <1682400251.pez54ergiy.naveen@linux.ibm.com>
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
        <20230418095557.19061-3-akanksha@linux.ibm.com>
        <20230425091039.9fd523dfdf7be5e800bac4fe@kernel.org>
        <1682400251.pez54ergiy.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 25 Apr 2023 10:58:30 +0530
"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Tue, 18 Apr 2023 15:25:57 +0530
> > Akanksha J N <akanksha@linux.ibm.com> wrote:
> > 
> >> Add new test case kprobe_opt_types.tc which enables and checks
> >> if each probe has been optimized in order to test potential issues with
> >> optimized probes.
> >> The '|| continue' is added with the echo statement to ignore errors that
> >> are caused by trying to add kprobes to non probeable lines and continue
> >> with the test.
> >> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> >> ---
> >>  .../ftrace/test.d/kprobe/kprobe_opt_types.tc  | 34 +++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> >> 
> >> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> >> new file mode 100644
> >> index 000000000000..54e4800b8a13
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> >> @@ -0,0 +1,34 @@
> >> +#!/bin/sh
> >> +# SPDX-License-Identifier: GPL-2.0-or-later
> >> +# Copyright (C) 2023 Akanksha J N, IBM corporation
> >> +# description: Register/unregister optimized probe
> >> +# requires: kprobe_events
> >> +
> >> +case `uname -m` in
> >> +x86_64)
> >> +;;
> >> +arm*)
> >> +;;
> >> +ppc*)
> >> +;;
> >> +*)
> >> +  echo "Please implement other architecture here"
> >> +  exit_unsupported
> >> +esac
> >> +
> >> +DEFAULT=$(cat /proc/sys/debug/kprobes-optimization)
> >> +echo 1 > /proc/sys/debug/kprobes-optimization
> >> +for i in `seq 0 255`; do
> >> +        echo  "p:testprobe $FUNCTION_FORK+${i}" > kprobe_events || continue
> >> +        echo 1 > events/kprobes/enable || continue
> >> +        (echo "forked")
> >> +        PROBE_TYPE=$(cat /sys/kernel/debug/kprobes/list | grep $FUNCTION_FORK | awk '{print $4}' | awk '{print substr($0,2,length($0)-2)}')
> > 
> > I think we can make it simply;
> > 
> > PROBE=$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)
> > 
> >> +        echo 0 > events/kprobes/enable
> >> +        echo > kprobe_events
> >> +        if [ $PROBE_TYPE = "OPTIMIZED" ]; then
> > 
> > and
> > 
> > if echo $PROBE | grep -q OPTIMIZED; then
> > 
> >> +                echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
> >> +                exit_pass
> >> +        fi
> >> +done
> >> +echo "$DEFAULT" >  /proc/sys/debug/kprobes-optimization
> >> +echo "Done"
> > 
> > Hmm, this test does NOT return any error. It always returns success.
> 
> Good catch!
> 
> > I understand that optimization may not be possible within 256 bytes
> > from the beginning of the function.
> 
> Is that true in practice? Looking at x86 and ppc64le, it looks like we 
> will almost always be able to optimize at least one of the instructions 
> within the first 256 bytes of kernel_clone(). That's one of the primary 
> purposes of this test.

Yeah, usually it should not happen. But since we don't disassemble it,
we can not ensure that. So this depends on the compiler at last.

> 
> Are there valid reasons why we may not be able to optimize instructions?

For example, if the compiler starts inserting some checker instruction
on each instruction boundary for security, it may prevent optimizing
kprobes. Usually it should not happen (because it bloat up the kernel size)
but we cannot deny the possibility of such new feature as an option
in the future.

> 
> > In that case, you can return
> > "unresolved", and not echoing "Done" but the reason why it is
> > unresolved.

Even in that case, it can notify such case as "unresolved", then we
can notice it. (something like WARN_ON)

Thank you,

> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
