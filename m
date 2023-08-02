Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0AA76CAF7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjHBKhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjHBKgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 06:36:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012E2D64;
        Wed,  2 Aug 2023 03:32:30 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690972338tkfrlw04
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 18:32:17 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: eSZ1CZgv+JBSYUJc7PFD3G6N17p6paGv1a8aco23EMsfHnoT1E30MoVGwBr4e
        QByHSsMbsLfPXEa+zRsmuRLbW2szMS4Hxre6acEx6Mjvio7Iqdq0AEWqfBvw1MZZL6ahf8U
        GLag5lZNVf1gcmDTa2VzXgpHIUlNXBe9XANo7MkoAYEYBbeXobgukJLqCMTgtLcroRSQ1c7
        rx0gP72pNkJ7FVMzKPyRFbDBZOt53RnWROigIiHHiglToR5AQI94rMMusfOc70Q7qpadhCW
        oEqNp1FVsqPQdEFbXBAkKQ6+PpQCxC/6imYhHr0urWr62Lg0yxvVBQOzBAkSCJBzqJkqYlc
        RdMArs8snvh5dwDiMDTftzxSKwkgdPTToB18f9li4AZ3s/foevBk9D4rUKY+s7Dt01qhZOx
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6677180004816281553
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Date:   Wed,  2 Aug 2023 18:32:17 +0800
Message-Id: <20230802103217.231036-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZMoKWheH5mrCXogy@1wt.eu>
References: <ZMoKWheH5mrCXogy@1wt.eu>
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

Hi, Willy, Hi Thomas

Good news for us ;-)

> Hi Zhangjin,
> 
> On Wed, Aug 02, 2023 at 01:21:50PM +0800, Zhangjin Wu wrote:
> > Hi, Willy, Thomas
> > 
> > Yuan is helping me to test this series and the tinyconfig series with
> > the latest compilers.
> > 
> > His first test found this ppc support failed with stackprotector when
> > using a newer compiler (I used an older compiler without stackprotector
> > for ppc), I'm debugging it, so, please ignore this revision too, of
> > course, if time allows, welcome to take a look at the other patches.
> > 
> > His other tests are trying to find out the exact poweroff support
> > options for every architecture one by one, let's fill this gap ...
> 
> Thanks for notifying us. I strongly suggest that you leave ppc32 aside
> for now, until the rest is completely validated and merged. It turns

Thanks very much, but good progress here ;-)

I compared some compilers and at last got the root cause of the ppc32
failure with stackprotector.

    //// gcc 13.1.0 from mirrors.edge.kernel.org

    $ make run-user XARCH=ppc -j4 CC=/labs/linux-lab/prebuilt/toolchains/ppc64le/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc
      ...
    Segmentation fault (core dumped)

      0 test(s):   0 passed,   0 skipped,   0 failed => status: success

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

    //// gcc 10 from ubuntu ppa 
 
    $ make run-user XARCH=ppc -j4 CC=/usr/bin/powerpc-linux-gnu-gcc-10
      ...
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

    $ grep stack run.out
    0 -fstackprotector                                               [OK]

And then compared the assemblies, found gcc 13.1.0 insert a bad
instruction at the beginning of _start() and break our stack eventually.

    start:
            stwu 1,-16(1) 

Further compared the preprocessed files, found the root cause is the new
compiler using 'no_stack_protector' instead of
'__optimize__("-fno-stack-protector")'. And the attribute 'no_stack_protector'
breaks our "omit-frame-pointer" like the failure with '-O0' we fixed before.

I checked some of the other architectures, they didn't have the same issue, but
test shows the 'no_stack_protector' attribute does have such compability issue
here.

I learned the commit message of tools/include/nolibc/compiler.h, seems
__optimize__("-fno-stack-protector") is enough for all of the nolibc supported
architectures? is it ok for us to simply give up 'no_stack_protector'
eventully? otherwise, we should manually disable 'no_stack_protector' for
ppc32:

    #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))

Benefit from the __no_stack_protetor macro, we have no need to input
__optimize__("-fno-stack-protector") for every new architecture, it may be the
time to only use __optimize__("-fno-stack-protector"), am I missing something? 

> out that your willingness to work around some of the oddities met on
> this one have resulted in a lot of drift away from the "keep it simple"
> principle and significantly delayed the possibilities to integrate the
> rest of your work. It would be much saner to only focus on ppc64/ppc64le
> and figure later how to make ppc32 work (or decide not to support it if
> it's not worth the effort in the end).

Another test shows, the run target of ppc64le with the big endian gcc 13.1.0
toolchain has test startup failure (although we have verified run-user before,
run-user ok! and run with local powerpc64le toolchain ok too!), I'm debugging
this now, hope it not cost too much.

Another good news is, Yuan has found a working defconfig for ppc32 which has
poweroff support and he is helping me narrowing down the exact options, this
will eventually make us happy ;-)

Thanks & Best regards,
Zhangjin

> 
> Regards,
> willy
