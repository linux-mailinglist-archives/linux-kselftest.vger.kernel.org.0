Return-Path: <linux-kselftest+bounces-17026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139D79695A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE705284CD9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950F1D6DCE;
	Tue,  3 Sep 2024 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLAGLMWR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0631CEAC0;
	Tue,  3 Sep 2024 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348838; cv=none; b=n/NNRACGEV996DVwDrXeAuVNdKeeBxChBAxVoFD8Rxi27B15PUzis5N3RAZyvZs7+SucNzfZOgeKVYWO4LGY9mE6vKyht/63aR6FGpzDnqT9m1wvO2zVBpvIQZXlKDgOdqrGg8txK14KASXy5CHuIzE1NjHpeztPTVW+91Ct9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348838; c=relaxed/simple;
	bh=WVmxf7QoD8oNyCSb1rb7pUVaCsAtEKjVp233fM2WxBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIDBEil6KlEKppWMe16GDjqBZOwTFMGQaRNxVWip1ntAccK9LBM5n8nr4XYVAmmWe+kra8exeY6P0fPaR18FQNj/ERWx/KaELR84iGWDnuk/CC5Ysfgz5lycLIvspeYwmKPc+qsR0irBDs1HSdnXaVlMYjQX0er2qITFrvU9DD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLAGLMWR; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27045e54272so2245210fac.0;
        Tue, 03 Sep 2024 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348836; x=1725953636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acmjBBzD9ulY9VYwgMsbI4+Uz0WTTw3wfPRsopM12Rg=;
        b=DLAGLMWRLAqCSnBtl9UF8l1cZ70KAQt3NnlFpTpVZWBtGGkBTdINHI5/r6sP+BJewb
         pFJ9fqGiM+5h3kEK0a2rqPq0BWYHRYYm8XE0YNDptKoiPrnm9JGPRTMljD8Q0uZHJtyo
         uKgYcrFhFP2Pr9fiZn4e7icrqb+5zXGAR9GxoEOqdIUZvNQVnk+w9/9EDiT88G0H78U7
         h5EcaCez9h9+nFukAhmF5NNWDuvdh1P/BoLgBzYAAi7z15XZpvQ6SVfCytlxUKc2iaxL
         CwFDpUI3aa9DZCm3LB4R0Ut+1f/9sr6I20LEOGPXCwj3fwpPMP7g+r7upuynJe5bQ0Go
         yE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348836; x=1725953636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acmjBBzD9ulY9VYwgMsbI4+Uz0WTTw3wfPRsopM12Rg=;
        b=v/harP9QTBMJpbrxw/6s9p1djk/9VHeqf+pB5YIfAAVmnpqet+82rYGLpN1Ku3audW
         m30d+Zy/RMDbVr7E7depHMFP0Q3JOzLy+wgygAeJjUZv7/aCbIbAkSwycZy19n8TS52t
         FnfWDlcRqEvZt2KB6abfZau78qGql7PVMwc0Mp+RKvqQ/8AHn4BAbF6Lwj5micsEWD6X
         deevJ0yADcRz+BwxddcXrwJbQMcBIP7+aqW0yQp71cXCiQnI6flvBNqn0VxZPnOPEryk
         33ZjcKZ28l3Pfp80Pl5LCfWYsG+b6ZMdZkrrjRy/zpVpvxI++TnQBd1gENztAstpMFZv
         PvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBBpWN3VTNiutZd/fSGFf4veQquGTkfmrcCnOxjUzmg9Np4awIszpaCzFTuUA4HY26q0x/C2P8uKPdLdA+AwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAuCC2PhcSUXlpsLVQD6w1V2+5M1Kgunqek/X1tC3AN9+VNU3K
	SRA6R6Nvhv1LjLfBc90Ff1YqaL/FT+QQrcqe6MYGMwegYi7kxkwporActQ==
X-Google-Smtp-Source: AGHT+IEB/Rn/uEMHp4l+ida9Qn0q3eonenpqIjf9C6XgMY5zQWHLr0Wh1Lj+qeNEJiKrjbpn6b6m9g==
X-Received: by 2002:a05:6870:611e:b0:261:1177:6a56 with SMTP id 586e51a60fabf-277c80a48a3mr9918779fac.20.1725348835524;
        Tue, 03 Sep 2024 00:33:55 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:33:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 5/8] libbpf: Support opening bpf objects of either endianness
Date: Tue,  3 Sep 2024 00:33:02 -0700
Message-Id: <6f2af9efc5b64d5c4669d48927393b97b0232497.1725347944.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725347944.git.tony.ambardar@gmail.com>
References: <cover.1725347944.git.tony.ambardar@gmail.com>
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
 tools/lib/bpf/libbpf.c          | 52 +++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf_internal.h | 11 +++++++
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0226d3b50709..46f41ea5e74d 100644
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
+	}
+	pr_debug("converted %zu BPF programs to native byte order\n",
+		 obj->nr_programs);
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
 
@@ -1571,6 +1589,16 @@ static int bpf_object__elf_init(struct bpf_object *obj)
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
@@ -1599,19 +1627,15 @@ static int bpf_object__elf_init(struct bpf_object *obj)
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
@@ -3953,6 +3977,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 
+	/* change BPF program insns to native endianness for introspection */
+	if (!is_native_endianness(obj))
+		bpf_object_bswap_progs(obj);
+
 	/* sort BPF programs by section name and in-section instruction offset
 	 * for faster search
 	 */
@@ -7992,7 +8020,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	}
 
 	err = bpf_object__elf_init(obj);
-	err = err ? : bpf_object__check_endianness(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
 	err = err ? : bpf_object_fixup_btf(obj);
@@ -8498,8 +8525,15 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
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
index a8531195acd4..eda7a0cc2b8c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -11,6 +11,7 @@
 
 #include <stdlib.h>
 #include <limits.h>
+#include <byteswap.h>
 #include <errno.h>
 #include <linux/err.h>
 #include <fcntl.h>
@@ -616,6 +617,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *insn)
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


