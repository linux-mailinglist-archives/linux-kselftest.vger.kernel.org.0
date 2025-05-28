Return-Path: <linux-kselftest+bounces-33904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03941AC5E0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858C99E475F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469A8F54;
	Wed, 28 May 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="We9nBLdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89110FD;
	Wed, 28 May 2025 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391080; cv=fail; b=c+aTXsJrz2Q82sf90cnZ0UAzQVMD4oTUr7Guw7Q7p+yUyT56j6GEAAlEFUPcUF2vofa13pot5Kd/MffvTmhXL5c3fTJSoP1+dETIqOdxHobMmZusJ6oaqLPsSklKwfBPF9LfZQQpF/Vq3UDAVjf9WFzubroXLm37qyQeVpQsFew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391080; c=relaxed/simple;
	bh=pRThuMS7l6pyUUk+k4EqG1rcm7phGXfGgBXafEqqt7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XS0Cr4Dy4bcXGoIaqw7ISZUpq3XlScRXFx6+0es6piMW4xHqBqkyEXorkcD6vyhlMF4iY3NbNdp7lvXEEN7Jb5SBdo5BLxmWk5P6rwJy5U15uvA0GOzTtiDIGNoBMMhEPz3bjHwtfPC+zZ9as+MpQVI06Et845jOQYS3WgSs19U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=We9nBLdQ; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQe35BSH0iFu0eusi1pLmG4BH5G4IeDrcSbw4dpTL6a99YykQTdCzyrxraMX33IYOfDPZHWHOdH9rUv1f95F0tc3HMHNGtkilDjVc5UlGWiKX3dD6KMXgP+Z3TGlfj7wsGvIHY8AGhpM/To7iDblQi3HU9YI3qYVnpc80gtRNsid4BLE6DHdaC4x1NCUNfZHYvxDRjEwZ7Xq618W9IZRrbYrQygsOCuDmV6bf9MYpwz7zPoxUltJ0zv8qaKzeJ/eCv2a9uqj/TyeNm8jKWXiQ9MZqKrQglW4m2JCaSna2HlFcX2SX0wnbFW/Qmo3GDGSp8TQZEh0fY0MKLDv9vrxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSKfqIMUhh/bIZSlqNM8T64/mTmXFqWltff+D7Q51Io=;
 b=PkCvXfP5C7Fap7PWKOjRSxSBpcG1hpBRdoDm7JwTk6FqtoQNNIn6ouBxm4XWCbtBm0pUE8YyE9IniX5sWw549Iih7x+n0U+DlI2NMmbHSBt7JsL8uShL6w60RMP32dLSPLpZuqqVr3GOunWvqQEdUhADUDl3VW/tfkQxt0qWKbhPYQZCy3tKUSSCapre39ZWJ5+RK2xV7LELPiasrgMEiG/Ys6Yqiw7u1yNbJzxcjgLqMtGbGLrWAX8bVHUjzjVuFAyC4FhjKbgyJ3QacRNkomd/i0Xs4sxJu4kA59Vi4r5BRf1VqMIBI8uI+ACFistlKKzeNWB0wxvUnYUmLChWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSKfqIMUhh/bIZSlqNM8T64/mTmXFqWltff+D7Q51Io=;
 b=We9nBLdQTiicv0oYAcgcO32emFfSCVQgstBNpDeqZjB3ukDmQbdMW0JdTV4jwSUY/RvdCmLHxOplhviyOqzB3Dygnu+G6Oq1CeOyi/gYEtpL/FiJooXTXJwOnMo2hzpdplWYTPeWgFQ6b+YnFCvCFkk0w6EHC3g80H3ZyOQuCRpp9xmHeLRDcpRwVV7XYx7hkKxyELTM/TXVAMwqAE25i7ntUWrva3bV9TrRPGr8LTRtzgrM39UlqAfUP5VZ+4s8YcGIJ2JSePaVJ11Oqhql/5q5+rh666Kkl3okwM7ecaFXd4f428jpIJ1cV8nHLf9gVSgpzuyHn3DYH8AxsWzSaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 28 May
 2025 00:11:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 00:11:05 +0000
