Return-Path: <linux-kselftest+bounces-16701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE37964CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A05E285B0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024D1B5ECB;
	Thu, 29 Aug 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDJi784K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E614884C;
	Thu, 29 Aug 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952025; cv=none; b=soLIKqza3ozkKfQ3hXR08WoYebms9iAimS8ENIuwGs1wyodyYiPKfIkZVjxORwrQ5TruiyYnrThaa8Uuz5pyVt9lJSVVh+CtzfWm2YB2uX5UW9iUdfacMs8WhuHwsQdMWop8bthO7mDIHiamzCYt3QttrBK2IytlKcfQ1Z8ddKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952025; c=relaxed/simple;
	bh=6LJEGZf3n3ynEEQJ10UOAZ7qPZy+uexA/5YdMequJDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j2O7FkwsXGqyN6WLDcs8WSbcO8ZWdaFWMgrKQvos9wXJl07Y5qgHEVK/nXiI+eLXQnRkWeNH7NWHEXCWhhDoOHa8uOlux9p4ehBgJkP0n37ZJ2V67M1fuOn8jVLLm7vPkZVauwq7EcKZoGy1eLWzqKPtM7b7gwp4SriM8OlTTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDJi784K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AF0C4CEC5;
	Thu, 29 Aug 2024 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952024;
	bh=6LJEGZf3n3ynEEQJ10UOAZ7qPZy+uexA/5YdMequJDE=;
	h=From:Date:Subject:To:Cc:From;
	b=DDJi784KoWoxL4fzh1R7CBaWskTrpcjj9tN9WJZk8ThMsdQ23yLyEMohc6ez1yq1g
	 RPjZS8O5Ee0OR4qDAe6otPMgAQ8UInWleQk5UGFIyJQPIkuXqFmK5vPOqZNGsgu9/D
	 qJ6QeCLzu2SNv5FC7pPgmdWbnlmrll1SinlqBh82ZMnFcDgI5s3bKpfcdzhYq2tvAn
	 iOX1EQfdl7Ij2k+ZJ7gYV27UPAyCV8HVDw6UhHH0eprMmacFW/VNeiKeICPW9v1eHT
	 PvxILET3jxwRPhwPVqlAF2w6F/WPyUX66eJ0DnMOSwy1GnIpNzRK4sgKSpP1OcvMyK
	 GqqRBd/oHYVyQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 18:20:09 +0100
Subject: [PATCH] kselftest/arm64: Actually test SME vector length changes
 via sigreturn
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-sme-signal-vl-change-test-v1-1-42d7534cb818@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMit0GYC/y2NwQqDMBAFf0X27EKaRtH+iniI9lUXNC3ZIAXx3
 w3icWCY2UkRBUqvYqeITVS+IcOjLGicfZjA8s5M1lhnGtuyj2vtWFewyhT8wtvCt5mgiUcMcOZ
 ZNVXtKVd+ER/5X4euP44TfcAS1HEAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6LJEGZf3n3ynEEQJ10UOAZ7qPZy+uexA/5YdMequJDE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm0K3UHxGEQlKEnTusD4tPnv70+x1q61heR1tT1+V2
 sNm6KjCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtCt1AAKCRAk1otyXVSH0CddB/
 4ozIaNIiTOSgiNhc3FeiWwmqMxVhHJC5k4LqFMCsAoc8TklWH+Y0Gr2ZWvVjAkz+nwc1BdXTzREvtM
 WYZM6Lu8pUHCc9qW+bfqRtPoi0KHRi6H6mjvwixAuFLRfhYgy1SQT7rSkntiXTCQHiTMNeLk5Smoms
 L9RsYEbErkaEVrkGEjFyZPL5wZt2Oren70LG5j0YY/5v5dBXBUWSuDWMjx3DfryvRUwSdctbBh4B/b
 zlzFo//7FAEOIZzaSjVlUgaMYTHtPnOuYL+pmrflViHE/l5Z/EUzCer6mOU5ppHHPLn41+kw3Q/QnE
 gt+aTtl/K2j1svEiCgN0EI1HDkzf7B
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The test case for SME vector length changes via sigreturn use a bit too
much cut'n'paste and only actually changed the SVE vector length in the
test itself. Andre's recent factoring out of the initialisation code caused
this to be exposed and the test to start failing. Fix the test to actually
cover the thing it's supposed to test.

Fixes: 4963aeb35a9e ("kselftest/arm64: signal: Add SME signal handling tests")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/fake_sigreturn_sme_change_vl.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
index cb8c051b5c8f..dfd6a2badf9f 100644
--- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
+++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
@@ -35,30 +35,30 @@ static int fake_sigreturn_ssve_change_vl(struct tdescr *td,
 {
 	size_t resv_sz, offset;
 	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
-	struct sve_context *sve;
+	struct za_context *za;
 
 	/* Get a signal context with a SME ZA frame in it */
 	if (!get_current_context(td, &sf.uc, sizeof(sf.uc)))
 		return 1;
 
 	resv_sz = GET_SF_RESV_SIZE(sf);
-	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
+	head = get_header(head, ZA_MAGIC, resv_sz, &offset);
 	if (!head) {
-		fprintf(stderr, "No SVE context\n");
+		fprintf(stderr, "No ZA context\n");
 		return 1;
 	}
 
-	if (head->size != sizeof(struct sve_context)) {
+	if (head->size != sizeof(struct za_context)) {
 		fprintf(stderr, "Register data present, aborting\n");
 		return 1;
 	}
 
-	sve = (struct sve_context *)head;
+	za = (struct za_context *)head;
 
 	/* No changes are supported; init left us at minimum VL so go to max */
 	fprintf(stderr, "Attempting to change VL from %d to %d\n",
-		sve->vl, vls[0]);
-	sve->vl = vls[0];
+		za->vl, vls[0]);
+	za->vl = vls[0];
 
 	fake_sigreturn(&sf, sizeof(sf), 0);
 

---
base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
change-id: 20240829-arm64-sme-signal-vl-change-test-cebe4035856a

Best regards,
-- 
Mark Brown <broonie@kernel.org>


