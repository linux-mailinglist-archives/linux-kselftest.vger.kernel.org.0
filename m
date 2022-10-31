Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FAA613AEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJaQBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJaQBL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 12:01:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC64EAA;
        Mon, 31 Oct 2022 09:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1zsaFd0Xwm+qWYzp6pygdbYbzUjMnCUNx3mpufOV+lXqSpkFDkgsinO6HVcWrx+IaAoafWtteaiyJSfgW+mJdtItK64xe2BK4i+YnEHD+91o+3+KLKDrJB0pOIKYMGjdGxq/DDNI3vyyraZXbZT60tb4OLuVBlIX7nAV75pdcwWxm2RD0rydMFcoTc19Le6reN+PZ/eFG4F0ZsLIjHHGO5F74u3zSfSqzLqO7QV1Ce4/ql1VK4QpJObCLhDYXLaFWXerh00VrE3Cx9AXYifXL0u6SyxgfJeWWs54K056c3cTZX1vmW4OSqre8krelzsnweS/uKMH1UyTiEyu0TYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjynL/rs7PIfjrgcK5Uv5Q/Y6hx3EpZXD944t8rTKRQ=;
 b=DXr/+GlSRAqulWjEFzaauKa8GYNP4+wX0TgyiU5m4UdC4vUdnKm0rTXLf88CPOQMNg8c4RhY0XUT+AqbG/6qrOWNEY5D82KVc9sTb3MKpjBqA5LW8Qlwyed1qpqSBTEKiEvttaWVrV4uOSMETDfeKig37qeHPT1p6RIrVS8Qx0IG+iyOuYJ2k90F0GolXAu2pqrAVPHhwrCWKKfqPE1bOekUVoQiGjjx0ukiUJFttp/t09stu7Fhg8KJEaLmvlYzy3vCSZmhzgdhDyVxnz+bnorMU6dwIaQM5lP4yyhFtmOmn+jbPxoLM1LMJr4S68Z09U6Ni7HNvenzn2YjZo4FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjynL/rs7PIfjrgcK5Uv5Q/Y6hx3EpZXD944t8rTKRQ=;
 b=psk16E6A5p4aOW1bwljNQvZhiio7i85jy0srORWWwzXU3QdsYlM2mSPOBzEwvRxZlpDkSLi5BGoKQjO4/Q2Kcarw536hWhD+gbfGU5Q2cysFGwvgrrLp2cFMqOWRfvtptjHxcsz4rXL3dmu3qQJpbAFVBKZGsPc4y2an+NnltZ2RIwyoyTT/8/ZZztTDS+anpqNtKvorLLbppnyM80kSmem6AUqqpMahadxzZl5Roh3JhWkCQkXD2sWmf4DsHZ2f/ZvLHPN7qBeVy6imXHt4csD0dC99GWYEw6psw9zV/SW9pRddZKJLQI4YMMdHH7+S201wnutV2+dFByhNGDwTPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:01:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 16:01:05 +0000
