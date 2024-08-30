Return-Path: <linux-kselftest+bounces-16763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8496588D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4331C219A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EDD166F35;
	Fri, 30 Aug 2024 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMK52TJn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF61531D8;
	Fri, 30 Aug 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003008; cv=none; b=nT4qtJCOSFh7uBk6JkOCXZpHjZNPTjKVZax5iN1Cb5xGBudti84FL+8tOa94sEqMmQNJuk1KBER8EqfRZoVf7YQJ1qfH9e5xwymdNB/bmi1LEvIsGlKGIP6DfUk8zoPOJdvubJpdJFZIlpsfTRSOLujPWXovJxxmO8lzhKC9kXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003008; c=relaxed/simple;
	bh=LkrBafs0NAlbpfTuD47AlJgJMZSzJnYvog6iNcs9XIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hknea0gGHJxrlXz3UJMbhHwTz77Hr9Q2fC6l5/XA7gYUKatekuNyJzVTiQCz3a/IRgJfZ1aN70Jo8GzFznW0Wuo1sb4pgF3XSeemFsDF7Mzkt2Fyrws9H/QHNGaxOKUU0oDtAL8OjthI74yZT70wfw2cqIk2ecLEjdQp4hhJslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMK52TJn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-204d391f53bso11966595ad.2;
        Fri, 30 Aug 2024 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725003006; x=1725607806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDhNeLRGMCGXFgaiAMyGz0HhiL4NmL5mHyzaYQ5Npec=;
        b=QMK52TJn9PeZSIwG8+m+hrasMIJt26J1xsgZ0jXia9fv/Guq0nMs2tznPGFygq+mJY
         e7LflrilYyv50Ee7PLB6e5VFArcJbJvBzJQdGcyG/5YJUCHX1VkP3w5eRHy9Vlll4rn3
         cyA8o2md/zc8t8fkWf2pB++Xicg2zQb0ylXdUsZZ3Q+bIRyrVA2Mnx/ZXQhoja3iT3Tg
         985rAPXa3QlHtb/Zm4xodl13h3jppmNx0Lsw33fckJR0JFk+s+v4/CifM+119JIEJsnP
         j+VIJlL0cZF5RB3DxrtDduoS3y5+/pkcnWu90GKSo3u6iWNFVnYxDF1iV6dAKUyW4bJ7
         98CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003006; x=1725607806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDhNeLRGMCGXFgaiAMyGz0HhiL4NmL5mHyzaYQ5Npec=;
        b=abiI6sPC84Q7zu5SKVPRsNa15nAXkSGFz0pf5jQ3wDz5faEy4U/yuYVgyk+6X4Y+hS
         +VvXLf3wyRECU/elGEurGjF0XcDL/MA0Otxu6gDTE6Sy7txaPvuqFOlbMOivBOzzfGKT
         U715bfELy64SX08UroM2M3MMyCt+kMqSpI33EJxMazfyZJQ6wnSwVhs2juhPtBMDF1V5
         OQpglOFKx6kbKac6IF0p1wH/MiIDR0aIEE403QV6NiUv5cEaMRTsJAVCVIFMttn983wR
         SGU/oCz+VSx1IRwGzrdMLkYETvwY5Lw8gzbHzMSdF+g1DquimOEJ53gK+TM3SzDclsL9
         U2qw==
X-Forwarded-Encrypted: i=1; AJvYcCUdOnUNwNe2qDKbgdHscDqU1rItHxlGxCrVdQD4AoMeg+whXjVnlmYFd6bpN3YEQhVGDxrNwra7bBrfBRfwQLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSTq+cauus8080GBp8ythaIz+vm0zw3fy278ohn90uVOI+yqd
	uzje5l39mFhRWlfjhSJHuGvzcgiwSOzm8BgqYo5AOTRWPClZ5g435b9AoPfc
X-Google-Smtp-Source: AGHT+IE8AXEwfirYXZhteZv/yl1lGSPAi+7whaciuszhDey8BHMBLPY5VAWsh/R9c1PbAuXkAtVZMA==
X-Received: by 2002:a17:902:d2cc:b0:1fd:6677:69b4 with SMTP id d9443c01a7336-2050c4a666bmr60117675ad.49.1725003005742;
        Fri, 30 Aug 2024 00:30:05 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:30:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/8] libbpf: Support BTF.ext loading and output in either endianness
