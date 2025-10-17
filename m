Return-Path: <linux-kselftest+bounces-43378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9965BE9066
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 15:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 253AE35CCFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48836350D56;
	Fri, 17 Oct 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QtuCq5sG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F427F006;
	Fri, 17 Oct 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708964; cv=fail; b=ppUK943f5HC0PnCSA7mm356NyInxE5+p61/ytrWxnJybqaXYEmdjTe0vr+xMcm69/wpvjbxUVPielHrpZGPVuc3iXJ/oFP/Xja0KfkmnY33yNP3TcyniMTyOecysU5boUyAwUX1AqXWBtKAvIyLsf5r1au2rURm9/UtCLqyKtmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708964; c=relaxed/simple;
	bh=0S8lW0uPvpg57OY3A7Af3W+Mo5qq0cgO5A6Poe1LkjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gPm9iFo46aQb+kVUGVAMv9Ym+UVFAhF+0+ifdO54NIwljTGf/yCxgnvzOG8T3UP+BEbmd+eBdiGISJ9ZzRWoG6Jv4vQsZ5sYJuFItqezGiWns1Cl9dyGnSAgPztNaH/fDcCIDnuWDX6MsMdfuB3w0FOZCuSNoezaLysqeOlJBYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtuCq5sG; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8TkWcbi70AT2U/88YWeNvxsXp41Dj4joNt6nuCDXMLGKVNAvrhVvKvBkMZfqvlsEaeaCmnDRJ2N+JJx3bNlPtNIN2amGDwQmlfp5EUOMPP9YJW1Qj9HLgKbCu2rN2MnpTTGnCdycf7ZQc5amycyr++5mIcgf1zn0sFfFHSIGvvs/feTDXUIzw16AFKCLJ350MuSXvXABcoBOHrMAXNSqt/vch9Tkd/I8JLXQ8mybyZ51gH3X8rP/2Y8iexNjOO+pDcimVIngj0+z4Zg0BBzHD9FsuRliM0tcOSX8drO+s5gTomyREax0VCmE5Se1EE/oY3YQPtlKVclfqjxh2WJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+GnbiYos+EEbaRAjp7KCE3ndao9kRwV+0gcgiicDcs=;
 b=T+JHjBX4AChRwkijRg2RjB+W7D8fbRaMvfgW2R0wnpXLJm3U6C2wSn0cjkyx61xeNYU9BhXc5cfc0DEBL6wyt3O3yEHuzoAxXbYJFd1YoRjtuLIHqrC1/WEygEArSbh2hyStxeJhKZ6eEOcx2a4EEciNqahRexYAm5xQPsVYX3OF7U1jMv4CxR9D+O6qaJdEKM4cFuSuNV4HTvWqGeZQISqo6Bd1r85AMUULDKj2QJaSh3RBJQeNOtEE+sQ7xGR+f080uTHclVxHkuKRbX9yBPGIHxkfaETcdjpY5Kt74i6SuvCijjh2+J/I/6/jZy8iqkigofTyY9cr6MLDoZVGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+GnbiYos+EEbaRAjp7KCE3ndao9kRwV+0gcgiicDcs=;
 b=QtuCq5sGJJfrPKNrsaFTM6nb3CrmNIYOteJzVXvs2AicdEXtWjFEiFDzBb9kCtO3zRskSnQERI3tk5LQTbLJFk7hQhxDq5v3K39B6FKM9vT0Hu2soAwbLlzRSVOkoqagWasZMU6eEExWTYTYcvpgJoEC/1iVaOA21JGku9f+PBwqn84ezQK891CNITyr3Otc5eBFKWksqkBSc1LFz4wyARvTX0cYyd/2qBl2mp6yhVU54JMXFIvJ48Agb3r5U3gMl8aRMMBQM7TmeiK0OskT5eDAR3FadrhVXiJtZtSJhHhHaBoexRjGYq8uU6O3SDWz07f6BZxMQLg6prk0hrwWPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 13:49:19 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 13:49:18 +0000
