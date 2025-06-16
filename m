Return-Path: <linux-kselftest+bounces-35134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FCADB871
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD96168693
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6DD28980A;
	Mon, 16 Jun 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wv7y5u5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE86289808;
	Mon, 16 Jun 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097197; cv=fail; b=s55gS23vKWpS1Cbi0dONfeYEqrcF7ELORRf1r2b2/ok4vhU8Nv6UQqNucl588R0rrGLdimGcu9XRxv1vMD1XMrgZQDU64c1ILIf0VfqmRjHK4pSc0LfU2u1tYQYMGf+nAdwj9/RneciSbvBsUw4d8L5ATWBhJEWfNHymibaLZU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097197; c=relaxed/simple;
	bh=ruRt/emJGWyrRlLS/6nYv+8lEf9wxdTBBckc9eIn3Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBCNdPar6i4mNRuYf9C51qchCyJ2vOZfcWby1m7fPetPJ1hRDuXz0iqc+I8jabrCD6nf1y9PBdyFaadPJinA6hxUHxDi783SjZ3uhY87KcGChOZHneSwUG5B9Dz/WqtGWGr/Q+/idPC4JKPur4k0u/f3S0bIPhgxz4gJFq707vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wv7y5u5T; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrbJMAd4gbT2H1RJtT6iqX+IYI5reZVGX5Uu2zQjwTQ5T36gIZdbJSldtpTeLQbVu9q0EMDT/SyOnTszrW401nJYNco+2D6LjBCom8GyraRpXnCRLO/PE8WW+tuGD1OfqByX5kn5LQoGcDuJBzOtg5u3EPSUgFJyaDMg4gMXeRyk11yJOYWsgNKmpHb6Ras1FvoG1dQ39V4ru8MTCzzpp42edOwHcfNlPluR1j4zjVkVQQYIRGvw5HxTVwbIapf30OHLuS7C96BmDahJ+eEioWZfa6iFFJ3GHZzjlm2g6NgltEPe7ii3P+tr98qjmpPln1h5kRuNnB2Y+7jKia3eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H//Pf8eJtBhimNX2BzyuhQ2AelG2OalJ5cJLrOiXX7s=;
 b=GzoSioejaxPt11R4pw/28MDlW7R7QP8tlmJQ4WViTs42u/DtFBOFdcyawD3cB64pptMG7iKAXawsbXZnoRBIj/pgDUBgK2TnDu1n052i/3bsywpFPnLBRKsXYiNO8eBk1cT2xW7rLExMIxq0/EYhlGEJL70S0G67JvOxoHE/U36KBIB9ECxXDXzJKfEFpqi62M/vjX+P1FsdcDd81J21ukHNYYJQjHd07AhxNKVLxZ6/ckZl/x6g/ZhM4cNSIkXLARBn0CR1QLmmAU/GFgXiokw1n1ysk5O/jmFP0Dq3SqMKb5b7BbO2ciZHNGYwFuhlgdzBV7KaF6dze4XNdJdRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H//Pf8eJtBhimNX2BzyuhQ2AelG2OalJ5cJLrOiXX7s=;
 b=Wv7y5u5TBKtRbbckxj0ZbNpQjAyNGKUwhCYko4f5zltykZEUYTzPFpAkIQI1l3Pw7mrXIJm+jmMTgINTZ+GU7S4AfeaGdo3/GeMhM7iW12kxr1QMQ13TtQRxLxUw5XwJQ9Rh3yD2CnPTz+D3b9s2XLn5t2durOSHM4e+uwDgtP08APr4oHZSTWCY/ikdu1Y1pgTLBdMPl3X+eGVmD0eZ7OQ3A0YlJSO/w+hT1XUYtxCpHlaELyBOmdRmG1FT/rnINU+dVZRlRIjaTlvKxdERIY9JaKmCTEMJAinqdaOJGF+kxca1urdT44SszzJEgNh/ipc+LIK0KkoqXMoX43aTrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 18:06:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:28 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v3 15/15] iommupt: Add a kunit test for the IOMMU implementation
