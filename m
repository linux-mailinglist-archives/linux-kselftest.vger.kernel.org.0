Return-Path: <linux-kselftest+bounces-33573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899AAC1B79
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6AA434FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9A271442;
	Fri, 23 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE7AaIXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23825E454;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975182; cv=none; b=rG6w8oOd8GvilpRJYgPAwX09d30+tNZZoprXDu+edojXXEmiHLbgNakNnSsb5o1rsY6nEzb2e1gF9zVhVU9uUm87XUSrx/9JwsLmRmPVfG4T30hXU8iDmpDm4EUK/DNZj4mm4s9OAdG1wLPS0xhNKylORArQsL8qyxtYcFB50oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975182; c=relaxed/simple;
	bh=Jd/sB6oZ8iltvnfrQDqGbUKjd0Ro3QNhdkLI+vDUogY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGyxhPh79+kjRujVjrYEGo5MrFNLa/E0TzSfcIWKN4lTE8TejhJoS4KFUzm5oHGatzgr4rrG9RQv7sr2evfgJLy60ClHqUcoSJuOIMkeTUpYA52Q/Ih+oJ74Pgvc5Hl/nU+WpXxjzyqeN4fmyNOC1rTCG1ykDcDJp0fSFouBEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE7AaIXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D20C4CEF6;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=Jd/sB6oZ8iltvnfrQDqGbUKjd0Ro3QNhdkLI+vDUogY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uE7AaIXpwC5UwsMRJ69CQY6UitGX9wnySf5tVkqGdVEf3R8NkbsWcogYuMzwCIPjU
	 PKOIlhjPY7eZqWnbn23WMH4eVsoeXc2gpbWtUYAl5lScvcTQhwCu+WHQ/weTwqFkY1
	 MKtNJT1gy9Ua87vncd628DzNyGV+pLo4o1GRdtLgYU4s0pK+yl1CFQL8tjutl60QfX
	 UIedCQqD0fEMZOR1fqZKF/lfM5q1EcIFwL7VMYlAEDzsOkmVJtO4+AOBJmSkAdh3q9
	 IX5DyMtDuEsfAVFqKg+pGrxwAZJxoDombtDDeetPTNkmjyHD7gtG+v5lDEGWWpUAoR
	 uheAXE53E4XBw==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
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
Subject: [PATCH v2 09/14] mips: Handle KCOV __init vs inline mismatches
Date: Thu, 22 May 2025 21:39:19 -0700
Message-Id: <20250523043935.2009972-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=kees@kernel.org; h=from:subject; bh=Jd/sB6oZ8iltvnfrQDqGbUKjd0Ro3QNhdkLI+vDUogY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3/Zi0kce6axcl3IlGXXv7dekvhyRPSBTort1tP1K SyVtX0ZHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOZysfIsPL2U8Z//9ZLv1JP aV33p2xj+sPc5oXl284XsjnqZc1ZtpPhf9Cv8pC7KxeE36nZ/nr2m3tGE9NjZ03f/PFc35H9N+K yTLkB
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we have to
handle differences in how GCC's inline optimizations get resolved. For
mips this requires forcing a function to be inline with __always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <linux-mips@vger.kernel.org>
---
 arch/mips/include/asm/time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index e855a3611d92..044cff0e0764 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -55,7 +55,7 @@ static inline int mips_clockevent_init(void)
  */
 extern int init_r4k_clocksource(void);
 
-static inline int init_mips_clocksource(void)
+static __always_inline int init_mips_clocksource(void)
 {
 #ifdef CONFIG_CSRC_R4K
 	return init_r4k_clocksource();
-- 
2.34.1


