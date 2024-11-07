Return-Path: <linux-kselftest+bounces-21583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A12959BFBDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587811F22B01
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2715B0F2;
	Thu,  7 Nov 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoGAVFaM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67996155398;
	Thu,  7 Nov 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943838; cv=none; b=A5HM0BfzDfHSEvQNsdR3fm3AH5Zw2BiIv8PFsIt9cD55iDWBu5sXjBUM3bvAH24PMRqMx3m10iJ1MDuTcppJnOOZgDPYj2rYourokaWrLBLi6Yd7gFk+1hwPPPYD3asbQ8WZRv9KNyqzjQ/KtXy65d9nk/UMDcX2Qif7VAgq0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943838; c=relaxed/simple;
	bh=UoJTq/4nL7BvDS6uY/r24/IvWcAW7qJlvfXTsku1iBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLZWYrXl3cLJn20SLKrPXRfo3zwHRQHRFEv8lYRC8ecDkkvMWfIgs6y3K+AJ4Wbs1k1/YtJpAXLZmx+gTka35nvtA9VE6oyEhEOeFpPqNGLFMPnzbRb4zWKL/9JpzszoErgFn2fRWo/wHte334c14r1mD46WdIYdDJYwy+8xs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoGAVFaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C76C4CED3;
	Thu,  7 Nov 2024 01:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943838;
	bh=UoJTq/4nL7BvDS6uY/r24/IvWcAW7qJlvfXTsku1iBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JoGAVFaMtyTqLWfIgNr/IR1H96/1i3JXJuY1GBIIhGy/MSX8l0z2eMmOBuO+vEchH
	 XW3dC68fRE0dOb9WdFfGmPTbBPCyctuR1/2OiSz+9Ci9bKIVgivsauXlYRbYGvOQQU
	 t5hgPhXjvQtcFGBj6e+RuRYMSqa4/3Yb0Tj8mNQIyuYDUtu88A8/KWta9+IbHc7HcT
	 SNsjwZAmaG1xwVEih+yu/ebwYh+SwgiAlANhJ9mLnCP5IQZ4uSm2iCw1NzPcFssxcO
	 ccoYPDLBaX6GKL7xFL1HRRss4zU8P5K45fnIqAnLdBwBy8usY/7Hpaq3luJUcHieyU
	 tfemnMhet+hKA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:39:23 +0000
Subject: [PATCH v2 4/6] kselftest/arm64: Implement irritators for ZA and ZT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-stress-irritator-v2-4-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UoJTq/4nL7BvDS6uY/r24/IvWcAW7qJlvfXTsku1iBE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBtSwoIBhD3y9ti90AkhESfq9btN6AviJzAkJBpX
 JMLOoZCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywbUgAKCRAk1otyXVSH0PY7B/
 4pynI9BeZ8ypvO8mQZDFKRkRl06pvwb0CZjNnHowWK4SQFeZQ69MZ1Bn2LD87oQiKDerIG6YmzQh6L
 tYGa+qzUGMOxhhVpXX1nEE2AA8/4cOVbjG1gjo0LnDtl53wdeI12qPSO7UOSc17WgfHJLVf7AA8S0q
 E8C7T6gnyfhtT/RPLB6k6+x7S76ra+U4yvVGGnuO9EjcByDdHdKrIz/7BEg8l7vmWbb+Hv0x8PXvke
 0S9JnXkgAeIrTH7X47McaV+BsgXHXI4PEhw40BJI6TKGhIB+gR8rpiLifeHX+mHuhL8dZiQ5YW9fzI
 V8CA8bt3/idVoZ+zcv6yZe6ckghDjl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we don't use the irritator signal in our floating point stress
tests so when we added ZA and ZT stress tests we didn't actually bother
implementing any actual action in the handlers, we just counted the signal
deliveries. In preparation for using the irritators let's implement them,
just trivially SMSTOP and SMSTART to reset all bits in the register to 0.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/za-test.S | 12 ++++--------
 tools/testing/selftests/arm64/fp/zt-test.S | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 1ee0ec36766d2bef92aff50a002813e76e22963c..f902e6ef9077bfa34fa7f85ce572ce3df4346789 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -148,20 +148,16 @@ function check_za
 	b	memcmp
 endfunction
 
-// Any SME register modified here can cause corruption in the main
-// thread -- but *only* the locations modified here.
+// Modify the live SME register state, signal return will undo our changes
 function irritator_handler
 	// Increment the irritation signal count (x23):
 	ldr	x0, [x2, #ucontext_regs + 8 * 23]
 	add	x0, x0, #1
 	str	x0, [x2, #ucontext_regs + 8 * 23]
 
-	// Corrupt some random ZA data
-#if 0
-	movi	v0.8b, #1
-	movi	v9.16b, #2
-	movi	v31.8b, #3
-#endif
+	// This will reset ZA to all bits 0
+	smstop
+	smstart
 
 	ret
 endfunction
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index ade9c98abcdafc2755ef4796670566d99e919e5c..c96cb7c2ad4b406c54099fe3f73917259bd947e4 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -117,20 +117,16 @@ function check_zt
 	b	memcmp
 endfunction
 
-// Any SME register modified here can cause corruption in the main
-// thread -- but *only* the locations modified here.
+// Modify the live SME register state, signal return will undo our changes
 function irritator_handler
 	// Increment the irritation signal count (x23):
 	ldr	x0, [x2, #ucontext_regs + 8 * 23]
 	add	x0, x0, #1
 	str	x0, [x2, #ucontext_regs + 8 * 23]
 
-	// Corrupt some random ZT data
-#if 0
-	movi	v0.8b, #1
-	movi	v9.16b, #2
-	movi	v31.8b, #3
-#endif
+	// This will reset ZT to all bits 0
+	smstop
+	smstart
 
 	ret
 endfunction

-- 
2.39.2


