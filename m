Return-Path: <linux-kselftest+bounces-45101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C9BC4045A
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9983D189247E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02432FABE3;
	Fri,  7 Nov 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sP83pP32"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996F2EC08D;
	Fri,  7 Nov 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524915; cv=fail; b=J6jLMtzjSfmoormHKVkC6QhpiUpcjOiTF+mpgHXmuKbItotw25j0VUhif6/u3g4syBcGYQ90PwII8xKhTxjl++ih8vxlZOSjb+fF6GsmyuVcg6r7l8fPYqi8WlJdv4GcXTWpFH7DLWPv7Tuai7dW8AvVkBh2qp5AOS+sZ8KNxMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524915; c=relaxed/simple;
	bh=K51Rl/yXSPcDOVe2PijEejZUdAtXxR6kdMUgm5qiC8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kW53jReWgBy3ek4lOCuzm7t2e9Umsh90PhCrgEQmT+7gg/u+REMr0vrX+miuQ/yNOpw9ca/hkwx2ybrxxpvoIHxXJfTX2WydcbyjqR3o+qmktICwFU2B5Nu7QmerDJIC9yZPVEhFqd+gF5iXX1ER2S8O3/AZ7+Io1N+BL7VO+8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sP83pP32; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvamxqjFfuCj/s7VN4x3iTsPuaHC5uJI0EO19tE0VWMhnYPQ4o5wmG6M7SyzTijSGqvy4nu8StYpTqRkR8Z1iZHf7SgXwORv/i5iGkcZ1A+Dqdm492wlUClJk2JL7KwcwWz/0XL4WAwEzGt2wp+Gc8JcFGuHnV2j5puFuGc5HtyiHLMuG4kjW9AWs/vsY9FJ4nqfKSjLgNzmjM5wEwpmr7IN5DWV9nlC/GYDyJ/ISmOE8/ldRQyhT9+iBnkGABBiPfl+YJveL02WlcWhPcAI1Us59JYYhV1XfvVso/TJfgUbvn893NVDATOlvs/q0JGEX1F8O/77hR9GCNeLU+pslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MfeT+sv7eGT1ANFFiMdmHy9YfqCkb/m2nuKjAyF/+0=;
 b=BGOEJ3hfIcOoX055qw1lubDy3a2XkJsUuMkxNX6/qNS0jT4DSCiY6DG4+zLA1afOAPelbsL3onCEFOLEkM3mAcDo4YcFnKdAWjHZ4OKasBa4FBFWZI7HfY2LJiTg2Ejmwl0umNAKY+Cg38dyK8sSRs+UH24sdVexkGPAE6oPk/6o7AD6LOXlsq8TmeU+0H/y3net4aeM6c3ZmyczLl7FBOVtltSFhG+yNORSZnUaAXtWBkdFYSpDtCVwpUkTHlQqQRblzBC2I8ouzXGqlviXpX4ZMgHGUcnEroC1RhoDWo6GG0IDuGGejsL9ezkpsN6ACDWBoyK159Mk+vixUlZfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MfeT+sv7eGT1ANFFiMdmHy9YfqCkb/m2nuKjAyF/+0=;
 b=sP83pP32ifVDvopIdt9dp48vp1Rrc7lBTywKW12dC3ZCa5ygiWKB4SJ4uEtEp3LeDs049lcjH4HfjUt0vOikKLqUzYbkDtpESwrX09JJHnLcUUzfMbiUIWVqPMz7BJezEVX4fPbePgiqKjcoC3YxdS5Wxau8qW4FHZi6ITb79cpC4OXlNsoLXJXgy05yO6QHEGzCVpwAqGxnyB6DsiEuztCx+tVEz/EnaVWs++87a7o7iv7doQX1Jr6XDLAp+rTBoYTaNhxjg458d4F2DIKSuFhPn0YPShiQRPl4LyWFUOM7sLyhEYSewA3g8ZfrGkrFLTRbzIL/+nmBPHt56Y+G2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 14:15:10 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 14:15:10 +0000
