Return-Path: <linux-kselftest+bounces-48229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF80CF515A
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705533031357
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD932F77B;
	Mon,  5 Jan 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="SOjOeS5d";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="cTswnLwF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFF1C3BF7;
	Mon,  5 Jan 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635259; cv=none; b=VLFIkl413pxqeZBr6GWk/juvJSt7KDCeX4Ft5KQIp62RN+7R3FYKhrVVR9BX5/gu44Jdr+pexfvfPANt087F3+YZxQJFywrPEZ20ilSpNVNSHz77A2guupiSmgNC4p/9fapJfUcabHiNB/NOWN8GFVp/7eqkqrtHM15enwKQUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635259; c=relaxed/simple;
	bh=wirrKdUILPa+ztEIgAAZT9tqHv9j2vrUAip4DfwBiuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGfE5OCgEj3K4aQ6WrH5ecNPvNbOhBB8ARLSOfR6aG5UoGZ4nMd56DeBkPj0ZhdIsCu1BeLuIsoyDCNFCERkJeIP57Wq88SkcjX18c4VF6l4RpbxZh04ZmaTZW+3/o2b7mDlk5GjEnIzx2xU3LmrOE7qdN7E7rnLzP/OcI/A8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=SOjOeS5d; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=cTswnLwF; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634676; bh=4RFsQG38WUaFBQCY8IsR0nQ
	s4fmT2fb1harffXkZ3+Q=; b=SOjOeS5d0Joldy7ixTWiryY6+PhZ7Cyd+Hdh7pOCR+PaItZecM
	gvSB4wjcR07uLSzt9mU+0taiX4/Ey1ZuySFQ6aWyJWl+b8XwGCDqqMMGEr79R5QWYJEpZa8cLqs
	6fe5uuy7Nu1POaRCuehk5gmvtsWmQLN78B6EiGNq7oU9KXvSmPUuEAvD8RBKdCHakrprSq9E0ue
	0P2gBe4mwyl0QIie0PP6jJ5+rz0ZsLOxYCP1WSBwLuYDS/cPbU43+cnt4+HHrMqfVPtwofFuoWf
	LL5Z9wzPVJ1VzeLyZ00qDuQj2P501jG7UKqhMrRXKBNdZyhhJfL/F7NEEL7jtmg4YcQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634676; bh=4RFsQG38WUaFBQCY8IsR0nQ
	s4fmT2fb1harffXkZ3+Q=; b=cTswnLwFl3a4OxJh/0Ynnwofzfws5qYC+jaUAKQByZPQluwJqL
	EBjY7kViMDeDTqezYczIT5tJHQG5vgUZnpCg==;
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
Subject: [PATCH bpf-next v4 1/6] crypto: Add BPF hash algorithm type registration module
Date: Mon,  5 Jan 2026 12:37:50 -0500
Message-ID: <20260105173755.22515-2-git@danielhodges.dev>
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

Add bpf_crypto_shash module that registers a hash type with the BPF
crypto infrastructure, enabling BPF programs to access kernel hash
algorithms through a unified interface.

Update the bpf_crypto_type interface with hash-specific callbacks:
   - alloc_tfm: Allocates crypto_shash context with proper descriptor size
   - free_tfm: Releases hash transform and context memory
   - has_algo: Checks algorithm availability via crypto_has_shash()
   - hash: Performs single-shot hashing via crypto_shash_digest()
   - digestsize: Returns the output size for the hash algorithm
   - get_flags: Exposes transform flags to BPF programs

Update bpf_shash_ctx to contain crypto_shash transform and shash_desc
descriptor to accommodate algorithm-specific descriptor requirements.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 MAINTAINERS               |  1 +
 crypto/Makefile           |  3 ++
 crypto/bpf_crypto_shash.c | 95 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 crypto/bpf_crypto_shash.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 70c2b73b3941..05e0aee5693c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4712,6 +4712,7 @@ BPF [CRYPTO]
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
+F:	crypto/bpf_crypto_shash.c
 F:	crypto/bpf_crypto_skcipher.c
 F:	include/linux/bpf_crypto.h
 F:	kernel/bpf/crypto.c
