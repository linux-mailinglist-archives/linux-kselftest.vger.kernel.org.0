Return-Path: <linux-kselftest+bounces-446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFA7F47C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F15FB20DC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EEB54BF4;
	Wed, 22 Nov 2023 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FP1mcTsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9123A4;
	Wed, 22 Nov 2023 05:25:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/LZqKt7C3p/0HuiU6kacgXt0kFF78YEBap0KgReVlEN96FrJt0K9XlYIgBf4+xZnGNLv4nuAefr+td2mqDywT+MAYe5vHb4ILIKIGOIAl1Tvy9BAGAFI53ZAZV3NjeHUIRwU69FbPwz7R90MxxHEuH/EQLonTW7xGd69inPfvekExrm03ffDxqHuzsKGSrWuD8YHwn9xwbE1nYEooSlTNxpr2LsXWy/JBZaUm5okRjqn3ZSbnZD3ceju2schJ5yEpuMhJn2VOmyovY5SQ56JkM9NJSV2tHqYHlSjdNMwTtid9UzoNnfVmCOA893MRPzV5AlP0l52R+hOjFwIkax0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w24Ra49JXgOydbwwLedm69393sWs+rQMlATbVH3Ou5U=;
 b=k8+Yv1IGQialz0qOIQJjriP1bKF2vjpfsQ0grRDFMCpG+KVJvfIm1IhgOfLjZm2z1cPoLrc5cSDqLfTeUs+3dmjNo5p8Bjezwj1XVBpY9GP7OhqXeUFKTe0m9AuB8y95QCF+RZNNHXnOCczp/qqUYu+fTCJYmyCV0R9TrmblbXN4HmBvEjYtpkUCy44cbHw/GmcHYwrOH5FmCLQky2OJwFIFXb7ms2wX5iCFMzIFlBzwqS9LpNHH+qyabr/DeEsWQvMcMH1Sx7xevc0rf/gYcRGVp7biqqRPMRr+7JIoaygMsYnd7J1JluU4qj4B1z4ggd60gdMo1B5bw85dEaoF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w24Ra49JXgOydbwwLedm69393sWs+rQMlATbVH3Ou5U=;
 b=FP1mcTsBPuijCrEQ57S1JsnNrqDxeYh1SwUmzQxeUZT7QeUFLgos9fncBPp86HDnOzKKT4ogH1oC/34H7W5JIquarB6JEKo0Ba7e3BRRjrh0OU8RpYbsSDsPvffQrPTbl+EkffIWljMXaHW70aIpLaKCtoVCAQ+a/ncUphAtRI9VHKE3sx6G78qcphCMK6xFCiznBNgLJOlRplyL0wYM+DZt3+edJ43fd+03t1ztOyDNN3SatP+WrlPYhswc2sZFxJDk5R+eKZLnVEoywoqcxBcjZtj6biKiWI7kJeqKqZ4yjNrDjH4ZZwRWarCO6SoXISXk/3MgAjXd8c5p/GzOIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 13:25:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 13:25:54 +0000
