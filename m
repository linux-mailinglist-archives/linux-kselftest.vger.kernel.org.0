Return-Path: <linux-kselftest+bounces-46202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AEC77D31
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2090B35EB73
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44897339707;
	Fri, 21 Nov 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PVaAUSWo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B4339B30
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712850; cv=none; b=BewoTJCUcXn5F1BHrRlZFf7RB5qGCRrdA1mo54U3GVK+fqhs6+DvFPwO71AOlUbOLhuLpgUOq9eC5yaEXAjFWV+0b4CBKtbRZSNnUjcYBHS3XGso/6LD2Li5bPUSRd7OlLq4YdfcuHYzHFS6af9Ct2Dg6jsSySrDUfCphBdYqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712850; c=relaxed/simple;
	bh=uAj5t3uon3XAlpMmhAYFzRZAjMZxodRwMmD+Cn89SWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtE9TAWDbEutSRk7opHiUpBxlOSJCcI/ohRB5DRflyk6TGPwr+gV8V0+mWC9GwBjBCi+9jtZYabHo+BxkLvG6g/fbJFMMfEDDHyDkcEHXubgVFEedwJa09kzOx6xde3phyXrpsE0JDnR4bUxj1r1s3BTUn+NpZtbP7OUi0oZ/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PVaAUSWo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso10402475e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763712846; x=1764317646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZvzY5tKy1Em2HRmItEveO3049C1oFM/cjXz6QNtNDU=;
        b=PVaAUSWo3EUPE4ofpl68nh8vBstpzPp4VMeHvqszFY4m25Yh3msXYMWPxbZUQLK8vE
         ZtUYmW0MiTX3d/kX0ME2LkE7P4oFyfn5uZhT1yv4sSl8OKRko7fsfzPEGWOKrutMOCzU
         vUglf+RCeXpRDCZhi30OzzKZnZSSP9MquM8vhjCxX+jCJ1pmmHsaSpFVCXiFWHL5AfRO
         IT2Xzq4uH3nVmYfaecGAUxRw1NQov1WU64bAY5/O21+zjj/HoabnO1Pk3Yh95rVExeX5
         YgV6scZXSzMAHhioI2t6vyupIgIeKMnQWfM0aYNfZX0hVcktIapkvdzYh80kW3N2ds5G
         NByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763712846; x=1764317646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LZvzY5tKy1Em2HRmItEveO3049C1oFM/cjXz6QNtNDU=;
        b=KYj5bZ/sF6vKjfr+vA36pAV9dNHcgs2r/ZAKK2+Cg70i1iZ5uKVUrBNAr6VVYShzwQ
         +mssCoe+wNmr32i9EAHXyd6NYkIErrlrD2XJE0bsI53xDbOnJ1H3dzpW3jZy40WIif7S
         vfHgdd5DLG35Ryh88PDsu8OlTvjURqQo4CuHv0oyYa8NqsN0NEHs2FEeAPHyZ4y+PvkT
         HO/XFGoyPUdjcYmboYIkDcmkuqJBsSzD3A1voxOl7fbhij9Bq3YmPhCgViUjuGRHsW6+
         6U7orZ0GOoQEi7Xlw5DCp01eYw3eDO5QE4GAEJB4EX5ip90Ff9pPJctyA5C4RtEyNKtc
         A4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW3m4pJsHnSNI4YGzaHG1vD2wzMGs/LKZbUlks6IDaijY9cnxL6G3sDPobIFDXCXFuIuXE6b5nCSuFVzsHw4F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKjbQZez4U1dV9ptZHbjlzcnCVGMODz8H5eptBbqsnQed11fs
	QmcyTeD6tHooxJ6UO4eGrVMz1+ReOSPtLdSXHJ7vao9YmCHbfrORopOP3eZwalf4kYA=
