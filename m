Return-Path: <linux-kselftest+bounces-46737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51FCC949B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 01:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3A53A4856
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9F4CB5B;
	Sun, 30 Nov 2025 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iuY7bDru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31683FF1;
	Sun, 30 Nov 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764463879; cv=fail; b=kGYy80fKIyddOyaOXzub4q7+UuQHNwcXVmztPbPGG0ZhlE7PW8H8BATV7urAGzESspZ8wbHBWg337tv9dt0wjuuenE6sJdWqsRmCVwDuMaPeqYegP4qWatEg+17rx87rwuTykEDS5uy64dpyBn1eAWPqkZCa0XfQgWF4DlQfzUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764463879; c=relaxed/simple;
	bh=HVrMmT8VKipTAvHLasN/BBxxBQKIFETpjkZpT3cEE+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qXkQboUpmdnL5q9M43EbwmETtgi9rzXQoosjzjqbEraRgjPcXuNeNQLZon4JRllWpHZDNL5+F3bf0fm3yC51miOv4V4m7srWI30TfzMA2DkY7JQKYZvi6oOLGzJwjf3WXk1YektU/hiMroiojSSkn9xhcYj2GSndq/9+Brx0EVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iuY7bDru; arc=fail smtp.client-ip=40.107.208.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD1JNNFeM/Af1ns5W/bmHSE08RZVbWzJ7yrILc7El2rTPhvnohF0rR3Ur/VY1t49+RrDSsbGuzEqfQeytUUOaZ9WjB9C8R3qKhtkUK0hESRjLBkLQO0EGu6hu/7OCgAtT8kMzV+Vpjzm7S5W1bJKTIlJpJc3fBeH9FgGwADQ2gUY0zJimvPRJRfjLJmwivR86oQ27Uyx6LnC/NEzAFzpkgxy6A4ycosOw08p4ZG+CkP4O8shfTU7gksDMfSuyqufUCLVCrCtJCd1IhtbTfPJFGRS33GzLqSLM4EUsh8+3e66q6HAMFM8uhAsP1c/Wn9TiTQhzad6tJFlReGKAxFwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50qlKUNrwUUZkXnirL1L/2zNLn2juRaGe6h7/hJhvjA=;
 b=TeXaZnYfK35elTuH9pPqQiXTdHnloyA9UtPNXEsY/PE5A4WzDCnV0CDLc75Xy379Jqgew7vLsGuj7wgAog4ZbltU8hsh3nbYOAz1X3SQYbi4OYYIoj6m/Nn98hGf/37CG5hublN4f7ODtobvxn/88WlA9gGOLgn8Kv+Nbz3QaXg8wV0K7ib7zXXvDSs+L94UFydssdKSALnfYs3xiRVqQRrWx/lW+EGOWQZgkKD5wHv2WuoaYwnee1/f5M9qacFdWR6R40DENJLsMABiDjOyszdY3l9psBdBtG4dZjZi+temiSr57aQ0LZrMNptMVsg9Nsho4uyo/XYVfsITRGq1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50qlKUNrwUUZkXnirL1L/2zNLn2juRaGe6h7/hJhvjA=;
 b=iuY7bDrubFal6Jbm5G8TurWPTvTmSYMwmYjAVDyDYS61cNsb2609s/bcmdQjb2g86Y83jXjKMu93ajtOyiVKpm2oK+l16cojgqLJwXTKZqImiV0ClGJVanqevF1ilPgjNtB+Bq8o3mFPRh6S//bvOsmLUtKqO5o5p39+jXwLPmud8AL04etDG14jcHB+AppF68C99hGaXJNZrJPg+v5cc93LEfa7LWs+kh/tDdk3J3QUrQSoNqZZ8F9ApWtVcU4UzogFRt8BIsnGvYlROf0NAqNs7CyWi+p/mG68txiheRv1RbvlKxHGJdC7dtlo82bZNGZu3/Mk8sJxYAV1dpoB8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 00:51:14 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 00:51:14 +0000
