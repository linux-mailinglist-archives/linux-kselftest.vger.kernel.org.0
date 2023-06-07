Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA4725D16
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbjFGL3V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbjFGL3U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 07:29:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261B19BD;
        Wed,  7 Jun 2023 04:29:14 -0700 (PDT)
X-QQ-mid: bizesmtp79t1686137341tbhfj5g6
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 19:29:00 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: q+yjhizk/eL77uWPsAdnep0mzHEQMbth2xOfZxpWL32hs5VqgL/zmKwk14/Wu
        i9q8XPfvyhdXG9+3oacVYSQr6FunSQbFvOVbwZwjQv24RB6YKbMH//08rrGS+LL+BSbrRqZ
        CwnbEjY/+7z/JMzsKqgv6sbEgj0I452l0mX23xA7jCjrQIbCkImtOj7EoGL6pyYUt7UkshA
        mWct2lQuEKCpcF6JthwUcMbUeXZmqiBPya1w7LlWWa2RniMpOLmdCMGYKkdpMIdFoR87xBT
        zyVt0HFh417TKiCcYhGJVjDY+gvn/0l9+8eHCG/KlDx+j6PvBTx4Y+0SVn6yaSZXvaY5j0m
        QAJRD4PQlmSCcB1jJ9qo7Maw3XVxr15+CFbQOZhB8hlaYSTTbAJE1ybwp7nzPPkcOY8DcJL
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6806432981910364890
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/3] tools/nolibc: add a new syscall helper
Date:   Wed,  7 Jun 2023 19:28:58 +0800
Message-Id: <cover.1686135913.git.falcon@tinylab.org>
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

This is the revision of the v2 syscall helpers [1], it is based on
20230606-nolibc-rv32+stkp7a of [2]. It doesn't conflict with the v4 of
-ENOSYS patchset [3], so, it is ok to simply merge both of them.

This revision mainly applied Thomas' method, removed the __syscall()
helper and replaced it with __sysret() instead, because __syscall()
looks like _syscall() and syscall(), it may mixlead the developers.

Changes from v2 -> v3:

* tools/nolibc: sys.h: add a syscall return helper

  * The __syscall() is removed.

  * Align the code style of __sysret() with the others, and use
    __inline__ instead of inline (like stdlib.h) to let it work with
    the default -std=c89 in tools/testing/selftests/nolibc/Makefile

* tools/nolibc: unistd.h: apply __sysret() helper

  As v2.

* tools/nolibc: sys.h: apply __sysret() helper

  replaced __syscall() with __sysret() and merged two separated patches of v2 to one.

Did run-user tests for rv32 (with [3]), rv64 and arm64.

BTW, two questions for Thomas,

* This commit 659a49abc9c2 ("tools/nolibc: validate C89 compatibility")
  enables -std=c89, why not gnu11 used by kernel ? ;-)

* Do we need to tune the order of the macros in unistd.h like this:

    #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
    #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
    #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
    #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
    #define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)

  Before, It works but seems not put in using order:

    #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
    #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
    #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
    #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
    #define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)

Thanks.

Best regards,
Zhangjin

---
[1]: https://lore.kernel.org/linux-riscv/cover.1686036862.git.falcon@tinylab.org/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
[3]: https://lore.kernel.org/linux-riscv/cover.1686128703.git.falcon@tinylab.org/T/#t

Zhangjin Wu (3):
  tools/nolibc: sys.h: add a syscall return helper
  tools/nolibc: unistd.h: apply __sysret() helper
  tools/nolibc: sys.h: apply __sysret() helper

 tools/include/nolibc/sys.h    | 364 +++++-----------------------------
 tools/include/nolibc/unistd.h |  11 +-
 2 files changed, 55 insertions(+), 320 deletions(-)

-- 
2.25.1

