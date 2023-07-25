Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C9761AE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjGYOEu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjGYOEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:04:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B71FC9;
        Tue, 25 Jul 2023 07:04:46 -0700 (PDT)
X-QQ-mid: bizesmtp74t1690293876tg58cvh3
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 22:04:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 5q30pvLz2icoF9hdwL4WDQiNv7OsU3zIhDB7OiE9gltG9XA/SdVsSyopCPbgm
        1QmH0/OUGyyBZB4lH0OA3hMZz470Vi9nNqS+jRrYZW1tdomCErw3jcZHyvJTp4wIy2rDvKT
        0mIQs5hawthK7EGHztCSLe+qtRWutiknO51LpMCTVUwSkvvlnQC7di4eUh5+V2sq2eoru2f
        AXgogj7H+Ir9smrqlP0cy/QF0+JjuJIoqsU7n2N6i45CTTdV5RGWqEbi+g5dCmRR51d7zrp
        iAXIdRVPqnYgb8M5IzV7v8GGUyz0iwekLheaiRz19yj61doajcz8fXQg7SivKDjeW37Ogwr
        ZoIiHSzvBkTWH37Dxguh0xN+ip6wPOEUsO3buBA/tDmHUaEVv97HqBUAM83HQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16957176899631373251
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 07/14] selftests/nolibc: defconfig: remove mrproper target
Date:   Tue, 25 Jul 2023 22:04:31 +0800
Message-Id: <20230725140431.36927-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722124603.GI17311@1wt.eu>
References: <20230722124603.GI17311@1wt.eu>
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

> On Wed, Jul 19, 2023 at 09:24:54PM +0800, Zhangjin Wu wrote:
> > The O=/path/to/kernel-<ARCH> option allows to build kernel for different
> > architectures in different output directories, in this scene, it doesn't
> > need the mrproper operation for defconfig anymore.
> > 
> > If really require to clean up the source code tree, let users run the
> > standalone mrproper target on demand.
> 
> But that's precisely what's going to make it more and more annoying
> to run simple tests. The mrproper was there precisely because one
> config at a time was being used, so without it we'll restart to see
> plenty of failures as it used to be before mrproper was added. I
> understand what you're trying to do with the O=, but then if you're
> already passing "O=", why not also pass "defconfig" ?
> 
> I mean, let's make sure this makefile is only used to manipulate
> the tests. It must not become a huge wrapper for the kernel makefile
> otherwise it will become extremely complicated to use to run just a
> simple test. And with this one and the last few ones, I'm starting
> to sense that I'll have to read a README to figure how to reliably
> run a test.
> 
> In my opinion, there are mainly two use cases :
>   - user, manually: commands should be short, forgiving to user
>     mistakes, and easy to remember. I.e. they're compatible with
>     upper-arrow, then enter.
> 
>   - scripts: these are the ones already running in loops with tons
>     of variables, setting object directories with O=$arch/... and
>     taking care of their own cleanups. These ones will already be
>     user-specific and can very well accomodate one or two extra
>     lines for a make mrproper or make defconfig if needed.
> 
> The second ones deserve thinking and control anyway. The first ones
> should mostly not fail for a user mistake and in the worst case waste
> a bit of their time by rebuilding something that could have been
> avoided. But I do want to prioritize the user here. And that's also
> why I want the makefile to be easy to read with as few macros as
> possible, because once it works for you, it's easy to figure what is
> being done, and how to exploit it from your scripts. The opposite is
> not true. Nobody reads a makefile full of macros to try to figure how
> to run their first test or why a test that worked once now fails.
>

Ok, let's reserve mrproper for defconfig and also for tinyconfig if we
add standalone target for it.

let's drop patch and the previous one.

Thanks,
Zhangjin

> Thanks,
> Willy
