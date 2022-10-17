Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8786012BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJQP06 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJQP04 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 11:26:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245135FF5E
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 08:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 84540CE14A0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 15:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DD0C43470;
        Mon, 17 Oct 2022 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666020408;
        bh=/BpcIVyo9bzysBlJmI2fdJmkg66MdNxjcBf92h+/Hu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ip78g48reMynF7K+XwEnxkZbSeiyOFutcA25X/d4p38PqJ/LCWHrkmqGfI323EtX7
         7guubtuVmUWWrglHHHICwtsvcX5jlw88dQJL7veEHndG2PQ/R4gkLru0gw3iG84wfM
         Kjr/ywz1/zrpN/Cny3vmsoEdc2d4nov6M/QrwddJDB/yLyixnxcz+3PT5lwdAgCbfr
         6br4ZtLPTN9xWgVu2ViFukQshYWUc+JpAYuA9DCnPb/r8AEbGD5O8pybFdPaBCgYNR
         RdzvpHYYLKx9fUXhwnSckGY5rHKTx6RjBNfcymI7RliKbyN2Zs60np7QelBUaHWzQz
         G72klpHNer3CA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/6] kselftest/arm64: Add FEAT_RPRFM to the hwcap test
Date:   Mon, 17 Oct 2022 16:25:18 +0100
Message-Id: <20221017152520.1039165-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017152520.1039165-1-broonie@kernel.org>
References: <20221017152520.1039165-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=broonie@kernel.org; h=from:subject; bh=/BpcIVyo9bzysBlJmI2fdJmkg66MdNxjcBf92h+/Hu4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTXPd7GJTI7gG+rKzBJHx+VkNAPi9VEBmMS16Vpvk oLWt3qSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01z3QAKCRAk1otyXVSH0K7bB/ 4ikC5urC0sb7g63B6duWtUdmDAgZnP9ebgO45m6UYGtTyms3qfvulBBoEc0aAOipT/z8duB5kziX9n X6MznGaVhn+VchxamYHNHUBniyaD7oP0uVKJ8S+wHTWTdJNcJXyimtLe9/yWPYtKqMktrOZXaRDjWL NXRPCkPQa9M3/MEuBM0AVD8W+WbP7QcpA6vOHhkp9qJLlghbEjYs909gt+Z+qaqUSYLgMhg54b92Qg VXfxxPSH3NJ6gubwZW4TVkriWCREfbh5yRG3+wyCHZ2V2R9HM0dIwHI1I54Q7ilbVxh1VNQfYDOOj8 oMeAjJUn1aA+wQbtYycUQqLJ2HTooL
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

Since the newly added instruction is in the HINT space we can't reasonably
test for it actually being present.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index c7a6b327a7d0..30f87dfd634e 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -138,6 +138,12 @@ static const struct hwcap_data {
 		.cpuinfo = "rng",
 		.sigill_fn = rng_sigill,
 	},
+	{
+		.name = "RPRFM",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_RPRFM,
+		.cpuinfo = "rprfm",
+	},
 	{
 		.name = "SME",
 		.at_hwcap = AT_HWCAP2,
-- 
2.30.2

