Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E45745AF4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjGCLYZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGCLYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 07:24:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F278CC1;
        Mon,  3 Jul 2023 04:24:22 -0700 (PDT)
X-QQ-mid: bizesmtp81t1688383446t1op3cnl
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 19:24:05 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: cbck7jzG4wYC8mah2/jqlcxJTdWqDIK9P0UT4RX2Zum2vuyXXC6GWwjeRgmzi
        5/ELDpDe6XvNbfUpTU0H8qffvoj/1wliAi3LfhVM+yvinfG5Yq2cc9wgZGr7jh3+q2tf7RO
        AVP4PAzEebTO5WBTKxnDJfl8edKAsiD56sJ7Mdl6KYgMye1rSVWgCU14evKkNZCml/bi14Q
        Sdy6bwd5XLt5b02oNBAone6RkiBz9wx7752eQed4TmgXmfPC6GQzVYaHFX+hc2IbYauTJpj
        k7ulh4XxvMPKqZAqj6EYHYBZo3GgI5uf7R+tKfcGfYV4yCGEeSW2k2rUFnsRkP95SaDkqSl
        61di5Pu28vy0V093/Gb0cHaV39BnMJpsgWjsf5ksaoxSxW3lno=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8141555401561398156
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Date:   Mon,  3 Jul 2023 19:24:04 +0800
Message-Id: <20230703112404.496996-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZKKbS3cwKcHgnGwu@1wt.eu>
References: <ZKKbS3cwKcHgnGwu@1wt.eu>
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

> On Mon, Jul 03, 2023 at 04:06:47PM +0800, Zhangjin Wu wrote:
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
> 
> Then we have a problem somewhere else and the test should be debugger
> instead. Are you sure there isn't a successful chdir() test before it
> for example, that would change the directory ? If so maybe we just need
> to save the current dir before calling it and restore it later.
>

Yes, as Thomas pointed out, the chdir test cases changed current
directory to "/" just before chroot_exe(), so, restore it with
chdir(getenv("PWD")) solves the issue.

> > I removed the "proc ?" check manually to test if it also work with
> > CONFIG_PROC_FS=n. it doesn't work, without absolute path, we need to add
> > the ENOENT errno back to the errno check list.
> 
> Same as above.
> 
> > I'm not sure if the other syscalls require an absolute path, so, the
> > realpath() is called in this proposed method.
> 
> No, please do not overengineer tests. That's only hiding the dust under
> the carpet and people adding more tests later that will randomly fail
> will have a very hard time trying to figure what's happening under the
> hood. If a test doesn't work as expected, we must not try to work around
> it, but arrange to fix it.

That's right, thanks.

Best regards,
Zhangjin

> 
> Thanks,
> Willy
