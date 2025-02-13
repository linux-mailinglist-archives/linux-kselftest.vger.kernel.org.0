Return-Path: <linux-kselftest+bounces-26536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B740A33E92
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A832F188C466
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AFA21D3EB;
	Thu, 13 Feb 2025 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Km/QdEei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA80207679;
	Thu, 13 Feb 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447984; cv=none; b=Esqx3T8A7aPPBm8kCK0G/484nMVAFlEjvzTTYEg/6gCrOTGqkvvheqitX/bW0Jue75giKy/v/JNWbLgMZnjRhqNzCXtYIy+2L7fkHWKaZmBxq9SUQCdgePanDyo9yawQlDNg87TqrPnmO7pK2iJSSzbnnzhpPdZOCQTjmH2bqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447984; c=relaxed/simple;
	bh=M6xHy0PaBRNYWRNxSZCbYoFZj0B7Im/gkJxtcK2w4P0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CjtxCgOQLwC8OtbALr1zXjIYWwYBE4SHpHFHivuXiEtwFOwgqEvMaKB8YTDhoRlNlOxMo4hak44z7o6we/m18wwvkp11/nIBo9V8FnEiXAVHImN1gp5XBNjHJY+dZv6dtsE2Gt5pdHvgniuv/oeXiJspb+CG6Q9VBhNMYRyEfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Km/QdEei; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsR-002RrJ-Bp; Thu, 13 Feb 2025 12:59:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=MJxuBFt87kX2zvCd0qkdSTjP0KE9NQ09/Go+P1LdO8w=
	; b=Km/QdEeiW+wJfB4HcnZ2vizgg/6ZsEd0R+Pywlq4RCj+ZvmL6z3AM1JTpsS4x10JeH+agLY7j
	Ex5xZz8bOLyFybbpkSq2TENG9IldBecrzVsvY1GY0d7AI85SacJw9mS/X3oKkwDKd34h6zgve6ZFx
	3IBaiegUy+RyaIAK8lktwkrVChpg784HWhoJFmZvLPjry+1Ap/eqbdpN+UqYOw6UCfYEgMKWxSES+
	zcBJAknGqs5GZJ3/Xuw9kGF+sPydmyEHwFN/Yk+Za5Ql/K6cJW94n03x5AzIVvXV17YP5nFcCn5/4
	sjiMO0kaBTQ7fHxY6oS31NDSVWU/mKPAm6fb1A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsP-0005H5-NV; Thu, 13 Feb 2025 12:59:29 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tiXs9-008u87-0O; Thu, 13 Feb 2025 12:59:13 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 0/4] sockmap, vsock: For connectible sockets allow only
 connected
Date: Thu, 13 Feb 2025 12:58:48 +0100
Message-Id: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjerWcC/x3MywrCMBBG4Vcps3YgCVgvryIuQvzVwTgNmbQIp
 e9udHe+zVnJUAVG52GlikVMJu3wu4HSM+oDLLduCi7sXfCOF5vSi7NYg/Kv37GwzjmXVhkjjiH
 Fw2n0nvqiVNzl899fSNHoum1f0a+gwHMAAAA=
X-Change-ID: 20250210-vsock-listen-sockmap-nullptr-e6e82ca79611
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Series deals with one more case of vsock surprising BPF/sockmap by being
inconsistency about (having an) assigned transport.

KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
CPU: 7 UID: 0 PID: 56 Comm: kworker/7:0 Not tainted 6.14.0-rc1+
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:vsock_read_skb+0x4b/0x90
Call Trace:
 sk_psock_verdict_data_ready+0xa4/0x2e0
 virtio_transport_recv_pkt+0x1ca8/0x2acc
 vsock_loopback_work+0x27d/0x3f0
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x35a/0x700
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

This bug, similarly to commit f6abafcd32f9 ("vsock/bpf: return early if
transport is not assigned"), could be fixed with a single NULL check. But
instead, let's explore another approach: take a hint from
vsock_bpf_update_proto() and teach sockmap to accept only vsocks that are
already connected (no risk of transport being dropped or reassigned). At
the same time straight reject the listeners (vsock listening sockets do not
carry any transport anyway). This way BPF does not have to worry about
vsk->transport becoming NULL.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (4):
      sockmap, vsock: For connectible sockets allow only connected
      vsock/bpf: Warn on socket without transport
      selftest/bpf: Adapt vsock_delete_on_close to sockmap rejecting unconnected
      selftest/bpf: Add vsock test for sockmap rejecting unconnected

 net/core/sock_map.c                                |  3 +
 net/vmw_vsock/af_vsock.c                           |  3 +
 net/vmw_vsock/vsock_bpf.c                          |  2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 70 ++++++++++++++++------
 4 files changed, 59 insertions(+), 19 deletions(-)
---
base-commit: 9c01a177c2e4b55d2bcce8a1f6bdd1d46a8320e3
change-id: 20250210-vsock-listen-sockmap-nullptr-e6e82ca79611

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


