Return-Path: <linux-kselftest+bounces-40565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B28B3FE1B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979C11B2179D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F802FC036;
	Tue,  2 Sep 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh6xYzRT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754892F8BF1;
	Tue,  2 Sep 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813482; cv=none; b=LmqxFEx4PPx/3txv6KA/gfq/ZriQT6PjV0BIWO7jmDT4zKtXnqCb6IJWGgkqsA2o2SgnNXIP4LTqqZaW912z/lAOHkrInlorCjhyzsqFitWapNNkdkLOJqwj7jE5Cu7czgb+NfNrJIrHQmTh2qn5NtbiNcAsZBLQB0FfqlHxgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813482; c=relaxed/simple;
	bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5F8AZxIkYjFBeh6g+bl6Z5D0UPFmFdFVEyLI5MRh0B8DDuXITaCeo9dNrlgQ6sAmX8JKF3KA+dH7qozHLQZBHZdUThtXIl4SoAIX9HjFIVAwUB6FYHPCbe8mE1vxJ+uDnIcBbAdkIQvtRitRHq8U91TEppur+ZKJF1qUoXSZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh6xYzRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942F3C4CEF5;
	Tue,  2 Sep 2025 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813482;
	bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qh6xYzRTWnyrgR8C6AJNbxZKm0nchFbf+33TeM9zOXW4aS1eWLkDwDmHGqiniFSOx
	 jhIXOeyHaNm47WlrlDM543R6MO3rdI43xAk9F8pHLi+K0d72HxjEGhzWcx3Oxq9UFd
	 8jWT3r+2el6uhBkbK6ZoOVJ/PiCVWDFfBI++KivbSTeHig9gl+lTwQ+vzR7+e/Zh5D
	 6n9UOvAv1hoxCbP+tAMG269yy1qMGRLTzN5voxlC3f56bVfPIiN8zLwD4Qk9Ldm00o
	 nx8lrYGR9xIWYUxwQt8mb26c8sfUPf3tdkqdU6m+nZpw/uJk9DcT0K9aR6BRDKoQMq
	 9QCRr3gUd1mvw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:08 +0100
Subject: [PATCH v8 05/29] arm64/fpsimd: Determine maximum virtualisable SME
 vector length
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-5-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotth9g2ETHDRccMXUN7ZClfqhFnpIGrt3f0eib
 Yyte/XvC+SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYfQAKCRAk1otyXVSH
 0P5bB/94F+nLQ4trESn0bLg/Okw1dl+INFEsHerSNtcHuaiKUM+hz719h/I6wq3epOs+YJMR+Vv
 PwGUERXckqH+BNJ6gEYRyc9/449vijyzsnuBly/10GbNh6vVcBE6JJHX+IJ/OlgGRxLRYGQ4wg5
 S8XsirfTjhQ+q4o5UMUjrqgvjOHNXqvBIVmdRE9g6hNzgqg8E+xhMnfTVCmIlY+eIy/IcmnYaZI
 h16N8bNAUMdSEGhjFMIyDyAc59cx2Z1kCMylcQtbOo2yczHXhxM6KNzS4YLikss5iVKP7MalFcI
 Z+OnpXnpsLKqXQaaNuaOC7C3ap7aWYITRpVEjX3pk+L9V9N0
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


