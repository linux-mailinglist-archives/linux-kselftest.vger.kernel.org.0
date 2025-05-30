Return-Path: <linux-kselftest+bounces-34073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0825DAC940F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB1A3ACD90
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E414235065;
	Fri, 30 May 2025 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A00wqL/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8974431;
	Fri, 30 May 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624252; cv=fail; b=OFBS1Vvf4r9yBodPQEgNAv4qvluSPDg6BPu9BK1Cljzojy7n2Q52dLq5HqrsKbarDeHect7mDCA5MRclzkEOiFpcwbPaQYHjxP5yBURSNUx97DAxJ25s/7ss2WLnbDB3KieAC4oQZsTsTLuAl7OAc6qWuXiduMpPZbbvzm0ozVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624252; c=relaxed/simple;
	bh=UosqIsr9LlqaozyxO126A1gb/35wOnkjs3Vwa5zJQvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b79WuVSrJMVapyKula18JHpmEmBjY1K1CpoUMOCtf1PiV1xasHQWtHuBZTeoKWIIRpe2/FrU4vkuTcXnjTWBbiQ3nlmFh7mIlbxb9b0GisrwF93HxLXw/Ed8chLtMDnzK5HS2wu75WPcQd+zhHBB2UgE9gVRY5LqpTcdxZiicrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A00wqL/c; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAyjfZKI2PqQpYPD9qTnEe+4Xq6RIqfMRibgDppvZvhdRxd3OSlueOWe2lvrGN0r39ZOEMxCdkKq1+XY6OD+R+irDF6/3xOK9bZmzoK5gcDmQ5eEls72Faz70gBXlcpFMxKy/FOVosHOo4F/PSRrRPa1K5rNonklYkYF8BH2Hv3G6nk4NZBly1aKuP9w5Lt0DTmS4BnOPCb1uGL79Ujz9zfyhc4dHY2SEoRXonA42E92zXtyHpTTk5h08f4hWu3iJSO1TLcNxvU2ao2LLWv4wLKTHU8Tk8P96c7+d76c1q0/wSahgGZuBDAbamQ7Co/D4KhZ+a8iAA3JF5GTNz521g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBBrYLJXsfgIfDNZ3dRk1/4TfqhfSWZIPIL0m6o/2oo=;
 b=mcwkLgGdlfYkTexUF8/Z3l/ObDGRt9/eJJ7KZNkupQK+6PSE5XjJvmbZXldXdwQBPTQ114NuVfXi3M5GeFQHYydq9jlrXbUyqhugSkT47L7jpio7cIJhT2TUVA5qQEpZsidYnYVh6QDveG+zwPhHoJt6K53FS9woFe9hhRgCgu9j1tl2DGk+QNLwF405sOLHX5J9kFKz0LoKJdz9GaYwiXb+HXnV7669mZ37fikk5r+UC6F6dcN3Vgu+V8GRB+V/4RPFBKHFIzX0txlMG7z2dZr7Q/bcDUF874f3UYiByk3TUm/4qLu5RfQQq1kj92/Zz0o0vlQwATw1DUM55UU/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBBrYLJXsfgIfDNZ3dRk1/4TfqhfSWZIPIL0m6o/2oo=;
 b=A00wqL/cNBZbiZlvz/IPuH/Va8qHPGX1RxQ7C8d0xHf0p+m6fMR2jDwtGaxnSKMYGx3ZCuzL3SiQsalGoqDtW9O7ia+JesMI9SPuopgc2SjBv91p0peCGfCqtAtPcZKxJob665zvApt8Yo1YrsiPHYyitYtU2Hzl8QtBRINw2KJoGLtKDWtshBJoqVIGeu8MlCIEbUi7fX3Cj0MrW0BB1kv7J+Ioj9EAGdQNBh9ghHVIoiHod+JWC09HTtu2J+gwlG/2PzwpAsAFPZaRkJovO3XJbn0NDMNxMV0WLvQ6MRq4k/ZDxjIh81elC3XAPw4lDxyUe1Br36JvPL242z1lLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 30 May
 2025 16:57:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 16:57:27 +0000
Date: Fri, 30 May 2025 13:57:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 24/29] iommu/arm-smmu-v3-iommufd: Add hw_info to
 impl_ops
