Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0E512147
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiD0SXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244736AbiD0SXW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 14:23:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E253D494
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 11:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36EA4B828C7
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D61C385AE;
        Wed, 27 Apr 2022 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083606;
        bh=wmz3PwuOvlMzXQTJatnv2wCvt/2+MqR+bsBQ3HiNApE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNdvikKk24GE5RtWiV7PVN7Seyp1RDLuRVDkaCoX2iye8lH04QOxDft3Cb8TFcWM4
         s/p62OVvnBqOaJFeA7oZgewCzwHKHwYmkPYUeuXbNyVVK51OdKZhzB0lesfj8Q+BHI
         IX5q9S+8Ekxqji7koNHZPU9Vuqr9PLWLBXz98I3tTkuFQF5NUN2KTL4PDnh/bCtsHq
         3WJiKL4rMwtcRlFxsHO3cN3VDVP9DgfiZsOn1cacBEaYrtqrSUGoVEFGdvkZaAh7Qg
         p+i+HPk7RSCFxzHN75QlcdIhe6sSa4AfWpc2bMfTAm4JIeG/n4kIb6XcfrOMb+MQEW
         Iyx7I3ToOz02w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 1/4] selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
Date:   Wed, 27 Apr 2022 19:19:51 +0100
Message-Id: <20220427181954.357975-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427181954.357975-1-broonie@kernel.org>
References: <20220427181954.357975-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; h=from:subject; bh=wmz3PwuOvlMzXQTJatnv2wCvt/2+MqR+bsBQ3HiNApE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiaYlGAYn/Esfdx4aZYt8/4V2Dka5jpcovBRub8atp ahQ7xq+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYmmJRgAKCRAk1otyXVSH0AAvB/ 94QZzXYQDcmTmcF8OfwAsbAh1iZZFrMFwe/E9OlLXDSatvm+6iALLyWIWaoQl8lB1HbVA2Eb3qJc7o JmhkT+1WYd+uj/ogRCJgJpngKq5rKdcLsZYL9mJ418+S8kWLkLfL63EHuZ5pPnWNpMWRbLNqotXl10 gQtPEn7OM7vFHqBxvuJNcCPXv7pc1bO5IgWqSlBLb87fLQqOe3IF4AZWTqTD8B3fcO+kGJKp5jCYgJ qNUVloczMxv3FM7+byRty02kxEtf748j3pyuJrv3LzrzoRgew+pR9wkPrW0x4Tp1T8IhRfK2n7e1B0 xrODZeDydWtpjmqoZ+IwZqTmDkbvFW
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kselftest lib.mk provides a default all target which builds additional
programs from TEST_GEN_PROGS_EXTENDED, use that rather than using
TEST_PROGS_EXTENDED which is for programs that don't need to be built like
shell scripts. Leave fpsimd-stress and sve-stress there since they are
scripts.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 95e707e32247..a0b8cc59947e 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -2,14 +2,13 @@
 
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg za-fork za-ptrace
-TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
+TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	rdvl-sme rdvl-sve \
-	sve-test sve-stress \
-	ssve-test ssve-stress \
-	za-test za-stress \
+	sve-test \
+	ssve-test \
+	za-test \
 	vlset
-
-all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
+TEST_PROGS_EXTENDED := fpsimd-stress sve-stress ssve-stress za-stress
 
 # Build with nolibc to avoid effects due to libc's clone() support
 fp-pidbench: fp-pidbench.S asm-utils.o
-- 
2.30.2

