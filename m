Return-Path: <linux-kselftest+bounces-18028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94581979CE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528F8281CB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD40213E41D;
	Mon, 16 Sep 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5qUjYH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361874E1CA;
	Mon, 16 Sep 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475892; cv=none; b=Rm3vPx7XjMY0VrMbjXFf4z9TS99/UgqJWiJer7fLBd2szoDTn4+EHGrT1qJn1lBUI6SgzfrFs34caZwswo65kaxZUF4Ox/fVmFL7cnNiReuFatCu/47+6yrEs0VJtVvcxkuojo2djVGOQ9LdO3AkRuCC7IxOBgHCS2quhm5cu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475892; c=relaxed/simple;
	bh=5kMLYNSOyz+Yn9UBpuDwYiJ2rW0v9fTgdAM3OHsUfvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZgifZqAgr/PeObPccIJt9aYm73L0f1V7ESj1e5fzKg8fq+Io1PkN24x26h9Nf3QV+OMdcMW6LW0rJetyHuoq2dKD3RfNEMtCRVrvEufHogxcljvx8TH9ZaZhoq2n5aUt1dkOB33Th6lB0zkSnM0LaiyYZV22SCQbGoWxNa+0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5qUjYH/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so3343651a91.1;
        Mon, 16 Sep 2024 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475890; x=1727080690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdeDfGkTMKuiLf2ToQ5XCmd62ELl3DcdV3OKoD7XkXo=;
        b=Q5qUjYH/Obb6k3ta6AsN5oUxaWyjwIiBtb9giGA9IgNNdSqLXLpzcuWQjyU3f9X9QL
         YrSmbM4eGgjwiu+ngU5OOKr51Uyk9CJBPaAe3ASfQ99PqbYzXAXukUIDOhAAO3z8qStl
         ZGxnELyv6B24e7cgvX21b0leLKQjVF+ChGAKPXCim63CNj5gOmOUoab8TuM6gSujwgvb
         /aGWduWp5jsD5+OrcQgNLQk08xdFaD+QelP8eQGTpUXk1wuzS4qQ3Uad0lpHO0rHYBVj
         iOwsJROn0iTImEyxDsXVt4TCg74d05pydEW4vvJTnf5gCDOECq0MVmke1GE56ANiS3Ii
         6a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475890; x=1727080690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdeDfGkTMKuiLf2ToQ5XCmd62ELl3DcdV3OKoD7XkXo=;
        b=JVPGKocnUQ1zDCUKlvtQY9UsSABCcUR+t56M5TP3rUnbOeIIifbe7MQpsE1EFbzzFj
         vT5xO3RiY0IVR9UpzsDNpp3tWV3rszp2DWSTvQmE1anPmRV9Zj7BK8iQcBGJM8DS56mX
         CTqnX5hk30AH6nctTsiF//Q6/6OcdqF6+QBLQdUTCPaVGKXqiTXV7UqfjupJ7XhLNPXM
         nQDgRyYAZsXCoI0XHY/VJ92JZaOeO8yniCUMQS4QqWSmmWnFJsYQlzvgBO92IFZsnf1S
         GkKJ+aSYpEyTt3niL8ryQblP6g7/Jfs4pPFVDBL6KhOR2oFHXz8Tv9bnzMkEw8xLnz+x
         d/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUcU2KKRqT1XpFp9hsbnGc8WezaOg4R5ti4QXnMaOeKdV/0pU94YYRESBgBRcx4rHPiW1P2IbRMZLiOjrbET1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8hp3cf3bWrTQqg052Sw/m9/b5HrttlZLNAlhROly8/nntiu/
	WwsLV8wvk0tuv+IBEPOUTSygia4mnFb5b5563XsE8w16uyrR0h/z81+2Vg==
X-Google-Smtp-Source: AGHT+IGQZL0RuRboACTy7lIOXJxsKbAKiYf2KyzE8oXWR3/0OwFKtJgiy8zskkFXwXxA9jK1b+QKQw==
X-Received: by 2002:a17:90a:ba94:b0:2cf:f3e9:d5c9 with SMTP id 98e67ed59e1d1-2db9ffdc386mr14501666a91.21.1726475889900;
        Mon, 16 Sep 2024 01:38:09 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:38:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/8] libbpf: Improve log message formatting
Date: Mon, 16 Sep 2024 01:37:40 -0700
Message-Id: <086884b7cbf87e524d584f9bf87f7a580e378b2b.1726475448.git.tony.ambardar@gmail.com>
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
index 3c131039c523..e1d4cbd83729 100644
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
index 0a7327541c17..8440c2c5ad3e 100644
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
index 219facd0e66e..60b69c6aaf53 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12760,7 +12760,7 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	}
 
 	if (prog->type != BPF_PROG_TYPE_EXT) {
-		pr_warn("prog '%s': only BPF_PROG_TYPE_EXT can attach as freplace",
+		pr_warn("prog '%s': only BPF_PROG_TYPE_EXT can attach as freplace\n",
 			prog->name);
 		return libbpf_err_ptr(-EINVAL);
 	}
@@ -13834,7 +13834,7 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
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


