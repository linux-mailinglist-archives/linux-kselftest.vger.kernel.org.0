Return-Path: <linux-kselftest+bounces-16035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E899595B198
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194AF1C21112
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32740175D2E;
	Thu, 22 Aug 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJkUf13o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483117CA04;
	Thu, 22 Aug 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318719; cv=none; b=AJH3hNlrSQc2BwDXKUFiek+mT8hBscUliCHz/ivDBFe0xTPBz85t7SIPfP9sqrsN+9KsW1kDZhB2R8pALdMWT541v+qANOo8EPkTCWKUnjHhx09sYlzOb2uCh0m0v5Xhgd2n6hcCrnAM0+46D2XZzJgwm/jG9SRV+VfLEE1FLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318719; c=relaxed/simple;
	bh=3iba5shuWIPRob4xl4OC8v28mHjKpMh2GQUEY5z+3sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQytQJMAawsOEQN2HpkeX+Q9B8d6f/XO8r6FdWGKKagtrmW6jxN5hhhe7+f2J8G47GAKHIdAMnZMx+3xkaz+15FuC62ugZgifZTI1YyPOiBu+kUQJMMJSL8su0KhzRG5JCvfG4WbApxomjDo1tvxF1plYysAmMLIkG5fL252ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJkUf13o; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso418035a12.0;
        Thu, 22 Aug 2024 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318716; x=1724923516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/2EqU7ePbWpHVQO4hsS/Hu1P6Ii9BBD02yY+gGUd20=;
        b=CJkUf13oMBXA/lJ150PLqlH9edmgqwYCxfCe9CMVKn1mucshFzk4oQlKF4Bldydiv4
         IB9QR0kRAMQKE6Zf1ouk0dA3v8Nm4l7UGMu9LTqP2bPykCpJkPmBr59vOuoynXqIqAKm
         bokrCuKSfp4p860CoGruipVhsHqz847ZspstFIMOS2pl11pXMzlt9HqCsefRhkwxDhqz
         dUbeHxdfrgDkbctEeVy3ML4izETuuGBSd6Bh6T1EZ64m93NE+A1bvzypBsiajeZXmnG4
         ZEXYk6hjkYclL+hX3wsTJy10aCObDnx285P5XPayIHxe8LrIpHD123jnmH0sln6Wo5K2
         5Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318716; x=1724923516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/2EqU7ePbWpHVQO4hsS/Hu1P6Ii9BBD02yY+gGUd20=;
        b=t7P4PZWexg7oURQjP6Tl3qprih6MYqA53V1oLap8/0rlxu3knpAtWjRoWWZ7ny64Jh
         LB/NOxdKyaf94t5OMZFtOEsXkIu91Aq4bHwYxX9hTBzV6I/8MsP8ZcyUtPwOl8IjOeG+
         29K3hyyMfMdjN47YMk7ewp64t79UrNzxvQBwDn8x27ejhS67n1KxYGeHKkbrqNoNrJDP
         JXC7FrCRgx2vMavGGqxgYdTiNHjTh1InaHrSSS0RiFvTO1bJCBu4Ip/y5k1B2b/gUTfV
         mArrIJugDtzF1qM/oYUO6XlSQ1tg9N5UuJWSH3MjX6T/3DGDZtBjvctKFezFDu8UaZnf
         G5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWnwiH6PrgzwgM6ygKfIwJip0tj2SUIz845TYHQNlLvLcQboyVIA7itTWs5utMQkZSNqlpgZEtl8XbTGD00kXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mSKbaQTibSFtTEvrtb00QYBNeUAxa3rIqE4URHxS3Hcx2W8Z
	KDBcHbAK/DirsL7CLWPJ0pM9neQIRyYviH8725X7jgzqaPpgo2TTVQNAGk+a
X-Google-Smtp-Source: AGHT+IG0uI8/6be/Wxk3fVJRCm9SwVLlF3b/C3lWzJ651CC/ujMUdANwIzttDWZBYnlq3Wued8voMQ==
X-Received: by 2002:a17:90a:7142:b0:2ca:7636:2214 with SMTP id 98e67ed59e1d1-2d6169beddcmr1378874a91.4.1724318716221;
        Thu, 22 Aug 2024 02:25:16 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:25:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 7/8] libbpf: Support creating light skeleton of either endianness
