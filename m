Return-Path: <linux-kselftest+bounces-15435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7195397A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 19:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805D71C25DBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E60A4501A;
	Thu, 15 Aug 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jV25O0in"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C44F8BB;
	Thu, 15 Aug 2024 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744308; cv=fail; b=d1oP6ZkNZsVu802bzrlN7q3YNthr8Slkove9jUytR6p4tvuWUG+d4UurS93vTjFzyxQD/AQwlKeVHG0DYSnOH+E7PuxUSfuIFIrDT/9ritXd+yyI1F5Egqv4v2wVA+w19cMH4qkcy0GvRUryLhUCKZhqOJn56jhwmEZ4PFsu4YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744308; c=relaxed/simple;
	bh=s9On1gDR78kbbt46ZqlCbLFd0h9JjIyQIazKAyrMfsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d+ft8dzSoruHk4fxNvYByIod+NhwpkGiloANLxoZf3uGlN/46G0KP7ZwjvI8/FsaOSHYVig58pLOeezpuf6fBepUh+hsPMPlJCfbiFmMZ8INmpuh1wdfV9bmRFGLcnWHHEinCRlyjn3/1KQpR37loLGtyF5hvj8UtItMq7BXHbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jV25O0in; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxJYr0cK9DTHMIgkxOMgyaBz0PAupVtA9Jqle6bAWtmWpcOU33aG6sJy8hifZdFYPDHG4w98BotLpRUuxizWlm3lABVBzVNcWSKZtjxj9SM9FvAX+lnvGsbV1y7+SsZo1e8FkenANx3ItDr6tjdqgYaKGsL9tb3NRMgY1KRZ1LkMdHt0cqXWs85o15eh4qmixYJyGxYaG4c7Fuc8AYAZXjHdDh1Chs8vXs9RedJOspXyjqpXHwiEsNaqsy0PA4Bvy4lPDon0qdiblHXDd8ffNSHc4YkuR41ts0S+CjoFqgKrh4HA7GaPY3nEB6Xwd/B19PvBTXp4T9AkYM0U3p38jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92VCOkkmAKpwQVPHZCHrWWLlhVGp5JHhzpgeKNIKNvI=;
 b=J9oEOmk5LXSEDdLGIXtP7pHp8mkba8s/hlSy5K/wCvyyxm9MwtZbGyY41KXZq5YADgPXb878ecB8fqBmR51mekVGfjX33AEPO67ZInoaQGvTvoe5S2yxOMrujyrkEHvHtoeJ3JOoPpPhwhBm2m7C9jcVg5b169nJ+v3vrkL/IPTbKDQWKlc+7mUiyW6WdjlqYUZO6XSb9pY9PDGcfyyJWiXml1bqK4et05T5RYNzl6xy9EXkZ5Bzo/U/4PmuWv8ZU97e8BK/F7hKla+I2hUY8qbtrDHHINF2/iCsFadlC6g+lsZhppmE4vqV+cbDvanIRq4aNc034n79q2ULFjUdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92VCOkkmAKpwQVPHZCHrWWLlhVGp5JHhzpgeKNIKNvI=;
 b=jV25O0iny9G4hp3dQiJJKFjkKpu8W0df4pLxcVoaa+QuKRLcwDFe4JG8HC3HdUE60FsBjuc/c3uTdWQzmjHyzGKOlT6ozsNeQY68kQVteODsN0m3hO4R2Bdc2FM9JdJhPNVVCbAbeGoSKo5SXGScoUPcGvsg92mAgk1l/KNsg5XJRyUY41dn+1gbyf3HyLNcOfr+3hmP5nF+nIusqpHQgwF2wTwpalOt0Bkn2OigAvIwr0xbJa9+V6fR5oIVBSkSwczq/0SYcvZc8Zfr1ZOM7KLY1hmmLFNhNh/Eiy1fSzfe9pYFhhC8D3LjoPlvF6LcvcJ6Tf5I+9Q2mKyv27p7XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 17:51:42 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 17:51:42 +0000
