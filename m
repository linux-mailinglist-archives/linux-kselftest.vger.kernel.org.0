Return-Path: <linux-kselftest+bounces-15838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B7959877
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC71C209E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E601E3032;
	Wed, 21 Aug 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaxxXyu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75D1E3004;
	Wed, 21 Aug 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231410; cv=none; b=fAgwJXRskv4lXbZr3u8Qvw1mOp1gVGmyglpevvUzuXeciGErXog7bd9XFEb/7bdlx4e78fDI6ZFWKEcO/HIWE03jNmTvi/c6g5xd0H5btE8/YojOTLC1s4eu+5YVfF1Y5sZbs3QWXtU0SZ9ObZDnyBZFxhnXVx7Fa6+j6pWMXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231410; c=relaxed/simple;
	bh=RcnnaHrY4fMAGL5jIkPD59CIepAORsN9Q6/v1K9Vv7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJ9y/cUEdVSwGKFG3yawnpERLsrGpoUEAmqlGW//nweExQe8+ziNFEdZBbIlAZWMwmGDNQSadMlmqAuhdjM0NJ9ZTjD/j55T8nmufSjm4Tj+wHeNdkuvp3M7TrAyrSRq5A8F812GemmN4IEstaHktpGrXnU5kscS27AD02bvhRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaxxXyu0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2021c03c13aso4569365ad.1;
        Wed, 21 Aug 2024 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231408; x=1724836208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aLmYF0iKxzGNvG6bLQuspXuhD1KszRtAYR8l9iASOs=;
        b=XaxxXyu0BKEPdxLvsKmrivzG/fS/vsfcgCeBKJW1juVI0fdH/VQYLz2IXc6+N7BXed
         i48lGHSlKMvFA184/EgC9l1w7ryRqrK7xoZyRrb89HEmzYa13wrJ8c8N3OX1lBiq0itt
         +aaXWYDmKiuURWnwobAgCCUqg9VKfx6GSIJLiVaVEhTBpw09VUnk/vEfsYMQ+R1ZqOHq
         nTlpWvDPEP5xwqNozywTrRpNiKgXO4vBH1AaHzS636XFbF+/bxDcG6a8l8xi9Nwf9wF+
         G3NpthGMH8yOCjFLgjIPn+z2+tbZkhXPnT7pTn/WVQBlcSRUKzGhxNMKM8oACeP3Aizp
         iDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231408; x=1724836208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aLmYF0iKxzGNvG6bLQuspXuhD1KszRtAYR8l9iASOs=;
        b=dugWfFMfumsej/moif18v6ZQWCjpSRp3NxVATT/ASBgRN9VLK/nj8Du7flr9UHMh1R
         eOEBbGKbK4JnaRathqATk3xLGvb3ogU7dxEQPwjOKOu8Rp6Tx0yahg93e7Et9UPHVCLL
         QU4PP4FJZ2YyvL5QpwPBBfWsJcJ5CoQ1G/FX0J26ZOHKt3jM/YmWHeaPaOCpBlshg0iz
         KGV8+9FZJUu6TwGUC3tkwCRtDLRdtb4sudBS4GTYmIBChfCkXvd7x3V3mPT88yFoDiMI
         gQBt4FPyazveVXowJ+Pl+xx2OsxZcy9bcvLfTVo12SDnmVY0XCYIUzKMbwGOxacKkH+P
         fXjg==
X-Forwarded-Encrypted: i=1; AJvYcCUtoON9pxqDJRxwioJepdkWbOTh5/hhmlkVhy3up30jZqddUxcT/0UgcBG3RQ7EUXySUfDDybXNOH5BCu+PGMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6Mbe3y2PD0lsjuuLprIvQV2WmiHR++lcryeX76lNuBQ2pEYz
	YJtLZTpETieqg5WSXIUfOioF1KKj87+qp10+GRzMh7XdqGIp/QZUpcTAoN7J
X-Google-Smtp-Source: AGHT+IHCJRaXAqYze4M3E0mQXD9sAFPRkO8IcXq5oUF4ClyasKZpi8wx81Cxk4aFLvUJQsiLBHDfxA==
X-Received: by 2002:a17:902:b402:b0:202:21:eb2a with SMTP id d9443c01a7336-20367d0cf67mr24246015ad.19.1724231407795;
        Wed, 21 Aug 2024 02:10:07 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:10:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 4/8] libbpf: Support BTF.ext loading and output in either endianness
Date: Wed, 21 Aug 2024 02:09:22 -0700
Message-Id: <72ac2339af4046bcc6a78a798de6491f9f1d41d6.1724216108.git.tony.ambardar@gmail.com>
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

Support for handling BTF data of either endianness was added in [1], but
did not include BTF.ext data for lack of use cases. Later, support for
static linking [2] provided a use case, but this feature and later ones
were restricted to native-endian usage.

Add support for BTF.ext handling in either endianness. Convert BTF.ext data
to native endianness when read into memory for further processing, and
support raw data access that restores the original byte-order for output.

Add new API functions btf_ext__endianness() and btf_ext__set_endianness()
for query and setting byte-order, as already exist for BTF data.

[1]:commit 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
[2]:commit 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c             | 163 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h             |   2 +
 tools/lib/bpf/libbpf.map        |   2 +
 tools/lib/bpf/libbpf_internal.h |   2 +
 4 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f5081de86ee0..fba6988a7820 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2884,6 +2884,52 @@ int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 	return btf_commit_type(btf, sz);
 }
 
