Return-Path: <linux-kselftest+bounces-19105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB015991632
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1051C21D20
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7480154C08;
	Sat,  5 Oct 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX17Zg/L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2D1547C9;
	Sat,  5 Oct 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124682; cv=none; b=RdbDlxe5x0sDv323xbb7eiEyMl5zBhahjh2thS5A2mx9sEZxkCvZwYjAH2cXDz6PcVqfYpahvwlLlbAGOq0qkD94kuzvvdnQpZEWpa92Lg66ZxWlZSIoWN109OSoM4LqxRiLci/PLgu0K/egECs7mzuiFQu8afY3GkRoIb6eG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124682; c=relaxed/simple;
	bh=djrrE5vI61PLt6bp7VaUC+7O2DJ3zSyZt7/lGI0Flkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcUKGwqFXtmqrCkwoYpAb7k/zI8YfK/P27v+zic1I0nzKEp+cxUYinIil0KkmN59DIwEAaaoyBPa4UI7kR7EFzOsfrpIo+zCwgMaRl8zcusWZv8rcfPDcW/jFUYifRuFu0s0Cocb6rv6IZ0LggGU33VbWFkTl2RA37IidK9gkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX17Zg/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD481C4CEC2;
	Sat,  5 Oct 2024 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124682;
	bh=djrrE5vI61PLt6bp7VaUC+7O2DJ3zSyZt7/lGI0Flkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EX17Zg/LFPJeWiupkMxyTmV0uaAUAGotvuvbBzRs04NA+ZvyjHMvTpRojnKAFMkgb
	 tkn0EnrqSRh3QGc3NZrByx5ulwjjOXAeFI3xJ11xrBWuU+T7cNeS+B6usOh6ncBF1w
	 JgAQ1VK9Rbzdi14hcovmQZhQD68bAoEfpLh/UeBLJaib40U/vZHcXSZLpgStABQglE
	 1Pxl77AkVEcQI1MdQ/5V7jFhNhy8eGDXKjEFMMCVXtlakGKcFipYjRoBZtPtKZDlO7
	 G7VbHP4x4sjsvtfCzP7NUdIvtg4jE1pW7jp2azF18czb9eD5H5TeLSIoQXfreS7d96
	 +LL9Kq9Q+eM2w==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:37:32 +0100
Subject: [PATCH v14 5/5] KVM: selftests: arm64: Add GCS registers to
 get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-arm64-gcs-v14-5-59060cd6092b@kernel.org>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
In-Reply-To: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=broonie@kernel.org;
 h=from:subject:message-id; bh=djrrE5vI61PLt6bp7VaUC+7O2DJ3zSyZt7/lGI0Flkc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARb4qiU+YPzWEcVBFo6t1JABWxQ5MjKPP1N/ZAgr
 jErfBQ2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEW+AAKCRAk1otyXVSH0BelB/
 9zvYadAZSXpdeHQ2QzcBmpXKpLn70G/fNZB6nAQh+5Lxf101g53WDUQ26PhUMy45Y8E17xuxWYRd2j
 Tc+1bCXD46lsDosehDL5SlodyeMPCuxXAajDOryY0Nv4VGbaSLMezChTRukxOzepiM693wv8kDEA+a
 +7JkN2Rus0HM/VNzfOTvoC+0k0Ge17kF/4UItbFE/U/KkaFBzMwsJSOvLxh5miKn8776vkMv84z1nA
 5/dwfu88KVjqt5Odz31mxU4e6HL3xOevYT0O8ueh8KgOzmMOriJOH4wXahZ7tInfCPT3G1TNQJo0as
 tIRbxHq1aJbJtUERr+tFnVOiletCeH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

GCS adds new registers GCSCR_EL1, GCSCRE0_EL1, GCSPR_EL1 and GCSPR_EL0. Add
these to those validated by get-reg-list.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index d43fb3f49050ba3de950d19d56b45beefec9dbeb..c17451069a15d181bb5a7efc8963290828f58c4b 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -29,6 +29,24 @@ static struct feature_id_reg feat_id_regs[] = {
 		0,
 		1
 	},
+	{
+		ARM64_SYS_REG(3, 0, 2, 5, 0),	/* GCSCR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 2, 5, 1),	/* GCSPR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 2, 5, 2),	/* GCSCRE0_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
+	},
 	{
 		ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
@@ -52,6 +70,12 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		16,
 		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 2, 5, 1),	/* GCSPR_EL0 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		44,
+		1
 	}
 };
 
@@ -472,6 +496,9 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 2, 0, 1),	/* TTBR1_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 2),	/* TCR_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 0),	/* GCSCR_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 1),	/* GCSPR_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 2),	/* GCSCRE0_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 1, 0),	/* AFSR0_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 1, 1),	/* AFSR1_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 2, 0),	/* ESR_EL1 */
@@ -488,6 +515,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
 	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
+	ARM64_SYS_REG(3, 3, 2, 5, 1),	/* GCSPR_EL0 */
 	ARM64_SYS_REG(3, 3, 10, 2, 4),	/* POR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */

-- 
2.39.2


