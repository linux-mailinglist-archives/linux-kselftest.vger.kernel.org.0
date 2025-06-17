Return-Path: <linux-kselftest+bounces-35157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B1ADBF1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F08B164DDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 02:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1B229B28;
	Tue, 17 Jun 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kVBbJ9GF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585F2BF01B;
	Tue, 17 Jun 2025 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126945; cv=fail; b=p2GtktQVsDpLnIYnhF4O2CQVlYwuP6e6E3XSoG9TCIhXC0IJriyek6ei8jPUHOFRl4t6oXzfhM5AqNPbXPrTnv0EHB/uScIInu6AOlaKEpledJ+izqoI2xNZFWQrrSy8BvrRD3RMd4O2bZk0vE9NNC9vrsz89mvdKlBfjTBZKFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126945; c=relaxed/simple;
	bh=2B9PBXJ2kVKxDEAiu0Qu0LZfmMWgCbYEnaZBeKuF1+g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPxWO3/a9XXdJKfjPdSfKlz7qqvMVieVO4QQTYyCGaGwHmn3wfhW2AzsG8NBF4hsVo3bwfw23wv4JZk3727B47w0XxlQGACfw6mov0M+tnzVGxDQTfDpEndgA1epCgfhi3eRpHCGcXK/U2ZoMP+JMyay18UIC1EDA9a6mCWNVys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kVBbJ9GF; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2EhXS2WTh/E+mKWsL31vO13agz8S0duIXp6Nv+7sPzSdsQg3gmguY1w4e8GfscubLNPtienc7GufB4laKPGkl0i6lvz6JvENcPzgbd/PgmJ0A19bOLFNHUZivDpI1NDXSjNBmIZFPf2HbUa2yuX0YmSHPYBGuvwp5E4OabaKSqcEMtWH2ea8GoPNP4IXGA7IIKnlpEqjE+4rHNq+s7kM+AjpO17OwnabRuPKtPediC3WTM5aY0/NndPknAnhaV9qTuUhoOdH0eK68gIdfGBbs3rqY3BAHed8grfgXog1O67DZv4r1EoHSb5DKLmcrKcztjudaVjABAxCaF272nX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC0ghtDXpB8/EOeTvkYSLxGpcaqXSK8QmWQzX1Z0Fgk=;
 b=nQL0udmM89zueJHMq6rtivsreK6c6aSU1ssEWXVdeSPFbc+0DQCQhta8Ql3Yn6RYm9cR9XLRO018Fqo0VfIyVU9Mprxf9B1ClOLhUf943orStwxY3jTC/OGceO782ZQHhZotp9ZiiCdGyn9Y4V+I5UslZdzuq+0EtOoOO8KOeG5YNiL/i6pQ605iX3hAnKY+qctVdLYUmSKVw/FELjwmcctssosThDor/uBTn9oejNUmakS4tgpNVlJLXL4a1Gj5TfloLlhkqvmyp89ZkV8wM6nLrtP6AbiMCxcUlyRZq+N1IztcWPfZthKbNeJaxHwfTtTZJDVHTlsMX+V+mgkBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC0ghtDXpB8/EOeTvkYSLxGpcaqXSK8QmWQzX1Z0Fgk=;
 b=kVBbJ9GFZA2L3wgoIHZtETtQn1Li8ulTkTsytpg8jVFEIba5yIz0PECPdX7g+52wNZEqU2t4U0S+jlLb157t4xnyuM4uqwpotohB6+AymJSiVdf7v2XrZNM4yl7Xj9gL+d1tIs4juJ9Fub2+8F8FtOEvQVZMQGjzUk9nIC5+TV0p7OvsfcTYnMc9I+PUJJkbgFJCVOoQ0Oq0HT0vvUmNNp7TkfFh3z+Kq+mIAM9hXFWm5QxP+6t80AO3T7FlvvbHKuAcRXqajDBubtb6xE+651iUu2v1/sD8ZSKjJ0HVUL+/ZEco0UgrM+TO3Oa7Z3CjPQStd/tEdc1e+xKsMWu0Mg==
