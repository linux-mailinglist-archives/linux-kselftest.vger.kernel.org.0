Return-Path: <linux-kselftest+bounces-32849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62EFAB3552
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C94F7AE7A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A1026A1B1;
	Mon, 12 May 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mbjZLemN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021077.outbound.protection.outlook.com [40.93.199.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91E269CE4;
	Mon, 12 May 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047207; cv=fail; b=NxGeMIRxgGH/JIm4sbgDesujriBlcba98tpOihkh6qdHTJDo/fZs4uPvoyqZ9sifWPO4t06tp0etsHCk76TSxTXC7bCM+ekkxJPHrS1LS3rLPYPhSYxC8HzHr7a+wAkR1orv+YYppaDXjy4qmEvuDuNgELuJH2+1u184uWUMo7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047207; c=relaxed/simple;
	bh=LA22jueyCOOUtnysIxG2Nx5UMfm2f5ICarzIidgAvz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bji/W5yETwf4bygFXsmaZwizpcTQM1TzZKrE0k2iJg6G6VKtAzpxXyoHVExFXSYuu+jyXN3U3mvjxrbbcIr1zlXxEXCs3hxDQIVFQ1LN7fAM1YQ6Ce90Uy+tlHvTt08s4wHmTYJUyY+fU01WUrPTp3qkoJwNkOd0NrnpOQQFOCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mbjZLemN; arc=fail smtp.client-ip=40.93.199.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+fOikKkZpWqPkAgCeMFNg71gXqsJIUoPwgLMaP0x5lXHB5tbrhvbZgYA2qTKbu3SD1MKN3tVOl4tEGSQCfV7cpVq7wT5HlmQbzmy04tbLFXwyrIh6RpzLkw5G7Ym/Hi//uoRoRat1044lqfH37k/hNIUJXbEAucqsnRFLMV9HqKHCegs8Ccp5xzT0pP9rwc+rJqMatWf3cngfC8Gq3RcIJ0OQdoS9cai2ZF9++Rla3WSaT5y7aT/uvITINmvxEP7Ppb8jPRnYLE6N9IxKWOfvHm31D98v6msJCv+L1VNcaGxLmeRZOKjk+bGf+9X3s5JR+VyuNyokRTukt3vCSLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U53OQ2ViFDKLIeFGVQDN/pm8Ynh2gt8FPvIs9yGts1I=;
 b=H6hGUm+27lDubj/r/l41XSk+JTwoSH36RbWXFjPOJKHw7ZbsQJnqAdQtDnPHM8+w9poDoTlmMW/UR9AhaiIK2B/F5KoL8yjyXXO0yW2B/R++3L4/HHF3gsEBAXcNO7RxTL/ToMPqRyU/SRKPORXw5gmw84l+QSmyH/bRLCQxZnvGhoI5maQu4E8owdbq80tM5X1iu4rOmrp4RbAvpRgzyMQWpydhC9w9uinUYrY5fxH3r220MZc0lEG0UwoneF7KzY1UWMrwy5qEUKgUKwuYCYnmkmh+qviBJY9bP8mTbWbcM8LcG0+7DdMpmbRkigypfnvjypXbbPnV0uIWz3RNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U53OQ2ViFDKLIeFGVQDN/pm8Ynh2gt8FPvIs9yGts1I=;
 b=mbjZLemN+cYziMtuIZm4Nj7Oi4rLOLeFaVRlQNouiva1tWvLgVVk0bz3lzV3zQKA24iA1ivWe2EayNF49JaHjz6jw6OfTVgwc6BkapgKkQRxvQgv66lL0yw0J4DIAnLT36O4LWuUsTjk6Q6C6h4WTFSCPDyaNJ33Jdea8JvPDxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:18 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:18 +0000
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
Subject: [RFC PATCH v2 5/9] KVM: arm64: nv: selftests: Enable vgic tests to run in vEL2
Date: Mon, 12 May 2025 03:52:47 -0700
Message-ID: <20250512105251.577874-6-gankulkarni@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45640861-d418-4efc-cbb7-08dd91433418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vonA/bDIVxYialnSuopx+hlQKfacsxseyWvbwZD0y9h+qWOe3mZI0VpwZlg?=
 =?us-ascii?Q?W37dP/F7k5L9O+fe86f5eQCI+NQr+hd6pvSehtNGUkaDG682qxHhB4UU/0CN?=
 =?us-ascii?Q?/yatMkdG3rPamkIoB//VshEj+wvdf00CKYqHbbIbQ3AQ4zfNE4FO0kEhTNtn?=
 =?us-ascii?Q?l5Vaz4xZBzUHMKWoPwlRllau1qUg1FQP9m2XqM0hZChmJC+2iii0pt1s01xe?=
 =?us-ascii?Q?GhXKA8cQ9CbR+Q60ubiFZ6vqqgpO6FgLkLmFy1X+7ZOd269ud02yc18KMwGn?=
 =?us-ascii?Q?sK/BlJPRsx+68Q8eejaczJepI2b5CpbY8tw4S/7yUouvt9K6UAL8/oLUDl2S?=
 =?us-ascii?Q?jWEyS3VSWttMw7IBMIiKY+cKj9jQUDrcyF1JFfItx5dO00YUBC5s1IH8d1JH?=
 =?us-ascii?Q?3JUR5lhkTEYyctwBhJXwezxgtHrnFt6F3IVpNfTaV0nijGyiPNWwg32Lns17?=
 =?us-ascii?Q?9l53RO1Wp9Is86aUE8VpDkrkoglZsPafkHywub5NnJLLoibrhtnfUJcEABYe?=
 =?us-ascii?Q?wrVUwy34JEz6G13rPG3Nr1b2nIlJ3XflEx2dXznbvNOXAD0v1BJTs2MIhIjN?=
 =?us-ascii?Q?aQ1D+sXA/y7ejI4HkRtkeO9FS3wYjN58PZ/KmW2M6r7dfs/jmsQvtujzHNxB?=
 =?us-ascii?Q?dRN9M74RTgTgD/oP+4TL9pMC2ioh0Xq07mP5snhjrLXAnj+ZBrCjYm0bBJDs?=
 =?us-ascii?Q?zYcJeZKbpej8kFm8eH+7T/cIDqfRXNBQmImphUO8biTk7kTkdLrSKkCQgzBA?=
 =?us-ascii?Q?daepWsXN1WdvdLSNnqYVjp8TXuBlbj8WhCOWEE2R/oBUdA7PyUj5dMttBCRo?=
 =?us-ascii?Q?CAAp2oE2MY2b6zicr7gXsFVyEp+tjOnKlmTfROWgeS0hlPMkle3vXXWH52w0?=
 =?us-ascii?Q?z4fSjWCg+i7+f7h3u83SD9Gu7zPQERyRPxK7SCvAmeBucpTNTLqbshfVxLZ1?=
 =?us-ascii?Q?R33bbbMX4eoZEW+VbPBNH3E+u6I6QCDkUmjZh0tKdUwe+GII6y3fiAEQTu8H?=
 =?us-ascii?Q?0HvLMuqazt9zORO9sg9jJrk8lNVSiJcKwWYM/7r+Z6qYrbLakyh7rESfMXVd?=
 =?us-ascii?Q?ZkHrE3zYs8lYo89fOXbknAUQrMIlEx0vZYv6x9W6QV2tqOw1QPtOm8c5XvKr?=
 =?us-ascii?Q?RMS8PxZ3+vFecKwbRsUw1/q+HCPzDqMa1zgLNk1ncwAMyv3f05BN3Q0Q6DQW?=
 =?us-ascii?Q?25d7j55W+lJVcfWcyCTb7phGyTeJ1+X+/mQLU2ywoEJJckAnAu1Y+PeWYJfz?=
 =?us-ascii?Q?82JmlgR9npY5F8+9EqIRy2iCUH9mGBWLr1wzFAAaMURR0XWad6XUCGQjkFTF?=
 =?us-ascii?Q?JgoCwGNHyEKSbBt402XdiUykJ3NOkt9js0W8eUdKYgK/PljlEx7UwqXRiEwV?=
 =?us-ascii?Q?o/Zvc/c21J8//uuNCalmmshICBsOZ3go4F9fxyA8w2J+llDtc295NzReDzvY?=
 =?us-ascii?Q?g3mkUslSc1WGS6/dhglegldmZiT/YJnZc656KMLgbJ9g7es2GNgAGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPm12ROWuNfKTeLRlbdi/HDXXglY41L0L5VyJYSUbbqJfIb2zyL5Sy+kHzLh?=
 =?us-ascii?Q?WVtRLGhyivM2VcAZ9cL3+UETdO/PwFrMYLNsnRWbU0Roe2mVryAjtOcZEMEZ?=
 =?us-ascii?Q?pt4JvHNjY+bOPOxhyPcWughxZ1YXBDEqvLFk4mYOnWBx50za0RxAOxT2dKl0?=
 =?us-ascii?Q?on+OlRHhaGfV9mgI3N4J+Bzc5tLmGnadR60ghuPdnCZu/MH5shg+FHWUh9qM?=
 =?us-ascii?Q?JXVJVG6c+NMpJoalE55YrDp6wUlxgtNcKzfWEUQ+KHFS2cqX7EiPXoS9fuqq?=
 =?us-ascii?Q?qjv90lyzEUb3ldlz84ltJjxYCd3fSKwoPBMgThMvn+36vQZPduOE9MuVBIFo?=
 =?us-ascii?Q?0kG0b3Gv46UmvnhzmTh9uiy3Kj5Lg3JXJf5XtRRpMBFobqBlZUeJCx9YkAI7?=
 =?us-ascii?Q?z4IiQvmHmBxEe/OOam9AcBE0qreuVs4rMyqVFEKMeVEvVWw6HPw9jrquQzf+?=
 =?us-ascii?Q?G7ngAkVERNT0LEcdttYNUORfAGZ9P8DNw4UkOlHKK6pdcOeSCfEAQfA8+yJo?=
 =?us-ascii?Q?kjIG4XNtvoNQkz3NQG1uD/bVNJV6ncq7kSy+2OD+vQ1pVkl0ysSxHmMHxLgN?=
 =?us-ascii?Q?jVuSrvoLV7MjQKXKMMeYt+OSrR9JCuPA1Ibwi+eciSkJ6+wD/pGKqvxWaJr3?=
 =?us-ascii?Q?v3kUw5IohSG4sIdb+Fx8CD1+63g85wXDH5EAUMpZHo0LH0c2g4JuYzbFx4OR?=
 =?us-ascii?Q?3xj+y3ZqLF+I77COkmj/tRlUh2HOx1lROHTL1C5Jxyj1iU8otvnbSNf1Llt0?=
 =?us-ascii?Q?EUU6g4/4lj3WoikddpWFBcuY6M3ApjkyaLBO5HzcaMt2evBACIT2xlVt9NL2?=
 =?us-ascii?Q?eA8anS4qJssIBAZFes5fjIVajNolQWnDWvFKDafPENJoQPmp1+SOAZEtygqm?=
 =?us-ascii?Q?LWIrjvEZysiWo1n4I7FRujJch5ymibC76TWLPBtVpRt27gxOQt2rS71yZupy?=
 =?us-ascii?Q?FuL261kHXiV11xixRUAA7gtd/z8tIat5aLimcWM3RpsXXQQF8vrQID6WXI2+?=
 =?us-ascii?Q?d000SWsgc3/QalRh6x4p3MO/VFieGCPPlpHwNH+w33B+oPNi72mlvuw7a6ut?=
 =?us-ascii?Q?lcpA2NkjjCaUSOsO8SpPlNbnF4IfiGpHIRVWoDYPJHYQliQUphsUoZCaEj9Y?=
 =?us-ascii?Q?B9li780II63XPeOc5HnqEnkT0hlQOESQkbJMDBpa0S3eUGHMJmkJSubB0gYM?=
 =?us-ascii?Q?zAEcUJBjIJQ/S2rGnGJYSEtVXYAeTwqetDDn2dmFHDEypVpX562b1f1pypqA?=
 =?us-ascii?Q?M8J63NI5yTttMcBrYqd0akSK3oCMtD4u4V0EbL+wY+GmUvDcXIDibWuzd7YR?=
 =?us-ascii?Q?7Y7IgQYOb7E7k2InbDsjR8j+i8PaQcT1oi9V9IQLsPLZ12ApN7feNmWsBZf9?=
 =?us-ascii?Q?iENGbddMwHvBGnopvqvqudmBGG1XqrI/KP0qYxGGcvzgzRwRNLSagfLsStYD?=
 =?us-ascii?Q?a7w5e7ALIcIoYhwLMRCYxX0GVJyFucAfzQ2JgiGDDZAXkgYG2N1xk+ezBTM4?=
 =?us-ascii?Q?V92WJIkohOnSHq0Wj9zO4QcYJFWiS/9B0MGk2flPyhwZZeI3tc8PR8m8zEge?=
 =?us-ascii?Q?JRGQeWUMWX6s0hRbtXdwP0kOHXU7sIGM5SgPNBw8FNKDMiMZsB+Szm97GljW?=
 =?us-ascii?Q?rAVN0eNETMML3/GJYvMx+tSSd9/LFBICBcZi/5zdDbLs?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45640861-d418-4efc-cbb7-08dd91433418
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:18.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZ8kZNNcSO9hubBX9LJFGhpdmpTAUuLHWarwLjw4OZYSHhBsotWla5iGFYHvZ3nuPFdQtP0n1vSmpYBKCGLUj02wQgILIn1Wz3OY+XAi1B708N7EbyX4I8WcXbbtmuhd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

Extend the vgic_init, vgic_irq and vgic_lpi_stress to run with NV
enabled(vEL2). NV enabled using command line argument and it is
disabled by default. The NV mode is applicable to GICv3 tests only.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 54 +++++++++++++++++--
 tools/testing/selftests/kvm/arm64/vgic_irq.c  | 27 ++++++----
 .../selftests/kvm/arm64/vgic_lpi_stress.c     | 19 +++++--
 3 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_init.c b/tools/testing/selftests/kvm/arm64/vgic_init.c
index b3b5fb0ff0a9..174350291c96 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_init.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_init.c
@@ -13,6 +13,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "vgic.h"
+#include "nv_util.h"
 
 #define NR_VCPUS		4
 
@@ -29,6 +30,7 @@ struct vm_gic {
 	uint32_t gic_dev_type;
 };
 
+static bool is_nested;
 static uint64_t max_phys_size;
 
 /*
@@ -75,9 +77,19 @@ static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type,
 					      struct kvm_vcpu *vcpus[])
 {
 	struct vm_gic v;
+	struct kvm_vcpu_init init;
+	int i;
 
 	v.gic_dev_type = gic_dev_type;
-	v.vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+
+	v.vm = vm_create(nr_vcpus);
+	vm_ioctl(v.vm, KVM_ARM_PREFERRED_TARGET, &init);
+	if (is_nested)
+		init_vcpu_nested(&init);
+
+	for (i = 0; i < nr_vcpus; i++)
+		vcpus[i] = aarch64_vcpu_add(v.vm, i, &init, guest_code);
+
 	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
 
 	return v;
@@ -336,14 +348,19 @@ static void test_vgic_then_vcpus(uint32_t gic_dev_type)
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct vm_gic v;
 	int ret, i;
+	struct kvm_vcpu_init init;
 
 	v = vm_gic_create_with_vcpus(gic_dev_type, 1, vcpus);
 
 	subtest_dist_rdist(&v);
 
 	/* Add the rest of the VCPUs */
+	vm_ioctl(v.vm, KVM_ARM_PREFERRED_TARGET, &init);
+	if (is_nested)
+		init_vcpu_nested(&init);
+
 	for (i = 1; i < NR_VCPUS; ++i)
-		vcpus[i] = vm_vcpu_add(v.vm, i, guest_code);
+		vcpus[i] = aarch64_vcpu_add(v.vm, i, &init, guest_code);
 
 	ret = run_vcpu(vcpus[3]);
 	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
@@ -606,6 +623,7 @@ static void test_v3_redist_ipa_range_check_at_vcpu_run(void)
 	struct vm_gic v;
 	int ret, i;
 	uint64_t addr;
+	struct kvm_vcpu_init init;
 
 	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, 1, vcpus);
 
