Return-Path: <linux-kselftest+bounces-47217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77740CA9CD0
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 02:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC0A315294B
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4491F30A9;
	Sat,  6 Dec 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOzlU7lZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FF1DF261
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764981608; cv=fail; b=hvp/nGXEd1tsO3FYkudSXXSIq0gfagA8J8Cj8jHChPtea6fSSozeJtzmnZYcIerE6Sw8Ep2kQRFJ2HnJcDYVRHbAvSUE+mXaqb1l6tgyOwf5lxVIH3wSqL/aQdF4L5V81kI10nxo2a4IKLKjo8+zr8XFAaSGO81dpMAfpwDI5pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764981608; c=relaxed/simple;
	bh=Edyq5LWD7+vCnItrHe4jRGgOwy/Jz+aHv9oI9KBZLNo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YVlLcF3XEFBntS8ZLOhfoqfvoiwWuAmzVbwI7cL7zALrgCN5fX+QgORRuVpuHQpmbHHv5pYwK4bWj7ERzDihATDPhGOunfIPwUpp0p3mfoXR1mwR/MeS+fUP3iJwENhZIzuNZQsXeXKgkPmV8pmIeIjhEeXm6b25lHTHk7ZmUNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOzlU7lZ; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mITi4aYRl9z3gJQAZmC61tUFj6tzzS2mB3DI14SKQUHKbrk7OGxbR/Q1/exAL8QBUcXz2TwrrhiJmdzmi6muxfnnTna7AB0F9PtPRG+AxWh7KgenWJ2yeDyJ1t/GUXMaNlNr06ROICSjZcXYwJadwffdqk1cVL0Okgp6xJ1Gjt/IHinNkKsGb/OGo4cQBs7rFO9nOeLAeb2d/tSh58QEF6aiiIYBQMqFADUNawYuXhPR1jRinXgA49L/6ERcpaghe9gi/qh+VOK+nbVex/KZNvkkphdZ3iMuDC/xkmn0KRcOXeaCYqS4dg0ptsf/riU7iTIzKqKgU8YJxyIGN7dmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjgq+6SeND5Cff/GVHAGZqJhwmTvCZggtt1YpjnfES0=;
 b=L/TWpLI3lP3h7DMfg2/60lLpQs41dZyYQ4NQXThXZIZ7TAZix+6GtmUIepRuN6JZIKc4EAGuJpy0Z1wEe92XB4FJ28pXh2V2mIcW9BOJhXogyDfrfA3fhQADYZB8qE7ufTsPVp2mAWMyPtKakWclOXXmRGipH4UP5DQEXCxrbPokyD5qOROpgvwqEfuHwV0D9Cbhv7HgevSG16bdVR0f4n/pzPBHQBsc1XTxPZXJ6slhiIYYqhzh0vcO6kHyc0zqOAOIVUmNmFHDw/PELoElijbYjBUmmtnL42wC1tGgYOoD/EFbfjK756oag7QPn0ilBnEUgrOgLR50e11wol2z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjgq+6SeND5Cff/GVHAGZqJhwmTvCZggtt1YpjnfES0=;
 b=bOzlU7lZwymOnKGRxJIr9rJe+gRaBbiHQaAG8Yp/mOn5KWslO27Z4SWNFlsUgIf18+rskIwLJwR6B5FR0kwY/h7FiI3C/f2OjAaR5eX+GwV7XPGDd7w3wogg+3vZ5NO160ufz8Z9wALu7xCaYo6h5N58yuB/619wZSoZNCdb12GkrBLu9RBFAPKlIctea/u7qKL0jPirsKl/JCPYhvu46SfS/3lliz6JXlAKoTB/fK2eU0G9a6POYAzbzFKhNIZp+VIBMsdDHvLNa92sa8Fbo4UYU0uiy9yR2QjCHY+f/Byfk5KmRfwjcLx3kRAGZlcjiw7h70IG/2HCMiFDyuPoeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 00:40:00 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.003; Sat, 6 Dec 2025
 00:40:00 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH] iommufd/selftest: Make it clearer to gcc that the access is not out of bounds
