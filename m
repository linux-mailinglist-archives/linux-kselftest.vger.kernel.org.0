Return-Path: <linux-kselftest+bounces-37530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CEB09771
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BF01C476AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9E264616;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS7X/XTw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD254858;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794721; cv=none; b=XEbE4j6vtjrnKnID9d82PVIAhLO002LJPpjw2bx2QQM7vGHNZX+eXem6Ag1xbBRJCro572KS9SosYQIrl1UFcXzvLWfA0Cg5P+lzxw7srl2tE/gZOUyg2UtFf5KZcI7ZE4leJnGXDjBv9qyAxET0wvDiEkiGtD43LlPFFiDbFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794721; c=relaxed/simple;
	bh=snrRkduazq+CuYpLqIIgLSyyFGO/4xQDvfJjkALfmd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxeH6nZqF7VdY6gB/RSaG8Jeked+bxh20xv7my5dcF1r+8Yb3pfZirhwbWQaOyxk4rJ9LfcjPwvkUrVMIVFCD5Ak5G0iK2xr3c7qjAIQs1qfZtcNgb7sapFLD7EgpjJIQIG/U2BpXGwIfasVSdQ4rz9DE7ccvp3SS1uTXKufE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS7X/XTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E8FC19421;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=snrRkduazq+CuYpLqIIgLSyyFGO/4xQDvfJjkALfmd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NS7X/XTwq0SYtDmR92m6RT7w73OtZDj9VgWVVNVGKgedVVsfxXRvHZI9COauTBcNx
	 IJf8CoQ1ueF1UtsRpdaFdWjynKTuJMR7iOQ9dB5eXAoAKeEzLgmcrAYOMHhNhBuTFa
	 5L0IXxGJyWd/qnua1I3g1OrwQj49Kwe8UWc5GvvBBsfFg5fReai2QocNn2cQh6TSBb
	 DrdqpyazzU7lmZjFR0owNeQOna8O13p08uyB8LWCY4vmB6q6B0dWRv1mSb1aqKPkBf
	 HSq833cbvEh+Brue9gGKbgfS+iuAfT82TyUA3HF2JfEkEDQXirKBuf9wcMrILU5Y7z
	 a9/YWz+eqqRzg==
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
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v3 06/13] arm64: Handle KCOV __init vs inline mismatches
Date: Thu, 17 Jul 2025 16:25:11 -0700
Message-Id: <20250717232519.2984886-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=kees@kernel.org; h=from:subject; bh=snrRkduazq+CuYpLqIIgLSyyFGO/4xQDvfJjkALfmd4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbdEzXlcsa9p/3vH4wcBunn0Xzgqe/i2/fPcJtzdM2 +dtv7RXoKOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAiJpcZ/meVLTv9o6vkxY3d a25FeUnp7579w2v1S82fR+ZrWufbpk9lZHhUJ9F5q+Oy06z3YoGri0MTin/7rdDVqX0tLvSAqbR 2Lx8A
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


