Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794826D2413
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjCaPc4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjCaPcx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 11:32:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBDF1DF86
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 08:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8MfQEFbiBfgOd+SQrWz19tyiUVjIuONBk9miPy8E+wVrNmbs1cMoZlQjEKX4IwYl48WX2E36VN8LPqKD3S9D6W+qse+IYjpFTJzwa2uYs9oESf5dLPFkACEFsHVDfUphUQ7YbrNylBkUBk79mOmDptIxVyk8D57rbjISGXPdDgsajVoNFTEzWmsRbUSQz8PQlLOH7l5AhPyx7VW+H3+fCE+PvTPmq0ZTnxT/xzz12e63GnLuEFLtr2BT4cK5UbZkbwugTXjQbiIvrVpiHrOm5s9us4LoSY55AcOnRCEAOFseAbYcASOfeg8ItfMhYuHLlih9XazFTJypYAammXidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKfjiTCoG73oiv986QSHGtlQoVKfS7VuLo3ijhVE5Ts=;
 b=ZDxnK/aC16ZSMSf/0Iv5uMbiCwt+ffeR+sQp6Ji3J4yrIS7qzWrEHr/ArtHHo/5znJsilBLUitA/5owfdTdX/DCEhOCb1R9HZ/Faj4Xwnx4/0kpfyuVnkAk1B+HGM7yywWQ+imRd6RxNL7XmyX79YhPZkLQo6ksIgw728n/fMxqdRdosQQmNp71L4/9HaPtcTn9LR46ZC6EffNSUuNp5qSdQ17QZ4X4vyOdTlsLAadp6a9YSQK2OMkat8x64fMbfJFKM0foALYB7WYnwFAkYtNFogMXcr1PuL4/zjfTE2yybs6lX/KhtM6sJz+XsYd7uYnmh82ovkYAxoEP60rSyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKfjiTCoG73oiv986QSHGtlQoVKfS7VuLo3ijhVE5Ts=;
 b=eUDDUldgrQlBwstJNoy8kUe0iHV92x2YyMpLzmFBl+RxMgKU2p42H9rbiM2xPdnHkdjmKv45lOAhCz+3uQQkDqbptkTpWGIaj7JNJ5w3Zw1n7yLnG6MRhr4oQRxKa/Pyts0NKn1pahlbdOvfEupenKomjEwAW3TprdO9S69cgnHvigHNO167LDaCR7kBAkf4F48xUc93fQUUkc+rA/9slVaApn2qDQzLidjetNtItZJd+WqqITbmdzVzC1rElTPuPAYLwKnm0aHkuU8wsxYfjnH2wgB9B51i6vJ0sKp4ye+pdD0Hqtqk6NhqRpL9BSoe7Ydd8ItdUMeK/V1cg0JdWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:32:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 15:32:29 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Pengfei Xu <pengfei.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 2/4] iommufd: Fix unpinning of pages when an access is present