Date: Wed, 22 Nov 2023 09:25:42 -0400
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
Message-ID: <20231122132542.GM6083@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
 <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231121121704.GE6083@nvidia.com>
 <BN9PR11MB5276BC5DD9824923C8A3ACC18CBAA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BC5DD9824923C8A3ACC18CBAA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: DM6PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:5:134::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df2412e-39bd-49b4-d5cb-08dbeb5e8e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hvbZUO3qYswst4UVh5bqlE1JGRBOEIAq2c4XrIL/cs3L95i5VxppBm3gVAYqRVhnYjFjfOOI2s0/hHsbpSLRXvWJqwl8K1jM30BpEfdXtDjDS0coy94h1LF4pE3peU2OPyOo7Nf+ukQQVD0ZS4haK5XaUKwxbgHQyTvNacp6ybsCN6YZ1HQx5pKav7aucbWM2pV/0fny0sn1cO9SNCiiTaRXRYcE1wg5oAWjVzojDzgwnLtMVZ/2/kBU4QTlN06W9mo45c2IoQmtqUd918J4hvcSZkkOfapUOtg2R47IorK0H+/DTYM3LojFDNugAdloFZK5vaxlUXVLXkfsU9zSmRIgh311bAJ1SAZxUh3XCPIEFhG8VLfVZJUJrrVwYF7kU60VLq67N22Ptg2OixqgFBZ9S3LHVKAbcsGGFsGNe45ze/PCaMsTdyCpKGJwzsG5qRikpKcRmNzD+AZ0f0CQfsJNJFdCAoQ4rgHKFheMJirKmhZhtH0rGbGjzOsPjcpQJGPA2+Z7YvboGc/7CxCbQJj3L+JVTCpOAYQVM0Y4lvY3p5tVoPpIy4akrdWc9+r/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(2616005)(1076003)(6512007)(36756003)(86362001)(33656002)(38100700002)(478600001)(7416002)(5660300002)(2906002)(6506007)(6666004)(6916009)(54906003)(8936002)(8676002)(4326008)(66476007)(316002)(66946007)(66556008)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXXEeBsKIfkhucLXkGuWjJ/SN8EQkINu5+BURR8zZoHVb17brKljLXkuMsZm?=
 =?us-ascii?Q?1Wb4ktx5sfY9atsbQPcQHLmXL+aAvUBg1PpYPQrpCm7JF+UxqJ9w//2/Ol/5?=
 =?us-ascii?Q?PqRJFfh4hl83yXy4zA30fSQdR43kXGFofG7idRX5XoyUVRIofGBKmxrneEqn?=
 =?us-ascii?Q?Q9Qfp2hUDCZDUgP4fgCSk/83sASfcI1DO4Rq+F30SwxHD9HLM0DCpdQW9V12?=
 =?us-ascii?Q?e5D1mXs0sTrC6Avl3OvuH8+nKBi7NpFTOzaN/f1b3ih5Zu8zD3eWKNK4XL0x?=
 =?us-ascii?Q?7NPkkNhJHdKu6zwWlm/M0i8YbBBhX4NNBKpx+sWah7h6cN5ss+Dvfgqg/Yna?=
 =?us-ascii?Q?GM4mjG+tWqSdI31Fkk7frywQJgV+rijJQh/20C3ChtC70Kj7+km5ZMr+qUI9?=
 =?us-ascii?Q?mkE+G0s5+5MmwGmZGbq9HnwdlJin2wOj+bsKOoBhsImrYUONzAnfCDs4fqpb?=
 =?us-ascii?Q?DtlQtewOWI6xXUq9vr1KgNADOWnNQPRJSrkuIdwfIdVlyXOZ3BaRtZbwTTUH?=
 =?us-ascii?Q?MovcdO5aNcOtVCXcldEv347m2mQDeAvFqQqZoOvHPCUkki/6mZRR0RrBR7+A?=
 =?us-ascii?Q?2rnoGO76ezuakWVjH26g7SpNFzVM4Mei+Eu2ZKQ+2+qsY6uHnf1qjZYbolHx?=
 =?us-ascii?Q?+IYm+7/4MslouVmeEgNjKVfvlkMlWydzcS0aDPL74I0aRojkSJrHr07HMQK9?=
 =?us-ascii?Q?RNSZ8hvruOZdNzF9P3Vh9PNN3j2+0M03VtDRQFKqaWxYISluE4n6NcBxcf9N?=
 =?us-ascii?Q?jb0QOVamxXJHistKiZNXrHnqZj8cKS9Ykxey+1TgiezSrCK0EevpXI1YxqwB?=
 =?us-ascii?Q?/uAN3Obogv4G/fpdrE74npK/i+IZVoymrc5IAStlSp9UVwV7sONCxVBFzAjG?=
 =?us-ascii?Q?HxwAF1rKyTGVn3Sn25SiW36CKF2ykx7GM7heSMWjNArgDtvLKI3RSF+w99f6?=
 =?us-ascii?Q?QgyC7cJgh1Pl3RTQLrGJ1McUMPmVHGZe0+QE0ZHccjof20enM0OfpaZBx8st?=
 =?us-ascii?Q?zcGWsxYLaCaHO/xAEqcWfLJkhNEOExkVxoHB69OmuiVFozt8paf84CNdIcUk?=
 =?us-ascii?Q?D122C+VmNqLS/LIdS0+KnpHG+Vq6VXWr3bb0C/nuwi9+CvBuFMSECseZKIlh?=
 =?us-ascii?Q?IoxFqcPWE3NGbOA43BS447dIhg2itDkHS4GAdibRcrn5u49fCBCjTxZx+9AN?=
 =?us-ascii?Q?ZXXTqg1Tjqht5cFSWi98dHl7sZUofS2X7ZxTTjp7A5BVexIaMDNCqzNch05t?=
 =?us-ascii?Q?OFEhjv3xcTHv0bShibwu/OPFhRwiI1y5XXaVgs27mNPW6S0ziFKEZR9KiFi2?=
 =?us-ascii?Q?bmEdGZp+myrsxM0OPUEiI12kF5wXQQOgifmqFZtRZOJzzuE18aCdLNfI1D5K?=
 =?us-ascii?Q?Pd//6ccurIgKpnZVmgGNcYdHs9BUvo0EHvMETO/UYo3+MkQXCdTpB9wBok2A?=
 =?us-ascii?Q?UW86DWvRQBlUAg8Jxv3cLFj4vjRcbvpKfbizdFI5xnrRoJrBEsF7s6J8Y4cO?=
 =?us-ascii?Q?8GdOSSj5FrWwcHfLM/j52D7SDVZxW6tFfarrfyohv3rek+d2x+UYkgygD/W/?=
 =?us-ascii?Q?oWiDuOofXNbnJeEmva5AoYZ6FDTKGPi+bplFk6BW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df2412e-39bd-49b4-d5cb-08dbeb5e8e08
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:25:54.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A83jyfTi0CL4TauJjKee4PIFrdJ63jLEJnJAfotuIt1+VSHmPP/72CtPrv2Uishq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907

