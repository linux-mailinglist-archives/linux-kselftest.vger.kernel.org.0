Return-Path: <linux-kselftest+bounces-25621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B4A266F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923B41882B2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A521323A;
	Mon,  3 Feb 2025 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05SV4dk/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740F212D6E
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622370; cv=none; b=ehuuWzuSiGVsfdRgiTNqELhMUYx+eW09OvWhWVlfusmqpOmM5kaBbx1TeZDqMVPowQlFzBeiXWTGRoRsfqhsgbWA6Bf0ZxuYcSpXQiDtHXIrvGJtvIdKb8RYgdnp4xEXhUkLdDpb9YP/UEM/XKHZ6kJAJK9d/IanWLtF36bdJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622370; c=relaxed/simple;
	bh=97oOx4z9pCZ0Iq/ojWzrHOGygbt98r31tFw6EuDjFTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Op8evCFLT3ojDQksS8IIzqrQO4080I4Uy6hZednpbRw/6jRLPFd6xxUCRfSs555GaeWXf7/LXS6lkBAG9eYIKQvG3GFf5ai5oNIIHeO5NI0mmIKbmVCR2gArxHN2QFDigx3BEKHkOJXkmrxCjqAKwtvl3K3bIjhn9Fsq6tSRLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05SV4dk/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so13930816a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 14:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738622367; x=1739227167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rc7c9JPXikCd8Iu9pgV4LRP9xA48AK8hD/MXmnBG3Aw=;
        b=05SV4dk/x3eiSCMAWP53WrkfCM4kvDiUKWnfVIejbpBTPu3MKBzJyLKcfzO4poy/kX
         Ke//cny2dUUax0s1K4eQ//i2ujZJqxVhxPPM4vaymmUYDxTv2yHJTfL8f/bLzyHDUq/L
         eK6mBODC96qEPMTbBeQuIoGazj8vTj3Gw0hgv19EKGKT8VsuxRJuXxqieAetsRFDylf8
         aM/+B0B/pz2BJBvSNC3ElMSL03uc2HI6LvkYg2XOG1ECF8y93gjQWN4ANXp4ZUT25g84
         CqlCRx8Z+rKOnbILEyBTXkvmEJh9DLDEcpxnyzxeomAbW5qxb9WVUGeRssQ6Bpu5kD5W
         0TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622367; x=1739227167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rc7c9JPXikCd8Iu9pgV4LRP9xA48AK8hD/MXmnBG3Aw=;
        b=H+d3qQFGJIabUm/pGc2oCOywfj1V0qxz2E0CPWzcedeuJJjhigtMwufGYhb50M209w
         gIg4DDZDhI4pcJfjNqGB4KE0pgtPXnDTq/q53n3KpTQFz3PdDR6i+AwMEXR4eKcKlFrI
         AjpjOAoAz1QOTzi5XI3Qfr6XZmN9M8iEIPLUqkUusySTChc8xBt3/4Yr6xr1Sq10cMzt
         cTa7kZQTU90ANkq4f2l9FNqbkOcZBFHUyiqkyt/kl/HH1DHZM/vmoxCCIQKvbpzam2Nu
         17ppYwyUnotm4kuesgwxtuueHZv+xe5YxehwqPiJ+5ZLwcI8skGinWUzVCpOIQ+6JXgC
         XZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwv7VDKoPIfHhewWpl7vBYdsa+uXq+0eDgjI0q4QURAp3JoKPuvLOHxY3b4Mksz4ApqywbG8o//Dx6Vn5HMwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YKVUDB6GdcBvjTk5CprjW8Rqg3ghm7jDowSIGL1Wyx3GnGX7
	iRS+VClSBrR/9J2R2zyTKctv5NJSAOc2mOF6wK0jvwI/2HguFXpOtXtkWyGlBwQYOMEsBHvacLw
	k43zbg8fMhyzGrVyUAvsTyQ==
X-Google-Smtp-Source: AGHT+IEVoq/odtPJGxLrrYEYPRP3ZsRO1cKfDMWv4+6BAejNJPoBnN+rujdSVvcz7HzR2bynurMrReZ/ogt/1YT+mg==
X-Received: from pjbsx4.prod.google.com ([2002:a17:90b:2cc4:b0:2ea:aa56:49c])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:53c7:b0:2ee:7870:8835 with SMTP id 98e67ed59e1d1-2f83ac83791mr40443324a91.33.1738622367078;
 Mon, 03 Feb 2025 14:39:27 -0800 (PST)
Date: Mon,  3 Feb 2025 22:39:16 +0000
In-Reply-To: <20250203223916.1064540-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203223916.1064540-7-almasrymina@google.com>
Subject: [PATCH net-next v3 6/6] net: devmem: make dmabuf unbinding scheduled work
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
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
index 5de887545f5e..23463de19f50 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -46,8 +46,10 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
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
index 874e891e70e0..63d16dbaca2d 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -52,6 +52,8 @@ struct net_devmem_dmabuf_binding {
 	 * net_iovs in the TX path.
 	 */
 	struct net_iov **tx_vec;
+
+	struct work_struct unbind_w;
 };
 
 #if defined(CONFIG_NET_DEVMEM)
@@ -74,7 +76,7 @@ struct dmabuf_genpool_chunk_owner {
 	struct net_devmem_dmabuf_binding *binding;
 };
 
-void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
+void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
@@ -129,7 +131,8 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	if (!refcount_dec_and_test(&binding->ref))
 		return;
 
-	__net_devmem_dmabuf_binding_free(binding);
+	INIT_WORK(&binding->unbind_w, __net_devmem_dmabuf_binding_free);
+	schedule_work(&binding->unbind_w);
 }
 
 void net_devmem_get_net_iov(struct net_iov *niov);
@@ -161,8 +164,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 {
 }
 
-static inline void
-__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
+static inline void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 }
 
-- 
2.48.1.362.g079036d154-goog


