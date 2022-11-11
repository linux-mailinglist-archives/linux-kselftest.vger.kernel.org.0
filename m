Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2D6263E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKKVwD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKVvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782B6B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD50CB82802
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64085C433C1;
        Fri, 11 Nov 2022 21:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203498;
        bh=aPsajbZlJ1Devthnun/HjJFRIhZ8YHh4Fs+22T7Mvjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5UmNB9/x9g7lsbR4j+XCgNw4JNktfgxfY1J5iywH8mVqUdlmuAXROlVinWvsOmqM
         0pS5q8mPx4nmOlS1vs4Kq+Ww28BnDiNCrM6JECM4noNyAHORJLhtJgss9N5nNC2mXZ
         ph5HcMOh1xXcJ4NhYAbTFGe6A7uCj4UEQhEyrF1TR6ShAsa5exEy9r5SatO2t4qqSD
         gVjSGxOngOv5o2PGUHs2El+2hnGI9PadV7l04FBmQrMD5NJebYrQYYdLkDxYwPSprG
         exTbFtLmfKy1O4QIegNGt9TlmaGGDnrHiLr4ck88Dpn0k3oWbXaIZwSnfDpGKEgASN
         opK4CYvVaZtxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 17/21] kselftest/arm64: Teach the generic signal context validation about ZT
Date:   Fri, 11 Nov 2022 21:50:22 +0000
Message-Id: <20221111215026.813348-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3158; i=broonie@kernel.org; h=from:subject; bh=aPsajbZlJ1Devthnun/HjJFRIhZ8YHh4Fs+22T7Mvjg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOdXpzWh18ZBwJu4MPVDW/1fV1ztVbBSwc1IDgW xTnzFKiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DnQAKCRAk1otyXVSH0BFsB/ 95NZS0Q5fJYDwEO1IQ5DiNLp7/Ekr9uQ+4KvnwQVG38/WR1n3uh0TyvqJc2e6vGF49jsx0zCRJsszb 2MTiHcw5Wm+TvRaiUErnG2EHj7asj/lwXqKWEamWjvRJAv4cDvsys/X/IozlN3udlkF1T8qHcxO7rx Fyi6/OhgA43X2/aDwBck7K3Q8Az1EiTr851m+06VOnTFcPtz7RTxa65VpMiaAOd5nUIYGdRZ2UDx2p nz0SNLujIsjtix4bjfem4vhY2gKGmtuK+MCV5N9GI/CKM0x1wCRQPI1LagyPBVRahKk2iGjDmPdLDz IiOP+HCBCgzjvunnDJKEAiwghCWCah
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ZT to the set of signal contexts that the shared code understands and
validates the form of.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/testcases.c        | 36 +++++++++++++++++++
 .../arm64/signal/testcases/testcases.h        |  1 +
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index e1c625b20ac4..9bee976aff55 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -104,6 +104,26 @@ bool validate_za_context(struct za_context *za, char **err)
 	return true;
 }
 
+bool validate_zt_context(struct zt_context *zt, char **err)
+{
+	if (!zt || !err)
+		return false;
+
+	/* If the context is present there should be at least one register */
+	if (zt->nregs == 0) {
+		*err = "no registers";
+		return false;
+	}
+
+	/* Size should agree with the number of registers */
+	if (zt->head.size != ZT_SIG_CONTEXT_SIZE(zt->nregs)) {
+		*err = "register count does not match size";
+		return false;
+	}
+
+	return true;
+}
+
 bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 {
 	bool terminated = false;
@@ -113,6 +133,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 	struct extra_context *extra = NULL;
 	struct sve_context *sve = NULL;
 	struct za_context *za = NULL;
+	struct zt_context *zt = NULL;
 	struct _aarch64_ctx *head =
 		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
 	void *extra_data = NULL;
@@ -172,6 +193,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			za = (struct za_context *)head;
 			new_flags |= ZA_CTX;
 			break;
+		case ZT_MAGIC:
+			if (flags & ZT_CTX)
+				*err = "Multiple ZT_MAGIC";
+			/* Size is validated in validate_za_context() */
+			zt = (struct zt_context *)head;
+			new_flags |= ZT_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
@@ -221,6 +249,9 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 		if (new_flags & ZA_CTX)
 			if (!validate_za_context(za, err))
 				return false;
+		if (new_flags & ZT_CTX)
+			if (!validate_zt_context(zt, err))
+				return false;
 
 		flags |= new_flags;
 
@@ -232,6 +263,11 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 		return false;
 	}
 
+	if (terminated && (flags & ZT_CTX) && !(flags & ZA_CTX)) {
+		*err = "ZT context but no ZA context";
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index 040afded0b76..a08ab0d6207a 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -18,6 +18,7 @@
 #define SVE_CTX		(1 << 1)
 #define ZA_CTX		(1 << 2)
 #define EXTRA_CTX	(1 << 3)
+#define ZT_CTX		(1 << 4)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 
-- 
2.30.2

