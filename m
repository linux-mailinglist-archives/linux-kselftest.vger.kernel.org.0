Return-Path: <linux-kselftest+bounces-48602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEECD08E98
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD8023014DFE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664F35BDDE;
	Fri,  9 Jan 2026 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXe9VPz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948235B147
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958159; cv=none; b=WCyEZNcGa/xcqhQEx2kE0WtxgYj+hmbcqs9lDL7agwHbSi5b2eWSnneWnsj0HTLAQHGpaa5HLqAwcsiunLhMswbwSuai0zMI4vlgA3oh3cp36+G3so78+EP7A8ana3tCt7b+aNwOQj305/r7GXyT8jhP5bpeiyZJh2Vqw9cqJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958159; c=relaxed/simple;
	bh=F6waAxUTN0XHkxjyQT+jUXiZnFRXTIpv+p7I9hYKiIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBd0aSsWHq8F81zFgRsLwpdrPXezG7zia9LhgordzEd1tMWouhfXtodWE/JtzsxUBbCCuKEl9MB+B3epqRI2EaeiPvLFsQxVEfBJXXCqSKBXLGom44AuENC7EaS6sa4BH2ZOyd5AwX64mpa8xRFDhtSN9uOeYqIAofmg9szAXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXe9VPz5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so36786125e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958153; x=1768562953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkGYuXz+QxHGRROmceDvRDL3xnFuc5UQrONsfTFdwcU=;
        b=hXe9VPz5zpwUdxHdQiNA7nI7D89AQSveggNCgVpkqkyCGsukQrI2unq7opkC9S70QQ
         Ma3zfkPfDUchjPMEWupLTGaO52psc0mwkWd9sHH0rVDMpJ/s47PPp/C/qQYRoWs5cWOw
         p0zwWsuRel4KPLiXU1oykrX0YVN3ZClfZLk69wJYfhTz2dgqJjX5InV/gzoij6MTQFzj
         ZZcTi2drf7HmcEjpmvWNx1GOynGzLktFNmg/od6VyS2UB7nPosKJXOSHbHPMZufx9OxL
         CuzbUvqb6Ugpd5rIAnXpo+GMO05CiFtWBfNlTCgqkedlFa8dFNmiVxO9h0hHzAqwFhRW
         NJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958153; x=1768562953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkGYuXz+QxHGRROmceDvRDL3xnFuc5UQrONsfTFdwcU=;
        b=s86IdcCuAUtAzwku+b1iKBtt/3PE+1VYNQVOvxbuWlQ7yz8CinvObxFMkpPhfeK94q
         3yMX/BekO2eQNSJxR1p7UJ9FFU4ojYWzBA3TycgsjP5vVIpGBMOKn7nFHgFmqrX8dhJE
         OBIyAV8pgRBIHQdxQhwJYGwWF6vsepx3emdb0thk+xUkp6mrkaYC0gpC1qDaqUVDzzZN
         3h1nKn6zEOJviCIGgdbp6q/aVNi5RFMsM5PPKrs8ECzGVWseZHv4rGIJ0WBjZTNXxVXE
         jsbobR21ir9Z2u4mQoQggaOISBJvhKgfA1d02QLOO3nYOyY8CV/evnAmDOZCRljeYHrb
         5Bbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZxgemJRUvQ35C7xgCqymjSHiydf7j9Bn/5PQHU4fQAwdxJOW55LuwjUClVTaGVLz93YSNxV8E3SQU/xz2dnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK61McVaKpnwG/4Y0HiHlvugqVzTcZdBJAAObn1kEuWh8hJWrv
	oUGDBenHSNjNmOqVq/qf9aE0ZFYUiWH/BxUJ39wfGQbX97BYTnnwdCCj