Date: Mon, 16 Jun 2025 15:06:18 -0300
Message-ID: <15-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:930:cf::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d6f682-fa71-4d26-52ba-08ddad008147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4gywHCUG5vQrfTvqibzwgNQ1RvpXmsuZm6g6jsOxScWEZNV3uciEMDF+XiAS?=
 =?us-ascii?Q?73kKgTQt16ANPl/YoF5Qg5z/J1sTeyWWlWlqYMHnIfzeULYfg5vnzSa5ltuZ?=
 =?us-ascii?Q?AtWUgVPWUi7Sk4f9Q9qF0qfWS4MXWKR+FtNT5V40N+QoO2GmL/LlBtzNqeZT?=
 =?us-ascii?Q?Xl72T6n7DTVfKEDAdD3GmgfOGrqsbT+SbRijaRoRhrkw2kIpl6g++By6Knoe?=
 =?us-ascii?Q?P5+qgRIDqtsMKc/TRcUeOrgj1kM6e71R9utJAEnYD871R4zGob1BK2dkdybp?=
 =?us-ascii?Q?bdM3do06xEtZMi5NONrNOTBYMKEIwlefg+drf+BBAWLsX5L//NEmW7boTlW/?=
 =?us-ascii?Q?xPJYg7ZB3u3HXbGb6u8JthfFUeSZoMxwN2yDl8UByB6sdjWOimeyDNkZogko?=
 =?us-ascii?Q?jcqyLLh4MYlJrQ6u51qsf8bYVZbI9WI0t1CM27hFNBVAoZ51VB0nuA8maABz?=
 =?us-ascii?Q?W3vFn54XC73BxvETfH3aXWiJ57AmL2EglLNz9Wdd+NuEjYyUz7CQaZ5Tz4fT?=
 =?us-ascii?Q?ytoQHXNWxHSCPhyWS5bqA7Tob4V+eWRZwOU6JCsjhNo9oX751qwdSqNZFJF8?=
 =?us-ascii?Q?ZjDsKUZ8vHosNVKtIwTV591vGI9pBV61zN89OdEC0aFYUZL3TjRMlohU+jbE?=
 =?us-ascii?Q?bH9GpK8SNici8VTdPw1YtDe44EX0EujoW7wjBs6H8Ve+90ka3ITBUTPm190C?=
 =?us-ascii?Q?2dBle4s1Wq+ESfMO/QOVVyBcRbYlUCd7UDhR1os6MDcY8O+KQG1S03ZIMjgk?=
 =?us-ascii?Q?J5imx9sr+cl/SbtuHxJ1oDGZKx50RKBUCHm1kqXent2G6XnkqgydcYpTqMc/?=
 =?us-ascii?Q?Z6ToIsvs58bl0nfYh8v90ACCqNCh4uJGJRR4VR/xNPVRaQGnA1yuBoZ1S/8P?=
 =?us-ascii?Q?CfiEiCWBgVeAvTFWlA8tioUYp6Acxs+Ab3dvvy8FopwJlt1Mw2GFIYvaL3T6?=
 =?us-ascii?Q?EkjkEE9b+IrCmnQ3FE4UHCxU9HfcxkC2H/8oUXmgJXdpocBgZG37BID8Zwsl?=
 =?us-ascii?Q?Zb1CLs/B2gKm6R1L/z3cOElEyC2uCJ8+6vem6J2BTptt1htIXEHy+y36+gJz?=
 =?us-ascii?Q?gidfwOlg3VOn6DY4W2K0UCNHgbLdqTkGvdIdC6if3hFI+xjtmESYrjtY/wT6?=
 =?us-ascii?Q?yDG7t6RGweWrohe4sigWn9kW74LmrUV4UjhdQsbBhtmUJt8PWAOR2ZbeI0Wa?=
 =?us-ascii?Q?2xHc3/7xMz8Uo7r8B4lPkPAw1ul8SM2fadxDbiPaKmyoYHIBO009fo7kJAvD?=
 =?us-ascii?Q?fW2OHFSK5+jaNvQWwJExVwACu8YDkGaXgpthohbtzhMF/c2XArg1uw9bAhlF?=
 =?us-ascii?Q?mgXxzjaezdyOiGwcyFFR27E4AlZWqwwrSXnQfQcvYtu67e2YI6MPwmr6ytAA?=
 =?us-ascii?Q?zzlrSyq3W/usdLxbIGiD9RccVQSbUffPqk4AsGVLIsOIqdbgw+Fb8swnybD1?=
 =?us-ascii?Q?7Y8BT1S8cmaJidyUD5rNntqQnI2Gr35LFhBZ7u+kZHfczpmnTtQKdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSYsIeQ/PAQekGKhz16hDvx0b5MZt76KbRz5/4OWtG/01RCo5nszdpWUaqXz?=
 =?us-ascii?Q?bTTN0FLd+U3aEOmViW+TlkUnupheFj7eqIcPm88ti73CX0uWTr2EuWGhxNz3?=
 =?us-ascii?Q?71o5+a/8daHA4iWel/f6M1p+0dLsP+QkUmgaCCb9rw7+vXxBLTulnvH1WhWq?=
 =?us-ascii?Q?1q98a7EGly9t2TzxG+D429b7nu5dpsWqI/6rk+cVi6ealPDt/R3eFdUEaMAl?=
 =?us-ascii?Q?KYd7JIlE049AYAkjtKGqr51od17HQaQJatjQ6UH8DXvq5EalELqHchOGIv2m?=
 =?us-ascii?Q?cMHg8bKDXuJgTja7avyJu7qUrg6CaINbUIsWF+HLRI8TPgzoNp9cSVwtuyaC?=
 =?us-ascii?Q?Z7h+doMkHKOG7cXvcoLq73i2uZswdtjyLzyUwwh0/b6gdycZL7Q1/vBboso3?=
 =?us-ascii?Q?dsEENbUpdr4aHAzI/JOhWbT8VkR60U+ezu64GLzX/oiLqiOj2bvIBctDAhZI?=
 =?us-ascii?Q?VyyvaIAMfamSIBlqGBEgf8qHK4RoSZjXhAIGlI4w4hp0Kvo52xe2YVm9a7Qr?=
 =?us-ascii?Q?zphPUC9La82oZ1Wp81qF0nK/+rrKf+kfXfkxrCvWVqewur+b0lbjshcrfHkd?=
 =?us-ascii?Q?XXIrADNqKMNAuwYrGd6HrGV/ScarEzSjVYOTqeooUBUt3+XRbyy9xsKYASaX?=
 =?us-ascii?Q?e3o6MKG+A3C86Q1jxdSlJKjpthRU1L6p1J68RZ3CPa6t9WQ/Qzxw3ltOnpce?=
 =?us-ascii?Q?zH27wHSiRzxwgRY7RxSIBavrf/q29f3Mc3hfo7hkuBcaslIDZlncEDIFg0Vo?=
 =?us-ascii?Q?k9do/Mn0sNjnmovXWe+zlXmWu3jqt2yd8IwhC6IdG1g8rH//dMHOtJOQ0zEM?=
 =?us-ascii?Q?SaBqFEtpFJKZLeakSYsznNzQGSe9oZI4XxndBMhMwsADWTNVJ9spj2yYvJUd?=
 =?us-ascii?Q?G+PKT1p3qDOtUd+8n+zwmugqRWeCJL9dnAipge4+dD1loj1vM5rFND2Ud/Yk?=
 =?us-ascii?Q?Wm0ytEkccoTfqyekgcFGolQAn5BIiICpg8ZcU4LvzOCYnjdozI1xvakMQh0R?=
 =?us-ascii?Q?ZeKWNHoq6aZ/inrxZhp0trJYH0AfrQfadNSoHVCNBA1cEs51pb51z8vn32Q3?=
 =?us-ascii?Q?h/X2QgE2+cYyZbQ4fi0TunRvjoOzgOl8qQkZCwNcLUg8JhSeG6Bsu+1j18Q4?=
 =?us-ascii?Q?IkotWgy10ypGsrYrUuC5q+KM8zAqU1+zp3YipV8Td0B2gzKEBM0P6BMGpqd6?=
 =?us-ascii?Q?eb573sR5B9XY47/T2X/r5/jO6VuApzjunLfoWKVGB5d8nlBnC7TIpeNiawFx?=
 =?us-ascii?Q?j8Wbkk0nuuPtMaqNG2Lz/i9bHG5nwbgCbMxz08swvgNhawlJCwqQkYDAvgft?=
 =?us-ascii?Q?tCjiKPeR8TWMlMHLi28FYFnuqqdywNlMFkbhYty5++mCR2X1tfunxz1npB0q?=
 =?us-ascii?Q?3el4xGCnmNVoe/+u5yMtMUJHO9bbJ2xMCeCkjiiW158ROfJI54VAoWnsh/Qk?=
 =?us-ascii?Q?ixOpI5mHRTvECd22QAqu6EsUW4ud1o3ZbbFJxEzPHGKZmG7QjLRgp6EIkLh9?=
 =?us-ascii?Q?OCp9kfk3VWJZsU489YJLk+90s42fGYiDyHDQDj/Cqv1iABgwY/LbR5/iG1N2?=
 =?us-ascii?Q?kbOPANO3xcKFDt6DIYhniYnExonbqk3nvKd6QSk+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d6f682-fa71-4d26-52ba-08ddad008147
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:24.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge0+SbsEpXzPR03lWlsblfJ+meKPSVG61LWpNmUN+5sBYDrEydvFMMigLAVASRAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

