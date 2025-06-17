Return-Path: <linux-kselftest+bounces-35238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA619ADDF7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A918826D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5852BD022;
	Tue, 17 Jun 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMyvJl/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0129B8E4;
	Tue, 17 Jun 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202333; cv=none; b=XO/BpflQ5zXFJM9Sm9IyNrFhcZqAYRoogbq7ErLmAF7P02iay9Y6F650sB1O/QWFB2eKKupMqSY9epNyzuZIV4D8hUryrusYIoyZq1iC08VttbqLVUi+B54z2qqLi13IfQn17NWb0ECiADpAj09JX3v5R0dr7K8AkAvDjGTKjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202333; c=relaxed/simple;
	bh=Gyd89FC9CmOQQ8A+9ZkRn5DKNiKCa70YaSK3DDh1WpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcF5oGAax1zGdheSeakhqEzno5fvoLYD/e6ear3AAc5JCsjjtwbByli+aZC7iUbLS8JKjfHC+a/vxRQiEmudC2UbK/bAvDNwW2e5nDc1S5SvYVQCQqwVW9zXh3t0LNmyiOtvjqD+HMFTAjK3UXH/nI6sIe+J+ZiUE8ontgmaZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMyvJl/c; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso53709266d6.2;
        Tue, 17 Jun 2025 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750202331; x=1750807131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m2i072eY2V/Lpj23ft0PYlJ1QdWWASrOKZEzo7QZKY=;
        b=BMyvJl/cEJCZyfc0QNIvBZBEj9k6Ru1mdLWZT4AFiROEpaMK2iaOPiXg5gTpFZ4uYY
         8V3PNcwvUAQEr9QcLt/PqYc6XTDrnBaJhSZ9C1zN8yrzetGgj1WgVE4P6yuTDdrCQHwy
         Sh7aYZmjJGSzRNPCdHKxZMMvXaGtJsVvxcfNxkQ7r8yIgFKkSEac2RWZ5jNfrgE3asvk
         zo6R8BRJi77Fzo7po2qSYdJFtKJVy9Jo8gNUo2Ap6Flu7Vb7o0N6yE3HA200fkV5tiHm
         9h2+Me481PzkCzoKgHAI15XoK6Cqtkb6d6xBt+FsncYzDiQA1aGrxuRsqecCCseJ4MWV
         aTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750202331; x=1750807131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m2i072eY2V/Lpj23ft0PYlJ1QdWWASrOKZEzo7QZKY=;
        b=u69eXK6Jp2UwJvu4RKW7mwC+D10ICqkcnOOw8NWpi/uptgtyn5RJ3c/gLY1KtS2ka5
         JGRLmVJwiWQQxj6ebPgzwpsDfLu15WnCO3L8Q84k6mTefJEYeURuQ6CccUtbQXSyk/Es
         oHn8VEWChGlFBGWyfb4YTqIhyFVzv3TVKdFASzLNci4xx4+uHsPBKUIJv77CJNJtlcGV
         7gRXblDreXAjBtEh57P7xsKLIxB0cON1eGp6t7D+2BVFDY/HRZbBa12OEyCou0yI6bqA
         DDA8NCtpdee3hu9sh1QYe8m4qDe3ZFgSXp1VVK3lzUB/tlkh97CqZUJZEQcK0QcYBEdj
         Opxg==
X-Forwarded-Encrypted: i=1; AJvYcCUTkyXDLK0Er1PIB7TWVSTdEaBa7RTIYk5pCUtAyBdY52Q1i0LGbKgC5IfpACfPwROVgk8guSbVOWTubDJl@vger.kernel.org, AJvYcCVqPEbR3ojrFt4PQOQUWRX/GUdcBieaThgTIvbvjLRjrL2LY7+AUz//0VFkzjoBMccMwcQ=@vger.kernel.org, AJvYcCWE/Ci+ph4i7BzE6195m+76bVPJ0URhb6mYhznkcxb/rAvfsID4RWPoZP8SXUDPrlYap6e1XmZ7hsqioP5328zk@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwJZBs7aaRa9jCQresv8YGlUFcoB5m6G9eut+WUcf+o/j7rx6
	Mz5bjajRGz/Hq0GvOjkKH78go+Ta5Al0WcENxGKn8Qmh7JL2tmBZR7Il
