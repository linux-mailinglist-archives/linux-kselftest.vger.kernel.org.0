Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CAB793E4F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjIFOEb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 10:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjIFOEb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 10:04:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC810D3;
        Wed,  6 Sep 2023 07:04:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81621C433C8;
        Wed,  6 Sep 2023 14:04:26 +0000 (UTC)
Date:   Wed, 6 Sep 2023 10:04:44 -0400
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
Message-ID: <20230906100444.7cdf6248@gandalf.local.home>
In-Reply-To: <77c3a142-0a03-8fa2-e5b5-cea9515065f4@huawei.com>
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
        <20230906094553.388cd787@gandalf.local.home>
        <77c3a142-0a03-8fa2-e5b5-cea9515065f4@huawei.com>
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

On Wed, 6 Sep 2023 22:01:35 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Will the qemu version have an impact? Mine is:

It shouldn't, but...

> 
> $ qemu-system-x86_64 --version
> QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.27)
> Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers


I'm using:

$ qemu-system-x86_64 --version
QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-5)
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

Maybe it's just that yours causes the race window to be bigger.

-- Steve
