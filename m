Return-Path: <linux-kselftest+bounces-45099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA91C4043C
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF94E2DF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E9F322C8A;
	Fri,  7 Nov 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RqvNp81m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951152BD015;
	Fri,  7 Nov 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524739; cv=fail; b=AXNwwXgxGijIZf0Gu9dk7sq1nMlGq1T+1RHWcy4Dmwm7naQSxCFZcIxgAlPJA9E9ZMiq4sEr56YkMoFxNjfrypsWoGw8qeWrXO/6uyaHu3i5U96zRB5ipzVIWRG254mHDxlv3Ku8fGyucr74Dv/qrpO69h/nbSeXmaOvn/rfXFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524739; c=relaxed/simple;
	bh=eLQnXXQv/1fukQDIj3IyNJSu13qUyUj9FsdDMvsWwtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n3YuLPYAnyiVXUiHhrDwpHZrRiaoZhy1nfgbKOttRmal4vj+4hCeHK7JqopPZ5MZ8QAi7ZdUrZpsXeN+40gkmFeE7yTu9ihdVrXqOl4wEZaFKBsRu6cJRoB1VYPM9VwUY2ecJwYK+mQDFfYkevtUENpGEn/CBuNmJcH4rOPIFhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RqvNp81m; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgV84+WjRz4cwDEUeWcW/oQrL81hjnuowkxpUc39V08vbKxUOF3jqZUvroT0qL3AZbIvDXjCbKzPoZt3ihHED/hlo5CiQowBXKup7ny+Y6vzSvk5BTZErS9I3aRD/TR+tyE3Zt+T+oovHCLjubZAcjwYLmUhMbCfx7cgW77N5wDFc2bCoYB/hoK6hcL7XEF5JvFmwhm3WFCThwr7LGFKsGzrG6i+qZojTQgof1CHUEx4ct5SPsOwVXJsuWoRrkBIc/AEzk/spvfZKxW1FaV2wDHN8ZFyqecFZASXCgSjyexS9bzYffEd8aP2NVZstl10UL+8TJTulGPvaC5FCGwwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gvjszr2yU3UX3gIdn9iKCCNlDPoPlbsXGQ75ZuGLszU=;
 b=w5aEI/tAnqpT1yHsqyWxdOXuSe7BDKtbptWGcEayS6RG/Cg/4so7rOzQgkXtxvr7aUvGjw0XZZopfA2jugVy2hV8KOSJlE4GnXjbHB8hjdSxHTkuzP/JY52oKZoNbahQhbiZjxAwvQAowXC7hnvgHUYQe+E1NF1jTP2JpKh3o+FrrCnP3a+ntgkNJ+F+r6or3GPXJ9uqs9B6r73e1IUS/qoyLUGyiHgiTTu+nhCsUFsi7rSP77glaSuLPg7k7wdrZiGNVGu/Dme6HRh/jrk26zRLVvkk+noAIvZxo9q82HHlwmn8SrEd329f66KJUE+wQTaCIOBltWuSxd4sBe1OBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gvjszr2yU3UX3gIdn9iKCCNlDPoPlbsXGQ75ZuGLszU=;
 b=RqvNp81mGeJgALS7YLHkUjtvcJ4CuOjyul5Ecz+P7tnEeXeLVyw6RC0x8Bsc54oEwgnSoBXy/lEFKGRYRq71rZFP1hEvCy6e9OJeVbh00KlKYph4T1MOAIbk+Jq1RmtY3kCFVqPfEEwjolom0j5j5YZUh1AS/aVrwImjEnuIqLyCX3wF8xn/UHwBDcTb7bVQEF2qzMHJvnp0h90wTbD6udP3vcCUkJi8jJPRmwXXGkeKz0DdU52PO+kqqOwA8SzDdVm5vE9gDL39fp6qjkY9PIGeh+V1A/an4BkC6xTX0hdGRAP05FwT9gyqCCIb0su8Sr17rjQBrjcPG9cY0C3T3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 14:12:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 14:12:11 +0000