Date: Fri, 17 Oct 2025 10:49:16 -0300
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
Message-ID: <20251017134916.GK3901471@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPGryj-V5PQZRtoI@google.com>
X-ClientProxiedBy: SN6PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:805:106::36) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: c93ac1d3-7756-4281-6949-08de0d83f807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zimEn6GEDe4kGEllABLbN+0jjyotBLm/jxbsnK5RAY8vxGQMYsYO+8C5CIPc?=
 =?us-ascii?Q?gkHjSRi5UtSE/9xM6Znf+tqEwaBKpirzmAz/QInBuLnqe1A6M9xv49Au5TLm?=
 =?us-ascii?Q?j6qKwuA0iXXuDcs9HFLhE0NG+kDOGPnw02yJ3LUxuyHiyHPWHdAm7m/fr5xi?=
 =?us-ascii?Q?z3ugxMIlaDItGPrdGCZcXRnzuGKfS6rSZQIOd23r4dEVBIL/xLq/EbTXZrfT?=
 =?us-ascii?Q?f71z6zTsiUVFh3TtkDsEPpX4+T7Ql1S7shW2g9LYoi2W2B8nrQkvlQUb8x8Z?=
 =?us-ascii?Q?xXfWjx87fKpeEZaeoDh5BFB4lkVniEu0QNZx5ykVDCRG8OORnQbqnex3wIBH?=
 =?us-ascii?Q?Q0ilw3Cd9kgLOO7BBKUN7j60AV2LoHAD5Og5fh6pbEzpXsDwX6yq/9DaXE/6?=
 =?us-ascii?Q?LoLozNJR6JAf9MB2nPEOVRSvkylCof9c9rVWDEzAhDzoc62dnnWkuRatkSOb?=
 =?us-ascii?Q?NnJnMsVLckV8jUFr8Yhnb401Mp/iAWC0qO5O0clMX0Myg6CwzGIHOL1IJC+r?=
 =?us-ascii?Q?ZmI9W805m68r7lgihKtiRA7tEok1vCOSOSh9ArkEXpBvWnVByjjVJIJxIKad?=
 =?us-ascii?Q?SaH8QvISkAjJ6scOJmwiJ3CO+3JcZ96ANehowFxppUzdJ/Ya7pTkh2EB7BcW?=
 =?us-ascii?Q?wf/907Zk4+urCsB42pwTLtV+D4jAiE7Hy/5T9kzpSSgcvMHX4ZC7aVZzn9M7?=
 =?us-ascii?Q?1atS80WOAYuWUMtOH8rUG783gB17Z2PLpZDtBbS8CJQBsufy/ODIDhuGwDSL?=
 =?us-ascii?Q?zAjXQdzij+vuNQLFRcPutYnh3ZK6AvV3Hhke4K9vIpIfM0eina7qkpDumu8X?=
 =?us-ascii?Q?2X9hBO+kGgMPUWV5SWl74vwF+08v5Rcy9oasfr9K2LSKMr8zOVlsybNHvJQr?=
 =?us-ascii?Q?OzWa2XYCKoGmd2oO6w4hxSZ8RoMcLyjXJjF5xfi7gb9XzvF/8A68pF1nxEHT?=
 =?us-ascii?Q?T+uROu6cbT1+eHeZfWyqW4M1V4+drcz/nZ2K/6BCIayjhEzXR9X6QOa2IPi2?=
 =?us-ascii?Q?d3v4HNnNjkUV8vnVAGkgDTN98Jcw6C/Rr5W+0FcTncxBv8N3NerI7HrlcfRU?=
 =?us-ascii?Q?SHGEUDhnDZ4OafpUp1nsqeaUtoXvN86Pn3YvMVJOPYZrM6pDlWtFjTIwUTed?=
 =?us-ascii?Q?fN9KItRtcFYcU5qgnWHAb8YZ6P8U7stQRvyk7as7us02f/M2Jvlfc7Co0aLK?=
 =?us-ascii?Q?UcE82liWOX4Ya0EhfBlA0N2CcCwJTUcPttYhqdu4LDc4OxMZych5XdzazhVn?=
 =?us-ascii?Q?+dSNaJRLI0dLVXu3YmKQw1VpXl+cToFDNUk18TmprA4lmldjcwSiPCQSdDd3?=
 =?us-ascii?Q?oMWcKSlS19ftNKgnk8nIf7kfO7GTe2/SuwjMZBH4fPNuuxaHSA/kv1kakO7s?=
 =?us-ascii?Q?6cWIdx/nVZ0fHMXk/ybMJmOm4rk8wScpiMAqZv5aGVofFfyXPnBFh48nWQES?=
 =?us-ascii?Q?y4E1nRCtcVHYdJsOnDpi+LrklYb3HrwL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C4yRflOmruwxjLePOcyQFFczNX0zqy7lrYpQtUz4dCDqkBzkweu+vV13Ue3b?=
 =?us-ascii?Q?U/CDdAmqEUfLI8/P83j8cuPXSgxkSyaJauZgweGPGOzPEA4+jXHEeio46Fij?=
 =?us-ascii?Q?wMr2ZZlusU2sHqTmJYSqu07dshFCZu5mJX0mGcxha3Tv4zR5IX6HChYBLynx?=
 =?us-ascii?Q?41I5+8Op7gYx8a1lLZXn2S2v9BYqsBQthiyIrMI8qTvWCG8D79uO3JXSwAWT?=
 =?us-ascii?Q?n12cN8qosCtdgoh9t06uLvMAhiNdHlRze17u2eb5NeOQxzFFBihpfCU+o0+9?=
 =?us-ascii?Q?JB9pjMSQc40xu9UkVTo27fCuhcnoeVlbglekbT8u0K1K30sBdmcbM7107Vu0?=
 =?us-ascii?Q?lgXKmaNuBEF4JAGwL5BHC1e7+NBKO+6LjwF5HKxE2vHH+rTmip2BwpgTD1Oo?=
 =?us-ascii?Q?eKlTq2n+ue4vuYnYtB0wRVvtimCm0FrAouPjs3ArIWMxeRbORjNlzNRVZJ5K?=
 =?us-ascii?Q?QvVKGSXG4f2SlEeAYdiEez49QwGZhNOWFSW3N0miB3+tMHSA0tdat7SmOEWf?=
 =?us-ascii?Q?zXIWEohDYJmG2EWQdsjTQ6wQ+nUGAoTFzza/daykjOOr0FggrGwghRVqmXEi?=
 =?us-ascii?Q?zdzWm9xNTvieab80gYs6clfKQIUtDuL4hC95aRFmZGYUqzpV/X6nlA39eHyR?=
 =?us-ascii?Q?6rTWS6oYHPB27B3JaQ2fQ/EEA450SlhVp+isZh65GUNBIO45nKPk+tQb8T0l?=
 =?us-ascii?Q?mauQXR1A0iC7cfjLNqvPBqwju5OiH/3mfqYXSMXElT7rwCPHrnCSkeGTcBre?=
 =?us-ascii?Q?1QKDNgGDawgmbTAfUuYDrtSLSeO+tsw5YaE3Ex6M5TKJpAnXrglt+E+kJfmv?=
 =?us-ascii?Q?xMNPD87ZJhel7uxqFgChgatJEk44sEXC7CtT+ChpBzWmmwF/mMIh9KEn2+YO?=
 =?us-ascii?Q?IE2tLhEsLEuV/GAw1YD2LS9rM9W7LLvL7jrhDQnEYH7IQBSLKuMZ/pjcWcXe?=
 =?us-ascii?Q?1VaEgLNDf1pt/VIfRdSqR2bN7bES9DVsHMOnAWPSBbApMNRbYhX2IV86SHqv?=
 =?us-ascii?Q?20aX9f+EObC+dIYuyJps7no+VmklapwU+dw6NqxlsBore8hnkTGolDQbnLuh?=
 =?us-ascii?Q?xHLjFQqdIF+JrMqnx9V90NWoGcDcfga//a6lqIX6cVtmLuCXB5wvxmh2MaZm?=
 =?us-ascii?Q?fPZWGg/9NXx/B0AvBmGdQugTUFPRa//ZtOFEVgVDweMBsAa2OvtNrSVzcEXh?=
 =?us-ascii?Q?WmkNj8ywXaFGdJ2fG3EaW+Ye7GvDmFtK1NCNKeo70KofWubKUKXai3mVZPaY?=
 =?us-ascii?Q?qNdZkyu1bBzCVOc+LNRjMnwKqE+B9TAzNtCZhZ9UCHg6yW/Hg7V5m8RrAJPA?=
 =?us-ascii?Q?hzF+bAF5UoZCRIYmqwdfq8Au7pKWxKV5dq3E2BAs5rR+LcMEl8pzE22KQeSL?=
 =?us-ascii?Q?ASsWpqdGDLa10B98OF6vTxnMz9oZxj/QcQzL5s2vK/YhkdOaLzap3XOcqmNJ?=
 =?us-ascii?Q?2dFHbtkovvJoDfJlt8+Xrms3wFxeV+ilswTT6PO+Qzvcgmm6xzPVzUgKLPlh?=
 =?us-ascii?Q?O7soKmOFRPuIa6DuRJClYDT2aW2Tr7Ui5ScBK4Z6CPoHaD1+3mpXQiZzzVPc?=
 =?us-ascii?Q?WAT8ib3yweeUmiZYa7Y2SwAZnsWSZauuXwFaeCO9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93ac1d3-7756-4281-6949-08de0d83f807
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:49:18.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0cLxufhX0b/Py/Fzv+TKWp72jW8nKPyIKVbWTJOCBDJDeUxtpV0+bz52e5T8AvJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584