Date:   Mon, 31 Oct 2022 13:01:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 8/15] iommufd: Algorithms for PFN storage
Message-ID: <Y1/xQCEgZ3XJh57D@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:208:15e::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a497430-134a-45e6-67b7-08dabb591dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDO0PBStEdjFf6cf78WyYUTS6xa4105BE1iU+p7aNY5+gbOOaZ/CaPi3HKqo/lKMRfmvfCCPp8Oru0UwXXqfPNaG6j2TR1LhtQNMeoUY5WXSFczSKdq4MbK4n2WsVRMRedU2G7PqQ+N8oIbI2QOJ11pb2ApMNaIV1tHsA7Pzytb9masOVeSig7HDNIsKmhFJFNJ4tTPO21veC5S3Q9htHiZfpdwDMXrn+0YLkP7WrSqgv3xzOf6QiDCzaTosPwpL4c9YoIzV47X9KmV/5mB0N9656Ba6AUWn5HPFF2HVDb58oY83zix5IS8NDDlX8ppW4TtYdq9amp4BixBgtdu4LJe7htvytBzE/UxEFfeumY7czDw1ZyKh3RLkoqusWoGGZxdQZZ6Rw0ASSGYzum4JAFTxesSU8neXGFmBfsKdzIfw0yesMQn+A0o0f+TAjt/o38DF736dyhnuCaFucHuMxSdF8kqr1oeQB2dQ748FW8bUI25m2CbGrFysUi9piBNjV9bownA8wHergMz8VeTfLK3gya1bE+qNpvSVrKupZT3LYSJ/5lenquQaxrIB8zehQINV1o8jVCgIn7r6FFM3M5nuUED7COkQtUWuYGxHMmbRV0ewKbGl/ZwBSEL0nSbdG9M8QJlinJL199V2haqY21cFImouwIlFvBPEtfI6sSj48CATvVSPU1Yquq95tW5p8Z52jHn3L7Edv0FYTj/lSwel6rAPtkL+Ms/o0QIMxGx1wlNLWweDknrrLOU6frBX7smtHfKtTLSdetMFe3rZag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(36756003)(86362001)(38100700002)(921005)(83380400001)(30864003)(2906002)(6506007)(2616005)(26005)(6512007)(186003)(478600001)(41300700001)(6486002)(316002)(54906003)(110136005)(8676002)(66946007)(66556008)(66476007)(5660300002)(7416002)(4326008)(8936002)(7406005)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?phDWfaF2UGrQPbw3PjcRrupeLrGI9gDmVh23SdhzVZd8JoaLWrixpCV+5Pf2?=
 =?us-ascii?Q?DVt9cp+IbYvWPZWZ3l2v1CqUHltcgRfWWo3goyFFcNhz7n8WmBK4s09xoYZC?=
 =?us-ascii?Q?d5pIuPP6065q1f/JQ+ucE9M4sZVtqCb2CibSvntyEGaBJuXgkqPf278bOUdN?=
 =?us-ascii?Q?LQAp7dk30g2pXTqqzm8DgSp0R8dMxOTpanxdb9qzT439u0e33ZCF1iB0i5e+?=
 =?us-ascii?Q?pzGtKLyd19NpJ33WsZ/mAyiisf2XY+2af4uz/z5tPMeTfas2Y9YXq6+dnvAp?=
 =?us-ascii?Q?raPWqlKKKcTomC2SE/TPq3z4yggwpfYk34OcRp5z+ZekE0CkMKkUdx/QvU/4?=
 =?us-ascii?Q?8ov7ofeZvYCkodDLw9yh0z5fMnveQ+6AC6zkFZxwXLuQXdB8URjT/2Z4xF2y?=
 =?us-ascii?Q?5C9S+iJaKDm83OIWohsfpPolw/FF596OZatIWUcux5DtpyWaKzlXKl5t03AZ?=
 =?us-ascii?Q?lnych0/85m0XhFLzWc8Nh4eL31GOhNXJ7y13cH1wq8DIJ/K/mnOd3K0y81wU?=
 =?us-ascii?Q?dN9BZBlvFl0aor7ues3UpvAJWOVb+uok4s/NotsdLSucjTeU5COnmlCuXhNd?=
 =?us-ascii?Q?kJlBO/rt9mEx58uo2kAqz/Uc+Taspgl5NuvCw23tAG1FE5Xd3nWSppMpOTug?=
 =?us-ascii?Q?2XvXsK23IBcEopxgD+ls5RYBnY/VNk9HCDiS/b6TtOCN5XY98py8eIupVoqC?=
 =?us-ascii?Q?I0d8GTCllXLiaX/WlqqRWREEE8X5nDHh4Lw9D1q3m6PIj4LoHa6dC9HZyw0n?=
 =?us-ascii?Q?Gjjz32gb8eKS14KB27eEfrl7ZccMAdYZLmNXjCjPUqMPqsPTSJb1BGsaY6Jf?=
 =?us-ascii?Q?3OlncOnlFJl1kdTvED9qp/XoWoaeaHeiR+Rp4wxwzAD0jcvNXzeLe6kSBuWm?=
 =?us-ascii?Q?MBybZ7SneJdWFBFh2/SEqC9sPghjVD8gCKhGm0VusXTz1vbeHP/2/Bj4leuT?=
 =?us-ascii?Q?Kmw92/4QoN0pOrl2s9Cqf754ITPqIwubvd3sjUQ1j301iJloyotPIo1uX/0B?=
 =?us-ascii?Q?EhjPoItjGd+zZzQ7x/9nJq8f703KyKZsn8ziZuH/BEYcqV3zl0P9Et6GlbU1?=
 =?us-ascii?Q?x3JMIziDYGilvUYV0HP4wpdVh/zrOERZDAdxIkUVHGBmB56qFLZM7zVE29Z4?=
 =?us-ascii?Q?3ogTAZnsvM1173iYyZtyq7kgJ2cR6g5oGPTxCBL6H+WNUtXAxrsNNHkqkQ60?=
 =?us-ascii?Q?RAhLOw/uRkKU92rKgo6e/a+PoHHT1cca4OXkLs00QDlo5ID5Qg6a7XT0OhqQ?=
 =?us-ascii?Q?QuSzmC0yH6ef8IQiVqFeM7i+b2krtuhCQXaMRSDnvMiMVEcU+45joPkECreX?=
 =?us-ascii?Q?GdEa9fRwcj7MhdBMA55GZGvMuQ2GiYxrVsSlsS67bJhN1v++mYhKaHy23d5h?=
 =?us-ascii?Q?lX4UegOxtabZol05jZ8DdMwuk+nX7E1HTY1AUbu0DxVsViK6cC91wmrWdoq3?=
 =?us-ascii?Q?ny8/ElTv63gcjRvP7KC65z/k/cA+Y6fjsrO34v9Qi6jke46N/QhWBLUyv3Q+?=
 =?us-ascii?Q?+8CyY4UBa/Puq6ShJIzJ4wLKwhNlx/GNOualEgK9UzUTO8JR+MLBIiBna3gM?=
 =?us-ascii?Q?J+wm0qtK64EqwEgwMS8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a497430-134a-45e6-67b7-08dabb591dc0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:01:05.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNEdbgKDlddFgUa8Q+ZC7M5Xz2pB9oWOOXmjK9z3OwevGVFG9ijk7KTaI+06fFLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:17PM -0300, Jason Gunthorpe wrote:

