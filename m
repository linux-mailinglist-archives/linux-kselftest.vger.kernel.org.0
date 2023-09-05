Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E448793209
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 00:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjIEWg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 18:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbjIEWg0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 18:36:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA715CE2;
        Tue,  5 Sep 2023 15:36:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF6EC433C8;
        Tue,  5 Sep 2023 22:36:19 +0000 (UTC)
Date:   Tue, 5 Sep 2023 18:36:38 -0400
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
Message-ID: <20230905183638.2b539fae@gandalf.local.home>
In-Reply-To: <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
        <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
        <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
        <20230710183741.78f04c68@gandalf.local.home>
        <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
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

On Tue, 5 Sep 2023 20:54:40 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Hi, Steve, Ajay,
> 
> After this patch and run this testcase, I got an use-after-free report
> by KASAN. Short log see [1], full logs see attach "panic.log".
> 
> And by simple bisect, I found it may be introduced by:
> 
>    27152bceea1d ("eventfs: Move tracing/events to eventfs")
> 
> Link: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27152bceea1df27ffebb12ac9cd9adbf2c4c3f35

Hi Zheng,

Can you test:

   https://lore.kernel.org/all/20230905183332.628d7cc0@gandalf.local.home/

and see if it fixes the KASAN issue for you?

Thanks!

-- Steve
