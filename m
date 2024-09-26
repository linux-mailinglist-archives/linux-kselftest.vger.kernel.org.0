Return-Path: <linux-kselftest+bounces-18414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92DC987944
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E5F1F226B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B110176FB8;
	Thu, 26 Sep 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nEHxsSel"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4F1D5ABC;
	Thu, 26 Sep 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376367; cv=none; b=NL4+n145l0ETkiZMuFlD0Sua1oDkXyjP95H0Jo1SGhhwsMoqKlL4bIBXAcQRHWdkxydYXEXoIPaMFV/0BIEZzUu5Bbg54wXp5vJAxqTrym4DnMG4YQb5SYWREfItest0SCyJ4T57VavnvvMmVNHmofUoNOxLGp4uFznOXsw+bho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376367; c=relaxed/simple;
	bh=+dCD6AZPxHSBa4BNwNlX6ikA85sfYkJhBtLZ/HQ4UUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCqM5hpQi5SV0/NLDspcW50vsIyEZS7+pTMkMtcWwrTrOjV5n+Zqk/w0tBQtVVC4H27IYP+s0nw0ZWFbde3/H/oy4biT1/DjSDLGFhfCkNDFBu0Y4jla0lv4DzAm8rgft4hJm4oxKGQG85tmWjRaOHSNzs2KsXzFgPWbOdEb5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nEHxsSel; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=t5+pyUN1sWxxhbIk0LBuAt0+sAfCDv06OwTbegq7gnw=; b=nEHxsSelvEuHOj/+u+QP04x/rg
	ZMwVJxdXDlmfvNpVkwJG9JFHbfTQFgFJbOtleuud8XJGM6EiYnd8GDqv0UXTQXljM5wqHghTX8kQ6
	WVZQw9FYrIqS6fe6uCNDZJrHngoeH6knJ9vDjB4Mjv8TPaVIkTT2nTXqNA16YosJIScRwuzW0RSZF
	ysj3OBkUwg+11dX8CqTbBn3b1KxvwnZW4hBgzFrykxfeX1sFZQfjk8Fq7iUUwT27/oScJyu32cJw7
	s9+2wA6Lin0bJTl3YV7cwRqHz7pVGhIaYCY3kZPN1K95IlNqjF9nIhcI4olCtIiBcKDT47YHzOElU
	dbLMEEdA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sttUq-00000007NA9-2Vg4;
	Thu, 26 Sep 2024 18:45:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sttUq-00000003Ybj-40qP;
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
Subject: [PATCH v5 5/5] KVM: arm64: nvhe: Pass through PSCI v1.3 SYSTEM_OFF2 call
Date: Thu, 26 Sep 2024 19:38:00 +0100
Message-ID: <20240926184546.833516-6-dwmw2@infradead.org>
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


