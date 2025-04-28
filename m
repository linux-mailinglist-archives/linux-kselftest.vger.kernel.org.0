Return-Path: <linux-kselftest+bounces-31759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BBA9EA91
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792F7189D2EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81625E46B;
	Mon, 28 Apr 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mFJK0/iX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7C25DCE9;
	Mon, 28 Apr 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828353; cv=none; b=jVBMrkiddNCLeXa9dVu9rON7K9Dif9viz2CJNssV1s70B4Eaz4JkDurzMIMSQLBwZbubcGwXSJ1h3Lmbpg28N91oGJr3l0f8v6obtbxIDqC6UGhVfHhPvj3MkLpT9IIYHm+5KBq5NStWqqJXZMwqLMnsMGj6RZcA7UFaAYiu2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828353; c=relaxed/simple;
	bh=0sGaXTtD20xzhNz4rmeWyme7BvH88i16MX9d4W1Y3CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekMglyPJrSpsGA4u1+snH1PBiO8DS7XRZTQCmWFsqtXlVcpcz0AYyAFnyUrDIqrMPAwP//x3wK+cjcyGdcQ45FW+sdK31pBwON4CV+ivIir/VJJtw+6f49qV7ni5p11adplSm2PlZMAq5u9nqcfMiqKhIvNsaPfKhY7duSQvQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mFJK0/iX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745828349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg/btEvaUcqT4NM4dYYa4R9u9WjGLVmndHIgtbzlFXc=;
	b=mFJK0/iXSOt5fj3xjadJLjSr81Jzb3GynBBFsr5KHqT0x5plfJlh+zMBgV6u+BWLX6J/on
	Z1DQYEu83m7V578FTrWJZp3poMihriyfGZvrhL3orFlBxG7S2JNcZZI4eCKIVrvRQeXBfN
	tQVSe3DLCCJKPkD/jCVFYI8t/3rq36M=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 3/3] selftest/bpf/benchs: Add cpu-affinity for sockmap bench
Date: Mon, 28 Apr 2025 16:16:54 +0800
Message-ID: <20250428081744.52375-4-jiayuan.chen@linux.dev>
In-Reply-To: <20250428081744.52375-1-jiayuan.chen@linux.dev>
References: <20250428081744.52375-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add cpu-affinity for sockmap bench. Also add no-verify args to avoid
validating data for performance enhancements.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/benchs/bench_sockmap.c      | 35 +++++++++++++++++--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  6 ++++
 .../selftests/bpf/progs/bench_sockmap_prog.c  |  7 ++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_sockmap.c b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
index 8ebf563a67a2..e004a618822a 100644
--- a/tools/testing/selftests/bpf/benchs/bench_sockmap.c
+++ b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
@@ -43,6 +43,8 @@ enum SOCKMAP_ARG_FLAG {
 	ARG_FW_TX_VERDICT_INGRESS,
 	ARG_FW_TX_VERDICT_EGRESS,
 	ARG_CTL_RX_STRP,
+	ARG_CTL_CPU_AFFINITY,
+	ARG_CTL_NO_VERIFY,
 	ARG_CONSUMER_DELAY_TIME,
 	ARG_PRODUCER_DURATION,
 };
@@ -109,6 +111,8 @@ static struct socmap_ctx {
 	int		delay_consumer;
 	int		prod_run_time;
 	int		strp_size;
+	int		cpu_affinity;
+	int		skip_verify;
 } ctx = {
 	.prod_send	= 0,
 	.user_read	= 0,
@@ -118,6 +122,8 @@ static struct socmap_ctx {
 	.delay_consumer = 0,
 	.prod_run_time	= 0,
 	.strp_size	= 0,
+	.cpu_affinity	= 0,
+	.skip_verify	= 0,
 };
 
 static void bench_sockmap_prog_destroy(void)
@@ -235,11 +241,18 @@ static int create_sockets(void)
 static void validate(void)
 {
 	if (env.consumer_cnt != 2 || env.producer_cnt != 1 ||
-	    !env.affinity)
+	    !env.affinity) {
+		fprintf(stderr, "argument '-c 2 -p 1 -a' is necessary\n");
 		goto err;
+	}
+
+	if (!ctx.cpu_affinity && env.nr_cpus < 4) {
+		fprintf(stderr, "4 CPU are needed to test cpu-affinity\n");
+		goto err;
+	}
+
 	return;
 err:
-	fprintf(stderr, "argument '-c 2 -p 1 -a' is necessary");
 	exit(1);
 }
 
@@ -327,6 +340,9 @@ static void setup(void)
 		exit(1);
 	}
 
+	if (ctx.cpu_affinity)
+		ctx.skel->data->redir_cpu = 3;
+
 	if (create_sockets()) {
 		fprintf(stderr, "create_net_mode error\n");
 		goto err;
@@ -367,9 +383,12 @@ static void measure(struct bench_res *res)
 
 static void verify_data(int *check_pos, char *buf, int rcv)
 {
+	if (ctx.skip_verify)
+		return;
+
 	for (int i = 0 ; i < rcv; i++) {
 		if (buf[i] != snd_data[(*check_pos) % DATA_REPEAT_SIZE]) {
-			fprintf(stderr, "verify data fail");
+			fprintf(stderr, "verify data fail\n");
 			exit(1);
 		}
 		(*check_pos)++;
@@ -553,6 +572,10 @@ static const struct argp_option opts[] = {
 		"delay consumer start"},
 	{ "producer-duration", ARG_PRODUCER_DURATION, "SEC", 0,
 		"producer duration"},
+	{ "cpu-affinity", ARG_CTL_CPU_AFFINITY, NULL, 0,
+		"set cpu-affinity for sockmap backlog thread"},
+	{ "no-verify", ARG_CTL_NO_VERIFY, NULL, 0,
+		"skip data validation for performance enhancements"},
 	{},
 };
 
@@ -571,6 +594,12 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case ARG_CTL_RX_STRP:
 		ctx.strp_size = strtol(arg, NULL, 10);
 		break;
+	case ARG_CTL_CPU_AFFINITY:
+		ctx.cpu_affinity = 1;
+		break;
+	case ARG_CTL_NO_VERIFY:
+		ctx.skip_verify = 1;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 8215c9b3115e..173329c5d034 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -92,4 +92,10 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+/* Description
+ *  Set sockmap redir cpu
+ * Returns
+ *  Error code
+ */
+extern int bpf_sk_skb_set_redirect_cpu(struct __sk_buff *skb, int redir_cpu) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/bench_sockmap_prog.c b/tools/testing/selftests/bpf/progs/bench_sockmap_prog.c
index 079bf3794b3a..dd1a11cb4f48 100644
--- a/tools/testing/selftests/bpf/progs/bench_sockmap_prog.c
+++ b/tools/testing/selftests/bpf/progs/bench_sockmap_prog.c
@@ -2,11 +2,15 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
 
 long process_byte = 0;
 int  verdict_dir = 0;
 int  dropped = 0;
 int  pkt_size = 0;
+int  redir_cpu = -1;
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 20);
@@ -33,6 +37,9 @@ int prog_skb_verdict(struct __sk_buff *skb)
 	int one = 1;
 	int ret =  bpf_sk_redirect_map(skb, &sock_map_rx, one, verdict_dir);
 
+	if (redir_cpu != -1)
+		bpf_sk_skb_set_redirect_cpu(skb, redir_cpu);
+
 	if (ret == SK_DROP)
 		dropped++;
 	__sync_fetch_and_add(&process_byte, skb->len);
-- 
2.47.1


