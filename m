Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19535618D8A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 02:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKDBQk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 21:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKDBQj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 21:16:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A31A807;
        Thu,  3 Nov 2022 18:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BC28CE2A00;
        Fri,  4 Nov 2022 01:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BD8C433D6;
        Fri,  4 Nov 2022 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667524595;
        bh=dzlyRmVJj4aqgu6QHpgGpzeFs/dJNMYKCW/my1iaHK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B5Z5XMXKeARQXhsE8YtL8oxfgArYXkdLEdAanWsQmy6zMLg6bXOWJsCNwx+Dx4go/
         9bE9c1P+QlYyY8e/IqXYcqXyJNoNNfhz54e3QDS18IKIRhX/H72xHJ+wOchFBO0mOj
         VJOgAKdyBYsYLKq1QKS90fJxBjGLBwfq+CoyX3W1Ub7nHWaHLCYe0OUj3D4SVMzduO
         AmrcPCTYwEdDwU47n/BbBqumJvoizQ0zBeb8VEOzgQ/hADYzxjvkVIfMv+L0vnOcyB
         EI52JShlyaqIbBY63b0dKBFSeQ/1bMw2x2nEeiZhDLeXpLPh/7FIwbrj/KeuqqZYGa
         mvJZDpRv/B0hw==
Date:   Fri, 4 Nov 2022 10:16:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v2 0/2] selftests/ftrace: Capture dependency on
 external programs
Message-Id: <20221104101632.3a6af159c364920ae6392da5@kernel.org>
In-Reply-To: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Can you pick this series to your kselftest tree?

Thank you,

On Fri, 28 Oct 2022 12:46:08 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This is a repost of v2 with the tags collected, and with cc to 
> linux-kselftest list:
> https://lore.kernel.org/all/cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com/
> 
> - Naveen
> 
> 
> Naveen N. Rao (2):
>   selftests/ftrace: Add check for ping command for trigger tests
>   selftests/ftrace: Convert tracer tests to use 'requires' to specify
>     program dependency
> 
>  tools/testing/selftests/ftrace/test.d/functions           | 8 +++++++-
>  tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 7 +------
>  tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 7 +------
>  .../trigger/inter-event/trigger-field-variable-support.tc | 2 +-
>  .../inter-event/trigger-inter-event-combined-hist.tc      | 2 +-
>  .../trigger/inter-event/trigger-onchange-action-hist.tc   | 2 +-
>  .../trigger/inter-event/trigger-onmatch-action-hist.tc    | 2 +-
>  .../inter-event/trigger-onmatch-onmax-action-hist.tc      | 2 +-
>  .../trigger/inter-event/trigger-onmax-action-hist.tc      | 2 +-
>  .../trigger/inter-event/trigger-snapshot-action-hist.tc   | 2 +-
>  .../inter-event/trigger-synthetic-event-dynstring.tc      | 2 +-
>  .../trigger/inter-event/trigger-trace-action-hist.tc      | 2 +-
>  12 files changed, 18 insertions(+), 22 deletions(-)
> 
> 
> base-commit: cb05c81ada76a30a25a5f79b249375e33473af33
> -- 
> 2.38.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
