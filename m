Return-Path: <linux-kselftest+bounces-32817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88276AB23D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A68A05EA8
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E855257441;
	Sat, 10 May 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Af5PcXQo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274702571DC
	for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880519; cv=none; b=C7KirY8XTtEB4zDC6/DO4CJWBzps0xY56899Rz1nnvigkRBshwehKaE0If3ghejbWtFAY+GUlGzVE0gPvaLB+vBWxxcOJBLO0dECe3Mn4XEjb85x5wR8x1Ay9E+08/1BOTPe2CJEJ8F1iCpG7JvrmvGF4f+/KpomOB+Z6Jh3P4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880519; c=relaxed/simple;
	bh=oDyB2BUsLqAJP5HgFvyGwrlv4qRfzOc4gjp/9GN5QSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDck/UXINj31/C9Ieijc4C0LV1XfbMumZbM+7sg0EnAhheMvrcSAPqOT4GUMQL6ucUSFsNVJT3LzPufd+W72RuvLFq1bG3oNmVkqcOpN8ToafRDJdt5FZSmHfwkZPIfapr07jzbmEsqGBJclgTZxBK9yll1aOzsW10GMplCF3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Af5PcXQo; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0ad74483fso34246966d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746880515; x=1747485315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rg4vIfXW8Fwu2I8MXWgJuQ7fFCwLHFdlnoSee3cSxL0=;
        b=Af5PcXQoAi5o8YfZ1BlEE8E5wUqYa1+IgEYCfj6/jGOPG7UaKT81o396IFix5tN8/Q
         MojELO5IFj2ylxaon4M9R4wkFFcqKbV9+wlLMjvBzAGSBSpFhDj2CH77p+2h6L5Q0oLn
         8e6hEK0r0SHbHYhN+Llfv+MB23M9E5yK6NKxDNhzfwWoGocdaTCaei0qAsSiDcWoexoD
         Mu/ZfltXsdzcKJI5usa3uQ7JXY8KUye3DALpWxBYDDbfdTTGEofniLpWgvcUxEmFL1Y4
         pGBYJT7qycrSUwd/wFA4p44Q594S4S+5y1jUm57yR/aRv2uqiu53R32LrcokozHNd84b
         DswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746880515; x=1747485315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg4vIfXW8Fwu2I8MXWgJuQ7fFCwLHFdlnoSee3cSxL0=;
        b=kNLEXt2ay5iG7GTxEHlAm3tJBhVoEs8FP/u97lnk5/BLAm07HzJzcYk7luCxm+JP33
         buouPwyaFfNJdsmwJre7xdPmYt8XmF7cAGlInHEfYTamejKP57tpydYIhULxiMhZ3OZ9
         Uu0li25/0vHkU5yTsH+BoQdgx5/kTm7ZCg2lEbCumXxSHo0e1PqG3xLJxOLYnjlM6Rc8
         Nq26cNBgPtEan68VYtkBOYdgdNrXF3Yl0QpSP/XXFLqJOoockI/rGxs2yrbGh6L1TqKA
         UKzd4rB8vZO6Cvo8ELC31P6UWgZoHN8XwLtHV93HOqrlpqPDg4zQVT9fewC5Drvm0YuO
         0rjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFrzuDEGeySc+qlJEQYXG+xM322md9I+JryJgzHltUXlhbuEW1ULzCY5k1CSGAhnwtiuG5vGgLh7drQg0Schg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9rzgaoKo9Xqq48pr/X/AfwCQkRewtd4BJofQlDk/2BHwFG1m
	vwIK4+KQYIW9oG5VPZ+iuDZWAXLmJH3VQvZbHr67I/u3U0fUrUL4jH0BH9ZEW/Y=
