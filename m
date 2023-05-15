Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF18702EFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEOOAm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjEOOAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4920AE77;
        Mon, 15 May 2023 07:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YReaI8Co69EyifblO5GGDPhGmDUvA1GG/V6yxxX6gOAk/kG7c/kHhkynHLsAZRMQwnfI4/27qwdKU2RHN6XAuofxYhwSSzJ797cn4ctUdyXJ0hC6+AlZTjfuT5rJe6woJjq+AmcUYkG12KfNDb5U+1RUb2VQaoC4q2zQ0tRGSItywGXisHZ5qrMQUtivPhtVZfXp8lQ49Y9JSDlYWFt6fT7MVmrAy7R/wKJffoZrNcgAz/Nnq7wBqD+lOysxcrIRH3IemhtbgjgM5fQdHBD2/FHH3XgcNrpsDph8duLWYh9ojClmSKqxQslQ9qv1e2BwVQDF+ajBBeFXgKBllq3eIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4MARGRQd0uszpmVggCVNaleQxuaE51CvkelLRtqix8=;
 b=QFOXLBZet3d7ju8pJuZsuTRqJcGl39tziW/CK7g5rM2I0jZbDjH9e4FEOwFiaq1iiP6uW7QZ+s3gyVxaguuewxj8nfG5CoCyvMuln4P5cQ9PnasZxUeJKaGAnUgYLzzZWMUIPPGbtuY4/1PgANSJ9ajYyVPlo+vOpx4WzMG39mb89KOffgv5bIjFqG63sf1LWWzc3rnC9wDV1R2k/31/AKq3IuDOzQd+5uVv4sLnyH96cuPj1Vu9ygL8IfYPztYqba8AKC8h1VpZ7F/Jn2U8ZULAsiYlcxodVrhEBtWXkoN2K1OyXQpYhQEK8aCxrj3o233PsLsAkf5VadQpDHw1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4MARGRQd0uszpmVggCVNaleQxuaE51CvkelLRtqix8=;
 b=T97bWZYO9p8Szwc6AonGBU+Q7OVYizIPyTAaQ3WafYVPajtxcaiVC/8WuRfzMJMgon0ZZQGXgv/Ej6tMCBsJs1BeoLpMq01m3kZXWxrHTQOi7Js9Q/PnD6t1DTl38qL1ym/DFNpXd01bBB07rkgL+HerTbfxLcCQI574MG61cDcLvUISLbJUwKt++T+kk7PZ8IC8W4aj5PQyY6SnZejFr7hMD6AVVesfYwcBCAypR7b/7Znr6LN1pUtXkgYTESvFx/azzdBb39Cuk2Lzn32Qt29sci/LlRNnkNoGkLEVTo7L53wXsZogrVto17dM6fwjb++fNz/qc8hZaZVz46ChZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:35 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 08/19] iommufd: Move putting a hwpt to a helper function
