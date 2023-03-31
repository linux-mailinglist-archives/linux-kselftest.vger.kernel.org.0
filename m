Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A96D2412
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjCaPcn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjCaPcj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 11:32:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881DA1EA2D
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 08:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPGEeO8nNIPt7wlW0JYWOgeyiodJ1KlPWpgWXNxZpGcDnyblwSbiEvWsoAIttGfZ0NCvw77WBqH3BWHtND+aUCHqWmmtOMdzFKfrFpLP8wRkeYPlWV9RRKVXlrFm/1QEcF2RV4fVGJYZvRF5RpjupuO7AqR2xCcG4ACjo3Ll8cE1z1zZqHHZH49EWQ/JJ4t0bGk+3K7bPs9dZ7EKnKBOC/8e7nUpArhraWiycDqz6RBWSCvym7hSyR17f7DZXGZBKghh8MeyeGKmL+bPieL6ja2JNmeXQ+5jf6Z77BNehXZDUfGcIbRt2xdFPts9QIf645QIy7WnBSRRjwhLPM1WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRsjRPSHJHxMXlisbBXj0goSuYS4q1To/1W8tMzVR8Q=;
 b=ejy90+qHOjQL4ZLzJXEQXvkuc1a4WWmJ26u3PU8gz/ETdMrPpfGjsFxQYSL2ak1SXRihGN7j4l7VpYL+tTFBxy5NwHTrx8SyChGCpBHvPoMrrzVTwiP5pR/xesC4YlZXz/1pnizaAn7aVF2ahCAGPmGIX2es3gkbwLP6/p7E55o3hyjpeO+58E5pALIoLySzSuMwhS0hCzJ0luFccJdJiygA1BMXWZWRmXAHeLWs36seYrZppZukNwX2DAjSkOlLMhpopO174b9CLJvzdrwsFAUbeVZxFIJuH07/hBbsuOWnjyaNDLfSIQa74pCp8gRDACs30mdFRCwN+bcB+wiZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRsjRPSHJHxMXlisbBXj0goSuYS4q1To/1W8tMzVR8Q=;
 b=uALBxpeCUY3wH8dtV7EjTIggMM6n6nAY7g4FQGo7rjC6Rshk53zkRFaZrxyp/8S6OtgJR1M41TCvqJANn0rv0R5kn0S/KkNsvX0nFFZCV5MaCo40yM96yZ0KIRTDHrfqeYH9HEi35LQHwh52lfwOC3CaeTCML3FCRelmpS7Sgid1P6Rl6tS+C4QzuijJhaqJ61V9xHXQcEs3eb3XbCkAis9r4Bqk5s0M7dxuq//OnDgT09m6vNrWjyXusYqJDqQPuv8zuL4HWuD6fKdPZC85hRxRzpfucQ+GBhiYLbIgd55jP/RL2nw0UnPj3ozVPfJrJ1uctcz15nqqipXw80mCvg==
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
Subject: [PATCH 3/4] iommufd: Do not corrupt the pfn list when doing batch carry
Date:   Fri, 31 Mar 2023 12:32:26 -0300
Message-Id: <3-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fc77ee-2abd-4bec-630d-08db31fd22e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7cEbYE3EaggymjHWSnoM4ETcDJCn7xw+sZbpC2q0AFNLQJ7r1TW28amvxO7x/YMw6UUxiX0Q7p9xIbSKvfBIBQ6OWUbk62Vye3H5fpazZksXvSNzTWHiE0KCWHEmIcinVHs6wl0a7JRpv6kW/kTjUFXJcKTRAWinaTh8ZnUKze1Hjbc/gZ5MUau7ijWEGnAl9EElE9+Zm4ttEjeMZxJtVyQw9iw61nxSZsxQ7BGZXq+WcN3w1weoXIfeSpf02WRk1aQe6FknMS4rhdOTgowgRzr282Hm/5F0FW87Qcqu/vdMKoyYNCTGg+Q1mQguWwfVeQeRjI1QVKtuoHk0zjrA9sT/M72vGQ4D646pRfst7YwqyR1j4g6WqKQ88g3Mawgk6K/ZygLgysccoleF3oB1pOqqRY2PvccxD9Pt9ICJYgm5w8e+TQumNe8HV9jrK8OwsTiLCYm8ByB6rPPb4wU0NXBrmusQfErrVEmiDiBIaF8P0WT80nLUwyeXYbwG6tE5JqjTTPvUWHOxUjW08NiT4KjkpSevkWa4xH1Dt2X/PTApF6Q9ETr5wHU3RuPuheF03FSBQAsKPm+g8sSsq75CHhPBSzPkqSAgxFIils1959iDSTNWBc7VdrQCaaJ0HomylBUYi7Y+NMLeXib1Uv3ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(8676002)(54906003)(316002)(6486002)(966005)(66556008)(66946007)(66476007)(4326008)(36756003)(6512007)(6506007)(6666004)(26005)(38100700002)(2616005)(186003)(83380400001)(5660300002)(41300700001)(8936002)(478600001)(45080400002)(86362001)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJ3Pg86jFSB7JnH4DAcxpX2yS5O798+2db6c6XavdrX5++SAt4qIOXPL6qmy?=
 =?us-ascii?Q?e4PL2dVNZS6+Zqhb8LuPqq7/GYBY4VNvwkQiUTunBqtQzeZx2PUqdEtBgOLd?=
 =?us-ascii?Q?WiuWdd8kFspvefp1ELfzXC123zGQJiuFjJzYgo65oxRW5FPMgZCh4WDX6Pou?=
 =?us-ascii?Q?Uw9tP2wby9t691I8/XpBZ/W8nTn93d1+4HLsjrz/kCPRrf7ucpTe1dTwC91Q?=
 =?us-ascii?Q?hqOmkPgLkeKEe87zFnLeUe1JQurT8hTPloc50gFUDKLNMtdOyhPN0cora+5x?=
 =?us-ascii?Q?81xDeCJIFAXDRL9bVbH47kr2azv6CW1oliKNUgG8IVBwZcmXwFSkJyhEGqTL?=
 =?us-ascii?Q?eyeSnfOq9qNjIhiRcoVA4l06yYkGckM4fVV+G+EmFG94LS9aoyuVtRrTLBff?=
 =?us-ascii?Q?k8ZLW1kznDmyF9+UEQvAkx0NkpHMQ7mDAgPS9NnG+KeDj7quJE8qzqt4YVuQ?=
 =?us-ascii?Q?afgipFrRJLQJV7m1y8kI5QuPpFW9gvJKvgZw+364pLYDZDRIdwdhizgxLL87?=
 =?us-ascii?Q?LDa5IUvL3H4Mkc/s3tWQo8AUX5ZOFCC9Q+5aqwdqsBDYoQh8Hc3ixC0GuhkA?=
 =?us-ascii?Q?+Q8vh3aYq5SXEF39qGoJns7cze3/KoIhJA8TdKSg4pWFInYEwLnFVhYsmQNY?=
 =?us-ascii?Q?z/Fvn41oc1HR/2TmWbGjCUy4Xhe3oENhFPhflQV7FW9k2u0E57NabhRlSRR1?=
 =?us-ascii?Q?LyvwtjichPvPWrd1nh/7b+S1gDcLMdwxpler31XzguFM8YxIAS0I5VhW3Kjy?=
 =?us-ascii?Q?JI1r8erezRu8IDtB2jUAnw3A5Pa1gvruydQ+eOF0Se/FUYt3bh4AMGU3PLy3?=
 =?us-ascii?Q?XzuImWtDJSKyL/+qptOOhNT864av7sO/zhK1ru3RokoWF9TI3DGfY3VANqmm?=
 =?us-ascii?Q?Fcr91DogIasdpNks275FpWXDn6z4N/gN1lr8JXK1pduZsFuz5/lUfgQ3+jSm?=
 =?us-ascii?Q?y4TvxO60UzSSZir6Enh5j467NnrV9vQ3lhUn0FHwU3IR/0UAzhxxv8xcBrKg?=
 =?us-ascii?Q?pWztdjxxVORL+nRswGuE9ZLXXpNhDjSF1bWLpqZ87r1elGfoHSPXYCmnBdmU?=
 =?us-ascii?Q?+DUW/faSRKNb0TNbV+DPG7XB7giMbvgWXMe2WF87ipLvNGC+wtRTdhHNmpTM?=
 =?us-ascii?Q?CTLk3ywv+6pjbm2l5SDdqY+W9GrTVqfZ95tWQQo6TUmkdcJry4BzNZvZydcp?=
 =?us-ascii?Q?+GnYDPW9GsCntK7KCwuUXhVucmAvUlv4bTlbQOWe+i82ZnhXIxvuAspY1qaG?=
 =?us-ascii?Q?DJTMk4HisgoLFpEVKW2pLbP2l5915t0OLjuqTk8GwZqsS0vCUgqno7ysQxKS?=
 =?us-ascii?Q?WI0OuKqxBeOdOgvEaf/unb89iwKWyXMLYIKowGR22a5imG+zm6Jh95PLsaaf?=
 =?us-ascii?Q?v0fIg3iZOhk3EiJdVCK4+rHb5vzCS3jQQTAeON/+zCnAo7Z+JpQ09ctXTcFW?=
 =?us-ascii?Q?ECN74Yaj5R4Gfz86CfUBKchIs0VFF5m4Jy/2pP0JQMYeKQ5fO2m9+DJ5uN+A?=
 =?us-ascii?Q?7RVEPf9nWBOLKJwn9Y0DQtdAN3XFUGa2Yuro/EhWYa4FZSr2APRGTtgdidKL?=
 =?us-ascii?Q?OHOIdCZNlqBhVcDGLxeYZE3ghyHCjOFxdkxF0ti1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fc77ee-2abd-4bec-630d-08db31fd22e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:32:28.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/dIB6U7b6SU6Jv/iJIx/Be5h0RnKyc0P87c/aUeM9ef9N+cJnhNJGAf8hg0LCgx
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

