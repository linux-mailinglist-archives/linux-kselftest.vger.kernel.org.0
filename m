Return-Path: <linux-kselftest+bounces-48599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2FD08EB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 12:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B138330CDEF7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9EC35A93D;
	Fri,  9 Jan 2026 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHHhRw72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28635971E
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958151; cv=none; b=t7XSiHhQOEEaV+U3mnLMH3vWk5M3kOKBd6t7O90nwZpG+7Zpx1n5O7raadZNWpSgcSW4NKiIsq9zPyYBursbgGyb0o7CBS8PNpZSJwOTQSrg6eFPtR6FBhvObRpzEEn2c9ELeUnGBy+tqDTmaxyl98y7qa6aNChHHK+QxP5rvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958151; c=relaxed/simple;
	bh=hKOxjq4fxJ+iQfib8Cm75gZgmDPHfB9Dr0qLWGLYXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY7E+agIxxL3NRFpl6veH9ELJislivtUth08RxC6mL00r1vkhly5RwiPCJBnlByBusb+w2tBqfzU8I25rkwgbH+BLZ8irtBsg9apbxXzJQ85fFYf28Ib6LWiRW2UEy3dEsDZDnXp/XDT3pjnwOr11t5uP28X3ee7TXo3mQ3ZhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHHhRw72; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4775895d69cso20731345e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 03:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958146; x=1768562946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWL7hbAkNRsIM9hHu4g4BkFlYyqPgZDU68a7iQIhzDo=;
        b=HHHhRw72TWPZCJ341hwOHL6/05wsgcs23mXP7RxJGEyIoqolIVbOMIqTOfpQt19zRM
         05n786aOs0DWt84e8XLXAC5urr/+RJonEsXhgsyEH819l3O5KdywIuIfw0WnfhAmedEg
         uElfdPLyHABR9T9kn2/wImSEOSjFbFraxvGE4IWOrY27GvqYIpRjZdw0Tasra0/Bjn9X
         T2ihfDVlOFFSlA0l5EaD/n4v4vOGSjXZHeH81b4UhXAztYFI/Pix/7Hn/20PAtoPvrO0
         5dG/AjptJRhve38dtYwUa/tU1t2/T36wZ7vM52kc4sQM6AhFBe28pqD+JAL4a8l7eHnk
         rDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958146; x=1768562946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWL7hbAkNRsIM9hHu4g4BkFlYyqPgZDU68a7iQIhzDo=;
        b=OwFoeZWxF7pYRMW2ZxDMrRwBER8ep2giXcRNTDWMCmDrjqzogf2QuxsnYUqaX9Tw4D
         6HAi2MOc1Bs9Jq44JxbRwj02ofrCy+9gAAiFkEPENwlyRzBUgllQWvYhAvR94m5o8WL5
         Wkp3wm/Ay1Riei5bUqDlXXSuKh35HcpKKVs7Hb/hvDScF3HSntmtb/SNkSYfqbcya2eR
         EeR3MSLFFYV+MaxqYwCJk8tYei6z5X1tTrbUDMpnpENjX6QkPQHmvOp50i8ssM/bBW87
         UEZcZuBA9sIp6YsxiH5ZQNex9xQafhYqlxREK6+3P1z+9f7iipbECO2E/kCu+F/mv5lD
         1Plw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3RxHDKVsCh6R7zOnAkfCcXsxADgw1x3u8cuhCqvUpCMaNpeG7IBq27yXuxiVlnkpVT3ewUD14DOHS5LUpuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38b1o9i8tA/IQOwik4fUOdf5RWrJPePet18mwuPz8wPPpjmSd
	fO6eGkqEofTenMuNXonO/NvWSB8Y8vgFn2px1o3kcYdnyqkHNTcqnJ6x
