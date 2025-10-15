Return-Path: <linux-kselftest+bounces-43249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C69BE0327
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C98504FE701
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502283009D9;
	Wed, 15 Oct 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHP4U2l5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE43002DC;
	Wed, 15 Oct 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553247; cv=none; b=KghF6hzIYH5Ot4ZU6YfNB7P2i87yj+NozOJx9DPjarpdHAz4mObgpoGzEWuDpK39KqHwuhQQjsYOTF3aoEm51R7cQvrrFXVeiYKsMQhc8ciD5F0LkRtHKdV9pn/3lH4lAm0LRxvE4doxfog4wsyGzu5zWPuAA0k0m5VAHKUllKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553247; c=relaxed/simple;
	bh=Xv6yHCpNjzsH8/JCHYEyM4n96nFPTL8HY23YJ+yYWPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWqkHHu3nOq0nXgZ6qxInNVPciDdB0bjA2U/XiFkAOf+/sKFJqhI32+r7Gyr8lA3BY9UsBtJFXaEyRvP/VlQbi4nnqo/XBuWgGVy0UYhnYcUmYAhG6RyXainCkq9GTSZE208Vfm9v3TFdQWOLSP2g3wSN3HZCkxEs/kHZJYVgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHP4U2l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC578C116B1;
	Wed, 15 Oct 2025 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553246;
	bh=Xv6yHCpNjzsH8/JCHYEyM4n96nFPTL8HY23YJ+yYWPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VHP4U2l5loyGV8ALU7Ia2R6/40D6LmhS6xILEBqjXewj3GySfW0t1tVXzNP61zHVW
	 sXHbk88fLJrMna5/0AwBTIvnRdO7Sm9Ae6SDtj9lh+8R4cgvRUaTRUXNXaqxt6JtxZ
	 +skunpbXlJNBkTcvH6TcYAOXjYQD93rvadMk46aZHznN5HGSWxotRtv0qsTpkBXU39
	 PKZqSN/kDgG+IvDZDblSuRgkv5gQiyfLxaMG18eH7/sb0gEb9h82JY56PbMRdy7cc2
	 KHvc06/ic1N9xypP/ENWi9sRiGgAQDddwoInJjW2lRx/QXc+uclV2v0g174eZBsWAX
	 zP/N0kMhDV36w==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 18:56:37 +0100
Subject: [PATCH v2 2/3] kselftst/arm64: Test NT_ARM_SVE FPSIMD format
 writes on non-SVE systems
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm64-sme-ptrace-sme-only-v2-2-33c7b2f27cbf@kernel.org>
References: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
In-Reply-To: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 David Spickett <david.spickett@arm.com>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Luis Machado <luis.machado.foss@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-2a268
X-Developer-Signature: v=1; a=openpgp-sha256; l=2876; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Xv6yHCpNjzsH8/JCHYEyM4n96nFPTL8HY23YJ+yYWPM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo7+kTtExQl2fALYDooDYk+IBi3sFFozHENC+hJ
 2suVYsiBFGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO/pEwAKCRAk1otyXVSH
 0BOvB/98hVKg3ztxRIYwgaH9DWjipCXQnv+FYob/1LS82o5N10ru8M1jnZVp9eHnHhMoSYCxDmz
 aMhbTxD1AOQKxn4FqpEuwTv1hiC+5++THVw11uZZDcqrtzbCsxT6a0TZD7YuiNupitSSuI1mnUS
 6k6U8qNWOIIdjIBJYCZasj5TRCZhgkw7nzVD4gKDSZ9jvefU9fIdNsQMCsR5mh2LZVT7pE7Hn7d
 R7Wv8vG+xA6VcqUTK/6Ra10mIHNzQE7Vg74wHvRzd4xj7n7qNDf+dfMa3vShssHdNCtpTmmG8ow
 ybRqI/4CpbvjZthTLw/L7XCxGGddlgnVwkm8aeTNVfrL0SW7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to allow exiting streaming mode on systems with SME but not SVE
we allow writes of FPSIMD format data via NT_ARM_SVE even when SVE is not
supported, add a test case that covers this to sve-ptrace.

We do not support reads.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index e0fc3a001e28..f44d44618575 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -394,6 +394,58 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 	free(svebuf);
 }
 
+/* Write the FPSIMD registers via the SVE regset when SVE is not supported */
+static void ptrace_sve_fpsimd_no_sve(pid_t child)
+{
+	void *svebuf;
+	struct user_sve_header *sve;
+	struct user_fpsimd_state *fpsimd, new_fpsimd;
+	unsigned int i, j;
+	unsigned char *p;
+	int ret;
+
+	svebuf = malloc(SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	if (!svebuf) {
+		ksft_test_result_fail("Failed to allocate FPSIMD buffer\n");
+		return;
+	}
+
+	/* On a system without SVE the VL should be set to 0 */
+	memset(svebuf, 0, SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	sve = svebuf;
+	sve->flags = SVE_PT_REGS_FPSIMD;
+	sve->size = SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD);
+	sve->vl = 0;
+
+	/* Try to set a known FPSIMD state via PT_REGS_SVE */
+	fpsimd = (struct user_fpsimd_state *)((char *)sve +
+					      SVE_PT_FPSIMD_OFFSET);
+	for (i = 0; i < 32; ++i) {
+		p = (unsigned char *)&fpsimd->vregs[i];
+
+		for (j = 0; j < sizeof(fpsimd->vregs[i]); ++j)
+			p[j] = j;
+	}
+
+	ret = set_sve(child, &vec_types[0], sve);
+	ksft_test_result(ret == 0, "FPSIMD write via SVE\n");
+	if (ret) {
+		ksft_test_result_skip("Verify FPSIMD write via SVE\n");
+		goto out;
+	}
+
+	/* Verify via the FPSIMD regset */
+	if (get_fpsimd(child, &new_fpsimd)) {
+		ksft_test_result_skip("Verify FPSIMD write via SVE\n");
+		goto out;
+	}
+	ksft_test_result(memcmp(fpsimd, &new_fpsimd, sizeof(*fpsimd)) == 0,
+			 "Verify FPSIMD write via SVE\n");
+
+out:
+	free(svebuf);
+}
+
 /* Validate attempting to set SVE data and read SVE data */
 static void ptrace_set_sve_get_sve_data(pid_t child,
 					const struct vec_type *type,
@@ -826,6 +878,15 @@ static int do_parent(pid_t child)
 		}
 	}
 
+	/* We support SVE writes of FPSMID format on SME only systems */
+	if (!(getauxval(AT_HWCAP) & HWCAP_SVE) &&
+	    (getauxval(AT_HWCAP2) & HWCAP2_SME)) {
+		ptrace_sve_fpsimd_no_sve(child);
+	} else {
+		ksft_test_result_skip("FPSIMD write via SVE\n");
+		ksft_test_result_skip("Verify FPSIMD write via SVE\n");
+	}
+
 	ret = EXIT_SUCCESS;
 
 error:

-- 
2.47.2


