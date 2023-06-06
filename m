Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC97237C5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjFFGfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjFFGeq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:34:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B87C123;
        Mon,  5 Jun 2023 23:34:37 -0700 (PDT)
X-QQ-mid: bizesmtp68t1686033262tl7dkkqk
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 14:34:21 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: /+iK7ZpVlLSPinLeQ9zsx66cqhGI6AjnH+oBn23Uhpa6VHM/NSh9KAGG0KU+3
        v7OGvDL7Trzyyqyu/XhqvEtxyVAXBYpoCrTvJk6T5vojDLz/svaeIkrwZmF05+KI0gKLUvu
        6XO0bkPxU0Yq30vmK/im5xjAfi8/vY+IdwTfn0aENDR4YPUbGTMu9ORdR6GUiszt3O1lZOI
        /YmZt7j8wUUDVHRjo+1DOHEf616JrEZwr7RcBZGSkLYcNjFpMu3L7G30luAcrcIRoJTmF07
        sbceNMhBIzm2RKjBeQ5wm9lkJZB2m5/LE4D3gucfe74XO88h9RmR4uskA4uyHD8TVF7k7Ra
        T/meyYMAs3/q2vIb4Xo6TF1f1oNpcirsRRTSjhEJclBGRTEXyI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2133803625882830366
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu, arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 0/3] nolibc: add part2 of support for rv32
Date:   Tue,  6 Jun 2023 14:34:21 +0800
Message-Id: <20230606063421.355411-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZH65QKQ1dlY+HsK7@1wt.eu>
References: <ZH65QKQ1dlY+HsK7@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Thomas, Arnd

> Hi Zhangjin,
> 
> On Tue, Jun 06, 2023 at 12:25:35PM +0800, Zhangjin Wu wrote:
> > The first two convert all compile failures to a return of -ENOSYS, if you do
> > like it, welcome your Reviewed-by. These two are required by the coming new
> > time64 syscalls for rv32, because they depends on how we cope with the
> > unsupported syscalls, returning -ENOSYS is really better than simply fail the
> > compiling.
> 
> I had a look now and I can sya that I like this. Initially the supported
> syscalls were so restricted that it was not even imaginable to accept to
> build without any of them, but now that we're completing the list, some
> of them are less critical and I don't see why we'd fail to build just
> because one is missing. So yeah, a big +1 for -ENOSYS.
>

Cool, I will prepare the new patchsets on them, welcome your new branch
with both of them, of course, still weclome Reviewed-by from Arnd and Thomas.

> > The third one is not that urgent, because some important syscalls are
> > still missing for rv32. It is added here only for compile test.
> 
> I personally have no opinion on this one. I can't judge whether it will
> make things easier or more complicated at this point. It seems to me
> that for now it's just avoiding one extra line at the expense of some
> $(if) on several lines. Maybe it could help add more such archs, or
> maybe it can make them more complicated to debug, I don't know. I'm
> interested in others' opinions as well.

As I explained why we did it in current way in this reply [1], Thomas had no
more questions on it, so I think Thomas was happy with it now and I got his
only left suggestion is that may be this patch should be applied after the
missing 64bit syscalls being added for there are several important test
failures currently, for me, it is ok before or after.

Thomas, welcome your Reviewed-by on the makefile patch itself If you are really
happy with it now, thanks very much ;-)

Willy, I will send the v2 syscalls helpers (also required by the coming 64bit
syscalls) and some other patches (mainly for test with faster kernel build)
about selftests/nolibc later, because we have not enough time for v6.5 test,
so, I suggest we can create new branch for v6.6 and my new patchsets will be
for v6.6.

Best regards,
Zhangjin

---

[1]: https://lore.kernel.org/linux-riscv/20230526092029.149351-1-falcon@tinylab.org/

> 
> Thanks,
> Willy
