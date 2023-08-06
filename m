Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB3771460
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHFKQ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHFKQz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 06:16:55 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D64B131;
        Sun,  6 Aug 2023 03:16:51 -0700 (PDT)
X-QQ-mid: bizesmtp86t1691316998tvucykia
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 18:16:37 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: zT6n3Y95oi3UNBq/05tBwfN55E8F18HQLKieo6XoWqFlFdZ4Ww8tTuCZhEv96
        1J91u0seLhK/NAc69RMunx9iy5hL9Qzb2ww2dC0niCNoAcS4v/Ws10Y1PXDhlBs05jPuF/R
        3lqIn4CbvtqAo/exiy3Q1hgkbZu9BldgDax85supGkDY7sNInD06V+ChRpkn3Ef7lD2PZvL
        GJvwM8SV+C5+6MvFdQHW+b2TajwusYHvmi59SFpW2RXroLOXmCYEa0zMgOfSeKGZnLXoeGx
        fkrxYNKD8lW4RkKs0Hed8IhQefR/iZJ9iyMtIpb7fz/Ogy61Tymnawu+ePGIeOjEmXnLU+k
        01NPgsXhGgfMkYZODlzt5Dzf24Mtxc1jfp27BztU3nFHjRDMU48V9YAweQ7Pg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16725939209030767129
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 7/8] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Sun,  6 Aug 2023 18:16:36 +0800
Message-Id: <20230806101636.14407-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230806100410.GC10627@1wt.eu>
References: <20230806100410.GC10627@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It uses 'eval $(1) = $(2)' style, no real 'override' as the name shows
;-)

> > But you did find a bug above, we should include it again here to avoid not
> > break the possibility of using llvm (still require to check if there are some
> > other regressions):
> > 
> >    include ../../../scripts/Makefile.include
> > 
> > And I have further found there is another cc-cross-prefix helper from:
> > 
> >     $ grep cc-cross-prefix -ur scripts/
> >     scripts/Makefile.compiler:# cc-cross-prefix
> >     scripts/Makefile.compiler:# Usage: CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
> >     scripts/Makefile.compiler:cc-cross-prefix = $(firstword $(foreach c, $(1), \
> > 
> > So, we are able to search the toolchains from Arnd's, local toolchains and ...,
> > may not need to force users to use which one, I will do more tests on it.
> > 
> > Please don't merge this patch too, to avoid break anything, let's tune it
> > carefully in our v2 and delay the whole stuff to v6.7.
> 
> OK. Note that in the end it might be less difficult to try to set
> CROSS_COMPILE *before* including the general include instead of
> after: we could preset CROSS_COMPILE based on the ARCH/XARCH we know
> at this step, as this is not expected to rely on auto-detection.
>

A simple tests shows, we are able to simply move the include after our
customize lines:

    diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
    index 1f7c36fbe083..ed21dc393dc0 100644
    --- a/tools/testing/selftests/nolibc/Makefile
    +++ b/tools/testing/selftests/nolibc/Makefile
    @@ -1,6 +1,4 @@
     # SPDX-License-Identifier: GPL-2.0
    -# Makefile for nolibc tests
    -include ../../../scripts/Makefile.include
     # We need this for the "cc-option" macro.
     include ../../../build/Build.include

    diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
    index 228a95e65113..91a2a546954c 100644
    --- a/tools/testing/selftests/nolibc/Makefile
    +++ b/tools/testing/selftests/nolibc/Makefile
    @@ -55,6 +55,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
     IMAGE            = $(IMAGE_$(XARCH))
     IMAGE_NAME       = $(notdir $(IMAGE))

    +# CROSS_COMPILE: cross toolchain prefix by architecture
    +CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
    +
    +# make sure CC is prefixed with CROSS_COMPILE
    +include ../../../scripts/Makefile.include

Thanks,
Zhangjin

> Willy
