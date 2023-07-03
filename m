Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F944745543
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGCGDr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 02:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGCGDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 02:03:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E88BB;
        Sun,  2 Jul 2023 23:03:41 -0700 (PDT)
X-QQ-mid: bizesmtp68t1688364205t17ezhh7
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 14:03:24 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: ZgHZPTZ8fzM2scasbR4KDNmzDJ57tOJaycJ/uri88ZY5e961v5sezP2d2eDKd
        3MdVLM6sDzieW/jVdp4RNJ3nRvnXbXxXbGuQPhrYGOS3e/iPaCcunS/dl8B8d0KuCs7Rsmd
        JI8jk7TEjFMrn0lSPIoSvYGnrMwVR9p1BoIABpJsWbowe1RNCD+wpl1I4PSJ4nRE/Oa3FQY
        HRG0QxFy7CrQlfKOlUOphW+aVbdrXa4K869Z8zz5tGD5nPCJrcaT8fWKqXoYo/lohCk/+tA
        D0NTEWTwXJpfmls1KsrvfSeqtvAfzFPbkZhkNBlzorNCEacgiiPis39vsCRU442licX8Ol2
        hGnzTZOUkila+j5Mho=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11292108538094942741
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Date:   Mon,  3 Jul 2023 14:03:23 +0800
Message-Id: <20230703060323.487347-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702193306.GK16233@1wt.eu>
References: <20230702193306.GK16233@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hi Zhangjin,
> 
> On Wed, Jun 28, 2023 at 09:51:57PM +0800, Zhangjin Wu wrote:
> > Three mmap/munmap related test cases are added:
> > 
> > - mmap_bad: the length argument must be greater than 0, otherwise, fail
> >   with -EINVAL.
> > 
> > - munmap_bad: invalid (void *)-1 address fail with -EINVAL.
> > 
> > - mmap_munmap_good: mmap() a file with good offset and then munmap().
> > 
> > Note, it is not easy to find a unique file for mmap() in different
> > scenes, so, a file list is used to search the right one:
> > 
> > - /proc/1/exe, for 'run' and 'run-user' target
> >   'run-user' can not find '/proc/self/exe'
> > 
> > - /proc/self/exe, for 'libc-test' target
> >   normal program 'libc-test' has no permission to access '/proc/1/exe'
> 
> Strictly speaking, if your executable is not readable (e.g. chmod 111
> due to a restrictive umask) it will also fail that one.
>

ok.

> > - the others, for kernel without procfs
> >   let it pass even with 'worst case' kernel configs
> 
> You should include /dev/zero, which is commonly used to allocate anonymous
> memory and is more likely present and readable than any of the other files.
> And another file of choice is obviously argv[0] ;-)  In this case you don't
> need any of the other extra ones. Thus I could suggest that you try in this
> order:
> 
>     /dev/zero, /proc/self/exe, /proc/1/exe, argv[0]
> 
> and be done with it. That doesn't prevent one from extending the list if
> really needed later, but I doubt it would be needed. Also, it's already
> arranged in a read-write, then read-only fallbacks mode, so if we later
> need to add more complex tests involving writes, the writable /dev/zero
> will have precedence.
>

Cool, both /dev/zero and argv[0] are very good candidates ;-)

Just verified both of them, works perfectly.

- /dev/zero

  we need to mknod it in prepare() and also, in test_mmap_munmap(),
  stat() return a zero size of /dev/zero, in this case, we should assign
  a non-zero file_size ourselves.

    -       file_size = stat_buf.st_size;
    +       /* file size of the special /dev/zero is 0, let's assign one manually */
    +       if (i == 0)
    +               file_size = 3*page_size - 1;
    +       else
    +               file_size = stat_buf.st_size;


- argv[0]

  since nolibc has no realpath() currently, we can simply
  support the current path and the absolute path like this:

    nolibc-test.c:

    /* assigned as argv[0] in main(), will be used by some tests */
    static char exe[PATH_MAX + 1];

    main():

    /* get absolute path of myself, nolibc has no realpath() currently */
    #ifndef NOLIBC
            realpath(argv[0], exe);
    #else
            /* assume absolute path has no "./" */
            if (strncmp(argv[0], "./", 2) != 0)
                    strncat(exe, argv[0], strlen(argv[0]) + 1);
            else {
                    pwd = getenv("PWD");
                    /* skip the ending '\0' */
                    strncat(exe, getenv("PWD"), strlen(pwd));
                    /* skip the first '.' */
                    strncat(exe, argv[0] + 1, strlen(argv[0]));
            }
    #endif

A full functional realpath() is a little complex, such as '../' support and
even symlink support, let's delay its requirement at current stage ;-)

one or both of them may also help the other test cases:

- chroot_exe (used '/init' before)

    CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(proc ? "/proc/self/exe" : exe), -1, ENOTDIR); break;

- chmod_exe (replace the one: chmod_tmpdir in another patchset)

    CASE_TEST(chmod_exe);       EXPECT_SYSZR(1, chmod(proc ? "/proc/self/exe" : exe, 0555)); break;

    It should be safe enough to only remove the writable attribute for the test
    program.

- stat_timestamps (used '/init' before)

    if (stat("/proc/self/", &st) && stat(exe, &st) && stat("/dev/zero", &st) && stat("/", &st))

Will update the related patches with them.

Thanks,
Zhangjin

> Willy
