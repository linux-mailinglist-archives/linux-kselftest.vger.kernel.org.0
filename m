Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC73917EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhEZMw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 08:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234906AbhEZMt0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 08:49:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D075613E6;
        Wed, 26 May 2021 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622033274;
        bh=8X2I+f5PJ7kkjivmgwzIimvrHxn47XP2IMrRBWyux0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTc+LAWZrmDrLwN74VDAQIB3dwNTMBujw5i9klqZDqOkS1QLlD6C2dqgHUHAzvAFQ
         czQljDKN6erb3bIkP5+6TGKpD2CKlnVpzGwMpF+m3h69f4iINNbGaFj0An46Soo33J
         xzZKNvsrrYV5pTi9wUTGgme0yb9yXZ9Datq3H5Mz10ZyBzyEAr0OobwskAwaSkpTPJ
         U2V5/cu83Zd2KeqV32EBTBBcgxFLHg5TZuEHY/Rik8EvPeFxcyIO428JPGfbGcsZnf
         O5nxU5gu/IV1yJEFc56OzmHxnQstUvQASZE5E3CrdZIAgMfMMY5TNQLCxNlDjNneC1
         QzoDapnOYRqbg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] selftests/sgx: Add EXPECT_EEXIT() macro
Date:   Wed, 26 May 2021 15:47:40 +0300
Message-Id: <20210526124740.16783-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526124740.16783-1-jarkko@kernel.org>
References: <20210526124740.16783-1-jarkko@kernel.org>
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
index d658882b5dd2..86d4283f9c61 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -207,6 +207,14 @@ static inline int encl_call(const void *in, void *out, struct sgx_enclave_run *r
 	return ret;
 }
 
+#define EXPECT_EEXIT(run) \
+	do { \
+		EXPECT_EQ((run)->function, EEXIT); \
+		if ((run)->function != EEXIT) \
+			TH_LOG("0x%02x 0x%02x 0x%16llx", (run)->exception_vector, \
+			       (run)->exception_error_code, (run)->exception_addr); \
+	} while (0)
+
 TEST_F(enclave, unclobbered_vdso)
 {
 	uint64_t result = 0;
@@ -214,7 +222,7 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(encl_call(&MAGIC, &result, &self->run, false), 0);
 
 	EXPECT_EQ(result, MAGIC);
-	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
@@ -225,7 +233,7 @@ TEST_F(enclave, clobbered_vdso)
 	EXPECT_EQ(encl_call(&MAGIC, &result, &self->run, true), 0);
 
 	EXPECT_EQ(result, MAGIC);
-	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
@@ -247,7 +255,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	EXPECT_EQ(encl_call(&MAGIC, &result, &self->run, true), 0);
 
 	EXPECT_EQ(result, MAGIC);
-	EXPECT_EQ(self->run.function, EEXIT);
+	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
-- 
2.31.1

