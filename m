Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DFF702EE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbjEON6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjEON6N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:58:13 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5646B1996;
        Mon, 15 May 2023 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684159089;
        bh=oKkXMwl9CppgPR3HEtDQfgVFXUAQ6EoIiQSv7ieSscM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0KlErVnELFnQBYCIU7/4DVtm8ChMs3Um1YTqbh3V+4stsWeoXaGXJ+f5gdeuTz9P
         UxQgDzjIr4w/SFIXS6tOvjnoNwxU09OZGkqioRJgyyUlnZXhXpxvjKcz3ob3o4wFJW
         3Z3KLAPFbC8gLxGArXONszk1T9F/Jpw5rxvs46xSVt/7OYJJxZgiEamGgSSB3QcliJ
         vHl6gRlaI18Os/wxxEez521Asbd333ADvJFOVT3j/6FaL6ThuuSc8uOmf+Pcs055i/
         2FvNZb1aWRX4zfjisnosOT6pPgwgP+YJ1gBOG2UY33Br0VfmSB7HfNwwvNDTzhrr3w
         NlIVY6N+LKLFw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKgtn2TMyz12dS;
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
Subject: [PATCH 2/4] selftests/rseq: Implement rseq_unqual_scalar_typeof
Date:   Mon, 15 May 2023 09:57:59 -0400
Message-Id: <20230515135801.15220-3-mathieu.desnoyers@efficios.com>
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

Allow defining variables and perform cast with a typeof which removes
the volatile and const qualifiers.

This prevents declaring a stack variable with a volatile qualifier
within a macro, which would generate sub-optimal assembler.

This is imported from the "librseq" project.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/compiler.h | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
index f47092bddeba..49d62fbd6dda 100644
--- a/tools/testing/selftests/rseq/compiler.h
+++ b/tools/testing/selftests/rseq/compiler.h
@@ -33,4 +33,30 @@
 #define RSEQ_COMBINE_TOKENS(_tokena, _tokenb)	\
 	RSEQ__COMBINE_TOKENS(_tokena, _tokenb)
 
+#ifdef __cplusplus
+#define rseq_unqual_scalar_typeof(x)					\
+	std::remove_cv<std::remove_reference<decltype(x)>::type>::type
+#else
+#define rseq_scalar_type_to_expr(type)					\
+	unsigned type: (unsigned type)0,				\
+	signed type: (signed type)0
+
+/*
+ * Use C11 _Generic to express unqualified type from expression. This removes
+ * volatile qualifier from expression type.
+ */
+#define rseq_unqual_scalar_typeof(x)					\
+	__typeof__(							\
+		_Generic((x),						\
+			char: (char)0,					\
+			rseq_scalar_type_to_expr(char),			\
+			rseq_scalar_type_to_expr(short),		\
+			rseq_scalar_type_to_expr(int),			\
+			rseq_scalar_type_to_expr(long),			\
+			rseq_scalar_type_to_expr(long long),		\
+			default: (x)					\
+		)							\
+	)
+#endif
+
 #endif  /* RSEQ_COMPILER_H_ */
-- 
2.25.1

