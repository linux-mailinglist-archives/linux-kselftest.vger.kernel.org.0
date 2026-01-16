Return-Path: <linux-kselftest+bounces-49200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 183A8D38856
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E4B93019645
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E130E0D8;
	Fri, 16 Jan 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqwvUnlN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DC307AF0
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598948; cv=none; b=YTpIIha+2h4FSLeOsG5KJ50rNhQIpMiq20ppC3GQFOT+2fGbUgK4m8YrGMGyMoOII5qg04fEhRYISGmUDgMSvh9l3nvnift9SdZMyxH+pSbWehY+3TSp0wQW38PvA5xze6RAA/P+Wuf+sxtIibps69KVEc3PdvnAVqyquCAsJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598948; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPXc+ZH7XjvLVBMtwpLJAYBMJOP52VTB1/+vTaH+UebhAQy5dn/xR4xXYBfF2t7KO2LrLekjveJGdHfohc6LkGnYXugsiPmUwOPktk3e1NxpE/22ihIcAyRpEtJ9qbIlp2UBcScWobSVur3VN/A0AWYfGaBvq6abVEYURnv1bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqwvUnlN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78e6dc6d6d7so25868657b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598944; x=1769203744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=BqwvUnlNPCKikTxYdL+5w8XOT82LgQ0+ssDXjKCFsQOiOEKeiqpdAFz8/CE93RQl5v
         /GVKF15nii0G6eKA5oQ8s22PMA7hztwgG5qgQDLIW3i5knksl747rL2nTy6hhVXHGHFy
         vQNhM17LwHRwZEtAqwkm6d5i5P1xIbrGPD8eDjNZCCEMNSMK8p6XUwSj1NxI0l7Ym5ZV
         S3Lxo/tw3O96guydkObG3nLyxKn7r9U0oaRjAvCLmJ8qQ1uCYYurSraB70Sj03AnAvXI
         WkOkTK0q3z508sBiWTyQ8VqmEyUTD1pndtwVGYmkBN5icbbVkvQOfNR9KCBiKYMzS1wK
         NxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598944; x=1769203744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=GQxAFubTYTczUff7GX1INQpuNntNOMYRnnw5WfTTpANkLhV6t2fDnpY/r+bmV547rQ
         Qy1yomf5QkFVCPTx99hmtFoWg3KNaq+GvnuXyy7jlaR5TBJb0dvpExZzxrbArqyZbb7e
         93eUN+YcLwPm0GZLIhXpoJTdgmHSHUkH3UGg/TXl4cBM6/8weQl5GTAzMIYNno2o8H0F
         1Bv2GFF++sQDp6dnpfUifvcfzGzWsoqGz5BG3umEaqhXsZixCxvN4ONv5dXqoUwPWHdY
         fdk3EgDmM8+9qFMtRBbZLEcys9luxJxAtoJn4Hv3Xb5GDQPEcdbOnupqaMxedUhggsRe
         MECA==
X-Forwarded-Encrypted: i=1; AJvYcCX7kehxcPv+oSZqBAmsTzWKOqZQgEGJBSiKlYBk1mfE2XWL4p3qTvsxTEQJe1S/7d1wDyr3PZeqGiWAb6nhyYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYLB3VX3MiYO6HXdQgUMnRPH0V8/DKaJh/lo7gf9d3lptO2uJ
	YWCo2WlDOR2j2utrTf4N61xM9WAmrJuvCmI+CBhamwH+S1lozq9WEy1E
X-Gm-Gg: AY/fxX6FLdzVn3FZ37hlXASORuYP9G+EdwnZ4v6EDwIKuKvJ9IEUyvZa38nRBY4GPXp
	vZ14pNbb5d3oMI0BXmSD/8dWkwGUcBAAvE6h1EF+hzxOiM7MlQuk2PNujv7UT+s0BUoKaLlQqf2
	YLS7JnNgDbE4ze7OqKi7V5kXVytfokNMIqLFRHT7YTfgVUbeVAJ9qFBIpOEni12W3MNvV5GzG5R
	Q2c2LZps5EEYZvhabH0LGj7YNfg8lNd2yTysJtVZBlUGYZtcX0pLZjeR2DdDGByUFs/LNHg7iGk
	pSq8n4m8uX6c+Q3PV7lLHmO4s4msaL/dK0PyhCrCdrEOgZTFiqG5aSLSH/NrDV6RF9+uqTDoQ9b
	OqO+T1wG353YcHpHOBABV/4Q9GP0f+OCXQ2fNbyuITS6GZgtKKhkVDQZXAxxX0g9mEHqJi6ZGq7
	3OfDUB5rRPfw==
X-Received: by 2002:a05:690c:39d:b0:78c:2916:3f0a with SMTP id 00721157ae682-793c66b8eb1mr33268517b3.7.1768598944439;
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm13186297b3.12.2026.01.16.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:42 -0800
Subject: [PATCH net-next v15 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-2-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fdb8f5b3fa60..718be9f33274 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3


