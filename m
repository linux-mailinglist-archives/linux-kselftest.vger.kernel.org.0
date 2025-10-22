Return-Path: <linux-kselftest+bounces-43789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337DBFDDA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82EC3A64EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06274351FB1;
	Wed, 22 Oct 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhRoR8h8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9D33FE22;
	Wed, 22 Oct 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157687; cv=none; b=OBuAwHn7GqwhuTvmnYvLebepqxiEFdY82JRjIa6a8LVlMJWWgDhAhElJGdnASpNLGERL2oEWJfapzptHgLY/WrVl+LkNrxlekmS8wuHpV9cKXTYdvk9Tu1T0icsGHD6PsRifCbUnGGO+tbImh9wtYyQx6/04skN4ttIpc/sKV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157687; c=relaxed/simple;
	bh=7MlFNzXs6F+KzCWeMz89aH26jQiyMZrmQsRXdSb3nEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSm3UQ2n2yrNcEVNlps3zLIvrtM+KeWvCAJChIdyKEeH60EApWlZxDJB8akXW+UI2qMCM+pgTplxADiHPPVKNrID5ZVzgToMLSTWw5c2dPVKCuUJzgS80Bobf50d72GuaGO49ZyS1z/1dYIgSbIhXKcZPM/ZQponL49bR0PhG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhRoR8h8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIJOgn022673;
	Wed, 22 Oct 2025 18:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1gcAKtu+RoO6R7Et0
	R7WNgRnWBuC+jWRdNLb38bY6E0=; b=bhRoR8h8fbD0IWtSF0jvdzKrAlqoyb9Xe
	e/OwmoH4SYeEaKIc06NCJ4OsznGoU00ovGiSrurU2X9zWfyZ++i3Styy7y+dRjYs
	BtoNNCPQJhFUbFTZqR5DviZh66ORJxo+cWBnOUXyVq+yd0B4P8tVUfQJAB+an8Ht
	V4Dv8smc5rPxIYUpBvy/ODpVclLIHeatChFTjQ7QiFQbo4NPOy+8JS69wH4hBu/Q
	8pVNv2DvRlOEaF3BioHDffZmE3sW1daHIxSRbRH716IfMgYhYVeBcIXLzP/SPeJs
	LrFyU3nhjNyQPfdkSYwSuf/Q2vTwDwMLeOFzhMjRyJepQFdcFP7BQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fee76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIRqQO010187;
	Wed, 22 Oct 2025 18:27:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fee72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIRDUW011030;
	Wed, 22 Oct 2025 18:27:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx19kw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MIRmSm13042330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:27:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D12758043;
	Wed, 22 Oct 2025 18:27:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7FC58053;
	Wed, 22 Oct 2025 18:27:48 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:27:48 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
        razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH net-next v14 3/7] bonding: arp_ip_target helpers.
Date: Wed, 22 Oct 2025 11:25:30 -0700
Message-ID: <20251022182721.2567561-4-wilder@us.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f92229 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=JHbxcnc1OzY8vxzM_6cA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 9Wk64ItDeMJUynonkOy6WknyU7LSpV1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+8BE2Z6a7+dy
 QVTcbL2vXaFG+jLYL7f0kL46WG18DVxWmaN1UO6wz06BAnMm7ifPtvYgNR7pPQBa89SXnNq5hdG
 e5mKAVxfBDvkJNA5DPPhmtU7r596EnQO0qT7IChzZEVZzohPLFpD6oSpMlLswgSh5Y1wjoeIU+A
 FaW191/inDfPLYZ2uM7dYVUl+za8ox/BEgYwNuNx/GKz4PvK3szU6zON11pdlrK8iLVo6t5ckGs
 08ktZUxq8Yf5TslNmnAhwY6zTlV5w9hC2xoYjh0YiJISo3bsa7FTtnKzZIKtqDJ6tt/XIqTSo74
 YI1anX8k0Z9LfPd6R36yWqCqbPje7ogJvQEMOi39BjReeUUn0SgmeK6rjAhiRedYBNXvxFHu5lf
 e9BczFjIKJfoosQ8WfrOA7H8BPKqUw==
X-Proofpoint-ORIG-GUID: H5sCNrCe0Hv1Uc7z1wH2kd781u-mxIlE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Adding helpers and defines needed for extending the
arp_ip_target parameters.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 include/net/bonding.h | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 3497e5061f90..0537b92c65eb 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -809,4 +809,56 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+/* Helpers for handling arp_ip_target */
+#define BOND_OPTION_STRING_MAX_SIZE 64
+#define BOND_MAX_VLAN_TAGS 5
+#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
+
+static inline char *bond_arp_target_to_string(const struct bond_arp_target *target,
+					      char *buf, int size)
+{
+	struct bond_vlan_tag *tags = target->tags;
+	int i, num = 0;
+
+	BUILD_BUG_ON(size != BOND_OPTION_STRING_MAX_SIZE);
+
+	if (!(target->flags & BOND_TARGET_USERTAGS)) {
+		num = snprintf(&buf[0], size, "%pI4", &target->target_ip);
+		return buf;
+	}
+
+	num = snprintf(&buf[0], size, "%pI4[", &target->target_ip);
+	if (tags) {
+		for (i = 0; (tags[i].vlan_proto != BOND_VLAN_PROTO_NONE); i++) {
+			if (!tags[i].vlan_id)
+				continue;
+			if (i != 0)
+				num = num + snprintf(&buf[num], size - num, "/");
+			num = num + snprintf(&buf[num], size - num, "%u",
+					     tags[i].vlan_id);
+		}
+	}
+	snprintf(&buf[num], size - num, "]");
+	return buf;
+}
+
+static inline void bond_free_vlan_tag(struct bond_arp_target *target)
+{
+	struct bond_vlan_tag *tags = target->tags;
+
+	target->tags = NULL;
+	target->flags = 0;
+	kfree(tags);
+}
+
+static inline void __bond_free_vlan_tags(struct bond_arp_target *targets)
+{
+	int i;
+
+	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].tags; i++)
+		bond_free_vlan_tag(&targets[i]);
+}
+
+#define bond_free_vlan_tags(targets)  __bond_free_vlan_tags(targets)
+
 #endif /* _NET_BONDING_H */
-- 
2.50.1


