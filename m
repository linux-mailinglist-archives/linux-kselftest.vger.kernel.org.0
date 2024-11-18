Return-Path: <linux-kselftest+bounces-22207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EA9D1A11
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 22:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7141C2823FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC461E8831;
	Mon, 18 Nov 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="mTY+jhho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CA1E6DDE;
	Mon, 18 Nov 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963934; cv=none; b=g7ZfkoS7zXNfCsTPQNafPIDFwGSgTU9copil8LiwwEZAU2Kfsm1tTCbprXLzxXAKsvHKa53HRQ/6DLr4+JqGkemg7Rxyh+8nvBXwjrkyMJOW+KiTTl8bLY+oJPxR6fIc88sQn1OAt2onff8AzvOOcvi5Zhls5hUTMcGAHHuqb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963934; c=relaxed/simple;
	bh=co8Dckm/Ft/4syFMI7aVc5JJY255utXjkRwiTHccfxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBlBvCH4GtiKm/DNK/zRncvW5ra6aLbiHcLrUWK+aW674PkM5mRDoiio/E2VmH0mZfc+KPQy2ObSYAknTMZqHaIQgGKwDthsp+qPVX4Aam+I9AO+LINvpNv8TvUonLoDzc/bFVTWtRIEyy4OHkzVOm2ISHwIulQJ1jgxZtMZyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=mTY+jhho; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tD8w2-00009x-Iu; Mon, 18 Nov 2024 22:05:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=1bOy9Ss9Ii/Bjx5TNc50w2/7adrGQRBgAQwHSSUDO0c=; b=mTY+jhhoRjUIx+0feW/erH+YhF
	R3HqrGPjaaZsbXxy+OnyTg2lMCoOwjO8T+k8XC48pJ1IjyG6ZuDUd/124Mzj0S4DhE220mMY6TkG9
	poO0Y+c7n4bTsSA0hMFwBaJvi3P71rFndQBHUv7gnSzFzgUZL2erUFwkLcGpHHnMlumw11ObU9crH
	dW1CdKXEMR1YFPyHD1k+FLWGhYY+UyBMAKrDwsVSVE9WrbZJFQL4graPCt9TYizDVCX8e1QJ0Nnjf
	CNEHHPi6Pf0hRuCjuC0/xP/pBuV2VuTsleXLHYmbQKiBH9R+wCOlQJH7k6XUnAWlBBBzIdeuMCI9U
	5ZppGTSQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tD8vx-0004oG-2k; Mon, 18 Nov 2024 22:05:21 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tD8vi-00DME4-9P; Mon, 18 Nov 2024 22:05:06 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 18 Nov 2024 22:03:44 +0100
Subject: [PATCH bpf 4/4] selftest/bpf: Add test for vsock removal from
 sockmap on close()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-vsock-bpf-poll-close-v1-4-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Make sure the proto::close callback gets invoked on vsock release.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 21d1e2e2308433e7475952dcab034e92f2f6101a..c502e1590dcc1d8b06c82673e060839479d99590 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -108,6 +108,35 @@ static void test_sockmap_create_update_free(enum bpf_map_type map_type)
 	close(s);
 }
 
+static void test_sockmap_vsock_delete_on_close(void)
+{
+	int err, c, p, map;
+	const int zero = 0;
+
+	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
+	if (!ASSERT_OK(err, "create_pair(AF_VSOCK)"))
+		return;
+
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_GE(map, 0, "bpf_map_create")) {
+		close(c);
+		goto out;
+	}
+
+	err = bpf_map_update_elem(map, &zero, &c, BPF_NOEXIST);
+	close(c);
+	if (!ASSERT_OK(err, "bpf_map_update"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	ASSERT_OK(err, "after close(), bpf_map_update");
+
+out:
+	close(p);
+	close(map);
+}
+
 static void test_skmsg_helpers(enum bpf_map_type map_type)
 {
 	struct test_skmsg_load_helpers *skel;
@@ -935,6 +964,8 @@ void test_sockmap_basic(void)
 		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash create_update_free"))
 		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKHASH);
+	if (test__start_subtest("sockmap vsock delete on close"))
+		test_sockmap_vsock_delete_on_close();
 	if (test__start_subtest("sockmap sk_msg load helpers"))
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash sk_msg load helpers"))

-- 
2.46.2


