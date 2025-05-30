Return-Path: <linux-kselftest+bounces-34084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6878AC94D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8731F5058EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247892405F5;
	Fri, 30 May 2025 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HhATSvGq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CE2367AC;
	Fri, 30 May 2025 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626733; cv=fail; b=CV7UbIOwAuf2920wT42EkJz/bWVykdg/a1AEJ4W0K+S1AIWkjcjN9H52W2m1FfWWIgz1L/y7aUljIXsPHBWUl3eZy2rnN7DBCVrZCV11lCrOl6H2mSwUKHu3APeUtKSFADG3xjL25kEfsCCt9qq3DPjQQVgBRB1MTEc/YNCTfnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626733; c=relaxed/simple;
	bh=dir7QQlKszaDq96PGTpvHyO9o/kvaO3dJ3hx9SMYPmc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3rHRoG8JFAEOorgbxKuBLnQpWLdN9D95LW1gmkQJpGHctBhZRNWNX57kwb3u2SZLYT0XogOJEek4c2JWFL38ZQrzOH3bIZKCuRchDqjEBxQTgXUCoU2gwOh4a8PA9aUU4wU4vrvz9ckY0YZNz3/dILffNOy6osZ/GDpeHrMFXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HhATSvGq; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAcpsfgsxP/W/qLZX4YfFFJXEdFsm04prQMGjRFCR5OA1xnCNF8TS2DbTeu49DdchWtvT8byUYRWqdbZ56dlAQ0Buh7JTlHIL7WG855A26NbfYBpNR7cpRLKPhFquEW/fOL5HLPMWYrJwAXFPykVRSzsrmC110b2oa2I2ANZIo8GSLfuXqaIxd1MxzfQXvdYBeR5WSbYq+bpjHEnamXqZcD9IQFKXbQYgj49vCHOoIsS1xTpAZM9zkbruA51/bhpJc/oLucefyhYL/nbyZufhCeooMAa3yR8Wh99RYifxv/MMvRrn9jvo0D0aZpG9ajkdH2GUKT7LXqPVMu0ns/Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqSQES/NEkqZnxbOiXnUGxqmGfyDXzCmq4JowUxHEHA=;
 b=om57DubwXoluyy7JxUrq+cSNJ3LIBisiA/SslxHTTPkFgxhb9u3Sfs5ZKBg2lTnFvkPvl2T+8YD3gnWPMAThslJYj4Kq/DqmfLhFCDOVdxC91g9xIENHaNwuoplMRLUyeP/uzi5jNMNNxqsQMnyTqc9eew/irlOe/Ms2uBdKYF9MF+IkdGewCRK0rvQoYiNPBZqUk4Mhgt+aa2uL8dHTXUXu2tL50JxrI0N/SkSR/pT7Q72pfDP3/hhkXufNs1BIk6cPv6/rbIBr01zXmW+P3ecUnD1GPLJMOBJ4m21GCuBVUSz7hNssNmdyMYKCwQdq9wFC8VKUwxbSlLk1hbYQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqSQES/NEkqZnxbOiXnUGxqmGfyDXzCmq4JowUxHEHA=;
 b=HhATSvGqoBskGf0YSkvSeW0OoXl2efeG0qtqeGBBA2TFSbzJomw2vNEm2zl9FVF46VXRg/G7wS1v39YUf0lqD7LXlrfvMFFCKTKqqn0JliUhPo0G4ARSp+t36n7wHBI1aGWXQAcsaCdH3ILOSTMPSwR3OXT0E8voEEQ2nLlPNBW1mHs2pwjw3MAPcMUT85zMa/mH6jvjSuuiaX/kMciBynQSZ292EmWOPtFRy/umeWGFYxAKfkTYk6kvF2mueoZP03GPG9lNOT1AVl50KRD/adoR4jBMWPo864BFzOxhzTJV5KaX45bPS7KWSyKrJYjEd0MvHd5/EdJrhRbq91iTkg==
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 30 May
 2025 17:38:44 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::8b) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Fri,
 30 May 2025 17:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 17:38:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 10:38:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 30 May
 2025 10:38:28 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 10:38:26 -0700
