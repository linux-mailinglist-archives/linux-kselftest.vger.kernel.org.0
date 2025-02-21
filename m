Return-Path: <linux-kselftest+bounces-27162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B2A3F640
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6DA1882A2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417BB20C494;
	Fri, 21 Feb 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nY2vx07T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F01FF7C2;
	Fri, 21 Feb 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145278; cv=fail; b=ABe41nKQxbZp7YGXCQK7pTz2uq5OjYPI3pBZ5b9fkR7AUFByI2SoVOYteMv9pULSAK/E/8SjiwsJO0V+MGyZ7PPo69AZ3UWN8G76NjVg81XvaSjoQi+EGwXnyKR42ULU9oq/9hstVVknqMas3u5f84ysbDDOsR48e5g9gm11Gnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145278; c=relaxed/simple;
	bh=jR7xyI64KL2gYWKQvJZxNRC4r01KV2skXglPz8fz5HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IXLj2ch20RMAnwl7H5h+G2eBRfBHyPvQ636Ex2Y+EPhGnPEBjTRBiy4ZUHmolVf+yHrGTNKYFGu1IVDR9SSl6eibCEInv2Tt1QOJrf1qO6Q3LAO5B24DUPfA+xprRzRly9Az+PtGKfHUJeDYAgX0crxyQAChIIVqRdJE1+oBnhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nY2vx07T; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjaq0ammhpABXsIzd/dqzL+TXsx8sfXt06Q0g15nYprFjbr3nhv6/+pmMqK/KjpouzzIaPmtQi0CMpNlsx0eEdd2FZ4faUQvndTZ36axVmJm550IgcRVT6WO0bovmer82Gk7+70dxmF/ONvFJTe0PMWWRbDgEHBZWWgRyDrGPA+U4S5W/KDhkC6ScZqPkFHeHLoo1wK12fg4g7XiapOE4N/5VQGMlG75ZxBYvnCjF0ffIU0XkAkBOxYcEurhH9ytI6WOwkwS/jsQF+EbypPPveWC4ochAdXaWelIdmFvOCbPV5A6whxoxahfOaUrkXEZTIknTztpc7BIup/D+LChcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRlwcgpLDHLiu/QL1aD0m92yB4DG+wHav7ZyQmbex6A=;
 b=rqx7n8ijM2aF9tUiZo7A42AaQs47hNOiZ8OcqO0Yeq0kzdNS9/aLzOothKVKD6ZrFaW2PVPd6Dr1D5icSWkk0tDeXa4req1yceaHM6FA8U1/+twnwb30iHlN9LiEG9Gm1D/8kl2LE/EMMt7QJTNXcfTVjeNLPHKHvxAIKiQHQqSaAi6GmoDlC8KOKk3VWEg1Bt5HLWkDjJ3QISGOI5HhxRRDCIPyHTRtuI4eXypZ04335eslxZ8n+b6Rb4jGxRDA4Ehi5bKEt4ehZ3aGM2BMW8QVNQK9K+D+QaOvvrr5c0J/H4iTpBscuPQEIYawtbkUIM6S1RZJRS78lTxkbYJA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRlwcgpLDHLiu/QL1aD0m92yB4DG+wHav7ZyQmbex6A=;
 b=nY2vx07TgZs3cWuOuTM/SrGJEhkAuNb4yP0Ps6u7qqNE3fqM9nMBJ6Khpx6zcqVhgWmb3+2RNbw87rTJ8bPybSoW8JQkj5/WlrO956RwV+bXL1+Y+kDwvQN3n6ZKr2Y7+5on4fQBYhYFzn4/QXzRZ96BGTEHGhT4nbAu5wcAnzcZ9kZgMp1QcRDUP39zXeaD7MGx9xkXWtqtzDcnsn27PTU8Y4alIUElp0xeX4Oao/Yx4k5Eu43LaIJsxXEQhLMt0okGrjE5QJKwZbWVv3kNUfyDqbeH1c5xS0AcXj6bD68JshT05hKyF5DxzBNjZw3pp7Ms5q7dz5CFJYjKerzYSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 13:41:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 13:41:13 +0000
Date: Fri, 21 Feb 2025 09:41:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>, kevin.tian@intel.com,
	maz@kernel.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/7] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <20250221134112.GK50639@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <a4f2cd76b9dc1833ee6c1cf325cba57def22231c.1740014950.git.nicolinc@nvidia.com>
 <87ldtzhcjv.ffs@tglx>
 <Z7hfNlnSj8BI6C7l@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7hfNlnSj8BI6C7l@8bytes.org>
