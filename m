Return-Path: <linux-kselftest+bounces-24235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993C3A09BE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 20:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A77160935
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859A214803;
	Fri, 10 Jan 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rICzdp6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81120ADC9;
	Fri, 10 Jan 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537284; cv=fail; b=JPv+HCFy8NDB65qnHXcSjltjh60W1LA8BXcqR0qOuilr8pzaVi/czotm6M6jT4luw+YXGvtkmvXCeKr6ec0eknMVn8C1nhGG/K6UdwVU+C76diXULJXBBG3r4oklOl/ury+zVFXWNj2y5Z6P0qpppiihB7GXlQGtoKHWHyFOM7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537284; c=relaxed/simple;
	bh=Qg/shGJxp4piIL3wuXs0Ji0mznNpTKnpz8fWiUGKxgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vaqc5D5rhWYF18rfwvThmaAU3QUyM9BRHkJ7w/KvMyVRU1ZS7oOxORz649QHvS5e9ILjqAieNISV856H72XkNNiv/4N9QzF4hAkUMPkMHMCdMqfUV7amyGd9pOFslIyBkCI2FK/t+3gjo8xa2APbBYLW+whhbue/JYxjjRnveLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rICzdp6B; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjpLqxrQ1SyZp7DG6ysFgrGQ+LqUkLB0keLbzNoZ8lqpr86Hps8AYBaf9JKBfFZmy3+QQ8iKLPOiXuGyfueebq+4wM7TivXOS50amY8nNknrCZI+PgYwvz/6xIklsn+798DB4Qi33x3iqoM2shkP3v2epXH5y7+8hGrsLWpwuRU/YlU5wXP7cXqejmAEEsMX8mpZJnYwpaUShNmujYcxrU2kZBA9PZbkmLdxMYeDv64ISip3BqfDNU6D4nrdBui4mDsBtDTRCODJN9S3NsR0WIfVao7LZ7KnLr+u6KEhFS4Sl3nXoOMvt6IkFIPOm0p+RIDsERPEmrLi69mMwzFgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USWyATaTozduxWuZNfL50mg/6wtw5Rf5njwp/lLQZ/4=;
 b=SglO1kLLaHQehoJuUPRqemn1PvltP9q2hz+Cn9Y72kUhIFQHcqfgRD4aN69gLTAT4+vzha+2KIqR1j8fD91r5RsgExPBXLpU1sSytt0rSDq9QSeD45gLAI7Rhae2SuKjTIp8wdh07c9PNxU+weQqv/4O5ubqDPgNezb5tLXbvD3eHu1dM2rsi50JseMwBJHgLZak/AmyWyYMCFkBiqMgVuVPWP5TaHvz9ESf1JlNuq5p1/Me5k9tgqipX+t1+5L2xvH6IKO1BG3BYzTN6KIBjMMmXxNLAzaL9hw3VxNa+vqLjA34Q2UzcqKgA5IpT5bNoGN5LyJDBVWzqn2yMO4SIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USWyATaTozduxWuZNfL50mg/6wtw5Rf5njwp/lLQZ/4=;
 b=rICzdp6B5Tl3xrRcN7r1k8jkwKzZ/HUmiZlEfKCXtntFrqTVOjv2UKszCe0NenrWLjuX7Npz2dL2Ye8gK+nI0b4TuLUKR65SQ6vTucuwRswp6gxxAeONnOu45I5ZmtLIeCsIndYYK2UJfUHVLiRYQ4AkIBmpfleOpTiQ8ZQBEyyxSmvgQ3EUY5F1yX8L6ie/JUZDhhNNT4kMXNEBzmq3GYaRzdDV2hycASnnxHQZqReQlAwXYJIb2ARuutDB8vWSR/+19xK5Xvu2DaJlZmbiS34HQOk/vqUbWa6b6XUyaEvipGq4dKzQSBaxuHwi0O7IPwqriT0lfaF8QU6XKgWueg==