Date: Thu, 22 Aug 2024 02:24:30 -0700
Message-Id: <94a6100651e3f61166703cf143f6366b15ee0d21.1724313164.git.tony.ambardar@gmail.com>
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

Track target endianness in 'struct bpf_gen' and process in-memory data in
native byte-order, but on finalization convert the embedded loader BPF
insns to target endianness.

The light skeleton also includes a target-accessed data blob which is
heterogeneous and thus difficult to convert to target byte-order on
finalization. Add support functions to convert data to target endianness
as it is added to the blob.

Also add additional debug logging for data blob structure details and
skeleton loading.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/bpf_gen_internal.h |   1 +
 tools/lib/bpf/gen_loader.c       | 187 +++++++++++++++++++++++--------
 tools/lib/bpf/libbpf.c           |   1 +
 tools/lib/bpf/skel_internal.h    |   3 +-
 4 files changed, 147 insertions(+), 45 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index fdf44403ff36..6ff963a491d9 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -34,6 +34,7 @@ struct bpf_gen {
 	void *data_cur;
 	void *insn_start;
 	void *insn_cur;
+	bool swapped_endian;
 	ssize_t cleanup_label;
 	__u32 nr_progs;
 	__u32 nr_maps;
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index cf3323fd47b8..00ed416a2f69 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -401,6 +401,15 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 		opts->insns_sz = gen->insn_cur - gen->insn_start;
 		opts->data = gen->data_start;
 		opts->data_sz = gen->data_cur - gen->data_start;
+
+		/* use target endianness for embedded loader */
+		if (gen->swapped_endian) {
+			struct bpf_insn *insn = (struct bpf_insn *)opts->insns;
+			int insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
+
+			for (i = 0; i < insn_cnt; i++)
+				bpf_insn_bswap(insn++);
+		}
 	}
 	return gen->error;
 }
@@ -414,6 +423,33 @@ void bpf_gen__free(struct bpf_gen *gen)
 	free(gen);
 }
 
+/*
+ * Fields of bpf_attr are set to values in native byte-order before being
+ * written to the target-bound data blob, and may need endian conversion.
+ * This macro allows setting the correct value in situ and is simpler than
+ * writing a separate converter for *all fields* of *all records* included
+ * in union bpf_attr.
+ */
+#define move_tgt_endian(lval, rval) {				\
+	if (!gen->swapped_endian)				\
+		lval = (rval);					\
+	else							\
+		switch (sizeof(lval)) {				\
+		case 2:						\
+			lval = bswap_16(rval);			\
+			break;					\
+		case 4:						\
+			lval = bswap_32(rval);			\
+			break;					\
+		case 8:						\
+			lval = bswap_64(rval);			\
+			break;					\
+		default:					\
+			lval = (rval);				\
+			pr_warn("unsupported bswap size!\n");	\
+		}						\
+	}
+
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
 		       __u32 btf_raw_size)
 {
@@ -422,11 +458,13 @@ void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
 	union bpf_attr attr;
 
 	memset(&attr, 0, attr_size);
-	pr_debug("gen: load_btf: size %d\n", btf_raw_size);
 	btf_data = add_data(gen, btf_raw_data, btf_raw_size);
+	pr_debug("gen: load_btf: off %d size %d\n", btf_data, btf_raw_size);
 
-	attr.btf_size = btf_raw_size;
+	move_tgt_endian(attr.btf_size, btf_raw_size);
 	btf_load_attr = add_data(gen, &attr, attr_size);
+	pr_debug("gen: load_btf: btf_load_attr: off %d size %d\n",
+		 btf_load_attr, attr_size);
 
 	/* populate union bpf_attr with user provided log details */
 	move_ctx2blob(gen, attr_field(btf_load_attr, btf_log_level), 4,
@@ -457,28 +495,30 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	union bpf_attr attr;
 
 	memset(&attr, 0, attr_size);
-	attr.map_type = map_type;
-	attr.key_size = key_size;
-	attr.value_size = value_size;
-	attr.map_flags = map_attr->map_flags;
-	attr.map_extra = map_attr->map_extra;
+	move_tgt_endian(attr.map_type, map_type);
+	move_tgt_endian(attr.key_size, key_size);
+	move_tgt_endian(attr.value_size, value_size);
+	move_tgt_endian(attr.map_flags, map_attr->map_flags);
+	move_tgt_endian(attr.map_extra, map_attr->map_extra);
 	if (map_name)
 		libbpf_strlcpy(attr.map_name, map_name, sizeof(attr.map_name));
-	attr.numa_node = map_attr->numa_node;
-	attr.map_ifindex = map_attr->map_ifindex;
-	attr.max_entries = max_entries;
-	attr.btf_key_type_id = map_attr->btf_key_type_id;
-	attr.btf_value_type_id = map_attr->btf_value_type_id;
+	move_tgt_endian(attr.numa_node, map_attr->numa_node);
+	move_tgt_endian(attr.map_ifindex, map_attr->map_ifindex);
+	move_tgt_endian(attr.max_entries, max_entries);
+	move_tgt_endian(attr.btf_key_type_id, map_attr->btf_key_type_id);
+	move_tgt_endian(attr.btf_value_type_id, map_attr->btf_value_type_id);
 
 	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d\n",
-		 attr.map_name, map_idx, map_type, attr.btf_value_type_id);
+		 map_name, map_idx, map_type, map_attr->btf_value_type_id);
 
 	map_create_attr = add_data(gen, &attr, attr_size);
