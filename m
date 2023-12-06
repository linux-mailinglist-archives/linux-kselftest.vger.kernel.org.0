Return-Path: <linux-kselftest+bounces-1314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E968077CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B90C2821CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29D130349;
	Wed,  6 Dec 2023 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbt/gkRh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C7D40;
	Wed,  6 Dec 2023 10:43:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faWeVgvY4frH0iUqBBNHwh398+0kfEX9QsUIHXtkGYzFg6t6L/ii9fdmamxHhZzij7buLoyAVfVihg9v66OFln3RlEJ5/8MUlzthGKRCioeeTuSVc5n3ycXHCO8ppNmoJ7YVIrxb6Inky9skWdzip0sNNVqJ2YPDKlweII+EKYBiIzWblIwcxwWp/2HBNl3zOepRxktFqtPkQBOwyjWkClLq1VeQ6brgTtLefd58wrNAiVwgnSmLl4mpaQXRFZeNH4rMVGAG/6B5f/vihjvt7G+TPeQq+mhyHvxX9y13VdD+T6Bwr7xVkd9PA2xhE/ad/JQE0xUuTqjn6Uuqfaf5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNBRVZTpqs5BJWVrHkRWGJNgbQ61ipFJNMOg8ju3HTE=;
 b=laa4SqfjGBRMvCuuyCqJZkdWZimoiA0onaH0ZxTZqph1FcDXR/qoj95HevyL3NPRrVR7ChYtiGJBr5lkF95+sHzQYTYAjlvG0gVX0WXnPHacsc6WDKhTx/wfku+lsuS6oGHi+IgfeogNajwAD0k7ae2OTvcSUOSGDTfmgDEwUs4ahJU4Bn1qGY5mlo9oqqSvqKsU74KYBzknlMYUBiLVhtJ0AUyf622qo7Ui+180k8RU1gB1WlAT2oSPrINqsRg9/NE4D1ANqx1jkUFPgUFQne32zsXi7pmEt+gNdTORqrKPjFADmtxDruJwIXMFVK4dFBkkJSczOqNYZxNI5xVhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNBRVZTpqs5BJWVrHkRWGJNgbQ61ipFJNMOg8ju3HTE=;
 b=lbt/gkRhrzrsqdaGRpBB6hh68Sjmj+0BdLugnxQYzXr9d5PegP7RE8g3oxrI1eELwHiTLs9jLvQoPHKBbOKk6wJpdMmQxyqDSHdl6vGbsgayFkgAFD+NnRd/IzCOiq9CVmNamnPVu8Nm8VOrelwfpzMs8aNqEnpMfbqQ4A+3aQ6pyTU9jbtBTgcZUIebQ6RaWXRsZe/lfaJhwMawKY4CnBpLdFPMGeHrNTbCFr/ZbM+UDjLYEYIGT2WWFZd2oySSmGv0zeu1f0tTpJ713wGCLvucWsFHfKn8fdpRpMNhB64t5mNf9YTfl1HSM55P5zWcac91VPis0UZauv+Di5YQhg==
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:43:53 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::73) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 18:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 18:43:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 10:43:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 10:43:38 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 6 Dec 2023 10:43:35 -0800
Date: Wed, 6 Dec 2023 10:43:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <cohuck@redhat.com>, <eric.auger@redhat.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
Message-ID: <ZXDA1uUzvxmLf/o4@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-2-yi.l.liu@intel.com>
 <20231206183209.GZ2692119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231206183209.GZ2692119@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 9589f116-762a-48f4-8ae2-08dbf68b4bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0LYVTZKJZz5eh3kE8tbA8M3XX52dGX3ra6x0XKKydWzNe2lIz/E886e8/l8QvPyPraLQ/9SjJYDjVB8oFpRmrbL3R4pMyvxlGEO39W9e4lDCm4zUyUKcMulcrnW4L4N/g8EoU5HXdNexctpIxIUmRfVdtNwMs5eMJCkldgL4uRBO+bY9JXvd94GWFMLmn7XSvvSMJCp6sQ8SgdkwFAuOhBA3Z122KSuzhXQ/7WUwuDU++Cv48080AZPNYeoYGwyzfizXji7UFhR4mrqNP1VozeNGNhv0/yWmt1BKlg6z/PoUW3n0f1LaRWkDH4xwarH31GOrAJQgDHc9yAhqsUEbPii6YhFMigIJB8k6CkWx3arJg4YiBSzsMfsgLZpkJaOiSqQmn9PGR+Kzq276c0DSNMc1fjP3jU8tFejV+VUndKTCqmu8W4HbzUxYhQg3Kc+NY8Q+6UmGm9R7BU6GuOL7luFxt9rdcL4OrVkLR/qr4U3zUOgi4dvmyJN1BfuaNDGx7nUCYeud9vXDHQgCDp9vVCDe20YCR3KYC536eaPj7ZOFD7EazQPNmmtiAnMiJLyr1B8roirXqCpeR6Jd0BwEpsG/XdObKusTcV0L4KRyyws1eNwF0l4XhOcTqpLfVTqbrUsrzXfRgz5Gsm8ogRLLrNdOelcC6oZyo2ht0L2/wU9CZHnzd9Kww0ua60B/fIBAa+Al7ACU7gXQhC0Let70PQAstN1DCNgJz9jN6g/c5vfxuxASmhTfqJYJqVlKCL9y
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(426003)(83380400001)(478600001)(9686003)(26005)(336012)(316002)(7636003)(6862004)(54906003)(6636002)(55016003)(86362001)(41300700001)(8936002)(70586007)(70206006)(8676002)(4326008)(36860700001)(40480700001)(7416002)(4744005)(2906002)(5660300002)(356005)(82740400003)(47076005)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:43:53.2373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9589f116-762a-48f4-8ae2-08dbf68b4bb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906

On Wed, Dec 06, 2023 at 02:32:09PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2023 at 05:07:12AM -0800, Yi Liu wrote:
 
> > @@ -465,6 +492,9 @@ struct iommu_domain_ops {
> >  			      size_t size);
> >  	void (*iotlb_sync)(struct iommu_domain *domain,
> >  			   struct iommu_iotlb_gather *iotlb_gather);
> > +	int (*cache_invalidate_user)(struct iommu_domain *domain,
> > +				     struct iommu_user_data_array *array,
> > +				     u32 *error_code);
> 
> Regarding the other conversation I worry a u32 error_code is too small.
> 
> Unfortunately there is no obvious place to put something better so if
> we reach it we will have to add more error_code space via normal
> extension.
> 
> Maybe expand this to u64? That is 64 bits of error register data and
> the consumer index. It should do for SMMUv3 at least?

I think Yi is moving the error_code to the entry data structure,
where we can even define a list of error_codes as a driver data
needs. So, I assume this u32 pointer would be gone too.

Thanks
Nicolin

