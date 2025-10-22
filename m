Return-Path: <linux-kselftest+bounces-43785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0BBFDD7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E84A4E693A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279C34B423;
	Wed, 22 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHHnA8GY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EED34A760;
	Wed, 22 Oct 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157685; cv=none; b=hHtN+j2S+wzpRFDcENvoBE+VtSbdPMbJT2IITL694F7R5f8KNvZX7OtCVJ+y2XsDU6kZ/CwCwhi0oDibp5Am5GVfFSesYLPTmLq9m96VAcVvOYH4xqGDUjVwze8zXP8WFXi+fyrG2m4JZcc4A68HhAUd5lh85IPxA5NbUzKo4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157685; c=relaxed/simple;
	bh=alzgymCj7Y1623ahGwAQ/iO3f9rJW4tXQKPkDukGdIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVL5/CZo89Jd0GJ+G+Nl04+m2cE4FyLEGcDbyQT//Wmi+wzLvL3HeeRfXeiuceLvfoVd03gd9EFHkLgGJ1uh04K4yeEB04VlwpEXPOFzxsyijaSA+m0IWQZ+P/YGugWQibPNA9eIgaFwU2TdNFgo+wg9ZaV6X1Pu5Ty/1i2X88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHHnA8GY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MATBJJ015516;
	Wed, 22 Oct 2025 18:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BNnti3a5ATpbYwF5b
	Tb+4Ceds1ZM8L97NXaXIWVUof4=; b=aHHnA8GYdf7jW5eiqvG/VAmra2uFyLLAX
	E2h10jkMiHpHZt1zkzwx69xKXb8HdcH7VDbJVd0mwlKreAQGQ7gJN1WjMbSDXN5x
	WMJtNKg6o25TT1IJlJXtgABfvRWAwEDny30r9mJ21dmSsWnsABzjGzhoPPfLTBoe
	szhFtmLE5k5Hy0EQwrBcJBKG7LIYKcqVPU5V2P6Dr+Le3cY1IMn5zGAF1tDdCBuK
	ik73UXtXUSCzO+f0CbJdZkzdnxgc3oeQyNlGB/GotoGGg1RnR+i74Ht45+xoD/AU
	yhhKCGR7XCal94E3grXGF/Vi2xlfQDno0IESi1/eJk6yimXsh25tw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326xcgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:50 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIRnvw032019;
	Wed, 22 Oct 2025 18:27:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326xcgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MGJG1w014663;
	Wed, 22 Oct 2025 18:27:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sa3uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MIRk754391530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:27:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACB685805D;
	Wed, 22 Oct 2025 18:27:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6469258065;
	Wed, 22 Oct 2025 18:27:46 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:27:46 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
        razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH net-next v14 1/7] bonding: Adding struct bond_arp_target
Date: Wed, 22 Oct 2025 11:25:28 -0700
Message-ID: <20251022182721.2567561-2-wilder@us.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f92226 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Al8d5LBM4mRIXYHQ2n4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxlg1V2nCcYbr
 vIlqU5Xwnuo9JWhsz14PupGlIEMoiY+x5ZD5ZAFiCRLqpaogjBlZP70rVoejp3zthuKqBKWoyhB
 qBSPEZKsqwA/4ZanjrjBXCyNzbFtZgwNezcJcgd/A6GieZmgV482AVRWZCdls3gSrNoH18DR0dX
 F2e78aF+05+sjrFAY+kjbqEmoOvnrBkIAfh0WpIqjQ7PhvEj+o1XA68tM0uZWq5QtZVN+HuQKsK
 RQ0MTBzeI5QqsysVAn1kI4DqiDEeQNk9qggnMJhgaObP3RJnXTTs8ns6S1rmB+efzblUCsJPS/x
 Ct72OedJlgDDHwhAlD1TzS0KwnzKzcpUZdD+kwCUJKScmlm25zkv7fssEjcNED8S2zfq5sLIbYG
 gl+KVGqrWnp6C4c3taY0efOJ/+S1KA==
X-Proofpoint-GUID: 2t_R3uqDB58gH8bc24kCVXzyMNlpyxKR
X-Proofpoint-ORIG-GUID: oj6IXaLdpH8B2gbqIUrEuzFRduImOl7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Replacing the definition of bond_params.arp_targets (__be32 arp_targets[])
with:

struct bond_arp_target {
	__be32			target_ip;
	u32                     flags;
	struct bond_vlan_tag	*tags;
};

To provide storage for a list of vlan tags for each target.

