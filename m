Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53CC6AFB30
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCHAgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHAgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC549CBEB;
        Tue,  7 Mar 2023 16:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/3iR3TuTPTIO20ft6JttpcTnOUpwxMHibQbUwl9ZVmODzE17BHxZkHxARWtHUiAnZW8eH4SmAHOYVLcEqp13qAdPmhTdHWvv501ZMVf+pkoh473svvnwdSAehNJqLwGjCDGHwTabCFJaqRAS6fOe9IdSehStZHrJtxCcc3Ydk1vSUuQFNQFPv1uz4l8E6zkKMRTakCncvQxH2lqlzax0e3n9g9rek8QbujwJkBxLDr3pXiZpJ05VvA+UqJllXON2dy48RGq79fenEV4uEo64mgdmP2j0ZYHuU3HOxMc4uSWusqcCfdB43EncmlPKNEQFfXykJdNwXsP90aupfIuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I67c8Nx/P56b1cVrMhLp2zEXkkfWcgqtbVYazjmWVeE=;
 b=TvsT6FZLNc3PAeAQoWTDjZ6ULkxu/iG7krCVkRKCgTEg4m70BzEBqz7zEfhQH9XQ/GZyRZ6TGZfl1cbzlZodfcQ/L4C56tE8i6cp2P9bN+MRgd4MndMGtRQ/Tr5DKWt6QflGJkspXC0dskMQ8vAldrznlz+G4Pybf5C47DcGerXDADWWxvRZsRn/5A3m3GDp/KW/vfC95i+812to05HTWraOg6inHR+jMc1BUt4c9Q2LcaQaeK2gWtom8yNPmmFKfbU8HFarq4sqeH56H5zfwA0vJRZiRylY+gjwGNb1YQ28Mw+h3WAtDNrGpZexE/AxzE0PHbXUxMSjhlf/eGK2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I67c8Nx/P56b1cVrMhLp2zEXkkfWcgqtbVYazjmWVeE=;
 b=kvOXyuofOt2E6FwmkYIXCHBPg6yTHEtEEpQ+1G53HJBRMLF4xfkbhHhhb/oq4gAJxVCEL9RKbRuIXa3eQG6Nbi90FhrNYLpmJI0Gtaq9y45uYdZjBQOX2+B0BMVoC1t7S3kgL1ceiaweIsw79imUr6exD63BmuXWzTNVzxtwoc/pD1QqjeGcQCqv86sWE+H91IJo721czQ8tQf0JvXOiOMMvbJoJIWi4gqhqT3jHT/R9FMBypqDlpmLgvBc3TQHKVOuRQeiuk4GE7EK1npVxxpPeJQyjfAHNqvRHOSJyjtf7G8uSvgW2VRzarFkcgYKnJxh0bAyclUsYwLKAkR3LXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:35:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:35:57 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 02/17] iommufd: Add iommufd_group
