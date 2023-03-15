Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C566BB51D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 14:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjCONsi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 09:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjCONsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 09:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1662F8A3AF
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 06:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51AE261D99
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 13:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188C7C433EF;
        Wed, 15 Mar 2023 13:48:00 +0000 (UTC)
Date:   Wed, 15 Mar 2023 09:47:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Update comment and clean up
Message-ID: <20230315094758.0441f085@gandalf.local.home>
In-Reply-To: <f7d58b48-41c6-a77d-2f7d-0df8ea59933e@gmail.com>
References: <20230311124151.43691-1-p4ranlee@gmail.com>
        <20230313103033.7bb461ef@gandalf.local.home>
        <f7d58b48-41c6-a77d-2f7d-0df8ea59933e@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Mar 2023 13:09:51 +0900
Paran Lee <p4ranlee@gmail.com> wrote:

> The first thing I noticed was that the a comment where "_do_fork was
> changed to kernel_fork" instead of "kernel_clone",
> so I fixed that as well.
> 
> Would it be better to send that typo fix along with the other fixes?

Yes. And I'm glad I didn't ack this patch. A patch changing formatting
should *never* include any other changes. No typo fixes or what not. It
makes it impossible to review what exactly changed.

One reason I hate format changes is that they can sneak other changes in
undetected.

-- Steve
