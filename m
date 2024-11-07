Return-Path: <linux-kselftest+bounces-21581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A760E9BFBD9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92541C2138E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260C7DA95;
	Thu,  7 Nov 2024 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc+QEMKH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A878C91;
	Thu,  7 Nov 2024 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943834; cv=none; b=kRl1GQVIReeOt1ErsIH1JeGhI1vSYZZU9Y6lwQqmQxtJHKeYu5aDjaqFyHQveJM0h1VXREQ89q+JauHjLJhZDBPCV8AM4gY9TsdmrZrPQCkOzxu3LrKMg/yhVqRtrIwuMdZZnWpPaLAEdQnCLsnX+S+ObRnXP8r65hZjQ1ypGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943834; c=relaxed/simple;
	bh=pztdj+ZQ+nZ7pOduVmqycF1CMI4X4Tvlwsap3wvNFRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGrNiYX3lZ079rYbELwG0DE7mv9OMkpAUHjkDpMCln7Mt2DRhXvXtKl1Vm5QtCwtUjtZgP2N/PGnhTZOYIkDwg5WQGxmT7OiGokIA/yCqkF6kBVBqVb/oyyJZcIs3/XmMBUbgtNkGCGV/PpE/JHRXIHRsnyUvNIt8c9fKvHqKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc+QEMKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2980C4CEC6;
	Thu,  7 Nov 2024 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943834;
	bh=pztdj+ZQ+nZ7pOduVmqycF1CMI4X4Tvlwsap3wvNFRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oc+QEMKHU7cbG/RYFDdqKaWXES/WEKu10yV5Iul6hLPPPTLWiRslUB2L06v3iq7zr
	 HoVNs9Y8/UOuZPRSUaiT2/xD47sfdKaR/z1M9VMCLK8fCx+ILNlmguP+EGRxQyz9ak
	 0UN5NYv2qPruR9YSVUSHMKJ2wW26eMMnocEGe9M6Lw2alYRRMdGMHMeirfEh07vdS8
	 5ON1GmoXGhVxvvvPMwHfkc9xtoQfyoDfQE2WMY8vok59QuulrrR1DkQGLZUHmSIoic
	 14hhGFXKT914pLGwPGNmj9d5dRq/YUdshqPZK8uGcdWCQ3nnBX+8Xb7nwERJgTw4NS
	 /QNo02PWQrOEg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:39:21 +0000
Subject: [PATCH v2 2/6] kselftest/arm64: Remove unused ADRs from irritator
 handlers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-stress-irritator-v2-2-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pztdj+ZQ+nZ7pOduVmqycF1CMI4X4Tvlwsap3wvNFRg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBtQXEOcLYz6Ymz/L4TdCASUU/sNqoWsRJpykR6Z
 kTRk5l+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywbUAAKCRAk1otyXVSH0PYwB/
 4l4i+l+21+Q7gIu9w2FF+H8asSmEscEiVklMw1AHhwNlzuWQ8cF1nEfeIf5vYFpbEakZsgDeEZWQeR
 AxAiY+xOXYg1HFw113F3OHX46sgc5qf+Lnmbi1oO7kUy76Bu7F/WwDvF/gGX72ItO9BTQkj1n95vCt
 12T/S2MKUiqaEOF/rXX07ehlOs9+cj/dBqXyvrv2Z1xRauxMpIwANsDYhJUtYEApfosvOdprj0Ayxr
 dqx5ouw13YOwbhMyCN1Y+RGsZlbeAfPA46AWnGjg0zvF322CJttDB3PGXeB53GBVYvggpdLeTPxHVL
 PDWXh9J01KcLIG+nP9N4WoD4HaJlWT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The irritator handlers for the fp-stress test programs all use ADR to load
an address into x0 which is then not referenced. Remove these ADRs as they
just cause confusion.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fpsimd-test.S | 1 -
 tools/testing/selftests/arm64/fp/sve-test.S    | 1 -
 tools/testing/selftests/arm64/fp/za-test.S     | 1 -
 tools/testing/selftests/arm64/fp/zt-test.S     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index bdfb7cf2e4ec175fda62c1c2f38c6ebb1a1c48bf..9977ffdd758a51a7af67cd607d019a6c54d3a6c6 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -142,7 +142,6 @@ function irritator_handler
 	str	x0, [x2, #ucontext_regs + 8 * 23]
 
 	// Corrupt some random V-regs
-	adr	x0, .text + (irritator_handler - .text) / 16 * 16
 	movi	v0.8b, #7
 	movi	v9.16b, #9
 	movi	v31.8b, #31
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index e3c0d585684df29723a49265f3df6d23817498c7..f1fb9745c681786f686f1fafcb7e1154f3c8e1a3 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -299,7 +299,6 @@ function irritator_handler
 	str	x0, [x2, #ucontext_regs + 8 * 23]
 
 	// Corrupt some random Z-regs
-	adr	x0, .text + (irritator_handler - .text) / 16 * 16
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 095b45531640966e685408057c08ada67e68998b..1ee0ec36766d2bef92aff50a002813e76e22963c 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -158,7 +158,6 @@ function irritator_handler
 
 	// Corrupt some random ZA data
 #if 0
-	adr	x0, .text + (irritator_handler - .text) / 16 * 16
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index b5c81e81a37946c1bffe810568855939e9ceb08e..ade9c98abcdafc2755ef4796670566d99e919e5c 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -127,7 +127,6 @@ function irritator_handler
 
 	// Corrupt some random ZT data
 #if 0
-	adr	x0, .text + (irritator_handler - .text) / 16 * 16
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3

-- 
2.39.2


