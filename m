Return-Path: <linux-kselftest+bounces-35172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC36ADC0CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2C03B56C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2625B680;
	Tue, 17 Jun 2025 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCCsxRY0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08025A341;
	Tue, 17 Jun 2025 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134789; cv=none; b=j5419943bwTUHWXKxtygJkEaZFAHIphpcq+RSjUvxKxaCvvmbZ8rbtkPO59ZJWGsaLEdxsSmXkcO1AElVN/GQ2aAfZuPLlqGaPqncWmYicnzFfT1XF1ud0NLajHCykXg591PNPB+NM4CvCA0g8Zm/gZ/HEu00tH2MiDcAq0NE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134789; c=relaxed/simple;
	bh=8iL4uzIPqS8RLVh3FNuZXgVHq1hRBKkNvfmU0de7s8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCLJ3KhBDRDD1HfDYkrUA1xHRgnYldWasZ88PQuhkxt1JiRD6El6kupGM0N0K5JyyPzVpZziENY0kYY6/YtkXpj5NWtd1P9Qj49MLsiLEewvslnDGvBxrVyY9y51Q0QkDFn1x7JIAV0U0Jh5KHKmcdB9PM8o6YgvKsxzD2hsIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCCsxRY0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso66827875ad.0;
        Mon, 16 Jun 2025 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134786; x=1750739586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJN1ESreek0j9m2XTDShreBHd17nPCksTQTpnYLrMbE=;
        b=QCCsxRY0KHuMSAv3IIb95emS60QJ/wR+qmKIkwndlM17I9x/fOgP1wwISg5uRQE2vI
         FCfut5QUahDKLu1PuAmOEgWDzV3EVUEXqg0xiRV5e9yVNY+07kdPNl7zZbAkZdCCa9bY
         yZcmW7OYo9HjHWWp14ev0TT+eQ6Hu0RYuBqubtrMpzFnilaL1xB4cxYME2yzJspNjiAJ
         C6OBvX8DmcTTYQ4FBl5Uu9vXOFoqE2FRaHscZjPjrdN9CB2KLXJoFfZnlwxaZumF/LZG
         OX38EGwaZl8MYxDVB/cLKWgRkd4BG/mcXTEQUY6VZkcuhh1xhyOJFPl5/oasGbMckicJ
         pf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134786; x=1750739586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJN1ESreek0j9m2XTDShreBHd17nPCksTQTpnYLrMbE=;
        b=RkZRpTKFfe/0oedmL8ogLKS+m1DiuknNcvdV6pXEq4jbu/gzfG3eGvMNVCudkGYgCg
         Wf+RokB8lJ19pW2GpqGW58E1EPvzea+ICRdiTUctTvR8pEvG4yWLcnoDTl0cjr+NCD0Y
         6BKclXjN9hqccOLB8/cYxXu/lu4GPzC80OZqHLW0PzNJLGb8+DAmQlNs7BlfpL1EKEhq
         BjKbR9RxfGB8cE7QsnueFU/Oh82LnGhOFb9cp+0gS2JJ/Jl6bM34Ify/NMrawlKkwqPU
         cGMRzCUmyRMPwWvZRWPc4uK6U7l/Ax00C7leNaO37+dQMI7mGj4rue8jArURwrOpvmUx
         lxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqFhQt6LRRk0sNKMdDDeUThGf6kAeIVThszAFLeyktZ3BUQ2c/A0MBwxh+DohnziklTUIlahcUWUdqapkCigLT@vger.kernel.org, AJvYcCVxgLNpt6qThK+SY9Fu+ZpzsB1LRK+klZ/P7CuPNWxWO3L5z6TIM3vqcMS4p8bZlDL11loKglynDfHHTLo=@vger.kernel.org, AJvYcCXLZL8K+ireRobCqXwZJ0ttCNis9qJVLBeIVDU/AaHL5uib7DTQ1u+Bwpsy5GzV0t7hICEafsJy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0N3l2DPC1QEqm2aTBbwSg+ZRRSA1q97Kl06ms7cf1cgc5h3ZH
	Fw9OIqtXQqxrD5Pa1U3Ev5PYpeoA6Mz2668N+bM1ULvHUChLr9GxtCCBDnw/JXW8
X-Gm-Gg: ASbGnctLuUP0VEsZMSr7rLNcVqgOJpohD2yNj1+8X5aio7M/lZC6GVeVT8zDGn+zhmS
	2BKWU04fr9e2INkS5JK0vvZjGs2GZIXrwHuQpGzfM08ff1vj3Ie5ifBOiziLkEilLDC8kgLz5Gu
	ZpzuFqhf/AxHaI6BT40NPLcRnlIKZK4L5D/aNZ60te9FgpklnMDiFYowtr5+9zS206jlXE3NL8r
	MC9MK4MBU22sxvteg+8sayAXJZJVcQNiOlRFnVQOo1ldaNjBsrXAI+326DR6e0eazcED5IbJoIr
	Sxx0OlTxQ/D0oXB85gA9bPOSgf5XvzoAMMWk/AMXjgFY42QQ34On+kVMnqmY
X-Google-Smtp-Source: AGHT+IGkFu9sQ96pWE/tvZJGaNKtT1/Ussv66FYp5oIw+9uvT4GiaGRUxhl5bUUj7am7ZNMIQejaAQ==
X-Received: by 2002:a17:902:e848:b0:234:a992:96d9 with SMTP id d9443c01a7336-2366b00ee5cmr163590035ad.17.1750134785904;
        Mon, 16 Jun 2025 21:33:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d98sm70324525ad.151.2025.06.16.21.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:57 -0700
Subject: [PATCH RFC net-next v4 08/11] vsock/virtio: add netns hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-8-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

This changes virtio to not be broken by new internal API changes
required for NS support on the host side. virtio-vsock namespaces are
always global mode, so behavior is unchanged for them.

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
2.47.1


