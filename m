Return-Path: <linux-kselftest+bounces-6792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7922E890F09
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357CF28B543
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8161FA3;
	Fri, 29 Mar 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDpGxoRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB02182CC;
	Fri, 29 Mar 2024 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671251; cv=none; b=cCOw/xhfhj8M8mUF9iEBXNf4IGZ4tyvTDtbifeIvIVfCttHagkAKUtlMxd03KVy/Y0t49StbPmbvRBgsv73xUkV7cpKx0CoKarDfYp0FTovUwEDDUGVMxZ8neKhCVUQNwQmiJnd4d73HKjsS3s6x6bDrV3o6hW8HYdaqzNvHiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671251; c=relaxed/simple;
	bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLQxU21nQ++e7XLPoiyXVkxQyFaXloi2Y4Akn+7Hs0tRQ8AIIwqdPwto4bf/HjXKwdi/YBVzKAUQIcuNt6API1rJLQNO84JLM6B7PGNBAc4vi+7IVdz4cCyTz4wQO6uR5wW3Ddfre30GpVsuMYpUgRp/hbyqTS5LWid8aF77+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDpGxoRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DAEC433C7;
	Fri, 29 Mar 2024 00:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671250;
	bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cDpGxoRYxLjokSzdjyr/XpeJME93UBt6tnftJZ4T9xOVKuDufBc1JIllQnvVnYmCq
	 rx/lZqfrEU0z1yyRPMbiLf3iggfMot6kYdtd1sW6H4c/9Rvvc0R8JsV6hKHSo0H5uR
	 ybcPFdq+49uL7I7a5fSGuun4iOvzrI+Xf7f0Y3+Kj4EAEayQAD6NjQ4fMdW1r4/Bbr
	 jDpLucIYlLtlp0NSYXnDT+vRy3+eyJypFk7diu1AkXTOSAQWvuPNh7dKwMVFYaudJ+
	 GDtKv9kJUrKjhJDjzg7vBbr4HJK9wBUHffXc3W0Xfu8/S84LBrzhQE2EwJqfwjRk6S
	 VCmPu+AkdbDyA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 29 Mar 2024 00:13:46 +0000
Subject: [PATCH v6 5/5] KVM: arm64: selftests: Teach get-reg-list about
 FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-arm64-2023-dpisa-v6-5-ba42db6c27f3@kernel.org>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
In-Reply-To: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmBge+eqk74AMtUMIBPiwGI+pi1wDTEcHLlC4p4q7p
 myPQfbeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgYHvgAKCRAk1otyXVSH0NW5B/
 0TcU6VavkFfCBJ8vGg2RX9vZ4t77ShVUFmfqiEzDq+KrtNcMcCRhCD6mQXTT/JcxC1Fa6P/PPFjApS
 fFaHMzOG+YHH0ngniUKKS/oLfDAK0z++QRPzBKHLZPzeb3t0Amcim7X703CJdZLdN+bivsNFzkgcqD
 zVgJPTVIrRdEE68SOE/l2KZgFuNqa8YT4v2wEHHG942seRV3ovb6Nt3UmWz1P6w1YRgpxWq+xflPVb
 1m4RMvSuUwHBEIOLmV4qA0QWlRPEE0gUF+hJIduSa8qLmxJEdxHN/0JRRR86TDzL82F3AJvX308o8V
 /lE+aiJZcM3rN2ebnTtAOrIAl8XjMQ
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


