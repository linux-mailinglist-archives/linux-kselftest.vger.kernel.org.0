Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1557BF5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGTUxc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUxb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 16:53:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF965073C
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 13:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 941AFB821FC
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 20:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438E4C341CB;
        Wed, 20 Jul 2022 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658350407;
        bh=I+iJlcg1R3+8kZpSRC/n6qtGReBtslazilklAayOT/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GllCerdx//tASznRlmaxykm+kHuzVvf9X7kz1aXLk/w2JLFV9dPGNspBJ+Zj/Srrd
         56KSDW0gvZbo9aHyW0jxYyk4QdYoO75GJ3bmyG2yca8IpPKgD2OdC1NDxm3xzM+aUD
         PlSt/fStWJ7pFmPKXl8mOXKNJiTRY7bTYlVrLG1UNzRmwm2BOjLKjqOyyad6MOOr8U
         sEAjuA75GdWXPhPpCSisHJ/GlOKwoCree0dz/UEv6b9cqEJGt9yoGwwkCVJkn7t/8/
         GHFZWP1m4++GU4jog0yPOuY7+RQrqjHzbQlwD4Mz12LeSCFtgMNmC7v/6Yn436ZAwU
         MTzDiB0QBkMsQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/3] kselftest/arm64: Correct buffer allocation for SVE Z registers
Date:   Wed, 20 Jul 2022 21:50:11 +0100
Message-Id: <20220720205013.890942-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720205013.890942-1-broonie@kernel.org>
References: <20220720205013.890942-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; h=from:subject; bh=I+iJlcg1R3+8kZpSRC/n6qtGReBtslazilklAayOT/M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi2GqDSwZmFtzJGfQYVzXb1gw/Qngx5RLEW76UtsEo wbOQg2mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYthqgwAKCRAk1otyXVSH0OYdB/ 0RCEulwYlgOQMWHqsEa6M4OTHADL1Nht6LkWXgFEEkWfbgI7El9AhyVlTv0P+7ioQWsah8vn+YlBzx 0IbkLeVk7jO/7eUnMY7nFhYfIBDvrwSsoO+CBLjyuROCR/YUtfN5r96M4Z1cpv6tpyCq6iOE49wFVX wrKM/5YqExhGvGDkdLzkh0XkvZ40ezqkmDbrKn0xBrefsdTZj4Jd1RLKzyqvfQ3cfuo2D8jyZetgHQ i6WwMu9YVTmDqQxv8+AhYhfoIfheoEOypmKqPNLmIRPe3SR5htnUGFq4Jpi8ssh98oLO2Fkx2daJFy 5W3yRJ5eT86E4h5a3YrhBfmzSqRnow
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

