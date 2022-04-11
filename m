Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF634FBB6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 13:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbiDKL6e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344103AbiDKL6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 07:58:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375243AD4
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 04:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10D0CB815A3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Apr 2022 11:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6038C385A4;
        Mon, 11 Apr 2022 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678173;
        bh=O9mTXZ51XW67vYoYCAP8nyhOfuxV/KXn/4qe9Y37o9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFELqIViQojxOoWGZz/ND1dKVnH+BLKdgsJCqL8fw8AogjmRPP9+M7vIifRz3csD7
         3LwTrQmh4Tly6kKhlQrYIhIXJzs5xrcQaj5ckiEJtpZ0SbtYej5aJKoVgD209zlL5s
         btbtZxdOJoXPHxiC1a+F0qy5ic6M5MibDDBWC7B24o/wzUyds0R1lbYSztuvpXjzrP
         26XqFSmP8KRhUrofmGWcKEPA6w24f9abPB3JqQ2cxzNJLK3/Lxt+c/1qkoqXghhmq4
         ZEvLbIkPJGxTCtcPDrLC5EPoJh7ykyeFqJN5NBdzeAnJGlJp1fbR616sV9+R2f4X0p
         BLQBYXSJGusCQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/4] selftests/arm64: Fix O= builds for the floating point tests
Date:   Mon, 11 Apr 2022 12:47:10 +0100
Message-Id: <20220411114710.16204-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411114710.16204-1-broonie@kernel.org>
References: <20220411114710.16204-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; h=from:subject; bh=O9mTXZ51XW67vYoYCAP8nyhOfuxV/KXn/4qe9Y37o9E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiVBU7Fnp2XJdfrJJ+IraaSXi82rN8btIuPd3SDuKT baVby8uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlQVOwAKCRAk1otyXVSH0MQ1B/ 9aj0Zc1eeBekYPcJFhWYfq5vgUA8W7HYEs5VtDGQzKe/bHZ5YT45AhWYOtBqop3KA/2NuJRrR1HJeo SdUcV8WA0E4oaoOJOv/ERSyDpoXSHLyvg2xgvO4kB9hjXfUhTzBpKRo5tduD1dzJEB3aYiCKi4Gum2 +Znm3IS/FaCSHos7FP/RJxi9WrxgQ9emL2vWKaYpQK2+mzYNUeC1uYKyYHEwTaTTP2gnzpwfUDpE+8 6kVgjkamEp810cW2GzxiPMrgcmp3+NCMD4tB7KuYI3HQFRKt2WvHcws3uFDsdYaUu4PZpcFZoc7joE NBe+h/vStzhfk1WtwOY5BVwPw9ilSR
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