Date:   Fri, 31 Mar 2023 12:32:25 -0300
Message-Id: <2-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 479064be-ed74-4486-4e4d-08db31fd22f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39EMAmHcvA8Swmfl2QXx5IRE4e7ie11Qm5uZLTec/CMCVf5fLXjXfvVNGYz3BQHGUjJ2nO4Na8rER6H2QveqwTOIQfcMKBBVGasvHxG1ruPbwan+hMSVi2/ZtJ2v3+CdIUO0DpTOsJ/HeqCyXCjGNEZy+zKo7/IHWTtJVK3PWLqgDVmy5NQhhhJpZzRnBBTckmu/fU6oD+44y5GG1EgJt5mkdzpA2vpKi5j/ynR84YN+p2tyegmhaoXd6YcT+nOjT5M1Iyx0ou+kX2TFvBT6r6AEonG/7sEoaq7NxWtLqzKE+cD4GFgmAnU5W0F0R/O59zpQ8nqa6f1MB7ZLVM2AzgMdIenUkG+AsvY7MJ1MBljZssUKfZcZUFvoObtWGa1CUgSBA+xou1bRbAHeHcOQjGJiPFuiE7tg1xH7QrhNLGH7NvMPTm2hfVqB3mKXfYCW3ZMqQZqmWIq6/2iBJieJoCvLclWGKg/5OpQFtP3lLmeJlx2VsY9SGNR7wA8wQE2dMKBkz9Rv+j/j8HQTf4DJ1/TNla7k5ye6fAyPB0PcBaXSbqAw8GC24Ca4lzi9gU0PRibDSrf6c9dT8Ts7Fzgu/GmLDe3AS0tHXVmWvAFqbU+ZMBhQce0OPwJw2f34xJmZ7pRRm/uFuJpJWOR9AfZmnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(8676002)(54906003)(316002)(6486002)(966005)(66556008)(66946007)(66476007)(4326008)(36756003)(6512007)(6506007)(6666004)(26005)(38100700002)(2616005)(186003)(83380400001)(5660300002)(41300700001)(8936002)(478600001)(45080400002)(86362001)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxEEV4FtylAxPY4qLBNxP4swHeJkxNh4JtGwc60QkNR/DbI1bPzmv7irEPDq?=
 =?us-ascii?Q?SLO0mv0ihPj3XEocBoVckkSTZbvhkG0XolDRlpHIwWYJm0+2bNrbR8LqPMm7?=
 =?us-ascii?Q?PKvvNrUcfxAmWD0yniZSYutoY6X2nV5r0ai846pMpVBMLBJor5KKSHY65mEm?=
 =?us-ascii?Q?UpEpFIRjYt0uxk4uhK5HYT8wW1heU5sjB+AuVxP7B76UIBP3HTl3K1dPhgez?=
 =?us-ascii?Q?i3fDjnzo8SeYaPabEvTr+3zcpcjy2TAnpBkF8iLTLEoLkd6GZzZBTPZp7rhW?=
 =?us-ascii?Q?DV3ZG0GkI1JHiaK0QtzYuDYdlFuFk2S08EUdV1GoYBMWM7SevnqEX7LSH09l?=
 =?us-ascii?Q?VMi3TLotdcLzorpb+64YVvhOVx0dfx2Z1AzczG7+190VCIQ21mn0OBZc3TSj?=
 =?us-ascii?Q?Ofc7zi/1Hu/cNI5kz8LB23JzkXlInohCELXjblzHsmHrBkBybWMa67vmKqUT?=
 =?us-ascii?Q?tbsWzp8lS1NdTBKiJpE4hmpnx2L2nv3pMxUlgWPASZfuazr45k/xRW7R0cWM?=
 =?us-ascii?Q?4CpC7gNolCGq5DvA82WsF2QOfD1BU8Q4IFfKVLbE/RVjTtUpZbRxjsJ8Cxc5?=
 =?us-ascii?Q?HUFJYgIMcesXnmlMUI5fkwE4vrRQmdHMMM9otV5S4RDjk2p2oVZBw0JqyMKk?=
 =?us-ascii?Q?w4l1scKBw6ugvSrgKURRW211GoT4vu/4UFYhYF/LxWjdEQo3G8QBivPzSdeQ?=
 =?us-ascii?Q?0e4HVVsXaZgEM07vcNqbkfiAXPqkGF8zG9gW/nOpsuU1HeQPhWKB9+8AsRtD?=
 =?us-ascii?Q?SVdcpeA62x69lJLMSg6h962sxtAHKOGhArx7aT7tznAv9k+E6ZnVi1+UlriL?=
 =?us-ascii?Q?efCZ4qtb4yUqiYr1HR+D/K3nAsgDeZ/ANVTyRS5kCNcNdoAacMoGmmr0mi1Q?=
 =?us-ascii?Q?f/k0uZUSvw/ntdfgAjvYDggLAXE0wWoJxwXCv6spJOP/kYzpis3phew45bwa?=
 =?us-ascii?Q?BeA/3YM32o+2rkfTLAIB7jmlNJtdLerdBAwPzo3p7TxE483W/ieGPLLCOyz2?=
 =?us-ascii?Q?6qUznSjddf7DU/50gmtyGo56ogSJFbHIQR/1yaMPrKG6eIxLdVnVjrlPKhMy?=
 =?us-ascii?Q?eQrw9T2KJ0dX/9jBtB3D3tUHgOGHlOp4OAy5rwg7cn2bajOpLwh2DHjmuIvs?=
 =?us-ascii?Q?zlB/f0ICmMS2euDEYlmieP/wAYlSshm6ughFJAILleCCD6GnxyGn1/Tgh0jf?=
 =?us-ascii?Q?wznB+404a7CXVAn8hz57WAokc9v+MbGUhdhsSw4cvIgZsH9Haag2UOTlW8AT?=
 =?us-ascii?Q?ya7GefCoNNI9/Iv5++yu+2Ux89xzCWajvrxni4NvbK6iOEVu5xwnuvj8gJ+B?=
 =?us-ascii?Q?zdNmlAB1GK+Z5sHGimGIg8EhcHnH6ORdnyg21LKAm44JWQyKM12G9CYdbUkQ?=
 =?us-ascii?Q?co8XHeJFhKHaXAs+6OPoVFfYCsgR5cbh1sE0kyA3oNhfWnUKfCwqqRF+3ucN?=
 =?us-ascii?Q?5BIBCpq96X3jQWSNuFKvn9SZ9Cjvt/L32Uxf/JtfpPENnLCf8XuaTfGJo4uS?=
 =?us-ascii?Q?e93cINFbmeIBuIalXGK56zFilTUYkHXenklsqMYYeYmDp8RVnfiTmy24Z6Sk?=
 =?us-ascii?Q?abxNchRbDTOsKaWyH2uWz5E+Y15me8HPCmqSkFwH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479064be-ed74-4486-4e4d-08db31fd22f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:32:28.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P9MLWVac4xbUAlgJIruM2puuch/Ms2euy0VpyJxO8pSDVhF4yREGzuUJpK0E0AK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

