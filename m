Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D11C49AA65
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348914AbiAYDh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3422139AbiAYCaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 21:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423DC08ED7A
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 16:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939EF6134C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990EBC340E4;
        Tue, 25 Jan 2022 00:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069847;
        bh=HZPqgEGfMDOJRbR9O3affXiwGZAfPzgR37m4iq1abJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzwwBsJ0t1q8OrUhQMZIyiGf10xJqpZ0GvCBvBG8Xp56kg8hUeTo0/x3P1fUvvwoB
         ngBe1XCVNztseWN9Q1Xe4aMrpoxMSRs/mQ9UTZ3OFxyenCJc/IyLN4yFgUUYcYF13R
         0lxKNBLd+4dsXH+9X/CoTPbrTGhz0RsMCAPhoHRpXN9M9D6ttkODe2WdxQOKHBZpRm
         tiS5cf3JWOTwgZbF9Ow0oXUcuiqyPfIRkLdnvjWMtUsEY10b1/wb8O1xD5rUpJlPY6
         XgCkjG1qIbx6JPQsTXc4mJk+D1tkHmsbpLkqfMsf0WW44l7lBrHzssgfhUbYn60nnc
         eWgQOFuCzhp3g==
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
Subject: [PATCH v8 32/38] kselftest/arm64: signal: Allow tests to be incompatible with features
Date:   Tue, 25 Jan 2022 00:11:08 +0000
Message-Id: <20220125001114.193425-33-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3936; h=from:subject; bh=HZPqgEGfMDOJRbR9O3affXiwGZAfPzgR37m4iq1abJY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AapfEXhZMiZZEUpvipJ+vhpvj7BzhhYgFzTZOk zo69Z22JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AGgAKCRAk1otyXVSH0NfCB/ 9x7wiP639S3YusZL3LM1Pr/h0ZEmHKhzxHIEV/01U1x3N5FH9WMlRPRugEO7A1yHrOqBp7FGJ9gNvc L4e0C8EjOLy/ACaw9vWKKGo7bLY2dauIAfHBj7SbR/oqY1c+iibibSzL8K32PJbMOL7qCwsU+hEzNe HkZMQV2xYPAw6p3QT1JJ00zK0JjV8aIDEcBn8MygixdFf2/zoXDjT/PHqMDS/85U2xDMGQMT/FemeB +Nz6K6GxAJDWpSz+DF/p4GB6ZFhxBdhh3eM5EhPp3wphfYI0r5XsDL1i7D85tx2PvZMsq8u2OEtWeL qwL979giwbxb+vesuTVA4Bj+23EQKe
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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

