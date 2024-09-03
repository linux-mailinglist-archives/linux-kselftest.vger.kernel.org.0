Return-Path: <linux-kselftest+bounces-17025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D95449695A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47306B243E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07601D61B1;
	Tue,  3 Sep 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrMp+A8X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7E1C62B1;
	Tue,  3 Sep 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348832; cv=none; b=gRyD21uQ0GR/1p7OzMix+JOqjgLTH9jnHd/jFQckRlakvH4BAgaKPm2YQFPJqyKq0kzyNYIp8ZGWiXMEjetombda7GeXooyuGBzg7MWgKc/WfLuWJyVR7wHf4//Djpbl+xCHxTu0PdTbvlZ/v2P6FEYKNvh5eE8OtsihJupfP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348832; c=relaxed/simple;
	bh=k3ZjPP1rqddXBA/KZAUO4HVktb5TTY8difh99oZDuWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVOC6QDQtBWafgaUoDEogt9GdIEeOQ9jEofOzIDBUKeIdU6DUSRcnCETccJ4rcWO/TYupgnXmW7csFXJZBMS6N/5JEaCWe33Ajqwq5djc6AZDfJ9JtUHAr1EnVECFvB4BwXbdPZnphD7rzTjv1ZaCYVKNdzK7/Sz7STKP3Zx1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrMp+A8X; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-277e4327c99so1137171fac.0;
        Tue, 03 Sep 2024 00:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348830; x=1725953630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOd9rxvV+OwBcufSp0Yu05Lbr5FDDuHNkEid/pTp9vs=;
        b=GrMp+A8X4RMhisBr8OqRqVmZfI7tPNiOFM5W2YO4ip5q64wORtISayUTp8d9H+9gcp
         rMaZgCuvZHBZ2gKpzN0CCDmu9PH/nQ4DUpARd4EJEYsMreJevSl6gYBmU9BkPpG+nN4T
         HcgNSgCT/i9nZCD9LyNgWcM6nKuFNVPmwRraWpndWy4LuLHfPF3VrXZ6I9l64azTH6+t
         cgugjfHBA1yw8aGeF3Y+2PW6AqY4fW4VFfb61YZGMp88RsrAtWHVk3BSemSCCMMFalHF
         FYMYI2aNFxHZ/8BROZipfK2UCazOFGqOCRuYoZnltqNLEtONXmQOHG5dKhJ6oRoykxqR
         2bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348830; x=1725953630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOd9rxvV+OwBcufSp0Yu05Lbr5FDDuHNkEid/pTp9vs=;
        b=nnfI7EdS7buvWIfgVSgLQfLryKRwG37QqdTCsikvqWbfPJkwaKvVHD1tA5B5Xw2Pvq
         iirJR9qkHUf5Ih6XDUY+8C9it2gExtGIPwSeYj/4mqtLmcSPmIOUZtYSNW7DACz+PUNj
         HIIvMC02R17tstAZzfPLXsNy16CwHr5lEgDqwvRxa6NI1/NJrESJlVpJgOZlt/6NWJc4
         kKAZIDUlr5z7AgCW5JB1qdfWImf0mAfgvLFVDfqtRUgembY9RH1BTBUQy3qeFxmgn0RJ
         9DXHlFVTJZ0ATKk4a1PiBhrKZ71JU1L1mL+/MfAjdF3MEAQWLVdANIntusbpSk+krKDu
         oJyg==
X-Forwarded-Encrypted: i=1; AJvYcCUzc1W2Fombwww6qV1ufg+wzojtVX+6oTYOFrAmgdVI2Nk58NzsSMPYkj5CPpd+GyXlfxnpjPrXHUSn16DTSNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZijp3j4KyMUfe+Sg4IqT3rX4UXAnUlIvvluw9AuMACWCk9tM
	AvqXl77S2CxMjKx+Tf7o3MXzTz1ypXOzPk4+vH9DU8Gf0a6qCQWwcXNrGhKn
