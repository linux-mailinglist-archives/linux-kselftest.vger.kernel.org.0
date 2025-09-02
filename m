Return-Path: <linux-kselftest+bounces-40567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66765B3FE23
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8E1B248B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296F2FA0E2;
	Tue,  2 Sep 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McaPTu/3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E832FC895;
	Tue,  2 Sep 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813490; cv=none; b=FM796NkcV56P7sjiSs+49a/HCgNkmlm8JhIcRcinusvL0KEkhrhqaZH/1rABxXuFt0RNl3tVX/5xI31Qvf/cVS4jqZG/KheRiz6+5GD92sUgy3wDFXiGq5hJ4OjQTFNMMUPNQvX9/74sxd+lwm+vfh4CWgksCRaI5vBVZ4bssfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813490; c=relaxed/simple;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKpuC3XfRY9BKO2Jm4PTDWWDK2k1J3fvrDRtDBEqhIObFyH+O3jCPApq6WIMAzdfnj1rLFqeQ8tQtsBPf7SY81A11tyu0qNrkFthSQDpC9KPfXMFd3X5cabThp1w17ySB67wlh2W01rVh5KCiYEJfuE0CTqPJVluIAwdcjLC7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McaPTu/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D16C4CEED;
	Tue,  2 Sep 2025 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813490;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=McaPTu/3nEsNP8++iWdFRglKCDsQdyR+NL93ZI4OrRVu2Q9xUK+u2VvR5p/3Z37f4
	 3vU/tgooF3fpSsDozPJhilz1IA0RdIWBePkbYvwUfd8WlWFX11pj8ZibuLecwLQJg9
	 8ZAVJNt+qGBDsKfQQ3RXYJ1lZeuMwrnQRDRmeopYzLPHmrr0lwlPTN6iwg+FsQ9t9g
	 Pz1Pis4LoJXlxAVknm4hVi/zYTcw5qmEOJzBmyHWCPTeYcCThgFzTEVyYxwt6/pdCe
	 lzsbrB5g3BGFSYDFIRSHUXO+7IojOPZ5+Mx8/AqHMCrq356OAMfMEoCzhpQc+6a0vQ
	 mwmif7Fgre9PA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:10 +0100
Subject: [PATCH v8 07/29] KVM: arm64: Pay attention to FFR parameter in SVE
 save and load
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-7-2cb2199c656c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotth/9YhjtgkxhNW/f037K41pEV8WSI0IuBOzW
 PYA2fg7tr2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYfwAKCRAk1otyXVSH
 0HWuB/4/sgZvXMFiO8HnjLPW/KnLnt7j3M2mbyq6B6N2WFGNoUMmKbnOpewTSJK3AebyJsxuZRz
 BQk0Yeskp7W3e70mCa/gkCkc2WToJKwGF+jI+XyLQyJ7AqybIfI4T8RVr+ZBUqSpiZrSJq7jagD
 m0Vtrne+Prso7Qr/nHlKBxL0z4G2kgleznHl2E3zJeyNTkaV4ZH8c6h34Y1zGY2tSbycgVlazU8
 AOgwzTIRRn+wbLrlOigGn+24TNsfWm3e6BbiE2ql3JvCGvA2g3A33zQuikym6t7lVt/tItParw2
 PB+F05oat9VglRwcHIlD582ek3of50kZnirNTxo/rpgagrUD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The hypervisor copies of the SVE save and load functions are prototyped
with third arguments specifying FFR should be accessed but the assembly
functions overwrite whatever is supplied to unconditionally access FFR.
Remove this and use the supplied parameter.

This has no effect currently since FFR is always present for SVE but will
be important for SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/fpsimd.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index e950875e31ce..6e16cbfc5df2 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,13 +21,11 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	mov	x2, #1
 	sve_load 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
 SYM_FUNC_START(__sve_save_state)
-	mov	x2, #1
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)

-- 
2.39.5


