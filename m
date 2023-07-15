Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E75754876
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGOLpw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGOLpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 07:45:51 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B9B135B7;
        Sat, 15 Jul 2023 04:45:48 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36FBjSYx025959;
        Sat, 15 Jul 2023 13:45:28 +0200
Date:   Sat, 15 Jul 2023 13:45:28 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 01/11] tools/nolibc: remove the old sys_stat support
Message-ID: <20230715114528.GA25953@1wt.eu>
References: <20230715085942.GB24086@1wt.eu>
 <20230715103941.341262-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715103941.341262-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 15, 2023 at 06:39:41PM +0800, Zhangjin Wu wrote:
> Just read the statx manpage again:
> 
>     https://man7.org/linux/man-pages/man2/statx.2.html
> 
> It shows something about "Linux 4.11, glibc 2.28.
> 
> And 'git grep' shows it is true:
> 
>     $ git grep -r statx v4.11 arch/ include/uapi/asm-generic/unistd.h | grep -E "aarch64|arm|mips|s390|x86|:include/uapi"
>     v4.11:arch/arm/tools/syscall.tbl:397	common	statx			sys_statx
>     v4.11:arch/arm64/include/asm/unistd32.h:#define __NR_statx 397
>     v4.11:arch/arm64/include/asm/unistd32.h:__SYSCALL(__NR_statx, sys_statx)
>     v4.11:arch/mips/include/uapi/asm/unistd.h:#define __NR_statx			(__NR_Linux + 366)
>     v4.11:arch/mips/include/uapi/asm/unistd.h:#define __NR_statx			(__NR_Linux + 326)
>     v4.11:arch/mips/include/uapi/asm/unistd.h:#define __NR_statx			(__NR_Linux + 330)
>     v4.11:arch/mips/kernel/scall32-o32.S:	PTR	sys_statx
>     v4.11:arch/mips/kernel/scall64-64.S:	PTR	sys_statx
>     v4.11:arch/mips/kernel/scall64-n32.S:	PTR	sys_statx			/* 6330 */
>     v4.11:arch/mips/kernel/scall64-o32.S:	PTR	sys_statx
>     v4.11:arch/s390/include/uapi/asm/unistd.h:#define __NR_statx		379
>     v4.11:arch/s390/kernel/compat_wrapper.c:COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags, unsigned, mask, struct statx __user *, buffer);
>     v4.11:arch/s390/kernel/syscalls.S:SYSCALL(sys_statx,compat_sys_statx)
>     v4.11:arch/x86/entry/syscalls/syscall_32.tbl:383	i386	statx			sys_statx
>     v4.11:arch/x86/entry/syscalls/syscall_64.tbl:332	common	statx			sys_statx
>     v4.11:include/uapi/asm-generic/unistd.h:#define __NR_statx 291
>     v4.11:include/uapi/asm-generic/unistd.h:__SYSCALL(__NR_statx,     sys_statx)
> 
> both riscv and loongarch use the generic unistd.h, so, all of our
> supported archs should work as-is. riscv itself is added from v4.15,
> loongarch itself is added from v5.19.

So that's perfect, thank you!

Willy
