Return-Path: <linux-kselftest+bounces-17731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E59974CDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B96DB2487B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFC158DB1;
	Wed, 11 Sep 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhEgXQSc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgc+CZrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878114B970;
	Wed, 11 Sep 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044108; cv=none; b=kYDvXPmLapLKwSUG6oR6RCbYQQNiH2qCZOWxGWg2TKKc49RF59at1peO/d0A/eUPyiYto98b9CrMBx3lrqUWibpbbNdsj72icyhbGCo8cIepeaZODl4s/xkNRIup6fQWIFtZ0/ebYrjhQXAOOgfwLrETLIRchrK2OUcv4UdT3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044108; c=relaxed/simple;
	bh=v9ASjx4AkQY74pBrfJHdygw7QDJW6F3tTHqu14JlvZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXVLoR8FA6XmM5alwEExo9lFNkj1hafzBC8AOKuHsry81oZFt2lNvfbmoRyiL6UU/wMFKkgfRBPeklBbtC4siOfDTdQHqMQ7u6jUg0gbYPCfRaPpIYuVYiv/O3D9Hj/1drUe6NBLW0yduKOwzs77vw2IKUDHDgEcl/AQANTPF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhEgXQSc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgc+CZrE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726044104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCULmNkmiSeT1SnEcJ8wNOTPBOtklSrol+/kqbWcEAw=;
	b=bhEgXQSchtWH18gcr/HQvYUvbrCM5iUrelOA3cYXRu2Z2rjbaOFLJp4vfEgMAJ6ON4fUj9
	h5ab+Ue0Z4pyENaHcsTdhMgEpRPFdcoVcENP2iCnW9j9p8oi4HgVpHWRnuoAZ/7x4YjNYc
	aV3A07+P2zYL4ctwI3KpUNl+UgwjvbrPh+6V6FOx/iqe0b0uSId0iMNY6eILEswFZpoofU
	O/caQdLc8qSKpzwsQR/L4nf0R27zZsb1mxnLp6Hau33HTH8escjmT+INByNHV6r+ImWQVk
	zwgSx4qygAjREsU1RQW4pOYosOWBwt3pllzOLaXVny9bQYXlPzGdqf7mFJlM0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726044104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCULmNkmiSeT1SnEcJ8wNOTPBOtklSrol+/kqbWcEAw=;
	b=cgc+CZrExZcJBwgesbkqbRhd18JSytXbxsLH0ZWByVL9LopJH8Kp3EZgGlW4nBkL0jirOh
	RAnBPCi1jxqPkGAw==
Date: Wed, 11 Sep 2024 10:41:18 +0200
Subject: [PATCH net v4 1/2] bpf: devmap: provide rxq after redirect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240911-devel-koalo-fix-ingress-ifindex-v4-1-5c643ae10258@linutronix.de>
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
In-Reply-To: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, 
 linux-kselftest@vger.kernel.org, 
 Florian Kauer <florian.kauer@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6103;
 i=florian.kauer@linutronix.de; h=from:subject:message-id;
 bh=v9ASjx4AkQY74pBrfJHdygw7QDJW6F3tTHqu14JlvZQ=;
 b=owEBbQKS/ZANAwAKATKF5IolV+EkAcsmYgBm4Ve6MPcHYthOpj3QwG5K34ri6AzSgCcjk1qED
 WBLEst0UgaJAjMEAAEKAB0WIQSG5cmCLvpm5t9g7UUyheSKJVfhJAUCZuFXugAKCRAyheSKJVfh
 JMDyEADPwFul85JXxTF8VCeFcGCpddTKFHKcTtinJg5aFdccvcfNtX58rf37Zy96r5/1Y8+PqvJ
 9ccHqzanZyPzf0IR8W6+VcLfd2pBm9PpMnrIGyKIvS2nhxNc5mRnDmXkjEYtGXDnLyDH5bqp8EU
 PHe6pf+N92MkRuSoaaJJ7B094BsuGKhxtawnBhFCoVb2u7e61Yy4S/d0UGxQzlbk/dBA++Nrl3M
 ArUPQNW4GLnY7uFn8HxA+RKka3wE2xZB8ThBKzPcZv5Os4v+OBgtTEpcK/laF2YC7IqC6MiVPA3
 HQxQvxVhgs4vx3WIAVUnIlxADuCRDsOGSH78R73lSDMJLCLcbYYHM9FOcCtQsS/dJLiDsc2NQSS
 lHZQPdu7UfXKDefx0WdiqZ+Zot9sJW90/UuQsmU36y4X0Q+7ApHnv7UrUQ5uzTlbcoklL4Psv4T
 bT5xxQftzE/waB0vmIx386+SxGw2PkuEmwfCBk2iQzkxKbNKFrqevv8sJ+lCgMwiL6HmW4blCGu
 OKEc/rP1pjeQTi3micI5v6NK5r0fpt1x/5ovkA/LY0ScLEb+KMLbFLSDx5cMcy2xyrQk4S3YzFh
 s9kEGb6InEsHN/TQ0iXQmeeEIJqzANEE37owboXc5Rp3wy66PfTimvXSbvn8xebs2oZ/sw/+wIC
 k2inveGEOsEu9GQ==
