Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF76A257F
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBYA2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBYA2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622375B96;
        Fri, 24 Feb 2023 16:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2CqrUUHy9FOdjURGHSuV9aNmtS7PzvTOhtVz9PkAgszsjLUc1N3T7xcumcGN7GJ6Q8D0e1hX8+YqN5uSEyVBwUzS6bMdGhAXHRqE8DtvaQbDRdC42Kilqih5jSYKiz9kecPgV5r0ptaPQ8Axr5rN5kRLKjRbdCqGi5aYdFnhHUD4mimBq2y/efY23qDM3604GytNThY8Tx7Ds1KS5lgceif/ahtCY+i5bnZy1aGwr/IHMMxTflox4JIELyuUNYHl92CnVO8Fdyfp0MdhuwxrzkEhihtr4Z01684K4HJmuxmNLpkcmolM33dCVv4kCgmuQXoJB1NHKdfA23tVKHqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGLJuCYYA1vnqsxOFyQDXK4MbFCoAqlxbAzGKOni9FM=;
 b=LwqJJCa8CW/exnEu7sKwKlQOULXvbZAOiHWd1kusyMxIYCgRSVqDrN50YogxZQMTO9g3bpWQxE6jjo1wHmG59pIWFGoHAVyzd8+hfRTECpYB7NJuAVkfu6Sk9eu6usU50Ii6lC0ORJRf/uE/iX6bX0W4qUSZgI8m/5JnnkNjdZmAw+pJ3PuDpgggW7Ide7FMZUiQ7+ht3ySbxSqaEZHwq/AZ6BjUNSFsllGaX+As3tmYaNHSp6NkjFUfXdsqma6jQVV3/zODBK2ljKDiWHy53xf2Ie15ec501NvJ+XGo5n7SR/C9ntQBLVuRfJ5h71/NkvguOA3wHAZRR6pk0qsZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGLJuCYYA1vnqsxOFyQDXK4MbFCoAqlxbAzGKOni9FM=;
 b=DVQsnOV1R8CK1Sjp2IPHvpCplcHWqzPhKPSepMcObvgN8zyxFhEU3TMBJiw6sDyrBicGeQucIgO933mRUymngeAzPV8opE663ocHM/RCxcaSCOLL2gU3vG+XdZ/KKf/x6OE+ZYT1GDgEqwyFfoXYNwifpU7PQl61vEzNAVxBGD5behGTL8ixPBu+eP2Cfe8wM29TqcKxml21Zski0vXbK8INP5LaobPKHoPE4pUJCeIJ8uV4vtUYn9LFhrFlWF6kNbpei673L550roUAmGHAAUvcWS85PXgSKDgArLwef6vlVfm1azzCr2N/8AmfM5d6qSzCUhJeTf7JG/adZ5eW0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Sat, 25 Feb 2023 00:28:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:02 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 02/14] iommufd: Add iommufd_group
