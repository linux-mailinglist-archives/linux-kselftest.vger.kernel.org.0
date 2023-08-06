Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772F97714DE
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHFMRq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 08:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHFMRp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 08:17:45 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608A83;
        Sun,  6 Aug 2023 05:17:36 -0700 (PDT)
X-QQ-mid: bizesmtp89t1691324243trupm40v
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 20:17:22 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 90EFqYDyPxBTP5m3DLzHmXuOT9mOD+v49IApa/gpVXiNSyxVaLC+SpcbpD4B5
        QX6C9iPym9Fj4e84qs4ydTG2F8O/V2QDQS0lNJzRuJHv7cWfNnJR8mTFgtrP5o92OPK9hiE
        mrcuCcNfFzbUwjOWDctAEvGLxdie1hBu/YdpZ/AdG0j6++9DjCjUxc9ogM2aaBEtJT146g/
        1gJC7mlyAs0rnFAXQAiROh+k/PPB4aDqhup02HJ+oiDlGvaWrsHiaGPt0BvWgc8I8gjumgg
        i8nOjRMbuiDV2+HrlX7U6Me68JeJn3npJecgNg5poNzfV8xtMGrUlL2irgpn9XYGQmbb/Tb
        vUajLEyRQ2yB29AqUd7R0lQ8l20jYWSpL7hvsBnzXySAi6y1fxeALd7cvw3JXxmZdfuT58Y
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3912675406111922663
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 3/3] selftests/nolibc: fix up O= option support
Date:   Sun,  6 Aug 2023 20:17:21 +0800
Message-Id: <20230806121721.30774-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230806112122.GF10627@1wt.eu>
References: <20230806112122.GF10627@1wt.eu>
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

> On Sat, Aug 05, 2023 at 02:13:11PM +0800, Zhangjin Wu wrote:
> > To avoid pollute the source code tree and avoid mrproper for every
> > architecture switch, the O= argument must be supported.
> > 
> > Both IMAGE and .config are from the building directory, let's use
> > objtree instead of srctree for them.
> > 
> > If no O= option specified, means building kernel in source code tree,
> > objtree should be srctree in such case.
> > 
> > To support relative path, as suggested by Thomas, $(COMMAND_O) is used
> > to pass the O=$(ABSOLUTE_O) to the $(MAKE) commands.
> 
> Zhangjin, I cannot get this one to work, regardless of what I try:
> 
>    $ make -j8 O=$PWD/output-i386 nolibc-test XARCH=i386 CROSS_COMPILE=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux- CC=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux-gcc
>    (...)
>    CC      nolibc-test
>    In file included from sysroot/i386/include/stdio.h:14,
>                     from nolibc-test.c:13:
>    sysroot/i386/include/errno.h:10:10: fatal error: asm/errno.h: No such file or directory
>       10 | #include <asm/errno.h>
>          |          ^~~~~~~~~~~~~
>    compilation terminated.
>

Willy, I also just reproduced the issue, seems only i386 sysroot has no
asm/errno.h, will check why it is no rightly installed later.

    $ find sysroot/ -name "errno.h"
    sysroot/arm/include/errno.h
    sysroot/arm/include/asm-generic/errno.h
    sysroot/arm/include/asm/errno.h
    sysroot/arm/include/linux/errno.h
    sysroot/riscv/include/errno.h
    sysroot/riscv/include/asm-generic/errno.h
    sysroot/riscv/include/asm/errno.h
    sysroot/riscv/include/linux/errno.h
    sysroot/s390/include/errno.h
    sysroot/s390/include/asm-generic/errno.h
    sysroot/s390/include/asm/errno.h
    sysroot/s390/include/linux/errno.h
    sysroot/arm64/include/errno.h
    sysroot/arm64/include/asm-generic/errno.h
    sysroot/arm64/include/asm/errno.h
    sysroot/arm64/include/linux/errno.h
    sysroot/mips/include/errno.h
    sysroot/mips/include/asm-generic/errno.h
    sysroot/mips/include/asm/errno.h
    sysroot/mips/include/linux/errno.h
    sysroot/x86_64/include/errno.h
    sysroot/x86_64/include/asm-generic/errno.h
    sysroot/x86_64/include/asm/errno.h
    sysroot/x86_64/include/linux/errno.h
    sysroot/i386/include/errno.h
    sysroot/i386/include/asm-generic/errno.h
    sysroot/i386/include/linux/errno.h
    sysroot/powerpc/include/errno.h
    sysroot/powerpc/include/asm-generic/errno.h
    sysroot/powerpc/include/asm/errno.h
    sysroot/powerpc/include/linux/errno.h

> I'll leave it aside for now as I've spent way longer than I hoped on
> these series. I could take the previous two patches however.
>

Ok, let's ignore this one, I will find why sysroot not install well for i386.

Thanks,
Zhangjin

> Thanks,
> Willy
