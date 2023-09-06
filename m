Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F607793D33
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 14:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbjIFM4H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 08:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjIFM4G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 08:56:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5510CC;
        Wed,  6 Sep 2023 05:56:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF2EC433C8;
        Wed,  6 Sep 2023 12:56:00 +0000 (UTC)
Date:   Wed, 6 Sep 2023 08:56:21 -0400
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
Message-ID: <20230906085621.6e20db28@gandalf.local.home>
In-Reply-To: <2667182e-691e-2ab4-4c2d-a47d76f38107@huawei.com>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
        <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
        <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
        <20230710183741.78f04c68@gandalf.local.home>
        <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
        <20230905183638.2b539fae@gandalf.local.home>
        <9cad73cd-1f8b-2f3f-cda4-99b89a87b931@huawei.com>
        <20230906072759.4e8bee1c@gandalf.local.home>
        <2667182e-691e-2ab4-4c2d-a47d76f38107@huawei.com>
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

On Wed, 6 Sep 2023 19:57:24 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> BTW, I do reproduce with following testcase fix, then just run: 
> ./ftracetest test.d/instances/instance-event.tc
> diff --git 
> a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc 
> b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> index 0eb47fbb3f44..42422e425107 100644
> --- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> +++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> @@ -39,7 +39,7 @@ instance_read() {
> 
>   instance_set() {
>           while :; do
> -                echo 1 > foo/events/sched/sched_switch
> +                echo 1 > foo/events/sched/sched_switch/enable
>           done 2> /dev/null
>   }

Ah thanks. I didn't have that on my test box :-p

Although I'm still having issues reproducing it. Do you have anything
special on your kernel command line?

-- Steve
