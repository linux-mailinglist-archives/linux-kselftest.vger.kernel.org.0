Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD045087A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhKOPeb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236711AbhKOPdr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:33:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CD5163227;
        Mon, 15 Nov 2021 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990234;
        bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlR1ytk6HDZSD2bIWIdqVcvh0JRDcUebryLCSc5smPoDU3G5TkO3mycVxRjFhiR6j
         AvqndWCOK5nS0SZ6Ex+/uDv61aJHFOADjI/z0TSTpyLmoC2BwdFfrXU9kC9FNm5c7c
         a4dJjrMz7VNJba8p6nw3H76URy2qAplLWbA+umWxd6t7HI1ByheoPkgo5oQHZcgHmv
         /vsq/+u6D1wOxnqBbB1hYGdru6uASKM+oC+VhxFkLgLpb2X5KZgQEVXWR7+z0z/xJj
         Sn/DZ2fqQNI7afFzEI+c2IN1IOsYyRnD8UQrBTgJUF4pRDO88XrgHUTwMwD9gjtsfA
         5C2fKQWXuMQXQ==
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
Subject: [PATCH v6 35/37] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Mon, 15 Nov 2021 15:28:33 +0000
Message-Id: <20211115152835.3212149-36-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknygMw1aSMaLYOpSHmlAJ01VdHXdXklZl9UT/zmb q+DxHDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8oAAKCRAk1otyXVSH0HpVB/ 9lne7hzkPdvQbX2QU9onsO0IX7yI1zUFyqWXKYTHQR2X0cEtyNvjftpdxmL3voXe1BRMf7IFYg4hE7 cMqRLjLY4ss4aqH9s8Ts+9RL90ysEG7a7NiDt22yxIe1fC6+sPxJAlMVr4qX8r4RYagyxAxdRj0H12 v0ZdnAL5DxuKfHPt1fG2owqNCKGIy8GXiaZO4Yxa0daHLVVTPBB+H8MUDlimfGBi0PV68uPFEC9lS5 nNtltkJ8vtNU7qS04dHxbvkJC5niD4rtFUa8vNk/AOA0GBud35nGH+RsxWeWLCcd2QBw5woiFdx8al VEb9QJYzPRjGIy84nUWIZs9Fh96+YP
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

