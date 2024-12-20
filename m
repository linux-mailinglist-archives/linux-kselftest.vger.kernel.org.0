Return-Path: <linux-kselftest+bounces-23674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40AB9F96FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A516E087
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F82206B5;
	Fri, 20 Dec 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLhYu+o1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08121B1A7;
	Fri, 20 Dec 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713484; cv=none; b=mW3y8eYWls8YRmklBi8I1HEuDqaBzIV6jh5ucNixzQPtLkdks8/5YapbLi1zVJylV2XHva/DrmJ4RW8m/b8/VweTchi3R+sf28k5wCu7L4xrPji5IgnTkluVYf/MRfw5uZkGn5tY6B1CfFgHXKpVDrU/HShufzlIsy5lQzKUOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713484; c=relaxed/simple;
	bh=a+yncXwMMueTmbDqZnDIxIoJ5xsyf/PU5pYLC6ZbRbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWlM12fL2EQ0A9XRbPK5VVZooKDKZLEWs0OQpeKxNNY4BjFxUOPUadzBD+JB/tv7P7ZkyQ4dKX1YIkKGCYOl9BG4nN8lW7mCUebRPiGsBST3U0sjfkDizkmKYMKKnUDYkBsc5MAXKbcu+7JC9OKmhsA8E69pwh40PRkhL9uenAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLhYu+o1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7A3C4CED3;
	Fri, 20 Dec 2024 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713484;
	bh=a+yncXwMMueTmbDqZnDIxIoJ5xsyf/PU5pYLC6ZbRbM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vLhYu+o1l++cILw7iyIVCcLat3F3ew01Ad54HxoZ0pxbH6rThGz/L0017gDWjF0Te
	 2dsAfTr8PLX+dlbs/lw6y+VBYIILA/8P6jovxfMPegV5yFcjF14U1UvdVGD7jL8f73
	 xwpkqjohLRCroOVtSg0rhhqL5tuTq8e8tSFGANkEH/3xgEMf3iz3fPW5W5WyHfMb13
	 XoKFe3Aba1VLOG+VjFFcL7zslcQ+OGdwUErrh0dZc9tFWio/bUfXnnVo3X4TY6EzJW
	 2PXEDecDpmzbhMkIiwKCs+s4zXLdWAGtEDKNHbB1pVUEMKbgGGpL+adtC/HI4R7tF+
	 x48mrTY9irCgg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:32 +0000
Subject: [PATCH RFC v3 07/27] KVM: arm64: Convert cpacr_clear_set() to a
 static inline
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-7-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a+yncXwMMueTmbDqZnDIxIoJ5xsyf/PU5pYLC6ZbRbM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBZdrU2V+OphtPgF7NwJy6uVDv4tmY4K7qACS27
 7872fXSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgWQAKCRAk1otyXVSH0BvtB/
 wI5sZMQ9hxIxROX5W9UZZrhMrY9fD+KkpsCZhFytntZ+8JR14prgNoUKPp3948eBLgtc15UJFySKGQ
 Ndru+92DG2ZY0Jfpg8pOhwNHdNFRf7i8iy3x6NzdfOWsfqsFgHVk4qGK9zhmwxyzl84dDIWHGhpD6e
 aRNiSuALRNHMgpvN3KbhOIO2wOCiR1eJz6gqILHINr0Cx6I7KcuiDQ4ryhz0W6rq+fPlwFLAM8lKW4
 grkNv1hEE5V4XG9cdtv5p0H99/KNSRxF0mf2l92afCdiNeSWHOqx3stkBvfaEzA96MuM5jrGDz875+
 KAGD/VaHBJfxPDBer/1e77U+E3qsCQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently cpacr_clear_set() is defined as a macro in order to allow it to
include a number of build time asserts that the bits being set and cleared
are appropriate. While this check is welcome it only works when the
arguments are constant which starts to scale poorly as we add SME unless we
do multiple updates of the system register.

Convert the function to a static inline so that it can accept runtime
variable arguments.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 2d91fb88298a263dcd73a4269318f8edf1379650..5f05da7f538d29d321c424233f21b8448d8b4628 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -592,24 +592,15 @@ static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 		cptr;							\
 	})
 
-#define cpacr_clear_set(clr, set)					\
-	do {								\
-		BUILD_BUG_ON((set) & CPTR_VHE_EL2_RES0);		\
-		BUILD_BUG_ON((clr) & CPACR_ELx_E0POE);			\
-		__build_check_all_or_none((clr), CPACR_ELx_FPEN);	\
-		__build_check_all_or_none((set), CPACR_ELx_FPEN);	\
-		__build_check_all_or_none((clr), CPACR_ELx_ZEN);	\
-		__build_check_all_or_none((set), CPACR_ELx_ZEN);	\
-		__build_check_all_or_none((clr), CPACR_ELx_SMEN);	\
-		__build_check_all_or_none((set), CPACR_ELx_SMEN);	\
-									\
-		if (has_vhe() || has_hvhe())				\
-			sysreg_clear_set(cpacr_el1, clr, set);		\
-		else							\
-			sysreg_clear_set(cptr_el2,			\
-					 __cpacr_to_cptr_clr(clr, set),	\
-					 __cpacr_to_cptr_set(clr, set));\
-	} while (0)
+static __always_inline void cpacr_clear_set(u64 clr, u64 set)
+{
+	if (has_vhe() || has_hvhe())
+		sysreg_clear_set(cpacr_el1, clr, set);
+	else
+		sysreg_clear_set(cptr_el2,
+				 __cpacr_to_cptr_clr(clr, set),
+				 __cpacr_to_cptr_set(clr, set));
+}
 
 static __always_inline void kvm_write_cptr_el2(u64 val)
 {

-- 
2.39.5


