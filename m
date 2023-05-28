Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6F713908
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE1KaI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE1KaH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 06:30:07 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 522BDBD;
        Sun, 28 May 2023 03:30:04 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34SATllc002024;
        Sun, 28 May 2023 12:29:47 +0200
Date:   Sun, 28 May 2023 12:29:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, thomas@t-8ch.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use
 __NR_ppoll_time64 for rv32
Message-ID: <20230528102947.GH1956@1wt.eu>
References: <83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com>
 <20230528082509.293250-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528082509.293250-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Sun, May 28, 2023 at 04:25:09PM +0800, Zhangjin Wu wrote:
> Just a status update ...
> 
> I'm working on the pure time64 and 64bit off_t syscalls support, it almost
> worked (tested on rv32/64, arm32/64), thanks very much for your suggestions.
> 
> It includes:
> 
> * Based on linux/types.h and
>     * Use 64bit off_t
>     * Use 64bit time_t
>     * the new std.h looks like this
> 
>     typedef uint32_t __kernel_dev_t;
>     
>     typedef __kernel_dev_t          dev_t;
>     typedef __kernel_ulong_t        ino_t;
>     typedef __kernel_mode_t         mode_t;
>     typedef __kernel_pid_t          pid_t;
>     typedef __kernel_uid32_t        uid_t;
>     typedef __kernel_gid32_t        gid_t;
>     typedef __kernel_loff_t         off_t;
>     typedef __kernel_time64_t       time_t;
>     typedef uint32_t                nlink_t;
>     typedef uint64_t                blksize_t;
>     typedef uint64_t                blkcnt_t;
> 
> * Use __kernel_timespec as timespec
> * Use 64bit time_t based struct timeval
>     * Disable gettimeofday syscall completely for 32bit platforms
>         * And disable the gettimeofday_bad1/2 test case too

When you say "disable", you mean "remap", right ? Or do you mean
"break in 2023 code that was expected to break only in 2038 after
the hardware supporting it no longer exists" ?

Thanks,
Willy