Date: Fri,  5 Dec 2025 20:39:59 -0400
Message-ID: <0-v1-63a2cffb09da+4486-iommufd_gcc_bounds_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f046de-ceb1-475f-76f6-08de345ffce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQU0+7VsZ+RtP88/F1Hkvn2xygQzk1VLDSB52H1st0gHEkILgyuqaULj839/?=
 =?us-ascii?Q?i+L6IE0vxXcVZPL/cJt3vmDQM1rgMJIBrUJDeG3bmWpkzdmu3kX7X/9np9jI?=
 =?us-ascii?Q?xKyJmx1+ayxZDKflSsn10CP1zbLCUB3gwyKHv7heHFHbwdt6KE4G/bgvPY04?=
 =?us-ascii?Q?Q+GaWb+e6oyfEudxgW4WkrttIPiVy8lc/QaB4lcPANY29mUL1Lml239nEiKR?=
 =?us-ascii?Q?9+5QlbzNthM5D5s1jBk10afgZC9kv3TUJZK/6TQVAO90ru/FOSm3dxXv8bYO?=
 =?us-ascii?Q?g+ypM9mFhgcY6lbdpSgP1Nn/i+KM4N8bh5klQB8jg63USinchz2QRho0DTFD?=
 =?us-ascii?Q?bZrsYuZ47mK7jPTUynqGzDftoUn2ckxVsFBvKbIB6khk6q5lbsTpXUYyXWi7?=
 =?us-ascii?Q?jvJhw2yrZODubBgJ33sEWnp8OhP391f8Np55dUH4S8fjylT6J2h+kXZ3HN18?=
 =?us-ascii?Q?SVnOUwudl32nG0BGLHsBBsRR7WwcRKmUUDZQT402WA1POPVY4eDlx/7/u+3C?=
 =?us-ascii?Q?uMcXpka7HH7oN7FMWpRjVjzYoLbN/WITwn8zzAA9y8//UlTo5Rz2cF0rFbVV?=
 =?us-ascii?Q?WFhpAJL7I0qcEMHfE4I6AfHEUCJkGFRuFJmF2HJRUqN+k4I0dW6dbwkEa6vW?=
 =?us-ascii?Q?jVyzCERpDKjhqgR+lhb6FetNWRz31C8ZB3STXIaKaY5ImcuqEt+Xk23ASHe9?=
 =?us-ascii?Q?1ICGRGT31DnVKLBT7CGZFj5a/ZIeqP2VKbtGRI4XOeDDERdYasg8lB7s/xxm?=
 =?us-ascii?Q?VOyub3oLE523jrQd2a9dhVPTehweK2a9CbEbIC7rEG3gLChGb5xsJ7iPaT6h?=
 =?us-ascii?Q?ygARx1hoa/WLVz8FDPdlO4fy1YWvd6PQbV4blzE3z6gAH1esw0gV4qbZ0X/p?=
 =?us-ascii?Q?cTNH2BVQ/jalGrXAs61xQhkMmnyvv3FfCKdLoSYf3aJcYwq/GnIAYteIXXXG?=
 =?us-ascii?Q?IsYPCSQEIotfqgxFwoFhdO8unNv9X+gnFFuSR4jBYvvH86hRgGADszMbJcCV?=
 =?us-ascii?Q?nThKlb2Rr5a2AjgVvxV+WWz1vQSUdp6T9DPwBP34hWWSl0GNJURNdYL1l1NW?=
 =?us-ascii?Q?cB2gv2apTYMnNEB39ZrCOPysHP/WPavjTKIlv7R5jOg69QXYMrAaAWBtucTS?=
 =?us-ascii?Q?NzYayJQPvtsdqLvZ4L9sUAoryCtxBVq434BvayBWfggVAXZLXBatRgfoz8FV?=
 =?us-ascii?Q?I5hpgAhOTExov+y9Ir589oPyli71jEb5htkrfcvhI0pJx9BYPwDBsOCM5Rzf?=
 =?us-ascii?Q?oZJxIt5orU1PSTn8aBdVVUbrgX//KMuZPsLwF5dwTShct8nwKDJEdon8cYL0?=
 =?us-ascii?Q?rsF4L3BMGXNA+TWS/ohh64+BY4GzGRDnVy5PATx7jlCS7/Z2Pyt+QdgmhxNf?=
 =?us-ascii?Q?eNZ5yxbc8RexT1Ls+w9EEKLh6dK1lyYc+4kO1ip+jnKIHJtdrtEJwI0xMYI4?=
 =?us-ascii?Q?sxEMqNREd1Brek8UA6dDt8NQv+wY6HANKKix2UUx7eFiPtfRhaKpng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kVRxRZ2DjLwvVC+EDxD0CTCMzeiNNw+9GCI5S376RTaCbP5HthrOOaKUUSXM?=
 =?us-ascii?Q?QlaH87aGZaxND2uLQ8jLYIe8zPL0rE1RvO5Xj8agcPh9J1RlUVDasz+hFnsd?=
 =?us-ascii?Q?8jG2tpZ2gYHfEku+GJl6mc7ovJQqDAaSiUsuT+OI1+Ws07xa4qB9NZMSolWK?=
 =?us-ascii?Q?KWrv15nc6kWqCckL3AbIsnk7TtYJuJWFU+MyuP9kQ5gN/Hzax+4PhQwGrLW/?=
 =?us-ascii?Q?ItPPJSsbLnRpo+1HA3P/hdkGOxY1O5HwHKtAnI/EFu2XFEQbTv9HguUj02rE?=
 =?us-ascii?Q?DsRwnye6FjKX1yaPrnOOVGHdK8wt12xF0CGOFFFtW676uVN8wKzKmKA1OMyg?=
 =?us-ascii?Q?c/AtQxkVrDNZZf/v/udAvi205ADEjXb8sXo4QcbmbHWy01dlChgAjuPs1CZE?=
 =?us-ascii?Q?oKDH2e/o//Rdz7DhVvjXOuS/ZSCtPWgNQ4YyDRyvFtcMtIZibWMZJg5cgnaE?=
 =?us-ascii?Q?uLFmWgATLVC1sYR1n5NrDJPnk/mQl+t4MRpFWv2xYz+tyJF5WFARM5YC/bcj?=
 =?us-ascii?Q?EgLzs6XYwdEilUOGCzYR4BSVDCPSs7iMQYvUZK9Zrj6UsiBYVQV66fYxeWyo?=
 =?us-ascii?Q?LRpNDXOw6o+YHpFj50i5vhLxGypcOZLpYLPvfOepG1UDcdP0zwMCuibZxx+a?=
 =?us-ascii?Q?lIvkSsGoEmt5VfTpFI5veBZ3CHwrr5k3ddJm+Q4Obi2v2HypzgSuUt+RqiQt?=
 =?us-ascii?Q?Cxl2QbI0EYzixaKtEd9jcaG+3J0vHoDAoNvwCT7ng03vNOprrx9x31ydL7B6?=
 =?us-ascii?Q?MQeYd6yLgCNAUP5TyxNj0siXnFhS4O+bBJR8niSagP9iTFdpHXYYpV5/Ul7q?=
 =?us-ascii?Q?tcKiUpAvFmxKTlFBt3hX2gcKXShb4O/UNqdtxaq5r95uwKUGG0ko5kNj3qEq?=
 =?us-ascii?Q?HpWCVkohW+2hWLV5CQoZB3iRgbxfzHjvNA4YZ68/ezXVjk9H296b6hQmhL3z?=
 =?us-ascii?Q?6ctUd7g0Qp/XGuPkPg6bUDn2Q+YQIidJUdTZfPQ6clopjgWKJ2grUBBkvsG8?=
 =?us-ascii?Q?0RFQBPZ8Z6G+c/pmg9I7A+i2D9J+RtUTU7OwLuM9Dqmx1tLzUtiAXMSn46V0?=
 =?us-ascii?Q?xa//Xyo+NBQrkUa4xx+Qeu47xm7KahNs8jFbK+bBXerK4W/IEyXH0c2OtWXC?=
 =?us-ascii?Q?fXZd6aT/VddRctwJHQ0AINj2sjVhzZJXY3WYtxI2vjin27je6bczuG7J0QPk?=
 =?us-ascii?Q?zvCdJIeQqmot+K0m9AL/j/I8EgZbPbLFIhR9Rb0mOKsQ1vTwtEJ4RnQ5jcV9?=
 =?us-ascii?Q?UOTI8hWx7GywieL3voCkGrQRKq6zTCMOt5EoODy6DwSm/L8DO1/BMW6rhTii?=
 =?us-ascii?Q?YguTDh7fxlocL71mO1XznjTAQC2J7+4gDO12JLW1yLOltPyzphQ5VdCc2383?=
 =?us-ascii?Q?3A7xNySdINn4HFDT2jZrhmchHK6RJNbl8hfB1d27n/LDRJOmb1iwxOGA6wRz?=
 =?us-ascii?Q?GO78pTqnCTdcO2xuGxWJzFEdNhAd7QUsqDsosYT+hgfOKSG5L33NYwEoUma2?=
 =?us-ascii?Q?Wi9zdmGKcEGntJHfTQxRI+8yfk31wn5FO2IaoBHu3YYgIR8YRgqJ0hT4Rqt0?=
 =?us-ascii?Q?Ux6Nthj8nbrIrlExtZQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f046de-ceb1-475f-76f6-08de345ffce7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:40:00.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUZ4Uhd97QfFJ2K6VSqxbH9Y1np6HP7kMVtMSW8n6AVyHJvepdR38ao2sfLU11/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

