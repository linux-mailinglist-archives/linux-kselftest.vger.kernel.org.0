Return-Path: <linux-kselftest+bounces-24821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B4A176D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 06:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8490016A1D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 05:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DB1AAE0B;
	Tue, 21 Jan 2025 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rz/DqcEg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1D1A724C;
	Tue, 21 Jan 2025 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737436176; cv=none; b=If60nVgwlnZtmi8EhqHgM97oMgeGF9Xxg781xtclSJLcNOI8Y/7I15P5O8Xhfu6Oi7HLuN7lIY4V1dYd7N7AS2CjfHRZK/KvT6uuyF/Byv3tV73cuIpU37eqB8oL9cpeQoDBNtMgx6VnEvTll2SBYckHHB316b1iOsObkVRzjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737436176; c=relaxed/simple;
	bh=MRbFXBRyZ6VO80r/tbLavWPYGstR7hTNcSTo0dkY3NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwaPS8r6FheMMIcJACT37XHEJd0zumHeaFpax7SOfAItDVSPBejMZjgzAGLK5C3z/JX/NJN/v5RvM/BigzbUWLNRL5bYXorIkbOYYRS3e4v7r0gDiKAYJwU+v1yPLj7aHC1Ytg9BPnvTFYuFvksUvKZYQsL1qyYFL3FSaNL/Mlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rz/DqcEg; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=bTS2v
	udIGnYCF5+bPeCAZ9C/WoAScG4XWVTYcSjmUXw=; b=Rz/DqcEghOON4BUZsxO6S
	scO9I2lh9KWFFudRqRIF9/jeJGLZ71jNQstWO8c+U2hdvlDN009kjaexrYSW5Zwx
	PhLWvloeWx+e9o1DR3ww/Lzbfd68P741yVio4xCgyNiSlGLrVgQLo+FEZy/L5B8E
	Cg/7h3A054zu8Pff8zy1dk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHwYeaK49nTErMHA--.41409S2;
	Tue, 21 Jan 2025 13:07:49 +0800 (CST)
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
Subject: [PATCH bpf v8 0/5] bpf: fix wrong copied_seq calculation and add tests
Date: Tue, 21 Jan 2025 13:07:02 +0800
Message-ID: <20250121050707.55523-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHwYeaK49nTErMHA--.41409S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrGFyfXw4kuryDAFyxKrg_yoW5Cw1DpF
	WkC34rGr47tFyIva1DA3yIgF4Fgw4rGay5KF1Fq3yfZr4jkryYyrs293Waqrn8GrWYvF1j
	9r13Wr4Y934DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_pnQ7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxPbp2ePHI2amQACsY

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
active(strparser purpose), tcp_read_sock() was used instead of
tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
updates.

In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
in both tcp_read_sock() and tcp_bpf_recvmsg_parser().

The issue causes incorrect copied_seq calculations, which prevent
correct data reads from the recv() interface in user-land.

Also we added test cases for bpf + strparser and separated them from
sockmap_basic, as strparser has more encapsulation and parsing
capabilities compared to sockmap.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")

---
V8 -> V7:
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
 net/ipv4/tcp_bpf.c                            |  42 ++
 net/strparser/strparser.c                     |  11 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  59 +--
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 452 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  53 ++
 12 files changed, 614 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_strp.c

-- 
2.43.5


