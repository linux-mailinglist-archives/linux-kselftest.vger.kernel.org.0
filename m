Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98C614CDB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKAOkB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiKAOkA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5D12AFF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354D5615EF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF4CC433D6;
        Tue,  1 Nov 2022 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313598;
        bh=aPsajbZlJ1Devthnun/HjJFRIhZ8YHh4Fs+22T7Mvjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Skeks33py27UHT6zdPPUzCyjRtXiplx97z/X1FmXwzhm86JkRE1ECuQ9nC5bTHA5K
         2/NlbZPck1BSTi14drdCMrX7EDl08GuCXticDObYYEiBevI4MO2eRzOrPJyj7i0oDC
         xY2NNaVZrtFDZdd9NUGCB6LFgQpT5ue9cm/bSPEcgB4iQfBLV+WBoJ/6F1W1wGf+HO
         OrBWGnnuBwAwNlzLWVVRlmEBsaJ2m08domNFsihjA4kAeukCy0MVIv5TFFDAXM6PpZ
         w2sE9ewHWPSVjR03MErvq6dS2AvgGKx7QhhVvkhessUrv0YIh+SdlMQxahdVcKos75
         wiOM0Yl6SU6Kw==
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
Subject: [PATCH v2 17/21] kselftest/arm64: Teach the generic signal context validation about ZT
Date:   Tue,  1 Nov 2022 14:33:32 +0000
Message-Id: <20221101143336.254445-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3158; i=broonie@kernel.org; h=from:subject; bh=aPsajbZlJ1Devthnun/HjJFRIhZ8YHh4Fs+22T7Mvjg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS47XpzWh18ZBwJu4MPVDW/1fV1ztVbBSwc1IDgW xTnzFKiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuOwAKCRAk1otyXVSH0HpEB/ 4o/6Y4Pbp9sAYsSPdvvsQFwq+Z+KKME3zYQ1klnFUx0KZB2+FEQtmVOwp0zMQjM0xkVBmHlo1rg2Jg 1ZoHKcjltEHB7hzYzSzgcMBanjdFtvhdLanZ5vsjkhCTqU3rJgwLxp6CwgcI3HowxMTTC6QzzN+3pw rUw4dkHGnTyFqYFjPIHTE3h3W3KMUyKBBeyAMxVbbY/1CIXXZrBnftB+HpSvjrpjQ1hp/G4o6eY4Ee 3r4dWDBQttHrjg+JuEDFzlaFwbaSVf4t2iidVIGWbrcAZQhR8p5keXhCSeZynRIx4YimHuSKoNSg7u 8JJkiN38xVAHbZ5CEIO9DCmIjoDuoK
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

