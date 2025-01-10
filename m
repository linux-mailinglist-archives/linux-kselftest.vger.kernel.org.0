Return-Path: <linux-kselftest+bounces-24244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F563A09D7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C94188C0B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 21:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B821516E;
	Fri, 10 Jan 2025 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQkDXDoo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9ED20A5EE;
	Fri, 10 Jan 2025 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546321; cv=fail; b=aAABmDD17Xs1VKAJy6rloM4H8h8c0FjTDtPyTjNHPAQq+eAn2wPJw9/TDrfJ0g1IyGlfJ7IhuLEoGm4IwNFf7J4qwAarsnbPK+2o25nvn6bIioYUZ2/6ouKbmXX546omGYf7KiznGDn7wUIrxnSlT0ruepFFCigq1xGHvBEX9cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546321; c=relaxed/simple;
	bh=GUZbj71mEy5vuoVWfBuU/QCnJu2EWqQHVowHDmSXdU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk2JkYPYF7uszoSN12qqldzR9LCg6FE2ZPRFFjsVHyLP+Fo2/4lrfX3ec5iHeU17XAOizQr3eRbiuyqrzzBXftM7ylLHEOkB4lB7MP3aReifa60Ue7Zn1wfWy19kyFmTKMNwvvhISl7QOV8BDrbcIF2AZRXsoyCPM1CVk6k8S2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQkDXDoo; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amVlqeXstqZuk+eQ2qKR1cYG+UUj3o6FAy3Wm+nRpaYRRrNtd4p1unI61dcbjs32Zla5T7CecS9JMTAQjrgfcUYLobU+IVa7e7hakAd1Vc7UP67MS5M5hIXdG6Y0MfoHVKyjFH0xuF/ungRL95xymCtEa8ylu+x/faT7c5DkoJSrzSnvpGNcY5EsH/E5M9Oi9+Y4uXJcjGiQawkTpYo+eD17W/0/7OHM92A61up+csS2j8pHM62gDoXbt9z7rF11ZAiIFQ7z6qg5KgDhMq2NR0lBgQma9bmolpyPqTo/bSk+BP/RLPAd8jKDPmZPMvFRaU/t5QWegbF6qonmC4J2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJY/oyJ/rYLMf8rjP9KD6Uzi/DBklaBugSDHe2pdZ50=;
 b=H7WhsOo5twnVXTm/jCNAGsEpx54LowbDqSaqErMOna9llhaeXVHEPjDy3JRoXpQ/7vH+qUzxdU2155bhUb0cBHRBq/KzntdWE6UzCQKcLbKfE3fzi69Tz4CVyuTeygJyQu8Dj0EXh7Gd0feIqkGwm9rE4LO+f74RaRkqYEX+KOenD5YtKGuKYOqd7Em5D7hgwnYd/INnm64l9WgM1CXWEV2bXyMv1+CAFQsr/AklW9jXVJOiJZz32p2t5CjhZcwZZv+FxppRL1b4gSc7WPIJcO9jvb95nOjAfoAV7iPRMdN6HPy0R9O5xI+1YgkZWn3b6ZPeP0KhXSlms57MSviftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJY/oyJ/rYLMf8rjP9KD6Uzi/DBklaBugSDHe2pdZ50=;
 b=hQkDXDoosjtin6DvUqUHsOkvsZoxG3HJRUSkARZPOPcuvKrvBLAp+kiFtv1icHT67o8x+9CpLAb/zBqEmKCxHXOo+zF4IhQAZog8Gec0Ey+7M/535HcIYYI3KSMLS1XGG5MnhvGQhP25uvH3DJFvjP7NrWvdti5YmEbeu74TYpRfrUlSNlz5N+bPu5vlfuJ+2+QEpwQ5zMWkbqo5w15LezJi2Lqk+RlgLT9Se7CIIMaCFZJWauyme60TUBj/E1gPubyANhnEP8V6vOF8MOkCO9kBzUTJrJAIK7vXtSfZF4/RBLc0aY08lwy+IaHhIyym5md7CtWkWzQ8EbGxhEy3EA==
