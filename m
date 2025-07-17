Return-Path: <linux-kselftest+bounces-37533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9617AB09778
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBD4A776C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D5826A0B1;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NteDUBwa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB125DD1C;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794721; cv=none; b=uYejgms/uMdlS4T9KehWCIJqjLV7JCCdcnyz2KBiAVZd4daRCyOAGp8MxeG4jW4JiYXFsnCD4ACquB6DIHChWcQS+URHuvwbkGZNS69IuNNTv4Wx2mDRvXMZnMf/9WeJn7iUAabgN50+2YoMdwJXaSi/pPE8whTQvKSfgAyEJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794721; c=relaxed/simple;
	bh=2ug/lH8nh3wdYXaBdZPOL2AvIMcZUPQ6EhDC2jpITSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLt9ZWDjSQnqG5JLeuiCbTlReGNNCa40eJEkCgiivrDkUABvEjkqLIsG1UYe/zJbR5bZaWrz9VospUonKoHP179Hf1jN+rVYz5T8LcvHPxLb7x9yIiURP0hIvBV3S1FVbNgOSMm1icDLOaXXrKkxKUuZbUMwjugcu6qyCz2P/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NteDUBwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBF8C2BCB1;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=2ug/lH8nh3wdYXaBdZPOL2AvIMcZUPQ6EhDC2jpITSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NteDUBwai+jItLwcpYckNP0xUiUtzclbkaFWn020YjQgwFVuyGGWrARl8Vn8ogjbU
	 HA7N6JUbwARRKiomN6gJkMEtj3ziS/fItDI81YF+wfJMRXtKK3j0GP8SF0gvhoO51X
	 oCI2fsMsgsVBz/v7awiAMsuOKmnfKRD72nOBmmxlXSV9CvjEStIWVUPEtq6gBKTXfH
	 f9qwUWBwEQ3d6FAPVDsBxaPct1USs9Cn4jw01nkaUPzrxrGxP/fXlkew24VQuyaEGH
	 PVVayYayn3gDzPIYcf1Hm8MivLp/HLHtpzhQm2HDSnwA74AgKf1aZYpvBe0CeBN0Zw
	 F8AX99YLu6fsw==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
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
	linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v3 09/13] mips: Handle KCOV __init vs inline mismatch
Date: Thu, 17 Jul 2025 16:25:14 -0700
Message-Id: <20250717232519.2984886-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=kees@kernel.org; h=from:subject; bh=2ug/lH8nh3wdYXaBdZPOL2AvIMcZUPQ6EhDC2jpITSk=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbTEaTpwT/CqkP/gFhCj/XO54+7qYREShYs8l04cXr l6frm7XUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMBEtE4b/Xqd+XFyVnrjymfWn 4Kf1C05k68rFv26yrf/i2iH18eJ2SUaGV0lMd+enHioMXSjkm7z02hWe6SLiP1bPKvlVrXb+1vx GFgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we
have to handle differences in how GCC's inline optimizations get
resolved. For mips this requires adding the __init annotation on
init_mips_clocksource().

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <linux-mips@vger.kernel.org>
---
 arch/mips/include/asm/time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index e855a3611d92..5e7193b759f3 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -55,7 +55,7 @@ static inline int mips_clockevent_init(void)
  */
 extern int init_r4k_clocksource(void);
 
-static inline int init_mips_clocksource(void)
+static inline __init int init_mips_clocksource(void)
 {
 #ifdef CONFIG_CSRC_R4K
 	return init_r4k_clocksource();
-- 
2.34.1