Date:   Fri, 24 Feb 2023 20:27:47 -0400
Message-Id: <2-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:208:32e::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf8a622-4845-4bb8-0749-08db16c726e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2P4wI/fqPpvmh+ZylXdYixwiZ94/bXU7tiMhD3NGhzO9aPCi/DbElePKsZPzS6oJWGneqEB5dGQ++J6QzARqVh9TK3ds26JfyEMCjK3yC0O8eGPbobKighSIXwe/VkGZOSjJ27I91NPglpE6wrhUOTSP9JCfukObdBckbm5MO1RQtUXVKcUp6DBJFXETCB7j+U2cSilUWKktQTBuBtmrqmCzP9+JXlUfAv31fwdCrgd2kByExI5ggw28tCKu6SltSQ7DtoHOfoAXqW6c+uMkQ26gX7gvPwnlSAcvfx+UoisgWcgaA9aHCdyxDHIqdB5tOEjj4RoMXGXfDkw06JcgA2Q/FX8WVxR3zc6GZjkqEHfcZ1IuyqugXJwCyxf/4apoPseTP7GBVi9wb7bAIhfzJm8dAAIrjPEIVnsbeT0zeF49PRqTRnxI33xSWsfjesdgQohP6rGY3yhMkIH/LAWoaCuB1TKGe02JxR7oFRQCduDOiIzO6qvZjTVjfXxDUBzVavHMnTDTV64vn3Pzq68APkvLD2YsFgcc5D/LGd9nEkJsLXBfAQeH5EIHl2KDInaKa7eLJQEXsTJd/Vxu1G72Mm3yqneAs7w7B5L9Madc1ElGVDRWaFn/V9dX3adqU7S6mdKm4dTFAk+6yd5aYaQNeCDsig+x0PKfcWFMy4lA36oMQpFzMbmh5EC9B06Qn8C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(41300700001)(83380400001)(5660300002)(54906003)(478600001)(8936002)(4326008)(38100700002)(26005)(186003)(86362001)(8676002)(66946007)(6506007)(6512007)(66556008)(316002)(66476007)(36756003)(6486002)(2906002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nEgRVbTCqbRBdE9hztAMD4FjbibT/hkxuCxCZpiXhh4ReAlNXRhcumYeWSa?=
 =?us-ascii?Q?ARtUhEhHgyD7SZsku76G7zhCP8a2J5hVXcD4Njsyq42exdoFCTXjhhsmLvNL?=
 =?us-ascii?Q?/dQM9ZoCR67XFQ/YkPHSEDrGIBxph42tSJe/MOcm7CqfAGF5ywPgqdzCOffX?=
 =?us-ascii?Q?TBa+zSRzFE+0UPK5dWSKv+q2uR0jbdKizYt1o5kQYOI9lc+Qni0rQtYywD7K?=
 =?us-ascii?Q?h0sTZmR1Q0F4xjB+lxIFAtWEIEA1SpE1Nq0Pbb1ZPvdXyvJKTbOzvWckbPhB?=
 =?us-ascii?Q?aZwi2U53EXJ9on8039nYwO8xNxWfOMUybnRKEQ1MMZa+HD6D/4wuexCszByF?=
 =?us-ascii?Q?L1WbAadM3iUfd3hv/GEMQU8IJrqDDwGb0Yularhgeb+KqrVH2QcCfHREE7G3?=
 =?us-ascii?Q?JvvGaSzD+eJb4/WZWTm2n4lycxqgGTJGiMADua9C3+D0Ga4Lb25QNPimJLvE?=
 =?us-ascii?Q?nIJARacy6TsLIilU7X8rF2Ddc7xmLbw1q0pIkqVzhCFQZ7TeIm7q4JIbk4n3?=
 =?us-ascii?Q?q8fnSxoHnex+Rvj5YnqRaTaWiOAHyHO5OWv6kiSHNGdm3BB65aRIyVPWmLAr?=
 =?us-ascii?Q?47+mxw7oh/mB0ruNmihFPDoq1Yqe67lSPW1R2mdI48nFlDaSwIufZNtEQTKZ?=
 =?us-ascii?Q?96hNHw3lGZayPeDWW4ZEdC0XnUFhd9qFURfBRC5GhazpW4rbJEX6tWQg1LNj?=
 =?us-ascii?Q?lXzbKcBeTg8MwkQkGE2GmytS/jTpSoPrLYgCpIZVaZv8XiKOlXJ1DUs2ySN5?=
 =?us-ascii?Q?UCO4EzlInA50mQxfsfQ2mR/w6a+skMajBTJGVCAyBl42H+OH7vUGlWt5LKtJ?=
 =?us-ascii?Q?B7oym7HNlvTmx/hi4Bg8tQF5cxh8jSh/K1JVuvUWXPs3rEOaaoQIY/ot7EZA?=
 =?us-ascii?Q?pFo8h3FfMk5sP49muM6a8gsZOlhvsxvVhu+pHcGG3I8QHX3RWE7jpz6UVQwD?=
 =?us-ascii?Q?SGruqkr+bS52uLgytHyRXHjGQqFPyGk7qFwZzN1pssIl6o2O+u7cQ5k0YOya?=
 =?us-ascii?Q?dhS7jg1O9oxakx9DsxHAQZeJ1/G7OMHyCSPdJcmBsvt0Zw5wd4v2HsB2DI5Z?=
 =?us-ascii?Q?QTHHXZSA6nPNBIpRmPs6zAleQQcy6srMEYiAJ/cJMBapO+6tTkQBcDEjFXH0?=
 =?us-ascii?Q?kT3sMwz/4jd1tZrN42pRUwUgvt9+NGvGPTAEO/5WovfJwPZqSUVTmz4Aayr2?=
 =?us-ascii?Q?/1IIF1LlnFfjuFM5Rr8FJhYVZb18nrqc7xSPpR6IInhZH5tphmkMlc9NoaOj?=
 =?us-ascii?Q?ozuIutEDYJ9CtApHou3KGcziEfGklfJ/6xvekpy8+e0Nl6Y9Mo3Ip0t0Umfv?=
 =?us-ascii?Q?Y2EBB9qSplWFCYRThmEPXKqOYoosvk9yOV+t6C8zp3ff2dr5sWtlyoiiX9r8?=
 =?us-ascii?Q?AA0FKdlAcbXU46O7FqL8OIgrNWl0f+rHilT1UfDkK6GnbTc0sgAT+hhnPpZi?=
 =?us-ascii?Q?iQZigsg9GmW5qRQBRid/XE0K2i9dgLPwfY+GGhKTkC3cVA5i3SGA798GmD1c?=
 =?us-ascii?Q?uUtHqifBy3nAap5/DhR3XFaZ58hGag9+b9B0taSr6wK+kiKRFytSNIuKE8n+?=
 =?us-ascii?Q?LVosljr5oRegbmiWows2fs7TSIZsPxt9YqEGOWBN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf8a622-4845-4bb8-0749-08db16c726e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfMBWOJ/RWCTTNa1LsoQLjPdAMZ7IxjeVJboETLx9IGvcv3mzYlTJx5sgpFegSr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the hwpt to device attachment is fairly static we could get
away with the simple approach of keeping track of the groups via a
device list. But with replace this is infeasible.

Add an automatically managed struct that is 1:1 with the iommu_group
per-ictx so we can store the necessary tracking information there.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 128 +++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |   9 +-
 drivers/iommu/iommufd/main.c            |   2 +
 3 files changed, 123 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 63b65cdfe97f29..d1e227f310e823 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -15,13 +15,110 @@ MODULE_PARM_DESC(
 	"Allow IOMMUFD to bind to devices even if the platform cannot isolate "
 	"the MSI interrupt window. Enabling this is a security weakness.");
 
+static void iommufd_group_release(struct kref *kref)
+{
+	struct iommufd_group *igroup =
+		container_of(kref, struct iommufd_group, ref);
+
+	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
+		   NULL, GFP_KERNEL);
+	iommu_group_put(igroup->group);
+	kfree(igroup);
+}
+
+static void iommufd_put_group(struct iommufd_group *group)
+{
+	kref_put(&group->ref, iommufd_group_release);
+}
+
+/*
+ * iommufd needs to store some more data for each iommu_group, we keep a
+ * parallel xarray indexed by iommu_group id to hold this instead of putting it
+ * in the core structure. To keep things simple the iommufd_group memory is
+ * unique within the iommufd_ctx. This makes it easy to check there are no
+ * memory leaks.
+ */
+static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
+					       struct device *dev)
+{
+	struct iommufd_group *new_igroup;
+	struct iommufd_group *cur_igroup;
+	struct iommufd_group *igroup;
+	struct iommu_group *group;
+	unsigned int id;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
+	id = iommu_group_id(group);
+
+	xa_lock(&ictx->groups);
+	igroup = xa_load(&ictx->groups, id);
+	if (igroup && igroup->group == group &&
+	    kref_get_unless_zero(&igroup->ref)) {
+		xa_unlock(&ictx->groups);
+		iommu_group_put(group);
+		return igroup;
+	}
+	xa_unlock(&ictx->groups);
+
+	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);
+	if (!new_igroup) {
+		iommu_group_put(group);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	kref_init(&new_igroup->ref);
+	/* group reference moves into new_igroup */
+	new_igroup->group = group;
+
+	/*
+	 * All objects using a group reference must put it before their destroy
+	 * completes
+	 */
+	new_igroup->ictx = ictx;
+
+	/*
+	 * We dropped the lock so igroup is invalid. Assume that the
+	 * xa had NULL in it, if this guess is wrong then we will obtain
+	 * the actual value under lock and try again once.
+	 */
+	cur_igroup = NULL;
+	xa_lock(&ictx->groups);
+	while (true) {
+		igroup = __xa_cmpxchg(&ictx->groups, id, cur_igroup, new_igroup,
+				      GFP_KERNEL);
+		if (xa_is_err(igroup)) {
+			xa_unlock(&ictx->groups);
+			iommufd_put_group(new_igroup);
+			return ERR_PTR(xa_err(igroup));
+		}
+
+		/* new_group was successfully installed */
+		if (cur_igroup == igroup) {
+			xa_unlock(&ictx->groups);
+			return new_igroup;
+		}
+
+		/* Check again if the current group is any good */
+		if (igroup && igroup->group == group &&
+		    kref_get_unless_zero(&igroup->ref)) {
+			xa_unlock(&ictx->groups);
+			iommufd_put_group(new_igroup);
+			return igroup;
+		}
+		cur_igroup = igroup;
+	}
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
 	iommu_device_release_dma_owner(idev->dev);
-	iommu_group_put(idev->group);
+	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
 		iommufd_ctx_put(idev->ictx);
 }
