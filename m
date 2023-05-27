Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419471322F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 05:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjE0Dju (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 23:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0Djr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 23:39:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EE8EA;
        Fri, 26 May 2023 20:39:43 -0700 (PDT)
X-QQ-mid: bizesmtp68t1685158778t8e4mrur
Received: from localhost.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 May 2023 11:39:36 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: mdpNu8XZCyCi4LvvLx7OdFvp/vpXARmkS5idFTDCHgkzfDC+fj4NC1rFle0VI
        GnqswCHld1I8GbOisvsAwaXT56Nqz1LLLITw4ScrHKahWQ11jT7qd+jg+rzxm7pMLJobVIc
        b8dQy4FC90bUzdU3FHaS+FkKyvDFBc8WCppDNR8MeMwGmcvD0N0zqcR9D8g0TXOQfpYmXT3
        R3zSr31KMyHXSypSzO9YrBjsKkdF3KBklmWgPvxXLuQXR1sXoCNUz/64JvXL+UOR6500Uz1
        9M4N4lvYsdNIVWOxyLgClmLASSsiCliY5IkhiTKTGsgw+ylpx7X1+KeQ5LXgEA+4kgpmTKs
        gSPu7krzk1vGffxhBiYhZku264mr6N034GMkEiwafPA8WwecF158JAxo4Az6Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 827569819390505217
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 13/13] tools/nolibc: sys_gettimeofday: riscv: use __NR_clock_gettime64 for rv32
Date:   Sat, 27 May 2023 11:39:36 +0800
Message-Id: <20230527033936.15465-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230527012635.19595-1-falcon@tinylab.org>
References: <20230527012635.19595-1-falcon@tinylab.org>
MIME-Version: 1.0
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

Hi, Thomas, Willy

> > On 2023-05-25 02:03:32+0800, Zhangjin Wu wrote:
> > > rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
> > > __NR_gettimeofday and __NR_clock_gettime after kernel commit d4c08b9776b3
> > > ("riscv: Use latest system call ABI"), use __NR_clock_gettime64 instead.
> > > 
> > > This code is based on src/time/gettimeofday.c of musl and
> > > sysdeps/unix/sysv/linux/clock_gettime.c of glibc.
> > > 
> > > Both __NR_clock_gettime and __NR_clock_gettime64 are added for
> > > sys_gettimeofday() for they share most of the code.
> > > 
> > > Notes:
> > > 
> > > * Both tv and tz are not directly passed to kernel clock_gettime*
> > >   syscalls, so, it isn't able to check the pointer automatically with the
> > >   get_user/put_user helpers just like kernel gettimeofday syscall does.
> > >   instead, we emulate (but not completely) such checks in our new
> > >   __NR_clock_gettime* branch of nolibc.
> > > 
> > > * kernel clock_gettime* syscalls can not get tz info, just like musl and
> > >   glibc do, we set tz to zero to avoid a random number.
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/include/nolibc/sys.h | 46 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > > 
> > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > index 2642b380c6aa..ad38cc3856be 100644
> > > --- a/tools/include/nolibc/sys.h
> > > +++ b/tools/include/nolibc/sys.h
> > > @@ -26,6 +26,7 @@
> > >  
> > >  #include "arch.h"
> > >  #include "errno.h"
> > > +#include "string.h"
> > >  #include "types.h"
> > >  
> > >  
> > > @@ -51,6 +52,11 @@
> > >   * should not be placed here.
> > >   */
> > >  
> > > +/*
> > > + * This is the first address past the end of the text segment (the program code).
> > > + */
> > > +
> > > +extern char etext;
> > >  
> > >  /*
> > >   * int brk(void *addr);
> > > @@ -554,7 +560,47 @@ long getpagesize(void)
> > >  static __attribute__((unused))
> > >  int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
> > >  {
> > > +#ifdef __NR_gettimeofday
> > >  	return my_syscall2(__NR_gettimeofday, tv, tz);
> > > +#elif defined(__NR_clock_gettime) || defined(__NR_clock_gettime64)
> > > +#ifdef __NR_clock_gettime
> > > +	struct timespec ts;
> > > +#else
> > > +	struct timespec64 ts;
> > > +#define __NR_clock_gettime __NR_clock_gettime64
> > > +#endif
> > > +	int ret;
> > > +
> > > +	/* make sure tv pointer is at least after code segment */
> > > +	if (tv != NULL && (char *)tv <= &etext)
> > > +		return -EFAULT;
> > 
> > To me the weird etext comparisions don't seem to be worth it, to be
> > honest.
> >
> 
> This is the issue we explained in commit message:
> 
>     * Both tv and tz are not directly passed to kernel clock_gettime*
>       syscalls, so, it isn't able to check the pointer automatically with the
>       get_user/put_user helpers just like kernel gettimeofday syscall does.
>       instead, we emulate (but not completely) such checks in our new
>       __NR_clock_gettime* branch of nolibc.
> 
> but not that deeply described the direct cause, the direct cause is that the
> test case passes a '(void *)1' and the kernel space of gettimeofday can simply
> 'fixup' this issue by the get_user/put_user helpers, but our user-space tv and
> tz code has no such function, just emulate such 'fixup' by a stupid etext
> compare to at least make sure the data pointer is in data range. Welcome better
> solution.
> 
>     CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
>     CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
> 
> Without this ugly check, the above cases would get such error:
> 
>     35 gettimeofday_bad1init[1]: unhandled signal 11 code 0x1 at 0x00000002 in init[10000+5000]
>     CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-rc1-00134-gf929c7b7184f-dirty #20
>     Hardware name: riscv-virtio,qemu (DT)
>     epc : 00012ccc ra : 00012ca8 sp : 9d254d90
>      gp : 00016800 tp : 00000000 t0 : 00000000
>      t1 : 0000000a t2 : 00000000 s0 : 00000001
>      s1 : 00016008 a0 : 00000000 a1 : 9d254da8
>      a2 : 00000014 a3 : 00000000 a4 : 00000000
>      a5 : 00000000 a6 : 00000001 a7 : 00000193
>      s2 : 00000023 s3 : 9d254da4 s4 : 00000000
>      s5 : 00000000 s6 : 0000541b s7 : 00000007
>      s8 : 9d254dcc s9 : 000144e8 s10: 00016000
>      s11: 00000006 t3 : 00000000 t4 : ffffffff
>      t5 : 00000000 t6 : 00000000
>     status: 00000020 badaddr: 00000002 cause: 0000000f
> 
> Will at least append this test error in the commit message of the coming new
> revision of this patch.
> 
> Hi, Willy, this also require your discussion, simply remove the above
> two test cases may be not a good idea too, the check for gettimeofday is
> perfectly ok.
> 