Date: Fri, 7 Nov 2025 10:12:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251107141209.GJ1732817@nvidia.com>
References: <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aQ1xfHuyg1y8eJQ_@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1xfHuyg1y8eJQ_@google.com>
X-ClientProxiedBy: BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ae9879-39be-48c5-9344-08de1e07a443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWMDV4o4FfeGKyiSlNk0Ww2byTOcNRqe4MjW4RDmCP6st7SWWrasH+xLWSZn?=
 =?us-ascii?Q?S1Gkoar9z6WOIhdsrfSYxSwKh3TjSAML2p0ElZEs9VwHON2Alemwv0Mgid2H?=
 =?us-ascii?Q?aqu5r3+SKGX/sz0ZY3Smqqo6CdcXAHQMD1ytNz60ObvkDwct3JWqHTTZ7ke4?=
 =?us-ascii?Q?/4RD2XJZYqVbzTOd4pHmib06oEeLEaGssx2e3dIeFEp0KQaDxcLhDktkSnBp?=
 =?us-ascii?Q?CkxaTFn+fX8zN+vnuQhqmLEFvN9OtpvjyPSW3Hg10Iax+7sYD0KZvyKH8YIV?=
 =?us-ascii?Q?6j89HHDlQThSQWLJDidGcjG1+L8aqw7vwIqlOPsH74wSoN8xbxs5N5Qoow+h?=
 =?us-ascii?Q?wOuYBIcPipL1jRN9C3tT855femklCUmkP9ICbHWiqQ1VFq6tyIc34yuXusPB?=
 =?us-ascii?Q?9O791YvZudfcsJna95+/jmewyY0lBOHfyJCdU/8pyhAtsluuUP0rFGD/sC7p?=
 =?us-ascii?Q?GNMkOd4peyEwgLBLCUe70u0xj5oMhuQcHiCAelxCK5J/LT8anGVNfUtjk8mB?=
 =?us-ascii?Q?1J0QnoUeAUUGuuScxViZcLmBQsW+iKXBcHvK+N9uhTuUuwSP1X50Jf0KG6Xv?=
 =?us-ascii?Q?Qz37KP6PpzvY//oaHJx/eRifE71lD9DdJHnDajIq3Wp/tJG16nmjpg0d6ozD?=
 =?us-ascii?Q?IrmXvFSOiR2qhNBJNwuDec5tMmrHoUMwa0FmWdkdR1CCMTNqHSbKldX1I4VB?=
 =?us-ascii?Q?9KDHJNXLfNV1rtMtSRzC8L6RXRmXM3djPWuy723XF3jhFB4URmTA9tFzNc9s?=
 =?us-ascii?Q?k8ANpcAlXzNqgRCNc+1TIb9gJ/q15iCGpaE7Dmdqk0uU+lGdbkwe3u7MPhSF?=
 =?us-ascii?Q?MVUebCGarXPThkCxjRWGW87G2hIAoyWP4qxC+0W7a/nbFY5kuzp1rijw0wdT?=
 =?us-ascii?Q?wDc5hGO3XxEZTLRJ4xtMEnSNdThSkj/KKbAj08TEPLmyWdg/EBo20epbod8z?=
 =?us-ascii?Q?vmAuE1zA546jWt4h+tJ9VW0WvvjB6NxID9Cd8YyBxSp7ETBxvqb6Gl1RdRLu?=
 =?us-ascii?Q?DDM04BrBlRtccDsVPX+8Fk3ks5xBYLY2DB88hi9x7+oECfPq8YVH0EXFmCg2?=
 =?us-ascii?Q?j3Sv6iv1xx9LLltS+REcPuXvemUX74+TwMawXVhg1Pj+5orSd1Bct5vDynLr?=
 =?us-ascii?Q?HHDTVSXNsljqEyfMAjC5OgYvjeOEvpaAUAYluyJpNu42zG9Oyf/yQ6EPLqDT?=
 =?us-ascii?Q?lBZOdfs4LXF4gms6eGgc4O8WDGhRH18PwJ39trdExka+yw5Jth0VczlLq6HY?=
 =?us-ascii?Q?D3rx0A7y4PahG0KytHahUGrWeIJ/haPRNH7cwVNvjRDy0lIrbIetyyTYZuy6?=
 =?us-ascii?Q?MGq/wD1e1byi6Ualhg6UMnjTgodXRVi/N++Nx5OTFCrbQ21HvYnjO6f+ff+c?=
 =?us-ascii?Q?XO1//RJrb9jLSn3U3Y7iHiFEKMK7uRqjCa3XarJo2WGkyOFRNPHzfihADkuA?=
 =?us-ascii?Q?9R9uUPIOylBYnrzxLhkEOo7J0Mouz9Cj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vziCuEpGZnNgUL4eiT2ZFNmduf18n/JuTJMJbsZrlSxF1O1Sfm5xTWb7sXkG?=
 =?us-ascii?Q?gGo9fftv5xkOzVFq35XqqACMxugzJNgj/2Mp9y0D/TopydLJq9TQY8jEF1nh?=
 =?us-ascii?Q?gD0r+0fSIqOqOxEIGnqjnb0ESrIs5vrGazC4GtDz2UjBQ/+QHQKeokbQsZli?=
 =?us-ascii?Q?yfQXUQLvF7XOadOAyoA6m/SCIVn+zRzpa62PVAAosYkROTAVydkwZHDUinWp?=
 =?us-ascii?Q?yPVbHo94tqAb3HxL+AxsnRwTrC3EvAkXhNwSoUne6mCSwpFN5KuUj3egyjWh?=
 =?us-ascii?Q?faPfJ6F2XkWCgS7P5DmrnLoL5KLMA8Q7I9MI9gWYo4LsOORZTD017760FXvm?=
 =?us-ascii?Q?RrTrYkcvZ20W4VSGf9eImOQ4ywtkryfx5ZjU96Hzv66JdA4mLLSpJTUP7lYH?=
 =?us-ascii?Q?Ioyru5nLrOX1fgXitQfsxy1qcuUz+otntPTF8xKE27C/JUKMT8BnvsvaJsHa?=
 =?us-ascii?Q?1ceUguedvd8Z0wlP9QFNZq3uyld9xCVYFoiFTQ5Nz69pXCSb5IX2I2/dgZpj?=
 =?us-ascii?Q?DzvbbSMBYG/jupC746vdW3LrF2dPT1a3OgRAGA5xJaKdFzzcKSfRE9CJiCMJ?=
 =?us-ascii?Q?7XE/KvFZa2koCu7K9v4XBniINfobi+wd6Gg4Ce7tpExdgwQe2vCLmSfBqoJd?=
 =?us-ascii?Q?lSJZIkfu40OpJLEdvqC9p0TjBxiCrUfZN7Kwt2eZEluQqpqmGcUwED0swa7g?=
 =?us-ascii?Q?0O3FoIjAVvglPQcCwNYxkzDgpxu7lbj0WGZ/QS5b5kJxsv7t2jDsn/ipOf9j?=
 =?us-ascii?Q?HGcHQpUDdKwkbac6PkuU38WbP+2DCbltpd12OQp3sSPWiwS+stFFCys/FlFH?=
 =?us-ascii?Q?YaDCWDLdr6mgXBAVO3OUQeMtV1Aqt2bcxw54kzXu1DhbwL+MQfUVI8k7afdm?=
 =?us-ascii?Q?HSRbVUzmnOuFz05+d6mg/3OB89m4ecKwkx0v/cxk9BsA3GE+hIJgO11IPnPB?=
 =?us-ascii?Q?Ng83BvrIMENYNmqglBRotFfvp9DouIInpwNRUr9tkzEShAsTbr6qNDfdY194?=
 =?us-ascii?Q?MGMjY0Jc+GFzOg912gCjj0pcpsis4ZSYslrruW+V4dGsANCN/M0NwyG/boWZ?=
 =?us-ascii?Q?b16g5UKLKFb9dew8smoRJNoWMxcSKAVB2ur74IZMvKicnvSTB03XB5xkxoct?=
 =?us-ascii?Q?V9S2XjHxfoGTuTnITzTksQdxGJgyZlf2qaMmbHXHkomSZbgdO0Mwx2R1fSUx?=
 =?us-ascii?Q?dd9hFrvM25w2yIfDMvHb2pLTwXj9Zcte+YmF9ue9bzy2iPOL6/sMwo5hmT6Y?=
 =?us-ascii?Q?ZVUvL49knFyZWldlZmfrK0FCJ0QRUQ6Fc5nSWSwn+3b0t3mJK9QT1e7IY475?=
 =?us-ascii?Q?ViETgubl4GXJCWuDvVhnOL24b9TY0Utc6ix7O+VrGVyLTiptGdyaOe+MvUUp?=
 =?us-ascii?Q?pOMlr/Xt1hnKP6XCnU7rgCPMYFsEfEo+T6445cKNqaIluIsVNR3QlvjgdX0m?=
 =?us-ascii?Q?1Crwg1/ug1tFIk16gEvuGhHzeL92Dt+CxfT8I2d27nGExHOsMKtSE5/yAGjb?=
 =?us-ascii?Q?eHe1IFz9L5WtbGCnwH2rkgfqEpSNGtq7l+Lk+ohYDt3y0N+fRDqa61/tLriL?=
 =?us-ascii?Q?aaJr7vs/+w7xHmPGaD0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ae9879-39be-48c5-9344-08de1e07a443
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:12:11.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywAU/+FvMpWcJ5LaAYA3YY92wv+iJdw3KhU3O62VEUzWYILf0BalL4WDfM+fVdVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

On Fri, Nov 07, 2025 at 04:11:40AM +0000, Tzung-Bi Shih wrote:
> Realized the approach doesn't work for the issue I'm looking into.
> 
> - All misc devices share the same cdev[1].  If misc_deregister() calls
>   cdev_sync_revoke(), the misc stop working due to one of the miscdevice
>   deregistered.

> [1] https://elixir.bootlin.com/linux/v6.17/source/drivers/char/misc.c#L299

That's not a "cdev" in this context, but yes, misc doesn't use
struct cdev at all.. Instead you have a struct miscdevice which has a
similar lifecycle as cdev. Indeed you can't use what I showed above at
the cdev layer exactly as is, but there is not a fundamental issue
here.

> - The context (struct cdev_sync_data) should be the same lifecycle with
>   the opening file (e.g. struct file).  Otherwise, when accessing the
>   context in the fops wrappers, it results an UAF.  For example, the
>   sturct cdev is likely freed after cdev_sync_revoke().

Yes, it should be tied to the memory lifecycle of the struct device
under the cdev which would then by tied to the file lifecycle. It is
not hard.

Jason

