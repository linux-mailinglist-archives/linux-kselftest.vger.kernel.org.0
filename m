Return-Path: <linux-kselftest+bounces-20199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7A59A5000
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 19:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CFD1F231E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDD4190684;
	Sat, 19 Oct 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GS/QyVEh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62D18A926;
	Sat, 19 Oct 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358716; cv=none; b=L5kF5xOIifgOEf1c6M05xVnGLLlKNYuZB522jeWAcf0NXfmgANDLw+D7XOeUtzJneYoDCCdU8RlRpNi4xlshzlMLqxfCaHqTBG8NOco3J6MpNYatkQyBqmMT7rLUaGmZlbqNHn7uumYL9FlXCjMTqnvzV3ZfCySMGjxjtWPEmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358716; c=relaxed/simple;
	bh=v6bvUMfXn6/3mzWN+Cxwfs5cIL8Ji6jRUR692F8s10A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOOCGQOK7zwt4J35kZ/H5bwRwxBH/oydW7sdmteP5LRhDwjNOM3dcsndmBTlLtzxuuA0QQWR9cX7t6wrKgrL/tism7ZOqAxAOYqt8GnFLuFKD983+da8ol6qfoRnC9OJi55QiKD9VAftwC5bXu9qIlU94jNi2+LxadS2ZD0S5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GS/QyVEh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=kKggqa/N3cJoVWPu+QTzfFDIYqmk6OrmEIUp4ZuSD8Y=; b=GS/QyVEhHGOm0rVGoOfSb/RPDe
	TWM88B2b0c3Zj45ybAA5PGOX8gxWdPPghlu7NZyCbLlmlyJXO/r/q0t/OHWpO/3/0Ia7XFuehHYGc
	9zCma/1bJW98TSPmeEbxkrXcq1m3hfDVfIhS5L04TPzjC2dJid5ZYP1szEc0G+b9maI7KD0IIA/62
	ZMeCfzkCB36fjp00xxl4OpqvYcOuk4rAJGxE4XSPbUu8nEdieX499tFOK8QpY0VD5t+dsD69sacx8
	l3AEiu43TCotBK8kcKVBppFCLfd0wco3j4xKh8NKXn7mcYkJpeAyRpSjzk8JOL4sdQ2aCa9vhO653
	7jlh/5FA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2DCK-0000000EUio-3ZcY;
	Sat, 19 Oct 2024 17:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t2DCI-00000009TKi-3TIz;
	Sat, 19 Oct 2024 18:25:02 +0100
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
Subject: [PATCH v6 3/6] KVM: arm64: Add support for PSCI v1.2 and v1.3
Date: Sat, 19 Oct 2024 18:15:44 +0100
Message-ID: <20241019172459.2241939-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241019172459.2241939-1-dwmw2@infradead.org>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
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

As with PSCI v1.1 in commit 512865d83fd9 ("KVM: arm64: Bump guest PSCI
version to 1.1"), expose v1.3 to the guest by default. The SYSTEM_OFF2
call which is exposed by doing so is compatible for userspace because
it's just a new flag in the event that KVM raises, in precisely the same
way that SYSTEM_RESET2 was compatible when v1.1 was enabled by default.

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
index df834f2e928e..6c24a9252fa3 100644
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
@@ -493,6 +493,10 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
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