X-Gm-Gg: ASbGnctxVPisCuHgPb9sBpqU/AsYbui0oYY6hKIv6TqOO+/OzbuaNhDaNDI4N6iPQp8
	ILKY7uTNDYYUi9RCdCT4SAWjvsHuvdWeuJRpopRlBijF5nvqIy1bWkV7Yrlu64xLNNCYJZ49krX
	v/rwADSKtSr+ggVh9J4sXzkKSMBiq96QteIdX+JXtqwXZC8UneqjoPkKAiTZq3SMPVWGdYSyeS0
	qz6tSn8ZUvAVqK/wZcWCTSDW15g/0xlnIArA5kJxjEhGyllhnq9Awg4U8ZQ3zX3O+d37heUwiNN
	ZtLgKVTj9H/n4PJBnRPfT5HZv8+Alj/SBdjqISe5peSw3NeRFTZzygDLcuuICMbcUm8LGbycQSg
	x63uAdKw=
X-Google-Smtp-Source: AGHT+IFiIjqbpUXKtb2X4q6JeET5+pL2HSZy76d54EdCIui+IrxqY7tmfZwMFCmtX6SCx2GZhb09KQ==
X-Received: by 2002:a05:6214:e49:b0:6e8:9866:7398 with SMTP id 6a1803df08f44-6f6e47ec7b6mr97257006d6.22.1746880514884;
        Sat, 10 May 2025 05:35:14 -0700 (PDT)
Received: from [192.168.1.45] (ool-182edad1.dyn.optonline.net. [24.46.218.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f588asm25725556d6.49.2025.05.10.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 05:35:14 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Sat, 10 May 2025 08:34:56 -0400
Subject: [PATCH bpf-next v4 3/3] libbpf: Use mmap to parse vmlinux BTF from
 sysfs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-vmlinux-mmap-v4-3-69e424b2a672@isovalent.com>
References: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
In-Reply-To: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

Teach libbpf to use mmap when parsing vmlinux BTF from /sys. We don't
apply this to fall-back paths on the regular file system because there
is no way to ensure that modifications underlying the MAP_PRIVATE
mapping are not visible to the process.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/lib/bpf/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f18d7e6a453cd9e5c384487659df04f7efafdf5a..42815a29c0a52a1a7eed2c6b22b9b1754ae01c9a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -12,6 +12,7 @@
 #include <sys/utsname.h>
 #include <sys/param.h>
 #include <sys/stat.h>
+#include <sys/mman.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/btf.h>
@@ -120,6 +121,9 @@ struct btf {
 	/* whether base_btf should be freed in btf_free for this instance */
 	bool owns_base;
 
+	/* whether raw_data is a (read-only) mmap */
+	bool raw_data_is_mmap;
+
 	/* BTF object FD, if loaded into kernel */
 	int fd;
 
@@ -951,6 +955,17 @@ static bool btf_is_modifiable(const struct btf *btf)
 	return (void *)btf->hdr != btf->raw_data;
 }
 
+static void btf_free_raw_data(struct btf *btf)
+{
+	if (btf->raw_data_is_mmap) {
+		munmap(btf->raw_data, btf->raw_size);
+		btf->raw_data_is_mmap = false;
+	} else {
+		free(btf->raw_data);
+	}
+	btf->raw_data = NULL;
+}
+
 void btf__free(struct btf *btf)
 {
 	if (IS_ERR_OR_NULL(btf))
@@ -970,7 +985,7 @@ void btf__free(struct btf *btf)
 		free(btf->types_data);
 		strset__free(btf->strs_set);
 	}
-	free(btf->raw_data);
+	btf_free_raw_data(btf);
 	free(btf->raw_data_swapped);
 	free(btf->type_offs);
 	if (btf->owns_base)
@@ -1030,7 +1045,7 @@ struct btf *btf__new_empty_split(struct btf *base_btf)
 	return libbpf_ptr(btf_new_empty(base_btf));
 }
 
-static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
+static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, bool is_mmap)
 {
 	struct btf *btf;
 	int err;
@@ -1050,12 +1065,18 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 		btf->start_str_off = base_btf->hdr->str_len;
 	}
 
