Return-Path: <linux-kselftest+bounces-43787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF90BFDD8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E29554E77B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE94734C98A;
	Wed, 22 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i+1ZZL6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDD348881;
	Wed, 22 Oct 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157686; cv=none; b=mBrhiPaYDEhsidh+/Ww85d/0LWp3+2BKS0M7Di8cnhEXcaboo9kzmYdmeixH+8mkoEJWphMzqxSkCFGvBV1PCSOnYcE165LeSA11YlBUyy7thwUx9czPC2cuygcWkC8SaFIN8eSKncZ2E47n1Bigl+W5qH6HKk7HGxa+t2b9e1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157686; c=relaxed/simple;
	bh=1khlhEz0vuh2kXS7tqtBwgJ13DPXLjPXKZH0KlN7xtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRtthAsW3fdSHK0dOVO2mT06UxYIIRxoqS+Srk8H9ZLWnuzD1wLKVjM/KNQXVCNGC5YElXUigK8N+uQEOJuQGgJeAzYMve/UAvyztYu3UzS3GMI4zaydjjLvvNp+LZCYEmO7gIOyu/8+YXGZJ/lTLPOtxC7PGnFOhpTU4jjvrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i+1ZZL6n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MFRJ40013813;
	Wed, 22 Oct 2025 18:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UfXeMA8MsuKnyoieB
	zJx4gmrkDYzHYC51bgiyrNoN7E=; b=i+1ZZL6ny621KXXJDJI9diKE6167slLek
	vyX3W6I63Vw5slmRJ1XBSpEx4dSfGfc2o0XjwlyxUB4AQTxhd5YNUxUy1JpvqGqY
	qhagwgpDAKpiu+ExQTTr/sDvtrRGO8mp/n0uu5GhRGNkuTuNbAVobkfiVp5eUSV8
	GoVANrJdCOhTWZZgrO8IkcRcFmbdXQOSWi/Shw6ErxngjYAjsbOyJZmWpi8N+inh
	Gtbb/oO4VnBis6r+EbcMGvXEzK/+niucirDNWY5VduJ78oDgLSxCBd6hgOPLeqdS
	bEJeYuyMa51pVIh0HxqGo301URidWftSSSEf8DsLki4SfE3ocOFbQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIQhCM022619;
	Wed, 22 Oct 2025 18:27:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHk8wP024677;
	Wed, 22 Oct 2025 18:27:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk1tw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:51 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MIRokB8847894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:27:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 458EB5805F;
	Wed, 22 Oct 2025 18:27:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02E3458052;
	Wed, 22 Oct 2025 18:27:50 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:27:49 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
        razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH net-next v14 5/7] bonding: Update to bond_arp_send_all() to use supplied vlan tags
Date: Wed, 22 Oct 2025 11:25:32 -0700
Message-ID: <20251022182721.2567561-6-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022182721.2567561-1-wilder@us.ibm.com>
References: <20251022182721.2567561-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8d_PNJWgFJzbs7tqYu6K3-ZBSRvYM6Ej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXz6ecw11hajaf
 qCjCDH0OlJiWojQRjX7UZtTb5Zz9BMU4rEHVkxYkqZQvvpckc1vPRMDfdKH1/62d4tYHILUKVDD
 +2kOWYyWC/MgIFaNFJh+q0X+/iE0HcCK4PEgbFUlOPHBDCmoyv0dpEStUeUWBr3Tqc8e82Gnx+5
 Woy9aCO6p4tn9My/tCdZSoPk/UJZH8YpI77El+VHGgn9XuNXqSN+I5Gwjb/3v0at/D3FKoU+NdR
 EnrbHZZYNSdwycJiakEbb3Z0URUIY3Oq1tTIFOCwNWvsaOo41Ozc9LzhIWpOJQZo/JHC8U9X27b
 JvlqRaIUyJy8uFQS3AiVvHX1ihnFUR7GVPV7WwFcftuUccs9Xjga48856qCkbN83e7fn5l8LZOF
 wdLIuFoPcS6ShAT8BgI1h2rksMRJZA==
X-Proofpoint-GUID: 7cGouJs2F2jdYmLpZlniFXo8V4b266aL
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f92229 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=vY6KpHgGsgsBOyHPQ_YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

bond_arp_send_all() will pass the vlan tags supplied by
the user to bond_arp_send(). If vlan tags have not been
supplied the vlans in the path to the target will be
discovered by bond_verify_device_path().

bond_uninit() is also updated to free vlan tags when a
bond is destroyed.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3f35303b4920..9817be7c3c5b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3064,18 +3064,21 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 
 static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
-	struct rtable *rt;
-	struct bond_vlan_tag *tags;
 	struct bond_arp_target *targets = bond->params.arp_targets;
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
+	struct bond_vlan_tag *tags;
 	__be32 target_ip, addr;
+	struct rtable *rt;
+	u32 flags;
 	int i;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
 		target_ip = targets[i].target_ip;
 		tags = targets[i].tags;
+		flags = targets[i].flags;
 
-		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &target_ip);
+		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__,
+			  bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf)));
 
 		/* Find out through which dev should the packet go */
 		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
@@ -3097,9 +3100,11 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		if (rt->dst.dev == bond->dev)
 			goto found;
 
-		rcu_read_lock();
-		tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
-		rcu_read_unlock();
+		if (!(flags & BOND_TARGET_USERTAGS)) {
+			rcu_read_lock();
+			tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
+			rcu_read_unlock();
+		}
 
 		if (!IS_ERR_OR_NULL(tags))
 			goto found;
@@ -3115,7 +3120,8 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
-		kfree(tags);
+		if (!(flags & BOND_TARGET_USERTAGS))
+			kfree(tags);
 	}
 }
 
@@ -6047,6 +6053,7 @@ static void bond_uninit(struct net_device *bond_dev)
 	bond_for_each_slave(bond, slave, iter)
 		__bond_release_one(bond_dev, slave->dev, true, true);
 	netdev_info(bond_dev, "Released all slaves\n");
+	bond_free_vlan_tags(bond->params.arp_targets);
 
 #ifdef CONFIG_XFRM_OFFLOAD
 	mutex_destroy(&bond->ipsec_lock);
-- 
2.50.1