Received: from MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::21)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 19:27:59 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::3) by MW4P220CA0016.outlook.office365.com
 (2603:10b6:303:115::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 19:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.0 via Frontend Transport; Fri, 10 Jan 2025 19:27:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 11:27:57 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 11:27:56 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 11:27:55 -0800
Date: Fri, 10 Jan 2025 11:27:53 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <Z4F0uZBg05J7Nuhl@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <20250110174842.GI396083@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110174842.GI396083@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ecec42-1d1f-4517-6728-08dd31ace432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6owmVDVMGTFZ12uErqMcIOCytB5F03qLNVcVCSqxcXK5B4PP2Vp8xh73NpLu?=
 =?us-ascii?Q?gWgXgkAvkJzW9R8a+EeF+5wEMcpjd7ZFUtqrCvafhLsWma/fxqORVlxYdjYc?=
 =?us-ascii?Q?E6UHAkHdWLjvN+ExblCUhrmxNlTpND/GjIYWeNCSv+KjB28LpWNUtBUBn9S4?=
 =?us-ascii?Q?N24B3tAkYv7fi2wrrgAB107+qwkry2G5D/Oek/Jz4McBl/Zak47i1a0213ym?=
 =?us-ascii?Q?YjbkuEhsiVfd3BR/U3bimaWbFRYcUFGTJh95vTMFHVzPo1HvyKd8kYRVVBL8?=
 =?us-ascii?Q?7T0vmYfILMWYA54u7DvY7Yty1y3nGDHUBL9kDWze0+MyUeWf6JbGsz+uKw01?=
 =?us-ascii?Q?TfiPBgg1oIoEliu/KZHIq/g46ezJgDgwzmvWh3NsGR4EqpdFC+VhTAkEJljq?=
 =?us-ascii?Q?zXdD52yZGdUSpAV10+eajbRhkkjtccClqJ4UhMCrcNyv4Hhuu/Vm+5Yl3nNS?=
 =?us-ascii?Q?qo14qZ1JDE2iCvI0ajLA8ZgEw0SrOvPnkcjlZM6fQ5Hs/AQ0x+PdAL4d2vFt?=
 =?us-ascii?Q?fikEWbLmoIUfePVqPnqLGlDsHv35P7Hcf+vHjR/8/ZPyfUlGpfDqJcBModh0?=
 =?us-ascii?Q?hFcDMZE0Tcw6w4Ngnkn0NOwUM9vkspb53mM6TBJ5oRBskAvGkWvlLSJpDEix?=
 =?us-ascii?Q?X/OFz42e/57ewPSGqLKcm7iFgm/TRTJsZtKpQh/ZwkJmiyOLGMdCRZT0vKtj?=
 =?us-ascii?Q?UtTXfRiyvo+3RG7Aqco/TUUnOKlQZYysCqSQivqhO3UlVzViuoWbDVLy5seu?=
 =?us-ascii?Q?Ag8zgie9MciixEz8iItWaC3gqg99hKXdGWaUockUodDo81OII3UXSdtCJxS9?=
 =?us-ascii?Q?R+iPhGjBo13vXiaBb52pkxTSFX3tkc+IJEelDB+ugInwnR+AjtpjGSGB0VbF?=
 =?us-ascii?Q?xbp8NRj7odp698TGllHLNC5IP7kaczK2mmRCrXPSs96ydSx9mtvE6MkmIHuz?=
 =?us-ascii?Q?UOMO5MbFhuGhb/DKLtmGTtz6WRr6qu5Y2+pajvIUzhPb58NACYqhwMXLzXOX?=
 =?us-ascii?Q?Q0ZNI+aZMJGQkTDAxK5icBwiE+xn6nFc/mfcm2buHkg94JpTga4iZspSMi6f?=
 =?us-ascii?Q?lFatPMK5SHnvh6W0Q+3fd+lIj5287yfqki3lNR0TaLEy84ueOVDP/WWVY3aG?=
 =?us-ascii?Q?fMl7vT4xQw0/zoB8KimnUqL3Okgs46F1Bi+T7LFzHG3uJzV9N99JWBKPeOL5?=
 =?us-ascii?Q?jt8I1r0+z1uxwGtmzSFGIxQHh6HsTW5oM+YlFJneSGE0R3KDVAEWNKZ9uVZy?=
 =?us-ascii?Q?FLNaw/LX3O5mDB+nCaJGeTH+QUVheuU8l2KSRx1Y28e8CaFMH3wPePo4geRa?=
 =?us-ascii?Q?8GqUIBIPdVElPCwjLzU5PQhQukcIA22TnnDP330esQubomy6bp0vs6NO6FYZ?=
 =?us-ascii?Q?f11aDgZUwCnTCL+CYwubZEuZ1wnxs+gghDKDGv73xx3+PR1S0bPP+hH7V6FP?=
 =?us-ascii?Q?VDsL3m4h2rPGWTV7fqNQ/AitC5GW/ZKD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:27:58.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ecec42-1d1f-4517-6728-08dd31ace432
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On Fri, Jan 10, 2025 at 01:48:42PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 07, 2025 at 09:10:09AM -0800, Nicolin Chen wrote:
> 
> > +static ssize_t iommufd_veventq_fops_read(struct iommufd_eventq *eventq,
> > +					 char __user *buf, size_t count,
> > +					 loff_t *ppos)
> > +{
> > +	size_t done = 0;
> > +	int rc = 0;
> > +
> > +	if (*ppos)
> > +		return -ESPIPE;
> > +
> > +	mutex_lock(&eventq->mutex);
> > +	while (!list_empty(&eventq->deliver) && count > done) {
> > +		struct iommufd_vevent *cur = list_first_entry(
> > +			&eventq->deliver, struct iommufd_vevent, node);
> > +
> > +		if (cur->data_len > count - done)
> > +			break;
> > +
> > +		if (copy_to_user(buf + done, cur->event_data, cur->data_len)) {
> > +			rc = -EFAULT;
> > +			break;
> > +		}
> 
> Now that I look at this more closely, the fault path this is copied
> from is not great.
> 
> This copy_to_user() can block while waiting on a page fault, possibily
> for a long time. While blocked the mutex is held and we can't add more
> entries to the list.
>
> That will cause the shared IRQ handler in the iommu driver to back up,
> which would cause a global DOS.
>
> This probably wants to be organized to look more like
> 
> while (itm = eventq_get_next_item(eventq)) {
>    if (..) {
>        eventq_restore_failed_item(eventq);
>        return -1;
>    }
> }
> 
> Where the next_item would just be a simple spinlock across the linked
> list manipulation.

Would it be simpler by just limiting one node per read(), i.e.
no "while (!list_empty)" and no block?

The report() adds one node at a time, and wakes up the poll()
each time of adding a node. And user space could read one event
at a time too?

Thanks
Nicolin