X-Gm-Gg: ASbGncvQxBYWk2KTW2pwkKrr442PgpQd5FditrQOHTkGqdbkkVp7id9dwG5z33i+tH+
	QvYPjvnxdyKZTutDLn1jvOyhzxBoseoGBCCoA70iMs0/yLjS4eEhqhOyd5YF2rUy61QAKQUpWv3
	kJn5YkhqfdZGP7uD3/5yfzt1Kn9pJEX8xqRc67UdIZaZ/6d+nG+xjbshqja5X3Le8RrbCUfQbBA
	C0YMJGRPYyd7FYtinyBPLRNod09uJZ3JMmG40CXTzrLydjihY6OLT0dY0HptMsR9q3ZkpHA3AtM
	s4KxSEuhcNDvRTScmPG2Mu9JA0QsCp5NSJrHm2JA00e1RBykQAi3eZE49N7eT4Gw/x7s7zR8Clm
	ZQh+BbysbwYfysNC03cEedVvJGd7nTnb5b3GiCxuTkFcILhvqD66ogTn9GojFcpLrNtsmgpAhmz
	gESepzrBUQvymgjOW1kKKygzpkFVr/dMwzorVnTMESn6gnLF7A+A==
X-Google-Smtp-Source: AGHT+IEu1txDJdEeuNyXg791niBx7HRrUwORyz/8Dajy7a5KZYJypuKK74oeC/wICBZW4I9TNk78aw==
X-Received: by 2002:a05:600c:3b86:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-477c10c8038mr10964305e9.5.1763712846382;
        Fri, 21 Nov 2025 00:14:06 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6314sm4722370a12.7.2025.11.21.00.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:14:05 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hoyeon.lee@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: use sockaddr_storage directly in cls_redirect test
Date: Fri, 21 Nov 2025 17:13:31 +0900
Message-ID: <20251121081332.2309838-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121081332.2309838-1-hoyeon.lee@suse.com>
References: <20251121081332.2309838-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cls_redirect test uses a custom addr_port/tuple wrapper to represent
IPv4/IPv6 addresses and ports. This custom wrapper requires extra
conversion logic and specific helpers such as fill_addr_port(), which
are no longer necessary when using standard socket address structures.

This commit replaces addr_port/tuple with the standard sockaddr_storage
so test handles address families and ports using native socket types.
It removes the custom helper, eliminates redundant casts, and simplifies
the setup helpers without functional changes. set_up_conn() and
build_input() now take src/dst sockaddr_storage directly.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
Changes in v2:
- Remove the tuple wrapper and pass src/dst sockaddr_storage directly.
- Rely on ss_family for protocol/port selection.
- No other logic changes.

 .../selftests/bpf/prog_tests/cls_redirect.c   | 122 ++++++------------
 1 file changed, 43 insertions(+), 79 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 34b59f6baca1..7488a7606e6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -22,79 +22,37 @@
 
 static int duration = 0;
 
-struct addr_port {
-	in_port_t port;
-	union {
-		struct in_addr in_addr;
-		struct in6_addr in6_addr;
-	};
-};
-
-struct tuple {
-	int family;
-	struct addr_port src;
-	struct addr_port dst;
-};
-
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
-			int *server, int *conn, struct tuple *tuple)
+static bool set_up_conn(const struct sockaddr_storage *addr, socklen_t len, int type,
+			int *server, int *conn,
+			struct sockaddr_storage *src,
+			struct sockaddr_storage *dst)
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
-		goto close_conn;
-
-	if (CHECK_FAIL(!fill_addr_port(sa, &tuple->dst)))
+	slen = sizeof(*dst);
+	if (CHECK_FAIL(getsockname(*conn, (struct sockaddr *)dst, &slen)))
 		goto close_conn;
 
-	slen = sizeof(ss);
-	if (CHECK_FAIL(getpeername(*conn, sa, &slen)))
+	slen = sizeof(*src);
+	if (CHECK_FAIL(getpeername(*conn, (struct sockaddr *)src, &slen)))
 		goto close_conn;
 
-	if (CHECK_FAIL(!fill_addr_port(sa, &tuple->src)))
-		goto close_conn;
-
-	tuple->family = ss.ss_family;
 	return true;
 
 close_conn:
@@ -110,17 +68,16 @@ static socklen_t prepare_addr(struct sockaddr_storage *addr, int family)
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
@@ -242,9 +199,15 @@ static void encap_init(encap_headers_t *encap, uint8_t hop_count, uint8_t proto)
 }
 
 static size_t build_input(const struct test_cfg *test, void *const buf,
-			  const struct tuple *tuple)
+			  const struct sockaddr_storage *src,
+			  const struct sockaddr_storage *dst)
 {
-	in_port_t sport = tuple->src.port;
+	struct sockaddr_in6 *src_in6 = (struct sockaddr_in6 *)src;
+	struct sockaddr_in6 *dst_in6 = (struct sockaddr_in6 *)dst;
+	struct sockaddr_in *src_in = (struct sockaddr_in *)src;
+	struct sockaddr_in *dst_in = (struct sockaddr_in *)dst;
+	sa_family_t family = src->ss_family;
+	in_port_t sport, dport;
 	encap_headers_t encap;
 	struct iphdr ip;
 	struct ipv6hdr ipv6;
@@ -254,8 +217,11 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
 	uint8_t *p = buf;
 	int proto;
 
+	sport = (family == AF_INET) ? src_in->sin_port : src_in6->sin6_port;
+	dport = (family == AF_INET) ? dst_in->sin_port : dst_in6->sin6_port;
+
 	proto = IPPROTO_IPIP;
-	if (tuple->family == AF_INET6)
+	if (family == AF_INET6)
 		proto = IPPROTO_IPV6;
 
 	encap_init(&encap, test->hops == ONE_HOP ? 1 : 0, proto);
@@ -270,15 +236,15 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
 	if (test->type == UDP)
 		proto = IPPROTO_UDP;
 
-	switch (tuple->family) {
+	switch (family) {
 	case AF_INET:
 		ip = (struct iphdr){
 			.ihl = 5,
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
@@ -287,8 +253,8 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
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
@@ -303,18 +269,16 @@ static size_t build_input(const struct test_cfg *test, void *const buf,
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
@@ -339,27 +303,26 @@ static void test_cls_redirect_common(struct bpf_program *prog)
 	LIBBPF_OPTS(bpf_test_run_opts, tattr);
 	int families[] = { AF_INET, AF_INET6 };
 	struct sockaddr_storage ss;
-	struct sockaddr *addr;
 	socklen_t slen;
 	int i, j, err, prog_fd;
 	int servers[__NR_KIND][ARRAY_SIZE(families)] = {};
 	int conns[__NR_KIND][ARRAY_SIZE(families)] = {};
-	struct tuple tuples[__NR_KIND][ARRAY_SIZE(families)];
+	struct sockaddr_storage srcs[__NR_KIND][ARRAY_SIZE(families)];
+	struct sockaddr_storage dsts[__NR_KIND][ARRAY_SIZE(families)];
 
-	addr = (struct sockaddr *)&ss;
 	for (i = 0; i < ARRAY_SIZE(families); i++) {
 		slen = prepare_addr(&ss, families[i]);
 		if (CHECK_FAIL(!slen))
 			goto cleanup;
 
-		if (CHECK_FAIL(!set_up_conn(addr, slen, SOCK_DGRAM,
+		if (CHECK_FAIL(!set_up_conn(&ss, slen, SOCK_DGRAM,
 					    &servers[UDP][i], &conns[UDP][i],
-					    &tuples[UDP][i])))
+					    &srcs[UDP][i], &dsts[UDP][i])))
 			goto cleanup;
 
-		if (CHECK_FAIL(!set_up_conn(addr, slen, SOCK_STREAM,
+		if (CHECK_FAIL(!set_up_conn(&ss, slen, SOCK_STREAM,
 					    &servers[TCP][i], &conns[TCP][i],
-					    &tuples[TCP][i])))
+					    &srcs[TCP][i], &dsts[TCP][i])))
 			goto cleanup;
 	}
 
@@ -368,11 +331,12 @@ static void test_cls_redirect_common(struct bpf_program *prog)
 		struct test_cfg *test = &tests[i];
 
 		for (j = 0; j < ARRAY_SIZE(families); j++) {
-			struct tuple *tuple = &tuples[test->type][j];
+			struct sockaddr_storage *src = &srcs[test->type][j];
+			struct sockaddr_storage *dst = &dsts[test->type][j];
 			char input[256];
 			char tmp[256];
 
-			test_str(tmp, sizeof(tmp), test, tuple->family);
+			test_str(tmp, sizeof(tmp), test, families[j]);
 			if (!test__start_subtest(tmp))
 				continue;
 
@@ -380,7 +344,7 @@ static void test_cls_redirect_common(struct bpf_program *prog)
 			tattr.data_size_out = sizeof(tmp);
 
 			tattr.data_in = input;
-			tattr.data_size_in = build_input(test, input, tuple);
+			tattr.data_size_in = build_input(test, input, src, dst);
 			if (CHECK_FAIL(!tattr.data_size_in))
 				continue;
 
-- 
2.51.1


