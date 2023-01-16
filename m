Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7847E66C5F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjAPQMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjAPQL5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:11:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC2226588;
        Mon, 16 Jan 2023 08:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB3461042;
        Mon, 16 Jan 2023 16:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3AAC433F0;
        Mon, 16 Jan 2023 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885249;
        bh=gxSkti1F5ID0rEdBPkOYNkvbTLYrpACDWicjOQ/QHTM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UyhocAeyDfUf7mfbCx7OgiHk3Ie4WUcMm09BaUqiVJ3cx8osp/udAklTxui+DxT6H
         aULoCL9MkXtEgOhJXHeBy1zqkLOXusLRo3cE4iSSrU69UU3PMz2cXgjQoPYliWBDT5
         AZ2yp2qiW1g7Le6RDPSYuAGlZB80pcU2RGJV+foDLtQv5NoBzgH2IW2fSgc7xy+Tqa
         NDfFPO6PsKKLwkbt1SAFLMn8ma6LTUic8VC0uVBRngwqHhu7rG5f/gS/4p4Rs7JErH
         ypA/NC+P5qvlve6iNSu3eV0dzyl7R2lHNQ7MjL1ttTr6FZD1U0QSFGb84rxVBMOfX+
         xSWjpF8VBqeuw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:51 +0000
Subject: [PATCH v4 16/21] kselftest/arm64: Enumerate SME2 in the signal
 test utility code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-16-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gxSkti1F5ID0rEdBPkOYNkvbTLYrpACDWicjOQ/QHTM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWuKST4k3gNaZh8n3qOfHlKwGQND65u7UKsCoNg
 E0iu9p6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1rgAKCRAk1otyXVSH0L9oB/
 90Pya2mgn5xLyBimadSMbweuMVLpEbeXxuJCJCt76/XtBmgMegGZmqZXvI4ikBWdrp5cK86xqy8Jwr
 JmcTbCDmaLuuno5d/So7oei2uamX+3DSgA3Jphfl66Q384isc+h+NNkLb27Kfuqrv5AU4N5LnmVWsH
 JDimqMrewSkJkuZnM64zRhV5rZXsPbjKwc81GTR18aDeFdbXvC9bCfDvBVJ8M5nPKI4g/qb4voHNcq
 sewxzos3q2qgFm7uKhpmFGAvDtKO589LnMLDEczs522xDRW/CMgzy0+OiGOOJCIFlKzbkHXIGdVjYV
 yOafhDjHP0UCN5GM061gzJtTs/NjYt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support test cases for SME2 by adding it to the set of features that we
enumerate so test cases can check for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals.h       | 2 ++
 tools/testing/selftests/arm64/signal/test_signals_utils.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 0c645834ddc3..1e6273d81575 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -34,6 +34,7 @@ enum {
 	FSVE_BIT,
 	FSME_BIT,
 	FSME_FA64_BIT,
+	FSME2_BIT,
 	FMAX_END
 };
 
@@ -41,6 +42,7 @@ enum {
 #define FEAT_SVE		(1UL << FSVE_BIT)
 #define FEAT_SME		(1UL << FSME_BIT)
 #define FEAT_SME_FA64		(1UL << FSME_FA64_BIT)
+#define FEAT_SME2		(1UL << FSME2_BIT)
 
 /*
  * A descriptor used to describe and configure a test case.
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 308e229e58ab..07f518f0e58d 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -29,6 +29,7 @@ static char const *const feats_names[FMAX_END] = {
 	" SVE ",
 	" SME ",
 	" FA64 ",
+	" SME2 ",
 };
 
 #define MAX_FEATS_SZ	128
@@ -323,6 +324,8 @@ int test_init(struct tdescr *td)
 			td->feats_supported |= FEAT_SME;
 		if (getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)
 			td->feats_supported |= FEAT_SME_FA64;
+		if (getauxval(AT_HWCAP2) & HWCAP2_SME2)
+			td->feats_supported |= FEAT_SME2;
 		if (feats_ok(td)) {
 			if (td->feats_required & td->feats_supported)
 				fprintf(stderr,

-- 
2.34.1

