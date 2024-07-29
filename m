Return-Path: <linux-kselftest+bounces-14360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8493EFCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C1D1F22CC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8463613D53F;
	Mon, 29 Jul 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bel8l+zF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826313C3CF;
	Mon, 29 Jul 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241252; cv=none; b=cEiJTUQT4L4w90xuLWyqNcZ5l/CXPG6eDI/dGTueGiJIJR9kL2nIyxZkRUkC+DWJt3tZ5Sd2gH/C6EJNBdVUpm4XFmSTukdENPlp5EO4HYrQ6xLycYmVHija2aPeqNSgjyD6FxB+XFQmO9qdp/Sc0RpllDSah8KiHUqRR3cD1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241252; c=relaxed/simple;
	bh=dhuUeMeg6A+6tpCx9Iav6D7D/rHdFvL/tF62fjAuDE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtDuVsHclOpJLkwC4yV1Om70f2PYsjvkQdk4+E4AxkylGohTLGeKgPnXxAJZj8puznbywx6l09atZFNb1A2mTdxE4kK5mxhmUXXZOZdBsxL7Z8kVxFwxGcHfm/ImXmV+xHuJAngcBqd3XafDTY28xXyV2T3EdXMNL4nJwGJ1FVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bel8l+zF; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBE2B60008;
	Mon, 29 Jul 2024 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722241242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXhPvfso1gEmmax+ETmwIuRk4s9Y1kZ7mG5mtrN6ID0=;
	b=bel8l+zFGKQDvazjMIF4BeA5Yutp3XjmQhMv3DMl7s8EwhzXdq/zMFEcKmIM+H0BpI6Dzh
	CzIOeu0w+Wn/ElbeMdFDjYj7aBwEx84iQSUzlF02fILECw/FdFDQdLc00uEPp83JFf29Y6
	RQ2e3ZW5/bkYQvnsuBa6rL67IbnZAUAU+FewjTaMn4ngKVrJi02SRLTS3K/G0l3rjjPc50
	oKKZTgYE2CxzPRcbYGdKHZVFkkR+Ohl6i2qnoBEb4LXZEKXFKcsU2bWMjANNRfpKNPeKQb
	kRQvcngyOtHJCXH0FnuLv/tgNgMm9W5Kld88hy745F19GSjrcs/UwbzKunfeAw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 29 Jul 2024 10:20:31 +0200
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: add wrong type test to
 cgroup dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-convert_dev_cgroup-v2-3-4c1fc0520545@bootlin.com>
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
In-Reply-To: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

Current cgroup_dev test mostly tests that device operation is accepted or
refused base on passed major/minor (and so, any operation performed during
test involves only char device)

Add a small subtest ensuring that the device type passed to bpf program
allows it to take decisions as well.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- change test name ("null" block device does not make sense)
- use updated subtest API for this new subtest
---
 tools/testing/selftests/bpf/prog_tests/cgroup_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
index af0b70086c21..a840973c87b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
@@ -91,6 +91,9 @@ void test_cgroup_dev(void)
 	if (test__start_subtest("allow-mknod"))
 		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
 
+	if (test__start_subtest("deny-mknod-wrong-type"))
+		test_mknod("/dev/test_dev_cgroup_block", S_IFBLK, 1, 3, -EPERM);
+
 	if (test__start_subtest("allow-read"))
 		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE, TEST_BUFFER_SIZE);
 

-- 
2.45.2


