Return-Path: <linux-kselftest+bounces-22738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A19E1C97
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 13:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8F02831B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC571F7559;
	Tue,  3 Dec 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1vFpBrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B291F708D;
	Tue,  3 Dec 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229829; cv=none; b=GNpPAkZ2V5kWI/JkFwY1J7TgtD5ETSK6yOcWLz051HV8EvF/5QI9tRFQxFzZGWaa7HGMeocOnrGdn9+eNHTHxWt2g/OpC3sAeYQZ9hTKCGdnjzC7KcEdpZ6I4mFtLT1r1NF6t7m+UwtMI9ePespLHECkh9NelVcU+bAUE9JLj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229829; c=relaxed/simple;
	bh=/R3T2dCUOvRsYvV0jA+tDFl+fxMd64EFAAAyTy0FGKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bu91rtCT9Ao7HpEDqV/3Gj6DqBhqOySjsbvxkjDfv8e/8sDK2j+C0BZLcYka+Sc3FL31JE4eYps/EYq+XTdjq1QC+CJOzjigt7sEly6hbxUG7t3brgCIXaZmIWSc3FN4BRAYyDuTielrAK5+2JORSwdu25Hu9Hi5/U2H5wXlZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1vFpBrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3D1C4CED9;
	Tue,  3 Dec 2024 12:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229828;
	bh=/R3T2dCUOvRsYvV0jA+tDFl+fxMd64EFAAAyTy0FGKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S1vFpBrE+KOjDQhX9btmNlDoQ7n2hTH1UMCBPiTEZu5fJndDDozTJeMOcWSu9viyz
	 Rck/tX7VRhK7HcZHVuzRL7BF4ypcbHrAZgL3VCosPx0EzKQBeGGZDgVzqNi2DauqZG
	 YnRKDwdjfxKG/x0QZ68vZuERobCN7rhX+blJmKvgSZp2oIH2wr+sgL+UUhUleZvBej
	 zezd5vvQpohWyUsvzkhwsMfFp1A+Tue0iVe29fDxSZHuFZnRYgldYWMTXvexLjB39K
	 3y0hWhh+HhmHogJCk2Z2CBw7tw//w3aOsSHHkojHDrJcnuCPslDAkixcVDS8Hdwob1
	 uNxmXg4YqrMNQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:21 +0000
Subject: [PATCH v3 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
In-Reply-To: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/R3T2dCUOvRsYvV0jA+tDFl+fxMd64EFAAAyTy0FGKE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz1m8jaBl4lRtzxxJijmwJtl0qRMO2NKOfX07of
 PveHS9+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0789QAKCRAk1otyXVSH0BK7B/
 4jbxft2DQuYdbfgTfcFjX9jH+XzlOieTzA/ksj8rFkCcphq/fO/RAaGhLDT5tcDNBWQakCvBJ5vFIq
 iX4SqEGf7NtgaSsjV5tFnKLg8Y2MRpCWuZ6tFgVdooRFxsoRbuyx4sfR9EbL0GFthB+8wm7WFtcMJB
 odzwdRAkRXLvzphBAsoZMNkCVicDDdv/J5FCbGO6IwqvTQZ37gYeFhaTzsSqss/oPLWj507smCyfg5
 Id19FyEr+bsySDaTPyKlr9rS/5vNUOiYGlyBnwYlI7zkqgcPICMrhfclEBr9p0UnN7PTp0PkZfmcOz
 OaDXOFVJyFdNczMl5uC4W4PyYEeQIf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines several new feature flags in ID_AA64ISAR3_EL1,
update our description in sysreg to reflect these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 911f16c82ebd3ee98ffed965b02a5c6b153bc50c..c5af604eda6a721cedf5c9c68d6f7038156de651 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1566,7 +1566,23 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
-Res0	63:16
+Res0	63:32
+UnsignedEnum	31:28	FPRCVT
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	27:24	LSUI
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	23:20	OCCMO
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	19:16	LSFE
+	0b0000	NI
+	0b0010	IMP
+EndEnum
 UnsignedEnum	15:12	PACM
 	0b0000	NI
 	0b0001	TRIVIAL_IMP

-- 
2.39.5


