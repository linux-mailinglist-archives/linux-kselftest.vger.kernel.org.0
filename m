Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABF723B02
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjFFII6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjFFII5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:08:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D47E8;
        Tue,  6 Jun 2023 01:08:55 -0700 (PDT)
X-QQ-mid: bizesmtp71t1686038924tds2m1zg
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 16:08:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OFQdrTmJ2CS8cMsJdI2SFzlvHmY/Ck0nNyKgKxiLI9UnvdqlnoY+5XpF6N8Br
        XdmjANCFOn/QtFRLGmvdaM4DpVxz5fMFWbRLx3CMqE+ZG+Lj5ARnkDkCxV8n6MuSHdda1g1
        j5wTsf6/AxFnmKq96zAS5vJXIC574TOyhXYGECXT+kBzBtefdfjL2LXn2603hiuVTsIdQ4r
        1OpvaBna3Uv95kdvvy4G3cvoj+wX7ouNqj4jNVJBCjXSuCMOO7BmR1R2YAKmIstqR9RSQX8
        LrfjIjY3gF2xk1M2RwGPecOM6r07gUJ+j2sZ/axWmNW4+7I6M542KZpf+ZFg7/rZY2W3BzL
        f5CKv26VV38EwMDkkF7NNRNHP/JS4/RjOPYJ9K9HNKPR4MY7LsCzrV/y+5pYQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9694467751585359085
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/4] tools/nolibc: add two new syscall helpers
Date:   Tue,  6 Jun 2023 16:08:40 +0800
Message-Id: <cover.1686036862.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Willy, Thomas

This is the revision of the v1 syscall helpers [1], just rebased it on
20230606-nolibc-rv32+stkp7a of [2]. It doesn't conflict with the -ENOSYS
patchset [3], so, it is ok to simply merge both of them.

This revision mainly applied your suggestions of v1, both of the syscall
return and call helpers are simplified or cleaned up.

Changes from v1 -> v2:

* tools/nolibc: sys.h: add __syscall() and __sysret() helpers
  * Use inline function instead of macro for the syscall return helper
    (Suggestion from Thomas)

  * Rename syscall return helper from __syscall_ret to __sysret
    (align with __syscall and it is not that long now)

  * Make __sysret() be always inline
    (Suggestion from Willy)

  * Simplify the whole __syscall() macro to oneline code
    (Benefit from the fixed 'long' return type of syscalls)

* tools/nolibc: unistd.h: apply __sysret() helper
  * Convert the whole _syscall() macro to oneline code

* tools/nolibc: sys.h: apply __sysret() helper
  * Futher convert both brk() and getpagesize() to oneline code 

* tools/nolibc: sys.h: apply __syscall() helper
  * Keep the same as v1, because the __syscall() usage not changed

Best regards,
Zhangjin

---
[1]: https://lore.kernel.org/linux-riscv/cover.1685856497.git.falcon@tinylab.org/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
[3]: https://lore.kernel.org/linux-riscv/cover.1685780412.git.falcon@tinylab.org/

Zhangjin Wu (4):
  tools/nolibc: sys.h: add __syscall() and __sysret() helpers
  tools/nolibc: unistd.h: apply __sysret() helper
  tools/nolibc: sys.h: apply __sysret() helper
  tools/nolibc: sys.h: apply __syscall() helper

 tools/include/nolibc/sys.h    | 366 ++++++----------------------------
 tools/include/nolibc/unistd.h |  11 +-
 2 files changed, 57 insertions(+), 320 deletions(-)

-- 
2.25.1

