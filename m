Return-Path: <linux-kselftest+bounces-45001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704DC3C27D
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3320E1AA13DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8677F302179;
	Thu,  6 Nov 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kuBDtcHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8F2BE621;
	Thu,  6 Nov 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444042; cv=fail; b=GfKGAQeYAzeIcUFNfNhzJFehzcqb9IDZiXUPvOJjYW2KsyvxvaBFqJfklWenpX+0Q1sEMrHitKU68qrI1MaO2nKorzA0lH8pHLdlXu0zxp1usyCjXUCAn5pEtIEoD/wWzsD+a/YmqOW3GpMQZL4cjjeCCGo57Ht/BGVtH+ZERV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444042; c=relaxed/simple;
	bh=JGAm145/RArNI0ZfVtx+lo1QLAAzYy3VI9xSmihBujU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G5w1IDiTcDW+nSPaDq3CL6gmJgW8NLUmMvxLLauFsioYG7LY0Gqd6qYFe3oq2cM0UFjyuhMIn8sGDHrAfqsC32tw/4/JxtZ8QFGUrX703jAWZfp3QGkD8/bk1FjQj1UOngiUoZfaUiLOM48a8hYOx7O8SwyCN1rL0i56sAXeCk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kuBDtcHE; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwKaIWXaoa3X0sjlKe1QWqwRLQvzpK3rbYa0B4PActnFS6tIa0tzqe/ZQCWnTrItJngdEIu+2FE1iT5r36eqMHyaZW8dEkUcYtEowmO9q3ZdfJZUNWw7NvFUlnrICMhNXsVHMLMDzRjgATNr24Wp+ZoBK6mdJRRfW5TW/U9lEVEoSPRkuNSi/UX8/DtdhBOX/yNq2XK2xhtGyvyJh2MJEBW3d2dupAnW7wntFToA10adOWxlr6G/xPRJ/uAw4hWtmvdBwND/dIf+ZYIUmLcuPJWNCsDCZPHe5ScqhFipI0SXZmxzhXYRuPlEVCcwFJgzccXRHVWef02SSeovkc5LOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRc6YuIlo5aH1HDx3hyBmzDL32tFRf1VyosEUb+EQkQ=;
 b=w+j+8OSWZOAJICCQxq1X8ilC03Mao2qdCacihAvGyLd/OwmemffCOi7KtJrORsAx+KQW35dVnCyQiLvU34kNTnxwHPTMBhVOEDsOuYDxnGlyoGwNxCVWRrSen7jrn1nTKydAUgedkV9gsqy6ySGUamZcLmTHJVCqg1w5C2eQYmHIuex52+zP4zy8ibPEm+QlYXHXL/Ujkn08H4BX41Qn3V0/Wr8wE0/8Cknac5EbfxbRd8zEGozHVplvzdpD2x0r2nM2ZlvxyQQkJiP0qVCFCWnPlFWE8nCxaN9NMy5MHLAban5EqzOcP0AdYJJ26lL8tt4WSf9oKkJPGrfDlKwpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRc6YuIlo5aH1HDx3hyBmzDL32tFRf1VyosEUb+EQkQ=;
 b=kuBDtcHEAAkQ2BrcNeYo3h5Sbm4GF3X/1uN9G4B6Jzecmoi1QFUUgLrtLXq9vcGDc2J/DB4hl88j7s6hwYS0NcsefEVXHaJG0K545qX8kfxkyE5QCG18u4adnbBjCQU3PNuRvRs/FqxI3CxAeAFpTKVzOsXBoJneO3V3UCAV1BuBc6Q7kZkMkXUDuW9MOgV3yAIziiKkGkbb/epe0hUj7S+Q+5tJsyg4YWmHM76WCKWeDe/mF+o6ixkESVCEV+8/Bp0SvmolLdJpduXkd1SL7Jigk51ma9+Pc3etugb6lj55nwCBT7JG8iZSeMqLachDccJcotG7k45nWnYCZwjebg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 15:47:17 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:47:17 +0000
