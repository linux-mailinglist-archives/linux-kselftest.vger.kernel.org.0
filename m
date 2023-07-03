Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1222F74597E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGCKAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjGCKAP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 06:00:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 282241FDE;
        Mon,  3 Jul 2023 02:56:43 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3639uRd9023860;
        Mon, 3 Jul 2023 11:56:27 +0200
Date:   Mon, 3 Jul 2023 11:56:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Message-ID: <ZKKbS3cwKcHgnGwu@1wt.eu>
References: <ZKJ35DyPOG+LAy5j@1wt.eu>
 <20230703080647.491363-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703080647.491363-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 03, 2023 at 04:06:47PM +0800, Zhangjin Wu wrote:
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

Then we have a problem somewhere else and the test should be debugger
instead. Are you sure there isn't a successful chdir() test before it
for example, that would change the directory ? If so maybe we just need
to save the current dir before calling it and restore it later.

> I removed the "proc ?" check manually to test if it also work with
> CONFIG_PROC_FS=n. it doesn't work, without absolute path, we need to add
> the ENOENT errno back to the errno check list.

Same as above.

> I'm not sure if the other syscalls require an absolute path, so, the
> realpath() is called in this proposed method.

No, please do not overengineer tests. That's only hiding the dust under
the carpet and people adding more tests later that will randomly fail
will have a very hard time trying to figure what's happening under the
hood. If a test doesn't work as expected, we must not try to work around
it, but arrange to fix it.

Thanks,
Willy
