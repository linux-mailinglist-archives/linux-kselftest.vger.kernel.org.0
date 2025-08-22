Return-Path: <linux-kselftest+bounces-39627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3BB30B1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B8C1D049F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C0230268;
	Fri, 22 Aug 2025 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ1QAK+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AF1DA60F;
	Fri, 22 Aug 2025 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827694; cv=none; b=FP/CIv9UfSohSSP2/BsYb0JtaHffvY6vfOX6NYI3VAgQU2oltVD0mzkmeRWSsCt2YWniK4b/RqFvIzUzyPkvdYzi/OUMAkRfWuiVB3lmzk6ikSoF3JwVi6CPsuV9bbQ97e2iI3zhDokeNrX3lZ/ifkNhydVUhW9w049MNtBMGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827694; c=relaxed/simple;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lh6uZvl43PFxyTkBuP9Zeja/IEoDtizHRRKN+1ao581w5yZeIcak9J+TJJHqLHWqOibsnpfqaJuFCrNfaX3SkFQemSrjYYfY5Mh3AVN2G5a47qle+QJGB7RcOBZth1cZ6HpJoH9sgzQH0lEF5GXFtQGDSo3c4//0Dfs0rqCjAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ1QAK+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E43C4CEED;
	Fri, 22 Aug 2025 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827694;
	bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rQ1QAK+ejMF2UsJTYMuGaQ+IUgv6wAQRUG1tk9AKVHc5EzOuBwatDMV2fTFBvZn5i
	 87J0trOaDm015XUoetk1CWfbiu72sypzgCtoDDeLo2MplMOpClXboXPx6n2LAwQtlI
	 urSrhJtfcvsQNLTXMWNHZlSdzZn6nPjNjCh8wiSrdzNVuZmFKpDz2gWbssytXP0xQj
	 hdnvytjfOnWU3HcUfPGND+WYEGAsoZY9VUQyhlP5r9Uwm2klEWv/HyQ1KXx1U6urkO
	 5xfvPPiAcsEbwTvMO0C7wpnFfhQ+O9tGhCETceauxB6SJXbA+ztvKYRHrFoqC6JPof
	 Bf1ng3cyhJTxg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:36 +0100
Subject: [PATCH v7 07/29] KVM: arm64: Pay attention to FFR parameter in SVE
 save and load
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-7-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
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
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LDt1xNEXDV4dCIkz7nCmkUUILCzxDoXGLDJ0dFTAhvY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop829BfoReXLtofNQ/kSrhSNQrNRdpaxmFkV/T
 Frm4XVS2POJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNvQAKCRAk1otyXVSH
 0IjhB/sF1Ys0WLO7A1A82RVjg1EGqd6NKiYg5AvJPYIvoPas6kpQsDCY2maqTagJ+xiueDoTxRm
 HJ+ZMnY0BudQLN8nXcOQRjKKhn59JQHrd+pJp2OPk6mjp7ev5SCENSoVRunepqOEGx1Yid805UO
 +ikcucvpnAOHOhDQofC22vWssdqMANC0G2iE1fVRSVJy9f/Svs+TlZknaG1Psh6GoqBv65WFtAj
 8ZyObioXb69XxEJXUIGvn4HL40otAYtrv+4XDSkIS9qOt8NgMXM2iIzVSGDgNaMDRUyoplONbqH
 xY//UrwfZs8HibaGIExxej3MEd3vb49SGNGl3BJ+12BEj139
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