X-Gm-Gg: AY/fxX75k/KXwxHjM9ncH7kkdS8AWLlhV4A/enroykD6QhZNl6Xn5IgUy1/zq9lH0re
	bX4UB+Cz0aXgxbjdZBX01Xfy3EzcchNHAtXzKf5/gm0j5+L8JUBVv6/sg+dsL/OTX9ttRtcS0rq
	uRIFFwZmoOF9KcKz7DN47D6sykBO7p+BGtkEPWjw9lOkCk7JnMsAZA/6F3RGyqbFCHewsFsuLSi
	di3MnfvYBMIPo0yK1fiiI0UDImA2Hcb1zQUxw7LL7X+7xXIxIa5+J0oj1rSeusvtb8p1SgBCrmu
	GJWX7t6FxVTRp1dWOHuKds9TQRj7l2PsAok3Dh6x6+cxZni1yIKj7CUPlViL045dKQWDn1Mcxm5
	q6em5qYgRJ8GiBBTqMfvBYt3y3hXB6mfyXeuZ9Vk9yAiW7X8SvF/Ev9kvRaG4sApbidyjWRHfhn
	tC6sExR7pu5emRsqzsMH6tSU3ZU8tC+iccaQEDwXplW2jJ6cqqtgWs6IbVkFHmXKPBiV4LGYmSl
	1j773Gv
X-Google-Smtp-Source: AGHT+IFSy1+lFxUURQmqDSNKN0HOOFkFOx1ujyLXJg2nypF43Lq0YrQtt9+vrxTHS0Rrgmo+7XmdqQ==
X-Received: by 2002:a05:600c:1d14:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-47d84b0a7bdmr104836275e9.1.1767958152875;
        Fri, 09 Jan 2026 03:29:12 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:29:12 -0800 (PST)
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
Subject: [PATCH net-next v8 7/9] eth: bnxt: support qcfg provided rx page size
Date: Fri,  9 Jan 2026 11:28:46 +0000
Message-ID: <28028611f572ded416b8ab653f1b9515b0337fba.1767819709.git.asml.silence@gmail.com>
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

Implement support for qcfg provided rx page sizes. For that, implement
the ndo_default_qcfg callback and validate the config on restart. Also,
use the current config's value in bnxt_init_ring_struct to retain the
correct size across resets.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 137e348d2b9c..3ffe4fe159d3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4325,6 +4325,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		struct bnxt_rx_ring_info *rxr;
 		struct bnxt_tx_ring_info *txr;
 		struct bnxt_ring_struct *ring;
+		struct netdev_rx_queue *rxq;
 
 		if (!bnapi)
 			continue;
@@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
+		rxq = __netif_get_rx_queue(bp->dev, i);
+		rxr->rx_page_size = rxq->qcfg.rx_page_size;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
@@ -15932,6 +15934,29 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static void bnxt_queue_default_qcfg(struct net_device *dev,
+				    struct netdev_queue_config *qcfg)
+{
+	qcfg->rx_page_size = BNXT_RX_PAGE_SIZE;
+}
+
+static int bnxt_validate_qcfg(struct bnxt *bp, struct netdev_queue_config *qcfg)
+{
+	/* Older chips need MSS calc so rx_page_size is not supported */
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
+	     qcfg->rx_page_size != BNXT_RX_PAGE_SIZE)
+		return -EINVAL;
+
+	if (!is_power_of_2(qcfg->rx_page_size))
+		return -ERANGE;
+
+	if (qcfg->rx_page_size < BNXT_RX_PAGE_SIZE ||
+	    qcfg->rx_page_size > BNXT_MAX_RX_PAGE_SIZE)
+		return -ERANGE;
+
+	return 0;
+}
+
 static int bnxt_queue_mem_alloc(struct net_device *dev,
 				struct netdev_queue_config *qcfg,
 				void *qmem, int idx)
@@ -15944,6 +15969,10 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
+	rc = bnxt_validate_qcfg(bp, qcfg);
+	if (rc < 0)
+		return rc;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15955,6 +15984,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
+	clone->rx_page_size = qcfg->rx_page_size;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16081,6 +16111,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_agg_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16235,6 +16267,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
+	.ndo_default_qcfg	= bnxt_queue_default_qcfg,
+	.supported_params	= QCFG_RX_PAGE_SIZE,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4c880a9fba92..d245eefbbdda 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -760,6 +760,7 @@ struct nqe_cn {
 #endif
 
 #define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE BIT(15)
 
 #define BNXT_MAX_MTU		9500
 
-- 
2.52.0


