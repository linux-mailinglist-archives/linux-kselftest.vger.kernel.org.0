Return-Path: <linux-kselftest+bounces-43788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E15BFDD94
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 666E34E9832
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0134CFD9;
	Wed, 22 Oct 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gov7fBET"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A92D77ED;
	Wed, 22 Oct 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157687; cv=none; b=USktjbrR7V7YV011ufaGCwadPEJ3+7hkriR6NPz2+dRQvt8RUq2X0HR97CZlEqJEpyGjxok0UrVreCvv42IAbDBWEwIwCmCgJ3u7m/HbesTOvv9VeyZvzG6SYagCYWCd+pYhCp3uv4TWBYYU7qr3VQCAJV4FyNihQSRHqu0+1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157687; c=relaxed/simple;
	bh=GAoJgJbC5Yfl6hiJfnX1dfjNTfluqggSvlTIB6nX09A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLhoVjUb886yDcltL0qIoM1AtN/9JDG7H1az5sQLpeiYt2cd0DU8bful4C9Llb+cZIHU6xKXbOxXOFJJ8p3LKpI1NCY0XM6gkCDPlpSASpSyebd3CZJ/LpDtad/+pLjPfjbuTjKrvh/gxG7m/HGsNU2iQJaojm/NfWpg77BwaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gov7fBET; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ME2VsZ024633;
	Wed, 22 Oct 2025 18:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L8BDLuET5McVwfWI7
	Ha5kXBaNdcc+kNzkxFrUByvUCY=; b=gov7fBETOjIm+00+CG6f5sIodOs+7oVvR
	slho9w2MiAeb/h0me0C617wI3AKJH02SLz4vs0s6sgkhGx3lM2UMrgMryRCtYUZD
	pVBITbu9pUVI1vQO3sCfseh5J4hPvv1AFMU1Oa2Iuy/2soK+zU1bMQDeWvV66Zo2
	ObgUbN5/gcQ+FTnPh14v3ZWbxShXuYSa1XWe6cy1mRqJ5raope/3FfVnPRh3VVij
	+0hyGjlU55YHJEl2mCsf0oO4bYlQ+RoM+lOV2572ijPTV4Vjwhs8dXsB49I4AIwg
	CfBr1MtXVGT3gj8QInEaunau53sXiNZ2Du2H7cEBZ0s96aZM/Pa3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIR41Z023687;
	Wed, 22 Oct 2025 18:27:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHCCMZ017058;
	Wed, 22 Oct 2025 18:27:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky20sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MIRnLs25756164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:27:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D7465805A;
	Wed, 22 Oct 2025 18:27:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1204C58052;
	Wed, 22 Oct 2025 18:27:49 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:27:48 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
        razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH net-next v14 4/7] bonding: Processing extended arp_ip_target from user space.
Date: Wed, 22 Oct 2025 11:25:31 -0700
Message-ID: <20251022182721.2567561-5-wilder@us.ibm.com>
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
X-Proofpoint-ORIG-GUID: bO0l5ynZrZpJY4bLW7mXWs_maUMaWA4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8AwTjZuHaFHa
 JCAtR3CuIh9z9UZomfC8WiuQ95LsLLUEIbutjNLADh74J4LO24vHWe5iPsIXetxuAZXSSDXrjuO
 6FtYAjXu4z7lVSiqc52s4toyqYjI3tVn8PFYw2uMawkVeAkw6WhjMUTgI7hwX4XX5WT89Bq32k1
 VuYmIsl2VxDgZzxz/rASD+5ouMDDX+CYNIWCGwqmDWFs4PTTpIWbhWqbNudMiPOhsUcUrUG+egw
 fxB8f72YOQp7t6BCYHBofvXNpwGMIQ0iYPc05SPsZBjCuxmA8NqYGUftnKNhyDe/EmWEImYrbyJ
 VYVFnVIvSh/EEWsaWQPLi17x8PMzw+E2Sr+W+cssOzKad2miRINJBZ/Pkr4rGwPqltdlA0ElEks
 1UqY0OZr3rQ5b2z6VmhiS+NnCMHZmA==
X-Proofpoint-GUID: zvLEatin8a3jNmYs59fzaX5OsK_BMttm
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f92228 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Yn90BycCmSjmNZNuBK8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Changes to bond_netlink and bond_options to process extended
format arp_ip_target option sent from user space via the ip
command.

