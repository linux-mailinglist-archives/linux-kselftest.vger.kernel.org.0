Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DF4C4C4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiBYRfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243753AbiBYRfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:35:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD381AA041
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7490DB832D3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B5C340E7;
        Fri, 25 Feb 2022 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810478;
        bh=fRMcQGt9qOd9tKyRQTKXjy5IY/TfQbpa6gESCexPdaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ys+rIwNeFsoa8Iqop1srsvcWOPPUm5CX1Z/5lFm5A/cva9CRnq4PoIHniCBxGsEly
         82+sa03vTZjidhe3Bgn5wSWTI2pSG7GjQrag7gny1wwzieS64GIrO+tLvnsBNVXYVq
         1QPs2ItBAgxjQF2G+wThHqBIm3sM1zqRqQGY98GyyOApj5zj+PXrww8clXgDiUWpaY
         ndc9c0cKYQI3PWILcssqG1MgveeZKMuXjVXz/vBv5N8UoYflXjGdbSlkeOzqnlOPCv
         eZsWyeUMWJ0pQ55LqCsz7RxfXYZm3fpBxDrLqk8v51Vm/dX/+2HTbytj9HTcd0Ng/3
         /pKTQW2SjWBIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v12 04/40] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Date:   Fri, 25 Feb 2022 16:58:47 +0000
Message-Id: <20220225165923.1474372-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; h=from:subject; bh=fRMcQGt9qOd9tKyRQTKXjy5IY/TfQbpa6gESCexPdaM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrNKAPxCaTE6j9X46xndFOJFEoYQVRk9ykKAar8 SCU4WF6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkKzQAKCRAk1otyXVSH0LLmB/ 4itWufojjDOWzlLsiLGiSHFkOQoYE+v0SpbmA52Kus2RzLry6YjuIczlaiYgmyFWI5VEXGFNe0hTqc 6Ns2U9aQF2BhB3AHQeKHQd09DrumME9y/r9yZ4Zql7co4e6Vloe8AnqoI54r8xNrxGAgC2UWJo2V59 SIUAhhEajyGpDE7oLntbB9HGDJRi8YOAoEOBc76T8XXYsgaxp5QCXVixD0FNXtgXTad0qitFXeIYnH RSitWjDUl56HMOIqauEbT9GDHdP/44taqCf3g0PJQ50HazYS1PzVf4pCBwc4JF+llswIX7jEspFDZx Y+oFaZklQ6f7Fu+/HgPlldBmyH4Bid
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

An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
in some of the arm64 selftests.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 1 -
 tools/testing/selftests/arm64/fp/sve-ptrace.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index d8eeeafb50dc..1e13b7523918 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -18,7 +18,6 @@
 
 #include "../../kselftest.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
 #define NUM_VL ((SVE_VQ_MAX - SVE_VQ_MIN) + 1)
 
 extern void do_syscall(int sve_vl);
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index a3c1e67441f9..4bd333768cc4 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -21,8 +21,6 @@
 
 #include "../../kselftest.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
-
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
 #define NT_ARM_SVE 0x405
-- 
2.30.2