X-Developer-Key: i=florian.kauer@linutronix.de; a=openpgp;
 fpr=F17D8B54133C2229493E64A0B5976DD65251944E

rxq contains a pointer to the device from where
the redirect happened. Currently, the BPF program
that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
does not have it set.

This is particularly bad since accessing ingress_ifindex, e.g.

SEC("xdp")
int prog(struct xdp_md *pkt)
{
        return bpf_redirect_map(&dev_redirect_map, 0, 0);
}

SEC("xdp/devmap")
int prog_after_redirect(struct xdp_md *pkt)
{
        bpf_printk("ifindex %i", pkt->ingress_ifindex);
        return XDP_PASS;
}

depends on access to rxq, so a NULL pointer gets dereferenced:

<1>[  574.475170] BUG: kernel NULL pointer dereference, address: 0000000000000000
<1>[  574.475188] #PF: supervisor read access in kernel mode
<1>[  574.475194] #PF: error_code(0x0000) - not-present page
<6>[  574.475199] PGD 0 P4D 0
<4>[  574.475207] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[  574.475217] CPU: 4 UID: 0 PID: 217 Comm: kworker/4:1 Not tainted 6.11.0-rc5-reduced-00859-g780801200300 #23
<4>[  574.475226] Hardware name: Intel(R) Client Systems NUC13ANHi7/NUC13ANBi7, BIOS ANRPL357.0026.2023.0314.1458 03/14/2023
<4>[  574.475231] Workqueue: mld mld_ifc_work
<4>[  574.475247] RIP: 0010:bpf_prog_5e13354d9cf5018a_prog_after_redirect+0x17/0x3c
<4>[  574.475257] Code: cc cc cc cc cc cc cc 80 00 00 00 cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 57 20 <48> 8b 52 00 8b 92 e0 00 00 00 48 bf f8 a6 d5 c4 5d a0 ff ff be 0b
<4>[  574.475263] RSP: 0018:ffffa62440280c98 EFLAGS: 00010206
<4>[  574.475269] RAX: ffffa62440280cd8 RBX: 0000000000000001 RCX: 0000000000000000
<4>[  574.475274] RDX: 0000000000000000 RSI: ffffa62440549048 RDI: ffffa62440280ce0
<4>[  574.475278] RBP: ffffa62440280c98 R08: 0000000000000002 R09: 0000000000000001
<4>[  574.475281] R10: ffffa05dc8b98000 R11: ffffa05f577fca40 R12: ffffa05dcab24000
<4>[  574.475285] R13: ffffa62440280ce0 R14: ffffa62440549048 R15: ffffa62440549000
<4>[  574.475289] FS:  0000000000000000(0000) GS:ffffa05f4f700000(0000) knlGS:0000000000000000
<4>[  574.475294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  574.475298] CR2: 0000000000000000 CR3: 000000025522e000 CR4: 0000000000f50ef0
<4>[  574.475303] PKRU: 55555554
<4>[  574.475306] Call Trace:
<4>[  574.475313]  <IRQ>
<4>[  574.475318]  ? __die+0x23/0x70
<4>[  574.475329]  ? page_fault_oops+0x180/0x4c0
<4>[  574.475339]  ? skb_pp_cow_data+0x34c/0x490
<4>[  574.475346]  ? kmem_cache_free+0x257/0x280
<4>[  574.475357]  ? exc_page_fault+0x67/0x150
<4>[  574.475368]  ? asm_exc_page_fault+0x26/0x30
<4>[  574.475381]  ? bpf_prog_5e13354d9cf5018a_prog_after_redirect+0x17/0x3c
<4>[  574.475386]  bq_xmit_all+0x158/0x420
<4>[  574.475397]  __dev_flush+0x30/0x90
<4>[  574.475407]  veth_poll+0x216/0x250 [veth]
<4>[  574.475421]  __napi_poll+0x28/0x1c0
<4>[  574.475430]  net_rx_action+0x32d/0x3a0
<4>[  574.475441]  handle_softirqs+0xcb/0x2c0
<4>[  574.475451]  do_softirq+0x40/0x60
<4>[  574.475458]  </IRQ>
<4>[  574.475461]  <TASK>
<4>[  574.475464]  __local_bh_enable_ip+0x66/0x70
<4>[  574.475471]  __dev_queue_xmit+0x268/0xe40
<4>[  574.475480]  ? selinux_ip_postroute+0x213/0x420
<4>[  574.475491]  ? alloc_skb_with_frags+0x4a/0x1d0
<4>[  574.475502]  ip6_finish_output2+0x2be/0x640
<4>[  574.475512]  ? nf_hook_slow+0x42/0xf0
<4>[  574.475521]  ip6_finish_output+0x194/0x300
<4>[  574.475529]  ? __pfx_ip6_finish_output+0x10/0x10
<4>[  574.475538]  mld_sendpack+0x17c/0x240
<4>[  574.475548]  mld_ifc_work+0x192/0x410
<4>[  574.475557]  process_one_work+0x15d/0x380
<4>[  574.475566]  worker_thread+0x29d/0x3a0
<4>[  574.475573]  ? __pfx_worker_thread+0x10/0x10
<4>[  574.475580]  ? __pfx_worker_thread+0x10/0x10
<4>[  574.475587]  kthread+0xcd/0x100
<4>[  574.475597]  ? __pfx_kthread+0x10/0x10
<4>[  574.475606]  ret_from_fork+0x31/0x50
<4>[  574.475615]  ? __pfx_kthread+0x10/0x10
<4>[  574.475623]  ret_from_fork_asm+0x1a/0x30
<4>[  574.475635]  </TASK>
<4>[  574.475637] Modules linked in: veth br_netfilter bridge stp llc iwlmvm x86_pkg_temp_thermal iwlwifi efivarfs nvme nvme_core
<4>[  574.475662] CR2: 0000000000000000
<4>[  574.475668] ---[ end trace 0000000000000000 ]---

