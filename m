Return-Path: <linux-kselftest+bounces-6884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF8689240D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F2CB220A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD0139CE7;
	Fri, 29 Mar 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GA6bqvrv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A086130
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740000; cv=none; b=muzocmc4jyS93OtflEkEtCJeXRX2PbWRHhXt1itk+Z7fEay3MqnqCz2y9Xkl+jgNIYpV+wSKhd2fNFT0ea7OI7OHoNCgd5ezMp0zzZExQslVmRfwNXXyUxdQYZL1RIpPFzc+t51hzMqcghYBE4jOBSLlJc3WV01M9GMJV8sV77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740000; c=relaxed/simple;
	bh=11J1oF1EtXV1qtgpaShlOiZNJHDVgqvSLoQIBQbUPeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cf7CFY+ghNyB6zbK8bzmgIpy1AM5FYHFzyEYH3d9coOEwpln2Nn5Cztv7U7LaRIab57G2q7LaIk6KImVxzKRsJ4If9phgSxS6JlqzhzlIwManLRg9TVeKtf214p+rlDwK+K2ZFrefNGZ8xEOv1bQ5PVKfJmGWfHPGt2UnNcnFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GA6bqvrv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-613f563def5so35463927b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711739997; x=1712344797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRiul2graw1bxh54kq90mvx6bUbLW8gw8FgM2SMnjyw=;
        b=GA6bqvrvlkpPAGnwuc8AHGv7kzB4KukeBwtnrYf4DXNf1IMSqcZkE3Ry6ABidbKQ37
         1FgQllKtYaoMM0tMUqkCSY1BtegKF5LPs+Y8QpbB8v59AUa646NDR+DzlXRHYCt60nqb
         ImGBXmkPQLK5kahMXZ+EHdE9x8nw5VobxUQ96bRFVgmkaagk5ldE1mU/VTJA9jPJ+AK+
         y735ofqcNYjJdPc3AfrWKMKZRhCz+Mj7W/Am26Atp7yTeHHF17rKJDuKkU6SC3nlGQ/9
         6R4bjjxyqsgEnt00Taq/lQfUoQj7mbBdifZXzERz+fPgQTwERkTMJTH+64A4FyK5lslV
         stAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739997; x=1712344797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRiul2graw1bxh54kq90mvx6bUbLW8gw8FgM2SMnjyw=;
        b=nCIV4+Ys+tBU4nq0fZBafYaEsQ1sl2dio9QTjjn4u23AMsWVvPipKKYIjoUGbWmBDb
         I3XbPiGMjn2byZRyWzgPcX7SmW9wOBUHGq0bjymz7pNee03G2iuEA3eSxbEXjQi+NDFD
         72Lp1WgJHQt8rNX0bHp143Sp3xjGEu+SsqSmFECanwnYIUwRu9z8TUOD3v2T3LSf/HDv
         XFTVn2y6UqJH9VOFP8NvhhQzqoFOjio9ncAl5ahviZMAXoujgLAddUMHB6VyUKDmvzmN
         XE5Z+ZlgmBi5kE8ugRrzl5rtKSAwxcj5uhbaLP59ROX0RThqSKUkq4CZXwP2V14wssRM
         4bOg==
X-Forwarded-Encrypted: i=1; AJvYcCXlU9iSDm6LqS/yDBw1ejufYfQBtrbUlgo3jFNCo9x7M1uaBszQyT14DeWQqFoguLaNQGYikK4gp+FcxnzFU2sk3hnA1o3DmnoArDT4AwzA
X-Gm-Message-State: AOJu0Yzu84SxNQ0SgfrkglVncvT/tCDV5FiswzGGNM6BdOnHhOXaPtLx
	XDEVVvpbXQ58IMLXvDK32bEaC1djker3zcnMBtcoDUJy5NMOYd1riunlEzdvHoRlaSrr4whlBg=
	=
X-Google-Smtp-Source: AGHT+IHRdLbvyHJnMHKtWdr+cFy6jSU0+diPw3ZFjoZcj2SJx21rEPQB79DhdlcNPoxtA68+qL8xQhArzw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a0d:d9c8:0:b0:613:eb1a:6407 with SMTP id
 b191-20020a0dd9c8000000b00613eb1a6407mr706881ywe.9.1711739997755; Fri, 29 Mar
 2024 12:19:57 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:47 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-3-jrife@google.com>
Subject: [PATCH v1 bpf-next 2/8] selftests/bpf: Add module load helpers
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch introduces a helpers used by the sock_addr_kern test program
that allow it to load and unload sock_addr_testmod.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/testing_helpers.c | 44 ++++++++++++++-----
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 28b6646662af6..16959a748d4b1 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -366,48 +366,68 @@ int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-int unload_bpf_testmod(bool verbose)
+static int unload_mod(char name[], bool verbose)
 {
 	if (kern_sync_rcu())
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
-	if (delete_module("bpf_testmod", 0)) {
+	if (delete_module(name, 0)) {
 		if (errno == ENOENT) {
 			if (verbose)
-				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
+				fprintf(stdout, "%s is already unloaded.\n", name);
 			return -1;
 		}
-		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to unload %so from kernel: %d\n", name, -errno);
 		return -1;
 	}
 	if (verbose)
-		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully unloaded %s.\n", name);
 	return 0;
 }
 
-int load_bpf_testmod(bool verbose)
+int unload_bpf_testmod(bool verbose)
+{
+	return unload_mod("bpf_testmod", verbose);
+}
+
+int unload_bpf_sock_addr_testmod(bool verbose)
+{
+	return unload_mod("sock_addr_testmod", verbose);
+}
+
+static int load_mod(const char *name, const char *param_values, bool verbose)
 {
 	int fd;
 
 	if (verbose)
-		fprintf(stdout, "Loading bpf_testmod.ko...\n");
+		fprintf(stdout, "Loading %s...\n", name);
 
-	fd = open("bpf_testmod.ko", O_RDONLY);
+	fd = open(name, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		fprintf(stdout, "Can't find %s kernel module: %d\n", name, -errno);
 		return -ENOENT;
 	}
-	if (finit_module(fd, "", 0)) {
-		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+	if (finit_module(fd, param_values, 0)) {
+		fprintf(stdout, "Failed to load %s into the kernel: %d\n", name, -errno);
 		close(fd);
 		return -EINVAL;
 	}
 	close(fd);
 
 	if (verbose)
-		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully loaded %s.\n", name);
 	return 0;
 }
 
+int load_bpf_testmod(bool verbose)
+{
+	return load_mod("bpf_testmod.ko", "", verbose);
+}
+
+int load_bpf_sock_addr_testmod(const char *param_values, bool verbose)
+{
+	return load_mod("sock_addr_testmod.ko", param_values, verbose);
+}
+
 /*
  * Trigger synchronize_rcu() in kernel.
  */
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d55f6ab124338..d553baa01d597 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -34,7 +34,9 @@ int parse_test_list_file(const char *path,
 
 __u64 read_perf_max_sample_freq(void);
 int load_bpf_testmod(bool verbose);
+int load_bpf_sock_addr_testmod(const char *param_values, bool verbose);
 int unload_bpf_testmod(bool verbose);
+int unload_bpf_sock_addr_testmod(bool verbose);
 int kern_sync_rcu(void);
 int finit_module(int fd, const char *param_values, int flags);
 int delete_module(const char *name, int flags);
-- 
2.44.0.478.gd926399ef9-goog