On Fri, Oct 17, 2025 at 02:36:58AM +0000, Tzung-Bi Shih wrote:
> Imagining the following example:
> 
> /* res1 and res2 are provided by hot-pluggable devices. */
> struct filp_priv {
>     void *res1;
>     void *res2;
> };
> 
> /* In .open() fops */
> priv = kzalloc(sizeof(struct filp_priv), ...);
> priv->res1 = ...;
> priv->res2 = ...;
> filp->private_data = priv;
> 
> /* In .read() fops */
> priv = filp->private_data;
> priv->res1    // could result UAF if the device has gone
> priv->res2    // could result UAF if the device has gone
> 
> 
> How does the bool * work for the example?

You are thinking about it completely wrong, you are trying to keep the
driver running conccurrently after it's remove returns - but that
isn't how Linux drivers are designed.

We have a whole family of synchronous fencing APIs that drivers call
in their remove() callback to shut down their concurrency. Think of
things like free_irq(), cancel_work_sync(), timer_shutdown_sync(),
sysfs_remove_files(). All of these guarentee the concurrent callbacks
are fenced before returning.

The only issue with cros_ec is this:

static void cros_ec_chardev_remove(struct platform_device *pdev)
{
        struct miscdevice *misc = dev_get_drvdata(&pdev->dev);

        misc_deregister(misc);
}

