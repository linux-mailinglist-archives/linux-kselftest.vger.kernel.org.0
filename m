Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1434863499C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 22:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiKVVto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 16:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiKVVtk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 16:49:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166EBF587;
        Tue, 22 Nov 2022 13:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872B3618E5;
        Tue, 22 Nov 2022 21:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22137C43470;
        Tue, 22 Nov 2022 21:49:38 +0000 (UTC)
Date:   Tue, 22 Nov 2022 16:49:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RESEND PATCH v2 0/2] selftests/ftrace: Capture dependency on
 external programs
Message-ID: <20221122164936.1a92f529@gandalf.local.home>
In-Reply-To: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Oct 2022 12:46:08 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This is a repost of v2 with the tags collected, and with cc to 
> linux-kselftest list:
> https://lore.kernel.org/all/cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com/
> 

Hi Shuah,

Can you take this (if you haven't already)?

Thanks,

-- Steve


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

