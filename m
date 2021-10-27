Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3166E43D135
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbhJ0SzA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240514AbhJ0Sy7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:54:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF6696103C;
        Wed, 27 Oct 2021 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360754;
        bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXjCEqgD8Q1ToRjrbDe1J7wi6qhkj6zmumHoGUDGxxChc9e5MlxUGW0Xhf6JJFPoU
         Hn853KSQow63hXAK9nxgBP4iSPEvnu5ZW7dJDTTIHdqETkmOI7vkP4CkhF75UzMR2z
         OZ+UuAXBH0J2VGjpqJCCrfsus0A7/2gvcKbJzeXCe9SNqnbH2d5heapqFE+BfZFZx1
         lcvwE6mm8lJyKqOhiF73iGKyDF9I1RhaxwgBJlagxbOWMtKl097wgS3ARE4LOA5tho
         u4oAaSYV/kLM/C6jXfrGAipFC6IuhDSIxp+NR4PLaVmG/yJ9kNeaDSj6as9rDlBDfR
         q1vt8SxfYmK0g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 36/38] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Wed, 27 Oct 2021 19:44:22 +0100
Message-Id: <20211027184424.166237-37-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ4CMw1aSMaLYOpSHmlAJ01VdHXdXklZl9UT/zmb q+DxHDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmeAgAKCRAk1otyXVSH0CRzB/ 9a2+vAQQ/taF5ayaym7r11UTP1i/HkD0Z2Ld2svtJeJhObu4dBcRhCBVVKDIpCHI/oAC3kiNO86Pur VJT9ShcoHaDCkN0MDggeXHMWefYYn+4Po5aZ5LwLUEFRcWeCicHzPGAkQMMzH97jSjrqia8JpTQx/S YQEAuIidkjXkYgY3Ge0YJgssSG/cnDNZiX05+oeAdLGGz31FbSK8/YfWhyEOr8FQuLpqx5LwZgQ5/2 0ZSJ18ac3HLCWzje11hDAImmlGDM7eJKZfFnYGjCP5YFGX0z/fTRSnBYlEPFGhFgjhEUDkKinQr26s OAox2N4aaH0yXhXJbF1EzW6d3ndDPC
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
index af798b9d232c..00c35b9db27f 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -28,6 +28,10 @@
 #define NT_ARM_SVE 0x405
 #endif
 
+#ifndef NT_ARM_SSVE
+#define NT_ARM_SSVE 0x40b
+#endif
+
 struct vec_type {
 	const char *name;
 	unsigned long hwcap_type;
@@ -44,6 +48,13 @@ static const struct vec_type vec_types[] = {
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

