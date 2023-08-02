Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9A76D33F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjHBQE3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjHBQET (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 12:04:19 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DF1BF1;
        Wed,  2 Aug 2023 09:04:12 -0700 (PDT)
X-QQ-mid: bizesmtp91t1690992239t4lqpxx1
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 00:03:58 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3533296546830657737
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        tanyuan@tinylab.org
Subject: Re: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Date:   Thu,  3 Aug 2023 00:03:58 +0800
Message-Id: <20230802160358.407890-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802103217.231036-1-falcon@tinylab.org>
References: <20230802103217.231036-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Hi Thomas

I'm so happy to share with you, we have solved all of the left found
issues, include the ones about ppc and the missing poweroff options for
the tinyconfig series, will renew both series ;-)

> Further compared the preprocessed files, found the root cause is the new
> compiler using 'no_stack_protector' instead of
> '__optimize__("-fno-stack-protector")'. And the attribute 'no_stack_protector'
> breaks our "omit-frame-pointer" like the failure with '-O0' we fixed before.
> 
> I checked some of the other architectures, they didn't have the same issue, but
> test shows the 'no_stack_protector' attribute does have such compability issue
> here.
> 
> I learned the commit message of tools/include/nolibc/compiler.h, seems
> __optimize__("-fno-stack-protector") is enough for all of the nolibc supported
> architectures? is it ok for us to simply give up 'no_stack_protector'
> eventully? otherwise, we should manually disable 'no_stack_protector' for
> ppc32:
> 
>     #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
>

Hello, any suggestion here? ;-)

BTW, we have found another -O0 + "omit-frame-pointer" regression with
gcc 13.1.0 on all architectures ("omit-frame-pointer" will be completely
ignored when -O0 passed whatever other internal optimize attribute like
'Os' we used together in commit '4dc4401991fc' for gcc < 11.1.0), Yuan
is doing more tests to confirm it, will open another discussion for it.

> Benefit from the __no_stack_protetor macro, we have no need to input
> __optimize__("-fno-stack-protector") for every new architecture, it may be the
> time to only use __optimize__("-fno-stack-protector"), am I missing something? 
> 
> > out that your willingness to work around some of the oddities met on
> > this one have resulted in a lot of drift away from the "keep it simple"
> > principle and significantly delayed the possibilities to integrate the
> > rest of your work. It would be much saner to only focus on ppc64/ppc64le
> > and figure later how to make ppc32 work (or decide not to support it if
> > it's not worth the effort in the end).
> 
> Another test shows, the run target of ppc64le with the big endian gcc 13.1.0
> toolchain has test startup failure (although we have verified run-user before,
> run-user ok! and run with local powerpc64le toolchain ok too!), I'm debugging
> this now, hope it not cost too much.

Just solved this, when -mabi=elfv2 supported by the toolchain (gcc
13.1.0 has this option), kernel will compile with this ABI, to align
with kernel, our user space application should use -mabi=elfv2 too if
toolchain support it, otherwise, test will simply fails at startup, this
solves it:

    $(call cc-option,-mabi=elfv2)

> 
> Another good news is, Yuan has found a working defconfig for ppc32 which has
> poweroff support and he is helping me narrowing down the exact options, this
> will eventually make us happy ;-)
>

We eventually find the missing poweroff option for ppc32, will update
the patches with them.

we also found such options for all of the nolibc supported
architectures, will add them in their tinyconfig support patches.

Thanks,
Zhangjin

> Thanks & Best regards,
> Zhangjin
> 
> > 
> > Regards,
> > willy
