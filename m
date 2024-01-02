Return-Path: <linux-kselftest+bounces-2590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51F8221E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92BF1F22996
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1F15AE6;
	Tue,  2 Jan 2024 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qt7Yn9am"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081215E90;
	Tue,  2 Jan 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn+KBMsxRu5K2v0sZouO7LgFQ3BWGUAbTlqV22NkNAuxB7JTjx/UZTCrlANtoCq2U5lplmWYYooxtcJlV/WsoN9VU9vKLSqPDKP+DWi/i6IiOK6GgHv0tg1chCQ7kG1fIIw+7P/Nq1I5JAMm6Fsv8sYhY22gepq2s7jC5YSBf3a9aotUJZevbLcdO7zruw6gtAL84Mq5kAaK0qgsW9h1IstKqC7eOcq1yD80oFMn+N1yH02wiPxzmjIz9iv5iG6Tt05Dorvfw7E0KiyuiBCtwii58QRMJu5WzYTw/CASiEDAqp4qqz6pBdE5fhHkKOmRh0zyti5biOaotTVAQ2kHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNUABVWxYIxsQdxnZtcViriWPqq+JyOuFyMKtn3cqbI=;
 b=ZDy047ZMXPAi3BH0iXaxmYEiJtwWVZjj7xZvk6449VF9XJqJmCYybDICQYb2LnrMrZTqiGf0M/LWA7/6119wNpwY3NpCs+ChtNBBniSYugxQY59URB8SItCfcKahUMhcixaY/gIQLk1HrNRfTQQ+5mU9tqIO1nvt30sUOB25lQhkExxWY0HdWeQjJXWyQ+m+IwNwq7KvonOdnIdCrYVs6Qdar+8zwwp2IvN/qi/fVmRPHVtMTBxbxyV3yPJoxtc22oO0va2pq4bTPot30LfMAno1W7gehS+lNo5F/XjrcgXlr65GVZpp0SzJOaWUisfjk8TCXp0jfBx5vpBMpufGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNUABVWxYIxsQdxnZtcViriWPqq+JyOuFyMKtn3cqbI=;
 b=Qt7Yn9am77bAa53Fep/wXrzyJPzavzk1Bxgw7j8llAvo4eSvbQDwJv2kc/7IsUDGI3DKHLu0xpHTk09MJWfOG4TeEyD/MuaBrSIqZ27tnN4nhK5GpmI+QtL2GwpUbl1YR/eyniG5pHiP4gylaX6VFQ1w4FPoTJBAMrfNtK57gPhLGT4AmHzaU+7da4i6b70v7zqyNjg6i7xsqHvL/8/TUV6SA/Cf/M95o3yCg8aZJiaqbLVa3N+XZK24Gp2xJ/Br5HFSHHLMyTQrF00t6JP/wv8FynfcsCf+yhRkEx6m3QRXxZPClncbCsVkcLEzlWoiSN8yUCZS8rGJBDOwRgtkEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 19:17:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 19:17:58 +0000
Date: Tue, 2 Jan 2024 15:17:57 -0400
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
	xin.zeng@intel.com, yan.y.zhao@intel.com, j.granados@samsung.com
