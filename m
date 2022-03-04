Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838D44CD13C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbiCDJia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiCDJiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C14180238;
        Fri,  4 Mar 2022 01:37:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A71561877;
        Fri,  4 Mar 2022 09:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5D8C340EF;
        Fri,  4 Mar 2022 09:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386640;
        bh=fNTV4I+C0WTycHpfTEy4ufYiU5ACD5yToWtt9P3LLcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zxklv0+mjLnuEjVfhieo8wknZwsJ+Ka5beq8Enuh+yawD7aJyoar1IHAb148XKLoa
         TakPoKOdaiNnLohz1FNH3Glf7oqxP8X2jojeYzrRBqo3HyrUlBOQwsRP0PNTGpcJpp
         +HT+seybm3SVuS+UdHzFJJwsYbdHevMHLbiCQDBT3gMmr1Izbyy7G8fCmJKuyPteqx
         XcWFEOlG2x26Y6qNfXRRF5Ec+pG8Hl0LgJPvzoIH1rBgrrrbvzqY6JZkpyZjJzqm9v
         5t+QVrNNp37qd+c7kee87RmRHi/6hidyvN23duVe8fke/xM2WYwfJ56Z5aNy80Vuux
         XwnMo73FqZIIg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 24/30] selftests/sgx: Introduce TCS initialization enclave operation
Date:   Fri,  4 Mar 2022 11:35:18 +0200
Message-Id: <20220304093524.397485-24-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The Thread Control Structure (TCS) contains meta-data used by the
hardware to save and restore thread specific information when
entering/exiting the enclave. A TCS can be added to an initialized
enclave by first adding a new regular enclave page, initializing the
content of the new page from within the enclave, and then changing that
page's type to a TCS.

Support the initialization of a TCS from within the enclave.
The variable information needed that should be provided from outside
the enclave is the address of the TCS, address of the State Save Area
(SSA), and the entry point that the thread should use to enter the
enclave. With this information provided all needed fields of a TCS
can be initialized.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/defines.h   |  8 +++++++
 tools/testing/selftests/sgx/test_encl.c | 30 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index b638eb98c80c..d8587c971941 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -26,6 +26,7 @@ enum encl_op_type {
 	ENCL_OP_NOP,
 	ENCL_OP_EACCEPT,
 	ENCL_OP_EMODPE,
+	ENCL_OP_INIT_TCS_PAGE,
 	ENCL_OP_MAX,
 };
 
@@ -68,4 +69,11 @@ struct encl_op_emodpe {
 	uint64_t flags;
 };
 
+struct encl_op_init_tcs_page {
+	struct encl_op_header header;
+	uint64_t tcs_page;
+	uint64_t ssa;
+	uint64_t entry;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 5b6c65331527..c0d6397295e3 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -57,6 +57,35 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
+static void *memset(void *dest, int c, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		((char *)dest)[i] = c;
+
+	return dest;
+}
+
+static void do_encl_init_tcs_page(void *_op)
+{
+	struct encl_op_init_tcs_page *op = _op;
+	void *tcs = (void *)op->tcs_page;
+	uint32_t val_32;
+
+	memset(tcs, 0, 16);			/* STATE and FLAGS */
+	memcpy(tcs + 16, &op->ssa, 8);		/* OSSA */
+	memset(tcs + 24, 0, 4);			/* CSSA */
+	val_32 = 1;
+	memcpy(tcs + 28, &val_32, 4);		/* NSSA */
+	memcpy(tcs + 32, &op->entry, 8);	/* OENTRY */
+	memset(tcs + 40, 0, 24);		/* AEP, OFSBASE, OGSBASE */
+	val_32 = 0xFFFFFFFF;
+	memcpy(tcs + 64, &val_32, 4);		/* FSLIMIT */
+	memcpy(tcs + 68, &val_32, 4);		/* GSLIMIT */
+	memset(tcs + 72, 0, 4024);		/* Reserved */
+}
+
 static void do_encl_op_put_to_buf(void *op)
 {
 	struct encl_op_put_to_buf *op2 = op;
@@ -100,6 +129,7 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_op_nop,
 		do_encl_eaccept,
 		do_encl_emodpe,
+		do_encl_init_tcs_page,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
-- 
2.35.1

