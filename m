Return-Path: <linux-kselftest+bounces-15674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF98957303
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817631C23810
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54A1898E9;
	Mon, 19 Aug 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C9U1TMzJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11A15ADA4;
	Mon, 19 Aug 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091652; cv=fail; b=n+84IwjPO1RDulrBcHj2Db3oCQyFOl76mgIxkaZ9iS+6F2yn7lRgzYmHp5bdxYqfjqdG/PK3pf6PQfhx1xXp0HIMvH2USVgSks65+i+iWd9v8xobHFFo4v18E9s3XHM4Y63CIp19G1ao4u+j4sAb2JlLp5npedtSw96/Lb0ols8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091652; c=relaxed/simple;
	bh=UQ9sV1mi+B1xHPcB60zt27I7D6MGMJGIPh3TGy06T5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OgOm0UWFkL0tMC2Bu9QuTCe2uNT/9rE6pExcb9puxuxxQJX2kKD80jdxuPcZEIApDeDxqQQTYIF5iULz0dSRMuYjDtVsLHG1Sajl8n9lUonIjTxWMIqdMWWS9MqEnLl0OHrGPMZjrr0g+GmYTSrCKeYM16NKAKwHZ8F523lQMb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C9U1TMzJ; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flrHzpgA/h7qlsDdChyLf6/xkO3RW0FrdKDKyxlsI7zSanpyOMbByLh441gGP+I0FrRTgddQRD/4VfTe6tvU2S1fchgHZmatb/mDr4T6AvbMh5qKttGj0OS6bTiFEMEhND+7czK8a2YYA99Ly7pJOGLTLphbJUFW7xykubzi8dHtmQED+3X1fqMm5ViBZa5DsRq/fEe91JAvkwpqU6k6LeCTG5lJRCYxRtBN2MqkdYJwNjS75yNlH86bYnDcEMsgd8NjI4ytblrd/I7l7CrJK1wjYJVd0hzOii5GAJiBIg4yRDbVD2JvZITOzoeQV+Lp2I//XnZdlYTBtkOQWHhd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Nrf370BajiAmouMDT4mHQ9cNu4RPxnJLtAnImabnZs=;
 b=tAJsZoTBf6w2QdrmcuFBwfw1JW8CjZPoaYD90uY1AXx49sro6RJWLjpKT2Ztvwyrqih/Kjx4crOvqA5shj5/C1izwdw2ukwv8qtztNptV9fF6b0YoIiMdEEpR6t2kiwi5JqsRfoPREVSTmnLT9SIIBTutrNlZLX8V0l3ZEADUUvfpQFxmDAUOpVmW0ZbBCAtit5A/rlDgAYnqn1n+jvaOJp4L5LvSpNANP3Dir/J/r2yiKtZWGWIbCpsomoEqjxJ9xChgj5G/qIO2zdor02lNks2t3mkRRi8MIQbdBAfE2LykoZAMm2GPJym0BzGI5cRqZCEyxWi2wSKIZNsJs7U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nrf370BajiAmouMDT4mHQ9cNu4RPxnJLtAnImabnZs=;
 b=C9U1TMzJTMNyKAmez1a8J0srjlAiad2PuuxKYrt3eZ8aMdqdotc5Brda63DwySFWeOsT1eR/u2j2IPOxeUw+9Of/ceaz7VEBB2Y1YO/PZ6aJrjz6r18lOTUvK3hLhbFw00VxUAYOF4QhfXqeGN+KNvFNB8GKWHG+25quVE4el2j65CTgunUodJkJW7PiwrhBxCt5ijIVe3clrFYE7TJTaV8s1kiW822uYudUdgrpVNNjdFN+CUgHVCnQkzGo+Bjorx7MzAa/RDckLElemH490Q2zR2JmXq7KRj9krWpnEg6AhtFGgeRyYEbEqYofys24zm5CuRMODyKyxEVUQ58Q3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:20:36 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:20:36 +0000
Date: Mon, 19 Aug 2024 15:20:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 08/16] iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE
 ioctl
