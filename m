Return-Path: <linux-kselftest+bounces-16528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31C962599
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA038284A99
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1F316F0D8;
	Wed, 28 Aug 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iStrVjgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFA16D330;
	Wed, 28 Aug 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843550; cv=none; b=jWnvABxQ/ge+HKHuYpPVFac6kF7n61XggC45lQ7LZSBTiQGcZOOtJUpVNQHK6IfbmjMO7Jx9/2ZkaBV7fIhAnoTL8THFKV1We433yUK8fEJf6wlaOkRUj2JU9LxU1CQK41eU+kQ60ncgE/X28B2AX1y5Pn9S7krNr4nnN3c2ZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843550; c=relaxed/simple;
	bh=cCSoUGIyKrugqLiIrLt7jjiKapYN9RFiwzRWrolQPk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVoBwXc4EuHpQ0maSXBVNXRdMqxvkDB8+aBE0jcTbQz7Vh0PdrMOAT1p53sDEXLgzYDxu9smDNimXvkzodLUR9hv+mYbL7sr+RIYeBLXRvVdMxbuY7FHNM2hDaD2kOZ4ezvACedR9kTKu5TgNGtq/LsZpWXOzpmIrr6FjxV2oAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iStrVjgl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-202146e9538so59242945ad.3;
        Wed, 28 Aug 2024 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843547; x=1725448347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd+XrfNSZgsU9ay0utzjZwVOwYbcth9X5XnC4C0ipnM=;
        b=iStrVjglZtYnvaSRVkfF4bMTcR9vOB0sULVcAoF961Q77Yyu4JBIAA77hJfuqGqxKE
         DBZU3z52rk9rz4+t/NYT5CH8juXCUUfAyclCbitOU5NNbier9zYYAiL9kyFwckaNiRmW
         uBbV8WWY2IjbOMcvpK6FBkJURLeHFwGEaskWhFNR4ZfgtunOXMDQ+oha4Z101UWsiWVj
         OyM2Iu3xv3U6Az6OZXto9z1tnuxUGUwg/hXv6mQSiFpKZwcbiT6kxWfWmHaWzFOLflQ3
         x2yNYwSefz/va6IG93Wg483F3QwrAew7y/gpAwfJVM27QoKDO7rEJf55ioKGLVCMQTmr
         Qiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843547; x=1725448347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rd+XrfNSZgsU9ay0utzjZwVOwYbcth9X5XnC4C0ipnM=;
        b=m3jYrpPFQDUHwWV2zM6QwS+fF8LFk1fnxQSrZM/3UwNZhBmOrg+evd6XOhPag6VjbY
         R2f/yOsvH4vYU4vwjtHlju9EwAqe8ZMflRSWM01fnymJiXGeqWog0j2xeo8T5rH7rwY0
         T0JLRS/DoPnkmdN1D0dnujjahDcKN9qZ64DjcLCSUryjUb1ZKrGKAFdQKWhGZLozrZWX
         Rcoc8FumJ4VcHX/nXRxEYpOroz8cLjO9KE5ptzIO6NGCCq86Nd8xBiZDbCg0QELEIBhL
         kqucDoAEwhrHi9tBBzhPabdD1GFgUm9dfGcs3ViDWqMqYiNfvK4OybP8N8+Vee2SyOjs
         FpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpsVe/4RTko7T03tNy33VRPYLRsrT2mlNEE0qjzdR/oYVz4MlIPymv0HX8bp8sfbMTBzCecJFPm3OHvx3avsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0q3L8tf6ND8yNEkvZbD8eO57kqEVHXIPssIivZc/JNe7s1Qi
	G8bvhxs5ZUM9plhMdfvWX8cz0NMfz0pQfbtY229OEDtHpDrFDxujDoy7YfcO
X-Google-Smtp-Source: AGHT+IFd9upWmhr62Rf/sNzxKWYyWgaHmVHrbeF4ItfcbombynVBijjEcl43rRnN37UOKnXQSrRcUg==
X-Received: by 2002:a17:902:dace:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-2039e4bbee4mr207546275ad.37.1724843547492;
        Wed, 28 Aug 2024 04:12:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855678f9sm97369395ad.1.2024.08.28.04.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:12:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/8] libbpf: Support BTF.ext loading and output in either endianness