-	if (attr.btf_value_type_id)
+	pr_debug("gen: map_create: map_create_attr: off %d size %d\n",
+		 map_create_attr, attr_size);
+	if (map_attr->btf_value_type_id)
 		/* populate union bpf_attr with btf_fd saved in the stack earlier */
 		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
 				stack_off(btf_fd));
-	switch (attr.map_type) {
+	switch (map_type) {
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 	case BPF_MAP_TYPE_HASH_OF_MAPS:
 		move_stack2blob(gen, attr_field(map_create_attr, inner_map_fd), 4,
@@ -498,8 +538,8 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	/* emit MAP_CREATE command */
 	emit_sys_bpf(gen, BPF_MAP_CREATE, map_create_attr, attr_size);
 	debug_ret(gen, "map_create %s idx %d type %d value_size %d value_btf_id %d",
-		  attr.map_name, map_idx, map_type, value_size,
-		  attr.btf_value_type_id);
+		  map_name, map_idx, map_type, value_size,
+		  map_attr->btf_value_type_id);
 	emit_check_err(gen);
 	/* remember map_fd in the stack, if successful */
 	if (map_idx < 0) {
@@ -784,12 +824,12 @@ static void emit_relo_ksym_typeless(struct bpf_gen *gen,
 	emit_ksym_relo_log(gen, relo, kdesc->ref);
 }
 
-static __u32 src_reg_mask(void)
+static __u32 src_reg_mask(struct bpf_gen *gen)
 {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	return 0x0f; /* src_reg,dst_reg,... */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	return 0xf0; /* dst_reg,src_reg,... */
+#if defined(__LITTLE_ENDIAN_BITFIELD) /* src_reg,dst_reg,... */
+	return gen->swapped_endian ? 0xf0 : 0x0f;
+#elif defined(__BIG_ENDIAN_BITFIELD) /* dst_reg,src_reg,... */
+	return gen->swapped_endian ? 0x0f : 0xf0;
 #else
 #error "Unsupported bit endianness, cannot proceed"
 #endif
@@ -840,7 +880,7 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 3));
 clear_src_reg:
 	/* clear bpf_object__relocate_data's src_reg assignment, otherwise we get a verifier failure */
-	reg_mask = src_reg_mask();
+	reg_mask = src_reg_mask(gen);
 	emit(gen, BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_8, offsetofend(struct bpf_insn, code)));
 	emit(gen, BPF_ALU32_IMM(BPF_AND, BPF_REG_9, reg_mask));
 	emit(gen, BPF_STX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, offsetofend(struct bpf_insn, code)));
@@ -931,11 +971,34 @@ static void cleanup_relos(struct bpf_gen *gen, int insns)
 	cleanup_core_relo(gen);
 }
 
