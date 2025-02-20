Return-Path: <linux-kselftest+bounces-27036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51EFA3CF1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 03:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1983B1891EB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F71DE8AC;
	Thu, 20 Feb 2025 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TELiJNu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A901D79B8
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017371; cv=none; b=mDBxnSz8yDYJOKrpapC6qMYfIqpG1vX7SdvvY9OfiLbGhYUgDUE163qPCXf1Jq/VgmoLGzWyQFzQIgmyvwFJ7vUiBY4eNTn3aeZrApLGZcTi5bv4Bz2IWkyhyQJ6Kyh6J8pNHPuh3h4R3VlEA2oXJzILrFUFy7WEB3EH7ct/vno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017371; c=relaxed/simple;
	bh=8qdnNdfQ/uj2uGtVeB+5gVRxg+q3R/Oiilzxr61Biws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMQvS0n6hfFFunRghG6kfn10dPWm6+F8gmAdiAyqD0gWQx84mRvBPs5jpsP0pkaFhEkiuHY+9tvYO8mGjAgAKtJksS0zdcFmYyoU1PiiEoHP/LZv4tJf4Z4cATSpcvzF5fwLBwRdDPalNZiK9m4AEzug982yAsvzyMF98YsKwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TELiJNu4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22101351b1dso8023905ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 18:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017368; x=1740622168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6BSxKQ00TlgrRbtfolLBJFy1zEtBu3OhJw4muzoQDk=;
        b=TELiJNu4cQ31sOMhLpFyVmDrgC6Innm7xZrrkQRGqOpQwY9dzlchgsA++yqPajDzQg
         5PjMSy2rObL7m/8JPdEvxGJe0omxTJiW2H8Tl4JwVi/5wrDtJu9Y4CupNWr20BqqZZiJ
         AoUZmHOCgrnOXrGuJxDsZjb0AbGHwFxwYGhu87jKCyfbmHe/1e7uHU6Gt9+lHxucRM6q
         jfLqUlMuga5aJqgBBYLVpGJf2jEYseASP2JxHfUIRBm4f/8UL+XQlVFaUlQN2V/SKFRT
         h7v7pK9d6yykP8pFYdkcFxznJuSC6G7TjECyYFvBJhT58o4IEWkNlQwavzBLyvAXK9Rm
         WsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017368; x=1740622168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6BSxKQ00TlgrRbtfolLBJFy1zEtBu3OhJw4muzoQDk=;
        b=EBWAbVklO+QiAn8SuRtSov2JRZ+THboJEISrQmLza1flSVrB1c5qbLx//BA4ULWTEn
         qqj3FjGUQuL/09+5yaJSeJnrJDyaQ/1zy+41JWbrc2cppPxNy6EUuDEOJ0YkISc5BMaN
         AmF2wqdobHCXDq7eX++9m8i1QZv9DRBxtixwlMdQVMDkJPCZnM1xqMBQAzn0/RtPfG3d
         LSfpVo6VALIbDmCF5q+Tya5Cr/YKK3jaNghqkjkwfQKeKZd2e/ajlQKH0C4GHYQ/8Jgv
         sOGymvr+SEPVF3Rn4Rqws3pevZsyviqgNVIqmqO+UjhIXmrPK2gMPZqU5dBdo3abfH3p
         TVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKOBofaEHactKEaqo99PDw9REdiAH6SvRPThpOl05+PcJIFbLcB70SQUXWV9S5pyqVu9lM2Qpykub3Pz8wpkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+YB0LyLvMaB8LQTeoDXJl29t/iKdpGeORdBNp16yi5YvGg1D
	I8JO7Ng9czNjre2fzmrP2JEUG2pNghdnT3YqbiU2f2TJet4Cif0S3ZRVVclzFP/MS7+j/06Q+1+
	OmAOXWikEHusDXaSZjQNJ4A==
X-Google-Smtp-Source: AGHT+IFc+58FEfMgCkmY33XyrttMcD7+XYuckVAKhUGjEipxl0LjYlIOjsWpCf1+0tMH6PT8yDHYnCMGdo2Gw894FQ==
X-Received: from pfbca6.prod.google.com ([2002:a05:6a00:4186:b0:730:848d:a5a3])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d8a:b0:1ee:7d91:59bd with SMTP id adf61e73a8af0-1eed4ff4811mr11266821637.31.1740017367599;
 Wed, 19 Feb 2025 18:09:27 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:09 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-5-almasrymina@google.com>
Subject: [PATCH net-next v4 4/9] net: devmem: make dmabuf unbinding scheduled work
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

The TX path may release the dmabuf in a context where we cannot wait.
This happens when the user unbinds a TX dmabuf while there are still
references to its netmems in the TX path. In that case, the netmems will
be put_netmem'd from a context where we can't unmap the dmabuf,
resulting in a BUG like seen by Stan:

[    1.548495] BUG: sleeping function called from invalid context at drivers/dma-buf/dma-buf.c:1255
[    1.548741] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 149, name: ncdevmem
[    1.548926] preempt_count: 201, expected: 0
[    1.549026] RCU nest depth: 0, expected: 0
[    1.549197]
[    1.549237] =============================
[    1.549331] [ BUG: Invalid wait context ]
[    1.549425] 6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15 Tainted: G        W
[    1.549609] -----------------------------
[    1.549704] ncdevmem/149 is trying to lock:
[    1.549801] ffff8880066701c0 (reservation_ww_class_mutex){+.+.}-{4:4}, at: dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.550051] other info that might help us debug this:
[    1.550167] context-{5:5}
[    1.550229] 3 locks held by ncdevmem/149:
[    1.550322]  #0: ffff888005730208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x40/0xf0
[    1.550530]  #1: ffff88800b148f98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x19/0x80
[    1.550731]  #2: ffff88800b148f18 (slock-AF_INET6){+.-.}-{3:3}, at: __tcp_close+0x185/0x4b0
[    1.550921] stack backtrace:
[    1.550990] CPU: 0 UID: 0 PID: 149 Comm: ncdevmem Tainted: G        W          6.13.0-rc3-00770-gbc9ef9606dc9-dirty #15
[    1.551233] Tainted: [W]=WARN
[    1.551304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    1.551518] Call Trace:
[    1.551584]  <TASK>
[    1.551636]  dump_stack_lvl+0x86/0xc0
[    1.551723]  __lock_acquire+0xb0f/0xc30
[    1.551814]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.551941]  lock_acquire+0xf1/0x2a0
[    1.552026]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552152]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552281]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552408]  __ww_mutex_lock+0x121/0x1060
[    1.552503]  ? dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552648]  ww_mutex_lock+0x3d/0xa0
[    1.552733]  dma_buf_unmap_attachment_unlocked+0x4b/0x90
[    1.552857]  __net_devmem_dmabuf_binding_free+0x56/0xb0
[    1.552979]  skb_release_data+0x120/0x1f0
[    1.553074]  __kfree_skb+0x29/0xa0
[    1.553156]  tcp_write_queue_purge+0x41/0x310
[    1.553259]  tcp_v4_destroy_sock+0x127/0x320
[    1.553363]  ? __tcp_close+0x169/0x4b0
[    1.553452]  inet_csk_destroy_sock+0x53/0x130
[    1.553560]  __tcp_close+0x421/0x4b0
[    1.553646]  tcp_close+0x24/0x80
[    1.553724]  inet_release+0x5d/0x90
[    1.553806]  sock_close+0x4a/0xf0
[    1.553886]  __fput+0x9c/0x2b0
[    1.553960]  task_work_run+0x89/0xc0
[    1.554046]  do_exit+0x27f/0x980
[    1.554125]  do_group_exit+0xa4/0xb0
[    1.554211]  __x64_sys_exit_group+0x17/0x20
[    1.554309]  x64_sys_call+0x21a0/0x21a0
[    1.554400]  do_syscall_64+0xec/0x1d0
[    1.554487]  ? exc_page_fault+0x8a/0xf0
[    1.554585]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.554703] RIP: 0033:0x7f2f8a27abcd

Resolve this by making __net_devmem_dmabuf_binding_free schedule_work'd.

Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c |  4 +++-
 net/core/devmem.h | 10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 2e576f80b1d8..4af9f754f6ff 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -55,8 +55,10 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
 	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
 }
 
-void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
+	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
+
 	size_t size, avail;
 
 	gen_pool_for_each_chunk(binding->chunk_pool,
diff --git a/net/core/devmem.h b/net/core/devmem.h
index a8b79c0e01b3..861150349825 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -54,6 +54,8 @@ struct net_devmem_dmabuf_binding {
 	 * net_iovs in the TX path.
 	 */
 	struct net_iov **tx_vec;
+
+	struct work_struct unbind_w;
 };
 
 #if defined(CONFIG_NET_DEVMEM)
@@ -70,7 +72,7 @@ struct dmabuf_genpool_chunk_owner {
 	dma_addr_t base_dma_addr;
 };
 
-void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
+void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
@@ -121,7 +123,8 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	if (!refcount_dec_and_test(&binding->ref))
 		return;
 
-	__net_devmem_dmabuf_binding_free(binding);
+	INIT_WORK(&binding->unbind_w, __net_devmem_dmabuf_binding_free);
+	schedule_work(&binding->unbind_w);
 }
 
 void net_devmem_get_net_iov(struct net_iov *niov);
@@ -154,8 +157,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 {
 }
 
-static inline void
-__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+static inline void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 }
 
-- 
2.48.1.601.g30ceb7b040-goog