X-Google-Smtp-Source: AGHT+IHRoaXOCgKZ1lOni463bc/YKzI7utTHNYeWxox8gVwblH0pj6OJ4ItQfXt5EcMemilOv8hRog==
X-Received: by 2002:a05:6871:588:b0:254:bd24:de83 with SMTP id 586e51a60fabf-277d03a4fb5mr11928552fac.12.1725348829587;
        Tue, 03 Sep 2024 00:33:49 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:33:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 4/8] libbpf: Support BTF.ext loading and output in either endianness
Date: Tue,  3 Sep 2024 00:33:01 -0700
Message-Id: <596b03b8e225de62e6877346fbed19502a205c88.1725347944.git.tony.ambardar@gmail.com>
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
 tools/lib/bpf/btf.c             | 238 +++++++++++++++++++++++++++++---
 tools/lib/bpf/btf.h             |   3 +
 tools/lib/bpf/libbpf.map        |   2 +
 tools/lib/bpf/libbpf_internal.h |  28 ++++
 4 files changed, 255 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 5f094c1f4388..c11dfc81d007 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3023,25 +3023,140 @@ static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
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
+/* Swap metadata byte-order of generic info subsection */
+static int info_subsec_bswap_metadata(const struct btf_ext *btf_ext, struct btf_ext_info *ext_info)
+{
+	const bool is_native = btf_ext->swapped_endian;
+	__u32 left, *rs, rec_size, num_info;
+	struct btf_ext_info_sec *si;
+
+	if (ext_info->len == 0)
+		return 0;
+
+	rs = ext_info->info - sizeof(__u32);	/* back up to record size */
+	rec_size = is_native ? *rs : bswap_32(*rs);
+	if (rec_size != ext_info->rec_size)
 		return -EINVAL;
+	*rs = bswap_32(*rs);
+
+	si = ext_info->info;			/* sec info #1 */
+	left = ext_info->len;
+	while (left > 0) {
+		num_info = is_native ? si->num_info : bswap_32(si->num_info);
+		si->sec_name_off = bswap_32(si->sec_name_off);
+		si->num_info = bswap_32(si->num_info);
+		si = (void *)si->data + rec_size * num_info;
+		left -= offsetof(struct btf_ext_info_sec, data) +
+			rec_size * num_info;
 	}
 
+	return 0;
+}
+
+/* Swap byte order of info subsection metadata and records in the correct
+ * order depending on whether or not data is in native endianness.
+ */
+#define ORDER_INFO_BSWAP(btf_ext, ext_info, info_t, swap_fn)		\
+{									\
+	const bool is_native = btf_ext->swapped_endian;			\
+	struct btf_ext_info_sec *si;					\
+	int c, err;							\
+	info_t *i;							\
+	if (is_native)							\
+		for_each_btf_ext_sec(ext_info, si)			\
+			for_each_btf_ext_rec(ext_info, si, c, i)	\
+				swap_fn(i);				\
+	err = info_subsec_bswap_metadata(btf_ext, ext_info);		\
+	if (err) {							\
+		pr_warn(#info_t " record size mismatch!\n");		\
+		return err;						\
+	}								\
+	if (!is_native)							\
+		for_each_btf_ext_sec(ext_info, si)			\
+			for_each_btf_ext_rec(ext_info, si, c, i)	\
+				swap_fn(i);				\
+}
+
+/*
+ * Swap endianness of the whole info segment in a BTF.ext data section:
+ *   - requires BTF.ext header data in native byte order
+ *   - only support info structs from BTF version 1
+ */
+static int btf_ext_bswap_info(struct btf_ext *btf_ext)
+{
+	const struct btf_ext_header *h = btf_ext->hdr;
+	struct btf_ext_info ext = {};
+
+	/* Swap func_info subsection byte-order */
+	ext.info = (void *)h + h->hdr_len + h->func_info_off + sizeof(__u32);
+	ext.len = h->func_info_len - (h->func_info_len ? sizeof(__u32) : 0);
+	ext.rec_size = sizeof(struct bpf_func_info);
+
+	ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_func_info, bpf_func_info_bswap);
+
+	/* Swap line_info subsection byte-order */
+	ext.info = (void *)h + h->hdr_len + h->line_info_off + sizeof(__u32);
+	ext.len = h->line_info_len - (h->line_info_len ? sizeof(__u32) : 0);
+	ext.rec_size = sizeof(struct bpf_line_info);
+
+	ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_line_info, bpf_line_info_bswap);
+
+	/* Swap core_relo subsection byte-order (if present) */
+	if (h->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
+		return 0;
+
+	ext.info = (void *)h + h->hdr_len + h->core_relo_off + sizeof(__u32);
+	ext.len = h->core_relo_len - (h->core_relo_len ? sizeof(__u32) : 0);
+	ext.rec_size = sizeof(struct bpf_core_relo);
+
+	ORDER_INFO_BSWAP(btf_ext, &ext, struct bpf_core_relo, bpf_core_relo_bswap);
+
+	return 0;
+}
+#undef ORDER_INFO_BSWAP
+
+/* Validate hdr data & info sections, convert to native endianness */
+static int btf_ext_parse(struct btf_ext *btf_ext)
+{
+	__u32 hdr_len, info_size, data_size = btf_ext->data_size;
+	struct btf_ext_header *hdr = btf_ext->hdr;
+	bool swapped_endian = false;
+
+	if (data_size < offsetofend(struct btf_ext_header, hdr_len)) {
+		pr_debug("BTF.ext header too short\n");
+		return -EINVAL;
+	}
+
+	hdr_len = hdr->hdr_len;
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
-		pr_warn("BTF.ext in non-native endianness is not supported\n");
-		return -ENOTSUP;
+		swapped_endian = true;
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
@@ -3051,11 +3166,50 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
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
+	if (swapped_endian)
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
+	if (swapped_endian) {
+		int err = btf_ext_bswap_info(btf_ext);
+		if (err)
+			return err;
+	}
+	/*
+	 * Set btf_ext->swapped_endian only after all header and info data has
+	 * been swapped, helping btf_ext_bswap_info() determine if its data
+	 * is in native byte order when called.
+	 */
+	btf_ext->swapped_endian = swapped_endian;
 	return 0;
 }
 
