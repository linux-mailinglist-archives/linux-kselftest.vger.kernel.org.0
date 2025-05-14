Return-Path: <linux-kselftest+bounces-32976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58264AB78EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B48C5184
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD022577D;
	Wed, 14 May 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="dfYlPxmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD0224231;
	Wed, 14 May 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260990; cv=none; b=eXnOljnfRGUSosO5f5smd5/mJZf8m94ih6VLRnWZTZhwkg5n3rYqAeYi5fUnEF37xBQ+ErM2DEfxdoNlrPzwCM4Vf+xWJhmV2L/yoUyNuGJDdbWRK4fB4K8Y7zktNp1cVaHxo11iMt6YFYeusJNi/6rE+MgGspUwnr2QlIUfJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260990; c=relaxed/simple;
	bh=TyUF2kTK0OoRdemoV9iugzMT6gxNZ1RBr8BqGdfVDs4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qnjdY/wwiGDygQvBQs7+Y7yeDkj6Jz0HX6LlD5uhoyuJRYLPPqolVxywl94hJ3M8EeVk8cA4MK7WKgbUNbShZOFf492X+UlLZSiVcPpwGZaAJK8+Ff82MjVn/hEmMgczJ/WMNDLLEMkDN+WdT7Rz5/sidIUn+TVIeIllAKtfZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=dfYlPxmi; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOb-001vd4-C3; Thu, 15 May 2025 00:16:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=V7SKvYYBvjhYi6RVJ20G8GWJE+okl8tEUeDj6Z81Fso=
	; b=dfYlPxmiHEkrn9TTFrrSoOgiFPjtKeQrWbl3Ly6p5zvFVgirZHIEA0Pz51cYe/TCFnjl/Zbe+
	9bbe4yCLzq24W6T9tlV9cQcMvricHfKBkrtLQhh+WAO8zQsfCSSwyqLwIM+85CFBLiFEUwQepa2e8
	l/C0DN/CfwdoPnqF3qoGCRy1pP9XBpFWFxE9EK+9D4/o3wFOYOWdlQ4dvfRejqTRhtLd1MGoaAnGo
	3rRBIYNOK2JaeOZCI+i6ij+gTRtjauvpJFYdUrCmTP0Od+PfKGs6ri/+++FwydTmPjsKzRTK/uUBW
	PrG9Uf+DOUO2jANeV7I+zOg7IVYjs3jiGL58uQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOa-0004JJ-R9; Thu, 15 May 2025 00:16:12 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOJ-005bJ3-1U; Thu, 15 May 2025 00:15:55 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next v3 0/8] selftests/bpf: Test sockmap/sockhash
 redirection
Date: Thu, 15 May 2025 00:15:23 +0200
Message-Id: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPsVJWgC/3WNQQ6CMBBFr0Jm7ZhSKFBX3sOwgHYqjUpJpyEYw
 t1t2Lt8efnv78AUPTHcih0irZ59mDNUlwLMNMxPQm8zgxSyFlpKZHq7RJwYOZjXZ1gwkvURle0
 qXenGtIogr5dIzm9n+QHj4nCmLUGfzeQ5hfg9L1d5+lxXoi7Lv/VVokDl9CjKzjatqO9xDNvVB
 OiP4/gBJvua+cYAAAA=
X-Change-ID: 20240922-selftests-sockmap-redir-5d839396c75e
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

John, this revision introduces one more patch: "selftests/bpf: Introduce
verdict programs for sockmap_redir". I've kept you cross-series Acked-by. I
hope it's ok.

Jiayuan, I haven't heard back from you regarding [*], so I've kept things
unchanged for now. Please let me know what you think.

[*] https://lore.kernel.org/bpf/66bf942f-dfdb-4ce9-bd95-8b734e7afa53@rbox.co/

--

The idea behind this series is to comprehensively test the BPF redirection:

BPF_MAP_TYPE_SOCKMAP,
BPF_MAP_TYPE_SOCKHASH
	x
sk_msg-to-egress,
sk_msg-to-ingress,
sk_skb-to-egress,
sk_skb-to-ingress
	x
AF_INET, SOCK_STREAM,
AF_INET6, SOCK_STREAM,
AF_INET, SOCK_DGRAM,
AF_INET6, SOCK_DGRAM,
AF_UNIX, SOCK_STREAM,
AF_UNIX, SOCK_DGRAM,
AF_VSOCK, SOCK_STREAM,
AF_VSOCK, SOCK_SEQPACKET

New module is introduced, sockmap_redir: all supported and unsupported
redirect combinations are tested for success and failure respectively. Code
is pretty much stolen/adapted from Jakub Sitnicki's sockmap_redir_matrix.c
[1].

Usage:
$ cd tools/testing/selftests/bpf
$ make
$ sudo ./test_progs -t sockmap_redir
...
Summary: 1/576 PASSED, 0 SKIPPED, 0 FAILED

[1]: https://github.com/jsitnicki/sockmap-redir-matrix/blob/main/sockmap_redir_matrix.c

Changes in v3:
- Drop unrelated changes; sockmap_listen, test_sockmap_listen, doc
- Collect tags [Jakub, John]
- Introduce BPF verdict programs especially for sockmap_redir [Jiayuan]
- Link to v2: https://lore.kernel.org/r/20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co

Changes in v2:
- Verify that the unsupported redirect combos do fail [Jakub]
- Dedup tests in sockmap_listen
- Cosmetic changes and code reordering
- Link to v1: https://lore.kernel.org/bpf/42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co/

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (8):
      selftests/bpf: Support af_unix SOCK_DGRAM socket pair creation
      selftests/bpf: Add socket_kind_to_str() to socket_helpers
      selftests/bpf: Add u32()/u64() to sockmap_helpers
      selftests/bpf: Introduce verdict programs for sockmap_redir
      selftests/bpf: Add selftest for sockmap/hashmap redirection
      selftests/bpf: sockmap_listen cleanup: Drop af_vsock redir tests
      selftests/bpf: sockmap_listen cleanup: Drop af_unix redir tests
      selftests/bpf: sockmap_listen cleanup: Drop af_inet SOCK_DGRAM redir tests

 .../selftests/bpf/prog_tests/socket_helpers.h      |  84 +++-
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |  25 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 457 --------------------
 .../selftests/bpf/prog_tests/sockmap_redir.c       | 465 +++++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_redir.c       |  68 +++
 5 files changed, 623 insertions(+), 476 deletions(-)
---
base-commit: d0445d7dd3fd9b15af7564c38d7aa3cbc29778ee
change-id: 20240922-selftests-sockmap-redir-5d839396c75e

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


