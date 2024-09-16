Return-Path: <linux-kselftest+bounces-18032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F03979CED
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A920D1C2228C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD5142633;
	Mon, 16 Sep 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DICbBf7z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4538DC7;
	Mon, 16 Sep 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475919; cv=none; b=PZCFdy59NJPwdoCVRVUUMx6oVjOrZ03plN+OyNIMEOCvF9ht3Vc+KpPBtcH3uUV3mRoNWvwsRgTVxh6C/syirDKP/GLFlJoW8OQd6+3RnGzB4eHGCGsfjUWn/LiC7HWLMoR0q9DleowxjaiUx4A2dgKHmvkftPJZW3hVQY3nHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475919; c=relaxed/simple;
	bh=hnYsaY4ArRVZ0vA9lxq6XcYJDOSjVPfcF66iEimF3fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBJDpPR7n3TLnjjq9ZniXtBN0Cx33fOx7MNUn0B7x0B0cSrKqNN5CvVmJfEnNz87VlVxTN/gvi6LRptyFuVp7lhWc8v6XtwlsrozvPgBJCP1bzfUbb1C85fV+8jZ7NpvjbNB5ybo5kTICg4IBkx/PRJYo/bGZOoJfcmhjCW65/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DICbBf7z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c1324be8easo3760095a12.1;
        Mon, 16 Sep 2024 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475917; x=1727080717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jfGPHKhnArhWe//HHrhWb4kbGv+7BR1DBlzgNaCkDE=;
        b=DICbBf7zEHZ1dWPGu9SAxNJ23S0Ubw1zWir82pNWEkoAcZrpYoCokXqOorynZtG0Yh
         63jen/YxZ/2VYCnH6iqSxY16PbBpb2AOiO+jsgGca+kQ2V/fcr051TyX4Fm+bIndYZdQ
         6BwyGeqbTu4Z16x9c2xipRnQFPPmY+rLrdQGMVOJVjAAenlJpyZDcIZqNsJoZQGKu8Op
         oqRUNdSWLnDEqdNi52GwN5Ek8akHNMJ2casHSJ+3sCT4tTmiZahMfqfeMDL7E1nEwhbs
         asXW6o7S4T7UeJHHnOg33ZN3Z4nEyxrp3aVpygYYAglv4lX+wwNZ5gae0kWaiynJOSRm
         UyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475917; x=1727080717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jfGPHKhnArhWe//HHrhWb4kbGv+7BR1DBlzgNaCkDE=;
        b=X2uGUk3sUmpu+LFlBAKojo56dBoJhjVOEZG/ybACOzgthZR83t6GD6zXt+Qdk6kURC
         fa9tBGGkaEjDZJ3eU7McJXeomWDQYXyuADBCRVjBwiWwEnZ7nyBLJujsXxtdIpvFcDSB
         0DzsBF4vTWeTdpOaOU2YuaYxh1lR095x+Bh4YEgRKZidK4rbtoaOQIpGarv5iFpA08Db
         PRJP4pdViZk8YF9XsU3J1trL/VFDwd0v0Vel9VGTvCtzYCFvNeacD36PniQLqgLEIqkA
         AevlZDIO8e5d2M60slfyHI2nCOMm25Rg5kLx6he4b1hXxF9p28ezNiOpwBpN/EWN6/pW
         ilpg==
X-Forwarded-Encrypted: i=1; AJvYcCVaqNe3amj0NvJj9oe+6zydSrfnyl8xjtrXL0r+D/BFpRheyRtzmAj08beoVtRVW0EGrea25L0nqJO7CtrOmCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49BUw/edraVvJTZdpxUbR7twUnN7oQ2jF1DvuvDdWYFZa23ea
	aTaTWulkETkkvmGz3m83ZQLR1KVbVUErsNlvBRKDaTC2IW8gvpTtXgiO7w==
X-Google-Smtp-Source: AGHT+IFz7Op4+yt11v51fZm6QhApUMbYSo21M2QgwLdYWnDAP6PWHR2XQoH58VJrPR39K9H1yqiPrg==
X-Received: by 2002:a17:90b:17c6:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2db9fcb941cmr23613681a91.14.1726475916865;
        Mon, 16 Sep 2024 01:38:36 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:38:36 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v6 5/8] libbpf: Support opening bpf objects of either endianness