@@ -619,8 +637,12 @@ static void test_v3_redist_ipa_range_check_at_vcpu_run(void)
 			    KVM_VGIC_V3_ADDR_TYPE_DIST, &addr);
 
 	/* Add the rest of the VCPUs */
-	for (i = 1; i < NR_VCPUS; ++i)
-		vcpus[i] = vm_vcpu_add(v.vm, i, guest_code);
+	vm_ioctl(v.vm, KVM_ARM_PREFERRED_TARGET, &init);
+	if (is_nested)
+		init_vcpu_nested(&init);
+
+	for (i = 1; i < NR_VCPUS; i++)
+		vcpus[i] = aarch64_vcpu_add(v.vm, i, &init, guest_code);
 
 	kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
@@ -733,11 +755,33 @@ void run_tests(uint32_t gic_dev_type)
 	}
 }
 
-int main(int ac, char **av)
+static void pr_usage(const char *name)
+{
+	pr_info("%s [-g nv] -h\n", name);
+	pr_info("  -g:\tEnable Nested Virtualization, run guest code as guest hypervisor (default: Disabled)\n");
+}
+
+int main(int argc, char **argv)
 {
 	int ret;
 	int pa_bits;
 	int cnt_impl = 0;
+	int opt;
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
+
+	if (is_nested)
+		TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_EL2));
 
 	pa_bits = vm_guest_mode_params[VM_MODE_DEFAULT].pa_bits;
 	max_phys_size = 1ULL << pa_bits;
