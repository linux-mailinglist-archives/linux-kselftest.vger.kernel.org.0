Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E96D2411
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjCaPci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjCaPce (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 11:32:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C9020DAD
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 08:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsg3tFmBIVE4+Wt3o2CrkKFEVvoA2zo0CCAx1IwDpR2rM2aUhMQvkegHPO9luX/QEYqqd2mnj6E6g398+FV1g1eEnSPn1kCbIIq6eKWJ1zL/m6Bx+hVb/e8MaRSFPVIdh4QYbEe9GvFnb0Q0+viA1WSeYYqZpjjYdcbi0OzreWfgx0JjjwD1wRSMhMlH/Q0Vvwjwkf2/OuPTetxcrYcoBjZ0wtTZ/+xUyOcWl947YjLGccC3xvy1PryoDyNwUstpt+cngNRI60pp1/xNO7W4Yiz0yeL/phr9CdVpvvz6ajFxjDK4KHI9BVQs2xBErvsNLAO612yZdOa+vl1EPLSB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki7X9rPZekzHolKZFmF+4Td7gVUK7vGfOxJ2gvZqeNM=;
 b=Nmn/CaceIN5EOjD+rpqnOPKlRgP9KftCNe7frNx5J70mmC51sWMVPQhAeeS75MIIKMLf5yCNnkYQFRGhKcs9DAOzW0AAH9TaTgyh09qJCh3NShaup8+LGCNs746SRlXSOSAzjbGkn46Epu8HiSTqwMt4eLdOG2d9RTn0GE5H3oUSW4jMFY+o5JID6LYMy/EBNyjK1jmgyUYfWeeZLk5iywuNXugEmSsx+VSuSvkWjIcS8IJ/aGoJooRkljiyTOx2zXChygnu90yGYOUwHUsC8BhiAwZ7Idm+rBUJgMavROBeJp2z/k/YvMzGNAC+xfC7zyfvZpylYMvyKf0C/C+N+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki7X9rPZekzHolKZFmF+4Td7gVUK7vGfOxJ2gvZqeNM=;
 b=ZNnx5GZDZHo0WGGSx8jQoLLC9mxHuZ60ZyX5AoCGM9s/7GzSDcudo7KbkeLwJPZliMl0C73QVBV2Ssgu3j6JC07oWmx0BR2+9Mm+/87aNP31JGCFWPw9I4ntYztbX+T4d/k+vbrOyqtIe96IWn7igFIqlSsZQaR6Mw8oTUV93utKF7x9HDYx2vhdQ+1t+x8ijy6XNemulP4kERfYFbdBPubGuYPAeZm+3zyQeNar9m46A+iiaVduHErRvLmD2Z4Rz8ejx1/4jr37MwMKHUhmQ53oCSE6VsYzj4Hb/U8BbaksOqQcA3EmGYsTM64/K4Lg4t3BdbeYc63bV7hCKVsebQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:32:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 15:32:28 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Pengfei Xu <pengfei.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 1/4] iommufd: Check for uptr overflow
