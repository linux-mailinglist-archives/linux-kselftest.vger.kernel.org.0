Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE25745826
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGCJPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 05:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCJPk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 05:15:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15012C;
        Mon,  3 Jul 2023 02:15:36 -0700 (PDT)
X-QQ-mid: bizesmtp75t1688375722th1fa91f
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 17:15:21 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: znfcQSa1hKYmGKLly0cpa018jyPZvn3QolrVhbDV/s3KpSQEDu1YDAdsEzZ/o
        LkRnAFX7Lxz9jbfIysjrjg4aO/OZQBdgDXx4M3O34Rl3DEXpZddlJqsoD9nrIsSSYVnrwPb
        Cn5XtmE9rRgU9C6xHuNm7TEDMo4V2tGOAjWMCbjehq6tECvb5Il4fmeZZ5EYWkVlfpvVdZ+
        NwnFit1uYxWe9BM+Tus0ea5+bDAe29hWH2QkhE/3mE1hEdOzTSBecFC9Bifxp89kPRC5aSi
        aAmf+vrVoqcs3wGryg9+GZ61egO03PyFP8k3jy2N3jPs4IemQCe5KavPtDNr2DbnbqT6R5a
        0J2Cr5kh5MVov5C96VkBPaJRLophe+aMRdmU8nomYs/eH7uqfg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16105542733624423556
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, w@1wt.eu
Subject: Re: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Date:   Mon,  3 Jul 2023 17:15:21 +0800
Message-Id: <20230703091521.492045-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f74a85a5-ea9a-4819-a95e-aa9525bf84f9@t-8ch.de>
References: <f74a85a5-ea9a-4819-a95e-aa9525bf84f9@t-8ch.de>
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

Hi, Thomas

> On 2023-07-03 16:06:47+0800, Zhangjin Wu wrote:
> > Hi, Willy
> 
> > [..]
> 
> > > > - argv[0]
> > > > 
> > > >   since nolibc has no realpath() currently, we can simply
> > > >   support the current path and the absolute path like this:
> > > > 
> > > >     nolibc-test.c:
> > > > 
> > > >     /* assigned as argv[0] in main(), will be used by some tests */
> > > >     static char exe[PATH_MAX + 1];
> > > > 
> > > >     main():
> > > > 
> > > >     /* get absolute path of myself, nolibc has no realpath() currently */
> > > >     #ifndef NOLIBC
> > > >             realpath(argv[0], exe);
> > > >     #else
> > > >             /* assume absolute path has no "./" */
> > > >             if (strncmp(argv[0], "./", 2) != 0)
> > > >                     strncat(exe, argv[0], strlen(argv[0]) + 1);
> > > >             else {
> > > >                     pwd = getenv("PWD");
> > > >                     /* skip the ending '\0' */
> > > >                     strncat(exe, getenv("PWD"), strlen(pwd));
> > > >                     /* skip the first '.' */
> > > >                     strncat(exe, argv[0] + 1, strlen(argv[0]));
> > > >             }
> > > >     #endif
> > > 
> > > No, please, not like this. Just copy argv[0] (the pointer not the
> > > contents) and you're fine:
> > >
> > >     static const char *argv0;
> > > 
> > >     int main(int argc, char **argv, char **envp)
> > >     {
> > >             argv0 = argv[0];
> > >             ...
> > >     }
> > > 
> > > Nothing more, nothing less. Your program will always have its correct
> > > path when being called unless someone purposely forces it to something
> > > different, which is not our concern at all since this is a test program.
> > > And I'd rather call it "argv0" which exactly tells us what it contains
> > > than "exe" which can be misleading for that precise reason.
> > >
> > 
> > Yeah, locally, I just used a global argv0 pointer directly, but
> > chroot_exe("./nolibc-test") not work when run 'libc-test' in host
> > system, that is why I tried to get an absolute path ;-)
> > 
> >     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(exe), -1, ENOTDIR); break;
> > 
> >     -->
> > 
> >     19 chroot_exe = -1 ENOENT  != (-1 ENOTDIR)                      [FAIL]
> > 
> > I removed the "proc ?" check manually to test if it also work with
> > CONFIG_PROC_FS=n. it doesn't work, without absolute path, we need to add
> > the ENOENT errno back to the errno check list.
> > 
> > I'm not sure if the other syscalls require an absolute path, so, the
> > realpath() is called in this proposed method.
> > 
> > > > A full functional realpath() is a little complex, such as '../' support and
> > > > even symlink support, let's delay its requirement at current stage ;-)
> > > 
> > > Please do not even engage into this, and keep in mind that the sole
> > > purpose of this test program is to help developers simply add tests to
> > > the set of existing ones. If the program becomes complex for doing stuff
> > > that is out of its scope, it will become much harder to extend and users
> > > will lose interest and motivation for updating it.
> > > 
> > > > one or both of them may also help the other test cases:
> > > > 
> > > > - chroot_exe (used '/init' before)
> > > > 
> > > >     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(proc ? "/proc/self/exe" : exe), -1, ENOTDIR); break;
> > > > 
> > > > - chmod_exe (replace the one: chmod_tmpdir in another patchset)
> > > > 
> > > >     CASE_TEST(chmod_exe);       EXPECT_SYSZR(1, chmod(proc ? "/proc/self/exe" : exe, 0555)); break;
> > > > 
> > > >     It should be safe enough to only remove the writable attribute for the test
> > > >     program.
> > > > 
> > > > - stat_timestamps (used '/init' before)
> > > > 
> > > >     if (stat("/proc/self/", &st) && stat(exe, &st) && stat("/dev/zero", &st) && stat("/", &st))
> > > 
> > > Indeed, why not!
> > >
> > 
> > Ok, without absolute path, the chroot_exe() will be changed back to
> > something like this:
> > 
> >     CASE_TEST(chroot_exe);        EXPECT_SYSER2(1, chroot(proc ? "/proc/self/exe" : argv0), -1, ENOTDIR, ENOENT); break;
> 
> Are you sure the ENOENT is really correct?
> I played with this before and got ENOENT because before the chroot test
> we have a testcase that does chdir("/").

