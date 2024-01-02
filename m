Return-Path: <linux-kselftest+bounces-2587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE52822093
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 18:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0103CB21E2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C18156C0;
	Tue,  2 Jan 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BtT/bkPn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E5154B2;
	Tue,  2 Jan 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbwIJA4jjOXJjxgFPWM1YpJKQljBXNaRoSR+jNy4dFxeye3SG1BObyknjg+639wc7RzRD4IC5/DsZFoTf1LKo9xWCwgBYgutzc5hqd0N/a1iawSOuv2P7Ls+20xMDL8QtjPbVlWrEcSqsmGfzgji/DzOERyojcMza29ZTJm2hH04Ii6eo4XgR+qLOrIQgcoYFuXWWVxszUIpB4zkef9Xo+X4tfGqsPLG6wNyVgI5kJtRND84mv2OwQW6YOtf4PJhN6fUuuoo7qRLHkKHlTbjV6JI0O6bDs2D56tqoj38t55rEiVhUYx2mCxZKn1SnCQQw7MfjKbYwIJ04wZJ0YJMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUKDGRnFIPSJ0LRN9R4WG3OzHsTXLIeocX8kxVP6t0g=;
 b=M0p1c7KVRIAOyTHO0Q63PNMO7V1HHkGjdpTRYZHx85mnekugWkrUnl2d2q+6zVdZMOSqzdNwFtM4lXdOQDZLTe4Tq7ehYcQOnKZfZUlPfDJDtkINIOlbxcPaLdc1LEB1R69zuJDArpjy6gf75rC/HLwpagAyElepzKe7j1OxL8KyAY4Fy+CUfoHdAAxJ9ZEXENjs8RIg9fA43v7gfREzFQ46vl90cWcRK2a72BzyjujjVoJpOFlIaB10ojWSuOKxPvfWc/E6YTFplihAz4kqult4u1UFIEvYvMjYcRAV2eVIDBo25M+zP+wxzaU58w4EkfTs7XqKUDyVmCV94T05cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUKDGRnFIPSJ0LRN9R4WG3OzHsTXLIeocX8kxVP6t0g=;
 b=BtT/bkPnKyzugicjUg2ecLBfYAxGluOZkMyJik3GTBLMHoEDOAT+qn80lTXh9pRGsZds5AK2CIeZmVoYiFi6hGsSOuDEXaG+Jkqys1izs41JgzJwm4uNLNbWgQ4pCtASsqU37Az6tO/DMjrqGMzEvgt+O1+vIsCJOKxNyW8Lrs4JgASYQ4jfTU52m7jUDo9+Mmies21YLER5NWL52c2ZgViHxfDriryxTxq344M+NgAvUmEQA3V8d0IOVv+SiRqIMJ5Bfl/tbIHy3q0h3jiiitMcyY4OF85sAOk3VrMHZPHZ1N63sgzITncxSEMki6H16i94UfW46gRsyF1KZo2mgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:46:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 17:46:41 +0000
