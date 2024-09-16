Return-Path: <linux-kselftest+bounces-18030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E1979CE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB75B220D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB5145B2D;
	Mon, 16 Sep 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTrgBm2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57A145335;
	Mon, 16 Sep 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475904; cv=none; b=Jvo3RclvR3sGOQWedwC/6mSAhKt+8Gs9YIVKFQ+fsD4X/1u9S1bUeExPEIBo3USjO4BJ0AGPkB3MxvOI3sBP04BVoeN+RbBKZSgjs+UFHYuQME6VvQ+IlKelqCt19XrPiW1HaPWQxwu8eGQ5T4s97Rs8QpS/2yac85BLghEiq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475904; c=relaxed/simple;
	bh=1GWnebf1RseokuzDNIRYp9kcCK6IFAGQqftyfp2LbRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXpLvfR+4h4CajYcVIHYWr8F+krB64oFJfSLmCzSmRQuRtD332AMuVHU5M8MGkmKcZeBgSCFkoUfFClJPobe2DFwlfQImn9dFpoUriGiZ8pQN8hEHfyqLhw3nzTgqF2w8U5vlveWBjsusJ9JFHthsYlTYZC8XrrCAssP+VTYai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTrgBm2T; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d88c0f8e79so3410216a91.3;
        Mon, 16 Sep 2024 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475902; x=1727080702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CbAkhRFpMG7Fo3UG18L+3urLiEiB2ud6hTuHn6KKs4=;
        b=jTrgBm2Tm7AlOZ2DPCKTlqAUo4tz3wzI6fKrgWIw6TKm+wrq9n0e8hpeavKWDD1FoJ
         LkSaswczfcrcCc62xYYlMk4sjzuHba8lQgZpGX8R4XHKc8n/x67edHDSbxb37crkWW4U
         Na4KmO2nOePeyQQHrS50M80aeiY2AhIRbSYcHaVRrDZO2+3MotjT5R08w0cnTqwOSrD3
         PcPWDlsbeIM416hmzR2bP/OVdetYveyWX/0fxuujAQJRN/BfgptKGkjQsKsMdBNjTnS2
         QyuvqNOjMyf+9r9PWk2T8JGjWOhkR0HlrW4+0dZH7Bg4YCaKMwE5diXlzN2Y3IvX7au4
         n4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475902; x=1727080702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CbAkhRFpMG7Fo3UG18L+3urLiEiB2ud6hTuHn6KKs4=;
        b=sSuOACanlulT+22YO1Vlb9z88GznSTWXKyRy7kI7+MXU/qEOjQ9v6KMRRGliD1Y4lx
         TIVFSLDFo1ivgmU1G4LKJKgaPskTcR8+7C2HN2I6sF4V8ucwMgHhTSQ3Z7CG4qih++kD
         SHDZbgUaeuWoisncxxAYG0DTFZB6WnzjJ0h6VC2QJixirD+7bj7b3dC8nAqHarJQwpf0
         gk8xehdjufIiW7IXEISXm2KngVSNHvnzzlDuobFrnlnrLSG1MFLCBq4zsq61yVj3BIn0
         Pjcat12ju4ABMF6Dqn14cPcF07KWTvscd4dIvB+cYMPGHfFGbqbH0q4DbHg56n8Ae7CW
         yHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpztptJStU2sYS5k6Wk6y1GDYOqaIZR4AJwSJBnCHJmbFHSA40VYPW0WuLcIGILVc/9QBgTIVFKIKZTMrNZv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/cLxX+Jd/CRBlZ6QZhXBCjD5T0CR8SE48ijL/aR8E0NIELp7
	2RNTZW26kFPqVKAgq+1k7ntksR+sZr6W5lAADTRsropEndMJTqeZmCDx2A==
X-Google-Smtp-Source: AGHT+IG9KLR0Y7gzkspYeTwZM1q5XFCWZTSrVQY1b+FxMUDAta0qHJup12q4I+6fL3ZFWN066WNchw==
X-Received: by 2002:a17:90a:1bca:b0:2d8:7a29:838f with SMTP id 98e67ed59e1d1-2db9ff901bamr17520774a91.10.1726475902374;
        Mon, 16 Sep 2024 01:38:22 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:38:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/8] libbpf: Fix output .symtab byte-order during linking
Date: Mon, 16 Sep 2024 01:37:42 -0700
Message-Id: <87868bfeccf3f51aec61260073f8778e9077050a.1726475448.git.tony.ambardar@gmail.com>
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

Object linking output data uses the default ELF_T_BYTE type for '.symtab'
section data, which disables any libelf-based translation. Explicitly set
the ELF_T_SYM type for output to restore libelf's byte-order conversion,
noting that input '.symtab' data is already correctly translated.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/linker.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index e0005c6ade88..6985ab0f1ca9 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -396,6 +396,8 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
 		pr_warn_elf("failed to create SYMTAB data");
 		return -EINVAL;
 	}
+	/* Ensure libelf translates byte-order of symbol records */
+	sec->data->d_type = ELF_T_SYM;
 
 	str_off = strset__add_str(linker->strtab_strs, sec->sec_name);
 	if (str_off < 0)
-- 
2.34.1


