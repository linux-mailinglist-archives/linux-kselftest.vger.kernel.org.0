Return-Path: <linux-kselftest+bounces-15839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C6959879
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979821F22E2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766691E303B;
	Wed, 21 Aug 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHMwEqyv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036831E302E;
	Wed, 21 Aug 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231421; cv=none; b=WITfiK49SSRDOtGcKrRAiFHdSNa4Xqcu8viRnRIXVL54tdfWSRlyNfIGTIlta+Fr7Exn+UwRuU4+PMhAFQjw0F1SiY0uOdc8UJ0Tcvkq0Iu6a5QaY4hGEx4FdA43W3uFlbbcQxm4LkQQacibzpbXzZAnxikJCv03kIkKuiLMrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231421; c=relaxed/simple;
	bh=2FSjsTIxChjJ7UDO6ZzkAAnWPtQd4NHAnWX6C5k7eao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoDL0KyhrYmsWUQJDm9I7tBbAErpw7IH3YUsHYSiwXSNGWlKapbs78BzHQoqnqUgPcaR45vu9KIh8kU+1rDt7givNlVsDCMxe68ZcwBr3LDhS1cgy1fEPZonJM3eAyFu+ZfnrtARWrfXdlvnTBrhun7e8bOj4Pq7sTproSTq7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHMwEqyv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20219a0fe4dso35633845ad.2;
        Wed, 21 Aug 2024 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231419; x=1724836219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y00tHlY2avYO/rkQs0/uAiE4KzWaFN2sK6H2K9tNmfU=;
        b=KHMwEqyvSLd0RDljooIGJlWCLdgzjOm9vyLeaL3T+G670y2/Tu0c3dIowtocvu6Why
         egsHh6vnmSTPOA27YD/vsjfpvOHe4p4E1zyw53v9x/MOyOX5tIUeOqYl/MS5Vr1lCNgE
         ygu0OkfjROeyducOoTmIDar+D/U2GOpq7yLczYKIsT5fXnE/9Qx2tds/KKY5UflVQcsP
         e+8932FXa3QIGyf328XXHXtKoXg/vgHK3aNF3Va3Bpzgk2SlN0E3U44rbC1aOoRMOkIU
         BjC2OqWe/XK+fYe+MUrKgilfLg7kwmKDi5B7bclUSoGxoTkb+7yORa+ScM+cCFQuRiu0
         ENuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231419; x=1724836219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y00tHlY2avYO/rkQs0/uAiE4KzWaFN2sK6H2K9tNmfU=;
        b=CKEOuGDvq6OXYF7fTaEiptVVukj40z7IytBGrvm/GjJHP/3XwF3Hhz4xElho1oamCJ
         9ANAP6usa3O++Ujszz+gP7G1tj2hlc8Giy4gOybUrZgav0SReRLWLwwmttLfMGKkUWS3
         76f51G2PtaRXhqkikEo56GZBh8ge3yNzt1axZzQhNsn2H43Ar/24ai5SZH3BIK4wLZyF
         5qVxHcuW0OC2CIY1Qts/dz533XM0rvbNIyI42+2Ma1DXOqo5gtorNua23oZEyJtnF4JS
         eQpMn+9vghLIsjMkC7x6trO4Y+de3xDAxoo8z4sWlEDKIDX7cOF2UWapxPKurNbQl/N1
         rBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYtBTOd42KHbOmv4ZjwdxoCnHxFZ0bFpt8dVxmaLOCB8E366sjVFlH2dKZJTHOr8xxi3eRuXCP3KWfJXd9jSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlsPB7inU32UqYxYIkkk2hean4C7XGxkb1oGzeBXeRkQxsSyF
	iaY/jYehbcsgX4q/b3bzvesmUZBLeO+jv/Sz30/O269Ir1BGqfCFMa1QEEty
X-Google-Smtp-Source: AGHT+IFxn6TkFSO6Y3brJ4NzV7wiL7tsGYdorgm4VlDTG/fw6XW26Qgar30DWVOuwAIGaUiussI5nA==
X-Received: by 2002:a17:902:e544:b0:202:1547:66b7 with SMTP id d9443c01a7336-20367d3be4bmr18768105ad.37.1724231419049;
        Wed, 21 Aug 2024 02:10:19 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:10:18 -0700 (PDT)
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
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v1 5/8] libbpf: Support opening bpf objects of either endianness
Date: Wed, 21 Aug 2024 02:09:23 -0700
Message-Id: <62a2ef41629ad5ef7db48d720959527462e1beca.1724216108.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724216108.git.tony.ambardar@gmail.com>
References: <cover.1724216108.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bpf_object__open() to access files of either endianness, and convert
included BPF programs to native byte-order in-memory for introspection.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 21 +++++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h | 11 +++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8a0a0c1e37e1..a542031f4f73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -940,6 +940,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
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
+		pr_debug("prog '%s': converted %zu insns to native byteorder\n",
+			 prog->name, prog->insns_cnt);
+	}
+}
+
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
@@ -1610,7 +1625,6 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-	pr_warn("elf: endianness mismatch in %s.\n", obj->path);
 	return -LIBBPF_ERRNO__ENDIAN;
 }
 
@@ -3953,6 +3967,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 
+	/* change BPF program insns to native endianness for introspection */
+	if (bpf_object__check_endianness(obj))
+		bpf_object_bswap_progs(obj);
+
 	/* sort BPF programs by section name and in-section instruction offset
 	 * for faster search
 	 */
@@ -7993,7 +8011,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	}
 
 	err = bpf_object__elf_init(obj);
-	err = err ? : bpf_object__check_endianness(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
 	err = err ? : bpf_object_fixup_btf(obj);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 6b0270c83537..f53daa601c6f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -11,6 +11,7 @@
 
 #include <stdlib.h>
 #include <limits.h>
+#include <byteswap.h>
 #include <errno.h>
 #include <linux/err.h>
 #include <fcntl.h>
@@ -590,6 +591,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *insn)
 	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
 }
 
+static inline void bpf_insn_bswap(struct bpf_insn *insn)
+{
+	/* dst_reg & src_reg nibbles */
+	__u8 *regs = (__u8 *)insn + offsetofend(struct bpf_insn, code);
+
+	*regs = (*regs >> 4) | (*regs << 4);
+	insn->off = bswap_16(insn->off);
+	insn->imm = bswap_32(insn->imm);
+}
+
 /* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
  * Original FD is not closed or altered in any other way.
  * Preserves original FD value, if it's invalid (negative).
-- 
2.34.1


