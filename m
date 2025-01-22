Return-Path: <linux-kselftest+bounces-24921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3400A18F54
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 11:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EB4188CA00
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934A211269;
	Wed, 22 Jan 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TTbd3Pd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB21F7914;
	Wed, 22 Jan 2025 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540695; cv=none; b=rgx/c62FI6Eld7wL41pz6+CEzxUSiU7MyBs+vrqqh6HP7ruX99o9BzZ/0yNar8lgexOUVuPD50/8GIaBi9foxVYMhlQIenSJT+OtUy3EdtTFCzCfavw+bgfetM0pS0dC6UV2XpBKS9ZtxiGTpQHDhRxJ/CchTowM2gp4MvVTW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540695; c=relaxed/simple;
	bh=nKWu84r5RQKGBqm5xElMSa7RfxVJ2SqHd74Gi/uAVuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kp1FtTeBwC5OQziVYKOwkfCBvnHhSTlivX8/QFiL1+7DpFVMFx1K68p3/o7R0rie1B0q4YpkrQAlPo9EdK827n1uKZ2kOhJmBb+9puU0c9rxKbr/nemr+MeTFEJAnysQOR0w8/HOKiBWK3RSHtn0L05pNbCmL9BadE8Pu3Yv9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TTbd3Pd0; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=QWWYmC4TDSJZjNRxBuhFocor1RdCIg5ChEjlLlaKCnE=;
	b=TTbd3Pd0dveYS7fHJATPaag2gs30E4nPLyWYVMolF8pHbrYMPef9j+M9Qj2Nrv
	XTvDgj5Qg9wDCvaP0c3/V1L9QfxleGnfRMMxzF0L6W6Y+tP23cN1XMuXHayj0Gx9
	lZJd78gN0AczG1xChg2EwdZ4pg2nbtCJKh5PWE+QLkk3Q=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHUcjUw5Bn_UIhKA--.64788S2;
	Wed, 22 Jan 2025 18:09:36 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v9 0/5] bpf: fix wrong copied_seq calculation and add tests
Date: Wed, 22 Jan 2025 18:09:12 +0800
Message-ID: <20250122100917.49845-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHUcjUw5Bn_UIhKA--.64788S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5ZrWfpa
	ykC34rGr47tFyxZws7A3yIqF4Fgw4rGay5KF1Fq3yfZF4jkryjvrs29F1aqr98GrWY9F1U
	Cr13Wr4Y934UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_pnQ7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwjcp2eQr31LCwACsb

A previous commit described in this topic
http://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
directly updated 'sk->copied_seq' in the tcp_eat_skb() function when the
action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
the update logic for 'sk->copied_seq' was moved to
tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.

That commit works for a single stream_verdict scenario, as it also
modified 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
to remove updating 'sk->copied_seq'.

However, for programs where both stream_parser and stream_verdict are
active (strparser purpose), tcp_read_sock() was used instead of
tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock).
tcp_read_sock() now still updates 'sk->copied_seq', leading to duplicated
updates.

In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
in both tcp_read_sock() and tcp_bpf_recvmsg_parser().

The issue causes incorrect copied_seq calculations, which prevent
correct data reads from the recv() interface in user-land.

Also we added test cases for bpf + strparser and separated them from
sockmap_basic, as strparser has more encapsulation and parsing
capabilities compared to sockmap.

---
V8 -> v9
https://lore.kernel.org/bpf/20250121050707.55523-1-mrpre@163.com/
Fixed some issues suggested by Jakub Sitnicki.

V7 -> V8
https://lore.kernel.org/bpf/20250116140531.108636-1-mrpre@163.com/
Avoid using add read_sock to psock. (Jakub Sitnicki)
Avoid using warpper function to check whether strparser is supported.

V3 -> V7:
https://lore.kernel.org/bpf/20250109094402.50838-1-mrpre@163.com/
https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
Avoid introducing new proto_ops. (Jakub Sitnicki).
Add more edge test cases for strparser + bpf.
Fix patchwork fail of test cases code.
Fix psock fetch without rcu lock.
Move code of modifying to tcp_bpf.c.

V1 -> V3:
https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/
Fix patchwork fail by adding Fixes tag.
Save skb data offset for ENOMEM. (John Fastabend)
---

Jiayuan Chen (5):
  strparser: add read_sock callback
  bpf: fix wrong copied_seq calculation
  bpf: disable non stream socket for strparser
  selftests/bpf: fix invalid flag of recv()
  selftests/bpf: add strparser test for bpf

 Documentation/networking/strparser.rst        |   9 +-
 include/linux/skmsg.h                         |   2 +
 include/net/strparser.h                       |   2 +
 include/net/tcp.h                             |   8 +
 net/core/skmsg.c                              |   7 +
 net/core/sock_map.c                           |   5 +-
 net/ipv4/tcp.c                                |  29 +-
 net/ipv4/tcp_bpf.c                            |  36 ++
 net/strparser/strparser.c                     |  11 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  59 +--
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 454 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  53 ++
 12 files changed, 610 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

-- 
2.43.5


