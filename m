Return-Path: <linux-kselftest+bounces-16029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1695B18B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0781C22C13
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20217DFF9;
	Thu, 22 Aug 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj7eNYZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C2157A43;
	Thu, 22 Aug 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318686; cv=none; b=I7ZEAEo3ZDh8Icp3kdSQq8VCf0WuR5K4Ur+gO+J2nKfhJwc0d1ixeTai23LtyQ37T759YL0JS3D/xjP2TTyU8h+ONAKDJOmrau1JlgF/n8ynY08OH97TMTfoqlAGjTWePkmbWacoEZYJCD1rXyHDqtLzXsuQGNIIlIEfRwjAoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318686; c=relaxed/simple;
	bh=W7u+8w+h8hZWKGfd+QED6nqeYS6S2UYV8DBHimrvaIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CvcphsD0gpBBlH5vH7OAIpes8JGGj7kjvKnmF6Qsx33SnYakCZHLSj5COvNxtM2eVC/cN18kAQBzVvizf3ceEvwRvdtsL+ukYPDltCPBkJzgh2oWjkcpAfibeVYOVdCVoRqvifFs7OkW2PIqo2Jo5LUsCBsWVX7xyL0VIp9NLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj7eNYZo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d439583573so407452a91.3;
        Thu, 22 Aug 2024 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318684; x=1724923484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvAD4v48CuguNlhDVFd/S44woq/SZ1SlM5Yjoy53vzE=;
        b=Wj7eNYZoFCI2JyGvycIh7z19mpeYGeTc7dDSRbUJcrhLohVOwgtMBrgtb6yY4SRac8
         50n/q0Bp25JwN6J5WuvWbKbQk0tcsKa9TnVLiiL6KpDxSJfeK/hqeZ9hEJ+me0/X0chv
         xK4h2deSTk5DSsuTbA3GgvKVRe8fXeeS4ZJq48A+1nIYI4/TXQMnu+4yy1ZXnpsaFCGY
         Xnb4Y0QuhpILNAzgBr9FldEcY+KNEo1akTQcBaSwjAT+qOr43rltrwLWaH2Qih98k4yL
         vmPd4CZFpJAHJFhSk1M6Q1F9vP4aUrmU7nWlnuzCHHdGOV3V2svREDUaKvf6Us+MD04O
         Umkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318684; x=1724923484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvAD4v48CuguNlhDVFd/S44woq/SZ1SlM5Yjoy53vzE=;
        b=JVpqc7q2Q4vdAoPiETENAgEPAWWCqCTKHsMRiTsOwKGxwq3i93218on8DjW1pycXXD
         AglJgmq/ttMK9hoaxEKnXbAV/l5lbLlDODaDC5PX3BVBbACEOIZwOAsy3TBsWj5JiSYv
         LkF/USSDuzM13flbEwxoUT6rYmOV8Akp9AN0oMFuXvyZZnnmpmZkK847phAUKfqYLYM+
         Cb7uKxIKRviAGbT2R4SmLEqQ7JsN+0wtXRJiJo5Gzj3BkWVbfFQt52hUWthKHWOLC81+
         1/93zlGhDMXplHnj5D4gywVbetUwBWsBxCcmdGT525HGV//YqQJjICJssDDghqhMPxOz
         0b4g==
X-Forwarded-Encrypted: i=1; AJvYcCVd/52Sw/euvkivHgwXt0LRgVY4u1TxlmXTQsTfTquvObKe8dF2c/IZD4gz/F56i9GklBkhkOnv5awtpQ7+RzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Bk7TiRRDglbbop1yB2c/78ekpL8Fs1FbY6teY45QY8lfwd51
	97bt4er3FHwmiSQUCYqBtGJ1ryQPJt2A8U8X4zbwLdq6mEwmju12PxRnWFp0
X-Google-Smtp-Source: AGHT+IHF81E+fAH2gWFVog0C1kxu5da0aOSjgtlE9SKqoV3Fy7X8je8xGrVyVaX/IFvrCNd1bf6pqQ==
X-Received: by 2002:a17:90b:380e:b0:2cb:4e69:eaa3 with SMTP id 98e67ed59e1d1-2d5e99c53abmr6020841a91.8.1724318683925;
        Thu, 22 Aug 2024 02:24:43 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:24:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/8] libbpf: Improve log message formatting
