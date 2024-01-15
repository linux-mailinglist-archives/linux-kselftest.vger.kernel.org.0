Return-Path: <linux-kselftest+bounces-3009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C682DE57
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 18:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66851F22B27
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCD17C79;
	Mon, 15 Jan 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ejVxlX0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0818021;
	Mon, 15 Jan 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRxst8KQKEjemrGWSt48IoavQvJAZQ2rzWVHiTVnNIg2BkemD77iweNkJXfAx2v/nI+49A8ra8lFlM6QzJEUnA0bmpvqk497cl3yOznQGbU6QS0KwUk1R1VK6djrWBlC5ZUmWax1UoU1XVAuK7r8muFJSIoNbxgmCMdqja7wHunqQ/lXzU0/FzNuNjYg80rhsWoQQLHRLDM6AzRDzpRuBHXveKc5Jo9cQhAClfXRNf2NnGxF9gImwa25NcSepqhUtHMm74gwq4Xl+ExiJ4dDN2MfcXRPrOBIP4LzPPfbk514jsC3uXORrbyac4UusUUZtV3hv1ow4lpbL76okiQZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Efo1NnWc645uyKiO94stb702AEWiKp2To+kC5vyZAvo=;
 b=BRx0QcuVPrizFE04NklCK87l/0hulcRtmw1R5P19uTDUi+VjB8PjHdb6yRPf6IT1wfTQfMFa852BpTZ/3kKXXLme6ZO6tAseVVh2CK4MXjoAP1iVXeKSJOpkDMBTxU2krxik4dJTH+uDz4Th+/4OhvQEC51iKTBnZkvjA7whSBS1qk+UQsXKzqg3tYmim5pG2Bh847XiYP+YmygpSVkJqcs/9gABFhkZaAaTOSPsgrC9BRYYh8mepCZvv6hy8j0Pe22u/0mLtXDdQYGS2pGhXRN0g4U/Q9YfrUYC6qTUF/09GnDiF6xWYAIls+uFZTrUQJdIainmmIECr7KE0D7I3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efo1NnWc645uyKiO94stb702AEWiKp2To+kC5vyZAvo=;
 b=ejVxlX0IpbN2GrIK1KZx2dd2ECsxrV8FYArIhktxmZvI86fzU4AzsiryEr72Rjl0Ba6Y5LGL/5oyYC0Y6YwYIc8a0LJ7hBlYB9CiCypJ3yORG1r7f5M/PpBCebB1YQLrk5kPgF5OZCoFRBIrQs1ZTHThuTpgWwVgJXWtLagbI9huh60UnY42sNa1BdgSdCCTznEtuHYoX8hcWpMDMNlF0cwZHtzZ6FjyZJ1VlIbZZDOEYe8s+DUsp96Ci9hIm6nmWKgXsCqLfNbRrnlD23pzLWAwW6dO0d2yGErfg9I9ZryqmdIQo8sfNn/xKZXigDodwUlhJyVmMKzuL6/iwTgzEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 17:19:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 17:19:52 +0000
