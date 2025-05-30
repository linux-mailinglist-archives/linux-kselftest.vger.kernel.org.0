Return-Path: <linux-kselftest+bounces-34092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5B8AC95B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 20:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460794A6EA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA172277819;
	Fri, 30 May 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfZFBf/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433CD1465A1;
	Fri, 30 May 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748630402; cv=fail; b=cje8N+jTrKt5VLFKR1GFAMr6Wk218nJRa636o4RxnbA8wZL4ztnN0LS49IDNO+YX11qWzY73GHown/TG8pY9xaQiYQ8rcTG0hP4hCHBlX21ne2NjPBRfZ7chAxXBdg0PlxgnqxA5Lcaf6IVuLklhVXO2yjtzslWUdrUg6C6PMO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748630402; c=relaxed/simple;
	bh=+CEGfQJo8VBRECLBC0tLp6ZDBuJ4mXYqEJo3/M5lNQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdK95LYr5kpLih3iI1fmaGnH0dym5hL/xFTtSB+fh679r2/mo51LlntFZAkj/UJDX4b3cUL49vgvyqvP6e3kA/JcsxpSXvHkSmi37dM9W2B8HDd2tIsKaVIfNtL6m830WXC3BwTR5mVF1mHyPNkf/MWocm3Xd/15olyWPTLJsR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfZFBf/F; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8x9wGDGNf32axXp6Jn9UYdnl3kMdlnf9dF9KGmYtCYIiaL+sPBiyPx/n/1CysfjPDs22FDAvRWv23Vyi459r9u0OBm4b/YxKz+0dBz3Uf8Q3gO8mCp3krF6rb5BZntte2PxGEwMOzyzO1GffmoOFHO4c3GRaX0d/juo9HtCOzyynsjW0+1dOOaMJLl/PfwDZoJxr5JNFulmg/WY+6ORord5Rth4lqeJzvvXqb1wJSHNyU2n/f3F8O55ZBohtzM58JjTm2zgiayi8XoIx7lpMSsk+YExOXiN2tJjudq+gsB8KZulJFy3f1you9p+2eXERfIhmBcrPwxFle5BegugiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC91iIjMR6NZvF/+Y9VfUIFksUq2Nol8NfyWrKoy23g=;
 b=BQyqmb1Q+OYt/j4MThiaT1JoAn2uB96Wangjsn6+C4lkPfUp7vDzqIYgHPLCheNQrhPhy5nZtLFilm2iYWgLZWgUKMW7SDqespgyTyMWPMz3KaUfYrF0IE59EP0xAPR/2JgCoNX942EqLnpy3lXSilmiF/UF1/3bPanB0Ue3T0Jmvn0omh+xkUhuC8jHKxP6zUCCKJBBSDew46U2axmFyT/X9sn5SgUfWJSaik1o2SYF2cs6IE9v3yNf1PFggWnrcbp0QR0FUnjylf7+U+Tkrb5W7R6q03hSZKmuV+SAPnW066hRL4Y3Uc1VfB0OUcYJbKr33z4ChPmsl7Ro1IA6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC91iIjMR6NZvF/+Y9VfUIFksUq2Nol8NfyWrKoy23g=;
 b=sfZFBf/FhKW1vhchnVW7i1MIKmNQ3L1QQ8ndFWsq36Ie5XFn/IZEp1sX4jkZCCQ5CoGtUM7rCWEmhgQqqOmpwNibKOXkC/oUFigaFzy5YwbUk2rkxHQAFDyc65nnLuDBsqVCXVZeGleJwG/UpbHwnZNpzJXQxJh0pyyd3Yxsr9og8Dxc1mHrvgRW0U4lM3P80ROc8xq1gEXD37Vbu26gDq8JBLl0dIYRJnr86vMOewOF8GCpc7E1au455HTMgxI2MzbO3VFTrnRMM6bbGV/h5TxedyjLMiuUSN2fj0l+LMwjnYMkxQW1dWQb3vXt0d7SV1mWJM+ub6FJL3eU0DqANw==
