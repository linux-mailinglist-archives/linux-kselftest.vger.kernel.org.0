Return-Path: <linux-kselftest+bounces-45382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD8C50C9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 07:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3743ADBEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 06:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0655C2E0915;
	Wed, 12 Nov 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKxvZ3+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A42E6CA6
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930543; cv=none; b=Wm11YrysBIpvd3ftd/Wui0tFxgfrZmAVFQgSR4MUKGjSpoaQOE1Rh3keODT2LJdpdhDaMmLco4op7IkIHv1i8d6NcxboCR5qPimrzY32isSCgR6x8yqXN+v+AO/egvH7i5uMrtTD99PJm3fWSsQmFUMXTKu2S+kd6ZHk1LZqHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930543; c=relaxed/simple;
	bh=veSnw3IGQ71cxIlqHypTONN3gf5WNTEJruTN4Lb14qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QesyIm5W6RKk69K3uUXuzCt2jps6OgRfyDK8SQbSXwDzP1bEvHEGX0c9cocsIhM7ME/YKn/DXVytkilbb/o0fuykHyWHBxsOUI3xtSveuLwBkFbMSp00zYA+vtCehULMl2TCILUqrhB2OGHfh0vDctnq/Qep6SjsEStsC0MrUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKxvZ3+e; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b18c6cc278so652909b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 22:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930539; x=1763535339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3POWcPl845f0o8duse0G0nccbWINBqqIKArZonruJ3I=;
        b=AKxvZ3+emhexl6EvJ0PznWdaDfGlMXSNlezSMQGEMSl83uWyDoc2tC+ZqjdEZjhPpy
         0XkRNl9pxZdRDCJOdp2n6SFIY/w+Kit7uM7ngC+9LQWRfRvE9PHvsyGbk6wx9qbU8WyE
         XBZlie25BFi5m/w9cOLEQ2R2uzQoIL1aRlaChiqOapuB9lcWtDgdWTen3DhUcSXR1UrX
         fxY+BaLFyqz6WzOZMOmlU469bFtemFP2KGhBDYXTgK6ltBD1XBeaFPry1zL8oshGgYaB
         YsbsEl+QwtkbiStp9bPp9dWcl21kWvyl4Xz6Yn0RsKBAq+e3KbWj9QRZkpwAaEbN2v9G
         g2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930539; x=1763535339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3POWcPl845f0o8duse0G0nccbWINBqqIKArZonruJ3I=;
        b=o3Zk9yeBwMB5ziScwzucl7aooGzsjKyP8CYHfAUQgSJRJ8EGKIWohkwgsV9yctAfBk
         DVNxVDVU1dYa12FH7AleAt0RG7TEoPPFFaioJerjoJrlTqHUd50y6DaFSFBjtoZQ+0uI
         hbGncXAW9wubMODbCqj4RZEnRS0lexLqyWS54NRu+hGYP2WAYwDsiHqSMNxBQiOO4ALC
         HcVGP9C3ser5izT6WSawDYCu1P1pVjHNgvJ4ltjvkw2f6C5hu0o7gSefsnm7YMFnjddk
         sHNfsc5bVSQCbqBOzXkb9oKoeXDbI1nZxgb9gaoz29TmUKkl6fB9dgV+rnkNdCb4oKwp
         y+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUljX0JEyQrARUxica+v+SCpWWcDX6xH9oDpD5mZitg4e1nD0uP/PCGA2/8bWJAgpMmaL3lsQdBoe7AYUuDhLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUNRCjO2Ud0tlHVwkhoy1q0d3SiY4qFW/Nuhjd21AYUPfA1ZE
	oAsduNXEA+VsSLcCoWW/PpSnc19kndym/gCUBuan5ufcw0uMdmd+kyNR
X-Gm-Gg: ASbGncvyKveR4FItMech2Xbz7UlPzMZHyuwSeoN2f0QbWpxLwDAJ+1SJ8sCO1fxtPwl
	L2nEbpjLB8SSCvDA7fBXwoWBvL3npPEy8UH+l6AvMJ5HYXVSch6GWur/xGzxtFUWH1U8OOwCSJX
	WzZw9Pb8RpN81iRSP1ftQe1jiE+kLJrGRY79ban3FuOj3d6NtPmhUYnSBB4s4GkRsjF43QnDjyJ
	IlHaJcJRx3u/9y/jaazN5Z1q8I1Hh5qqiJ3mLCEdCsvlDIUaBofYJhtRQf3eZCagEfABvdVAR+K
	PVjmvhrMYzWzDDG/mA5kC+pCSm0qsRBBUG9Ni+vGQGnQUxPUSpoYLcPwz5YVKcIHLKxuVqYgl5P
	R7BwirfNwRlszfdIhFBsPGXxdx2nDLyLHTwycof3t91czRFOoiShAonOFWYxL8HJK+/lxQ195
X-Google-Smtp-Source: AGHT+IHHvidQKHevYduW37onhvCFlT+u0IEMiGDYOLRIvORJFfiefLF1h5W5O7IoFAvmqwigA4o2NQ==
X-Received: by 2002:a05:6a20:12cb:b0:334:8239:56dc with SMTP id adf61e73a8af0-3590b820767mr2885613637.56.1762930539480;
        Tue, 11 Nov 2025 22:55:39 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07d2e5esm1357244a91.17.2025.11.11.22.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:39 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:47 -0800
Subject: [PATCH net-next v9 05/14] vsock: add netns and netns_tracker to
 vsock skb cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-5-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer, netns_tracker, and net_mode to the vsock skb and
helpers for getting/setting them. These fields are only used by
vsock_loopback in order to avoid net-related race conditions (more info
in the loopback patch).

This extends virtio_vsock_skb_cb to 32 bytes (with
CONFIG_NET_DEV_REFCNT_TRACKER=y):

struct virtio_vsock_skb_cb {
	struct net *               net;                  /*     0     8 */
	netns_tracker              ns_tracker;           /*     8     8 */
	enum vsock_net_mode        net_mode;             /*    16     4 */
	u32                        offset;               /*    20     4 */
	bool                       reply;                /*    24     1 */
	bool                       tap_delivered;        /*    25     1 */

	/* size: 32, cachelines: 1, members: 6 */
	/* padding: 6 */
	/* last cacheline: 32 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- update commit message to specify usage by loopback only
- add comment in virtio_vsock_skb_cb mentioning usage by vsock_loopback
- add ns_tracker to skb->cb
- removed Stefano's Reviewed-by trailer due to ns_tracker addition (not
  sure if this is the right process thing to do)

Changes in v7:
- rename `orig_net_mode` to `net_mode`
- update commit message with a more complete explanation of changes

Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 18deb3c8dab3..a3ef752cdb95 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,6 +10,10 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	/* net, net_mode, and ns_tracker are only used by vsock_loopback. */
+	struct net *net;
+	netns_tracker ns_tracker;
+	enum vsock_net_mode net_mode;
 	u32 offset;
 	bool reply;
 	bool tap_delivered;
@@ -130,6 +134,35 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	get_net_track(net, &VIRTIO_VSOCK_SKB_CB(skb)->ns_tracker, GFP_KERNEL);
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
+}
+
+static inline void virtio_vsock_skb_clear_net(struct sk_buff *skb)
+{
+	put_net_track(VIRTIO_VSOCK_SKB_CB(skb)->net,
+		      &VIRTIO_VSOCK_SKB_CB(skb)->ns_tracker);
+	VIRTIO_VSOCK_SKB_CB(skb)->net = NULL;
+}
+
+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
+}
+
+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3