All references to arp_target are change to use the new structure.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_main.c    | 29 ++++++++++++++++-------------
 drivers/net/bonding/bond_netlink.c |  4 ++--
 drivers/net/bonding/bond_options.c | 18 +++++++++---------
 drivers/net/bonding/bond_procfs.c  |  4 ++--
 drivers/net/bonding/bond_sysfs.c   |  4 ++--
 include/net/bond_options.h         | 20 ++++++++++++++++++++
 include/net/bonding.h              | 15 +++++----------
 7 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4da619210c1f..3f35303b4920 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3066,26 +3066,29 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 {
 	struct rtable *rt;
 	struct bond_vlan_tag *tags;
-	__be32 *targets = bond->params.arp_targets, addr;
+	struct bond_arp_target *targets = bond->params.arp_targets;
+	__be32 target_ip, addr;
 	int i;
 
-	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i]; i++) {
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
+		target_ip = targets[i].target_ip;
+		tags = targets[i].tags;
+
 		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
-			  __func__, &targets[i]);
-		tags = NULL;
+			  __func__, &target_ip);
 
 		/* Find out through which dev should the packet go */
-		rt = ip_route_output(dev_net(bond->dev), targets[i], 0, 0, 0,
+		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
 				     RT_SCOPE_LINK);
 		if (IS_ERR(rt)) {
-			/* there's no route to target - try to send arp
+			/* there's no route to target_ip - try to send arp
 			 * probe to generate any traffic (arp_validate=0)
 			 */
 			if (bond->params.arp_validate)
 				pr_warn_once("%s: no route to arp_ip_target %pI4 and arp_validate is set\n",
 					     bond->dev->name,
-					     &targets[i]);
-			bond_arp_send(slave, ARPOP_REQUEST, targets[i],
+					     &target_ip);
+			bond_arp_send(slave, ARPOP_REQUEST, target_ip,
 				      0, tags);
 			continue;
 		}
@@ -3103,15 +3106,15 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 
 		/* Not our device - skip */
 		slave_dbg(bond->dev, slave->dev, "no path to arp_ip_target %pI4 via rt.dev %s\n",
-			   &targets[i], rt->dst.dev ? rt->dst.dev->name : "NULL");
+			   &target_ip, rt->dst.dev ? rt->dst.dev->name : "NULL");
 
 		ip_rt_put(rt);
 		continue;
 
 found:
-		addr = bond_confirm_addr(rt->dst.dev, targets[i], 0);
+		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
 		ip_rt_put(rt);
-		bond_arp_send(slave, ARPOP_REQUEST, targets[i], addr, tags);
+		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
 		kfree(tags);
 	}
 }
@@ -6066,7 +6069,7 @@ static int __init bond_check_params(struct bond_params *params)
 	int arp_all_targets_value = 0;
 	u16 ad_actor_sys_prio = 0;
 	u16 ad_user_port_key = 0;
-	__be32 arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
+	struct bond_arp_target arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
 	int arp_ip_count;
 	int bond_mode	= BOND_MODE_ROUNDROBIN;
 	int xmit_hashtype = BOND_XMIT_POLICY_LAYER2;
@@ -6260,7 +6263,7 @@ static int __init bond_check_params(struct bond_params *params)
 			arp_interval = 0;
 		} else {
 			if (bond_get_targets_ip(arp_target, ip) == -1)
-				arp_target[arp_ip_count++] = ip;
+				arp_target[arp_ip_count++].target_ip = ip;
 			else
 				pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\n",
 					&ip);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 286f11c517f7..566a11bb7f1e 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -716,8 +716,8 @@ static int bond_fill_info(struct sk_buff *skb,
 
 	targets_added = 0;
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i]) {
-			if (nla_put_be32(skb, i, bond->params.arp_targets[i]))
+		if (bond->params.arp_targets[i].target_ip) {
+			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
 				goto nla_put_failure;
 			targets_added = 1;
 		}
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 495a87f2ea7c..91d57ba968d6 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1125,7 +1125,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 			netdev_dbg(bond->dev, "ARP monitoring cannot be used with MII monitoring. Disabling MII monitoring\n");
 			bond->params.miimon = 0;
 		}
-		if (!bond->params.arp_targets[0])
+		if (!bond->params.arp_targets[0].target_ip)
 			netdev_dbg(bond->dev, "ARP monitoring has been set up, but no ARP targets have been specified\n");
 	}
 	if (bond->dev->flags & IFF_UP) {
@@ -1153,20 +1153,20 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 					    __be32 target,
 					    unsigned long last_rx)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct bond_arp_target *targets = bond->params.arp_targets;
 	struct list_head *iter;
 	struct slave *slave;
 
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
 			slave->target_last_arp_rx[slot] = last_rx;