+/*
+ * Swap endianness of the info segment in a BTF.ext data section:
+ *   - requires BTF.ext header data in native byte order
+ *   - expects info record fields are 32-bit
+ */
+static int btf_ext_bswap_info(void *data, const __u32 data_size)
+{
+	const struct btf_ext_header *hdr = data;
+	__u32 info_size, sum_len, i, *p;
+
+	if (data_size < offsetofend(struct btf_ext_header, hdr_len)) {
+		pr_warn("BTF.ext initial header not found\n");
+		return -EINVAL;
+	}
+
+	if (data_size < hdr->hdr_len) {
+		pr_warn("BTF.ext header not found\n");
+		return -EINVAL;
+	}
+
+	if (hdr->hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
+		pr_warn("BTF.ext header missing func_info, line_info\n");
+		return -EINVAL;
+	}
+
+	sum_len = hdr->func_info_len + hdr->line_info_len;
+	if (hdr->hdr_len >= offsetofend(struct btf_ext_header, core_relo_len))
+		sum_len += hdr->core_relo_len;
+
+	info_size = data_size - hdr->hdr_len;
+	if (info_size != sum_len) {
+		pr_warn("BTF.ext info size mismatch with header data\n");
+		return -EINVAL;
+	}
+
+	if (info_size && info_size % sizeof(__u32)) {
+		pr_warn("BTF.ext info size not 32-bit multiple\n");
+		return -EINVAL;
+	}
+
+	p = data + hdr->hdr_len;
+	for (i = 0; i < info_size / sizeof(__u32); i++, p++)
+		*p = bswap_32(*p);
+	return 0;
+}
+
 struct btf_ext_sec_setup_param {
 	__u32 off;
 	__u32 len;
@@ -3022,24 +3068,56 @@ static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
 	return btf_ext_setup_info(btf_ext, &param);
 }
 
-static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
+/* Swap byte-order of BTF.ext header */
+static void btf_ext_bswap_hdr(struct btf_ext_header *h)
 {
-	const struct btf_ext_header *hdr = (struct btf_ext_header *)data;
+	__u32 hdr_len = h->hdr_len; /* need native byte-order */
 
-	if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
-	    data_size < hdr->hdr_len) {
-		pr_debug("BTF.ext header not found\n");
+	if (h->magic == bswap_16(BTF_MAGIC))
+		hdr_len = bswap_32(hdr_len);
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
+static int btf_ext_parse_hdr(struct btf_ext *btf_ext)
+{
+	struct btf_ext_header *hdr = btf_ext->hdr;
+	__u32 hdr_len, data_size = btf_ext->data_size;
+
+	if (data_size < offsetofend(struct btf_ext_header, hdr_len)) {
+		pr_debug("BTF.ext initial header not found\n");
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
 
+	if (data_size < hdr_len) {
+		pr_debug("BTF.ext header not found\n");
+		return -EINVAL;
+	}
+
+	/* Maintain native byte-order in memory for introspection */
+	if (btf_ext->swapped_endian)
+		btf_ext_bswap_hdr(hdr);
+
 	if (hdr->version != BTF_VERSION) {
 		pr_debug("Unsupported BTF.ext version:%u\n", hdr->version);
 		return -ENOTSUP;
@@ -3066,6 +3144,7 @@ void btf_ext__free(struct btf_ext *btf_ext)
 	free(btf_ext->line_info.sec_idxs);
 	free(btf_ext->core_relo_info.sec_idxs);
 	free(btf_ext->data);
+	free(btf_ext->data_swapped);
 	free(btf_ext);
 }
 
@@ -3086,7 +3165,12 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	}
 	memcpy(btf_ext->data, data, size);
 
-	err = btf_ext_parse_hdr(btf_ext->data, size);
+	err = btf_ext_parse_hdr(btf_ext);
+	if (err)
+		goto done;
+
+	if (btf_ext->swapped_endian)
+		err = btf_ext_bswap_info(btf_ext->data, btf_ext->data_size);
 	if (err)
 		goto done;
 
@@ -3119,15 +3203,76 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	return btf_ext;
 }
 
+static void *btf_ext_raw_data(const struct btf_ext *btf_ext_ro, __u32 *size, bool swap_endian)
+{
+	struct btf_ext *btf_ext = (struct btf_ext *)btf_ext_ro;
+	const __u32 data_sz = btf_ext->data_size;
+	void *data;
+	int err;
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
+		err = btf_ext_bswap_info(data, data_sz);
+		if (err) {
+			free(data);
+			return NULL;
+		}
+		btf_ext_bswap_hdr(data);
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
+	if (!btf_ext->swapped_endian) {
+		free(btf_ext->data_swapped);
+		btf_ext->data_swapped = NULL;
+	}
+	return 0;
+}
+
+
 
 struct btf_dedup;
 
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b68d216837a9..8c4cbaba6194 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -167,6 +167,8 @@ LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API struct btf_ext *btf_ext__new(const __u8 *data, __u32 size);
 LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
 LIBBPF_API const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size);
+LIBBPF_API enum btf_endianness btf_ext__endianness(const struct btf_ext *btf_ext);
+LIBBPF_API int btf_ext__set_endianness(struct btf_ext *btf_ext, enum btf_endianness endian);
 
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


