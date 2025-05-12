Return-Path: <linux-kselftest+bounces-32850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A145AB3562
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6128C171411
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1226A1CC;
	Mon, 12 May 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eFZHO4MD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023112.outbound.protection.outlook.com [40.93.201.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFE269D0B;
	Mon, 12 May 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047208; cv=fail; b=ACOBYTCN/2jIg7MI2lNSouK0Zq3H8ssk8RNCRiHfYyI8oDkxdT7pj2TOl0PAaVygW3+7pk76Kh1GqouWhzYt026Dj+nnRWP8ny9scjLGqL5QZejYcNwT2paY36zRzd8UrpXUFSzYRqoE8NsJGnPulkXzdL1TjA0xtTVVZd+F8Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047208; c=relaxed/simple;
	bh=usMn2HF2AeGmf3NBW+E8qwHqQhdNWMk+JQMAFdmqO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oOp9IDQlXb8kjwj5jcnFcyt7f8u/dZhHVL6kH7vqs/vstrB2CIQD64lO1JYMLwkql11zPuaCf4kzUR80ej78/qcjHzpTciZnHGTy/WCV2Ph3rD6DMgleTVwptwWzvwk4thB+1C9DgFNxyGxfQP1JT1ahGY4uQI1UIIWU8MzDzQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eFZHO4MD; arc=fail smtp.client-ip=40.93.201.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTGGBqTKh5rM9lVjl+udQ/dBkFm/3yxFciI1v/BabAY2YT/eqtWsfhVSnu9DrV2GeADHzmsNz2tiV/YhpDX1IoQS9kkgML3+RrgL9+M0OYNzL+ct00LdulBprOrc6qSWjo/bWMvfQX7IfO5ITFRZcHGJKkK0y0WGVhrnkM072KvEdWBLlHM2ux+C021uwZRCg4brIHbKRBmdbj3wABUu3RR12tV+/52n8NHYDXsW+2VOK0/EI4kksm3GeL6SvQtx6cszgs3TTyIZewNLikyO6YndBhMyspOE1klwCvu2S/OOYIDKFGgQU/CqWLhQWNQRD0+4b6+j+GSdrutSheNQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEJxGtc3ivgqZDYaVz69qZ4p8YBGRxcKWxGlHVI1ElM=;
 b=dxkc7zozFiDKCjdrSEGKTXw1xjdhmbl/W2ymK8f2ZIPQzPJn+2Ye8mfZgNvfXCJv/x3y0J1MvQwvh6EzjdWwBZKzwDXKAK8iZFffu8snMVIqdkOkPLo2s4OnM36UNKP+Ms7n1ReaS89wYUW/LQ6EPyULOx9YMZqNNuLhpYZ6Tnqv5GFaVclN/ANNXrAcsJ/Qc4JmwPH/zjtsS6BEHXs627XJrxB1v3QapIIOFf/Pn/1TrAXugijnHjHATBmsAoZ76qjz9XR6SqIfbEcclweHNop7W3Z8YF6NDgxNF3IZOLhG+jGG3Ec2UsxvquDn+guq1NBZBoCarr3flFXupUM61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEJxGtc3ivgqZDYaVz69qZ4p8YBGRxcKWxGlHVI1ElM=;
 b=eFZHO4MDHE+KPrE7sgpMmAlZKhmiBfOeSgcqwuyAvBs7eAwot7dyI9lBCpr117Jk5TCMZrd8gBS3sf6z6YgM8ZzCqZI5UsCCOGJ4IadLh3WtViGxr/VhYeGJEFrx3YKOK4JeXp/KrpLhcEi4DqW3PDWf4xwdTIHnG5V1CEH69p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:19 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:19 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	seanjc@google.com,
	darren@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [RFC PATCH v2 6/9] KVM: arm64: nv: selftests: Enable set_id_regs test to run in vEL2
Date: Mon, 12 May 2025 03:52:48 -0700
Message-ID: <20250512105251.577874-7-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:930:6::14) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b54b829-3abb-49c5-d71e-08dd914334ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YIoyC6m81f4N8vwa8g+zsqNpDb0Sl9xeWWJuv+dF0cCOknjeP3FII13sPltn?=
 =?us-ascii?Q?J+HM34MWr89BICbw1sh1+KymmXYgxw4UyIUXpz5NKJnKy2YJAdNtT2RH64Pv?=
 =?us-ascii?Q?k2TzWpeeU/q89yjDPzjuSDhuEjUJcbIqW/DUOstgdT/kjThHtRP/HmtTRqO9?=
 =?us-ascii?Q?TT4mqDr5Z+p2a15+Lx33EYbGVYLAqnq9fcgKN/cHVKoJgQICH+A0Ma7yEZ8a?=
 =?us-ascii?Q?/hPSpXCBEB1HHPy/0OKRxFb1OO1XY5qWthNQvT26HmsIz+RrvZ1L4/YCSryq?=
 =?us-ascii?Q?wQHUrAUivYOE4X1ZmNmz1BQnqxDYSDL92UfZGw8kmJUTWqWhoADGOuRJ+c7i?=
 =?us-ascii?Q?1XKQj38Y6pK3s6VW34iUuzGd+pWsJ0UW7XzlA1q+meBe1d9I6wJmEmGq48HE?=
 =?us-ascii?Q?q11tyAmyrb6zywgCviqrvNX9WRCxQ986UU10bbG6ppdeEXO7ieI9iyg+svOx?=
 =?us-ascii?Q?BfQvkVd2rVaFSd0ThePGfaU1JE+7FgRUtyCo0gW/Ig9djngb/xGjMhyPamxl?=
 =?us-ascii?Q?aO7ZGwbNApNqaAKXgK+AIWQdGNq3A+JCrkycNuvUSmFs/l4Br757AFwrKf4l?=
 =?us-ascii?Q?nVtVl//0BGXg9yK+DJi73+3JU1/JmrD9GSejmST90uPieQplTxaERf+nnLq2?=
 =?us-ascii?Q?ePco7uJV/S9pipZTEGWiBdHo3C8lWl0rPUR7Gup5US0JMNwJlYXexvpwd1zs?=
 =?us-ascii?Q?iaYop+SAJXyYs6LJ7KlASkB+j4LFGuzEqYEcI797z98F2qtpLiDLnURAxgL4?=
 =?us-ascii?Q?V1qFESD90eCL2TV7mGSHkDM6Uu7VqSiZ3EHWi6Ympq8XzRp4tN6/V8NWC+l4?=
 =?us-ascii?Q?i4IYVOut5OIjZJrW2icYS0hfqq7N4qvBvS3Dz1LgLL3GLOA0jEAuCQNrFNtq?=
 =?us-ascii?Q?e4AT2CsBz7ziSgpt6tEplzQzS/QSsY5/OC6VeivaskIaSiAXZ7SJ1y+efWXe?=
 =?us-ascii?Q?SYtSjVD5qPiFFnSTAOOh+/81mb7o7Jjwv1R7FHl2IZL5ji0KX7xG6S5eWGbM?=
 =?us-ascii?Q?Z+Nu/JS1MfJkg+VfUPYxrqyRuOIByEElrJ4OAb829H8Xy8zk0OdMS7SqYkey?=
 =?us-ascii?Q?Q/dWcvt93cjXofEwUbg/XcW4RQmxr3MxNlBe3Vb/jSN1iPaJ04zgPfZ6Brci?=
 =?us-ascii?Q?X1KgMzJMKhjOyCKztRwwsANgLoEBdJflUnqUNcSR8gRbD/SUFJMT22iT7pQ8?=
 =?us-ascii?Q?+kvPPCRIOCkN2II+D3kIHo1J4gloOdYL4ScAQd1D9AFtWc5VnVA6dxRCMKwY?=
 =?us-ascii?Q?F0Y3p/pM3v14/6+UbuDcIW5+GzjPIQ1LZ3n2/Iftel+yFdSsiwUSIFFpTPCp?=
 =?us-ascii?Q?9pJIl91HMbPqLJ0+M/een4u3sQK2p40hJD/sbfyklt19adbdWLJHsUQneT03?=
 =?us-ascii?Q?m1BRNUxkc5vXSoBR/fKe3jnBNszK3KqG776c9NRkZPntAdTfq4b6k5GkWS4l?=
 =?us-ascii?Q?kdWuGBA/fBt5ftX4rlKo/JM+EodjSV9SWzXuMs0yrHH9zoRuExdLpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcIHaPYG5+1yYnvf8iWeMBVkkqtdZj6INBoNRUtmhSp2HtbH1HDmSJgeJ5Ym?=
 =?us-ascii?Q?a0c92fWpEfh0ZREynFnL8f62462TJlmAACMrbzO8GJMzxpng2VZYR17XvHO2?=
 =?us-ascii?Q?0Xnr20MS6vfY9SkKDmG3FrdDhV2V1amCt8zwmdXFJORT2gKbcCF8TX1O6Bwn?=
 =?us-ascii?Q?mhmZKd6FizHrRcXG910/UuUTWiNF0l5+bl87J6vnQlsglkA4jEnR+9oqd9Io?=
 =?us-ascii?Q?Kb7fk5YTLzdss3WR1dJoCGGOAHrRG9tiZvTxbdrqFingMWN8CSPPEgNyjsaK?=
 =?us-ascii?Q?nLUu4/hNYBdqmfSdwsRcXVBSXiHcc2P13RvzxHe3+4YRnGvopIHawXApPVFH?=
 =?us-ascii?Q?P3YBUO8jDfSitKnZGtr65gPIYa6EDnqe2X8akeHeFAPPypoO/0H+EYAP3yDm?=
 =?us-ascii?Q?fgJ2ylqNlYgEtOlbJA/+0YhAC2KVfg638gAnDMObmHO5Wbw2aCGY12tPMwEf?=
 =?us-ascii?Q?5V/0Zqg6QiDVHY9Q7MIQPhpFswvqvGks8U9IKm7kBAEF9FHXiDWY3zWw2LGB?=
 =?us-ascii?Q?r5rLe5ehuO9X+suYGldMnfj3rf/6cuvMNo3+XYfqR++bTAkaW8JIcnGWk0kl?=
 =?us-ascii?Q?cUQfpa5uI1ijBrNHLto2iaj6MhXiy+klocbB6FFQnkForIcws9df6EoL6x3s?=
 =?us-ascii?Q?DBeBlnR1aID/C9pLyV5CBqbVIjE/TAltWBysTS83XYN12N+sM4V1iXAqVjUj?=
 =?us-ascii?Q?sgGvSHO14xFKK7ULTbndfQM9nm/l9bz4kViZI5R1oXGlExdh7pvuxEjlCCNp?=
 =?us-ascii?Q?l1MvcavK8qq/zxTmEiPCgrKDnFE41qY3D+/Hg2mdHZwU79llZCDjIqiHN5PF?=
 =?us-ascii?Q?lewIoHw33fZXeyYyB+PVHhD+bHcpDF6JAVx0vEuWdplyaKCabM/nqRFzqws6?=
 =?us-ascii?Q?ENOkeh4MWonfAeSDpV4yAn5BJ3RRuHiJevn8ldlYXXSzCDZLGhvn8qAeG/g9?=
 =?us-ascii?Q?yZ9AGztEYHPSzbJui+BCHrogi9zyRdgxQuh6nSIZ8+LHy0fCKModCWuo86zf?=
 =?us-ascii?Q?zfPMc0OsDqK2il0Qdto59weLQhPq8w+mF3IYocFlHoO8WbP2l7nTO4WdGlGG?=
 =?us-ascii?Q?9ZCRi9fRwxaOpRVsMYT9gSk2HV/c2vDFURstNXG/SDmsmfetx4H9j1I8g5QD?=
 =?us-ascii?Q?V8fZepf7RYGwdQ8t/Q9UxI6aqhB9z49c4i5apj6B2uSOgak3KLj4indLkKSI?=
 =?us-ascii?Q?I/D+ijJdIPtYf5Mc3ijLn261bYV1JAzJLpzFJQ0jRtAwiGrNMED+CeEhP+/P?=
 =?us-ascii?Q?6Al7jnM05UUWOfNsBI/46cPSlTaM8SzvKmQ/mwhyqoPOC7sGY0HcB/7bg1OF?=
 =?us-ascii?Q?YskfRv2viWp7zA9QdPji+CbkQAae5dYK3r6lp6i6pmjagQvY13m9B46w1UX1?=
 =?us-ascii?Q?bynUbsL4UX1P/ThahpDYWGpZ/Rqal7AaMzcmLF3hqa2pusD4StBcF5e9YZe4?=
 =?us-ascii?Q?RGbE9nMPq43h3TntxAzWCzviaRhWoZ+H6ldZdS91pNts/30vzAlwZzbn0z4s?=
 =?us-ascii?Q?z4rcRKttJ0v2mIyXw+/zN6yrjudVLGCH7C1hTcyuaYDfJyZcvWrYeLTfxAYQ?=
 =?us-ascii?Q?uMUW2Pek1gi/ZgGkKOkK6KWoFA8h3usGanaEfuNi7mQpHquize439CQ2es3k?=
 =?us-ascii?Q?NfZ4BM+Nuip5CANAerxqTo2sKgplGNZiou6SiA90YfPy?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b54b829-3abb-49c5-d71e-08dd914334ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:19.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qafSoejMIhR0rqojpymIrCo7w4wUFrKIOuNLyoqv7UqKLYokxzazMUfwGHdoaBs766rNIg5vYRndeOBFYYA1yFsNQg3GzdWIHgY9vdQZnKABe0xbCM5GUXIRJiVjprLo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