@@ -46,7 +143,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id)
 {
 	struct iommufd_device *idev;
-	struct iommu_group *group;
+	struct iommufd_group *igroup;
 	int rc;
 
 	/*
@@ -56,9 +153,9 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
 		return ERR_PTR(-EINVAL);
 
-	group = iommu_group_get(dev);
-	if (!group)
-		return ERR_PTR(-ENODEV);
+	igroup = iommufd_get_group(ictx, dev);
+	if (IS_ERR(igroup))
+		return ERR_CAST(igroup);
 
 	/*
 	 * For historical compat with VFIO the insecure interrupt path is
@@ -67,7 +164,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	 * interrupt outside this iommufd context.
 	 */
 	if (!iommufd_selftest_is_mock_dev(dev) &&
-	    !iommu_group_has_isolated_msi(group)) {
+	    !iommu_group_has_isolated_msi(igroup->group)) {
 		if (!allow_unsafe_interrupts) {
 			rc = -EPERM;
 			goto out_group_put;
@@ -98,7 +195,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	/* The calling driver is a user until iommufd_device_unbind() */
 	refcount_inc(&idev->obj.users);
 	/* group refcount moves into iommufd_device */
-	idev->group = group;
+	idev->igroup = igroup;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -113,7 +210,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 out_release_owner:
 	iommu_device_release_dma_owner(dev);
 out_group_put:
-	iommu_group_put(group);
+	iommufd_put_group(igroup);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
@@ -170,14 +267,14 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 }
 
 static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
-					   struct iommu_group *group)
+					   struct iommufd_group *igroup)
 {
 	struct iommufd_device *cur_dev;
 
 	lockdep_assert_held(&hwpt->devices_lock);
 
 	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
-		if (cur_dev->group == group)
+		if (cur_dev->igroup->group == igroup->group)
 			return true;
 	return false;
 }
