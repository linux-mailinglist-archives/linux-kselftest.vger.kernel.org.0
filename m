Return-Path: <linux-kselftest+bounces-84-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324AA7EB226
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F08B20AC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D12D629;
	Tue, 14 Nov 2023 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk927/WR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989541231;
	Tue, 14 Nov 2023 14:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9713EC4339A;
	Tue, 14 Nov 2023 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972533;
	bh=S3NMLYQ19RrEAdoy2+4KbBwGNVT5MhUVc+1BjCfl9/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gk927/WR5EyKxYCh+Pc9WZW0pJpXPTAJ7h7INrAFmYKpNzXy0QaHuBCJilMqIjnQH
	 Mn38NuP2LsD8pE/xmAvQMSmPP/n40W1kC7o+31ydbHesOG0BvKPuJCKdGiN3hDOlFk
	 w/8r4X/DZsKSPqCPrC6ZaEEM/PVazUEs+YQ+lvaoRZU8/Ib8plBvg1BZ/XItd9oVFi
	 urzu1sja8QR0rr5VLNfpp5GpGjOEAhMERKLWzlZsFaFL2EVki4xByb/OHL9ClpIG5W
	 7BzgpRIgqqnWfWVOgjwVc0kz/wWtEQA9oM6IIqf6AN+CEB3JjKbe0D1OJIWcbKHB3M
	 GlGMqsCj9+NYQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:48 +0000
Subject: [PATCH v2 03/21] arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-3-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S3NMLYQ19RrEAdoy2+4KbBwGNVT5MhUVc+1BjCfl9/g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WXRWQJV7DkDAe3fM6c5JrXAGS3X/FV5KJmVmk8
 a11Rw7qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFlwAKCRAk1otyXVSH0H8nB/
 49tuCQSBSQtsxS5e0Rae5UXUeHeRSH/3KyXZ7fGq/3lRCdroUjdR7AG1aRnH2tJs+foAMLSM4z6Bkl
 bbRabcc01HyPjbI5fWZJR0I49QlvtwEb8fqySdTry88YbC3YpY15VB7S6+RWfxb+bGLiGl8yIdAQGf
 IO2nL9IqH0Uo8i6sq7KbukZPPjvz1vM9BJo5nonurtVtqWND4ASkbYN7Mgwcgxd6roGQrpLvhq4Uo/
 eHMdExTsADgJ4+q0jDalXGEQTF4WeyjvS0GMS4UJl6SWyZecI9i+MA/GD1bXF/4dX5Ds8y4mpL2+tO
 T3gVstZITu1RNs6EpUzDcpsApht+oD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 adds a new system register ID_AA64ISAR3_EL1 enumerating
new floating point and TLB invalidation features. Add a defintion for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 27d79644e1a0..3d623a04934c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1433,6 +1433,23 @@ UnsignedEnum	3:0	WFxT
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
+Res0	63:12
+UnsignedEnum	11:8	TLBIW
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	FAMINMAX
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	3:0	CPA
+	0b0000	NI
+	0b0001	IMP
+	0b0010	CPA2
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64MMFR0_EL1	3	0	0	7	0
 UnsignedEnum	63:60	ECV
 	0b0000	NI

-- 
2.30.2


