Return-Path: <linux-kselftest+bounces-23132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FE9EC13D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F77169034
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98113B5AE;
	Wed, 11 Dec 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh3XVNlK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0173A8CB;
	Wed, 11 Dec 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879069; cv=none; b=Sr/0DsPSXV1jmvgx1tRBhNlK6sWBCUqb6XAOgdMJ7m6YjxJzgwO4Cxf2nMTcnQRjxGNzCDXdc41s8vI0zWjPuZBOZ1fc2oYyLiwzv9A5Ub/CPv9+ZvZB3Jb2BUQI0M4AWoEjdArHExvjUvxCk6VrThbjK1hQIrENL7SEupPO9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879069; c=relaxed/simple;
	bh=JZ5YG/ZPtu0+rE3J++aCFRB1wnbLT9/tbF2mceWYsQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAYYMFdRd19sS7SIgKL2zFCyLSotDdEW2ZisAmHfkVZCs7Ag4QvISPi7j1Z62QQ84r5Srpimv/t5/NsQJ+/5erVk+c5OQ/XJvdGcb8go5YMOhI5QzWbR0lWA3pyhv+zspJZVhMQ04SBh9AVp0j4Y1vgBRLmPpi9F5ZzIvcVXGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh3XVNlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8481AC4CEE2;
	Wed, 11 Dec 2024 01:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879068;
	bh=JZ5YG/ZPtu0+rE3J++aCFRB1wnbLT9/tbF2mceWYsQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wh3XVNlKH9j7aWMeMKMS2zglc1MDzb3cNC3P3ZVhKF1a/2Vw0HuF1nvrtu8PcbhdQ
	 vzxGzsKJL8j+3EVbYjpNZUvkbOUslBar8YVfHs61E0BGXh8PQ6EOsJBFy9CyC9kIUY
	 cwSEJ9Vt2TYNUnPYeGiZ5opuHm+Qg9eqiU1bCy+g4eWiEMpUKYNeY1yDwMg02s8GD5
	 khF0m9ou4Dt9I5W9iDzeBAopue0CfpNT1oSIb2tvVptRFg4RxY55Q2ruXTmCu1DLkG
	 LKB6oO44s3ICHPWJe3SKq8vd6bKtpclik3tEpp4MfgfLOg/4OZZcSPswlX3rcZ8m3L
	 uJG6mu8yV3e2Q==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:02:46 +0000
Subject: [PATCH v4 1/9] arm64/sysreg: Update ID_AA64PFR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-2024-dpisa-v4-1-0fd403876df2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JZ5YG/ZPtu0+rE3J++aCFRB1wnbLT9/tbF2mceWYsQI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOUPKGYKMBg6LVTy4ZKj00alAeR2T1/6KyqDXfuC
 v2nAsb2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlDwAKCRAk1otyXVSH0GAcB/
 9A9ZssLa2ITwyImdrKFofGZHRFhONgiad1DSNOH8rRWAAp3W91RDBwqlRz57TxQsbHGRX38JV1qTiD
 n5KbKtyzjNrEPrz/apU6rQW5r/Jdk6xV53nqDZUmWEsxWdUvv7X8LkU9UK+sBqtMi+afHPXTFdjv/G
 QWccbqd+SHpQsA0gShWPpVdbeoBY44svHIkOaff5/pDoPn1geub7iah+SFjS0/U+6zSeuasxG224rC
 pVdfvxaJmLCHCxSEZ6MTEpVc4eG+Cfy782fLZGJH3mK8Pd21Li41PIpifmK76xQyLaeeUcv3hpwtUw
 7BtchhuJ3OkZoHPhYBKMYBaRKwVuS+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines a new feature flags in ID_AA64PFR2_EL1
describing support for injecting UNDEF exceptions, update sysreg to
include this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b081b54d6d227ed8300a6f129896647316f0b673..911f16c82ebd3ee98ffed965b02a5c6b153bc50c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1010,7 +1010,12 @@ UnsignedEnum	35:32	FPMR
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	31:12
+Res0	31:20
+UnsignedEnum	19:16	UINJ
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	15:12
 UnsignedEnum	11:8	MTEFAR
 	0b0000	NI
 	0b0001	IMP

-- 
2.39.5


