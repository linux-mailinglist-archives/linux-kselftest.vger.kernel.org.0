Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46919523835
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 18:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbiEKQKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbiEKQKS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 12:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB76237B93
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 09:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C0C6B82527
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 16:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF0FC34118;
        Wed, 11 May 2022 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652285413;
        bh=1uWilRA3UQa3QOcanblr9lbpzGiWsreP8pgcmwWIHEg=;
        h=From:To:Cc:Subject:Date:From;
        b=OhGJFXULm5fGdI/JEgWiIgOFBuQde0lu7xjejdV2o/vMdBgb13ZJY4uv5SDIC9gSj
         y9mRjPSUAOfb8i1c9xcS4uvIXPXOOy0un0inx3TboSvmacrHc1XwDSMM+ZhNO0mkwi
         g9LnRvbjrMHy/qW6URNW5duPKYlKgoy0Nh2FOPLYdQM5pQ1QMLjNQWJMCJaRn5ntUG
         xVUL3IVSSvYZ0FZ6bPBGcFLOQpn/EJNk+lA575iZHvWFw0uiKFshySE4pk+3rlxiIa
         anwSP4HTMSq0R2pTelyix9TosHIXLdgXazT1N2PIhDtKIGY1M62wjB870IiDX7SlLU
         3gtizD58MKZmA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Explicitly build no BTI tests with BTI disabled
Date:   Wed, 11 May 2022 17:10:04 +0100
Message-Id: <20220511161004.189348-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; h=from:subject; bh=1uWilRA3UQa3QOcanblr9lbpzGiWsreP8pgcmwWIHEg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBie9oZEgT2bKmvuOaDKjMGisPiS+TgGqJFOyDsk2U3 xMjiP4aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnvaGQAKCRAk1otyXVSH0JLVB/ 9rjnwYb7P/DiOwtb1O+q2S3VPimEVBJCeVKKGC89iu8hfwRC3TuochZ6oX56+Poa+iRgHqa2IUuB+J Q2+NNNGqL2jciUXGL8i09HlNzHIXUHhtYVfTl4dsnEFLzNTCLOF33sYFv2Edkf2uSzH2zgIYbJo+tM xmJYX7n6NLRXL9BW6jPglNjfZxDnogHzSvS75QApRMVGDM9YwRQK9iuntMVUCwp/kDF/mnX8PlUqk5 zHUj0kQV5g69gtJ9PhrZ7F1/HqsPyHyHGUYBo6U7wLjBaQl13lyGXy6CBASlqWskQMtmZgmavdFu56 C7s2hETT68o0r2pKx5xFCq6YfcR9Ox
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

In case a distribution enables branch protection by default do as we do for
the main kernel and explicitly disable branch protection when building the
test case for having BTI disabled to ensure it doesn't get turned on by the
toolchain defaults.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/bti/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/bti/Makefile b/tools/testing/selftests/arm64/bti/Makefile
index 10a12c5e05e6..a3e59d7910b3 100644
--- a/tools/testing/selftests/arm64/bti/Makefile
+++ b/tools/testing/selftests/arm64/bti/Makefile
@@ -14,7 +14,7 @@ CFLAGS += -I../../../../../usr/include/
 
 CFLAGS_STATIC = -ffreestanding
 
-CFLAGS_NOBTI = -DBTI=0
+CFLAGS_NOBTI = -mbranch-protection=none -DBTI=0
 CFLAGS_BTI = -mbranch-protection=standard -DBTI=1
 
 CFLAGS_COMMON = -Wall -Wextra $(CFLAGS)
-- 
2.30.2

