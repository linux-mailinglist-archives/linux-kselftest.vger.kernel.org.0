Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785CC6ED938
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 02:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDYAMT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 20:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjDYAMS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 20:12:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9159C5;
        Mon, 24 Apr 2023 17:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F0E62A57;
        Tue, 25 Apr 2023 00:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A905C433EF;
        Tue, 25 Apr 2023 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682381536;
        bh=TmGzBUgWuiLre39xQk2ahbZ/X29IjktKzskcbC+TxWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jMqJdloXYo8bEdypj3cRt6LLYo4ZxqajB0J1TYtqhZAWrM7dTRpt59XSBUqex/h9x
         mmjgeXTxh5RFT0d7ZuFVK7lT6/6MG8CvJUenYUzpyVAV0bJn/mH4iJVBuhYaRu6U5V
         r37PDd1ZHjBO06kB6eq6lOFSqUdBkn+odQooBUjLTxaTiON4Xwj2VIYBvtdfYWeRkx
         fQg9b49Lh5WqEGkPNFbJw5UWRehqVtZCYUBtkMXuX2tT6GvA9ZxLgD1RRExVi8Mf7x
         6Z/Ml6Sfu4Qc+dtAb3aLiqmQYvrzirS3K0NGAkYYC/mp7ukDdf6VGisEhTD2L/eNfA
         3GtRuhh6MCceg==
Date:   Tue, 25 Apr 2023 09:12:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Akanksha J N <akanksha@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org,
        naveen.n.rao@linux.ibm.com
Subject: Re: [PATCH v2 1/2] selftests/ftrace: Add new test case which adds
 multiple consecutive probes in a function
Message-Id: <20230425091213.9af554f08e607c6e43a54039@kernel.org>
In-Reply-To: <20230418095557.19061-2-akanksha@linux.ibm.com>
References: <20230418095557.19061-1-akanksha@linux.ibm.com>
        <20230418095557.19061-2-akanksha@linux.ibm.com>
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

On Tue, 18 Apr 2023 15:25:56 +0530
Akanksha J N <akanksha@linux.ibm.com> wrote:

> Commit 97f88a3d723162 ("powerpc/kprobes: Fix null pointer reference in
> arch_prepare_kprobe()") fixed a recent kernel oops that was caused as
> ftrace-based kprobe does not generate kprobe::ainsn::insn and it gets
> set to NULL.
> Add new test case kprobe_insn_boundary.tc which adds a
> kprobe at every byte within $FUNCTION_FORK up to an offset of 256 bytes,
> to be able to test potential issues with kprobes on
> successive instructions.
> The '|| continue' is added with the echo statement to ignore errors that
> are caused by trying to add kprobes to non probeable lines and continue
> with the test.

Hi Akanksha,

Thanks for adding test case. This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> ---
>  .../test.d/kprobe/kprobe_insn_boundary.tc     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
> new file mode 100644
> index 000000000000..4f7cc318f331
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2023 Akanksha J N, IBM corporation
> +# description: Register multiple kprobe events in a function
> +# requires: kprobe_events
> +
> +for i in `seq 0 255`; do
> +  echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
> +done
> +
> +cat kprobe_events >> $testlog
> +
> +echo 1 > events/kprobes/enable
> +( echo "forked" )
> +echo 0 > events/kprobes/enable
> +echo > kprobe_events
> +echo "Waiting for unoptimizing & freeing"
> +sleep 5
> +echo "Done"
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