Date: Fri, 30 Aug 2024 00:29:26 -0700
Message-Id: <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
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

Support for handling BTF data of either endianness was added in [1], but
did not include BTF.ext data for lack of use cases. Later, support for
static linking [2] provided a use case, but this feature and later ones
were restricted to native-endian usage.

Add support for BTF.ext handling in either endianness. Convert BTF.ext data
to native endianness when read into memory for further processing, and
support raw data access that restores the original byte-order for output.
Add internal header functions for byte-swapping func, line, and core info
records.

Add new API functions btf_ext__endianness() and btf_ext__set_endianness()
for query and setting byte-order, as already exist for BTF data.

[1] 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
[2] 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c             | 192 +++++++++++++++++++++++++++++---
 tools/lib/bpf/btf.h             |   3 +
 tools/lib/bpf/libbpf.map        |   2 +
 tools/lib/bpf/libbpf_internal.h |  33 ++++++
 4 files changed, 214 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f5081de86ee0..064cfe126c09 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3022,25 +3022,102 @@ static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
 	return btf_ext_setup_info(btf_ext, &param);
 }
 
-static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
+/* Swap byte-order of BTF.ext header with any endianness */
+static void btf_ext_bswap_hdr(struct btf_ext *btf_ext, __u32 hdr_len)
 {
-	const struct btf_ext_header *hdr = (struct btf_ext_header *)data;
+	struct btf_ext_header *h = btf_ext->hdr;
 
-	if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
-	    data_size < hdr->hdr_len) {
-		pr_debug("BTF.ext header not found\n");
+	h->magic = bswap_16(h->magic);
+	h->hdr_len = bswap_32(h->hdr_len);
+	h->func_info_off = bswap_32(h->func_info_off);
+	h->func_info_len = bswap_32(h->func_info_len);
+	h->line_info_off = bswap_32(h->line_info_off);
+	h->line_info_len = bswap_32(h->line_info_len);
+
+	if (hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
+		return;
+
+	h->core_relo_off = bswap_32(h->core_relo_off);
+	h->core_relo_len = bswap_32(h->core_relo_len);
+}
+
+/* Swap byte-order of a generic info subsection */
+static void info_subsec_bswap(const struct btf_ext_header *hdr, bool native,
+			      __u32 off, __u32 len, anon_info_bswap_fn_t bswap)
+{
+	__u32 left, i, *rs, rec_size, num_info;
+	struct btf_ext_info_sec *si;
+	void *p;
+
+	if (len == 0)
+		return;
+
+	rs = (void *)hdr + hdr->hdr_len + off;	/* record size */
+	si = (void *)rs + sizeof(__u32);	/* sec info #1 */
+	rec_size = native ? *rs : bswap_32(*rs);
+	*rs = bswap_32(*rs);
+	left = len - sizeof(__u32);
+	while (left > 0) {
+		num_info = native ? si->num_info : bswap_32(si->num_info);
+		si->sec_name_off = bswap_32(si->sec_name_off);
+		si->num_info = bswap_32(si->num_info);
+		left -= offsetof(struct btf_ext_info_sec, data);
+		p = si->data;
+		for (i = 0; i < num_info; i++)	/* list of records */
+			p += bswap(p);
+		si = p;
+		left -=  rec_size * num_info;
+	}
+}
+
+/*
+ * Swap endianness of the whole info segment in a BTF.ext data section:
+ *   - requires BTF.ext header data in native byte order
+ *   - only support info structs from BTF version 1
+ *   - native: current info data is native endianness
+ */
+static void btf_ext_bswap_info(struct btf_ext *btf_ext, bool native)
+{
+	const struct btf_ext_header *hdr = btf_ext->hdr;
+
+	/* Swap func_info subsection byte-order */
+	info_subsec_bswap(hdr, native, hdr->func_info_off, hdr->func_info_len,
+			  (anon_info_bswap_fn_t)bpf_func_info_bswap);
+
+	/* Swap line_info subsection byte-order */
+	info_subsec_bswap(hdr, native, hdr->line_info_off, hdr->line_info_len,
+			  (anon_info_bswap_fn_t)bpf_line_info_bswap);
+
+	/* Swap core_relo subsection byte-order (if present) */
+	if (hdr->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
+		return;
+
+	info_subsec_bswap(hdr, native, hdr->core_relo_off, hdr->core_relo_len,
+			  (anon_info_bswap_fn_t)bpf_core_relo_bswap);
+}
+
+/* Validate hdr data & info sections, convert to native endianness */
+static int btf_ext_parse(struct btf_ext *btf_ext)
+{
+	struct btf_ext_header *hdr = btf_ext->hdr;
+	__u32 hdr_len, info_size, data_size = btf_ext->data_size;
+
+	if (data_size < offsetofend(struct btf_ext_header, hdr_len)) {
+		pr_debug("BTF.ext header too short\n");
 		return -EINVAL;
 	}
 
+	hdr_len = hdr->hdr_len;
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
-		pr_warn("BTF.ext in non-native endianness is not supported\n");
-		return -ENOTSUP;
+		btf_ext->swapped_endian = true;
+		hdr_len = bswap_32(hdr_len);
 	} else if (hdr->magic != BTF_MAGIC) {
 		pr_debug("Invalid BTF.ext magic:%x\n", hdr->magic);
 		return -EINVAL;
 	}
 
-	if (hdr->version != BTF_VERSION) {
+	/* Ensure known version of structs, current BTF_VERSION == 1 */
+	if (hdr->version != 1) {
 		pr_debug("Unsupported BTF.ext version:%u\n", hdr->version);
 		return -ENOTSUP;
 	}
@@ -3050,11 +3127,42 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
 		return -ENOTSUP;
 	}
 
-	if (data_size == hdr->hdr_len) {
+	if (data_size < hdr_len) {
+		pr_debug("BTF.ext header not found\n");
+		return -EINVAL;
+	} else if (data_size == hdr_len) {
 		pr_debug("BTF.ext has no data\n");
 		return -EINVAL;
 	}
 
+	/* Verify mandatory hdr info details present */
+	if (hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
+		pr_warn("BTF.ext header missing func_info, line_info\n");
+		return -EINVAL;
+	}
+
+	/* Keep hdr native byte-order in memory for introspection */
+	if (btf_ext->swapped_endian)
+		btf_ext_bswap_hdr(btf_ext, hdr_len);
+
+	/* Basic info section consistency checks*/
+	info_size = btf_ext->data_size - hdr_len;
+	if (info_size & 0x03) {
+		pr_warn("BTF.ext info size not 4-byte multiple\n");
+		return -EINVAL;
+	}
+	info_size -= hdr->func_info_len + hdr->line_info_len;
+	if (hdr_len >= offsetofend(struct btf_ext_header, core_relo_len))
+		info_size -= hdr->core_relo_len;
+	if (info_size) {
+		pr_warn("BTF.ext info size mismatch with header data\n");
+		return -EINVAL;
+	}
+
+	/* Keep infos native byte-order in memory for introspection */
+	if (btf_ext->swapped_endian)
+		btf_ext_bswap_info(btf_ext, !btf_ext->swapped_endian);
+
 	return 0;
 }
 
@@ -3066,6 +3174,7 @@ void btf_ext__free(struct btf_ext *btf_ext)
 	free(btf_ext->line_info.sec_idxs);
 	free(btf_ext->core_relo_info.sec_idxs);
 	free(btf_ext->data);
+	free(btf_ext->data_swapped);
 	free(btf_ext);
 }
 
@@ -3086,15 +3195,10 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	}
 	memcpy(btf_ext->data, data, size);
 