diff --git a/tools/testing/selftests/kvm/arm64/vgic_irq.c b/tools/testing/selftests/kvm/arm64/vgic_irq.c
index f4ac28d53747..e4319f91f7cd 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_irq.c
@@ -15,6 +15,7 @@
 #include "processor.h"
 #include "test_util.h"
 #include "kvm_util.h"
+#include "nv_util.h"
 #include "gic.h"
 #include "gic_v3.h"
 #include "vgic.h"
@@ -728,7 +729,7 @@ static void print_args(struct test_args *args)
 			args->eoi_split);
 }
 
-static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
+static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split, bool is_nested)
 {
 	struct ucall uc;
 	int gic_fd;
@@ -747,7 +748,10 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 
 	print_args(&args);
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	if (is_nested)
+		vm = nv_vm_create_with_vcpus_gic(1, &vcpu, NULL, guest_code);
+	else
+		vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
@@ -795,7 +799,8 @@ static void help(const char *name)
 		"It has to be a multiple of 32 and between 64 and 1024.\n");
 	printf(" -e: if 1 then EOI is split into a write to DIR on top "
 		"of writing EOI.\n");
-	printf(" -l: specify whether the IRQs are level-sensitive (1) or not (0).");
+	printf(" -l: specify whether the IRQs are level-sensitive (1) or not (0).\n");
+	printf(" -g: Enable Nested Virtualization, run guest code as guest hypervisor (default: Disabled)\n");
 	puts("");
 	exit(1);
 }