Date: Thu, 15 Aug 2024 14:51:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Reorder include files
Message-ID: <20240815175140.GM2032816@nvidia.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <7524b037cc05afe19db3c18f863253e1d1554fa2.1722644866.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7524b037cc05afe19db3c18f863253e1d1554fa2.1722644866.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:335::16) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 88645275-5684-46ee-fac0-08dcbd52ebd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/x+CIQJ0TUL1ogijl+VXMOBZv3lA0vHYgYOKJO3seMQtCX5mkBkstbVuyAEH?=
 =?us-ascii?Q?QFYEBnO422SK/65fwYccDASmDe6dKblRAvbb8wnEtW52nooZJg0B4StGlb8B?=
 =?us-ascii?Q?3IgYH5x13p0lR3e7XFGAMDCf80ru7ZEQ2felm+zEivU2o9PfUss0MnbnbHGD?=
 =?us-ascii?Q?Thd/TFfcSMYf+Psik4sN6dT1ExWGkgyMobKLVlvK1JgveYST366QTgwxBNxx?=
 =?us-ascii?Q?T/BKZdACFTyfuHS78P0AxnJ9widC1FceDyQKyf1/r+MWzcRI7WV+lzt+tTVk?=
 =?us-ascii?Q?I6DkG1g7aWktAvENy0CONNWB80WsJ+32lEaxRtOiFW1Yq4YcX8kzkLpTLRpe?=
 =?us-ascii?Q?8U1KNHiVjGKpRbyzS+9TRzhApWZy0/14LI/ELVYM4TFRA3w5XXgFmRqyvabY?=
 =?us-ascii?Q?MqHX33AW7SLwVIvV/PN6idyjwg78AqAW12LcjCBuBUYD4uYWHSQImIuJqvN4?=
 =?us-ascii?Q?b3nG1Vt0XBNauX+6fHQmsz3qv/PPAkEDxzNSj8RgFUQZ6O7dhCGS73wPXDVs?=
 =?us-ascii?Q?sAkzeNWreijKGpm4ZWUKqeqP0rMvt7E2yYxNs2td3vQFgRG5lcV+oPIVADFw?=
 =?us-ascii?Q?z3gtxUEtH4weueDae9vYBdxeNv/ku74yDYith136zYApGmd0UxtcDSGPnHwW?=
 =?us-ascii?Q?2H1kxabf7Lghp0hetLpMQjZHXkw0jljDPzJAO1D09KhtCetb4htSeQZFegoR?=
 =?us-ascii?Q?yxw/cdNrya+VyLOELTudspt0u5u/hDbepOFhoWYRmtSNY993VPB9DuCCvFS3?=
 =?us-ascii?Q?6gUPsHah7MuDeTmpcAuaEJ+uZ8UE7RbFx0/g4+UwHo0XpwFK5NQBzeEsjvbx?=
 =?us-ascii?Q?l991s3vsWZq8rkHK8MgYeVmgK7CNizmg5TOuAyCCRBfAJZKVdu4rUQ6q69QT?=
 =?us-ascii?Q?3vIk0bWQOIApnvTjV4IHnfN+7a8Y+dqwXmfH+pRy3rAzie06vbiU9G8MS0eH?=
 =?us-ascii?Q?jxCn8ShFYBZphyF9i3zHLd2M1fkWRbkZpnwgp1TFnAJ8qpImJ7dkfObCJ+dY?=
 =?us-ascii?Q?prcG8nl8Bs7TmsQB3elyHj5GkWI5SIozoZTxnhUVoiG++IIXmkDkHnC9L2Ft?=
 =?us-ascii?Q?dKiRZyoRX7ZHiTbb8dOvtS7XI6O6WG5OcyhDRNgj84Jqj6bFMuHqFRXh7Ano?=
 =?us-ascii?Q?6gw+/45KQ6v9+UeHVSOdYk4qO5Q8EWD4cxoXivilDFjl/2/oa4B4R29UCAuz?=
 =?us-ascii?Q?OabmHeekVXixzzKXANDdx8CATPh5kv6hBsI4c6xy1qFSeMqFJJRRywL4XYle?=
 =?us-ascii?Q?sS95VhOpywS5JmG/Nq6wsvykmTW4G/FfrWix9ir0/z7dy2FZsfPPcLUVfBiz?=
 =?us-ascii?Q?HIhaqW0LwNUTPEhgltoGvFmo8CImpxnI3FuzSCAssEwJOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBOdukix4bzyGJKjW8NlAX8N4VdSEDuXvp9/ObDFtVR0tem/H8L2HMbjFqZe?=
 =?us-ascii?Q?+sw/RM9q7unnnGgn1wLIYmAyy8MIN97jgGjq60+wEBVB02RRXMGUK66UOhBj?=
 =?us-ascii?Q?AQGlwglrrDKWIdJN12ygcYiV6SN4AQqFfp9gVRNv7y1EzTm3HhT9XPCCTS10?=
 =?us-ascii?Q?ijv1Ocg6Say7V+oobRIVgr3mOr/f97xWVJCPcmtEpcCWc9MCqsGczt9yV95l?=
 =?us-ascii?Q?/GJFJfjYjKGi1ZJp8vmmyIeQATNmGZWGzM06LHsPI/C1dGWQqOED6rZC0j9S?=
 =?us-ascii?Q?cOPUzSznXktXKT/ufapUOcZGKoBEkv0m0J+n5GIMCZomCCNzl6eVUKpjAEDr?=
 =?us-ascii?Q?m6MdHS4d6ChaOqjAwAyeDPqasa3BTRWj/SkgAyy20k+OypbbJnLmEiJyUXIz?=
 =?us-ascii?Q?HFaoPWClRmJ+F6YOLFxKWVmfyB7nOXO3QzU9WPMtXHmq71eBMHUnM4Xz3OOc?=
 =?us-ascii?Q?gap8QP69OeT+w7JwOla9mXidVlgSM1abfPpjNczRgSDrxVv6epNEje11QcP6?=
 =?us-ascii?Q?21xf9muCxQDhLzkiT2bkTL9xgm8eyaMgRErieF/m/lXQpjK8FilUMGpQctNu?=
 =?us-ascii?Q?Gq6qip6lnXMP4EyRSR89unsSPFMBPCJXRSdhBsNAYr3pZmUXUSOsqgnAeQvi?=
 =?us-ascii?Q?vBmMM0COZ2aboJG3Uj7zRH9TGX/OVuI+mywKstJudVQwVNG1A+zpk+EQSUlm?=
 =?us-ascii?Q?yvDxJPIMu5or6ws3xAN1HIcPHVQaveXuD9BPCm4MCXd185XUwHR9iasWPw+F?=
 =?us-ascii?Q?htYPViYERwFfR+rl2RdjgVvnN+H4TjXfG3yxmjpWJ0fjWd1TWoE2BS7FcMqa?=
 =?us-ascii?Q?+Flm2j/scEgZ5/Bqb1H67X56/elw07TWatWCfTCqwF4LXuolFETsjLJgcQiu?=
 =?us-ascii?Q?F0VhiWOlRFm+bpt+msuxcdXBRsdKpSiMeFtqurIoJ/RgITF7E3Pny9UwJV1J?=
 =?us-ascii?Q?sN2VTDnDx/nLIV2dFewLsAFnDhsDrci3ski5oZmigb6zsoM4rvTsU6nV5wvS?=
 =?us-ascii?Q?hW7DxHWn+sHdExRFcT+JZGoGryecQ+lHBJXNbNmKOiU4fwzzArrgtwi5pB+d?=
 =?us-ascii?Q?CgSQY3Y1tZvfRqaSjg0USZjhjc85KOOKTH4TEcwltSzZoeArrDdlfnxKkygi?=
 =?us-ascii?Q?YHwB3i4w0EoA5/Sk9VjHPdzipQBcDF3cVx/rB+lYXFtTCDFTBwinS/H9FoDy?=
 =?us-ascii?Q?0/nC+OwMeJKIzFevx5bzJdKE1zi2w7Vc2yijlDZBz/kJgaQiUej4z6TZaU2j?=
 =?us-ascii?Q?wsLFakLBR0nZitbPVnf76yQZumlxqLiMlvo2tokaRLoWs34xbF23MtGJ83N8?=
 =?us-ascii?Q?NwQNU13kSIrDJ847CvkvKKKZ2csP3etsNgqN23jo5VjB0WWJkxnp8OD8uSMa?=
 =?us-ascii?Q?jP4ysXsbpsSoBE1uDoOJsVrJ1Lsj0ZeP5CjFUSz9IKVmpaZWV7aC1AfgnTq1?=
 =?us-ascii?Q?LFoWnqqO+ogkUm/QrIlCZp6YGYGGpzsAlQSQrCpUqD4i0+dY0JhkXpnKE5z6?=
 =?us-ascii?Q?3o/pJHkivUCwMbKLjWfzzhSlf4cUr9TjUbQD1cYAbfQi8tapN2N6n4iI6o7D?=
 =?us-ascii?Q?d/wm8fGcpo5tlo8IjfA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88645275-5684-46ee-fac0-08dcbd52ebd1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:51:42.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llCx4KizD3A5Ggy/qO8bPtqyZxUbwl9T+Q+8iimSwhtKYCSFo/mG5WD5c7s0dLTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