Date:   Fri, 31 Mar 2023 12:32:24 -0300
Message-Id: <1-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f394ad9-75f3-43d6-eef8-08db31fd22d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nk69qSovB2DhvqjbLI/vbmphD9InTD1kFBDb+jre5/calEHtXbeHE2wxvCi3+RurHtiZcLbOAcL3jQe8ptVUXTuSuCwEyWNnMGESwgSQ9eB8P1cz+5c1WPItk5B3I37c+0AyZIY5zqYoQTqB8jorecrFfNZGu49+K2sB3+KbNmextoDrPcjVS/zcmC4h0QF92b18QmbKtjmZSVRrUNi4LC8rU9BKDaBCIIP3W2/cAjXj3V0GwtbEkBovwqOq+4di4FPe6WHEOZFvwJ/4Ga1QwTQL5SgkuS2c28s8QvHiXvhZLweUFvEm20mQh392JkfK2Gn9iCJWRdAho0mOaR26x7NpySoNKn7PPSviFA33WfWqT/YzX5zegkaYdWuEoh1dUN0zviJC3bGmRp+ZvPrxuKKs23fiGqiXhHHyyfCdTAW1vDG08jw9vymCPFwTigrrOVDm2j3Mx9TxROSCjFTziH2ai0d0wOCU/zuxEvS4uHaLomUKA7e5bq7cGhk9F9KL3J8o/BCx2UtGMM2KsjmuTt1QCoehTehg5U0k8Y7l5gzkTK1AxZkKxYrd76WbhkCr6cC+IEuqpoXgTPEh9rqtZr0ZcxUtYZxDIOaR8WJmPFDs3kVkgjtMoKMXcKjSfgWHdKDYfLpWg9t/xOG7hOj3qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(8676002)(54906003)(316002)(6486002)(966005)(66556008)(66946007)(66476007)(4326008)(36756003)(6512007)(6506007)(6666004)(26005)(38100700002)(2616005)(186003)(83380400001)(5660300002)(41300700001)(8936002)(478600001)(45080400002)(86362001)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RprWfBUt93EldFUbaa0QVeCsGk5sIX2E5kaTUtpmvfJhepPaiXzMytbEAkWA?=
 =?us-ascii?Q?pClOFQ0ieDxusUHaormH2guhVaB1y/J5BULPG44rIKs4nJFhGMX1mWFanGH8?=
 =?us-ascii?Q?jkkhPiT6HUVS9QQiDTH26xjgimtyPo5PqtTynXg5IEEwFFx+qAHY78MM6IIf?=
 =?us-ascii?Q?lNtuQhrf0jHBQh4PCA5DWz4x+54tR1dIfffgBBtkQ+8pE3B/HXMkpaep91gv?=
 =?us-ascii?Q?KKI6vEoMrSpzFoinlsDg4Bl/KlwQJ2lTDpmeIIGzdZ9wsBB/3DkSLTrSCADa?=
 =?us-ascii?Q?4ixLWvC5aV5NyWC+SdvVO/t3YBblZ50Hnu0GMf037cJRtuSEOduBMSvH7Vrl?=
 =?us-ascii?Q?3hVATDnIg8L/0zvIDlEYXaZUu/4L4kcP8wsk+9B7cvddn9mxmiDs7UVoyR8m?=
 =?us-ascii?Q?v02eeabJDkEbxcJbDkmZ9rlsgIgZSL7FjOx4V3nvVtcvCYsYgGUpOozzMKPY?=
 =?us-ascii?Q?OQf6cn9OTuJx8/Zzfec96JlwNZWUTvXOz+X0KS03PmgJDRKTGaXJnAw9lpkZ?=
 =?us-ascii?Q?lilk1yp7dHXG0t2QxGU/2o8xaEqYxP+femRWAl7tgg9Lu9glCRpfM0Q4r9bP?=
 =?us-ascii?Q?wgxFJJzT4Nl7e52WQuKxoAB/YVyGDpuAfRKmP4WVwhMlcvPWsxjMIvEA9sUa?=
 =?us-ascii?Q?jwvxQr8s7l6fEcE6bTk7qtD2El4Zf+emvMmJkvqbgBSp79V99c2phgPG+SsU?=
 =?us-ascii?Q?YbXlhYEwPIfTxSm3E3vkwp/dBrDbauQkDCapZg6sAC52RnGw0vqpxb0CfgUC?=
 =?us-ascii?Q?IDMov0o9eLUPkSva48Vl1uBac9KuID5Mg3X+Xuqg2u6QQBOElW2argd8ev1G?=
 =?us-ascii?Q?DOUC4760/9Trstq6sAMa2RlhIoft6h06CeaGLFpeTrfNg8Et6s5l1bunW8Yz?=
 =?us-ascii?Q?f6tHXB24PCRS9Cg5X3KalI4xTQ5y/rhZUrNmtfiJPFmj63DhqDX4olJOKEx1?=
 =?us-ascii?Q?yywnSBVF8purJSPh5RjZCO01KqGHJ6+kpu47wJh5d4tRHI5OVgV+D4tfdH4G?=
 =?us-ascii?Q?URARy7FoEDbBAULUyhsnD60eLriUihiqSAoNodSpi2zSejFhlRZ+Z0fAibzY?=
 =?us-ascii?Q?SRgXLcSRmgey2Qo4dyuZSZAuC1RkJZU9ElAR36mPo397WLPVIPayi7XhvbXR?=
 =?us-ascii?Q?dFA4fb47Pc7ZMxoSlCuFUV4bcdI/sRG7J9eUM6Zb02TyMybF0wjP4j2n/PNT?=
 =?us-ascii?Q?bcia4RiwZhFybEfu9pEE7z7kgc3Tzqu/OhqC+XyjnQuZDTzeKx0smNba0WCS?=
 =?us-ascii?Q?ppt67YRTf4jkuclQ/VOilFzC0+JrWScxEpZqoY3ICIfrHQcnaP7TJq9RtsPe?=
 =?us-ascii?Q?HKj4J8Bg9HwHBktq8VcebnLabRaeRYRL7H/4aygaioHHDCp8lO3tYeV9n211?=
 =?us-ascii?Q?C3lFUbNYVgGuWZaF1hjzPRHRxRLvrz68sbhFHAbRnpuMefR/lyvGSx7cfakM?=
 =?us-ascii?Q?+l/JXT+i19u+lf2i1cvlN+cvcdTQnTde/Hwt0PmV5i0J7fbSbAVmZpWSTWqL?=
 =?us-ascii?Q?QxRHzpBjQu5KurDGUV1yMP0frSHQp8S2+yXnL3ZWDTr05J/nYBoBmHe9OyGq?=
 =?us-ascii?Q?bGTiehQlTesQam1xHqW25HpBtMW8mHYIQWiYeE+J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f394ad9-75f3-43d6-eef8-08db31fd22d0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:32:28.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh7JXX3pB2+7p91TcbP5h5xVMKABGoAYdTSxnQwyOXUAZyxKD25zD1vNzRwv2if2
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

