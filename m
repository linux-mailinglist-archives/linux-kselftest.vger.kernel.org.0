Return-Path: <linux-kselftest+bounces-14144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5C93B05C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 13:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA56E1F24BA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDA15884F;
	Wed, 24 Jul 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ULwP1ZtW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035211586DB
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820832; cv=none; b=JbVzA9HX44yImrb7kj20XKuCNwU8cB1TBObHwuhLOwbRb53JvKcN3RU8U/IYMc6TPWOarWp2oTtEHiKWzTH3L3JDi7f8IYU++6Y1VWVjqgkbcUEip81FZBH3OozNcmBqgC+nX6blBM6byygz1OE02AWn6ZbtDk3UFeQfinKCkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820832; c=relaxed/simple;
	bh=WKheBqdL7GtFkTog+x8Ke5yX5bW566JG72tLXKvQZ4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuQQhj6n2UvlHaMZE2PyiVTA2vAXm8U1h05RcwJASiNNOgqjhE8SHG6G8otB1tgq8O/neQ/szxpiIrrinV+kPLfl5RC4IQmPbor8kJCDTWBnmDYglRRjcOGa6Ptqc7YbbijP0+Mr88whp7SGQK/3Cz4ubrNd2Plku8VreTGhZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ULwP1ZtW; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFZ-008Nv5-7l; Wed, 24 Jul 2024 13:33:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bkpsF3prMgBzSP/ySzeq5IGdYeHxsx9jrEK45yh3Dw4=; b=ULwP1ZtWJplKEevA3ZhLKDpcV5
	+j0AmWJe8RiSfUCjznebMh7TnVmxuYFppq7BUrHeZ6fdINOQxUCLhlsqYGNNS+3lAhE5nsDMmK/vG
	yUoMWXwQOF21e4d39wlZXyqNWj0k0rnCkhs4DJ78lVXVi2AQv7xL1dXTINGnNE/9+Ij+w7iNlxvZz
	XpwklMvJly2q4aSvfVDYgTP5x69eUiZMHDv9Q8qwaAod3JsMusuYUnLWFKKsKnEN9paF1wwkVZW9d
	CkQSbcgQVdjcHst3xdf0Yqu5qdXBBQH2wov/JYnXG0eg1wvc+uyxQmlrFLgibK22YgmTemRLkUOz0
	m97Wsy4A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFY-0004yB-SD; Wed, 24 Jul 2024 13:33:41 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaFO-00EK6H-Nk; Wed, 24 Jul 2024 13:33:30 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 24 Jul 2024 13:32:41 +0200
Subject: [PATCH bpf 5/6] selftest/bpf: Exercise SOCK_STREAM
 unix_inet_redir_to_connected()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-sockmap-selftest-fixes-v1-5-46165d224712@rbox.co>
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.0

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