If batch->end is 0 then setting npfns[0] before computing the new value of
pfns will fail to adjust the pfn and result in various page accounting
corruptions. It should be ordered after.

This seems to result in various kinds of page meta-data corruption related
failures:

  WARNING: CPU: 1 PID: 527 at mm/gup.c:75 try_grab_folio+0x503/0x740
  Modules linked in:
  CPU: 1 PID: 527 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
  RIP: 0010:try_grab_folio+0x503/0x740
  Code: e3 01 48 89 de e8 6d c1 dd ff 48 85 db 0f 84 7c fe ff ff e8 4f bf dd ff 49 8d 47 ff 48 89 45 d0 e9 73 fe ff ff e8 3d bf dd ff <0f> 0b 31 db e9 d0 fc ff ff e8 2f bf dd ff 48 8b 5d c8 31 ff 48 89
  RSP: 0018:ffffc90000f37908 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 00000000fffffc02 RCX: ffffffff81504c26
  RDX: 0000000000000000 RSI: ffff88800d030000 RDI: 0000000000000002
  RBP: ffffc90000f37948 R08: 000000000003ca24 R09: 0000000000000008
  R10: 000000000003ca00 R11: 0000000000000023 R12: ffffea000035d540
  R13: 0000000000000001 R14: 0000000000000000 R15: ffffea000035d540
  FS:  00007fecbf659740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000200011c3 CR3: 000000000ef66006 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   internal_get_user_pages_fast+0xd32/0x2200
   pin_user_pages_fast+0x65/0x90
   pfn_reader_user_pin+0x376/0x390
   pfn_reader_next+0x14a/0x7b0
   pfn_reader_first+0x140/0x1b0
   iopt_area_fill_domain+0x74/0x210
   iopt_table_add_domain+0x30e/0x6e0
   iommufd_device_selftest_attach+0x7f/0x140
   iommufd_test+0x10ff/0x16f0
   iommufd_fops_ioctl+0x206/0x330
   __x64_sys_ioctl+0x10e/0x160
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

Cc: <stable@vger.kernel.org>
Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/r/ZBExkEW/On0ue68q@xpf.sh.intel.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index b11aace836542d..3c47846cc5efe8 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -294,9 +294,9 @@ static void batch_clear_carry(struct pfn_batch *batch, unsigned int keep_pfns)
 			batch->npfns[batch->end - 1] < keep_pfns);
 
 	batch->total_pfns = keep_pfns;
-	batch->npfns[0] = keep_pfns;
 	batch->pfns[0] = batch->pfns[batch->end - 1] +
 			 (batch->npfns[batch->end - 1] - keep_pfns);
+	batch->npfns[0] = keep_pfns;
 	batch->end = 0;
 }
 
-- 
2.40.0

