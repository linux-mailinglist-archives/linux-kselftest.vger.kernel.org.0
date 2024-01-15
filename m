Return-Path: <linux-kselftest+bounces-3008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB682DE54
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 18:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62551284BC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B607817C7B;
	Mon, 15 Jan 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AVKKOb0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BE17C6E;
	Mon, 15 Jan 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8+AT1gdQ8/3r2raBJtjvKuiHKaEuyyrf0xVlf2n1lQaznYTsy8QF/UW+NAmbD8mskBxRMTaepRp3b26s5hY0AuTLiZGsLIfRPXwwtk4C8Ez/Rr78lv8otY5l6qqDe7tC7pSsKUIuTHvikGJC6v+bCMfJ2nNDSxqXsBhiAFE5GQq/OZgBka6W2Y0U+6SCM22Op9FxhoucWLCceScJNU9nFucHYrDnxf+panVVp1TcYeTPcQ8PRmae8IrxWVY/dlVkrPaDn8uZXCRzPCF/2ntRZGZ1GOEXoNt9/TEaGa4UeW+sSTXysl5Kck1HY5FGwV0Mmdfs9SJf5vgOUVE0vVVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/RUiocUUoBqFIEGoO2KW1qCEThjKHYMPEc8ztrmD/c=;
 b=bErgBX44QzOQvppzANNVu0U+hUVJrdHLGpFcjIxxVdDimljOkwtEuzc75PwTgk7UJ4s4OXgYauMKyDTw6h8HJiWouFOrrBZ+vJovTmWWbKuWPe94ClsCdAAx9nHU2x7Pm06EVUyXDsrE7UDm9Ww7khHS8t1Ptu+1Hyxdm7PPxm5Zb+ZslEeCqQznDDYpRIjc+M4ofilmn5oe7WW8wRoUi9bRmpOs1F52e+ZI8ETkafxt/Imz2g43W50tdrbIyTjXD/8XNX40oid5qyn1I8YL+WjzFbdalCxPQyIEuWJQXjpM+/wo0iVk+LyEornjN18AeiIRtZnuFZ4C6NgHRKhWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/RUiocUUoBqFIEGoO2KW1qCEThjKHYMPEc8ztrmD/c=;
 b=AVKKOb0WI5KNjIwABxkw9ZBTd6OgTZ9hMSe4W9W84wRaWPxoPJAw29yFpry/KwUGSYUQHyrO1jDCTfORJltQiVjzT+Vm6Rwg2XhSXEDQ9RUSF0SoEt+M/q+VbxJ7JHJZL8Q3+qwF1BOp4OcUyJtiVBwrS4ghGQQrDf6s9JsNwnS+KTPcPYGZwe4ifapcDP92ymkWowtgDkFNaojbPdPgSlcb0Y2Mp1f3iEFX0Wr5lR04+gxGEsAxj2YRTkfYxyBArnDfR23h9cz/uK1sG52CXLUrhhxFT8W9vG6Y6wyXnr92UqsyvNc2GWCxrb5QSvanDwHd5t3C8o5MYyingHDZsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 17:18:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 17:18:53 +0000
Date: Mon, 15 Jan 2024 13:18:52 -0400
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
Subject: Re: [PATCH 1/3] vfio-iommufd: Support pasid [at|de]tach for physical
 VFIO devices