Date: Fri, 7 Nov 2025 10:15:09 -0400
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
Message-ID: <20251107141509.GK1732817@nvidia.com>
References: <20251106152712.11850-1-tzungbi@kernel.org>
 <20251106152712.11850-2-tzungbi@kernel.org>
 <20251106154715.GB1732817@nvidia.com>
 <aQ1-qj0ztQ29h-oc@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1-qj0ztQ29h-oc@google.com>
X-ClientProxiedBy: MN2PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:208:23d::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ef0919-4a17-4289-3f18-08de1e080f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7dd1zz+XNPgtCrStXOHmdQR2CC8H1NyFhu8Ds0QA5/Dw4ADvDlGLYrkw2A0z?=
 =?us-ascii?Q?OEBbbeqCHKhPM9ASOk+sLfiRJvtFdlShDgdZSlb5nDezWvEVBjLhFvL0v5of?=
 =?us-ascii?Q?YjXWmNBrazhQLgketByL+jsGDicK3gpBxE0v+bmUUAQ10/0IwwFLOXQhF0kq?=
 =?us-ascii?Q?p9CwbR0VtALol7ACqr+gFj5+qJiDI0uvzNTxo/zaA8AiJTR1IXAhooGHpYAX?=
 =?us-ascii?Q?BlSPYubKlWwNym1Gy+D/IrCsMSwz109Et/cXVJZCIJ2mrNPBQQM8ZZ7rnXeE?=
 =?us-ascii?Q?ZWn0WAIQBm6ile+etcBtk/T47sWDV/ykbhGOE8B8/EqW/jxXGIbyStrQqANE?=
 =?us-ascii?Q?fZuRacXZ92ykmdpIGAPxWsaS7RXMxftTwmZGySI1HfdX2MUASHpRcHVuZqkx?=
 =?us-ascii?Q?KBQ3dZaW6ZXZrHuOtAlU297uksxiR0nOwvhszpvyhvG6b6dekzOx6ON1J/RZ?=
 =?us-ascii?Q?DRjNMk8iHw1DogT0r+VuBNqltnN1uZeGGFu68V+83+MVQpnH78wIdh9abMvo?=
 =?us-ascii?Q?mWs6JZYb0IApSp+SF9vsR5wE5Y60gxW8MXbdgu+yYzXe3FfrK62QcQ2Nugoz?=
 =?us-ascii?Q?SVyORCsoTFMUXbbBon2QZ8UIhcBxsnFaNdOnhx+XsB2z0DOfv/ZiBXIoDTcq?=
 =?us-ascii?Q?yYggmKrib91+18gQCUtyvUL4xo9md5MqefpEYKF3+PHlT+5W17aylmu1f+6Z?=
 =?us-ascii?Q?OjS2OINvVZfDvlS3A4HQSV7rShS2xyNvDwX6yREhdZYpKt5bPkNBoBrf9G3n?=
 =?us-ascii?Q?2snOSsGhFtnMaP7wDGg7HbyXbI3gPO5KDvt7yfyeXG0a1qqY8jBsoK/MnQod?=
 =?us-ascii?Q?AhgXed1UvQk43hO4020StGARpcr2AuZdFpU02T14EkDGRmEqRYK6v23Opkln?=
 =?us-ascii?Q?fu1Q03m+lF4VAog2DYpZozNJI40cKLjYWPa+sqkar/9It5YZFqNATlqAXph4?=
 =?us-ascii?Q?ZESSU+b9WXiZHFbm1TKV+tQ8jnKPJp1q7+sqAmLY5g061o/MmbmetrNK4t+3?=
 =?us-ascii?Q?L11Yf1WllaN1Ca6YB+Whl2yYuCrPNgnxonnL8toJPP2P5zHeoILoMJdfdrU5?=
 =?us-ascii?Q?a2dzObePqEkqXYOv83eYmYX+vdq1XuNvyNTqh8ZzFqF2yfAc0izegORRV5Ta?=
 =?us-ascii?Q?T3xEdu9UmF9ntnQray0r2oU3hTloH0V+MIYw8QiIhrZHx3Y91SSyPBtv64Ct?=
 =?us-ascii?Q?n82JyFcM7Cqk5KX8KNBs3zV1zY6gV+eujbV1WHk3MStYX2yQrXExJ09L+Khv?=
 =?us-ascii?Q?iEW9aCdrTk4YyI9jEfa4btHkNG0J5mraBkNtvBL9J3ZR1j/7g6lIvgWz9Fpk?=
 =?us-ascii?Q?bHahC1HUTP6gweV7HrX5UspZfDH+9wfArHO3QDxqUVZDuVoN09/fpU4XCFFv?=
 =?us-ascii?Q?YMcRyn8j27E4kt0XrhnwlBBP8YaSGR04YJjBt9H4n8HbtVXlCONm598KsGqx?=
 =?us-ascii?Q?4drkTYuTUNsInjDVRqfoTsneMyC2jJnq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMtTh8aFhWIN9+bVTMFJNMHenqGrikynu17UNGgyjc12iPO3L77031xII0jy?=
 =?us-ascii?Q?TiqEcjbXWxy219m9a4hsaJtX8HHzVX+fhRFLDTihqjtFQG2Ez+9KJofUSl+L?=
 =?us-ascii?Q?4reYR9/89exzfBdamBvWj39pDwos8imiUgCt12p5291oKdoGGSTw6y162BIP?=
 =?us-ascii?Q?YKxHUaw1AxA7PjbU9fnXiQeH1fKNWXr55obtZlk0jK8fXwBcUqf95McicIFg?=
 =?us-ascii?Q?yNFv8A7CTgRzirqu6tT1nok7y0FG3rVcXH7itZGoJ3k0MoVbZM000BmyjKcp?=
 =?us-ascii?Q?1nALm6vZdhNDfAjoskpktch6E7Et3JqdqvNTHHLIIE76BomgfkM8S2Jr98Bt?=
 =?us-ascii?Q?Nvw67+XaPe5QexMls71A9mWF91fL+7MR5Q8MvTGEwSQbPA7F1BVQ22hT9rxd?=
 =?us-ascii?Q?s256Bh+HIKCAXXXYYepqhDlQqJzP3U1Lwl3XzrcmaW0lUmPbRPSLu5m8lKHA?=
 =?us-ascii?Q?DjkLkLsaLQlARQ1fq7ITSUUwoAiFRzgKa6gjSJnPNxbwPT/E0IUyjetty8m8?=
 =?us-ascii?Q?NoCS2bW/jrCEgebsG/0oJqNytQyC+e7PuLImG7sQXFAdY6ruFFdZ6zAUECcC?=
 =?us-ascii?Q?OY2lDTWmOq5Nu4YzJZidFjdXcPRTuCPm82k/IcNOi7IpxuS+7g3FpnQfV3Qk?=
 =?us-ascii?Q?kx6/fLkCBjFol9CKfLqY6kgPe5GS5CkbjbtFUWWIyCHYjIxE9Yt/29kqhlIG?=
 =?us-ascii?Q?fsamkqMBx7wRMjZFQiYSuvzrtXEXpYcC4IvVrbiayMsSlO8QGs0S6YwD5Ubq?=
 =?us-ascii?Q?Fo/pRAttH3oaVYzD7aMOhL4y+7z6Fpb/J1xiHDIaGpEZMVmokrKWMlc5ygPG?=
 =?us-ascii?Q?c9zFf73zdYEdsp3zrdzTIKMdkrBxSvE/BnwejdNNQ8qN3xooiLOK0tsul8k8?=
 =?us-ascii?Q?Fc8tm/7QJzOzjlQz/NcercmGjAxeCVwOZeY2OUOA1iaHq2IcCvJywlo9Ejqh?=
 =?us-ascii?Q?RKWaG0QwwSEmMZBnlSnPZ7ffBMNhOayvR7ky2+4bMAg8jqkVUYSz+L2+kS/f?=
 =?us-ascii?Q?NDJDYRQQxD/C3ZjA0DZWGi/XUKDGOUe3bMf5AvXE2Cn5/2VVPgVfNBwyiKeh?=
 =?us-ascii?Q?7Kt0OZC60Fx+BaTXAtFUun99aaeflHbm4QjQx2je1Hih/z2vBOHng1s+JkPp?=
 =?us-ascii?Q?cJiXOrrE1+QXEVr3HrHqKDJyA6LPQC+CSuUzOWHC27DqeRPHrqETwpIQ2p18?=
 =?us-ascii?Q?Rm0SYHiAWyqDC8p+/i2gsjfRj8pTyt91IF7NbjPYG32CGHxIUtzMaYS7bXdw?=
 =?us-ascii?Q?GC/3Pwk7kV/NY10Qa6C8k7Uvr4rEtxUAbTZsDxGIujIwRfysBsLawPwLvcSO?=
 =?us-ascii?Q?mVngolLoZQ2obINbFc1PgJ3zLd4Wlbvj5XCcinMCnb9PobXqGd4GbrA34jLa?=
 =?us-ascii?Q?qDmncCNpiE3jTQrB5mt4WMdy5DN9ah1SLzUxGrfcKFz/BiPEohgWzP4HUt/L?=
 =?us-ascii?Q?6wjFhW5xyAr/zzL27Fn9sDNOrnGusZvQXj/q0O1tPpDag9laEnutRUU9Mb+B?=
 =?us-ascii?Q?r9UcVtfC1+cqzKRRb2rXiShIU3ev8CdI7YKnH5185XHY7+vJYWF/KsQJ5R2h?=
 =?us-ascii?Q?5zKcnQBApsaPp8z7b1I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ef0919-4a17-4289-3f18-08de1e080f91
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:15:10.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rG8DqM6de70l3y8/5N0WNsHBf5/DYSsjj0rvho0VMKVUKH4WEfb9GdSYYiXOYKy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

