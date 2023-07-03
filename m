Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26697456F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGCIHf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 04:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGCIHY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 04:07:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD33D1710;
        Mon,  3 Jul 2023 01:07:10 -0700 (PDT)
X-QQ-mid: bizesmtp65t1688371613txz6f5uw
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 16:06:52 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: C46Rb8GPIEdHxAFCE3BvkSlNOAIZKwGCuo6b9oMnIg2+3RsnASJ4Odgdn480K
        D9O/zHQs9+SI0waAap24x1DtHFT1YhLFoXm+IHocqEYwW6JswgvloZwfQAJN6UsHkvyaP9x
        QyBfBnAjQS8LVnCs302OFPUOYjidAiN/QvVkBaZGWrOwLLOZotAu8RmowxqfgV/oY7Kp6Rx
        q2GZuLW+0aFiIafX5uuKHRaz+7efPvRT8FTu1WQZrCDywPojQ0HrrqkoL49Q1GenSQ+3x14
        g/7TqCVqZOHLLlXzTLGfS0VAr0TFd7f+RwSYEOw4TIw4AtYEt2zSett+Kx0g+o/bTv4XZtb
        qQevDcOllpzai0lcp+5UgkPNFxGHTFnhRL6r+g56jEEFEc4T7w=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 351077419301285196
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Date:   Mon,  3 Jul 2023 16:06:47 +0800
Message-Id: <20230703080647.491363-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZKJ35DyPOG+LAy5j@1wt.eu>
References: <ZKJ35DyPOG+LAy5j@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Mon, Jul 03, 2023 at 02:03:23PM +0800, Zhangjin Wu wrote:
> > > > - the others, for kernel without procfs
> > > >   let it pass even with 'worst case' kernel configs
> > > 
> > > You should include /dev/zero, which is commonly used to allocate anonymous
> > > memory and is more likely present and readable than any of the other files.
> > > And another file of choice is obviously argv[0] ;-)  In this case you don't
> > > need any of the other extra ones. Thus I could suggest that you try in this
> > > order:
> > > 
> > >     /dev/zero, /proc/self/exe, /proc/1/exe, argv[0]
> > > 
> > > and be done with it. That doesn't prevent one from extending the list if
> > > really needed later, but I doubt it would be needed. Also, it's already
> > > arranged in a read-write, then read-only fallbacks mode, so if we later
> > > need to add more complex tests involving writes, the writable /dev/zero
> > > will have precedence.
> > >
> > 
> > Cool, both /dev/zero and argv[0] are very good candidates ;-)
> > 
> > Just verified both of them, works perfectly.
> > 
> > - /dev/zero
> > 
> >   we need to mknod it in prepare()
> 
> Indeed.
> 
> >   and also, in test_mmap_munmap(),
> >   stat() return a zero size of /dev/zero, in this case, we should assign
> >   a non-zero file_size ourselves.
> > 
> >     -       file_size = stat_buf.st_size;
> >     +       /* file size of the special /dev/zero is 0, let's assign one manually */
> >     +       if (i == 0)
> >     +               file_size = 3*page_size - 1;
> >     +       else
> >     +               file_size = stat_buf.st_size;
> 
> OK but why this -1 ? That doesn't sound right, unless you explicitly want
> a file size that's not multiple of a page size for whatever reason ?
>

Just make sure the file size is a litle random, not just aligned with
PAGE_SIZE, it is ok without '-1' ;-)

> > - argv[0]
> > 
> >   since nolibc has no realpath() currently, we can simply
> >   support the current path and the absolute path like this:
> > 
> >     nolibc-test.c:
> > 
> >     /* assigned as argv[0] in main(), will be used by some tests */
> >     static char exe[PATH_MAX + 1];
> > 
> >     main():
> > 
> >     /* get absolute path of myself, nolibc has no realpath() currently */
> >     #ifndef NOLIBC
> >             realpath(argv[0], exe);
> >     #else
> >             /* assume absolute path has no "./" */
> >             if (strncmp(argv[0], "./", 2) != 0)
> >                     strncat(exe, argv[0], strlen(argv[0]) + 1);
> >             else {
> >                     pwd = getenv("PWD");
> >                     /* skip the ending '\0' */
> >                     strncat(exe, getenv("PWD"), strlen(pwd));
> >                     /* skip the first '.' */
> >                     strncat(exe, argv[0] + 1, strlen(argv[0]));
> >             }
> >     #endif
> 
> No, please, not like this. Just copy argv[0] (the pointer not the
> contents) and you're fine:
>
>     static const char *argv0;
> 
>     int main(int argc, char **argv, char **envp)
>     {
>             argv0 = argv[0];
>             ...
>     }
> 
> Nothing more, nothing less. Your program will always have its correct
> path when being called unless someone purposely forces it to something
> different, which is not our concern at all since this is a test program.
> And I'd rather call it "argv0" which exactly tells us what it contains
> than "exe" which can be misleading for that precise reason.
>

Yeah, locally, I just used a global argv0 pointer directly, but
chroot_exe("./nolibc-test") not work when run 'libc-test' in host
system, that is why I tried to get an absolute path ;-)

    CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(exe), -1, ENOTDIR); break;

    -->

    19 chroot_exe = -1 ENOENT  != (-1 ENOTDIR)                      [FAIL]

I removed the "proc ?" check manually to test if it also work with
CONFIG_PROC_FS=n. it doesn't work, without absolute path, we need to add
the ENOENT errno back to the errno check list.

I'm not sure if the other syscalls require an absolute path, so, the
realpath() is called in this proposed method.

> > A full functional realpath() is a little complex, such as '../' support and
> > even symlink support, let's delay its requirement at current stage ;-)
> 
> Please do not even engage into this, and keep in mind that the sole
> purpose of this test program is to help developers simply add tests to
> the set of existing ones. If the program becomes complex for doing stuff
> that is out of its scope, it will become much harder to extend and users
> will lose interest and motivation for updating it.
> 
> > one or both of them may also help the other test cases:
> > 
> > - chroot_exe (used '/init' before)
> > 
> >     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(proc ? "/proc/self/exe" : exe), -1, ENOTDIR); break;
> > 
> > - chmod_exe (replace the one: chmod_tmpdir in another patchset)
> > 
> >     CASE_TEST(chmod_exe);       EXPECT_SYSZR(1, chmod(proc ? "/proc/self/exe" : exe, 0555)); break;
> > 
> >     It should be safe enough to only remove the writable attribute for the test
> >     program.
> > 
> > - stat_timestamps (used '/init' before)
> > 
> >     if (stat("/proc/self/", &st) && stat(exe, &st) && stat("/dev/zero", &st) && stat("/", &st))
> 
> Indeed, why not!
>

Ok, without absolute path, the chroot_exe() will be changed back to
something like this:

    CASE_TEST(chroot_exe);        EXPECT_SYSER2(1, chroot(proc ? "/proc/self/exe" : argv0), -1, ENOTDIR, ENOENT); break;

Best regards,
Zhangjin

> > Will update the related patches with them.
> 
> OK thanks!
> Willy
