Return-Path: <linux-kselftest+bounces-3348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C4E836D59
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD02528BCB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFADC6DCF8;
	Mon, 22 Jan 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uenH2NUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8A55C1F;
	Mon, 22 Jan 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940956; cv=none; b=qqajGBfcfBfHa93T4QSlsp2iE2lkSyjIhWp5Y/qQU1lpwj/bNSH1t5vegLzp3oHAqRMwnjdZZwZKrab1pnoYXYXf4c3gD64sjmwbrYuqPxe5I+EnnpJVIuQ7F2gXp44TY8/NDXFkBiI1pp2zwziGQ91leFIxG7H1qT1xLWpVtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940956; c=relaxed/simple;
	bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e240o9y0mb5vKUZWFIQ8NInJ23Os6GAKO/Ccp+8XTQY0aXEvylzqEVqGcvFtcUAHg60GXh6GlUC4m82Kgq5jYhJczy+saekMehic2mgvux6SwK5iiFu6nqol2AFGqEdXkZypWZH4yHiyiBh6+GcE/aDwXkwSEzbkPq42OWBWHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uenH2NUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E90C433C7;
	Mon, 22 Jan 2024 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940955;
	bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uenH2NUrX3BKHUZTGYAKES6IUCVEd34fQcYHD/QnUk1hcVVtzw8IkjJAygPTxBvUV
	 tLkmF17RwOKNQAvH5LjkOzMpL0aNyhV0o35SD1BLHNr948RqRN1zl9kG5sRSF703g2
	 cGPTvtH9m6GrOm1ja5pzN8BsNPwRWktFhbpNkmbYSjSBSM/pcVITivuw5S1ejWN+hG
	 TV0RjxjdH3wWxQvToX4Cq+xZmgPWrvwp5eJBN0t+6T2t4NE2sSey9xtVM0MZCsKJUP
	 /T8YN2h6hgpeTeQeQdDR0xruIqNn4IfxlVcwpKxwjoYKiyBfMUJ01ipOAB5QmzXE2u
	 pa2nuS9aj8BDA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:17 +0000
Subject: [PATCH v4 14/14] KVM: arm64: selftests: Teach get-reg-list about
 FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-14-776e094861df@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpemmM3AK6+WPaoSdy7Qcch0oKIzrES77Fu5/jhd
 JEa4ODGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XpgAKCRAk1otyXVSH0L2FB/
 9JtvyUkvEyYLF+wF35/AAh39vh4Uvxxsf8+qhD0Ff1cZCEm7UP72/BD/8DFiY44ZE9neyx6LzObJu4
 b7wIddfXclMlzgs+ZS3eB/OfjGEUcTbK9rVQQHvreEkW9S01Zct8IYaKbfTePsXLratgs+8stgWDry
 ubCvtehsccI4szJhv0p2hVbpt6MYWDU6vORq5ZC5cRJnD4klBcHi5kSYPFvy8qIYr+LF+L8d2XgEp5
 OFcGru+xBhviS/IlCoLWx/VV01mEOaPW9hDK6+udmSB/0BjI+E0t2XqmsCOHwuuFr7h8+SMlSQ8ACu
 rFY8oKoGPaCrZujLbSgguhkXRQIpJw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR defines a new register FMPR which is available at all ELs and is
discovered via ID_AA64PFR2_EL1.FPMR, add this to the set of registers that
get-reg-list knows to check for with the required identification register
depdendency.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 71ea6ecec7ce..1e43511d1440 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -40,6 +40,12 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		4,
 		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 4, 4, 2),	/* FPMR */
+		ARM64_SYS_REG(3, 0, 0, 4, 2),	/* ID_AA64PFR2_EL1 */
+		32,
+		1
 	}
 };
 
@@ -481,6 +487,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 3, 14, 2, 1),	/* CNTP_CTL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 2, 2),	/* CNTP_CVAL_EL0 */
 	ARM64_SYS_REG(3, 4, 3, 0, 0),	/* DACR32_EL2 */
+	ARM64_SYS_REG(3, 3, 4, 4, 2),	/* FPMR */
 	ARM64_SYS_REG(3, 4, 5, 0, 1),	/* IFSR32_EL2 */
 	ARM64_SYS_REG(3, 4, 5, 3, 0),	/* FPEXC32_EL2 */
 };

-- 
2.30.2