Date: Tue, 27 May 2025 21:11:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Joel Granados <joel.granados@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <20250528001103.GP61950@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250526170951.GD61950@nvidia.com>
 <CALzav=f_12DE4iJ4XxU+jsaEcP2LZioVfuVwGMnK8a=JJbA0JA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=f_12DE4iJ4XxU+jsaEcP2LZioVfuVwGMnK8a=JJbA0JA@mail.gmail.com>
X-ClientProxiedBy: BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e3593b-982c-4641-3bac-08dd9d7c2377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ngV2pSNtFB6vou52+wbuup1vovmfE2sLhknnSSndHSTa4YWUbImtbTHNXmh?=
 =?us-ascii?Q?j0QdGmgiYrygmONnaO0/MFWLH+VX1+0UuYpTKnOSkWnCDO7ymFVGoi1YwvPn?=
 =?us-ascii?Q?ngtoDAwbMgMww5HSenlqW1uaUSx1A3TtEGHePQNmergLTaPXz28Bh28asgEY?=
 =?us-ascii?Q?5z9i92owb7g9GJu/LXsWVZkaLqNFQMaCb8DqipdGMHjaWYAoaRNqHMndklxI?=
 =?us-ascii?Q?3AD+K2Vd4cdbkEdCvcZqniU8DLbJbSJatfqJYefU33bzv5Qwhfi8tqsK1kFV?=
 =?us-ascii?Q?EbkB3LjpEDg5thysYvlVrc1nq5Kiog/SAIo8tv+dADFbrk9R47YttKnlzVtj?=
 =?us-ascii?Q?2uJpcSfNdG2xhmj9r1MrT1oy5w9EbLsyF2WNUzCk5VhuWHPz4T0eHOqSIomr?=
 =?us-ascii?Q?FTur5HST+uc9LpTmAhir+0hggab3vQT6wHkM2kF4JhlAC3uNrPzPQ4MA5Wfd?=
 =?us-ascii?Q?nDa/yyVjdz/WfspSvC2+6D/rffh2t0HeDPfVZh295H7l2pdRd+VL0tQ0I4Q0?=
 =?us-ascii?Q?PZi7HFhFcAGo6boXzH2DSthwjPsCinfQYKsPLUTnKl8dgzy4FrvqOLxGGYRN?=
 =?us-ascii?Q?cFZEF73EyMvSCw90Cvj7ShB+6TN7oKSgWWrOnHwhpmKpyWpdr59oVjclo3tL?=
 =?us-ascii?Q?Shpwyxa06IXtBLRAbLohCS0pduzwCyRNZ8IxjdV9T+Ch85EIt8binvQO8v7Y?=
 =?us-ascii?Q?BCHdfa2Xr4Knbi/CoNI4ItD+B6ir5Ysra7MLxvO2or3Q3NjZ9U+FqXaikv/f?=
 =?us-ascii?Q?tDAHaRjJ5HMZ2qQak+FtlW8eLA+tmPNNrPMOIe+ptIMRJQYi8NnY8owfTaof?=
 =?us-ascii?Q?Fjby3zc6mfOq1uv3R9i0QJR8R6GbnM0v6WI8gIPHeNGqqzReyUMH0HmmetAQ?=
 =?us-ascii?Q?2YvqRzCGs3seqY5CH2yIdJErQgYlmW4QLHt8YYWYpV0FA/D3HUWJPxdLdEoQ?=
 =?us-ascii?Q?gVOTYZIOZcMW+83Rbq/m32t+j3hxOJKOLOVNnFex1Av6jnms9oXYCNivChwg?=
 =?us-ascii?Q?8NdKzO6LH2lPl+wTT4wkEkimDII2w2m2R2Ag20f/IXF6UospLAkqJBlTidtq?=
 =?us-ascii?Q?Fmim7Z+GZEm4XugBBgGOCGVN1cMqpDjiOxDNr0xV0N6IAeSy6vX9698BiaBl?=
 =?us-ascii?Q?NWMB0XrF0x3ZzddFkJc7/Sy/NrJ0fGtwZuMGOVkNaOU7ouRHjLoDy3fxfeFm?=
 =?us-ascii?Q?yHFsZaDcZKF6vksSstZz6kJDpGk4CU7TlXNokGDHEKdpqwrAZiwAPMu4zY4v?=
 =?us-ascii?Q?oMc6d8oSpvquPPg7YKgKEUUJ6PXl0K9EzlD9bTkce/3iwGsLnk5766WjW19u?=
 =?us-ascii?Q?+TzwApaWokaK7y+H33LDDF3DsltKLAI5Psb57BHw/UQP9wVgAPs0CFSwmz6Q?=
 =?us-ascii?Q?9T6ETOzOERbOhcjot43jGFeqtnsq7BNCCbhVi+L0/Sse+KLYkYdDb8HYrZRt?=
 =?us-ascii?Q?bpa/xebB6XQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASziSneOM8aD1QOE68sZBkBWg9ZxJNMwWGaGzo0YsCoPQ3UZMWYBvhdMDSS8?=
 =?us-ascii?Q?9hy+wcQaAsZhaXGDw5vKd8WCf+tY7KBb0dXIZKJzZGRr4AV9o6UiwqcoGvso?=
 =?us-ascii?Q?wnCrJshUW3cRPk9yxlSSnhRM+GbxhhQ9q0qICCvD1OvbpdvKbZGMP733PsTX?=
 =?us-ascii?Q?jbdHZVs6ktH7AyjvHrWmMaXvVrdhFpV9Wpg4L3HFVNFHGntnaDKZsbuSRZWT?=
 =?us-ascii?Q?+cSygWCrXskxGQw0D/0V5JGWGZeaHMntpPM/E4xxQgBCBK1OzIyHYfdUO65b?=
 =?us-ascii?Q?lelrZNVpjcFab+NVhIIGQKT0oC1ExXUawFTBRjbm4G74J7GhUT3eHTffGBjn?=
 =?us-ascii?Q?btawGDgfQdaTxd6GYwJ414mqqP4s3Jgw7aWI42UTJ4Pr/JtSbb3VfE6h5Cn9?=
 =?us-ascii?Q?hw/tP0mLVJKJ49o95smmUDSIb44bH0zqcan7EA3lVtzyHK6NYlaokJj8CGQg?=
 =?us-ascii?Q?ZlrB5EFPKAzlHBfXprwGDmFu/OUVRUDsh8tmsqPcaE3Cpoy8d/AOPLKxbJKP?=
 =?us-ascii?Q?4n/zkvweUutE183arW+HY5uvm9dmn8R3n03ogsYc2kFWNZX6kT5dMRO0wTO9?=
 =?us-ascii?Q?Ih6aqyvLgvpCATG0OXsWP8ERh5lXOkMe8b4zbGwIvEFH3HOLxYNdzMpviV5y?=
 =?us-ascii?Q?YX+AJytc7GdgTqrjiCDEN7BHuXslQ1xis0EJuVkCjCuP+FSnwy4lVC1xsHoM?=
 =?us-ascii?Q?3QVcGM/WeOfWmj49cVehE8Fux7WOd00VlMLAfvCiEsG6HsPG6eV4J20r+tNV?=
 =?us-ascii?Q?Sp1UPG4zkEdmCWEDpGQvS32TmExw5jYxCshorlEnqhEyswhe3ktcwXZDdiD7?=
 =?us-ascii?Q?7A4xKSkCLhi8qLJOYnQWEGKovh+ah4ZX0mGmOgpTG7QvtDV4ulhM12DSgpn+?=
 =?us-ascii?Q?wC8z2vAcsk7/gnAH2Wya0dB71lHZ7FT+THLNgiTf9gNdMv4738LmWZXwhLEv?=
 =?us-ascii?Q?oAMvl6jSqgE9Z3+ZH7dp8QWX6tD/hScRjhNSEN7dDRExutMciA53l94db9SI?=
 =?us-ascii?Q?cCjEDrLkul0Ncy4PRKPIYk709aiGBcGY24Li8ZpXO8knaktYQJZY11vpuQ9J?=
 =?us-ascii?Q?JRwukaX8WUdhegIv9hTE8SQ09dwLzJXc3HNjPNPjthKy1YJlakFaZtKBX8Vo?=
 =?us-ascii?Q?L43jAxANLb3IjbAfo4fOyEc+PMeVLD/rUyMPhli75UOak4GoB4CrTJ+f9xcH?=
 =?us-ascii?Q?oyXezCaJfjZtc48xUrfdYp2iljMdS0F0pwVFfEfd7xqBzJMWM+r6hM6mYv5G?=
 =?us-ascii?Q?hq3yPNCv5iWvwCtg6OXVGdMWgJVWkJmy/TgR84BqcnUrg7RYYmHaof6clHRW?=
 =?us-ascii?Q?V7YiY46rX4XRu6/lAJoTk+nxcwprkinNzaf4hMCW4+t2Vmig+wuEnaV/b6wn?=
 =?us-ascii?Q?foCKtwJXs5TeXKZtKmhbW4BUhXtU6uWvoHhhIR9qESGMjcJAICmYs9hyNL4y?=
 =?us-ascii?Q?HZYYhviTIaQugG4OMmDrFwt0JJG9bnhqFBz/xew/D//jtK39mikarp9pB0ca?=
 =?us-ascii?Q?esi7BqC2XBYMpvopFpnoxhj9BvLAUMVXXNxUYGLzdlNbXe3ehw+PBx76T3vS?=
 =?us-ascii?Q?LMEi5+w4wmpsDZAU+3zzQz33hFyc+eqFrUMXTlOe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e3593b-982c-4641-3bac-08dd9d7c2377
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 00:11:05.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn14z/2HWUZDELxmasByIdfzoMuwgDe0lwr1cGB+EmSvsV6tIIcbpxEhg0afWZxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834

