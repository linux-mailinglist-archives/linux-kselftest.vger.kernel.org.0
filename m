Return-Path: <linux-kselftest+bounces-21513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED2E9BE228
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 10:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C3028482B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 09:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83981D8DE1;
	Wed,  6 Nov 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fVEYmXbl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B0183CD6;
	Wed,  6 Nov 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884665; cv=none; b=jCk8pqAnz9BsysjeBGjVWKc0vQeBAE4B1tEOR/KGk9FQnm0ifpbsgV3R43KZbx5c5KXrvPT9ujAjLI5DsegcumfAtVPD5s5O3DNLIG3LdI7EIKC92TF5owF6gWRLyBdrL08xnDoo4REdSgd9nBtonzrAWFluVi76esU/2Zl1slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884665; c=relaxed/simple;
	bh=dIAxm1szg0eXxoUrHaRJyEkFiqNB1EbdiqdWK0Q3L7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctbqCFbbB/3a2AyWMvwsTXqyXsNSxPP8b2vzu7Z6Ua0YoO4QrIB0EeeKjVoXJbEdRcfv3ELekJbfclJMofiEKpkX+iUUP53ecx8+IOengvf1XFwAa6TJWaN4RZJJcB119KhPS7dXwpXmmID2Xn1RQdKnVmNZuRq4/rAxmCiPuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fVEYmXbl; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HFOL110698;
	Wed, 6 Nov 2024 03:17:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730884635;
	bh=7pYI8kQhzLjk8qhIVY25r6ky5/FBxidxa1N2CUq2AxI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fVEYmXbltt8Xc7Xm+CpIDL0w0E6bHBXl6InclwWRsf4S6VZdDZB1W+IN1JfI5utqJ
	 +uiqSYH1wxPcCA31bc9T2sJYI1pr/qM5+JTU+K+Urs6qF+A7iz7SmRWp9T+8M5sp0M
	 jyR8yG2HS7/v6NlLg9nf1WtP1mGHYL5fcIw2Ndf0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A69HFVt016164
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 03:17:15 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 03:17:15 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 03:17:15 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HFic081211;
	Wed, 6 Nov 2024 03:17:15 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A69HEcK020781;
	Wed, 6 Nov 2024 03:17:14 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <jiri@resnulli.us>,
        <w-kwok2@ti.com>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 1/4] net: hsr: Add VLAN support
Date: Wed, 6 Nov 2024 14:47:07 +0530
Message-ID: <20241106091710.3308519-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106091710.3308519-1-danishanwar@ti.com>
References: <20241106091710.3308519-1-danishanwar@ti.com>
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


