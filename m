Return-Path: <linux-kselftest+bounces-40821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B25B455E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB701B250F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB29345755;
	Fri,  5 Sep 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oXYlez50"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143C342CB0;
	Fri,  5 Sep 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070728; cv=none; b=lBNLkAP5lVJSchsqBTsLsjiDQIkJGjWyeAd7fUwegfQH0T7TgVECj+MvC9iHvam1DKHv6RPBQ5mDkMCCZaey3/j3xQelJAIopg3nNjGBql2btUeI3Lt3gD0wWWJ33f24mR7FDa5gqf8SFYcJh63WNbZayrc2hNq5XKRSCoxZlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070728; c=relaxed/simple;
	bh=5l2WmyIrw4huA09wl6EzkxVuMibO25q87hLx+ZzI/VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InY3CYWpv3mQfq/wTpYJf5ozpFmy2ufNxEu+tsq/uTAxeFPduSPyOqNrwvk1LtUHcOFWz+LILPXHrrOUldjnDFlLVIpIJ98a2qVwCNwkld8ugs5u7p8Hqo67QNXCG4t5L7eKHm/HZPMbRi9gm9a0GEvVyJQ1/dClCNf5+dsYEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oXYlez50; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uuUME-003TEn-1N; Fri, 05 Sep 2025 13:11:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=tNtuGg01lWaBXl/Af0XL6hoU9LuTDSKEgUeGslbsWt4=; b=oXYlez50bt20WSNhQDLhduPHNd
	m9CcOgL/j6H789vkbYAhzrAgaH8JghjdQbCh7KnPCU5MDzddOpTVp2JMMVZx7IKFGlwZ6LwjlYRqC
	I9F1CGUTt4/D7Ofc+INuTxukPdnaD0WgU2ZDiRBsqnXpsCR9+eLAsDsHegQXTqB1y+x8FdYAcR/00
	bUtB5Y4fcmeRoQTgQIh0EEFpgk4I7+/7+RQXne6ydWo2/Ce+oG+gi2/hhoMNPPBRc5SZxW8VHt6p1
	iy1k2EUy5tJNdLVS1VVH7e4Z1NxXgU0Xm399ftttwWb9uFEKEuP9Vkl4cDmtuqXwE/pAU+LVvOKLH
	+EhTRsxw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMD-00006H-8d; Fri, 05 Sep 2025 13:11:53 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuUMB-002yZ1-0q; Fri, 05 Sep 2025 13:11:51 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 05 Sep 2025 13:11:42 +0200
Subject: [PATCH bpf-next 2/5] selftests/bpf: sockmap_redir: Fix OOB
 handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
In-Reply-To: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

In some test cases, OOB packets might have been left unread. Flush them out
and introduce additional checks.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_redir.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
index c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e..4997e72c14345b274367f3f2f4115c39d1ae48c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
@@ -184,6 +184,19 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
 			FAIL_ERRNO("unsupported: packet missing, retval=%zd", n);
 	}
 
+	/* af_unix send("ab", MSG_OOB) spits out 2 packets, but only the latter
+	 * ("b") is designated OOB. If the peer is in a sockmap, the OOB packet
+	 * will be silently dropped. Otherwise OOB stays in the queue and should
+	 * be taken care of.
+	 */
+	if ((send_flags & MSG_OOB) && !pass && !drop) {
+		errno = 0;
+		n = recv_timeout(sd_peer, &recv_buf, 1, MSG_OOB, IO_TIMEOUT_SEC);
+		/* Ignore unsupported sk_msg error */
+		if (n != 1 && errno != EOPNOTSUPP)
+			FAIL_ERRNO("recv(OOB): retval=%zd", n);
+	}
+
 	/* Ensure queues are empty */
 	fail_recv("bpf.recv(sd_send)", sd_send, 0);
 	if (sd_in != sd_send)
@@ -192,6 +205,9 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
 	fail_recv("bpf.recv(sd_out)", sd_out, 0);
 	if (sd_recv != sd_out)
 		fail_recv("bpf.recv(sd_recv)", sd_recv, 0);
+
+	fail_recv("recv(sd_peer, OOB)", sd_peer, MSG_OOB);
+	fail_recv("recv(sd_out, OOB)", sd_out, MSG_OOB);
 }
 
 static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,

-- 
2.50.1