Message-ID: <20240819182035.GP2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
 <20240815232405.GU2032816@nvidia.com>
 <Zr6Ui1NBQ8078hRZ@Asurada-Nvidia>
 <20240819173056.GL2032816@nvidia.com>
 <ZsOFxI2aItINttOF@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsOFxI2aItINttOF@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:208:2be::10) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ad9822-024a-42dd-8499-08dcc07b9ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KuvZuyaWZAfk97N2UpHKEXNgIl15EHkagTphfhbpBgfrSdMGxjDeMAHzN6Gu?=
 =?us-ascii?Q?WmhIpsE6VNGR4IsC00oBPrDEgEWaGJFmbVIyPoDlHrynAYW2ZemEjqPbnPgx?=
 =?us-ascii?Q?5CPn1utwtI0cIyG0upRniueWIIL9iPw+4VbuM9YGf0CLbUIAVrVkEYjZ6iiR?=
 =?us-ascii?Q?zdLoTJfbT4ZR/SZ1K0UZTzKpXtQZS7QHop+hxVV6VMat0Ge8lghFRSaWSPKS?=
 =?us-ascii?Q?vzVAVG1H5VtONLT6bX8BQbmuspRfJjpK30mqEv3p7gvBSlYYa/8sgHQBn3IF?=
 =?us-ascii?Q?Z2NFnaLjv09OaMYLfI+XNXJnbrp0TbIBVnQKOytD9Ckt2ATEZi/Y81VGMClS?=
 =?us-ascii?Q?FxnAXjNdOGGgASrWKpmV1NjgWNxIjBSzpUfDfipCPZkxftgzyIkVz0xwmjyc?=
 =?us-ascii?Q?V3nNNlECsoMKMJgTsVTZO1jHsM4SqCFYKb0eKT2nR3X6ZmVWPwoo9m/1d7xn?=
 =?us-ascii?Q?bVvDPnYf3WTEabOlvZrLbT7MNnX5qWspYQpGQGkKw4eKclW53kJd30uSHyBZ?=
 =?us-ascii?Q?jTxhtLuPrjB3fHXe4GDbu5h/bETGGhX9EQH0wgkJDKgyAd0n6Wwe/dlvqTt8?=
 =?us-ascii?Q?ddrPzir/RqxPZt+zGviqMdl4oEM+UA9EdAb/a/ep+EcJJtge35nO7GyzbzSu?=
 =?us-ascii?Q?r8xi/ETG5ImX7N0s7bbcyOdEhWju9trtFSvOOdl4gzSxE3TOGN5omAPSM47h?=
 =?us-ascii?Q?2fLyroO8s2Msx5MRdW7QN12qNy35s5ccaaCkftqET26GCpc6TMH7GlqyjMuq?=
 =?us-ascii?Q?Ol4mGh4ulnrCzu5hn1FsCQSqxwm/1veHo4LlgRu2ptb5hjJfhpyCpHz1IsBY?=
 =?us-ascii?Q?u96NcYheR4PqgK58F5KcvMWYFr3lfJnMggdIFnbdxMPy1Mtfo4STKbm2gqly?=
 =?us-ascii?Q?6pVFiYG88MBUPY4lMBIm++kAqK7XVcdHUN2pUM3DHLSYwITFtM6YBgMa9qbN?=
 =?us-ascii?Q?VA3E5xJauGcFxuRFdYzh+QDJ4biJ9wcqGr5gigxAXpy1U40Fs3wcjDs67Qt7?=
 =?us-ascii?Q?sqbvYjuZvXRg/09JV0MPxGJojA/vGfbZiRN0bQ66MF+nPB3jqO4h6OQeZppA?=
 =?us-ascii?Q?5Xv3ayVCEsrhR10zjaNA5fZ+ZtuE1MT9F3ndlvu/yq6VCf9IQe+DN3+WWsnG?=
 =?us-ascii?Q?SMREGgRrZWbwNdb66hi60RUQb+jznuOfhUvwYmqg/FB6yOXMrFfigrlkX5fV?=
 =?us-ascii?Q?92UR+aDGvHGRKprl6jX4J4mBzC20sq4tLukIffCTyF71Llf6d09LtYp5kUEF?=
 =?us-ascii?Q?IfLHX7JutWi7CdLmL1np+07IYYmQAa9sgrDxPezPNtxThlQ65rcMY2L93TKe?=
 =?us-ascii?Q?GWbhfbH18Mk7n0EaGW+rFKXgC23i3eDqQJIUnTfz15kY0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHtYH23wHVOsIP3BMWGbRCd733+hzRx3sbnTAHGvKUkqcsVkzjCkXv5WK0Im?=
 =?us-ascii?Q?QLoC2jOxlcqYY85zvEGSswzzavqLAB/i43zSUJcu18wz6Xqbl6HAjZbl9FBL?=
 =?us-ascii?Q?pZcfZUsf9AGx4Q8FSRy+q6X1NAF/zXcvkw11EOOrQMxNhXA2bIZTOyOkcLXW?=
 =?us-ascii?Q?Lp2RKmEQcYKa8gKiMGLWdtdz1+yzyNb6wAMe01gRtGqdraahwYUYIBFO8q+B?=
 =?us-ascii?Q?U0/v+PK9unntRQQDxQ/v/+Gy3WbffcHucRcl1k4dIr8CE1EGLTLYIAlIwDR4?=
 =?us-ascii?Q?GSt5PghTSgipK3a+QTM24Kw9pLRIOiSLOUpz0KREFY/8Lds4Ytc/AGwdQR8R?=
 =?us-ascii?Q?2SWKzJEmUCaryaPRh2dJPkGunNF4bD5rUpEX7OWZ3O0wEvXJzjzVwB67zF8d?=
 =?us-ascii?Q?IKuNO7My6a5Jg1DB56pGFuAvxRT9QW0gHL2w1rtj7OwrwsIBExqNiRTjbU5v?=
 =?us-ascii?Q?I0qsMRy66ybNQUlzl3gQIFh52AjR6l2IHz2bB4g81c1uNWThzE5hH9P5+lqQ?=
 =?us-ascii?Q?u0TuH5gITIxTN7pudUYwhIal59W2EoPwVuHfEeOyaxcKzO4hjbHdB325n2PW?=
 =?us-ascii?Q?uJSTboKsmzz9ms8QRccMpxF3njlVZVl4e0LCjC/t4PioGlNHAwOnR4w9PS6o?=
 =?us-ascii?Q?HP5TZDWA1jRw82V2IdrFv2Ym8eX3hkXuQSslVwN+fOdcs/IrspmuCoP1aKFU?=
 =?us-ascii?Q?RXmPvyxUJBXADpfYcVEkUEQLuZOMRxQo53k7Hpr8nsUxoeKWZlxvy1LZve94?=
 =?us-ascii?Q?y0AB0S9dd070KuvkrN5B/Kl9u7lGKM4pLiTjShDPICVQmKnriBH9lVEQlCs5?=
 =?us-ascii?Q?RurPpoptrPKwOjrVeEkJDGVvLPX2dEKumtpqQGOeTUSF8mlSRaxZDGM3eDwe?=
 =?us-ascii?Q?Q5FpwT8grJGeUTqpI1kfPjz4l4Ui/KF+dEU7rlYwZG+RQQn24q3AgPuHg1Ft?=
 =?us-ascii?Q?KS/yh5YaE262qlTfMJO0Z1FehNWnbh5MoR6a3UuiLRE+Mx++coFXB8yWC6uL?=
 =?us-ascii?Q?b/psZDqJo/0Os8h10VZDEQPZ2z2S+mgYniGOQep0bh1t3gPRtMNCXl5NYrV4?=
 =?us-ascii?Q?i544s+hoEN9LKm5dlzLX5j+4Y4dbbeLWxr2tI0UlOURKD/EN0qewexvIX7C+?=
 =?us-ascii?Q?x3fG3JI9BAZJGMvrBLKWMMp+ZZvnhAbRz8VQX/r8GQIgdTnd3gg0fweL6Uq+?=
 =?us-ascii?Q?usF9bzIbNbC0WExoLCxYCojqu70gNWGbX5pu/mNwmCZ0WFi3XmX+3Hm/I3l1?=
 =?us-ascii?Q?Z2VqewfqUvPEK9jMweGkDimVgD6PJyQEnkmn4UPzYSkIFR6Djxs01ssfjQ+F?=
 =?us-ascii?Q?I0rCTrdH9+IZVul2x80XyoqzkLUfjYC8mQ9ISht3v+s1yVFlPAU+Nypi5vRv?=
 =?us-ascii?Q?NQUunigPQN5Wp6qBhXcKSd6pPtDvmd9Kt1b4pRZHmCOxIy3FBlkxWGtUlEGM?=
 =?us-ascii?Q?9ErF6aNHZqrSuNgFOWnGE/kE80bAYeCsGHJttuXHU49nrDkhtbNzpGpb7B3S?=
 =?us-ascii?Q?1SJ/FYwka7qYvUOPzOIPojRfm2XEt32Tt/OW8u18qoziABvUg3D/XiGy6Rgm?=
 =?us-ascii?Q?ttRVDRL/JOxSHZ2Qm4wYO/+7hbNmw5Gp+zRB9qMH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ad9822-024a-42dd-8499-08dcc07b9ef9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:20:36.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfqE+jvE8kV757cMhszvYtUJRVHv/87I1GmpDRj6XTcRTZHLSMwu/CaLB8V4PBGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659

