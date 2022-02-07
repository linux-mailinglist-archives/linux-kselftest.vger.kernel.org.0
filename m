Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1313D4AC3F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbiBGPfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbiBGPXa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:23:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4AAC0401C8
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:23:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF8E8B815B1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E1BC340F3;
        Mon,  7 Feb 2022 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247406;
        bh=HZPqgEGfMDOJRbR9O3affXiwGZAfPzgR37m4iq1abJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9DNThZ1/xIHSIAxLD8ZnWQhP0gFAGhIXNfmcIo++j+LXui6uVKgfsBrU52cUpGnU
         rb45OBkIe7iWC88k345VOVlKa5yYNoAsUDHsFx+hhHRWuW6JHTdKUF7h5H7IPeO+3h
         ymat2ODmNysLMsIWiiysIr62JHeEAwy+u8BXEeAtOgT0inTYePxvz2JeL3KxVFgDwn
         6XgNk7HaitYBJSaW+5wIcaA/si7xR4xe7EFNAzgJMCdmBPxIacdNjL+4ECTA48ZbXz
         Ar0pzz59h1UPB6XWcussgArKqAvY577Ef73g/5oabm01813ql7pTPoIBMqHibDaFPL
         QeizzL9adNu8g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v11 05/40] kselftest/arm64: signal: Allow tests to be incompatible with features
Date:   Mon,  7 Feb 2022 15:20:34 +0000
Message-Id: <20220207152109.197566-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3936; h=from:subject; bh=HZPqgEGfMDOJRbR9O3affXiwGZAfPzgR37m4iq1abJY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjIpfEXhZMiZZEUpvipJ+vhpvj7BzhhYgFzTZOk zo69Z22JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE4yAAKCRAk1otyXVSH0J7nB/ 4/xFy8VZEPbn9wYFKdYQ/v1pkPPiiC1Syg/k8Hu0vQMGqfTcnISl3O6UbfA9l1MN5oxVtho9gdkgtB g7qHczJkr806SFioyMc5feCeWoF/ytlpLyTmdzlSHQj78QPjaysc4sXZb+1xOy8UJg+2eeybp+a+pC RPTC5Hv4BCU3QV1/1N8LWffkcp4QGNg9+bh/61gBqCgNOePZkIH+7OzM/Xra2+NUlhW5qHXrnou4UO f2NuDFlOxzBx+VBLVBe0r5TjFWElbRxI5tHGd8cHiw7oDF9tDIkvOHRCbTkyZOgCA+oOD/BWgAAePK XsmuGfyI0x59Fxm+JM0lm4Wj3kM9Yd
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some features may invalidate some tests, for example by supporting an
operation which would trap otherwise. Allow tests to list features that
they are incompatible with so we can cover the case where a signal will
be generated without disruption on systems where that won't happen.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/signal/test_signals.h     |  1 +
 .../arm64/signal/test_signals_utils.c         | 34 ++++++++++++++-----
 .../arm64/signal/test_signals_utils.h         |  2 ++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index ebe8694dbef0..f909b70d9e98 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -53,6 +53,7 @@ struct tdescr {
 	char			*name;
 	char			*descr;
 	unsigned long		feats_required;
+	unsigned long		feats_incompatible;
 	/* bitmask of effectively supported feats: populated at run-time */
 	unsigned long		feats_supported;
 	bool			initialized;
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 2f8c23af3b5e..5743897984b0 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -36,6 +36,8 @@ static inline char *feats_to_string(unsigned long feats)
 {
 	size_t flen = MAX_FEATS_SZ - 1;
 
+	feats_string[0] = '\0';
+
 	for (int i = 0; i < FMAX_END; i++) {
 		if (feats & (1UL << i)) {
 			size_t tlen = strlen(feats_names[i]);
@@ -256,7 +258,7 @@ int test_init(struct tdescr *td)
 		td->minsigstksz = MINSIGSTKSZ;
 	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
 
-	if (td->feats_required) {
+	if (td->feats_required || td->feats_incompatible) {
 		td->feats_supported = 0;
 		/*
 		 * Checking for CPU required features using both the
@@ -267,15 +269,29 @@ int test_init(struct tdescr *td)
 		if (getauxval(AT_HWCAP) & HWCAP_SVE)
 			td->feats_supported |= FEAT_SVE;
 		if (feats_ok(td)) {
-			fprintf(stderr,
-				"Required Features: [%s] supported\n",
-				feats_to_string(td->feats_required &
-						td->feats_supported));
+			if (td->feats_required & td->feats_supported)
+				fprintf(stderr,
+					"Required Features: [%s] supported\n",
+					feats_to_string(td->feats_required &
+							td->feats_supported));
+			if (!(td->feats_incompatible & td->feats_supported))
+				fprintf(stderr,
+					"Incompatible Features: [%s] absent\n",
+					feats_to_string(td->feats_incompatible));
 		} else {
-			fprintf(stderr,
-				"Required Features: [%s] NOT supported\n",
-				feats_to_string(td->feats_required &
-						~td->feats_supported));
+			if ((td->feats_required & td->feats_supported) !=
+			    td->feats_supported)
+				fprintf(stderr,
+					"Required Features: [%s] NOT supported\n",
+					feats_to_string(td->feats_required &
+							~td->feats_supported));
+			if (td->feats_incompatible & td->feats_supported)
+				fprintf(stderr,
+					"Incompatible Features: [%s] supported\n",
+					feats_to_string(td->feats_incompatible &
+							~td->feats_supported));
+
+
 			td->result = KSFT_SKIP;
 			return 0;
 		}
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 6772b5c8d274..f3aa99ba67bb 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -18,6 +18,8 @@ void test_result(struct tdescr *td);
 
 static inline bool feats_ok(struct tdescr *td)
 {
+	if (td->feats_incompatible & td->feats_supported)
+		return false;
 	return (td->feats_required & td->feats_supported) == td->feats_required;
 }
 
-- 
2.30.2