-	err = btf_ext_parse_hdr(btf_ext->data, size);
+	err = btf_ext_parse(btf_ext);
 	if (err)
 		goto done;
 
-	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
-		err = -EINVAL;
-		goto done;
-	}
-
 	err = btf_ext_setup_func_info(btf_ext);
 	if (err)
 		goto done;
@@ -3119,15 +3223,71 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	return btf_ext;
 }
 
+static void *btf_ext_raw_data(const struct btf_ext *btf_ext_ro, __u32 *size,
+			      bool swap_endian)
+{
+	struct btf_ext *btf_ext = (struct btf_ext *)btf_ext_ro;
+	const __u32 data_sz = btf_ext->data_size;
+	void *data;
+
+	data = swap_endian ? btf_ext->data_swapped : btf_ext->data;
+	if (data) {
+		*size = data_sz;
+		return data;
+	}
+
+	data = calloc(1, data_sz);
+	if (!data)
+		return NULL;
+	memcpy(data, btf_ext->data, data_sz);
+
+	if (swap_endian) {
+		btf_ext_bswap_info(btf_ext, true);
+		btf_ext_bswap_hdr(btf_ext, btf_ext->hdr->hdr_len);
+		btf_ext->data_swapped = data;
+	}
+
+	*size = data_sz;
+	return data;
+}
+
 const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size)
 {
+	__u32 data_sz;
+	void *data;
+
+	data = btf_ext_raw_data(btf_ext, &data_sz, btf_ext->swapped_endian);
+	if (!data)
+		return errno = ENOMEM, NULL;
+
 	*size = btf_ext->data_size;
-	return btf_ext->data;
+	return data;
 }
 
 __attribute__((alias("btf_ext__raw_data")))
 const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32 *size);
 