Date: Wed, 28 Aug 2024 04:11:54 -0700
Message-Id: <2f0ebdf09179d2674080aad60a9befd8acd89177.1724843049.git.tony.ambardar@gmail.com>
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

Support for handling BTF data of either endianness was added in [1], but
did not include BTF.ext data for lack of use cases. Later, support for
static linking [2] provided a use case, but this feature and later ones
were restricted to native-endian usage.

Add support for BTF.ext handling in either endianness. Convert BTF.ext data
to native endianness when read into memory for further processing, and
support raw data access that restores the original byte-order for output.

Add new API functions btf_ext__endianness() and btf_ext__set_endianness()
for query and setting byte-order, as already exist for BTF data.

[1] 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
[2] 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c             | 226 +++++++++++++++++++++++++++++---
 tools/lib/bpf/btf.h             |   3 +
 tools/lib/bpf/libbpf.map        |   2 +
 tools/lib/bpf/libbpf_internal.h |   2 +
 4 files changed, 217 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f5081de86ee0..07e39131d02f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3022,25 +3022,136 @@ static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
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
+/* Callback funcs to swap each type of info record, returning its size */
+static int func_info_bswap(void *p)
+{
+	struct bpf_func_info *fi = p;
+
+	fi->insn_off = bswap_32(fi->insn_off);
+	fi->type_id = bswap_32(fi->type_id);
+	return sizeof(*fi);
+}
+
+static int line_info_bswap(void *p)
+{
+	struct bpf_line_info *li = p;
+
+	li->insn_off = bswap_32(li->insn_off);
+	li->file_name_off = bswap_32(li->file_name_off);
+	li->line_off = bswap_32(li->line_off);
+	li->line_col = bswap_32(li->line_col);
+	return sizeof(*li);
+}
+
+static int core_relo_bswap(void *p)
+{
+	struct bpf_core_relo *cr = p;
+
+	_Static_assert(sizeof(cr->kind) == sizeof(__u32),
+		       "enum bpf_core_relo_kind is not 32-bit\n");
+	cr->insn_off = bswap_32(cr->insn_off);
+	cr->type_id = bswap_32(cr->type_id);
+	cr->access_str_off = bswap_32(cr->access_str_off);
+	cr->kind = bswap_32(cr->kind);
+	return sizeof(*cr);
+}
+
+/* Swap byte-order of a generic info subsection */
+static void info_subsec_bswap(const struct btf_ext_header *hdr, bool native,
+			      __u32 off, __u32 len, int (*fn_swap)(void *))
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
+			p += fn_swap(p);
+		si = p;
+		left -=  rec_size * num_info;
+	}
+}
+
+/*
+ * Swap endianness of the info segment in a BTF.ext data section:
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
+			  &func_info_bswap);
+
+	/* Swap line_info subsection byte-order */
+	info_subsec_bswap(hdr, native, hdr->line_info_off, hdr->line_info_len,
+			  &line_info_bswap);
+
+	/* Swap core_relo subsection byte-order (if present) */
+	if (hdr->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
+		return;
+
+	info_subsec_bswap(hdr, native, hdr->core_relo_off, hdr->core_relo_len,
+			  &core_relo_bswap);
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
@@ -3050,11 +3161,42 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
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
 
@@ -3066,6 +3208,7 @@ void btf_ext__free(struct btf_ext *btf_ext)
 	free(btf_ext->line_info.sec_idxs);
 	free(btf_ext->core_relo_info.sec_idxs);
 	free(btf_ext->data);
+	free(btf_ext->data_swapped);
 	free(btf_ext);
 }
 
@@ -3086,15 +3229,10 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
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
@@ -3119,15 +3257,71 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
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
index 8cda511a1982..6b0270c83537 100644
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
-- 
2.34.1


