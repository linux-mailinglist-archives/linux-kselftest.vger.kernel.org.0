Return-Path: <linux-kselftest+bounces-24194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C11A08BD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31EF3AB3C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064C120D51D;
	Fri, 10 Jan 2025 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="psNjNxqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10520A5F2;
	Fri, 10 Jan 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500881; cv=none; b=CjgvP3We4U2V+wX+woOypkJ3WfVyYg/apBzZaXS7F7bhxB6AiQaE8pv8bAQzyPPc3mprGjOUG1kHeZuMJqa1GT4BoTZQbPeEdb25GbUMd4zWdKfV65km3+20VoeaWRLKEuadcZGHluwfGaAdifonTXN8okohWIOpBsPzRkYUKW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500881; c=relaxed/simple;
	bh=ZMnS/CCMGGORoqA8raGQG3X5AXSSVNilwAPP5RQlZ4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCqM3RPxGaxLloy/fXp98cQx+E+ShJqBFrMsVJdlstY068adiYi/PMAc0Rfb4LrPK3mgKICZJ/tGfoeY+FfQjWuU0ZN4Vm9bgML35J/txQkc2W08IevevCzjT8lji0ejZ+Zb80FBVBG+W3btt3ofa3DPHfCOCMpHI1N9pg/Iajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=psNjNxqc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8620DFF80A;
	Fri, 10 Jan 2025 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736500877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zE3Qj+wzy3/ijSchaBF4BZ78lkkThafbwyvbpr5Xms=;
	b=psNjNxqcC/vi+Tq2u0jl2omRpGVLlFsehJZb1uVHgcj6v2/laLnSIPAdW32wRG1pxpjAlu
	RDKt+x6FhAb3mQbCa2S9Gr3MC2J2VbOI0c5s1nhQ3Ne9cLO/SV3zef9Nep4CxuQCFrmDeu
	81RSEKH6F+3zNqZokII1k+Vy0CrNwLWu2ynLuqHLOX159OU94alVM0JyZIEhiS3DSP8O2r
	3L6PmiDOTP7BtN6NysV7cB2oHb+7jCuBednQ4vqiAuGsTvorzp4O3Yok6G23zcS5PHQuNM
	InTehgPjwuw9eduhSY7GUtGhILPyfMYCeuvHUA9djQoLlL7y1LimKH4AIxZzGA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 10 Jan 2025 10:21:11 +0100
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Migrate test_xdp_redirect.c
 to test_xdp_do_redirect.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-xdp_redirect-v2-3-b8f3ae53e894@bootlin.com>
References: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
In-Reply-To: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

prog_tests/xdp_do_redirect.c is the only user of the BPF programs
located in progs/test_xdp_do_redirect.c and progs/test_xdp_redirect.c.
There is no need to keep both files with such close names.

Move test_xdp_redirect.c contents to test_xdp_do_redirect.c and remove
progs/test_xdp_redirect.c

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |  7 +++---
 .../selftests/bpf/progs/test_xdp_do_redirect.c     | 12 ++++++++++
 .../selftests/bpf/progs/test_xdp_redirect.c        | 26 ----------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index 9052ed0fcf427db9ffc4ff33fbc46ab0ba561b07..16edc83e4da4536cba4ea608f16fa5ae16cb10ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -11,7 +11,6 @@
 #include <bpf/bpf_endian.h>
 #include <uapi/linux/netdev.h>
 #include "test_xdp_do_redirect.skel.h"
-#include "test_xdp_redirect.skel.h"
 #include "xdp_dummy.skel.h"
 
 struct udp_packet {
@@ -324,7 +323,7 @@ static int ping_setup(struct test_data *data)
 
 static void ping_test(struct test_data *data)
 {
-	struct test_xdp_redirect *skel = NULL;
+	struct test_xdp_do_redirect *skel = NULL;
 	struct xdp_dummy *skel_dummy = NULL;
 	struct nstoken *nstoken = NULL;
 	int i, ret;
@@ -351,7 +350,7 @@ static void ping_test(struct test_data *data)
 		nstoken = NULL;
 	}
 
-	skel = test_xdp_redirect__open_and_load();
+	skel = test_xdp_do_redirect__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
 		goto close;
 
@@ -383,7 +382,7 @@ static void ping_test(struct test_data *data)
 close:
 	close_netns(nstoken);
 	xdp_dummy__destroy(skel_dummy);
-	test_xdp_redirect__destroy(skel);
+	test_xdp_do_redirect__destroy(skel);
 }
 
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
index 3abf068b84464ce0460a671abc4dfb97e1f2be4a..5928ed0911caf4d5a71ef37889d9315bfa6623ae 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
@@ -98,6 +98,18 @@ int xdp_count_pkts(struct xdp_md *xdp)
 	return XDP_DROP;
 }
 
+SEC("xdp")
+int xdp_redirect_to_111(struct xdp_md *xdp)
+{
+	return bpf_redirect(111, 0);
+}
+
+SEC("xdp")
+int xdp_redirect_to_222(struct xdp_md *xdp)
+{
+	return bpf_redirect(222, 0);
+}
+
 SEC("tc")
 int tc_count_pkts(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
deleted file mode 100644
index 7025aee08a001cfc42e52174a4acce7869dd331b..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/* Copyright (c) 2017 VMware
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- */
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("xdp")
-int xdp_redirect_to_111(struct xdp_md *xdp)
-{
-	return bpf_redirect(111, 0);
-}
-SEC("xdp")
-int xdp_redirect_to_222(struct xdp_md *xdp)
-{
-	return bpf_redirect(222, 0);
-}
-
-char _license[] SEC("license") = "GPL";

-- 
2.47.1


