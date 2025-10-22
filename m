Return-Path: <linux-kselftest+bounces-43790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F415BFDDA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075011A068C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370C351FC4;
	Wed, 22 Oct 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c8ugQxfR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A034C141;
	Wed, 22 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157688; cv=none; b=MAPYvRwsmwXmqh1z8r52tyVDNIjiGt1UGSKbgm5DzZeUcWlll6dK+478lmBGQqTKLsDbXIQ31FLvIfmGgzBhFJMizSrzvkeCxIooQ7TPU8rRjLniVbRV/YiE7hTQoqEYHD7rUdRH8dllFIHH/prVr8n+ykel+9y4YG06zW1aTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157688; c=relaxed/simple;
	bh=yT+iRQluR+WAK0XYuUr/lcLMSQ8hcFNXEdZG0B+tFH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLCSjZYNaB9FYKzBpulQa30UACIso/yRJ4FprsBzbJuuS9XzdxCn4dDy913vl9x/ME20Jx13bW7DA8lTrr4OMfu/J+ee5vWf153XACraSEmWCe339mZ2id6icPUbByAXAYRyKyTsGeDehTLWgbTV6SO7QHU3YtT+6yzVIj/0y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c8ugQxfR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MEbAfR020450;
	Wed, 22 Oct 2025 18:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/rCb8AhEm5gfz86Jt
	PZfc7LccG/iHcUG6DHL9ME7yr0=; b=c8ugQxfRTHzaYScAfF1gJiL6CyAS5jDdg
	4reEmmDCzAAuok0A7AgOXFF3QbYDJm+hoPGGH/YRAnJcb65dvXF+40SElZE382Rn
	QUP8lpAmtW+yDRMNEMw9fACI8PN2tGCyyM+zLTvUyUzgmsKc0sqfrqH9hifD2R6h
	+KZJtc/MCDu5jT3fpsPkYFp59H9AKIRiKc5U4Gg2AQxB8lsZdDSsr+Z1v21F4BN5
	8vMaK+eos90wYYk9EYqlUJGM5psFk5ZIwWWPa1AOQ6D0rj/4Vp001K1IMm5U5lzR
	IDH9Z59cYHllmkR+NYr18lr9J9uBMSi1xGxIswS+dnxa4Mnfqkkxw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIRrVi025006;
	Wed, 22 Oct 2025 18:27:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MGCWfa014658;
	Wed, 22 Oct 2025 18:27:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sa3ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MIRp7F10224272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:27:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D2425805D;
	Wed, 22 Oct 2025 18:27:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2D3458052;
	Wed, 22 Oct 2025 18:27:50 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:27:50 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
        razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH net-next v14 6/7] bonding: Update for extended arp_ip_target format.
Date: Wed, 22 Oct 2025 11:25:33 -0700
Message-ID: <20251022182721.2567561-7-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: PLe7zvkU-bwZ6CZ8QWtNKmN1eJ9MMhRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzZsAho106C8E
 ACYA2WzPzX2nYpRMeUt48Jy7fBS1T2pOmF7aN9s8DNH8mf0CgdH810/K1RWKLEJ9DtWVqEo2XYO
 cYdVTwIR3xrZj46wgdipMszSfqI7nJmUyoKryyOuxPrMZF0dflGiocZvq8LrSRDkuPv/qehBH34
 J45zLPCFUXJdQ3s4ni3luGf88E4nROXM4tWkdUZoldDuC52QdAmUPZoyCO2VN1gwECjg8d8ndOY
 9mmme8N9xAADQyjpwCp/fSQxvzKcgGJmyMHCHbYnQXy4YOMzuqkKkGUprQBNtAsMVd60b7azM12
 tJAOXAETuwzS/IgbSZci7KeCd29uZGZ+oRdHFqmkxfD3IeRM5/E0h/MkqQjHlOBZd6dCOWJgzgz
 KLhkrJSlrkvEWZl066o7q//IJm/lpw==
X-Proofpoint-GUID: eMj38YYeqO9TTnF1ayEMKn69fj4VQkAV
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f9222a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Hn20HZpmeNSaDzm9T5gA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Updated bond_fill_info() to support extended arp_ip_target format.

Forward and backward compatibility between the kernel and iproute2 is
preserved.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c | 34 ++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 15782745fa4d..ba6a48901255 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -16,6 +16,11 @@
 #include <net/bonding.h>
 #include <net/ipv6.h>
 
+struct bond_arp_ip_target_payload {
+	__be32 addr;
+	struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
+} __packed;
+
 static size_t bond_get_slave_size(const struct net_device *bond_dev,
 				  const struct net_device *slave_dev)
 {
@@ -626,7 +631,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_ARP_INTERVAL */
 						/* IFLA_BOND_ARP_IP_TARGET */
 		nla_total_size(sizeof(struct nlattr)) +
-		nla_total_size(sizeof(u32)) * BOND_MAX_ARP_TARGETS +
+		nla_total_size(sizeof(struct bond_arp_ip_target_payload)) * BOND_MAX_ARP_TARGETS +
 		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_ARP_VALIDATE */
 		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_ARP_ALL_TARGETS */
 		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_PRIMARY */
@@ -678,6 +683,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			  const struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_arp_target *arptargets;
 	unsigned int packets_per_slave;
 	int ifindex, i, targets_added;
 	struct nlattr *targets;
@@ -716,12 +722,28 @@ static int bond_fill_info(struct sk_buff *skb,
 		goto nla_put_failure;
 
 	targets_added = 0;
-	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i].target_ip) {
-			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
-				goto nla_put_failure;
-			targets_added = 1;
+
+	arptargets = bond->params.arp_targets;
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && arptargets[i].target_ip ; i++) {
+		struct bond_arp_ip_target_payload data = {};
+		int level, size;
+
+		data.addr = arptargets[i].target_ip;
+		size = sizeof(__be32);
+		targets_added = 1;
+
+		if (arptargets[i].flags & BOND_TARGET_USERTAGS) {
+			for (level = 0; level < BOND_MAX_VLAN_TAGS + 1 ; level++) {
+				data.vlans[level].vlan_proto = arptargets[i].tags[level].vlan_proto;
+				data.vlans[level].vlan_id = arptargets[i].tags[level].vlan_id;
+				size = size + sizeof(struct bond_vlan_tag);
+				if (arptargets[i].tags[level].vlan_proto == BOND_VLAN_PROTO_NONE)
+					break;
+			}
 		}
+
+		if (nla_put(skb, i, size, &data))
+			goto nla_put_failure;
 	}
 
 	if (targets_added)
-- 
2.50.1


