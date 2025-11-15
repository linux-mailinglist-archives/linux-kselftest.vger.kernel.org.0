Return-Path: <linux-kselftest+bounces-45693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD1C60C3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 23:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3B6F357CD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5D246770;
	Sat, 15 Nov 2025 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jskj9V19"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E65254AF5
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247385; cv=none; b=TNlL4QcjGxqrX0BZi/K+q1cCogqRtbR8FTvL87iOg1ZrM9ycnVMvTr65rlw1/s9ABxj/i50gwPK16gVZCn5cmD/m3v8RWqONvPSFgDvFASbxs1dBU5rrSlegfSUhMSE2zsboMX80o6fvWPIK6z/CcEvlr8m0ziXjVQlvGFfBV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247385; c=relaxed/simple;
	bh=rK7uoN9nxTgUBJL7wgn5gIDURxGikMdf+Ut6AQxyTPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGibfh2SP02eiV8YLf3sgzUhHSWmeGxRFh8BlZleqPFYMZqwR+jVbRJC1R8RQAwWzLGOyyKRuHHIcdW5/f/QDQ4YnqKk+iI6CDdue445qN67RC0qIZvFNwb+zr/RzFHeX26RP667TnbNADAses5lFtLdcpX5fvKHYveRvH4PzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jskj9V19; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a637712so3841975e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763247381; x=1763852181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44YHi/Zv9JKkS/TnByMrMK2XicviB1+DvTFrKwvLwD4=;
        b=Jskj9V193I5dDXoGI+CcsU1/CJSozRGQoBr4WCmz2pnqOq5apCou1f3ryVhpGtLL1u
         soX6L2wT96xK9uusODAax8Wo5fAFgF/3FV5UWcf8iScBDgzNFrsktfiqrL0J/QSwa730
         q9DzgKFMqXSX/miwV5LxeE4ER1QbOqaNh4o4FKJ4+IpDCAmX9KtoU6UTIzjJJ5Dxwdnb
         XN1+/uPaY86dlNvr/Sy7LSLpd+mA28Ljuc7MVoy+G+59pEeFjfOsM3FBIYCAf2/eiGZ9
         OJ9zz8+f7hISv1qW2SXRfXd61Gp7rAZGQ98lBLv58zD0UAkhMlA6RcdbGLKV67W/B6Ut
         Ln2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247381; x=1763852181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44YHi/Zv9JKkS/TnByMrMK2XicviB1+DvTFrKwvLwD4=;
        b=jU8JVvR1Ex1EVJfBgBYpM0gbRE6PcYIUaRKUYn9Dd8m/ATQLZ1knXS6VNF782BKw7g
         M5w6oL4FcrcoQkFuHxRmbswI7aHKSalK+nJaCUtpdSpuxbHYuADery52qKlH4Trdp7HC
         TDkoeyhXsLvi5VErIDYQjg7KeHcm09H6vhenvm3T8aIxJWkeNFzpBQxqV53w1e9+xkiW
         TwdpV8StmP77zUxMYnGTA5xTYzeLt/wvJ0V5XeXg2SukYri0VGcjn7lAyAX4/eetZsOK
         pfKvBU+zy4cSKKUYWTeOhWwRtlnCkMhPgDW5r2LTI2zDdWQFRRi19PxLoavGdMKRBapw
         nYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6LhsDl9QaRITkX63v+fKefihCF3QnbJcq6D8EW5Z6FBiNPEF1LIcXCorS0jkzzbqmYQIFYShw7YIXlBFtOS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcznVrYFBWfqFN5CWGNojQKOlZC4vjZUGiCX+2woyi1I/Favfj
	TmO62yypmVtvVydlp2o/lLSYqpiL+4pN32CJ/bOXwYxEaViJDDqMk80rP44cHmGeKPw=
X-Gm-Gg: ASbGncucJAv10AGhzmy1ftCQSxGo61/f1KrCEcWJjDCuTum49OCpPbKEWIjlH1Yw2im
	9tasTFkhHqr15rtIrTsjk/ugBXhvWSDEthz9JD4NNToC3mZ7YtdJ5SBT/i8PBhOxK63QG6i1Vt0
	11KkO1sJ5nvEZ+RuJq3D+ZRhJNrxlWH5tVAFANosL4mCfllD2psVQYaigVjq6evjXq5UfMp52JB
	ySag4hCs8kOlFVE9pvbyNhv3FZOKzJbRHyfzEw3plq4igLBE1YuNlWLcMlPNWtMBCePqHQFXCGE
	lDBuA5VP5J4AAxVsuQtXTEHU2AVI/X5ZJt96ZUVafz48mDG7mvjfQyUj1ZDuPAlAo228t2R5qTD
	LAvks/3q9yNc02nhfnbFi4jLoHx09ig1MKyJvn4PlPfzVGIGs9BB3d6M6zRykRPKonY8PM/1uc/
	DIT+2xPQLYL9idv9Exo2Hv/eKTCvUt/jMiL3N1ITn51Y88R3cf4A==
