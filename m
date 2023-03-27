Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417FB6CAD4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjC0SkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjC0Sj7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED704693;
        Mon, 27 Mar 2023 11:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA2iMZRrBxownrOC3UfuzA7sG4aOajP1KDJDQnBCLRqpwp7rgDJrOK2kgIJhieisPMvk5yNr3TvoOUMp8zwUal4QbLIfKbEq3ily7zridibdRE09WFOH3bI4KMVIh6Bi0DmCBv+q4+SGVWs+LYUiC5tLMGMID7m52X5xEJRSt6eIOxkHJu8zgdPKrUIWiXewYiodOgsdAMyPSg3dwK5sWBwHJTriBgAnXt8Gf9u4XtunE5/Di/SdiF5kMS3o+0CPo314U4QRQRdgbiGEklGRY7g6xvbGP10neXmZzGES8wj/12EFfu72oX8EqNmqhpI8zFip54aRYIepnIyW9C9nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfKinqvF+fUlGnIibM7uDNiQvHgsMRmgf9gVZYmQiTc=;
 b=fjin3Ok5w3hGYFsrzp/EaoEwco/XMriHaRzR/jNsp+wOBosrJNFLGBE/l2uu3WortN7NKEF6UqtcvwAwv0yXQGkaZ6dpfYVmgM96mT2+cFrqXM2IEzO46+fSP8ws2FFdp0/ZvxjXau2VjU+uQ5CslNqZZWm2ef3aQEDdBwqvEat9HYY7gOOvxjJrNQugjviW5ho9h3m2S0Z1wBN27HkL0akbQf1CeKyz8VRc6fppjS7zrcKhtO9mWwOlDHBkkkMQFX7RxQw/4HhGo0fVhBLsadSXQbXtXsDtGeDZPos9B7xbpW9TExEOpwLkE6/UthcOyNlJjzdSmcZoni44yPa0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfKinqvF+fUlGnIibM7uDNiQvHgsMRmgf9gVZYmQiTc=;
 b=hh8avczQlGI83xphlbI9ayD/tA0dpHcWNe+mB2RBbsr4cyFwBrczLyVCUQ/pPfeDFPrl2QHvwrD5R9rYzRx3+3TuC0j+AGshs+vWD3QdvjvhdgbztUIE62JlwJiZMaTcyV0TYTUKwyeS9znDSwG8Cc6Jyj8ZjokU3nq9+KJmA9hCDuTQtmho0QpSCjBJ8a4URCLJlp82H3TptooEiIYzbMYj7UJxWmXWziBnFO6rus70rrVdcBmYJS/toxTOoRXExcXWO16inb/1A1MKogswy5PRCCoIlyMJ0ac6KW/DSVFw8b0nRzQ4y+CRfa4gDcxNAm2NKliew40NsD34URLR8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:23 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 06/17] iommufd: Use the iommufd_group to avoid duplicate MSI setup
