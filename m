Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB12507A9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 22:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356453AbiDSUHp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356516AbiDSUHo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 16:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE46277
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 13:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF96616B2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303F2C385A9;
        Tue, 19 Apr 2022 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650398698;
        bh=O9mTXZ51XW67vYoYCAP8nyhOfuxV/KXn/4qe9Y37o9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nA+lndyq2nuRa5DCVgxF7CHYWzPZpp72PxenTRdUoIo2ersIXu9ymJMEUaWm+EcbC
         TVYqMtddG5U5/ATfSV5xuX7siZ3H0zB+9Y6ys10teElAczqLrbxVGTTvMxmNfZF6ZO
         VbdgH/tOHpzxQoQlsfGv5J2s4b52duCtUu0W8hLdfGKuXNT26qcAGQookBOHrnGmWE
         OcFcUgoNUo+IC+GiUx1l5CzcG5ObkDk42405TQw3YO5Bw4kfTsnds7VFIUHOHWZ4t6
         0+vIshe0yYWH32KljYHM+2hlrjv31x5gXCD3bh/P8BbGhqbmr41vjTVnBA5oGtIimB
         gvu1H/XXv43Xg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/4] selftests/arm64: Fix O= builds for the floating point tests
Date:   Tue, 19 Apr 2022 21:04:42 +0100
Message-Id: <20220419200442.1374548-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419200442.1374548-1-broonie@kernel.org>
References: <20220419200442.1374548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; h=from:subject; bh=O9mTXZ51XW67vYoYCAP8nyhOfuxV/KXn/4qe9Y37o9E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXxXZFnp2XJdfrJJ+IraaSXi82rN8btIuPd3SDuKT baVby8uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl8V2QAKCRAk1otyXVSH0PuyB/ 9hzMfitS2eGLSXNCQXpMcMpghJMIExHbwqAYSN+qoSM7I37xTxo2tjqsPxbV1c1P3fnVLr1dQQ6lNG JZ3Wjy7Eob225NLToe9gGd5Xgjb1RwwrhaPKyzvC8pShu68Vqt7Y9qZBycwezhl6fCpkowGx2SEVnx 0PywoOSyAT4XyFhg48rwjYpm521yp1LaGX92+bV6kV5kBDLvFiPAh6PDm7IHoPnHRkNYESjIAS+/+b tsyWHLH8TWiiRlW4gZS/cTrIz1rWxHWP6uBMQwlKcrt76MGU/6LAFlLomlnbtxD54EGZwZol02LcgV L6MS5+Uzj/cGKCM2vanBXjmpcdlahr
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 tools/testing/selftests/arm64/fp/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 927b1e83f469..45bbbf1c5b97 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -14,16 +14,16 @@ TEST_PROGS_EXTENDED := fpsimd-stress sve-stress
 
 EXTRA_CLEAN += $(OUTPUT)/asm-utils.o $(OUTPUT)/rdvl.o
 
-fp-pidbench: fp-pidbench.S asm-utils.o
+$(OUTPUT)/fp-pidbench: fp-pidbench.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-fpsimd-test: fpsimd-test.o asm-utils.o
+$(OUTPUT)/fpsimd-test: fpsimd-test.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-rdvl-sve: rdvl-sve.o rdvl.o
-sve-ptrace: sve-ptrace.o
-sve-probe-vls: sve-probe-vls.o rdvl.o
-sve-test: sve-test.o asm-utils.o
+$(OUTPUT)/rdvl-sve: rdvl-sve.c rdvl.o
+$(OUTPUT)/sve-ptrace: sve-ptrace.c
+$(OUTPUT)/sve-probe-vls: sve-probe-vls.c rdvl.o
+$(OUTPUT)/sve-test: sve-test.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-vec-syscfg: vec-syscfg.o rdvl.o
-vlset: vlset.o
+$(OUTPUT)/vec-syscfg: vec-syscfg.c rdvl.o
+$(OUTPUT)/vlset: vlset.c
 
 include ../../lib.mk
-- 
2.30.2