X-Google-Smtp-Source: AGHT+IHxjDLFe/NFHOZ68sltibpUEmaR9bCl2o+vLnWIEmGTciohPmr1mEPytJrGgMMEUePOuXeBGg==
X-Received: by 2002:a05:600c:4753:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-4778fe60658mr73845575e9.17.1763247381503;
        Sat, 15 Nov 2025 14:56:21 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm6641971b3a.21.2025.11.15.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:56:21 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next v1 1/5] selftests/bpf: use sockaddr_storage instead of addr_port in cls_redirect test
Date: Sun, 16 Nov 2025 07:55:36 +0900
Message-ID: <20251115225550.1086693-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cls_redirect test uses a custom addr_port structure to represent
IPv4/IPv6 addresses and ports. This custom wrapper requires extra
conversion logic and specific helpers such as fill_addr_port(), which
are no longer necessary when using standard socket address structures.

This commit replaces addr_port with the standard sockaddr_storage so
that test handles address families and ports using the native socket
types. This removes the custom helper, eliminates redundant casts,
and simplifies tuple handling without functional changes.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../selftests/bpf/prog_tests/cls_redirect.c   | 95 ++++++-------------
 1 file changed, 30 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 34b59f6baca1..9a7d365f9b24 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -22,79 +22,42 @@
 
 static int duration = 0;
 
-struct addr_port {
-	in_port_t port;
-	union {
-		struct in_addr in_addr;
-		struct in6_addr in6_addr;
-	};
-};
-
 struct tuple {
 	int family;
-	struct addr_port src;
-	struct addr_port dst;
+	struct sockaddr_storage src;
+	struct sockaddr_storage dst;
 };
 
-static bool fill_addr_port(const struct sockaddr *sa, struct addr_port *ap)
-{
-	const struct sockaddr_in6 *in6;
-	const struct sockaddr_in *in;
-
-	switch (sa->sa_family) {
-	case AF_INET:
-		in = (const struct sockaddr_in *)sa;
-		ap->in_addr = in->sin_addr;
-		ap->port = in->sin_port;
-		return true;
-
-	case AF_INET6:
-		in6 = (const struct sockaddr_in6 *)sa;
-		ap->in6_addr = in6->sin6_addr;
-		ap->port = in6->sin6_port;
-		return true;
-
-	default:
-		return false;
-	}
-}
 