Message-ID: <20240115171852.GK734935@nvidia.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127063909.129153-2-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:208:134::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 4543a277-cef5-4064-e5cd-08dc15ee0c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uHznK4pMfP6kuBsV/sTxYZPF824eYveTVuWYRLuztin+wIrrG0cS/HSRcBUwi3Fvhtm/YJR0qT1nrQ+9huQ1HWHKxXD1UFuSNNkXIsqDvCPe2bPeBjHArSZXWpm7TUrisqkimqzf0Y8NX/jeFdj8UrgGRnzSbIxu6g+nSdaxHtvd6FV/JfZUfHxKlceOWBVy1J5fB+HFDOyL465PQP4ol2HNkuVUWvOeDeHRF8L/CcnBYgn9jwHXs5qB4w9eD+/Db90tT9R8tK6V1W2FXySpY66iuHqMpNtSaMuGAeXRL2edisjZX1Kg14ZfQFAwrP7ehcRGNkqC7vyeeHPDekRKkfBRT2Mtk+1POaWkC2SnUHtQh14LeqdTsZnO1IxMTFh304LSKkzipwmEVsaCGdBWDPWBuedAtYMCQ/2GKynhmpjHu2TNIETD/Lbj6ao/ZeHfhyMpdE3W63EDIQ+5EbxXka6YWaqUrm7y0Krrkb4DBFpGhO4A3krmFXEAIpRXr7mI2p1ASYvvrQ0xoLqfJGjg/cMiVCQBROT3dNj1yrxrsylNrP/W38J2rf7mSB4H/ipG8SVmOrh2gdZBafMHYvGFLMii5PdQDarJDCdmzHwLd/0FZA0BI5HpFamtKg/PQxw2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(6512007)(478600001)(26005)(2616005)(1076003)(86362001)(33656002)(38100700002)(36756003)(41300700001)(2906002)(5660300002)(83380400001)(4744005)(4326008)(8676002)(66556008)(316002)(6486002)(66946007)(66476007)(8936002)(6916009)(7416002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIoZKKGHS2hlZufkroHNU9MGpXp531ljGoN3MWvUhl3v1R4j6uj2e+mWQpKs?=
 =?us-ascii?Q?diOAJuv806ZsAC+HoNAFOisXWReOccTcNSlmUkTYP+Vgjf2tqNP5QJ3JvO1Z?=
 =?us-ascii?Q?aU/CChXCBQnPpJHYQMqBynu7OFeB9joWkE+rPP27M+Lhvv/sCH1BIemTJVQz?=
 =?us-ascii?Q?Jte1xTifw9zKc+80cV+9mRJ2g2C72WwXaR5EBu57JWo7RatizMhMH6RQPTi5?=
 =?us-ascii?Q?YqTDI0E1RwnkClMB1KpblGyd6IohMmBL2nz2OpVs3YeMB9I02f/iLNWBdyYr?=
 =?us-ascii?Q?15q/7JlXav0DmHhKgriUyVDlMpKsHsQYXB56I92TD1Kh0sZM5NE29Ft/5LF1?=
 =?us-ascii?Q?uqgjW0/ruAXXGmJ3L5ahdqTX3QBwszNThzLY08/joCOf+bq5jDgUIez+aWMQ?=
 =?us-ascii?Q?of+d2kup4IqhUDdti4qBCnkyLhN/XiGMs+TsBNLlDQo11nymEhhYqus3qI5f?=
 =?us-ascii?Q?BvuOsw8yHSnVaWH0GxSw0JJ3bODtnK0vHKpWpuJc/NVvEGe+rh9qXZ4Y3cjN?=
 =?us-ascii?Q?cAl6jorerqNAISYuD7EzevBqAi+1EjCbUWGV3UF4YyHqxOQRcbgN/c1Y0Uk7?=
 =?us-ascii?Q?jyZE7k9W2XOYX+9rphwc8J61p3S+qFkhzRcnRGgTU8zuFzUziuqNyPgPKh/x?=
 =?us-ascii?Q?ukcO3NXf8E4Q+LTTtvXyBUzqSKRLKYyfZ6SEQLceuQkBDsHJXjJU/oK3RLNJ?=
 =?us-ascii?Q?xJ+AhTBR9PjdMbriP3rSffmHktpyYQBB8CqTOXlwHBOrd96qRifHOX6peLkw?=
 =?us-ascii?Q?ZJJUTap9WsMV3v2yIQlBeTmtKuzE/lUkNJJP0QLFnV7aBPMh9mHPWSjmPc2z?=
 =?us-ascii?Q?fJ6NvtPpSvi5c7GS8TWDymVOF6Jw3Yjyd15aAI05vDnC0+cHrqtiMNQOm03L?=
 =?us-ascii?Q?GlSoLbpjvSbXkKx/B2ib1i7kLUEVGTPkU4JOnvQTl3AEhorcOwbheEM4vfGc?=
 =?us-ascii?Q?F+CvR/hJKaAv0Sui+eNXfw7rf2BLQLrs3dIB4kqDjCBrHCEuG26FAJLsX7n1?=
 =?us-ascii?Q?+0Ay5hiHLO+QjdjnowEdD4TeCJn7lZIucynte19QKt3+BLoyvaNuCZ/6Bgda?=
 =?us-ascii?Q?kN1DbIJLAxJJzRk5hgFhdGFR17eG5rhlOqE0+49PjlnLr+Vvjit+SAtNaAPy?=
 =?us-ascii?Q?gy8dej0c/qU5HFRV0FKhAMjdiZ0jq15SFDXvuhjTCgjk+YSAho+KLq4o975f?=
 =?us-ascii?Q?mv9N2NOVFr1WoJLKCgItEF4hpJUUuc074WqlEXpxdt+jTj9I6tD36j/kRlcE?=
 =?us-ascii?Q?onxlVDyqQaR+dM6ZUw9OPcD/8bEO0SqF8o95RCYtZ0znwCsEVXFCguCjudnO?=
 =?us-ascii?Q?xPQZ3HEKoR5wF26w6MxALK/15SBHYAaeAPyrovZfwYKN/7BbZjfACu9S9cdL?=
 =?us-ascii?Q?cqBwxhShg8WdPaWyPj/vUMOJASH3dpVJ7OoI+RY0hIq1bUAhLCPREDO/Lim/?=
 =?us-ascii?Q?LLMhG5FtU30gYvDGJQFe0GjeLMt5Hf4u78/kfn2C98cRmJA0VM3FrM+5p6oM?=
 =?us-ascii?Q?/OS0l61b2TYfvsxAVmx0z0wlC70AXaBUc9MK/PrIXnt46us4cX5eQ4Vpqqcj?=
 =?us-ascii?Q?cQQG+Ku7u9wQETzjvLnygb/jsmrXBKMQRvTjMamY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4543a277-cef5-4064-e5cd-08dc15ee0c8a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:18:53.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyCVu/WpuCMv9mQAdt7m35ZXHgy6zN5HgO+1n7s1kjKQu+43Hq5xFFQ1DTzQbcgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477

On Sun, Nov 26, 2023 at 10:39:07PM -0800, Yi Liu wrote:

> @@ -168,6 +180,42 @@ void vfio_iommufd_physical_detach_ioas(struct vfio_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(vfio_iommufd_physical_detach_ioas);
>  
> +int vfio_iommufd_physical_pasid_attach_ioas(struct vfio_device *vdev,
> +					    u32 pasid, u32 *pt_id)
> +{
> +	void *entry;
> +	int rc;
> +
> +	lockdep_assert_held(&vdev->dev_set->lock);
> +
> +	if (WARN_ON(!vdev->iommufd_device))
> +		return -EINVAL;
> +
> +	entry = xa_load(&vdev->pasid_pts, pasid);
> +	if (xa_is_value(entry))
> +		rc = iommufd_device_pasid_replace(vdev->iommufd_device, pasid, pt_id);
> +	else
> +		rc = iommufd_device_pasid_attach(vdev->iommufd_device, pasid, pt_id);

An ida is a more approriate data structure if the only point is to
keep track if a pasid is in use or not..

Jason

