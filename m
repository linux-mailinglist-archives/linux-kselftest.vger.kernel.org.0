Return-Path: <linux-kselftest+bounces-18031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C8979CE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565941C22298
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164613DDDF;
	Mon, 16 Sep 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grb7yqql"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAF20B22;
	Mon, 16 Sep 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475911; cv=none; b=lOrswyW/6PlS/CyOqBXgexqfLjBGU9m9mFRKEAAksOZCxjDk5sA4TR+5i/gkey7sIR5oh/JA/ch5XYs5TXrXSyi1P84jgZCZmTIC/SMECH5rUqXpCd29f4ihA7Pw6LCBm5uGmIqhWPJo/Nmtrd4t8Qdb+adJ1mck6zJRiMxp1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475911; c=relaxed/simple;
	bh=Xx7wqKMJhudDqzjHFa5hc6JqBpwiNXDJ7fwoNdUHCys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW2q38L6dW8YTTeMJbZPmLj1keUhRNmCRYIfWC0IIhxo0qjq9L794Yah23ymt3abL9srMOOyN2dDGbDHqZv9gI3dFfF70p0jopgMd2/ErrjlhocrNw3U9gvADjdLw6CYSJ82bJ80M6CuXK9t00cPpHMTTDpHyRbmPlcqlEXbcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grb7yqql; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so2032377a91.0;
        Mon, 16 Sep 2024 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475908; x=1727080708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOnKIJQvY2AyFQar8PW+oCQ3/WUYijzgeo8O608zq8Y=;
        b=grb7yqqlA8xLOzd0B/QVFBTbhLQDVeiBq2mQQNxkHTUGCBOw8lK86TEkxftTzZoF1q
         BmKWmekVBryootYjJuAp5RMWIFcjrT5YNfiJ/Q+592CvaVYh+7PEgBobBOKaPAGOlh17
         f5BgcNX3jn+fyDO+qmcTbwhUDlBVgZNpQlo7Iy9COvnLI6dw2zJRHo24tD1cfYfe4XR0
         E/ed2LSu8B4JHx5smoAfdkwo5QfmCyCJjX11FZUmSkcCT7ZYhEz979SeMc4747c18gA5
         UqMf2JPhzE2G6R9w5JEVah90mHjhwC7JqUXHfISjTXtk3NNiUSC+yn4ReATZ7VPu7Fxq
         Ep3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475908; x=1727080708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOnKIJQvY2AyFQar8PW+oCQ3/WUYijzgeo8O608zq8Y=;
        b=igWVCBrprcKAj56kWOk+yJT0IJK4k2wxDQc0aJ1YVpQYLTpROxtdK7hF38JHFrq7Wq
         NSze+wldaSbloxJqXcAI/ys5rAfJt52J0yZvRinDndqus6DUWc8+qnADT9+RRJReHVC9
         //RpZX8lUuvsV8f4uCQ/XsLHv+jO7C0ZG4pa8g3R8HgUGB1TYXqrqVRGMGZudxeC+RRH
         qhRhEuxC7Kt2OOsj9JtVG877ix11epILzZuAAxv6OeBlqUa2Jwls/S2Y7o6ZWuFh2DMT
         nYhZnf2vUIBA+Sp7mRbZdUu0qEO9Vk7rY+T/nYj9IrRnYVcOlQr5v23M5MNXJG8tEVur
         NDtg==
X-Forwarded-Encrypted: i=1; AJvYcCWsIIWEJrhPfkgixE7v01BtqyemFwYS8FAOmbDxgAsyUaFKdRHp8Xa6/7K9NJ4Jxsv/n9CqoaNMPwKQj/caP8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDpEDVpyARSKsKTBLwUbgjkeVTP7JLabtnmGXcOQ3O1akUpF9
	3xCM1PetGif3NHA8xl3byCnU70pGyUAxArLhppFakpo0ro5bdWu53sWfEg==
X-Google-Smtp-Source: AGHT+IEansLmVKmiOeUHnpTovP56KgoNxFkAc7lX0YDZlLLGFPIPW3OVxf8/jGzTRxlJDTTcOv4xNw==
X-Received: by 2002:a17:90b:886:b0:2cf:eaec:d74c with SMTP id 98e67ed59e1d1-2dbb9df6432mr12266939a91.16.1726475907910;
        Mon, 16 Sep 2024 01:38:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:38:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 4/8] libbpf: Support BTF.ext loading and output in either endianness
