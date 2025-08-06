Return-Path: <linux-kselftest+bounces-38347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26270B1BEAB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 04:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30F8622A6B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D901A0BFD;
	Wed,  6 Aug 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vl8NGN45"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5378F59;
	Wed,  6 Aug 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754446860; cv=fail; b=FCCqzbusQKhJxUA4Xx3KhYNANpmMPsBA3HnSLX36NiwIdwO2dxAyoRKBmzb6tNsLs8zPVMVjrhJCxVTQF9xHyUxILxinJfnc8jx4SfJXYwNqQsCj8pAdlguTnWRPI0DNEFlTShx9sM3RrFeDrguEn97gcfGMGNSAZRPo5WzxX0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754446860; c=relaxed/simple;
	bh=uMdUuIcW29npYEUz0o691QAg3H9QRlZC0OiCc1txvS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N13rFLO1aadg65rlMKxwKYYpoz5UPpX3S3ozyDZc4SX5EGKWN2z8qv5RCKlJcbM0ZYzMMY2+meljyszgoArfI6JBrZsu++Y1xg7EAlQiaFpCCVQeBNt3ryYS9ZiDV5CYpULzRQudkxXw1jBK+3yHaMj0omXl5c7sCvOLDYD97wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vl8NGN45; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtvWMlqkO3IcyUzNY5Dyzz3cbOOOKQlGp5LQUw7VBz1xlHMg+Z1J7dOSeB1UX5DXCHW9x2FG804fI+LmTA13yfbY1QY62fsnvpu3y+w4mSHVrNoXXlf7xU19QFg77BkjLWBj5ouJ11L/jpRvB4kei1cqvQW3yqSV4LetL6ZY48AhtO+QV7XbhqiHDGtcHc2omxbDtaOM1SSVk0OYw8B4lAb6fkjPHtngl2KE/JgOD+AXujbrUQf73qVPJrCCtHbXI0vPLf8wtIDNPg1nrMILbPPmQ+7EvvQe+4jlsGqCpHRqdxD7okp2tFRSAamnColvakiJNZQwYshi5SgZPSkcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwxGKTJlw93Fk+fMk4JcYsQHDckAlvBx2OE6ha8dvPg=;
 b=ruAKQeHDZ9uc2PmdMQlLU6gAz3L2XpaWPsCVb8J3HdRAAN2YRmR4lVEJ3kYlDRCyPwJhCyvkwSwiqB54HAPh+B+3/WmL/pEAu+CyFWmKGq31govMoE7ofYiTrPuOJlVXcWd4iVYxdv1n/Rr7m97/Pcv8u54cXxfhzpYAcHXq/DzLUGdUdaFRLwMZTFkVTXkrsvM7YJHIxf/2qE0dIAKSjNuZELO2TmPngdDgry1gt4LeuxCI4QC/u2OiScKyv+ULgX/yEvLbq6odkyVULsHRkIHNxE4vWkb2Bha2Xm4a7693apm8dTcQ90tO4Il6yncMbqBybijWBupDeNnW+Ecrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwxGKTJlw93Fk+fMk4JcYsQHDckAlvBx2OE6ha8dvPg=;
 b=Vl8NGN45B+178bWRK/ttRTS1TV2eeNYciiTjUpccgioY0IaHby47iGjgBZivrGGpnBa9Vy3Ui9TG5W9TTmm5sdRaIp2ljo8jbvvlcjweMc/BRdOda2eLAFyeO10Z/HE1KquPs1+346GtjsiKek46Ak6rzKdeH8lGDzS+2+G1Kqx/oeWE/BbuGA3FauYXaZh2UI/QBUOuYSlOpUNewO+EmcCLekmgvjPO/6/7H6Y3ev81Et2EWPs1D0aoJLv44G+z7GC0aPOKG43RgqVeXbT4NPrqfRAdeBKSFFTfw5zoZj77jnF8sbBzp7MK8AlkpPSacdFN/D9bLJJwXDB5fWdecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:20:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 02:20:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/4] mm/huge_memory: add new_order and offset to split_huge_pages*() pr_debug.