The extended format adds a list of vlan tags to the ip target address.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 drivers/net/bonding/bond_netlink.c |   5 +-
 drivers/net/bonding/bond_options.c | 132 +++++++++++++++++++++++------
 2 files changed, 107 insertions(+), 30 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 566a11bb7f1e..15782745fa4d 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -307,9 +307,10 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			if (nla_len(attr) < sizeof(target))
 				return -EINVAL;
 
-			target = nla_get_be32(attr);
+			bond_opt_initextra(&newval,
+					   (__force void *)nla_data(attr),
+					   nla_len(attr));
 
-			bond_opt_initval(&newval, (__force u64)target);
 			err = __bond_opt_set(bond, BOND_OPT_ARP_TARGETS,
 					     &newval,
 					     data[IFLA_BOND_ARP_IP_TARGET],
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 91d57ba968d6..9b930a6880b0 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -13,6 +13,7 @@
 #include <linux/ctype.h>
 #include <linux/inet.h>
 #include <linux/sched/signal.h>
+#include <linux/if_vlan.h>
 
 #include <net/bonding.h>
 #include <net/ndisc.h>
@@ -31,8 +32,10 @@ static int bond_option_use_carrier_set(struct bonding *bond,
 				       const struct bond_opt_value *newval);
 static int bond_option_arp_interval_set(struct bonding *bond,
 					const struct bond_opt_value *newval);
-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target);
-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target);
+static int bond_option_arp_ip_target_add(struct bonding *bond,
+					 const struct bond_arp_target *target);
+static int bond_option_arp_ip_target_rem(struct bonding *bond,
+					 const struct bond_arp_target *target);
 static int bond_option_arp_ip_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval);
 static int bond_option_ns_ip6_targets_set(struct bonding *bond,
@@ -1150,7 +1153,7 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 }
 
 static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
-					    __be32 target,
+					    const struct bond_arp_target *target,
 					    unsigned long last_rx)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
@@ -1160,24 +1163,26 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
 			slave->target_last_arp_rx[slot] = last_rx;
-		targets[slot].target_ip = target;
+		memcpy(&targets[slot], target, sizeof(struct bond_arp_target));
 	}
 }
 
-static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
+static int _bond_option_arp_ip_target_add(struct bonding *bond,
+					  const struct bond_arp_target *target)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
 	int ind;
 
-	if (!bond_is_ip_target_ok(target)) {
+	if (!bond_is_ip_target_ok(target->target_ip)) {
 		netdev_err(bond->dev, "invalid ARP target %pI4 specified for addition\n",
-			   &target);
+			   &target->target_ip);
 		return -EINVAL;
 	}
 
-	if (bond_get_targets_ip(targets, target) != -1) { /* dup */
+	if (bond_get_targets_ip(targets, target->target_ip) != -1) { /* dup */
 		netdev_err(bond->dev, "ARP target %pI4 is already present\n",
-			   &target);
+			   &target->target_ip);
 		return -EINVAL;
 	}
 
@@ -1187,43 +1192,46 @@ static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
 		return -EINVAL;
 	}
 
-	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target);
+	netdev_dbg(bond->dev, "Adding ARP target %s\n",
+		   bond_arp_target_to_string(target, pbuf, sizeof(pbuf)));
 
 	_bond_options_arp_ip_target_set(bond, ind, target, jiffies);
 
 	return 0;
 }
 
-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target)
+static int bond_option_arp_ip_target_add(struct bonding *bond,
+					 const struct bond_arp_target *target)
 {
 	return _bond_option_arp_ip_target_add(bond, target);
 }
 
-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
+static int bond_option_arp_ip_target_rem(struct bonding *bond,
+					 const struct bond_arp_target *target)
 {
 	struct bond_arp_target *targets = bond->params.arp_targets;
+	unsigned long *targets_rx;
 	struct list_head *iter;
 	struct slave *slave;
-	unsigned long *targets_rx;
 	int ind, i;
 
-	if (!bond_is_ip_target_ok(target)) {
+	if (!bond_is_ip_target_ok(target->target_ip)) {
 		netdev_err(bond->dev, "invalid ARP target %pI4 specified for removal\n",
-			   &target);
+			   &target->target_ip);
 		return -EINVAL;
 	}
 
-	ind = bond_get_targets_ip(targets, target);
+	ind = bond_get_targets_ip(targets, target->target_ip);
 	if (ind == -1) {
 		netdev_err(bond->dev, "unable to remove nonexistent ARP target %pI4\n",
-			   &target);
+			   &target->target_ip);
 		return -EINVAL;
 	}
 
 	if (ind == 0 && !targets[1].target_ip && bond->params.arp_interval)
 		netdev_warn(bond->dev, "Removing last arp target with arp_interval on\n");
 
