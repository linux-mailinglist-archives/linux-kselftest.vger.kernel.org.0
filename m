Return-Path: <linux-kselftest+bounces-32974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC003AB78E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AE7AA5D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E302224223;
	Wed, 14 May 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cht9WUif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F91EB189;
	Wed, 14 May 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260988; cv=none; b=P+rrA5a1di7w9vD1n9mrKdP9sB9JZdwvFHq5UlVb6wWxjBhsoyU4dAD+JJ5ME6NkVxPlw6ZDLNzg8Vdd05xXkvv/OY9z3wTLDDe9nNoBG7e/urdw0lOVDWdf5tKaTKgjt63m+Q2bbKyAZkrpKfUZxO5+cJJlbUtclTsceRx99pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260988; c=relaxed/simple;
	bh=AWk9Ca73id5F9YQWEPEIhc+mFJs28UXN1ReaPw4guow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDkxWJLVNA/QaZiObJubUED2QRxSd2jIfRChdP8yBOAbU7Kz1CSBtpBA9rZX5KGyKiEfNfhdkI667r2/jZLGpveXWBENleifVl4Amse8NSl0aCO2U0rvqeHYcGYnz2n/Rgm2pfjpEcKgUZbBgDId2WbKkJFlSRLlpiuWQeujqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cht9WUif; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOk-001k8n-6z; Thu, 15 May 2025 00:16:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=UbCVgwxpRFnpFZpXah8Lt7X+QYdpyqNgSqr+wPpYtPk=; b=cht9WUifGa0X8aAJ6An+SP07zu
	DUPWUug0oVB9ikoJn8A6bqspOAtUkB+Y0VuycJzgnla9gyavB6yVm6TPme+SJcDpbwySTIkAMrS2I
	vetY2jFnsmlTk42EWZRvIWN+CB8hZlh7xSGJK1Y3MIMLncdvoHIPWDvo3dZksC6TwgkrkwOJn0F0z
	IDPO/fn7Nv48EZvbSCKk85iCrQ4LbLziYbOYiOJ5h8iXp0hHMrvUL2TfVZb91RqHtnjVRQjXI5m6k
	A6wfQSyYwRA3/kqoFUPub4s9JoaoXlk1yqkeWLVRSsYmazAIh+C5Tj3L+UTcCExj6+oXh2FNAwU/B
	9hzFOTJA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOj-0008AM-S3; Thu, 15 May 2025 00:16:22 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOM-005bJ3-Kf; Thu, 15 May 2025 00:15:58 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 15 May 2025 00:15:27 +0200
Subject: [PATCH bpf-next v3 4/8] selftests/bpf: Introduce verdict programs
 for sockmap_redir
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftests-sockmap-redir-v3-4-a1ea723f7e7e@rbox.co>
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
In-Reply-To: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Michal Luczaj <mhal@rbox.co>, Jiayuan Chen <mrpre@163.com>
X-Mailer: b4 0.14.2

Instead of piggybacking on test_sockmap_listen, introduce
test_sockmap_redir especially for sockmap redirection tests.

Suggested-by: Jiayuan Chen <mrpre@163.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/progs/test_sockmap_redir.c       | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_redir.c b/tools/testing/selftests/bpf/progs/test_sockmap_redir.c
new file mode 100644
index 0000000000000000000000000000000000000000..34d9f4f2f0a2e638c6e05cfa9f19971bd36c11ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_redir.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC(".maps") struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} nop_map, sock_map;
+
+SEC(".maps") struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} nop_hash, sock_hash;
+
+SEC(".maps") struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, unsigned int);
+} verdict_map;
+
+/* Set by user space */
+int redirect_type;
+int redirect_flags;
+
+#define redirect_map(__data)                                                   \
+	_Generic((__data),                                                     \
+		 struct __sk_buff * : bpf_sk_redirect_map,                     \
+		 struct sk_msg_md * : bpf_msg_redirect_map                     \
+	)((__data), &sock_map, (__u32){0}, redirect_flags)
+
+#define redirect_hash(__data)                                                  \
+	_Generic((__data),                                                     \
+		 struct __sk_buff * : bpf_sk_redirect_hash,                    \
+		 struct sk_msg_md * : bpf_msg_redirect_hash                    \
+	)((__data), &sock_hash, &(__u32){0}, redirect_flags)
+
+#define DEFINE_PROG(__type, __param)                                           \
+SEC("sk_" XSTR(__type))                                                        \
+int prog_ ## __type ## _verdict(__param data)                                  \
+{                                                                              \
+	unsigned int *count;                                                   \
+	int verdict;                                                           \
+									       \
+	if (redirect_type == BPF_MAP_TYPE_SOCKMAP)                             \
+		verdict = redirect_map(data);                                  \
+	else if (redirect_type == BPF_MAP_TYPE_SOCKHASH)                       \
+		verdict = redirect_hash(data);                                 \
+	else                                                                   \
+		verdict = redirect_type - __MAX_BPF_MAP_TYPE;                  \
+									       \
+	count = bpf_map_lookup_elem(&verdict_map, &verdict);                   \
+	if (count)                                                             \
+		(*count)++;                                                    \
+									       \
+	return verdict;                                                        \
+}
+
+DEFINE_PROG(skb, struct __sk_buff *);
+DEFINE_PROG(msg, struct sk_msg_md *);
+
+char _license[] SEC("license") = "GPL";

-- 
2.49.0


