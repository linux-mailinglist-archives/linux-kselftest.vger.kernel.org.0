Return-Path: <linux-kselftest+bounces-16530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6495296259C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C010284C6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0216C875;
	Wed, 28 Aug 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLytrttJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CC16EB53;
	Wed, 28 Aug 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843556; cv=none; b=roNuMfgRPunnUg9yCIjteMPQDncfBwQ8dTEPXr8mCBC9rzfS+YMB2UrY5apgNIENO1BO3g1+UNI1920l59xF1gdqHJ9N7TOYrMKwy3mfUhfR+t+Vu7StDRhDiSBq5PVQjigs2Ymm1pvf1zHyJg5nj6Q3NCEcJJC/2mj0nymaXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843556; c=relaxed/simple;
	bh=bZFiVLxsPqJFp+7OFMaqX0ZvCLgCDYIYtrLGMsK2oz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqfBaaE2GA/iVPwUmrpj5DcyRZwbWWoOky5Ti959rT7XFrT+Y6rt+77kQVTaoqM5QxbZb+MF1+UQ4gPKdQ1iP8BR8lHZ0RMXb62XRXcfsyEi2GZgXYQKZP7rP7g86flUVX3XHi3n/leW03Hlvku1UWAvszhDQ7U5y/ZHOIluTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLytrttJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso377769b3a.0;
        Wed, 28 Aug 2024 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843553; x=1725448353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCLEqvYFcYfbFDmBpnULkP78s+23ipk0h/fW+02tbBM=;
        b=ZLytrttJRy82WPqijQuaGfs7NX80h1QGZ4XBhr9Oihn/RX8jomyRkRAvxXU/hk9B67
         E0ejuPggmJGrxWs3f+UvPC1GO78gxneHECHA9nE7MVsT7eH59VFrYVYP6AlcBsIK05LC
         cTcp63hMY1nzT8lQ+dvQiZuZDyj8ByL3bbq9oiXotgW9TvRacf/wcSqxmeotElt377Wb
         5UerZyRrXssSxj/Rq+Bpt8YF4yd6DXvdthsnmrZw7hCcDBG+HXCKELLn7Uq7oKQ/X4P3
         NjXB9HU5vJRQeWpyTmJ0P1PpHwemSrsaW/dpGzu7zYINL5/6oq4LJMwI4xAD2QqTK4ZI
         VFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843553; x=1725448353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCLEqvYFcYfbFDmBpnULkP78s+23ipk0h/fW+02tbBM=;
        b=YUFyzM9PW9ktFMkMU7NfjJHSJnNrzkJdheduFWP6YnL+avAotX6NWwIp/AxuxbQMyq
         mq1zASZPL/CkzyaRP/I5FRuVIAKckdU2J9EEWc1+DOUXwyB9F8+sAbAcav/WEI5uwWfv
         ItVQcuxpwwArMFoSMKeRdcZakn4HFv65w8Ikc/u5VKzDgGcdKy4/EKm80beGM4q826mR
         b/Fwe97ahhZjYOiY1C97A9LX03LSukqeAQiAYMs3cqHQOlpkjnZp1GAWpkmJa4Ngrtyc
         y35f7jNq7swCWzd9jBPz+j25ic/ncH1CeWKiNTSn1HtgnkHF/6dooXX+3iN+eHdP/yK6
         JUag==
X-Forwarded-Encrypted: i=1; AJvYcCV5sPuHIC0jUwGwod6GrqsUaoAaBD58carpwlIrWQuunspIMKfJo3lMusd6PsguI/nmA5VXddXbdIF9sKKLyfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfEq3F5Fgvi+/F/Mlrh4eUaLyFEHM6rrUuJU++2attKSXSSZH
	vNtD5WaQUyMryuZcSldtll7dcdfi4rgcAaIQHsnP6YilP2aXnwASeugBiiUU
X-Google-Smtp-Source: AGHT+IFs1BgkDZRzQVSkj+QbKuBXXVtOvntvqDEvkJy8E02YpVC0gLSPckg3xS14m2EOCi3FDtA3XA==
X-Received: by 2002:a17:902:7082:b0:203:b05a:ad9f with SMTP id d9443c01a7336-204f9c83994mr19646995ad.32.1724843553383;
        Wed, 28 Aug 2024 04:12:33 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855678f9sm97369395ad.1.2024.08.28.04.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:12:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/8] libbpf: Support linking bpf objects of either endianness
Date: Wed, 28 Aug 2024 04:11:56 -0700
Message-Id: <715c93be5421e319b0640f17a5c423fdebda9329.1724843049.git.tony.ambardar@gmail.com>
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

Allow static linking object files of either endianness, checking that input
files have consistent byte-order, and setting output endianness from input.

Linking requires in-memory processing of programs, relocations, sections,
etc. in native endianness, and output conversion to target byte-order. This
is enabled by built-in ELF translation and recent BTF/BTF.ext endianness
functions. Further add local functions for swapping byte-order of sections
containing BPF insns.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/linker.c | 90 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 7489306cd6f7..bd97da68eed6 100644
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
@@ -1170,6 +1203,10 @@ static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, struct src
 		memset(dst->raw_data + dst->sec_sz, 0, dst_align_sz - dst->sec_sz);
 		/* now copy src data at a properly aligned offset */
 		memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, src->shdr->sh_size);
+
+		/* convert added bpf insns to native byte-order */
+		if (linker->swapped_endian && is_exec_sec(dst))
+			exec_sec_bswap(dst->raw_data + dst_align_sz, src->shdr->sh_size);
 	}
 
 	dst->sec_sz = dst_final_sz;
@@ -2630,6 +2667,10 @@ int bpf_linker__finalize(struct bpf_linker *linker)
 		if (!sec->scn)
 			continue;
 
+		/* restore sections with bpf insns to target byte-order */
+		if (linker->swapped_endian && is_exec_sec(sec))
+			exec_sec_bswap(sec->raw_data, sec->sec_sz);
+
 		sec->data->d_buf = sec->raw_data;
 	}
 
@@ -2698,6 +2739,7 @@ static int emit_elf_data_sec(struct bpf_linker *linker, const char *sec_name,
 
 static int finalize_btf(struct bpf_linker *linker)
 {
+	enum btf_endianness link_endianness;
 	LIBBPF_OPTS(btf_dedup_opts, opts);
 	struct btf *btf = linker->btf;
 	const void *raw_data;
@@ -2742,6 +2784,22 @@ static int finalize_btf(struct bpf_linker *linker)
 		return err;
 	}
 
+	/* Set .BTF and .BTF.ext output byte order */
+	link_endianness = linker->elf_hdr->e_ident[EI_DATA] == ELFDATA2MSB ?
+			  BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
+	err = btf__set_endianness(linker->btf, link_endianness);
+	if (err) {
+		pr_warn("failed to set .BTF output endianness: %d\n", err);
+		return err;
+	}
+	if (linker->btf_ext) {
+		err = btf_ext__set_endianness(linker->btf_ext, link_endianness);
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


