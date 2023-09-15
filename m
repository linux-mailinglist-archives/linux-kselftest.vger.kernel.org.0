Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993067A1E95
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 14:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjIOMX1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 08:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjIOMXV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 08:23:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCDC268E;
        Fri, 15 Sep 2023 05:23:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E1BC433C9;
        Fri, 15 Sep 2023 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694780588;
        bh=PRDjBgGWGghQhg/tWPb7ZH7iDykrzxmqhs+gMi1vJbU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UxTbdnVzk/rl5KN+mfS/89f0Dw9IHQShwifrRADrhMRVqYSF2hnVh+EPqAW12jQsO
         9NrfvN3/tA1TlRFZ7RMii9GnuAvZqYcD1CDYtQ01RCLN8g4qse4QUPFvAstXZ9W9Nj
         gTb8MQbG19B66JbkMRZuVBdfYFXH8gfm031BuiOYUQGrlbNY33KMQdSZCUmgg4sN6e
         1qJOwdYq7Gj6g5ZgaoY1RcsTWHYOe6TBlOMjD1N3eFvgvx+tWswstfhGdThTuhLETL
         aS/REbNFaSrCngkOy1OwD38ysS4jDEqy8DpjYyip20qPq1dGZl4sn9CoFC2H+QFqy4
         QfVSAMKtnPS/g==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 15 Sep 2023 13:18:07 +0100
Subject: [PATCH 2/2] kselftest/arm64: Verify HWCAP2_SVE_B16B16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-arm64-zfr-b16b16-el0-v1-2-f9aba807bdb5@kernel.org>
References: <20230915-arm64-zfr-b16b16-el0-v1-0-f9aba807bdb5@kernel.org>
In-Reply-To: <20230915-arm64-zfr-b16b16-el0-v1-0-f9aba807bdb5@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PRDjBgGWGghQhg/tWPb7ZH7iDykrzxmqhs+gMi1vJbU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlBEyh1Q1DxfXjmIM7NFRHNM28YeA0Up8sAZxwpEBS
 4xytz1yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQRMoQAKCRAk1otyXVSH0MtfB/
 0dvicZBlBgZ+uDGQ4PBgtDBYjKlsrCXDnBnj56PbVHU5UQHrG8MeMq3H+0kVYDFV6RWi7EM2epLgK9
 o5Ta85uCkZ3loQvECa0hIwiYB1AsZXhABAGs+Gy84UtgtFooW509jKu8BGSdhoaNFO19TdV7XbfIwp
 Q41i8vhrx7p2vt/Ytcgt4qY5Zd9VH2MXk/dkeI6KZwQr5yVWQ5i2VK2ZiXXs/+YInmfOFls0pgGUub
 jSd+Ht1wO7VJYUiJUkJSaZQez5y+dGcmMSsSyY31C27RE0OniqLGinnluJ3JwrTVYvGrJDwqVRjuJM
 suABRzG539sdZdoSd2y3JMh5M0hpfD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Validate that SVE B16B16 support is reported correctly and consistently to
userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index e3d262831d91..d8a144213d04 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -226,6 +226,12 @@ static void sveaes_sigill(void)
 	asm volatile(".inst 0x4522e400" : : : "z0");
 }
 
+static void sveb16b16_sigill(void)
+{
+	/* BFADD ZA.H[W0, 0], {Z0.H-Z1.H} */
+	asm volatile(".inst 0xC1E41C00" : : : );
+}
+
 static void svepmull_sigill(void)
 {
 	/* PMULLB Z0.Q, Z0.D, Z0.D */
@@ -493,6 +499,13 @@ static const struct hwcap_data {
 		.cpuinfo = "sveaes",
 		.sigill_fn = sveaes_sigill,
 	},
+	{
+		.name = "SVE2 B16B16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVE_B16B16,
+		.cpuinfo = "sveb16b16",
+		.sigill_fn = sveb16b16_sigill,
+	},
 	{
 		.name = "SVE2 PMULL",
 		.at_hwcap = AT_HWCAP2,

-- 
2.30.2

