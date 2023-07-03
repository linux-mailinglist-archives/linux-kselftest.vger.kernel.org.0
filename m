Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC56745734
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGCIUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 04:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGCIUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 04:20:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C449E5E;
        Mon,  3 Jul 2023 01:20:44 -0700 (PDT)
Date:   Mon, 3 Jul 2023 10:20:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688372442; bh=eG4hejjueR/OQipmldkNjJWTBqfgbdBdHjpVICVNdr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8f5qUhQgUw3BKlidU3AXrWYiHHDaz7jEDMYnxmlvtjEohc3c2srqggGtDLtyNAq/
         T+MgazLr1nJ4pjFOEwyQUt/HAQeTXb3Yna3H2VuxXyjsjl7LQ6T01StoBhB6MF5NsI
         cpL4Jg4WFmpvkMoBE8Quz23HqZywFRmblvYwCKEw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Message-ID: <f74a85a5-ea9a-4819-a95e-aa9525bf84f9@t-8ch.de>
References: <ZKJ35DyPOG+LAy5j@1wt.eu>
 <20230703080647.491363-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703080647.491363-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-03 16:06:47+0800, Zhangjin Wu wrote:
> Hi, Willy

> [..]

> > > - argv[0]
> > > 
> > >   since nolibc has no realpath() currently, we can simply
> > >   support the current path and the absolute path like this:
> > > 
> > >     nolibc-test.c:
> > > 
> > >     /* assigned as argv[0] in main(), will be used by some tests */
> > >     static char exe[PATH_MAX + 1];
> > > 
> > >     main():
> > > 
> > >     /* get absolute path of myself, nolibc has no realpath() currently */
> > >     #ifndef NOLIBC
> > >             realpath(argv[0], exe);
> > >     #else
> > >             /* assume absolute path has no "./" */
> > >             if (strncmp(argv[0], "./", 2) != 0)
> > >                     strncat(exe, argv[0], strlen(argv[0]) + 1);
> > >             else {
> > >                     pwd = getenv("PWD");
> > >                     /* skip the ending '\0' */
> > >                     strncat(exe, getenv("PWD"), strlen(pwd));
> > >                     /* skip the first '.' */
> > >                     strncat(exe, argv[0] + 1, strlen(argv[0]));
> > >             }
> > >     #endif
> > 
> > No, please, not like this. Just copy argv[0] (the pointer not the
> > contents) and you're fine:
> >
> >     static const char *argv0;
> > 
> >     int main(int argc, char **argv, char **envp)
> >     {
> >             argv0 = argv[0];
> >             ...
> >     }
> > 
> > Nothing more, nothing less. Your program will always have its correct
> > path when being called unless someone purposely forces it to something
> > different, which is not our concern at all since this is a test program.
> > And I'd rather call it "argv0" which exactly tells us what it contains
> > than "exe" which can be misleading for that precise reason.
> >
> 
> Yeah, locally, I just used a global argv0 pointer directly, but
> chroot_exe("./nolibc-test") not work when run 'libc-test' in host
> system, that is why I tried to get an absolute path ;-)
> 
>     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(exe), -1, ENOTDIR); break;
> 
>     -->
> 
>     19 chroot_exe = -1 ENOENT  != (-1 ENOTDIR)                      [FAIL]
> 
> I removed the "proc ?" check manually to test if it also work with
> CONFIG_PROC_FS=n. it doesn't work, without absolute path, we need to add
> the ENOENT errno back to the errno check list.
> 
> I'm not sure if the other syscalls require an absolute path, so, the
> realpath() is called in this proposed method.
> 
> > > A full functional realpath() is a little complex, such as '../' support and
> > > even symlink support, let's delay its requirement at current stage ;-)
> > 
> > Please do not even engage into this, and keep in mind that the sole
> > purpose of this test program is to help developers simply add tests to
> > the set of existing ones. If the program becomes complex for doing stuff
> > that is out of its scope, it will become much harder to extend and users
> > will lose interest and motivation for updating it.
> > 
> > > one or both of them may also help the other test cases:
> > > 
> > > - chroot_exe (used '/init' before)
> > > 
> > >     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(proc ? "/proc/self/exe" : exe), -1, ENOTDIR); break;
> > > 
> > > - chmod_exe (replace the one: chmod_tmpdir in another patchset)
> > > 
> > >     CASE_TEST(chmod_exe);       EXPECT_SYSZR(1, chmod(proc ? "/proc/self/exe" : exe, 0555)); break;
> > > 
> > >     It should be safe enough to only remove the writable attribute for the test
> > >     program.
> > > 
> > > - stat_timestamps (used '/init' before)
> > > 
> > >     if (stat("/proc/self/", &st) && stat(exe, &st) && stat("/dev/zero", &st) && stat("/", &st))
> > 
> > Indeed, why not!
> >
> 
> Ok, without absolute path, the chroot_exe() will be changed back to
> something like this:
> 
>     CASE_TEST(chroot_exe);        EXPECT_SYSER2(1, chroot(proc ? "/proc/self/exe" : argv0), -1, ENOTDIR, ENOENT); break;

Are you sure the ENOENT is really correct?
I played with this before and got ENOENT because before the chroot test
we have a testcase that does chdir("/").
And therefore the relative name in argv[0] was not resolving correctly
anymore against the changed working directory.

(You can also test this by executing *only* the chroot test and it
should work)

In general chroot() should work just fine with relative paths.

This is really a lot of complexity and discussion only to avoid
depending on procfs for the tests.

Thomas