Therefore, provide it to the program by setting rxq properly.

Fixes: cb261b594b41 ("bpf: Run devmap xdp_prog on flush instead of bulk enqueue")
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
---
 kernel/bpf/devmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9e0e3b0a18e4..7878be18e9d2 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -333,9 +333,11 @@ static int dev_map_hash_get_next_key(struct bpf_map *map, void *key,
 
 static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 				struct xdp_frame **frames, int n,
-				struct net_device *dev)
+				struct net_device *tx_dev,
+				struct net_device *rx_dev)
 {
-	struct xdp_txq_info txq = { .dev = dev };
+	struct xdp_txq_info txq = { .dev = tx_dev };
+	struct xdp_rxq_info rxq = { .dev = rx_dev };
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
@@ -346,6 +348,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
+		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		switch (act) {
@@ -360,7 +363,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 			bpf_warn_invalid_xdp_action(NULL, xdp_prog, act);
 			fallthrough;
 		case XDP_ABORTED:
-			trace_xdp_exception(dev, xdp_prog, act);
+			trace_xdp_exception(tx_dev, xdp_prog, act);
 			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame_rx_napi(xdpf);
@@ -388,7 +391,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	}
 
 	if (bq->xdp_prog) {
-		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
+		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev, bq->dev_rx);
 		if (!to_send)
 			goto out;
 	}

-- 
2.39.2


