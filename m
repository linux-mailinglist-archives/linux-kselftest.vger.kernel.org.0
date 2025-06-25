Return-Path: <linux-kselftest+bounces-35747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E1AE80F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BB61C22410
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164C2D5C8F;
	Wed, 25 Jun 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfW3mKV7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4022BEFF7;
	Wed, 25 Jun 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850702; cv=none; b=TKDL3q2nboNTzHbpHLStEZRcHgXn743pMvlSoVtrMjnnTMu4xtBqpNhAlWXKZ4dPB/xSwDxVWS6+tWv6JJaUJ3vWawjo3jjrMT62Eu5YcEJknNsj/pCu9NUU6tn7S+1SnbHTVd2GQBIpY7vWWHtHnQZBKvqj0iax3CLrscPAZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850702; c=relaxed/simple;
	bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFhIUufTD0IUDHYKpuQcIjblkfN9tzG1kAessk7r7cWOXtw5j/APq8w5GgwjnV8B4i5criTVm5jzGs5HkA8r/llHDwz5C5a/WnVHajsc+uZlKEt8vNtNaLGwbTkWHjUVfv+mFKTKV0v3JcnxMlBqaL4mtjqatdJCZDhvqWDtXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfW3mKV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EE6C4CEEE;
	Wed, 25 Jun 2025 11:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850701;
	bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sfW3mKV7Ytdx8hMQecRd1Vqsdsyv9tMqqvbXxxGz4vUcj/8dYYK1Nw/GxPDn09xtS
	 Buyl3MoaZdLtapEnnidcsQ7KflQc3XNl4ri0lGuoViKl7CKqAYA7z3KjXdEd/TcHHq
	 BSHvp6QSKvGWiwX+N3pfDZiQbWMfhXYdHP9KZ+rywoDtJ6AaVzV0Sy6Lu6XLAeegDH
	 RtC8YQt9PBtfM66e4odB4QQADewstFig8Z2HueAjD+DnhdEvyH+pLEQvetjbs7CPiA
	 RXRNNKlDt47VJXbzkmF/6o6Mi+sV1ynjcwuNp0947wXcX9VD2qRF5zK2Au3wyRhwjv
	 HvVaeTGt0eytA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:47:55 +0100
Subject: [PATCH v6 04/28] arm64/fpsimd: Determine maximum virtualisable SME
 vector length
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-4-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d5H7XLcR4Rtj+Rj6OZQAl1e1bSehEWOuVd1drKJeL5c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xo98IrSXv5WTcOKPpKcGTvEVAPF5A7vwGuy
 5NSYUKsOk6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcaAAKCRAk1otyXVSH
 0CLQB/0a9lvwCPmsjyKYw7c9zx/gaw7CFvWQ2jEkPLj6mcsahRGzA3bvQ3D2/eT05lo4pEItT7X
 ssPLYuvowOxyFN3ALLOqFxNOqUVFXV9n03XVCyq1YpfLQ/7UFVVsGaEG58kP4nw5ssnu6LpYBKU
 P4fBVhvlTkH1sR8eiVT1K8cimB6v/OEt+a5ZeFILF0wtFHHjKeC8btXlloGN5hj0x61Ds7U6YO6
 z1KkgnahzMu5Ns7s7lINHiqrxK3EmZ2AAMPiH/UXFgVXJTtiqj2sjELzP+Xh6Jq2DHZwfSg/ZTK
 dDsKGYYeeBJqO1Qz3B2zni0kZkP83slF5/ShVXQ1IwawPTS3
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


