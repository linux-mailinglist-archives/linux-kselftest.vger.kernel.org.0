Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932865A50FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiH2QHb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiH2QHa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95141857D2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 309B7611F5
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D621C433C1;
        Mon, 29 Aug 2022 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789248;
        bh=Dxt22W8Em96QEF9sjlP0/VfqCLzptWgJwiuX8Wed7dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qldtaT3Pf4yslygdL47ecbEGFUOfy2wY+DsjHRgK06Uzva8cAwX+kv3VGvow2hDEx
         z4HUUVg8gKOsfr7oKONW6UNjLn5I3NBcaX51pmZCb3HgVIT/LvpZLMnWi5ivFQux/z
         gRq0DgmzAx8R5E7xfrD1gLfcZMmZ6qPzwEq4RpaSvXw7KW7cGP28zbVnCgyTn4pQbr
         oK1RB2b7nx960BCU8nWNRpmk/LvXn+qz+kgH8yuW21wbsezLayJBzFuKfwsafqzNYH
         F1+KtrnhA4qaPr7jd0/T4cwVY0RUHGsFoocxmZYI8ryjD2Rm7BX/xmpqZBQhx3Uu2+
         P8oVBP+w8WlLg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 02/10] kselftest/arm64: Validate signal ucontext in place
Date:   Mon, 29 Aug 2022 17:06:55 +0100
Message-Id: <20220829160703.874492-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=broonie@kernel.org; h=from:subject; bh=Dxt22W8Em96QEF9sjlP0/VfqCLzptWgJwiuX8Wed7dw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQfrr6pXSdNsaCjPzZcsv9NuPUamlQgH8zMcvpo Nhmt7KiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkHwAKCRAk1otyXVSH0D0kB/ 42txWh/FT2tTjSTaAz8ndvkC2r5L/wCL+nPhlCIh0gvqiGY1QhbnxrVS2f8zwJjoY+/6lQ88XgQrra hbv8CwB7uroxm3SfJ6ayB3ek9g/kgBVNaUEpCxILlShKrQjAAujqQfaFRcecyk0HG1gMtm0UCOuLMP XoJoPfeMHOJSjr691odiMM2Plaq8y+TnAqZB5ywpKEBadHMLr5Zl4rLWeeiWB+ME0KTnuZEHxd6Lo0 kWxkvnm7HHkgSth/nzguOITWp95oi6bmHWSlGbbxb6kfsTDNPQQP6mpWyzE3w1x/Zdh+1aPRN+W6jV 5hJLjl0Cko7pxwyZzKuoQ8yPws1vei
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

