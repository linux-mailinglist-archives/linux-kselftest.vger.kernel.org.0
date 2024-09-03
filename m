Return-Path: <linux-kselftest+bounces-17022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E30996959C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45681F2465C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6C81DAC4D;
	Tue,  3 Sep 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef2zBkr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB3A5F;
	Tue,  3 Sep 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348815; cv=none; b=XrDLdEmV/dNdvQO0uTmH+y7xJ19T0RR14+J9F7J/+TIkhHWn9YSrNfsNIGxGZz351X04looieCk6IAKUckfS06Io1afsy6oIGCy9YAejTudFIVyhZHQwkZkSrmXwFTIuPOQXOAeCTBhA10TVEH5FvH+8eINWhXM/Xqduj4OY5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348815; c=relaxed/simple;
	bh=/HkP5F3Ap1Yy1yov6eEfRAbFIVvJ7FuWWT8X7JQ61J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaVmnwgOn8BCt/qKS//qgpwj+X8MqNLuArdoEE4lOiFpSXCFNwAsu1Kc49iHhk1c6JZ+GAxIIi1tlKR7I8O52gs/QjI6dkv7UUjdv5RJyrQ6EKpoemCiKmB1+FsJXMGW9QriAwXBxWaYTKygd1jipQEyKdAERVga0lT79uqFEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef2zBkr/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-715cdc7a153so3430285b3a.0;
        Tue, 03 Sep 2024 00:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348813; x=1725953613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIffDFZIdPanpgFz8jwQR1M2aOiBc5fSpuhRSjpmIuY=;
        b=Ef2zBkr/cFGXTF317sfMOBA/5sQ/U01qK0ZNqb8WBLaLgoQ/57K5rCKyRAJDkK8CxE
         oMulrhkTSrzbcp7sm+3ll4CB9tDBgs7JcLCjTndLfwqYF/3zq/EuaYggMdIpWD5YwzOR
         F/XC3o9dozr9WHC5CvF8ZzitxDQYn/+xEHMIh1GfUlQz/cw73T0+JrF34r7vtnXUN+8T
         QEhjqLWnar1BFBx/3VGn00Am7692Ctqgu2EpIcc5Rk9mKSb4xOB6GKwmijcE75CJWLPj
         yrPr18NHT2YyBnVjE0e6KsAElxdvnfO2IbAvRlFb1jHrVdfqKtxT4/q6RF8tg78jrKoL
         gEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348813; x=1725953613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIffDFZIdPanpgFz8jwQR1M2aOiBc5fSpuhRSjpmIuY=;
        b=oS+Z7B6YCC2RJRBKsNtxALDwz892LLj7UApKKNlx+TdSo3SIu4vZUjLicapyHHHJqD
         GGr0rQmeV8Edk708LfZMfzcrqtRB2SfA6YNYWtLe1QvhWoMvLXR0k9CcxJhWH0mmixzC
         xmTcs9goAiiJsGoBUicPqwThCjw+GYtvKc79um8REVa7kPXlvJ6B015mpRuSMtJuVsLT
         +0I2KbvskRVZtb7AjyDQlOb+q08zPxxrcf+X29OvM6fGfvsiti0G6qahXy5BmvZtcXMq
         /HEigWpNvGegBnQbw0LcBbQ6tRCqaQM7zQrpXZcH0F71QOQCUY0FgvbNXpx5LPJvs2iB
         /C3w==
X-Forwarded-Encrypted: i=1; AJvYcCXiT4Ivb72RtS7Tu+bLD/pzZceIMUpAupiEX7AfAYjvnD/ky+JRucEmezt31Doqw6xblCSoOhJjqY738/9VCDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXT9rveI0W3og1+TQbQCEY2OyM2KWfaq9JK77zMy5ssuWXK3Ko
	EKRYrbWRZ6o0kM49AFppmDvnabZJh0iiltk26Y6lXRnPaBYleSjJkFWAC3dB
X-Google-Smtp-Source: AGHT+IH8HG0OyMjaDQl5ib4bF49WijrVTmUuZ7EMqb+g8dl0BLamiZVyekK2R9uj1chq/P4NfEZUfA==
X-Received: by 2002:a05:6a00:9298:b0:70e:aa7f:2cb3 with SMTP id d2e1a72fcca58-717000c75d3mr19261345b3a.2.1725348813175;
        Tue, 03 Sep 2024 00:33:33 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:33:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/8] libbpf: Improve log message formatting
Date: Tue,  3 Sep 2024 00:32:58 -0700
Message-Id: <5f8bbe16b738d455a0b2f74663b5c402def8b28f.1725347944.git.tony.ambardar@gmail.com>
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
index 40aae244e35f..5f094c1f4388 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2941,7 +2941,7 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 
 	/* If no records, return failure now so .BTF.ext won't be used. */
 	if (!info_left) {
-		pr_debug("%s section in .BTF.ext has no records", ext_sec->desc);
+		pr_debug("%s section in .BTF.ext has no records\n", ext_sec->desc);
 		return -EINVAL;
 	}
 
@@ -3029,7 +3029,7 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
 
 	if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
 	    data_size < hdr->hdr_len) {
-		pr_debug("BTF.ext header not found");
+		pr_debug("BTF.ext header not found\n");
 		return -EINVAL;
 	}
 
@@ -3291,7 +3291,7 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 
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


