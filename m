Return-Path: <linux-kselftest+bounces-16034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCB95B196
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5DF1F217EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CB17DE06;
	Thu, 22 Aug 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5qMdFzJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D117C7C7;
	Thu, 22 Aug 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318711; cv=none; b=uO90f5/lbdy/vM4+Uf8fF1UctgZoyboUer/Oflu0t0xDJQOnpkXxZDoOpIkXlWZvVuIcHUJUKiY9o6kZJsnv9aKw+Py5jpwLE+vmp7G0+AwNUgZtAIM9TYEboXCsKmoPSjEVdYjfn8BWNlbmoG3FAGG9GWSJt2rUBz+8eKQ5010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318711; c=relaxed/simple;
	bh=07KmEz8U1Ki/J/dfw9Y29T9TVvcCa/OYF+krcbEiVcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhPL4Baa6V5RgVTuBXmulKb7QG0PZuCaOqBeAAZAQfhUQRr5Lff/wibf5nuXU8FeDlZgGynyc3OYX0GxVIvQbW3EVXIHMzbDI/yoiyorgqWBmOJUHlSzBOTIWSaxwUY5p4Xv4Zs8PDk2M0q12R4BDx2a9K9NK07HqPGg26xlYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5qMdFzJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso143920b3a.1;
        Thu, 22 Aug 2024 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318709; x=1724923509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W16ikeO+zpfqJqCTabePrGDL48+AE63HibtRRZxWkk4=;
        b=C5qMdFzJUnYXavTLedhSnCFNwK6Dt3RsBkQZLTq0W07sHPHP8hii0cdTpC283jKp7Y
         OlKpewGVdlPl6uCkjSegp4EhL4Ex2r7aKRcuDrJZ2zpDUn8n2iuuP3NWEahmu6goG2Vw
         /k4GXAHJPUYNxaCIr8GjqWPCBXWZYcP75RZ5B/RLS2X9zbf86F9pgjZqxmZwlQLdB8zv
         93XSx/jIGd0u/lzNn1c9ft+2h35ry4wlmsmKBc+dwRCPC2cn1jcAYDu3i+HQfvyyU6AD
         F4sUgFeYtNYo+O+CKdkU++Hoxc80MZ+HJM2mxtP7zKOaMfrLlLXY61E89FEzfMXnX7J2
         QXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318709; x=1724923509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W16ikeO+zpfqJqCTabePrGDL48+AE63HibtRRZxWkk4=;
        b=dY7FuWvIK185QRmAY8tDYc4HCpRb00QB5TpGXYV24QXWchA0+awbcGC8Z548ub93Z5
         ZJOHA5tWXnGjJdHo1PsTfBPLXleqzmm7YShnGunkq4fIdXMPEB58yebnC3sJ6q7qNN4I
         otL8Ye1TujbSO89Ml2IsG2s+rMXObsxgqvRrHy3PhHfnCxaXNW4GxLjmo5qBOYK3xopR
         vYKsKDi8wRqIKstYQjrTydKVQCk2j4ES7Orh1oSspQknGyfiliKbnX77iVu0VUlDiGyv
         zjNW6j4HqPbYnbDit8xxMUZb+3s8JQawCfkGp3/djytxZ+a1UQkQB6UCQzkZzQtWBVbE
         e2qg==
X-Forwarded-Encrypted: i=1; AJvYcCVjmL7a0MimtNvvEBwXdFABwNCfV+0LCBq6b612s/OC6PajW4QGpCZwp5rwXYFNRKM6YTmDordVvEbF+2ur8Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJY5F9+NMdtfEPxqZUbila6/FMRqumqsgDbbDdRjsngdD3Dry
	XYn6q+SPseygmlN0G+sRkTpTBUVD1wGMP20a6C4Zb73cE5z4yvrX2ctQ3ZU8
X-Google-Smtp-Source: AGHT+IEphvEhhEPcq69wpQggNS7hr78OA4Ew+Otm25LrLwIu5OhSG6+kCwgpgczlajZ95KzScPIveg==
X-Received: by 2002:a05:6a20:439f:b0:1c2:8af6:31c2 with SMTP id adf61e73a8af0-1caeb34ef2fmr1345209637.44.1724318708521;
        Thu, 22 Aug 2024 02:25:08 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:25:08 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v2 6/8] libbpf: Support linking bpf objects of either endianness
Date: Thu, 22 Aug 2024 02:24:29 -0700
Message-Id: <0511638ed6191f4434be23ed7fb56001ccb5b687.1724313164.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724313164.git.tony.ambardar@gmail.com>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

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
index 7489306cd6f7..9bf218db443e 100644
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
+					     src->shdr->sh_size);
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
 
+static enum btf_endianness
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