+/* Covert func, line, and core relo info records to target endianness,
+ * checking the blob size is consistent with 32-bit fields.
+ */
+static void info_blob_bswap(struct bpf_gen *gen, int info_off, __u32 size)
+{
+	__u32 *field = gen->data_start + info_off;
+	int i, cnt = size / sizeof(__u32);
+
+	if (size && size % sizeof(__u32)) {
+		pr_warn("info records not using 32-bit fields!\n");
+		return;
+	}
+	if (gen->swapped_endian)
+		for (i = 0; i < cnt; i++, field++)
+			*field = bswap_32(*field);
+}
+
 void bpf_gen__prog_load(struct bpf_gen *gen,
 			enum bpf_prog_type prog_type, const char *prog_name,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
 			struct bpf_prog_load_opts *load_attr, int prog_idx)
 {
+	int func_info_tot_sz = load_attr->func_info_cnt *
+			       load_attr->func_info_rec_size;
+	int line_info_tot_sz = load_attr->line_info_cnt *
+			       load_attr->line_info_rec_size;
+	int core_relo_tot_sz = gen->core_relo_cnt *
+			       sizeof(struct bpf_core_relo);
 	int prog_load_attr, license_off, insns_off, func_info, line_info, core_relos;
 	int attr_size = offsetofend(union bpf_attr, core_relo_rec_size);
 	union bpf_attr attr;
@@ -947,32 +1010,60 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	license_off = add_data(gen, license, strlen(license) + 1);
 	/* add insns to blob of bytes */
 	insns_off = add_data(gen, insns, insn_cnt * sizeof(struct bpf_insn));
+	pr_debug("gen: prog_load: license off %d insn off %d\n",
+		 license_off, insns_off);
 
-	attr.prog_type = prog_type;
-	attr.expected_attach_type = load_attr->expected_attach_type;
-	attr.attach_btf_id = load_attr->attach_btf_id;
-	attr.prog_ifindex = load_attr->prog_ifindex;
-	attr.kern_version = 0;
-	attr.insn_cnt = (__u32)insn_cnt;
-	attr.prog_flags = load_attr->prog_flags;
-
-	attr.func_info_rec_size = load_attr->func_info_rec_size;
-	attr.func_info_cnt = load_attr->func_info_cnt;
-	func_info = add_data(gen, load_attr->func_info,
-			     attr.func_info_cnt * attr.func_info_rec_size);
+	/* convert blob insns to target endianness */
+	if (gen->swapped_endian) {
+		struct bpf_insn *insn = gen->data_start + insns_off;
+		int i;
 
-	attr.line_info_rec_size = load_attr->line_info_rec_size;
-	attr.line_info_cnt = load_attr->line_info_cnt;
-	line_info = add_data(gen, load_attr->line_info,
-			     attr.line_info_cnt * attr.line_info_rec_size);
+		for (i = 0; i < insn_cnt; i++, insn++)
+			bpf_insn_bswap(insn);
+	}
 
-	attr.core_relo_rec_size = sizeof(struct bpf_core_relo);
-	attr.core_relo_cnt = gen->core_relo_cnt;
-	core_relos = add_data(gen, gen->core_relos,
-			     attr.core_relo_cnt * attr.core_relo_rec_size);
+	move_tgt_endian(attr.prog_type, prog_type);
+	move_tgt_endian(attr.expected_attach_type, load_attr->expected_attach_type);
+	move_tgt_endian(attr.attach_btf_id, load_attr->attach_btf_id);
+	move_tgt_endian(attr.prog_ifindex, load_attr->prog_ifindex);
+	attr.kern_version = 0;
+	move_tgt_endian(attr.insn_cnt, (__u32)insn_cnt);
+	move_tgt_endian(attr.prog_flags, load_attr->prog_flags);
+
+	move_tgt_endian(attr.func_info_rec_size, load_attr->func_info_rec_size);
+	move_tgt_endian(attr.func_info_cnt, load_attr->func_info_cnt);
+	func_info = add_data(gen, load_attr->func_info, func_info_tot_sz);
+	pr_debug("gen: prog_load: func_info: off %d cnt %d rec size %d\n",
+		 func_info, load_attr->func_info_cnt,
+		 load_attr->func_info_rec_size);
+
+	/* convert info blob fields to target endianness */
+	info_blob_bswap(gen, func_info, func_info_tot_sz);
+
+	move_tgt_endian(attr.line_info_rec_size, load_attr->line_info_rec_size);
+	move_tgt_endian(attr.line_info_cnt, load_attr->line_info_cnt);
+	line_info = add_data(gen, load_attr->line_info, line_info_tot_sz);
+	pr_debug("gen: prog_load: line_info: off %d cnt %d rec size %d\n",
+		 line_info, load_attr->line_info_cnt,
+		 load_attr->line_info_rec_size);
+
+	/* convert info blob fields to target endianness */
+	info_blob_bswap(gen, line_info, line_info_tot_sz);
+
+	move_tgt_endian(attr.core_relo_rec_size, sizeof(struct bpf_core_relo));
+	move_tgt_endian(attr.core_relo_cnt, gen->core_relo_cnt);
+	core_relos = add_data(gen, gen->core_relos, core_relo_tot_sz);
+	pr_debug("gen: prog_load: core_relos: off %d cnt %d rec size %zd\n",
+		 core_relos, gen->core_relo_cnt,
+		 sizeof(struct bpf_core_relo));
+
+	/* convert info blob fields to target endianness */
+	info_blob_bswap(gen, core_relos, core_relo_tot_sz);
 
 	libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
 	prog_load_attr = add_data(gen, &attr, attr_size);
+	pr_debug("gen: prog_load: prog_load_attr: off %d size %d\n",
+		 prog_load_attr, attr_size);
 
 	/* populate union bpf_attr with a pointer to license */
 	emit_rel_store(gen, attr_field(prog_load_attr, license), license_off);
@@ -1068,6 +1159,8 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
 
 	map_update_attr = add_data(gen, &attr, attr_size);
+	pr_debug("gen: map_update_elem: map_update_attr: off %d size %d\n",
+		 map_update_attr, attr_size);
 	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
 		       blob_fd_array_off(gen, map_idx));
 	emit_rel_store(gen, attr_field(map_update_attr, key), key);