Date: Mon, 16 Sep 2024 01:37:44 -0700
Message-Id: <26353c1a1887a54400e1acd6c138fa90c99cdd40.1726475448.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726475448.git.tony.ambardar@gmail.com>
References: <cover.1726475448.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bpf_object__open() to access files of either endianness, and convert
included BPF programs to native byte-order in-memory for introspection.
Loading BPF objects of non-native byte-order is still disallowed however.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 51 +++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf_internal.h | 11 +++++++
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 60b69c6aaf53..0540d2331535 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -694,6 +694,8 @@ struct bpf_object {
 	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
 	struct elf_state efile;
 
+	unsigned char byteorder;
+
 	struct btf *btf;
 	struct btf_ext *btf_ext;
 
@@ -940,6 +942,20 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	return 0;
 }
 
+static void bpf_object_bswap_progs(struct bpf_object *obj)
+{
+	struct bpf_program *prog = obj->programs;
+	struct bpf_insn *insn;
+	int p, i;
+
+	for (p = 0; p < obj->nr_programs; p++, prog++) {
+		insn = prog->insns;
+		for (i = 0; i < prog->insns_cnt; i++, insn++)
+			bpf_insn_bswap(insn);
+	}
+	pr_debug("converted %zu BPF programs to native byte order\n", obj->nr_programs);
+}
+
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
@@ -1506,6 +1522,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 
 	elf_end(obj->efile.elf);
 	obj->efile.elf = NULL;
+	obj->efile.ehdr = NULL;
 	obj->efile.symbols = NULL;
 	obj->efile.arena_data = NULL;
 
@@ -1571,6 +1588,16 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		goto errout;
 	}
 
+	/* Validate ELF object endianness... */
+	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB &&
+	    ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
+		err = -LIBBPF_ERRNO__ENDIAN;
+		pr_warn("elf: '%s' has unknown byte order\n", obj->path);
+		goto errout;
+	}
+	/* and save after bpf_object_open() frees ELF data */
+	obj->byteorder = ehdr->e_ident[EI_DATA];
+
 	if (elf_getshdrstrndx(elf, &obj->efile.shstrndx)) {
 		pr_warn("elf: failed to get section names section index for %s: %s\n",
 			obj->path, elf_errmsg(-1));
@@ -1599,19 +1626,15 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	return err;
 }
 
-static int bpf_object__check_endianness(struct bpf_object *obj)
+static bool is_native_endianness(struct bpf_object *obj)
 {
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
-		return 0;
+	return obj->byteorder == ELFDATA2LSB;
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
-		return 0;
+	return obj->byteorder == ELFDATA2MSB;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-	pr_warn("elf: endianness mismatch in %s.\n", obj->path);
-	return -LIBBPF_ERRNO__ENDIAN;
 }
 
 static int
@@ -3953,6 +3976,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 
+	/* change BPF program insns to native endianness for introspection */
+	if (!is_native_endianness(obj))
+		bpf_object_bswap_progs(obj);
+
 	/* sort BPF programs by section name and in-section instruction offset
 	 * for faster search
 	 */
@@ -7992,7 +8019,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	}
 
 	err = bpf_object__elf_init(obj);
-	err = err ? : bpf_object__check_endianness(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
 	err = err ? : bpf_object_fixup_btf(obj);
@@ -8498,8 +8524,15 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		return libbpf_err(-EINVAL);
 	}
 
-	if (obj->gen_loader)
+	/* Disallow kernel loading programs of non-native endianness but
+	 * permit cross-endian creation of "light skeleton".
+	 */
+	if (obj->gen_loader) {
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
+	} else if (!is_native_endianness(obj)) {
+		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
+		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
+	}
 
 	err = bpf_object_prepare_token(obj);
 	err = err ? : bpf_object__probe_loading(obj);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 1307753b49b3..37477387fb5b 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -11,6 +11,7 @@
 
 #include <stdlib.h>
 #include <limits.h>
+#include <byteswap.h>
 #include <errno.h>
 #include <linux/err.h>
 #include <fcntl.h>
@@ -618,6 +619,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *insn)
 	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
 }
 
+static inline void bpf_insn_bswap(struct bpf_insn *insn)
+{
+	__u8 tmp_reg = insn->dst_reg;
+
+	insn->dst_reg = insn->src_reg;
+	insn->src_reg = tmp_reg;
+	insn->off = bswap_16(insn->off);
+	insn->imm = bswap_32(insn->imm);
+}
+
 /* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
  * Original FD is not closed or altered in any other way.
  * Preserves original FD value, if it's invalid (negative).
-- 
2.34.1


