Return-Path: <linux-kselftest+bounces-18033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD6979CF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C6C1F23A7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93714600F;
	Mon, 16 Sep 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdHxY4CL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59301142905;
	Mon, 16 Sep 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475926; cv=none; b=oa9Zm3NGwvmjtOSSIpe8z0Re50Q9S776N0rQbwC1dl+dqkLSBJOW23l2srjqJlRsDd8SMZheHomhZeNq+8J1G0k+uigGdVcYeGFgqOqD+SIwM94LcDzFuWMrKe8IKmquOWJCJuut+fgrTYXMVhTnevqj/Vq5HHPjQoCd3VWM41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475926; c=relaxed/simple;
	bh=kqbj8/2GGp6dvWqARUQrfOUK5Uu74HFEWV26Aq5HzL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CC1bSnhpl0bBiSDl9RcRR48UKpxDO/s5vt4qoaGWz7hjgxx2Hc3GDyD+tVxRSFp71qEmYt2dNFlqNwUj7hITq/C2h7YmVk/GQmR5RS+K8zgVSaIFSydQkClNkY9MTnxuFmv6mofz0Zndls1Zf0qdmNEB7hJAD9BoKP9GXvwSjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdHxY4CL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so3427434a91.0;
        Mon, 16 Sep 2024 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475923; x=1727080723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ukOm1ON/R6xCBqebFJ1iu48OudSgMPQOBv+ztuCzP4=;
        b=EdHxY4CL9YEw4UcLa6V9ZfcTE/fbsw9yb1X7j7HkBDtQPZkoDe6LjUaCuPboh8+sly
         SabVZBNljxvv+slSTmr1XO40CmyjOS1pqqYyKOG2WVOEKLCOEdlPOq3JB5kUjkrAoaJR
         pf4aewzQrUsup1TsOTWjNFbwtT58NlSQN6Ay2j3YcAiOoO3tROUl8jn03JCGcnzfK4Q1
         swIwSe8L8UWQyW4CX7KlpXf7PFAwNH2Xvn0Kd/XFWz3EH2/hBVVh5/OenKV+shO0B6l/
         PSJxbDiSAnCqljKDjhbqYJiFt13OJ5UyeBfjN04Z7xZVFEzC4ZrDRreg79XRoxRhm6H/
         tNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475923; x=1727080723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ukOm1ON/R6xCBqebFJ1iu48OudSgMPQOBv+ztuCzP4=;
        b=rdVlDQhZzwY52WTqVExj1PIOZQjyT17nHOT7PGe3Z6upFtQ/DuekWfbYkV9QGZX0wa
         xOCBS/jH1XXEh+YhNzomFHuxCEfeOI6DKAY25tVZ/KRyg06A+RkQm/hJ/xDWI7IVOWwH
         fw3GS6wW1++p8dlvTL8TD5Uc4E6QUyrbluK1EmMrUlOShqkhJkZMvUc6mpUPMuBssSRR
         tbKsNGPP9+S2ETQ+4l3eW1h3IcdbdVAvgTNQ0oorRB6tgfSedaAQihfJ09BC19UPYcKP
         zQS4YjEUHqwGukXm4dV5kSrmTcKrnXUyruR3rugMytmXmv312DvBVG7gbO2V7SA1Nhzc
         X+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmdVaBFsE6aahHQjlN7IoiQwFsGR6piQyjW3rNZy2AXiHFfwes7aP0bAPPcr/tyYlt8yIRpcVM2hu9cJmEbnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHP7qL3MdFwQxBV0zbnNMzK2X2m5TI0gox/EU3dfHG1JEz8cbR
	xOUoJVZ6LjIkJmJmbnBliCmQXdf33rPgZ5zN68GehZyshdQNA6yZ+jpfIw==
X-Google-Smtp-Source: AGHT+IGQIH3Oyk4nP6lqmiiuMxEWl+ZNhasvaRckwVWMFMfeInL/e2TWtqnaBT8ID7pYmacgad28bQ==
X-Received: by 2002:a17:90b:1f8f:b0:2d8:859b:931c with SMTP id 98e67ed59e1d1-2dba0063accmr19577857a91.33.1726475923346;
        Mon, 16 Sep 2024 01:38:43 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:38:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 6/8] libbpf: Support linking bpf objects of either endianness
Date: Mon, 16 Sep 2024 01:37:45 -0700
Message-Id: <b47ca686d02664843fc99b96262fe3259650bc43.1726475448.git.tony.ambardar@gmail.com>
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
index 6985ab0f1ca9..81dbbdd79a7c 100644
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