Date: Tue,  5 Aug 2025 22:20:42 -0400
Message-ID: <20250806022045.342824-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806022045.342824-1-ziy@nvidia.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:91::36) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f0f364-0269-49a1-c914-08ddd48fdfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2iCOIxamJ73ogeTTj5+Wib+iSch35YQOEuG0/vgldzVOiaO53MaHCZqBBHs6?=
 =?us-ascii?Q?V9vGbrliFAD7cZOcRkA6Lk2mccB3w+1F4iWWVKzxdSxbne5dlj3DVtj97sqV?=
 =?us-ascii?Q?9K6VuyRvu+SB1/kF0wETBzhXC90dmQ+OB6nB3F05VQpOF9nKZlwLEp7b9kgV?=
 =?us-ascii?Q?eAuTO8srKt986ma4ALKZtn0eF6etLcC7P5IEyNx0TEzpbyP0MAuHFvernK0T?=
 =?us-ascii?Q?BIwXrHNmuUt35rZkkMN7XgvAAFDLU7RocSAbJPI/v2ErclArtnSGp8hKFvCh?=
 =?us-ascii?Q?Lirpb0AK0yU8LZkUnojbvUmEb25g5MD7Dxd95WKmH5egRtW+0IXQ9ufCx1Wk?=
 =?us-ascii?Q?0rP+Jjr32lfDVgtOyEfKmv/VtmVwLm1a2mohJf0hNrbjMliWEb+t39e9mtA4?=
 =?us-ascii?Q?lU/ZKHbqFYtmS1bx12F0IcQfF35bI+RvhyZ60zOuIyj8WezXNruDV6Iliitl?=
 =?us-ascii?Q?+8OJPhZEUxpnZDOEICQW0JeMh4TMordw/s8OzB4eOs/b9QQsJlHhASk5OMa4?=
 =?us-ascii?Q?a74ts+MTMrzdv10WIyaPpX0TsOu1+I8lBvYRp6mroidoNdoUxibzHourrbWo?=
 =?us-ascii?Q?mIz7pmBSNZaZyRRsCUHZXUQhp8Juwk51dsLKpbfhTaZpvjoEVs0yp6g7MQYC?=
 =?us-ascii?Q?I9n3MYd6ocODGBvs4fIqng1cWxhnoH49lTGnP6w4ZBQLTKdTzwLveMuxvfsE?=
 =?us-ascii?Q?2ax3mn7z+AHdhOvWv4UNJGLl5kMEFvCWbXBzlLCh81hkozjvexzet7wvbxVC?=
 =?us-ascii?Q?1AjgWqisTKAeP5QBUny5h5wa47Gz/nWcedbZ7ac9ISHShXyqnpp99Om4c4/t?=
 =?us-ascii?Q?/tSYeDQF74i70/in63aRdi5IudM1NsUWCk05ufYRDREhevEVEmAFKZGH3KBm?=
 =?us-ascii?Q?H5pT0cDOoCPej7uZHjjLOtrDncVDPkxSJVzk8mEiO+7tC70qKv+dVNklZQa6?=
 =?us-ascii?Q?rjiJURXzxS4E8Fo4c/kp0JZ+jOq3YIY/rGlfDSaim/SV6nnBm218Mze+Sn4l?=
 =?us-ascii?Q?Z4EFpjXVxxzeEUjQdAD4JsDAGlZ7Mdi2BeyDlXTc7Kmnho0CIyXXE+60C3Nf?=
 =?us-ascii?Q?oJuXVyTi0NZNc//cXp352Xkt0o7chvfqjR0OTt3KN5TjiWl9YNWtzhPHEmp0?=
 =?us-ascii?Q?4MedXfmLTCVZhYj6QXIpx1f2smPDidb+GH8AgXGqTf8piKw5uEZ4V77/HUiq?=
 =?us-ascii?Q?Q1nLmEydZ27AQkN06PJNfGM7gXAgXmc1E84PKSUAa3cx1/XFD5w715V1+ToO?=
 =?us-ascii?Q?CkQ1wzjHy5P6g7RXj+Um0b0fmkiwL2eUoMOmiaUVKv1ycJ/oixThmxkVBf2P?=
 =?us-ascii?Q?a92F3cJckoqCfvUqodXNBgmsLrRablkYcXS54SvThMnR8aNNclrbsCD1j163?=
 =?us-ascii?Q?Ly1uxcfscRXLVb0YqBdGjNdzUy7AV7xkK+aFYpOyqh1o8IKp8vcBgeb8pHAD?=
 =?us-ascii?Q?09/i+UDrsuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/xeH7Ouhf44ynruFJf6aqykOoHyAXvlkms76AvvLVyA1TsyVIbEH2vHzTpf?=
 =?us-ascii?Q?7n/b/oHb5BJ85fNsualQEHZdcYfYMKv5J2ZxOs1fgOehuNWwomqvs0LiQpgk?=
 =?us-ascii?Q?Pqbmzzx7IOdUsL/sUWatwzvi2pIx6AFg13i3t+0J+UYZqbW2k3ulKjCwCNgM?=
 =?us-ascii?Q?6wytmC08NRmwYO60GweSQ0Ahhrhw+yTG3AeqG8Y4un1DnFHm6XglCrQKt4h3?=
 =?us-ascii?Q?MI4q3b8EDNqMY0OUcD18QoweB6U2Sev43y3eKuscsITDCr5xvIoxq6TcTI5f?=
 =?us-ascii?Q?DjxUAYOWsedbhhIVlva3/Zj5t8ctziK1Z8V/21a17EdaL1WgNQd3xBFlB5z/?=
 =?us-ascii?Q?N4hewIadsAu/QxMIZ9/d5JPWon1rj5o4mbWlfiXfV07mcVqTOXflytvhCsAw?=
 =?us-ascii?Q?310YtcnDwK1oPV6mHT5cIIsWr56X9Za9gJWCU0+6YsFW1fMw+uiICKuzQtrs?=
 =?us-ascii?Q?B+8rwgQXf6ct8vGJKvIfhsxYRtlk3RNAO9liCj3hEU4cLjyFDaOC0Bp19rkZ?=
 =?us-ascii?Q?W1hsNk3BQMmljzUdGIg2IJ0U/zFw8zEcooiut4P35tstVyvqlbSJDz9Q45Ch?=
 =?us-ascii?Q?x8Y7GSUl0TJBKXPfUVNSfvRTuq4rrPwKXTy4ZygkT6m1ZcNmPKTLtlsUcQOo?=
 =?us-ascii?Q?CpD/YbjvMbZ1q96Noa4XRXRjKFFkgvG7NGHBMVFZ5K1mkUPlNShbSBzCO/41?=
 =?us-ascii?Q?AN2MGcKlJpATZ6guMsGEV/rfclx7A8qHsbw+9jFWFO4nNnhFzI9jWDfYPD7i?=
 =?us-ascii?Q?6MRTXdGbb5jAe1qpDYjFaGHF6fLGSt2YxbRgqvStOpUC4OUX2Uc9zg/0RC+d?=
 =?us-ascii?Q?PNw7Zf5PlEIQ+57JFjvG/MQgUz/7AZhbJmYZZcE8T+OZ/HDMZH+XT4y2nYEn?=
 =?us-ascii?Q?/G53d8sMWcS3oYseBFRfv6oFa3bMceXE4cg/KNnhRE45Mb/SXEOyRiE1n5Oa?=
 =?us-ascii?Q?O3/gNikmB/4ddu3a2pZocxQrbzqVtU3+RkxtMn0PLCDwHm1vgbW0mGcz0b0R?=
 =?us-ascii?Q?rHMhcotLpme7WTnnroTDAaT5EeMQCYqnQgcMvo+Vihf0qHPCxD1SsRH7m7XI?=
 =?us-ascii?Q?/uEY2YtL9G4Ptr5XFVBDNIbhu2UPy313hHfhYMltnS8/AXmfMXz8jBrnu/lC?=
 =?us-ascii?Q?vQJL2XoesYEewQbAjR3owAfRKrUZobjf9/PwzGhvyjM7C8L18xoC1/bhVBd5?=
 =?us-ascii?Q?6CklrPy+uJbB0hUVRnHPh9gf2duo2REeqhj7YcLMrCmNEyAwQIOKTV5+tXrI?=
 =?us-ascii?Q?B7OhgObrqPhbtDiWFjJ00+qLBGF+g8l21xn08YoKQM+MwUPhakeQ97C3Bz+G?=
 =?us-ascii?Q?hXxX0MjHlA2xkaG9tJuvZzaqEA3lIHTTqjG+pkFLDMjzHVaIyH4XKETJqcYv?=
 =?us-ascii?Q?fu2+ODTCVjyw7nVc5eVAEFoYc4r5UBSGKk31bO6NMJgNKNJTgvQMeBttz+Vk?=
 =?us-ascii?Q?SLEtApF8xNJ+4J4ftL/FC+SmpS+9LUP+AxJNrfI5TKAwbZyxkyVled4ozvtq?=
 =?us-ascii?Q?CsjzpoJtK4eWH8cXoMGi/NQHFmIxWHpCXf2yjEE1Ibg6CEHSbYdMxLCuA5De?=
 =?us-ascii?Q?2Q+C5/nvTgYEywEyVd6Xjb9yR0P9VOpqMGZExThN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f0f364-0269-49a1-c914-08ddd48fdfda
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:20:55.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmDZRLQDezS1VhlZhQYRzceTPrt0pElgcZQZzja8wxo+pfYKr8eH1SabjsM9SYSu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

They are useful information for debugging split huge page tests.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d..8a11c2d402d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4327,8 +4327,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		goto out;
 	}
 
-	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
-		 pid, vaddr_start, vaddr_end);
+	pr_debug("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx], new_order: %u, in_folio_offset %ld\n",
+		 pid, vaddr_start, vaddr_end, new_order, in_folio_offset);
 
 	mmap_read_lock(mm);
 	/*
-- 
2.47.2


