Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9747138B5
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjE1IZa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1IZ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 04:25:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB899;
        Sun, 28 May 2023 01:25:26 -0700 (PDT)
X-QQ-mid: bizesmtp70t1685262312tra33cp0
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 May 2023 16:25:10 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: An8j/rhzjdGajJeEXw9TkdV6lrxosyLeWWZ9VDBE9LOjDBmydLX7wTGYZYvYx
        IwKElaEyNjmHyGHMKJab2Zt1BbXL2L2S9MY/mJeCcgY6mTf99g5K/h0OG/BKKizV3mavnde
        ya71KdKJ28Ku7Hfo4T20IWMGVjd6BtGAvJaYTaAXwJofSuE9Ux/o2inHP7SnyfazeXi+gDz
        VXqA7WmMfOdIlmM4yJeiy00K8pHgkMZ47UZcDbcTcelWgpAkerI87FRFSqmLXkrUAeublyI
        uxdnjZsrucnpXKh79cSi7lK503yfp97zHAoNLr5w4dBiLEfibrDqfmByEJqB/fjADX4NueH
        x2UMgq1b2R0TKKJT/AHXoqMQnWCFw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 107622595535614610
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de, thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64 for rv32
Date:   Sun, 28 May 2023 16:25:09 +0800
Message-Id: <20230528082509.293250-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com>
References: <83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Arnd, Thomas, Willy

> On Fri, May 26, 2023, at 09:15, Thomas Wei=C3=9Fschuh wrote:
> > On 2023-05-25 01:57:24+0800, Zhangjin Wu wrote:
> >> 
> >> +/* needed by time64 syscalls */
> >> +struct timespec64 {
> >> +	time64_t	tv_sec;		/* seconds */
> >> +	long		tv_nsec;	/* nanoseconds */
> >> +};
> >
> > A question to you and Willy, as it's also done the same for other types:
> >
> > What is the advantage of custom definitions over using the one from the
> > kernel (maybe via a typedef).
> >
> > From linux/time_types.h:
> >
> > struct __kernel_timespec {
> > 	__kernel_time64_t tv_set;
> > 	long long tv_nsec;
> > };
> 
> I agree the __kernel_* types are what we should be using when
> interacting with system calls directly, that is definitely what
> they are intended for.
> 
> I would go further here and completely drop support for 32-bit
> time_t/off_t and derived types in nolibc. Unfortunately, the
> kernel's include/uapi/linux/time.h header still defines the
> old types, this is one of the last remnants the time32 syscalls
> definitions in the kernel headers, and this already conflicts
> with the glibc and musl definitions, so anything that includes
> this header is broken on real systems. I think it makes most
> sense for nolibc to just use the linux/time_types.h header
> instead and use something like
> 
> #define timespec   __kernel_timespec
> #define itimerspec __kernel_itimerspec
> typedef __kernel_time64_t time_t;
> /* timeval is only provided for users, not compatible with syscalls */
> struct timeval { __kernel_time64_t tv_sec; __s64 tv_nsec; };
> 
> so we can drop all the fallbacks for old 32-bit targets. This
> also allows running with CONFIG_COMPAT_32BIT_TIME disabled.

Just a status update ...

I'm working on the pure time64 and 64bit off_t syscalls support, it almost
worked (tested on rv32/64, arm32/64), thanks very much for your suggestions.

It includes:

* Based on linux/types.h and
    * Use 64bit off_t
    * Use 64bit time_t
    * the new std.h looks like this

    typedef uint32_t __kernel_dev_t;
    
    typedef __kernel_dev_t          dev_t;
    typedef __kernel_ulong_t        ino_t;
    typedef __kernel_mode_t         mode_t;
    typedef __kernel_pid_t          pid_t;
    typedef __kernel_uid32_t        uid_t;
    typedef __kernel_gid32_t        gid_t;
    typedef __kernel_loff_t         off_t;
    typedef __kernel_time64_t       time_t;
    typedef uint32_t                nlink_t;
    typedef uint64_t                blksize_t;
    typedef uint64_t                blkcnt_t;

* Use __kernel_timespec as timespec
* Use 64bit time_t based struct timeval
    * Disable gettimeofday syscall completely for 32bit platforms
        * And disable the gettimeofday_bad1/2 test case too
    * Remove the oldselect and newslect path completely
    * The new types.h looks this:

    /* always use time64 structs in user-space even on 32bit platforms */
    #define timespec __kernel_timespec
    #define itimerspec __kernel_itimerspec

    /* timeval is only provided for users, not compatible with syscalls */
    struct __timeval64 {
    	__kernel_time64_t tv_sec;	/* seconds */
    	__s64 tv_usec;			/* microseconds */
    };
    /* override the 32bit version of struct timeval in linux/time.h */
    #define timeval __timeval64

    /* itimerval is only provided for users, not compatible with syscalls */
    struct __itimerval64 {
    	struct __timeval64 it_interval;	/* timer interval */
    	struct __timeval64 it_value;	/* current value */
    };
    /* override the 32bit version of struct itimerval in linux/time.h */
    #define itimerval __itimerval64

* Use __NR_*time64 for all 32bit platforms
* Use __NR_pselect6/ppoll/clock_gettime only for 64bit platforms
* New sizeof tests added to verify off_t, time_t, timespec, itimerspec...

   	CASE_TEST(sizeof_time_t);           EXPECT_EQ(1, 8,   sizeof(time_t)); break;
    	CASE_TEST(sizeof_timespec);         EXPECT_EQ(1, 16,  sizeof(struct timespec)); break;
    #ifdef NOLIBC
    	CASE_TEST(sizeof_itimerspec);       EXPECT_EQ(1, 32,  sizeof(struct itimerspec)); break;
    #endif
    	CASE_TEST(sizeof_timeval);          EXPECT_EQ(1, 16,  sizeof(struct timeval)); break;
    	CASE_TEST(sizeof_itimerval);        EXPECT_EQ(1, 32,  sizeof(struct itimerval)); break;
    	CASE_TEST(sizeof_off_t);            EXPECT_EQ(1, 8,   sizeof(off_t)); break;


@Arnd, the above timeval/itimerval definitions are used to override the ones
from linux/time.h to avoid such error:

    error: redefinition of ‘struct timeval’

    nolibc/sysroot/riscv/include/types.h:225:8: error: redefinition of ‘struct timeval’
      225 | struct timeval {
          |        ^~~~~~~
    In file included from nolibc/sysroot/riscv/include/types.h:11,
                     from nolibc/sysroot/riscv/include/nolibc.h:98,
                     from nolibc/sysroot/riscv/include/errno.h:26,
                     from nolibc/sysroot/riscv/include/stdio.h:14,
                     from tools/testing/selftests/nolibc/nolibc-test.c:12:
    nolibc/sysroot/riscv/include/linux/time.h:16:8: note: originally defined here
       16 | struct timeval {

@Arnd, As you commented in another reply, is it time for us to update
include/uapi/linux/time.h together and let it provide time64 timeval/itimerval
instead of the old ones? perhaps some libc's are still using them.

Or perhaps we can add a switch like __ARCH_WANT_TIME32_SYSCALLS, add a
__ARCH_WANT_TIME32_STRUCTS and simply bind it with __ARCH_WANT_TIME32_SYSCALLS?

About the above ugly override code, What's your suggestion in v2? ;-)

Best regards,
Zhangjin

> 
>      Arnd
