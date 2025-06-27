Return-Path: <linux-kselftest+bounces-35990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45FAEBE68
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5DA17EDEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718F2EBBBE;
	Fri, 27 Jun 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkF1UUJ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551392EBBA8;
	Fri, 27 Jun 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751045116; cv=none; b=UQrOeNJXoWkDxMhZHVOJvzoj3ZnxCkTgtU16RqoPNANqRb3eLe1gVgn6a3gwI2lYzezelqAbrwC5GFsy0Fqwncu+5YKebmSXoquYdMfbeNnDbFqgMXfEHChtX/LnnVLyxj0piuZwvMjLkJwBeK1U6erVWZgN4qY20nQCZQIJUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751045116; c=relaxed/simple;
	bh=lH2UPYp6QCoEhr4YOD4G34RicJOUqUNXtxpfpE/H2hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hX0V6KxvJ9zhWAY348ZJjaJZ+pTyH5T3WTaWIFX/6xTPYnW4r14IoPVJHYwj4sJ2eeySlEwLx42CkOeOe089Pn7qUMk9H7oTzzz8NolRhJk7Mqz8ptiZoVpCHMNA8vsd68GM+6kAm5mskSmyhPEzxl3+gVDuQXi6CgtC+G3wffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkF1UUJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD342C4CEF1;
	Fri, 27 Jun 2025 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751045116;
	bh=lH2UPYp6QCoEhr4YOD4G34RicJOUqUNXtxpfpE/H2hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mkF1UUJ/jF5LyPnV9B8BJwjRIGHIl8zLQkLQBsrWZKEGb8SBkvLa8jRSNa6qgMQZv
	 pBIIc0622B0Gw2SQ6vVqwWr6289TmMZxjXrA8ZuvvVzIZhVCUMnvrUrlfjbx7S2d+2
	 AXYocZpqY0qZ4cr1S1ADPeQtAkLpSFYRyS054D8waAKCBQtXM7w5snKxUdq/J/bWAc
	 GsCeURDU6QpyBmLMKdN5n8+cWrLRckFu5MeZCXfBXDFkAMZM+jE6/HIzfm6LHdJJhE
	 6k079+yJOD0zdKdDxb6RqMnUbktSjcbBjN9KoxQR+yJHbShOXQ9kkzSSDort40GUxK
	 9++ZdvO+uSIrg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 27 Jun 2025 18:20:46 +0100
Subject: [PATCH 3/3] kselftest/arm64: Add lsfe to the hwcaps test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-arm64-lsfe-v1-3-68351c4bf741@kernel.org>
References: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
In-Reply-To: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lH2UPYp6QCoEhr4YOD4G34RicJOUqUNXtxpfpE/H2hQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoXtPvHdrwxtM6K55h9ibmBPuatpZ0f6ZPAQ+ii
 cvW6CW1ddaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaF7T7wAKCRAk1otyXVSH
 0IQKB/0TOvdgLavdQtvO6QYDy5rzRWcJ2bv8jmEwtiA6ZLIXdyI8DSOJnxX6gJP6juqegfqPfTz
 iLvcK7uYQGzTs868wXkYC1LgUVJMX0f3gKSX0wJ6p8cGOduRvD5ZO3MB0ve0CdNP4hgxvaxM2ov
 Mdv05y+jtfzgNxJht4TI3X4PXwstUNqvphKdetij0jZiV/m+t5l6gLmYbkAJEoAz3kf+p0hkT8k
 Z9D17eNlB5ptmsmq13v1Qlnz9ya3zr1irOCD5nTMjkpRLXucuLLcrOCmKiwV0a8T7ZApbNJbXsR
 CHp5ZsrGCMS5LRNT1pH78PzHtRSp4Fpsr4huWOw/79Rkf+LD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This feature has no traps associated with it so the SIGILL is not reliable.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 35f521e5f41c..9dfca2eb7c41 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -17,6 +17,8 @@
 #include <asm/sigcontext.h>
 #include <asm/unistd.h>
 
+#include <linux/auxvec.h>
+
 #include "../../kselftest.h"
 
 #define TESTS_PER_HWCAP 3
@@ -165,6 +167,18 @@ static void lse128_sigill(void)
 		     : "cc", "memory");
 }
 
+static void lsfe_sigill(void)
+{
+	float __attribute__ ((aligned (16))) mem = 0;
+	register float *memp asm ("x0") = &mem;
+
+	/* LDFADD H0, H0, [X0] */
+	asm volatile(".inst 0x7c600000"
+		     : "+r" (memp)
+		     :
+		     : "cc", "memory");
+}
+
 static void lut_sigill(void)
 {
 	/* LUTI2 V0.16B, { V0.16B }, V[0] */
@@ -758,6 +772,13 @@ static const struct hwcap_data {
 		.cpuinfo = "lse128",
 		.sigill_fn = lse128_sigill,
 	},
+	{
+		.name = "LSFE",
+		.at_hwcap = AT_HWCAP3,
+		.hwcap_bit = HWCAP3_LSFE,
+		.cpuinfo = "lsfe",
+		.sigill_fn = lsfe_sigill,
+	},
 	{
 		.name = "LUT",
 		.at_hwcap = AT_HWCAP2,

-- 
2.39.5


