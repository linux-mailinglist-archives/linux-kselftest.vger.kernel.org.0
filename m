Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364D6AFB45
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCHAgZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCHAgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7294DA225E;
        Tue,  7 Mar 2023 16:36:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4Qv/BIkn2j7vhlLD5v6i5SBqy6bm/kkNaU0sj0Qq1bNMT8BTAqfqFCHOiuqRPcLe+rujyKGeSu+oDNdjzH0HQAA41A2Z0TE9nJ3xzosiVp5rCRnBKQqkAWHKQP7W2OGeMGozmWwjYL9iKbsdIQ0EKRAP6JOYv6VIIMjsNebI+8C+aEu6Jp7KhN1QvgchJ0NK2FBAEZaVbH0zxODnCmmWWMTj0rAVpEiGMD6T3NsD7fH82mzNmNUs3mUcW5vZMtNbr+WqnlIOsiAw6qltEMUmFfQulNcDx8vzeRvGWlsd+zyaaNd1UbiKAPz42EVrQ98c9YN3EnZTiHylleYbhQyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwytGq9WjFtn9115TCY/bO2n76D7AUTe00Juo2oVHRo=;
 b=EyrpwYngQpW9fWjHpU4BqU7LVkDNzNqBOcVxhYkLo7Je03o3DWVedxvczUmTJ+TjBS+OCHWNc2wX/KFaWDE8vWCwvE9WlWyiVSBBdpQGdltlk0m2LM+WPE2VXA0Pvpu9DnSAVUMir21Uadd8jSWhxxznyf8Eno+bkA3ZxwQ/Z44qgJ7WBBAfydqxW4rxmYPTSQkUoHGH4Ridd9WbWHnx5xYuwplnPuyiOC/Bgou7AlQ3wX2PnwPQfbHknXDi5+RurAXHMtSVdoQ17nuPZ+4EUY27H2oNY5JLp36Ba5Z3Y0CePub3SxgPS+x49RHxxONMdmPMF0XfDbtMtFC8GXA0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwytGq9WjFtn9115TCY/bO2n76D7AUTe00Juo2oVHRo=;
 b=QHsw+AXId+T38wirTEZkC5S/xh7eh+Uw5n9atFbPL83qvj4bGcJqIa0QGxCMbayAjWATIaVV0T5f8pPK6blfWd7OYl8Q69mNGSLtYxZO7fkO9WFKmNvi8uyuGh1v2bjuuB/JD/ZaAtcGNFFtY+FaMobeCm/OH50dj9kkX+tCy+a6SmD2cYL/hoNnRKPp8Mok6HmOpjZyXxw3BxSvLCFjbjxhaVhpcu/EGEphUgtzPCKZ5YEgxNSQ43j2F62BQAzZn9IIC7Ij+PMO/84A1NOTqyurrnP6uLxLEJVZh9UeQQA2yhyjId/haeWb6iRaLcVDIDCtrlXRfC6MK5BTWrgEdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:02 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 06/17] iommufd: Use the iommufd_group to avoid duplicate MSI setup