Date: Mon, 15 Jan 2024 13:19:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Message-ID: <20240115171950.GL734935@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127063428.127436-2-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: eee5bea1-5de6-4147-078b-08dc15ee2f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eKbCqbRwvcl0RJ2BedHPUibthEWG6MHYkufdZjofdv2hPpJn5twIRffkCfNFzfQtu3OjOFV986c19L4tZeLZvS/gIYTdoaIu8C/J+3k/WfChuv/g+aGFm35FEwKHpQd9oyN61bv4gI0H0nvDy4TARylvm0BgGTslvm7c3XU//5SKAeSztiXHDN7zRzcEzgmeVrprzaS4xR9Lt5cgQKmpIJwXNs3ghCg+4OXMt6WxVBq7pgFG3RQ3xn6U/0E5Qt+SAJG/BnsorAzlu4uD/Y++IHZPoPW/E8e3ExeAC40S8v7+JWgAf2PEQVgxPVoERL8CQjFdP3C2zKJdC1847Y7qSS4M0V1mFqM9CsgniWJS+j4SsgpgYA86785Z6Ai6gT0ebTRcbQ9MPD6JPhKcebR8TwWE7MPX39GCBK4nXf0Ag4lgqB7S6wGaZ4rFUvTJRxNjq5TcaMer5excdE+a5+HQjx7dTK07xFIn5ewvAJARjmbxOZxj1Rxp1HE3aFTPrgSrGHZkSI/St8zEngSitd8rgkc9KT5MgjpfoxajxH1uuE8wVY/U3qgRiCZqHfdlNXWd4+4kuZ96J8fZ/wqGrdr0bepEtKDEZEVamtfjIAiskeuL+A4EpsYUtRSRRZVUnc3p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(2616005)(26005)(83380400001)(6506007)(66946007)(33656002)(316002)(36756003)(5660300002)(4326008)(66476007)(86362001)(2906002)(8676002)(6512007)(8936002)(66556008)(7416002)(6916009)(478600001)(4744005)(6486002)(38100700002)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qhT0wQF4aIuaLAfHVxJFwWHmOIzb5spg2AkJy3huOX3m/W+frZ8zRbzrcOyB?=
 =?us-ascii?Q?3jV/hnqXp3x7dywV//xrOBzYhU8zTNH+uxelDfydNkeNSWbXkp0NQwUXljGw?=
 =?us-ascii?Q?9qu4hYywpH6ohvHNcHv0KCLexnUxk8LGzg34iEEhKS+NAR8rStu8ah1YGYx4?=
 =?us-ascii?Q?YlBMH0MNQZnn9r+EokDffwGxcpUc8NAUv2xrgHOYGOtx8upwUafwmDJUKcoP?=
 =?us-ascii?Q?nS1bdtJb+fnuN0qkThkmem37LjtahDQ0jF78Vp4ldHl2WgszX5C+jRS6frh2?=
 =?us-ascii?Q?kdF9EK0R58nh/Pi48LY2JX2pH9TZw79goGU0zBBYXY3oIoVOgBDgsoctff/p?=
 =?us-ascii?Q?79X/mpj7kE1siSj2LjQv6XJbbD1b7J4snXr22MU9kE9EbLhm6ucw1BrF9gbh?=
 =?us-ascii?Q?JC4m6BsBNnMfll8R+t9WvLCDqSB0rIBoYJPiOG4T2kWnq2ZjTkyWYpB88Uib?=
 =?us-ascii?Q?lIOpUxpAamtKrhIbDRQR+7OxhobTkXD1xTBGAUF8a2R1ULS2AJQqeuZrUQEr?=
 =?us-ascii?Q?NvciRiwMXBiNxRI0OErnbZvOmjJAtzNtSb+yVl64ahBrVFpahdFlUAcGfuhx?=
 =?us-ascii?Q?86ZP/4KAWfAL7LwtFiG8BPOuneOWm78J80qRXd7Fd8dYPQWkRNS6pdHh37C7?=
 =?us-ascii?Q?XguaTJbbZ0hyK7xEnz6hFJrxVaGuS/L9BqBI/YPcYq/7Sg0J42DI10CLOXVy?=
 =?us-ascii?Q?0GJiaG5J1Sm2xoZLLe1JC39XCKCmVa6HvwGHvZJ8YVJ7nRIvzhdYCp8ijsSf?=
 =?us-ascii?Q?v1OHzbnGxgpbW+qBZhZEDFWvQN5JbCjkldfEsLt2E8xpzja2ZRvoN1ep9yDF?=
 =?us-ascii?Q?qixIm7ardfiGPJ+8ms2mBMr40ZingREYdnnO70caK8wPSU/CudgIwOTFgdUW?=
 =?us-ascii?Q?ezAAV1NQEIYTgqX44fb2JRzn6rElzNRkvWFq2vJtz0Rws1GYU5mSblS6Ch1D?=
 =?us-ascii?Q?WfmLznoQFPbCoK0zoQewqn2Ktjbl0E04E//g8yCFotvr4UDQrF5nehFV8Ppb?=
 =?us-ascii?Q?kd+CehqgDIP3K1LqhaRmFImhlP13QJQtPnYtbSNvQ9HvKyjMjUxq3EdSf23l?=
 =?us-ascii?Q?LzNRbGvQXoLf6qHjHr+Ah53/PeAHvz26E8elrdJb5NwVRdxAPbjFcV3F+s3V?=
 =?us-ascii?Q?0n0h31w36IVUCX6AFE8Tp7DMDQeNKMH0az3ud3Yzz+TiBkiLGXKmnLVU1tY9?=
 =?us-ascii?Q?u26m0z2kS1RqVSewU0BEhUg89nnAlBbezUxP2HDibVQ7ZuWEaB5GU20N+r88?=
 =?us-ascii?Q?j2FQ50C+h5mTrkV9B+7+At8VDd2jv/RW0TklIfqj4m4rlKPdVT6UBwG4CKk5?=
 =?us-ascii?Q?HkzMjZCsXD6M/xIy3oLlxOkMojdyXXdw5yZW3iJYW4kXvGlJyMuysySwjppU?=
 =?us-ascii?Q?7u/ZZyjyf/WsBCVtuwubsquNsjKOk8BkIeLJPyQFdPF/ejTL/Stddnh7S6z3?=
 =?us-ascii?Q?FAmJfheeit3qmMMeOF7xGOeyjGwlO+42UXUXIQsrJpIfUFChSlmsyb1sdG3z?=
 =?us-ascii?Q?OQlMYW09GR9uOcJkq055FEsko95X25o0uv+jHwNMqVhS0zfbZPRCl8eH/UTe?=
 =?us-ascii?Q?frbRo/ed3v8jj/TJLRD86g82pQHw0kU6zl+8//ET?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee5bea1-5de6-4147-078b-08dc15ee2f48
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:19:52.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPJmDZ1ZINh8mKAe3rGSz/GyGuB+nuVy0HpYg4y9UPlqhfPELWBo+BA7gXDQSpe3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

On Sun, Nov 26, 2023 at 10:34:21PM -0800, Yi Liu wrote:
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_domain *old_domain;
> +	int ret;
> +
> +	if (!domain)
> +		return -EINVAL;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	mutex_lock(&group->mutex);
> +	__iommu_remove_group_pasid(group, pasid);

It is not replace if you do remove first.

Replace must just call set_dev_pasid and nothing much else..

Jason

