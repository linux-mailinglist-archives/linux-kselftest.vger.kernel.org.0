Return-Path: <linux-kselftest+bounces-30368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0AA814AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AD88863DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3A23E338;
	Tue,  8 Apr 2025 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzK+xfLR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F8235374;
	Tue,  8 Apr 2025 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137180; cv=none; b=ZwbIsc3wSPQgGyEV0cgClwLiHIniFWJoNfnUmgOG6THLIL3ay29ELvYTX5z20A4q8cRyLTn5lvwWu8S3E0OPducV+j4Uk8Ak+14vJHyRDu2snQcXq4yfnj8yT5BCbnC4MNgvyvrP4wJJTDv4XBL3rTDZYBchNMHM/yhXXLujSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137180; c=relaxed/simple;
	bh=cz0sFymjpfC/h77fzceNQsL/NvczhkEObHLXu7XO1kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDNPqP3A92YuXn3w/2sIjHJSgxleSJOYjxxVd+jOYb3NFYMRN0TJpuQir7vIv28uCsLoksrKt5ndP8aMn5cOHbLAVj0aShxjDcSgaBpkenPMUPFtop5RkFJ78oKeFl21Yd6rGMn8+nCNjDJmPiooyRRYsKVQD9rxZwciomQuJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzK+xfLR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2295d78b433so59274235ad.2;
        Tue, 08 Apr 2025 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744137178; x=1744741978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsXm6MV5K5BRVbJnpoBwjC4UXp/lFGi2onPtWmwIMd4=;
        b=dzK+xfLRa7wxYJ0LfdmytMFM4VZ3X28FogVVWRspPQitkXLPa1llfD5Dkwgf/l1rji
         bPCOc/YDkBxjnIyj30wj/SWovLmvelD79r1E3Zdlb0/FWYD7hRn3GrABNaqzdbBfRJe3
         GGh3tL9In8pFty7AET0TTcapswFSS4Er+Q4C7oxQ1GZLeq1ZCR0quBkzhZVupur1YfhX
         xdw1koCnSXSiftqcl1q7ltHHyjrqBeyk4Arn3z13ALt4IdMda1v6fHD2qOLx15SriZHL
         vm6MlU2oDApzWXcDD4TIFH9NTAcChZpbim7cfK029+/0V9s0FlynIdMNMQWfP6tqbzyX
         DD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137178; x=1744741978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsXm6MV5K5BRVbJnpoBwjC4UXp/lFGi2onPtWmwIMd4=;
        b=YrtRcqUZGWmytxZvdVA8DZk98ph4SLtX0p+McpA44G70OlGdbyOsxVMlFhAl+3QIte
         Fw8uEU0Q4LVQ7/h2yKwEfz1YbTz5RkYMZ0v+jNOUMgHzzsL61EckDRxuocqewDo4LMVV
         Kl/r/+V0LdxKIE6D0YObI0kPG51CW6Yw1TgfkKzeE7gVZkXUu2fCsDqJ4vFToZ9R6HAd
         dHs2fTbT6cq/vpRBhbLEjHiQpi9HVBVVdn6Rajz37w8wrYUSL4riWkj/Mwqybyf6xF8s
         2VoAS6DLFhE/jlXc/OpZ6Uy6S1icPfvJYoS415wQrYksXlZKkBbbHBxfPJlW0uJ0PiNR
         Y7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ31foE3Kpasz0wVc7wum5YiGJjm+qpcIilWaeza7ny1j67c9YalvyvyojCOEEg7cLeKg=@vger.kernel.org, AJvYcCVY60Z5xYY031PRv1UPjlPeS5sax/J6jm5PV4fVUbR5pWK2Zja+sEN9qQFgUCVvc4zbVm/PrxPccEFtkDS5NPB1@vger.kernel.org, AJvYcCWwaIPwPB3Q0bMme7LL2g8qkg2IF2qP00rVqu0z4qPghs8GPgoaaIVuIT1x7+vwPQHf9HL9azY4OAQiUvFw@vger.kernel.org
X-Gm-Message-State: AOJu0YzygH8xQAPSC2GDYgmJw/NQ6zlGxoCrRyZAECsmqnRovwNKxadl
	ysuPdb7IVustweK4MnyexgfYTYn++fA3niOB8hSUJWzhyISe+T1s
X-Gm-Gg: ASbGncs/L8B1XhhFBIw8IEt0U9vaPYKme92CRthTWpOt3LAiMcnCXfX0kA0p2ZhLCEn
	X+anCRgpIrIyJlHTzMxnfQyYta+HZz2GgexzSdvGOHpE9dCXMCJ08wNG2x/XaJfT6ieDgbUg6D1
	j3HdUFFUMl4dn75+9P7/HAZhX8A/vZzWwu6tG/pbhK9umnwHmow0TwXhpfwen5uDAa98y2+LNLf
	9/e4qlhuKVSVoGdwyWOuYgOJtPcDsc/PBbZBTWtQgAGlmm6Ykd2DPEhwO9PU25d1zHwRVOm4PWB
	j08U+sx33VoKQweHi1c595flQ+Z4+GjZbBknXdeGyYB06w6tqSoU3XLJCgG2dLOqK259hw/kUWP
	wqOnEHlsvCBV3r6At
X-Google-Smtp-Source: AGHT+IFFgN7WMzBD5HsfPDqJ2wUPAWRl9kp6owNScncUOYS4nasPvN1eVgLjKMFFQTsakeZjjrHQxg==
X-Received: by 2002:a17:902:f686:b0:223:faf5:c82 with SMTP id d9443c01a7336-22ac295cfe8mr2454945ad.8.1744137177911;
        Tue, 08 Apr 2025 11:32:57 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865fa98sm103806325ad.140.2025.04.08.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:32:57 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: houtao@huaweicloud.com
Cc: Malaya Kumar Rout <malayarout91@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH RESEND bpf-next v2] selftests/bpf: close the file descriptor to avoid resource leaks
Date: Wed,  9 Apr 2025 00:01:40 +0530
Message-ID: <20250408183214.6437-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <92596c82-4a12-3afc-6cb2-21a11bef3739@huaweicloud.com>
References: <92596c82-4a12-3afc-6cb2-21a11bef3739@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static Analyis for bench_htab_mem.c with cppcheck:error
tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
error: Resource leak: fd [resourceLeak]
tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
error: Resource leak: tc [resourceLeak]

fix the issue  by closing the file descriptor (fd & tc) when
read & fgets operation fails.

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
index 926ee822143e..297e32390cd1 100644
--- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	}
 
 	got = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
 	if (got <= 0) {
 		*value = 0;
 		return;
@@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	buf[got] = 0;
 
 	*value = strtoull(buf, NULL, 0);
-
-	close(fd);
 }
 
 static void htab_mem_measure(struct bench_res *res)
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..10a0ab954b8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -37,8 +37,10 @@ configure_stack(void)
 	tc = popen("tc -V", "r");
 	if (CHECK_FAIL(!tc))
 		return false;
-	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
+		pclose(tc);
 		return false;
+	}
 	if (strstr(tc_version, ", libbpf "))
 		prog = "test_sk_assign_libbpf.bpf.o";
 	else
-- 
2.43.0