Date: Tue, 2 Jan 2024 13:46:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20240102174640.GA171005@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c802ba9-64e4-4ed9-200f-08dc0bbac74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MABMqP9OROM1UWOalIBn347H0uS0J/lOQC9lJIHoHbSm1KTzNxyibZmsvfrwTfNYPvmQxwGTqpPiYIhB97mBKoM53cZ1MrrdplSN45VBMKFajPjghEfv7Rpr7uJBbNlpYgZOCowb8r+AV3ajS0rNFvJLuUWD3fqxVnZ9dt+ptyuS7LrWaCW+1jkjK4+/X59cj4Vf36rhuPQCpeUWtDT40rT84fUAgTp9WwEONkzdcTvf283XoI+J/9RjkqLgPBqRDLTkZOZucZGJ1Y3MDObEeRVDQTFrvfJ8n5Da6AnOCpXiz+WIguA/z5PzTlTPBJX4BQJiZMyWTHD1feD7SONo7B5hFL9sSQht5tVu+u/6/EO416tIFmmvNaWFf5JE0eP9EZ4rKLZOkB1pv/jlkwLKhRMkqRD0Yb4ikkENdMWK5w5fRSlf9eXWCmXADx8YFNcMn/1qY49OWWE5MA0vIohKOtwAEhN4n2aTlt4R+B8JbRJJ1JkChYu6RH7KVTwbeWo/+nOy2uFcfR34o0xjOsyB2vE9PLerQnUTpj5jIVD6PN8MjxVWFintzQB360Ob/7yZJgOxiVhEki9EWAWhH0aHt941YAiyoD5CNDvzv7+yuFaEq2gbvmY7BU1Ia7DSaGJF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(33656002)(83380400001)(2616005)(1076003)(26005)(6512007)(6506007)(478600001)(6486002)(41300700001)(66556008)(316002)(6916009)(66476007)(86362001)(54906003)(66946007)(8936002)(36756003)(4326008)(8676002)(38100700002)(2906002)(7416002)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzjYOORsvPkkzDpdoRD+Kgi8Q9pD1fyEEsSDGT6YBzIzMfvndtiHLHy/heKN?=
 =?us-ascii?Q?gj7beS8jRUic5AOny8+FbzerLXjoTJHmnxp8kbwLUFqoNXcl626bNCZV1T1v?=
 =?us-ascii?Q?XBEsnVBSK7E2IEWhQk1wbPub1IKkRL7nVZ/dm9bzyzqUIVP0ihl7uLkmyKdG?=
 =?us-ascii?Q?1qEbJTPFFC9B7kmFdPPUmXZpa+D/rgjLSakXNlX66mK+DWQ8e8Sosi7yM3qi?=
 =?us-ascii?Q?pCF47oGHknTgEn0j3kxjYZpA62xxIAyrq7e7TT31wfeYncxQGjK4WOdkU5US?=
 =?us-ascii?Q?BcvdWlVRn4JewIiPo8aEGwA/JTccckWOjwuoS/7UDi8Z+n6VE1FDjLZ33vNp?=
 =?us-ascii?Q?JkZKs6hyc+puDqAMQZKDFUBmPzdwxPwbdO6TbViGbaaHVU2ufyQLQenFVY6T?=
 =?us-ascii?Q?cyonCVU7nzzGIcspjAzTg7Z+0pcx7/dEaBK6Im0U2GFGKCLBjtg5dmgsceYK?=
 =?us-ascii?Q?n63LBrpB0d864l3wafgcpU52oBo5c9yfPMW1oElrlncnUPOf00XiMlbw0K2o?=
 =?us-ascii?Q?pp3YpWFwsuAMegMNhZP/4u7y6Ixax6IBfAT77RdvM9p51ZxoDLN9nlqPFbIu?=
 =?us-ascii?Q?yP3CbslvLhsn1eU3h8ANkHHDis0WtCWFMseADnaSRWuwbDI84xZ8BAMw8xuY?=
 =?us-ascii?Q?YXfht/91EbsyZE3mKzayvNm4T1SCw5q0Q6i4M19UMAMygInvjjuQyayPeUcK?=
 =?us-ascii?Q?AT8cSKvh6mMvZNGxmDpW246uJ1d7LVArpIrGNxpadZ1BJRLrGnWe+S0QzDqX?=
 =?us-ascii?Q?9j06i06HOMaTkJpOy7LMR+EYtFp2hBsBYQuIPmek9Wk6xihy2izuBLGrKXai?=
 =?us-ascii?Q?V1xITc9cF6dwqSTmcVn4SNxuIGiT4tvBT3dUYWx6yOYJHGoOkbLZyf0rYtxL?=
 =?us-ascii?Q?cUCyFF40m/97fVkfTCuJYz8z7Xzhi/qJrrg/5ExIx9k6Z15AEYAR0xuFRxFs?=
 =?us-ascii?Q?YvP1jzVQAfmmA18Q2KArgPz//s1PSLf36Q4VXQOjuFjPbwoAKzFw1sVdDQwa?=
 =?us-ascii?Q?wn6e4ySqzdsban3eAUZtAkLE2zmDZoD+XtTJv6S62C++QMfuRvmc+JNwCXOo?=
 =?us-ascii?Q?FG3OhRjXVD3d6S6sXFo22SbGVEItK6HSfDC6eGiPPOvAWoMa/e11iak/5lPc?=
 =?us-ascii?Q?AavctH2B8h8r98I5hR94vFSXf+x85WMCu2jPu221MiAfw0Q61aZlGncEz1nN?=
 =?us-ascii?Q?izvo7xyuG2bLVgy8OGwdu4VxLJCancUO+rW7z2MjtIQtK6FwAlRFl4/6aFYt?=
 =?us-ascii?Q?uApUOXUETDxFVNGcd2PLkaIbvLGLXhqYEkAgCK/nK3dV7pSNqHhg88BQzwZP?=
 =?us-ascii?Q?kXG5sz9Es2lV0Ba2qCZ6HLjE55kKAoxLcel8pHdhB2ICXX4jHBounzjJbBHv?=
 =?us-ascii?Q?7aYpSXDqVk5SbIVBBfimYRTUvaazbVZ5WxxU4W4zF45BYWO5uDPMlCPTROtj?=
 =?us-ascii?Q?n6Wo0YUBaFzI9C6mcgxLXNnjOM5ArWog2uLcNmIhCwCDVbISlp3hrfikANb/?=
 =?us-ascii?Q?ZBTvtvIYWt3d7TGNRdvpMkACzslAoUbwHGy/uRaZQF0V0d+JWs5Enns3Ss6P?=
 =?us-ascii?Q?6hgsNlepFQ1lz05fPeE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c802ba9-64e4-4ed9-200f-08dc0bbac74f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:46:41.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htsGWAgAth3edLmxdFo3T680mJ/nP+lfCBoa0juL/3I3f2iitjSfdjuVg9vOpz6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405

