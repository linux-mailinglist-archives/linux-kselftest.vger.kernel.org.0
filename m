Return-Path: <linux-kselftest+bounces-38336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38373B1BC0F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA8818A7A99
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354A2BD5BF;
	Tue,  5 Aug 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHC/NxH1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0E2BD010;
	Tue,  5 Aug 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430567; cv=none; b=IhPspw9U64oNQetig0hfP9uoFS7I62BPoz2xwHKWl1Bs2kPyQj9Id23a8IUAM6PwYHoYaX9omwFzz9m52r5+P1jFLSKat2oxoR8fULYwxJnxRrdN4FkjNabUQX7wP64CeSEmvQQwYwKW63Gc7xy6602ow//6VL2hkvrq0ayfjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430567; c=relaxed/simple;
	bh=P1/qaJCybjcXSEfP6RGJaoK9v8utpfUNtngCHpZIML8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD7VesTm4HOEhus0/37yxcqBkSOBhgon0tiegln/9Yl4VjhKZLEAu9E2Er9B/q3dI3HhTBhHp2TXG6DRHhyZJfuR1BexMRADZz82ZSPAZtmdH6TYXO5VACQOlVYKrW1xBB4ShgBI9t+kM1oH76vg529/gyyHLJ1jMYoDyTWbRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHC/NxH1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso4346335b3a.3;
        Tue, 05 Aug 2025 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430565; x=1755035365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWqr1u7R6aV4zTd/B0j1tkHJBdcxjwTrCzBwm4Fr1i8=;
        b=HHC/NxH1yEuKE6hO2+10BGnFa6/NahjfNqjKoDF9BdxjbirkGJyVgSoAXpwBKvXIRz
         b+LiGJkMO7IK5GIsqLX9E84yx2lGdK+DkJDq5QgQEIslyE+ukEl8RY102CmKnUKbFdwb
         D7ItyQdfiP8FbYeaEHatHFgCxqB4NQxj3e6C0Jaa3h5bi6UCmE6NFwUNidPfPEktZeND
         0wH4JO2/FBxBjX3gHQ26AbQYOtVpeRf8YRycGlaQ+sbmPIuE5VYPCscJHRvgPtcRZUOn
         9oeKmW0spJxlwXC3wMueIOgg5CwtneI91nLdXyK/1UG6xcsMYWHWRUVSMswKW4yxEIHY
         /Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430565; x=1755035365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWqr1u7R6aV4zTd/B0j1tkHJBdcxjwTrCzBwm4Fr1i8=;
        b=u/lqLEIhJm5zb9gTUEBnfLD0ulxOt5sISgN+o/zEmG4sx8K3/ZYoyEarRn1JkJfjMo
         N/pkgMEh8zoPOxsBO5Lxk6sLhaeYBj4/ociKBL3Jpc6/cNygkZFtDye+nBTXJGer4tmS
         NR4U8NQvmbTVmeT+lxXyXizl26SHDe1eMICxK+6W+FKkaSqI94l1Zf2LRL7dArJRNsxt
         c/ZOlW7qzjBHdl5ENdrnkJgzTQUp2FwwLrBEpuVXEDbdbqjy00Qsx4uQtleG3SOiME91
         2i5tF/xYSQs1kFzBHCMqdqLvdO3xS536JTgv7fN3/sNpaIFgdF/s4roDUWSjOhevDv+x
         UBdw==
X-Forwarded-Encrypted: i=1; AJvYcCU2zb4jNA04tdutI9FkjkPVSapLj2k02fMuMge7rqtZQyTgJIfI7nz3JL/51TBLoMHzbsOM5kcI6jkB1AZT@vger.kernel.org, AJvYcCUh4y54/18kdEn/tsaUEN3pDo4iHuvaVfhoJWAyyjcdnJYARs5RYjEEpNTvAoQPaYh0SPnQRukNTOmjfdxjVuWv@vger.kernel.org, AJvYcCUu+HaX5Ru/MDMgdNf5WNHd+qu7kVuqMJFNrQDejLP0dISDeYMXU7wQG7mb2JZp0Y56HQrTOJ09bZXcdHj2@vger.kernel.org, AJvYcCWQzviePB9PfEL2P5fF6IofOIaFVhMslT8jfm8oiYSrtYyEVEh42r/uJbMD1B8BAWvbsgI=@vger.kernel.org, AJvYcCXMu5eQo9dLwB+ZQOik+vAjwLmDDgXHfM/9DVE777xBZktQ++z9fJ4NLDfgtg4ZpVqT1OjShyfE@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4+0UBD26fE7vk0aP6ZpGvipbE7LXQ9cwBzgPuShJ/eCEGVZr
	EVIxbAkhtzDif279WTGVyVZZJS1cmFxqExez4xXDVxyeFEU8TxpP+m4nO406PGZS
X-Gm-Gg: ASbGncudTxlJRrRLQJc6Nzet39ABspKd7BC+1eHdF5XokaWHqvo27Ah4mtqHrSi+ruV
	2AKXVNxzVBJGm2hkf3kAliklN9s/Atgz2/Eob6MdDC7xDpEuDFawlaO9PT8QYsFMUcuE07CZ6da
	gBYBB880BZLosJ/RDfFSsHN0gybTkrSU0zYt8uxs/UXwdLZBN7KoSXM8VsNrUL/dAZCx7rRoXbR
	5zPNtflPknbN4jnwnrRDb31V2Y7s8rp0sqd6dqrnjUpiXZUf1HFNVNX1hG2oM3m46hbPINOVSWu
	YAKqrUORniPoaWTMvKvNKfQe3ZkSkBiZ2+M7Tphitr8zi3MfViAvQVCiofWUnShQNTOn9M4vylD
	OG4ctCV8mNLJzjnePnAaV
X-Google-Smtp-Source: AGHT+IF9PY4f57pByyzJj+B/qQvdtKhfo8+NygbXA2dkub9dCFAKHMnBQ4/xzUnOCuyFm/MQwZFvxw==
X-Received: by 2002:a17:902:ce0b:b0:240:3e73:6df with SMTP id d9443c01a7336-242a0aa3352mr2595325ad.14.1754430565561;
        Tue, 05 Aug 2025 14:49:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a11sm142925745ad.86.2025.08.05.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:24 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:16 -0700
Subject: [PATCH RFC net-next v4 08/12] vsock/vmci: add netns hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-8-059ec51ab111@meta.com>
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

Add hooks for new internal NS calls to avoid breaking vmci. Guest vsocks
remain in global mode namespaces, so behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/vmci_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..3c434ee3ca8c 100644
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
2.47.3


