Return-Path: <linux-kselftest+bounces-20509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34419AD5AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC6C1F24A47
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB741FF7D1;
	Wed, 23 Oct 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAwtJDup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B91D174A;
	Wed, 23 Oct 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715985; cv=none; b=saJK99LxHPHaLIS1IKPlBr5igmw+eLL1U3PC7WjVUshQoc8fLao7GiNcQu1h/UuVhGufK57g9ZjNDVkXwQDCEPHAna2SopDTGtKH3UYvZ4JrkOHQbGiMXMEMlHuv7KsisTjUJSFZRgFFXuf9I8iV4BKjv9PhTdUdqyt0B9ffh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715985; c=relaxed/simple;
	bh=A0xCV0/PSvevUax4GW3txbWNtrgIm8u+5XUscwTPb/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oj7IFgI8m0xmJOYuy1iIhS8CdaajPL1Cm/5E94dz5WNegZmRHdY3VkPbeO5GSLjfF/sCI0Imr34+mavP7bb/HhpiQo7t8MMbyxMCFE+JrAZ9TkR+/F1qwFCLyqzwbSh3HuxWDWh7JQN2MuSCp6ot4BSwkTtN5XNhD99jMutYMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAwtJDup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5059FC4CEC6;
	Wed, 23 Oct 2024 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715984;
	bh=A0xCV0/PSvevUax4GW3txbWNtrgIm8u+5XUscwTPb/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GAwtJDupEyWOB3uuEGnaulVAgHAukMaigDlXwBOK/DK5UrHfJ04dEZpVvJHQru2Qy
	 JrS5jofMrUiccO3pL9n/A1HbMCNpFQZu7kJB7vTz9jFTDJeKrSMixnsZjGMv5K8F5j
	 8o0Cm+wWK3/vWiXr3Lk517Pj0ZnMxFKr8mqOqkBshm8KKT7FQ2R886EIxX2CUBNGWy
	 Af5kJM+fDzNbajd4GJBWYbPOH3FlHqUACAKwyzCzwopBR7RuwHlKwqfGMPnBnZ1awS
	 21nOuSbDKCG658SpD7ksW1KQgN6qI/rCUZ9/fOJvIrXZNNoMWebYdglt+RJDLFqYui
	 zZnGVTJPu+Tew==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 21:38:30 +0100
Subject: [PATCH 2/6] kselftest/arm64: Remove unused ADRs from irritator
 handlers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-stress-irritator-v1-2-a51af298d449@kernel.org>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A0xCV0/PSvevUax4GW3txbWNtrgIm8u+5XUscwTPb/o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGV8HpM2/QKONGuDoJRvv7T//ECB/Hh6Fht25u/wh
 bXTfT0eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlfBwAKCRAk1otyXVSH0KM5B/
 0WNMHqxiKcGxbpdzPHNYqwJzUbmWOTTHmbNlhyehRneGnNCvkwuaW7HSPHCncZK3WuJu5ZxGujaDbw
 hSX3xomF3kvFN++b6sLJvowe3lgwXeadwd8NRAuKuFwZNRaJlrwqSRfpGeNZRvPd9zAnJBQE52CL5J
 1DKNnlI1y7uAhieuL2aGoWQBzrxvBLn7c5myKCEeQYuE9V9Ub3XhU04rUkoFjK05ZcQTDtf1lBtTLd
 qyFgwUAUizrgXECgz93ffnB7ED86olrhWBFQxWwR7YJAxQe6UnLhbfCZ0CEeQNDudd0Nba+KzNwiBu
 Oz6gHCXYVR5zI+JUGijriZuillOYAZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The irritator handlers for the fp-stress test programs all use ADR to load
an address into x0 which is then not referenced. Remove these ADRs as they
just cause confusion.

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


