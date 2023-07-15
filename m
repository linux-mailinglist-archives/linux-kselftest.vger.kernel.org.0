Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75537754AC3
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGOSfx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOSfw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:35:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BD128;
        Sat, 15 Jul 2023 11:35:50 -0700 (PDT)
X-QQ-mid: bizesmtp69t1689446141t0a64ark
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:35:40 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: hoArX50alxEP2Sb8uvEvfwqp0isWNa+zWwxc+jw4R+V+O93iv1AjpTAT4wLPu
        PukhzTWa5syj0mOwXIxwt0hxvE5xVzWIFKWesXrgJV0hpeKOypPkgDYnMS7Tt2sswDV9/iq
        kqHik0GlrccCDs2yLDgwMqnl4JgV7v/9IFfvXrnAjx6IwMQxHdl95E4qf6rgLheAkX/nQjJ
        QPFVtZc8LbWahGJwD4hnWHgPHEoTYdW64iNXQVS5wBazPhBlInFmUJnPhDdl71FqipoAXqb
        EvCRA6HfO625yW8Ci3t92M2P58BsQJcT14wuvIfsx8iHA04UnnglO9FrLGV394Uvghh4YNP
        cOJ/hBnYw/i4Nuiq5Q/RgH10ERc+f54VMnkJQpu6/iySfbER4Nl2tpVNVbUfBdRHA4q37VQ
        tgPSxoAPSLY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13372605302875324200
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 17/18] selftests/nolibc: allow run nolibc-test locally
Date:   Sun, 16 Jul 2023 02:35:39 +0800
Message-Id: <03aa4c73f88806a7c3a7648a24793246a6e70afa.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is able to run nolibc-test directly without qemu-user when the target
machine is the same as the host machine.

Sometimes, the result running locally may help a lot when the qemu-user
package is too old.

When the target machine differs from the host machine, it is also able
to run nolibc-test directly with qemu-user-static + binfmt_misc.

Link: https://lore.kernel.org/lkml/ZKutZwIOfy5MqedG@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index d31d6cea82e2..b42e67b1a7e2 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -133,10 +133,16 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
 
+# local libc-test
 run-libc-test: libc-test
 	$(Q)./libc-test > "$(CURDIR)/run.out" || :
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+# local nolibc-test
+run-nolibc-test: nolibc-test
+	$(Q)./nolibc-test > "$(CURDIR)/run.out" || :
+	$(Q)$(REPORT) $(CURDIR)/run.out
+
 # qemu user-land test
 run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
-- 
2.25.1

