Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1625A51E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH2QfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH2QfY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1728119C34
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7FAD611BD
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF42EC4347C;
        Mon, 29 Aug 2022 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661790922;
        bh=DNdz0MfFndJNgNHVZx0vWnDoBM1u55kaIwwlDgaROqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4tyKCRzIH3WGa5oMyNIZhMtpmXFcFWPDTm8gd1mtiFrIXfQvPo8eihhkbBKxooC5
         eYVnfgPIqDLSwcYf/XrchhQLzesyGWPFasbRS6o3coWVrUzo17qxRJTBsyFtNaHt38
         0mmF8EFLUaEEAv0rC/OeCEaA9KeZrUtIsgC/88HwXeqOgZ8s4OrObMgEDNN18/UxRz
         2Fd17/Qt2iM+Z244d4dJPsH7i02gp7xhxhNsG0bMshn5CCOm74TWP09EgsubNR1dZE
         MRh7V94BwEU8paiXWuwxXyPlUEzqnMpi1iNs/nO/hZRJ1erIMYFXXOQQcH4rkeuTIE
         JjI4qVrSlBAUw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 1/3] kselftest/arm64: Correct buffer allocation for SVE Z registers
Date:   Mon, 29 Aug 2022 17:25:00 +0100
Message-Id: <20220829162502.886816-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829162502.886816-1-broonie@kernel.org>
References: <20220829162502.886816-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=broonie@kernel.org; h=from:subject; bh=DNdz0MfFndJNgNHVZx0vWnDoBM1u55kaIwwlDgaROqg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOhb7hmLtHE4+oP5TALfAhsi/OSeQlXehOcaVmuA 77uU7OuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzoWwAKCRAk1otyXVSH0BGeB/ 4qaCmgsaUpcOB/fYTFhRObGqDtriLa5HBZ6BBaO6NJM19w9qyWAHnQeDzIP654HehfEaJucNGu/BzA yDHsMRBpZs7d8V+is61MYJXnhBGud0sQ/yl7wDlaz1fiXaM61CDNb/BlZ3pB4YlBk0G+/04jto64oU H+MSnB8rx5d6ZJZpBuRA9D1fQnq18BXzdi1yWofLPs6EEoIPHYzNQSZtTAlPteY9/ylG9soGgaw7R9 eMF7u7O5aAUxJVhCdViBvHEQzdfQBeRcrRY5eOn9uHB3xuBHozYnqQ1mA9PkFlgPcmrLkW740NdBnS cawSc92OXz9KU/Jgn+f3IP02QJ6kCY
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

The buffer used for verifying SVE Z registers allocated enough space for
16 maximally sized registers rather than 32 due to using the macro for the
number of P registers. In practice this didn't matter since for historical
reasons the maximum VQ defined in the ABI is greater the architectural
maximum so we will always allocate more space than is needed even with
emulated platforms implementing the architectural maximum. Still, we should
use the right define.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

