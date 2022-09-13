Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3D5B7023
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiIMOUN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiIMOTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 10:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0865244
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 07:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4799614B4
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 14:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAA0C433C1;
        Tue, 13 Sep 2022 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663078311;
        bh=m8rYBXGK2zrdekuTqL5ieyhDhOUxgJYJ+kanTTgsfw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVGDOfnA7FCGEf6ffvtjhKCtFyn6z6iBALO+qn2KGr0Fxh2ufm4ZhFbpCd76sT8W2
         RvHwmqPF6HA1zNJcBGAZugaJNLv3c4PLomg61d4pFq8aEPgfyS171el6tBJF53JIlW
         qDRYWa3TNRZX7kkDXZQJG9JiHirWXx2MVvrCosRN15F6qf2bm7ynv/iVZ1Z/BEcHfe
         Kwlnpj4jI5+fU9DmdV8AC7rQKhzIWIvi3bh1km2fgBnP/luoE3Pw0T4Meld+yjBe5d
         ULpcA67pQXSwZLODL4I/DCSXH5bx4scHUPvSKm+UJ43dM88vaWYXL+7ioFEcLqZS0G
         SMh2MZSZk48qw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/3] kselftest/arm64: Add missing newline in hwcap output
Date:   Tue, 13 Sep 2022 15:10:59 +0100
Message-Id: <20220913141101.151400-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220913141101.151400-1-broonie@kernel.org>
References: <20220913141101.151400-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=850; i=broonie@kernel.org; h=from:subject; bh=m8rYBXGK2zrdekuTqL5ieyhDhOUxgJYJ+kanTTgsfw8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjII9zRIhMk9ZGoH+ZWFklvmdX1nKgPmpJX22oSxmJ vtTzlfSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYyCPcwAKCRAk1otyXVSH0JuZB/ wKqZHD/t0VVbQEud6eyxIQdpbMQOrIFYr5rzLZKnoCT0p/+wI2JvsxFGrhD+DJzpme52HaskxExVIK Wpnqbm+eS7WOtKW444F1DLye4AEK6kRTy5F32+OjjWw6RWMRA5JIM/thN1tNia+mA5NnhLQ5AggsD6 DQO29GWey/1s51K8X364P/uooAkSZTjovGRjYWZW5ilCUgR1cTpC3Me+UKcWvbZR2nwfen86UnFou+ X8QIRnzbw/N10oKR7I+MI7qfR39wgClj8DyiPs8keFtIaocvjm8XdR+RkxyFo8x/UCBpR+s9k5Lbtx W8MBsapdrLf71/39K7R5EEBaBGqDdj
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

Clean up the output of the test by adding a missing newline, the fix had
been done locally but didn't make it into the applied version.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 8b5c646cea63..04e4a81dd159 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -151,7 +151,7 @@ int main(void)
 		have_cpuinfo = cpuinfo_present(hwcap->cpuinfo);
 
 		if (have_hwcap)
-			ksft_print_msg("%s present", hwcap->name);
+			ksft_print_msg("%s present\n", hwcap->name);
 
 		ksft_test_result(have_hwcap == have_cpuinfo,
 				 "cpuinfo_match_%s\n", hwcap->name);
-- 
2.30.2

