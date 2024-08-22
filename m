Return-Path: <linux-kselftest+bounces-16032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343695B192
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CF11F217EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42617C7DF;
	Thu, 22 Aug 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXufyS9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00217BB2A;
	Thu, 22 Aug 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318701; cv=none; b=lv8v6CUAi9Znr/mqyascrXfNFCDCc0o/W7qLfeEc7uzlP4jvJ+q/9J3/8x4QmKrMiOmyr0jmFEVejsbeuuahpymJfKkp3fyP+H+i38oPMr5EUFB4VZYh6lWq/4IqNS0+hJOMYUwHPULkaWxrjweJJ4P0gR5Plm06M9scdXtx9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318701; c=relaxed/simple;
	bh=26TlPTEbZ905jwsgRIUv0ZCFSfQYUKHgv8/ohfDKF/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3XuOtUJLeLn4l+W0wbbPBzBtKCnOnwNsPz9yzT5yZFyETjgBEZ1LvB4SeqlA/TGtyi6OrKc8H7qfwrfp/rwVvRwm4kdF08cK+I+Io0qLqjyUnuZUKqtWChSA2XHqI0gOjHh/ottJsSnisoNl4aVA0K7ugXAA/WZQH21dyeFg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXufyS9D; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d37e5b7b02so412653a91.1;
        Thu, 22 Aug 2024 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318699; x=1724923499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzODO6nzCICIUMlgGVk4+Q48fOL7xNsv4iWIgFEFZJQ=;
        b=bXufyS9DekrUO2DuEua+D//mmgi16MeWAOqrxOuiZ/KweFNo7yeEj7Ag8yAqthhgFS
         rPoQqBLLxo1O8V/eNvL4jG1q0AuOS4HxkK9wTEx+rV5j+fAGKpiFuQDb3cU3AA6wfASQ
         ZI9/rk4Tnw85+bIrWq9y20Q9pE2aZbUzhKBa8/LVvny8RWytiP/RygmdAMZpYNpLFUBq
         9qfU3BMSZE0tacsRrnvIp86O2fPe2QO+vLQmfqNlcqiSOWcVI43VDs6uK4G8GLbDq2ka
         PmR2x+BA29l5HJopD42tl+rGQDhhgqsS8gtFHeftIiiedgGNtB7b1hDNSe8oUXWuVHDk
         Ml1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318699; x=1724923499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzODO6nzCICIUMlgGVk4+Q48fOL7xNsv4iWIgFEFZJQ=;
        b=T/qiTieFwQJhlliWxCW9luo18roC6sAGXmh9nhChmGt91frlbG4rO4EioSIbCJUysf
         7JRT+OWq2XbVgbuHTnzq3YQNpwe4TIQEdruh26PWEicClSc88ubL6f61WK2/+UeSZMsP
         XUFB0p1ce4jLq7tLKD9MkmMCwxkOssxLxVQnVSGXeOxPwDZdcHiYEbMp4zRh4Rh6s/gR
         pH503+fZIY0LqW+AKaIB20xsXNzzUgmSqYlH5kiJoYI7+s6Ml1e7sQNRwylDSPP+cZwN
         JgMaTZHZZ/3tnqL9IOPtGXrwOeTtEEcTNmdDP1JCTRt6NSkDfcsNNqYsvSZ0TMQKTERL
         /zFw==
X-Forwarded-Encrypted: i=1; AJvYcCUEa8pN0sZm/7+U3qYBgdutnJac8hhLZnALr3I/eRYecwHmiCSQajTQ1XxdlItB/g/jQPwEbMYQchSV/CchPPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GAq/Cu7udfkekoXYmu2cuvP6zu8r865A9RDjiON+TOov3UeJ
	AZBlh/nN0798BgWXp66TuENlyEDZeQKBxjWiwlmGSRH1JDa9V8+UuFYlnOqg
X-Google-Smtp-Source: AGHT+IGJDau4qkVoFMHfwEDtn11l++mOLQnCQaK/s1uuqFS684Xa10HpWSz3VYY2R5otiQhAtiU81w==
X-Received: by 2002:a17:90a:8cb:b0:2c9:6514:39ff with SMTP id 98e67ed59e1d1-2d5e9dbbb7cmr5467079a91.33.1724318699240;
        Thu, 22 Aug 2024 02:24:59 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:24:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/8] libbpf: Support BTF.ext loading and output in either endianness
Date: Thu, 22 Aug 2024 02:24:27 -0700
Message-Id: <bf9275e2af357f287bc4d37dd9b43a1f8be33ef7.1724313164.git.tony.ambardar@gmail.com>
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
 tools/lib/bpf/btf.h             |   3 +
 tools/lib/bpf/libbpf.map        |   2 +
 tools/lib/bpf/libbpf_internal.h |   2 +
 4 files changed, 161 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index cf4f7bd7ff5c..cb4ee4ed4b5c 100644
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
@@ -3023,24 +3069,56 @@ static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
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
@@ -3067,6 +3145,7 @@ void btf_ext__free(struct btf_ext *btf_ext)
 	free(btf_ext->line_info.sec_idxs);
 	free(btf_ext->core_relo_info.sec_idxs);
 	free(btf_ext->data);
+	free(btf_ext->data_swapped);
 	free(btf_ext);
 }
 
@@ -3087,7 +3166,12 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
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
 
@@ -3120,15 +3204,76 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	return btf_ext;
 }
 
+static void *btf_ext_raw_data(const struct btf_ext *btf_ext_ro, __u32 *size,
+			      bool swap_endian)
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
+	return (is_host_big_endian() != btf_ext->swapped_endian) ?
+		BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
+}
+
+int btf_ext__set_endianness(struct btf_ext *btf_ext, enum btf_endianness endian)
+{
+	bool is_tgt_big_endian = (endian == BTF_BIG_ENDIAN);
+
+	if (endian != BTF_LITTLE_ENDIAN && endian != BTF_BIG_ENDIAN)
+		return libbpf_err(-EINVAL);
+
+	btf_ext->swapped_endian = (is_host_big_endian() != is_tgt_big_endian);
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


