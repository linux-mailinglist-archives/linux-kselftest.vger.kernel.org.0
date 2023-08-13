Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07C577A6A5
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHMN5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHMN5X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 09:57:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD2AB;
        Sun, 13 Aug 2023 06:57:23 -0700 (PDT)
X-QQ-mid: bizesmtp69t1691935022tmd0znhp
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 13 Aug 2023 21:57:00 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: XBN7tc9DADKY0u0gYyU/9iar40391tVgg6th9DXb2Tc89vEhh6Pcj3EUcGKpW
        XlLZ/uLOrczFEQ9JcKBt4mHPcilMtoya+/qW+cUrzQWYrU09RsgIjQQaT24orKUyM3oFroK
        32PzoSmcCOym28AKRahOkSWGDt7Id3i43dPVskDaFkFhxRwhyvSKDBZt0W+RfZM+mlY+8lg
        3sRaaeiwijD9FGchbgrQBTl/3KnJXhwmlatbl01hHd8U7nUZWst2pvjT+nlrQRShuv2a/X2
        y2zBxi/bYfIqmq70O1F+ldTksLDaOl9G1meioVDU6NXq7veZwG+Qnl9xyA05000UyZ2w2VV
        w6e6CkPI3VhabDJfVus6Fp2xGd4mUa5CcxKYVbCBvdK1jMDpqE4RLUXVFgNyg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1576533473743589944
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 0/2] tools/nolibc: fix up size inflat regression
Date:   Sun, 13 Aug 2023 21:56:59 +0800
Message-Id: <20230813135659.19763-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230813090830.GF8237@1wt.eu>
References: <20230813090830.GF8237@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Sat, Aug 12, 2023 at 05:49:36AM +0800, Zhangjin Wu wrote:
> > After these two patches, will send the proposed my_syscall() patchset
> > tomorrow, it can even further reduce more type conversions and therefore
> > reduce more binary bytes, here is a preview of the testing result:
> > 
> >    // with the coming my_syscall() patchset, sys_* from functionsn to macros
> >      i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19250
> >    x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 21733
> (...)
> > It can also shrink the whole sys.h from 1171 lines to around 738 lines.
> 
> Please, Zhangjin, please. Let's stop constantly speaking about potential
> future improvements when the present is broken. It needlessly adds a lot
> of noise in the discussion and tends to encourage you to explore areas
> that are incompatible with what is required to fix the breakage, and
> very likely steers your approach to fixes in a direction that you think
> is compatible with such future paths. But as long as existing code is
> broken you cannot speculate on how better the next iteration will be,
> because it's built on a broken basis. And I would like to remind that
> the *only* reason for the current breakage is this attempt to save even
> more code lines, that was not a requirement at all in the first place!
> Sure it can be fine to remove code when possible, but not at the cost of
> trying to force squares to enter round holes like this. The reality is
> that *some* syscalls are different and *some* archs are different, and
> these differences have to be taken into account, and if we keep exceptions
> it's fine.
>

Agree very much, that's why I didn't send the new patchset but only send
these two ones about size inflate regression, I don't want to discuss
more than one issue at a time either (and you also have shared this idea
several times) ;-)

The progress and preview data here is only because the patch 1/2 [1] is
an important preparation of the new patchset, the data here is more or
less providing a selling point why we need patch 1/2, I have explained
it in this reply [2]. Of course, we can roll them back directly, and If
we do need sys_brk/mmap return 'long', we can revert the rolling-back
and apply patch 1/2.

    [PATCH v6 1/2] tools/nolibc: let sys_brk, sys_mmap and sys_mmap2 return long

> So let's only speak about this later once the issue is completely solved.
>

Ok, it is the right direction.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/82b584cbda5cee8d5318986644a2a64ba749a098.1691788036.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/20230813132620.19411-1-falcon@tinylab.org/

> Thanks,
> Willy