Date:   Tue,  7 Mar 2023 20:35:41 -0400
Message-Id: <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0247.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab70f60-0cbd-415c-6b8e-08db1f6d155b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeIuCKL0ppEMTTqGklo2gIeRs6Gx953WyejDm57C4ZnWg37V933OFi9CJfqPdZEmRKviFatFHesU8tg78YinPmPxgRi1Hidg8K9M9/rJNImHJJoa58uc+N1L+l6VSto2S/GBdHFtVNctfP0poMBpBI1XJwmD48SQtlSPXtmAT0kKr2qM1k4SJzfySG069wd+5jESnoDUzf7R4BYh3zSPexHlD2NK5PBOyF3OyiTZSo5Hs3xa6nsdHpGiNI8dQ/398v1XQXCpgYzMo8T/6LHzeShF7MWW2TVzx61nygzCKA4pA7jsT/MY0MGm9Ldk0cgqQ8IR3mZVJAzEYxg//5oz+Vv8ugoKAHfsyxxv32qWvyD7WCFV59appe46041riW/wXoCNJLZ8cAZWY8Ek/1C6LJuulQTl6C2WrkAxMMpDWqBh1b2rSkd9LOxy+VWVhx7TfS2gTQZSRRfjoVr98p/HXPF+tQSmVhbJSFw+6KQW4h/BEgpzs5/cSGPMxOLiwRUXGngEga7Cpm7ehBzjAUo3+i/SyA+Aumhmy2oaTyeiwJ7LcDI2ie4XEGjGNRAI2BDWTPu+D42fCHlsMJpBcIAlON6PAxytli2wBuOdwutGSpJgPdoSd8wwWqHMf8txT4RHAcS8aIKIHGZAqpdo0eiMBEZzLgP5yzIsVy8zhWtcbOpYt5tjz4ua/MwygYGH9pXT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TWdLG34fiwS4dII5RBcyXSkpNG4NLjtEF6klsvd5fWbNNhPdQqQ9cFJVQBsz?=
 =?us-ascii?Q?CdO2mFbMtGV2XosujLuiry9n2DURh57MavGVFXI4nWWSz2fcarMDEVA+kBm3?=
 =?us-ascii?Q?27HWc+wCgUEQyahyDXILoD1cScLeUCcmBEfUmudZ/cvUlg03A0TVCXK9dFuy?=
 =?us-ascii?Q?yXxeXj50RKZxHb1SSaZEOa2Chu8U5gPJMGtUvdrQ+nQJUS+xC4xHyFRjI44L?=
 =?us-ascii?Q?JkAEPy7fQvv0ya2zwZ6Xemd9knjt/FezRu912TOd/8O2kY+LleKRVmd5ovZI?=
 =?us-ascii?Q?CuU5D7Hcq1S/Oraycp6A4Mjt9PrfQZFZuxG2eFxyF5OdKW3VKImfQ6oOXHLF?=
 =?us-ascii?Q?HoexR1jjCNGe0spVkNGTyOO6l/f0xYOzoLstD0jyniblobs1l/BMdp5xIYOh?=
 =?us-ascii?Q?/n+mFcfFXj0R3u/Sdw4KCykVQurwgwOr5jj7/V3x7ZfSKqoGDogGodTx00Vn?=
 =?us-ascii?Q?KPfAfBn358wUC6H3nZl52aoExSJf2OkhBa/cy3DQxZSdKiKKL5rQXYHb9rXK?=
 =?us-ascii?Q?O2DGHJUKBuvryYyTtys7cBxL4Yl3DuI/G2PmMwlU/1vIoOeOs6QzdA1dt3wl?=
 =?us-ascii?Q?6VrMrGD64CggGV1NCdl8hQvwN+0LCpmnQQbLgvqSjG7S8gwMRQfl7v0nzc2j?=
 =?us-ascii?Q?ZfYuj8ySMka57xdCsHPz/C54lQ0Qad4scDo0XMLODnd9Bnq9m4fUYeC5UBD1?=
 =?us-ascii?Q?JUTHQXfPNvYr/3QG551nt5+5FWLwOGkbxGtbnmD6bnmuO0fVPJJYWyTd5RzS?=
 =?us-ascii?Q?5bLnno7vznNJfdCZ0VbYvKtMkq+NeXfvjM7+PPgOOKQ1N8jZyRNp+N88ERD4?=
 =?us-ascii?Q?dAHnAR4hbg0pc8pP2+jir1SFqHqfpcEP8OQegZkTIVigp1If/8oo4OiHGyZP?=
 =?us-ascii?Q?3rXJOz1KRGLAjbu8uxLQulrSdtvpdU90NGi5wRNlzFKN9UPueWESdhOzK+Zc?=
 =?us-ascii?Q?K1aHwFVsihwkuESQ5W3es3sCzwQo4sss+B9YVeP3HW1X6mdMfNSIW/iYm56Z?=
 =?us-ascii?Q?OHdLLKGkAqt/CTU7QW63+7mvNGYtQBbOkr48oqoDoyhh6hBxMYfMepChmsud?=
 =?us-ascii?Q?Aw26eZmsGplQfWyqRPfKlpxp0J+8P9Wtu/YOR5T15HnoBgaUJuqpb1WtRp8g?=
 =?us-ascii?Q?ZGf66fLWJjvZOtJxhAFGnAvZuqfMDpn5HGLye89/YweCnLTJYF4D64/ocuMB?=
 =?us-ascii?Q?CwzoQY591cIbZa/9O816qHEEg4sRtordDlN/h5Dm8tFwbgNkoHxTa+vqDFMU?=
 =?us-ascii?Q?lqnpQEUTNAwIQqf9i6UWWEGlEnXLPbmNI6WGKOY0BxIzb3j8iQQnpsyXiqNJ?=
 =?us-ascii?Q?TYnzyGTOk5xlMNAFDLe6FncmiJj5uxrVpssn4+bpf0Wl3fC099IxMblFPxQS?=
 =?us-ascii?Q?JQFSPxhJ/qf/gF111tCMaRLl5WSQqIigCoge3GTyvpZPQypJP7tdiIYj+SF0?=
 =?us-ascii?Q?uKDDDEKP634LCE+lqJRctJkN59pj0GvoWfSqAjm46WG+GTVNUTUhnISORfKd?=
 =?us-ascii?Q?hv7ZJs5u1TRSBQTFVsdaVaHlFcZexfyyzzsyIcXtFpoNG7Wv5wlMA3ytdte8?=
 =?us-ascii?Q?QX3NE5s+xRbxCmrOkz0p04LjqRGLshfo4TtZ668o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab70f60-0cbd-415c-6b8e-08db1f6d155b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:57.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QB536dL4nw2bzdppX0l4V7YsODIzKuXbba7XtEdYmfIQteJaPQv+keU7Yc56nu4
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

