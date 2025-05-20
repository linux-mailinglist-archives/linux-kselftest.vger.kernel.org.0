Return-Path: <linux-kselftest+bounces-33402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4933DABD8B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35417A529F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E847222DA1D;
	Tue, 20 May 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="i6zMAy8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D822AE6B
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746107; cv=none; b=GeKvR/lZCLkWdqOILdGAnK1ijW1yS9IcPi3E16o040HR4tsFtGm9WAivU1c4OFBT/w8189ZABwzCcGU/hfRuPp07Ti5adBHH73sDcZiib08SE0UhXLHgDhrLJh5xssC/F0wS2fhUr+VtNHkjGdojxHZ31KiiPFvCtHFGx4rcU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746107; c=relaxed/simple;
	bh=/R6j9K4jScYvrR5J0W5As8DeDzzv9KIlQWuMdG/6/7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUBOVvgEkJgOy4kfJFuqUQrBYRaMpQGGIlABwIPns+xMX6X11VDlDU/iMK53OyTWTAOvrEZStUOHCTG8KGlxFrDjRc5pSuQHGgP1SRJx2riV1kgVSszMAEGBWZEX69y6FttywpW5RtnYMnDj7rfOMN0WU0Gch39UbyCFLSyHuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=i6zMAy8w; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a36abf5df9so1790462f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1747746103; x=1748350903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpMtnil2qblYoO6Q14njX8XFYnavuQfuqbvg7JG/1LQ=;
        b=i6zMAy8w0IrgpFffBc8OdW0Bx2FLTKTJFcztC0QFQ+haUzlhZVdmUwHRRZfEOGNAY2
         YOjyChNMR36jTp/j5I0jPyJusqlezQAd7XxTIBmftf7l4ZEvvc+QpT2ZIOYXYQkAHyNA
         DTA2wDqx3Dgzr6ZwzHQYJb0rFKK983ia+9io/oMdc5NSha04sQSBkgA/i5mEfG6BlZ3o
         4n+jo0qB9ok65FAL4xylBmeZHcu2ldqUcQlSi9XZnu/qQA/0aoUYmBt3MSjiRnZ6cK1M
         9wkOa99AZb7g/lngf+Kf0/jMzj3LYoPmSTu+8UV6FspSqNlwIPWxOYVtm5emUgMeHpL9
         IOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746103; x=1748350903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpMtnil2qblYoO6Q14njX8XFYnavuQfuqbvg7JG/1LQ=;
        b=tAcVC1LkXCW3xIAk8JY1KUu4tZ0U3Kakc8H2fcsbWZdEJ1dRJxVTstFcDdKkqkbqQa
         Le/kuJnIB/1yr+UTWfpsVSO0JDa1WZ2q2Stps81iWJ+k6Mynm64Sn+sKYEN/IeLxDsXP
         h6RtOXgeLiYwskvcWz+TMfKvWR9o6GBgT7unZN1FKvKJmyhAr1pG76jmhpfVGxCGocgD
         /Xu7O1oHNt8RC0qpQtq78I9tmZDx5uzLfw4AA2CcvH2fz4I4pyr2KGkruSPu1wmZiJjf
         CwHu8VExzFMjNpDEdiVUXHcXiyl8rxwrTExeynU4sU578VqHRGSI+B5mqgBtyC3Qxhrs
         M1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUy6BxrrG+pXEuTKkLxc//mSZ8kvL82ldppvP+q8NClxn/7qkX7D7dhOrLUnPqyAFMgEETB5c++prxfHmUrYWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/tWslHSt6EpyHrf1TOHNYKJKNGA1W3JJYcxpnFs2LBcUMyugC
	3mYNYcck8YNEW76Wg5K5I78ayUOdgWBRU/bZBvnDuASKVcIhiN/e+NbjUmuphyxvvLo=
X-Gm-Gg: ASbGncsTc3ywDafU+8aIqYSZdk8nJahpTbSwwx6QA9R/31soYYTE3yY1lCU7XETl7+g
	ckne3q0IYsugSyfzb4b/4kxNKy1vvqawyyIsxNWAnxzCIrfFWCVT58PWWPMBuYOSVfjeMJv8bur
	WFqbIaXD0wyDuBzd5KHIRz52npkYlPund5R96Rh4mTj0KhHPO8EzOfaD27cHljFaBb6bkm429Hz
	acYx5q6/EdiW0ieFO4bpE1rXUbwBsWOo3GDuPq+2Ku5+T172zHertxEwDc4pKHWoCXikA+CsHRQ
	Jeg1Ao+LdcqZcjEgYTgJRHlhKVA1y1E5PARENBiy+tJQGx5Nd68kBhpq4QqDtiAAuQTqlb44f6J
	EctnNYfcpj4A/s04PCeNdv6GmxmFBSk2LdiKL7ym7orkF17A=
X-Google-Smtp-Source: AGHT+IG5+1GVi2mH8CpCHCfiaPZz/F4eS33pzARjBNR2zH29aTmr8kvRs43iZqFzkoNQ2RMuMcTeHg==
X-Received: by 2002:a05:6000:2911:b0:3a3:6bff:9735 with SMTP id ffacd0b85a97d-3a36bff9995mr7410026f8f.10.1747746102260;
        Tue, 20 May 2025 06:01:42 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8cfsm16538095f8f.37.2025.05.20.06.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:01:41 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 20 May 2025 14:01:19 +0100
Subject: [PATCH bpf-next v5 3/3] libbpf: Use mmap to parse vmlinux BTF from
 sysfs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-vmlinux-mmap-v5-3-e8c941acc414@isovalent.com>
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
In-Reply-To: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
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
 Lorenz Bauer <lmb@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>
X-Mailer: b4 0.14.2

Teach libbpf to use mmap when parsing vmlinux BTF from /sys. We don't
apply this to fall-back paths on the regular file system because there
is no way to ensure that modifications underlying the MAP_PRIVATE
mapping are not visible to the process.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/lib/bpf/btf.c | 89 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f18d7e6a453cd9e5c384487659df04f7efafdf5a..3b98ac40bbd66c4fa688f967f9370b5c92610ba0 100644
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
@@ -1354,6 +1375,37 @@ struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf)
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
+	err = -errno;
+	close(fd);
+
+	if (data == MAP_FAILED)
+		return libbpf_err_ptr(err);
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
@@ -1618,7 +1670,7 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 		goto exit_free;
 	}
 
-	btf = btf_new(ptr, btf_info.btf_size, base_btf);
+	btf = btf_new(ptr, btf_info.btf_size, base_btf, false);
 
 exit_free:
 	free(ptr);
@@ -1658,10 +1710,8 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
 
 static void btf_invalidate_raw_data(struct btf *btf)
 {
-	if (btf->raw_data) {
-		free(btf->raw_data);
-		btf->raw_data = NULL;
-	}
+	if (btf->raw_data)
+		btf_free_raw_data(btf);
 	if (btf->raw_data_swapped) {
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
@@ -5331,7 +5381,10 @@ struct btf *btf__load_vmlinux_btf(void)
 		pr_warn("kernel BTF is missing at '%s', was CONFIG_DEBUG_INFO_BTF enabled?\n",
 			sysfs_btf_path);
 	} else {
-		btf = btf__parse(sysfs_btf_path, NULL);
+		btf = btf_parse_raw_mmap(sysfs_btf_path, NULL);
+		if (IS_ERR(btf))
+			btf = btf__parse(sysfs_btf_path, NULL);
+
 		if (!btf) {
 			err = -errno;
 			pr_warn("failed to read kernel BTF from '%s': %s\n",

-- 
2.49.0