syzkaller found that the calculation of batch_last_index should use
'start_index' since at input to this function the batch is either empty or
it has already been adjusted to cross any accesses so it will start at the
point we are unmapping from.

Getting this wrong causes the unmap to run over the end of the pages
which corrupts pages that were never mapped. In most cases this triggers
the num pinned debugging:

  WARNING: CPU: 0 PID: 557 at drivers/iommu/iommufd/pages.c:294 __iopt_area_unfill_domain+0x152/0x560
  Modules linked in:
  CPU: 0 PID: 557 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
  RIP: 0010:__iopt_area_unfill_domain+0x152/0x560
  Code: d2 0f ff 44 8b 64 24 54 48 8b 44 24 48 31 ff 44 89 e6 48 89 44 24 38 e8 fc d3 0f ff 45 85 e4 0f 85 eb 01 00 00 e8 0e d2 0f ff <0f> 0b e8 07 d2 0f ff 48 8b 44 24 38 89 5c 24 58 89 18 8b 44 24 54
  RSP: 0018:ffffc9000108baf0 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff821e3f85
  RDX: 0000000000000000 RSI: ffff88800faf0000 RDI: 0000000000000002
  RBP: ffffc9000108bd18 R08: 000000000003ca25 R09: 0000000000000014
  R10: 000000000003ca00 R11: 0000000000000024 R12: 0000000000000004
  R13: 0000000000000801 R14: 00000000000007ff R15: 0000000000000800
  FS:  00007f3499ce1740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020000243 CR3: 00000000179c2001 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   iopt_area_unfill_domain+0x32/0x40
   iopt_table_remove_domain+0x23f/0x4c0
   iommufd_device_selftest_detach+0x3a/0x90
   iommufd_selftest_destroy+0x55/0x70
   iommufd_object_destroy_user+0xce/0x130
   iommufd_destroy+0xa2/0xc0
   iommufd_fops_ioctl+0x206/0x330
   __x64_sys_ioctl+0x10e/0x160
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

Also add some useful WARN_ON sanity checks.

Cc: <stable@vger.kernel.org>
Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/r/ZBE1k040xAhIuTmq@xpf.sh.intel.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 400ec7c91ed7e7..b11aace836542d 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1207,13 +1207,21 @@ iopt_area_unpin_domain(struct pfn_batch *batch, struct iopt_area *area,
 			unsigned long start =
 				max(start_index, *unmapped_end_index);
 
+			if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+			    batch->total_pfns)
+				WARN_ON(*unmapped_end_index -
+						batch->total_pfns !=
+					start_index);
 			batch_from_domain(batch, domain, area, start,
 					  last_index);
-			batch_last_index = start + batch->total_pfns - 1;
+			batch_last_index = start_index + batch->total_pfns - 1;
 		} else {
 			batch_last_index = last_index;
 		}
 
+		if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+			WARN_ON(batch_last_index > real_last_index);
+
 		/*
 		 * unmaps must always 'cut' at a place where the pfns are not
 		 * contiguous to pair with the maps that always install
-- 
2.40.0

