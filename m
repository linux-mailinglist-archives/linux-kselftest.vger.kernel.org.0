Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7E506A4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351355AbiDSL07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351489AbiDSL0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53E31217
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB5061328
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F02C385AF;
        Tue, 19 Apr 2022 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367411;
        bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1cpewV+oNMgwj4e/36Yr8stpv3evTelc+ya2uLnlq+mVoMUbVTuac3469woDEaDo
         Zjrj7xmcXczAqsAcarHyNnOUT+XufO743aidLXhVfGtdxYnXRvfP0VUsufHKNN31F9
         ZofbyWHNtdM4ns4loS+v/pv76R23SS20WXg7k2gDXPlu0iuCsHviCsR2CBDwRD4maj
         XdUUzchf2ZsaIM+/PgzSRkvpQZGSUTB7SN3gmRKleY1jI3eZhiqKA0t18IMtW1jWjW
         EDn4yb4eh31u2s+SExN9YhKmiOPDz0sgPFgGbHkthHZsXYj72h5ftY6uwF+J1ADpA0
         ApyD6FEuoTL1w==
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
Subject: [PATCH v14 01/39] kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
Date:   Tue, 19 Apr 2022 12:22:09 +0100
Message-Id: <20220419112247.711548-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; h=from:subject; bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXptoO+w0M52wR5OGcu7Rb9aMmx7Vhd+DLVQSaszX 8TQxkxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6baAAKCRAk1otyXVSH0BAMB/ 9Zbg/QaH4zFOnbKbqqF4TxRo3xxajvi1zZ3l70LsVaLZ34hFhGiT6p+D8ydj+E7KjcGZnI1YBo9oWi hBLeZzdkmBKYLSCQTur/xQYW11HrdWQUqAqNl2zltvs9idg3FpW01DwfB3XJ4MLItvTJsPQXXQWdRn hUPNTSFLTucef0BnH/kOF45Vne7233JFMXCXAWo/H/V/FOgXiSNBhY27IkFvjbLkwFTAIY/jomwLrW wCgnr21J2QJtGMvlt6FOeBPdsKmWgbWXlS3WKg+8nrEUsIi37aJMyHWjGobEXxgGhEhxPAwEjif+FO 1Ekh7M/KMh5EM9C5eCwicRBli6nhAZ
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