On Fri, Dec 15, 2023 at 01:50:07AM +0000, Tian, Kevin wrote:

> > - Reuse Nicolin's vRID->pRID mapping. If thevRID->pRID mapping is
> > maintained, then intel iommu can report a vRID back to user. But intel
> > iommu driver does not have viommu context, no place to hold the vRID-
> > >pRID
> > mapping. TBH. It may require other reasons to introduce it other than the
> > error reporting need. Anyhow, this requires more thinking and also has
> > dependency even if it is doable in intel side.
> 
> this sounds like a cleaner way to inject knowledge which iommu driver
> requires to find out the user tag. but yes it's a bit weird to introduce
> viommu awareness in intel iommu driver when there is no such thing
> in real hardware.
> 
> and for this error reporting case what we actually require is the
> reverse map i.e. pRID->vRID. Not sure whether we can leverage the
> same RID mapping uAPI as for ARM/AMD but ignore viommu_id
> and then store vRID under device_domain_info. a bit tricky on
> life cycle management and also incompatible with SIOV...
> 
> let's see whether Jason has a better idea here.

I think v10 is OK

struct iommu_hwpt_invalidate {
	__u32 size;
	__u32 hwpt_id;
	__aligned_u64 data_uptr;
	__u32 data_type;
	__u32 entry_len;
	__u32 entry_num;
	__u32 __reserved;
};

Sends the invalidation to the HWPT which matches what Intel wanted
where the entire HWPT and all its associated devices are
invalidated. No seperate per-device invalidation.

For error and event reporting they should be returned to userspace
with the IOMMU dev_id indicating the originating PCI function.

The VMM would have to convert dev_id into vRID according to the vIOMMU
instance that the device is hooked up.

In iommu land we should never have a "RID" but always some kind of
device-specific "device ID" which is the index into the particular HW
table, and that ID is naturally scoped to within the IOMMU instance
that owns the table - so it is very much not a global ID that can be
used alone in any of the uAPI.

The uAPI should use the iommufd device ID to refer to specific
devices.

Jason

