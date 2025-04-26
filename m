Return-Path: <linux-kselftest+bounces-31714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E3A9DC13
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046835A4D9F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA925D547;
	Sat, 26 Apr 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqV4E8Hm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D151F7580;
	Sat, 26 Apr 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683273; cv=none; b=ZN0AVIf43yG9gXUyM77XhZUngdQ1J8uWLvjZSrHw4LUHoaMsJSxXKfZZZtIjNO9RWZa9K5LBZMC8dD8IAsQM8fzExFDkeMlr8vkiY1l1v//dkWSqUcB9/fwG82sS3ZOh0lv+ZgV3YfU1LZA38isrC63Ncoade9TYJVSMEjTSUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683273; c=relaxed/simple;
	bh=sYrYwmNXEWJvhSrFZ7do9MRllwHp0cTWhXCq5TJG9ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvFm5XZtxRM33IvFxgtQsi+or7vfzYj5qbxxZgazOdPhTwu2DNIxOuzqUPOuSCLNUqE2ldkY1gFzw1GEmuuwzMCl547wYxrAsAocnUNfGPx3tbzv4FsxwjUrnBCmrFaMsa257lpC4s6QYbs6nt6HxcRrtykKQVCHZUbDSWJVTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqV4E8Hm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736bfa487c3so2787608b3a.1;
        Sat, 26 Apr 2025 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745683270; x=1746288070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfrHPL8SYej58F/66Eqqubx6STs/vpsTKaIaiNl+Q5w=;
        b=mqV4E8HmV030JWD+fsnbSR4bsJOn+idzgnWewmGPDfzaFvicZB+ie6wSkPtgGFtnfp
         nWt2CE13+lDzY9whWFd663VX/FxJSSroxPZjEkARJMloTKqj771R/rv4Ilp1j3EhanSG
         j1QEe2DKMKIb2HJ7krdlr0s04hjq38rzl9E0v65XvrT65bqbWJDgeLqgg5GY4HjHeq8T
         jIV7wq8i+MBf6DU0QtrTnQoHhLMekrGzoimukFwKQPQVPWKn81nGkgZsX9XSegYwFlrW
         YhxTUawIWg+bg844Yi6vAlaa1tL2Vm+Vkceynw9IIAgzp/RVBNxIPhNSiA8SmwYBWyQ+
         JcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745683270; x=1746288070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfrHPL8SYej58F/66Eqqubx6STs/vpsTKaIaiNl+Q5w=;
        b=LWiIEtqnrPSq2GjeBV1CtWRGnbVyzkXiSPqVwrJcbiU/me3Yz+SrAIuo77TLA2lkuY
         tyBavKuHbqlBESDx1y0q/UI9+VtrMSql9/aqzUQFBWFKDQ2nryzBLU5puQBVM3TLtnB3
         k0ZMr7XChhhRj8Pvx31HdDD09YQ06FjUXW0w0HrPg/WJ4Zmtflt66BozdGQ+Hmo4JVP+
         9HWe2EhDFx0khdPhq3MK4md8nYQhZVLijjIOwCRmzQtk9/hIHBXpg3OO2y5db/EtIhQl
         t/RqTq8EBC9r34sxMTCGgaHkS6+fOi8H5dXayZYDdu0Og28IM/TWmYoR6FXGkufLwIRh
         vJPA==
X-Forwarded-Encrypted: i=1; AJvYcCUeX71H2ZFpNZTldRwhg82IjYJFClviHVvwAYpVJxV+qkBonkJsj4v7yKrykvgsfA7T+KQkDom/TeuIflPZKxbCmrRy@vger.kernel.org, AJvYcCV9Qr17eGmd+4Kte8TkUiChX2zGbD1LNw86AN9w2KX/CxFGSngBfSYD4Qn8+eNiuauAY+0=@vger.kernel.org, AJvYcCVuiCkbv1gQ9QWLnTfF02wukpqSE14+TBzxkYJ5zuKajAuAgR2PgRmE0YGQZWHOgUP5OK7lOHWxQ3vfdwH+8HmT@vger.kernel.org, AJvYcCXiUS7WTirqWpN23iiITO8ARE91ScMZ6CtXoAfeF01iXYM2tPHXOtRd5/rPv3PlrVLsUPjKd8c4@vger.kernel.org
X-Gm-Message-State: AOJu0YytXKP7SaA8Ll7vrbJxu3lrabqaCxtDIVbtz9aWMmLT70bvxjPS
	r/2/VuOQv+kO+1+UJeE8JBzP/3Palc8FkrVUO6Y8+1mj0uI1zmKG
