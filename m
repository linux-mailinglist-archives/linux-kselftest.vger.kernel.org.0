Return-Path: <linux-kselftest+bounces-32428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE1AA9BB4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D674F164BB7
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC42701B8;
	Mon,  5 May 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Ez5ZNQhB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FE26F463
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470386; cv=none; b=Ul/gluHI8QIFBtcN1FbZ2YKrRRPkxJ+rE9/vcaHDvKq5YSinPZth8jZDe+raViDcmCtbJbQbUIOnTAaCdOGFtQK5VuRnIRSmu4moPQlu36uD08DdOjIORtHCGqal4M9sDFL9/7ydW2F2U/9S+MIvf5qKTOt4SNeQ3iEF56oT510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470386; c=relaxed/simple;
	bh=up9a1YM4tArFppHFNdrFADc8/CKFM14Jqw3tI56B5t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIhEhisYDUabL/AQ/nd+E6n3EsKqw0oxqyj5bq1wmefaHdt6vSEC/yHZf9aj6jkbmE6Y7S73cGq9NVoL1bXmhkgv+Ic/jPpwmnMekAmMlkOZ9Q9R1Ab+wLdymLhSLVsje3ZTyifJ8N5YnOUH/X1RkLt87hs+S7fn70CzOcinck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Ez5ZNQhB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3044342f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746470382; x=1747075182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvnaQmeST1mheRYMccMqZNEEW84cIcZjY0Sub0+nVyg=;
        b=Ez5ZNQhB2DPtSJ/ev1UVhohZo9QZBU6MvtM5gk7cYrJ55DfwwTb3fa7h1ulvav6xsD
         2hJ3Bb85POmNr2B1OmJz03iY6iOA+w6aHUHwG734N2TpRTuvKMPyBq4QXQN5Q5yWxavb
         Odzg0h5CmFR/qMdNtSfZ0Y7rG/Tcl0sHRMXnE/OXemN+EQq+GpZsN198oOBDxUJguWHO
         K9jekQtMIVjIYCi1zcSOVRJGoXCGgCPszScJWyklfV5bzxMOPmnNvHiTnOAMicltDlCl
         xLJieyIHaP3U9UlTgmV0fu7Cq0wwSZj2GxOCK/AC/6RrYanfVr2uOQevurx8qDr5o+H9
         9PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470382; x=1747075182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvnaQmeST1mheRYMccMqZNEEW84cIcZjY0Sub0+nVyg=;
        b=fjRflfWVBuaQL/pldVKnOn7KzJ1GRHdiLj0dqVA8MQkuT9Lq6YsrcE0Y0J92V/VVV1
         v50/wHSTPhWzqHMNezbDYafbZS3NTfL5L02o93PiFBLl+eZHG8QKn0wximsVEjYFjwtd
         0xfrIwwuvZF9Ic3CQrtiMPOPT4uph2zs/MXDxahMh3rwHDT0/9nExMBfjeeebv2IJlKR
         5EQyExs0fyrQ/k/JBmAF2kpasVC47jWYqA5/mpXT/tVjm0EIYqEinl/6NpPqHtyumsQi
         9jF4LkkmT9kizgnWWte6DGkqYEHJ5V4k8KEr1JVF3JDYbJ8aNKQ80qeRo0QDOnALO/ct
         cc3w==
X-Forwarded-Encrypted: i=1; AJvYcCXseDEO7YqB9ZxkbqX1ZMTa+39nqPBTHx2Zqa5l5UE8tKe/95GeHwb9I3blfVKrq1ADEncsVyi2YYq12XutzEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQYrxWj5vlEEdVm9vEdLtBNL+sL/tlJHJptie1tbOH9HQRMJP
	wgKHNmpH5QKQ4BVn57y+rNxDKFxuc5IW1qNPcC1hV4qf12GunL/to1ANf5VlATw=