Received: from PH8P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::9)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 18:39:55 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::d8) by PH8P223CA0017.outlook.office365.com
 (2603:10b6:510:2db::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Fri,
 30 May 2025 18:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Fri, 30 May 2025 18:39:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 11:39:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 30 May 2025 11:39:34 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 11:39:32 -0700
Date: Fri, 30 May 2025 11:39:31 -0700
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
Message-ID: <aDn7Y+3s+YD7qDlh@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
 <20250530161455.GE233377@nvidia.com>
 <aDntEDywhsgMoZwc@Asurada-Nvidia>
 <20250530174037.GR233377@nvidia.com>
 <aDn3hueUhGKWFIkn@Asurada-Nvidia>
 <20250530182519.GV233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530182519.GV233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 986f4635-9a84-4005-325b-08dd9fa95f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+5yU/KyfhwKXc6kaUCQ01mWcPGPmOmpfAnX0VP2F/J6PZjhzTtgrh1TB8H+C?=
 =?us-ascii?Q?IbuKaGqcmJT/qabThAPt1DSpJCsfuP3n0XHihyUJZn8Mh28LWEaGgZ785ryT?=
 =?us-ascii?Q?Ocbnz/fxT+Eho6IWwJ/6F0SNzJWeWxbqI/iheit3Ow9mX8VzLzAHXzpek0A3?=
 =?us-ascii?Q?XuTgwR1U1ap7rLqtIZ2xVBd2hfsjKxGuAt2qzrFVBenkBek8HCTxUCqMjgg+?=
 =?us-ascii?Q?ckFRfzfuDZibxMLSoePUwgY6/sA1aFGrnAy0AHAMoFYmDsEJ47q75WBayr/P?=
 =?us-ascii?Q?IiM3sE8aTkuR8rpihTAHBoPwr6xcUWdGiMOOzgEphLY+xeDjcyde3xLLb6AP?=
 =?us-ascii?Q?2RFl4D0ZDLz1Y8KHI06fB9hv3ljP7ickdOjuUNnv0DA2etswbg/uGoiDy2z8?=
 =?us-ascii?Q?8Gw82rMUNIxncKxj9AFX21i3V8iURooQ6dHQGUMnXhAka1VG/a+PyPMW7bEB?=
 =?us-ascii?Q?4umnsqV1SCKL6XTTDcvtdLZTiae0/d7EZ3ZvGMf87nJSgmzf4XrRImthxjxK?=
 =?us-ascii?Q?qa8tAppp/FzF9CbdGyjxyh301ykxodwHWaEgkCTMLIGq9bmA8BKquv8DgQll?=
 =?us-ascii?Q?ribr+ri2k88uqbEEbZ1zEW1LDORW33Up5I3icauEWgEEbz9O96GPdlgfeWq8?=
 =?us-ascii?Q?kMRTp+4JCmWUhK+KUK5nnTQ4TaWYt7efQUCdy1fwDcsFTFgTuehC9Bf82rvs?=
 =?us-ascii?Q?V1E1zjosZAbSfQWbKpTZEUjF1QQgc/u5c7gGTMesC7w89oQo2oQnIobU49B4?=
 =?us-ascii?Q?Ji2TkxYxDpzk6gDA8Wap+2N65WQMMVKP3sXgvI+dZJYtTl2LB4q9WOSPcCTx?=
 =?us-ascii?Q?eSqptZGxlUWKfIcLRU+WLFFbe2g+YNazAORjhIVI/spAIYapHtpZ1E74fhR+?=
 =?us-ascii?Q?keAIvlBeaf11SK5vBusITpF1QGVOMCs5dkycUAKk289c6BpxZwZHZdr/fAmi?=
 =?us-ascii?Q?CJ5vdp0KkZQiULNBV1WauCzdmKD5B3vICxdHHlgnvd0cDkI4b1tQtkS1qw67?=
 =?us-ascii?Q?A+lCSXizwEk7TCextKTGjyK19iuQvpJQOavscEWc2XyXcle4x6Avg04huk+7?=
 =?us-ascii?Q?JVWMlo4zBPLCTvsTsGrgpBnF5AC7o03WXnfGXGS/HgiHwmPrTMGS9nXaCVNC?=
 =?us-ascii?Q?gATyGwowFZQc+8y29bvqPBLgDab1yB8Gz/kmHFPQU4OvC4j6TG4aKXL3BA1P?=
 =?us-ascii?Q?FIALe8DRYGeJReqwO+KkskOEzGzdHCfXfMxS8xAqtERa4GGZwRU4tgFyqaCQ?=
 =?us-ascii?Q?efwrJFADP6BGJF4fSC4qbD8eUpGHZF7F+0rtnz7qSRJJz7P7iL2IlWYkVTP5?=
 =?us-ascii?Q?Q5HnYW4tOnF8UtvkJl2uXacai4mhjico+PkaKy6gpvwkyyacmdGteUimoriI?=
 =?us-ascii?Q?2MRooWhgBshcdrRQo4Rv3LmhuvWCcB25KGriu/RgKEh4axHaZYOf071T/62A?=
 =?us-ascii?Q?DKo85BZefuulFh2z+7u9M8CDdcPlpNpyn6XqtFT5+2d61cHoccvsynjQcfV5?=
 =?us-ascii?Q?VgbRL180lNbqF1gy+biJemac43gLuL9kPW/L?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 18:39:55.4955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986f4635-9a84-4005-325b-08dd9fa95f77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

On Fri, May 30, 2025 at 03:25:19PM -0300, Jason Gunthorpe wrote:
> On Fri, May 30, 2025 at 11:23:02AM -0700, Nicolin Chen wrote:
> > On Fri, May 30, 2025 at 02:40:37PM -0300, Jason Gunthorpe wrote:
> > > On Fri, May 30, 2025 at 10:38:24AM -0700, Nicolin Chen wrote:
> > > > On Fri, May 30, 2025 at 01:14:55PM -0300, Jason Gunthorpe wrote:
> > > > > On Sat, May 17, 2025 at 08:21:31PM -0700, Nicolin Chen wrote:
> > > > > > +	offset =
> > > > > > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> > > > > > +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> > > > > 
> > > > > This should probably be capped to PAGE_SIZE/sizeof(void *), return
> > > > > EINVAL if not
> > > > 
> > > > Hmm, mind elaborating where this PAGE_SIZE/sizeof comes from?
> > > 
> > > We can usually allocate up to a PAGE_SIZE without too much
> > > trouble. Beyond that it gets more likely to fail.
> > 
> > If PAGE_SIZE=4096, the upper limit for max_npages is 512, i.e. the
> > max size of a guest queue is 2MB? It seems to be too small, as the
> > VMM can use a larger huge page size to back the guest queue?
> 
> May need to make a new API that returns a bio_vec or something else
> more efficient then :\

Hmm, that sounds like a rabbit hole :-\

Let me leave a FIXME at this max_npages calculation instead..

Thanks
Nicolin

