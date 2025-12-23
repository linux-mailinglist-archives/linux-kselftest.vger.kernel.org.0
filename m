Return-Path: <linux-kselftest+bounces-47875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 539D2CD7C22
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05295300928B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A429227AC57;
	Tue, 23 Dec 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+mGMvr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF52777F9;
	Tue, 23 Dec 2025 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452917; cv=none; b=Y2B3gBYt8vkypLLOpz6ALaq4NbWePwy5Z1qYXJopHygKCYM4qHUKwAzqAOwkiN8fzvn5q1A3/d/RonViEq9YEGytDrdluhZB5bznyO/2yKzGSGhloZRhRdwsEkMhIHWgHd3x2mwpgpqNqVYEXcfa90cxRHSaVFpCxhZl3eNtUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452917; c=relaxed/simple;
	bh=4+FJ7+9SNzMFsLU/lZOfnlAHMAOz0MdKHDvJ4fcVrRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFrCVdacrvoqJoOxtGLaMZeRc0pG5AdCV/ajrt6mObnZvXg3/1UeCYquq6NMHkPH61SsW3tQB9tokFMQ8jSYOvx26p27Wp1ohxBm+lbXXxoTgPCiL9+/ksyhOUhMd42ZEl8zsMwWEXeqDDDuc61n5QFFG6LX3srjGKkwaMTSd7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI+mGMvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6453EC4CEF1;
	Tue, 23 Dec 2025 01:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452916;
	bh=4+FJ7+9SNzMFsLU/lZOfnlAHMAOz0MdKHDvJ4fcVrRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bI+mGMvr6H4pr6+RIaS0/WHsc0UELxttOk8dVJWS5Nj5KiDQ5QjlDUbESX/gqp37i
	 nn4gaNLTaNR/L3s4rttanfzayaZj+zjOeQMmrVRqhkbA5FFjBIf16Hju+lRhHDuBWu
	 mJmgFDdqBNMFab5QkSlKI/drSfNEeAgnDfMOVmeNsPJp++6JAMWSlkeePFCC5uM/86
	 jLicmnJIJmaveoG79JK8Nwzi+NCyC6+q38SkZT3spDsVITMSbtXvCmQqEbAzBWemnp
	 c5SKFyLNjMlNiQLJHADQJUz5clv/LEy83QyshgnoiANMBt7JCrekEOVycqDSSBftrr
	 XgoHwImiQIDiA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:20:59 +0000
Subject: [PATCH v9 05/30] arm64/fpsimd: Determine maximum virtualisable SME
 vector length
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-5-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4+FJ7+9SNzMFsLU/lZOfnlAHMAOz0MdKHDvJ4fcVrRk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6G94IqpPKtBF6i+APEEZA50ZuCkXbJI1Xmp
 pNNMT4DhmeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuhgAKCRAk1otyXVSH
 0HaOB/9t0imWZqpN/qCLBUFVBTic1DgibgESyXd44hvr7rrNUUATGfqFo7hScqgfof9CTCj8b0T
 0HC0+QtAtf3fPAeEJskjJ3iHr5P/Y7Gjspj8/s5XFxnb36iDbMmfWIqmciRJrA+fxvgL4MWnUXj
 6R7artS98h2mfiYUmUiTI6DbVtuOdvf/JuC/keSkmAq2fUvOPCDfoau1lQaBGjg0cL6q13SL5MY
 3mXBUVldRK31z4cr7dYMuRrjBh5jmOQsr4vZuunAniObziCOLEVnATLq8yeznT7qLKczgEbtV10
 Tg2LzX5o6dP/i+kzgBmU66U2x3YWTqPeEsjj3Nh1Htyls4z9
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
index f4e8cee00198..22f8397c67f0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1257,7 +1257,8 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
 void __init sme_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SME];
-	int min_bit, max_bit;
+	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
+	int min_bit, max_bit, b;
 
 	if (!system_supports_sme())
 		return;
@@ -1288,12 +1289,32 @@ void __init sme_setup(void)
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
2.47.3