Received: from MN0P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 02:22:19 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::b8) by MN0P222CA0026.outlook.office365.com
 (2603:10b6:208:531::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Tue,
 17 Jun 2025 02:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 02:22:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 19:21:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 19:21:59 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 19:21:35 -0700
Date: Mon, 16 Jun 2025 19:21:28 -0700
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
Subject: Re: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL
 for internal use
Message-ID: <aFDRKEsdVZc2XQ91@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
 <20250616133305.GB1174925@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616133305.GB1174925@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 8684e62e-f0b0-4173-021e-08ddad45c8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2p613Dkr5MdR745tDkqd8VKLOS3PJhJ8DEV1bBfmn8AbgLWz0XeK6q4O28Bh?=
 =?us-ascii?Q?VA0aZggTe2C81tuUPlGBMMhwOvqh4A1ZyUaNcg2d66noN8MB0UoKWqTGB2wP?=
 =?us-ascii?Q?Mnt3VoBQISjgEBkIk+GDdUK8vvl5iCC10rLmmff3e4ZO37zBAdFOCbav8NCz?=
 =?us-ascii?Q?q/Vb+46DheRwhNozncCnAf+Jw3Htg0yXpVM0xktIIujSwlEDpN28YS+vCiFE?=
 =?us-ascii?Q?Is3y3qwjAIwZmI1hRwv/uOewJ5b4mq003ERsRzDCWgN/lAf/J56C3PPCTu7f?=
 =?us-ascii?Q?ui1aEeH3B14QTej+DUfgOhB0dUV+T5P8rRKpKjsa3nj3h5xyQA8dJ/pPk6Ld?=
 =?us-ascii?Q?5dek+Mo3hm3LdJBiHKolt+8aiwFTN+E1acKTv3bUhsteGYQJO5gMnOiqMa+P?=
 =?us-ascii?Q?32QOV3w9tYwg6fwXirhToMbGJ7YIPL6KJ8gAS3CfaelmyqX0J74dsdmSKDXO?=
 =?us-ascii?Q?aiVQtgkzTRJPlB/LbDqU9FuMSE4XnZ++DG1drkog//B8l7lQP0hMrMxSbJWD?=
 =?us-ascii?Q?Vkac6Us8YNi3sZlmdF1yGZ32ePae+cz/XF2RJj8BY8hEPOL0d5jA6L+Qu7Xm?=
 =?us-ascii?Q?f6Owg7D4e8hdqf1T43f4Q08FMMs0qopfzMCBlL+0MkSUhavs6zxi3IjTcPJc?=
 =?us-ascii?Q?nFY4BjJK3YxmLPKu4vDTk/o/6BkffmUzvaZnYfOlUC6D5Ci6EQHWTGIqTTgZ?=
 =?us-ascii?Q?Cs3j1pC/cQV7xSPrKeQebMfvQ5DydnGLJ2gx80zRBh8TKtieBd4KF9j5MMEq?=
 =?us-ascii?Q?f2AzBUxKHXE1ljoeifzxyRXHYHnDqV0FStC2Oi2MCmXFCZCn1J+QSeIgETyA?=
 =?us-ascii?Q?Eykn+39iZ8TnT6fXIr9dmKIKiEQNbLMlQbwB5lExiLs6SThdjFeIigkUcS2V?=
 =?us-ascii?Q?YhzUdZoE9xTltF/ejfK0OVwv3sWwa0O3Tb413ofItrMdz1OQvrk1U3ShZKoF?=
 =?us-ascii?Q?1DwFx4OyBk5AqksU5mMStd6tFHccctF0aZdGZooaPifRDHc9N8Wh1fufM4x8?=
 =?us-ascii?Q?goemlOzFVnzb9ZIj1cfUdZPaJsSZoLv7esLSeV5xNIDoCQxuKvnQv7PLm+gX?=
 =?us-ascii?Q?SA/ifQ36vTTK0Tl+S8zYmeUt3SQ5VSU6bPFfbWgyH5GFvSAKodaeP+DIga9x?=
 =?us-ascii?Q?GTDZYeTcH1h4MVYsFsTRaCMitucPUyGLP+IdeGAZLdw7u6BObMVw1xp2Sdjy?=
 =?us-ascii?Q?Gq5bzYjO4t8kpnRVLyKD5bvydSPioK0doTNqfUtBLlJlq3sV+48UqCfKliql?=
 =?us-ascii?Q?tGgv/1ALMPcuog5m1ZELYtSgT0ke4lgKWHbbDjo5tfCCsIvZB+vfKMh4PR7T?=
 =?us-ascii?Q?EeVvTB8XKjYLngUAZTG03DDp8q27jvbHXmOZRIsKvhx6ygTR+X3jBt00nbir?=
 =?us-ascii?Q?nax47ri6eYRmnQ91ZmXDzf7YWiohWq7IdjP3Y/GffOqFCSE3v1X5VkqWHCvL?=
 =?us-ascii?Q?lJKGnH38428XmV5V2YW8HtHOMi2WnGyMF/Ir1qypF7obxlP1JNafyb0vF1QA?=
 =?us-ascii?Q?hc0J25EIYwrCjfZItPO8DRkEsT9b4fYcFY7h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:22:18.7777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8684e62e-f0b0-4173-021e-08ddad45c8cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313

On Mon, Jun 16, 2025 at 10:33:05AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 14, 2025 at 12:14:31AM -0700, Nicolin Chen wrote:
> > @@ -1321,7 +1328,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
> >  
> >  	/* Driver's ops don't support pin_pages */
> >  	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> > -	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
> > +	    WARN_ON(access->iova_alignment != PAGE_SIZE))
> >  		return -EINVAL;
> 
> I don't want to loose this check, continuing blocking mdevs is still
> important. Only the internal access should be able to use this
> mechanism.

OK. So, it probably should be 
	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
	    WARN_ON(access->iova_alignment != PAGE_SIZE ||
		    (access->ictx && !access->ops->unmap))

Thanks
Nicolin