This intends to have high coverage of the page table format functions and
the IOMMU implementation itself, exercising the various corner cases.

The kunit can be run in the kunit framework, using commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=100
tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y

There are several interesting corner cases on the 32 bit platforms that
need checking.

Like the generic test they are run on the formats configuration list using
kunit "params". This also checks the core iommu parts of the page table
code as it enters the logic through a mock iommu_domain.

The following are checked:
 - PT_FEAT_DYNAMIC_TOP properly adds levels one by oen
 - Evey page size can be iommu_map()'d, and mapping creates that size
 - iommu_iova_to_phys() works with every page size
 - Test converting OA -> non present -> OA when the two OAs overlap and
   free table levels
 - Test that unmap stops at holes, unmap doesn't split, and unmap returns
   the right values for partial unmap requests
 - Randomly map/unmap. Checks map with random sizes, that map fails when
   hitting collions doing nothing, unmap/map with random intersections and
   full unmap of random sizes. Also checked iommu_iova_to_phys() with random
   sizes
 - Check for memory leaks by monitoring NR_SECONDARY_PAGETABLE

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/iommu_template.h |   1 +
 drivers/iommu/generic_pt/kunit_iommu.h        |   2 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h     | 451 ++++++++++++++++++
 3 files changed, 454 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h

diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
index 11e85106ae302e..d28e86abdf2e74 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_template.h
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -44,4 +44,5 @@
  * which means we are building the kunit modle.
  */
 #include "../kunit_generic_pt.h"
+#include "../kunit_iommu_pt.h"
 #endif
diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
index 8a53b1d772ca9d..cca4e72efcaa04 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -70,6 +70,8 @@ struct kunit_iommu_priv {
 	unsigned int largest_pgsz_lg2;
 	pt_oaddr_t test_oa;
 	pt_vaddr_t safe_pgsize_bitmap;
+	unsigned long orig_nr_secondary_pagetable;
+
 };
 PT_IOMMU_CHECK_DOMAIN(struct kunit_iommu_priv, fmt_table.iommu, domain);
 
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
new file mode 100644
index 00000000000000..5e25d698450783
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -0,0 +1,451 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include "kunit_iommu.h"
+#include "pt_iter.h"
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+static void do_map(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		   pt_vaddr_t len);
+
+struct count_valids {
+	u64 per_size[PT_VADDR_MAX_LG2];
+};
+
+static int __count_valids(struct pt_range *range, void *arg, unsigned int level,
+			  struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct count_valids *valids = arg;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			pt_descend(&pts, arg, __count_valids);
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA) {
+			valids->per_size[pt_entry_oa_lg2sz(&pts)]++;
+			continue;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Number of valid table entries. This counts contiguous entries as a single
+ * valid.
+ */
+static unsigned int count_valids(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++)
+		total += valids.per_size[i];
+	return total;
+}
+
+/* Only a single page size is present, count the number of valid entries */
+static unsigned int count_valids_single(struct kunit *test, pt_vaddr_t pgsz)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++) {
+		if ((1ULL << i) == pgsz)
+			total = valids.per_size[i];
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[i], 0);
+	}
+	return total;
+}
+
+static void do_unmap(struct kunit *test, pt_vaddr_t va, pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	size_t ret;
+
+	ret = iommu_unmap(&priv->domain, va, len);
+	KUNIT_ASSERT_EQ(test, ret, len);
+}
+
+static void check_iova(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		       pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t pfn = log2_div(va, priv->smallest_pgsz_lg2);
+	pt_vaddr_t end_pfn = pfn + log2_div(len, priv->smallest_pgsz_lg2);
+
+	for (; pfn != end_pfn; pfn++) {
+		phys_addr_t res = iommu_iova_to_phys(&priv->domain,
+						     pfn * priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, res, (phys_addr_t)pa);
+		if (res != pa)
+			break;
+		pa += priv->smallest_pgsz;
+	}
+}
+
+static void test_increase_level(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_common *common = priv->common;
+
+	if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		kunit_skip(test, "PT_FEAT_DYNAMIC_TOP not set for this format");
+
+	if (IS_32BIT)
+		kunit_skip(test, "Unable to test on 32bit");
+
+	KUNIT_ASSERT_GT(test, common->max_vasz_lg2,
+			pt_top_range(common).max_vasz_lg2);
+
+	/* Add every possible level to the max */
+	while (common->max_vasz_lg2 != pt_top_range(common).max_vasz_lg2) {
+		struct pt_range top_range = pt_top_range(common);
+
+		if (top_range.va == 0)
+			do_map(test, top_range.last_va + 1, 0,
+			       priv->smallest_pgsz);
+		else
+			do_map(test, top_range.va - priv->smallest_pgsz, 0,
+			       priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, pt_top_range(common).top_level,
+				top_range.top_level + 1);
+		KUNIT_ASSERT_GE(test, common->max_vasz_lg2,
+				pt_top_range(common).max_vasz_lg2);
+	}
+}
+
+static void test_map_simple(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	pt_vaddr_t cur_va;
+
+	/* Map every reported page size */
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+
+		cur_va = ALIGN(cur_va, len);
+		do_map(test, cur_va, paddr, len);
+		if (len <= SZ_2G)
+			check_iova(test, cur_va, paddr, len);
+		cur_va += len;
+	}
+
+	/* The read interface reports that every page size was created */
+	range = pt_top_range(priv->common);
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		if (pgsize_bitmap & (1ULL << pgsz_lg2))
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 1);
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 0);
+	}
+
+	/* Unmap works */
+	range = pt_top_range(priv->common);
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+		cur_va = ALIGN(cur_va, len);
+		do_unmap(test, cur_va, len);
+		cur_va += len;
+	}
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+}
+
+/*
+ * Test to convert a table pointer into an OA by mapping something small,
+ * unmapping it so as to leave behind a table pointer, then mapping something
+ * larger that will convert the table into an OA.
+ */
+static void test_map_table_to_oa(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t limited_pgbitmap =
+		priv->info.pgsize_bitmap % (IS_32BIT ? SZ_2G : SZ_16G);
+	struct pt_range range = pt_top_range(priv->common);
+	unsigned int pgsz_lg2;
+	pt_vaddr_t max_pgsize;
+	pt_vaddr_t cur_va;
+
+	max_pgsize = 1ULL << (log2_fls(limited_pgbitmap) - 1);
+	KUNIT_ASSERT_TRUE(test, priv->info.pgsize_bitmap & max_pgsize);
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+		pt_vaddr_t offset;
+
+		if (!(priv->info.pgsize_bitmap & len))
+			continue;
+		if (len > max_pgsize)
+			break;
+
+		cur_va = ALIGN(range.va + priv->smallest_pgsz * 256,
+			       max_pgsize);
+		for (offset = 0; offset != max_pgsize; offset += len)
+			do_map(test, cur_va + offset, paddr + offset, len);
+		check_iova(test, cur_va, paddr, max_pgsize);
+		KUNIT_ASSERT_EQ(test, count_valids_single(test, len),
+				max_pgsize / len);
+
+		if (len == max_pgsize) {
+			do_unmap(test, cur_va, max_pgsize);
+		} else {
+			do_unmap(test, cur_va, max_pgsize / 2);
+			for (offset = max_pgsize / 2; offset != max_pgsize;
+			     offset += len)
+				do_unmap(test, cur_va + offset, len);
+		}
+
+		KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+	}
+}
+
+/*
+ * Test unmapping a small page at the start of a large page. This always unmaps
+ * the large page.
+ */
+static void test_unmap_split(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	unsigned int count = 0;
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_vaddr_t base_len = log2_to_int(pgsz_lg2);
+		unsigned int next_pgsz_lg2;
+
+		if (!(pgsize_bitmap & base_len))
+			continue;
+
+		for (next_pgsz_lg2 = pgsz_lg2 + 1;
+		     next_pgsz_lg2 != PT_VADDR_MAX_LG2; next_pgsz_lg2++) {
+			pt_vaddr_t next_len = log2_to_int(next_pgsz_lg2);
+			pt_vaddr_t vaddr = top_range.va;
+			pt_oaddr_t paddr = 0;
+			size_t gnmapped;
+
+			if (!(pgsize_bitmap & next_len))
+				continue;
+
+			do_map(test, vaddr, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			/* Make sure unmap doesn't keep going */
+			do_map(test, vaddr, paddr, next_len);
+			do_map(test, vaddr + next_len, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr + next_len,
+					       next_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			count++;
+		}
+	}
+
+	if (count == 0)
+		kunit_skip(test, "Test needs two page sizes");
+}
+
+static void unmap_collisions(struct kunit *test, struct maple_tree *mt,
+			     pt_vaddr_t start, pt_vaddr_t last)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	MA_STATE(mas, mt, start, last);
+	void *entry;
+
+	mtree_lock(mt);
+	mas_for_each(&mas, entry, last) {
+		pt_vaddr_t mas_start = mas.index;
+		pt_vaddr_t len = (mas.last - mas_start) + 1;
+		pt_oaddr_t paddr;
+
+		mas_erase(&mas);
+		mas_pause(&mas);
+		mtree_unlock(mt);
+
+		paddr = oalog2_mod(mas_start, priv->common->max_oasz_lg2);
+		check_iova(test, mas_start, paddr, len);
+		do_unmap(test, mas_start, len);
+		mtree_lock(mt);
+	}
+	mtree_unlock(mt);
+}
+
+static void clamp_range(struct kunit *test, struct pt_range *range)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (range->last_va - range->va > SZ_1G)
+		range->last_va = range->va + SZ_1G;
+	KUNIT_ASSERT_NE(test, range->last_va, PT_VADDR_MAX);
+	if (range->va <= MAPLE_RESERVED_RANGE)
+		range->va =
+			ALIGN(MAPLE_RESERVED_RANGE, priv->smallest_pgsz);
+}
+
+/*
+ * Randomly map and unmap ranges that can large physical pages. If a random
+ * range overlaps with existing ranges then unmap them. This hits all the
+ * special cases.
+ */
+static void test_random_map(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range upper_range = pt_upper_range(priv->common);
+	struct pt_range top_range = pt_top_range(priv->common);
+	struct maple_tree mt;
+	unsigned int iter;
+
+	mt_init(&mt);
+
+	/*
+	 * Shrink the range so randomization is more likely to have
+	 * intersections
+	 */
+	clamp_range(test, &top_range);
+	clamp_range(test, &upper_range);
+
+	for (iter = 0; iter != 1000; iter++) {
+		struct pt_range *range = &top_range;
+		pt_oaddr_t paddr;
+		pt_vaddr_t start;
+		pt_vaddr_t end;
+		int ret;
+
+		if (pt_feature(priv->common, PT_FEAT_SIGN_EXTEND) &&
+		    ULONG_MAX >= PT_VADDR_MAX && get_random_u32_inclusive(0, 1))
+			range = &upper_range;
+
+		start = get_random_u32_below(
+			min(U32_MAX, range->last_va - range->va));
+		end = get_random_u32_below(
+			min(U32_MAX, range->last_va - start));
+
+		start = ALIGN_DOWN(start, priv->smallest_pgsz);
+		end = ALIGN(end, priv->smallest_pgsz);
+		start += range->va;
+		end += start;
+		if (start < range->va || end > range->last_va + 1 ||
+		    start >= end)
+			continue;
+
+		/* Try overmapping to test the failure handling */
+		paddr = oalog2_mod(start, priv->common->max_oasz_lg2);
+		ret = iommu_map(&priv->domain, start, paddr, end - start,
+				IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+		if (ret) {
+			KUNIT_ASSERT_EQ(test, ret, -EADDRINUSE);
+			unmap_collisions(test, &mt, start, end - 1);
+			do_map(test, start, paddr, end - start);
+		}
+
+		KUNIT_ASSERT_NO_ERRNO_FN(test, "mtree_insert_range",
+					 mtree_insert_range(&mt, start, end - 1,
+							    XA_ZERO_ENTRY,
+							    GFP_KERNEL));
+
+		check_iova(test, start, paddr, end - start);
+		if (iter % 100)
+			cond_resched();
+	}
+
+	unmap_collisions(test, &mt, 0, PT_VADDR_MAX);
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+
+	mtree_destroy(&mt);
+}
+
+static struct kunit_case iommu_test_cases[] = {
+	KUNIT_CASE_FMT(test_increase_level),
+	KUNIT_CASE_FMT(test_map_simple),
+	KUNIT_CASE_FMT(test_map_table_to_oa),
+	KUNIT_CASE_FMT(test_unmap_split),
+	KUNIT_CASE_FMT(test_random_map),
+	{},
+};
+
+static int pt_kunit_iommu_init(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->orig_nr_secondary_pagetable =
+		global_node_page_state(NR_SECONDARY_PAGETABLE);
+	ret = pt_kunit_priv_init(test, priv);
+	if (ret) {
+		kunit_kfree(test, priv);
+		return ret;
+	}
+	test->priv = priv;
+	return 0;
+}
+
+static void pt_kunit_iommu_exit(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (!test->priv)
+		return;
+
+	pt_iommu_deinit(priv->iommu);
+	/*
+	 * Look for memory leaks, assumes kunit is running isolated and nothing
+	 * else is using secondary page tables.
+	 */
+	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
+			global_node_page_state(NR_SECONDARY_PAGETABLE));
+	kunit_kfree(test, test->priv);
+}
+
+static struct kunit_suite NS(iommu_suite) = {
+	.name = __stringify(NS(iommu_test)),
+	.init = pt_kunit_iommu_init,
+	.exit = pt_kunit_iommu_exit,
+	.test_cases = iommu_test_cases,
+};
+kunit_test_suites(&NS(iommu_suite));
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit for generic page table");
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


