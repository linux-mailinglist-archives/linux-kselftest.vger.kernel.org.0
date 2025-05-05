Return-Path: <linux-kselftest+bounces-32419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A5AA9B05
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363D517DDC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0F26B0A9;
	Mon,  5 May 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJsOZIIF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF1C8F0;
	Mon,  5 May 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467275; cv=fail; b=RhIYDsQTbo/xsCfVgTNIZtEXxlIMLwhQ0h7uvEFv3pGbk7Xx0/y4W86KJ8bNvyWdktIV5LAI+aLPdRZkPeRJiVkYfmbnDFdCIz4TrH+mHARvKvS3CeY++08a4kwxkLyIO1eD+HNbkam7QOqkFqPCJNKF3VBMDDMoT2NWZXsXFRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467275; c=relaxed/simple;
	bh=L0CXG4pAbFQqBilWyX2ECKaafv2QwYJ/6Feh9mZqIwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=edSplx5yMDaTL/qdsNx01qIWQgn0Hu+MGtwjDCaLz1rRgk2Q+2YWprXXM3laYMd7N3E8/WVrXF2kP6TAmUSc23eAojlaZTPEP+UdGP0erdRRGS6IIUQaSS6tv07Au/zS4nAGzbnqsQYq4Yr/8EK9bhWxuT4KyuDztqyQWYbX7hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJsOZIIF; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjHouMaOfzprrZuGhQHLYHftIN44pq/msdHP/clidjMr2AFqiJp+vYCCEefmmwRyv8qwPe2BFTPbViR/IpFM0q0Lbv+URyfh/66hieaKqGGpHOD8DoU3l2MJDUNpqQ5xKXYpEh0uy8162yc+U0frwTvpRY5M6un8TJmK5EE6Xkw3sl9l1kToFDfui027HaUwJeyrHme+8odAzV2o1zUciUoSfsCv1+Brc6HTQ9Xg2qkd52SyQNokk3EhABDfpC33ws4dt8p/w52MdYEL/C7BM8UmJCVe3TWgjj9xRP6JnHjHx0h9hrYbSAc7IXUmsSb2tP/Ys3ZyVX9BVsr5Elh2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDN9I0OXdfchROmGvcJNoeO4eOuVGdTPoH9jBgX5oRs=;
 b=I02S+vlxGLcRGbe5u4QruusqJjjk6GuJj1EaEYTo/ODf1bDmrGFvftggjvy5bk1jhMB2BwzGe+ncdcosMXs1uJmxyh082KdDbKjq5pHaXJFnl24li3pw6b0Q8km2HUZ0Vqp1Su2EnyD1LoTQzk4PsCSO4p97Io9KyNhSMpIwAeOXh+Qh2arGAxox2JQJkKzZ5txq8Rp3MG4L2bM7jpjNmd6xU3ydSQnJOOFrZOwXW7YwkW6mfm7arnMXMSUwDuWc+VnwNm+OZwa2LN9XLZIAa3VRY+2V1nyon4xXt2VqtBhclqbl7uMTs3DEsSF+3way65NfIS8qn7qVbczg6qYkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDN9I0OXdfchROmGvcJNoeO4eOuVGdTPoH9jBgX5oRs=;
 b=AJsOZIIFUzDjetsbUIXndxDVoc2BlbDxxgoVAEtZMzadklCBneJtJdz5LGOZ+X8QHW8xW3D4z277pCQgaX3p3Oc/UFOD0pQul/RuXJPejvoaOkRbGyOcaXrlvdFmYWggrvvHck7CeStR7ahpj475rJe6W3WGjuAQ2lprcrsS09GoU4ljRRLJyRtTQnUPnh4owHWtG5fNUXAqq2hEdMdyRh1IquWnsxhtxFeDhFLWtpDrCHTIphysKwebFhL8E21kdxeyOouUsMFTuiHYk4TE0/29kM2JFcKxohvJvy5p7V8OlBkmAeTQ/ReK0npmJcT5jWcaJmVPqAdSNwH17RXk7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 17:47:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 17:47:49 +0000
