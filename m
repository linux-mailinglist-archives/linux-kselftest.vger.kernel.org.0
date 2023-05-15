Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211B2702EE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjEON6O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjEON6N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:58:13 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548AAE77;
        Mon, 15 May 2023 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684159089;
        bh=qFf1hun0+xYmubtn9VmGNMqI2i9FxElFjRQQBueSdgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMaz/yz7Qcw42NQsO1xoVnzsuHpxh+Jym3JezQb5AqF2wIV+qw5EU3+6MX1RPSRJm
         NVKHulStaTKaLNqT62HHg2yrGP5Mkndk4bNHPwIi8uoOXDP5rKWnpoqExs9uyWsN5N
         EBHs7p2821ZdYox5kyt1QmyRJJc/X0/fMyHEKMjGs6XDTg4C9I3WWihaaHzb81C8PL
         rgY7iYJFPQVxB0xkbcTDXAXNcKTwSaQmLqPwseveD185SF/+DGNE2+gmzca31ATSEm
         GytgIGy1EfoIq7YceXXKA1K5ZftkfUjsjMYl8ZyRKAAYitt37Ku4hF0YRV20YV3thD
         jVBSng1FiqcTQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKgtn0Vt5z12dR;
        Mon, 15 May 2023 09:58:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/4] selftests/rseq: Fix CID_ID typo in Makefile
Date:   Mon, 15 May 2023 09:57:58 -0400
Message-Id: <20230515135801.15220-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
References: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ensure that the basic percpu ops tests are effectively built against
mm_cid.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/testing/selftests/rseq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index b357ba24af06..8f023b7cab60 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -31,7 +31,7 @@ $(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
 
 $(OUTPUT)/basic_percpu_ops_mm_cid_test: basic_percpu_ops_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
-	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID_ID $< $(LDLIBS) -lrseq -o $@
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID $< $(LDLIBS) -lrseq -o $@
 
 $(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
-- 
2.25.1

