Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEACD7D59F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjJXRvT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXRvS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:51:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5939910D0;
        Tue, 24 Oct 2023 10:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEcUBhGvZZN2Y1U/iuG8fPip1phE004bSt356yldFv+uXdJ32t6JrvngrdmoUTkQNVAqR2Ki8nDAUkzzIXNnLd9RKxMQigaBjl9CsAQmpeciQb1I5PYufh2bq4HWx0lD54ADIaFRSh/E+fkRQcTD4SaJ7xgQYTO00UVazX4Gaks9J6h7gRb/W6bnIRxtHTd9tn3X0/d2ZuCWH6YKlvA8N3OOPmCMniSIrZf8NWtxkRhunY4DP3eJYaBvol1z8AA4k5VLdzZ2nAx8YgSzYQdipPO7t5LoelCm5Lrpv1zxnhwVXfPaFAblVnCFrblVMxEmk74u67/jVOXK9ACazgaunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLaFUHgoOt5elCfIb4qhOB4GNdpUf4Bu4zuAl/APZs0=;
 b=NtXeHmj432gKkNjQWNuY5msvfJN1qfYsOGqZLzB8gKvPY5lAoJ+KlQHRvoAZeRu21x6gE6qa7tPkiXiCbd3B2UGITdhaPVDhFJROkBoK7v2oqcvDQzOuLej8bqQrTdpAj6d5VQiZtXPdCxyn6Eua1t/DLeo7uH7Zhqu/v0tiumkG8C67ISZxIIsR5D0/3wj1DfdSha1DyLvYYQ4goMAZLDuNwGu10BiMSkaFcsTvvMmJraqdbuMcBCWOCfRU4plfsNSb+P2l3Hfwbu5MQG4PK9e02GAdKEqBD6HPvnZ8DOC/AOEsEeRe0a6r94SDWAyi5+kpeTkgaphzbzBLTK5D4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLaFUHgoOt5elCfIb4qhOB4GNdpUf4Bu4zuAl/APZs0=;
 b=I6EsUrAUtiA5Thrlv4gk+7wDZG0N14XvhsxCJ9YMTEtGt43fIExzMD0s0AT+VOC7oQD0DIJ18FYhEwijlHZDCxW5G/fF/bZFm6qIuoo+ZLCppRaA7Up//LCjJ4jMzgxPMJb67z0p/sazd9EsEU99F3z5HSutVeWNZ047P7CzgHRUTLneYM262nG9el1mT5QrYJNyc5RC+LrFWPMpwJE253r/TXcYAW5gdsz1LHbPzITg9HzD5W9zIMimitPqr78DyEtA8JecYRBnXxrfGXXaiQGY5atfFnzIRjS2ihibcdyEzzE4p4suJjIUv+38IpkI0O4p0U6GtQTfSpzsJTrF/g==
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 17:51:13 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::3f) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 17:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 17:51:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 10:51:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 10:51:01 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 24 Oct 2023 10:51:00 -0700
Date:   Tue, 24 Oct 2023 10:50:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <ZTgEApUgriFj1dKa@Asurada-Nvidia>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com>
 <ZTf+zWJE2qlgkf1M@Asurada-Nvidia>
 <20231024173139.GR3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231024173139.GR3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a124768-7477-4b96-666f-08dbd4b9d066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oqIrzJXMfDPJ+bqpKaJqQxWvEQMzuH1LYy7KCFvF0I2fsKpA/8znQo+mnwyzynwPX7QjillRFyTOTG41//zbXalXMUzm81/wT7FbnndpILXivvYKgYhQfxIoSek4KmYkOGxAV6yytrg/Y9nsQWMH1V3jpyeYG3NvzQo/JW2s8TNvQS7CZS9JAs771DM0KX8zO63gyMiijZi+PalCaUxbstFvFE0zLkqxCP37wGD5KzoCJGuFJ20mM3fT1IoAS7HiXzaEeqdmRDs7590bVzEQJkxRJjgysedH2N9Eub9sxMTGjemMuXEi2t/HX0kd+17M1mVas0IRzcNPHEji45OJophM5JeBYRkTZ8QuNcFOF8lXF/TQGmGFRfeZVA4gbmKbevRTWO4LpJpqx8KrxTHH6aq9aVfpwDpAevQjutNoN1F9WewwdRqnOS62C3fOnWTJioj4gMJTTDrp8n23TGyEdwRBNJ5UMwM615GEC7LHWq0UAY2Jhg9cHkTqv84DEheWJ5zsor+6YCw+6k2TW5Pva3P7bPybO2yoOVibgzCianB7TL/L//88UyCjUokO1V56Yp/ZGcj3DdKmghwHbXt6KN0xgCvHIxtfjhbFmcf6HZgk5jBoKVqEFOoyxHMt6AAC9bOlOKZRsgTiiipKdJMTjQNbdSsqpjHu476+HZFfDpQSGmNsnfZFkTwKL7bDfjw8U7u4r1QEHlDnSeuLk2By6DTlKO2oxgJR6JthBq88k1tPwfbCyFBa8U09MhiSSAD
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(55016003)(36860700001)(40460700003)(82740400003)(356005)(7636003)(316002)(70586007)(70206006)(54906003)(478600001)(6636002)(9686003)(47076005)(426003)(336012)(83380400001)(40480700001)(5660300002)(86362001)(41300700001)(7416002)(8676002)(4326008)(6862004)(8936002)(33716001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:51:13.1904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a124768-7477-4b96-666f-08dbd4b9d066
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 02:31:39PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2023 at 10:28:45AM -0700, Nicolin Chen wrote:
> > On Tue, Oct 24, 2023 at 02:18:10PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
> > > > @@ -195,6 +279,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> > > >  	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
> > > >  		struct iommufd_hwpt_paging *hwpt_paging;
> > > >  
> > > > +		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
> > > > +			rc = -EINVAL;
> > > > +			goto out_put_pt;
> > > > +		}
> > > >  		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> > > >  		mutex_lock(&ioas->mutex);
> > > >  		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
> > > 
> > > ?? What is this?
> > > 
> > > Ah something went wrong earlier in "iommu: Pass in parent domain with
> > > user_data to domain_alloc_user op"
> > > 
> > > Once we added the user_data we should flow it through to the op
> > > always.
> > 
> > Hmm, iommufd_hwpt_paging_alloc doesn't take (or need) user_data,
> > but we could pass in a dummy one if that looks better?
> 
> The point is for the user_data to always be available, the driver
> needs to check it if it is passed.
> 
> This should all be plumbed to allow drivers to also customize their
> paging domains too.

