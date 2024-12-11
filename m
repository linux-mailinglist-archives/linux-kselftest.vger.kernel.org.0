Return-Path: <linux-kselftest+bounces-23137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF29EC14C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E475A163F8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C61A1A4F22;
	Wed, 11 Dec 2024 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJIzxGO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9271A2643;
	Wed, 11 Dec 2024 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879083; cv=none; b=JyoU7tue8KHpX/Z2JqNiuhNKMB9+3K3AFahCemxUYGLBdLbMw8bCRcDVpHa1gluohPAHW6AaIX+fN7tNvC6dqb0mKCdRF9hO9tRJR8qzyfAYRilSB2q/5CP8wFy69pStnLWpyMR2O4q21E8N7yzqvWJ+N/SxxzpXh9Hn1aUt6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879083; c=relaxed/simple;
	bh=TIHTphWBuVOkUDtoZBC1frDZIcBdWo09SQC7mFjqspw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svlpULQgCzPDjfgibtd6VxnZnkJyZdjufgNCr269MaBeIxVd51H23fCDdpHeyb4xdS01GCQmMN0Qv1hMpz5NP3kMT336Q/qKkj61fveJNmkQV16WQb0rlKjegPnATg0EbROYHPy4MtRjpiHTIvsWzJ8sHZBy91yGuw1gINu/IwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJIzxGO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D76FC4CEDE;
	Wed, 11 Dec 2024 01:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879082;
	bh=TIHTphWBuVOkUDtoZBC1frDZIcBdWo09SQC7mFjqspw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RJIzxGO9ObOgo4oihtpBf38kU5wUdj9l4zW3P4wo7xEyRvnIw7g+d8J+qttSdL5XR
	 gIlQs7VlHPrmfZPLrzt6UYCYKAeNR7CxLmBA1eOJSQF+dzFog9vV9OsqbuSxuEiYch
	 gYi0PS5Z66LX1yfdSaILRs+zeJxSKhvviXO+ojtyLKFczernfbcJJjoq0MJWDJDRnD
	 YN136ycnoj0y0yM3MxlODW98SPnT0L9MdSyLRsd9sxkeVWeKm/17RXMX65jKPYruBo
	 GLAJ5AD6CPvUjMViyIyIDzS56knZgkQQoLBjZa5s30nFPuD3cKSLBxeygnYs77cntb
	 y5c5zxZ2kokkQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:02:51 +0000
Subject: [PATCH v4 6/9] arm64/sysreg: Update ID_AA64ISAR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-2024-dpisa-v4-6-0fd403876df2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TIHTphWBuVOkUDtoZBC1frDZIcBdWo09SQC7mFjqspw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOUThsm18uEZtQLS9pYRiLAL4lh6QYuVYwITO2XT
 DTeVQQ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlEwAKCRAk1otyXVSH0OvpB/
 0XPMGf/WfzIbveT4gNjNboBw7DD62/YxmpCCoPr/Q4BCY9k1xkCplBqi3c7E51jqf6MYkf0nGbBdvz
 WYHcklfjIUIAYgIV3KfrpKzL93LIqbEgTNO29gEMjOcoNlZ8x5WfMsodfOjI/Ux7ig7BQ4aDpR7S2r
 gFsKNEyUgTP7novphMpBMGg7CgP5dW3ywHZe9mr9tzcI333uQdAnBV9HsNBlxZ9/dXiAokuUvaK+g3
 bwEK91IPZrTUoHMynJqsjXCyftINTo4sM/32BttYVWVWJVlUlBEL3TuPFcGfN2AS1TIKIYIvNf42Tv
 cKOoIWqh2OM2s5vE5mv2MZ5PWNLJ28
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces new features which are enumerated via
ID_AA64ISAR2_EL1, update the sysreg file to reflect these updates.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index d78b12c59658b480739ae797f5ea2c2f14d8d765..724762f0c1db223b5772f4f1b27720facb428bf1 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1556,12 +1556,16 @@ EndEnum
 UnsignedEnum	55:52	CSSC
 	0b0000	NI
 	0b0001	IMP
+	0b0010	CMPBR
 EndEnum
 UnsignedEnum	51:48	RPRFM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	47:44
+UnsignedEnum	47:44	PCDPHINT
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	43:40	PRFMSLC
 	0b0000	NI
 	0b0001	IMP

-- 
2.39.5


