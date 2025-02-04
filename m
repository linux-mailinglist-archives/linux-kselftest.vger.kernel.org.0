Return-Path: <linux-kselftest+bounces-25638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A830EA26A12
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 03:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9D3A4A45
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332013E02D;
	Tue,  4 Feb 2025 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffGO+QGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE432200CB;
	Tue,  4 Feb 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636801; cv=none; b=HzG0A4IO89hqeJdQ1aku7P8JuKhOIiJBbRT0a+tRuonlDk4PMp7acf0QbLbfHnXKwBMgFgE9GaAQgXNnJHQg/cSa8gwFECUGPnB3YnKg/+lcIgjxm47yTryfoGW49tMToZuuSUo6f9Sh9baTotkfTjiIqRtKBiUnPndKQQfGMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636801; c=relaxed/simple;
	bh=avwcFeE3v8/i9k5+AJviYJnHKxvA12H6thP4KvBglSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjQLltbdk6NWJB+k0bIP0o7CbwDK5xdwOj5upDuUAxETZk9iv2Tiolou+WN0ulbyKfKxSCcpVAgSxZEjMxAPG3uDBH9uQ/SPUFce/ASYJVvo6kuM2WVqn6e10PBNPTiZruvBXeI2uFPtekFBmFkDYxC8HAg/+4c5dUTS+x/dWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffGO+QGI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166360285dso84266605ad.1;
        Mon, 03 Feb 2025 18:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738636799; x=1739241599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRN6PqvA11EKemHsq0MfALu7b4UacC/g9PP9w/eqESA=;
        b=ffGO+QGIXKt7QmfcgsnwKIjhrE3QL2HK5V6b7cu7SjtUN3RDIvbwFGUMbWB5kFZ8w8
         jRvPklRillrwdNdSbzmIqzt0xygc8Cv5QWitgstQW19ujKl7T6YItleCZbrf7CwCaVDo
         CirsiC0RbQyMEKQGK+8DNvc6uy8cFYzfpy8hwfZ7MV48WeBPZ3etcK9LDp/yVOVevJha
         1QhQWnu5ySF2HTtZjOjvYRqWkvW9Dbxgq1daE5b3dkj7CavwzJq0PyyZ9Qe3meN2KclT
         0nEQGGjrqd3YOaG80aGC/9Rkx3l4WS3nt/oKUs3dr1cJ9IymBsbo4EW0/CLRBVgG/qn/
         YMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738636799; x=1739241599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRN6PqvA11EKemHsq0MfALu7b4UacC/g9PP9w/eqESA=;
        b=UpjXyRg8KFZuo35ATwpZrx1qW5wiSqwnMzGhayOhIV12KwMAyNPedMMavMKFXYAGLq
         aAAuM1ZQZCBHIRMihx+sDWJssix7v45BhWINRjgnCLbWRsxQ4EDst1qbSRIL1B8tAeNE
         H8RUE9DQ/GYqX677pj1aXlBt3aJkgtaRVIc+rr7pm/J5aJ4mX8PXy/5wZOt/ArE2eUAk
         3gWICw+1euUIFBbPSl5hhIBB9MUBciyCjF+ceUazU7Zgro4k0A8hb2D4/Ckhj+AKI6Lf
         6OQqGOEwN6WwRbKc4hi0IALxB2VfYmzc62+MheXbRzqnetTu3lCD68FWgXSF9SI25opq
         x4xA==
X-Forwarded-Encrypted: i=1; AJvYcCUfWFY7VZlV6sjeVWlXGhFct+ipXoG37NuyoaOWQK8LfmJZtyABWLxkKW1StSOSCfzBAGLrrOj0P/5V2nTzJnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+jWQvSIR7oVJtqFvlu/U98InCDzvMVChNBQ6U8JOuZI1ZIvA
	VI8ITi+9vJjFcdim/OKKoQXANybST+Bi8q+aHtFt46z9DZw1yWSo
