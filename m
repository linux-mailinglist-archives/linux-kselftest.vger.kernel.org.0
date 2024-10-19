Return-Path: <linux-kselftest+bounces-20197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3ED9A4FFA
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE828183B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620218DF86;
	Sat, 19 Oct 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NXtDHAde"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509102F3E;
	Sat, 19 Oct 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358716; cv=none; b=Jaf/CINGk5VxzWpIJ/nT/PgUV3UQCL0lqC7rp7jK91lRL4ZbR7k8kP9OjB/OILX2auebJlYXkLDvfhgq3Emu0PAw5IIAwqbRQJws0mD1t4FtsPmUEpxMTb6BMd8OMXihH7dy/3naf+Pe9vL6UJ04OwUzDlSSIlFytr3LzCPT01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358716; c=relaxed/simple;
	bh=+dCD6AZPxHSBa4BNwNlX6ikA85sfYkJhBtLZ/HQ4UUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRgXvYzQUSQEEtQHAB8vXhxCEgKozHq6O1EAnQUi+TNA3rsyo/5UtRENKdbRLJ80DAVBd9L7BC0aJU9Bi94PKbkp0M7Q3dhTES6sNVHTDdaONNExpKg76aQF3GplqeQnjnIAJcP2ekXcCaT/JJr4aHXgf+K2Qs3QQcC9BpMBnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NXtDHAde; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=t5+pyUN1sWxxhbIk0LBuAt0+sAfCDv06OwTbegq7gnw=; b=NXtDHAdee2SOC8yqbljv7R9G0n
	fLJMcC5TekKlUvBLG37AOwDrqSQ9ifslDuYS5b6FwSUJ5Lx8UNZq80+6dj7eJ2B4DBV166kE6CKPX
	41zQd35sNHNwjrdHoGumwg6s5YTR9fUbpeKa0oIHKRdCoI8IY//K6tu1oMMlDOIZ7qrGTuht5ktVm
	TnaDsDem59Rd8yJBks7/89ePQCc9xE+AskMwKsNRxwACHWhIZPs2iuXTBkquI6iESpvyUKW4S19uW
	Vq+wJ7kxTnEJ2xk4cdWjxsfSJIwsuOuCjm+HhT/DwgK9NgwB8938MlIJgxqAfFRXyZL0+nhKlxCeN
	pNbH41ZA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2DCK-0000000EUip-3chn;
	Sat, 19 Oct 2024 17:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t2DCI-00000009TKs-3jv4;
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
Subject: [PATCH v6 5/6] KVM: arm64: nvhe: Pass through PSCI v1.3 SYSTEM_OFF2 call
Date: Sat, 19 Oct 2024 18:15:46 +0100
Message-ID: <20241019172459.2241939-6-dwmw2@infradead.org>
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


