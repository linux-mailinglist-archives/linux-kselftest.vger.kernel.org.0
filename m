Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6709277A5F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHMKSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHMKSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 06:18:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9824BB5;
        Sun, 13 Aug 2023 03:18:14 -0700 (PDT)
X-QQ-mid: bizesmtp66t1691921887tkcb5cn4
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 13 Aug 2023 18:18:06 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: ILHsT53NKPg+283Ng5uzJw8wzVPjJUtToL2Upd9wguWGcvuktkz0Cb8zfndnC
        Sp3ooIf4EgIpqoRfz02WGLfNywNCUd1FYJTKRbquUYj0gikYPgcpw1iRR9Gg4iJKApTuodu
        O/8BY9uOE7FSPnwONltxJQjPLwnXBmRZgEx/MkDe2fr1LNmWAStJtnXy9z6BpYxx+CXgzkg
        DEFlXztMrKVx88ldZs1gSL/0ep7a7RnB6Id9ZpNx8dMnhubTl5UOvXbwWDJLbQPUaBv34nU
        2y1zk5Ttuc2lO/CjiDaBItJFuSZwDOZn/1yQkFpacOZZwk7x9CHit5cRANNwS3XnXvXSW5n
        yb26GUIj4RvGSh4h4xrDw/GtrVBVXcybU4gZX74VEm20MbPAVeauZqOWRJDkA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4624236649935335797
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 5/7] selftests/nolibc: customize CROSS_COMPILE for all architectures
Date:   Sun, 13 Aug 2023 18:18:05 +0800
Message-Id: <20230813101805.10885-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230813091625.GG8237@1wt.eu>
References: <20230813091625.GG8237@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sat, Aug 12, 2023 at 04:32:41AM +0800, Zhangjin Wu wrote:
> > +CROSS_COMPILE_i386      ?= x86_64-linux-
> > +CROSS_COMPILE_x86_64    ?= x86_64-linux-
> > +CROSS_COMPILE_x86       ?= x86_64-linux-
> > +CROSS_COMPILE_arm64     ?= aarch64-linux-
> > +CROSS_COMPILE_arm       ?= arm-linux-gnueabi-
> > +CROSS_COMPILE_mips      ?= mips64-linux-
> 
> Given that we don't support mips64, I'd suggest to ust mips-linux-
> instead here for now. That doesn't seem right to ask users to
> download a toolchain for a different architecture than the one
> supported just because we can adapt to it.
>

Agree very much, and the one below from patch 7/7 [1]:

    +CROSS_COMPILE_arm64     ?= aarch64-linux- aarch64-linux-gnu-
    +CROSS_COMPILE_arm       ?= arm-linux-gnueabi- arm-none-eabi-
    +CROSS_COMPILE_mips      ?= mips64-linux- mips64el-linux-gnuabi64-

It should be:

    +CROSS_COMPILE_mips      ?= mips-linux- mips-linux-gnu-gcc

And if necessary, the mips64-linux- line in the commit message of [1] should be
corrected too.

Thanks very much!

Best regards,
Zhangjin
[1]: https://lore.kernel.org/lkml/b06de47989e3138de3d178da0d705ad6560924ec.1691783604.git.falcon@tinylab.org/

> Willy

