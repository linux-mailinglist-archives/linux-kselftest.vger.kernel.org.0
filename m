Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FEB793DF6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 15:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjIFNpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjIFNpi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 09:45:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3DCF1;
        Wed,  6 Sep 2023 06:45:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10F3C433C8;
        Wed,  6 Sep 2023 13:45:33 +0000 (UTC)
Date:   Wed, 6 Sep 2023 09:45:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ye Weihua <yeweihua4@huawei.com>
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Message-ID: <20230906094553.388cd787@gandalf.local.home>
In-Reply-To: <20230906094306.67a51feb@gandalf.local.home>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
        <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
        <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
        <20230710183741.78f04c68@gandalf.local.home>
        <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
        <20230905183638.2b539fae@gandalf.local.home>
        <9cad73cd-1f8b-2f3f-cda4-99b89a87b931@huawei.com>
        <20230906072759.4e8bee1c@gandalf.local.home>
        <2667182e-691e-2ab4-4c2d-a47d76f38107@huawei.com>
        <20230906085621.6e20db28@gandalf.local.home>
        <20230906090252.36219543@gandalf.local.home>
        <fcc5d688-9d58-3b4c-58de-472330160142@huawei.com>
        <20230906094306.67a51feb@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 6 Sep 2023 09:43:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > also can be reproduced with the newest:
> > 65d6e954e378 ("Merge tag 'gfs2-v6.5-rc5-fixes' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2")
> > 
> > And revert commit 27152bceea1d ("eventfs: Move tracing/events to
> > eventfs"), the issue just seems gone.  
> 
> The reason I'm asking is that there could be something added that fixes it.
> I'm testing Linus's tree at: cbb557ba92f08b945e2cb20b7ab37ef49ab53cdd

Never mind, I just noticed that your above sha includes this one.

Not sure why I can't reproduce this. I'm using qemu as well.

-- Steve
