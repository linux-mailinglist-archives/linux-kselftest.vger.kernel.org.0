Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77849CDAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiAZPOP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiAZPOO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:14:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380CC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 231CB61842
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383FDC340EB;
        Wed, 26 Jan 2022 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643210051;
        bh=Oja1/wO9gzdoi99/QIiaS7CVLDJss5+ewa1C/MDEXls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UspBiTLX7oA/wP9GC6WdtaGZ6p6ABC3ihVdAn1wAEuQxR7031HUx/7Q6qOVW9EHQG
         ZnNAQxk55sPUOqZWGN3yfV/j8TAyTmQiyn3lPAWQcjqz5VxEMzvq2yvy+15B68GWzO
         vQAH5o8mUOBdWBJLUqPZ9UooD+n6mYI3iu/zyL9GzcEYcMbuj7OzMe/1m/6Xl79twS
         KGGXsriV9t85PcIK+QD+ZAh8mjX9oNRLWe6fYNhZZ+Gv7dUlLdVQGeUcA3H/cCzYja
         GXI9klyRdUijcueJgHzA5LJcz0tOfLi8DYSsTDNArUjkNeNEKHvVwfJGfG0a8e65LJ
         hCRbLPG4wxB2g==
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
Subject: [PATCH v9 37/40] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Wed, 26 Jan 2022 15:11:17 +0000
Message-Id: <20220126151120.3811248-38-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=Oja1/wO9gzdoi99/QIiaS7CVLDJss5+ewa1C/MDEXls=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSUKqGPNGZXH7z6iwfnPdNtlzhXYbjCCRcGKiz8 vwxyiyiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFklAAKCRAk1otyXVSH0ACqB/ 9H5FbWIzMbqx0jF7effH5vEJmz1AFPrA2WB3HBOBbIaMlvmVGPsk3rjTzrJrv2YhmcvbR4SH5qWjcy iNEZuf584MdmuNQf2scMulPNuNY9rjIQu4Rr8CKZSDxN0HWjHYM+irqzzAK7vpCPjSxCJwJ/k5Rkg6 fOZ02eQLTWJorxtm9EjpzJhGjbhnxQElfc8fsuFP9Z1T2EVhYxIPEW12EawWFbyXbKZxanoZ/Ynk3Z 83C7JnWCoxNckdqvUcuZ08P/GFqF9FLcAl9s3wU6mHTHWthinLymZlSX1F7WKghIORkiBoLQ8wya+/ qWlaHX0+sSFYwaezFs0GYsoiSow8WU
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to allow ptrace of streaming mode SVE registers we have added a
new regset for streaming mode which in isolation offers the same ABI as
regular SVE with a different vector type. Add this to the array of regsets
we handle, together with additional tests for the interoperation of the
two regsets.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 90ba1d6a6781..fb74b11bab71 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -26,6 +26,10 @@
 #define NT_ARM_SVE 0x405
 #endif
 
+#ifndef NT_ARM_SSVE
+#define NT_ARM_SSVE 0x40b
+#endif
+
 struct vec_type {
 	const char *name;
 	unsigned long hwcap_type;
@@ -42,6 +46,13 @@ static const struct vec_type vec_types[] = {
 		.regset = NT_ARM_SVE,
 		.prctl_set = PR_SVE_SET_VL,
 	},
+	{
+		.name = "Streaming SVE",
+		.hwcap_type = AT_HWCAP2,
+		.hwcap = HWCAP2_SME,
+		.regset = NT_ARM_SSVE,
+		.prctl_set = PR_SME_SET_VL,
+	},
 };
 
 #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
-- 
2.30.2