On Fri, Nov 07, 2025 at 05:07:54AM +0000, Tzung-Bi Shih wrote:
> On Thu, Nov 06, 2025 at 11:47:15AM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 06, 2025 at 11:27:10PM +0800, Tzung-Bi Shih wrote:
> > > +/*
> > > + * Recover the private_data to its original one.
> > > + */
> > > +static struct fops_replacement *_recover_private_data(struct file *filp)
> > > +{
> > > +	struct fops_replacement *fr = filp->private_data;
> > > +
> > > +	filp->private_data = fr->orig_private_data;
> > > +	return fr;
> > > +}
> > > +
> > > +/*
> > > + * Replace the private_data to fops_replacement.
> > > + */
> > > +static void _replace_private_data(struct fops_replacement *fr)
> > > +{
> > > +	fr->filp->private_data = fr;
> > > +}
> > 
> > This switching of private_data isn't reasonable, it breaks too much
> > stuff. I think I showed a better idea in my sketch.
> 
> The approach assumes the filp->private_data should be set once by the
> filp->f_op->open() if any.  Is it common that the filp->private_data
> be updated in other file operations?

You can set it once during open, but you can't change it around every
fops callback. This stuff is all concurrent.

> > This probably doesn't work out, is likely to make a memory leak.
> > It will be hard for the owning driver to free its per-file memory
> > without access to release.
> 
> Ah, I think this reveals a drawback of the approach.
> - Without calling ->release(), some memory may leak.
> - With calling ->release(), some UAF may happen. 

It just means the user of this needs to understand there are
limitations on what release can do. Usually release just frees memory,
that is fine.

I think it would be strange for a release to touch revocable data,
that might suggest some larger problem.

Jason

