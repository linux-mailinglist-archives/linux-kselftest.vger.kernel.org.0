Return-Path: <linux-kselftest+bounces-15840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E9695987B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2781F22CC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673AE1CBE93;
	Wed, 21 Aug 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1dmcTE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74871E3004;
	Wed, 21 Aug 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231436; cv=none; b=X/iTbfh0sEMrpVGfyiMT0IS0lixnPe5ztSS6f/JXGhb37LrKHrRiL1KC2XaDTDGD/1QEn8htHFv/UQ+P/29oEFk/1bKMguQxXI9blCJN4vWF39DNUvRe98KiuQ7ZA3Gdq+mzlybHCnJst96uAevFQLnwgZYLNORIbUInI71fN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231436; c=relaxed/simple;
	bh=yQB0lQx3oD6X/5PKXL3UHA6cbOEzk7oqb3jdmQ2PX7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MV7F9Qpg2Akcysp3CnsPhQXQOWSNCS/VI10xS74eYS0z1hhzFhN6+mYv4f/+Ptuj2wtWenInG7E6m8B2Efjdm8n0cmq4qY4f5l9VGtVSx2NwEcoWg1tRgBp37L28jAecpo/Pn80+a9wnXMBU+0l7kP93YMbiefqxH5QmDoyIpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1dmcTE+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so4578025a12.0;
        Wed, 21 Aug 2024 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231434; x=1724836234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om4vqqQ/0cNqedfLTqsqxQTqvqKbzb5r3RH1OMQkD3s=;
        b=m1dmcTE+OPCo3ifAYGhN8SH0/3ZJ6DdRSrhCT6FXAd2E66D5aI6Q+nNO2DQpyPcCD5
         FRDnPYHcR6nxSzzET8LjWR0lB3uDhqvu57I9ns9TDA1iEPpd+C1M6URzZb9JXsQYfPkb
         zoYteVWi7wDp1duik8gZCp1ZRQh8w/GFGSEef6pP1pWHlkpl9gd+DYC5JkajqpWluY2Y
         cP17TCS8azp3OyVEKlI1OL2ldvfg9l/zX4kCiygynHGB+MhWilG3GBxwapLqs9bd33bi
         dIgkos3qeHPCwIqgKn8ISsN0simurzwNUztd2vNm2YNB7LTP0KZN9s9NScD2H0zJ/yHB
         W+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231434; x=1724836234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om4vqqQ/0cNqedfLTqsqxQTqvqKbzb5r3RH1OMQkD3s=;
        b=EN7h40prydWOt5ILLDIS37gtGnfyhkI4HKRK1OL5lv2x+o1utLwq/D6l270E3dNMzv
         9ZmlYduvAEdn3TsK6N2tkhn4fV+Kl/COjLv5uChQNBi6iEttlAOjawA7pG8eqY0pzMv/
         YQjWgEpRaYbG/sz8VJzBTBR2mcM+v0pT/1CSEmIoJvnFqsz2avNF6SYntS0I2xZfrKAD
         rDxzr9vOna6/M23sQYhezkiHeYRvGvjtuvlyld2mpVfd+ar5eXCc48Yyqb8UND2BUtI6
         eSYWlLxQp5b8cgbY5yjC7HkLHpHZIz8KIJAcr6xgIn/GnEdv4ofQsCQUgO8qgDaZneDp
         Y9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXtleFfKjMGzTjN/Y+cpVf6fqugdT65KYsWTLFUDkD1sqNG1izktkrnte80X7ARzr45Sx+cFW4gqyQw1N3rGi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLgbXMDT6hQSKeopVZLGqyGSPftMyOsEgKZyUj4T4Dm6NZjCb
	ifnQYhnBSN8/k6zkcfl7JZ7Uo3vWygpk6h217jDppAHDuIGJnKd+/mXRr8Lj
X-Google-Smtp-Source: AGHT+IFNwJQGj5kRUTj3LgCg83CvL1G4H++bYKBiSDC6MSU1huXlu1ZxG9cIX94vVKBK6kLJZ9UWQQ==
X-Received: by 2002:a05:6a20:c78c:b0:1ca:7440:9b56 with SMTP id adf61e73a8af0-1cad7f6c81amr2240050637.1.1724231433924;
        Wed, 21 Aug 2024 02:10:33 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:10:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 6/8] libbpf: Support linking bpf objects of either endianness
Date: Wed, 21 Aug 2024 02:09:24 -0700
Message-Id: <06df51af59486b89018279fa32f840b505f47856.1724216108.git.tony.ambardar@gmail.com>
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

Allow static linking object files of either endianness, checking that input
files have consistent byte-order, and setting output endianness from input.

