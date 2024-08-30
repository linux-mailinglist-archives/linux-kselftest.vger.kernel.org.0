Return-Path: <linux-kselftest+bounces-16765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A8965881
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9C31F262A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C413A168492;
	Fri, 30 Aug 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwlWw4Ve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247651607BB;
	Fri, 30 Aug 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003014; cv=none; b=QzHDk0QX6kvPcdbYd8zsEyygnCcGFekiiD0TJzFlWCzqnMp7423e8tK30EdTQAnWIpvfPHhqmnM7qen9VdLrLhkMni7Y1PNdVripfqm2Jwxgknl3bAN9QLTPNQ4KCUy4f/yeK34nvHHuRH81MpZW99pKvf5LFO4f5uiV1dH+uF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003014; c=relaxed/simple;
	bh=bZFiVLxsPqJFp+7OFMaqX0ZvCLgCDYIYtrLGMsK2oz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qkm9QM13tyNacxL0nBshtGxOfJAdh9fXl/7cS0HSquXffu2tTxGCIm1ZIVZO3aBJARiZmmzpNd8ozNPFM1kyecaTiYjtdxYpKuseLc5/1eRVnt0FUtrPYCeinMHHfrUp4MTQx2cp/uJO2l3c9A4b7LnVJ2QMlBIK38ulgqJQJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwlWw4Ve; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20231aa8908so11557615ad.0;
        Fri, 30 Aug 2024 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725003012; x=1725607812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCLEqvYFcYfbFDmBpnULkP78s+23ipk0h/fW+02tbBM=;
        b=IwlWw4Ve6JZmBni/iiuimdFP+P/QCLGMTI5BbpcDp1KjznoN8uGuZjVw8BpIqTALIT
         VjuNYXwQPNqJOmz0MJSEarzQqd+wQqB4ZLGD9rs4fXBdSBGbENmB3RHV+ro/AAMossRU
         DLrOY4HITuDz+nnL68dKM+325sgrK9rKljxkdh2m2+YkrGQOEgZHuxoO0/f1GOqnHq4m
         l+KGnvp0sJzn9HzdE0f4xmPXAq02m9yxuHgQVCXV2+ZZT4UgrmzNv7pypiC/LGnqfA8l
         mpIfny7WVFxpETKu30ulrlvBBEhVnsmhKKe3opHyAJPfmZJf+feowCK1UWgCw/2N9hIU
         ULXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003012; x=1725607812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCLEqvYFcYfbFDmBpnULkP78s+23ipk0h/fW+02tbBM=;
        b=NjF4EYM/ADhcxWc5pO8caOMFypcyatsgJ21goZwAvYW6idQKbd0EIiLHUr9dn4UDcH
         b+YqAwAw9POP1oN5rOIKMT1cAitaEGq08ZosAP/AwRucLrWSF2YUFy7pAJ7aIhGaJ0QY
         iiM3+2pn5lV0+qjPmgFVWfNNEwaHaRKjWu+VdNveh/razKtVlSSXv6OiL3CLgDwnToUT
         oGZ8pBijK98AuJXmVul9slY+HGkLSVuP9gwULoLReDvJ/yqiR5ttlTixmn3r293h3Iy9
         5JMTmSGhV2fZUX6BbUPDvfbwnTm96//PBbnYlRWb3u1vrxrl0ekFvoHzfBEFLtR/B9za
         7GRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnFPJLi3dhQuITYU7XW/Et8dDH5X4XZrLM0IpPyaCi/eIQr7q+/EkYiIirPvo+CjvosvKlp4BK40HMJQBAnIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxlmsSMBTjkJzr4I9lfYOb6YEQn0k62hAU0yV8lO1+24aM8Fv
	RK/iGuzd5RAsf5NfSwxTfYz1nv+Qi0gEXApcfDJIVQbKVtQyVaNvocQ5eZsE
X-Google-Smtp-Source: AGHT+IEs9SU9D0i7I40ChktQADK5+wH4dZhhKyxvKfHl0U8D/im4JnxT8BFD2i78X9laiER7tuLdYg==
X-Received: by 2002:a17:903:22c6:b0:1fd:d3db:bd06 with SMTP id d9443c01a7336-2050c34f1fcmr61723295ad.2.1725003012258;
        Fri, 30 Aug 2024 00:30:12 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:30:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/8] libbpf: Support linking bpf objects of either endianness
Date: Fri, 30 Aug 2024 00:29:28 -0700
Message-Id: <895753fe6de5a06dee8ac110f0c05571db73e70c.1724976539.git.tony.ambardar@gmail.com>
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


