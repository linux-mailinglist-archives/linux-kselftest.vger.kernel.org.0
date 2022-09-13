Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1645B7036
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiIMOUM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiIMOTG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 10:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE1F1C131
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 07:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70564614B9
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 14:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAF0C433C1;
        Tue, 13 Sep 2022 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663078315;
        bh=beifvSd0yZCf/rhb6goLcuPqGmCyFQ/KBjdE6tPJ6QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQbe0aY1RIi6/xcLONQ02TTGgNTtJ9MkN6Sackgo4LbNmpUGUL/ag3mJwPnjGPu/T
         TSZAiQgCvyjFZVZfsbA5mvvGuZ5s/T9qhmiEYCggnktMQNDgSJNPDB6R60ri1Cng2a
         1sOgDO3S3wiPOIDzRQWdMkeytOmZn3SS42xep4yea0SIEMXqu5Dt+AVyxwt+yvRdmZ
         diXZscJY0is7Q6Wa0AWH4FRl34qLmJXZsdU5B69eO0hkzzjnEf5Z9D/pSKAo5uDhig
         il3BSF75d4JNW3KAYxIwyr0VngH7myzutoJ12u2ww2ShrYoySK7Fwls/10LHMCKbRL
         Q2qfzzCtnpw+w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] kselftest/arm64: Add hwcap test for RNG
Date:   Tue, 13 Sep 2022 15:11:01 +0100
Message-Id: <20220913141101.151400-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220913141101.151400-1-broonie@kernel.org>
References: <20220913141101.151400-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=broonie@kernel.org; h=from:subject; bh=beifvSd0yZCf/rhb6goLcuPqGmCyFQ/KBjdE6tPJ6QA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjII90gcKY6uSnz9tFfY2jAbMa19gPEEyveQ1V4Ytn 1LC/BPWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYyCPdAAKCRAk1otyXVSH0OxzB/ 4y5iu5SKb3HvofGak5+WdjYkSzcZJxFjG2nkrJvTRDpQjzfwRTbudxAFOXxfCwE1VoGdl40pWOy3y9 7WCBRxj9jCZbMzgT5vqBU1tCBD4SwMTAhTLuNKrSWCnqeuLYDywpIJCRr0X4907jd70GVPpJ4mV1mm yTlFIa0Cqif23IiFGLTrcv9Lp5zGEKnFhwlmIj6LF8E9Iu3h+RHrNfUszNrlGtb5Z9bwX5RbOi3j2k C+cUp5E3Se1JbzoHNtGyU/9Uybdr82BUMtV4wV4yPOb8KQDY1EWh/uxClIUqETorwABwPtpKzS/xFV lU96m4kzlIKr2gFoxIg94ZPspVeOaM
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

Validate the RNG hwcap and make sure we don't generate a SIGILL reading
RNDR when it is reported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 6c91b4a0987e..d173e41f2123 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -33,6 +33,11 @@
  */
 typedef void (*sigill_fn)(void);
 
+static void rng_sigill(void)
+{
+	asm volatile("mrs x0, S3_3_C2_C4_0" : : : "x0");
+}
+
 static void sme_sigill(void)
 {
 	/* RDSVL x0, #0 */
@@ -113,6 +118,13 @@ static const struct hwcap_data {
 	sigill_fn sigill_fn;
 	bool sigill_reliable;
 } hwcaps[] = {
+	{
+		.name = "RNG",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_RNG,
+		.cpuinfo = "rng",
+		.sigill_fn = rng_sigill,
+	},
 	{
 		.name = "SME",
 		.at_hwcap = AT_HWCAP2,
-- 
2.30.2

