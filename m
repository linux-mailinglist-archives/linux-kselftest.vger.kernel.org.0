Return-Path: <linux-kselftest+bounces-30586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF322A85BF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247903B6FF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1920DD47;
	Fri, 11 Apr 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="k3yGkSiJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3E28C5DA;
	Fri, 11 Apr 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371240; cv=none; b=SyQ0ptn9uNLWjhamY0lb9XpYiq6AS/H+8Tdf3cbu8pL/95bLqis9SkfW+wDXlDl1smeilIBiqvfrlWj9MEtXNOpoDjeIlK8blHYmVR9evB4dEYo1QglxYccU8BRke7kaOpcAAYsivYe7NqpmG5kN+CPOSYFvdbGN38QRub8tFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371240; c=relaxed/simple;
	bh=+0ft7eGcqyQDmzGlJ0Y+aX5H8VITeWT84VeYRuys/6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l+GjGZJqNARoY7OGgaupuoI1ctY0E2wuTDyiMg1fV+Y/+KzbaDeRzwz96/K7c54JnxeheeVniVeC98fBk7GCM3qgxalV3x18vBlvvomiWJU9380laqx9eguF7+2r895YTqoeCtCui3rHjfK15y0rfTSQcuvNu7iw2UF92l9nml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=k3yGkSiJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdu-005qN1-6j; Fri, 11 Apr 2025 13:33:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=HsvbAupQVvi3ZHcorjYlvpLENiBtjIaGIq2kqSj09/8=
	; b=k3yGkSiJ8wXMaKPeZl2UC29fr5XaZhRqB4eMMQKTaK5VQVGWk4n5DCzA7pBk8KVuWPy8wmWTU
	8E897ACqyit8WqmN6OPXvAOHY+37xqUtZiKnvTJ1MtHkcH2d1JoT+tXwGjZhpc89Mipr+8C/cO7Hv
	YD36lT8k1+wRRyxbXHPRHdtAPOm7zGzvEYbYHUr4CDoWM4b4J7h6kIXTJMY2CXGVDx8RV+YUqLPzy
	YwAsA3WThRsr1IR6+Sh4Vbu7qeywwEPxV12BroRVeelRiCqwznO2pQ/Jrf30orquVAvvEMdtpKIfM
	F6C6veU74kMO3bFTGgeezJz7iGJULAr7TIiw0A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdj-0005t4-GA; Fri, 11 Apr 2025 13:33:43 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3CdS-00D5Ut-7C; Fri, 11 Apr 2025 13:33:26 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next v2 0/9] selftests/bpf: Test sockmap/sockhash
 redirection
Date: Fri, 11 Apr 2025 13:32:36 +0200
Message-Id: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANT9+GcC/x3MQQrCMBBG4auUWTtQplaNV5EuavJHBzUNmSCF0
 rsbXH6L9zYyFIXRtduo4KumS2qQQ0f+OacHWEMzSS/H3omw4R0rrBrb4l+fOXNB0MJjuAxucCd
 /HkGtzgVR1//5RvccOWGtNO37D7xGsNNzAAAA
X-Change-ID: 20240922-selftests-sockmap-redir-5d839396c75e
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

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

Changes in v2:
- Verify that the unsupported redirect combos do fail [Jakub]
- Dedup tests in sockmap_listen
- Cosmetic changes and code reordering
- Link to v1: https://lore.kernel.org/bpf/42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co/

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (9):
      selftests/bpf: Support af_unix SOCK_DGRAM socket pair creation
      selftests/bpf: Add socket_kind_to_str() to socket_helpers
      selftests/bpf: Add u32()/u64() to sockmap_helpers
      selftests/bpf: Allow setting BPF_F_INGRESS in prog_msg_verdict()
      selftests/bpf: Add selftest for sockmap/hashmap redirection
      selftests/bpf: sockmap_listen cleanup: Drop af_vsock redir tests
      selftests/bpf: sockmap_listen cleanup: Drop af_unix redir tests
      selftests/bpf: sockmap_listen cleanup: Drop af_inet SOCK_DGRAM redir tests
      docs/bpf: sockmap: Add a missing comma

 Documentation/bpf/map_sockmap.rst                  |   2 +-
 .../selftests/bpf/prog_tests/socket_helpers.h      |  84 +++-
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |  25 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 459 +-------------------
 .../selftests/bpf/prog_tests/sockmap_redir.c       | 461 +++++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_listen.c      |   6 +-
 6 files changed, 558 insertions(+), 479 deletions(-)
---
base-commit: a27a97f713947b20ba91b23a3ef77fa92d74171b
change-id: 20240922-selftests-sockmap-redir-5d839396c75e

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