-	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);
+	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target->target_ip);
 
 	bond_for_each_slave(bond, slave, iter) {
 		targets_rx = slave->target_last_arp_rx;
@@ -1231,42 +1239,110 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 			targets_rx[i] = targets_rx[i+1];
 		targets_rx[i] = 0;
 	}
-	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
-		targets[i] = targets[i+1];
+
+	bond_free_vlan_tag(&targets[ind]);
+
+	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++) {
+		targets[i].target_ip = targets[i + 1].target_ip;
+		targets[i].tags = targets[i + 1].tags;
+		targets[i].flags = targets[i + 1].flags;
+	}
 	targets[i].target_ip = 0;
+	targets[i].flags = 0;
+	targets[i].tags = NULL;
 
 	return 0;
 }
 
 void bond_option_arp_ip_targets_clear(struct bonding *bond)
 {
+	struct bond_arp_target empty_target = {};
 	int i;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
-		_bond_options_arp_ip_target_set(bond, i, 0, 0);
+		_bond_options_arp_ip_target_set(bond, i, &empty_target, 0);
+}
+
+/**
+ * bond_validate_tags - validate an array of bond_vlan_tag.
+ * @tags: the array to validate
+ * @len: the length in bytes of @tags
+ *
+ * Validate that @tags points to a valid array of struct bond_vlan_tag.
+ * Returns: the length of the validated bytes in the array or -1 if no
+ * valid list is found.
+ */
+static int bond_validate_tags(struct bond_vlan_tag *tags, size_t len)
+{
+	size_t i, ntags = 0;
+
+	if (len == 0 || !tags)
+		return 0;
+
+	if (len % sizeof(struct bond_vlan_tag) != 0)
+		return -1;
+
+	for (i = 0; i <= len; i = i + sizeof(struct bond_vlan_tag)) {
+		if (ntags > BOND_MAX_VLAN_TAGS)
+			break;
+
+		if (tags->vlan_proto == BOND_VLAN_PROTO_NONE)
+			return i + sizeof(struct bond_vlan_tag);
+
+		if (!tags->vlan_id || tags->vlan_id >= VLAN_VID_MASK)
+			break;
+		tags++;
+		ntags++;
+	}
+	return -1;
 }
 
 static int bond_option_arp_ip_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval)
 {
-	int ret = -EPERM;
-	__be32 target;
+	size_t len = (size_t)newval->extra_len;
+	char *extra = (char *)newval->extra;
+	struct bond_arp_target target = {};
+	int size, ret = -EPERM;
 
 	if (newval->string) {
+		/* Adding or removing arp_ip_target from sysfs */
 		if (strlen(newval->string) < 1 ||
-		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+		    !in4_pton(newval->string + 1, -1, (u8 *)&target.target_ip,
+			      -1, NULL)) {
 			netdev_err(bond->dev, "invalid ARP target specified\n");
 			return ret;
 		}
 		if (newval->string[0] == '+')
-			ret = bond_option_arp_ip_target_add(bond, target);
+			ret = bond_option_arp_ip_target_add(bond, &target);
 		else if (newval->string[0] == '-')
-			ret = bond_option_arp_ip_target_rem(bond, target);
+			ret = bond_option_arp_ip_target_rem(bond, &target);
 		else
 			netdev_err(bond->dev, "no command found in arp_ip_targets file - use +<addr> or -<addr>\n");
 	} else {
-		target = newval->value;
-		ret = bond_option_arp_ip_target_add(bond, target);
+		/* Adding arp_ip_target from netlink. aka: ip command */
+		memcpy(&target.target_ip, newval->extra, sizeof(__be32));
+		len = len - sizeof(target.target_ip);
+		extra = extra + sizeof(target.target_ip);
+
+		size = bond_validate_tags((struct bond_vlan_tag *)extra, len);
+
+		if (size > 0) {
+			target.tags = kmalloc((size_t)size, GFP_ATOMIC);
+			if (!target.tags)
+				return -ENOMEM;
+			memcpy(target.tags, extra, size);
+			target.flags |= BOND_TARGET_USERTAGS;
+		} else if (size == -1) {
+			netdev_err(bond->dev, "Invalid list of vlans provided with %pI4\n",
+				   &target.target_ip);
+			return -EINVAL;
+		}
+
+		ret = bond_option_arp_ip_target_add(bond, &target);
+
+		if (ret)
+			kfree(target.tags);
 	}
 
 	return ret;
-- 
2.50.1


