Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64B6656B43
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiL0NIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiL0NIM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:08:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DBBC22
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 05:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 402ED61159
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 13:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8D4C433D2;
        Tue, 27 Dec 2022 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146470;
        bh=xDyRSGoHuFrSYgE6BySpQvmHRd5fFKw0HhCRo1ANkdQ=;
        h=From:Date:Subject:To:Cc:From;
        b=lpYHhhQpdGO6t0fm727aOH62PysUs+PcFIESMuAbEAroUjx4WVN5Fj48rqq8crxeQ
         Lvtvw8KUb1vau5FO7AUd5GaQE0yEadb7t6pzs0PnSw1jiUv/bfB2z2pYvfsIQFnsdJ
         EXFYBXKIzf0CPUb3XReOcr6KzyJpAeNnIspFXXqRM2ZSOv9RtpZ0gItAZ9xgw6J0Gj
         C76n9sCQVmy54dBlVRUydP2le4jznbamD6ff794vOi9JlSO1EsCHjNmuSMD5K9cNI2
         Qz6fe7wzWfUdmqniNw2wbwv8amrDIaDdq4Fui7iv8k6S5LAxggImsEtoTVhvaFwpL+
         D7Nlp44hvBtyA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 13:07:45 +0000
Subject: [PATCH] kselftest/arm64: Skip non-power of 2 SVE vector lengths in fp-stress
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221220-arm64-fp-stress-pow2-v1-1-d0ce756b57af@kernel.org>
X-B4-Tracking: v=1; b=H4sIACHuqmMC/x2NQQqDMBAAvyJ77lKzBG37ldJDoqvuwSTsSlsQ/
 97Y4zAMs4OxChs8mh2U32KSUwV3aWBYQpoZZawM1BI5ohaDrp3HqaBtymZY8ocw3hxz53vn7wQ1
 jcEYo4Y0LGecVWZJ1zXYxnr6ojzJ9799vo7jB5Pi7yuGAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xDyRSGoHuFrSYgE6BySpQvmHRd5fFKw0HhCRo1ANkdQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqu4kzZW+osJBWLRnRJG2tHjFPO2kQXbFgnObJURI
 32NtFhGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6ruJAAKCRAk1otyXVSH0M5VB/
 4oKaYfrwEPMwiLaRdrfHUr7/xz8ImCGpQvXsgT80O/PuNAdwx2HSal2DWhAbMiqNuvw1Een/6hs/dh
 TAtb0lt5x+O8GC7JF0l0ONuk02BHupCkADjt37/x1iP3jwEdZNPx42vqxZ9mY1OjCwUQhKWKFFCj/4
 2sOH8c2SYylHu5iAdhISQ/b7JHU153Zo1LKABwQnt+2FPOsDtItecL9WeE5/VNQc1Va73GQpcUM1h1
 xqYOyVX2zPQQosesGEtAFu/2TdL1JItRCVf3TQNKs31B4NLTPaia29B0npYEpg1MN2IhWPwVVZpWmx
 jZQjXaQfq+XqN1q+x1sxsorOIIbNQ1
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

As documented in issue C215 in the known issues list for DDI0487I.a [1] Arm
will be making a retroactive change to SVE to remove the possibility of
selecting non power of two vector lengths. This has no impact on existing
physical implementations but most virtual implementations have implemented
the full range of permissible vector lengths. Given how demanding fp-stress
is for these implementations update to only attempt to enumerate the power
of two vector lengths, reducing the load created on existing virtual
implementations and only exercising the functionality that will be seen in
physical implementations.

[1] https://developer.arm.com/documentation/102105/ia-00/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index f8b2f41aac36..2b95f9451b1b 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -377,7 +377,7 @@ static void probe_vls(int vls[], int *vl_count, int set_vl)
 
 	*vl_count = 0;
 
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+	for (vq = SVE_VQ_MAX; vq > 0; vq /= 2) {
 		vl = prctl(set_vl, vq * 16);
 		if (vl == -1)
 			ksft_exit_fail_msg("SET_VL failed: %s (%d)\n",
@@ -385,6 +385,9 @@ static void probe_vls(int vls[], int *vl_count, int set_vl)
 
 		vl &= PR_SVE_VL_LEN_MASK;
 
+		if (*vl_count && (vl == vls[*vl_count - 1]))
+			break;
+
 		vq = sve_vq_from_vl(vl);
 
 		vls[*vl_count] = vl;

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221220-arm64-fp-stress-pow2-b81ee6471492

Best regards,
-- 
Mark Brown <broonie@kernel.org>
