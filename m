Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45683725A2A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjFGJXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 05:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjFGJX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 05:23:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C911BD4;
        Wed,  7 Jun 2023 02:23:15 -0700 (PDT)
X-QQ-mid: bizesmtp76t1686129784tl9oaodx
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 17:23:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: XBN7tc9DADIFM7iJZj/3G7Db0AryQR0jjbOpzlxnxKCoLoFzk5a9wv39TaYWu
        ORYSoDohQWzfiO2HMD9c3nIiwV7hU7SvXXsgjVVEgIKzzWzlIEj+SIIOgeMWIhK8gieeJqj
        El0KIX7ZCs4DEV4VU8uoQg4sGFiOSRnDWIX15ZHeVMSaA2vNR03IXhOavencDcqiA/FXcRV
        gSN5OkZFthKYp+2Y3EkQGbcFAJt+uj3xYqmlNOiFWm1Qge73AXDVlTBMS30VJc19M0esJCS
        blGSJzEItp1FH42FFapLAV6sUEFBgVPR+rZOP/9/So1cNojn7EJgk6dD5r88UNv2WYjL+cy
        3ufanl8BnMM1Ej2IbElHh/5IxP7Buw/5pA32TbbCeFJVevY0TKat15DKUdsL7LqipDUbRwJ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10563508675985585977
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/3] nolibc: add part2 of support for rv32
Date:   Wed,  7 Jun 2023 17:23:01 +0800
Message-Id: <cover.1686128703.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi, Willy

This is the v4 part2 of support for rv32 (v3 [1]), it applied the
suggestions from Thomas, Arnd [2] and you [3]. now, the rv32 compile
support almost aligned with x86 except the extra KARCH to make kernel
happy, thanks very much for your nice review!

Since the 'override' method mentioned in [4] split the whole Makefile
context to two parts, it may make the code not that easy to maintain,
so, this patchset goes back to the KARCH (suggested from Willy, before,
I used something like _ARCH) passing method, as suggested by Willy, we
also aligned the KARCH assignment with the other variables.

Changes from v3 -> v4:

* No new changes in the first two except a new Reviewed-by line from Arnd

* selftests/nolibc: riscv: customize makefile for rv32

  Do it like the other architectures, especially like x86.

  The difference from x86 is, the top-level kernel Makefile doesn't
  accept riscv32 and riscv64, it only accept riscv, to make kernel happy,
  a KARCH variable is added for riscv32 and riscv64, and then passed to
  kernel with ARCH=$(KARCH).

  Since tools/include/nolibc/Makefile shares arch-riscv.h between riscv32
  and riscv64 and there is a headers_standalone target who called kernel
  headers and headers_install, so, pass ARCH=$(KARCH) to it too.

Did compile test for aarch64, rv32 and rv64, include run-user and run.

Note, this is required with the default config from the
20230606-nolibc-rv32+stkp7a branch of [5]:

    diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
    index ce02bb09651b..72bd8fe0cad6 100644
    --- a/kernel/rcu/tasks.h
    +++ b/kernel/rcu/tasks.h
    @@ -1934,11 +1934,13 @@ void show_rcu_tasks_gp_kthreads(void)
     }
     #endif /* #ifndef CONFIG_TINY_RCU */
     
    +#ifdef CONFIG_TASKS_RCU
     struct task_struct *get_rcu_tasks_gp_kthread(void)
     {
            return rcu_tasks.kthread_ptr;
     }
     EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
    +#endif
     
     #ifdef CONFIG_PROVE_RCU
     struct rcu_tasks_test_desc {


Best regards,
Zhangjin

---

[1]: https://lore.kernel.org/linux-riscv/cover.1685780412.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/linux-riscv/d1c83340-af4c-4780-a101-b9d22b47379c@app.fastmail.com/
[3]: https://lore.kernel.org/lkml/ZIAywHvr6UB1J4of@1wt.eu/
[4]: https://lore.kernel.org/lkml/20230607063314.671429-1-falcon@tinylab.org/
[5]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git



Zhangjin Wu (3):
  tools/nolibc: fix up #error compile failures with -ENOSYS
  tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
  selftests/nolibc: riscv: customize makefile for rv32

 tools/include/nolibc/sys.h              | 38 ++++++++++++++++---------
 tools/testing/selftests/nolibc/Makefile | 20 +++++++++++--
 2 files changed, 42 insertions(+), 16 deletions(-)

-- 
2.25.1