Subject: Re: [PATCH v10 00/10] Add iommufd nesting (part 2/2)
Message-ID: <20240102191757.GJ50406@nvidia.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102143834.146165-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:207:3d::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb4d856-fa2c-4bce-2b9a-08dc0bc787a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ug6HvyNTE6DDWiUUPlMFygM9MBPGa9rYTbMQxaxjvyMlQKEsHYnM/a8ow2PL7fN3G2rSxJdNX1RfjRyaGEwLFWfzKm/6BpFmxmdYFr4GDsLXcNeMYtvGQQD5F+pmTXfdedW9iLy2x2bbJGh0s7k23WX/fYrijG7Y4JtrzqgyEbRw5ZFmjd66QV0lrEaIk978gYMobbpTCQ0UEgIuvrAqzr5xYnJk06gE2JozrhXTj2cTF+diL+uq2bAk+UiN1TGpURgPUrVXGXFbSbbeRhpMAtTcG8/IzRqiOz32WQFUghB4QoyRBWrtpSzK/EDbkLdmqoTde9STChaIW8Kc0PbJX6A4Ze89x4ZKNd/kZM/ywBbf/V5RGGSWnuJlPZ4CQ9NP3iqBl5uBHPotRx1t3ZFpQ7pPd/k3bxx6jmh4Yb7XPK5pZygkRP6sZp65u3QMBCXf0WWSTvdRgpfhBKtStKAkFxTbj/kaoyS8+oMWQGGewipbWSbtMzlSTyscv30HUv1TgRt1Z1k+QWVxSNB6nbajuEYptu9KZuSTqioMb6fTXUVzO8hmMV07yu99mukizE8u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(316002)(6916009)(66556008)(478600001)(66946007)(6486002)(66476007)(5660300002)(2906002)(4744005)(7416002)(4326008)(8936002)(8676002)(1076003)(26005)(2616005)(41300700001)(6512007)(6506007)(86362001)(38100700002)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rnfhdK1AqTUVCWfzYLmlQbYBd37Leoz48M8HFYuy9GsaPsTFxEe1H4IRygCO?=
 =?us-ascii?Q?FOPNgWbKe2tktymOvpM0u3yFvjCyXjEP99wnSF9z6K5K79ymLNIA6hJpBdXY?=
 =?us-ascii?Q?H8lvYC9SW6z89B8QkZ3MQmgHcV5d/njToIUaWO5hdcHXekgOCspUv2eLHtVP?=
 =?us-ascii?Q?I5LEznmVYUtBsfWDJWUkehHWfqkce6b36xHbtiUV+2LlBm2E/8x4unQKg0V1?=
 =?us-ascii?Q?YIywJn7cXKkOY34BHvk37hGZ6Lp1vQhh27O4576Z7beuiArCV3vXNF87fR3L?=
 =?us-ascii?Q?px6Fthvoddw4mMKlA91iSweCdo0z482JTnfPWOSyXKJYUOvPrC6/WwTRGYSw?=
 =?us-ascii?Q?Jp0MfSttI7bAPtNew/ual7z1IPR2/EG17qZ7lQcKU2gL4eVlrlZSSspb37Bv?=
 =?us-ascii?Q?o6FWAeFmNB3iuSW21Ep2F1FmH7ZsO6BnzmEhndXd6qWU41qN1PQfFC+EUahZ?=
 =?us-ascii?Q?Vd2f0nYB09ZSpSXH6ylscZ/4kGQs+CigWPdjuzEvwgipcwQMOdOMzykjrTN+?=
 =?us-ascii?Q?DEd+684W3/K6S36Sx6FYPEZRMDYzcN3DcOq1x0YGN5gMJgubUi8+afrovJzg?=
 =?us-ascii?Q?egQFFpKzqipZP9tSnxw0ukZiVg2x0ILmPHz/HmhSGmd4XC5mVln+F9NTZeSr?=
 =?us-ascii?Q?UZ955zMZvl+iugBcyURyaJEU4xk1YC0vS0piHDWEvTPAzzide8lYYMVrVN1M?=
 =?us-ascii?Q?9nwPmJ4wg6C+7gZNHpDsfV86zYgDHK7xnTxVbJEa0MRFCg9fhH+zRfA4F0TE?=
 =?us-ascii?Q?y1SG1ME8OeKBwef8ZjrlS6CYonwvyBbyTPSYVuVfrWUf0SOklWsb3Lb2mzB/?=
 =?us-ascii?Q?P2TT4pU8LUohBQAMTeeJwi0XtjOPfOVw3jl96gMdg81DM0iN90JXK5RVdmi2?=
 =?us-ascii?Q?VdNQKI+ZGw82G4JSVk4FsYGLisin6a5veX4s/acZpCnvzPDvzZwQU/xXljFe?=
 =?us-ascii?Q?dmurHAEIfuHlwOB9ed2GZsqsB4WkAqsV4OhMFtitAsWcSJljyiaznU1BuuIR?=
 =?us-ascii?Q?zKmpEBrf9MoEINdl9RLC13jzkIynCs/n7+p3K+LTLK8l2sow+R5Y5+uFljpj?=
 =?us-ascii?Q?8hQB8Kh3uYNtQX9i/5zsyA8InFeHGJGvu/07q+KNUSDhvanCojgm1O6qbXx6?=
 =?us-ascii?Q?qcvcbZmHeO+xpQCEPBlgxVj9CJw/Li8gFzrfSFhwm9nf+O3eVmIx7VqW/XTE?=
 =?us-ascii?Q?oJqTWLdrSZqJCXveP1g10jl/HcbxWkYzYv+GnO6LRzJlzYRIRhK9xelUq6yt?=
 =?us-ascii?Q?UZHP9W8g5783uTrCPN+LGS9rRqHIknyfcEigDbbQ11q1BQJOSAXj9FyE0T4d?=
 =?us-ascii?Q?LWFM4TIwzZIGfrBIhvSn5hrIeBgg1nPRv/oqKT38QpZoNhHAT4hF7HyUFkDw?=
 =?us-ascii?Q?np8aa86y7sgN06DyIPQsCXI62vf07Pa7vhiMQCRnkrxURWwcQgnKB5A6zkHQ?=
 =?us-ascii?Q?TfP8VMGUfs6Cx33+k1hH1V3ZHIRiWP5vgM4w3GY4oKil/NT6NzJJKpGJszVy?=
 =?us-ascii?Q?e/smXLVEi6+HJS8Sjv4yXUEzxcC4OLoLQn02MTDe5BNEsA6KPySR0H1cRgvQ?=
 =?us-ascii?Q?d9Nq0DcG49nciqeT0F1HKOTo2UJZb+/+wGNolrJw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb4d856-fa2c-4bce-2b9a-08dc0bc787a7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:17:58.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4lFgz4P3M4FJopkX52N2RzZzPg+wLA373WwjebvWzzOWgb25h2E/mmuM67jePpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

On Tue, Jan 02, 2024 at 06:38:24AM -0800, Yi Liu wrote:
> Lu Baolu (4):
>   iommu: Add cache_invalidate_user op
>   iommu/vt-d: Allow qi_submit_sync() to return the QI faults
>   iommu/vt-d: Convert stage-1 cache invalidation to return QI fault
>   iommu/vt-d: Add iotlb flush for nested domain
> 
> Nicolin Chen (4):
>   iommu: Add iommu_copy_struct_from_user_array helper
>   iommufd/selftest: Add mock_domain_cache_invalidate_user support
>   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
>   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
> 
> Yi Liu (2):
>   iommufd: Add IOMMU_HWPT_INVALIDATE
>   iommufd: Add data structure for Intel VT-d stage-1 cache invalidation

Applied to for-next, thanks

Jason