X-Gm-Gg: ASbGncuHYCotRz/lB3pXs7QlXn9gBheGbHjKPdvc+nfeR5fvmGrEMf3LoQNrd+ro3fc
	eQugnmVQgsHh28JRocv2NFYgnfUjcTK4S1/kEYogv3RPpM6aYSOh1f3tzEzqbwOKBxL96MZ4Op/
	AEQ8zXPPHfLj14Kwie1WtTSsHmChnpRGvCzv/D8cGFQAxk7Y0y9rRZK7xpS6XSE0g7AftD40TLd
	Gua8H0I0SgcH1kOvTcH/U1gmhDfyBSehiq2SoH0PQlcdjPMR93LkAbI1n2MkGiR36TWObwJ5uMJ
	CgzPhd31UA1DYfZ+lJxMjLTpi2GoNPbgLfSiJw45VVzRYKJ4ySz+fQ==
X-Google-Smtp-Source: AGHT+IFu+1cGlh96TINRjRpDwQP+Wf3TOtTItMz9VsT/s+rEN5GXckcVbcc3u1X3DKPXKB4JwdWTxQ==
X-Received: by 2002:a05:6a00:3e06:b0:728:eb62:a132 with SMTP id d2e1a72fcca58-72fd0c679d9mr35134446b3a.15.1738636798762;
        Mon, 03 Feb 2025 18:39:58 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba44fsm9660492b3a.100.2025.02.03.18.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 18:39:58 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: changes_pkt_data: correct the 'main' error
Date: Tue,  4 Feb 2025 10:39:45 +0800
Message-Id: <20250204023946.16031-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204023946.16031-1-kerneljasonxing@gmail.com>
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiling the selftests, the following error is printed out:
selftests/bpf/prog_tests/changes_pkt_data.c: In function ‘test_aux’:
selftests/bpf/prog_tests/changes_pkt_data.c:22:27: error: ‘main’ is usually a function [-Werror=main]
  struct changes_pkt_data *main = NULL;
                           ^~~~

Fix it by replacing with 'main_data'.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 .../selftests/bpf/prog_tests/changes_pkt_data.c      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
index 7526de379081..b5c9031ec470 100644
--- a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
@@ -19,7 +19,7 @@ static void test_aux(const char *main_prog_name,
 	struct bpf_program *freplace_prog = NULL;
 	struct bpf_program *main_prog = NULL;
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
-	struct changes_pkt_data *main = NULL;
+	struct changes_pkt_data *main_data = NULL;
 	char log[16*1024];
 	int err;
 
@@ -27,14 +27,14 @@ static void test_aux(const char *main_prog_name,
 	opts.kernel_log_size = sizeof(log);
 	if (env.verbosity >= VERBOSE_SUPER)
 		opts.kernel_log_level = 1 | 2 | 4;
-	main = changes_pkt_data__open_opts(&opts);
-	if (!ASSERT_OK_PTR(main, "changes_pkt_data__open"))
+	main_data = changes_pkt_data__open_opts(&opts);
+	if (!ASSERT_OK_PTR(main_data, "changes_pkt_data__open"))
 		goto out;
-	main_prog = bpf_object__find_program_by_name(main->obj, main_prog_name);
+	main_prog = bpf_object__find_program_by_name(main_data->obj, main_prog_name);
 	if (!ASSERT_OK_PTR(main_prog, "main_prog"))
 		goto out;
 	bpf_program__set_autoload(main_prog, true);
-	err = changes_pkt_data__load(main);
+	err = changes_pkt_data__load(main_data);
 	print_verifier_log(log);
 	if (!ASSERT_OK(err, "changes_pkt_data__load"))
 		goto out;
@@ -60,7 +60,7 @@ static void test_aux(const char *main_prog_name,
 
 out:
 	changes_pkt_data_freplace__destroy(freplace);
-	changes_pkt_data__destroy(main);
+	changes_pkt_data__destroy(main_data);
 }
 
 /* There are two global subprograms in both changes_pkt_data.skel.h:
-- 
2.43.5