Received: from BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 21:58:35 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::94) by BYAPR02CA0021.outlook.office365.com
 (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 21:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 21:58:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 13:58:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 13:58:25 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 13:58:23 -0800
Date: Fri, 10 Jan 2025 13:58:21 -0800
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
Message-ID: <Z4GX/R6lRwuhlBJQ@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <20250110174842.GI396083@nvidia.com>
 <Z4F0uZBg05J7Nuhl@Asurada-Nvidia>
 <20250110194950.GI5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110194950.GI5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f49e53-39c2-44fb-d61f-08dd31c1ee8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8YziFOA6+jBTDKEC79Hc2PEBNFjM3kOP3o9YMXmyliHe04WsPErFOdhDWpx?=
 =?us-ascii?Q?STcKOn5Glj0Ezv2AmC3vZwZcRqKAxhmYgrY80vWxS78dDQ4XLqRSNj7A8P6b?=
 =?us-ascii?Q?AB4EbseIQcAe59vAYNBslAmn4AQxKTtvKfTtoPUFwEx0xs4JgqviM4WN/GKD?=
 =?us-ascii?Q?26GG853mFEeANDIBrlQyC4lOxcYRB7BpOI11x6j2Osmphym52c8i0KoPOXcN?=
 =?us-ascii?Q?RFRLjvoZIDl7wqTKsqZaFPo/Lupuyctl0ayzAYVRroXu2KCvNbf4XIyhOUlX?=
 =?us-ascii?Q?3o+GNoI5UMj3amk8uwJtkeozcSNXkHY2tgkiZH4M3N6P63oH3BjWQIBg/c9+?=
 =?us-ascii?Q?q4leflnkaP3ZaxOgdddPMNpHRUtL7l2nhcqipJkIBWJzStigIDCumw42PMf8?=
 =?us-ascii?Q?PgI9L00+IyXoqlnUx2oG7aOuWTEd1s/OWdDp69sprsNhaNrIVZyACpvjbIXm?=
 =?us-ascii?Q?y+KHy0qgdwtwklP/SnyH+MHU6fNQEWK5UxuR1WlPc45CPg8RvbhzvHB77v83?=
 =?us-ascii?Q?xHFcYcdMTpT3EiQmvro6PlN+9nBS1RdSktlJTQZk4njLNFNMAshZVFj5esEM?=
 =?us-ascii?Q?1s9Sh2E1EN9o6Q/38ACkmLRa7XQ7bmERp6Awc/JXENz3NPz0lpTHzWhJvSQ5?=
 =?us-ascii?Q?eaO2DZPWVW+kKQI9DzNCeJ8vqIRolRKd0jqncG14Y+5s0Hh6NJ9TprgH0kQb?=
 =?us-ascii?Q?V9WONTzbcOyTlMlx3vEMsLDyS4tT3Fr/mEag9zcSK3IlK7GLUpuFO7xq1shw?=
 =?us-ascii?Q?ITLz4t+AG9hdkN606jMs2fLgNbZIyYJ5aJJN/UjIlOrq4ytNm3E2gWbxt/o8?=
 =?us-ascii?Q?iN7tU4yTqH40CvGVtt16zgjhwDeLY//xZHeHJoavuKIWsmC5tNKSmEwgLFEF?=
 =?us-ascii?Q?Ta9n03EfHMql56IAiW4WkXDYbh+nylB8bRSaYCoD51mUx71LRcv/6sKoSClq?=
 =?us-ascii?Q?mA9qnvkQ5cQkhvcmgs2dmt0N0IHvIynEcQupMKhIj2KwDHvRr92dpc4c6Mg/?=
 =?us-ascii?Q?j0Oju5aQv6Scy/7mhfj4kp2WMfyZhXFcpfFyWiaS/VNFBnleqIEeCqlUtgS6?=
 =?us-ascii?Q?XXwY1F0Abu3iyROfCVO0xi0t56fF8B9UPmXT8w2D6l1DdPzE6zrGfesWK66f?=
 =?us-ascii?Q?X326kTswMT0DZrPvCshlqeCRB15g1LRcRbGL73mSkY/IVDeV4yiMOT+bvdKk?=
 =?us-ascii?Q?8Pk64H3wWs20+9wagVVd0zeayuOqlZpLxpQ1nVBvTOd0USPzTOiXfCiuNLbS?=
 =?us-ascii?Q?336k6uZmElot5VQIAK0LmsJKVEZnhnAoQw6843svdbzKCgB87+rhBvza3v0j?=
 =?us-ascii?Q?+il0QaWcEFeSo1L2x36HIOghZzYsmyQ5zGlV00/8FyWp+8LqFAZ7nJTgkkti?=
 =?us-ascii?Q?xOEfqdZeDqrMaI+K700I4K0TM845OeSdh5JrVsA3MA5lVIYEZ/Yx27BLMoOd?=
 =?us-ascii?Q?4j1fR8Wcgirueb6EIYWCzYrw2Y905TNrlcFRvUDdwllI3AwolYwILgnV/hD+?=
 =?us-ascii?Q?MtLSyBWX+D0PoCI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:58:35.6822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f49e53-39c2-44fb-d61f-08dd31c1ee8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

On Fri, Jan 10, 2025 at 03:49:50PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 10, 2025 at 11:27:53AM -0800, Nicolin Chen wrote:
> > On Fri, Jan 10, 2025 at 01:48:42PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 07, 2025 at 09:10:09AM -0800, Nicolin Chen wrote:
> > > 
> > > > +static ssize_t iommufd_veventq_fops_read(struct iommufd_eventq *eventq,
> > > > +					 char __user *buf, size_t count,
> > > > +					 loff_t *ppos)
> > > > +{
> > > > +	size_t done = 0;
> > > > +	int rc = 0;
> > > > +
> > > > +	if (*ppos)
> > > > +		return -ESPIPE;
> > > > +
> > > > +	mutex_lock(&eventq->mutex);
> > > > +	while (!list_empty(&eventq->deliver) && count > done) {
> > > > +		struct iommufd_vevent *cur = list_first_entry(
> > > > +			&eventq->deliver, struct iommufd_vevent, node);
> > > > +
> > > > +		if (cur->data_len > count - done)
> > > > +			break;
> > > > +
> > > > +		if (copy_to_user(buf + done, cur->event_data, cur->data_len)) {
> > > > +			rc = -EFAULT;
> > > > +			break;
> > > > +		}
> > > 
> > > Now that I look at this more closely, the fault path this is copied
> > > from is not great.
> > > 
> > > This copy_to_user() can block while waiting on a page fault, possibily
> > > for a long time. While blocked the mutex is held and we can't add more
> > > entries to the list.
> > >
> > > That will cause the shared IRQ handler in the iommu driver to back up,
> > > which would cause a global DOS.
> > >
> > > This probably wants to be organized to look more like
> > > 
> > > while (itm = eventq_get_next_item(eventq)) {
> > >    if (..) {
> > >        eventq_restore_failed_item(eventq);
> > >        return -1;
> > >    }
> > > }
> > > 
> > > Where the next_item would just be a simple spinlock across the linked
> > > list manipulation.
> > 
> > Would it be simpler by just limiting one node per read(), i.e.
> > no "while (!list_empty)" and no block?
> > 
> > The report() adds one node at a time, and wakes up the poll()
> > each time of adding a node. And user space could read one event
> > at a time too?
> 
> That doesn't really help, the issue is it holds the lock over the
> copy_to_user() which it is doing because it doesn't want pull the item off
> the list and then try to handle the failure and put it back.

Hmm, it seems that I haven't got your first narrative straight..

Would you mind elaborate "copy_to_user() can block while waiting
on a page fault"? When would this happen?

Thanks
Nicolin