Date: Mon, 16 Sep 2024 01:37:43 -0700
Message-Id: <133407ab20e0dd5c07cab2a6fa7879dee1ffa4bc.1726475448.git.tony.ambardar@gmail.com>
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
 tools/lib/bpf/btf.c             | 280 +++++++++++++++++++++++++-------
 tools/lib/bpf/btf.h             |   3 +
 tools/lib/bpf/libbpf.map        |   2 +
 tools/lib/bpf/libbpf_internal.h |  30 ++++
 4 files changed, 258 insertions(+), 57 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e1d4cbd83729..c04f37b87f25 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2885,22 +2885,29 @@ int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 	return btf_commit_type(btf, sz);
 }
 
-struct btf_ext_sec_setup_param {
+struct btf_ext_sec_info_param {
 	__u32 off;
 	__u32 len;
 	__u32 min_rec_size;
+	__u32 rec_size;
 	struct btf_ext_info *ext_info;
 	const char *desc;
 };
 
-static int btf_ext_setup_info(struct btf_ext *btf_ext,
-			      struct btf_ext_sec_setup_param *ext_sec)
+/*
+ * Parse a single info subsection of the BTF.ext info data:
+ *  - validate subsection structure and elements
+ *  - save info subsection start and sizing details in struct btf_ext
+ *  - endian-independent operation, for calling before byte-swapping
+ */
+static int btf_ext_parse_sec_info(struct btf_ext *btf_ext,
+				  struct btf_ext_sec_info_param *ext_sec,
+				  bool is_native)
 {
 	const struct btf_ext_info_sec *sinfo;
 	struct btf_ext_info *ext_info;
 	__u32 info_left, record_size;
 	size_t sec_cnt = 0;
-	/* The start of the info sec (including the __u32 record_size). */
 	void *info;
 
 	if (ext_sec->len == 0)
@@ -2912,6 +2919,7 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 		return -EINVAL;
 	}
 
+	/* The start of the info sec (including the __u32 record_size). */
 	info = btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
 	info_left = ext_sec->len;
 
@@ -2927,9 +2935,13 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 		return -EINVAL;
 	}
 
-	/* The record size needs to meet the minimum standard */
-	record_size = *(__u32 *)info;
+	/* The record size needs to meet either the minimum standard or, when
+	 * handling non-native endianness data, the exact standard so as
+	 * to allow safe byte-swapping.
+	 */
+	record_size = is_native ? *(__u32 *)info : bswap_32(*(__u32 *)info);
 	if (record_size < ext_sec->min_rec_size ||
+	    (!is_native && record_size != ext_sec->rec_size) ||
 	    record_size & 0x03) {
 		pr_debug("%s section in .BTF.ext has invalid record size %u\n",
 			 ext_sec->desc, record_size);
@@ -2956,7 +2968,7 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 			return -EINVAL;
 		}
 
-		num_records = sinfo->num_info;
+		num_records = is_native ? sinfo->num_info : bswap_32(sinfo->num_info);
 		if (num_records == 0) {
 			pr_debug("%s section has incorrect num_records in .BTF.ext\n",
 			     ext_sec->desc);
@@ -2984,64 +2996,160 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 	return 0;
 }
 