Date: Thu, 22 Aug 2024 02:24:24 -0700
Message-Id: <884c0e57404f3ad15bb658bc55b7d16928069828.1724313164.git.tony.ambardar@gmail.com>
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

Fix missing newlines and extraneous terminal spaces in messages.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c          | 7 ++++---
 tools/lib/bpf/btf_dump.c     | 2 +-
 tools/lib/bpf/btf_relocate.c | 2 +-
 tools/lib/bpf/libbpf.c       | 4 ++--
 tools/lib/bpf/relo_core.c    | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 32c00db3b91b..cf4f7bd7ff5c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2940,7 +2940,8 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 
 	/* If no records, return failure now so .BTF.ext won't be used. */
 	if (!info_left) {
-		pr_debug("%s section in .BTF.ext has no records", ext_sec->desc);
+		pr_debug("%s section in .BTF.ext has no records\n",
+			 ext_sec->desc);
 		return -EINVAL;
 	}
 
@@ -3028,7 +3029,7 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
 
 	if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
 	    data_size < hdr->hdr_len) {
-		pr_debug("BTF.ext header not found");
+		pr_debug("BTF.ext header not found\n");
 		return -EINVAL;
 	}
 
@@ -3290,7 +3291,7 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 
 	d = btf_dedup_new(btf, opts);
 	if (IS_ERR(d)) {
-		pr_debug("btf_dedup_new failed: %ld", PTR_ERR(d));
+		pr_debug("btf_dedup_new failed: %ld\n", PTR_ERR(d));
 		return libbpf_err(-EINVAL);
 	}
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 894860111ddb..25e7c44d9f95 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1304,7 +1304,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
 			 * chain, restore stack, emit warning, and try to
 			 * proceed nevertheless
 			 */
-			pr_warn("not enough memory for decl stack:%d", err);
+			pr_warn("not enough memory for decl stack:%d\n", err);
 			d->decl_stack_cnt = stack_start;
 			return;
 		}
diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index 4f7399d85eab..b72f83e15156 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -428,7 +428,7 @@ static int btf_relocate_rewrite_strs(struct btf_relocate *r, __u32 i)
 		} else {
 			off = r->str_map[*str_off];
 			if (!off) {
-				pr_warn("string '%s' [offset %u] is not mapped to base BTF",
+				pr_warn("string '%s' [offset %u] is not mapped to base BTF\n",
 					btf__str_by_offset(r->btf, off), *str_off);
 				return -ENOENT;
 			}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e55353887439..8a0a0c1e37e1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12753,7 +12753,7 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	}
 
 	if (prog->type != BPF_PROG_TYPE_EXT) {
-		pr_warn("prog '%s': only BPF_PROG_TYPE_EXT can attach as freplace",
+		pr_warn("prog '%s': only BPF_PROG_TYPE_EXT can attach as freplace\n",
 			prog->name);
 		return libbpf_err_ptr(-EINVAL);
 	}
@@ -13843,7 +13843,7 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
 		map_type = btf__type_by_id(btf, map_type_id);
 
 		if (!btf_is_datasec(map_type)) {
-			pr_warn("type for map '%1$s' is not a datasec: %2$s",
+			pr_warn("type for map '%1$s' is not a datasec: %2$s\n",
 				bpf_map__name(map),
 				__btf_kind_str(btf_kind(map_type)));
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 63a4d5ad12d1..7632e9d41827 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1339,7 +1339,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 					  cands->cands[i].id, cand_spec);
 		if (err < 0) {
 			bpf_core_format_spec(spec_buf, sizeof(spec_buf), cand_spec);
-			pr_warn("prog '%s': relo #%d: error matching candidate #%d %s: %d\n ",
+			pr_warn("prog '%s': relo #%d: error matching candidate #%d %s: %d\n",
 				prog_name, relo_idx, i, spec_buf, err);
 			return err;
 		}
-- 
2.34.1