Linking requires in-memory processing of programs, relocations, sections,
etc. in native endianness, and output conversion to target byte-order. This
is enabled by built-in ELF translation and recent BTF/BTF.ext endianness
functions. Further add local functions for swapping byte-order of sections
containing BPF insns.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/linker.c | 106 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 7489306cd6f7..778b2b9d65a2 100644
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
+	unsigned char *link_byteorder = &linker->elf_hdr->e_ident[EI_DATA];
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
 		err = -EOPNOTSUPP;
-		pr_warn_elf("unsupported byte order of ELF file %s", filename);
+		pr_warn("linker: unknown byte order of ELF file %s\n", filename);
 		return err;
 	}
+	if (*link_byteorder == ELFDATANONE) {
+		*link_byteorder = obj_byteorder;
+		linker->swapped_endian = obj_byteorder != host_byteorder;
+		pr_debug("linker: set %s-endian output byte order\n",
+			 obj_byteorder == ELFDATA2MSB ? "big" : "little");
+	} else if (*link_byteorder != obj_byteorder) {
+		err = -EOPNOTSUPP;
+		pr_warn("linker: byte order mismatch with ELF file %s\n", filename);
+		return err;
+	}
+
 	if (ehdr->e_type != ET_REL
 	    || ehdr->e_machine != EM_BPF
 	    || ehdr->e_ident[EI_CLASS] != ELFCLASS64) {
@@ -1111,6 +1123,27 @@ static bool sec_content_is_same(struct dst_sec *dst_sec, struct src_sec *src_sec
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
+static int exec_sec_bswap(void *raw_data, int size)
+{
+	const int insn_cnt = size / sizeof(struct bpf_insn);
+	struct bpf_insn *insn = raw_data;
+	int i;
+
+	if (size % sizeof(struct bpf_insn))
+		return -EINVAL;
+	for (i = 0; i < insn_cnt; i++, insn++)
+		bpf_insn_bswap(insn);
+	return 0;
+}
+
 static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src_sec *src)
 {
 	void *tmp;
@@ -1170,6 +1203,16 @@ static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src
 		memset(dst->raw_data + dst->sec_sz, 0, dst_align_sz - dst->sec_sz);
 		/* now copy src data at a properly aligned offset */
 		memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, src->shdr->sh_size);
+
+		/* convert added bpf insns to native byte-order */
+		if (linker->swapped_endian && is_exec_sec(dst)) {
+			err = exec_sec_bswap(dst->raw_data + dst_align_sz,
+					      src->shdr->sh_size);
+			if (err) {
+				pr_warn("%s: error changing insns endianness\n", __func__);
+				return err;
+			}
+		}
 	}
 
 	dst->sec_sz = dst_final_sz;
@@ -2630,6 +2673,14 @@ int bpf_linker__finalize(struct bpf_linker *linker)
 		if (!sec->scn)
 			continue;
 
+		/* restore sections with bpf insns to target byte-order */
+		if (linker->swapped_endian && is_exec_sec(sec)) {
+			err = exec_sec_bswap(sec->raw_data, sec->sec_sz);
+			if (err) {
+				pr_warn("error finalizing insns endianness\n");
+				return libbpf_err(err);
+			}
+		}
 		sec->data->d_buf = sec->raw_data;
 	}
 
@@ -2696,6 +2747,13 @@ static int emit_elf_data_sec(struct bpf_linker *linker, const char *sec_name,
 	return 0;
 }
 
+static inline enum btf_endianness
+linker_btf_endianness(const struct bpf_linker *linker)
+{
+	unsigned char byteorder = linker->elf_hdr->e_ident[EI_DATA];
+	return byteorder == ELFDATA2MSB ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
+}
+
 static int finalize_btf(struct bpf_linker *linker)
 {
 	LIBBPF_OPTS(btf_dedup_opts, opts);
@@ -2742,6 +2800,22 @@ static int finalize_btf(struct bpf_linker *linker)
 		return err;
 	}
 
+	/* Set .BTF and .BTF.ext output byte order */
+	err = btf__set_endianness(linker->btf,
+				  linker_btf_endianness(linker));
+	if (err) {
+		pr_warn("failed to set .BTF output endianness: %d\n", err);
+		return err;
+	}
+	if (linker->btf_ext) {
+		err = btf_ext__set_endianness(linker->btf_ext,
+					      linker_btf_endianness(linker));
+		if (err) {
+			pr_warn("failed to set .BTF.ext output endianness: %d\n", err);
+			return err;
+		}
+	}
+
 	/* Emit .BTF section */
 	raw_data = btf__raw_data(linker->btf, &raw_sz);
 	if (!raw_data)
-- 
2.34.1


