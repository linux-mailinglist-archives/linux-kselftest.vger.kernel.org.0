Return-Path: <linux-kselftest+bounces-33656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E563AC2672
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501BB7B6710
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2C296158;
	Fri, 23 May 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf/wEcGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14E29614A;
	Fri, 23 May 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014094; cv=none; b=I89wN4QS6OKY/Nur0Om3ldbeov47Lp1Q1Km+WC5BTcTb+DbujLUP+eP4RhW3psyXetLzMWpbhjRqpZLHSCXSqUBfG+QLcyhSEOmIFlBYIZ4O2gkgzly+V/3LyPoLt7zlDHii7TN0zN6Z0E5/aXzvMoR6WPSFQ1kBGJdzdtJegMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014094; c=relaxed/simple;
	bh=gfmQZEjvd5HDHLmuHnVwJuVoa1j8dMgiHvo8VziUUs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPyDWtuLrQsagp96S/dqRzD4C/qVbS+slaS7NSajR/UKAN3IOqWxwIVnVfT89vzRmUAwwivdfrPKA+tnLzy/C5ZUYafs1wC/w43cUAzFTd6H4N/svIXL+idGPtoljdZ9hVRZ/OBu4cqrCjDfwLvjfHmIKug5xj+ONl9LskqMlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf/wEcGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F091C4CEED;
	Fri, 23 May 2025 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748014094;
	bh=gfmQZEjvd5HDHLmuHnVwJuVoa1j8dMgiHvo8VziUUs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pf/wEcGacg2Vgw6XMePyL405X3aefzruhm4/UySrnPZbDlXZqybrLYOFIRU47imdi
	 vjD4UwT1IPRuzjiAUpzgImy6oXIgQwfpSZsaYkw0HL92ijaNvheknGdOyDIICxbsjI
	 SRV3klq+L1lef3hdoOFW2raDwIdVuoIx33HOro3sz4rex4JFEsrJbyJ+VyyH8roIy5
	 rSxK9N6GeIQMgDwiKnJhwYqYEGv93yRV12F32Ttwy4cF8/7Wn2JfAONzWBMlmv4f4a
	 zNKoIZvHnkpk2gY6dplt/NlENresmWStvI+QlwfnODXAiO57je7/lEq5019CQCxF+4
	 J3KSzJ2Wp/jpw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 23 May 2025 16:27:13 +0100
Subject: [PATCH 2/3] kselftest/arm64: Fix test for streaming FPSIMD write
 in sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-kselftest-arm64-ssve-fixups-v1-2-65069a263b21@kernel.org>
References: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
In-Reply-To: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gfmQZEjvd5HDHLmuHnVwJuVoa1j8dMgiHvo8VziUUs8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoMJQFKaEAwlOR1pLqNxibuEg3VMGRQcEX4bDOI
 WshDoApkV6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDCUBQAKCRAk1otyXVSH
 0MuzB/0Z1E+Hyy1unXqqQ8fqpfMYEtTcmEmi/TRWvmVFbMWb8AryOXP3nKbmK0NuWBQDrNZehEz
 Woy/IzjB/XJB4mTdolQGZnkIyp7dUEp9zOcIZRHC/cljhN0L7O3iVy8nym894A4SOqPnBAXQuGI
 vbtRt+wESIXvqublxp1pvF4hXI5nFiXZ1a/bVh3BFDkOVEMdyrQwzw+6PBFqLMqbtjPQVkKO674
 /c/7HGV895d4rbxsH2b0LfhRENXPCd4GGLMhrCE15H1gV7sgUcs22/3MGHyvEU6OwtKSu6A9usF
 j/ldCL5FOIrz5mnZCmck+O//MaIAydBf92S436aad6tlnZ6n
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since f916dd32a943 ("arm64/fpsimd: ptrace: Mandate SVE payload for
streaming-mode state") we do not support writing FPSIMD payload data when
writing NT_ARM_SSVE but the sve-ptrace test has an explicit test for
this being supported which was not updated to reflect the new behaviour.
Fix the test to expect a failure when writing FPSIMD data to the
streaming mode register set.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index c499d5789dd5..7e259907805b 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -301,8 +301,10 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 			p[j] = j;
 	}
 
+	/* This should only succeed for SVE */
 	ret = set_sve(child, type, sve);
-	ksft_test_result(ret == 0, "%s FPSIMD set via SVE: %d\n",
+	ksft_test_result((type->regset == NT_ARM_SVE) == (ret == 0),
+			 "%s FPSIMD set via SVE: %d\n",
 			 type->name, ret);
 	if (ret)
 		goto out;

-- 
2.39.5