On Fri, Aug 02, 2024 at 05:32:02PM -0700, Nicolin Chen wrote:
> Reorder include files to alphabetic order to simplify maintenance, and
> separate local headers and global headers with a blank line.
> 
> No functional change intended.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c          |  4 ++--
>  drivers/iommu/iommufd/fault.c           |  4 ++--
>  drivers/iommu/iommufd/io_pagetable.c    |  8 ++++----
>  drivers/iommu/iommufd/io_pagetable.h    |  2 +-
>  drivers/iommu/iommufd/ioas.c            |  2 +-
>  drivers/iommu/iommufd/iommufd_private.h |  9 +++++----
>  drivers/iommu/iommufd/iommufd_test.h    |  2 +-
>  drivers/iommu/iommufd/iova_bitmap.c     |  2 +-
>  drivers/iommu/iommufd/main.c            |  8 ++++----
>  drivers/iommu/iommufd/pages.c           | 10 +++++-----
>  drivers/iommu/iommufd/selftest.c        |  8 ++++----
>  include/linux/iommufd.h                 |  4 ++--
>  include/uapi/linux/iommufd.h            |  2 +-
>  13 files changed, 33 insertions(+), 32 deletions(-)

I picked this on up to iommufd for-next

When you get an answer if we can do something else for the MSI lets
reconsider that patch, also the 3rd one has a kbuild failure.

Thanks,
Jason