-		targets[slot] = target;
+		targets[slot].target_ip = target;
 	}
 }
 
 static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct bond_arp_target *targets = bond->params.arp_targets;
 	int ind;
 
 	if (!bond_is_ip_target_ok(target)) {
@@ -1201,7 +1201,7 @@ static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 
 static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 {
-	__be32 *targets = bond->params.arp_targets;
+	struct bond_arp_target *targets = bond->params.arp_targets;
 	struct list_head *iter;
 	struct slave *slave;
 	unsigned long *targets_rx;
@@ -1220,20 +1220,20 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 		return -EINVAL;
 	}
 
-	if (ind == 0 && !targets[1] && bond->params.arp_interval)
+	if (ind == 0 && !targets[1].target_ip && bond->params.arp_interval)
 		netdev_warn(bond->dev, "Removing last arp target with arp_interval on\n");
 
 	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);
 
 	bond_for_each_slave(bond, slave, iter) {
 		targets_rx = slave->target_last_arp_rx;
-		for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
+		for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
 			targets_rx[i] = targets_rx[i+1];
 		targets_rx[i] = 0;
 	}
-	for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
+	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
 		targets[i] = targets[i+1];
-	targets[i] = 0;
+	targets[i].target_ip = 0;
 
 	return 0;
 }
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 7edf72ec816a..94e6fd7041ee 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -121,11 +121,11 @@ static void bond_info_show_master(struct seq_file *seq)
 		seq_printf(seq, "ARP IP target/s (n.n.n.n form):");
 
 		for (i = 0; (i < BOND_MAX_ARP_TARGETS); i++) {
-			if (!bond->params.arp_targets[i])
+			if (!bond->params.arp_targets[i].target_ip)
 				break;
 			if (printed)
 				seq_printf(seq, ",");
-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i]);
+			seq_printf(seq, " %pI4", &bond->params.arp_targets[i].target_ip);
 			printed = 1;
 		}
 		seq_printf(seq, "\n");
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 9a75ad3181ab..7114bd4d7735 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -290,9 +290,9 @@ static ssize_t bonding_show_arp_targets(struct device *d,
 	int i, res = 0;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i])
+		if (bond->params.arp_targets[i].target_ip)
 			res += sysfs_emit_at(buf, res, "%pI4 ",
-					     &bond->params.arp_targets[i]);
+					     &bond->params.arp_targets[i].target_ip);
 	}
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index e6eedf23aea1..dea58a07e4cc 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -121,6 +121,26 @@ struct bond_option {
 	int (*set)(struct bonding *bond, const struct bond_opt_value *val);
 };
 
+struct bond_vlan_tag {
+	__be16		vlan_proto;
+	unsigned short	vlan_id;
+};
+
+/* Value type flags:
+ *  BOND_TARGET_DONTFREE - never free the tags
+ *  BOND_TARGET_USERTAGS - tags have been supplied by the user
+ */
+enum {
+	BOND_TARGET_DONTFREE = BIT(0),
+	BOND_TARGET_USERTAGS = BIT(1),
+};
+
+struct bond_arp_target {
+	__be32			target_ip;
+	u32                     flags;
+	struct bond_vlan_tag	*tags;
+};
+
 int __bond_opt_set(struct bonding *bond, unsigned int option,
 		   struct bond_opt_value *val,
 		   struct nlattr *bad_attr, struct netlink_ext_ack *extack);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 49edc7da0586..3497e5061f90 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -136,7 +136,7 @@ struct bond_params {
 	int ad_select;
 	char primary[IFNAMSIZ];
 	int primary_reselect;
-	__be32 arp_targets[BOND_MAX_ARP_TARGETS];
+	struct bond_arp_target arp_targets[BOND_MAX_ARP_TARGETS];
 	int tx_queues;
 	int all_slaves_active;
 	int resend_igmp;
@@ -276,11 +276,6 @@ struct bonding {
 void bond_queue_slave_event(struct slave *slave);
 void bond_lower_state_changed(struct slave *slave);
 
-struct bond_vlan_tag {
-	__be16		vlan_proto;
-	unsigned short	vlan_id;
-};
-
 /*
  * Returns NULL if the net_device does not belong to any of the bond's slaves
  *
@@ -524,7 +519,7 @@ static inline unsigned long slave_oldest_target_arp_rx(struct bonding *bond,
 	int i = 1;
 	unsigned long ret = slave->target_last_arp_rx[0];
 
-	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++)
+	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i].target_ip; i++)
 		if (time_before(slave->target_last_arp_rx[i], ret))
 			ret = slave->target_last_arp_rx[i];
 
@@ -763,14 +758,14 @@ static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 /* Check if the ip is present in arp ip list, or first free slot if ip == 0
  * Returns -1 if not found, index if found
  */
-static inline int bond_get_targets_ip(__be32 *targets, __be32 ip)
+static inline int bond_get_targets_ip(struct bond_arp_target *targets, __be32 ip)
 {
 	int i;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
-		if (targets[i] == ip)
+		if (targets[i].target_ip == ip)
 			return i;
-		else if (targets[i] == 0)
+		else if (targets[i].target_ip == 0)
 			break;
 
 	return -1;
-- 
2.50.1


