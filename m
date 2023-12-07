Return-Path: <linux-kselftest+bounces-1359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9980808ADA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17113B214F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A31381A8;
	Thu,  7 Dec 2023 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e6fAFflG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9437D53;
	Thu,  7 Dec 2023 06:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEYWxN/fNL2EjtNlBv41fXlAT718/rqdFYiOvkDoKus3+ykCfpTsInIM5JZBm/fWtx+ZX45ibSwZOFMsgD6MH3QcdIbeVxGsSc7pd9MYbWfJjpuY5fBbJlvQq89l9vmDXQ78h46sKW7QQeGtCQURyaENACoUbxOTcIdGKe0TnRNJDZSEdLLyNtODeaXBykNUqixVgkepWu4l0lmX7bnNQDRd7Kllnopn+ItXgOdkZsJY+8lv3tzV/hrsZcE/8KsauyXPILFiDACsKzRyuSudStRw9lkmNDDdJpqifE6EoYYCPGzM1U+NuYnjVmMne0kpMh7dhqDq7bPlrgROOYq2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKhvPSdvzrDJ8L06qefECZsfLRSUIR+cIod0WsOCJlQ=;
 b=hWXVfGlXmXHBc5sjyOtkA9Afsg9qrjal1d7igG0v9WATPBVuu6hXMQwsjt5hmC8660yOm0lxAFoJXI8UoitTYn7pNKB5AS2rmcb315Ua5A9Xde0LJYn/B0a3NGvH7vItyCPE7Zjd856faIYJnsEKm5SuKr7ZI8HIH0yCKt3kGYFzF9qBPtHP8J/J9dhKjzKFb1C9mamhJ5YLVzrZmRLUsXU5MBv0QxDTAnhRGN0DzifCBtb7p9+9fqyqEmodhQUK+X+K9Do19O7PFlsDJeXwiqsKwSp8m2Ca4vRdnnxrv66u5wHsMB4q48AcLWH1DAm9CX9L+EfyrbjXW3W60Hjs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKhvPSdvzrDJ8L06qefECZsfLRSUIR+cIod0WsOCJlQ=;
 b=e6fAFflGPencBAP/frgnHJ0IPNG04cGON0leVfIwbz43ldwkn11Rjle3Zr3A/aBtQu9YdfVRz2hMTN/VxIsmLxwiUH3/R8PTsqZuwlVzsFgtRDWGxbXGqATMEEA5sQiL1xnmSz90la2mWAHfdkYR8uUOLJ3wMZ1p6oOx1jR0z6dNKhMSyNR2L9LtqquKAjh36b3XY1GA3y1adbdlAWIf4yubpJYP71fQoS5BbNorNQdmO/ebmYJztuJrgVhDmKvlc+4cKnaen14NGGFjjILQRuQx3lsWOia8LCAgkDPszfCQYxFkqtFeblDlMFmO9YRIoQW+/HA4/1kBe99VJqY4pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:42:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.038; Thu, 7 Dec 2023
 14:42:09 +0000
