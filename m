Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6E592FFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbiHONdQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbiHONcy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:32:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD817053
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90B44B80EBC
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2418C433D6;
        Mon, 15 Aug 2022 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570371;
        bh=Dxt22W8Em96QEF9sjlP0/VfqCLzptWgJwiuX8Wed7dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVfREFIgYH/ba8Dn0zby6B5NIAwHYKMFxbbhQUzTZriH9pDHDM27KOQ2jfkzly0BB
         744HG8OKf3gK8pOcFahr/SGA2bR6pDwW8ubtt+Zk/MXWty0XMRErxGOs36KzcdWZQX
         t7ixkVz0GTojK5PuSIQi5HOrJE08Bx7Jun5JQa7XViEr6GDSjsBKfGW/9TNqFXwBuG
         oFKoGlFc6LZvjlv7TSfepOxwqMC31QvkPp9NcxPpeyXZBE1foYjXHOE3X5g9euYuki
         /F7HtbrLNR6kXNGMEreqySj4mYijQqmcBmfu5fB3JpV8S/iOohZCnnIXoYJdeKCoeW
         SQt9Gycyh9HEQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 02/10] kselftest/arm64: Validate signal ucontext in place
Date:   Mon, 15 Aug 2022 14:32:28 +0100
Message-Id: <20220815133236.235464-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=broonie@kernel.org; h=from:subject; bh=Dxt22W8Em96QEF9sjlP0/VfqCLzptWgJwiuX8Wed7dw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+krsrr6pXSdNsaCjPzZcsv9NuPUamlQgH8zMcvpo Nhmt7KiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK7AAKCRAk1otyXVSH0LwYB/ 0UNOOLBubNtJoAJf+3G4GxyvIPFx3sdmm2hr2Hc21/KpGoiNb6woKL1Nw/esHVywTjnONJjYRH/2+W 786cRMtBRJcKOzwtdqy38dQo7elMCai3NA/Rk8yVhEkdO5LiHd+O1qcZq2rEJZGqccBIpuEqqb6tBH vrIu+jQCvr1RCzAmdc9vAb8rLs1+FQzszrCtTVjNQP/hD7xZsxKnciUfSCZrsqU0oGxZcC/XxYj5Yk 3n+4Zau3dcQ5pPMqtN62EylDcwDll5+wr42uHUJmMl6tNk94k/IV+yXzLxc0sUBUTxMnuxr+XdhcWI 1SBD4AdLCIMzP2P3BGSZWCP898c1Z5
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

In handle_input_signal_copyctx() we use ASSERT_GOOD_CONTEXT() to validate
that the context we are saving meets expectations however we do this on
the saved copy rather than on the actual signal context passed in. This
breaks validation of EXTRA_CONTEXT since we attempt to validate the ABI
requirement that the additional space supplied is immediately after the
termination record in the standard context which will not be the case
after it has been copied to another location.

Fix this by doing the validation before we copy. Note that nothing actually
looks inside the EXTRA_CONTEXT at present.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/test_signals_utils.c  | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index b588d10afd5b..a54dc1b6f35c 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -165,12 +165,15 @@ static bool handle_signal_ok(struct tdescr *td,
 }
 
 static bool handle_signal_copyctx(struct tdescr *td,
-				  siginfo_t *si, void *uc)
+				  siginfo_t *si, void *uc_in)
 {
+	ucontext_t *uc = uc_in;
+
+	ASSERT_GOOD_CONTEXT(uc);
+
 	/* Mangling PC to avoid loops on original BRK instr */
-	((ucontext_t *)uc)->uc_mcontext.pc += 4;
+	uc->uc_mcontext.pc += 4;
 	memcpy(td->live_uc, uc, td->live_sz);
-	ASSERT_GOOD_CONTEXT(td->live_uc);
 	td->live_uc_valid = 1;
 	fprintf(stderr,
 		"GOOD CONTEXT grabbed from sig_copyctx handler\n");
-- 
2.30.2