On Wed, Nov 22, 2023 at 04:58:24AM +0000, Tian, Kevin wrote:

> As Yi/Baolu discussed there is an issue in intel-iommu driver which
> incorrectly skips devtlb invalidation in the guest with the assumption
> that the host combines iotlb/devtlb invalidation together. This is
> incorrect and should be fixed.

Yes, this seems quite problematic - you guys will have to think of
something and decide what kind of backward compat you want :(

Maybe the viommu driver can observe the guest and if it sees an ATC
invalidation assume it is non-buggy, until seen it can do a combined
flush.

> But what I was talking about earlier is about the uAPI between
> viommu and iommu driver. I don't see a need of having separate
> invalidation cmds for each, as I'm not sure what the user can
> expect in the window when iotlb and devtlb are out of sync.

If the guest is always issuing the device invalidation then I don't
see too much point in suppressing it in the kernel. Just forward it
naturally.

> then we just define hwpt 'cache' invalidation in vtd always refers to
> both iotlb and devtlb. Then viommu just needs to call invalidation
> uapi once when emulating virtual iotlb invalidation descriptor
> while emulating the following devtlb invalidation descriptor
> as a nop.

In principle ATC and IOMMU TLB invalidations should not always be
linked.

Any scenario that allows devices to share an IOTLB cache tag requires
fewer IOMMU TLB invalidations than ATC invalidations.

I like the view of this invalidation interface as reflecting the
actual HW and not trying to be smarter an real HW.

I'm fully expecting that Intel will adopt an direct-DMA flush queue
like SMMU and AMD have already done as a performance optimization. In
this world it makes no sense that the behavior of the direct DMA queue
and driver mediated queue would be different.

Jason

