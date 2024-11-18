Return-Path: <linux-kselftest+bounces-22164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD99D081B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 04:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CED1F21E1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 03:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66174438B;
	Mon, 18 Nov 2024 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QmA5W5u8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA53BBF2;
	Mon, 18 Nov 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731899466; cv=none; b=ikXYNdK7YcHWVdcq4GIQD+lJZGdXDhxfeCFP27HsIrluSa8MKp3vH+aMUiaNrV/D3GQ38PICO//wE1BBNovgnBcpOttIxXOEQtKNL3Kwnkn5hXrItDBSAnL+KYoOdrtNhyFFAZ1T2S53yAozaXudDQaxzHzVNm3OtYxRWdhW5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731899466; c=relaxed/simple;
	bh=m1Bf8pTAXZVAmctcbTeIv1DRTTkwBXvgdiGG7t0IUt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnehGfQ1xQWRInq2jULFam4Ek4fv0pkY2vIUqC4MMt99gYqepldKS+PT+Qpz7vkpQSWPigOkSn9eH/hmtlaaO01X+qqHTLrVA+nQCI2EdNNvqgK3JApKEHoTn+Ng8sWYWdz5SGe38cNXQYlsW1js4Hkf/6AEqsCTwYLos+nObCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QmA5W5u8; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=DvEpP
	j+D0VN2cgQ0y1KaqjfX8SObfBeJKjuhl+zvTNM=; b=QmA5W5u8bkbfqnKWVBzpK
	Kivjt5RN9meZxvr3xcC7q6k636mcuDwSKmxCBNGN/JRoyv7FN9d/4HpnlwgYjVy0
	+O6wvbBbV5Mly9YyKKaTUW5yRtyS2Kb82rF0hgZMWWs39Dwvt8LWUgOh683STZTm
	PAV9kwhkkBKwXTztHgKbGw=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnTyXirzpnA_TwCQ--.780S4;
	Mon, 18 Nov 2024 11:10:01 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: martin.lau@linux.dev,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	daniel@iogearbox.net
Cc: mykolal@fb.com,
	ast@kernel.org,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	haoluo@google.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add some tests with sockmap SK_PASS
Date: Mon, 18 Nov 2024 11:09:10 +0800
Message-ID: <20241118030910.36230-3-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241118030910.36230-1-mrpre@163.com>
References: <20241118030910.36230-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTyXirzpnA_TwCQ--.780S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4DJrWkXFyDJr4rAr47Arb_yoW5WFW5pa
	4kC34YkFs3Aa42qrs8Gw1I9Fy5WF4rZ3y5KF4jg345CrnrWr1fur1xKayYyr1fGrZaq3W8
	uw13uayfG34UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziyrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwibp2c6rMNqYAAAsD

Add a new tests in sockmap_basic.c to test SK_PASS for sockmap

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 82bfb266741c..a2041f8e32eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -501,6 +501,58 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void test_sockmap_stream_pass(void)
+{
+	int zero = 0, sent, recvd;
+	int verdict, parser;
+	int err, map;
+	int c = -1, p = -1;
+	struct test_sockmap_pass_prog *pass = NULL;
+	char snd[256] = "0123456789";
+	char rcv[256] = "0";
+
+	pass = test_sockmap_pass_prog__open_and_load();
+	verdict = bpf_program__fd(pass->progs.prog_skb_verdict);
+	parser = bpf_program__fd(pass->progs.prog_skb_parser);
+	map = bpf_map__fd(pass->maps.sock_map_rx);
+
+	err = bpf_prog_attach(parser, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream parser"))
+		goto out;
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
+		goto out;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
+	if (err)
+		goto out;
+
+	/* sk_data_ready of 'p' will be replaced by strparser handler */
+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p)"))
+		goto out_close;
+
+	/*
+	 * as 'prog_skb_parser' return the original skb len and
+	 * 'prog_skb_verdict' return SK_PASS, the kernel will just
+	 * pass it through to original socket 'p'
+	 */
+	sent = xsend(c, snd, sizeof(snd), 0);
+	ASSERT_EQ(sent, sizeof(snd), "xsend(c)");
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), SOCK_NONBLOCK,
+			     IO_TIMEOUT_SEC);
+	ASSERT_EQ(recvd, sizeof(rcv), "recv_timeout(p)");
+
+out_close:
+	close(c);
+	close(p);
+
+out:
+	test_sockmap_pass_prog__destroy(pass);
+}
+
 static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 {
 	int err, map, verdict, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
@@ -923,6 +975,8 @@ void test_sockmap_basic(void)
 		test_sockmap_progs_query(BPF_SK_SKB_VERDICT);
 	if (test__start_subtest("sockmap skb_verdict shutdown"))
 		test_sockmap_skb_verdict_shutdown();
+	if (test__start_subtest("sockmap stream parser and verdict pass"))
+		test_sockmap_stream_pass();
 	if (test__start_subtest("sockmap skb_verdict fionread"))
 		test_sockmap_skb_verdict_fionread(true);
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
-- 
2.43.5


