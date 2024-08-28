Return-Path: <linux-kselftest+bounces-16529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403296259B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A9A1C20D63
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA7A16CD10;
	Wed, 28 Aug 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4b1COWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35816C866;
	Wed, 28 Aug 2024 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843554; cv=none; b=sADr7ZQsgtmmfFgBhAyAQQjry7vkoGKfzPQGFza6JPJ3R0WChBgoDncSkEwS1jrDxgsnA3sXeMi/gh40q3pE2N4XXWofbVJn/Fdqv+lSZBhHLrpUQIitYAbgSO3PYZxkcpZfvGdQ1uO2ilm+gkcZkkt1k/yDnDi8sUOi5XfBWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843554; c=relaxed/simple;
	bh=TFmo7jLEnYrhP8A58hd61Cvucm5weeCITeWXJicaggY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1eWHYZD8T8lO6jvvoxAWr2bPaEYfPvGyj6wASaI059mMNvLyavUnsPdGnBPRlE26LRCV+uVc3msvDg1mbvJNgOMiOCiWQxPoouHcwrlX65et2SJuznPIuE/YXOvQzQQcDh3pzB3X12a5l7tq4t+utdgRcIN7l5/MrThelbhhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4b1COWS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20230059241so55795545ad.3;
        Wed, 28 Aug 2024 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843551; x=1725448351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18WDQ6Euc19xaDRjDIZJNMiPYXZ56Cc/DlgzvBkCFQE=;
        b=W4b1COWSdwfE44TeAXEcP1eF1H3Dnw+uPYyZh1qRArKM1QqzvHdS2A4pleRYMwlDL2
         WGf7wIZAAL9ECQGMIO8GnbDV4R/HAbfOSSsLpG1mzfvhR5DtiXDq2KTW5KOxXICI2SeV
         PLcKklQVrXoM7fAUcPWNxxy7Lj0nIAVWGcKckplKcO6wJHWuRcrOPa9p/rUpbL2kUi9e
         X5Az8IN3eGXEF7CLUWYJb7xeTgiKTKbXdQVLR7TCj2WaSmOitqME38/a5aPhICJDW6OV
         F/VGU6PZwjeHrveTKsWGvEakZkA6FCzqGDHMJBkv56ffLVXMuQq3nKl/+xM795PpI5gJ
         4oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843551; x=1725448351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18WDQ6Euc19xaDRjDIZJNMiPYXZ56Cc/DlgzvBkCFQE=;
        b=H08AwkH3Es3QhXnzYCRoSo1A68aVRF25DugBw49n7UlYuhVICJaxjmcWzGZe7z9+jn
         U9WxI49yaYsqMtdV2EaVfi2NTpeBMVZYisxZiInj3eDCC3fTvd5ZeIrgJGRWvUKnYHoB
         TEgUVFEwD6X0c2g9vyE1Ga2aNVukPinsXqw0GkH7lUD/QOsJNB5MvNW5q9Yr2rLpHvc+
         BjbypTmA/UFycZUUazkhdPveXdIXqVpc7nSuD1df83xRtweYAnoNc+PE7zJGGCcmnJfe
         kbKEbK0pIFpBygOLsz0VdCySgi6eddsPj/M9y9kltremRGez1HAoeiH3Ier/lpRJ4i+R
         6tkA==
X-Forwarded-Encrypted: i=1; AJvYcCVLaOpuSojVlmd36Qud+m1yGQadiK460ELIqIyqtC15WPcqYxVfRSFiauBnaHlOo+0iy2nTn2SLHAAu80iSvzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09CA41IlYQAXA0zYN/17m7dcTsALcpu6wl7jF84yNVcSCSJ73
	B1EdVoLGEzxICKEjaxn4Nsttt8mIbR4Hm6k7S5pgYI1LcjxODn/YlSfser75
X-Google-Smtp-Source: AGHT+IHFp0gi3BEc4vX4bZTdn2dlfk4YIvQpFGzlC9jSOpu8ssJi7c+sb3epfcbPwF0e1MdLm2MBvg==
X-Received: by 2002:a17:903:31c3:b0:202:2b3e:28d0 with SMTP id d9443c01a7336-2039e44c41fmr130155665ad.8.1724843550700;
        Wed, 28 Aug 2024 04:12:30 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855678f9sm97369395ad.1.2024.08.28.04.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:12:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/8] libbpf: Support opening bpf objects of either endianness
Date: Wed, 28 Aug 2024 04:11:55 -0700
Message-Id: <e5ccc5ff8f48987d2b3fb59dbfc6e604c726f604.1724843049.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724843049.git.tony.ambardar@gmail.com>
References: <cover.1724843049.git.tony.ambardar@gmail.com>
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
 tools/lib/bpf/libbpf.c          | 34 +++++++++++++++++++++++++--------
 tools/lib/bpf/libbpf_internal.h | 11 +++++++++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8a0a0c1e37e1..27a5cb8ccf80 100644
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
+		pr_debug("prog '%s': converted %zu insns to native byte order\n",
+			 prog->name, prog->insns_cnt);
+	}
+}
+
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
@@ -1599,19 +1614,15 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	return err;
 }
 
-static int bpf_object__check_endianness(struct bpf_object *obj)
+static bool is_native_endianness(struct bpf_object *obj)
 {
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
-		return 0;
+	return obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2LSB;
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	if (obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
-		return 0;
+	return obj->efile.ehdr->e_ident[EI_DATA] == ELFDATA2MSB;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-	pr_warn("elf: endianness mismatch in %s.\n", obj->path);
-	return -LIBBPF_ERRNO__ENDIAN;
 }
 
 static int
@@ -3953,6 +3964,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 
+	/* change BPF program insns to native endianness for introspection */
+	if (!is_native_endianness(obj))
+		bpf_object_bswap_progs(obj);
+
 	/* sort BPF programs by section name and in-section instruction offset
 	 * for faster search
 	 */
@@ -7993,7 +8008,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	}
 
 	err = bpf_object__elf_init(obj);
-	err = err ? : bpf_object__check_endianness(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
 	err = err ? : bpf_object_fixup_btf(obj);
@@ -8498,6 +8512,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 
 	if (obj->gen_loader)
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
+	else if (!is_native_endianness(obj)) {
+		pr_warn("object '%s' is not native endianness\n", obj->name);
+		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
+	}
 
 	err = bpf_object_prepare_token(obj);
 	err = err ? : bpf_object__probe_loading(obj);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 6b0270c83537..020bcbf8a566 100644
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


