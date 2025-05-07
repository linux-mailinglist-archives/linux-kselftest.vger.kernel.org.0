Return-Path: <linux-kselftest+bounces-32596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E894AAE8C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489C51893E53
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29928ECE3;
	Wed,  7 May 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Galm7MFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFC28EA6A;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641781; cv=none; b=stURnS3XjualfrlOAg9pyeiv2rfO0zYSsCij0s01hTZvi+p/GMWmenyy24P/O2r0BbpPUQ1+o7Krrq9JPtrE8DOOk8oLy87CMd/6fmTEjXoPsBksXQ6pdy3X4tOrcZhCBAjvmdoyQz0us7mi460J68WSQOBXqzt9CrmDIorTyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641781; c=relaxed/simple;
	bh=voDf6H+5x8ZJ+QNvLaKxp1ngBKm9HW1NaIJiF5gitL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFkY9HIWh3VTCI6kgf+2me7FoonsSnRm5LyJlYOK3V9hlRr7UFGWmtzuRxSRxcNRDhVZ99roVsvPisSJws4Gpu6gfvwlVEmaDsbwWDdN1eRX7jMe3E/JcnfMKxGcFjY8caLOXUpz3SSv3H3fc5lHoKeBlxEMmYZ9KiUl2NyFyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Galm7MFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B73C4AF09;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641781;
	bh=voDf6H+5x8ZJ+QNvLaKxp1ngBKm9HW1NaIJiF5gitL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Galm7MFzgJLnAO40Xck5MAyECjLHydu6iGER9PypizD509zMeOB/4tfpj2XjlmQbB
	 4sJSSWPSoYH2FAb4h4V4vRe/L+lulz2GTN4v/Qam2C9/DeU1Bc8Uzld3CWYqu8eTHE
	 ir4Pl2cYuXKEoHsR2jmnso75ptgZHUGanjNsz9duDft9vH/aJOHXDvqz/1SMQ0iyPU
	 VZ9BQLpS2AN4I80976dcubo05dYAgXIT3H4E5hXAHvFZ//fta2lERW7Te6m4xgSwyy
	 s1ccWzl/5WcaoZIMRaGu2tuqeIfrQ9EmgUOzjHXkyfA7J+ftgXLoofKE0fbhmo7/Np
	 xSnh6mmNFLhLw==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
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
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 7/8] configs/hardening: Enable CONFIG_STACKLEAK
Date: Wed,  7 May 2025 11:16:13 -0700
Message-Id: <20250507181615.1947159-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507180852.work.231-kees@kernel.org>
References: <20250507180852.work.231-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=kees@kernel.org; h=from:subject; bh=voDf6H+5x8ZJ+QNvLaKxp1ngBKm9HW1NaIJiF5gitL0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi3NndCfFZfNKLYsNrJ26vcOTL89ba72XzNPJVjs9u S6YOVh0lLIwiHExyIopsgTZuce5eLxtD3efqwgzh5UJZAgDF6cATKTsBiNDx94c+e3PfryMY4kJ m5dxOLHrbdTcm/xLJ6UelLZ+09L/heG/q46Tus+VBTWHLX+eee7NGPv0yjELoStvXEK7Fl3oXvG DBQA=
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
index dd7c32fb5ac1..3da00926b4eb 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -63,6 +63,9 @@ CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 # Initialize all stack variables to zero on function entry.
 CONFIG_INIT_STACK_ALL_ZERO=y
 
+# Wipe kernel stack after syscall completion to reduce stale data lifetime.
+CONFIG_STACKLEAK=y
+
 # Wipe RAM at reboot via EFI. For more details, see:
 # https://trustedcomputinggroup.org/resource/pc-client-work-group-platform-reset-attack-mitigation-specification/
 # https://bugzilla.redhat.com/show_bug.cgi?id=1532058
-- 
2.34.1