On Tue, May 27, 2025 at 04:01:52PM -0700, David Matlack wrote:
> > A reusable mini-driver framework that can trigger DMA is a huge leap
> > forward.
> 
> How broad do you think the reusability should go?
> 
> I structured the library (which includes the driver framework and
> drivers) so that it is reusable across other selftests (i.e. not just
> in tools/testing/selftests/vfio). The last 3 patches in this series
> show it being used in KVM selftests for example. IOMMU-focused tests
> in tools/testing/selftests/iommu could also use it.

I think having it as a usable library within selftests is a good place
to start at least. It shows it has a clean API boundary at least.

> But it's not reusable outside of selftests, or outside of the kernel
> source tree. My intuition is the former wouldn't be too hard to
> support, but the latter would be challenging.

And then we can see if there is interest to move it outside.

> I was also thinking of using NVMe for this (cheap, broadly available),
> but I'm a little worried someone might accidentally corrupt their boot
> disk if they accidentally pass in the wrong BDF :)

Yeah, you can't do memcpy on NVMe without being destructive.

You'd want an alternative stimulus API that was more like 'DMA write
something random to X", then you could DMA READ from the media and use
that as a non-destructive test.

> Do you think mlx5 HW could support the current driver API?

I think it can do memcpy. It would require copying a lot of code but
it is "straightforward" to setup a loopback QP and then issue RDMA
WRITE operations to memcpy data. It would act almost the same as IDXD.

There are examples doing this in the kernel, and we have examples in
rdma-core how to boot the device under VFIO.

Jason

