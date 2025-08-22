Return-Path: <linux-kselftest+bounces-39625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA0B30B07
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DB65682A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875D212566;
	Fri, 22 Aug 2025 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tibW+k5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEE1BD01D;
	Fri, 22 Aug 2025 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827686; cv=none; b=YTyfEYPLienIXKuZ1ZsE7R4kXvdfai18Z492S/ruDsTsSJgO+RHhbFSBmRBf2QvNCnDjdFMYdfQCJ+c9oXFeUucBMXc2hChVHALmsQ7zKi0MryVK/SRt2uQTbFUzWJKW+IghvgaMHVOZszvxOIfwf42ZNm5DXcpfda2IBVg83gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827686; c=relaxed/simple;
	bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CauNeRg5LzMUopxoMGH+zXgjXMH0FgSi4EJxrBi7PRSIGyVaWGg4z0ZFh/JAGXii27vuHAx5hTuClAkMJdOHTPT4BiVhMNMk5XYClDZPVhgPmHpMK16UEjYGxi0ZWC3W7ACWx2Ntde7yBZ/8fL09i9afwMR/sAkJK4y1p3oL/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tibW+k5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3040EC4CEED;
	Fri, 22 Aug 2025 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827686;
	bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tibW+k5SwC+EQm8WETK8o5ITo8euhu5ASLP6FreYV63JafnswXALSlNjA5fe0BBUF
	 utSEukgiYNWb9rkXIO1sltM19IZux+zjdKo0ghJcqZy0BsXULblGupdC9rsILKQea0
	 2hZfYIXE/paPuG6XPOM2M0JIoK4FfC365vCZICUQXTx6pf+6npuiMla1120UivYIVd
	 NemCtEqTe6FSaaDKfTJaI1d0A0ki2CHwZOsLUgNo+qKCmB554CAH0lar8dKJuLNxjd
	 e0YazioxY9CAmiA4qZvtRpX9RW3W2s/DHxZyT4dQNgmwFYnNZEhpy7MQO789AGnIXy
	 nywxNayD6D5iA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:34 +0100
Subject: [PATCH v7 05/29] arm64/fpsimd: Determine maximum virtualisable SME
 vector length
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-5-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop8280CPUlyvzjydHYRql5QRxrmhiav3FGPaDs
 n+EnHbXasCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNvAAKCRAk1otyXVSH
 0KRVB/wPGSAtQ4s7ogb6sHyi03Q7frhO+eVSnrjqlh6UjiulblrEjYQ7wSeyZTfca1wam4DKPI0
 95VzhCW05qMVQMxAgL+SQwE9ACbEw5rW4lirttju1CI9uhSLeXZo0FA0BIthS1Q6mIa3Jqd6Np2
 FN/aBsF3co7dWb2CoSuHOGxiBnVPnkbRgTtECO3aqeIuqHpQPUV2tFQ1bdw40kFH3qxfgoQD/1/
 6a+WWCldm9UV/yNVifW+6Oz2or7emXDQRckHyCcI7TPwl20PoJ5RaZr6b6Za4BQ/1XUSR5nCvHw
 U3UjS069dgR6Prii3dKV1mKfBMZzLPZmAFu3Z1D/Cp5AZcqa
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As with SVE we can only virtualise SME vector lengths that are supported by
all CPUs in the system, implement similar checks to those for SVE. Since
unlike SVE there are no specific vector lengths that are architecturally
required the handling is subtly different, we report a system where this
happens with a maximum vector length of -1.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index de2897d6208c..fbc586813f6a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1244,7 +1244,8 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
 void __init sme_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SME];
-	int min_bit, max_bit;
+	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
+	int min_bit, max_bit, b;
 
 	if (!system_supports_sme())
 		return;
@@ -1274,12 +1275,32 @@ void __init sme_setup(void)
 	 */
 	set_sme_default_vl(find_supported_vector_length(ARM64_VEC_SME, 32));
 
+	bitmap_andnot(tmp_map, info->vq_partial_map, info->vq_map,
+		      SVE_VQ_MAX);
+
+	b = find_last_bit(tmp_map, SVE_VQ_MAX);
+	if (b >= SVE_VQ_MAX)
+		/* All VLs virtualisable */
+		info->max_virtualisable_vl = SVE_VQ_MAX;
+	else if (b == SVE_VQ_MAX - 1)
+		/* No virtualisable VLs */
+		info->max_virtualisable_vl = -1;
+	else
+		info->max_virtualisable_vl = sve_vl_from_vq(__bit_to_vq(b +  1));
+
+	if (info->max_virtualisable_vl > info->max_vl)
+		info->max_virtualisable_vl = info->max_vl;
+
 	pr_info("SME: minimum available vector length %u bytes per vector\n",
 		info->min_vl);
 	pr_info("SME: maximum available vector length %u bytes per vector\n",
 		info->max_vl);
 	pr_info("SME: default vector length %u bytes per vector\n",
 		get_sme_default_vl());
+
+	/* KVM decides whether to support mismatched systems. Just warn here: */
+	if (info->max_virtualisable_vl < info->max_vl)
+		pr_warn("SME: unvirtualisable vector lengths present\n");
 }
 
 void sme_suspend_exit(void)

-- 
2.39.5


