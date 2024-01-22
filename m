Return-Path: <linux-kselftest+bounces-3345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618E836DEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C53BB2C6F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C276BB4F;
	Mon, 22 Jan 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5+aNOMS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756C6BB4B;
	Mon, 22 Jan 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940945; cv=none; b=WkWvOsbXm5TSQ8O4hiEzngOZ7WNtx6w5hKNN4LN96JF6MA/D9Fo0k/9E+Y6C3RnVO+uoZj04f4wTUwTpJ0v9x+gNcHgRe6dffk4O3caggs8tmURJ8D/7VDEdVONN7C/qhD8EmMtidaNtjnjgD8Ti1EYTmYFrz9Lq1RABb/3TR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940945; c=relaxed/simple;
	bh=8kqcjtFGMUDbHp30mYnVMt1wKs74Pp18vGzWWW8msEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCQzEiHxt3ZUXT1tTHyBoXbBthMROVVYclU1LalAGYFrCCG5rYIJZl52HF1JUxV39iyEB9u4NPWANae/6qepxgiyAZ/y9OUvhTNY4qDKwp75B++5s6zvnqUl8h0N6fdJOKTigX6phqP6KxxRypmsL6dhqyXt05Io6sMmWpJyKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5+aNOMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41812C433F1;
	Mon, 22 Jan 2024 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940945;
	bh=8kqcjtFGMUDbHp30mYnVMt1wKs74Pp18vGzWWW8msEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l5+aNOMSVzI4/bnFMAa37EW4F+TjqePlxyy3h1jeps9BsAOV3uX7eGX7+1dKF7B/a
	 ZwHQwX/JKCYnaHW4EjxJd6eaJ+vEFM/2M4jA2ASYoNIHTUhhcynkiN6XUcpnEHQHeb
	 FtcxTMzbUS3cohDvUxxeel4QlwwtuGz4y3mnmkqNGS4YDlCAzX2hyaoNX4zZwGKke6
	 al1rhpjrpsdmHPgGYVgYkT9TKlTP1PUkROb4R3m89FYJ2d4xQrXb/1W98x+TRapaDg
	 LMVn/Jn12Tx0xAS1tUYQgh6gJ+LfZXiX7Ig5TEJybBZyFi3PIJfmH+cZPr+Js50y1j
	 eEHNGbQ1GQjmg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:14 +0000
Subject: [PATCH v4 11/14] KVM: arm64: Add newly allocated ID registers to
 register descriptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-11-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8kqcjtFGMUDbHp30mYnVMt1wKs74Pp18vGzWWW8msEI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpej9so0BeeRvnHW8ds9RaNDOIMoNEVc5PFt/7BN
 HpV+IFmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XowAKCRAk1otyXVSH0Dp1B/
 0TvmIXnqbBDKeGsLouvL1C2jl+r+BY/I04pJe+MW25ysOGS7L+Iw3Te7diEb4PKhGJdlT8s8lyQmfk
 dtOWRT8kN27qpb8p8A5YDdHkBzLwuTWIvypgOIHyLAptp0ZkO6dOVoMgPoiyw90v8GT5N1iB2lWbLm
 mFlDlpyWmImFKMLQt8IwF0M2hMTDNuKULUmmsR43yZJ1kR0McZPQhngCx0Q/qo+L3UkN8mUnUSN8H5
 2s1XGtior9wuepDmYJfw1u0ZZNIVoTdNc3rMXT2wwJlsoyD4dDlBs/yAN5C4dxoWTGZ6P8lgKYW5gF
 Aa5FxliqVxLpVY6yHoGLqWtMLWuAsR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2023 architecture extensions have allocated some new ID registers, add
them to the KVM system register descriptions so that they are visible to
guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 30253bd19917..38503b1cd2eb 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2292,12 +2292,12 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
 	ID_SANITISED(ID_AA64PFR1_EL1),
-	ID_UNALLOCATED(4,2),
+	ID_SANITISED(ID_AA64PFR2_EL1),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
 	ID_HIDDEN(ID_AA64SMFR0_EL1),
 	ID_UNALLOCATED(4,6),
-	ID_UNALLOCATED(4,7),
+	ID_SANITISED(ID_AA64FPFR0_EL1),
 
 	/* CRm=5 */
 	{ SYS_DESC(SYS_ID_AA64DFR0_EL1),
@@ -2324,7 +2324,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, ~ID_AA64ISAR3_EL1_RES0),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.30.2