Date: Mon, 5 May 2025 14:47:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Message-ID: <20250505174747.GA4155135@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <15-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <20250505174458.GA226031@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505174458.GA226031@ax162>
X-ClientProxiedBy: BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 3690b07f-aa92-476a-cbda-08dd8bfcf37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/fPHhSnI+A1m6AyVSx2rOFLSLfXU+Qf2TS+EwLvnQJIvVYMokPlXEir22IeV?=
 =?us-ascii?Q?fwEFZQraP/Pe+A99WglcHJsyGChTR8c1krv0gZHn6HBNbE6iDsDdtF1qmZP/?=
 =?us-ascii?Q?k4q1HVwxrVf1ptCGFD5sotum2Ovgwk4AFoOm+2KLwoO3jZ/URZfRUFH+xlso?=
 =?us-ascii?Q?/lKuxdUZat4LGHMx/w9uCDn77egjZN56dxbA9Pq3t8hssDf7eW3Br+TuDPM3?=
 =?us-ascii?Q?6+QK7CkyaqGYVQ0OEbiWWS3kYYDOVW4tJRwj2I9meUugRSP7bmvQSZmCY45x?=
 =?us-ascii?Q?INNi6iU9xak70pa4g/hYEsIRxYAuXYQmQWze9CWpXVaYqKUPq2jTnHuxFrm/?=
 =?us-ascii?Q?KQ5hTpdNpbu9JJxAV/0eQDQWdaBp+YgvcvceU1sRKNSrbpwmus7cAAWWrosL?=
 =?us-ascii?Q?UooXhhRS8uA+7J1crZ9enxSfuKnmxZe9SWEOBP8qNEG+ABsgAQjBsswhSkLz?=
 =?us-ascii?Q?o/uRK9RHfU635Zgi+g1ADQVWTzW9zgc9YSNiFfoKLyBOks0z9K6d/0BI5B3K?=
 =?us-ascii?Q?Ls95nQicUV1vLbAKF2B4KgO8nGfWQTbu2AvAS5BwYb+mbdyYBrTYGP2azlqG?=
 =?us-ascii?Q?7a6CMcHmULVz9L2fPEFSlvrLVQEjQ+/BdvhR1Se4Soxl/JwEjWoV1GJE9ZbI?=
 =?us-ascii?Q?z5s/3BJ6oIWFw8oztRy7I41fGbYbcyI3C2sSTKwz/3+3UISZ15NxZ1taYxev?=
 =?us-ascii?Q?dFda/GYwpBAaLLlDo1LqCFxPPXWMkJd0DdY1KutxZNTX4tjMhh2F33n1F4Kr?=
 =?us-ascii?Q?9lZTAQlnHECqZ2XFHxaKauwuKUq5k6DQ/WdsGWU8rbIn9Wx1OWevlkrD74lM?=
 =?us-ascii?Q?Nm520s9Ph1LUgKEeTnRTMXSNi0kFSocxFI+IOT+xuXUqc1Q9j86E50P8eeLs?=
 =?us-ascii?Q?M0T5WTk6mTzHV/1rLw+Lun3vuYO+Gs/G2+r+b/LYP6/9/tKanNr+XVn/GIyM?=
 =?us-ascii?Q?JOG/pKccJWjGsVQPN/z+AkQFZGWEtOIucBOkRTe7d2Q95COv/hYF+nvlC5Vx?=
 =?us-ascii?Q?lrlMg6U7BfIVwT3mtTYB9wd7F+GHQIaWP6FGmbZa2wq9A3crYxTTd3IFzY4P?=
 =?us-ascii?Q?u7yTgmjDrm7U0BAVPencWIwmTZVbjf/ZIYDLp6xK2LYjpT8K2aGHZK//Xezw?=
 =?us-ascii?Q?hi9rGMVadWFikZTv5sll5OFMmM43tp5CxDGydP+ekwfl0u9tYcnZYTsBHt5m?=
 =?us-ascii?Q?QkCyMiSz/D7m0JnN0zCPBl9cjsahMsc9jmMkp7ObrKGfDvNdIR0sbDhrPxRL?=
 =?us-ascii?Q?sNT3qd+eZkFU6NnVvhpYkIWFzc3RWbjN0xnzsYx80+FPkZ6xhEX4tgnIHjtP?=
 =?us-ascii?Q?L5HPco8StiHl1iZgRzw0F8EAaMLWWEPliR88Wn2n3VKVJnZ9AOoH44fLrdp1?=
 =?us-ascii?Q?pUPAXH48NtGjlk2vM7SrUYvp7EtjT9xcQHXgSNm18puvc7Zjv+VOUwdvwdpF?=
 =?us-ascii?Q?fNqEXy27c6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3PgV3p2FbMM4vxIjwg5J7FukJ3RoU8q1TI69G2fGnrYEWGhq7tlqPdyajvB?=
 =?us-ascii?Q?gIA2q7EfdguB89BU/lrZ/Pk8X47P0LB5Ty8vxPMH9D0HKsLsL6A1vbyOsQUb?=
 =?us-ascii?Q?msMXo8q1Sjn8q7d7iLH60G4GZXt8JcBBB2iizx6C65tUm2Q8nQijdqZi2kn9?=
 =?us-ascii?Q?JVCkVll3pz5jT+vlh8PS4oxYqpxIc2LAHqQBSoTiD7RZ0HSePKCVuf14lS52?=
 =?us-ascii?Q?eo4o+JQDyTme0SCdVhgeVLWMgdUB80/V7hyfCnSiFH+DKA/bdRHJLvYZiU0Q?=
 =?us-ascii?Q?p9whRDedX6c5qxGEm9CSC9QZXn6IrZuqkfym1pC8Hbhtd9bY2qZWGyDzq5tH?=
 =?us-ascii?Q?XysMFpFamIYo3j3KNsCGofY+4sAjLJKkvITi8yW2vK6Q6nNJAVr7uYiCiEzj?=
 =?us-ascii?Q?wiskQv3RoR2Yht9YUEz7E85KzEA0cecHJ20uNieBPszEFShK3HsS/ZI9sNTD?=
 =?us-ascii?Q?caNElPBdeY7HUZ7zWiuZHSYWiLIscwNH8vHDqErX+UEXdYi/qGzk8tqgtpwy?=
 =?us-ascii?Q?itgSoyOa/ZC4JprPnSNMzAuQjdKojSFmrsFy0z6Ya9mU15TeNm2DD/JzB2Sr?=
 =?us-ascii?Q?slmaqiuaTtbGeExxbDEMHlgZYuLqi/ew9UqonvmJNmAXzxvSJtvfS3aoFNbH?=
 =?us-ascii?Q?0kHs3Um36zYIuu09/YvUTtglhIw1Vsizvj7a0zjiRzliGJIzQ9NPeOZKVdxu?=
 =?us-ascii?Q?MMQCA/dEXqjES8WbdrwtyHvAnRGneHumom10Nm3adPCYOsznmMTr2QoUcKZE?=
 =?us-ascii?Q?gJzXrKXm05qlETElH4uME6t2SxQgnSXSk2Eq79KyUrP+VTGVSBw6iVr4go9E?=
 =?us-ascii?Q?yXhnodWvxmA3wJjGIkDBkAC4zw+CgaYiahBJk1hSMYc1Yl4/CINL8IcZXOKF?=
 =?us-ascii?Q?LHOXE+J7gscBZ4XwxTpV2OqDzVVObMJ6cZfXZiuk3v7vZfhRftwGJvKCKKVc?=
 =?us-ascii?Q?TqluamGTfE8VumswihorGsJ3IrIxa4eUonS85kfg4YHga1wMehvqKAr6NJe/?=
 =?us-ascii?Q?mNICLFcZJlo55xdSyaUjk6BywJ8Uq8bGfivV6MzR17b/Opo3zIdfBOzeBtU2?=
 =?us-ascii?Q?V3L+fSwEU7yR9kR+lVI497pZxW4Ohh3ef/D8J10IpMiX+d5mt6j5QxiTVkvR?=
 =?us-ascii?Q?Jm7hvjp0eGnNhtI7DZyq8y7qUNx3oez27m5vvDRYPFGpu5MMBx4qDF5Ch904?=
 =?us-ascii?Q?4e9jMza7+it2g3p/W1XeiiDqE7+nWJpboxff60Q8d3/DemcQs94U9UUVaByI?=
 =?us-ascii?Q?jXtkqaVWVOcbofkoupj58AdSk9zFT3ThmmtO9MuaKmef+XMBVVQpkzrSBwxB?=
 =?us-ascii?Q?1OxlvXcZK4nb6uxX8Ds55cMBBk4mVOTs3BF7sSA/2w2in6cVQX5Tw/E8qJNz?=
 =?us-ascii?Q?UsE+AdeGQ5Q0UaVveyL2ef+8REpOd3QKheCirf3/iUH5Yng6WRIAfD9WVTFh?=
 =?us-ascii?Q?wFJbN5EDclYzeqS5B+jtn0AnhvpO402Ph6IP1leK9AERXoC6AtAYXvqY1RX5?=
 =?us-ascii?Q?iQISyiwWpFH+Xj+/ufy6jMm1FR/NkNAQPdCJBqe/918eBh3s5JLTqBC2VlkF?=
 =?us-ascii?Q?TVv7ocsb7YetPSQNVEd8v1qPHnQNlpK6wMT+hhkm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3690b07f-aa92-476a-cbda-08dd8bfcf37d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:47:49.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4piDYBItx5g8NEF+1rrc/H2kPDCNWBvvRefQgFdjg2o3ErQSZ8rGkAOU0ki35R0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700

On Mon, May 05, 2025 at 10:44:58AM -0700, Nathan Chancellor wrote:
> On Mon, May 05, 2025 at 11:18:45AM -0300, Jason Gunthorpe wrote:
> > This intends to have high coverage of the page table format functions and
> > the IOMMU implementation itself, exercising the various corner cases.
> > 
> > The kunit can be run in the kunit framework, using commands like:
> > 
> > tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=1 --make_options LLVM_SUFFIX=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> 
> Just a small comment about the command:
> 
>   --make_options LLVM=1 --make_options LLVM_SUFFIX=-19
> 
> can be simplified to just
> 
>   --make_options LLVM=-19
> 
> You should never need to specify either LLVM_SUFFIX or LLVM_PREFIX.

Oh wow, I had no idea. Can I encourage you to send a patch for 'make
help' to explain how to use it?

Thanks,
Jason