Yes, there are some chdir tests before chroot, it does answer why
relative path not work and return ENOENT: no such file in the relative
path changed by chdir(), it differs from the one in PWD environment
variable.

> And therefore the relative name in argv[0] was not resolving correctly
> anymore against the changed working directory.
>
> (You can also test this by executing *only* the chroot test and it
> should work)
>

Yeah, If chdir() back to current path, it does work:

    CASE_TEST(chroot_exe);        chdir(getenv("PWD")); EXPECT_SYSER(1, chroot(exe), -1, ENOTDIR); break;

    -->

    11 chdir_root = 0                                                [OK]
    12 chdir_dot = 0                                                 [OK]
    13 chdir_blah = -1 ENOENT                                        [OK]
    14 chmod_self = -1 EPERM                                         [OK]
    15 chmod_exe = 0                                                 [OK]
    16 chown_self = -1 EPERM                                         [OK]
    17 chroot_root                                                  [SKIPPED]
    18 chroot_blah = -1 ENOENT                                       [OK]
    19 chroot_exe
    pwd: /home/ubuntu/Develop/src/examples/musl
    exe: ./nolibc-test
     = -1 ENOTDIR                                       [OK]


> In general chroot() should work just fine with relative paths.
>

it does work with relative path, to make sure argv0 always work as
expected, an extra 'chdir()' may really required, or let's clean up the
previous chdir() test cases to call chdir(getenv("PWD")) after every
test.

    CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
    CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
    CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;

perhaps only call 'chdir(getenv("PWD"))' after chdir_root() is enough,
because the chdir(".") doesn't really change the directory:

    CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
    CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
    CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;

Which one do you prefer?

> This is really a lot of complexity and discussion only to avoid
> depending on procfs for the tests.
>

Yes, one step further to find more interesting info, thanks a lot ;-)

Mixing chdir and relative path really need to be more careful.

Best regards,
Zhangjin

> Thomas
