Return-Path: <linux-kselftest+bounces-19102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092AE991628
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1814284495
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BA14E2CF;
	Sat,  5 Oct 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvXwRAie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26D14D71D;
	Sat,  5 Oct 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124674; cv=none; b=jrleDPQcAby/VhMH+SnYtrdfCZqJm8WvrZrGJdjyzQRZwuSW6QgTqyINEc3lKBR8g87KIcSbX1UxHKor2BcJiGStMQeeUdbjIcAOSGV8NNHJFCigaHmDiIwpESFzkdTEGo7Pu9+gs05yHThvddnY2bZ1Vl5PA7791GtTMZkEC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124674; c=relaxed/simple;
	bh=8Pjxo9INu/EMoo+OhS44/Ry5FhrWqchqYTe1rDN+srw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tTh90bB08iGrjEPJU3o9gOYpEVME5W5LqlB3Nh/2/RJhnOhscU5VE2L7Hg0OuvXwSv5HdIufi0ssQE8uMvX3ry3kzdDUFeCLWVXw7USq0G7l9Q7oaweg82fo6SN2Z3ZASINf/vpmCpOO/5PsOIuYWf+OPedN8WmXnhlKvr+bZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvXwRAie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A788C4CEC2;
	Sat,  5 Oct 2024 10:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124673;
	bh=8Pjxo9INu/EMoo+OhS44/Ry5FhrWqchqYTe1rDN+srw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvXwRAie93MFmCGJRO4V+tIfv2x+W2yImgIjT6hJdi8+RZuCnPhDyIVR62QeMeBcP
	 bLQZCqgGCXtgHpKLinhIeNj46JJWPgstEjHAmGFEGUatlhtrYZLlhOHv/sRa6dKcAC
	 JCtd6Ozz9HTybQtmamvlkhY5/NEcsikCKeWJzS/wrEbHijhTrJY981GAAK7dZ218F+
	 k2ABlQM8wSaUG3CdsJSr33xOYVzszcTUbkwEsJWW4/fpWBJtznqHkZ7tv32Oe4KV7b
	 FbI9M7fwPpdHJ8IirLdpZ1fSJ4BjohM10BkYdiwy/qkVyd+uE934J4TpkoyvHywrPG
	 yCL//zlICqG9A==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:37:29 +0100
Subject: [PATCH v14 2/5] arm64/gcs: Ensure FGTs for EL1 GCS instructions
 are disabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-arm64-gcs-v14-2-59060cd6092b@kernel.org>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
In-Reply-To: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8Pjxo9INu/EMoo+OhS44/Ry5FhrWqchqYTe1rDN+srw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARb1lDpxvdKpZowgvD/JRoSi/pRDCs1WIRe/PPzb
 EpioVFSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEW9QAKCRAk1otyXVSH0LmUB/
 0banw7+CVnBt752fDpu8Y34/fz21ZAwQ8KbJGKTIH6/tX1K8ReNsMuZBsW2PSDY5tDYDQ4HQMLqHRl
 230LEsoW/n2GqS/bGxFWXghMpzb/a0HiHyze5zB6NkXDiYhtLeb/gVocsBYnrUj85xpKCk7wDbciBX
 ru0Nft+Baamtso/j+nZfPBbV3D0aeG0jLuFs3e4vboXmQ08Wyr/DeKT2+d4LQpMYi1SxhjRcQaCiyJ
 aAW7h0aI3udMpf2yEJC73UWibBJ1FRrgbNyVz1FkR/M/QpKw+Ei+cfSirjvaLvKmGLIXjFJH5ae01B
 SRGU9w7ZvzFVN1KR7cBlqQd7nn+Nku
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The initial EL2 setup for GCS did not include disabling of EL1 usage of
GCS instructions, also disable these traps.  This is the first disabling
of instruction traps, use x2 to store the value to be written.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 27086a81eae34483a682681ab1be1959a339527a..99e887a5b2190f8810f1ed22d35b7acd26d2fd1e 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -170,6 +170,7 @@
 	cbz	x1, .Lskip_fgt_\@
 
 	mov	x0, xzr
+	mov     x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
 	cmp	x1, #3
@@ -217,10 +218,14 @@
 	orr	x0, x0, #HFGxTR_EL2_nGCS_EL1_MASK
 	orr	x0, x0, #HFGxTR_EL2_nGCS_EL0_MASK
 
+	orr	x2, x2, #HFGITR_EL2_nGCSEPP_MASK
+	orr	x2, x2, #HFGITR_EL2_nGCSSTR_EL1_MASK
+	orr	x2, x2, #HFGITR_EL2_nGCSPUSHM_EL1_MASK
+
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
-	msr_s	SYS_HFGITR_EL2, xzr
+	msr_s	SYS_HFGITR_EL2, x2
 
 	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
 	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4

-- 
2.39.2


