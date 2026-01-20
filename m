Return-Path: <linux-kselftest+bounces-49554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBmkI6jTb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49554-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 20:12:40 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1B4A142
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 20:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C879580A715
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59D4657EE;
	Tue, 20 Jan 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="XLqCc38J";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="LheYgBBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE94657EB;
	Tue, 20 Jan 2026 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934853; cv=none; b=BsWgfzFLLhcXEufAf0ckiMcMPTkA8JiBT6u8dOgMdinW8/jGKSnvM20pKb1PudludjLhGhCI52TbxSJ/vb2FQNih/JDejWQGxU0nIiZZhYvJRYSLPRa+hyldVC2raWee25izLgNG0dcip1Fps5EgTLXHDeB+YM+lQpvIofDK8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934853; c=relaxed/simple;
	bh=hM2KyOMS+eZXsryzn7K/pMFBf7en3Cw/bkdHhsjjP9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2aG7XZQnruRmOKCNS7J4pa/6u5xBvyWdnK/TRO7/v6JeaOj4DT5oX/lH5dCU9wgiNsn9Roy3DV11tbabl1w2xqLV3AWvRPgcgHLq+/NSX1VGofeHJR3zLBxhj6nC3IVkhcSNCHJqfo4ISNXZOXKT8bGoJx+wiXGflUsO3facDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=XLqCc38J; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=LheYgBBH; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768934822; bh=WXZF1gl6PfUsJgVQx1bqUpP
	wsVJMNv3kZJHgA/2BkXA=; b=XLqCc38J0OkuJDIME3o9rzOtE4arZrmbq38pTvLVkHvYxj8egC
	GPSPxNf6gTktqsuMXc5xI0tsELckd89Xa3y1mw+ceGmNzCEHOsjXtbqIeFa0GmXLzXtemJSZAlm
	behRIXWGWoasO+QmIYAjBiVzNDXgMAbtVcocw6Kjyfr4R58wWZqnuQWhegUyw+igaVFBseu5OVD
	4jIMXeazYyuCKuVg+XH6M4mONhNBxhOMcmqDuo65EaPkSJVMsciQ6Q6gwtFjPvQRXx4qtS5m4lY
	6ZXx+E3DPgE+KyGBgq8DFtcGX8XEvuDiAcyFUybPPhHIoWRYS8QmYPikmhPeGOeeGyQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768934822; bh=WXZF1gl6PfUsJgVQx1bqUpP
	wsVJMNv3kZJHgA/2BkXA=; b=LheYgBBHnLa0Pd8LyzFiOQxK72DJqDmMfE1vFFxwhf5/jBJXoS
	9bMaT5OEQgtGS/acPyiytlw3Bj7FtRzrHGAA==;
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
Subject: [PATCH bpf-next v5 3/7] crypto: Add BPF signature algorithm type registration module
Date: Tue, 20 Jan 2026 13:46:57 -0500
Message-ID: <20260120184701.23082-4-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120184701.23082-1-git@danielhodges.dev>
References: <20260120184701.23082-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,meta.com,gmail.com,google.com,fomichev.me,gondor.apana.org.au,davemloft.net,vger.kernel.org,danielhodges.dev];
	TAGGED_FROM(0.00)[bounces-49554-lists,linux-kselftest=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[danielhodges.dev,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:email,danielhodges.dev:email,danielhodges.dev:dkim,danielhodges.dev:mid]
X-Rspamd-Queue-Id: 24C1B4A142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new bpf_crypto_sig module that registers signature verification
algorithms with the BPF crypto type system. This enables signature
operations (like ECDSA) to use the unified bpf_crypto_ctx structure
instead of requiring separate context types.

Changes:
- Add verify() callback to bpf_crypto_type for signature verification
- Add bpf_crypto_sig module with:
  - alloc_tfm/free_tfm for crypto_sig transform lifecycle
  - has_algo to check algorithm availability
  - setkey for public key configuration
  - verify for signature verification
  - get_flags for crypto API flags

This allows ECDSA and other signature verification operations to
integrate with the existing BPF crypto infrastructure.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 MAINTAINERS                |  1 +
 crypto/Makefile            |  3 ++
 crypto/bpf_crypto_sig.c    | 67 ++++++++++++++++++++++++++++++++++++++
 include/linux/bpf_crypto.h |  2 ++
 4 files changed, 73 insertions(+)
 create mode 100644 crypto/bpf_crypto_sig.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9b369acd1c..62d712a1f730 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4714,6 +4714,7 @@ M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
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
index 000000000000..1d6521a066be
--- /dev/null
+++ b/crypto/bpf_crypto_sig.c
@@ -0,0 +1,67 @@
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
+static int bpf_crypto_sig_verify(void *tfm, const u8 *sig, unsigned int sig_len,
+				 const u8 *msg, unsigned int msg_len)
+{
+	return crypto_sig_verify(tfm, sig, sig_len, msg, msg_len);
+}
+
+static const struct bpf_crypto_type bpf_crypto_sig_type = {
+	.alloc_tfm	= bpf_crypto_sig_alloc_tfm,
+	.free_tfm	= bpf_crypto_sig_free_tfm,
+	.has_algo	= bpf_crypto_sig_has_algo,
+	.get_flags	= bpf_crypto_sig_get_flags,
+	.setkey		= bpf_crypto_sig_setkey,
+	.verify		= bpf_crypto_sig_verify,
+	.owner		= THIS_MODULE,
+	.type_id	= BPF_CRYPTO_TYPE_SIG,
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
diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
index cf2c66f9782b..363ed72561f4 100644
--- a/include/linux/bpf_crypto.h
+++ b/include/linux/bpf_crypto.h
@@ -18,6 +18,8 @@ struct bpf_crypto_type {
 	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
 	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
 	int (*hash)(void *tfm, const u8 *data, u8 *out, unsigned int len);
+	int (*verify)(void *tfm, const u8 *sig, unsigned int sig_len,
+		      const u8 *msg, unsigned int msg_len);
 	unsigned int (*ivsize)(void *tfm);
 	unsigned int (*statesize)(void *tfm);
 	unsigned int (*digestsize)(void *tfm);
-- 
2.52.0


