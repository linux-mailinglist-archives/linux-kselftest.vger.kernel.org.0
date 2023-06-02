Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05D720101
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjFBL5j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjFBL5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 07:57:38 -0400
X-Greylist: delayed 28230 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 04:57:07 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D9E51;
        Fri,  2 Jun 2023 04:57:07 -0700 (PDT)
X-QQ-mid: bizesmtp64t1685706961t67k8i2u
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Jun 2023 19:56:00 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: k0mQ4ihyJQP+tm91rx4PnDCmNQx5PlLwmtBQSrIufi4NAs5P4d+to5cY+J9hh
        j6hHs7pOK7V5F+ibUiR11d0sToIwGWe4Ram8/xcpzKIE3vKMmmMNKmt8lz3Wn4olhM06oWt
        H666d4tbc+l4sQjOCxcsEi5CPTLfiWEy3j8hSQ/HT8sy7+4y/BpjoXyFyUMUIv27G8oBf0X
        JZ5ho8q4c59oWMl+xPMHaK1TQAAu09sFAG5T37oZv3VC+IXrokEIWxC+2TGn3CXq0W96ggQ
        PNT9foAp++WO8LIezYegS8gXGU1TuVM0kVqt6u232qWUwFow2Hl6T5UbKHOnBM69z3hc88e
        Nv8frKO+BPnA3F94Ey691NDgdk66n7I452RQ/xYaGM3PZhOntByV/5svIRIRg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7108637236776978947
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH v2 13/13] selftests/nolibc: riscv: customize makefile for rv32
Date:   Fri,  2 Jun 2023 19:56:00 +0800
Message-Id: <20230602115600.80382-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f7cb4209-a70f-4f59-8b11-2d189908f18c@t-8ch.de>
References: <f7cb4209-a70f-4f59-8b11-2d189908f18c@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-06-02 12:06:25+0800, Zhangjin Wu wrote:
> > Willy, Arnd and Thomas
> > 
> > Based on your suggestions, in the comming v3, I plan to split the whole rv32
> > support to something like this:
> 
> Is each of these parts a new patchset?

Yeah, It is also my plan, just like the v2 series.

> I would suggest to do so.
> 
> > 1. Generic part1
> > 
> >    (The old feedbacks are applied with the new Suggested-by lines, welcome your
> >     additional feedbacks if there are ;-))
> > 
> >     selftests/nolibc: syscall_args: use generic __NR_statx
> >     tools/nolibc: add missing nanoseconds support for __NR_statx
> >     selftests/nolibc: allow specify extra arguments for qemu
> >     selftests/nolibc: fix up compile warning with glibc on x86_64
> >     selftests/nolibc: not include limits.h for nolibc
> >     selftests/nolibc: use INT_MAX instead of __INT_MAX__
> >     tools/nolibc: arm: add missing my_syscall6
> >     tools/nolibc: open: fix up compile warning for arm
> >     selftests/nolibc: support two errnos with EXPECT_SYSER2()
> >     selftests/nolibc: remove gettimeofday_bad1/2 completely
> >     selftests/nolibc: add new gettimeofday test cases
> 
> These all look good and non-controversial.
> 
> > 2. Add Compile support for rv32
> > 
> >    (Convert all of the unsupported syscalls to a return of -ENOSYS, this
> >     allows us to fix up the test failures one by one not that urgently later)
> > 
> >     tools/nolibc: fix up #error compile failures with -ENOSYS
> >     tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
> 
> These should be their own series in my opinion.
> It will likely generate some discussion.

The 1st one is not rv32 specific, but the 2nd one requires rv32 compile support
to be validated.

> 
> >     selftests/nolibc: riscv: customize makefile for rv32
> > 
> >    (The first two are new but clear enough, based on the idea of suggestion from Arnd [1])
> > 
> > 3. Fix up the left test failures one by one
> 
> I'm not a fan of adding an "official" rv32 support with still failing
> tests.
>

That is reasonable, but in another side, without the rv32 compile support, It
may be a little hard to test the left patchsets (see below explain).

The other reasons for rv32 compile support is:

* Some people may use nolibc without the left syscalls.
* It is able to detect the new test failures.

But anyway, the compile support is not urgent.

> >    (Plan to add everyone as a standalone patchset, which will easier the review
> >     and merge progress)
> > 
> >    wait4 -> waitid
> >    lseek -> llseek
> >    gettimeofday -> clock_gettime/clock_gettime64
> >    select -> pselect6/pselect6_time64
> >    ppoll -> ppoll_time64
> 
> I guess these new codepaths will also be used on non-rv32 architectures
> and will therefore validated without rv32.
>

Unfortunately, most of them are time32 syscalls related (except the
llseek), rv32 is the first architecture who has no kernel side time32
syscalls support, that's why I plan to add compile support at first ;-)

If the new time64 syscalls will be added as the first 'branch', then, they will
be validated on the other 32bit architecture, but some of them may be not added
as the first 'branch', for example, the waitid() emulated wait4() is bigger
than the original one.

> So you could submit these before the final rv32 patch in a series.
>

Thanks for your suggestion.

I'm working on cleaning up them independently and carefully, will send them out
as standalone patchsets.

Best regards,
Zhangjin
 
> > 4. Clean up some old test cases one by one
> > 
> >    Like statx ...
> > 
> > Best regards,
> > Zhangjin
> > 
> > [1]: https://lore.kernel.org/linux-riscv/5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com/
