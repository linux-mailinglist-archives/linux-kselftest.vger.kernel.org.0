Return-Path: <linux-kselftest+bounces-17027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD4C9695A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA311C23317
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A21D6DAC;
	Tue,  3 Sep 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIFdXDRv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE221CEAC0;
	Tue,  3 Sep 2024 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348845; cv=none; b=VsZnfq0YMZFjStuZ2BMXSWcCPU76uususRjPw5Yi/OfpCmlI3mdlyFzTxQSUWMkygXe8CUnIKLQ+XuRZjV0Crz2a3qQwR0VoAMpIZBNsU7abhga2Y7ukTGZjghclGch49Q9+8buXbdiD3ERu3pUvn9hBwADTr47mC5Vd+260N6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348845; c=relaxed/simple;
	bh=fLu7SRxaO3s2yceOm/54Xd5v5MZAWzqNq7ttzNUJLXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZu/h5SBIV7lJxcS5d3CU5yB3g5KyumIEVgVyHLP++NHJd5hq4s1bI6q6mxq8y7wwXJx2TY+Lm9otdY0N/BGaTmRGqbSFM1IA5WJT/xq/7GFDy5JN6imCfZfJwabBppPOodQCg643+h3dlH7lFsS5ag0MQXcgc1cfZd05FV0BzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIFdXDRv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7176645e51bso1035293b3a.3;
        Tue, 03 Sep 2024 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348842; x=1725953642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9wlcZ+z00Zleza6QUOzbvfLXCYoiEpMVmJc7xCTfsc=;
        b=PIFdXDRv5pB5Jf+yuyq1QHPOWRCB6JS/u/BbBKoFbQUdfatjLz0/HaMT7ico0gT0Fp
         LK5W01P8tIXQauNjE4x61aKXpts3nrl6zI7NpmXoq3VtY0aW/B/pA96E7hPHxTx3OKVE
         Wbz9oYSowQAGiBaQOf//vJevmuzRIIjV0e4Z2kE7DPyGoIquvoF8ouT6fCynCnPsjn3J
         Txz+8MGHZWaKrLVgXCLrW4fTvdDJgbo1O3YN5hL+S9Mz6kwIhljtWCdg+UusKy+U/V5m
         6d8edINmed8cMuvTw4IMPa9hGLk81fahZIdPmT77b6idgyekjVKqTdRwXcM03WPhBlLz
         tfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348842; x=1725953642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9wlcZ+z00Zleza6QUOzbvfLXCYoiEpMVmJc7xCTfsc=;
        b=qNFMsrUbOhXIl5flXktj6a1r8NmNiCS3ihWf2dWEblvn8YnXda+i8QcdVkFdRGA2Ta
         25sGsg1vbBB9xhwI9uqgbWYh6NhYlBVZ37MOlCyFC2/9YAPXP7YsUGf27bMQwsHBKb63
         F+aiMWMiu71Mryjp1bpGNd9Mth9MOEPZXSaJQjh4CWcOwIPJJ+9YFEn4zxS9z1sqqHhn
         QdcYqAwINdUaGkjUqLL0ehdw1v9b/Dpe+druEtWIvNDyVxTyIl8u61xZ46aNko4MHqv5
         BLalb/WMcwZyEzjqLy+XAJBSi4FTbEpWBUa89cwiikgldJNAbvsOrE79Jjgwh15AMMav
         pWNg==
X-Forwarded-Encrypted: i=1; AJvYcCVUfDdcTBFdE2XHNXXfl78G3VDO7F38JjCFyzEFB8RFVJC5ShxOvIK2eiAxUAQhjl0hA7hJhpRcywUUVK5yaOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rDp+UpezzAEVfoQViHJPrRRzO3b/DVqiyGkHd5wacxv/goSt
	lvGaYNWGX/CIejJMB59VA222q4Zsu+n6h5zKVVfrfCQ7opQazTP5dO26FQ==
X-Google-Smtp-Source: AGHT+IGDx2kLLn5O++h5NIXQC68EHwTNTlXLo2IvGG1E+XNqvnUNtuqQOdnCDWj5ivFVtqkU0DCCCQ==
X-Received: by 2002:a05:6a00:2283:b0:714:2922:7c6c with SMTP id d2e1a72fcca58-715dfccb426mr19876482b3a.19.1725348842488;
        Tue, 03 Sep 2024 00:34:02 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:34:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 6/8] libbpf: Support linking bpf objects of either endianness
Date: Tue,  3 Sep 2024 00:33:03 -0700
Message-Id: <d9c2565c75d7a41a6cd7e4b1657da6cdc2428df0.1725347944.git.tony.ambardar@gmail.com>
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

Allow static linking object files of either endianness, checking that input
files have consistent byte-order, and setting output endianness from input.