X-Gm-Gg: ASbGncv/5TzcKeehAn1PzwY/RIaNdJ2StvdO5VngVeRZJkZTG4ORPYJQ8ztZjWzbCbM
	hzpEG+CNtDBDTyguh94/Gfzc1AqhKr5Xa0GjhYDoHXSFSBaWBGNsSZ7kcr4yne051fsud6G7Lr1
	2q+Gz/Egk+H2RJsCxso4BZR905QUY2ARXCImEY0+wYYsJPeizrWjDETZ2GuGR4XuS0HiPpwiZQP
	reGnUineo0U4ow+D5frZ2K787z/hYsOlHS1o99ciOy4Zx4g8J7Oit8tgHJyVKU690DZeGWC+zFt
	HQkNuT/MC0SdBj1P+7tBnL3g79RWHg4HF59vkvM19PQ=
X-Google-Smtp-Source: AGHT+IHH8JmPF6Bo5KLrR6mlou2ajWs07pw1O7Jy5rpnCnPvYOD74bRAZa77Qqju+OGMCRCnUbkf+g==
X-Received: by 2002:a05:6a20:12d1:b0:1f5:769a:a4be with SMTP id adf61e73a8af0-2046a6f41d4mr5051483637.36.1745683269931;
        Sat, 26 Apr 2025 09:01:09 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941cc1sm5174760b3a.60.2025.04.26.09.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:01:09 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev,
	mannkafai@gmail.com
Subject: [PATCH bpf-next 3/4] selftests/bpf: Add raw_tp_test_run for tp_btf
Date: Sun, 27 Apr 2025 00:00:26 +0800
Message-ID: <20250426160027.177173-4-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426160027.177173-1-mannkafai@gmail.com>
References: <20250426160027.177173-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test runs test_run for tp_btf base on raw_tp.

Changing test_raw_tp_test_run to test both raw_tp and tp_btf.

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 .../selftests/bpf/prog_tests/raw_tp_test_run.c | 18 ++++++++++++++++--
 .../selftests/bpf/progs/test_raw_tp_test_run.c | 16 +++++++++++++---
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
index fe5b8fae2c36..e2968a1e73bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
@@ -5,7 +5,7 @@
 #include "bpf/libbpf_internal.h"
 #include "test_raw_tp_test_run.skel.h"
 
-void test_raw_tp_test_run(void)
+static void test_raw_tp(bool is_tp_btf)
 {
 	int comm_fd = -1, err, nr_online, i, prog_fd;
 	__u64 args[2] = {0x1234ULL, 0x5678ULL};
@@ -28,6 +28,9 @@ void test_raw_tp_test_run(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		goto cleanup;
 
+	bpf_program__set_autoattach(skel->progs.rename_tp_btf, is_tp_btf);
+	bpf_program__set_autoattach(skel->progs.rename_raw_tp, !is_tp_btf);
+
 	err = test_raw_tp_test_run__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto cleanup;
@@ -42,7 +45,10 @@ void test_raw_tp_test_run(void)
 	ASSERT_NEQ(skel->bss->count, 0, "check_count");
 	ASSERT_EQ(skel->data->on_cpu, 0xffffffff, "check_on_cpu");
 
-	prog_fd = bpf_program__fd(skel->progs.rename);
+	if (is_tp_btf)
+		prog_fd = bpf_program__fd(skel->progs.rename_tp_btf);
+	else
+		prog_fd = bpf_program__fd(skel->progs.rename_raw_tp);
 	opts.ctx_in = args;
 	opts.ctx_size_in = sizeof(__u64);
 
@@ -84,3 +90,11 @@ void test_raw_tp_test_run(void)
 	test_raw_tp_test_run__destroy(skel);
 	free(online);
 }
+
+void test_raw_tp_test_run(void)
+{
+	if (test__start_subtest("raw_tp"))
+		test_raw_tp(false);
+	if (test__start_subtest("tp_btf"))
+		test_raw_tp(true);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_raw_tp_test_run.c b/tools/testing/selftests/bpf/progs/test_raw_tp_test_run.c
index 4c63cc87b9d0..ddc22e6cfdd9 100644
--- a/tools/testing/selftests/bpf/progs/test_raw_tp_test_run.c
+++ b/tools/testing/selftests/bpf/progs/test_raw_tp_test_run.c
@@ -8,10 +8,8 @@
 __u32 count = 0;
 __u32 on_cpu = 0xffffffff;
 
-SEC("raw_tp/task_rename")
-int BPF_PROG(rename, struct task_struct *task, char *comm)
+static __always_inline int check_test_run(struct task_struct *task, char *comm)
 {
-
 	count++;
 	if ((__u64) task == 0x1234ULL && (__u64) comm == 0x5678ULL) {
 		on_cpu = bpf_get_smp_processor_id();
@@ -21,4 +19,16 @@ int BPF_PROG(rename, struct task_struct *task, char *comm)
 	return 0;
 }
 
+SEC("raw_tp/task_rename")
+int BPF_PROG(rename_raw_tp, struct task_struct *task, char *comm)
+{
+	return check_test_run(task, comm);
+}
+
+SEC("tp_btf/task_rename")
+int BPF_PROG(rename_tp_btf, struct task_struct *task, char *comm)
+{
+	return check_test_run(task, comm);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