Date:   Mon, 27 Mar 2023 15:38:00 -0300
Message-Id: <6-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: de32c114-afdb-461a-38dc-08db2ef26cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJZ0R8fAIjnCSQN1n4BfJMB6zemDyEPoQt5HeMjejYs+uyUHJbjbE5RrD2iJ0Co7nF5uekWaAViZ7CWIy+W5ELCA3wNBSyyj25CqODcsTv+4Tu6k5xnCNHzl/vCz9kiP86h0cEC8IL2dVpBJIUaN+/i75NOMtM9WJ+8AeSW9odty9rLZLcW6fDOZVhLt2s7OME0ziJcpZjCxONkpthvIfYRop/19kXkc8jzNuEy932vT+euLX2/cIEsE0mE0qafn4o3MAJDT8XqhBrWauifzVK1LN1I/MrAGHmQZ2EsR64jpjYIR4wvDy1JRMDdanmo80l88BB7mUiDHy5gyc+XKRebeqyoL34PPjxq79fytkS/LUeD38jMDgSE11F7nrAfBeou5fLS5XvpS5XSmiSvaV/XNmxcYh8ghlvfjqUGoSpt8xkVtHpyczwDfwp/8GLyvuAf9vF5hpuJHVOYzMPQL6fV2VHUYikLYK8YvksdVi/CoMUZ5j4JUSENXtKetlw/gj/XoaCGTwqQx4qKgvdsu3WXng3wuZ7HZgmg+JK4sv1RtIh+5HMwNl5Up1IO4Whmj/DVCje0pEqN7kBntCLGrFCGMDOAhbf9T0lf20YSJbLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLPCEJXq5aEG3GV6r2M1eWfZmRqrl1Aod/RgqKSsUArGArcwgf2vFFuBzvsa?=
 =?us-ascii?Q?s2se0lh2ybNzormy0LhupsFQXDu8ZVIX/ba1PBiBZRdV7v2Zh6Gf9WvxuxjJ?=
 =?us-ascii?Q?QV56P/lbXJYsXlrZGjcrpvRRxecj8TtA1BekZ/LghpzapSJ14W4xz//QVRn+?=
 =?us-ascii?Q?TyJ1UfoehKHl46z8k4NMdVdO66rkzDYH3+oJ9hXN8MZULUt13Xm0xljWDqVZ?=
 =?us-ascii?Q?kWFGDxYkLPBhIEV5gSwCJ6hbcTxVKL5Ss0Y2YuHJljUjbY+ydsO4tmfDqJNj?=
 =?us-ascii?Q?lFWZCOCUjx6TRTq/DK3XSkNqdaPBLZ+wm8SDKRF4tmYRp5/L9lKXTgyO8rra?=
 =?us-ascii?Q?wQVKddkXxhfl/93O02KRp1OxQyrpWAsvmoz8g9/BcxYuy2LiTcN8h+njh0bO?=
 =?us-ascii?Q?ZO2LuozA+APE5KOs5vttNt9v1/l6vkI7JS4BpTKOsygm7jq2QBifY0t0AA/w?=
 =?us-ascii?Q?oE7fJcpl7ckOo7UnRAZVsoGGOOjwlS2tmSYqhX8X3p0YEgv+GnM/LVVIF0FX?=
 =?us-ascii?Q?XpFMAsdUIX0GY+OLFbD0Kcq/FzSVNgsuSdjpi/ZhCEQiJFcLs8SCrAQZCQXH?=
 =?us-ascii?Q?1W6+NtIo0EeNzlU7O1svSMvT5pAmrlPkXtPQWd7ZpoTfp9g7DMsOKqYD+zSG?=
 =?us-ascii?Q?SDDW91lVA9LBUCFrn7p0kfwwHQbYwoTlphpgSR8lItens42F10kmopGYNDow?=
 =?us-ascii?Q?WEseH2hklF0DYuDSDrcSpXnvSnpT5ia9Xx/jhKjyEtb5qu1zOqSmF7RNTavD?=
 =?us-ascii?Q?RQxw8DxxvpxHkOkHSPwrDKMmazztMOyFp/04qVHswawmeeLPwztR8H+BBG4w?=
 =?us-ascii?Q?9YL3J75RWbiTcN23XKvZ1ZCIZD/m7XNtSesQdfgDZUTwTLfa3tWGwKSqtR1D?=
 =?us-ascii?Q?w6/XKdNYr+UCkpQ5UuSIp8QAnmS0yEZkqNtiJsqHGtST/7WpcMBueMgNwCgQ?=
 =?us-ascii?Q?TohKnRwgW7aved1/iACFUoPQ3W/jlqRtvCuV1aXbgx+ZvGYe0hp0eyb2b272?=
 =?us-ascii?Q?MvRWd74US12EL78X4WJLzyS3x4N4bg1anFcFZbu4b5HJch2tFKIqLfomBI4f?=
 =?us-ascii?Q?cMkisuwJ65xlOftGPgDeitK3BcAwzhelLP5gz6Z/KzBJUoYIcRrjmtV2+1S/?=
 =?us-ascii?Q?GxxUoZpE4cp5N97/ibQnzjo9e7ltDdQIWRwoPN8QbENEvBwayhD6s4NwjpY0?=
 =?us-ascii?Q?eCoWjZeAR0PTQjt7SC5wHPW4hSFwFFfYEybVxuSWuHAus6xzeLFQkdox85HA?=
 =?us-ascii?Q?0WNgrO3uFA6nSitPxeri6DJtu4k0ZjYIdzRGuLmk0CoNwKjszvsP+nPn/5iH?=
 =?us-ascii?Q?yxeWeRNKxaGnNGZU8g/1xGCF9M1desp8t+vD1SNk+CkUmMnfFn5//eYBQgoE?=
 =?us-ascii?Q?PUzlU2Bg+2ZKVjsfi+9CzOL+x8ChVdk0CXKXWNm0HOSgBYF32nv3P39KaFk2?=
 =?us-ascii?Q?wkmJNGYOYKRMCrvxKE74YuFVULCiP0eMY8dZptQ35WKSWDNJaBAB6zCAzk64?=
 =?us-ascii?Q?8JXRkMiwWBSYRRkXAzVUi/hFyj0VTSM+u9mZLc2024GuGhSouXmRNXWHkm5u?=
 =?us-ascii?Q?l9wrnT62nDJYt96VcsAChihU9nmuDJxdo7507SeV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de32c114-afdb-461a-38dc-08db2ef26cca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:14.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcxmmA3Qmya3nDxit+UHjJxasnHdikLHUgSL9btHZ6a06deGaVXGt9eToxlN+ouX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This only needs to be done once per group, not once per device. The once
per device was a way to make the device list work. Since we are abandoning
this we can optimize things a bit.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 112b6c541c47e4..0aac63742437aa 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -318,10 +318,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		goto err_unlock;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto err_unresv;
-
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -330,6 +326,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
+		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		if (rc)
+			goto err_unresv;
+
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
-- 
2.40.0