+enum btf_endianness btf_ext__endianness(const struct btf_ext *btf_ext)
+{
+	if (is_host_big_endian())
+		return btf_ext->swapped_endian ? BTF_LITTLE_ENDIAN : BTF_BIG_ENDIAN;
+	else
+		return btf_ext->swapped_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
+}
+
+int btf_ext__set_endianness(struct btf_ext *btf_ext, enum btf_endianness endian)
+{
+	if (endian != BTF_LITTLE_ENDIAN && endian != BTF_BIG_ENDIAN)
+		return libbpf_err(-EINVAL);
+
+	btf_ext->swapped_endian = is_host_big_endian() != (endian == BTF_BIG_ENDIAN);
+
+	if (!btf_ext->swapped_endian) {
+		free(btf_ext->data_swapped);
+		btf_ext->data_swapped = NULL;
+	}
+	return 0;
+}
 
 struct btf_dedup;
 
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b68d216837a9..e3cf91687c78 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -167,6 +167,9 @@ LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API struct btf_ext *btf_ext__new(const __u8 *data, __u32 size);
 LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
 LIBBPF_API const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size);
+LIBBPF_API enum btf_endianness btf_ext__endianness(const struct btf_ext *btf_ext);
+LIBBPF_API int btf_ext__set_endianness(struct btf_ext *btf_ext,
+				       enum btf_endianness endian);
 
 LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8f0d9ea3b1b4..5c17632807b6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -421,6 +421,8 @@ LIBBPF_1.5.0 {
 	global:
 		btf__distill_base;
 		btf__relocate;
+		btf_ext__endianness;
+		btf_ext__set_endianness;
 		bpf_map__autoattach;
 		bpf_map__set_autoattach;
 		bpf_program__attach_sockmap;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 8cda511a1982..81d375015c2b 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -484,6 +484,8 @@ struct btf_ext {
 		struct btf_ext_header *hdr;
 		void *data;
 	};
+	void *data_swapped;
+	bool swapped_endian;
 	struct btf_ext_info func_info;
 	struct btf_ext_info line_info;
 	struct btf_ext_info core_relo_info;
@@ -511,6 +513,37 @@ struct bpf_line_info_min {
 	__u32	line_col;
 };
 
+/* Functions/typedef to help byte-swap info records, returning their size */
+
+typedef int (*anon_info_bswap_fn_t)(void *);
+
+static inline int bpf_func_info_bswap(struct bpf_func_info *i)
+{
+	i->insn_off = bswap_32(i->insn_off);
+	i->type_id = bswap_32(i->type_id);
+	return sizeof(*i);
+}
+
+static inline int bpf_line_info_bswap(struct bpf_line_info *i)
+{
+	i->insn_off = bswap_32(i->insn_off);
+	i->file_name_off = bswap_32(i->file_name_off);
+	i->line_off = bswap_32(i->line_off);
+	i->line_col = bswap_32(i->line_col);
+	return sizeof(*i);
+}
+
+static inline int bpf_core_relo_bswap(struct bpf_core_relo *i)
+{
+	_Static_assert(sizeof(i->kind) == sizeof(__u32),
+		       "enum bpf_core_relo_kind is not 32-bit\n");
+	i->insn_off = bswap_32(i->insn_off);
+	i->type_id = bswap_32(i->type_id);
+	i->access_str_off = bswap_32(i->access_str_off);
+	i->kind = bswap_32(i->kind);
+	return sizeof(*i);
+}
+
 enum btf_field_iter_kind {
 	BTF_FIELD_ITER_IDS,
 	BTF_FIELD_ITER_STRS,
-- 
2.34.1