> +int iopt_pages_fill_xarray(struct iopt_pages *pages, unsigned long start_index,
> +			   unsigned long last_index, struct page **out_pages)
> +{
> +	struct interval_tree_double_span_iter span;
> +	unsigned long xa_end = start_index;
> +	struct pfn_reader_user user;
> +	int rc;
> +
> +	pfn_reader_user_init(&user, pages);
> +	user.upages_len = last_index - start_index + 1;

Syzkaller found that upages_len is supposed to be in bytes, not number
of pages. Which is surprising the test suite didn't find it.

-       user.upages_len = last_index - start_index + 1;
+       user.upages_len = (last_index - start_index + 1) * sizeof(*out_pages);

While fixing the test suite to cover this I also discovered this:

@@ -129,7 +129,7 @@ void interval_tree_span_iter_advance(struct interval_tree_span_iter *iter,
                return;
 
        iter->first_index = new_index;
-       if (new_index == iter->last_index) {
+       if (new_index > iter->last_index) {
                iter->is_hole = -1;
                return;
        }

Where the span iterator would not behave properly at its limit,
causing some chaos.

While thinking about iommufd_access_pin_pages(), which is the API that
trigggered all these problems, I realized we need to upgrade the
iova_alignment when an access is created to at least PAGE_SIZE if the
external driver is going to call iommufd_access_pin_pages(). Otherwise
the API can't work right because there is no way to communicate
offsets in the struct pages returned when pinning. Use of RW doesn't
require this so I made it a flag, which is convient for the test suite
that assumes odd alignments for RW testing. See below

Finally, the test suite didn't cover the unmap while access exists
flow, and the code forgot to set the ops pointer:

@@ -435,6 +425,10 @@ iommufd_access_create(struct iommufd_ctx *ictx,
u32 ioas_id,
        if (IS_ERR(access))
                return access;
 
+       access->data = data;
+       access->ops = ops;
+       access->ictx = ictx;

Jason

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d1af0389dfab83..737897a2dcfc3c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -26,15 +26,6 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 };
 
-struct iommufd_access {
-	struct iommufd_object obj;
-	struct iommufd_ctx *ictx;
-	struct iommufd_ioas *ioas;
-	const struct iommufd_access_ops *ops;
-	void *data;
-	u32 ioas_access_list_id;
-};
-
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
@@ -413,8 +404,7 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	struct iommufd_access *access =
 		container_of(obj, struct iommufd_access, obj);
 
-	WARN_ON(xa_erase(&access->ioas->access_list,
-			 access->ioas_access_list_id) != access);
+	iopt_remove_access(&access->ioas->iopt, access);
 	iommufd_ctx_put(access->ictx);
 	refcount_dec(&access->ioas->obj.users);
 }
@@ -435,6 +425,10 @@ iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
 	if (IS_ERR(access))
 		return access;
 
+	access->data = data;
+	access->ops = ops;
+	access->ictx = ictx;
+
 	obj = iommufd_get_object(ictx, ioas_id, IOMMUFD_OBJ_IOAS);
 	if (IS_ERR(obj)) {
 		rc = PTR_ERR(obj);
@@ -443,15 +437,16 @@ iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
 	access->ioas = container_of(obj, struct iommufd_ioas, obj);
 	iommufd_put_object_keep_user(obj);
 
-	rc = xa_alloc(&access->ioas->access_list, &access->ioas_access_list_id,
-		      access, xa_limit_16b, GFP_KERNEL_ACCOUNT);
+	if (ops->needs_pin_pages)
+		access->iova_alignment = PAGE_SIZE;
+	else
+		access->iova_alignment = 1;
+	rc = iopt_add_access(&access->ioas->iopt, access);
 	if (rc)
 		goto out_put_ioas;
 
 	/* The calling driver is a user until iommufd_access_destroy() */
 	refcount_inc(&access->obj.users);
-	access->ictx = ictx;
-	access->data = data;
 	iommufd_ctx_get(ictx);
 	iommufd_object_finalize(ictx, &access->obj);
 	return access;
@@ -495,18 +490,18 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 	struct iommufd_access *access;
 	unsigned long index;
 
-	xa_lock(&ioas->access_list);
-	xa_for_each(&ioas->access_list, index, access) {
+	xa_lock(&ioas->iopt.access_list);
+	xa_for_each(&ioas->iopt.access_list, index, access) {
 		if (!iommufd_lock_obj(&access->obj))
 			continue;
-		xa_unlock(&ioas->access_list);
+		xa_unlock(&ioas->iopt.access_list);
 
 		access->ops->unmap(access->data, iova, length);
 
 		iommufd_put_object(&access->obj);
-		xa_lock(&ioas->access_list);
+		xa_lock(&ioas->iopt.access_list);
 	}
-	xa_unlock(&ioas->access_list);
+	xa_unlock(&ioas->iopt.access_list);
 }
 
 /**
@@ -591,6 +586,11 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	bool first = true;
 	int rc;
 
+	/* Driver didn't specify needs_pin_pages in its ops */
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(access->iova_alignment != PAGE_SIZE))
+		return -EINVAL;
+
 	if (!length)
 		return -EINVAL;
 	if (check_add_overflow(iova, length - 1, &last_iova))
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index bb5cb19417d696..5d4d48c80d3ad8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -505,7 +505,8 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			up_read(&iopt->domains_rwsem);
 			iommufd_access_notify_unmap(iopt, area_first,
 						    iopt_area_length(area));
-			WARN_ON(READ_ONCE(area->num_accesses));
+			if (WARN_ON(READ_ONCE(area->num_accesses)))
+				return -EDEADLOCK;
 			goto again;
 		}
 
@@ -643,6 +644,7 @@ int iopt_init_table(struct io_pagetable *iopt)
 	iopt->allowed_itree = RB_ROOT_CACHED;
 	iopt->reserved_itree = RB_ROOT_CACHED;
 	xa_init_flags(&iopt->domains, XA_FLAGS_ACCOUNT);
+	xa_init_flags(&iopt->access_list, XA_FLAGS_ALLOC);
 
 	/*
 	 * iopt's start as SW tables that can use the entire size_t IOVA space
@@ -669,6 +671,7 @@ void iopt_destroy_table(struct io_pagetable *iopt)
 
 	WARN_ON(!RB_EMPTY_ROOT(&iopt->reserved_itree.rb_root));
 	WARN_ON(!xa_empty(&iopt->domains));
+	WARN_ON(!xa_empty(&iopt->access_list));
 	WARN_ON(!RB_EMPTY_ROOT(&iopt->area_itree.rb_root));
 }
 
@@ -802,9 +805,12 @@ static int iopt_check_iova_alignment(struct io_pagetable *iopt,
 				     unsigned long new_iova_alignment)
 {
 	unsigned long align_mask = new_iova_alignment - 1;
+	struct iommufd_access *access;
 	struct iopt_area *area;
+	unsigned long index;
 
 	lockdep_assert_held(&iopt->iova_rwsem);
+	lockdep_assert_held(&iopt->domains_rwsem);
 
 	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
 	     area = iopt_area_iter_next(area, 0, ULONG_MAX))
@@ -812,6 +818,12 @@ static int iopt_check_iova_alignment(struct io_pagetable *iopt,
 		    (iopt_area_length(area) & align_mask) ||
 		    (area->page_offset & align_mask))
 			return -EADDRINUSE;
+
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		xa_for_each(&iopt->access_list, index, access)
+			if (WARN_ON(access->iova_alignment >
+				    new_iova_alignment))
+				return -EADDRINUSE;
 	return 0;
 }
 
@@ -896,10 +908,12 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
 static int iopt_calculate_iova_alignment(struct io_pagetable *iopt)
 {
 	unsigned long new_iova_alignment;
+	struct iommufd_access *access;
 	struct iommu_domain *domain;
 	unsigned long index;
 
 	lockdep_assert_held_write(&iopt->iova_rwsem);
+	lockdep_assert_held(&iopt->domains_rwsem);
 
 	if (iopt->disable_large_pages)
 		new_iova_alignment = PAGE_SIZE;
@@ -910,6 +924,11 @@ static int iopt_calculate_iova_alignment(struct io_pagetable *iopt)
 		new_iova_alignment = max_t(unsigned long,
 					   1UL << __ffs(domain->pgsize_bitmap),
 					   new_iova_alignment);
+	xa_for_each(&iopt->access_list, index, access)
+		new_iova_alignment = max_t(unsigned long,
+					   access->iova_alignment,
+					   new_iova_alignment);
+
 	if (new_iova_alignment > iopt->iova_alignment) {
 		int rc;
 
@@ -1106,6 +1125,41 @@ int iopt_disable_large_pages(struct io_pagetable *iopt)
 	return rc;
 }
 
+int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access)
+{
+	int rc;
+
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+	rc = xa_alloc(&iopt->access_list, &access->iopt_access_list_id, access,
+		      xa_limit_16b, GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_unlock;
+
+	rc = iopt_calculate_iova_alignment(iopt);
+	if (rc) {
+		xa_erase(&iopt->access_list, access->iopt_access_list_id);
+		goto out_unlock;
+	}
+
+out_unlock:
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+	return rc;
+}
+
+void iopt_remove_access(struct io_pagetable *iopt,
+			struct iommufd_access *access)
+{
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+	WARN_ON(xa_erase(&iopt->access_list, access->iopt_access_list_id) !=
+		access);
+	WARN_ON(iopt_calculate_iova_alignment(iopt));
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+}
+
 /* Narrow the valid_iova_itree to include reserved ranges from a group. */
 int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 					  struct device *device,
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index c32a87f11c55be..068055272fc5b5 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -17,7 +17,6 @@ void iommufd_ioas_destroy(struct iommufd_object *obj)
 	rc = iopt_unmap_all(&ioas->iopt, NULL);
 	WARN_ON(rc && rc != -ENOENT);
 	iopt_destroy_table(&ioas->iopt);
-	WARN_ON(!xa_empty(&ioas->access_list));
 	mutex_destroy(&ioas->mutex);
 }
 