@@ -1084,14 +1177,18 @@ void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int slo
 	int attr_size = offsetofend(union bpf_attr, flags);
 	int map_update_attr, key;
 	union bpf_attr attr;
+	int tgt_slot;
 
 	memset(&attr, 0, attr_size);
 	pr_debug("gen: populate_outer_map: outer %d key %d inner %d\n",
 		 outer_map_idx, slot, inner_map_idx);
 
-	key = add_data(gen, &slot, sizeof(slot));
+	move_tgt_endian(tgt_slot, slot);
+	key = add_data(gen, &tgt_slot, sizeof(tgt_slot));
 
 	map_update_attr = add_data(gen, &attr, attr_size);
+	pr_debug("gen: populate_outer_map: map_update_attr: off %d size %d\n",
+		 map_update_attr, attr_size);
 	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
 		       blob_fd_array_off(gen, outer_map_idx));
 	emit_rel_store(gen, attr_field(map_update_attr, key), key);
@@ -1114,6 +1211,8 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx)
 	memset(&attr, 0, attr_size);
 	pr_debug("gen: map_freeze: idx %d\n", map_idx);
 	map_freeze_attr = add_data(gen, &attr, attr_size);
+	pr_debug("gen: map_freeze: map_update_attr: off %d size %d\n",
+		 map_freeze_attr, attr_size);
 	move_blob2blob(gen, attr_field(map_freeze_attr, map_fd), 4,
 		       blob_fd_array_off(gen, map_idx));
 	/* emit MAP_FREEZE command */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a542031f4f73..8b6c212eb9a3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9106,6 +9106,7 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 	if (!gen)
 		return -ENOMEM;
 	gen->opts = opts;
+	gen->swapped_endian = bpf_object__check_endianness(obj);
 	obj->gen_loader = gen;
 	return 0;
 }
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 1e82ab06c3eb..67e8477ecb5b 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -351,10 +351,11 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	attr.test.ctx_size_in = opts->ctx->sz;
 	err = skel_sys_bpf(BPF_PROG_RUN, &attr, test_run_attr_sz);
 	if (err < 0 || (int)attr.test.retval < 0) {
-		opts->errstr = "failed to execute loader prog";
 		if (err < 0) {
+			opts->errstr = "failed to execute loader prog";
 			set_err;
 		} else {
+			opts->errstr = "error returned by loader prog";
 			err = (int)attr.test.retval;
 #ifndef __KERNEL__
 			errno = -err;
-- 
2.34.1


