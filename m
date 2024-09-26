Return-Path: <linux-kselftest+bounces-18418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E8987953
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294871C21A6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9B184543;
	Thu, 26 Sep 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/3Pzpez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A017BECD;
	Thu, 26 Sep 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376369; cv=none; b=m9jq9ffKOiWp4ZZMjqantkHKRaLcWS3Yl5GYqAM8KGsHr1bnE28x0qXPx4hDIhPujMT9e3D4jmuxXBK/htHw5NnFvyH/s5RwSR3r465NmMuha0DLnbdKa5YRPWiN18jYqSETyQn5TyXfzkBoGK110kR1c3MVmuneoUyiE+Uk7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376369; c=relaxed/simple;
	bh=LX+diJ7M2E4ujM5KwD7j5MZK13pg812LqbEv4+Py5+k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYMIrw+Lshb70Qfaxli4tk3ivNv0cIKHbdbZ71ySSamMtT7SH02B3k6XC7Vlyl+u9BRaN3Qf/LriiZYE8c63SoWj3lEohSS/ibBgG8J+ogFRlJMwqeb6DxDsKYcg24PGXQydw9vubaOcxYvm4n4E40wpspi76HzcXIfw4gA+BBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j/3Pzpez; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=fzYnC4u4lNGhcwCgM7TOwvzsrVSzF8ITtilKodkz3e8=; b=j/3PzpezeRmihjXkNTbbwCiHzL
	RhJX75tWpppEMEGuop3VDWZiIC0Qd8uxyqp7vcq+st9rQvkZ++FWOXnNszfUKqM1luvs32cz2dQNX
	PyJTyGWZ/LvG92VAFnP8T3MMkriz+iSkULkyCyl2wO8B7fHWQsMiF3KWc4X6Wvu86Nc05E42FPwV0
	LiIx+K5klsGLS4fczdLeV1ai47lZB+pRr1fStKJ086/CO0YmD7m97fwHyye0oF2iyaBJTO+P24Ui8
	Y42vkjjzk9YSjP4QlfLxOcYJV6t98Jpy1w4MzIceMnPjHat2s/8jUKMdh+t9yZr6a7zJt582az+EP
	ow2TjdAQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sttUq-00000007NA6-2HA6;
	Thu, 26 Sep 2024 18:45:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sttUq-00000003YbU-3f0M;
	Thu, 26 Sep 2024 19:45:48 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: [PATCH v5 3/5] KVM: arm64: Add support for PSCI v1.2 and v1.3
Date: Thu, 26 Sep 2024 19:37:58 +0100
Message-ID: <20240926184546.833516-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240926184546.833516-1-dwmw2@infradead.org>
References: <20240926184546.833516-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/kvm/hypercalls.c | 2 ++
 arch/arm64/kvm/psci.c       | 6 +++++-
 include/kvm/arm_psci.h      | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 5763d979d8ca..9c6267ca2b82 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -575,6 +575,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		case KVM_ARM_PSCI_0_2:
 		case KVM_ARM_PSCI_1_0:
 		case KVM_ARM_PSCI_1_1:
+		case KVM_ARM_PSCI_1_2:
+		case KVM_ARM_PSCI_1_3:
 			if (!wants_02)
 				return -EINVAL;
 			vcpu->kvm->arch.psci_version = val;
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index fd0f82464f7d..5177dda5a411 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -328,7 +328,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 
 	switch(psci_fn) {
 	case PSCI_0_2_FN_PSCI_VERSION:
-		val = minor == 0 ? KVM_ARM_PSCI_1_0 : KVM_ARM_PSCI_1_1;
+		val = PSCI_VERSION(1, minor);
 		break;
 	case PSCI_1_0_FN_PSCI_FEATURES:
 		arg = smccc_get_arg1(vcpu);
@@ -486,6 +486,10 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 	}
 
 	switch (version) {
+	case KVM_ARM_PSCI_1_3:
+		return kvm_psci_1_x_call(vcpu, 3);
+	case KVM_ARM_PSCI_1_2:
+		return kvm_psci_1_x_call(vcpu, 2);
 	case KVM_ARM_PSCI_1_1:
 		return kvm_psci_1_x_call(vcpu, 1);
 	case KVM_ARM_PSCI_1_0:
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index e8fb624013d1..cbaec804eb83 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -14,8 +14,10 @@
 #define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
 #define KVM_ARM_PSCI_1_0	PSCI_VERSION(1, 0)
 #define KVM_ARM_PSCI_1_1	PSCI_VERSION(1, 1)
+#define KVM_ARM_PSCI_1_2	PSCI_VERSION(1, 2)
+#define KVM_ARM_PSCI_1_3	PSCI_VERSION(1, 3)
 
-#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_1
+#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_3
 
 static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
-- 
2.44.0


