Return-Path: <linux-kselftest+bounces-27285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF0A40B3D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 20:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F7189F4FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 19:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4920E702;
	Sat, 22 Feb 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpXbPI1h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39920FAA2
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Feb 2025 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251730; cv=none; b=MQLoHXnaymMuGJpQSMK0iDipGcT5XislW6o373bJs7t9j84pvc5qd0ErI6JbR3LEMY6d6vwKTOaWGSkrXFanAWfECYAOll1dyDl0ixXnl6mvjNzrouxFCGqzq0O9yshkamU61NZZTuNzC2GrxhVbZFCfNHFtyA2un7Cod9XOgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251730; c=relaxed/simple;
	bh=E/P7rPxR4Kk1M6YTaZjfUiSuLdbUI4t3yFFBc5WKH3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DdU364pVkzJ5hR7yTpv3GxRjug8jDYc5Mzi1TzSl/EkmkwnveTL+ehWsGdJ/X88SA9bZHpxPDJppt9gMMOQowvueCGOhnw0BDHBqjz5ze7yfQmoQ73RZD2wBeMovDjvlhOLlPvESRMaiEJfb6wdRRPjixZPBPceY+2dHoRqvIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpXbPI1h; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220e1593b85so62065825ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Feb 2025 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740251727; x=1740856527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUeVNgWGUp7ktC/YEhqD+3gJ3Ib6eWIiGMQ6DKQeydo=;
        b=WpXbPI1hbKKhh0erQ7K3reSfQpu66tfQVQP654f7TDA9449mO1eXA32Xl0yNKI4cOu
         E34xIHcurZ0KALJN7XRYiGwsdzwOmeaega/r/reE/JWZPFGM8wvPa4jaHg8DBCHUcnNP
         46RoPAFT0aDWhar/v4FpllrrYIy6VpI+tzq2G8MfJnVeKSzjYjHo4oEWHclBH1zDd+15
         EfRlcVhEhhPE/kGcSu1TE3w73+LqdYqHQiMpedA+M2CbPyI2QNSbsFzZg1Xov6YR+Agn
         NAjjgfLUwDxNyuiasPBE0vGAEKuxMz/7Xq2KVirmlGmoaGRvlqFPZh8Jn47R2KyKj6fY
         eYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251727; x=1740856527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUeVNgWGUp7ktC/YEhqD+3gJ3Ib6eWIiGMQ6DKQeydo=;
        b=tTAJ4ONhEnrv0aXaCeU/tG5BMifw4JXUaJf96BsHFzMJ3hNAr1saAA3CziJ8Wx5wy5
         RMujZY8zB30NereQtbDOs8Z4KlCG8t0yu6pfL9uHkMi+GEgAwhf6Zb+c79mqUceSg0Aa
         Y3UCDljMMdfeVqhwvP6wy4vdy0NH4d8G22c7G9mFrSNB8ufC4sLY/w0EPSigHWUqCegP
         HQCBBhJmwNM89kJfkn1uafv9ySj1GrxlHlvV6vrBOBICVfj2HmhOdMQXXR0j+a0mzvwB
         Uhhnv48WSlvrzSS1fLzj98NPh/WHTJX15L1GVAW8Bu6L5xmSCGJI6mH1Uvad8gG4sjxQ
         8bQA==
X-Forwarded-Encrypted: i=1; AJvYcCWFnsj9VgcS+2ScVT+k0IhMpuhQpDL60XlW+dGXbhwHEUFYnGpbbOhWfoD2GBvIWvH1zFPcGiYTLPTiLMc+xEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9mvPBKKDhCnPAixOlk21KG4w4VzduC/xRDI0qfDXTI7oxfxx
	hwLrMKVOoegu5uyb9lhgXAqVfJBRhyLi1TD83cDOMF9AG6DnhdT7JVV1oFjrt8Qt1Narfc+dZYV
	555mrQouumXrasqUIgthBRA==
X-Google-Smtp-Source: AGHT+IEk/SyxiiKUwYqu42o8ilQTEtdwmxUvqDOqkfVjhLyldlpx8hpol9aqi8Y0N2cdPnmHqxqGFy4YpekVtRbslQ==
X-Received: from pfbfc26.prod.google.com ([2002:a05:6a00:2e1a:b0:730:7d23:bc34])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e87:b0:730:91fc:f9c4 with SMTP id d2e1a72fcca58-73426d8fa7dmr12105412b3a.24.1740251727269;
 Sat, 22 Feb 2025 11:15:27 -0800 (PST)
Date: Sat, 22 Feb 2025 19:15:12 +0000
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250222191517.743530-5-almasrymina@google.com>
Subject: [PATCH net-next v5 4/9] net: devmem: make dmabuf unbinding scheduled work
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c |  4 +++-
 net/core/devmem.h | 10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index e5941f8e29df..7a0ce705a703 100644
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