-static int btf_ext_setup_func_info(struct btf_ext *btf_ext)
+/* Parse all info secs in the BTF.ext info data */
+static int btf_ext_parse_info(struct btf_ext *btf_ext, bool is_native)
 {
-	struct btf_ext_sec_setup_param param = {
+	struct btf_ext_sec_info_param func_info = {
 		.off = btf_ext->hdr->func_info_off,
 		.len = btf_ext->hdr->func_info_len,
 		.min_rec_size = sizeof(struct bpf_func_info_min),
+		.rec_size = sizeof(struct bpf_func_info),
 		.ext_info = &btf_ext->func_info,
 		.desc = "func_info"
 	};
-
-	return btf_ext_setup_info(btf_ext, &param);
-}
-
-static int btf_ext_setup_line_info(struct btf_ext *btf_ext)
-{
-	struct btf_ext_sec_setup_param param = {
+	struct btf_ext_sec_info_param line_info = {
 		.off = btf_ext->hdr->line_info_off,
 		.len = btf_ext->hdr->line_info_len,
 		.min_rec_size = sizeof(struct bpf_line_info_min),
+		.rec_size = sizeof(struct bpf_line_info),
 		.ext_info = &btf_ext->line_info,
 		.desc = "line_info",
 	};
-
-	return btf_ext_setup_info(btf_ext, &param);
-}
-
-static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
-{
-	struct btf_ext_sec_setup_param param = {
+	struct btf_ext_sec_info_param core_relo = {
 		.off = btf_ext->hdr->core_relo_off,
 		.len = btf_ext->hdr->core_relo_len,
 		.min_rec_size = sizeof(struct bpf_core_relo),
+		.rec_size = sizeof(struct bpf_core_relo),
 		.ext_info = &btf_ext->core_relo_info,
 		.desc = "core_relo",
 	};
+	int err;
+
+	err = btf_ext_parse_sec_info(btf_ext, &func_info, is_native);
+	if (err)
+		return err;
+
+	err = btf_ext_parse_sec_info(btf_ext, &line_info, is_native);
+	if (err)
+		return err;
+
+	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
+		return 0; /* skip core relos parsing */
 
-	return btf_ext_setup_info(btf_ext, &param);
+	err = btf_ext_parse_sec_info(btf_ext, &core_relo, is_native);
+	if (err)
+		return err;
+
+	return 0;
 }
 
-static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
+/* Swap byte-order of BTF.ext header with any endianness */
+static void btf_ext_bswap_hdr(struct btf_ext_header *h)
 {
-	const struct btf_ext_header *hdr = (struct btf_ext_header *)data;
+	bool is_native = h->magic == BTF_MAGIC;
+	__u32 hdr_len;
 
-	if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
-	    data_size < hdr->hdr_len) {
-		pr_debug("BTF.ext header not found\n");
+	hdr_len = is_native ? h->hdr_len : bswap_32(h->hdr_len);
+
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
+/* Swap byte-order of generic info subsection */
+static void btf_ext_bswap_info_sec(void *info, __u32 len, bool is_native,
+				   info_rec_bswap_fn bswap_fn)
+{
+	struct btf_ext_info_sec *sec;
+	__u32 info_left, rec_size, *rs;
+
+	if (len == 0)
+		return;
+
+	rs = info;				/* info record size */
+	rec_size = is_native ? *rs : bswap_32(*rs);
+	*rs = bswap_32(*rs);
+
+	sec = info + sizeof(__u32);		/* info sec #1 */
+	info_left = len - sizeof(__u32);
+	while (info_left) {
+		unsigned int sec_hdrlen = sizeof(struct btf_ext_info_sec);
+		__u32 i, num_recs;
+		void *p;
+
+		num_recs = is_native ? sec->num_info : bswap_32(sec->num_info);
+		sec->sec_name_off = bswap_32(sec->sec_name_off);
+		sec->num_info = bswap_32(sec->num_info);
+		p = sec->data;			/* info rec #1 */
+		for (i = 0; i < num_recs; i++, p += rec_size)
+			bswap_fn(p);
+		sec = p;
+		info_left -= sec_hdrlen + (__u64)rec_size * num_recs;
+	}
+}
+
+/*
+ * Swap byte-order of all info data in a BTF.ext section
+ *  - requires BTF.ext hdr in native endianness
+ */
+static void btf_ext_bswap_info(struct btf_ext *btf_ext, void *data)
+{
+	const bool is_native = btf_ext->swapped_endian;
+	const struct btf_ext_header *h = data;
+	void *info;
+
+	/* Swap func_info subsection byte-order */
+	info = data + h->hdr_len + h->func_info_off;
+	btf_ext_bswap_info_sec(info, h->func_info_len, is_native,
+			       (info_rec_bswap_fn)bpf_func_info_bswap);
+
+	/* Swap line_info subsection byte-order */
+	info = data + h->hdr_len + h->line_info_off;
+	btf_ext_bswap_info_sec(info, h->line_info_len, is_native,
+			       (info_rec_bswap_fn)bpf_line_info_bswap);
+
+	/* Swap core_relo subsection byte-order (if present) */
+	if (h->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
+		return;
+
+	info = data + h->hdr_len + h->core_relo_off;
+	btf_ext_bswap_info_sec(info, h->core_relo_len, is_native,
+			       (info_rec_bswap_fn)bpf_core_relo_bswap);
+}
+
+/* Parse hdr data and info sections: check and convert to native endianness */
+static int btf_ext_parse(struct btf_ext *btf_ext)
+{
+	__u32 hdr_len, data_size = btf_ext->data_size;
+	struct btf_ext_header *hdr = btf_ext->hdr;
+	bool swapped_endian = false;
+	int err;
+
+	if (data_size < offsetofend(struct btf_ext_header, hdr_len)) {
+		pr_debug("BTF.ext header too short\n");
 		return -EINVAL;
 	}
 
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
@@ -3051,11 +3159,39 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
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
+		btf_ext_bswap_hdr(btf_ext->hdr);
+
+	/* Validate info subsections and cache key metadata */
+	err = btf_ext_parse_info(btf_ext, !swapped_endian);
+	if (err)
+		return err;
+
+	/* Keep infos native byte-order in memory for introspection */
+	if (swapped_endian)
+		btf_ext_bswap_info(btf_ext, btf_ext->data);
+
+	/*
+	 * Set btf_ext->swapped_endian only after all header and info data has
+	 * been swapped, helping bswap functions determine if their data are
+	 * in native byte-order when called.
+	 */
+	btf_ext->swapped_endian = swapped_endian;
 	return 0;
 }
 
@@ -3067,6 +3203,7 @@ void btf_ext__free(struct btf_ext *btf_ext)
 	free(btf_ext->line_info.sec_idxs);
 	free(btf_ext->core_relo_info.sec_idxs);
 	free(btf_ext->data);
+	free(btf_ext->data_swapped);
 	free(btf_ext);
 }
 
@@ -3087,29 +3224,7 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	}
 	memcpy(btf_ext->data, data, size);
 
-	err = btf_ext_parse_hdr(btf_ext->data, size);
-	if (err)
-		goto done;
-
-	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	err = btf_ext_setup_func_info(btf_ext);
-	if (err)
-		goto done;
-
-	err = btf_ext_setup_line_info(btf_ext);
-	if (err)
-		goto done;
-
-	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
-		goto done; /* skip core relos parsing */
-
-	err = btf_ext_setup_core_relos(btf_ext);
-	if (err)
-		goto done;
+	err = btf_ext_parse(btf_ext);
 
 done:
 	if (err) {
@@ -3120,15 +3235,66 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	return btf_ext;
 }
 
+static void *btf_ext_raw_data(const struct btf_ext *btf_ext_ro, bool swap_endian)
+{
+	struct btf_ext *btf_ext = (struct btf_ext *)btf_ext_ro;
+	const __u32 data_sz = btf_ext->data_size;
+	void *data;
+
+	/* Return native data (always present) or swapped data if present */
+	if (!swap_endian)
+		return btf_ext->data;
+	else if (btf_ext->data_swapped)
+		return btf_ext->data_swapped;
+
+	/* Recreate missing swapped data, then cache and return */
+	data = calloc(1, data_sz);
+	if (!data)
+		return NULL;
+	memcpy(data, btf_ext->data, data_sz);
+
+	btf_ext_bswap_info(btf_ext, data);
+	btf_ext_bswap_hdr(data);
+	btf_ext->data_swapped = data;
+	return data;
+}
+
 const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size)
 {
+	void *data;
+
+	data = btf_ext_raw_data(btf_ext, btf_ext->swapped_endian);
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
index 4e349ad79ee6..47ee8f6ac489 100644
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
index 0096e483f7eb..f40ccc2946e7 100644
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
 		bpf_object__token_fd;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 8cda511a1982..1307753b49b3 100644
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
@@ -511,6 +513,34 @@ struct bpf_line_info_min {
 	__u32	line_col;
 };
 
+/* Functions to byte-swap info records */
+
+typedef void (*info_rec_bswap_fn)(void *);
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


