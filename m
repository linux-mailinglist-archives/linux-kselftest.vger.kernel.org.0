Return-Path: <linux-kselftest+bounces-478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342747F5CC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 11:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F351C20DC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E221352;
	Thu, 23 Nov 2023 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTcTIJoo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C3184C
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59BEC433C9;
	Thu, 23 Nov 2023 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700736365;
	bh=a/0xnzSEqDgdkmB+Ou/rO19RkkJCDKLmNeBwmcdoHhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rTcTIJooVID1Ib9olpdj+20mPww9uC5zCmFqFdKXWqeKxQuvxgx6dKoAgRe3lHfCR
	 7dC92JTY4NK32pEqTbrOELXoFoj+zS3Z7bVUStw8som5F5AcstvYDPkk+4uoa2DIY1
	 fbCWe+UuWopz6Vys3o0xAVK/Dz32QA5x+8CQrLVVklKhPU5/MEjZFOkHyoOXjkQuOn
	 wkW3i4YGsdCyB9f63Vk6W9InIBl+jr/n4xf6n9FrOXnef2RvZlL5npifrN7fNRv1LP
	 P1GdAqJ6L9tVUuYL7yBV97rA78QP8rosb3cU/nU/QSOhV8iJyFHKSVlrnmMV3/98EH
	 9v912jBT6pICA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 23 Nov 2023 10:45:49 +0000
Subject: [PATCH 3/3] kselftest/vDSO: Use ksft_print_msg() rather than
 printf in vdso_test_abi
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-kselftest-vdso-test-name-v1-3-1b30441c422b@kernel.org>
References: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
In-Reply-To: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a/0xnzSEqDgdkmB+Ou/rO19RkkJCDKLmNeBwmcdoHhE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXy1lMTced+NcgUkIpAhxxJ8e7HZk4MO0yZjrl
 pFql9Ib0p+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV8tZQAKCRAk1otyXVSH
 0M9NB/sGRJU2UFvPA5r3mlI2dzt36kaovzgfbklY1UeNZUS1bz59nT74Klk6v1p5k8ywH5yK9k4
 7eKdQ2qtaN+jq3CrJRNjLGRB1qnyjsHJ41AW4NiVBKon9a+SO4Qwzoq5RysgwB4daRolPJm7hhy
 i4MLgKHoZTecqDfl9LFQiAjJcwqGJOCvsF/SztCgQtqZ9hsQpnzl1QFNrYr5PG2gPiespvk+zoW
 KZzovK79wUE1VKgxXcSXpCklw4gkRAma7HMu9PUCed05bx8/g/+9So8LqZRrXLh0ikZl0H7JJGR
 I7llYuwE/vRrsTWXTl4wk0i1TCk0M+WzB8zk9usW2N38PPuc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are a couple of raw printf() calls in vdso_test_abi which result in
non KTAP conforment output such as

   [vDSO kselftest] VDSO_VERSION: LINUX_2.6

Convert them to use ksft_print_msg() so that they don't cause confusion for
parsers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index d0e247cca58a..96d32fd65b42 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -187,14 +187,14 @@ int main(int argc, char **argv)
 	ksft_set_plan(VDSO_TEST_PLAN);
 
 	if (!sysinfo_ehdr) {
-		printf("AT_SYSINFO_EHDR is not present!\n");
+		ksft_print_msg("AT_SYSINFO_EHDR is not present!\n");
 		return KSFT_SKIP;
 	}
 
 	version = versions[VDSO_VERSION];
 	name = (const char **)&names[VDSO_NAMES];
 
-	printf("[vDSO kselftest] VDSO_VERSION: %s\n", version);
+	ksft_print_msg("[vDSO kselftest] VDSO_VERSION: %s\n", version);
 
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
 

-- 
2.39.2


