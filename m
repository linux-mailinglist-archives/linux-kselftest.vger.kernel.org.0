Return-Path: <linux-kselftest+bounces-16764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BD96588E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E561F26297
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F303158539;
	Fri, 30 Aug 2024 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqWjQWKz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8541531D8;
	Fri, 30 Aug 2024 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003011; cv=none; b=SCeho3jptXTR60Rbi5PLUwyXTFDHegp8EN30XUtj/UnxmmIarBqMAe30cTHD1jPygYRmJ1CAGQfoRxzS6IjQfc7g1DJrPv26iweNfhkcsCf7/wh8mgTscs/l9c2MCEIexSYpaTUK3j86bQEAmyeD9jukAdkfYto3n3UP6ce1HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003011; c=relaxed/simple;
	bh=zMHgBV9MPoayBW5BxuZkI8lBHTKi/MZZKDBmxSKOIBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oWD+QZIul4UeI9QHliAiz04++NYj4D7t7hVU42Wp6KZlcbj8o7URKZx7GQP7zuXPJgoZAbRZqpn4zaecRUT12tRyile2zjXNQK4XKasBUq0VoSbK3lVdQ6jJB0WqhnPdbBdTCfdESAf++IPUrRWrOHDS/Ij524supk9BwRJ2nvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqWjQWKz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso951750a12.0;
        Fri, 30 Aug 2024 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725003009; x=1725607809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSPserhYdnWbrZnczBTRe1/uEXl/4VByG9Mp4IeCUR4=;
        b=AqWjQWKzIsWQFeOA7oIXLyucc4m6w74KHLfHTc82MifdGXv7+PT1JuU+Gnt1i/PPt8
         I9Jj2vggEfHlGHKMFkULmmVZqh6nVeFA+lrGEj1YV+55M9YXog2t5ClcAQY9pwdHfIQN
         kOc5oOzen1s8Fnz6nB4AmYd/ewzTUx0ZYALZ+N8fKU5kLos+2pVH80sXBatWXfoJN1jn
         m3WjymG7n0RN0TPMB8v6iO9RAwk3VIO0LAXQbMEsYb/1x9SKrtELHQTna1o0AD6NUtyn
         D91irU6ZARvTfKBvQogoZguh7QRNlDzsY/zxwMCkbFJhWmrs0CJxjwrji0dLSFujbYXk
         z3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003009; x=1725607809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPserhYdnWbrZnczBTRe1/uEXl/4VByG9Mp4IeCUR4=;
        b=uul4Ncjgb3DQz2Yk4F8dybCjm6jJOj4I5BTiLX325nfMX9Hq+zGUMWkjTU7U9EY1FS
         PQ10w4DwKXeFNYyD2dA3EdiBp1PDuBVekudXS+l++7e0bn5Es9A/hj2f7Pumeb6oQP77
         eUo7Rw1ZKu3/6JbxpEqeOGNJYFAY5HEuQxXkQIdBcru2L8ioc/GowrbC+dQ28p0xP2Cx
         8rFdze5Vdh1Lxdj8fUeF7mkVu7XbuTl7ZzPlgZPd9sfvC5iroaS4nReXJn93XKpfGqAk
         3A3BdVVX/FYGUS4jju+08XrcG27Unj77ljqrobxj5h6EA2suuGCzl0ICML9MWW6NoIOR
         kTLw==
X-Forwarded-Encrypted: i=1; AJvYcCVp/bG1B5M636S4RfgTGYC2q1Kbv02RIaTqbKHLzyOPJkjIemG7uPz6a+4DHhfewcPFwwnMcojDP7trES4ZbPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQpcTYrXMf8FSG/BT4h5ifYs8s/BtdTnYDribK1JtreCroDuqm
	/LhDenmmgNn0AIe3+lXeDDcMZbT7ygbqTN687n08HIkW0EcQhpVyjayjav71
X-Google-Smtp-Source: AGHT+IE/vqY9Fi+mQD9ljYei5IS/FqNpda2aH4Wm4fe6ZJQnD42YS3bYOXxX3veSKUzG87nGitgMrw==
X-Received: by 2002:a05:6a21:e85:b0:1c6:fb07:381e with SMTP id adf61e73a8af0-1cce10ed59fmr5125445637.44.1725003008817;
        Fri, 30 Aug 2024 00:30:08 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:30:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/8] libbpf: Support opening bpf objects of either endianness
Date: Fri, 30 Aug 2024 00:29:27 -0700
Message-Id: <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724976539.git.tony.ambardar@gmail.com>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
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
 tools/lib/bpf/libbpf.c          | 49 +++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf_internal.h | 11 ++++++++
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0226d3b50709..aa52870b1967 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -694,6 +694,8 @@ struct bpf_object {
 	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
 	struct elf_state efile;
 
+	unsigned char byteorder;
+
 	struct btf *btf;
 	struct btf_ext *btf_ext;
 
@@ -940,6 +942,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
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
+		pr_debug("prog '%s': converted %zu insns to native byte order\n",
+			 prog->name, prog->insns_cnt);
+	}
+}
+
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
@@ -1506,6 +1523,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 
 	elf_end(obj->efile.elf);
 	obj->efile.elf = NULL;
+	obj->efile.ehdr = NULL;
 	obj->efile.symbols = NULL;
 	obj->efile.arena_data = NULL;
 
@@ -1571,6 +1589,18 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		goto errout;
 	}
 
+	/* Validate ELF object endianness... */
+	if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB &&
+	    ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
+		err = -LIBBPF_ERRNO__ENDIAN;
+		pr_warn("elf: '%s' has unknown byte order\n", obj->path);
+		goto errout;
+	}
+	/* and preserve outside lifetime of bpf_object_open() */
+	obj->byteorder = ehdr->e_ident[EI_DATA];
+
+
+
 	if (elf_getshdrstrndx(elf, &obj->efile.shstrndx)) {
 		pr_warn("elf: failed to get section names section index for %s: %s\n",
 			obj->path, elf_errmsg(-1));
@@ -1599,19 +1629,15 @@ static int bpf_object__elf_init(struct bpf_object *obj)
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
@@ -3953,6 +3979,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 
+	/* change BPF program insns to native endianness for introspection */
+	if (!is_native_endianness(obj))
+		bpf_object_bswap_progs(obj);
+
 	/* sort BPF programs by section name and in-section instruction offset
 	 * for faster search
 	 */
@@ -7992,7 +8022,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	}
 
 	err = bpf_object__elf_init(obj);
-	err = err ? : bpf_object__check_endianness(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
 	err = err ? : bpf_object_fixup_btf(obj);
@@ -8500,6 +8529,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 
 	if (obj->gen_loader)
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
+	else if (!is_native_endianness(obj)) {
+		pr_warn("object '%s' is not native endianness\n", obj->name);
+		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
+	}
 
 	err = bpf_object_prepare_token(obj);
 	err = err ? : bpf_object__probe_loading(obj);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 81d375015c2b..f32e3e8378a5 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -11,6 +11,7 @@
 
 #include <stdlib.h>
 #include <limits.h>
+#include <byteswap.h>
 #include <errno.h>
 #include <linux/err.h>
 #include <fcntl.h>
@@ -621,6 +622,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *insn)
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


