Return-Path: <linux-kselftest+bounces-15835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD295986D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8E11F22B09
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB71CBE90;
	Wed, 21 Aug 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwRQy2WX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975D1A284A;
	Wed, 21 Aug 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231392; cv=none; b=kiH4Lsipb3F4hq8+ZRtupOw4qZhXB7kdtrxZXNjuon31R1OBmHYH4BYGP2JEreNfCPIcTimXp1JDmvnLiMJ1xr+CB5k12eX9SNFkzRBiWIUhEamgc+iU5GBfiFN9lfPZ27PcqaOvvjGLsvm9wK0FwqYJccl0Tl2sNdP8Uid9v+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231392; c=relaxed/simple;
	bh=RULpRj+x6xiQ9FxrwCrODXVeFnHaWP7jw8+W86HvXwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsL5jeauKTsRmA8FAdomjJxkVn84M5Svvus4hSJPgpbIdVbsTojk6QfobyQkkZIDrTdFZ3kbhYqwNjComhN+oTxWOqVTH/+h2fsoEjrYbH9dtwGblDIYOXaIyN2gedM/yz4Np8NGuTw15/tTRoGNsD6qKtl0pH9tokLv05+xiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwRQy2WX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fee6435a34so42663735ad.0;
        Wed, 21 Aug 2024 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231390; x=1724836190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg+SydAic1DN9KXNLTqh5Rc9lnjAu61/0BbcjkZohkI=;
        b=UwRQy2WX/hg40klj5nTHUT6MrQQEuTP8hxVsPPkrkve+Q0XlFm/NAti8jUSTA0R7oE
         0hS0l4b2RSflgt3E5zpRTNekSaS+QKFATFvOONWpUYOlzaFOLE9myQKMLb3/TKydop/4
         QoN7imqPuppOfw+tN+sgpMUkFXmexplVg8A8ViWZO6h5gaDI30nKiE1AjhLBOLYzTeEc
         sB1Z4xfscU6OZTHHnr6QnEQ8c8pNMF4MmDfUbe0fwEBotlBod3VFQIn8/0G9SZeMBWZu
         zEIDIEGfcDhsUrogQMzt2N2E2Gj6c+rztG4clHpO8rrTxNHQpqOWtmJuKlvxgGBrFHlO
         LC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231390; x=1724836190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg+SydAic1DN9KXNLTqh5Rc9lnjAu61/0BbcjkZohkI=;
        b=I/2giCDyXaf/h0WdRQmwsRG+9RvHuUthSsqITevJu92BP8Dk+TV1zuMVOqKiurA2Hc
         ZqIXcg0BLnOnr3MnQK+tuvgJ56JrtTLlHFEA1S9q3d6S8ylMQ2on91mZkoyRNNuqMLRd
         3VUxi+GDpjCA6lzqUKULj1QTIoKS3lRC6+u1d/uoOT3yhdUeHyA/dLOdXkA5fe7tp0Ah
         mB9QmFEvLpue8NXTPiBKHdLxDri9zWB6CNx2SNWqfSollW6LSh7CWUQQ6Z8iXz+urNx+
         BWLwhDAhZhLWVWWn3PMMkAhiWlNR/8rCkZYDvwnQE0EDi1qcQPhljaSUU5KAIOLaezQM
         CRIA==
X-Forwarded-Encrypted: i=1; AJvYcCXExVr/vxlnd+g0hD3HzQbWnMJ0cHyfavgdW6GZQL9o9wydOGFWCznmn0wBWno2zAVwk1vkdmbhJ5B/Qnue6xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFJEEkaVac0AGfDaIjhyDXhisHaWzqsBtT2c4POTr3mvI4Kki
	PjxIXfYPulGngxwgxYGjGi6aRzyfsB1SmD9Bqrds/KJONkNeDoln2uQDkzwF
X-Google-Smtp-Source: AGHT+IEw6lwbnf2ZWiyTT68HHAWnAM89KsUZV+OpNNv1NIE/IsiaF4luDJlh44nmg/uDuGf6DkE/NQ==
X-Received: by 2002:a17:903:41c6:b0:202:3296:eec1 with SMTP id d9443c01a7336-20368199110mr17054885ad.36.1724231390237;
        Wed, 21 Aug 2024 02:09:50 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:09:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/8] libbpf: Improve log message formatting
Date: Wed, 21 Aug 2024 02:09:19 -0700
Message-Id: <91de76f9924a8fad2273532e8ed2536656213f68.1724216108.git.tony.ambardar@gmail.com>
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


