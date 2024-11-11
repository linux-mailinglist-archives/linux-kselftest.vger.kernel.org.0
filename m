Return-Path: <linux-kselftest+bounces-21790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FB9C427E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45C91F22CB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A41A2C32;
	Mon, 11 Nov 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpSfi6sz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1821A2C27;
	Mon, 11 Nov 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341955; cv=none; b=tk/Kd0H96F4otE28wcOXWHNVOVeMskX1T8w5avrLfyZwkZctsKdS2gmW0Ge68RtoHfYMUw0uikCZw4qifeN3HtKGid23kfjGw24ikQ9N4+NTq0jTHImU/ccXVN/X6UZnkuykTnAlbhSg1K2EG+rrPlQ2a2dL+gXSVCeEE7vUCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341955; c=relaxed/simple;
	bh=9cyh4O1U5G+quhH4mm627kHtyNUEPP2A3/N1m265/l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUNG5E4e2qn55mPBny+chH+92wwd6F5b0kBjsYv4NhebuFvA4B4YMR68+Q/tDxKcfRQuklOC1h6Njr5Q6RAhmhjgUFSCyEIrx3su/sJVEJe8oWcz9nuaA9V+pToBZmP3GcFceKCvxuGUmlXrPV+TgP67nUfQBL5iLtnt9XoJdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpSfi6sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447E2C4CECF;
	Mon, 11 Nov 2024 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731341954;
	bh=9cyh4O1U5G+quhH4mm627kHtyNUEPP2A3/N1m265/l0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tpSfi6szIGQ1/P2NbGmmPURdONHXrmQaS9FJkjZMRxZ7vbHzW9P9Hh92+qyymxFRU
	 1Zlq6opK8+hZXuSV6JjAtF3CHplmd0/unNlCDiMJxl5+tkDIEu2RI0gnBNzJ1N0Goz
	 Hw6kjk+Es6SBhrqjTbt8vPCpXMA/AWxPzOZLXi86rQK/ZsZiba9Hlr+dteUU4kJ06V
	 q7CqD6O1l/tTWzxA9HWWsas65z9EXcsJbEJI4lYrew0+276563iAO6JA43dH8yIEmx
	 mf347ya6V6+XeJYu9wuBJeVaXDCN/FhaFNbi5Cv7q6VCpijvRBC5204OkVHLZZWiGJ
	 UWh4W7syExE1w==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 16:18:56 +0000
Subject: [PATCH 2/2] kselftest/arm64: Try harder to generate different keys
 during PAC tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-arm64-pac-test-collisions-v1-2-171875f37e44@kernel.org>
References: <20241111-arm64-pac-test-collisions-v1-0-171875f37e44@kernel.org>
In-Reply-To: <20241111-arm64-pac-test-collisions-v1-0-171875f37e44@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9cyh4O1U5G+quhH4mm627kHtyNUEPP2A3/N1m265/l0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMi58jgwmS4v3ef00rmDIKXGflINOqMihqygBt
 HmqWBC0ANOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzIufAAKCRAk1otyXVSH
 0MxSB/9AzHa5kOicOsY4cAV412rEHAWT2qZEK1xKi3h/eENhxz0LC++OwfzN3D+SFWY8xxbmRdP
 FNiPlPn/9sD7F2XmUNIlczNn48rMwO5c/JIpIY48bPUklBJl/3rwFR8B33Pnsg5mkUQK1v5pljM
 D7tMSYDtUIPq49oH6kzc6lcqEFCHdfP9hR4prgpansGchCYkGcP43WBAz4DY71UcwFn5tX0/x6C
 ll3N5dAgB/OZaiuuSdB1PUnGCy9szdE1N0cg5fDSXq5m8ReqyHAxlPdMFtChsnMJMY/rr3Tw7Do
 91GDxAt+g9NgTmRnXykAjANxDYmOTTHxBzVVuuoZGnT+zdrM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We very intermittently see failures in the single_thread_different_keys
PAC test. As noted in the comment in the test the PAC field can be quite
narrow so there is a chance of collisions even with different keys with a
chance of 5% for 7 bit keys, and the potential for narrower keys. The test
tries to avoid this by running repeatedly, but only tries 10 times which
even with a 5% chance of collisions isn't enough.

Increase the number of times we attempt to look for collisions by a factor
of 100, this also affects other tests which are following a similar pattern
with running the test repeatedly and either don't care like with
pac_instruction_not_nop or potentially have the same issue like
exec_sign_all.

The PAC tests are very fast, running in a second or two even in emulation,
so the 100x increased cost is mildly irritating but not a huge issue. The
bulk of the overhead is in the exec_sign_all test which does a fork() and
exec() per iteration.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/pauth/pac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index 5a07b3958fbf292b09c9d6b11b8f9db2880beeed..6d21b2fc758d80d0cd7d0db2859de3b308522cb4 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -13,7 +13,7 @@
 #include "../../kselftest_harness.h"
 #include "helper.h"
 
-#define PAC_COLLISION_ATTEMPTS 10
+#define PAC_COLLISION_ATTEMPTS 1000
 /*
  * The kernel sets TBID by default. So bits 55 and above should remain
  * untouched no matter what.

-- 
2.39.5