GCC gets a bit confused and reports:

   In function '_test_cmd_get_hw_info',
       inlined from 'iommufd_ioas_get_hw_info' at iommufd.c:779:3,
       inlined from 'wrapper_iommufd_ioas_get_hw_info' at iommufd.c:752:1:
>> iommufd_utils.h:804:37: warning: array subscript 'struct iommu_test_hw_info[0]' is partly outside array bounds of 'struct iommu_test_hw_info_buffer_smaller[1]' [-Warray-bounds=]
     804 |                         assert(!info->flags);
         |                                 ~~~~^~~~~~~
   iommufd.c: In function 'wrapper_iommufd_ioas_get_hw_info':
   iommufd.c:761:11: note: object 'buffer_smaller' of size 4
     761 |         } buffer_smaller;
         |           ^~~~~~~~~~~~~~

While it is true that "struct iommu_test_hw_info[0]" is partly out of
bounds of the input pointer, it is not true that info->flags is out of
bounds. Unclear why it warns on this.

Reuse an existing properly sized stack buffer and pass a truncated length
instead to test the same thing.

Fixes: af4fde93c319 ("iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512032344.kaAcKFIM-lkp@intel.com/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 10e051b6f592df..dadad277f4eb2e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -755,9 +755,6 @@ TEST_F(iommufd_ioas, get_hw_info)
 		struct iommu_test_hw_info info;
 		uint64_t trailing_bytes;
 	} buffer_larger;
-	struct iommu_test_hw_info_buffer_smaller {
-		__u32 flags;
-	} buffer_smaller;
 
 	if (self->device_id) {
 		uint8_t max_pasid = 0;
@@ -789,8 +786,9 @@ TEST_F(iommufd_ioas, get_hw_info)
 		 * the fields within the size range still gets updated.
 		 */
 		test_cmd_get_hw_info(self->device_id,
-				     IOMMU_HW_INFO_TYPE_DEFAULT,
-				     &buffer_smaller, sizeof(buffer_smaller));
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_exact,
+				     offsetofend(struct iommu_test_hw_info,
+						 flags));
 		test_cmd_get_hw_info_pasid(self->device_id, &max_pasid);
 		ASSERT_EQ(0, max_pasid);
 		if (variant->pasid_capable) {

base-commit: 93013488dd77dd2ea8bd23355a5587d9e6dac185
-- 
2.43.0


