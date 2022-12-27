Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C897656B39
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiL0NHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiL0NG4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:06:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF5277;
        Tue, 27 Dec 2022 05:06:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32A9AB8101D;
        Tue, 27 Dec 2022 13:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AB9C43392;
        Tue, 27 Dec 2022 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146412;
        bh=RNcNgyi+XWeNF+WSinst8npBEXg52AmbeM5w3G+O9YA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=X1mXjweTTYK8xa39s4cz6r7MbA+2CJZyqC5RKsj+ACMyyIOmfCUJUgL5+UZb4Dul4
         fGaNKbhxAIXxZ+ZEXBOoJNXYEF9k/NwjmaM0AQeG8pu+yCkZDnSKbdQkmzN67B8M6M
         zr0ZU/GH7tvTgK9IzBa920Xed5Yg1aC/tvnebchLf4X/ySqw8cl6suqVwi8fbgtXEd
         WgStWeGtjRQlTEZ2P6Mxq8adIEM6LeAdXVIsGr5CoNAXy6oZWeMQR7aqv0aTvwQXYa
         6S82w3JCzDnkXR4DTapI1NhW0/usghZ2naaIvpISx1gd/WgG9e436GGpwGDxwbcpym
         lZ2jnAt0IvECA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 13:06:35 +0000
Subject: [PATCH 1/4] kselftest/arm64: Fix syscall-abi for systems without 128 bit SME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221223-arm64-syscall-abi-sme-only-v1-1-4fabfbd62087@kernel.org>
References: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
In-Reply-To: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RNcNgyi+XWeNF+WSinst8npBEXg52AmbeM5w3G+O9YA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqu3l6Oy4cmr1i0AZdD7/l1h/+/8+rwatiqVG6BTH
 CJpZJdKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6rt5QAKCRAk1otyXVSH0C0GB/
 41Fa+ye3U2Z+ujAnWV+Wyw58vmNFHQRwErFPW8ILHwKAurwod1ESbL3QB84c6oyxBY0Xm5akg63pKv
 AHyoOJo0V7ylfEeo+KLhIUf+/j8g5TvTgL4Ao+wuUdR7FniW9n17Nup/g8NpAKE3zNNwK0gFZWBwZ2
 K9w8Fh+LI8/LVusdHwE+3xf9EfObLOoFNTXDvrIR5XDFJkzX+shp7IFgdNLowymPJJHaeo4DQ+mAB5
 UuFkn34rcrCOzQumrWH9SD6nD+PBk6SVn+K5J+RdJDkSWGj55n+FFmX+PBbUxyNLT4vHB3PnNqdJXG
 HitVrnB+Lng5mN3x5qHOU90Q67lNzG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SME does not mandate any specific VL so we may not have 128 bit SME but
the algorithm used for enumerating VLs assumes that we will. Add the
required check to ensure that the algorithm terminates.

Fixes: 43e3f85523e4 ("kselftest/arm64: Add SME support to syscall ABI test")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index dd7ebe536d05..ffe719b50c21 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -390,6 +390,10 @@ static void test_one_syscall(struct syscall_cfg *cfg)
 
 			sme_vl &= PR_SME_VL_LEN_MASK;
 
+			/* Found lowest VL */
+			if (sve_vq_from_vl(sme_vl) > sme_vq)
+				break;
+
 			if (sme_vq != sve_vq_from_vl(sme_vl))
 				sme_vq = sve_vq_from_vl(sme_vl);
 
@@ -461,6 +465,10 @@ int sme_count_vls(void)
 
 		vl &= PR_SME_VL_LEN_MASK;
 
+		/* Found lowest VL */
+		if (sve_vq_from_vl(vl) > vq)
+			break;
+
 		if (vq != sve_vq_from_vl(vl))
 			vq = sve_vq_from_vl(vl);
 

-- 
2.30.2
