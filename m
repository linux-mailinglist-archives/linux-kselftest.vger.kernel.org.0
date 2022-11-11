Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523CD6263E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKKVwB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKKVvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21ED6B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F50FB827ED
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCE4C43140;
        Fri, 11 Nov 2022 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203496;
        bh=00PR8/nuJtujDDYwl13sEDj5zwVgbMN4OsknhAsrsH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qb7YuetQZZq4ey4h7zAoJrfOlGUj495/6AfC4SXj6DzlaChHOY8QRzC7KLBTZ3kDN
         fcXihTqzNP5KQf1gMSzbmIrLHvems/K/dK4sEutKpR+2r04ldw/TbU62o8tKubYrfK
         SzC+UoH1RrCyREG9V0zI8DKUr45SOwEXA87O6cHFPlInkSJfoaOjTOUgv5fIGuxgGs
         Czb6HRPrZMA3PnE6u45VYXCGbVoZ092a40raugZtItF7jwzhoHiyrXf8eLvZL8J008
         +JyMkarEgew6eT1HZZ2g4jUe1CrLZ9IT3Oi5raZTkyq2IbDQ73Ul6tkyxmcaYjBCpG
         TUmdH9NsPBFAw==
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
Subject: [PATCH v3 16/21] kselftest/arm64: Enumerate SME2 in the signal test utility code
Date:   Fri, 11 Nov 2022 21:50:21 +0000
Message-Id: <20221111215026.813348-17-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=broonie@kernel.org; h=from:subject; bh=00PR8/nuJtujDDYwl13sEDj5zwVgbMN4OsknhAsrsH4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOcEwSHdJtxJHAjAf8Zfz1sC/cs1BTSXZAb2G1l y/UKikGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DnAAKCRAk1otyXVSH0FGJB/ 40fOQ834mxneKlJ+SKnDUuJltgJdXilhCTew+j9PIqHSuMI6cWl0iC1bzXUXk8FY9bYieyn24Ta8US 4kk7wLshlfBXx9/KRDGwYm5NN9eVORw4I7Fq0qpC7xahPiqv1UdukqZD362AumLuLZOGajEKzuugjp nP9zk+WwiOlISE1XVQ7kimJ3pc0WGZsyHvew8IX0KVUvOnUWN9stRm7j1HtkPI5JxJ2Xe1OPt0DwMC YflxcOq/27BMC7qJjAXOPEM0wS80xTvNM/3IQv+ojcBELJ+gJrDTqZaNJfHoY+hR1UeEKTsBSkh/Uh tM2Ep648eazE8v6ulOKHZLvqSXviEW
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

