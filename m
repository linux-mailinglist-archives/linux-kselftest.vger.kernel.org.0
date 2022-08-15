Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24882592FE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiHON0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiHON0n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0341F607
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3397EB80EB5
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1293C43140;
        Mon, 15 Aug 2022 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660569999;
        bh=DNdz0MfFndJNgNHVZx0vWnDoBM1u55kaIwwlDgaROqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4b7YxTtLBjF69J7XfAHbV2fDBiY/gY8yIOrRRah4zZHyFn5KxSPmzoCPIm5gxwHs
         uO2E633V/2SfKCNOjSf1BbgQfOepaKO94XHhkwBBarOSWCNqvI3mVxsMbadT7Pp3sV
         MGzW/utjA/54z3+eV2pN1n08xuUXurfwYzgDCfa5wSQMTzrcpJur8mhXggvpy+2ivi
         fGpZMGyuoBUeAdsOeF6iCzIiNoDd+Dd8aYKqwnfwsiqkXpbolNWN/RAr65x4DraVgY
         ueaUPrMAYIOgXfuxt+iSloeC1XoBDA4dYF2hZ+E3JnNLnzz3DPF5Go38sCASU6TB7o
         qabstx6k7TkZw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] kselftest/arm64: Correct buffer allocation for SVE Z registers
Date:   Mon, 15 Aug 2022 14:26:20 +0100
Message-Id: <20220815132622.220118-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815132622.220118-1-broonie@kernel.org>
References: <20220815132622.220118-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=broonie@kernel.org; h=from:subject; bh=DNdz0MfFndJNgNHVZx0vWnDoBM1u55kaIwwlDgaROqg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kl77hmLtHE4+oP5TALfAhsi/OSeQlXehOcaVmuA 77uU7OuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpJewAKCRAk1otyXVSH0OdKB/ 9eBYKbZwcsddzvs5CaZkqg/EOczNagmliyPWafRgFNm9eKbXIj75JSZle0cdt7UKkBOxUvK2cPcAaM 5hzAkyZHhlwYpr0ZK1K2mcTvsh9lSPiEZ6SNAbJWXKSDSvycr9pypxyq+jx0sy6SOGvwikFAChppxF 6OX9xzDskZH1U0r5JsWIUhy7CPXGz0RdnGVf6YRFhYF8FV2lsG5t/0WE5b8O1XTebF6O4zyxBw7gVK wp20hEBdmBaVS7yWjK5Bngm1dmFEKT/TrvXF+rlDnOSWv4OJ4XL5MuEiCnICWy27SVUgtQuXD57DJ8 VGJqfgl73pgR6560x9ErlAygopSbju
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

