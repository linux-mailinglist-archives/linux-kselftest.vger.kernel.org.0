Return-Path: <linux-kselftest+bounces-35770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16384AE8156
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB29D1896E4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB62F1993;
	Wed, 25 Jun 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjmAbHl+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9272F0C59;
	Wed, 25 Jun 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850786; cv=none; b=qeAppgpKfnMVTWElwnijnuObXHqcfqbwCv6TkxX3/F9R6jdaJORp2COMUPF9y5wy4ztCXp1l1Ha2zSMLgOeyDXrf1DHB8naxagJes8N7dMMS1m5keMp/f84aWHBrjY/dM9ELDErDiCp+jFjECP173s64ZEF9JJKyKgLhtTLlIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850786; c=relaxed/simple;
	bh=8wKbF7ujl1hlDs76hV4PzHiP9Uo97M2NjFijaiGNkbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK8bLRKTUJuBvM6iFAkmxlf7PT/nKQ8/b+TcHk1EcSKsMfcugd8o8SA+dBhHY1IqKIZpOT+nhS2jEdPMPP1Wz2iZISBRIe/O+s9YzM8NUsQC74gcMD+zYMA/35JO7LziBbnZgd1f6ctY/8ZMdU+1zmgzl6hxa1XtkqeukDibe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjmAbHl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD2FC4CEEA;
	Wed, 25 Jun 2025 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850786;
	bh=8wKbF7ujl1hlDs76hV4PzHiP9Uo97M2NjFijaiGNkbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CjmAbHl+bPNg8RlC8ZCfaqwwPd4NQ+EShcFjK33qIo3ksxA/dnMU+CE3jQ24ik899
	 YWnRA/WGf1zBFIVMdCKnE7P6FVNVIST7MOSYxOLW/a6WBK9MXSq/maWeSY3mKOr2mj
	 Qgcm7OXgDeSY9bAHR3yYJDW6HNGwYNXegmcteCLDKNaDMWmaFpKqdVOUrGL2EL97EA
	 W87DH7E98NsKnZxteere4ZjPy7DsaVtSM2y1IIUoEaQl4b6CAyiTkqg1rQ81P+rWuN
	 VqoHvI1zgB9cOanaOB03joBfdFYwqFsgKR2V0LGQyU6XvNqfwLx9tYt3RYyF7Re8eq
	 VRZCH3WmJ5DVg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:18 +0100
Subject: [PATCH v6 27/28] KVM: arm64: selftests: Add SME system registers
 to get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-27-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8wKbF7ujl1hlDs76hV4PzHiP9Uo97M2NjFijaiGNkbY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9x6jP9Kbaqa1gjraF/WFiCP4Z0JheFJ8M16d
 OY99NwBbDCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcegAKCRAk1otyXVSH
 0AyDB/9GynBfXm9+yas6Ol1uzb4YLnaWl8KeuXK1eHNlqwJ0WNkCFv2l+OJcWl9IPZPaVqnegKu
 tnmssq6PGaBdn4uXKhW9UZR01maR1tnfdo/l8uHc0dGt86lgzOK6upw6dMjSqREQyeb6qgIudDB
 pEQwOuCrcQuDODOYmL9LuLqbx0wVwozh9kU05f9Mpj6hiU4sX68iGhoVf66QyhBao+nDJ7REjuJ
 Tqfq7eGVNHAKDPWwNxojIepthauKSX5slcikAGp+Dper/jN7ZFhxbPR3LHjQeqaKLVEGnoaGEjP
 DvdA0Su08HOinXbrJI9TLNdrOV7IvQ0oqPpWjkX9N6yx3lI4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a number of new system registers, update get-reg-list to check for
them based on the visibility of SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 32 +++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/get-reg-list.c b/tools/testing/selftests/kvm/arm64/get-reg-list.c
index d01798b6b3b4..920784aa2838 100644
--- a/tools/testing/selftests/kvm/arm64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/arm64/get-reg-list.c
@@ -23,6 +23,18 @@ struct feature_id_reg {
 };
 
 static struct feature_id_reg feat_id_regs[] = {
+	{
+		ARM64_SYS_REG(3, 0, 1, 2, 4),	/* SMPRI_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 1, 2, 6),	/* SMCR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
 	{
 		ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
@@ -52,7 +64,25 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		16,
 		1
-	}
+	},
+	{
+		ARM64_SYS_REG(3, 1, 0, 0, 6),	/* SMIDR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 4, 2, 2),	/* SVCR */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 13, 0, 5),	/* TPIDR2_EL0 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
 };
 
 bool filter_reg(__u64 reg)

-- 
2.39.5


