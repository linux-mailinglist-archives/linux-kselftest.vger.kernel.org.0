Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1027E511D7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbiD0SXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 14:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244723AbiD0SXa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 14:23:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E0580C8
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 11:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE08AB828C3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E42C385B0;
        Wed, 27 Apr 2022 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083615;
        bh=cSixAmlTKw2H16xY90fD7WUxVIixGgp++6gG6bobZN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0zPWuZ61bxd2O36m2WONC/A11wEeAfoaz3iOH4pPyemaDoVKRmfclY0TjBz1vQzb
         KRRfpBHnL5w7ARMm60jEV2I/kqM9TNUEz9OGxevAJcliln9XlL/Y4xCjTilrCEGFZX
         Rm3XUcnsARcSiEDgkeQaNy/bA6MR/62EoGwfPWt/irg1MgZlX9c9udwUb3Y0vc5l+1
         R/TkUYl1V93f1+UGwyuqY+Tk4SzKOt3ckVVZJ6XJeV6Akh3IYJjJH+eKuNkYG4q/Ou
         HNkKj5/tljapuJyp6aQ8Akf8qQJus34LxcXNFeLnffk+6VXlMvzSfd82UnXVBp4x75
         U+Ud9znCVuejA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 4/4] selftests/arm64: Fix O= builds for the floating point tests
Date:   Wed, 27 Apr 2022 19:19:54 +0100
Message-Id: <20220427181954.357975-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427181954.357975-1-broonie@kernel.org>
References: <20220427181954.357975-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2912; h=from:subject; bh=cSixAmlTKw2H16xY90fD7WUxVIixGgp++6gG6bobZN4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiaYlIGvewxxC8WRJH/MZ9rckliMw+BcxTDoacoDZk y0L/jdKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYmmJSAAKCRAk1otyXVSH0DvIB/ 9BgsWRrlKD4/z8sAmXXd9W29zuNfcoXDM3fl4iPLwzkHDKxfveLr68wW+S39yuxJ8d7RSU4cGRxK4C OkFYYvS7jEuP0aGPVDyKbNilfWfqjbog9MxUJtIvgUtcgtfwxCzNrq4BgdGJPYD0NtI6F8DWP+VaEb Ukcs79GSfNAr57zrN1el4rsnH78fqpc5Sga3vpPT4rSy6Y6CrCu0CZ84awNHRnXfkTk760hfkhPtu/ ZhTG0JFs9F1vylyt5prgfkkr7HgeEtBWWlkSR2fD4oiPAvtZnrSJtcF0LHk9CzUcJ7r+VRTwlisIYC 3UzgWB/MWblR7w0j1qoS1FrWBxNLLX
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

Currently the arm64 floating point tests don't support out of tree builds
due to two quirks of the kselftest build system. One is that when building
a program from multiple files we shouldn't separately compile the main
program to an object file as that will result in the pattern rule not
matching when adjusted for the output directory. The other is that we also
need to include $(OUTPUT) in the names of the binaries when specifying the
dependencies in order to ensure that they get picked up with O=.

Rewrite the dependencies for the executables to fix these issues. The
kselftest build system will ensure OUTPUT is always defined.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 32 +++++++++++------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 7e5d48c4a59d..a7c2286bf65b 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -17,28 +17,26 @@ TEST_PROGS_EXTENDED := fpsimd-stress sve-stress ssve-stress za-stress
 EXTRA_CLEAN += $(OUTPUT)/asm-utils.o $(OUTPUT)/rdvl.o $(OUTPUT)/za-fork-asm.o
 
 # Build with nolibc to avoid effects due to libc's clone() support
-fp-pidbench: fp-pidbench.S asm-utils.o
+$(OUTPUT)/fp-pidbench: fp-pidbench.S $(OUTPUT)/asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-fpsimd-test: fpsimd-test.o asm-utils.o
+$(OUTPUT)/fpsimd-test: fpsimd-test.S $(OUTPUT)/asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-rdvl-sme: rdvl-sme.o rdvl.o
-rdvl-sve: rdvl-sve.o rdvl.o
-sve-ptrace: sve-ptrace.o
-sve-probe-vls: sve-probe-vls.o rdvl.o
-sve-test: sve-test.o asm-utils.o
+$(OUTPUT)/rdvl-sve: rdvl-sve.c $(OUTPUT)/rdvl.o
+$(OUTPUT)/rdvl-sme: rdvl-sme.c $(OUTPUT)/rdvl.o
+$(OUTPUT)/sve-ptrace: sve-ptrace.c
+$(OUTPUT)/sve-probe-vls: sve-probe-vls.c $(OUTPUT)/rdvl.o
+$(OUTPUT)/sve-test: sve-test.S $(OUTPUT)/asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-ssve-test: sve-test.S asm-utils.o
+$(OUTPUT)/ssve-test: sve-test.S $(OUTPUT)/asm-utils.o
 	$(CC) -DSSVE -nostdlib $^ -o $@
-vec-syscfg: vec-syscfg.o rdvl.o
-vlset: vlset.o
-za-fork: za-fork.o za-fork-asm.o
-	$(CC) -nostdlib -static $^ -o $@ -lgcc
-za-fork.o: za-fork.c
-	$(CC) -c -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+$(OUTPUT)/vec-syscfg: vec-syscfg.c $(OUTPUT)/rdvl.o
+$(OUTPUT)/vlset: vlset.c
+$(OUTPUT)/za-fork: za-fork.c $(OUTPUT)/za-fork-asm.o
+	$(CC) -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
 		-include ../../../../include/nolibc/nolibc.h \
-		-ffreestanding -Wall $^ -o $@
-za-test: za-test.o asm-utils.o
+		-static -ffreestanding -Wall $^ -o $@
+$(OUTPUT)/za-ptrace: za-ptrace.c
+$(OUTPUT)/za-test: za-test.S $(OUTPUT)/asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-za-ptrace: za-ptrace.o
 
 include ../../lib.mk
-- 
2.30.2

