Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1D408CAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhIMNVL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240399AbhIMNUd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3673361216;
        Mon, 13 Sep 2021 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539137;
        bh=3RGlMrOqTC9QZNG8f5YOa/s+hJ+c18k3VekrOVRUQEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFbjj6TVfED9S9hFdrABRBiPHgjsJy9Vn6kn4XrpXDQhQL/zOLEFomg3Vr+wNZrk5
         4Y0rdZXrWWtYMGG2zhmyZoCF0Ulztir+NcpKpO7Bs40ht5pmFygtQfKVEvfQBnCjJZ
         NTYqZKDOxUhBaTF9zFXluRuD+uU3t9xMAY8vv383K1tw+q0AtZkN+0mEvxZLQw5WVN
         /zp8KezwAdNv8Jr1e49Vt09sBVtWK0aO6N9Iez0BnHx5QBfgQGU4Q9Bzbpe7hCwBfz
         v6RbGAWGrfbBoaXrMcQY89vDFaQP58r3VEXniFhGvXBk/WjB1Y/S96PDsrLXMpl0B+
         D8osld9OQ9hmQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/8] selftests: arm64: Document what the SVE ptrace test is doing
Date:   Mon, 13 Sep 2021 13:55:01 +0100
Message-Id: <20210913125505.52619-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330; h=from:subject; bh=3RGlMrOqTC9QZNG8f5YOa/s+hJ+c18k3VekrOVRUQEA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0ol6DkHVUICf8Th6pUk6tfsdEP8uH4OL+9Tu5lU 0FceRhqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KJQAKCRAk1otyXVSH0LgVB/ 9A/aC9RnVqvaN747YpyJsNIdYQ3o0Uhr6aQXDK3BRYACofl6l4MCga6Kc86rrtUPyHGBxQ29d7+jAj Rr2PYf4nYn3IZ6qPXZD9ZlXNuSOll4ilpEzlDpoxN6+nVTQUQovU9lBYuXULo6bQrLXT3FT2psB1Su mxR/vMqcUaEy6Kx+E7vaKigrZPnR1OpML7/OIpTzP6dAh9FDgqLDaqIdgbcArzNBaJHufAfG525N9i ls6l8tjS6WvKSXh+YrAEdy6BbCkoteGxDnFhag1mT9DRQGsXUfJUkxzNjUvSgp6J56iUgMYCl8v5iY fcfJDtASr41L/eJhnKIyGWQnIrlOFt
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before we go modifying it further let's add some comments and output
clarifications explaining what this test is actually doing.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index d2ec48f649f9..fc4a672825eb 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -181,6 +181,7 @@ static int do_parent(pid_t child)
 		}
 	}
 
+	/* New process should start with FPSIMD registers only */
 	sve = get_sve(pid, &svebuf, &svebufsz);
 	if (!sve) {
 		int e = errno;
@@ -191,14 +192,15 @@ static int do_parent(pid_t child)
 
 		goto error;
 	} else {
-		ksft_test_result_pass("get_sve\n");
+		ksft_test_result_pass("get_sve(FPSIMD)\n");
 	}
 
 	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
-			 "FPSIMD registers\n");
+			 "Set FPSIMD registers\n");
 	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
 		goto error;
 
+	/* Try to set a known FPSIMD state via PT_REGS_SVE */
 	fpsimd = (struct user_fpsimd_state *)((char *)sve +
 					      SVE_PT_FPSIMD_OFFSET);
 	for (i = 0; i < 32; ++i) {
@@ -219,6 +221,7 @@ static int do_parent(pid_t child)
 		goto error;
 	}
 
+	/* Zero the first SVE Z register */
 	vq = sve_vq_from_vl(sve->vl);
 
 	newsvebufsz = SVE_PT_SVE_ZREG_OFFSET(vq, 1);
@@ -245,6 +248,7 @@ static int do_parent(pid_t child)
 		goto error;
 	}
 
+	/* Try to read back the value we just set */
 	new_sve = get_sve(pid, &newsvebuf, &newsvebufsz);
 	if (!new_sve) {
 		int e = errno;
@@ -257,12 +261,13 @@ static int do_parent(pid_t child)
 	}
 
 	ksft_test_result((new_sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE,
-			 "SVE registers\n");
+			 "Get SVE registers\n");
 	if ((new_sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_SVE)
 		goto error;
 
 	dump_sve_regs(new_sve, 3, sizeof fpsimd->vregs[0]);
 
+	/* Verify that the register we set has the value we expected */
 	p = (unsigned char *)new_sve + SVE_PT_SVE_ZREG_OFFSET(vq, 1);
 	for (i = 0; i < sizeof fpsimd->vregs[0]; ++i) {
 		unsigned char expected = i;
-- 
2.20.1