Date: Thu, 6 Nov 2025 11:47:15 -0400
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
Subject: Re: [PATCH v6 1/3] revocable: Add fops replacement
Message-ID: <20251106154715.GB1732817@nvidia.com>
References: <20251106152712.11850-1-tzungbi@kernel.org>
 <20251106152712.11850-2-tzungbi@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106152712.11850-2-tzungbi@kernel.org>
X-ClientProxiedBy: MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32)
 To MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 74689851-bf93-4f3d-4eb4-08de1d4bc360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEMaBU+V1kk8gEga9W2PXNuOmnwpafjWPZN5N8nq1M14VpHpSmd13M5P8A+y?=
 =?us-ascii?Q?jkm8rDUCkiKKE5rBr0MTpcETWGFiEAYEN7IDjCpjMvux+8R3ALInpIqZvDXb?=
 =?us-ascii?Q?WsjpPdzynhPhmencjWvVX42nWoR5aX0UUVLDAlHXqMQsNzavXS7NywQfddNM?=
 =?us-ascii?Q?rbDki5/uIg5CaleI20ijtgpO8lveAr5hC8qvCmklA1CG3fia/CTsX/r6aw4A?=
 =?us-ascii?Q?2Dikz//nfoWgrrfEcA2I9W1hqhc/ZHszKatNy7ApHnMZc8DKKMD76rA1Is4J?=
 =?us-ascii?Q?4RdPdfGnZEiI0U+0lRTLuWjFRTkW59aMrEgzEfD6K2jQh4fDPU9gzzjHOL5R?=
 =?us-ascii?Q?gb6Z6YnhgtPGr2sT9E40gpKeWBka96IVTJilzlTnRbMP5slpsJdoY9XNtowI?=
 =?us-ascii?Q?0ZAaxvLBb3xD7S4c+mxR7R/kpYKMYIH639FZuy0lCb20mo4hmNuZTyIihDc7?=
 =?us-ascii?Q?xWrYboxd0PL8aNSRtWUuC7CSayrcXciC9xUlJSrQ3UX+6Gc77Pc++y0GzGT+?=
 =?us-ascii?Q?H6TxeSI2D1dJnqlaLnd5K4lld/JIxF3iomZSkYXpBBs8wRS/evYpNHjjY8LE?=
 =?us-ascii?Q?o8UVybSRNv9U9c4ql3snf7wpsjG6y4fA6EEBrcV20CDz9lpnm3vwdNEvsrzJ?=
 =?us-ascii?Q?2yfscCtyi2AvDlZxckTqNd56Ec6PUUrEWs8EXZAYubmr8Q4Ff0gTQGuGT9hZ?=
 =?us-ascii?Q?4AUt8cG+Ip6jS/uJUZ2jCnIGAstswuW1pMUWsWQFK5CIKj5hAH++HuA7fTyD?=
 =?us-ascii?Q?4UCAC9xbebVJhhX1NaMp9xuVPghqa+KkANzlUlWZK0HwmQZqEz+8KzyqDwmw?=
 =?us-ascii?Q?oxcXJHF3Rmc9CZnRQgm2ZKx+Cgi3xD432vFyUN3veCrxKS3Y00Y++cKOuusx?=
 =?us-ascii?Q?K63GQSIVhGGerH/OhCDPqAllxMBxzCFuhTFhJLXOCi6aL3PBPy355PLdIUP6?=
 =?us-ascii?Q?KpRLjndV8+fCbaw5N36wktbv2ZKfVaAq3t2+6puwgnmMhw3kN2IRN88ILCzz?=
 =?us-ascii?Q?ThRlDSec/xPJyiRz7tjxuntfUS9cS4SDaMaPIGuGTkXsG6gdL0GFK+0qdrdL?=
 =?us-ascii?Q?IfyBIoMZ1sqMBqgFhb5QSz2RU3Mr1c4tGzLNgnPmTttOAQqioKYDwqL+LZkU?=
 =?us-ascii?Q?56dlI5hugHHPnJ05j13weYbrmlX6tyBjoJBg43A1CbSbFktYbpPAeTE0FttW?=
 =?us-ascii?Q?dC0k54K7LW7UJvZEVNGuB1/956Vxz+B01ihtxeSXjNMo9qsNAySdkbC25GXw?=
 =?us-ascii?Q?d4+SvKTd0oymm3YOUWwbqul65P/jFNb1rQPAaiy7rASE8Gj4dVQTwbihhOug?=
 =?us-ascii?Q?QBkfjXEO+xu4D0qGqv7vonCX13RR1KoZcbYGS5/vxsQoaK9yB/mE6BiQd4Tx?=
 =?us-ascii?Q?mHss3cVW/rnF6XHrkARQ4Mwg/m1ECX42zh8W2cHEv9qL31QVMEu9sELtSaBH?=
 =?us-ascii?Q?e4kUMBJkryVpXEjZpPsv5iI0M8R14n9U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KTNPkiLxFVHvRlgeWtJqFkqPGf4uPG6KjKnBvJ6svRJAdWdPP/aKsI5vhehE?=
 =?us-ascii?Q?TVMYepYGFT9Elv1U54SKdmpfvd5pm2xtv4B9DgUNmImum7qVzobK2z+r6iFX?=
 =?us-ascii?Q?idQjUY3E0/1zbeFQu9ewQ+F4FvvbpTm4C5QIHg0s2IYsvekTXzzrbQ4DK1jc?=
 =?us-ascii?Q?w3QqxNkVt2j0QfPEpjIsRCBgJ7C+oUYagQkJ0VkeYgxJsHrl3BRIswOyej83?=
 =?us-ascii?Q?CmI3jbBqMquBPELWDIU3kFVYsULg95VgIqwoqIZPXhLMEWuDSop4w1nXTpyb?=
 =?us-ascii?Q?IkZWg+8UM6My+eZNNf8rYVb5W7oQAlc+6jyproeV+qxHbkHUV0sRKBhocJNh?=
 =?us-ascii?Q?9p54doDprc2t710SANufDhBy/nFEZyFQyQhcvS5AAOJHM2J1j9G8LH0D64Z+?=
 =?us-ascii?Q?kzO+fNo0Eg0EJEj+On6KelUaIrAoMVDmH73sA1Z4W4FUHDxVscoY/5xZLBDY?=
 =?us-ascii?Q?5y1EBHG0typvatHqP3OP9qt1eG6uOe0xVeNxHXsRkBWMRkmpa7wto9v/2tnZ?=
 =?us-ascii?Q?RGQqwO3tlRjjwVGYmROCcfK7PKHAbmBIGLwCByYS8o9yjlv27Bv77JGcFoqT?=
 =?us-ascii?Q?9uu7pET5bNFG4DADMLpJ/NIzvTN49hLtrbZ3yoyHw3OAu9BT9PMZFWdr1he0?=
 =?us-ascii?Q?xR0SqsJrTGd5Ub6gpY/WvnqaMZdrlniOUsI4KX/FLM1shSTWDte3qj2isI5t?=
 =?us-ascii?Q?/sIDXMqzTMtpZHBl6naTm0x49NT3pK9UT7Df7F8d+bWF2lGzEG0OgYrp7xhp?=
 =?us-ascii?Q?FVK9x7hUgMynDDdjisZU9s3eLkOFfFd3b+QZj6ViEYnElq73YAsgNSVqT47Y?=
 =?us-ascii?Q?MArC2I6NzAEejVuzLwqCwVnMG+Ho6U1Qlvn4SYZhS3NPaTe9C7Fr8nSxBpdA?=
 =?us-ascii?Q?Qiik7jZ6l6nOHWnSLUcUT4tfFsV5MInQB0SowDy7GXdCBU5CyiOLk4cqHhFH?=
 =?us-ascii?Q?VXZeBwy1K25IPhSWNY9Bxe/cSqW9bVc9Y2LDTfUX5Dq6njftCIW+4fagVoNR?=
 =?us-ascii?Q?mPu3UW7hCZQe+NoFy5cANUpIHpNlciWKBw995s1x2sMmDQ/AkQk0F+srb+P6?=
 =?us-ascii?Q?HQ+Kq3RfBaaFuEspA5ehK0btnzuj6LutKKwB3bDLLQBrcMX6TOfuhMUGikjg?=
 =?us-ascii?Q?KZ3Io2QiGIhbmUVKINr2TQ292QOoYRxBmBff3ZuIhs9dfPGOYUV+W9UE7jB5?=
 =?us-ascii?Q?Uo/VvxYvLXtqRSPucR6XfwyRYgYWQiRbb2E+i3Z/0I6Z/Cz/ufXu1oZ/WRDF?=
 =?us-ascii?Q?2QxGRzDFHaMtIiyz3acK9uxKnPO9yETD96dJE5/5EUpfUHQJ250a69J6TPr6?=
 =?us-ascii?Q?OEJ9/DMLVlyeNc0Vv6Ws6LOpOVMBnu4j498fxvMhfyReFjo5/rbgXuDpGY/C?=
 =?us-ascii?Q?7eC+qeqi+voxsDpsgX3pWtEcXMhga3KOgKECyYfyZs18WzFoZm68PIcEYSAo?=
 =?us-ascii?Q?dcqgu1RNtXjUrayUflGcmp3V20F0gpIRpf43+TOHFOWLAK4fM0/ATMCuEvPR?=
 =?us-ascii?Q?3iUkDvl5VlK8yfxqWnI9bqpI7a9RmyKsVodl7YBP3asvhvt7QP7XvYjZeKY7?=
 =?us-ascii?Q?ahhb+/LnfqfR3gbJJz4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74689851-bf93-4f3d-4eb4-08de1d4bc360
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:47:17.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IzCT6DEif4V95K1NxZKqcGHwOpA3fzC7S5WgQLvTxxcM/p14ZNxupltu807xnSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

