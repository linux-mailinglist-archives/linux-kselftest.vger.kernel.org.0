Return-Path: <linux-kselftest+bounces-16033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDA95B194
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A1A1C22DDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0117C213;
	Thu, 22 Aug 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSWxAXgK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478417BB2A;
	Thu, 22 Aug 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318706; cv=none; b=SLLJJqZTpqWgzQ8jH/ky9OTHTYSKJkyN9rbohIg9N8Ev0dABFFBY1EUuk5jj0B1TuTEjVQKVbGommSutr66HN0uNkjDWm609vKfXS8jOkpsCLYWb7xVe1AvbAvvWeAqM7v2PFlJYeIZEwk55cgyP3oLHTZ/QvMCZPgltSN1tt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318706; c=relaxed/simple;
	bh=TxA2C+GdCqOmHIAvvr4Uuh0LZXojsqIzQodG1UXIbJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zpgg5jBp0qRQss59/qiuKMkSdXpPE3yc4NlL5MJgm94AZChgqJQtLwMJ+iB19qTHWMz8JJYt3cikG7olDSeDjMcMsPSBOSnRKqdF/p6BP1MgmuV8xfpzI0jNkTQAdP5+38f+6tqCGeN453Ip6CdHcN+6zIRuNZkrvMBVcRDwnko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSWxAXgK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so451990a91.2;
        Thu, 22 Aug 2024 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318704; x=1724923504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIq9mb8QDFOrDtUTONaareYk+pebO6PU/g3DNG9tstM=;
        b=YSWxAXgKa4b1YmvvacKbsFSjJzbV4LxDZ855qoIEk2W7HlJMEeLtAeUHxkNcihM+iC
         MNBVQW+c/3PX8kpU1807UXoTeivfohDBtoS5CmnWXuHCmssnBZxYMN9OXGfV4i0OQCd1
         SchQqOvPK6zmEJdQ8C+qf+H1OlVOan0q3ZJRyL2cFVZe6Z1CyYBEbkEoEpOzRxESps4t
         S8wuHVNuhTi3BpP+qgUPH7xYbaIqUFRzF3qKJ+VduPh3xH9g0Iu8zcVIpr3Dilw/c/O5
         o45QkPHRaSQBsF7yiL/9CLxi5zfewj/B7LFfDlmhkoGwrW/tq+QVdxYsL6CaBjXmpf3C
         BDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318704; x=1724923504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIq9mb8QDFOrDtUTONaareYk+pebO6PU/g3DNG9tstM=;
        b=CWKXMcQ/+iq32K3OAba6t57TT++2l6Nd6ZAZ1brmDkxyKyTcUzFOPiFMC9tAGb/fbl
         CEXb8dpPAziE9Ws6ekwHJC6IjJc2c+bH0AcmuT1ndtbwnQ6fhYPqgy6HIcOfsMhX2Rdd
         +fwVgJIEUutiTRfODH26M2USmd3tUqDEuvKU7w6fmPrO51NWdYbO46RcaDRuhky6Zoim
         6ic6HyGp501vGFDkBF+BXvAqOoVblVCh6ttwaz+n6G+eoyJCKKHCp6BFTOZLn8dKiqPs
         n7D+Iq9XrRKec1u59UiKznOJBDRL00NVlFhQzYPAYIaoOZEzWxmfiGm6NLBBsWWRGNbA
         6/kg==
X-Forwarded-Encrypted: i=1; AJvYcCUNyXNhy2Y2F0dSDMLbK1aOjKrhaLALeal3ASF4+AZJEN+HDhig036XJQ7V7tBYMfD22VCuSBQA79MVoBuRAnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0c5R85chF/LdXpFHQrogOe70llJJJ8RVsQcBK4XBZVdDW3KfI
	apXYTTzTb71zN7x9HT4rWS38S18fPgB5O4OXWSJk2YswVOjVjiiuDnvGyuxz
X-Google-Smtp-Source: AGHT+IF4NbmvsWWc8JOu4qe9+WWagOMF5F5qnjixbQqeDaZwde0vuaZs3+C9Rzt6XrfJQ25OqL30oA==
X-Received: by 2002:a17:90a:6fc1:b0:2cf:c9df:4cc8 with SMTP id 98e67ed59e1d1-2d61728e621mr1501220a91.38.1724318703682;
        Thu, 22 Aug 2024 02:25:03 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:25:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/8] libbpf: Support opening bpf objects of either endianness
Date: Thu, 22 Aug 2024 02:24:28 -0700
Message-Id: <3b65982b50a9ca77a13d7a5a07b8b5d37abc477f.1724313164.git.tony.ambardar@gmail.com>
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

Allow bpf_object__open() to access files of either endianness, and convert
included BPF programs to native byte-order in-memory for introspection.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 21 +++++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h | 11 +++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8a0a0c1e37e1..a542031f4f73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -940,6 +940,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	return 0;
 }
 
+static void bpf_object_bswap_progs(struct bpf_object *obj)
+{
+	struct bpf_program *prog = obj->programs;
+	struct bpf_insn *insn;
+	int p, i;
+
+	for (p = 0; p < obj->nr_programs; p++, prog++) {
+		insn = prog->insns;
+		for (i = 0; i < prog->insns_cnt; i++, insn++)
+			bpf_insn_bswap(insn);
+		pr_debug("prog '%s': converted %zu insns to native byteorder\n",
+			 prog->name, prog->insns_cnt);
+	}
+}
+
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
@@ -1610,7 +1625,6 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-	pr_warn("elf: endianness mismatch in %s.\n", obj->path);
 	return -LIBBPF_ERRNO__ENDIAN;
 }
 
@@ -3953,6 +3967,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		return -LIBBPF_ERRNO__FORMAT;
 	}
 
+	/* change BPF program insns to native endianness for introspection */
+	if (bpf_object__check_endianness(obj))
+		bpf_object_bswap_progs(obj);
+
 	/* sort BPF programs by section name and in-section instruction offset
 	 * for faster search
 	 */
@@ -7993,7 +8011,6 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	}
 
 	err = bpf_object__elf_init(obj);
-	err = err ? : bpf_object__check_endianness(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
 	err = err ? : bpf_object_fixup_btf(obj);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 6b0270c83537..f53daa601c6f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -11,6 +11,7 @@
 
 #include <stdlib.h>
 #include <limits.h>
+#include <byteswap.h>
 #include <errno.h>
 #include <linux/err.h>
 #include <fcntl.h>
@@ -590,6 +591,16 @@ static inline bool is_ldimm64_insn(struct bpf_insn *insn)
 	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
 }
 
+static inline void bpf_insn_bswap(struct bpf_insn *insn)
+{
+	/* dst_reg & src_reg nibbles */
+	__u8 *regs = (__u8 *)insn + offsetofend(struct bpf_insn, code);
+
+	*regs = (*regs >> 4) | (*regs << 4);
+	insn->off = bswap_16(insn->off);
+	insn->imm = bswap_32(insn->imm);
+}
+
 /* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
  * Original FD is not closed or altered in any other way.
  * Preserves original FD value, if it's invalid (negative).
-- 
2.34.1