On Mon, Aug 19, 2024 at 10:49:56AM -0700, Nicolin Chen wrote:
> On Mon, Aug 19, 2024 at 02:30:56PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 15, 2024 at 04:51:39PM -0700, Nicolin Chen wrote:
> > > On Thu, Aug 15, 2024 at 08:24:05PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Aug 07, 2024 at 01:10:49PM -0700, Nicolin Chen wrote:
> > > > > @@ -946,4 +947,40 @@ struct iommu_viommu_unset_vdev_id {
> > > > >  	__aligned_u64 vdev_id;
> > > > >  };
> > > > >  #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
> > > > > +
> > > > > +/**
> > > > > + * enum iommu_viommu_invalidate_data_type - VIOMMU Cache Invalidate Data Type
> > > > > + * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
> > > > > + */
> > > > > +enum iommu_viommu_invalidate_data_type {
> > > > > +	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> > > > > +};
> > > > 
> > > > =1 here I think. Lets try to avoid 0 for the types..
> > > > 
> > > > And this shouldn't be in this patch
> > > > 
> > > > But also we can probably just use reuse enum iommu_hwpt_invalidate_data_type
> > > > here?
> > > 
> > > Would that force IOMMU drivers to implement both hwpt and viommu
> > > invalidations? SMMUv3 driver would implement both anyway though..
> > 
> > I wouldn't say force, just that they have to use a consistent
> > numbering if they do choose to do both.
> 
> But if we duplicate a driver type for two IOCTLs, that assumes
> our ABI supports both IOCTLs? No?

No, it is just a numbering system to label the struct layout.

Jason