Linking requires in-memory processing of programs, relocations, sections,
etc. in native endianness, and output conversion to target byte-order. This
is enabled by built-in ELF translation and recent BTF/BTF.ext endianness
functions. Further add local functions for swapping byte-order of sections
containing BPF insns.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/linker.c | 78 +++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 7489306cd6f7..85562e26c3de 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -135,6 +135,7 @@ struct bpf_linker {
 	int fd;
 	Elf *elf;
 	Elf64_Ehdr *elf_hdr;
+	bool swapped_endian;
 
 	/* Output sections metadata */
 	struct dst_sec *secs;
@@ -324,13 +325,8 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
 
 	linker->elf_hdr->e_machine = EM_BPF;
 	linker->elf_hdr->e_type = ET_REL;
-#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2LSB;
-#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	linker->elf_hdr->e_ident[EI_DATA] = ELFDATA2MSB;
-#else
-#error "Unknown __BYTE_ORDER__"
-#endif
+	/* Set unknown ELF endianness, assign later from input files */
+	linker->elf_hdr->e_ident[EI_DATA] = ELFDATANONE;
 
 	/* STRTAB */
 	/* initialize strset with an empty string to conform to ELF */
@@ -541,19 +537,21 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 				const struct bpf_linker_file_opts *opts,
 				struct src_obj *obj)
 {
-#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	const int host_endianness = ELFDATA2LSB;
-#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	const int host_endianness = ELFDATA2MSB;
-#else
-#error "Unknown __BYTE_ORDER__"
-#endif
 	int err = 0;
 	Elf_Scn *scn;
 	Elf_Data *data;
 	Elf64_Ehdr *ehdr;
 	Elf64_Shdr *shdr;
 	struct src_sec *sec;
+	unsigned char obj_byteorder;
+	unsigned char link_byteorder = linker->elf_hdr->e_ident[EI_DATA];
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	const unsigned char host_byteorder = ELFDATA2LSB;
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	const unsigned char host_byteorder = ELFDATA2MSB;
+#else
+#error "Unknown __BYTE_ORDER__"
+#endif
 
 	pr_debug("linker: adding object file '%s'...\n", filename);
 
@@ -579,11 +577,25 @@ static int linker_load_obj_file(struct bpf_linker *linker, const char *filename,
 		pr_warn_elf("failed to get ELF header for %s", filename);
 		return err;
 	}
-	if (ehdr->e_ident[EI_DATA] != host_endianness) {
+
+	/* Linker output endianness set by first input object */
+	obj_byteorder = ehdr->e_ident[EI_DATA];
+	if (obj_byteorder != ELFDATA2LSB && obj_byteorder != ELFDATA2MSB) {
+		err = -EOPNOTSUPP;
+		pr_warn("unknown byte order of ELF file %s\n", filename);
+		return err;
+	}
+	if (link_byteorder == ELFDATANONE) {
+		linker->elf_hdr->e_ident[EI_DATA] = obj_byteorder;
+		linker->swapped_endian = obj_byteorder != host_byteorder;
+		pr_debug("linker: set %s-endian output byte order\n",
+			 obj_byteorder == ELFDATA2MSB ? "big" : "little");
+	} else if (link_byteorder != obj_byteorder) {
 		err = -EOPNOTSUPP;
-		pr_warn_elf("unsupported byte order of ELF file %s", filename);
+		pr_warn("byte order mismatch with ELF file %s\n", filename);
 		return err;
 	}
+
 	if (ehdr->e_type != ET_REL
 	    || ehdr->e_machine != EM_BPF
 	    || ehdr->e_ident[EI_CLASS] != ELFCLASS64) {
@@ -1111,6 +1123,24 @@ static bool sec_content_is_same(struct dst_sec *dst_sec, struct src_sec *src_sec
 	return true;
 }
 
+static bool is_exec_sec(struct dst_sec *sec)
+{
+	if (!sec || sec->ephemeral)
+		return false;
+	return (sec->shdr->sh_type == SHT_PROGBITS) &&
+	       (sec->shdr->sh_flags & SHF_EXECINSTR);
+}
+
+static void exec_sec_bswap(void *raw_data, int size)
+{
+	const int insn_cnt = size / sizeof(struct bpf_insn);
+	struct bpf_insn *insn = raw_data;
+	int i;
+
+	for (i = 0; i < insn_cnt; i++, insn++)
+		bpf_insn_bswap(insn);
+}
+
 static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src_sec *src)
 {
 	void *tmp;
@@ -1170,6 +1200,10 @@ static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src
 		memset(dst->raw_data + dst->sec_sz, 0, dst_align_sz - dst->sec_sz);
 		/* now copy src data at a properly aligned offset */
 		memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, src->shdr->sh_size);
+
+		/* convert added bpf insns to native byte-order */
+		if (linker->swapped_endian && is_exec_sec(dst))
+			exec_sec_bswap(dst->raw_data + dst_align_sz, src->shdr->sh_size);
 	}
 
 	dst->sec_sz = dst_final_sz;
@@ -2630,6 +2664,10 @@ int bpf_linker__finalize(struct bpf_linker *linker)
 		if (!sec->scn)
 			continue;
 
+		/* restore sections with bpf insns to target byte-order */
+		if (linker->swapped_endian && is_exec_sec(sec))
+			exec_sec_bswap(sec->raw_data, sec->sec_sz);
+
 		sec->data->d_buf = sec->raw_data;
 	}
 
@@ -2698,6 +2736,7 @@ static int emit_elf_data_sec(struct bpf_linker *linker, const char *sec_name,
 
 static int finalize_btf(struct bpf_linker *linker)
 {
+	enum btf_endianness link_endianness;
 	LIBBPF_OPTS(btf_dedup_opts, opts);
 	struct btf *btf = linker->btf;
 	const void *raw_data;
@@ -2742,6 +2781,13 @@ static int finalize_btf(struct bpf_linker *linker)
 		return err;
 	}
 
+	/* Set .BTF and .BTF.ext output byte order */
+	link_endianness = linker->elf_hdr->e_ident[EI_DATA] == ELFDATA2MSB ?
+			  BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
+	btf__set_endianness(linker->btf, link_endianness);
+	if (linker->btf_ext)
+		btf_ext__set_endianness(linker->btf_ext, link_endianness);
+
 	/* Emit .BTF section */
 	raw_data = btf__raw_data(linker->btf, &raw_sz);
 	if (!raw_data)
-- 
2.34.1