X-Gm-Gg: ASbGnct60+ITRAmB/3RE54JlSAl7od1dyXiz1oa2px+SL/8GhIN3EhLjrLH9yZpnkmS
	qcfdQ8wYOjuSvM1RO5eowwY342uqiwiaTl8Ml2YV0pYIKtwQlfIws2RJ5zM6YYW6VPcG+s4RZLj
	/dE9HaqDVzVW2B+ccOR2QRHfd0LrH/3OMyNwlckTyz4iCk/nM34x5EK9boibhbg4I4oAww8EN/C
	wTnY4uCI4OAjk/sHgtAsh7cyNhZ/tU4WyhmeShIDnLKFG1Jr1Wbm42wBjZApTrziifqayo6+g4q
	GT2c8WbETLJOQVqHFabNB2Ae/d6L051bjs0rl2ECadKGcsJjqYXRdxnPI8PU3WSlDWabx1MDOQ4
	sajtnNd681+UMepfqg1d3PYmZoIFJ4KXSIdqp
X-Google-Smtp-Source: AGHT+IGaP9tNm2c0RziJEdBKRZpIsFJ5xqDJC0msO6dFV0yZufxPJ59rvap8ssGSpPlqeWLjv0NnQA==
X-Received: by 2002:a05:6000:1887:b0:38f:4acd:975c with SMTP id ffacd0b85a97d-3a09fd96325mr7274351f8f.27.1746470382270;
        Mon, 05 May 2025 11:39:42 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8117sm11328877f8f.56.2025.05.05.11.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:39:42 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 05 May 2025 19:38:45 +0100
Subject: [PATCH bpf-next v3 3/3] libbpf: Use mmap to parse vmlinux BTF from
 sysfs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vmlinux-mmap-v3-3-5d53afa060e8@isovalent.com>
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
In-Reply-To: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
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
 tools/lib/bpf/btf.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b7513d4cce55b263310c341bc254df6364e829d9..3006c1ebb97ed899eb519b10927491d87ccdaca5 100644
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
+static struct btf *btf_new_no_copy(void *data, __u32 size, struct btf *base_btf)
 {
 	struct btf *btf;
 	int err;
@@ -1050,12 +1065,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 		btf->start_str_off = base_btf->hdr->str_len;
 	}
 
-	btf->raw_data = malloc(size);
-	if (!btf->raw_data) {
-		err = -ENOMEM;
-		goto done;
-	}
-	memcpy(btf->raw_data, data, size);
+	btf->raw_data = data;
 	btf->raw_size = size;
 
 	btf->hdr = btf->raw_data;
@@ -1081,6 +1091,24 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	return btf;
 }
 
+static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
+{
+	struct btf *btf;
+	void *raw_data;
+
+	raw_data = malloc(size);
+	if (!raw_data)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(raw_data, data, size);
+
+	btf = btf_new_no_copy(raw_data, size, base_btf);
+	if (IS_ERR(btf))
+		free(raw_data);
+
+	return btf;
+}
+
 struct btf *btf__new(const void *data, __u32 size)
 {
 	return libbpf_ptr(btf_new(data, size, NULL));
@@ -1354,6 +1382,37 @@ struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf)
 	return libbpf_ptr(btf_parse_raw(path, base_btf));
 }
 
+static struct btf *btf_parse_raw_mmap(const char *path, struct btf *base_btf)
+{
+	struct stat st;
+	void *data;
+	struct btf *btf;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return libbpf_err_ptr(-errno);
+
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return libbpf_err_ptr(-errno);
+	}
+
+	data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	if (data == MAP_FAILED)
+		return NULL;
+
+	btf = btf_new_no_copy(data, st.st_size, base_btf);
+	if (!btf)
+		munmap(data, st.st_size);
+	else
+		btf->raw_data_is_mmap = true;
+
+	return btf;
+}
+
 static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_ext **btf_ext)
 {
 	struct btf *btf;
@@ -1659,8 +1718,7 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
 static void btf_invalidate_raw_data(struct btf *btf)
 {
 	if (btf->raw_data) {
-		free(btf->raw_data);
-		btf->raw_data = NULL;
+		btf_free_raw_data(btf);
 	}
 	if (btf->raw_data_swapped) {
 		free(btf->raw_data_swapped);
@@ -5290,7 +5348,10 @@ struct btf *btf__load_vmlinux_btf(void)
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


