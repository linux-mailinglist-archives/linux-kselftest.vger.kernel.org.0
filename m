Return-Path: <linux-kselftest+bounces-20203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658909A5019
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 19:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1072881C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E137193417;
	Sat, 19 Oct 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XzGlFbWx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCAD18DF86;
	Sat, 19 Oct 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358732; cv=none; b=GPrlsSeFkoW4UkSmph93GhShvV/IK4IqKMdeKFzTCHktiXWJoGYVTe+TLnKw8LZmcgm7EtMvOvoLPlncU3Xu0QQE7yKvhSbwemnyINN9wgC/QLZIR57YBF5LsKZKdXm+ZHzG2l8iDI1seBGcA2Ck3AxovWyqjPD8TxaPRWAcKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358732; c=relaxed/simple;
	bh=GAwiRUme3l79armWjPCTT1xL7TWZdYQrkokP+tBs6xQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMe+MaBYhTq0cS7pdGkcB13FCWnS5rayQSaIkPQxzJmWEGgwP01HUHk1frK5xxAJwH/5umw7ju1XPULe6rIb24e3vBw//uwTUWAt0+5I6gihsbkW5BXjtrB4ZPUxz4BaOiR0+xtIhVFe5qTqz0GtnwNRl0CW/umh9pPjZk9oUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XzGlFbWx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=dgOa7g3zajQLpd5LE62QUGty2o4u6sxV9PdYHjxAfec=; b=XzGlFbWx89wH/Hwr4VFywS7iRy
	UkBHnYBAN0gqrQSfLligxN8doifFp8nQM/JkfDAiuCDUs9nTloQXWsEENhsW591tkwqZS1smmDjxq
	IE4baRNi425eXqxZk1Euqd3gQMxGNG9UREgt+rsiQZleSd2JYkbNFguG27JA0WKqeNQVcYcu+JS33
	nc+SPrbSqpVJvHn5tAhhAoNAO2J8T5wNKdBwtPakGmscIp7xNkEqDk6Yp95y2/vvVkiglssnEcrUl
	9Zyv+p/yON8qkZOpAs0fNzdILJPpjWG7V7eesdNM6WUfCk3DPStY7VxUnUeKi0wZcPjfmQ7UI2ABm
	EaDMZKJQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2DCM-00000007ZXd-32pz;
	Sat, 19 Oct 2024 17:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t2DCI-00000009TKb-3CtK;
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
Subject: [PATCH v6 1/6] firmware/psci: Add definitions for PSCI v1.3 specification
Date: Sat, 19 Oct 2024 18:15:42 +0100
Message-ID: <20241019172459.2241939-2-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The v1.3 PSCI spec (https://developer.arm.com/documentation/den0022) adds
the SYSTEM_OFF2 function. Add definitions for it and its hibernation type
parameter.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/uapi/linux/psci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 42a40ad3fb62..81759ff385e6 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -59,6 +59,7 @@
 #define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
 #define PSCI_1_1_FN_MEM_PROTECT			PSCI_0_2_FN(19)
 #define PSCI_1_1_FN_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN(20)
+#define PSCI_1_3_FN_SYSTEM_OFF2			PSCI_0_2_FN(21)
 
 #define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND	PSCI_0_2_FN64(12)
 #define PSCI_1_0_FN64_NODE_HW_STATE		PSCI_0_2_FN64(13)
@@ -68,6 +69,7 @@
 
 #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
 #define PSCI_1_1_FN64_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN64(20)
+#define PSCI_1_3_FN64_SYSTEM_OFF2		PSCI_0_2_FN64(21)
 
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
@@ -100,6 +102,9 @@
 #define PSCI_1_1_RESET_TYPE_SYSTEM_WARM_RESET	0
 #define PSCI_1_1_RESET_TYPE_VENDOR_START	0x80000000U
 
+/* PSCI v1.3 hibernate type for SYSTEM_OFF2 */
+#define PSCI_1_3_OFF_TYPE_HIBERNATE_OFF		BIT(0)
+
 /* PSCI version decoding (independent of PSCI version) */
 #define PSCI_VERSION_MAJOR_SHIFT		16
 #define PSCI_VERSION_MINOR_MASK			\
-- 
2.44.0


