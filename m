Return-Path: <linux-kselftest+bounces-38334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A969B1BC01
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E699A6267B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE9629DB8B;
	Tue,  5 Aug 2025 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZvhyKzz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CD29B78D;
	Tue,  5 Aug 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430564; cv=none; b=UtW78AbGxVwCJs93s6W2XB6fkSesPdX0fJfqNSOcTLDPfOy0s52vdMDCAgP+IWTTs1orwriOJPjBMbrWDc9YbieKCKXk4ATia+DwLv2o1AcieaquBjA+LXLUw9EY8fAWl7p1lvP1MMKwkfaaxygtHWhnssAxUMPHuP03A7V58MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430564; c=relaxed/simple;
	bh=iVkInzQ7uHzZMQZ7UxyeGw74/8iMWFmqHrGNUTfOeag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVQrABHy6H1EngTGT7xSNPQsxMyfxgSf27TC2/Xc0KN5l7bWenhbqqpAjA1MPYQwbdXVzm9c4CYrMEljIvp4KPMBenxGstxZYJv/YFusmyYy+BJ9HO3OVLidTfLsH7TZF3v3SLC/QawW9CM/fqbnrP9fqVaypUoJneEqd1rcw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZvhyKzz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so4129346a91.1;
        Tue, 05 Aug 2025 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430562; x=1755035362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm0/fMgK4tErQjYzZdv4phel9XrBq2Yycw99jmqjet8=;
        b=VZvhyKzziiNuh9V+BXeZi+wMiiQyLuK+EjDRjbZ7TBuKaUBFxoH+zI/ppa1RZviS0V
         I4/XIGJT+tAJpZCd+rfMLeZ8BNkhZ2bg1Wx+AysMiv3P+BUEQOiclp9FC/ESVC6g6ERc
         Hl8xM8Xl20j0jxo8NO4TYKUAEigeqw99wgy/BAEQoLMJkBBPSc8NNrH4IIVZcc6SwtCk
         BHMEtx1TzrcUg8Xr243Zsttlcrm4GfPueblUengzZ6TjUpQdATKkzs2KOgzwRh4LRPc6
         yIPXWBM713wpFD4gNAdAs7rkjesOgn43r1j+D3DnuDSw8Vu/rPgvXC8Gj/rBe7nomeFD
         ndjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430562; x=1755035362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm0/fMgK4tErQjYzZdv4phel9XrBq2Yycw99jmqjet8=;
        b=eXQKWEOR14+yadJ4Zmh2Rq3FF5jF1MhUOFDPsrCSTXhrCdmIUtcjcu62l9GwdFcbGF
         +fl77QogUG+DB2cN9VkuxE5dMqLg7UGYMlOW3TS7IegvbPtVLx3G3KOCiMCuw7wKxlJ7
         NS1/iFSdVS9UHd6FRRPPaDZOiL21GMzNEfmskesC7nYJSnuxVk+cio1aB4mg0R7mudnK
         uE3O7Bgi686/rUKCPu/cP/rTq3bdvf6GV6A6uXYMLZcSn3Fnzx6idBnXjbQ25MPgQh42
         B2bVOeWOoQs6QeONS/bDzPe0BtjAsMMdHrv5JxEx0cqs0rmcCGp3xlWUhcFVxwYkVffr
         ubHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB8rZqXZt+oB8+VJWYJtnuTVubleEK2YVOU3qKHQ9NJcQL8kY6uM1zPPwqiiISEgPq/8bC412bBPJzXMtz@vger.kernel.org, AJvYcCUEboTOAn8eFI1w5fUvxxWUtO54RTFxIsD3Q2XYBjN1SXmP+6x0TWYu+mo6MSLbKiAq2VWxILe9pEhmOgXmz7QR@vger.kernel.org, AJvYcCVzjf8MBS2JGOc6nGPn1DGbAwdTSDU9SSE6w339xOgDsuSRwx/QvRaKsY1cRHXvRvM28SPXLijW3nW7ODFo@vger.kernel.org, AJvYcCWHMaDJvBkT86nUk2wsuz5jDcvhkkbE+bc2/BHWB52UOarfK80ITfYzzK2JiTBUA3+8XqKKBXmT@vger.kernel.org, AJvYcCXjxPB4cDlVC0BP+G3e7q8nbdkTuouAPaFlw4WM7DVEIg+ESSvL0RBXxKQOMC0Kr6Z131k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3AQYU+Gs6JioUdsVzL8RC6h1q4X5svDfozrzDn5/6MDIccyz
	oWPqRJpizbsIw3S5r15XBc1vA4/5aeQFe7OJP6UjuYMdZ8SxWgYATVHL
X-Gm-Gg: ASbGncs8SQnBhP6XGKUvPmhFcaFbJJhrJ26rs7Zpr2LRiKn64GtxS3LblQiztsB8wHN
	J7BgXQ1mxGxKvUASorjRaBZdXZfgz7lVg2sDQnLxQJK8cUbOhaCWEzp3+S06QJ2J5LaihGMUchq
	7ppKpxSLCjLRyia6UWt4ud/qmyrfJhVXT2xJCKbOJ75mobS+CmAhijyvKX052wycGrjJq3eOedB
	WO1cWgaiP6rujZwK9sJzOx08sLylfW90UdjgSHUgQD8vSR7dWwkHFVsr6tyggkkcRDdyi3LhIXH
	f/7Bd7PkXK4JjxQCRxkaDvFfcIa00wnSXxzZ0DLoWD+t67Dvh5JIgFwa+be1nd289qZ42DlHgvO
	oTSo4LzqXob+g0glnaCI3
X-Google-Smtp-Source: AGHT+IEkvDIFK5HkjsCOvoxAuFgibsDf9KbOCOhnG1IK5JHA4oFThHnwoGQ5xLGBLKlnGLxewHy3vQ==
X-Received: by 2002:a17:90b:2783:b0:311:c93b:3ca2 with SMTP id 98e67ed59e1d1-32166c1e68amr448003a91.6.1754430562315;
        Tue, 05 Aug 2025 14:49:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161198f17sm1051118a91.17.2025.08.05.14.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:14 -0700
Subject: [PATCH RFC net-next v4 06/12] vsock/virtio: use the global netns
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-6-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

This changes virtio-vsock to always use the global netns dummy so that
all guest vsock continues to operate in global mode. The guest vsock
behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/virtio_transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..25c1bca7b136 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -536,7 +536,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid);
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport virtio_transport = {
 	.transport = {
@@ -593,7 +593,7 @@ static struct virtio_transport virtio_transport = {
 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
 };
 
-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
+static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	struct virtio_vsock *vsock;
 	bool seqpacket_allow;
@@ -649,6 +649,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			virtio_vsock_skb_rx_put(skb);
+			virtio_vsock_skb_set_net(skb, vsock_global_net());
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}

-- 
2.47.3


