Return-Path: <linux-kselftest+bounces-16760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CCC96588A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891661C20C34
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9631607A0;
	Fri, 30 Aug 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8gb1p06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDB15F40D;
	Fri, 30 Aug 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002999; cv=none; b=m1VDK4nxyB0TPe2b/bmfc+4mkLwGNuwnmtdb8b6+xNnvmKOdimFsMXAr7MhMJL9NTIbylX8TAEcpaoE3XLE25PItWDfIYNz8ryFHzWkq1eksZcMEwr5fvUzwFGz/quVZPeXdLC0BNhyuGnTr/jTl4VyiQ6NBmYiLphdIX6cBztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002999; c=relaxed/simple;
	bh=/8JlYToOV5Gh2aJg+gM8mSMyGlhceXm0Nh59C6X4FrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edDl/VBO/P9cpSiEw3lAg5FIYv2dyN3ieli/0Kg9UFAzWaCh4QWEqGE6010etiADMKDBpz/chf3kBVq0++tY5fJuHAmfytygh61YpMUeqrZ+YDmIEJbWa5UpGmSXOw5GDltFb8s9oAR/7i0i15XOac0GXYGzJyqgrxXzia6eRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8gb1p06; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2021a99af5eso12794285ad.1;
        Fri, 30 Aug 2024 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725002997; x=1725607797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFOnTSDoWpWkB6h5TfNEaXuZcI0mAABpdIpEU9t11Jw=;
        b=C8gb1p06nAl/LksNfA3QqjI8kd5NjmJc9sT51MRFMrqbZboY5FARwmFudvCHoC9GdK
         IomjN8Qd+JqAgr/D1EWT4xz9+lNBZoGVbV9KFfiLP/0HNAskw3GkQkwAJ5VLtCERYmdU
         QjbfAUKPOylw5Th1bRBjo50oxGnlg2GjWDG9flBeWUWU9LSkkNTTqWWAQpg1FrpkU+vl
         3c09uHvYBD/hG4he57SEoTSi1RlxIt4hSyb1ngdusp/ThQFicHg/MxK6BNn266XuODBJ
         2As0P5ceQdHjJ0QSdxlcTyFEW2z1wGoK5hX7WiuOMR6hJ0FlSjyRKjtWrjNG0126GVdq
         b3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002997; x=1725607797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFOnTSDoWpWkB6h5TfNEaXuZcI0mAABpdIpEU9t11Jw=;
        b=cUhSJOFf4jlHcj6uI7X647B5WbEjhXtck2yI/ACsPwRKjktBsJp7E7g51rVPvSugQl
         RFKUw6hSwM+sYACDX3Cis+HxP91rp09V/r9u+cFYhUTKOAt+b/qQ4Gf+DNWuDVOhqxBu
         ktePh945KFSZ4oXeL03kdpl+piBZt2ItPRmuZRYWtP7LSb9MwHv+yoXeKXS6yJkk1SQJ
         CoLGA/7hwjPGnKXgOoIipVNNl9/VEPsTZ+E63fLOTb7iQoOGY2w1FHaHPjrNMLFOetnq
         Y6qZYILBh6h5qjMlLvbVOy1DTtx/Ez0WqgMKqMiBHfS/Fvz6nQCR/L7rEblSRYgyuUiP
         bB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTr4JZM/yNjH6aEUxlkhYStWwC0I+EMNUSr0HmDnJQXBA2+hwNgSOUwrv7ezSeBA9ErFnDPhLIwV93YBogkUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzduk8CyMo77eYIlPVMQB7BR8zWpJ6xBgOP4czmYISfhRQDAs1U
	X0OUTMWBKJFH09q0pQsI8Px5peKzRGhm78624JuWKv1A7RgZaD/gh/ILNoDH
X-Google-Smtp-Source: AGHT+IHdRDnNWiulS4EMKo4qcAn2TIU7lvMijeQh+WazHvpsp+DtRsDxiteBQW5kh0AJF0zyCjQWcw==
X-Received: by 2002:a17:902:cec7:b0:1fa:abda:cf7b with SMTP id d9443c01a7336-2050c2068edmr70608875ad.9.1725002997031;
        Fri, 30 Aug 2024 00:29:57 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:29:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/8] libbpf: Improve log message formatting
Date: Fri, 30 Aug 2024 00:29:23 -0700
Message-Id: <0d337d7c8f78dc616fd68449d6bdf4e48fb67fa9.1724976539.git.tony.ambardar@gmail.com>
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

Fix missing newlines and extraneous terminal spaces in messages.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c          | 6 +++---
 tools/lib/bpf/btf_dump.c     | 2 +-
 tools/lib/bpf/btf_relocate.c | 2 +-
 tools/lib/bpf/libbpf.c       | 4 ++--
 tools/lib/bpf/relo_core.c    | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 32c00db3b91b..f5081de86ee0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2940,7 +2940,7 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 
 	/* If no records, return failure now so .BTF.ext won't be used. */
 	if (!info_left) {
-		pr_debug("%s section in .BTF.ext has no records", ext_sec->desc);
+		pr_debug("%s section in .BTF.ext has no records\n", ext_sec->desc);
 		return -EINVAL;
 	}
 
@@ -3028,7 +3028,7 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
 
 	if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
 	    data_size < hdr->hdr_len) {
-		pr_debug("BTF.ext header not found");
+		pr_debug("BTF.ext header not found\n");
 		return -EINVAL;
 	}
 
@@ -3290,7 +3290,7 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 
 	d = btf_dedup_new(btf, opts);
 	if (IS_ERR(d)) {
-		pr_debug("btf_dedup_new failed: %ld", PTR_ERR(d));
+		pr_debug("btf_dedup_new failed: %ld\n", PTR_ERR(d));
 		return libbpf_err(-EINVAL);
 	}
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 894860111ddb..18cbcf342f2b 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1304,7 +1304,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
 			 * chain, restore stack, emit warning, and try to
 			 * proceed nevertheless
 			 */
-			pr_warn("not enough memory for decl stack:%d", err);
+			pr_warn("not enough memory for decl stack: %d\n", err);
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
index d3a542649e6b..0226d3b50709 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12755,7 +12755,7 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	}
 
 	if (prog->type != BPF_PROG_TYPE_EXT) {
-		pr_warn("prog '%s': only BPF_PROG_TYPE_EXT can attach as freplace",
+		pr_warn("prog '%s': only BPF_PROG_TYPE_EXT can attach as freplace\n",
 			prog->name);
 		return libbpf_err_ptr(-EINVAL);
 	}
@@ -13829,7 +13829,7 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
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


