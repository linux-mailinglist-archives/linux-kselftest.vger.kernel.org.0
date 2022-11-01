Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38D614CDA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKAOkA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAOj7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0287120B8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B6E1B81DEC
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECB0C43144;
        Tue,  1 Nov 2022 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313596;
        bh=00PR8/nuJtujDDYwl13sEDj5zwVgbMN4OsknhAsrsH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrShyTCS6BFlqhIudoVmx2ETzHReW2G6m4ATLyNs0y5l97nYxCACN3ej0o38yTylI
         HWRvegPL+NzUl1ZSuFuxsvJ+ulR6vI28242COepT6dBmefY9QhG+P4kL8+u4utRzy7
         qRvLW5/gy4EKnTaxjLiENaOkPrdO+d5Dl2UDFF93GnRe6AIM1IxpjnW5yQWLBem/0y
         B4CoKdiGU84s76pauX6YrulisEwpKm9LtQr48bhlvRF8lLxSbVzNBs8S/iA9Xvu9s9
         /WHzvy25IuBRYu/6iWnQzmIRGTRTadl/UKbPZEDpboj3u9ZBZhffMDKo2EuuzOsNK0
         DXuhZM3k9eNQA==
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
Subject: [PATCH v2 16/21] kselftest/arm64: Enumerate SME2 in the signal test utility code
Date:   Tue,  1 Nov 2022 14:33:31 +0000
Message-Id: <20221101143336.254445-17-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=broonie@kernel.org; h=from:subject; bh=00PR8/nuJtujDDYwl13sEDj5zwVgbMN4OsknhAsrsH4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS46EwSHdJtxJHAjAf8Zfz1sC/cs1BTSXZAb2G1l y/UKikGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuOgAKCRAk1otyXVSH0OlwB/ 9+hVBopJLDhiX4bXrMAHS1mYjUG+ZOoqvrO4y4SFxGpdKDgr4BZrK9z9q3mvqFgEBj6v00ku3Ir70L Edq7iXTJztUNqzx3496NNF6qAYoaCgr7vCKKdUCS6YHu6kWOM2y+GyO/kpej2Hbjs3UgrGwd2vgv59 mmlgLkcH0aZyclVSPatkUijv/x0Qzd9jk7R9aytlE4uOnN70P+ro750jQ2hOFJ+VfN4XB4n7Dj2Jyg fSdG5FrJ5rEm94SRS1lFfCKPRek3XJ1V5qND8gl2WpKZz97XPdRN8lq6nHeB0N4JajNXzhU5hgKzsC 73iJMbdqGFlTqFmKuuXuw3QUulsley
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
2.30.2