Extend set_id_regs test to run guest code wth NV eanbled. Also added a
check to avoid the writes to TGRAN*_2 fields when NV is enabled.

NV is enabled using command line argument and it is disabled by default.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 .../testing/selftests/kvm/arm64/set_id_regs.c | 57 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 322b9d3b0125..86f69ec7ac0f 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -13,6 +13,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "test_util.h"
+#include "nv_util.h"
 #include <linux/bitfield.h>
 
 enum ftr_type {
@@ -67,6 +68,9 @@ struct test_feature_reg {
 		.type = FTR_END,			\
 	}
 
+static bool is_nested;
+struct kvm_vcpu_init init;
+
 static const struct reg_ftr_bits ftr_id_aa64dfr0_el1[] = {
 	S_REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64DFR0_EL1, DoubleLock, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64DFR0_EL1, WRPs, 0),
@@ -435,6 +439,24 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
 				continue;
 			}
 
+			if (is_nested) {
+				/* For NV, ID_AA64MMFR0_EL1.TGran4/16/64_2
+				 * are not allowed to write.
+				 */
+				if (reg_id == sys_reg(3, 0, 0, 7, 0)) {
+					switch (ftr_bits[j].shift) {
+					case 40:
+					case 36:
+					case 32:
+						ksft_test_result_skip("%s For NV guests\n",
+								ftr_bits[j].name);
+						continue;
+					default:
+						break;
+					}
+				}
+			}
+
 			/* Make sure the feature field is writable */
 			TEST_ASSERT_EQ(masks[idx] & ftr_bits[j].mask, ftr_bits[j].mask);
 