diff --git a/crypto/Makefile b/crypto/Makefile
index 16a35649dd91..853dff375906 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -30,6 +30,9 @@ obj-$(CONFIG_CRYPTO_ECHAINIV) += echainiv.o
 crypto_hash-y += ahash.o
 crypto_hash-y += shash.o
 obj-$(CONFIG_CRYPTO_HASH2) += crypto_hash.o
+ifeq ($(CONFIG_BPF_SYSCALL),y)
+obj-$(CONFIG_CRYPTO_HASH2) += bpf_crypto_shash.o
+endif
 
 obj-$(CONFIG_CRYPTO_AKCIPHER2) += akcipher.o
 obj-$(CONFIG_CRYPTO_SIG2) += sig.o
diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
new file mode 100644
index 000000000000..95c178ec0ce8
--- /dev/null
+++ b/crypto/bpf_crypto_shash.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/bpf_crypto.h>
+#include <crypto/hash.h>
+
+struct bpf_shash_ctx {
+	struct crypto_shash *tfm;
+	struct shash_desc desc;
+};
+
+static void *bpf_crypto_shash_alloc_tfm(const char *algo)
+{
+	struct bpf_shash_ctx *ctx;
+	struct crypto_shash *tfm;
+
+	tfm = crypto_alloc_shash(algo, 0, 0);
+	if (IS_ERR(tfm))
+		return tfm;
+
+	ctx = kzalloc(sizeof(*ctx) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!ctx) {
+		crypto_free_shash(tfm);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->tfm = tfm;
+	ctx->desc.tfm = tfm;
+
+	return ctx;
+}
+
+static void bpf_crypto_shash_free_tfm(void *tfm)
+{
+	struct bpf_shash_ctx *ctx = tfm;
+
+	crypto_free_shash(ctx->tfm);
+	kfree(ctx);
+}
+
+static int bpf_crypto_shash_has_algo(const char *algo)
+{
+	return crypto_has_shash(algo, 0, 0);
+}
+
+static int bpf_crypto_shash_hash(void *tfm, const u8 *data, u8 *out,
+				 unsigned int len)
+{
+	struct bpf_shash_ctx *ctx = tfm;
+
+	return crypto_shash_digest(&ctx->desc, data, len, out);
+}
+
+static unsigned int bpf_crypto_shash_digestsize(void *tfm)
+{
+	struct bpf_shash_ctx *ctx = tfm;
+
+	return crypto_shash_digestsize(ctx->tfm);
+}
+
+static u32 bpf_crypto_shash_get_flags(void *tfm)
+{
+	struct bpf_shash_ctx *ctx = tfm;
+
+	return crypto_shash_get_flags(ctx->tfm);
+}
+
+static const struct bpf_crypto_type bpf_crypto_shash_type = {
+	.alloc_tfm	= bpf_crypto_shash_alloc_tfm,
+	.free_tfm	= bpf_crypto_shash_free_tfm,
+	.has_algo	= bpf_crypto_shash_has_algo,
+	.hash		= bpf_crypto_shash_hash,
+	.digestsize	= bpf_crypto_shash_digestsize,
+	.get_flags	= bpf_crypto_shash_get_flags,
+	.owner		= THIS_MODULE,
+	.name		= "hash",
+};
+
+static int __init bpf_crypto_shash_init(void)
+{
+	return bpf_crypto_register_type(&bpf_crypto_shash_type);
+}
+
+static void __exit bpf_crypto_shash_exit(void)
+{
+	int err = bpf_crypto_unregister_type(&bpf_crypto_shash_type);
+
+	WARN_ON_ONCE(err);
+}
+
+module_init(bpf_crypto_shash_init);
+module_exit(bpf_crypto_shash_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hash algorithm support for BPF");
-- 
2.51.0