Date: Fri, 30 May 2025 10:38:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aDntEDywhsgMoZwc@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
 <20250530161455.GE233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530161455.GE233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS5PPF5C0B6C3B6:EE_
X-MS-Office365-Filtering-Correlation-Id: ff59d098-dece-4650-df7b-08dd9fa0d33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DgTm8JWNIOmpu+a/fXKdMGOZUvFwi4hYqjR9pDSOG7SEOn8WXenmyBYIuzAb?=
 =?us-ascii?Q?AVvb9FqNKMjfIfKQB4nfsFVg6oAD7FN77PEfyrHKWHqEkyDAeuYiB7dpv2d+?=
 =?us-ascii?Q?wMgU8iv7xMMyr2nn1Jrcq0reQIhshnc59XHgVB8ZIdvZ10I+fd2AntGoySbu?=
 =?us-ascii?Q?eLimtDqAyHEHerZiMQZh3w1N+5x/vQORIkL7X3836c5MxMh9jDB1RNn1LA5f?=
 =?us-ascii?Q?NWWXm4qKFNQUMz9LRiU3QYybDFklds9lvtVbo5V8WocqVE4DXHX0BEsFT6bj?=
 =?us-ascii?Q?61SW9WBaURJEKAAZFZK23Vsup1MrrOR6jjVikmm1tRwrjqv+MHPBJBdzbFeT?=
 =?us-ascii?Q?yQXBYrULWK3Y9u6id6qzmKaWjrXtk3qwXy+wvsCcuinz6Jdu1ABIPdGU08Yv?=
 =?us-ascii?Q?2JkiefLSkopBYmgEw5SuJEJma+ZzURg8COFcwTULrpzf1fCFUStbphGrM+nB?=
 =?us-ascii?Q?ugg5uz+yh2mBfUyTqINt1ji4H3fhKxBG4vgkXDKf3+hnAOw/SQt++TvQSfFf?=
 =?us-ascii?Q?Zq8143JDuJHCZVKTnkOy8+q8otoPIpHOl2bDjjVhfOwPkytHrQRpr1p1NXr+?=
 =?us-ascii?Q?+m5RmwRbrPJv3CmoWYwPwu5On4WxvN7Wf85+4brb7qpuV2y4y3qTYJ3iBoZt?=
 =?us-ascii?Q?wFRfLqLjvUDZI5tYih7F8TVUovXW0fNGoNuGWJa+ac2p3J1bWqcKb5JKVaRP?=
 =?us-ascii?Q?qsyYErjZFlmnWF3T/kTocGEvgxTJr1+oqAqD7tGZ18KSwuOFYSy9yGfPKc96?=
 =?us-ascii?Q?ie180lH+v3oa5CaVDtoh2OB60PcbSL2NWpCfLKsFfJ9yQmd/saHkp+EE/kmc?=
 =?us-ascii?Q?EB9X+HfheBov0nodol02koDvNz2JvrJq5Laie06aaXObfYbfUcrq9MrK0yx7?=
 =?us-ascii?Q?LKjyodt+mdTnsJ0Nepjcs6qghL2NjZb0zdH+bWvk7b2G2tzC2k1WpuwjW2d0?=
 =?us-ascii?Q?uF/6Wfb2PdMx/+ONSPDTZ/r8b/XfgDyYkdhM8N6os8+yM3lM2R9DJiFobMgT?=
 =?us-ascii?Q?QeUjwrT5TmcHBks9NZInAr5bGL0N241GO1eX0wBSTmp4FW+fRoJJO2R4jgGG?=
 =?us-ascii?Q?/i8KNsXHEiV7+3+RsQWrOyWuFJpNl/iJBHaR0e5JMuOyhT6cHfrmEvZD9fjP?=
 =?us-ascii?Q?oZfmA/gNeyf+0POVipExOSoWiSYrqzaaqi6qlD90sflpO+0u+wX90H/ZyjjE?=
 =?us-ascii?Q?RN6rSXi3wtm4NXwD9aA4e6OQQ0u/8QTc9BcdqQ3qGDkbH4Et9+Ot8gcHNKJv?=
 =?us-ascii?Q?cPto9vePL8jGqqmkl6vrrHsr6lRl6OMGqBDEhcmitM8wl5GMi7gIiq6XEcS5?=
 =?us-ascii?Q?wsUt/m8RKvwC4NGdWG9aS0Kox1PENk7LP1fwoUszob+trDyZ5qEwpJQxQuH0?=
 =?us-ascii?Q?/jUieKjus2g61yTQpJJdBUyA+Ugs1f4lIflE2K/rAvgPGHCZkN5GIEN9tcxw?=
 =?us-ascii?Q?CNY6VzbVCVzsFQowTCcoaGG935j2/L4TMcymOi7+PmliQPL394qY89lGWGgm?=
 =?us-ascii?Q?bdZ8YkASBJLod0S93RbRNQ281CSi32EVWhve?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:38:44.2612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff59d098-dece-4650-df7b-08dd9fa0d33c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6

