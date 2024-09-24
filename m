Return-Path: <linux-kselftest+bounces-18315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30639984935
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621201C23174
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C81AF4F6;
	Tue, 24 Sep 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SqrifSr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8091AED4B;
	Tue, 24 Sep 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193940; cv=none; b=PZ3wnRTAlc/IXBt1b14kyM4YN4WT19fNdwQluRNRw5Ohsy5JmK7CDZlLcGKQWl9SP/zPF95H6ZaYfh6QF2jL7LUOhWtNt1AlvQQfjQPID5vh6+IgOUW1fRVpVRmPwC+bBAl3nADhfRFHZVt7g8VLNXHRli8L6E5J8OJc+JNUfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193940; c=relaxed/simple;
	bh=+dCD6AZPxHSBa4BNwNlX6ikA85sfYkJhBtLZ/HQ4UUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDftWAfv750EfMX/D0P2SFG5Beg5UpTWBbNMJpmRWwfahCt6Ryn3kf/9fy5NNqBzO2CdZevDPER48QQNLFiJeoWaghSIdnVa13BqKRsM6mObjMITUBoQeIRrtPQnxuL0b+tXtNnzn2XwPPNnk0vRcYyWBxnHfZzZjGZXqwVY7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SqrifSr/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=t5+pyUN1sWxxhbIk0LBuAt0+sAfCDv06OwTbegq7gnw=; b=SqrifSr/tEv8jnFCYNFNx3/YmZ
	Kkt032r9r0wenz0aCjKI1DSvYmf/VUhMQKWHZhOZGDKey+AZF5IH9w7uYNQYYYDtz9ktFu53a0DiH
	N4mM9zVgKzjsy8vv2Ss1dviOU6xVhBwKDszipzrh2x84rTupqE0ovsIe0WXbAa1I9YkVpAH/y5hj3
	dwcZeVCsiMrnX5KJQiKnnPoDPmSwo+Fc7JYHYjvIrag0kUAI7ucdyODPXx/hy8YteNLadRfL0IWp4
	jMLxRo2LW+LlXWmLN60ubf63vV7Gbgf2Lg90RwJPfiOx4nRE/aLE/9qPo3K7LgZZd+RFG0ljYvIAI
	twADzPSg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st82M-00000001rIZ-318G;
	Tue, 24 Sep 2024 16:05:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1st82K-0000000HMic-2I4e;
	Tue, 24 Sep 2024 17:05:12 +0100
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 5/6] KVM: arm64: nvhe: Pass through PSCI v1.3 SYSTEM_OFF2 call
Date: Tue, 24 Sep 2024 17:05:11 +0100
Message-ID: <20240924160512.4138879-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240924160512.4138879-1-dwmw2@infradead.org>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Pass through the SYSTEM_OFF2 function for hibernation, just like SYSTEM_OFF.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index dfe8fe0f7eaf..9c2ce1e0e99a 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -265,6 +265,8 @@ static unsigned long psci_1_0_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_1_0_FN_PSCI_FEATURES:
 	case PSCI_1_0_FN_SET_SUSPEND_MODE:
 	case PSCI_1_1_FN64_SYSTEM_RESET2:
+	case PSCI_1_3_FN_SYSTEM_OFF2:
+	case PSCI_1_3_FN64_SYSTEM_OFF2:
 		return psci_forward(host_ctxt);
 	case PSCI_1_0_FN64_SYSTEM_SUSPEND:
 		return psci_system_suspend(func_id, host_ctxt);
-- 
2.44.0


