Return-Path: <linux-kselftest+bounces-47895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADE7CD7ADB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6DB331270D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57933F8B1;
	Tue, 23 Dec 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdctPKNJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C533F397;
	Tue, 23 Dec 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453003; cv=none; b=XZQlPuZTpnF/nl+WGSL+byHy2/o0x5Aj1HOyTUvqmnT6+CZ3fmJY6b3NxUtedJXcCRK4WsyFqnX/ok8pEaVEWvekOAQ67kRgsa6+jsQxLqOUJ1DNJFmPIhBSq9n2BozA2BMWRV5nODn05VEBIvhMfJx4PdbLGWT3nM5f2zcrzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453003; c=relaxed/simple;
	bh=FzRi1bctv9rrqNEWwOJp3F+K+iFD0wwTwXRP36rhp+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CM1gz3Xxm4U7G6rWmVWS0YDseQWqUotvnxgIaTM7OeQPP0oxwnEysru5V8qZOmzZ93UU4/9eEiWxtEtHuoKXRmtzdnxFyMTUHdUrrqg9n5EgaDjcEn+HoI5YqBR27VWMefEASDE17iRsk6OuEgtxJ82SbXWoiTO2vQMppSp9GR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdctPKNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E997C4CEF1;
	Tue, 23 Dec 2025 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766453003;
	bh=FzRi1bctv9rrqNEWwOJp3F+K+iFD0wwTwXRP36rhp+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OdctPKNJwOjWJ5tecGrza74VtWHJA9rrjCwOhN2FX4CdIo9tRikRy644wetxVooIN
	 IxOkRdl83h6vyyS401NfoF9BJGXc4LHcF2cIdR7OwPJOKDb9vjzS+WsXCW7zC+yp/b
	 hemm1WLXEpOfp2qa/Ww+RBfYFNVM70aWmqZ3E056kOqKWXvtAd6u9RbgjtC7wV3aR1
	 SLV6QBFuJ5owkYy8Mqr6cOv5j5OP1hsKqei9pm95vSiB908pvlkD48lgeEOgV3KJdQ
	 emF/QSPj6QoZAB4EkayZIKNkYwuIHcf0Z/83lALqupB9Lrew7oh2NnBKgsw/h5DCUQ
	 OnkhLeKZi411A==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:19 +0000
Subject: [PATCH v9 25/30] KVM: arm64: Expose SME to nested guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-25-8be3867cb883@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FzRi1bctv9rrqNEWwOJp3F+K+iFD0wwTwXRP36rhp+Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6Vf+MTqYjq4kXe4kbr9Zy9gweDKTkN/+6I+
 2AscH+hGPOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnulQAKCRAk1otyXVSH
 0K47B/46AKQNCiAhn5hTkguKHo5oVF1pbyCaBey9vSjyQIbzDbvhCfKZqmL6Sdu/DMwtf98exB1
 RD1+t4wd3yU5XYMsyE8z5/zhRYyKKnOpz97jMwjJwkZ1YS7TYLQ4WmUhvaSV+WkLPEJkbCsSXIi
 y59GMQwrVxyom7Wui2mpYgm2JkqomZOW10XLIPBi8G60NgFjH6q7LGsUDBe7lucid92uDTvCkGe
 bh5+0qgM2Bf0ecCA5VCfMKhgCY6yAj7SPuzOWWApXTABtJHLH7MPC/b6EWv6h9PpwbdWQy8YHTf
 ezKax5T3S18GNdYUmZZdkUApkD2VmxucgyzJ6bwLrmqesJhe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

With support for context switching SME state in place allow access to SME
in nested guests.

The SME floating point state is handled along with all the other floating
point state, SME specific floating point exceptions are directed into the
same handlers as other floating point exceptions with NV specific handling
for the vector lengths already in place.

TPIDR2_EL0 is context switched along with the other TPIDRs as part of the
main guest register context switch.

SME priority support is currently masked from all guests including nested
ones.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index cdeeb8f09e72..a0967ca8c61e 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1534,14 +1534,13 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
 		break;
 
 	case SYS_ID_AA64PFR1_EL1:
-		/* Only support BTI, SSBS, CSV2_frac */
+		/* Only support BTI, SME, SSBS, CSV2_frac */
 		val &= ~(ID_AA64PFR1_EL1_PFAR		|
 			 ID_AA64PFR1_EL1_MTEX		|
 			 ID_AA64PFR1_EL1_THE		|
 			 ID_AA64PFR1_EL1_GCS		|
 			 ID_AA64PFR1_EL1_MTE_frac	|
 			 ID_AA64PFR1_EL1_NMI		|
-			 ID_AA64PFR1_EL1_SME		|
 			 ID_AA64PFR1_EL1_RES0		|
 			 ID_AA64PFR1_EL1_MPAM_frac	|
 			 ID_AA64PFR1_EL1_MTE);

-- 
2.47.3


