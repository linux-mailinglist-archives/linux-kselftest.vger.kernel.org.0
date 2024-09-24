Return-Path: <linux-kselftest+bounces-18310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2D984919
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B74B1C21D88
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103301ABEDF;
	Tue, 24 Sep 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g3XaFWO1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5D1AAE39;
	Tue, 24 Sep 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193934; cv=none; b=afqVl813ySgpgWrGFbPQ6zaVY2yGYixauL5pvQnGy+rzj797S+NQhNINH/5sTQotkF+Q9nIuK/+5npBYXLgxmd1pATqeu1lVfm+jG1DrA6kU3toY8ZBjvD1d3+BGYNw4Hog36TNgZ8/wlJ908jTliTH4610F6yjr4iFyBd/BWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193934; c=relaxed/simple;
	bh=DLpACTWgg6UtjxsumUlE13iTjn9+HG31gwbzCwRyKA0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JSGdtyrD3unDD4+y+P80aoWbgHH2HGLTvPUC0nhZ7HdwM8M2Slsyvns+VDLe/Nzw6smpVku4tJQHa62dbw+PUWoOsnhOlk1n5ZIQkPg3UJJjspLvlnzmy86Kzn/f7i2aqnx0HXJwWvCLFdopX6rrY+pCW4YGMFzNXOcLdedtpW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g3XaFWO1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gpbsniFgtOHZgJp8y3v9VSnosB7+jAV6rr5l+o89n6M=; b=g3XaFWO1202OH9wg8+ui4k8BIq
	89Dv4D35YFZdKmNtpcLAnPnyrwiJP3Bk/fe/WDOqIc0R6r9eMwvwIfvA58vUbCchjXD93242mOhic
	ugZ1O+TKxyFgFTK7lY8G7r6tbLD/VpgeAbFHEH89FDn0vmPP4h/kgeooTWbvd+QHCjiRJbRANdrW/
	oaOzLHqfvFP9dkzAjAlP20hVHc3g8hZWSPzuXd/LMrdK3zRJ8j+4pS2wW7vCLS9vY/nEzhR3mVvrP
	jOmt8gC7Wh8Eau7tACXrWLuHwUxnWhERpKDa48bxFvhBJKFXKaphLfuN6N/HkswkSIZLKTmqwlAqA
	y1hE4yug==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st82K-00000001vkN-3jSP;
	Tue, 24 Sep 2024 16:05:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1st82K-0000000HMiM-1Pnb;
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
Subject: [PATCH v4 1/6] firmware/psci: Add definitions for PSCI v1.3 specification
Date: Tue, 24 Sep 2024 17:05:07 +0100
Message-ID: <20240924160512.4138879-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
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

The v1.3 PSCI spec (https://developer.arm.com/documentation/den0022) adds
SYSTEM_OFF2, CLEAN_INV_MEMREGION and CLEAN_INV_MEMREGION_ATTRIBUTES
functions. Add definitions for them and their parameters, along with the
new TIMEOUT, RATE_LIMITED and BUSY error values.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/uapi/linux/psci.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 42a40ad3fb62..082ed689fdaf 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -59,6 +59,8 @@
 #define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
 #define PSCI_1_1_FN_MEM_PROTECT			PSCI_0_2_FN(19)
 #define PSCI_1_1_FN_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN(20)
+#define PSCI_1_3_FN_SYSTEM_OFF2			PSCI_0_2_FN(21)
+#define PSCI_1_3_FN_CLEAN_INV_MEMREGION_ATTRIBUTES PSCI_0_2_FN(23)
 
 #define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND	PSCI_0_2_FN64(12)
 #define PSCI_1_0_FN64_NODE_HW_STATE		PSCI_0_2_FN64(13)
@@ -68,6 +70,8 @@
 
 #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
 #define PSCI_1_1_FN64_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN64(20)
+#define PSCI_1_3_FN64_SYSTEM_OFF2		PSCI_0_2_FN64(21)
+#define PSCI_1_3_FN64_CLEAN_INV_MEMREGION	PSCI_0_2_FN64(22)
 
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
@@ -100,6 +104,19 @@
 #define PSCI_1_1_RESET_TYPE_SYSTEM_WARM_RESET	0
 #define PSCI_1_1_RESET_TYPE_VENDOR_START	0x80000000U
 
+/* PSCI v1.3 hibernate type for SYSTEM_OFF2 */
+#define PSCI_1_3_HIBERNATE_TYPE_OFF		0
+
+/* PSCI v1.3 flags for CLEAN_INV_MEMREGION */
+#define PSCI_1_3_CLEAN_INV_MEMREGION_FLAG_DRY_RUN	BIT(0)
+
+/* PSCI v1.3 attributes for CLEAN_INV_MEMREGION_ATTRIBUTES */
+#define PSCI_1_3_CLEAN_INV_MEMREGION_ATTR_OP_TYPE	0
+#define PSCI_1_3_CLEAN_INV_MEMREGION_ATTR_CPU_RDVZ	1
+#define PSCI_1_3_CLEAN_INV_MEMREGION_ATTR_LATENCY	2
+#define PSCI_1_3_CLEAN_INV_MEMREGION_ATTR_RATE_LIMIT	3
+#define PSCI_1_3_CLEAN_INV_MEMREGION_ATTR_TIMEOUT	4
+
 /* PSCI version decoding (independent of PSCI version) */
 #define PSCI_VERSION_MAJOR_SHIFT		16
 #define PSCI_VERSION_MINOR_MASK			\
@@ -133,5 +150,8 @@
 #define PSCI_RET_NOT_PRESENT			-7
 #define PSCI_RET_DISABLED			-8
 #define PSCI_RET_INVALID_ADDRESS		-9
+#define PSCI_RET_TIMEOUT			-10
+#define PSCI_RET_RATE_LIMITED			-11
+#define PSCI_RET_BUSY				-12
 
 #endif /* _UAPI_LINUX_PSCI_H */
-- 
2.44.0


