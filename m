Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF77789BAB
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 09:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjH0HJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 03:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjH0HJa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 03:09:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57951E0;
        Sun, 27 Aug 2023 00:09:25 -0700 (PDT)
X-QQ-mid: bizesmtp76t1693120152to4qhmj2
Received: from linux-lab-host.localdomain ( [116.30.127.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Aug 2023 15:09:11 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: mhgCCnGOC3zBXXZrve8spmu5rA4BAZw/BqKCcFYCz5lTN2Pboydlj1TV8z8Xe
        Qb4n3CE0MiqiRCAWbt2GGlsH962GOO0A/so6v2Y6B7znXDJttgiZ1KvhExRBvZ6uVnpEDBI
        kMdVCtZ2Lgt5fQ8S5d7zaxX90+00vgACUesXi1q3FtqedEAf4UajobgDdoy7WOwUnCBQHmR
        HPcCVJ0wYannfKUGi7si/QG293pbexmstR+CPxgl1iN8k4ODEAjwhXViSprLOIdNfVi9kpr
        opJum8+ahjJGcVfHgRDSchBxKV5ts9iOupKiRn8YBgVEACD2z6yr3DFzrKGh3Eo8TNUgBCv
        PN3Ai5KMCvHOo+0zJGgr2ephFZN7wDaI1vWsdf43IJ2mYpCFYW1w9UHLI3rWw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3324772232417533549
From:   Zhangjin Wu <falcon@tinylab.org>
To:     tanyuan@tinylab.org
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v2 3/3] selftests/nolibc: fix up O= option support
Date:   Sun, 27 Aug 2023 15:09:09 +0800
Message-Id: <20230827070909.6999-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <B0DD4BA059591F13+4c61dc98-4d70-4ab2-b4ca-81c0e6596482@tinylab.org>
References: <B0DD4BA059591F13+4c61dc98-4d70-4ab2-b4ca-81c0e6596482@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Yuan

> Hi Zhangjin and Willy,
> 
> On 8/26/2023 12:30 PM, Zhangjin Wu wrote:
[...]
> >
> >      ubuntu@linux-lab:/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc$ find sysroot/ -name "errno.h"
> >      sysroot/i386/include/errno.h
> >      sysroot/i386/include/asm-generic/errno.h
> >      sysroot/i386/include/asm/errno.h             --> here it is
> >      sysroot/i386/include/linux/errno.h
> >      sysroot/x86/include/errno.h
> >      sysroot/x86/include/asm-generic/errno.h
> >      sysroot/x86/include/asm/errno.h              --> here it is
> >      sysroot/x86/include/linux/errno.h
> >
> > That also means, to use O=out for run-user, we also need to use O=out for
> > defconfig (and kernel ...) too, otherwise, the top-level source code tree will
> > be polluated.
> >
> > Seems a manual mrproper on top-level source code tree is always required for a
> > new iteration, so, it may be ok to pick this patch with a note on the potential
> > error.
> 
> There are two potential solutions for addressing this issue.
> 
> The first option involves copying 
> 'linux/arch/x86/include/generated/uapi/asm/' to 'sysroot/x86/include/' 
> during the make of target headers_standalone.
>

Will this work when linux/arch/x86/include/generated/uapi/asm/ is stale?
for example, when linux/arch/x86/include/generated/uapi/asm/ is there
for v6.1, but we are installing v6.5 sysroot?

> The second approach entails displaying an error message when the code 
> tree is not clean and prompting users to manually execute 'make 
> mrproper'. In this case, we can utilize the target 'outputmakefile' from 
> the root makefile directly.
>

A question is, without O= option, will this 'outputmakefile' always
require to do mrproper (when we have already done defconfig, kernel or
run without O=)? but currently, seems we don't require to do so. 

Currently, the asm/errno.h is installed whenever the source code tree is
clean or not, the issue is asm/errno.h will not be installed only when
O= specified. The root solution may be the generic-y (or generated-y?) in
scripts/Makefile.asm-generic should be corrected to work with O= option?
but this common code want us to be more careful.

> Willy, which method do you prefer? Do you have any alternative 
> suggestions? :)
> 
> 
> Besides. using x86_64-linux-gnu- won't reproduce this issue. It searched 
> and found 'asm/errno.h' in '/usr/include/x86_64-linux-gnu', whereas 
> 'x86_64-linux' lacks these libraries.
>

So, the -gnu- toolchain may hide some issues in
scripts/Makefile.asm-generic for O= option.

Thanks,
Zhangjin
