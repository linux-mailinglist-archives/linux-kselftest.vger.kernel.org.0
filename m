Return-Path: <linux-kselftest+bounces-43698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB8ABF94B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB312584ADF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6142C325F;
	Tue, 21 Oct 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpaFAJxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53B24A049
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090424; cv=none; b=XbDnNqdFdytWcNBKfaP03PBUhnj9EUk0WcKgYf6YlxS5GTaZIK513slM0Wmxymn0IWt/KacF6chllyXwcu2oQTAh1lAR9/20SAB1Xe8vJRKQFDAmMFp+nb5EcPkRgcsUsXL2pqAg4lPeVD/e9KDyiBItxtZR8RL6AhbhtxRx9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090424; c=relaxed/simple;
	bh=5lT5a275Jig/x0y4MU1RBKKAqav6WdTww5TZeVBwOjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3StSxRXbavI6072VElWwGb/hGUlARxMeWZt17OzrcN2ed6Ic1LBXTltV/psq55/9cD7OwlDrPNgJV3V3Vr3LKqj/WnFArQ9ByglHh47tNsn2s7EZhAAof3FPs+75bj+5TNpgwRUQWA6FLjW5FNCptTre3HGSVRajLjvEL0+EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpaFAJxZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so5620993a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090421; x=1761695221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8QAc03+caTvAAzxQiYsQ8xN61QvIP62Vy0HUa32Vyw=;
        b=fpaFAJxZILo96dTdXQYE9qtnCzZGvnNfx9C1TGKWaKTTtCljcSQWt7cq0lbPn8L5bK
         Dj14By71004rbyJLs+BpOdTQorjgq9zF9T9YkNu3J0odu5r4T36DNJbYR1hEL0zPPbNN
         0oXkB2kqaZqO8isDfoMDnyPf/yljTJ3uhuG69qgxGIH4A+VcvSCYILTCT9IyUmygzPZ/
         ZUH2QGJxbMZzApyTPtVKqn0F6pkU244es9W+haffDeiwLa5Cntuh6xxVrX3WeclGNPd6
         E0MiDd2O3g0jFRaH0jzBhlFW/o9GH6EeOWqCsaIQSzMnz3CzFw4Rb0Pdojr3/+wrzTs3
         I8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090421; x=1761695221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8QAc03+caTvAAzxQiYsQ8xN61QvIP62Vy0HUa32Vyw=;
        b=n073w112fkjXtJLtxwcs2fvjBF+GJl2smrXQXn3GnkPWXUhx+4XTmEorEp+3Lz+hrU
         8eQ92mk6tj7YSTkpg4rtq5EFZuIeCTPNj+JrseLqlbadf9Rnb+ivEkPOSc+gBKVu463u
         HvFKLx2i5C2FILp9VqPmibbSFiuIag/3R6DYGWhe9qyRnyWQueszg48ObEGZlWegOimj
         O/cK5mWwa8prmxye1UteiXF/xSx/3sJke5Kw3piz+4c6eNtxnrzeu3t1psHh3eeszj3W
         sD2tSDw58djtcJff2TdOT0oQQ2ibD+dSzgqT4VKC9YY0OUxUznN2vrug0pprAErEFMdX
         LhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2zAA91elzZdReXqrwn0cSSN0iB+bkpvelncHhj9onTwh7DiqTZZYmpzMZ0+SnJbmnp9dihIdwTADKgPgxeo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT/UukLGlRprQ29qfjZWfJgQ8ZTJFkEOihQ3LBCtZlA5Ku4ZsT
	bZdAZZFRuOmjYxyPtdytWt1FxC078qNTm3Qk65NDwjf0DtY1WiReIGvy
X-Gm-Gg: ASbGnctjxaLLvsMW3OteyzhQv1Ga11EUoq5VLAL9BniY8lIfIYBXf0b6lL0ZgJP9coz
	m35sZgtZlvXMqTIiA572xFAuvfNTqBG8//c/6NnIu6JpuXI7C1rb3oRQa6wtw7tA1Xe0t29kcpQ
	3w2cRTiJO1zZeCPr9dB0CDGkX0RmNhF3Vvo797RhlHqIulF8p5+i3x2bdXL8zNbCSYdrwxpQ7mC
	RtrpF4XpHkK/b7mHC6oX2Ssc91CFF7HAKB9m66gcVhxBcQsBL1m+Oq/XGQsxNTJEHVDhaTYmbTC
	Pus03vAAxOxONYLaZAnvtOM1uPUYli5nvksPOHC+rvfHeC29mc2xWts17FhoP7MLBRMvKmxiwVV
	Ozel9cE7AByAS15bXSH+pViPV87zozv+14xiuSIwY+WT6oS6gXKqtCotxe3SVdQ1V9b18++3Mbt
	zDGAzlrFk=
X-Google-Smtp-Source: AGHT+IFnLd8MEBHJWDP/6T0bT9CF6tUU40IwqT7WMWTgte724ObVfh7g7Y965ujhPSVyLp4smF4h2g==
X-Received: by 2002:a17:90b:3942:b0:336:bfce:3b48 with SMTP id 98e67ed59e1d1-33bcf87f431mr27158450a91.9.1761090421527;
        Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22428b1esm708138a91.22.2025.10.21.16.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:46 -0700
Subject: [PATCH net-next v7 03/26] vsock: add netns to vsock skb cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-3-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer and net_mode to the vsock skb and helpers for
getting/setting them. When skbs are received the transport needs a way
to tell the vsock layer and/or virtio common layer which namespace and
what namespace mode the packet belongs to. This will be used by those
upper layers for finding the correct socket object. This patch stashes
these fields in the skb control buffer.

This extends virtio_vsock_skb_cb to 24 bytes:

struct virtio_vsock_skb_cb {
	struct net *               net;                  /*     0     8 */
	enum vsock_net_mode        net_mode;        /*     8     4 */
	u32                        offset;               /*    12     4 */
	bool                       reply;                /*    16     1 */
	bool                       tap_delivered;        /*    17     1 */

	/* size: 24, cachelines: 1, members: 5 */
	/* padding: 6 */
	/* last cacheline: 24 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v7:
- rename `orig_net_mode` to `net_mode`
- update commit message with a more complete explanation of changes

Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 87cf4dcac78a..7f334a32133c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,6 +10,8 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	struct net *net;
+	enum vsock_net_mode net_mode;
 	u32 offset;
 	bool reply;
 	bool tap_delivered;
@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
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