Date: Thu, 7 Dec 2023 10:42:08 -0400
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
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231207144208.GJ2692119@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
 <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:208:134::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: e46bd89a-11e4-40af-49f2-08dbf732b10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QwjYCA18zd4APSJJhPDlu2jUuzPiycwTH3yMV9vpoPvPvvyYJRliptfjBc3sUWV4Y/1Wm+Xnodus4yV1OCNvsM0vDSvbxXPTi4mJAjm6sR17itzECtw0LABF3COSp5mjIzPGLTLEjO3JGnebTeTw0f0QDVMqm7H6Xg2a3l7F7kS8P9FgiWsfp51L3sbNgTZDp5SAYkkMMXpqpPV7170AoTZvcNK92xqtAF0uqEVRp7YJ3YfPPE1/ulF1guapaSZc01PLhDZbCIyKwlf1uRitz/gnUm2b8Urgi/IamdhOOYb0r2aLCMHmiA9F2GgwEtOhI0Vq3V4HYnBpHhoRJiDLYWl1OiobBl2571GbYsAjU11A8wVbB8asWrTaZb+iWgcK6BkT7q05PMybRW3ikwmXiZFyINdF/8vHs1oxX75UBmBtlhX+HGAAK9hEn/YM05hJzQvCeD4snSiczeDg66QssNXTlxM3x0raXy3RdMzk8Uvs6WswLnyImuxkz7Wpqc+nfTkPPEPcFFC4CjukxIaary7Pei4eE9d++7zinp8/eOcRGANHREUJy+/dj6AyW6hB7jkqchXZloYXZq7t34ILaDcv47AM4wGgAAMH9EZatgE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(7416002)(8936002)(8676002)(4326008)(5660300002)(316002)(66556008)(66476007)(54906003)(66946007)(6916009)(2616005)(1076003)(966005)(6486002)(6512007)(53546011)(6506007)(36756003)(26005)(41300700001)(478600001)(83380400001)(33656002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OwJDY2E8CTZwaMikKnJ/XbFHN1/BwfmCgWEoKT++/dL7w+o1XHW1R5I9oTvM?=
 =?us-ascii?Q?3ZQ9zZ3AW/vZLG0NyjRKA/mFBENOvQVxXW4XPBUDCeyQh3QAsMCN/urHOhEt?=
 =?us-ascii?Q?O8a2e4uBG9znYhOJ3nMn257NlG8A66v22YG9JgzHxnnOgrCQostyDjwGxE9c?=
 =?us-ascii?Q?jOV5Lt0+1CQpcDniaWmjPsTcJfSRyxACiCbM4S8JQxkclB+LsO9lVXjOQs/V?=
 =?us-ascii?Q?4b5osiPcg+RgjG5AXebAmgFbhVMx3rzJjEU0g0m+w0keJcxdarFZ22nuHxnU?=
 =?us-ascii?Q?1A0xIWdQj7ByX2XTPE9ck9el3ZiW5uONixXAq4tx4L6a/uH4uzVHbHRr3lIP?=
 =?us-ascii?Q?ux32jKoydT6gy6bU7XfPVB9Bj4Syy6Gil1Z+dJSHTD803Z6CPIgmdEN3eS4N?=
 =?us-ascii?Q?2zVwAHDQKARZqBJ8BaZ/x/P/r5tEx7AyOMtwutZGNhr3uwvaNujpttRMoHrI?=
 =?us-ascii?Q?K6RKXyNg8ntp5wMXznChQNWcEI2NtY3by/iQaIyN589ypJUwVLmjdHmDkM0V?=
 =?us-ascii?Q?yCYKFLptb9HpiKRZn4RDK/IOl1sBNH0aCXBd1ZdbAO0tHqlcTMPIELxWTJdg?=
 =?us-ascii?Q?utKuOIbL2kjhco5eMGW71zbJ38Bn7T5NFO7XSXTf8a/abdQiPb8UqN96s6Ws?=
 =?us-ascii?Q?MDtvlgVfDqxoc6nGbOtpS/ZZV5tso32+s2RwQuFNMqkfhscKMD7vIaJFOGg2?=
 =?us-ascii?Q?CRpPCEGHw1JSQ5HZ7NGedVFLHjKFE4H0EGIAxEuePZRzAYQDYehl0F0clhGj?=
 =?us-ascii?Q?SazBM8YXXWziyMYp0VSz8mIdkFvFLxSstUnoqGOvuPPl7Lq8nm0q7qKJWu5V?=
 =?us-ascii?Q?ZrLppmwJHJp+XuaM7r+D6K9rvuzzfsDGiY9KFJxH0erxkQK5ov8JF6YfUnKa?=
 =?us-ascii?Q?RatMBmXPAaLwlgUcyWdIV+fANqX+J+5paucwOJWDLBEoqbfswIvHnHl8toeX?=
 =?us-ascii?Q?FWnSIZdDVL0DO6AVQfbLSoIUoKv2l3AUt1vqhuKWUmaNcDhrx5jUgG5TWipr?=
 =?us-ascii?Q?U+d2QUr5JRsk74waVVftnKEYkaz+2ADHiQbx6dKrqOCTf7D76ZbRlPVVfzLc?=
 =?us-ascii?Q?E6Ty8eAg//YLDxz8sPzIypNSvUdhXGtlX45BxbRJWJenHbCeZAihJ4PnAOQW?=
 =?us-ascii?Q?ucjBeOOwxNbG1Nm+AdnmFwM7zHp0oMtnjujjbYedb6CtTviGpgTO13WcW0v2?=
 =?us-ascii?Q?u9DbnFDyzMl2PeSMgwSmy75Rel4/3ayvwtxfGZRY40nUOhRI+pTKxJzCY7mE?=
 =?us-ascii?Q?j3FKNvOoKIRCuKOIHYoArf2BqVhlmYk3y0nHuRyb3T+lOjy0RGZYpjIKTxEE?=
 =?us-ascii?Q?lReBORkAWKrY9GW6WelsDOyqok0SF7G/Q1eE4PBLmJOc++YXf0F0Ay7rd/xy?=
 =?us-ascii?Q?xJgtl+7V06lq/n0KqE+mIyog3LJ/gUB6pygCtIVW99i8jPolL5ptWmEzDBXu?=
 =?us-ascii?Q?crg7Qi68gnIodpbCbPE1kqNU+IdpG1RcF9jLYSQEBynkSUEmb1fwcqxNIGQ8?=
 =?us-ascii?Q?HulacrHIbsQmlRYGWs0mqjtsrvVAGbkSLUqa09ot0hXbsnWF1RHPmBxMF61q?=
 =?us-ascii?Q?o8VC1Vb9yOMsi2JvuLKXU95AMYpEdLUReNRVDKm4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46bd89a-11e4-40af-49f2-08dbf732b10a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:42:09.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5qSEPxXNUOMYgikeaY69aPfRxJd/l9dKhsmFmFnoDBWP/W8H7uWtJIFFDMH04uq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031

On Thu, Dec 07, 2023 at 09:04:00AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, December 7, 2023 2:59 PM
> > 
> > On 2023/11/17 21:07, Yi Liu wrote:
> > > @@ -613,4 +614,38 @@ struct iommu_hwpt_get_dirty_bitmap {
> > >   #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
> > >
> > 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
> > >
> > > +/**
> > > + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
> > > + * @size: sizeof(struct iommu_hwpt_invalidate)
> > > + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
> > > + * @reqs_uptr: User pointer to an array having @req_num of cache
> > invalidation
> > > + *             requests. The request entries in the array are of fixed width
> > > + *             @req_len, and contain a user data structure for invalidation
> > > + *             request specific to the given hardware page table.
> > > + * @req_type: One of enum iommu_hwpt_data_type, defining the data
> > type of all
> > > + *            the entries in the invalidation request array. It should suit
> > > + *            with the data_type passed per the allocation of the hwpt pointed
> > > + *            by @hwpt_id.
> > 
> > @Jason and Kevin,
> > 
> > Here a check with you two. I had a conversation with Nic on the definition
> > of req_type here. It was added to support potential multiple kinds of cache
> > invalidation data types for a invalidating cache for a single hwpt type[1].
> > But we defined it as reusing the hwpt_data_type. In this way, it is not
> > able to support the potential case in[1]. is it? Shall we define a separate
> > enum for invalidation data types? And how can we let user know the
> > available invalidation data types for a hwpt type? Any idea?
> > 
> > [1] https://lore.kernel.org/linux-
> > iommu/20231018163720.GA3952@nvidia.com/
> > 
> 
> From that thread Jason mentioned to make the invalidation format
> part of domain allocation. If that is the direction to go then there
> won't be multiple invalidation formats per hwpt. The user should
> create multiple hwpt's per invalidation format (though mixing
> formats in one virtual platform is very unlikely)?

I think we could do either, but I have a vauge cleanness preference
that the enums are just different? That would follow a pretty typical
pattern for a structure tag to reflect the content of the structure.

Jason

