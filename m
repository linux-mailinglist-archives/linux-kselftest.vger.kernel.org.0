Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E0726139
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 15:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbjFGN1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjFGN1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 09:27:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140091AC;
        Wed,  7 Jun 2023 06:26:57 -0700 (PDT)
X-QQ-mid: bizesmtp79t1686144406t8q8sh1i
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 21:26:44 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: gSGF8h2+s1IeuyvNvsjPqo51c92Oei+VMiWk3neliuJycIgEbNKvZYuLZeUAz
        lFnZwQGxKatqDuzMJQohZXLRw7ojULNOb0uySR+PI0K0wz6TMCdQK5KMg3dv/ZBa7cf690j
        F3aLIkjJfE3lX4ajZr1YhoqbesoV5tm1xPa4dgHqPRx4tnlNdb6/oenJsj48MaPH/aQufsD
        Sp37ssx34gS5ZLeJOCeKoo5c5NvhJHhx8r8CLz/vloLE2w420Q6cPe+pfk1Nc0dUfNqTu1N
        bTMFDwxFV3/+1jfMLT8XM9JJBvPv1sXabROdq0SdWbp1kI1zQZpLo2ym5FGUTuy7u2kcCrp
        vmlng70HKM3MPHoViSeRec/NWnaWjkBVaCo2c1qQ8V6lsgomCqO0G6+7IgnbvNrTd1PJFeS
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11098037038039291754
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v3 1/3] tools/nolibc: fix up #error compile failures with -ENOSYS
Date:   Wed,  7 Jun 2023 21:26:44 +0800
Message-Id: <20230607132644.824792-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <635d1aaf-3982-4404-9c05-05e51800691e@app.fastmail.com>
References: <635d1aaf-3982-4404-9c05-05e51800691e@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Wed, Jun 7, 2023, at 11:46, Zhangjin Wu wrote:
> >> On Wed, Jun 7, 2023, at 07:19, Zhangjin Wu wrote:
> >
> > Ok, agree, as the 64bit version of lseek may be enough for nolibc, if a target
> > application really require, they can add the alias themselves.
> >
> >> Are there any examples of functions where we actually want mulitple
> >> versions?
> >>
> >
> > For example, the following ones are related to the syscalls being added,
> > all of them have similar library routines in current sys.h:
> >
> > * waitid, https://linux.die.net/man/2/waitid
> > * ppoll, https://linux.die.net/man/2/ppoll
> > * pselect, https://linux.die.net/man/2/pselect6
> > * clock_gettime, https://linux.die.net/man/2/clock_gettime
> >
> > The similar routines are put in right side:
> >
> > * waitid --> waitpid, wait, wait4
> > * ppoll --> poll
> > * pselect --> select
> > * clock_gettime --> gettimeofday
> 
> Ok, I think these are all useful to have in both versions.
> 
> All four of these examples are old enough that I think it's
> sufficient just expose them to userspace as the bare system
> calls, and have the older library calls be implemented using
> them without a fallback to the native syscalls of the same
> name on architectures that have both, newer architectures
> would only have the latest version anyway.
>

Ok, Thanks, I have already added parts of them, will send waitid and
64bit lseek at first.

> > For the clock_gettime, it may also let us think about if we need to add
> > its friends (clock_getres, clock_settime) together.
> 
> Yes, I think that makes sense. We also need clock_settime()
> to implement settimeofday() on rv32.
>

Ok.

> Ideally, I'd love to extend the tooling around system calls
> in the kernel so we can automatically generate the low-level
> wrapper functions from syscall.tbl,

That's cool.

BTW, I did something on dead syscall elimination [1] (DSE, RFC
patchset), a v1 has been prepared locally, but not sent out yet.

It also requires to work with the syscall.tbl or the generic
include/uapi/asm-generic/unistd.h, welcome your feedback on the RFC
patchset [1] and you should be the right reviewer of the coming v1 ;-)

The left issue of RFC version is finding a way to not KEEP the exception
entries (in ld script) added by get_user/put_user() if the corresponding
syscalls are not really used, such KEEPs of exception entries reverts
the ownership from "syscalls -> get_user/put_user" to "get_user/put_user
-> syscalls" and blocks the gc'ing of the sections of such syscalls.

In the coming v1, I used a script trick to drop the wrongly KEPT
exception entries to allow drop all of the unused syscalls at last. Will
clean up them asap. But it is a little slow and looks ugly, it is only
for a further demo of the possibility.

In v2 of DSE, I'm wondering whether it is possible to drop all of the
manually added KEEP operations from ld scripts and use some conditional
attributes (for the sections added by get_user/put_user) to build the
'used' references from "syscalls" to "sections created by
get_user/put_user", this may need support from gcc and ld, welcome your
suggestions too, thanks.

And that RFC patchset added a patch to record the used 'syscalls' in
nolibc automatically ;-)

[1]: https://lore.kernel.org/linux-riscv/cover.1676594211.git.falcon@tinylab.org/
[2]: https://reviews.llvm.org/D96838

> but this needs a lot of
> other work that you should not need to depend on for what
> you are doing right now.

Ok, welcome to share any progress.

Thanks,
Zhangjin

> 
>      Arnd
