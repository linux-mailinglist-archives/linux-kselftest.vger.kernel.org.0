Return-Path: <linux-kselftest+bounces-48225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6115CF512A
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E553081E50
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510E933B6F0;
	Mon,  5 Jan 2026 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="pmldrgkC";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="dJtnKrWx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E033890E;
	Mon,  5 Jan 2026 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635025; cv=none; b=MMS4cqveAUtnI1wgVuXJA//oG6ZdRv14UYu0whfQQ+sBICS2whHMVEIuIUUu3WlqQosHO0b80xtt5MlIKoBWMqQd47BKsPOlKOQ3WRi0UHclRI166MW6j0wzgWlO9HX2XrzdW3BkxaliwpxnCdss/x92Yxa1DTaNsKnoKZxOBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635025; c=relaxed/simple;
	bh=CCLSrVcQQdLtKMevZOtc1V0zWYDen3Yz71UZ/CUV9bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUxg5SMoy4eRdiabI1qr5Vt6q15/WAHTu7UcwYxsm6kKB+PLj22tth9FMl1UAAdxTF3n/Ci6kh5Fok3LnjS3ywkfvc7Tpptlxdy/+VLwoTunn8XsO0m/ZRATzotJhrLsKo5/+GwAsjgMdP7jtT5iFg1GlhwNoIBOaaA3emF0C6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=pmldrgkC; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=dJtnKrWx; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634676; bh=27Bq5HOhFwej0EJiEqS0MFP
	4ZRLAKVJI/s2j8DhSHkA=; b=pmldrgkC9WVB/NZIuV6rfjzTgLSQr4mNfSbBXJu/kOTxKc7/jG
	m4yglgu59SzefXr+s1HpB6EVVxtPP+roN1x2CM/vMBy/C546sUjzDFkKmPUZOkVxNJMdCU6J8ZS
	zI6lU+JAi1h/X+jS88Q12XKgeLU8Muw4mfuwAZxhipakkqMq+Jg9eL/riBxbcq8iA0QfyH14kVz
	BNTciMiyzmXfxAJkOLGfgG61UnPVlNlK3VLGDOoncaTpeouHWcfBHagswYbid/CaZWU6YT7ZxAh
	0jiWSIV+L9DZ5iyXOgIJTA+1MBwbAJcBuXswGF+VxSQ+SC/Sd7FUms86mKkF7bCmPdg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634676; bh=27Bq5HOhFwej0EJiEqS0MFP
	4ZRLAKVJI/s2j8DhSHkA=; b=dJtnKrWxVXyKcpvQgI044R9GQaPvZ2ZK4p1KzgUQl4FcneIINh
	XNl88fa0nb0o6LgzO05SdqFIba8qugJ/HUDA==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Song Liu <song@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v4 2/6] crypto: Add BPF signature algorithm type registration module
Date: Mon,  5 Jan 2026 12:37:51 -0500
Message-ID: <20260105173755.22515-3-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105173755.22515-1-git@danielhodges.dev>
References: <20260105173755.22515-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new bpf_crypto_sig module that registers signature verification
algorithms with the BPF crypto type system. This enables signature
operations (like ECDSA) to use the unified bpf_crypto_ctx structure
instead of requiring separate context types.

The module provides:
- alloc_tfm/free_tfm for crypto_sig transform lifecycle
- has_algo to check algorithm availability
- get_flags for crypto API flags

This allows ECDSA and other signature verification operations to
integrate with the existing BPF crypto infrastructure.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 MAINTAINERS             |  1 +
 crypto/Makefile         |  3 +++
 crypto/bpf_crypto_sig.c | 59 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 crypto/bpf_crypto_sig.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 05e0aee5693c..fdf451bad869 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4713,6 +4713,7 @@ M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	crypto/bpf_crypto_shash.c
+F:	crypto/bpf_crypto_sig.c
 F:	crypto/bpf_crypto_skcipher.c
 F:	include/linux/bpf_crypto.h
 F:	kernel/bpf/crypto.c
diff --git a/crypto/Makefile b/crypto/Makefile
index 853dff375906..c9ab98b57bc0 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -36,6 +36,9 @@ endif
 
 obj-$(CONFIG_CRYPTO_AKCIPHER2) += akcipher.o
 obj-$(CONFIG_CRYPTO_SIG2) += sig.o
+ifeq ($(CONFIG_BPF_SYSCALL),y)
+obj-$(CONFIG_CRYPTO_SIG2) += bpf_crypto_sig.o
+endif
 obj-$(CONFIG_CRYPTO_KPP2) += kpp.o
 obj-$(CONFIG_CRYPTO_HKDF) += hkdf.o
 
diff --git a/crypto/bpf_crypto_sig.c b/crypto/bpf_crypto_sig.c
new file mode 100644
index 000000000000..ad0d3810df8e
--- /dev/null
+++ b/crypto/bpf_crypto_sig.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/bpf_crypto.h>
+#include <linux/crypto.h>
+#include <crypto/sig.h>
+
+static void *bpf_crypto_sig_alloc_tfm(const char *algo)
+{
+	return crypto_alloc_sig(algo, 0, 0);
+}
+
+static void bpf_crypto_sig_free_tfm(void *tfm)
+{
+	crypto_free_sig(tfm);
+}
+
+static int bpf_crypto_sig_has_algo(const char *algo)
+{
+	return crypto_has_alg(algo, CRYPTO_ALG_TYPE_SIG, CRYPTO_ALG_TYPE_MASK);
+}
+
+static u32 bpf_crypto_sig_get_flags(void *tfm)
+{
+	return crypto_tfm_get_flags(crypto_sig_tfm(tfm));
+}
+
+static int bpf_crypto_sig_setkey(void *tfm, const u8 *key, unsigned int keylen)
+{
+	return crypto_sig_set_pubkey(tfm, key, keylen);
+}
+
+static const struct bpf_crypto_type bpf_crypto_sig_type = {
+	.alloc_tfm	= bpf_crypto_sig_alloc_tfm,
+	.free_tfm	= bpf_crypto_sig_free_tfm,
+	.has_algo	= bpf_crypto_sig_has_algo,
+	.get_flags	= bpf_crypto_sig_get_flags,
+	.setkey		= bpf_crypto_sig_setkey,
+	.owner		= THIS_MODULE,
+	.name		= "sig",
+};
+
+static int __init bpf_crypto_sig_init(void)
+{
+	return bpf_crypto_register_type(&bpf_crypto_sig_type);
+}
+
+static void __exit bpf_crypto_sig_exit(void)
+{
+	int err = bpf_crypto_unregister_type(&bpf_crypto_sig_type);
+
+	WARN_ON_ONCE(err);
+}
+
+module_init(bpf_crypto_sig_init);
+module_exit(bpf_crypto_sig_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Signature algorithm support for BPF");
-- 
2.51.0