X-Gm-Gg: ASbGncvvGM+8B/eIf8eLjnGmEVZo3WEsrsLt/IMEiRkavvS0fgKCJCI1s2bfOgDQFKK
	5NXJcy+TOQrKUgwgvxdrv7Ia7D/SnWdGZ4+87WMJcLNtOm60Oa0B8XLiAeHX5C5XH4dkNrZkQGV
	NMze2va77wiSQrk6efBrP78GLlyshiZHinbsEZxwb1zj4VEp/WzYnih3P3WAURlY/HF8nwoTAc0
	jlNFJCfz71xCpF7kHWcV+qKSw6i2+nERNKBaCvqazEmbJ2kEyQiIT8LnLeaGilMmWnLq9caqhPN
	kl8KBJ71fy64aYs6zxvwAYjaOMTCN9SqetAu5NXcb7vjz1UGgDpSEiCpQAj499Tk3HAozYEb7tl
	6/Ibt/weorZBhyhdCzuxRGDb13LieqW5xGfGiBfNbPpXDLdtjdXhL98ToMxsB/qLPAgICTg==
X-Google-Smtp-Source: AGHT+IG4PL9CNIYyLFeVBaz5Sus/L9wLZ8/0wuS99owjWOyWj/GoiHW/J971fUutvNJBcNXOuyUCIA==
X-Received: by 2002:a05:6214:3203:b0:6fa:c22e:e56 with SMTP id 6a1803df08f44-6fb4762f4c6mr251792536d6.8.1750202331102;
        Tue, 17 Jun 2025 16:18:51 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb5db9f173sm12992576d6.14.2025.06.17.16.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:18:50 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Matan Shachnai <m.shachnai@gmail.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/bpf: Add testcases for BPF_ADD and BPF_SUB
Date: Tue, 17 Jun 2025 19:17:32 -0400
Message-ID: <20250617231733.181797-3-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit improves the precision in scalar(32)_min_max_add,
and scalar(32)_min_max_sub. The improvement in precision occurs in
cases when all outcomes overflow or underflow, respectively. This
commit adds selftests that exercise those cases.

Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 30e16153fdf1..20fb0fef5719 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1371,4 +1371,89 @@ __naked void mult_sign_ovf(void)
 	  __imm(bpf_skb_store_bytes)
 	: __clobber_all);
 }
+
+SEC("socket")
+__description("64-bit addition overflow, all outcomes overflow")
+__success __log_level(2)
+__msg("7: (0f) r5 += r3 {{.*}} R5_w=scalar(smin=0x800003d67e960f7d,umin=0x551ee3d67e960f7d,umax=0xc0149fffffffffff,smin32=0xfe960f7d,umin32=0x7e960f7d,var_off=(0x3d67e960f7d; 0xfffffc298169f082))")
+__retval(0)
+__naked void add64_ovf(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r3 = r0;"
+	"r4 = 0x950a43d67e960f7d ll;"
+	"r3 |= r4;"
+	"r5 = 0xc014a00000000000 ll;"
+	"r5 += r3;"
+	"r0 = 0;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit addition overflow, all outcomes overflow")
+__success __log_level(2)
+__msg("5: (0c) w5 += w3 {{.*}} R5_w=scalar(smin=umin=umin32=0x20130018,smax=umax=umax32=0x8000ffff,smin32=0x80000018,var_off=(0x18; 0xffffffe7))")
+__retval(0)
+__naked void add32_ovf(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r3 = r0;"
+	"w4 = 0xa0120018;"
+	"w3 |= w4;"
+	"w5 = 0x80010000;"
+	"w5 += w3;"
+	"r0 = 0;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("64-bit subtraction overflow, all outcomes underflow")
+__success __log_level(2)
+__msg("6: (1f) r3 -= r1 {{.*}} R3_w=scalar(umin=1,umax=0x8000000000000000)")
+__retval(0)
+__naked void sub64_ovf(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r2 = 0x8000000000000000 ll;"
+	"r1 |= r2;"
+	"r3 = 0x0;"
+	"r3 -= r1;"
+	"r0 = 0;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit subtraction overflow, all outcomes underflow")
+__success __log_level(2)
+__msg("5: (1c) w3 -= w1 {{.*}} R3_w=scalar(smin=umin=umin32=1,smax=umax=umax32=0x80000000,var_off=(0x0; 0xffffffff))")
+__retval(0)
+__naked void sub32_ovf(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"w2 = 0x80000000;"
+	"w1 |= w2;"
+	"r3 = 0x0;"
+	"w3 -= w1;"
+	"r0 = 0;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.45.2


