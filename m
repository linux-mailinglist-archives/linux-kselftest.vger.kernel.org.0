Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3324A754837
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjGOKkA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGOKj7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 06:39:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073B3A8E;
        Sat, 15 Jul 2023 03:39:54 -0700 (PDT)
X-QQ-mid: bizesmtp67t1689417583tms82huj
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 15 Jul 2023 18:39:42 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: CR3LFp2JE4nK18uNrjmdV9g1LWuVN/HuTB5VcUN/LSXQmVHH627ibbLWF3EoP
        jxg1SUQtg8Ab/3irnsRim8wkPy2/94whnTf54sTuaEQqYU7bDRxq1snain4OiUEAhU92fEG
        hD8HopxqfsmvfWh0GZmu4NvUwtCTvR0wjZxyLiQYnij+wDMhlqK5QI9+RCajsflCFzXA3qw
        ueVx7yCIXLzwTTSmxkRf9fhhT35aZL8RdS987B+bJzU6GxalyspKHrQcKY/LaVScl70GFyd
        lSOaIEEUeZz7SL3HUqhVH1JPDqbzXEnYpKCBnbFbVbDmVlnV09z/hCy6S9usq34RfSEvSeO
        vn/MOI6yNemB9eHR7jIlZI7a1eb6gB+565+vQPQKBxKs2ZUxajuXHxK+zjhuw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3909186012897845147
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 01/11] tools/nolibc: remove the old sys_stat support
Date:   Sat, 15 Jul 2023 18:39:41 +0800
Message-Id: <20230715103941.341262-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230715085942.GB24086@1wt.eu>
References: <20230715085942.GB24086@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hi Zhangjin,
> 
> On Wed, Jul 12, 2023 at 05:16:34PM +0800, Zhangjin Wu wrote:
> > __NR_statx has been added from v4.10:
> > 
> >     commit a528d35e8bfc ("statx: Add a system call to make enhanced file info available")
> > 
> > It has been supported by all of the platforms since at least from v4.20
> > and glibc 2.28.
> > 
> > Let's remove the old arch related and dependent sys_stat support
> > completely.
> > 
> > This is friendly to the future new architecture porting.
> 
> As I previously said, I'd like that we at least preserve compatibility
> with supported stable branches. 4.14 and 4.19 are still supported, so
> does this mean that if I rebuild my preinit against the updated nolibc
> it will fail to boot on such older systems for the archs that we support?
>
> Because if it means that in order to support all currently active
> kernels, one must only build from an older copy of the lib, that becomes
> a disservice to its development and usage. Thus if you checked that aarch64,
> arm, i386, mips, riscv, s390 and x86_64 had already adopted statx by 4.14,
> then I'm fine and we can drop stat(), but then it must be mentioned in
> the commit message, because here it's not explicit.
>

Yeah, we used 'git blame' before and found the last related change is
v4.20, but it is not really the first change.

Just read the statx manpage again:

    https://man7.org/linux/man-pages/man2/statx.2.html

It shows something about "Linux 4.11, glibc 2.28.

And 'git grep' shows it is true:

    $ git grep -r statx v4.11 arch/ include/uapi/asm-generic/unistd.h | grep -E "aarch64|arm|mips|s390|x86|:include/uapi"
    v4.11:arch/arm/tools/syscall.tbl:397	common	statx			sys_statx
    v4.11:arch/arm64/include/asm/unistd32.h:#define __NR_statx 397
    v4.11:arch/arm64/include/asm/unistd32.h:__SYSCALL(__NR_statx, sys_statx)
    v4.11:arch/mips/include/uapi/asm/unistd.h:#define __NR_statx			(__NR_Linux + 366)
    v4.11:arch/mips/include/uapi/asm/unistd.h:#define __NR_statx			(__NR_Linux + 326)
    v4.11:arch/mips/include/uapi/asm/unistd.h:#define __NR_statx			(__NR_Linux + 330)
    v4.11:arch/mips/kernel/scall32-o32.S:	PTR	sys_statx
    v4.11:arch/mips/kernel/scall64-64.S:	PTR	sys_statx
    v4.11:arch/mips/kernel/scall64-n32.S:	PTR	sys_statx			/* 6330 */
    v4.11:arch/mips/kernel/scall64-o32.S:	PTR	sys_statx
    v4.11:arch/s390/include/uapi/asm/unistd.h:#define __NR_statx		379
    v4.11:arch/s390/kernel/compat_wrapper.c:COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags, unsigned, mask, struct statx __user *, buffer);
    v4.11:arch/s390/kernel/syscalls.S:SYSCALL(sys_statx,compat_sys_statx)
    v4.11:arch/x86/entry/syscalls/syscall_32.tbl:383	i386	statx			sys_statx
    v4.11:arch/x86/entry/syscalls/syscall_64.tbl:332	common	statx			sys_statx
    v4.11:include/uapi/asm-generic/unistd.h:#define __NR_statx 291
    v4.11:include/uapi/asm-generic/unistd.h:__SYSCALL(__NR_statx,     sys_statx)

both riscv and loongarch use the generic unistd.h, so, all of our
supported archs should work as-is. riscv itself is added from v4.15,
loongarch itself is added from v5.19.

The powerpc we plan to support is from v4.11:

    $ git grep -r statx v4.11 arch/powerpc/
    v4.11:arch/powerpc/include/asm/systbl.h:SYSCALL(statx)
    v4.11:arch/powerpc/include/uapi/asm/unistd.h:#define __NR_statx         383

So, let's simply correct the commit message (the old v4.10 has a wrong -1
offset, I wrongly used 'git show a528d35e8bfc:Makefile' before).

    sys_statx has been supported from Linux v4.11 and glibc 2.28:

        $ git grep -r statx v4.11 arch/ include/uapi/asm-generic/unistd.h

    Both riscv (firstly added from v4.15) and loongarch (firstly added from
    v5.19) use the generic unistd.h, the others are supported from arch/.
 
    Let's remove the old arch related and dependent sys_stat support
    completely.

    Since the current oldest stable branch is v4.14, so, using statx
    instead of sys_stat preserves compatibility with all of the
    supported stable branches.
    
    This is friendly to the future new architecture porting.

Best regards,
Zhangjin

> Thanks!
> Willy
