Return-Path: <linux-kselftest+bounces-47268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE732CAD395
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 14:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67C08302C4DC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F33313535;
	Mon,  8 Dec 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="plP4iKYD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D42EA172;
	Mon,  8 Dec 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199772; cv=none; b=QAbeOblYzt6Up9DAxECkejyPWQh5WHWQhGutbr8YsgndzuL12b3ZcYPHF65OTc1Je8HsC//kXIyeBkSPOTTvaIsLX6L6lIpITpycLQaAMWovpfyw3bISLeGlyX9yxI+VRiesOH8WN7y20QlmoSEXxyVOuNPcH7DULoo6fQKkx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199772; c=relaxed/simple;
	bh=k8krsWT/x0GUv66MZcxXLZX2sPNCof4Ugeu0Wu3by4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzTor4gIEZQS0G4Lj1XOseXtsp2alS8QZlmtEn+04bEONMdw/1HMtL78ImjcTx7jIB+o0e2m/u4jAgOf+AO4NItlvn2Qqs33BGYltytQN8NeAKTXMJ2A9/Ir4XU/5VUCrni1IaielPS/uOSjuzU4NGjc8fRHrG6Oo2L6wMuLBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=plP4iKYD; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765199771; x=1796735771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I9rd1qnxgT5n1V9dbFcwzJdspGNvNKAJ3jsGytQQ6BM=;
  b=plP4iKYD3mMlIMec5HsQ4/dLire32azSwoYC7PuWwQR3NN9JcGTng5n3
   JewgfaoxZQ2+bgNKwaIaLeUsDNkk/hbJ4XGnOhpB69kTjtDH+LHu2Yvhm
   2fL+/3Tgq95YOxdnrUGu3IKPYpSkIwsqvWQqPUNCEjnWkTQOKZPuNusOB
   NoRQ6RmfUtp90gdq2ADJy+9B7acAsiMjS4MDp6N/05xC+l913XeWSruDN
   lBzCjsvWF1Vx+bSojgWYLE1BAsOSlSEApXXUjVIiJNxGKVP9GcLm60i5z
   /T3DFW63bD3EmzKzevzy320Hmoe1fG100za1mq9FCjcfZW01OJ2EVnjQ3
   g==;
X-CSE-ConnectionGUID: rrhCpM48TZi2aJTlBbfWyw==
X-CSE-MsgGUID: asNdWjQPT3WkkxwJKju5cQ==
X-IronPort-AV: E=Sophos;i="6.20,258,1758585600"; 
   d="scan'208";a="8652624"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 13:16:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:8667]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.201:2525] with esmtp (Farcaster)
 id 87279090-16cc-4b35-b6f3-e6a1687c057e; Mon, 8 Dec 2025 13:16:08 +0000 (UTC)
X-Farcaster-Flow-ID: 87279090-16cc-4b35-b6f3-e6a1687c057e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 13:16:04 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 13:16:01 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, <kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for attaching invalid fd
Date: Mon, 8 Dec 2025 22:14:32 +0900
Message-ID: <20251208131449.73036-3-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251208131449.73036-1-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add test cases for situations where adding the following types of file
descriptors to a cpumap entry should fail:
- Non-BPF file descriptor (expect -EINVAL)
- Nonexistent file descriptor (expect -EBADF)

Also tighten the assertion for the expected error when adding a
non-BPF_XDP_CPUMAP program to a cpumap entry.

Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 .../bpf/prog_tests/xdp_cpumap_attach.c        | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index df27535995af..ad56e4370ce3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -18,7 +18,7 @@ static void test_xdp_with_cpumap_helpers(void)
 	struct bpf_cpumap_val val = {
 		.qsize = 192,
 	};
-	int err, prog_fd, prog_redir_fd, map_fd;
+	int err, prog_fd, prog_redir_fd, map_fd, bad_fd;
 	struct nstoken *nstoken = NULL;
 	__u32 idx = 0;
 
@@ -79,7 +79,22 @@ static void test_xdp_with_cpumap_helpers(void)
 	val.qsize = 192;
 	val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
 	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
-	ASSERT_NEQ(err, 0, "Add non-BPF_XDP_CPUMAP program to cpumap entry");
+	ASSERT_EQ(err, -EINVAL, "Add non-BPF_XDP_CPUMAP program to cpumap entry");
+
+	/* Try to attach non-BPF file descriptor */
+	bad_fd = open("/dev/null", O_RDONLY);
+	ASSERT_GE(bad_fd, 0, "Open /dev/null for non-BPF fd");
+
+	val.bpf_prog.fd = bad_fd;
+	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
+	ASSERT_EQ(err, -EINVAL, "Add non-BPF fd to cpumap entry");
+
+	/* Try to attach nonexistent file descriptor */
+	err = close(bad_fd);
+	ASSERT_EQ(err, 0, "Close non-BPF fd for nonexistent fd");
+
+	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
+	ASSERT_EQ(err, -EBADF, "Add nonexistent fd to cpumap entry");
 
 	/* Try to attach BPF_XDP program with frags to cpumap when we have
 	 * already loaded a BPF_XDP program on the map
-- 
2.51.0