X-Gm-Gg: AY/fxX6xEkXV/TGbAmjJ1rbMeHIq9rjiEO0kon7xXghRfPntlc+EEM5sxG5lEqvRup1
	96Ps4THLh535JgZUJ9kX5mNs6PPrFrRvmdFX7th8l8IFV4Oxor5QmZ6f2pCM2gIB36swTtbCZGr
	f8THeHycV+eACl+tBuEBcsdmo/TfrOJHj8t3MfrLBa3O0zscoxMTDmxpXUO4JrtPVSBDmWZ4LLj
	xI7LaRUVnlotCdA8zOIULg3Vj6qkL5dZ78NxeSAW4/9OfFxG3B7nBh0x/BvPHpEz2dh5vUUxTcu
	rvmHQcAXlZxkTRO52O78fbKe45VPjWOmRAl0jvNip8zxPaLBdttn5k7kJ8dz0E6aigg/0v83AVL
	244OVQS14KjGt/zneNZ60gIOaQW/AD+oLPcrjHUoJDx0vrBYnk5+k28n5KS5IB8JtEyy6Wr4Y3p
	IchDGTKM1WoXYoI/5ewxtQh7DbyjjFyM8TqG6zG4i9lrJn/M7pQe8Lny2oLyH82/M4SJaWQg==
X-Google-Smtp-Source: AGHT+IEtu//eEPFSMQCQc0x4+ohl+/zP3PbtVY9Fq75VCKqTNmy1GQDGxEUmS6COuOk11FJ2AmC1hg==
X-Received: by 2002:a05:600c:1f8c:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-47d84b40955mr99606675e9.27.1767958145751;
        Fri, 09 Jan 2026 03:29:05 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:29:05 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 4/9] net: pass queue rx page size from memory provider
Date: Fri,  9 Jan 2026 11:28:43 +0000
Message-ID: <da8aa10eaa0e4dce52a0b39ed7e3829eb70e22f5.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767819709.git.asml.silence@gmail.com>
References: <cover.1767819709.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow memory providers to configure rx queues with a custom receive
page size. It's passed in struct pp_memory_provider_params, which is
copied into the queue, so it's preserved across queue restarts. Then,
it's propagated to the driver in a new queue config parameter.

Drivers should explicitly opt into using it by setting
QCFG_RX_PAGE_SIZE, in which case they should implement ndo_default_qcfg,
validate the size on queue restart and honour the current config in case
of a reset.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h   | 10 ++++++++++
 include/net/page_pool/types.h |  1 +
 net/core/netdev_rx_queue.c    |  9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index f6f1f71a24e1..feca25131930 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -15,6 +15,7 @@ struct netdev_config {
 };
 
 struct netdev_queue_config {
+	u32	rx_page_size;
 };
 
 /* See the netdev.yaml spec for definition of each statistic */
@@ -114,6 +115,11 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 			   int tx_start, int tx_end,
 			   struct netdev_queue_stats_tx *tx_sum);
 
+enum {
+	/* The queue checks and honours the page size qcfg parameter */
+	QCFG_RX_PAGE_SIZE	= 0x1,
+};
+
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
@@ -135,6 +141,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  *
  * @ndo_default_qcfg:	Populate queue config struct with defaults. Optional.
  *
+ * @supported_params:	Bitmask of supported parameters, see QCFG_*.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -158,6 +166,8 @@ struct netdev_queue_mgmt_ops {
 				    struct netdev_queue_config *qcfg);
 	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
 						 int idx);
+
+	unsigned int supported_params;
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1509a536cb85..0d453484a585 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -161,6 +161,7 @@ struct memory_provider_ops;
 struct pp_memory_provider_params {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
+	u32 rx_page_size;
 };
 
 struct page_pool {
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 86d1c0a925e3..b81cad90ba2f 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -30,12 +30,21 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
+	if (WARN_ON_ONCE(qops->supported_params && !qops->ndo_default_qcfg))
+		return -EINVAL;
+
 	netdev_assert_locked(dev);
 
 	memset(&qcfg, 0, sizeof(qcfg));
 	if (qops->ndo_default_qcfg)
 		qops->ndo_default_qcfg(dev, &qcfg);
 
+	if (rxq->mp_params.rx_page_size) {
+		if (!(qops->supported_params & QCFG_RX_PAGE_SIZE))
+			return -EOPNOTSUPP;
+		qcfg.rx_page_size = rxq->mp_params.rx_page_size;
+	}
+
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
 		return -ENOMEM;
-- 
2.52.0


