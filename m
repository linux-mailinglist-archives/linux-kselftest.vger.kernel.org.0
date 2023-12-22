Return-Path: <linux-kselftest+bounces-2378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955EF81CCB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532EF283153
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443125116;
	Fri, 22 Dec 2023 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1ANtrRl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105E250F1;
	Fri, 22 Dec 2023 16:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B0DC433CB;
	Fri, 22 Dec 2023 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262100;
	bh=w5s2jNG9BPYWmFf0oI6jWuVaNSklZF3unJXgGkHvqHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k1ANtrRlavK3s44CoVjHxAxI+CJZORR0VmcMLjzrTwi71cQFbyZdFTUiWEEevefc2
	 dzvtPDFtq3S5WWI3JOb76jre/BU/CBMNe+FAQ+TvJWHdrmqhbmIInnkpbpBwqHRF/A
	 fkMc5S0IlzJwJOLQQaYfnLZnE0Aaf7x5j44VXVqTyh5e+Ssh9+9XDCY+buxC01R7aw
	 CbxgpvWEuIIKukLDrODQARbw++h8ufszffex3Rw50sc3SKl2xBbInKoDPa9P7yNsBr
	 jKa5x3KiaXuu9qlhrqYu7L2HqxxKXOkAhnltMbsMdBWkqT+2HX5XeqXxRSHZjJJVUL
	 KMTj47h7vnz8Q==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:09 +0000
Subject: [PATCH RFC v2 01/22] KVM: arm64: Document why we trap SVE access
 from the host
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-1-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w5s2jNG9BPYWmFf0oI6jWuVaNSklZF3unJXgGkHvqHE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbd8Ij+o8u6u46M60Ux7jRqjnVI6Jb42lELi9pfS
 MpNWCyCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3fAAKCRAk1otyXVSH0GURB/
 wPw0RwCu5zmRSv09pjcXbn0EfE4bQeUkt57Cyn7kfGPSsyMzsFsOzriP+sDaeIsSkCiO6M0TqBmxno
 sIp9VOfqtQ/MWErps9PRlmYoUwaRSfWDui7ZdFKlKxl1TYTNTMvCKpTkFqHpCOdKrH+OJ4765+k5YY
 s4sOF50vQ5ZZbDb6W940BL2aks/AOgCcAn+ELj1o4Kq+J5jAKyNUK2UkAjhzzgB/ze55lj2uMcYsn9
 WEOO8O6j6i0uortkPVUl17ZxU27r8jeO2maAgW6vl3OMHBdIan5P5fVXhKNcMPCLJMEz0KBW2duJw4
 ji+FJ1MAX80G1KtuyoO11HAYBO4a0l
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we exit from a SVE guest we leave the SVE configuration in EL2 as it
was for the guest, only switching back to the host configuration on next
use by the host. This is perhaps a little surprising, add comments
explaining what is going on both in the trap handler and when we configure
the traps.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 78a550537b67..14d6ff2e2a39 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -598,6 +598,7 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 	} else {
 		val = CPTR_NVHE_EL2_RES1;
 
+		/* Leave traps enabled, we will restore EL2 lazily */
 		if (vcpu_has_sve(vcpu) &&
 		    (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED))
 			val |= CPTR_EL2_TZ;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2385fd03ed87..84deed83e580 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -420,6 +420,7 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 		handle_host_smc(host_ctxt);
 		break;
 	case ESR_ELx_EC_SVE:
+		/* Handle lazy restore of the host VL */
 		if (has_hvhe())
 			sysreg_clear_set(cpacr_el1, 0, (CPACR_EL1_ZEN_EL1EN |
 							CPACR_EL1_ZEN_EL0EN));

-- 
2.30.2


