Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868B2792F84
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbjIEUIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjIEUIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:41 -0400
X-Greylist: delayed 3733 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:08:37 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B728113;
        Tue,  5 Sep 2023 13:08:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B1FC433BA;
        Tue,  5 Sep 2023 18:45:33 +0000 (UTC)
Date:   Tue, 5 Sep 2023 14:45:52 -0400
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
Message-ID: <20230905144552.3b390a7a@gandalf.local.home>
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

Can you send me your config?

-- Steve
