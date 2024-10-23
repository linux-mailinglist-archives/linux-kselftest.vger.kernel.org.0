Return-Path: <linux-kselftest+bounces-20511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6749AD5B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F831C22155
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94112003AC;
	Wed, 23 Oct 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dahnr0R7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B62003A8;
	Wed, 23 Oct 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715989; cv=none; b=ZQVUq7bomnm1+VaHFUIcxVPIV+nK0ZPFutA3z3Zxs076y+PgYEbK5wWtyg18sgXSdr82zFKEqk3mHDjQmQiWOjOJEtzvbC1i2AUSsUoMTBH9vPH4MhVkkjZMOcQ6faVww1fg183yc+COxtnr/3THDSnsV+URF6fVE6v5KzfBeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715989; c=relaxed/simple;
	bh=WEpX97GMGue5h7bD/Qq1020rZU1gV6I6QjnRHlLOdmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVSjWO6h0oAtUCKHBJQmk6cfUVsQ2ksIHGA6vM6PVXssypubiu8Piv+mIxbheiX+ll0aPrO0OBDvtmITd/y1AzQ17yeYiGWfqP49flrgdq7wqSsjtEFd+F6aLpH2E+sYpIwl0hGcjbgu7vINdLXMdovaOcvOt/0Hdckba8mDF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dahnr0R7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67550C4CEC6;
	Wed, 23 Oct 2024 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715989;
	bh=WEpX97GMGue5h7bD/Qq1020rZU1gV6I6QjnRHlLOdmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dahnr0R796Tfqila1uyH46kYi0NyolVV4NVVXPx6GyX+TrSMZvzYKC2IORDw91YcN
	 tKn1v2LWgFdFPtpoEwjbgjk6TcOIttCRanO+Wn1Kx9ktepzB0DLWfPn2k9kRbxHEpv
	 QVJKi4Vw2rDOt4PFgydLmUw68t6yFax8L3/qoTLFOZ8PTnT7PfbFP2Bi5t25UtJb/L
	 6DSwhJRBYZF4xpoY6+nQKd+4pjUNnGnL5IqlXi/vM6Trl54bV9JIarDJsED5Y7BdQA
	 L+46L5knrXhElA4DrTtP4mAA62AOtl3HX8KthlH7C5vPXUsyLB8HoAnyPG094zqjm1
	 RfDstiEW0BL5w==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 21:38:32 +0100
Subject: [PATCH 4/6] kselftest/arm64: Implement irritators for ZA and ZT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-stress-irritator-v1-4-a51af298d449@kernel.org>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2511; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WEpX97GMGue5h7bD/Qq1020rZU1gV6I6QjnRHlLOdmM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGV8IqFapOgWCDGYthrlNY7lK+roKfgEiszak93NR
 OziALsmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlfCAAKCRAk1otyXVSH0C8aB/
 9UFKrDED/C0Pc/AaNhAZcgAygaJXFU3+FqMiLgUTnRqeckBQB23OIdfU76q00F6+cT6wcXrddgjfVq
 MN5mRc7jPQF2rWgQEsUviDNoaRJuSk89KZDFW0vOjP0KOqSS3U6rVinrrSGwF/1S3Y2VU9mdRY7ZGY
 gtvGmm+spMMl+ImoOlbp2kwd589P2O798KVzGLyKtjt0vWyzTPzEeNBWN92SbdgYKuH2tBvd35PhEy
 hW1oGvxgsIaWSIuuik8tF7zyvh76LntL4xi+PKyt8f/uv6RFAjkr3TFONT9HaYPi8vg3r9V4EhcHsY
 pwKFhl48BWyYjvD6WHIwzrUzHfEUBP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we don't use the irritator signal in our floating point stress
tests so when we added ZA and ZT stress tests we didn't actually bother
implementing any actual action in the handlers, we just counted the signal
deliveries. In preparation for using the irritators let's implement them,
just trivially SMSTOP and SMSTART to reset all bits in the register to 0.

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


