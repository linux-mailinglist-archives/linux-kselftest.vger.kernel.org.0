Return-Path: <linux-kselftest+bounces-23133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0189EC141
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BAB282FB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B335815A858;
	Wed, 11 Dec 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXs6NC4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820891494CC;
	Wed, 11 Dec 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879071; cv=none; b=DGKhxN/oLX1397C3hsLh4jy2XONRxJ1bcfX2MioiAbbCUuLQJLNncowLRMCovfspUasBOzFUkb+H108n901q5zO+gxCQpkjfo0Alv5Tnmz+nAFMvKMJEZSlfcUN32Jo4XtgHvyUa9Shnj4qn8aqF8y83BG84c46IC7nWzD1ZJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879071; c=relaxed/simple;
	bh=+YQiNGxuReZbhRyHsK58fKXnEHlrUTfoqeBLUdyrvis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjBLTNqG4i+p3oab1J+4LqxxZ9brqhyZ7/vL3unw0sMaA+zfxHohZJyV2L/ESAAE6VrzjSbfD7tj1cT9mNNkTDexI4xe9XOwmg09LIgP5DFJNcecn/EjMmNve2kvI4crByhLi4QtfHoLi46Z8+S1XIGsEZtDcK/tZduARGKqicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXs6NC4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC8FC4CEDF;
	Wed, 11 Dec 2024 01:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879071;
	bh=+YQiNGxuReZbhRyHsK58fKXnEHlrUTfoqeBLUdyrvis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YXs6NC4+lw95Qtea2tDdeLyYZjrmzDf7dE0QQBYikfky4j9y2GANmtaw8gty4xY6c
	 QtgUSU7EM6rbJWWA3gIGOl+Q9n4yMFa9VZ6HxJ/uxc4uczU3zyLn9DyzyDS0p80dAS
	 R2Xk9/rkpCTNOXVRQwfGr1LbqhJt1kBH9fIl5CQLGLqlhxYJme+Lphlcsv90zBHAek
	 4hePp9W79W/EeNQbUBRUyhrQT/iAxH2fq2nNvbB3VKwJjXmC5Zgbd3xKjDsAYBjHiW
	 OKkWco9WWQRR8C3480D+D/3FzI7a3szGoGkVxsPDYJ1cGTe/VFy9C0F8tG8czcwLUY
	 YTGeDr7G2WMrA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:02:47 +0000
Subject: [PATCH v4 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-2024-dpisa-v4-2-0fd403876df2@kernel.org>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
In-Reply-To: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+YQiNGxuReZbhRyHsK58fKXnEHlrUTfoqeBLUdyrvis=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOUQ80C4Zub4NZs2VfYDJhImH82ICyjvpEDJbvB7
 SG7v4NSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlEAAKCRAk1otyXVSH0EC6B/
 0RFPGutI+vIH8jF5EGtW53cB1rpdiueDzb2YaCdcmLCEeHrVcXPhy9KfpTuHIs8/8yAdMarcNbH1nJ
 33zwvJ/vpMdTP4n8uUAo4U0vnlYBf5QsoVaHrbzwYsG34N6BtnZsQoNG0upCM8xWMzAeClowxv6aWM
 K7W7JKC7GIj2sZOGIpIYXJdDLIr3eocL//sF1KCGQYqvQHMyi8vc6j4YlEtjr0Ler+zemOhnr98vs/
 FV9AFIl8uA8hQfiV4d+sGXE5rb9aKRH6RRxxitYpq1mLAcf1Zlsm1q+Bg6Ia5x6DleEHtoBa46iKd0
 pVEadGgrT5qQjFTf9HSWqdyo9MMqB9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines several new feature flags in ID_AA64ISAR3_EL1,
update our description in sysreg to reflect these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 911f16c82ebd3ee98ffed965b02a5c6b153bc50c..6273068fd4fdef145cb7dd49e2d9bee4db467975 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1566,7 +1566,23 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
-Res0	63:16
+Res0	63:32
+UnsignedEnum	31:28	FPRCVT
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	27:24	LSUI
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	23:20	OCCMO
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	19:16	LSFE
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	15:12	PACM
 	0b0000	NI
 	0b0001	TRIVIAL_IMP

-- 
2.39.5


