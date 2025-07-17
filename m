Return-Path: <linux-kselftest+bounces-37535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15DDB09785
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4794A772F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F626E700;
	Thu, 17 Jul 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDQPJoue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FF262FFF;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794721; cv=none; b=UM1oaHxt+lyXIxtkUqw2rLm+2YrrjkeGSPyWU4+JHxKSSn+NTuX+qbWDkygzTidXgKih7YrmEzqXqeH0t26tvnMCvIzJJxwbMPVbtFU781MGptJJV+dSGNs26xWtoVlTfyQ7oIOkZpSUy5HoxTrefjYDv6SZr8Dgj+Ar5k/n+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794721; c=relaxed/simple;
	bh=qfrc6vYarbMRQKv1a7xZvSfoxfkNIKlLJL8wJGuWS5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DC7zM2wkAME8tBtzUxE4DKbcl5Wt/itdtLMY0Hz6lg2GVQ5ao6jQlrRAKGGXvdeT3iyuPFBKgWPixL9z57mxDPFmId4QrOudHc0a43xy5fJq3yJrb/kB7Okj/6W+GQ9gryOmHfi54EWliGLOCgsb1lBB8Ul/yqRaS09EziZ2+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDQPJoue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75F1C2BCC6;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=qfrc6vYarbMRQKv1a7xZvSfoxfkNIKlLJL8wJGuWS5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDQPJoue8FZRuS/LJrGq2GchrAASLibnSmGeRRoSUGpvH3awBC+7kUb1yyaVYH89y
	 ULfO45CeKqJRVGvpXRA0BcyHOvq/18F0odTwMODSsaKPhyZ6a5RObjGBHyzV8F/o67
	 bRdab3eThDwtbXMkLCf7OvDiOrTOIwe/+HGDzhnD0XxLPtqyR6jgFUfqETsGM1mdv+
	 bnFaNOMq8O4teU/HwNwUrtNBKmLU5MLmrmRF+Dfv34p8l9jQ3mz2PYnKIToPImVNxa
	 KM1ucd9mD0unIDTP+r5FbWZidX3EtXT5OQTFbfBDNgNkXEVraPMIWLffBOUAzwljDl
	 L3ZGqkwchCdPg==
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
Subject: [PATCH v3 13/13] configs/hardening: Enable CONFIG_INIT_ON_FREE_DEFAULT_ON
Date: Thu, 17 Jul 2025 16:25:18 -0700
Message-Id: <20250717232519.2984886-13-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=kees@kernel.org; h=from:subject; bh=qfrc6vYarbMRQKv1a7xZvSfoxfkNIKlLJL8wJGuWS5I=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbbGrLRYky9XJyFyITXiqam157PKKj7mdDyYc/Xw7s uRv7WSGjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkc62Vk+Hwt/L3Rbm1tn84l unrT0jgulm5lD+LgcnL+WfbLeJOREcN/7/17erb+Zmw+2dikfKTxS9XuurzmRR6/80+FfF6/xlG FFQA=
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
index d24c2772d04d..64caaf997fc0 100644
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


