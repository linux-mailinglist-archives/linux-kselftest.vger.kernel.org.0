Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D863A270A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFJIce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 04:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhFJIcb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 04:32:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572E3613E7;
        Thu, 10 Jun 2021 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623313835;
        bh=x8L2XbT7UeF/YX+xMXCb8IgKRZGfTLgzOlAx/pbaHjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbHFvJAu+5bqyUdSvaH7thgy4D9ZlZbi69IEkoAc6dhDAMTRU3PVxhjSrL9iOArXS
         dekLPr9ez9u1lkLzkORFOgqkOiYNhEcc580XaEQTrkTVihlG6Bfc2KVkuYbZs//iw4
         Mq6XfwESpbbh4hun25piK1YyOqXXG7BI6do+DOakDIIstnCj4DIKKm7BqpCbus1IYe
         pi1zmqPtZL58gjn9gQnyonBtTh3+R3fDt0MrAd7oYwOhv9YJGBnuHIslo14tCGoQsI
         nOaDmUWeRBai3PMB3A7O69on85xfrOoDqo/zCQIjPIZP1/fJ00/rgHTItMRMBTanfG
         tGwcbcOrKA9iA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/5] selftests/sgx: Add EXPECT_EEXIT() macro
Date:   Thu, 10 Jun 2021 11:30:20 +0300
Message-Id: <20210610083021.392269-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610083021.392269-1-jarkko@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add EXPECT_EEXIT() macro, which will conditionally print the exception
information, in addition to

  EXPECT_EQ(self->run.function, EEXIT);

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 14030f8b85ff..bcd0257f48e0 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -205,6 +205,14 @@ FIXTURE_TEARDOWN(enclave)
 		ret; \
 	})
 
+#define EXPECT_EEXIT(run) \
+	do { \
+		EXPECT_EQ((run)->function, EEXIT); \
+		if ((run)->function != EEXIT) \
+			TH_LOG("0x%02x 0x%02x 0x%016llx", (run)->exception_vector, \
+			       (run)->exception_error_code, (run)->exception_addr); \
+	} while (0)
+
 TEST_F(enclave, unclobbered_vdso)
 {
 	uint64_t result = 0;
@@ -212,7 +220,7 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, false), 0);
 
 	EXPECT_EQ(result, MAGIC);
-	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
@@ -223,7 +231,7 @@ TEST_F(enclave, clobbered_vdso)
 	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, true), 0);
 
 	EXPECT_EQ(result, MAGIC);
-	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
@@ -245,7 +253,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	EXPECT_EQ(ENCL_CALL(&MAGIC, &result, &self->run, true), 0);
 
 	EXPECT_EQ(result, MAGIC);
-	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
-- 
2.31.1