On Fri, May 30, 2025 at 01:14:55PM -0300, Jason Gunthorpe wrote:
> On Sat, May 17, 2025 at 08:21:31PM -0700, Nicolin Chen wrote:
> > +	offset =
> > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> > +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> 
> This should probably be capped to PAGE_SIZE/sizeof(void *), return
> EINVAL if not

Hmm, mind elaborating where this PAGE_SIZE/sizeof comes from?

> > +	hw_queue = viommu->ops->hw_queue_alloc(ucmd, viommu, cmd->type,
> > +					       cmd->index,
> > +					       cmd->nesting_parent_iova,
> > +					       cmd->length);
> > +	if (IS_ERR(hw_queue)) {
> > +		rc = PTR_ERR(hw_queue);
> > +		goto out_unpin;
> > +	}
> > +
> > +	/* The iommufd_hw_queue_alloc helper saves ictx in hw_queue->ictx */
> > +	if (WARN_ON_ONCE(hw_queue->ictx != ucmd->ictx)) {
> > +		rc = -EINVAL;
> > +		goto out_unpin;
> > +	}
> 
> There is another technique from RDMA which may actually be very
> helpful here considering how things are getting split up..
> 
> Put a size_t in the driver ops:
> 
>  size_t size_viommu;
>  size_t size_hw_queue;
> 
> Have the driver set it via a macro like INIT_RDMA_OBJ_SIZE
> 
> #define INIT_RDMA_OBJ_SIZE(ib_struct, drv_struct, member)                      \
> 	.size_##ib_struct =                                                    \
> 		(sizeof(struct drv_struct) +                                   \
> 		 BUILD_BUG_ON_ZERO(offsetof(struct drv_struct, member)) +      \
> 		 BUILD_BUG_ON_ZERO(                                            \
> 			 !__same_type(((struct drv_struct *)NULL)->member,     \
> 				      struct ib_struct)))
> 
> Which proves the core structure is at the front.
> 
> Then the core code can allocate the object along with enough space for
> the driver and call a driver function to init the driver portion of
> the already allocated object.

That's interesting! Then all "_alloc" ops would be "_init" instead.

> Then you don't need these dances where the driver helper has to do
> things like set uctx, or the core structure is partially initialized:
> 
> > +	hw_queue->viommu = viommu;
> > +	refcount_inc(&viommu->obj.users);
> > +	hw_queue->length = cmd->length;
> > +	hw_queue->base_addr = cmd->nesting_parent_iova;
> 
> When the driver is running, which can be a source of bugs.

Hmm, I don't quite follow the "bugs" here. Any example?

> This would be useful for the existing ops too.
> 
> May reduce the size of the linked in code.

Yes! Haven't tried that yet, but sounds like we could move quite a
few things back to the private header.

Perhaps a smaller cleanup series first to the existing code.

Thanks!
Nicolin