@@ -36,7 +35,6 @@ struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
 
 	INIT_LIST_HEAD(&ioas->hwpt_list);
 	mutex_init(&ioas->mutex);
-	xa_init_flags(&ioas->access_list, XA_FLAGS_ALLOC);
 	return ioas;
 
 out_abort:
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 47d18388dc24fa..783fbbf0b732d4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -34,6 +34,7 @@ struct iommufd_ctx {
 struct io_pagetable {
 	struct rw_semaphore domains_rwsem;
 	struct xarray domains;
+	struct xarray access_list;
 	unsigned int next_domain_id;
 
 	struct rw_semaphore iova_rwsem;
@@ -205,7 +206,6 @@ struct iommufd_ioas {
 	struct io_pagetable iopt;
 	struct mutex mutex;
 	struct list_head hwpt_list;
-	struct xarray access_list;
 };
 
 static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ucmd *ucmd,
@@ -256,10 +256,22 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 void iommufd_device_destroy(struct iommufd_object *obj);
 
+struct iommufd_access {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_ioas *ioas;
+	const struct iommufd_access_ops *ops;
+	void *data;
+	unsigned long iova_alignment;
+	u32 iopt_access_list_id;
+};
+
+int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access);
+void iopt_remove_access(struct io_pagetable *iopt,
+			struct iommufd_access *access);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
-struct iommufd_access;
 struct iommufd_hw_pagetable *
 iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 			       struct iommufd_ioas *ioas,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index fc253a4d2f8e77..7a5d64a1dae482 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -29,6 +29,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
 void iommufd_device_detach(struct iommufd_device *idev);
 
 struct iommufd_access_ops {
+	u8 needs_pin_pages : 1;
 	void (*unmap)(void *data, unsigned long iova, unsigned long length);
 };
 
