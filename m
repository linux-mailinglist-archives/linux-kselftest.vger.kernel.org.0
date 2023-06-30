Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5C743A9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 13:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjF3LQq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 07:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjF3LOw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 07:14:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D9199B;
        Fri, 30 Jun 2023 04:14:45 -0700 (PDT)
X-QQ-mid: bizesmtp88t1688123675tcy9lucv
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 19:14:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: eSZ1CZgv+JBp2tKVZu1rONM6SQDFA2JgnZMV6noUr51nU2G6TWg+ZG6E6OVLo
        7TEmSXkzLzc7+uyH+G63P68de5WvwaA7en6pqZv9/QFfXVU0l3ujxSZAuSjD2hweQTjiu+t
        lVS3GF9ksffTBMlu+i1RVU0hOP9I3rFnhdW9TC1XG7RFi+TrGF9WZkNarbjKWctijXvdA5P
        /Q/lG3CoWkm4Zua4F53KHVWNXu30AmptHh7JEuovtRieljoU4H5KkxvlwT2/d0LiqgmqR5E
        v9BSnsAQVipWVT7iajXO3CcAfs9hmKs5SiIMJ65W8zpplm0bBYT/h2i8pV3uj3T4Kg+e0In
        bEDH7SzwveWrN/yZXvHrTDcmpijW/7ZrKKiS9eQKMwtCJppeETJ4jJ6Jr0yrw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5588585638812015083
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 13/15] selftests/nolibc: rename chroot_exe to chroot_tmpfile
Date:   Fri, 30 Jun 2023 19:14:33 +0800
Message-Id: <20230630111433.211130-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8665cddc-0ac8-497c-848e-aaa42398bf24@t-8ch.de>
References: <8665cddc-0ac8-497c-848e-aaa42398bf24@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-06-30 08:00:28+0800, Zhangjin Wu wrote:
> > For CONFIG_PROC_FS=n, let's use tmpfs and create a tmp file for
> > chroot_exe test.
> > 
> > Since chroot_exe is mainly testing the not directory case (ENOTDIR), so,
> > rename it to chroot_tmpfile may be better.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 1002e0267515..2e9eaa7efa6e 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -682,6 +682,8 @@ int run_syscall(int min, int max)
> >  	int ret = 0;
> >  	void *p1, *p2;
> >  	int has_gettid = 1;
> > +	const char *tmpfile = get_tmpfile("/tmp/dummy");
> > +	int has_tmpfile = tmpfile != NULL;
> >  
> >  	/* <proc> indicates whether or not /proc is mounted */
> >  	proc = stat("/proc", &stat_buf) == 0;
> > @@ -720,7 +722,7 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
> >  		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
> >  		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
> > -		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
> > +		CASE_TEST(chroot_tmpfile);    EXPECT_SYSER(has_tmpfile, chroot(tmpfile), -1, ENOTDIR); break;
> 
> get_tempfile() looks really weird.

Yes, it is, it has been used in another patch, but now, only has one user, let's remove it.

> Given that the nolibc implementation of chroot() is the most trivial
> imaginable in my opinion we can keep the current "chroot_exe" that is
> using procfs.
>

Just did some new tests, what about this one?

    -  CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
    +  CASE_TEST(chroot_exe);        EXPECT_SYSER2(1, chroot(proc ? "/proc/self/exe" : "/init"), -1, ENOENT, ENOTDIR); break;
 
"/init" added for !procfs, and ENOENT added for !/init ;-)

And for the chmod_tmpfile, it is changed to chmod_tmpdir like this:

    CASE_TEST(chmod_tmpdir);      mkdir("/tmp/blah", 0755); EXPECT_SYSZR(1, chmod("/tmp/blah", 0555)); rmdir("/tmp/blah"); break;

Not sure if it is possible to use a syscall to return the file path from the fd
without /proc/self/fd/<N>, if so, we could use the open(, O_TMPFILE...) method
to get a random tmpfile, just like the mktemp command does, will run strace on
it ;-)

Thanks,
Zhangjin

> >  		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
> >  		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
> >  		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
> > -- 
> > 2.25.1
> > 
