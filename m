Return-Path: <linux-kselftest+bounces-33570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8299BAC1B54
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424CC1BA8162
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0C267B9B;
	Fri, 23 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op8RRRGe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2045253933;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975182; cv=none; b=pmI14zKwq2hN75Qgy8ih+B28S/y1AHY6ZjulH3PZV2nIZoL+4x7roVRH9WR7aj7wCHSi1Z6fXYmEYLlv9cjvTgmnpLhFP8soMtseB42KuiecIPxJ9UIacITmqMqcFn2sIEZvSZv3ewJQZgBnBbAXzK0bYWwerD5Cl/LtFO6DUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975182; c=relaxed/simple;
	bh=snrRkduazq+CuYpLqIIgLSyyFGO/4xQDvfJjkALfmd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1rYZnBTraNNC0QlrBw8jugg+gDaBQ32jCo6w5N4K+t6GHp/DsBu5hPbACot77idre5EnW3ONs568eOxr2Xa3Nky7p18mhr/bNAgn+qLqvcSQT0KGOASrqFbLDEGD70mi9za9PLK9vJsXL9TfaXl7gv1kUN3Gke9RhpA2KuDkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op8RRRGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3784AC4CEF2;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=snrRkduazq+CuYpLqIIgLSyyFGO/4xQDvfJjkALfmd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=op8RRRGe2/JON5AhouRE1uGu/0MQ6MJngswUtwTUCqRtXYGhN+/KMwsfK+InxrS/j
	 qVBI5FPdfZQsdd15OTbv5MfokKIPn3Jom9SYvVFRlUvJM+6byXz8hpvJnEUDE/eoC2
	 Fykfqq9R8Bgz7OPXG2c8og+uXdyuym0+B8zll4KTL4MLpoPnoSmk1fzWge/iYDnFwT
	 RpNM3JYC/cn/dKAymuALJKhBi5GY0ejseIQ9zPqp4Y4TLqiI49u5fGaBLSNpGn9dI9
	 1EiGxhtXGhxc6+9u34GU/yztyCegScP3oRdaK54o2i08c44La6Bv2YXhmPUOSt6Ojj
	 ExTH5vB4iW4Yg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 06/14] arm64: Handle KCOV __init vs inline mismatches
Date: Thu, 22 May 2025 21:39:16 -0700
Message-Id: <20250523043935.2009972-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=kees@kernel.org; h=from:subject; bh=snrRkduazq+CuYpLqIIgLSyyFGO/4xQDvfJjkALfmd4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3/OeF2xrGn/ecfjBwO7efZdOCt4+rf88t0n3N4wb Z+3/dJegY5SFgYxLgZZMUWWIDv3OBePt+3h7nMVYeawMoEMYeDiFICJ3LzFyHBy2+63G546VX1g 0Vi7P+DmOWnH15LfT2QGVG0KzD0V33ie4Z+ZkuwqZaEtna8zJ9x43F2j86WpmZGvafXnHuZ8IQF la24A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we
have to handle differences in how GCC's inline optimizations get
resolved. For arm64 this requires forcing one function to be inline
with __always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: James Morse <james.morse@arm.com>
Cc: Oza Pawandeep <quic_poza@quicinc.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm64/include/asm/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index a407f9cd549e..c07a58b96329 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -150,7 +150,7 @@ acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
 {}
 #endif
 
-static inline const char *acpi_get_enable_method(int cpu)
+static __always_inline const char *acpi_get_enable_method(int cpu)
 {
 	if (acpi_psci_present())
 		return "psci";
-- 
2.34.1