@@ -658,7 +680,7 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	 * Calls KVM_ARM_VCPU_INIT behind the scenes, which will do an
 	 * architectural reset of the vCPU.
 	 */
-	aarch64_vcpu_setup(vcpu, NULL);
+	aarch64_vcpu_setup(vcpu, &init);
 
 	for (int i = 0; i < ARRAY_SIZE(test_regs); i++)
 		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg);
@@ -673,20 +695,47 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
-int main(void)
+static void pr_usage(const char *name)
+{
+	pr_info("%s [-g nv] -h\n", name);
+	pr_info("  -g:\tEnable Nested Virtualization, run guest code as guest hypervisor (default: Disabled)\n");
+}
+
+int main(int argc, char **argv)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	bool aarch64_only;
 	uint64_t val, el0;
 	int test_cnt;
+	int opt, gic_fd;
+
+	while ((opt = getopt(argc, argv, "g:")) != -1) {
+		switch (opt) {
+		case 'g':
+			is_nested = atoi_non_negative("Is Nested", optarg);
+			break;
+		case 'h':
+		default:
+			pr_usage(argv[0]);
+			return 1;
+		}
+	}
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_WRITABLE_IMP_ID_REGS));
+	if (is_nested)
+		TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_EL2));
 
 	vm = vm_create(1);
+	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
 	vm_enable_cap(vm, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS, 0);
-	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	if (is_nested)
+		init_vcpu_nested(&init);
+
+	vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code);
+	gic_fd = vgic_v3_setup(vm, 1, 64);
 
 	/* Check for AARCH64 only system */
 	val = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR0_EL1));
@@ -714,6 +763,8 @@ int main(void)
 
 	test_reset_preserves_id_regs(vcpu);
 
+	if (is_nested)
+		close(gic_fd);
 	kvm_vm_free(vm);
 
 	ksft_finished();
-- 
2.48.1


