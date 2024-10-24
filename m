Return-Path: <linux-kselftest+bounces-20534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6359AE290
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797F11F2302B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383361C0DE2;
	Thu, 24 Oct 2024 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="meUcuEIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654518B46A;
	Thu, 24 Oct 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765892; cv=none; b=pk5Bh4RVehY1dhXRvjeg6dlkuHncSJ8G1aJFt6YCid07x0b71SJ0CKnnH0gn84hrfuCKg/IeuuHp11TOb54sPJCMo0dW22/dLqPuLsN9sZN091CEwei4yMueODup6kYGc2NLZ4ebAH5N2p05qH/D6By3CpxGQbGZ0UDIGeVj3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765892; c=relaxed/simple;
	bh=dIAxm1szg0eXxoUrHaRJyEkFiqNB1EbdiqdWK0Q3L7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6FC/TPQ1xkWhm5z3VDFpnyFOGbUpJl9WF2tfNJMNWQtLYvwcL0gdacK5ULIfCEJfNSekKxkWSrG1/aX5S1vjTgJ1sP6yfkeGV0h1CxLiHpInSI1XeLqhZNO5ZkjqkQGiwcWK9se6iR3R9HsGXE5y3rVfwm136Rh8tr66I2SeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=meUcuEIU; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49OAV0AH105566;
	Thu, 24 Oct 2024 05:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729765860;
	bh=7pYI8kQhzLjk8qhIVY25r6ky5/FBxidxa1N2CUq2AxI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=meUcuEIUCGevKlh1I5NWc5PRPQTLTOTK4YmrI1wNzb5KaJTIzU78AYCe50port1j+
	 xcAgZNKpRdhHstjQDVV5IILKC1rpVO9GO9G/r1zbhK83kRP9U9nRIbpyJle6pgwfRX
	 mVFCgFgjEgocNz10kfLTDynGWlVtipqxVz4tu6fQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49OAV0DB022888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Oct 2024 05:31:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 05:30:59 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 05:30:59 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49OAUxwd082187;
	Thu, 24 Oct 2024 05:30:59 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49OAUxfs024592;
	Thu, 24 Oct 2024 05:30:59 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <dan.carpenter@linaro.org>,
        <jiri@resnulli.us>, <n.zhandarovich@fintech.ru>,
        <aleksander.lobakin@intel.com>, <lukma@denx.de>, <horms@kernel.org>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>
Subject: [PATCH net-next v2 1/4] net: hsr: Add VLAN support
Date: Thu, 24 Oct 2024 16:00:53 +0530
Message-ID: <20241024103056.3201071-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024103056.3201071-1-danishanwar@ti.com>
References: <20241024103056.3201071-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: WingMan Kwok <w-kwok2@ti.com>

Add support for creating VLAN interfaces over HSR/PRP interface.

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 net/hsr/hsr_device.c  |  5 -----
 net/hsr/hsr_forward.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index ebdfd5b64e17..0ca47ebb01d3 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -572,11 +572,6 @@ void hsr_dev_setup(struct net_device *dev)
 			   NETIF_F_HW_VLAN_CTAG_TX;
 
 	dev->features = dev->hw_features;
-
-	/* VLAN on top of HSR needs testing and probably some work on
-	 * hsr_header_create() etc.
-	 */
-	dev->features |= NETIF_F_VLAN_CHALLENGED;
 }
 
 /* Return true if dev is a HSR master; return false otherwise.
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index b38060246e62..aa6acebc7c1e 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -280,6 +280,7 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
 				    struct hsr_port *port, u8 proto_version)
 {
 	struct hsr_ethhdr *hsr_ethhdr;
+	unsigned char *pc;
 	int lsdu_size;
 
 	/* pad to minimum packet size which is 60 + 6 (HSR tag) */
@@ -290,7 +291,18 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
 	if (frame->is_vlan)
 		lsdu_size -= 4;
 
-	hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
+	pc = skb_mac_header(skb);
+	if (frame->is_vlan)
+		/* This 4-byte shift (size of a vlan tag) does not
+		 * mean that the ethhdr starts there. But rather it
+		 * provides the proper environment for accessing
+		 * the fields, such as hsr_tag etc., just like
+		 * when the vlan tag is not there. This is because
+		 * the hsr tag is after the vlan tag.
+		 */
+		hsr_ethhdr = (struct hsr_ethhdr *)(pc + VLAN_HLEN);
+	else
+		hsr_ethhdr = (struct hsr_ethhdr *)pc;
 
 	hsr_set_path_id(hsr_ethhdr, port);
 	set_hsr_tag_LSDU_size(&hsr_ethhdr->hsr_tag, lsdu_size);
@@ -368,7 +380,7 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 		return skb_clone(frame->skb_std, GFP_ATOMIC);
 	}
 
-	skb = skb_copy_expand(frame->skb_std, 0,
+	skb = skb_copy_expand(frame->skb_std, skb_headroom(frame->skb_std),
 			      skb_tailroom(frame->skb_std) + HSR_HLEN,
 			      GFP_ATOMIC);
 	return prp_fill_rct(skb, frame, port);
@@ -690,9 +702,6 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 	if (frame->is_vlan) {
 		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
-		/* FIXME: */
-		netdev_warn_once(skb->dev, "VLAN not yet supported");
-		return -EINVAL;
 	}
 
 	frame->is_from_san = false;
-- 
2.34.1


