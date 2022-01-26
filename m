Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4071349CDA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiAZPNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiAZPNy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:13:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AD6C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6FCC617B4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D877C340E8;
        Wed, 26 Jan 2022 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643210033;
        bh=HZPqgEGfMDOJRbR9O3affXiwGZAfPzgR37m4iq1abJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHPHxcSAlslb11pCOwl3Jo+DRTJxFbC+n3Xfdp9VIR+MX6Wxn5hBjvQ/NRn+1DlsL
         /T7cOObray3K3N8jD9JyKIuhTTxcQeU2xpHeTVbWE90QnibLlMqqqwGiQEgaRLFOIy
         4KNU4/7xNHbSMZvhzCrS/RvC19/TM2m+VULyo4+PEkBEGIAGKcFfj49bNyHSGgLEp5
         JvQqwUaD+QNfj681jJy4FPUGgjXCvR2+NrBeP0i+OF2NVrEtR1OCrEVIOPGo4P6GV9
         8QdemV2FFCQEj1OlO1MRMHWqm+fqkrptISS250R+mGLGyMzMLqp6SJ1excOmwLcBvH
         dcc8P7Onk1q1A==
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
Subject: [PATCH v9 33/40] kselftest/arm64: signal: Allow tests to be incompatible with features
Date:   Wed, 26 Jan 2022 15:11:13 +0000
Message-Id: <20220126151120.3811248-34-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3936; h=from:subject; bh=HZPqgEGfMDOJRbR9O3affXiwGZAfPzgR37m4iq1abJY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSRpfEXhZMiZZEUpvipJ+vhpvj7BzhhYgFzTZOk zo69Z22JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkkQAKCRAk1otyXVSH0Lf3B/ 9Xg2sLa9D12aP+Oj3NXxL28J51+BSip6GT4MaLaJrm+vwjwgxNUuSi3GWZYCIE3oWuqaxhOg0PYPQy kn/3/o2X885AR7rP4YqgIHG4WGck5T68WkbJjrv7ocz58I1rZLT+jUaWkfhFoSJbTrh++bLubHs6Di QfWzsESxW/pypWZmQXswLblwX07lEFEUYJKOk0SEiYkR7wzNCgPG+Hlg23cKTxq51nIbYb6UmX8KJo lYGtVBEOfu5DI/9Rgyw4/jKN1Nyo+SQLOjFKJiavyHSEA8DonwaVTmeeDwvyQDEJTG3rcs1pjQWf/H rrX2E9g3MWBXc9dtSU82cc+1Cw9j4W
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