@@ -3067,6 +3221,7 @@ void btf_ext__free(struct btf_ext *btf_ext)
 	free(btf_ext->line_info.sec_idxs);
 	free(btf_ext->core_relo_info.sec_idxs);
 	free(btf_ext->data);
+	free(btf_ext->data_swapped);
 	free(btf_ext);
 }
 
@@ -3087,15 +3242,10 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
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
@@ -3120,15 +3270,71 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
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
+		btf_ext_bswap_info(btf_ext);
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
index 8cda511a1982..a8531195acd4 100644
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
@@ -511,6 +513,32 @@ struct bpf_line_info_min {
 	__u32	line_col;
 };
 
+/* Functions to byte-swap info records */
+
+static inline void bpf_func_info_bswap(struct bpf_func_info *i)
+{
+	i->insn_off = bswap_32(i->insn_off);
+	i->type_id = bswap_32(i->type_id);
+}
+
+static inline void bpf_line_info_bswap(struct bpf_line_info *i)
+{
+	i->insn_off = bswap_32(i->insn_off);
+	i->file_name_off = bswap_32(i->file_name_off);
+	i->line_off = bswap_32(i->line_off);
+	i->line_col = bswap_32(i->line_col);
+}
+
+static inline void bpf_core_relo_bswap(struct bpf_core_relo *i)
+{
+	_Static_assert(sizeof(i->kind) == sizeof(__u32),
+		       "enum bpf_core_relo_kind is not 32-bit\n");
+	i->insn_off = bswap_32(i->insn_off);
+	i->type_id = bswap_32(i->type_id);
+	i->access_str_off = bswap_32(i->access_str_off);
+	i->kind = bswap_32(i->kind);
+}
+
 enum btf_field_iter_kind {
 	BTF_FIELD_ITER_IDS,
 	BTF_FIELD_ITER_STRS,
-- 
2.34.1


