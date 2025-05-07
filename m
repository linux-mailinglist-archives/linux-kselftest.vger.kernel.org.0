Return-Path: <linux-kselftest+bounces-32594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A03AAE8B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461519E09E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934F28ECD8;
	Wed,  7 May 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7UcDZXd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA728EA67;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641781; cv=none; b=jVfbP6shB6V7NU47m7AmYI/Fzmf0BJJT+lWwKs9m7FmYAtFHO9vHrfiaImI/DxlBl94jT6jz4/FcTHjMzxmFtS3YPX2sjgvpU3YbQ+i5Gfr0ky1HKxGPIqH1NUIKRYvZLwPnWhw6fwIjii67K88Bc8a9N4NzEr1l0a1AvEBXtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641781; c=relaxed/simple;
	bh=JBC57/AJ4s9wnqVrwmV7BOpA+2zHUnfcHWTkMgWl8NU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMLQaUh6HZR6PpwPPpeR0Ohfra6/Ue1MWAamPikBBPFSpYHKmlQ60SUOtnE9GsF9gHiwA8iDL0i9VLUkfWKJuE5V5GjNhUcZFBwPSL/J64QtRy9P2nJj0/qASzfKRnbt5mToWMtAOKGKenK2KyBZm6tqDz21VcndrYLw4c+M5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7UcDZXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB66C4CEE2;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641781;
	bh=JBC57/AJ4s9wnqVrwmV7BOpA+2zHUnfcHWTkMgWl8NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7UcDZXdXjx3KZ0l3mLTB+csre7VN6l1usVAnFYpDApDPAm06prvBdEhlADnkW6qA
	 6Ct662+QPW0P+8F0Oa58tF6i9aT/9MCvBj/FBr6/uU/vhZiR6R4zBCfysEenLCqUrE
	 6tHqabUzR/N/LG6jfquCv4eWd3RJ/h4rXkS1TFORy7r97wCz0ABguF/eGnXxW8zxIz
	 ljfxv6OYRJ3vkc045YYhxP1/yI3w0ca03pTUHUMVgH8UIKM6xE/RhL/CRvTjpi4qn3
	 JyQH3je+lX/JEdGO+Fm75JCf/UdhCxfXNlzSyJ5TaUdz+qFXxrtWxAwoV/tmvZGTYw
	 KMyTgtIMShNuw==
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
Subject: [PATCH 8/8] configs/hardening: Enable CONFIG_INIT_ON_FREE_DEFAULT_ON
Date: Wed,  7 May 2025 11:16:14 -0700
Message-Id: <20250507181615.1947159-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507180852.work.231-kees@kernel.org>
References: <20250507180852.work.231-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=kees@kernel.org; h=from:subject; bh=JBC57/AJ4s9wnqVrwmV7BOpA+2zHUnfcHWTkMgWl8NU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi3OdD7t0n7oULsejGJ/+9MQm/geGMg9cz00Vqajg/ sTnY3e9o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJToxkZNsxfvyhx39Nzpiyy k1d9mfdaZ2I4d4Fed23ppfk+FmvT+Bn+V65ZP6cwRVHDaFl+g9uJIPvmT50TbXLDqlrmpn0pTfX nBAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To reduce stale data lifetimes, enable CONFIG_INIT_ON_FREE_DEFAULT_ON as
well. This matches the addition of CONFIG_STACKLEAK=y, which is doing
similar for stack memory.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: <linux-hardening@vger.kernel.org>
---
 kernel/configs/hardening.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 3da00926b4eb..7d92a740e490 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -60,6 +60,9 @@ CONFIG_LIST_HARDENED=y
 # Initialize all heap variables to zero on allocation.
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 
+# Initialize all heap variables to zero on free to reduce stale data lifetime.
+CONFIG_INIT_ON_FREE_DEFAULT_ON=y
+
 # Initialize all stack variables to zero on function entry.
 CONFIG_INIT_STACK_ALL_ZERO=y
 
-- 
2.34.1