syzkaller found that setting up a map with a user VA that wraps past zero
can trigger WARN_ONs, particularly from pin_user_pages weirdly returning 0
due to invalid arguments.

Prevent creating a pages with a uptr and size that would math overflow.

  WARNING: CPU: 0 PID: 518 at drivers/iommu/iommufd/pages.c:793 pfn_reader_user_pin+0x2e6/0x390
  Modules linked in:
  CPU: 0 PID: 518 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
  RIP: 0010:pfn_reader_user_pin+0x2e6/0x390
  Code: b1 11 e9 25 fe ff ff e8 28 e4 0f ff 31 ff 48 89 de e8 2e e6 0f ff 48 85 db 74 0a e8 14 e4 0f ff e9 4d ff ff ff e8 0a e4 0f ff <0f> 0b bb f2 ff ff ff e9 3c ff ff ff e8 f9 e3 0f ff ba 01 00 00 00
  RSP: 0018:ffffc90000f9fa30 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff821e2b72
  RDX: 0000000000000000 RSI: ffff888014184680 RDI: 0000000000000002
  RBP: ffffc90000f9fa78 R08: 00000000000000ff R09: 0000000079de6f4e
  R10: ffffc90000f9f790 R11: ffff888014185418 R12: ffffc90000f9fc60
  R13: 0000000000000002 R14: ffff888007879800 R15: 0000000000000000
  FS:  00007f4227555740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020000043 CR3: 000000000e748005 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   pfn_reader_next+0x14a/0x7b0
   ? interval_tree_double_span_iter_update+0x11a/0x140
   pfn_reader_first+0x140/0x1b0
   iopt_pages_rw_slow+0x71/0x280
   ? __this_cpu_preempt_check+0x20/0x30
   iopt_pages_rw_access+0x2b2/0x5b0
   iommufd_access_rw+0x19f/0x2f0
   iommufd_test+0xd11/0x16f0
   ? write_comp_data+0x2f/0x90
   iommufd_fops_ioctl+0x206/0x330
   __x64_sys_ioctl+0x10e/0x160
   ? __pfx_iommufd_fops_ioctl+0x10/0x10
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

Cc: <stable@vger.kernel.org>
Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/r/ZA/O6vGUfni158oK@xpf.sh.intel.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index f8d92c9bb65b60..400ec7c91ed7e7 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1142,6 +1142,7 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
 				    bool writable)
 {
 	struct iopt_pages *pages;
+	unsigned long end;
 
 	/*
 	 * The iommu API uses size_t as the length, and protect the DIV_ROUND_UP
@@ -1150,6 +1151,9 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
 	if (length > SIZE_MAX - PAGE_SIZE || length == 0)
 		return ERR_PTR(-EINVAL);
 
+	if (check_add_overflow((unsigned long)uptr, length, &end))
+		return ERR_PTR(-EOVERFLOW);
+
 	pages = kzalloc(sizeof(*pages), GFP_KERNEL_ACCOUNT);
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
-- 
2.40.0

