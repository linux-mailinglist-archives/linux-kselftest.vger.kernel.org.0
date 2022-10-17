Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92AC6012BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJQP07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJQP05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 11:26:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1AC647CE
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 08:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A502ECE1784
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 15:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB4CC43470;
        Mon, 17 Oct 2022 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666020412;
        bh=8V2GhJ4jVvqw3eI18z+SJ7d6N8Yl/q31zrS4myMV8vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNwTaKuzQMFSMkUXMF2t8C0fzjC/+BEEgQrbVTqgS4y6h2iEdPJ/Hq3Q4upmC987u
         l+LsYbbF8yYQsHaKhSclTjKvrDYH3PLq5rLSDGQO1sD55W1EmhQ4uKilrdH4myD9/B
         ttG3rIKGFfsNkWozQtdTf128GsosrrdBQZjNreyrFmJ1EqvWvkDhHFhLZa9+kQWEZG
         UKVjI9zPmtntqFBU/1Kh+wyIt4ZUiF1jZy30/a0Avtmd41VCud477ZaXpRPVn0WP30
         B7E7O/46ZbzqIBv9y/TAHVeUbqg4uIVA0L3hSpGttqzOq0Ox3LICVQVVPaajIKZM38
         Cp6DKwGJpGcyA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 6/6] kselftest/arm64: Add SVE 2.1 to hwcap test
Date:   Mon, 17 Oct 2022 16:25:20 +0100
Message-Id: <20221017152520.1039165-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017152520.1039165-1-broonie@kernel.org>
References: <20221017152520.1039165-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=broonie@kernel.org; h=from:subject; bh=8V2GhJ4jVvqw3eI18z+SJ7d6N8Yl/q31zrS4myMV8vk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTXPf6xaAYBc8ox07be/LQezNNjaZrSJSfXzeNFrs NI2S2W+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01z3wAKCRAk1otyXVSH0DWoB/ kBvdAdNKDU24CwLcJlPAK2c/k2LbL/WWQ3tbnt0GWNWllgljr1Ds88CnR6EKIzo3hmBI8yaG6dbaAf Z4NEkr73TuOsM4pQe2WUW1ECBnYt0uBQzJY/Bnsm0qiSwY3ILC5MM8VwadT2ZeZx6Hj7UOwm2Wksxg 5F8t2RC/lvVmHTnQtoWOQZPaKUM823CCO/eeDfw1jT3AlbjUOTIhgbpVxozmuvK48s1mE787d9uFon k0LbUF+86RP14uppzmQpSv61Izyql+1vh1VD06eWWuMxVNrohnbYn15FzmPUR6mgE/jZYApnJWgK6F nTIR5TMgZUM7lQF5uGezDN7z1pzIr+
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add coverage for FEAT_SVE2p1.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 30f87dfd634e..9f255bc5f31c 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -62,6 +62,12 @@ static void sve2_sigill(void)
 	asm volatile(".inst 0x4408A000" : : : "z0");
 }
 
+static void sve2p1_sigill(void)
+{
+	/* BFADD Z0.H, Z0.H, Z0.H */
+	asm volatile(".inst 0x65000000" : : : "z0");
+}
+
 static void sveaes_sigill(void)
 {
 	/* AESD z0.b, z0.b, z0.b */
@@ -167,6 +173,13 @@ static const struct hwcap_data {
 		.cpuinfo = "sve2",
 		.sigill_fn = sve2_sigill,
 	},
+	{
+		.name = "SVE 2.1",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SVE2P1,
+		.cpuinfo = "sve2p1",
+		.sigill_fn = sve2p1_sigill,
+	},
 	{
 		.name = "SVE AES",
 		.at_hwcap = AT_HWCAP2,
-- 
2.30.2