Date: Sat, 29 Nov 2025 20:51:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <20251130005113.GB760268@nvidia.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSrMSRd8RJn2IKF4@wunner.de>
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f95332-e526-4e91-b5f3-08de2faa9014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jb+LGI9XjSpBQnVPxtFU6wg6xq5gbcx1U1XbOU460Mu2N/sDNwCgnWHh7KIV?=
 =?us-ascii?Q?D2EVcdWIuo2ulv6ELS9p1TMO8GTjhF1zCAxi36z9makwgV/QkiRw8fJAAnt4?=
 =?us-ascii?Q?hLSLTP9rlpsXzb+odC//5mfDYORvQRooES7PmmceF27AZl6Vn1rxzNy4vSob?=
 =?us-ascii?Q?1uTNoXhD5XJZFMsmHEQtnsQPowhxU6niqNvSGmLkxE3PaKwlWqA4eSPWv8Hv?=
 =?us-ascii?Q?S5BdaUVZ1D8GQcIKXgVPatIC8DtCMA2sFgRDAquhHliqQNyboKntwDuU14dJ?=
 =?us-ascii?Q?aeJyiiwpY215Kem4pBZMBnMHPPckI24xLn+eV98nahsYp2RRtjMwKyyfjrjc?=
 =?us-ascii?Q?XyX43iw+YNoSKCWoTOGDw0p+Qr0vk1/v2ZGmKWyINKgK7QXMAhN9ta74z05q?=
 =?us-ascii?Q?2SqHgHhJYXggd6TwDyj477fecWtGbG1KKjyA470lZJtp0wkw2Q5mJuwbLEPy?=
 =?us-ascii?Q?o2DzBsymURyjbsXldjYBfTmNLYhcESlwRkyQBjcfZdte/avlx17oY2vI6iNB?=
 =?us-ascii?Q?mOZ/ulo4sEB4OhEQMnJUl1Dr2ueIbFrJv05M6QH4bIVlLvQrc0sSfxhWEcrM?=
 =?us-ascii?Q?pHLhQcLLz6SAL/MW1JlOn4rDobQ7E7vSNRmI2D7PFaYqvL0qhJL+e8p84Ph6?=
 =?us-ascii?Q?uTRlclKtj9YKwZ3W1G1hKv3coKB+fqpmogE0AZBjRwjF2ka/NZlydUTnUjca?=
 =?us-ascii?Q?s3JRW5k1Lyb6y/P7SpQV7dGpGC9v8XlEQKN0rrlYuMiTMhjx2yx7frvjPQQA?=
 =?us-ascii?Q?FLqW+3QHy6a91cyuXj8AAP8tKCkc/UQpEG1G3sMwt2V9iffakGzQc4YYjlki?=
 =?us-ascii?Q?HLb+mC3Jnb/J6klVileU9bs1VwpPP8vjc+MN6qWSWH0tDKa95XwC2SusTanI?=
 =?us-ascii?Q?FvTtbe3gq27TaTElRl7I6jbY5m5Qd4e4y4lNGaSyQggx1t7GCZdFhAjH6kj4?=
 =?us-ascii?Q?botQogSKhtHNSQr8vKmcNf/IZ1Ffq+nEeqNxd4ckjeMYeMpAfHq1jqPcFkLj?=
 =?us-ascii?Q?9LQybhu1jkFUDecui5oJyWqUDLS9C+jEwgbnTkgbuwjRr/LwkEDEjlCSuOGY?=
 =?us-ascii?Q?bzMpuyXfeNv9pkmJjH4yAxYoI4bdqvtTOiVTvkIRvKVQS3bBy7EKdBPUWsVy?=
 =?us-ascii?Q?fotPhIXW/4Erj9YBCH1acKmBWG/SIdkmWIstQ8wq18IYyeawZ9FW5KngAG+k?=
 =?us-ascii?Q?76Rst+t0wXY6qRUwObKnSsoUrEJ3gr2pexPFZvxJNY8esoxrAqeX0cMNmI/R?=
 =?us-ascii?Q?mlh68+SQ0zBmIppNcEP1SapXPHvKYu6XPp3koSOrj3D0TpaFWOf9RX2tEu3I?=
 =?us-ascii?Q?XmcO3mlKIEL/kZxCNhldTBXYXnUv0dsEuhFvH/NJBrK00e3iSU8vUUNh0xdV?=
 =?us-ascii?Q?H0MpaEFwCR4JhldTCE560OOmLdgW74BfcO+gghpyxGrEcJNxlZagJKBrHkad?=
 =?us-ascii?Q?u2cGAKamyGkVHP7Wz/3cYrVPPA80CyM+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+AEyh2VRRUpwa9GFAlNvTQOzWjp4e126doCFfpg7S9hSTp16lyjam1Dnj43?=
 =?us-ascii?Q?spvWV1v+rn2KhIUD2LaGMjit6Jx6maz3YWleDl7k4Dmqc9AJXrMXITM88JLX?=
 =?us-ascii?Q?HbaI0+KsVYA48J5ay4A6UCMIp5LyjInmYHt2M5XCadGld+ER1SVYWUvjV6Jj?=
 =?us-ascii?Q?vl3ON/dAn/2+NuIF6yRuVdaZphpv2WWqRnPn+JxwfOlslnZfx7kFreGr/ETZ?=
 =?us-ascii?Q?y3/051g7TIFtoOziIESO9aAyjEgu17ZsMuX4AS2H3n8BH8wWejS+jCmHFJX0?=
 =?us-ascii?Q?uhjpaSE1oSxo4K/s4xvLIqKGcl3hWJF8Z4l0ocQbXv5nUznINqc9v43s3D/G?=
 =?us-ascii?Q?4YAYUbCk8fi7RXxrm2UbN9WduwyP1LcBDvdZgoyaZFXxCvZX9BwRMJzAze+G?=
 =?us-ascii?Q?XoQENP3gAQJ1YNOwb1ZENUDhCfoMfEQaxy1zndf+Sz2tx8gVjmPLcLBz2oUC?=
 =?us-ascii?Q?lpv35R5U+n/ZO7L9drlCQ//6dg5OMi5NZ9Tr3QUxcrH4REulH4emjoysO9QQ?=
 =?us-ascii?Q?1k3qrY435MKAyNY79NMa5okwyujHW1EHX4Tfql3SYFd8h9ye/IAlzgQiQKSY?=
 =?us-ascii?Q?yhxnYn9g/dqjJBrpOEVFQt8MOXFFmDvXYlV6aAly5GdhxrTYnKL9t+Asv1kC?=
 =?us-ascii?Q?DzTyKCXOPipoSaFFGBsBAXIUVqq6BOTOVjjzoXZ3QpnQ5MhP0TA9xJJEHR9s?=
 =?us-ascii?Q?7xfmCRIrgfbjkWZmkmtD9MIUN4wE8cg+8iHWJ9viqWSlx/DU+RHJPmTRo0G6?=
 =?us-ascii?Q?iI6t4t5ZPijWBh3ye5AXfLvcixmnggyFHfAqaXvFo3WUhZlvCk/64uYlEeKr?=
 =?us-ascii?Q?PKPJc0bBailZr9EF6jsgX9UMn/t59ELScT6a9SjcqBLg+kj2KvtBvSBg4rQi?=
 =?us-ascii?Q?abLfJylX/RveBHJztZ6FfUYZw4d8vtl0XBd2p/B/lm3JpONpLWQuYS5HfKaX?=
 =?us-ascii?Q?Pzdpt3cizOiCQUfz1IKQCJ+8fp2rZhJlc+8LvzZGbDXVixt9gEk3pbDA0rPI?=
 =?us-ascii?Q?ABPArnhHE9BTFxNEAyrMYbAsKlmo47bOQCit5rhDFYAdxuZG3R+02tCEuEvN?=
 =?us-ascii?Q?HdshZ51x/Hbgdfge81N/EMmYvZMTsYmn9T7FB6kKFIqy6B4xpwhDGPtJFOUs?=
 =?us-ascii?Q?uOevdXKb0Xn1e6lroVJkJjVRbPyd/V9+K1aO4gCZ3FTfOQrzlFJ50VHuwCKh?=
 =?us-ascii?Q?BfMoz3+Bz8Hz3oFIclbMrAadkU42NcyCC1kN707748ysSH6NvsNeaD6JNhuZ?=
 =?us-ascii?Q?BalKsVSIB6M9/duJerowvIq358w98jl0ssHDPm8Klr4Z64Rk8rou7Lm5hbFS?=
 =?us-ascii?Q?xMeHXQBhPIc4/2MJg17zQCX51b0svlXoVSgErY5DxaEx/UQXx50VvRnEm6pi?=
 =?us-ascii?Q?Redz8xzaWIXo6GXm3sdLEQCj5ypcUdhmI56IJosNtcuTcK4/ezGb4s+qkwE9?=
 =?us-ascii?Q?PMuouNYygLx84yPEgckcgUspQwU/XviWBmaHOdCEsdBGlqPX6ewnBdObzKnf?=
 =?us-ascii?Q?QKjxSMb88GAM4RFXmoBRJWjfFcCePHV13Afp9T7unNnqsTaKZmOUvPorBj6L?=
 =?us-ascii?Q?hdbSlPQlLqEn4mu7618=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f95332-e526-4e91-b5f3-08de2faa9014
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 00:51:14.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npLbcAaQn8/zJsz4okzmrz8Sojm7nRIoQMhAKar1BcvuxAtwFAFKZh0G3I9ZI1LS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850

On Sat, Nov 29, 2025 at 11:34:49AM +0100, Lukas Wunner wrote:
> On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> > Add an API to enable the PCI subsystem to track all devices that are
> > preserved across a Live Update, including both incoming devices (passed
> > from the previous kernel) and outgoing devices (passed to the next
> > kernel).
> > 
> > Use PCI segment number and BDF to keep track of devices across Live
> > Update. This means the kernel must keep both identifiers constant across
> > a Live Update for any preserved device.
> 
> While bus numbers will *usually* stay the same across next and previous
> kernel, there are exceptions.  E.g. if "pci=assign-busses" is specified
> on the command line, the kernel will re-assign bus numbers on every boot.

Stuff like this has to be disabled for this live update stuff, if the
bus numbers are changed it will break the active use of the iommu
across the kexec.

So while what you say is all technically true, I'm not sure this is
necessary.

Jason

