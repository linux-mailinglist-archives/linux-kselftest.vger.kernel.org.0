Return-Path: <linux-kselftest+bounces-1177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B6805A7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB9B1F217CC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67B60BBB;
	Tue,  5 Dec 2023 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJH6nUjJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B554C5F1E7;
	Tue,  5 Dec 2023 16:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627CDC433C7;
	Tue,  5 Dec 2023 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795142;
	bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oJH6nUjJn+pyp8n8QaDhYp6O6TcSF9HaFifSF/X8m4+yK2Pwp31ReTfIX4tZWn/Cz
	 86lXE9v7PZRc+2Cxb3IxSdF5UhFqACIGOtfmUB6u31A1yaUg2mteWy6Gi3vfyqjrqV
	 WhknUSSiQJWuYzSSaQcjs17iKEVob+7hwlxId8i/yrI1yZqqPjHgeo/Uhqz5ErV+Fm
	 GANr1ePi3zIO3dmEFhEZEMQuByFj1pU2UyShP0ql85o+6wWlej0p3w/+yk1LjFaIAb
	 0Dzlv02i4V9ZBU0GzUFinZ4csSrcSjK9dXHCmjljO6kIXLM4hrj6nuvIFLKYWqKSfG
	 33DIepcLWSMXQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:19 +0000
Subject: [PATCH v3 21/21] KVM: arm64: selftests: Teach get-reg-list about
 FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-21-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1T5Ms1LUZ7iykmEHQxr5Fc4YCOF2pq4fe2+9KtB
 TDNYZouJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U+QAKCRAk1otyXVSH0LS6B/
 9m9yzXT/1mV+qdIYO/iuTT5Lxlk2I9E71H/ZXhNX+z9TkxFh9/bVj7czqQM1kKuWwSY4I/FMi+GpXj
 OTN+KJliG6qr+1JrGSyNMdZcEXdR+7TmQF/zu5t0O215vAYHI4xGJxVqHuG0HTK7+UyN4sCb4q69U5
 aC178H0cE0U/XI4Cb4UnUb+XTLo2IJLxcn8pT5g/5qQVe5Ot1jZgGLWjxbKT0p1h8H/L/vKyFbEGG2
 1ghWpPyxtGpWFnF3ckyM0qg/5sjW2HEbWxTDG6fYtSOqjm5/YEhd+jLdvMoTLzyXGrQh0SogO60n7k
 EfGfxPn+wsNRM7rgF8MP7C4bVua5pZ
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


