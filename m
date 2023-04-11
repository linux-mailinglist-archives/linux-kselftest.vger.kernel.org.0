Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340316DE13D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDKQnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDKQnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E80C49F8;
        Tue, 11 Apr 2023 09:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvmY7uhMbucHNDo6wmCm2ThEDg67K6pptOqPjZJjB+CW215lXixjsajGPj7QdWsKSNeZW3mavm8i3zZGpSbqALWWl4PHN8uZ6qbu2mRrs3IZIt2v45JCI81RpDHcxkMYB+gsbdgQFydv5avGhxHj/0yXQ4YR5npXo0w9Zsc3aGKc4bCuySfKySBV0xdPqoyiw4JZvRoB57vcb3O0bX/aRQvEnAFbpeVUtHKENmttikBiIIfzMkWzxwACAAoaBcjXdXqlYlqAf2tfwF7QCwF3kfkrywZswcPtydM99nCyXvWSxs6hBDswe58m5MTftpE6xIBj3j5UPon+ezQsOvvf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOPaiGig87vimgHT+ArD1kqF9Z2jpRmES37V6Tdvtpg=;
 b=RkDQNgFWZpKnjeYMA2URAPDj28dvEW2OxXNhqWXvbo1ewmBFwMay0FWHIBYoZKVq4QP+LtlUs+KDuViy3bMr6HojeICRYQRwsQal3f5sSu6tCmUxuGy7YmPFDk3q22VtuRywOHIJdPk638ReM8aJ0jkknZvGICeP/DsC5DDrDr4hgl8pigcR1tvk+c4bm0+Ue0t8S8vMiMP/ZX5E4RNxdmuW424RSBDA6IHyREJIM+9rZV7HC0nBarWqH3xfJ0dcevx+VavI0XMvYmxPBHxv3g1BiRM3SHzIMf44X75U80/B9lkPXmPpcNu8JdHTScPFFRCR2gzIZOmxXOjzzU+Egg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOPaiGig87vimgHT+ArD1kqF9Z2jpRmES37V6Tdvtpg=;
 b=rqdXjQkpMjTPp+G4UDq6FChbFsBSsQxfSHFOxx+XgH5uLeBgQ0H1eJBwuhq2Ic4fKlzbsX+m9SSlopwNbGQLruPj5ILC9WKUvqsejm0tSZBfLjd3x9MQ1lJ0ifM4hVX9fx1SGz9fQMNfuRINvsB7ujgAezeiwcqhaC1/seERNHsU0J9ZQ+GICALHKZCVgp1Yjf1Swwt1lN9LtqR9tUcf4wg5owELuPuGSzFes3Xx1ZZrDU9DEqY1hu8eNommqxL/3uEvJHR904tgFXVe0PT6rnP0fyP/+euJpACqPTWokkVpfqaO4xRA1VVq9qUoJ75yEj2xUzmB60TjImPcoPH4Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 16:43:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:26 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 07/17] iommufd: Make sw_msi_start a group global