Message-ID: <20250530165725.GK233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <9296d67c92ecbc5a6e33a1162d8f41149b2f551e.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9296d67c92ecbc5a6e33a1162d8f41149b2f551e.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:408:f4::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: cde0f746-b754-44eb-233f-08dd9f9b0ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydZAl8DvkVomsE3dPBHdv/P/vxP11ChUoTY9vsSz8D/EKwJ+t2pz4Mzx8KOf?=
 =?us-ascii?Q?WPFHQFp7wmFsfRaOrSY95uMb575w06JkMvU9V0QKITGag77gvHj122e3FQq+?=
 =?us-ascii?Q?WDbSuogWCevyG97Evp0Kb/cFD9jVdNsKJ90XLD4B+mI771j02DqUN/l6OgRa?=
 =?us-ascii?Q?OitbmvrK5TsdoqJQpSBLSR9nyYD7Td74OaqSxCysXCX8lwZpY7WpSZZU8QZV?=
 =?us-ascii?Q?drwlQtL1/DQzCFoWZ1tJiZIo7TXWfmMFQdAADdk2yKtctAam9ta2xX9CjOgl?=
 =?us-ascii?Q?NLmthLWPfPQsDKddw6IP7MbJ/lDI2B3Z9XWD2W8nyJiOdXJbtLUDwmLWuUBb?=
 =?us-ascii?Q?vgyiagZNfWUkEOrCD/xSrVtGO+YPUQ+zOdTOsrAoBYbwUXc3UGnjnf7xyHYM?=
 =?us-ascii?Q?8lHMBe/Of2EetWCyc2zNDDpOi8ybWBOw3u4Dej3F5r0vU2rKdijRYWVfPjQJ?=
 =?us-ascii?Q?bdWT7kh4pyDaR3FW2lcEYFx0nKJyRk4VVtmgmRrdgFnTNspmKeojwSCsvMfy?=
 =?us-ascii?Q?LiHa/NPiKAi/9tLbb/72SdffcF7Kv7x6TTO60galoTZprYwEjSYeu6pohPuH?=
 =?us-ascii?Q?caGMd32OqCM9eFJtDr2oTEDBQi3uZzSR7FD3l+E4I5CoA7GsbeI180CDU1q3?=
 =?us-ascii?Q?NYtQJK81d4KHHXzrJrtEcy9zyTbQF4vUvuilC/L/Uze0wgTAzQ2BGR+aRzQz?=
 =?us-ascii?Q?RHJ7DQF2j0WZWF947UCSyDDex9BfAHR24eHgAb8tVG7IaTS+zn8XDTjuUTu5?=
 =?us-ascii?Q?QEHZ1oWjxeEfXhV80CZi/FmKPau/1Vkpi0xnCtYwIhI2oKuC0P5heSYh1p0O?=
 =?us-ascii?Q?Ttp5x1s7iDRe/z+C6ppvpsMjievSCed+pl9ISiQKNlBP0TdeQRVmP3MtlxuJ?=
 =?us-ascii?Q?35Oq5t7Ixzf9XDmNXbNr4CG4cgaykGgwpT6xfo/p4Vv4qPQdFi6BXnhxFFbx?=
 =?us-ascii?Q?WkhKCQHu6k0ziLpufEBneL4HUjLgTy9T7658FXUPUlvh2S1s5Gs3ZqCVWBB5?=
 =?us-ascii?Q?XSyjNocCHbyg/8qCx90o4d/P4F/ZvHOVGQQdxUsrg0WJNKxPUy+SeqEqAiTG?=
 =?us-ascii?Q?1epIbnuKBvuswwa5aG1PYSjB9FZj5U7uIeNiHHWltmXfPfWLIYGz0WDS8KDK?=
 =?us-ascii?Q?5dNWMHdbHkeD8Vm7h33I+e/MERWFUtzHolUgnCGr0+WfUc2tgGylx4vzSzSy?=
 =?us-ascii?Q?k0qHInDc3twM6Jw79lRwnb+dBEXG33kRl+Y5tYbs8e2n1fqRE5Q99iLCMjF5?=
 =?us-ascii?Q?eih44wXtJhJvjOi80DDOwK52ot3onSaAwq3s+IqCLcFVtag8iIeZWSHcWoOi?=
 =?us-ascii?Q?Rv5XgIW0NCBfUTAx2DD492mNrFjRQXXlzHlq8pS2cg3gTl0LimRDwhG6Vvh7?=
 =?us-ascii?Q?w7vonUfEIAj1FyuqeTI1oyzSKPhX4MtY8z+G3oEGJDadgtGrFcGR+D7c5Lf6?=
 =?us-ascii?Q?4IN0cJvhI0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3u6nyNc+QqQ/4SXtKnAyRF8zqCDNIWteoTV1QKvj3uEJNhXIPdN7EKJGYWI?=
 =?us-ascii?Q?0sfEUXAA0WpHYexJXoGDjpwhVyL9Ks7lO/t9RO88HWuh9uq3HFlXw6qVCUye?=
 =?us-ascii?Q?7CSuuzzhMRNnT1JGiQeXSjknKc2sKIhxdnqHx+PAQ8nIq8vtNQtsKJYRS9o1?=
 =?us-ascii?Q?ISUKEfjJfskGLbtxIuTYpSqbhA+ksJItf7LLz6KejeTFoa98ZqquyewYGK/j?=
 =?us-ascii?Q?m2NcmpXFscqpDX/wlOQdjlNNRFJrv0BzbET0iM8zmi0G8hlMWgj8cdZhLx1a?=
 =?us-ascii?Q?7pdeBGnKTf55F8C/Onbdz+MVU7/8GppzFRkJMDwDxGx2mQNlzreGfECdE/jK?=
 =?us-ascii?Q?qM5EzqPKgaRjZerMPnezDnpHjGF/Q8ietS7F75gvL7Mn3M89RSX1OzABCy7/?=
 =?us-ascii?Q?+vYk1t/AesSEU6dZyXOzCC2G9wnLdSWY7HyLnvTQCDPPZUj52CDt2QAZA76V?=
 =?us-ascii?Q?JFFfoSWQSXHFD0FzkstD+tba0lraB0nUSETNOUaVJA+lZeH2oKSg9rbgQ+3C?=
 =?us-ascii?Q?Gy4uL1anEPH9Hohgy+iAt0IQlfVBh9ZQNvlG/HKNesRUiGLhbCOGPZkSmPGU?=
 =?us-ascii?Q?03eACwWCYTyv8uVZCC1gw7X0Ct+x6Zphbr0HMgKCbctATRnhRuTocU+BZ3vB?=
 =?us-ascii?Q?5JLJGgxhdpv1k0s6etXDg1Vc7SCqyYr++/dTO2eca/GniEZI5X9ibCDBJX1Y?=
 =?us-ascii?Q?HJuahcEowT0yYyLKCDmTJVaTuCvhFQc+UNyb99vShmUqTEFopCN/iaXpvTII?=
 =?us-ascii?Q?P4Q0mbacnV2M5C1VZd0VsW8UTKhYTF8T/5kY3NAQ059dyPVmKx5S6QQ/98po?=
 =?us-ascii?Q?X5njXIWoH0L6XdSuiX7ThHtfYMh6+IYsDoiU+At3oUYQvYHAIK+EgaEY+pwH?=
 =?us-ascii?Q?O4/+jNaAGGgIju3TL2sWiOK0NXi4kXSkCcJbRaYsfZaUlJWNza4nGSpEn232?=
 =?us-ascii?Q?xIaxC39qhDxTAaw6UuPQ9G7PX0/Y956TyIEB+lUSiZ32dkUl+B/4JA6UMzdX?=
 =?us-ascii?Q?iLvLzaOUYv1gOQLmwuphCFDtpVD9axvAhqV8lSPdxzKGY5kG/N/AfJSQoBP5?=
 =?us-ascii?Q?RgaLVSLtU6UkZIAzP5Ut028AUpp/FvBOJ2FgpdDumoKN8TG4gqM+V6aDTKnl?=
 =?us-ascii?Q?Mc1C/Ds37LrNe9AsCFncvSKfdZQqJmn/N3469atEemQNLCj0yh9HK3ixxMVV?=
 =?us-ascii?Q?wrJ98SPPzWdI0CgdM7yYPe02yI9m3uQUp9ox4Q2Ay9hPHm14VEDkVCS+Vtw7?=
 =?us-ascii?Q?dMJc16A75cOHoYmwEFBEdn590nLXfypJBUiRtR5FLnqDhYcPg+4eBxStlPPy?=
 =?us-ascii?Q?ns5qZbdsYeC3qNpMzSfDHo29jpnzcI8UtJJQeo3DW9Fl5cv8d4UChHStjzys?=
 =?us-ascii?Q?lVoae0Xf+iqF1Z+0qR9+Ox4d3NK7M7y/Ndp2lh3GqsAyOvG5DHQmDuqqMS7r?=
 =?us-ascii?Q?1VTA8C4E0vScx+aRY44U3wdTXpMrJzxkumR748yBAr7OVNM/2ECjkHw7HInn?=
 =?us-ascii?Q?dEy5XF3cI/aZxEZKyVB9ZAYe4HKBJZi5Ws0K2dXOb2dmMKnf5dZ2cLI5zORN?=
 =?us-ascii?Q?yxTwLpaMLtJJGoDI67nJQGdRFCQIaImvEUJmw7sn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde0f746-b754-44eb-233f-08dd9f9b0ebd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:57:27.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QS9RO/alTERXPx9hPAuYj0EGs5SKMFWvwhMIn/DVKKeYlfmWbAWgh6jEmXqQpHi+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903

On Sat, May 17, 2025 at 08:21:41PM -0700, Nicolin Chen wrote:
> This will be used by Tegra241 CMDQV implementation to report a non-default
> HW info data.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

