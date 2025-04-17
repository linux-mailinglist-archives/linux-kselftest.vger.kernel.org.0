Return-Path: <linux-kselftest+bounces-31000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F4A91056
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797DC3B4375
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81451ACEAB;
	Thu, 17 Apr 2025 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDCEzTo6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246586352;
	Thu, 17 Apr 2025 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849560; cv=none; b=XN3daDy/N+pZSSvZLfzJ5qmTBzfPXExDsVPAkBfRxoJjKqnMud+AtUNJk+lCDTVSjgIiz+unLTwp76IGKGoN+jvfc5JZ0H3cEgYI1qrwfGfLGVThMvxIQRHWEZVtpLlOIMkYxeVL+j2PxWKcC+Q1ZBWGBAV0I7OJxXt1wsNeB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849560; c=relaxed/simple;
	bh=pnmYCJgE/nkEzGjN1xsLpA3poTKMJm9x0l7BvusSFAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqdYzEaesIQKmUioMdrQJxR9gvnFFKwYxgwqv7wUBHAukS7/WcNqiWh1tqOWVF6rmJ/nRxWiFyaFRu/zCghuaoRlAVhxc67+/P3GLEVvNx2tR7B+BbJ8/NOeW4J9dwj48wmDbJFbXctRCzBTurXFhc+bJhqMZZpqBHF7g9VYJEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDCEzTo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40CAC4CEED;
	Thu, 17 Apr 2025 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849560;
	bh=pnmYCJgE/nkEzGjN1xsLpA3poTKMJm9x0l7BvusSFAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fDCEzTo6k8vauX6QZxob4zR5IdBqfQG9/LBGploL4Rw+4x37UEeadqXly3TOiCVkk
	 +rc/7SpLVfLlXaWO5avohmEd0zWsW7chf+tfFiui1MOvDAKWbtRuE/bG1D45hk2nRJ
	 q2bozicBrs/jrCYU9bW1pv5DRRPspE3j0z1YSZxkNQJc4koA51pjqCmeYNbR9TOVX8
	 1v2OG4o2khssaslvIoGBly2Ses1hhT5kPVqAG2CnrP7cOdcEwU7tR1dz6WM0JklhYK
	 9NGPQaA/Oo+z/dvz5qH0/yq/Xb7EevIr8sHdI3r7c2MU6sdabqz59NGx+xyTdoFQcK
	 oU7g9N6g64oaA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:08 +0100
Subject: [PATCH v5 04/28] arm64/fpsimd: Determine maximum virtualisable SME
 vector length
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-4-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pnmYCJgE/nkEzGjN1xsLpA3poTKMJm9x0l7BvusSFAg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEpyqJW6FEgBtMbN9D20fjorXEvsb+J367A9+HaO
 cv+12yyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKcgAKCRAk1otyXVSH0K9iB/
 9iHNXyxCnCRC0GZoAVZ9Oz/0hMNvuJ1p2hmggRPj+Gwl4uhW6bFIUlM7MFA23oCUn3BvukVr0GHTj1
 2uurVbhQ2uo01VD3KNMo95lOpwCJXGeLCB3inYPJHev8JKn4YioCNAXPBS462JwaIsp+yFCSFzPoqb
 +mCfioy7NElEABy/s7QWoC8oRbSaFFLtXaJ0qQbgMowrEME6NNMXCPOUG2vM85UF21DPAJhMtGE8cn
 nmYbHCxUNkoMLIsknnNAdVaIrBVQJ8KGi9M+Y/AxqB9h4c08CDV1VPH8xrCX9xUVZaTDz844lzC9nS
 gUr8MKjjYwMzWEJ1WVz6erXLVwYHBS
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
index 83a4f8d3e895..31b3ca061bb2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1249,7 +1249,8 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
 void __init sme_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SME];
-	int min_bit, max_bit;
+	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
+	int min_bit, max_bit, b;
 
 	if (!system_supports_sme())
 		return;
@@ -1279,12 +1280,32 @@ void __init sme_setup(void)
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