What about this? Just like Willy did in 1da02f51088 ("selftests/nolibc:
support glibc as well"), Let's only limit the test case under the
__NR_gettimeofday #ifdef:

    diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
    index 702bf449f8d7..d52f3720918e 100644
    --- a/tools/testing/selftests/nolibc/nolibc-test.c
    +++ b/tools/testing/selftests/nolibc/nolibc-test.c
    @@ -563,7 +563,7 @@ int run_syscall(int min, int max)
     		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
     		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
     		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
    -#ifdef NOLIBC
    +#if defined(NOLIBC) && defined(__NR_gettimeofday)
     		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
     		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
     #endif

With the above change, we can simply remove the ugly etext check like this:

    diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
    index d1d26da306b7..ebe8ed018db6 100644
    --- a/tools/include/nolibc/sys.h
    +++ b/tools/include/nolibc/sys.h
    @@ -572,17 +572,9 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
     #endif
     	int ret;
     
    -	/* make sure tv pointer is at least after code segment */
    -	if (tv != NULL && (char *)tv <= &etext)
    -		return -EFAULT;
    -
     	/* set tz to zero to avoid random number */
    -	if (tz != NULL) {
    -		if ((char *)tz > &etext)
    -			memset(tz, 0, sizeof(struct timezone));
    -		else
    -			return -EFAULT;
    -	}
    +	if (tz != NULL)
    +		memset(tz, 0, sizeof(struct timezone));
     
     	if (tv == NULL)
     		return 0;
    

If agree, will apply this method in the next revision.

> The same 'emulate' method is used in the waitid patch, but that only
> requires to compare 'pid == INT_MIN', which is not that weird.
> 
> > > +
> > > +	/* set tz to zero to avoid random number */
> > > +	if (tz != NULL) {
> > > +		if ((char *)tz > &etext)
> > > +			memset(tz, 0, sizeof(struct timezone));
> > > +		else
> > > +			return -EFAULT;
> > > +	}
> > > +
> 
> The same issue here.
>

And the one for waitid may work like this:

    @@ -1390,10 +1382,6 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
     	int idtype = P_PID;
     	int ret;
     
    -	/* emulate the 'pid == INT_MIN' path of wait4 */
    -	if (pid == INT_MIN)
    -		return -ESRCH;
    -
     	if (pid < -1) {
     		idtype = P_PGID;
     		pid *= -1;
    @@ -593,7 +593,9 @@ int run_syscall(int min, int max)
     		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
     		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
     		CASE_TEST(wait_child);        EXPECT_SYSER(1, wait(&tmp), -1, ECHILD); break;
    +#ifdef __NR_wait4
     		CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, ESRCH); break;
    +#endif
     		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
     		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
     		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;

Best regards,
Zhangjin