-	btf->raw_data = malloc(size);
-	if (!btf->raw_data) {
-		err = -ENOMEM;
-		goto done;
+	if (is_mmap) {
+		btf->raw_data = (void *)data;
+		btf->raw_data_is_mmap = true;
+	} else {
+		btf->raw_data = malloc(size);
+		if (!btf->raw_data) {
+			err = -ENOMEM;
+			goto done;
+		}
+		memcpy(btf->raw_data, data, size);
 	}
-	memcpy(btf->raw_data, data, size);
+
 	btf->raw_size = size;
 
 	btf->hdr = btf->raw_data;
@@ -1083,12 +1104,12 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 
 struct btf *btf__new(const void *data, __u32 size)
 {
-	return libbpf_ptr(btf_new(data, size, NULL));
+	return libbpf_ptr(btf_new(data, size, NULL, false));
 }
 
 struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
 {
-	return libbpf_ptr(btf_new(data, size, base_btf));
+	return libbpf_ptr(btf_new(data, size, base_btf, false));
 }
 
 struct btf_elf_secs {
@@ -1209,7 +1230,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 	if (secs.btf_base_data) {
 		dist_base_btf = btf_new(secs.btf_base_data->d_buf, secs.btf_base_data->d_size,
-					NULL);
+					NULL, false);
 		if (IS_ERR(dist_base_btf)) {
 			err = PTR_ERR(dist_base_btf);
 			dist_base_btf = NULL;
@@ -1218,7 +1239,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	}
 
 	btf = btf_new(secs.btf_data->d_buf, secs.btf_data->d_size,
-		      dist_base_btf ?: base_btf);
+		      dist_base_btf ?: base_btf, false);
 	if (IS_ERR(btf)) {
 		err = PTR_ERR(btf);
 		goto done;
@@ -1335,7 +1356,7 @@ static struct btf *btf_parse_raw(const char *path, struct btf *base_btf)
 	}
 
 	/* finally parse BTF data */
-	btf = btf_new(data, sz, base_btf);
+	btf = btf_new(data, sz, base_btf, false);
 
 err_out:
 	free(data);
@@ -1354,6 +1375,36 @@ struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf)
 	return libbpf_ptr(btf_parse_raw(path, base_btf));
 }
 
+static struct btf *btf_parse_raw_mmap(const char *path, struct btf *base_btf)
+{
+	struct stat st;
+	void *data;
+	struct btf *btf;
+	int fd, err;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return libbpf_err_ptr(-errno);
+
+	if (fstat(fd, &st) < 0) {
+		err = -errno;
+		close(fd);
+		return libbpf_err_ptr(err);
+	}
+
+	data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	if (data == MAP_FAILED)
+		return NULL;
+
+	btf = btf_new(data, st.st_size, base_btf, true);
+	if (IS_ERR(btf))
+		munmap(data, st.st_size);
+
+	return btf;
+}
+
 static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_ext **btf_ext)
 {
 	struct btf *btf;
@@ -1618,7 +1669,7 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 		goto exit_free;
 	}
 
-	btf = btf_new(ptr, btf_info.btf_size, base_btf);
+	btf = btf_new(ptr, btf_info.btf_size, base_btf, false);
 
 exit_free:
 	free(ptr);
@@ -1659,8 +1710,7 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
 static void btf_invalidate_raw_data(struct btf *btf)
 {
 	if (btf->raw_data) {
-		free(btf->raw_data);
-		btf->raw_data = NULL;
+		btf_free_raw_data(btf);
 	}
 	if (btf->raw_data_swapped) {
 		free(btf->raw_data_swapped);
@@ -5331,7 +5381,10 @@ struct btf *btf__load_vmlinux_btf(void)
 		pr_warn("kernel BTF is missing at '%s', was CONFIG_DEBUG_INFO_BTF enabled?\n",
 			sysfs_btf_path);
 	} else {
-		btf = btf__parse(sysfs_btf_path, NULL);
+		btf = btf_parse_raw_mmap(sysfs_btf_path, NULL);
+		if (IS_ERR_OR_NULL(btf))
+			btf = btf__parse(sysfs_btf_path, NULL);
+
 		if (!btf) {
 			err = -errno;
 			pr_warn("failed to read kernel BTF from '%s': %s\n",

-- 
2.49.0