It doesn't fence the cdevs! Misc is a hard API to use because it
doesn't have a misc_deregister_sync() variation!

Dan/Laurent's point and proposal was that mis_deregister() does not
work like this! It is an anomaly that driver authors typically over
look.

So the proposal was to add some way to get a:
  misc_deregister_sync()

What gives the fence. Under your proposal it would lock the SRCU and
change the bool. After it returns no cdev related threads are running
in fops touching res1/res2. I think your proposal to replace the fops
and that related machinery is smart and has a chance to succeed.

From this perspective your example is malformed. Resources should not
become revoked concurrently *while a driver is bound*. The driver
should be unbound, call misc_deregister_sync()/etc, and return from
remove() guaranteeing it no longer touches any resources.

For this specific cros_ec driver it's "res" is this:

        struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
        struct cros_ec_platform *ec_platform = dev_get_platdata(ec->dev);

This is already properly lifetime controlled!

It *HAS* to be, and even your patches are assuming it by blindly
reaching into the parent's memory!

+	misc->rps[0] = ec->ec_dev->revocable_provider;

If the parent driver has been racily unbound at this point the
ec->ec_dev is already a UAF!

For cros it is safe because the cros_ec driver is a child of a MFD and
the MFD logic ensures that the children are unbound as part of
destroying the parent. So 'ec' is guarenteed valid from probe() to
remove() return.

IHMO auto-revoke is a terrible idea, if you go down that path then why
is misc special? You need to auto-revoke irqs, timers, work queues,
etc too? That's a mess.

I think your previous idea for revoke was properly formed, the issue
and objection was that the bug you are fixing is a miscdev complexity
caused by the lack of misc_deregister_sync(). If you fix that directly
then you don't need recovable at all, and it is a much more useful fix
that is an easy and natural API for drivers to use.

Jason