When the hwpt to device attachment is fairly static we could get
away with the simple approach of keeping track of the groups via a
device list. But with replace this is infeasible.

Add an automatically managed struct that is 1:1 with the iommu_group
per-ictx so we can store the necessary tracking information there.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 141 +++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |   9 +-
 drivers/iommu/iommufd/main.c            |   2 +
 3 files changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 63b65cdfe97f29..71dd9c7bed48f4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -15,13 +15,121 @@ MODULE_PARM_DESC(
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
+static bool iommufd_group_try_get(struct iommufd_group *igroup,
+				  struct iommu_group *group)
+{
+	if (!igroup)
+		return false;
+	/*
+	 * group ID's cannot be re-used until the group is put back which does
+	 * not happen if we could get an igroup pointer under the xa_lock.
+	 */
+	if (WARN_ON(igroup->group != group))
+		return false;
+	return kref_get_unless_zero(&igroup->ref);
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
+	if (iommufd_group_try_get(igroup, group)) {
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
+	 * The ictx is not additionally refcounted here becase all objects using
+	 * an igroup must put it before their destroy completes.
+	 */
+	new_igroup->ictx = ictx;
+
+	/*
+	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
+	 * value to assume for the xa_cmpxchg algorithm.
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
+		if (iommufd_group_try_get(igroup, group)) {
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
@@ -46,7 +154,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id)
 {
 	struct iommufd_device *idev;
-	struct iommu_group *group;
+	struct iommufd_group *igroup;
 	int rc;
 
 	/*
@@ -56,9 +164,9 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
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
@@ -67,7 +175,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	 * interrupt outside this iommufd context.
 	 */
 	if (!iommufd_selftest_is_mock_dev(dev) &&
-	    !iommu_group_has_isolated_msi(group)) {
+	    !iommu_group_has_isolated_msi(igroup->group)) {
 		if (!allow_unsafe_interrupts) {
 			rc = -EPERM;
 			goto out_group_put;
@@ -97,8 +205,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
 	/* The calling driver is a user until iommufd_device_unbind() */
 	refcount_inc(&idev->obj.users);
-	/* group refcount moves into iommufd_device */
-	idev->group = group;
+	/* igroup refcount moves into iommufd_device */
+	idev->igroup = igroup;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -113,7 +221,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 out_release_owner:
 	iommu_device_release_dma_owner(dev);
 out_group_put:
-	iommu_group_put(group);
+	iommufd_put_group(igroup);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
@@ -170,14 +278,14 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
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
@@ -211,7 +319,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->group, &sw_msi_start);
+						   idev->igroup->group,
+						   &sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -223,8 +332,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
@@ -237,8 +346,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
2.39.2

