Return-Path: <linux-kselftest+bounces-2206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447C18188F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 14:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93F1288B03
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADFC1A27D;
	Tue, 19 Dec 2023 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI7sX6aA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88ED1BDF4;
	Tue, 19 Dec 2023 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6d93278bfbeso457388b3a.3;
        Tue, 19 Dec 2023 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702993852; x=1703598652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq1f1jBr4XkUyEUcj8yDFOYNMksjfFLPe3NKskOFWQA=;
        b=RI7sX6aArHRjZH77NdZumcIPQBo4sn9YK/QYORvTzLgn2BqVc4qb9iRbUq5SLt2iL1
         Z6SKWLaEubFiLyZY7/0oSAknmctNdD03r+IJJJTMO264UkXd1OVNZ6R5D8gb3yEQV4dv
         wJBi/vHtA/2xcbNoj5MeDyTvE7z9ozICkLP9/fkrtTJ0uKXA8ld+4MEN6otKMUH+CiI1
         E34SbF2RoWoONuKxozTxAHzgMZWF5Ru7PvcrCEF/DrGatyWmHuPFVeSrrMpkUPyhkOg/
         Y2fee7e7h8BEzWfvZvblrU+L65/cNjc418Xuo9VGd5aAxFTbSIkGZ7+IlxqlZEwVrUgx
         11iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993852; x=1703598652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq1f1jBr4XkUyEUcj8yDFOYNMksjfFLPe3NKskOFWQA=;
        b=Toqr9jHRobYhfjEma2GXVk0OVwZ+UvqAuNCt5HUYzpOLuNlUI/uwsJuEg/I0XYcr4h
         CbxP8bjjPwHVgSiZdi5Q/EnxfqHVEZxAo7WCTBs8ckDUMV3bF/UxmCZ0Ssmle1gmirta
         hneU8O+8XMGxq1awXLuvjKxZgXFjr3b6/HD1rH0SAmXkHzNJCTFmB4Vbg6rgpMmje8za
         rhbFvUX4YJeqTJwfVVat4Sy1ig/L3yVDto0KL8Pp1agwLG73P1StzeCdFyVaLGoVI6p1
         RWnr+cXDdM3bavw9Wfnk4zx/e2uxz84tCk0emwOmCE/ChSFSkQwxJyPOlC9Cv06UkUDr
         sY7g==
X-Gm-Message-State: AOJu0YzlT2RJoIdHFuT5YbiYpCIsY+Tz2YoHOBBY/iCB45wQ5i+uW8nq
	bljAEbU2vHaqCwi/v6i4mHU=
X-Google-Smtp-Source: AGHT+IFXUWRj9t/MbZUpJFBlRR3CykUJVbDUmllPXTpoY8VdVe8ynDBEYHT/rOywdbigHM8GB8DOqQ==
X-Received: by 2002:a05:6a00:2712:b0:6d3:fe2d:e37b with SMTP id x18-20020a056a00271200b006d3fe2de37bmr2129372pfv.10.1702993851870;
        Tue, 19 Dec 2023 05:50:51 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00245100b006cddecbf432sm20695264pfj.96.2023.12.19.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:50:51 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	menglong8.dong@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: activate the OP_NE logic in range_cond()
Date: Tue, 19 Dec 2023 21:47:59 +0800
Message-Id: <20231219134800.1550388-4-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219134800.1550388-1-menglong8.dong@gmail.com>
References: <20231219134800.1550388-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The edge range checking for the registers is supported by the verifier
now, so we can activate the extended logic in
tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to test
such logic.

Besides, I added some cases to the "crafted_cases" array for this logic.
These cases are mainly used to test the edge of the src reg and dst reg.

All reg bounds testings has passed in the SLOW_TESTS mode:

$ export SLOW_TESTS=1 && ./test_progs -t reg_bounds -j
Summary: 65/18959832 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
v5:
- add "{U32, U32, {0, U32_MAX}, {U32_MAX, U32_MAX}}"
v4:
- remove reduplicated s32 casting
v3:
- do some adjustment to the crafted cases that we added
v2:
- add some cases to the "crafted_cases"
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 3bf4ddd720a8..820d0bcfc474 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range x, struct range y,
 		*newy = range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b));
 		break;
 	case OP_NE:
-		/* generic case, can't derive more information */
-		*newx = range(t, x.a, x.b);
-		*newy = range(t, y.a, y.b);
-		break;
-
-		/* below extended logic is not supported by verifier just yet */
+		/* below logic is supported by the verifier now */
 		if (x.a == x.b && x.a == y.a) {
 			/* X is a constant matching left side of Y */
 			*newx = range(t, x.a, x.b);
@@ -2101,6 +2096,18 @@ static struct subtest_case crafted_cases[] = {
 	{S32, S64, {(u32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
 	{S32, S64, {0, 1}, {(u32)S32_MIN, (u32)S32_MIN}},
 	{S32, U32, {(u32)S32_MIN, (u32)S32_MIN}, {(u32)S32_MIN, (u32)S32_MIN}},
+
+	/* edge overlap testings for BPF_NE */
+	{U64, U64, {0, U64_MAX}, {U64_MAX, U64_MAX}},
+	{U64, U64, {0, U64_MAX}, {0, 0}},
+	{S64, U64, {S64_MIN, 0}, {S64_MIN, S64_MIN}},
+	{S64, U64, {S64_MIN, 0}, {0, 0}},
+	{S64, U64, {S64_MIN, S64_MAX}, {S64_MAX, S64_MAX}},
+	{U32, U32, {0, U32_MAX}, {0, 0}},
+	{U32, U32, {0, U32_MAX}, {U32_MAX, U32_MAX}},
+	{S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
+	{S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
+	{S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
 };
 
 /* Go over crafted hard-coded cases. This is fast, so we do it as part of
-- 
2.39.2