@@ -807,8 +812,9 @@ int main(int argc, char **argv)
 	bool level_sensitive = false;
 	int opt;
 	bool eoi_split = false;
+	bool is_nested = false;
 
-	while ((opt = getopt(argc, argv, "hn:e:l:")) != -1) {
+	while ((opt = getopt(argc, argv, "hn:e:l:g:")) != -1) {
 		switch (opt) {
 		case 'n':
 			nr_irqs = atoi_non_negative("Number of IRQs", optarg);
@@ -823,6 +829,9 @@ int main(int argc, char **argv)
 			level_sensitive = (bool)atoi_paranoid(optarg);
 			default_args = false;
 			break;
+		case 'g':
+			is_nested = atoi_non_negative("Is Nested", optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -835,12 +844,12 @@ int main(int argc, char **argv)
 	 * combinations.
 	 */
 	if (default_args) {
-		test_vgic(nr_irqs, false /* level */, false /* eoi_split */);
-		test_vgic(nr_irqs, false /* level */, true /* eoi_split */);
-		test_vgic(nr_irqs, true /* level */, false /* eoi_split */);
-		test_vgic(nr_irqs, true /* level */, true /* eoi_split */);
+		test_vgic(nr_irqs, false /* level */, false /* eoi_split */, is_nested);
+		test_vgic(nr_irqs, false /* level */, true /* eoi_split */, is_nested);
+		test_vgic(nr_irqs, true /* level */, false /* eoi_split */, is_nested);
+		test_vgic(nr_irqs, true /* level */, true /* eoi_split */, is_nested);
 	} else {
-		test_vgic(nr_irqs, level_sensitive, eoi_split);
+		test_vgic(nr_irqs, level_sensitive, eoi_split, is_nested);
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
index fc4fe52fb6f8..63de3903b2c8 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
@@ -11,6 +11,7 @@
 #include <sys/sysinfo.h>
 
 #include "kvm_util.h"
+#include "nv_util.h"
 #include "gic.h"
 #include "gic_v3.h"
 #include "gic_v3_its.h"
@@ -43,10 +44,12 @@ static struct test_data {
 
 	vm_paddr_t	lpi_prop_table;
 	vm_paddr_t	lpi_pend_tables;
+	bool		is_nested;
 } test_data =  {
 	.nr_cpus	= 1,
 	.nr_devices	= 1,
 	.nr_event_ids	= 16,
+	.is_nested      = false,
 };
 
 static void guest_irq_handler(struct ex_regs *regs)
@@ -333,14 +336,20 @@ static void run_test(void)
 static void setup_vm(void)
 {
 	int i;
+	bool is_nested = test_data.is_nested;
+	u32 nr_cpus = test_data.nr_cpus;
 
 	vcpus = malloc(test_data.nr_cpus * sizeof(struct kvm_vcpu));
 	TEST_ASSERT(vcpus, "Failed to allocate vCPU array");
 
-	vm = vm_create_with_vcpus(test_data.nr_cpus, guest_code, vcpus);
+
+	if (is_nested)
+		vm = nv_vm_create_with_vcpus_gic(nr_cpus, vcpus, NULL, guest_code);
+	else
+		vm = vm_create_with_vcpus(nr_cpus, guest_code, vcpus);
 
 	vm_init_descriptor_tables(vm);
-	for (i = 0; i < test_data.nr_cpus; i++)
+	for (i = 0; i < nr_cpus; i++)
 		vcpu_init_descriptor_tables(vcpus[i]);
 
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
@@ -367,6 +376,7 @@ static void pr_usage(const char *name)
 	pr_info("  -d:\tnumber of devices (default: %u)\n", test_data.nr_devices);
 	pr_info("  -e:\tnumber of event IDs per device (default: %u)\n", test_data.nr_event_ids);
 	pr_info("  -i:\tnumber of iterations (default: %lu)\n", nr_iterations);
+	pr_info("  -g:\tEnable Nested Virtualization, run guest code as guest hypervisor (default: Disabled)\n");
 }
 
 int main(int argc, char **argv)
@@ -374,7 +384,7 @@ int main(int argc, char **argv)
 	u32 nr_threads;
 	int c;
 
-	while ((c = getopt(argc, argv, "hv:d:e:i:")) != -1) {
+	while ((c = getopt(argc, argv, "hv:d:e:i:g:")) != -1) {
 		switch (c) {
 		case 'v':
 			test_data.nr_cpus = atoi(optarg);
@@ -388,6 +398,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_iterations = strtoul(optarg, NULL, 0);
 			break;
+		case 'g':
+			test_data.is_nested = atoi_non_negative("Is Nested", optarg);
+			break;
 		case 'h':
 		default:
 			pr_usage(argv[0]);
-- 
2.48.1


