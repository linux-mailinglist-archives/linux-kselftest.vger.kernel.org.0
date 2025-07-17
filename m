Return-Path: <linux-kselftest+bounces-37538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B708B097B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2112C1C45AA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8336C27F00A;
	Thu, 17 Jul 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsqjdsQS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562B262815;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794721; cv=none; b=PiJRkhooH1afwxsGdRJtuJVFE3DqlgG7AI9TroXDp/yph8CMNKuju6ggm8ARMrrayQicXusKR0cds2LuGaBPaBITdLuDFTqWZH0sIJalo/+GUEcEplXK7bH2m9hbkozArmO03lB0uGlln1UZ7V4DXjmxi4TzNgwtRrQ1X0KPpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794721; c=relaxed/simple;
	bh=hftQ+JwDBzI0zRNacsurrBG64kHnxlfHAL+GJc3UtlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pcPO4mDGdAafO2KAr6atUTCti74qydyxJ6nmOzgaMho8DxAcr78PKStlTjaAzOCcU/cECwuP1PqMOjaEuOEGX1fIKApCyMu6XWlMFAoEqCRgOGxwpR/kSqaGUaLTL3PNgJDt9Qqmsy0ssHkUbnKAro2cp/9wWK7ZkAW5IxVeAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsqjdsQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B589AC4DDE4;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=hftQ+JwDBzI0zRNacsurrBG64kHnxlfHAL+GJc3UtlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsqjdsQS75ijp4EewZkFNnZ7oGWM+bQuK2TZnkPG1i4tUtkePSQGvhT3cJzizICIP
	 n7VsETLWXSDSuNlB4j5w4GFk77PgUesXjhwz6yMoT31mNWaWjswPyAxrArx7XoTrzv
	 qwRQ4j9gCoTu0mZgFXm9mV43Qt0uBu3ieYyCdmQG53nX22891/8O+gwogWE5UBED26
	 ScLxadVl8C+/OHTvTZH1MoVS2hlIEz8r+PE+d+h/fgLqGQh1uU2RoHTiTONCiUEx+a
	 5pAsMwG5Sv8s6jqrUJ/cIcIw1BL4yue1cJRn64/wKIgKX5LH0prSsOZ29wNitGYIID
	 IN144gC7uUisA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
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
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 12/13] configs/hardening: Enable CONFIG_KSTACK_ERASE
Date: Thu, 17 Jul 2025 16:25:17 -0700
Message-Id: <20250717232519.2984886-12-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=kees@kernel.org; h=from:subject; bh=hftQ+JwDBzI0zRNacsurrBG64kHnxlfHAL+GJc3UtlU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbbFBctklSlm/hUWtYmesmm/+4Mz/o2oveebseJx+3 f2N065JHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPZrM/wT/+s9b/zj2UjKz2d 0opOWQdaqM192v1qrb5mpnFiz/LKFYwMM5YFnp723f9/aP7hJMnrxuH6yRfrcxYbWx+zavrULTm NDwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since we can wipe the stack with both Clang and GCC plugins, enable this
for the "hardening.config" for wider testing.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: <linux-hardening@vger.kernel.org>
---
 kernel/configs/hardening.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index dd7c32fb5ac1..d24c2772d04d 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -63,6 +63,9 @@ CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 # Initialize all stack variables to zero on function entry.
 CONFIG_INIT_STACK_ALL_ZERO=y
 
+# Wipe kernel stack after syscall completion to reduce stale data lifetime.
+CONFIG_KSTACK_ERASE=y
+
 # Wipe RAM at reboot via EFI. For more details, see:
 # https://trustedcomputinggroup.org/resource/pc-client-work-group-platform-reset-attack-mitigation-specification/
 # https://bugzilla.redhat.com/show_bug.cgi?id=1532058
-- 
2.34.1


