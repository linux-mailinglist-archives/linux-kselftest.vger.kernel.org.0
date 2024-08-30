Return-Path: <linux-kselftest+bounces-16762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05169965883
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F81F221FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10A166F02;
	Fri, 30 Aug 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3CWSWa0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91C1607BB;
	Fri, 30 Aug 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003004; cv=none; b=AzNQU+lUnjQFi9Vgz40hMMxkkEXH7zXhBiqZAI6ZW647JI0/owyM/Pjc7g7O17ipzjfr/vUSv5bi5JL9nDh8n1bmIZ5zQfaxXjVS7lTplC76aREu6R2GTcjoT64i0uL93nkNRrxmkeFIw5k6LNmTR6xdtOWtgU3U2D+dDdi9IJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003004; c=relaxed/simple;
	bh=p+VcdB9HCA/6O6oQIVFwtXKCMYlajKRORAljsPWPaw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbSP8BZv8ptihCzwwOUoXq5g/fulflmZhPgNM7DKUNGomkvqeuio/CUGgNCrU/Ihtp3PNlA2ZD5mbT5MeqeHrUN820uLO3qv1e5vxNvJxSEb//QZGsbCYyFmrjMPiC/QCXH0UhCwnvfhxZY8SYbNsOammXB1RVQH71pfJoZuFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3CWSWa0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20227ba378eso13252255ad.0;
        Fri, 30 Aug 2024 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725003002; x=1725607802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=E3CWSWa0p3hALd/8ELtyoolhO5Otpizb46XB2wTA0hGe9v6dvyifhNK/cbSDEgoPQj
         juGQTqlwOua9kmOgh299NFm9bPfVc+v4qh7u4PL719NEFrMKgOfEM15O12NgxD3ZzJrT
         BEF6Iv7pg0QcsIp5P07Ajq6Xo2gGGo9/yVqYZZSiUXX8LYmYX1YK2VBUTe6NosPohN3j
         ptuJovfSU/lEm8N7eIej5W67jBxBeaBTITpy+00asr/ojB1Gcbht7aK+q4SDdyqRl8qv
         HdN/vDF1n2BTSYCUTf7Jwu8GB4l/8qXsfoN+KGsjNEzMjlfWT283KzbsuvQ7wZpYpd3P
         sApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003002; x=1725607802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DiB3vSoKAyJWAd5i8cP5vFqzZUUYpSQG/CLty7944A=;
        b=pGPjQoPg/U0bCtFcdPmTewaaGXrrZe16nUqUrtpRNbdiW7ech2kgIg3uVz0Y7zcwu1
         2EOM/fDfiA8Gi4upbTuXpCJPFIVtWQTzvB3R/GrsNA3E0SiJsCHcPbQ62ejHR4PRtMai
         iGWQgCNsb0NmDKo0pPUX1EJ9GLzC8TvEN+ZG4f+Dju+WhWy091pMGjDcHSS8Ow6tSVcp
         auFUmqrGm00XrMJnyMvPxYEQh47iAAqvGSjJqyQr9G4otyLLAxQwjg7IS+IuX8Lo9vu8
         WqDx/A2j2nLOUpCib190y0eT8J08oiYiMRGFXNj6NAxvYIVZFPgp3Juy4gpQSfsL+oHk
         OGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgk784W97QdB2ePO1OiBxPcAtgbpSAlVbtGD/onPM8MvCZWtIz1xDEO+kGmlihkrJHhyF5yZsIckZbj3zdhL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGIp1OVRgTrjuEoYJqqiuv146Rc/sb4Ddv+guLMAPybooSmtf
	tkBmNkHuvXV5/vEoNpbq+5GbaEu+JXQcZn6YvJzuVW3/KjQumtPln5aRYHnw
X-Google-Smtp-Source: AGHT+IFEUAuQssJkebXVGRRWusj9yjVzkcpoGUHA24SHz0QnN7F3fvrbb/FvnqH6OiwavNFDoWYqNA==
X-Received: by 2002:a17:902:ea0f:b0:203:bbc9:2b93 with SMTP id d9443c01a7336-2050c2060ddmr53824545ad.1.1725003002426;
        Fri, 30 Aug 2024 00:30:02 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:30:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/8] libbpf: Fix output .symtab byte-order during linking
Date: Fri, 30 Aug 2024 00:29:25 -0700
Message-Id: <5672557ebf511ff2231853fa306a36d280313165.1724976539.git.tony.ambardar@gmail.com>
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
index 9cd3d4109788..7489306cd6f7 100644
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


