Return-Path: <linux-kselftest+bounces-31625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D0A9BE43
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 08:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7324A1B882A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 06:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCA22B581;
	Fri, 25 Apr 2025 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ny8/XG3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF887227E93
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560858; cv=none; b=nrgDt2n/5XR/4VNGDBHUfzmaD2ba6JQLmVLgN+4SETHI9iXTV/D8cRQmEL445vDjURNHT1id6OAsL0JF10ZGCRDnqws6xQK6gLrCuGRN36eXyWL3qa3Yws3lUIYdxQxgAxVpP5TQD5nDlRe28psQYyQrtx7RUC+3UZB2rV2bqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560858; c=relaxed/simple;
	bh=jmofsGFzLjmgZ8ZBCzLdrMPiUlRLdu+MBWlrZwAXVeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrfWw2ufgWp/63tCU0GnAviOFfKkOiErjTn338gV5u2Sl0LVWggwvbZ9+GwPjQO8lEkrwVmooJxtuLNCcfQBgeqm+R9Ez6JMYXPwH4AOllnbvaPGeZtNCi7BK/tEYXaZblPXqu/SLN1hvRqucstv6a4rLYyCdcAlQU5sKC1Gfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ny8/XG3w; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745560854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=728Q82xIBCh00I19CJB2+kqGL8qnI1hZCn1gPW8uhgQ=;
	b=Ny8/XG3weuD2QLv7a96dCx27f+T9mKGu+xSN0+phkLpgGAWB6LL/BX7Y5osUbgmU+veCc8
	wQJ1Aa49YNzkrafeX+eNyZ14rI9kadjw4HM14o18tlasdtgnx1Vj5BnaKaypyupOMD+NqH
	Nr38j+reLw3dc7boGfSOet5+JFwuYrk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 0/2] ktls, sockmap: Fix missing uncharge operation and add selfttest
Date: Fri, 25 Apr 2025 13:59:56 +0800
Message-ID: <20250425060015.6968-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cong reported a warning when running ./test_sockmp:
https://lore.kernel.org/bpf/aAmIi0vlycHtbXeb@pop-os.localdomain/T/#t

------------[ cut here ]------------
WARNING: CPU: 1 PID: 40 at net/ipv4/af_inet.c inet_sock_destruct+0x173/0x1d5
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
Workqueue: events sk_psock_destroy
RIP: 0010:inet_sock_destruct+0x173/0x1d5
RSP: 0018:ffff8880085cfc18 EFLAGS: 00010202
RAX: 1ffff11003dbfc00 RBX: ffff88801edfe3e8 RCX: ffffffff822f5af4
RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff88801edfe16c
RBP: ffff88801edfe184 R08: ffffed1003dbfc31 R09: 0000000000000000
R10: ffffffff822f5ab7 R11: ffff88801edfe187 R12: ffff88801edfdec0
R13: ffff888020376ac0 R14: ffff888020376ac0 R15: ffff888020376a60
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556365155830 CR3: 000000001d6aa000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __sk_destruct+0x46/0x222
 sk_psock_destroy+0x22f/0x242
 process_one_work+0x504/0x8a8
 ? process_one_work+0x39d/0x8a8
 ? __pfx_process_one_work+0x10/0x10
 ? worker_thread+0x44/0x2ae
 ? __list_add_valid_or_report+0x83/0xea
 ? srso_return_thunk+0x5/0x5f
 ? __list_add+0x45/0x52
 process_scheduled_works+0x73/0x82
 worker_thread+0x1ce/0x2ae


When we specify apply_bytes, we divide the msg into multiple segments,
each with a length of 'send', and every time we send this part of the data
using tcp_bpf_sendmsg_redir(), we use sk_msg_return_zero() to uncharge the
memory of the specified 'send' size.

However, if the first segment of data fails to send, for example, the
peer's buffer is full, we need to release all of the msg. When releasing
the msg, we haven't uncharged the memory of the subsequent segments.

This modification does not make significant logical changes, but only
fills in the missing uncharge places.

This issue has existed all along, until it was exposed after we added the
apply test in test_sockmap:

commit 3448ad23b34e ("selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in test_sockmap")


Jiayuan Chen (2):
  ktls, sockmap: Fix missing uncharge operation
  selftests/bpf: Add test to cover sockmap with ktls

 net/tls/tls_sw.c                              |  7 ++
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 76 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   | 10 +++
 3 files changed, 93 insertions(+)

-- 
2.47.1


