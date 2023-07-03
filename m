Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61DC7455FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGCHZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGCHZz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 03:25:55 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EAC7E56;
        Mon,  3 Jul 2023 00:25:45 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3637POX9022120;
        Mon, 3 Jul 2023 09:25:24 +0200
Date:   Mon, 3 Jul 2023 09:25:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Message-ID: <ZKJ35DyPOG+LAy5j@1wt.eu>
References: <20230702193306.GK16233@1wt.eu>
 <20230703060323.487347-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703060323.487347-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 03, 2023 at 02:03:23PM +0800, Zhangjin Wu wrote:
> > > - the others, for kernel without procfs
> > >   let it pass even with 'worst case' kernel configs
> > 
> > You should include /dev/zero, which is commonly used to allocate anonymous
> > memory and is more likely present and readable than any of the other files.
> > And another file of choice is obviously argv[0] ;-)  In this case you don't
> > need any of the other extra ones. Thus I could suggest that you try in this
> > order:
> > 
> >     /dev/zero, /proc/self/exe, /proc/1/exe, argv[0]
> > 
> > and be done with it. That doesn't prevent one from extending the list if
> > really needed later, but I doubt it would be needed. Also, it's already
> > arranged in a read-write, then read-only fallbacks mode, so if we later
> > need to add more complex tests involving writes, the writable /dev/zero
> > will have precedence.
> >
> 
> Cool, both /dev/zero and argv[0] are very good candidates ;-)
> 
> Just verified both of them, works perfectly.
> 
> - /dev/zero
> 
>   we need to mknod it in prepare()

Indeed.

>   and also, in test_mmap_munmap(),
>   stat() return a zero size of /dev/zero, in this case, we should assign
>   a non-zero file_size ourselves.
> 
>     -       file_size = stat_buf.st_size;
>     +       /* file size of the special /dev/zero is 0, let's assign one manually */
>     +       if (i == 0)
>     +               file_size = 3*page_size - 1;
>     +       else
>     +               file_size = stat_buf.st_size;

OK but why this -1 ? That doesn't sound right, unless you explicitly want
a file size that's not multiple of a page size for whatever reason ?

> - argv[0]
> 
>   since nolibc has no realpath() currently, we can simply
>   support the current path and the absolute path like this:
> 
>     nolibc-test.c:
> 
>     /* assigned as argv[0] in main(), will be used by some tests */
>     static char exe[PATH_MAX + 1];
> 
>     main():
> 
>     /* get absolute path of myself, nolibc has no realpath() currently */
>     #ifndef NOLIBC
>             realpath(argv[0], exe);
>     #else
>             /* assume absolute path has no "./" */
>             if (strncmp(argv[0], "./", 2) != 0)
>                     strncat(exe, argv[0], strlen(argv[0]) + 1);
>             else {
>                     pwd = getenv("PWD");
>                     /* skip the ending '\0' */
>                     strncat(exe, getenv("PWD"), strlen(pwd));
>                     /* skip the first '.' */
>                     strncat(exe, argv[0] + 1, strlen(argv[0]));
>             }
>     #endif

No, please, not like this. Just copy argv[0] (the pointer not the
contents) and you're fine:

    static const char *argv0;

    int main(int argc, char **argv, char **envp)
    {
            argv0 = argv[0];
            ...
    }

Nothing more, nothing less. Your program will always have its correct
path when being called unless someone purposely forces it to something
different, which is not our concern at all since this is a test program.
And I'd rather call it "argv0" which exactly tells us what it contains
than "exe" which can be misleading for that precise reason.

> A full functional realpath() is a little complex, such as '../' support and
> even symlink support, let's delay its requirement at current stage ;-)

Please do not even engage into this, and keep in mind that the sole
purpose of this test program is to help developers simply add tests to
the set of existing ones. If the program becomes complex for doing stuff
that is out of its scope, it will become much harder to extend and users
will lose interest and motivation for updating it.

> one or both of them may also help the other test cases:
> 
> - chroot_exe (used '/init' before)
> 
>     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(proc ? "/proc/self/exe" : exe), -1, ENOTDIR); break;
> 
> - chmod_exe (replace the one: chmod_tmpdir in another patchset)
> 
>     CASE_TEST(chmod_exe);       EXPECT_SYSZR(1, chmod(proc ? "/proc/self/exe" : exe, 0555)); break;
> 
>     It should be safe enough to only remove the writable attribute for the test
>     program.
> 
> - stat_timestamps (used '/init' before)
> 
>     if (stat("/proc/self/", &st) && stat(exe, &st) && stat("/dev/zero", &st) && stat("/", &st))

Indeed, why not!

> Will update the related patches with them.

OK thanks!
Willy
