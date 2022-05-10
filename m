Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5652219C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbiEJQtu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347636AbiEJQtm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902217644
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 355FC61811
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CB6C385CD;
        Tue, 10 May 2022 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201142;
        bh=+doQH0V5WrVXFxAnPAr+9FVdqU2NMS/NTVoUQBr2X+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xv9eky1VFhK56OWO3K77S8T1rRWOuwNbwJe+FCozmudeb9zKoxClA3BFioSorp/gb
         gfkvjNFnFN0zP7HriN6UPE/ypz1iamEPB/U3md1C5NdQl3ynf1dDXBrMciN2sk+orm
         m6eJ+sIn2WUKtijbYMHDQ/0AOsjEiCQkrpYzz4AMZJU1jUv1Fl6tq8Tk3ni2weAVSJ
         b4V2UryOGyF3LwaspcYkKRt3ICiJrQSJN9HlBL547qL2YJoOS4OBcpOgujYhwTxltm
         h8hmCfwG2+0+KMY49y6tbpPH/xVE7SejEa4xL5efGIGcXvGUPOoFgDy2HaclCGFS2M
         7A3JoESBo7rXQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/5] selftests/arm64: Allow zero tags in mte_switch_mode()
Date:   Tue, 10 May 2022 17:45:17 +0100
Message-Id: <20220510164520.768783-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510164520.768783-1-broonie@kernel.org>
References: <20220510164520.768783-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; h=from:subject; bh=+doQH0V5WrVXFxAnPAr+9FVdqU2NMS/NTVoUQBr2X+o=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiepacjqDNrDfpJZfEr3DwpfcqFuan/SeP5LzD9VQK CAX7dCOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnqWnAAKCRAk1otyXVSH0J00B/ 9k/VvTk83ITffqPZeHO8yhTPM8kJJUMoPQtCnahbvYY1OwB7szGoyB69Ksb9u0KDxGFLwSFTVsU1fZ iikZJrX2AFqJzAEa05XE2SqW6bBRUFuI8xev6pE4/PcViccpkIsXgzIO9ZOraB6LBpS1YgDLsUVcHu BcBXJuVxPR6tO62kuqg4mY3uZhQTy9u4CHgucvjNfryW/5d11nTl3rktiH6RQQ5C4S7fR7sSgHXDeA v4vmYt0TT+sw7oU2xIZ6yP+wBz2ht2aNsQ6f9xz9S0g+vHn0nUYGjSDB7RWZk2ceeoBQ/MHajDBuMW 84U8eieohLqlUZyHsMIdAW8Glum/zH
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

mte_switch_mode() currently rejects attempts to set a zero tag however
there are tests such as check_tags_inclusion which attempt to cover cases
with zero tags using mte_switch_mode(). Since it is not clear why we are
rejecting zero tags change the test to accept them.

The issue has not previously been as apparent as it should be since the
return value of mte_switch_mode() was not always checked in the callers
and the tests weren't otherwise failing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 260206f4dce0..6ff4c4bcbff1 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -283,7 +283,7 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
 		return -EINVAL;
 	}
 
-	if (!(incl_mask <= MTE_ALLOW_NON_ZERO_TAG)) {
+	if (incl_mask & ~MT_INCLUDE_TAG_MASK) {
 		ksft_print_msg("FAIL: Invalid incl_mask %lx\n", incl_mask);
 		return -EINVAL;
 	}
-- 
2.30.2

