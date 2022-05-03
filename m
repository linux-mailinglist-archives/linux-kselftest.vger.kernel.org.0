Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEAF519238
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 01:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbiECXUo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 19:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiECXUo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 19:20:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE71D0F2
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 16:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74B99B82224
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 23:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF8CC385A4;
        Tue,  3 May 2022 23:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651619827;
        bh=xq8OdW/Qfeb1viytZsGrSdvJt6JOzauPBtWOMs4vFuk=;
        h=From:To:Cc:Subject:Date:From;
        b=k3GbyR8HiSQV2maqfXLcfE1E8XhZqeaHwfsPKp2omCPTeiMnZyq2fO/mfN31lnFeN
         0aLnrHQpqJdbBO3u6ISJ7jaH106kmfAr1ZzK08KiIDgQL1JO8YN7KXb+jPpegR5d0P
         Z7fUN+a9Ov97MZl77y+VXIgDHJtBikx0KHeFmtNHrjDb0KpxqMjW2D3A+Jy+cw/uBM
         oG8F2H4fWGwLd+kNHcsN2okOZoZY42hDRrUalUMZnw7HLU38AIXQV1N5ftdvtAtEjC
         o98cGSHbDRhxPVQsNUAduQT1pwTXrWVUaCD7PlG1UMTZ48EOj9jm6NxlPOTXmqXtOi
         zU+XNLPPznLRQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Fix ABI header directory location
Date:   Wed,  4 May 2022 00:16:55 +0100
Message-Id: <20220503231655.211346-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; h=from:subject; bh=xq8OdW/Qfeb1viytZsGrSdvJt6JOzauPBtWOMs4vFuk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBicbdhIhUnxDX26JOYve2zVMImzTb89GheRAjYVI/F Nfy3ExOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnG3YQAKCRAk1otyXVSH0MT/B/ 9qqKb34qG9s/PH8RWB5ZdX292jor0oSYBQU2RASeD5Alq9TE0vDsEE+E6qP3ZM+Jz0IKW3Z/6JCXfT 1eWKSg6EQBm1YkoZUqoxEbhw1RhVuv/YcSooTOUwCePR2IGRTamV25fwDNatWBP22/WmXbPydVuR+y WT0NXNhaw0oywppVIVf0Ar2gYTM2Qni/kL6kF0/Gfp+jgeyH3m4pniGZ3IMP1UxGT5cLj7wq9KIe1X Tr9NKDDkm+DC3ivq21IuA4T3mjWFpPbRd0xcvWMDRkUzLDPLQVWQzP27AMRVw7VY9S+Q0f6qBMXXNS wi63Ix0J2yQP0t6YZGViG0DjsTQtVH
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

Currently the arm64 kselftests attempt to locate the ABI headers using
custom logic which doesn't work correctly in the case of out of tree builds
if KBUILD_OUTPUT is not specified. Since lib.mk defines KHDR_INCLUDES with
the appropriate flags we can simply remove the custom logic and use that
instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

This fix is required to get us able to run the arm64 kselftests
in KernelCI, it does out of tree kselftest builds triggering the
issue especially in conjunction with the addition of the new
definitions for SME.

 tools/testing/selftests/arm64/Makefile | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 1e8d9a8f59df..9460cbe81bcc 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -17,16 +17,7 @@ top_srcdir = $(realpath ../../../../)
 # Additional include paths needed by kselftest.h and local headers
 CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
 
-# Guessing where the Kernel headers could have been installed
-# depending on ENV config
-ifeq ($(KBUILD_OUTPUT),)
-khdr_dir = $(top_srcdir)/usr/include
-else
-# the KSFT preferred location when KBUILD_OUTPUT is set
-khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
-endif
-
-CFLAGS += -I$(khdr_dir)
+CFLAGS += $(KHDR_INCLUDES)
 
 export CFLAGS
 export top_srcdir
-- 
2.30.2

