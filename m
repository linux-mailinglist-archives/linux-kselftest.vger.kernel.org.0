Return-Path: <linux-kselftest+bounces-21556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240189BF9C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F551C21ACE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52920E306;
	Wed,  6 Nov 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="tUnTnZid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M5fk3Reu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210920E03C;
	Wed,  6 Nov 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934848; cv=none; b=ByXPMN+Fgd094FO6fzWlZGIZILCFfylLPp1nWPAsEZLU3Ztq34noyLoUwfX8/vzFibj4Y70uj9M1VHkZtrrH5w1lqQV61hy8PhoIMRLxMfpcPD70Xw29GF8Npxkm282cGPwWSuHtKo2M4E0mdr3rUK2OS08shGjVJ47iMLngASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934848; c=relaxed/simple;
	bh=rXCNYxoxJcPmvIxxy0Avj2TITqZEFU2/8cnl/Uh3lWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV8tvc5bk+stbCvQ7TBgBVieRXga6E3n2ITfqozxGe0TrEiemGPlfLsRTCKKsITMyUCEmdI8d5h0o6vvDaKkCMnFenLCSvWcmbX6+41d646ekAUIIzZG80GmCJ6zLA35Ce2sbzqSiHthbU4d3NeOZZtnCt49kFdaDUDCw8eqstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=tUnTnZid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M5fk3Reu; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id C36F61D402E4;
	Wed,  6 Nov 2024 18:14:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 18:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934845; x=
	1730938445; bh=z2pmxZ1YgDOgUkHR9UX+jDUIkxOfNwEcS4gC3HCEiL8=; b=t
	UnTnZideGp0ziWREJGhXBWOZJRTRBA7lG3pPaY661cEC5esRS06zFgAVDYOspTTi
	dD6szKY16MmtBbERqudh4TAzaJVXZslGo+R9m0dlchiDeSjvvD1XTglKYz0M2TlG
	cx0w6UJleZnc1pYi1nr8CpHwtRDgf7RQeAysWNlXlMgQBuvTV3KIme+nUn9NgCjU
	7ujiYmQ0yP6YBH7V0TjuD7KB9lkEn12bhFUyQDbaH0vsYF3IUA9EzPd3uF95DWFR
	IbVtpvKkfRBMqIPbfgJHtC8bWb9v+e4AENoFGxqIAcCyS2DTVZuLix19utop6I+j
	Zn06ufyUCPpYJF4Qvd0Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934845; x=1730938445; bh=z
	2pmxZ1YgDOgUkHR9UX+jDUIkxOfNwEcS4gC3HCEiL8=; b=M5fk3ReuR4dU4/7i0
	orr8x4q/d64xsNei4UTl4IwjhW3FVqzpgwuItE7oJ/xWGycEGmUQ5X/JW/lrmS92
	XHhk3dap5NIVeqF9JKG99aP57HSXlBO/N9zWgD5D98dIJ3C+US7mZOPUfHmhJWsN
	zS8BXdTpGi93XUayDFoSY5m+Ws74OUvBNB4ZX91ir4vtieyQluRRbv+oZaFJNxKw
	GN7ZRku2rG5wCfdSLWfq6cFgLTqtKaCIp3tW2TQB1QAHkUpISHkn9vjntVfjVl3q
	Ar1LJ/7f1otchlaRLz9uGT5L2o7FUEG7u25r3D7RR8oBYABWSiDf8kL5b4/zQ7tt
	Q2aUQ==
X-ME-Sender: <xms:PfgrZ7NRXkCowYK7bQs3Rp_6g8xlqmT3-WmIA1Qh10Xd_IQ1ZwKeog>
    <xme:PfgrZ1-3ifgzuD80bjkat8qV1FENFudoBuTzUEqnNxnwY9-uxpRD2hwX6e_-bJJOF
    c6j4gXcPzmwcrwSuek>
X-ME-Received: <xmr:PfgrZ6TFVvKGinwu16qBK-GoRxkfEEh7u0KGvW2xjrZdYR7tQVjxE8zcJG0B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PfgrZ_vqltSHumDuQcNSK9dWoqqY-wRe9qDG_1D6CoVPAsMbPTqa9A>
    <xmx:PfgrZzdTB6H6O9s5DlPDKXWafWh3j2wZQqysDsA9Babpq9fKVcDtOQ>
    <xmx:PfgrZ710fA7mola9qVx8ViNQOI9-oVK8EgTXzINQ37oLVFqPVnThAg>
    <xmx:PfgrZ_8TufK8td_YO96xopH3HmLgEmdhcvUfqURzJN8BZfb0zKNv6w>
    <xmx:PfgrZ0rwXjsaOoLSHz3naKCFqTmigj1bTz2DB-NPf_7FKhU_U1VlonB3>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:14:05 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 5/8] macsec: inherit lower device's TSO limits when offloading
Date: Thu,  7 Nov 2024 00:13:31 +0100
Message-ID: <8240c0181e851f169d815f59658a01fb9dfc5073.1730929545.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730929545.git.sd@queasysnail.net>
References: <cover.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If macsec is offloaded, we need to follow the lower device's
capabilities, like VLAN devices do.

Leave the limits unchanged when the offload is disabled.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index e6670e876ff6..24c190d9b959 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2621,6 +2621,17 @@ static void macsec_set_head_tail_room(struct net_device *dev)
 	dev->needed_tailroom = real_dev->needed_tailroom + needed_tailroom;
 }
 
+static void macsec_inherit_tso_max(struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+
+	/* if macsec is offloaded, we need to follow the lower
+	 * device's capabilities. otherwise, we can ignore them.
+	 */
+	if (macsec_is_offloaded(macsec))
+		netif_inherit_tso_max(dev, macsec->real_dev);
+}
+
 static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
 {
 	enum macsec_offload prev_offload;
@@ -2666,6 +2677,8 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	macsec_set_head_tail_room(dev);
 	macsec->insert_tx_tag = macsec_needs_tx_tag(macsec, ops);
 
+	macsec_inherit_tso_max(dev);
+
 	netdev_update_features(dev);
 
 	return ret;
@@ -3537,6 +3550,8 @@ static int macsec_dev_init(struct net_device *dev)
 	if (err)
 		return err;
 
+	macsec_inherit_tso_max(dev);
+
 	dev->hw_features = real_dev->hw_features & MACSEC_OFFLOAD_FEATURES;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 
@@ -4479,6 +4494,13 @@ static int macsec_notify(struct notifier_block *this, unsigned long event,
 			if (dev->mtu > mtu)
 				dev_set_mtu(dev, mtu);
 		}
+		break;
+	case NETDEV_FEAT_CHANGE:
+		list_for_each_entry(m, &rxd->secys, secys) {
+			macsec_inherit_tso_max(m->secy.netdev);
+			netdev_update_features(m->secy.netdev);
+		}
+		break;
 	}
 
 	return NOTIFY_OK;
-- 
2.47.0