-static bool set_up_conn(const struct sockaddr *addr, socklen_t len, int type,
+static bool set_up_conn(const struct sockaddr_storage *addr, socklen_t len, int type,
 			int *server, int *conn, struct tuple *tuple)
 {
 	struct sockaddr_storage ss;
 	socklen_t slen = sizeof(ss);
-	struct sockaddr *sa = (struct sockaddr *)&ss;
 
-	*server = start_server_addr(type, (struct sockaddr_storage *)addr, len, NULL);
+	*server = start_server_addr(type, addr, len, NULL);
 	if (*server < 0)
 		return false;
 
-	if (CHECK_FAIL(getsockname(*server, sa, &slen)))
+	if (CHECK_FAIL(getsockname(*server, (struct sockaddr *)&ss, &slen)))
 		goto close_server;
 
-	*conn = connect_to_addr(type, (struct sockaddr_storage *)sa, slen, NULL);
+	*conn = connect_to_addr(type, &ss, slen, NULL);
 	if (*conn < 0)
 		goto close_server;
 
 	/* We want to simulate packets arriving at conn, so we have to
 	 * swap src and dst.
 	 */
-	slen = sizeof(ss);
-	if (CHECK_FAIL(getsockname(*conn, sa, &slen)))
+	slen = sizeof(tuple->dst);
+	if (CHECK_FAIL(getsockname(*conn, (struct sockaddr *)&tuple->dst, &slen)))
 		goto close_conn;
 
-	if (CHECK_FAIL(!fill_addr_port(sa, &tuple->dst)))
+	slen = sizeof(tuple->src);
+	if (CHECK_FAIL(getpeername(*conn, (struct sockaddr *)&tuple->src, &slen)))
 		goto close_conn;
 
-	slen = sizeof(ss);
-	if (CHECK_FAIL(getpeername(*conn, sa, &slen)))
-		goto close_conn;
-
-	if (CHECK_FAIL(!fill_addr_port(sa, &tuple->src)))
-		goto close_conn;
-
-	tuple->family = ss.ss_family;
+	tuple->family = tuple->dst.ss_family;
 	return true;
 
 close_conn:
@@ -110,17 +73,16 @@ static socklen_t prepare_addr(struct sockaddr_storage *addr, int family)
 {
 	struct sockaddr_in *addr4;
 	struct sockaddr_in6 *addr6;
+	memset(addr, 0, sizeof(*addr));
 
 	switch (family) {
 	case AF_INET:
 		addr4 = (struct sockaddr_in *)addr;
-		memset(addr4, 0, sizeof(*addr4));
 		addr4->sin_family = family;
 		addr4->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		return sizeof(*addr4);
 	case AF_INET6:
 		addr6 = (struct sockaddr_in6 *)addr;
-		memset(addr6, 0, sizeof(*addr6));
 		addr6->sin6_family = family;
 		addr6->sin6_addr = in6addr_loopback;
 		return sizeof(*addr6);
@@ -244,7 +206,11 @@ static void encap_init(encap_headers_t *encap, uint8_t hop_count, uint8_t proto)
 static size_t build_input(const struct test_cfg *test, void *const buf,
 			  const struct tuple *tuple)
 {
-	in_port_t sport = tuple->src.port;
+	struct sockaddr_in6 *src_in6 = (struct sockaddr_in6 *)&tuple->src;
+	struct sockaddr_in6 *dst_in6 = (struct sockaddr_in6 *)&tuple->dst;
+	struct sockaddr_in *src_in = (struct sockaddr_in *)&tuple->src;
+	struct sockaddr_in *dst_in = (struct sockaddr_in *)&tuple->dst;
+	in_port_t sport, dport;
 	encap_headers_t encap;
 	struct iphdr ip;
 	struct ipv6hdr ipv6;
@@ -254,6 +220,9 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
 	uint8_t *p = buf;
 	int proto;
 
+	sport = (tuple->family == AF_INET) ? src_in->sin_port : src_in6->sin6_port;
+	dport = (tuple->family == AF_INET) ? dst_in->sin_port : dst_in6->sin6_port;
+
 	proto = IPPROTO_IPIP;
 	if (tuple->family == AF_INET6)
 		proto = IPPROTO_IPV6;
@@ -277,8 +246,8 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
 			.version = 4,
 			.ttl = IPDEFTTL,
 			.protocol = proto,
-			.saddr = tuple->src.in_addr.s_addr,
-			.daddr = tuple->dst.in_addr.s_addr,
+			.saddr = src_in->sin_addr.s_addr,
+			.daddr = dst_in->sin_addr.s_addr,
 		};
 		p = mempcpy(p, &ip, sizeof(ip));
 		break;
@@ -287,8 +256,8 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
 			.version = 6,
 			.hop_limit = IPDEFTTL,
 			.nexthdr = proto,
-			.saddr = tuple->src.in6_addr,
-			.daddr = tuple->dst.in6_addr,
+			.saddr = src_in6->sin6_addr,
+			.daddr = dst_in6->sin6_addr,
 		};
 		p = mempcpy(p, &ipv6, sizeof(ipv6));
 		break;
@@ -303,18 +272,16 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
 	case TCP:
 		tcp = (struct tcphdr){
 			.source = sport,
-			.dest = tuple->dst.port,
+			.dest = dport,
+			.syn = (test->flags == SYN),
+			.ack = (test->flags == ACK),
 		};
-		if (test->flags == SYN)
-			tcp.syn = true;
-		if (test->flags == ACK)
-			tcp.ack = true;
 		p = mempcpy(p, &tcp, sizeof(tcp));
 		break;
 	case UDP:
 		udp = (struct udphdr){
 			.source = sport,
-			.dest = tuple->dst.port,
+			.dest = dport,
 		};
 		p = mempcpy(p, &udp, sizeof(udp));
 		break;
@@ -339,25 +306,23 @@ static void test_cls_redirect_common(struct bpf_program *prog)
 	LIBBPF_OPTS(bpf_test_run_opts, tattr);
 	int families[] = { AF_INET, AF_INET6 };
 	struct sockaddr_storage ss;
-	struct sockaddr *addr;
 	socklen_t slen;
 	int i, j, err, prog_fd;
 	int servers[__NR_KIND][ARRAY_SIZE(families)] = {};
 	int conns[__NR_KIND][ARRAY_SIZE(families)] = {};
 	struct tuple tuples[__NR_KIND][ARRAY_SIZE(families)];
 
-	addr = (struct sockaddr *)&ss;
 	for (i = 0; i < ARRAY_SIZE(families); i++) {
 		slen = prepare_addr(&ss, families[i]);
 		if (CHECK_FAIL(!slen))
 			goto cleanup;
 
-		if (CHECK_FAIL(!set_up_conn(addr, slen, SOCK_DGRAM,
+		if (CHECK_FAIL(!set_up_conn(&ss, slen, SOCK_DGRAM,
 					    &servers[UDP][i], &conns[UDP][i],
 					    &tuples[UDP][i])))
 			goto cleanup;
 
-		if (CHECK_FAIL(!set_up_conn(addr, slen, SOCK_STREAM,
+		if (CHECK_FAIL(!set_up_conn(&ss, slen, SOCK_STREAM,
 					    &servers[TCP][i], &conns[TCP][i],
 					    &tuples[TCP][i])))
 			goto cleanup;
-- 
2.51.1


