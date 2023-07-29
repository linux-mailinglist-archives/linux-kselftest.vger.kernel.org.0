Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C327680CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjG2Roy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjG2Roy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 13:44:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA32D4A;
        Sat, 29 Jul 2023 10:44:51 -0700 (PDT)
X-QQ-mid: bizesmtp66t1690652681tcnl4nga
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 30 Jul 2023 01:44:40 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 9fp+MOMfZT3YqoIFnEF0OR1+VUODU5fW9D/nBjLNN/iaVhjhfAGZOllcpZ8mP
        2J5JVYtlo+v6bfIx58hIKWU47/7pBkbuiiwyyrjf6QdHPin1kemsXSR9VvBBczVypaFSJiO
        gsp1gBkjtdHNi9HPYsE+srpZplrNxWgQ+/e8Fnj/rvU/+0VNUTu2v+lBKnmOlTuKR2bLoCY
        GVFS/ACuGDM8ZxA6PdoWketPvw4POiLtrGPdOqqOhBYduagPKdBbqqsCxEl2NZ23JyYqoqW
        TDDfYQ31RnhwOvnlR8SCIyY+YdjrGiPd99nyfyU9Hwt64NHiIRBk7OoMRd+1eD0x8wqXkYE
        BzOc/m6xwU2uD72tOClYBltW/bVcLlvrdZU3mtr3jBrI8f+QYI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14227650704422558490
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 08/14] selftests/nolibc: string the core targets
Date:   Sun, 30 Jul 2023 01:44:40 +0800
Message-Id: <20230729174440.91556-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729171527.GD5219@1wt.eu>
References: <20230729171527.GD5219@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sat, Jul 29, 2023 at 05:54:47PM +0800, Zhangjin Wu wrote:
> > The 'defconfig' will only be triggered while there is no .config there,
> > I do think it is important, at the first time of using nolibc, I
> > directly run kernel but it fails for it has a manual defconfig
> > requirement every time, so, I do think a default defconfig for kernel
> > for the first run or after a mrproper is helpful, it doesn't modify any
> > .config for there is no one there.
> 
> On the opposite, that's yet another example of automatic stuff that for
> me adds zero value and just doubts in the user's head: "is it safe to
> call this with my own config or should I keep a safe copy of it?",
> "what will it use for the config?", "will the arch be correct if my
> current config references 32BIT and the generated default one switches
> it to 64?" etc.
> 
> Please let's not add unneeded dependencies and chaining. It does not
> help and makes it harder to restart at one specific step, thus lowers
> the overall value.
>

Ok, let's do subtraction, drop this one and the timeout two.

Thanks,
Zhangjin

> Willy
