Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C654F94A0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiDHL5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiDHL5X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EDC66CBE
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026CD62052
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0003C385A3;
        Fri,  8 Apr 2022 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418919;
        bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PamkjOArE7Hjmvtu1JTEDwf5RctFxUkbu8fG1c7cs/NzCdzncx6jYmbKz0oNq/bMQ
         l3Y25/bJVvl67JKoYpsAQyH2uEtuavVKLUbuzXmD272ktYqLBDZve+s+vkJerMhz+b
         uRqrhhsaG4sx7PV3qPR1fa3BeU9LcOae4vNd6eeKH+uF3LmisJeBnqcexjovdkzUKe
         azQwHReylglhcG3kDutxDmwbzQiOtkxKYF+1N2tG9CI6gEXogLpbcKksVT64fIL5cV
         a+Kv0w6qmXUGGn3sHyYiGdB3GtOiPAl/UQIgJMsXuU+hu+A755bGZ/xusLv1lTJqkZ
         HVHlpr1TErJXw==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 01/39] kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
Date:   Fri,  8 Apr 2022 12:42:50 +0100
Message-Id: <20220408114328.1401034-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; h=from:subject; bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/AO+w0M52wR5OGcu7Rb9aMmx7Vhd+DLVQSaszX 8TQxkxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfwAAKCRAk1otyXVSH0J2LCA CCqlEjQHYoX0n5bMsXo5P5DZoy4aNDOPbCF8VG7ypPKWb5Ntx+M9y7VC7/9rNKriVtd8+vSLtkN1OH E6zyLBCraR10kCE93iy6HvLDQ8HHpbdOf6pPyHlv9jMvjFE75R0Zforkew0QOXVDnTqAmX2XvrbmND oyoPF3bvjyr2BkD/ILcVZkD152EvSpbxJOFTNnHBRjK/1mCU81Z+7ES0jHc9CIi/YX/MPDn+0sJLVZ IDgNcadfA1JruyDMXYH84oAFt+2PjooFmrMi4PvWte+LV0j4VnOhW87dr3szMNiOex5fT+U/DKaCZD H/U3r8bPG7VlHOT1bv0LLhef0OKTgX
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The comment for ptrace_sve_get_fpsimd_data() doesn't describe what the test
does at all, fix that.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 4c418b2021e0..7682798adbba 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -395,7 +395,7 @@ static void ptrace_set_sve_get_sve_data(pid_t child,
 	free(write_buf);
 }
 
-/* Validate attempting to set SVE data and read SVE data */
+/* Validate attempting to set SVE data and read it via the FPSIMD regset */
 static void ptrace_set_sve_get_fpsimd_data(pid_t child,
 					   const struct vec_type *type,
 					   unsigned int vl)
-- 
2.30.2

