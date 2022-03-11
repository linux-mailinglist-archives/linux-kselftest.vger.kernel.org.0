Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E234D629E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348999AbiCKNxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 08:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348976AbiCKNxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 08:53:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4941C57C1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 05:52:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 740F9B82BFA
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 13:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE33C340F4;
        Fri, 11 Mar 2022 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647006721;
        bh=xDJBAJu/5veMEVeVdUV21/gXIWmfA4m9JztlrzCV77E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcnwki3MVgr+s5gVHac/R43x6AQjpFocPVC1K5I7uAJwZ80uQ+2/G1HkPwYl69Zec
         6mNKSOH+Bql/yF1+5C+tsAjX/Zt1VJMg5nwW89kLGcdqxSTJqQon0J7kBEeM3ByLuz
         oM+deOX98nVYKeFFpW6sYTgjS47g8wXGk5hil7VtV73eapoBsqD9f4OmB5Us7BS3DH
         BxwSoPOhUNoVIu2JIWITP+VqVN+wOYRTV0nsDyNEQ1oAYnwfNPNVHcnw8obHNUvSK5
         HDawVNKOf6s1eN4Rii5DQPS2XjUFwPvlkJp8WtVAuQOQVfFr69nMAnphIE2eqE3zOI
         xMJ0GrG+JEL/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 1/4] kselftest/arm64: Handle more kselftest result codes in MTE helpers
Date:   Fri, 11 Mar 2022 13:51:45 +0000
Message-Id: <20220311135148.410366-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311135148.410366-1-broonie@kernel.org>
References: <20220311135148.410366-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; h=from:subject; bh=xDJBAJu/5veMEVeVdUV21/gXIWmfA4m9JztlrzCV77E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiK1PvPQt3fHsS6WLGobnHqIeZInPVzKOE7Uw0KVpH GpocEQKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYitT7wAKCRAk1otyXVSH0IAqB/ 4gypIvvqzwiX5fljwxQC0EKVKfR3aDhK5U+TvEnXTR6wBK+XfzkagtEt7YWSdXNplRaI/f+TXPnupv T+j9OH1egsXNysCz56t2g1FwcGtYw5xQS7AXFiQUyQZL4RTbXXq5TbPkPJ24PAr5R5OjqAnwXaViMr XvvSy6aXwzJeUJnUCsBVGPZh6g+cpa5vsq5kwjjWe8HUF3EuTvHZZndRnbHNYdFQXX5O6WgKqWCM2X Ex/kOVNuPljWgLWxFgMu5WWH/4GA3Q2dqoicWJBz+fMmyGgZ5ilz3eP6pjUsKPhr764WRHcG+lEoKo AEQ8hUAsYlKGHcR8g+1MilU10Wj4rL
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The MTE selftests have a helper evaluate_test() which translates a return
code into a call to ksft_test_result_*(). Currently this only handles pass
and fail, silently ignoring any other code. Update the helper to support
skipped tests and log any unknown return codes as an error so we get at
least some diagnostic if anything goes wrong.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../testing/selftests/arm64/mte/mte_common_util.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
index 195a7d1879e6..2d3e71724e55 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.h
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -75,10 +75,21 @@ unsigned int mte_get_pstate_tco(void);
 /* Test framework static inline functions/macros */
 static inline void evaluate_test(int err, const char *msg)
 {
-	if (err == KSFT_PASS)
+	switch (err) {
+	case KSFT_PASS:
 		ksft_test_result_pass(msg);
-	else if (err == KSFT_FAIL)
+		break;
+	case KSFT_FAIL:
 		ksft_test_result_fail(msg);
+		break;
+	case KSFT_SKIP:
+		ksft_test_result_skip(msg);
+		break;
+	default:
+		ksft_test_result_error("Unknown return code %d from %s",
+				       err, msg);
+		break;
+	}
 }
 
 static inline int check_allocated_memory(void *ptr, size_t size,
-- 
2.30.2