X-ClientProxiedBy: BN9P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 5767957c-0ef0-4527-68ed-08dd527d6860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yGfOBkWqucf5naHUSqKk6BsrlobBOlK7tS07kBXR0o1A6n4ixRW1Vog7ejGW?=
 =?us-ascii?Q?p0lLj/uvkD2U+2g2dWk+1Sq9UDXcfV1K+OnASsd9vDK+RYIEFgR+NrtS66h7?=
 =?us-ascii?Q?CbZcnWhCsVvFsis6IDRDMgvc17TImMzKYP6QRg063u0MIfvtEwZXwlHhPQHP?=
 =?us-ascii?Q?6xpEZejo1YIaxc2Lz1ER35DqSompKd1ADTZb5GAG7SFuLsWm/UDhaz/s+PNq?=
 =?us-ascii?Q?EYIZTCXiQXoR1lxUgyRfE4bnMVSWbtX+jsNUVaQg4WFKWb7XKO4UfcTnu8t0?=
 =?us-ascii?Q?OlgWHAGih5Zy6uCqtsyqGaJbTJSmRBl5BgCZ8QecURAOKhkPCVOzkKQz52bm?=
 =?us-ascii?Q?h+iWDpc71DN6byZktRCTM75y+wEimMuYs6/tHk2Jn3qauapI8RnV5zKM9aQS?=
 =?us-ascii?Q?Hru4HI5WNriwMOaSUvS5E/rbembvqaIfiKiBvjx7fUMl7OwWCTqKTBeFNvgP?=
 =?us-ascii?Q?xNuc7oYSWldkKL1vLesMUENs4MSUfGsd3FhJfrMk4U04BWDTLLtJ8/MR10u7?=
 =?us-ascii?Q?zFokWFC1KJvmg4z8fZ76Unl2OqkDGM0dyJbYcpoRb5xRCDXmNywPsKRvfjms?=
 =?us-ascii?Q?BLOTb43r0aaoRQf4TepQkSChJzP04eJYhHXUKJ2NH2TpusJFG1KVjog38U7S?=
 =?us-ascii?Q?seguUqUd4JO1bwIGpsYup4o64s09PATNEsIwI2JTNs/N47V+p6bRUu/IflrP?=
 =?us-ascii?Q?w+c8gALGeBtVtL23yvYOkExm/GzorRwR8u+vP1Fq40yLbK6MlU83PyuBYXdQ?=
 =?us-ascii?Q?UfP9WRFut3Msv4025C8DJvmi+A4Y63KhJ9YLUSVujFkqG3DYH3jciM7YY5sB?=
 =?us-ascii?Q?rL+BMYQIwgmd1vWuI0nfY7yn2Uq3Mb+tBcRH5Zwl984mnxp7+ky72OG0yph2?=
 =?us-ascii?Q?8i7zrC8y2BITw6R1rhuUidBR1o9Yl2aU36rblyy49oJkp72VJ8DlDMIu5ceN?=
 =?us-ascii?Q?+KBo6kwVD2DTd/HrwjgJZTYp5arUr3zSEvFRNb6tyrkxzW2zYEd7mFEM8f1s?=
 =?us-ascii?Q?66a91JhGA3LMquUatQ84/OPd1c7kCRMVM0/fp5hDJLA4Jd9eluyn+7GvweOG?=
 =?us-ascii?Q?4dK5KquAr9Uaz9pdc5jZlCAraw8//zmwO/6kBj4zczW9X42buXF3VGPqyU7f?=
 =?us-ascii?Q?2Oqlhe4+3IiRbfSnu6lO8y+V5UxpFnr0x0bbghMKYKjrhCnrkxs32euJVs9r?=
 =?us-ascii?Q?mDfKQhrw+QsHpiF4YN+cRB94dWt49cTz/kHu0esulQLK7K7HGD+h9qVat25b?=
 =?us-ascii?Q?bYwPB7oSsbcb7orM51wmwb/DcvF8lB0qn7bRRQBqboYDPFrYrwBaY9xlqyON?=
 =?us-ascii?Q?Wg/wjxuiQkEtjf5IakejhvCZ1yD65kmAJUWq/o6CcST56yiGuiFB24aNbk6Q?=
 =?us-ascii?Q?V66NsSwZxOlxpxbaYRMaact2Vzwb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0olkqU+AH+ATMIn5dJlH6AzRwCc/kS06LfzEncvv2Hd7zv1PMiiju+LQalq?=
 =?us-ascii?Q?HUmo3OiWkXDPKVhwBeYLrefmJdvu5OgNzPY5O3bCMFNXiyQSsRNC9kQjoJT/?=
 =?us-ascii?Q?3P0EpDhV8CTRMhw8E1K5yEAhN3SlRk2xY8ONSS1Ht6kT3hRsz1Q4S/LgRXg6?=
 =?us-ascii?Q?Ez/A5GULQaBWJXNmC9QZNwgyYyGf/oBG4RfPwpzmiLZkvgGriSNh8ADvMx+S?=
 =?us-ascii?Q?r9BxY++XFyM/vg36iOWbS9hg6l1EvA0j6zYl50HvrxmFWWLaraUnveXcd2uS?=
 =?us-ascii?Q?GqV+L4Z6YJK4to5KLjJgVuFJ37nfw1mUWgzADWksFDE8lVFopB4fRJ/qgEyt?=
 =?us-ascii?Q?e8UKrj2OtISW542cNzMY0dJP+r/wzKZd4VHwsHW6P+dzzei1gBHJVpKXO9eG?=
 =?us-ascii?Q?YUxreqshveRc4sTcP4yRrrpKe11AZ5cZ5FM9t5XQBQsLWScyDU4sDUK+bs3Y?=
 =?us-ascii?Q?ur5VhlnWE8YAx1sLoMAX/Djm2l6vNtm5q+Diqq9h4VqUL0U4MJLeoA41o7DW?=
 =?us-ascii?Q?jxk3s5NBh1uQtAM23qDVyzGrbWajAorWlLM1Cl2X540NG1FygATBUXlWApio?=
 =?us-ascii?Q?O7LqkvDGWMEgvP2ejKGR1PWVLYNEj1C+pLPupY82VZQSPQ8JPPfLFbh+c+AT?=
 =?us-ascii?Q?ZXeBtpUB8FdNOkZlBiSK4nkd8bJati0cmjuvrxEvnHFKkrDjPyV+ITUMLL6V?=
 =?us-ascii?Q?4Rynun0jJ+tFco4vlDRjWzaaABqFG8es4TnJgNE70kf6Sc7KMOWepVtbtJLc?=
 =?us-ascii?Q?dOKs90ciX0MT0uco0Rgj3PeLwpJpJLSQsmF0fSRfNiTZkg1Fj4aVWB+fuoda?=
 =?us-ascii?Q?aWkYu998ktewkpjtpdCyZ0DguQYanuOMbXSOc71R02l8Sh+soWt3xsXrPzhR?=
 =?us-ascii?Q?9PQtzSOw4s32xyLwBWWIvSqbwfdznOTJ1G8jdocW3WGGLspSYJzo0Ym2q9D9?=
 =?us-ascii?Q?3mKuyWTk1kPm5S7DtSWlPa+WqAJCubkUTgKaKVXFynpMvzttwW9OpESELx+M?=
 =?us-ascii?Q?Mzf1Chbt9bf2DSw7ENSyPHs0ZSe3WkT+wfFcWFWkqCQg53UipwN6caUT3PAB?=
 =?us-ascii?Q?/coVYmYxRg07fm6U8O0fBV3Vjd6LbfIzAGDq5RqsxW74xDyA6mCFbTRL+WWZ?=
 =?us-ascii?Q?5h2ziQpxylMngdTIKe0daAaXf9ZchQlB9XCt04qYMRUfC30+1BF41cRscdbl?=
 =?us-ascii?Q?8WzcyPQ46JIAF3h37UsmxIa4WnbrXPRP+l9BjZF2kurMvJDy2LunsPQUyaRJ?=
 =?us-ascii?Q?qFFJOR4Ph8TwhY+SEcCztW1obKhmSVQEFuRtSNavG0M332jyJJOFgNcJCpqA?=
 =?us-ascii?Q?eNwyUqh42xQAQaV48+vd1bs9Au79fIK7DLoF14/7EDENldY3sNvqFaGumVDo?=
 =?us-ascii?Q?mVmyo0YS9Qen7QzUZajj86GKWuqVUl2Sc0f0UW2kcqdZOuW4sh5nhnooU8GG?=
 =?us-ascii?Q?QoSaKbeWH5cTgJWs0lfcVwBB8ed9MPIGf+8zvXzwZ3Ns3GlkDZpWqphwjqDG?=
 =?us-ascii?Q?txu6EOQSq+Br+SWYFJ8peAWMeARNZ5xYv0ZwlZTBXec12qPYi3ljXvp8aflh?=
 =?us-ascii?Q?4QFCD74x3JlKOMW9gQT5WleajR4pJyX08ATZj7sc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5767957c-0ef0-4527-68ed-08dd527d6860
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:41:13.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/7lucdb9QTROUCwCi+BIceyjlhkbENgVN3kv9CtMnIibDIhwSfhJb0ShJzyrpMi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

On Fri, Feb 21, 2025 at 12:10:46PM +0100, Joerg Roedel wrote:
> Hi Nicolin,
> 
> On Fri, Feb 21, 2025 at 10:28:20AM +0100, Thomas Gleixner wrote:
> > On Wed, Feb 19 2025 at 17:31, Nicolin Chen wrote:
> > > Fix the MSI cookie UAF by removing the cookie pointer. The translated IOVA
> > > address is already known during iommu_dma_prepare_msi() and cannot change.
> > > Thus, it can simply be stored as an integer in the MSI descriptor.
> > >
> > > A following patch will fix the other UAF in iommu_get_domain_for_dev(), by
> > > using the IOMMU group mutex.
> > 
> > "A following patch" has no meaning once the current one is
> > applied. Simply say:
> > 
> >   The other UAF in iommu_get_domain_for_dev() will be addressed
> >   seperately, by ....
> > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > With that fixed:
> > 
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Can you please send a v3 with updated commit message and all the
> review/acked tags added? I will pick it up then.

Can I send you a PR instead? I'd like it on a branch so we can work on
the iommufd specific bits that where in v1.

Jason

