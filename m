Return-Path: <linux-kselftest+bounces-47135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4973CA8B34
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA38A30F2789
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A953431EA;
	Fri,  5 Dec 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="JwxejCwJ";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="sjmP2N5W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C57341040;
	Fri,  5 Dec 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956429; cv=none; b=FGXUmA9DfWJM662c7Me0HoZvzjMLjsFXP8Um9pz9ulVIWTjzhRT30XPDmedF9kH6vwpkmqqdc5d5tOFuO+jTOA7HbgjQJGegCKWgs7D7wljLfKEglPcf4f0c5ezzcKZOhZZrIR7LVm6UhyxAouHCmM+/cey5EeSNZ+bEQwgKMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956429; c=relaxed/simple;
	bh=C79LJkVJls9DlmpOEN66nhgyRQkT+HWCWZ8ASZfSeqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaWYlQH1f+XPuDclBKXoRCEIjhk8jAdz5yxRQyZCw0woTjcjMDUZ4CPDfS1Kxt2rql9FZzFYwYNZBgqZ1zvcVfeDCHSk53g1VHwBiaXly72XegRQdCBFxC7TbZAFHXWmsOx3dfqOmXoPjmGpc3ZTJclzafae+/fB458O1gxYMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=JwxejCwJ; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=sjmP2N5W; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956364; bh=de5Cgh+qm/fEZLkzMZIwXEb
	z0LNQmq+/Xuc11Hm0Ck4=; b=JwxejCwJ1ThNryW0OK4n4fnS6wF5vq9TChGbunhSyYpP+zJUx7
	AJJB6XakMJgvJixFX70mt9q1s+PKJNVK4sdfqzew4uT+6yRrXCzTQdvhNSJq3CgaQH9GWQ8SqNz
	BTgXOaHJ8KzrV5A66fjHUV6IZAdtbicUtebDhnm185YmPQJXvCINiIU5f+lWiF5UObHQ81QYGvf
	pCXviIHtzzr6TpZtTFzZtfSZHjI10UtoRjK8/DIaSPA3jko8L6psBjurGD8z61tJ0RQjOfuM8Cc
	8itykqqYP+/CXrdx7vZBcaegYmiYYVYZraJxKyQCJls/OZSDZC+PxBjNFpNDoNiGl+g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956364; bh=de5Cgh+qm/fEZLkzMZIwXEb
	z0LNQmq+/Xuc11Hm0Ck4=; b=sjmP2N5WxoJELwi+wYf3O7HW8dmKQQz2ni3aeI1Nyr+gx7vjpf
	xyVmZ1lCw7Hj1F2Rc72FooN+M85HtY1idZDw==;
From: Daniel Hodges <git@danielhodges.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	vadim.fedorenko@linux.dev
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v2 1/5] crypto: Add BPF hash algorithm type registration module
Date: Fri,  5 Dec 2025 12:39:19 -0500
Message-ID: <20251205173923.31740-2-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205173923.31740-1-git@danielhodges.dev>
References: <20251205173923.31740-1-git@danielhodges.dev>
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
 crypto/Makefile           |  3 ++
 crypto/bpf_crypto_shash.c | 94 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 crypto/bpf_crypto_shash.c

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
index 000000000000..39032e7dd602
--- /dev/null
+++ b/crypto/bpf_crypto_shash.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
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


