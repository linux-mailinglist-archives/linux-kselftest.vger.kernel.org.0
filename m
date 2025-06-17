Return-Path: <linux-kselftest+bounces-35174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB560ADC0D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E62A1743E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7502325D54A;
	Tue, 17 Jun 2025 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr/9MOvB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7625CC52;
	Tue, 17 Jun 2025 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134793; cv=none; b=lUUOx7rNl8LFxHLeVQcOwpBnUOvm8YySrggOle6DQbDXQg2nuaCRQ4fD4eVTBJ4cRysdDzw5BYUROnBi6CRmPpjuqprsj6lUK7og3LBMZZ216d06FGMo1CvKariwr/mWmcExaDRlXtb2pxsOpu+zvfv1QAxMxnmmzTyI7roobRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134793; c=relaxed/simple;
	bh=+t28P7IfMd6Z3qkHyejEJg2X1cP76IfrOfkKHb23b4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssyRAi/rZm6PsrnpDhzArK1qiQNJQfRFOSSDyfm07xAT3b+T4fzr8eBK3EFADT+5bv+CWjsdJ6QMibzH9StWPHQW2Z+h+ccFx7m4PJav71d9qcSStQH+dFUnCjseFRbUHce3wrUBAlYGOPao07wiCvwdAUuyTptYQd9Y57sWmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr/9MOvB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3139027b825so3669248a91.0;
        Mon, 16 Jun 2025 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134789; x=1750739589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfX6aOsHYzp8OvVtnsleRNNoqy1TSXcylauBeBxQCfM=;
        b=Gr/9MOvBKjRs7cP5UifHuG6Aj66vhYmvRyvnJz8VM+0Gu55rdhoGUj4fwbY4vaxRXL
         KJ3osiOR5dFrH0JMmzpT70iKIp+ktTobpKW/d/TkJFxLTlpxeRW7pH8YW/9h9i0Ppj0X
         +Im+vFx1w/4+NSpxNpIoDIogp2iRtUydmEfnsVTEVF06F/r7gdJKee9aTQhvjWkGN24Z
         nr7MU6WoODrrpfkeJbzqNhOP/kkKI9n3l5o0Mc+8YGH6X4nWRYbpognzrxMB6Qg0S2MY
         fP2kFa6AAZbnnzf7xpgzz9UnAZO7BTZ0wrGODZYfp/Evj13wS8nIekpgox80O/t+kr72
         edCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134789; x=1750739589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfX6aOsHYzp8OvVtnsleRNNoqy1TSXcylauBeBxQCfM=;
        b=P+X7D08rLB4QLTFk8iJJwYMdP1r38iJhGPjZCk0wC58dh3SoVBb04sNlQZIVc2C169
         xpdTbJ25GQE5kV47icGMCfG7qFtVSL6/szetF0hZh4kqc8Ss9OqEEKLEgdVH09ju+6/b
         Yvgtg1StHlZxIM8GREHpFbRUMpt6yNFgB8+J3VrLxxwJZk+pZLvQHqJLYG1uGjNm2qN/
         khiQbVnFtcbsYcGA0J2x6blg30XsqFe87pBcOFLRYDl6Mc8grXCzQYzd1H85yQzjTGqL
         HBzO+F/ZnGhhbaTzF0uJExn91G7G4MAqCM+pJ3Yd5qWLLCToeXyhg5powURqgN6wIaIe
         v4+w==
X-Forwarded-Encrypted: i=1; AJvYcCVHXUFPgGmhGioy2fED7yBnibc3mmHQkzvujoiFf6+OIAWgrONlUbCO2udwgI2W5/LQK6PPJkmk4mDzA4Y=@vger.kernel.org, AJvYcCVa1QsVY38Nfa08h463GaNYpWfU0w27/VF5D36a3D8Bi0vcCI45gguRYc8ib7KxRPrnwBXkEr25@vger.kernel.org, AJvYcCX/YMAuhtPKN78JqkL9yHK0zdCP+nxvLqiXYvPs3EA329yuw6UjWYWNn1ednOjqmacXuoSv88bGFsPMijTBudq7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvy9BXbJNeVnBjxGIbKr1ZD+MFeCfo/HvFNnRLM0pe9cLzJheY
	/VDqgK3/JKsM6XNQ8Bx8d6Gj+oslfyA8jMPmJ8PuQpGCFvVwQQZkrj6PsN1IInQT
X-Gm-Gg: ASbGnctO5jytUW/k4B6ksyFhmeRA2NJkOYKos1OUXRdw3IqHghxKs2VdJfeEVoG7lqm
	2Vm7vqMt6Qrjrd55Du5R3tz0OdvO5RbzAri4wkUJei6g1LuFbLNYp3hNuwiek17hn5yrlaGdyon
	5VgkFPHZxNEKDH0CCVg0ovguDnBnj4u1NNttQieRvoiI4CiIlyKGbF3dBiWrVwdqKubt/oiWhIc
	qmMXr9XjXZkB0jtYTGI2JyaQq5/0QS3H2MjK8B2c0JVoJTAb9fA4W5eXkO64P853Yp0w0xO7rxV
	uFtvx0RqqsRYSr+pKlCw2YoB3hDX8heAWBNMf+Ap7i9MAGugRmNwmzwMaJDKLo/njuo=
X-Google-Smtp-Source: AGHT+IHnlb+3zl8t+M0JYb3T3mvJO36gRS/DjbaA/k1lUw1YbdWzxTO9ao8p51vZKxNJED/Jx4OQ8Q==
X-Received: by 2002:a17:90b:53c5:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-313f1daa7b4mr16313306a91.19.1750134789555;
        Mon, 16 Jun 2025 21:33:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c6a80bsm9566197a91.44.2025.06.16.21.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:59 -0700
Subject: [PATCH RFC net-next v4 10/11] vsock/vmci: add netns hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-10-bdd1659c33fb@meta.com>
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

Add hooks for new internal NS calls to avoid breaking vmci. Guest vsocks
remain in global mode namespaces, so behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/vmci_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index b370070194fa..8f374f84a526 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -703,9 +703,9 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
 	vsock_addr_init(&dst, pkt->dg.dst.context, pkt->dst_port);
 
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, vsock_global_net());
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, vsock_global_net());
 		if (!sk) {
 			/* We could not find a socket for this specified
 			 * address.  If this packet is a RST, we just drop it.

-- 
2.47.1