On Thu, Nov 06, 2025 at 11:27:10PM +0800, Tzung-Bi Shih wrote:
> +/*
> + * Recover the private_data to its original one.
> + */
> +static struct fops_replacement *_recover_private_data(struct file *filp)
> +{
> +	struct fops_replacement *fr = filp->private_data;
> +
> +	filp->private_data = fr->orig_private_data;
> +	return fr;
> +}
> +
> +/*
> + * Replace the private_data to fops_replacement.
> + */
> +static void _replace_private_data(struct fops_replacement *fr)
> +{
> +	fr->filp->private_data = fr;
> +}

This switching of private_data isn't reasonable, it breaks too much
stuff. I think I showed a better idea in my sketch.

I still think this is a bad use case of revocable, we don't need to
obfuscate very simple locks in *core* kernel code like this. I'd rather
see you propose this series without using it.

> +static int fs_revocable_release(struct inode *inode, struct file *filp)
> +{
> +	struct fops_replacement *fr = _recover_private_data(filp);
> +	int ret = 0;
> +	void *any;
> +
> +	filp->f_op = fr->orig_fops;
> +
> +	if (!fr->orig_fops->release)
> +		goto leave;
> +
> +	REVOCABLE_TRY_ACCESS_SCOPED(fr->rev, any) {
> +		if (!any) {
> +			ret = -ENODEV;
> +			goto leave;
> +		}
> +
> +		ret = fr->orig_fops->release(inode, filp);
> +	}

This probably doesn't work out, is likely to make a memory leak.
It will be hard for the owning driver to free its per-file memory
without access to release.

Jason

