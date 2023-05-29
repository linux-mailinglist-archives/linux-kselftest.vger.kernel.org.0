Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8649271501D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjE2T7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjE2T7A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:59:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E89B7;
        Mon, 29 May 2023 12:58:58 -0700 (PDT)
X-QQ-mid: bizesmtp81t1685390329tl4a1sn8
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:58:48 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 9fp+MOMfZT2zNx5cI/90p1+iD3OFYm3s3YK5fd6MqPYblqw1OWNOqBS6mtmxO
        fMoOM+E+goEI3ecHYGOH/rDB2EhsgYIwM5UgrdO6NKUa0jQ0vC5le58Goq/yJpBxb+QpkiK
        f/vtUsnjRUKAVtIvhP3uG0qEaAOKEDu1l+HU9ziNNi/9Lfj7/wkOqNDUij2iR6gXCjDyZ4n
        9lTIoyirLK/p7BAhjuaT0ah2jVt+yKYWrTeA25q9PEpJK2mFtyrxEXUF6lqNnOmRL3N/K9i
        45+J3itzDAeYalzg1hO+DaTd+jvKUXN2yBI7B5sZqCUToA1X/NJbzbD662koEts8WroOj3X
        dtwBusqYja9KxUeXB3ViNXaNnE0ucLWqFCxKVsIIrih7kvbRw4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5773408727969922355
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 10/13] tools/nolibc: sys_poll: add pure 64bit poll
Date:   Tue, 30 May 2023 03:58:42 +0800
Message-Id: <f0956ce681eb8abc81c91e6b34174034d5b32c07.1685387484.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's time to provide 64bit time structs for all platforms, for y2038 is
near.

ppoll_time64 has been added from v4.20 and the last arch support is at
least from v5.0.0

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index db648b5b9a1c..ca802627e88f 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -940,14 +940,21 @@ int pivot_root(const char *new, const char *old)
 static __attribute__((unused))
 int sys_poll(struct pollfd *fds, int nfds, int timeout)
 {
-#if defined(__NR_ppoll)
+#if defined(__NR_ppoll) || defined(__NR_ppoll_time64)
+#ifdef __NR_ppoll_time64
+	const long nr_ppoll = __NR_ppoll_time64;
+#elif __SIZEOF_LONG__ == 8
+	const long nr_ppoll = __NR_ppoll;
+#else
+#error No __NR_ppoll_time64 defined, cannot implement time64 sys_poll()
+#endif
 	struct timespec t;
 
 	if (timeout >= 0) {
 		t.tv_sec  = timeout / 1000;
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
-	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
+	return my_syscall5(nr_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else
-- 
2.25.1