We don't have a use case of customizing the paging domains.
And our selftest isn't covering this path. Nor the case is
supported by the uAPI:

458- * A kernel-managed HWPT will be created with the mappings from the given
459- * IOAS via the @pt_id. The @data_type for this allocation must be set to
460: * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
461- * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
462- *


Also, if we do passing in the data, we'd need to...

280-static struct iommu_domain *
281-mock_domain_alloc_user(struct device *dev, u32 flags,
282-		       struct iommu_domain *parent,
283:		       const struct iommu_user_data *user_data)
284-{
285-	struct mock_iommu_domain *mock_parent;
286-	struct iommu_hwpt_selftest user_cfg;
287-	int rc;
288-
289:	if (!user_data) {	/* must be mock_domain */

...change this to if (!parent)...

290-		struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
291-		bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
292-		bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
293-
294-		if (parent)
295-			return ERR_PTR(-EINVAL);

...and drop this.

296-		if (has_dirty_flag && no_dirty_ops)
297-			return ERR_PTR(-EOPNOTSUPP);
298-		return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED,
299-						  has_dirty_flag);
300-	}
301-
302-	/* must be mock_domain_nested */
303:	if (user_data->type != IOMMU_HWPT_DATA_SELFTEST)
304-		return ERR_PTR(-EOPNOTSUPP);

Thanks
Nicolin
