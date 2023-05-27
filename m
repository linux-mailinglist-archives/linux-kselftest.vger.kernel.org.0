Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B1B71329A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 07:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjE0FM5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 May 2023 01:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0FM4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 May 2023 01:12:56 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E92114;
        Fri, 26 May 2023 22:12:53 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 34R5Ccrb019728;
        Sat, 27 May 2023 07:12:38 +0200
Date:   Sat, 27 May 2023 07:12:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 13/13] tools/nolibc: sys_gettimeofday: riscv: use
 __NR_clock_gettime64 for rv32
Message-ID: <ZHGRRtEURNb9eUAP@1wt.eu>
References: <29e4b23d-27cb-4101-bfe9-c6b412222578@t-8ch.de>
 <20230527012635.19595-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527012635.19595-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Sat, May 27, 2023 at 09:26:35AM +0800, Zhangjin Wu wrote:
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

I also disagree with this approach. The purpose of nolibc is not to serve
"nolibc-test", but to serve userland programs in the most efficient way
possible in terms of code size. Nolibc-test only tries to reproduce a
number of well-known success and error cases that applications might
face, to detect whether or not we implemented our syscalls correctly and
if something recently broke on the kernel side. In no case should we
adapt the nolibc code to the tests run by nolibc-test.

What this means here is that we need to decide whether the pointer check
by the syscall is important for applications, in which case we should do
our best to validate it, or if we consider that we really don't care a
dime since invalid values will only be sent by bogus applications we do
not expect to support, and we get rid of the test. Note that reliably
detecting that a pointer is valid from userland is not trivial at all,
it requires to rely on other syscalls for the check and is racy in
threaded environments.

I tend to think that for gettimeofday() we don't really care about
invalid pointers we could be seeing here because I can't imagine a
single case where this wouldn't come from an application bug, so in
my opinion it's fine if the application crashes. The problem here is
for nolibc-test. But this just means that we probably need to revisit
the way we validate some failures, to only perform some of them on
native syscalls and not emulated ones.

One approach might consist in tagging emulated syscalls and using this
for each test. Originally we only had a 1:1 mapping so this was not a
question. But with all the remapping you're encountering we might have
no other choice. For example for each syscall we could have:

  #define _NOLIBC_sys_blah_native 0  // implemented but emulated syscall
  #define _NOLIBC_sys_blah_native 1  // implemented and native syscall

And our macros in nolibc-test could rely on this do skip some tests
(just skip the whole test if _NOLIBC_sys_blah_native is not defined,
and skip some error tests if it's 0).

Overall what I'm seeing is that rv32 integration requires significant
changes to the existing nolibc-test infrastructure due to the need to
remap many syscalls, and that this will result in much cleaner and more
maintainable code than forcefully inserting it there. Now that we're
getting a cleaner picture of what the difficulties are, we'd rather
work on these as a priority.

Regards,
Willy