Date:   Mon, 15 May 2023 11:00:23 -0300
Message-Id: <8-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:32b::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 94df2a80-310c-408b-bf0f-08db554cc124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dj9XEuLvzFDXwMS+7b5vMUJtjvZs2GyxxtXH0reAI4/IB0+ipoo7kZRnEXoEPBLFIDNDvpru0TV/GDqUYs5kIefLTOjQQuxDxzJ7Jn/O4xiO92607hVu5qCUZ1+A6ORmLW6YAVekGW9gGXCsHJF++qf+OjIWHBUMNRv8A7Zerb8bJH7HpsjpeJyvHjujUUZNION7KCXYm4lyVHAWUkTXl6eDbdYgdymAj3PVcu3i6/YRpE6M32In1PZbtv7fejovYjsiQsKimD7PsaIO/zOoOXiZ+iBTlAjpZHgiXXe2Vq3AE+z90gclaEXBdtZYhEPhRGPtzWfgN2Y7d86pn46g4+eZ3xaOOHKYxn3JTNhwIy0NPpSa8O1dGHKthJow+VvSyRmx2g+UJFIR8p7qvJUKccw2FRTb5mCh0s/ZgBF9ETgbwcOg6w7Cd3QOLZ9X1tVrlbNIBpPkZCojzSdhXkTOkT2h2jxZ9xTI+o/ww5t/g6ANS0gFLxbV1hXqseV3rfLp8LT/nZomGBfdudtBagJCo8ouNNOow5mRTWKbfEc/aFlHO4REPbRvrCbsjcxJXx9tqhHu4OPH/LT9O4oS0WuZLVY9sIZ/ijKRpAtFlNZdoTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(36756003)(86362001)(54906003)(316002)(66946007)(66476007)(4326008)(66556008)(478600001)(6486002)(5660300002)(8676002)(8936002)(6666004)(2906002)(38100700002)(41300700001)(6512007)(2616005)(186003)(26005)(6506007)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEBn1eivR5YQpWKRDXZm+iVczVesSu1xie8RjC1ByVsNXY32Wj73Xh7QSr7R?=
 =?us-ascii?Q?PhAfapCE1rOwDkw3b7iSVo3Cj7ISiaxsha/2XYYERs4rrUv2k8zoXUyIS4Rs?=
 =?us-ascii?Q?GD0dpukZdgkb6YCfuMd6V/FuSN9Ess/wIRq8tIjNJYsm+IGo2kKyxoHaqs94?=
 =?us-ascii?Q?CQoUDOiuTO/kfF40FO5GrcdCAP1sgFtgiJzNJBjmRsGFYbND/xRJWzFEb5pE?=
 =?us-ascii?Q?op8HZuBTEy5PnMYzIIrPSYZ8+HzWpqvxKLsEuAbRyNtxagWh0vKIa4LvFqfs?=
 =?us-ascii?Q?C4afDMIzY0Arpw5pAxyZ7gEyrfIxQKED+xS8+3Gd+wGyRdi1xj7KRbzN2tnc?=
 =?us-ascii?Q?f/Vvdx5rEBHnaUSB5NlWHZcAkvaBUfaa4MNw6a7x+KWT5MRtOE/TsO8+sYKz?=
 =?us-ascii?Q?4fiTk+bV0iMsxNWd3fQ0BXRDr0w3jBP0wST4SDIKKLJaDGQc8M+pMJD4G3on?=
 =?us-ascii?Q?qbSyqJ705ePQyVodbh038w3/AMPXxTfxqVwk1X/Y60S5BzssAjwyIpM9i6fJ?=
 =?us-ascii?Q?JsTOIuYlLiTt36yQkL4wUgtxv1ohAiEwZlAdmcj22zSTReFMe0acZoVqQ4/s?=
 =?us-ascii?Q?v2804OwHQ0E8BtyHNvi8EWq/2ErRUzMcq2h2Iokv+KIQY0t8ut04hY8Pc5Ze?=
 =?us-ascii?Q?JbsGQ8RXEaUBXhIiQMjiPYgX40NHiqe8TRzIJb+AX2bL2xxLeJkQTvQVkqWJ?=
 =?us-ascii?Q?Xr6L9OQDk5e/BOGMXG4ZjrTaa3C6riBczjCRsMtCe716QSThlc+0mjleIiGO?=
 =?us-ascii?Q?jbEcPQ024Q+B1+tNn/950zOzogbpip1yJfbJ38kmtVWKqm3kPv0mCNhj0lNr?=
 =?us-ascii?Q?rHqrXWNKwJIrFaIRzOuuEpTFizs5OudJx+zF6CTSIJ5vAp4kgGux+vQzm/S4?=
 =?us-ascii?Q?X7iAl1e2d6KLI/zl8suepEIrUZQ+sMwsg1Gv76Q6stTlxS2DoH4zdDwfqOBE?=
 =?us-ascii?Q?2WzZhDwzbZGAQ6ljhSFGziC4XsquH5YZ+fLGohCs1ix9MRQ9/M8y21Cf258m?=
 =?us-ascii?Q?1VR3J1C2oaIdMuM2+Ytcik1MuDGFiwITHg2MUcnpQaljckIqgTG0grNdq9SV?=
 =?us-ascii?Q?Qb80XBWuHTf2yqaHAF75mit7v8seHtd4GLtjkdj7UY2nx8gCQ+VW2u8D9xTy?=
 =?us-ascii?Q?GoUYtVEHg0Mc8HZ1n0yLxrRF5OrXRT50dOe14WqOQCw7RaJkEEZBa/Volruo?=
 =?us-ascii?Q?GGJnGJtPJVf5cRxE4JO2LPB/vydGyedl7xKv+VKwIEHBTC/+WW4JOdZ5BOAn?=
 =?us-ascii?Q?iMzdAqDsicGVoUHwaW6Re/B6B5ZgIEvEyc2hPQkGTfeDMkhaTpmsFW56Vnvp?=
 =?us-ascii?Q?jz9i5GDKzw4SMUxsiN9D7iayQ3+0YtqhtBTRCWI7lUZQw3YZnaIg1p1wRJ7R?=
 =?us-ascii?Q?uxBhqqdt5lKrDfa6jTS3gYHDFwiBaf4LrAZNst1q2t4K3Al092yBU1ih44cN?=
 =?us-ascii?Q?AWGq3irARsxmfcxnIqVqBWI9gLJHsfcM5hJxaJY8ok48YWMSbdLJ1HM6IRF3?=
 =?us-ascii?Q?oPNUucAImQL/fDq+KJgqfXlrV+ONneme29BlLsK1F/9i6kSLXWdNmoss6wJo?=
 =?us-ascii?Q?Dovje1u4ZdzGbomaUDKIFnAVpAWRBTzJVF11eBA1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94df2a80-310c-408b-bf0f-08db554cc124
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5mXQ7ftY7bhzqp8kv26JFJ6aayKWx0IgI/hecyNQQSMsU1NCEOrTg/pRcmKFYqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Next patch will need to call this from two places.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  6 +-----
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b6bf447a6b1752..69536f6c7be832 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -483,11 +483,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	struct iommufd_hw_pagetable *hwpt;
 
 	hwpt = iommufd_hw_pagetable_detach(idev);
-	if (hwpt->auto_domain)
-		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
-	else
-		refcount_dec(&hwpt->obj.users);
-
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ede238908e7b3..63b2587a37f23d 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -260,6 +260,16 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
+					    struct iommufd_hw_pagetable *hwpt)
+{
+	lockdep_assert_not_held(&hwpt->ioas->mutex);
+	if (hwpt->auto_domain)
+		iommufd_object_destroy_user(ictx, &hwpt->obj);
+	else
+		refcount_dec(&hwpt->obj.users);
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
-- 
2.40.1