Date:   Tue, 11 Apr 2023 13:43:08 -0300
Message-Id: <7-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecadf78-26f7-4790-3956-08db3aabdea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UoRaL4kEczwbM3Iya8pVAALyFl0S5Lu8qGe35lKGkPpp/nECvdynRuMr6YxzQHszHAL6/CgHNpeW0WTghHtuhgpj8vWDveU9l1W/2rmQF0UMKM1hdyCmDL7K2MiFhils42xSDpp2m4676P0haZ2azj5eyjPFYUinLzO3PxlaU0UsFVkOBncLTSig+n7fBkcaQ/Qm3jS2s1E4Ro6NVgVumxmlY0Fiu7G9/kRPtPKiRDDqUOa0MAA1ugQdfhSmpZAMkX/b11SA4LeEm/dhv0soSzekYd+9TKK0nlEadfqFeQDLvHamnlsHJkPzRKAiZwJ4I2UpQQTOMkhXyp4IOFe1Av2Lw9Lnx6B1Yd7XogzomTBG5CSqPkXUAUrV/6l2z3SitXROglcc4d8Jx9nj7G6yqFQfdLcNAoKLwA1kAtincI5W7Z4aafmMBaODHvbszjOYIFr2M94/Qd16aeLHdA4uD1oJJS6g1N3u947Uo9guW0vPXP4KGn4EPn8JdXPjecitqTI4bBJWZXSRqw+WKrZrY1PP3dRcoc84lzb/VEvXne7XtdB7YbZqbXR6HiBV+Bg2QDHN3/MnqcGRCxqU4eNWTLmejvn7Ss9EKYjBDjomH04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(478600001)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6666004)(66476007)(6486002)(41300700001)(8936002)(66556008)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBhr/1Bv+fWcDzejgjViz3a8d31EePTlzfnzcB78pL2APIpVtJfBmmBmzASB?=
 =?us-ascii?Q?j9gwWBYB0GFGiITk/zJh/CD/PYSN/5z22QTiXqpNt7S6We/c3Lg5/a7/22Cc?=
 =?us-ascii?Q?XNrX0g9Q+Scrl1c7DsU3Ne5wn6EDQsRvgccnnlMhGr07FxvkDC//MhWSqj1c?=
 =?us-ascii?Q?XjPxWxeZ+vLDl8FQRfIqjwUSQU7eqqQAFlZkj3tz+BXxHcql8ltwZlrZHBdy?=
 =?us-ascii?Q?ut1qDvZR0S6Bn5WGsQDe2bNi5bwKilyG79A+364617IdpdURl7QtEXPcFPH8?=
 =?us-ascii?Q?++vuuAIrDpOUbaRODo0EG1/t4w7eaIG3jIOhmEyy72Igq90P1pLLJ0xyoVtp?=
 =?us-ascii?Q?PW6CXOPSd9q6ahmYLDiO3G01goMwlxGvQ+6w91M++oG8yHHgWRoMJPa2g9ly?=
 =?us-ascii?Q?wn8k/qySMkeg/OyUFz43wSOQJZyk/+ij0DSOrHfph6c1vxyPt23imH9OxEyq?=
 =?us-ascii?Q?Nku89lgvUdwXm/pw4M+um638NgcwemqU8u9I6E8ix5vVAOCS4+fw7CTwlYoh?=
 =?us-ascii?Q?rGDUBp99rET7sJOpQroYWb0dw9xyM08ffLF8h+BUJQ82UMwwDkob+VZif69G?=
 =?us-ascii?Q?iUZ6yXDFLEsqMESd1eDM+TLBKdXsR4rXDbquX5DweDkEr0v6WiRW1Nw+ZGDp?=
 =?us-ascii?Q?f12a8jUs0J3a8t/ywwn1nWOzNP7q6cfKRmXAKXOI9VgXCTWIrvxUN2eoovV0?=
 =?us-ascii?Q?GyZnPvz0skkF4HLqsAcXV2gEKKj3GWJ4ON4v3uGIIc3o/x77whQUoeVCfctO?=
 =?us-ascii?Q?PRs3ovkpiFR1yTrofXUESrCLqq1XxDKcsPdwdRdOfpDh4wv4MtaDoAYFufAR?=
 =?us-ascii?Q?A9gpaTbvKPb4+RNjV/5ORP90WJWjQT6mIlutseLSxc/OLDltnXHIPtOtsj4o?=
 =?us-ascii?Q?6OxGmx8vj4sLUoIO4LpdXqDse3ui7VB5vMhPSPf/xl6IH5ZDa6Ep5O3q9COb?=
 =?us-ascii?Q?ZFymYllM0O70IqCeLzBUtFJ/8HCGC4n9Rp/GW6T3/0aqG5RRHiI75XJzPFa8?=
 =?us-ascii?Q?Vm1rMcZhvMz6mB95dOMUMlFN2LwvVtb5K3eeSPQnPgDrYRUgWN64htJin7nG?=
 =?us-ascii?Q?l36T6NsWhkOFJDsiC36jUZKw1tLEmGNuS84NZhNvuAFGr7DZ8eEBghaq+4sc?=
 =?us-ascii?Q?kL0VDEahY51WwSO4BI/j5NnIW26wi/D63Fcvdt9C93rR8A1iQ1rzWsfVVjKX?=
 =?us-ascii?Q?JvI4JJFud1yis1wWMLhwDBBeyRn3G1ssfpzXAnihUlCSoxK3DZ+p4Y18Qxcf?=
 =?us-ascii?Q?Mjo9qyzIe5+OeuRjZ66yoEPaJQHrEt/AZ8EpuQPRPpRooYngO5MJaLzTWoKw?=
 =?us-ascii?Q?QBpML5Wlz8JqHjKvBRHDfFAPMqB6ofd0qh9XHv3vzHv0sE7ccZoIb7oZ8N51?=
 =?us-ascii?Q?5M3tsU/bETv6H4RFvvbWXBooufzdSGCpNLIsTXM1FD14zzzrxQw/WYUAG9L3?=
 =?us-ascii?Q?d+dsumDq4T0a5qzQLaXh4/6g3q0tSndbGoo/uy7GRNXNH8c/Z/0nW/n2uJ8z?=
 =?us-ascii?Q?LN6ocTconcuw9JJKI44C/uiyFEhav2BnYVPDWdVn7aj4U7t2cqiQpgSGyW6H?=
 =?us-ascii?Q?sffBmZb+ujlPakSCFpm8npUYmKERana3LuzSMzsp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecadf78-26f7-4790-3956-08db3aabdea1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:25.3470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQiV3R0FfY3xE36akrt1cUICErxjduFfVy0S43EwIdMfwfDNEluw/Qa5SzhY5stc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sw_msi_start is only set by the ARM drivers and it is always constant.
Due to the way vfio/iommufd allow domains to be re-used between
devices we have a built in assumption that there is only one value
for sw_msi_start and it is global to the system.

To make replace simpler where we may not reparse the
iommu_get_resv_regions() move the sw_msi_start to the iommufd_group so it
is always available once any HWPT has been attached.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 14 +++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b02f98dc02c284..b828683f4d45a1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -88,6 +88,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	INIT_LIST_HEAD(&new_igroup->device_list);
+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -249,10 +250,10 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
-static int iommufd_device_setup_msi(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt,
-				    phys_addr_t sw_msi_start)
+static int iommufd_group_setup_msi(struct iommufd_group *igroup,
+				   struct iommufd_hw_pagetable *hwpt)
 {
+	phys_addr_t sw_msi_start = igroup->sw_msi_start;
 	int rc;
 
 	/*
@@ -285,7 +286,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	lockdep_assert_held(&idev->igroup->lock);
@@ -310,8 +310,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(
-		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						 &idev->igroup->sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -323,7 +323,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
 		if (rc)
 			goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 22863759c3bfb0..7f4936cf537be4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -267,6 +267,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	phys_addr_t sw_msi_start;
 };
 
 /*
-- 
2.40.0

