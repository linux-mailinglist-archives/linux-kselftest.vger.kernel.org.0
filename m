Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8765957BDAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiGTSVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 14:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiGTSVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 14:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300876BC27
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 11:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE75AB821B4
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 18:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE9BC341CA;
        Wed, 20 Jul 2022 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658341306;
        bh=I+iJlcg1R3+8kZpSRC/n6qtGReBtslazilklAayOT/M=;
        h=From:To:Cc:Subject:Date:From;
        b=WP/TkDRk1gBx4JJBZsqPeeqw4SBu+hhd20X29nhPrCKQ+ex2t3HeOoOxj43cHk6zc
         RCTy1hDieHXT/plpUzzLzbQqBf9LElbR+juG+8lbxUqH7nEuUWPXXFjX6Bc620TJma
         zQLMXF6jbAZ87vkQEYgpVPhBKZ/aXREPtcvZAjD0zCgoiuIuL8xbSIE2ONIhLY/Rs2
         YHH01ycm8P9urfZkufXvBkfa7hMGHNcwOxFLXIXLmISWPIRBc1IPL5M4yfNPUQ12pp
         UtnWi81N4m/DJNPKoTNRq6FYLguZ87KFs75idAHzarZAJyF81YzrCJmlGCv0HOfqR2
         WYO8NAUuGkzSg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Correct buffer allocation for SVE Z registers
Date:   Wed, 20 Jul 2022 19:21:38 +0100
Message-Id: <20220720182138.604711-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; h=from:subject; bh=I+iJlcg1R3+8kZpSRC/n6qtGReBtslazilklAayOT/M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi2EdASwZmFtzJGfQYVzXb1gw/Qngx5RLEW76UtsEo wbOQg2mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYthHQAAKCRAk1otyXVSH0OioB/ 9Lsuwu8LhmjZmIw8e2ljh4ijPhr/h3CL0Jw1ZmF8mAuGnfDEHnpzsizAWgxNUhfv7kh3vV1rKmJx9F hhkEyI3p7qQAtQa1Y9OqJvUdmTaSPl7x6kNhDzTaqYLWqetqnAn7WwoAho9jgK7z3L4+qE6/Z0sdIy Xm0o5LodHr7oeJ7ChFaLo34jfTa/6mQmgpqRoXov1NG6xbZQlZtGwXPl5l3v3nSrf1yGgLlqqrhGT9 kyh+6EvZpVhLCYJEUBsB6fuPaC+dIWAoea6f2XXKPl7+8YuO9tNBSh3O/b7drv34QRp63NkEaspGp7 0UrhQ7iBJsAvbV9/P6v30Qc1DN3WZB
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The buffer used for verifying SVE Z registers allocated enough space for
16 maximally sized registers rather than 32 due to using the macro for the
number of P registers. In practice this didn't matter since for historical
reasons the maximum VQ defined in the ABI is greater the architectural
maximum so we will always allocate more space than is needed even with
emulated platforms implementing the architectural maximum. Still, we should
use the right define.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index b632bfe9e022..95229fa73232 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -113,8 +113,8 @@ static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 }
 
 static uint8_t z_zero[__SVE_ZREG_SIZE(SVE_VQ_MAX)];
-uint8_t z_in[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
-uint8_t z_out[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+uint8_t z_in[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+uint8_t z_out[SVE_NUM_ZREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
 
 static void setup_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		    uint64_t svcr)
-- 
2.30.2

