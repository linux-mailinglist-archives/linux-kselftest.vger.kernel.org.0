Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E14AC3EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiBGPfM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiBGPXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:23:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AFC0401C1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:23:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7273561035
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACE2C004E1;
        Mon,  7 Feb 2022 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247402;
        bh=+3VTZZuKVlfj3PHcp/aHFz8BbrWQRRO0ZN8yApxFTHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6e39YuVcqxvURE1dDlybDtE6+/O3bPloBPqXpGC4cx3/aJeZ4vFmguknMx1Il73d
         OvBpKGXFrzr2UPbIM278KTNvi5675X2WWDmL5R+I0jGfp9XO2rYrX/YjOgaeI3HCg6
         fZHNWWFivUptT94eAFlZ+iOcO12nVWwlkhGQuTC57BCPxElHettnZh8yV+xwSJwbcf
         sFnV/xXB6XtYRNtgwC+XPmGgktO1kGyA3JqJvOCXkX7Db6P6Pi8I/0jOS2iMMmTiuu
         BeHDypCWwYdXakuwiAwLHogrdV69vbyIr9FwfBfK/NzR5jNwE0UAC1GFmj6ktBQAKv
         TbZlAeeXLa1rw==
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
Subject: [PATCH v11 04/40] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Date:   Mon,  7 Feb 2022 15:20:33 +0000
Message-Id: <20220207152109.197566-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; h=from:subject; bh=+3VTZZuKVlfj3PHcp/aHFz8BbrWQRRO0ZN8yApxFTHo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjIOOkBxtTD0ogV/fD69P5hPnz9SqSHumCqfc4B xt2smpWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE4yAAKCRAk1otyXVSH0E07B/ 0TlC/mxicrwg6RnAylCxB3yQzF3z45C3GndS2h6TJbLqyZPgUp8CbANNcL5GJeFd/9LVR3PGKxMwpZ NItKAxS7Qv/OT6cOT0puDG+d739swVYdMSbyAddDnIgE9ypjbEwQlOF3/AGk76IX2ETb1vMyOaoJyE 1s/O5IFipgYeP1AAweotF/4qkGFPCa1t3qb0CdPOtLW52zkhnLZJU3YUmH3FDpmoOq88Ybme80+Dm8 ckTPs0IjEPj4AG16yXSKeX+7HAzTD3M906CTW3wVljWYPBxaxoUOGIqSLXpkwwZW33uuDLv4/XXi1B /iGh/02ipBtMJwOhSeNIUqhDOCr/VM
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

