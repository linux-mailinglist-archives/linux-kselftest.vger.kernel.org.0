Return-Path: <linux-kselftest+bounces-19332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94A9966C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074D0B20A4F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE768191F7C;
	Wed,  9 Oct 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jWqPrOf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46B18F2C4;
	Wed,  9 Oct 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468748; cv=none; b=McSKLL1fisDVDm5R/vHlvoFqSPRNznxD2taJ0vmriIUeyaQoRe+HrzjdPK23lGJt4doRJ64XaxvfGdhVB/Isb2z3OouQQzekLaaBLsrgcBWaHbV1xyNIZlCEuIRtVThnRXJwvO0+IMS4Kro5vi83e8W8QZBByYqsLkSwfec/UIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468748; c=relaxed/simple;
	bh=7j9vq35pXyRAcVc3ZRAoNyo9ZAAvkSUotw0OPx7aaTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHApQmHICmwc9DDx0RnmcxQUKlGgQ7PuDjT9PLvfnd4fU9EuYs2uXngW1Vx6kLMYjvao0jWYYBQTPJcOvYaWOBet4gFqo7KmiM5qDqoijqjEUuldXJw9OG6TfwwI9sQw0/94y3SLPoQXCFGAJDJFO47FC8EHsekturjIweSFfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jWqPrOf+; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 358D6FF811;
	Wed,  9 Oct 2024 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728468739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu33JTzN4sTvi1v3XIuk8Ur/NqSxuhd85F01Nc7EkjU=;
	b=jWqPrOf+md0dM+VyGixNbUyMEKSVYnqKNr1kzG3n6cFeVhHJRK8lg9Xo962x8AXu+GK0Uq
	h2wKJ5wgpdI5GeSyWdHlFZUD4v8ycu6Zz/Xe4QCsffKMNBT9CGxRYYMQJHYSfH9rDn02F/
	VffH2ys9zpw2rlGHWt39VdbKML2F6PkY+AMkNTFP/RMt1pLk212msqDgIssC4wcGTO+qWE
	7qyyO0rwsi0xUfj2flV1g36HjqijYH+8WlNs4//X0HOAmmft5PCpCC75QPanOFwkjWVxpe
	OlamNvFgykUM/2HDzsTRrTaRT1i6PQ0kCzf0sblhP6hXg20PtDNwz81bQlr26g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 09 Oct 2024 12:12:09 +0200
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: check program redirect in
 xdp_cpumap_attach
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241009-convert_xdp_tests-v3-3-51cea913710c@bootlin.com>
References: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
In-Reply-To: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
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
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

xdp_cpumap_attach, in its current form, only checks that an xdp cpumap
program can be executed, but not that it performs correctly the cpu
redirect as configured by userspace (bpf_prog_test_run_opts will return
success even if the redirect program returns an error)

Add a check to ensure that the program performs the configured redirect
as well. The check is based on a global variable incremented by a
chained program executed only if the redirect program properly executes.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- new patch
---
 tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c     | 10 ++++++++--
 .../testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index 31c225f0239613f6b5adad36b5b0e6e85eeddd9a..57d1661dc72aeb152c7cb9c2f63e3b47bf1799d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -62,8 +62,11 @@ static void test_xdp_with_cpumap_helpers(void)
 	err = bpf_prog_test_run_opts(prog_redir_fd, &opts);
 	ASSERT_OK(err, "XDP test run");
 
-	/* wait for the packets to be flushed */
+	/* wait for the packets to be flushed, then check that redirect has been
+	 * performed
+	 */
 	kern_sync_rcu();
+	ASSERT_NEQ(skel->bss->redirect_count, 0, "redirected packets");
 
 	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
 	ASSERT_OK(err, "XDP program detach");
@@ -203,8 +206,11 @@ static void test_xdp_with_cpumap_helpers_veth(void)
 	err = bpf_prog_test_run_opts(cm_fd_redir, &opts);
 	ASSERT_OK(err, "XDP test run");
 
-	/* wait for the packets to be flushed */
+	/* wait for the packets to be flushed, then check that redirect has been
+	 * performed
+	 */
 	kern_sync_rcu();
+	ASSERT_NEQ(skel->bss->redirect_count, 0, "redirected packets");
 
 	err = bpf_xdp_detach(ifindex_src, XDP_FLAGS_DRV_MODE, NULL);
 	ASSERT_OK(err, "XDP program detach");
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
index d848fe96924e32a72e1e0327e3afffeb349b933e..3619239b01b741dfd81bbebf5d9a62e0cf71e4f4 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
@@ -12,6 +12,8 @@ struct {
 	__uint(max_entries, 4);
 } cpu_map SEC(".maps");
 
+__u32 redirect_count = 0;
+
 SEC("xdp")
 int xdp_redir_prog(struct xdp_md *ctx)
 {
@@ -27,6 +29,9 @@ int xdp_dummy_prog(struct xdp_md *ctx)
 SEC("xdp/cpumap")
 int xdp_dummy_cm(struct xdp_md *ctx)
 {
+	if (bpf_get_smp_processor_id() == 0)
+		redirect_count++;
+
 	if (ctx->ingress_ifindex == IFINDEX_LO)
 		return XDP_DROP;
 

-- 
2.46.2


