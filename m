Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A65068D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbiDSKfi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbiDSKfh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:35:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC929CBE
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 72EDECE1767
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F9BC385A7;
        Tue, 19 Apr 2022 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364372;
        bh=kEQALFvVnF2JUNgXMicTSPE1AfxRggwyPGzRYL7rWak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pvl787b5m/ia7Bbs9L7/caC0DCE6h88rvWm92C6AH7V9FOyeTBkr44zlpZMkZeGvA
         sUl6OCiG9cc6SU5eimK2qfSoj0u6pE3YAHharL4QrHtRBv8x19Ei3+ZFoGR0OanjR9
         SNfhKDdTs+5FDReNz5MhxQqVRf/URGQGr8cKapjOXjbWaGLZ9XwbI7y8BvP87feLgI
         /6b+w+dWuTeJLJxtEr1/2nv0FdJNAIEqeKlI7SzWRTAC1TdEyrcgOG0eESnrLq8RK1
         +n/cO1R5IR3o5oSXUGdajvrZUD+0Gf4DazppMS8IcKjGSVC+zXNTuvCMbdXPHVpIYo
         4vnYEp0xmMoTw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 2/4] kselftest/arm64: Log unexpected asynchronous MTE faults
Date:   Tue, 19 Apr 2022 11:32:41 +0100
Message-Id: <20220419103243.24774-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419103243.24774-1-broonie@kernel.org>
References: <20220419103243.24774-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; h=from:subject; bh=kEQALFvVnF2JUNgXMicTSPE1AfxRggwyPGzRYL7rWak=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo/IoXEdRQ7/5KuVtfTwYvHv3UfBHnjTUblpso4O pdkhaOOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6PyAAKCRAk1otyXVSH0ENmB/ sEH5L2Gb81E4Zc+o+Zonzk1+7cy9yubPvybNq4KN71HJjv1KziAWp2q+TKhpolWzlAZIVjWduQvhFJ AjXpvvisQHYS6Dv66i/12uIVvAJTwUb10bmXGlWaBya89cFWcG6kn2MvISBF5ntLsBEP70nOMMbByz VpVKe4835BWhDZaMOpnXSmYYrG57IKrBNiw8HEvshF/MM6pTtx5KfmPcjZXDh7iwcjgJyYXTWVvWBE TCC999Djr3q2ePjduzHNcssXFsNMfsMo7l4zYqccAvhR5liN+4i7cT6ZHbYhyDNjwaZQP6FQ5mCy4k 19eVHv5vScvn9JmSm7jdGZAbqljhIt
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

Help people figure out problems by printing a diagnostic when we get an
unexpected asynchronous fault.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 0328a1e08f65..5327aa958171 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -37,6 +37,10 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
 		if (si->si_code == SEGV_MTEAERR) {
 			if (cur_mte_cxt.trig_si_code == si->si_code)
 				cur_mte_cxt.fault_valid = true;
+			else
+				ksft_print_msg("Got unexpected SEGV_MTEAERR at pc=$lx, fault addr=%lx\n",
+					       ((ucontext_t *)uc)->uc_mcontext.pc,
+					       addr);
 			return;
 		}
 		/* Compare the context for precise error */
-- 
2.30.2

