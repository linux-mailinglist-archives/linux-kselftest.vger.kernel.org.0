Return-Path: <linux-kselftest+bounces-14518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB56942B76
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4891C20985
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6811AD415;
	Wed, 31 Jul 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="UnqI2Eyf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCE1AD9C7;
	Wed, 31 Jul 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420121; cv=none; b=FK8KPPLLPQK/6xKmQb0YX3JEbcdNSLqMRhQJ5OC/RcqAbxggX5A2RkzaUJtZklN5LI9dX9tgZaIdVI1IuTuJYnV5I4cGWAskddgMUTEl8DPdDY6vSGTNFFxkxrGpu1TwLOIatvyR7nAcuqeC3oTwUS7i/Omj1tr0xKzrqpuvQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420121; c=relaxed/simple;
	bh=WKheBqdL7GtFkTog+x8Ke5yX5bW566JG72tLXKvQZ4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9N7Zqe3bPqKYVdhLbiVw63+dWBNJ+lh/BoObDzyQpgFE4ol0JlcD5+ZRFXIibqYi6slD2Vm2sF4lg/3jnqUTsPPfSXtZIg+uBj/P+2+FY9P8Y2uUCSQftFTnCpGvSUIFOCj/bQWL85fe2r0ly8npiD2PR+IUSzfSlfoD7Icyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UnqI2Eyf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69V-007DDV-R7; Wed, 31 Jul 2024 12:01:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bkpsF3prMgBzSP/ySzeq5IGdYeHxsx9jrEK45yh3Dw4=; b=UnqI2EyfrHFoSL/HqC7gw6hDnW
	nyfk1DJzqdeA5QKkGUJH+xsRICU/gi1B88J5S5QZlzFdbHwBCI8XNpDv6REbWSf61K09QiuutJ1+h
	zng0ZIHfJZIakcy3HGuyO7Vr14ZX2bHEOJmYq4e1RdpX+P5SZptfDbZOUbYlHiDnBFa9OAgu8ByvJ
	tVyl68KVpaEn7sjtyI18VuY5CfDXNAjg7KGjDsLpH0sb9PNJjyMaGSK0fpnu/fHAZYljzFLO9iyQY
	M/T3h+P3eqoYOm3OnmcpTUS2K2An1u7OR1iP2jbTPfP8aBn65jAhKWvlPrXy6JaPQTN/xEXRKqUdl
	x8keR2zw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69Q-00020X-Ao; Wed, 31 Jul 2024 12:01:44 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sZ69I-006dO6-QZ; Wed, 31 Jul 2024 12:01:36 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 31 Jul 2024 12:01:30 +0200
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: Exercise SOCK_STREAM
 unix_inet_redir_to_connected()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-selftest-sockmap-fixes-v2-5-08a0c73abed2@rbox.co>
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.1

Constants got switched reducing the test's coverage. Replace SOCK_DGRAM
with SOCK_STREAM in one of unix_inet_skb_redir_to_connected() tests.

Fixes: 51354f700d40 ("bpf, sockmap: Add af_unix test with both sockets in map")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 7ed223df5f12..da5a6fb03b69 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1793,7 +1793,7 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
 				     REDIR_EGRESS, NO_FLAGS);
-	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, -1, verdict_map,
 				     REDIR_EGRESS, NO_FLAGS);
 

-- 
2.45.2