Date:   Tue,  7 Mar 2023 20:35:45 -0400
Message-Id: <6-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0259.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: f5606781-df76-4e65-16ad-08db1f6d16cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egtrWuDkRK9D1KYrCn91SktnxVCs7eFaSdBKsC7auV+ospNC0PVr8mAkGqR5oBBw6hWTMa5HkhFD+6e532Y0xI9VNYiWHx6w7twBPBOkqslrHy0P4bhMa1rKS2yYPTHMv3Twbu6ax/jzrTsRKpoPNcnI2wxFcPJpqSTEOdQtSS0AHrVarQybe4Mu0nI2QDCO6ioMrFMQ0cguqkZ09REDnWxFhtW6Xj6v82HRHeP7pjCiOjzgH+yhZu4FK0Ty5v0HNLoufgfWpZo3X3QF2crSq4cz2BOywa1obyVLtKNYKGAuy1hC1wmxz1oQj5YUl3UhSUvF6YgwiHw9Eu4cP0kJR0GJAdRlytVnvrGxRFQotFZP37xxGnnYh5sFtSXomvFe2RvD+XOgTgn3xO4lokT0sQ0OMtf9anyl8QnNpa1YJjizxcMgweO4bnl4SD7reooOlo1PFeIIDXAWJ79El5ZWCFb4Su6oj/zOrMdkYIl8EgboWab5r3k8r9OWzgRMhSbutq9nDG4d7/F4tnSz92W+VooPdwVkpb30PfBtMsw6RGquvp0sEVEbrszB95M39egmd7ABJMSQF7PonlgZ8QHT/VIbqI3M5YVFgTN1ip1OnG3RHjvgDQatyS5q7jhS4GZWmOhhNf0Lw8AGOkXRhTSA/lG+5qzAoGr3+C78gLczCHRehT8YYadzS7qLl6C19nG8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FeCy6xn+zIIi2qvQDAFM1XVDTf2aFSV79tXOO1oNdkl1wQFGMjZNzDIm2PjL?=
 =?us-ascii?Q?Q1rGi1BqvSHiIL2yWJLhO0tsm42oV6cEB3T5HKuTaPer52hW9wAzx33NoVbQ?=
 =?us-ascii?Q?yDVoSk0qJgjjx4y2ARhGWsvIt+j/G1kv/4UTCsV//e+H/p4tYw3SjCwxQvHV?=
 =?us-ascii?Q?hwH4m2wfDwthAaL5iRTjBk2rHX3BOolvkHQ1ily3pKkMXQCfVfUoDdn5zG3T?=
 =?us-ascii?Q?M8U72U+WSd8CK1WQFk/cuqN4uNUcdIWqrHsuRf+O8AHx0c7PVPa4c4pzQE4D?=
 =?us-ascii?Q?P8xFtPrFiScKXptkZx8/MXvsQpi9UVVYVrhmyqHIuOpIUoTnweyscIkSpkn0?=
 =?us-ascii?Q?fT4sQXVMe1bsgBQM6twNJVMlPtgm2CL2yk84KOg31dGzsKYFHRFGRM1sy6I+?=
 =?us-ascii?Q?Jb44W6Elr6IOXQGyFGxDh+d7+5SxrC45+b/464TXewKSkVf6FvJV4pFhnWIn?=
 =?us-ascii?Q?hr3e75NhbFtf3ttwVz0bAVFaGKlU1AKqLDDX5shrqbxSU4gPeyxrJfyvSiB6?=
 =?us-ascii?Q?bOUIoIm9UEIxTq0egYYCV0gOWzB/58O7NdwlT0M78RM98BqXXKwoeOk7hgBi?=
 =?us-ascii?Q?q9yPSOTi9DjusbpfsZOE4gT9g2WlbSPKx94SNP5mX3euIgQXPg5WKSMIsgoO?=
 =?us-ascii?Q?Dfp8A6OIptx0GQUEKOqqkVv+m1HB0D64TMiPE9Ht6QzZWG/3yJhbm7jNW39F?=
 =?us-ascii?Q?UXwM+15Uxxxyv2r80ewRqiL2FoVis9pXg9L/W6y1dSFdv5X6mTTqLqbgfyZu?=
 =?us-ascii?Q?hrqwL9IavcNoKBxp526aP6HS/pHEAOe1n3nLrwHkDIl6dK7wSZrrw8c6A+8R?=
 =?us-ascii?Q?NAqZKHi+KAVAluPWs+arSP7HIQ0lONNZD+w0x9qOybdgJ5Bu/fUoY99TxhEx?=
 =?us-ascii?Q?XSeEfzgYrnOj+IWZvp+myQsxrgtUqJPdnn+PVd1k5/RTor5IeJb7jTuGxmp5?=
 =?us-ascii?Q?PUghl7iCJs9T4jIKbcTVdUSI2sa6IUsD3GRpFGRKrOcx+DI9h0YWmFDB/FDy?=
 =?us-ascii?Q?LchGFCIOCeU4AggbE6yRoHNjIZ496yAdrxtQx+9wzwPoXJcr5iLx9/U6Krnj?=
 =?us-ascii?Q?DVnB8Fxuav1YAYeXzkobh3A6IFxyKICZheZmIsfHFPZBTxW85MEh8yt1n5dA?=
 =?us-ascii?Q?fOcMmgb27VVqy5dEan5rDmFsxHD6bm12FTk5SfUUWTcw7hv0clmWi33/i5a3?=
 =?us-ascii?Q?wEUwsuohJ3KvBVovo2XN9iR0Itk/IERGTAfGJY+PmyG+FFP1lqvpUCgsd9eY?=
 =?us-ascii?Q?suVHhzPEA14tpvc5IAT4wvBMG8wPCM8YAX9b/ivFuPFl0V0cIhA+bdLoOhMC?=
 =?us-ascii?Q?0ocf9DgelIWAazhs0qh54beIZkjn1i7DgpoVvxv/GrIzcu2+PhZPEtYV6ELd?=
 =?us-ascii?Q?yExuuIR0ksuMz5I7EB4oHIguX7WqtAySdKLXwNjA6+mTu0ozxhI6PY+NMyxi?=
 =?us-ascii?Q?2YFGYV24dIsiwRD17JDjfP7vtsyYzU/kBua+X7XjukF/E4kPBrOirY/KubRV?=
 =?us-ascii?Q?7WZh/wrjs9PUreyWL6Zzzb2Lxqp5rDLYvPa+tG1crXGxNaYyMeBCiVnTlTxH?=
 =?us-ascii?Q?T1taOyoxsOwO/e8YyhczE3JE+LgvNaYbJbLQn9lP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5606781-df76-4e65-16ad-08db1f6d16cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:59.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuMy4j6ipwRFpMIcF78aEUtmgItWvh2wuCskCtgpiLccq4UEsj87PiytDOuBxqj9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This only needs to be done once per group, not once per device. The once
per device was a way to make the device list work. Since we are abandoning
this we can optimize things a bit.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b546250dd1e226..4331c7a4e6831f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -315,16 +315,16 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		return rc;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto err_unresv;
-
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment.
 	 * The user can attach every device individually as well.
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
2.39.2