@@ -211,7 +308,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->group, &sw_msi_start);
+						   idev->igroup->group,
+						   &sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -223,8 +321,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * FIXME: Hack around missing a device-centric iommu api, only attach to
 	 * the group once for the first device that is in the group.
 	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		rc = iommu_attach_group(hwpt->domain, idev->group);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup)) {
+		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
 	}
@@ -237,8 +335,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
 				 struct iommufd_device *idev)
 {
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
-		iommu_detach_group(hwpt->domain, idev->group);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
+		iommu_detach_group(hwpt->domain, idev->igroup->group);
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index d523ef12890e1e..2544f10dae9aef 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -17,6 +17,7 @@ struct iommufd_device;
 struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
+	struct xarray groups;
 
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
@@ -262,6 +263,12 @@ void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
 				 struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+struct iommufd_group {
+	struct kref ref;
+	struct iommufd_ctx *ictx;
+	struct iommu_group *group;
+};
+
 /*
  * A iommufd_device object represents the binding relationship between a
  * consuming driver and the iommufd. These objects are created/destroyed by
@@ -270,12 +277,12 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
+	struct iommufd_group *igroup;
 	struct iommufd_hw_pagetable *hwpt;
 	/* Head at iommufd_hw_pagetable::devices */
 	struct list_head devices_item;
 	/* always the physical device */
 	struct device *dev;
-	struct iommu_group *group;
 	bool enforce_cache_coherency;
 };
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3fbe636c3d8a69..e5ed5dfa91a0b5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -183,6 +183,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	}
 
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
+	xa_init(&ictx->groups);
 	ictx->file = filp;
 	filp->private_data = ictx;
 	return 0;
@@ -218,6 +219,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 		if (WARN_ON(!destroyed))
 			break;
 	}
+	WARN_ON(!xa_empty(&ictx->groups));
 	kfree(ictx);
 	return 0;
 }
-- 
2.39.1

