Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32B077A5F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHMKFR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 06:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHMKFQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 06:05:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0121708;
        Sun, 13 Aug 2023 03:05:14 -0700 (PDT)
X-QQ-mid: bizesmtp84t1691921105ts8qluee
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 13 Aug 2023 18:05:04 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3jeIXmkp223a/1Nmgxc0vUbVpDIZ5vzf8TxSIOwOFdrc5a2HZkuX
        KW/iH8UUhDLpYSCf1X/tCKX40uyHVW85GaGQkbXIvJi0ZSm2lSycjVHfbtNv4TpK8nIJeP5
        5PQ5onpKrYtWTIj4mmTePzjQz0LWrVWo1RPfgL+4iS6qxA28zsB5t+2d2Bx1/GL7XA7Yn9E
        H6K3ItnTBuIhg17qSOSSW194N6qsWHFBD03KIPFrxAzA6x8AbuLtJwIf4whfuAFTbR6XbnP
        5iL77n/3HG6k1btLCg8pa9uar3vr/A4SuTqpSFcT1OA+DIs0khrkOTqUzkuypK/GgqRZtYV
        SfQjpF5sPHcz4QCloM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1082990782784997304
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 0/7] selftests/nolibc: customize CROSS_COMPILE for all supported architectures
Date:   Sun, 13 Aug 2023 18:05:03 +0800
Message-Id: <20230813100503.8613-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230813093734.GJ8237@1wt.eu>
References: <20230813093734.GJ8237@1wt.eu>
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

Hi, Willy

> Hi Zhangjin,
> 
> On Sat, Aug 12, 2023 at 04:27:01AM +0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > Here is v2 of the customized CROSS_COMPILE support, this helps a lot
> > during the testing of the other cross-arch nolibc changes:
> > 
> >     $ ARCHS="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390"
> >     $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch | grep status; done
> > 
> > Based on your suggestion, we did this changes:
> > 
> > - The qemu notes patch [1] is removed, welcome your doc file ;-)
> > - Arnd's crosstools are customized by default
> > - Import cc-cross-prefix to support local cross toolchains too
> > - Use mips64 toolchains for mips like x86_64 toolchains for i386, allow
> >   download less toolchains
> > - Use HOSTCC for libc-test compiling
> (...)
> 
> I think it's basically OK (just this mips64 thing). I've picked patch 3
> already since it's a fix. Once we agree on what to do there, I can queue
> it if that helps (I can modify mips64- to mips- in the patch if that's
> OK for you, no need to resend for this, just let me know).
>

It is ok for me, thanks ;-)

I thought somebody may add mips64 support soon, but we do only have mips
currently, it is fair to not use mips64 toolchain.

> I think that later I'll further extend XARCH with new variants to
> support ARMv5 and Thumb2, because we have different code for this
> and I continue to manually change the CFLAGS to test both.
>

Ok, what about further add x86_64 as the default variant for x86 (like ppc for
powerpc)? and then it is able to only resereve the variables for x86_64. I have
prepared a patch for this goal in our new tinyconfig patchset, it will further
avoid adding the same nolibc-test-x86.config and nolibc-test-x86_64.config.

Best regards,
Zhangjin

> Thanks,
> Willy
