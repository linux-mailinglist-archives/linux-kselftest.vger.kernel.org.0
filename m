Return-Path: <linux-kselftest+bounces-35127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB4ADB864
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C68188D2B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2C288CB7;
	Mon, 16 Jun 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NQDV9HJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45EE288C12;
	Mon, 16 Jun 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097191; cv=fail; b=emaLaH0fpL2vfu8eg+TDQn6xdmrtIwblUjfy9nayXfj82hJ7Miopd0KrPby4j6BYJFjzrGVPHa4kPa81eRSUipEn2OF9JaQRgo1m/kx3bQ/oFEoaCc/1XqEqas1b3vsNvsILbG6YUkrHooTIUVQ4UWyGvKzqWyi5p3nNAIo7Zsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097191; c=relaxed/simple;
	bh=uELafSJ+nDrgeGeurOgGCAiRt6kejjw1FfhB3exE388=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kAiQHCdHb6fbvXVJyI76ouoQHdgt1fdgl1WjQPGFvue6Etbu7HeMLsxgP22WlMmAdhttpi9k/D6s7gkoRZPnDBoCBcYE1rjq6s9C6tb21IhZjpjFiw7JLEJ0S3xI1AXf/wEyToMdWbndCLhOb03uaBje6iap1OzAGCTHBBqOrDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NQDV9HJG; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZKTjPFLP4DY5pw4RhExqjVDEbbYSt12QYpP88+cmbKSdkb3CE9pQnaUOMRfMe9k4yIQ2lmBrweJ2qQlQoYOOwBDlMmoXnIakKXa11eNpKSk0VHo1bLPmncWrc9MWm9m1rRPNZsfz3a8ErAWHMfk+38F2NKh0TMu+AliDkJCHWKcnMK3ziPl+CyOpC5Oe7WhAkn4jELLcEOdM/S0Hd8L/fe5F2+Em+QkFpazV1f4IVyz1OXHqWSYTqDrdfTkal1gfFAHZjdWCo6jf+21fBvesXyNCUvt78AxpwuLV7uPB7rRWcOzrRCzeGOTuphPDCUhtlMZBH2rPmjW5LpQVaa7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu12XfxN3g7iU9MmB9P2V8Uio14qAJy3nHNxLwR5Xm0=;
 b=Zi8l0ZwQ9mYU+Tfv04i5Awf++pxl0oMMVO0P5w4+5LhnppyZ0KrNGWUInv0loq5v5/IVNyzo8S42N7s6qTq3CxuZnWHdMteIHbtShXJ/j56ud6PniGzxVf6CrWC09fyx75tiw4dLrx6oIDimu36fVd+a4P9HqVlSWSrqi073vWIaVZjOh1JO0oTGfW2zpzQd3xy+2yB+MS7Xlu+jpXInQSAN83gj3BHwRfcrrc2qO37B5oGrP2/2E7IHQTHKE75orEw9zipAhlMdCNmuh5MoS9cmRFSxaKWZuwlEbxoVIVsIZbn6VkZ9Dz6zEO7SWjQ//Ru6/HJsl1GbZNUbT7qm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu12XfxN3g7iU9MmB9P2V8Uio14qAJy3nHNxLwR5Xm0=;
 b=NQDV9HJGmaRWDLhJ7PfZCaN04krKlCnSfXTtR84QM/tLJzJpW7OE3VQzWVrIdkv5Eu+CD70EHPa2Z6JKrGCmQssOjZOh/MZ37+xJOaH5GcvBmHROLroluOb4B6smUuGIraR6tbddHD+/VlriLqijfIZBcR+oCF2FOXOQUKgGKZzFHDyhO/L+gO4jcxuCLVIafDKYJpiZD2WxQIzl49H0TtP3YR6tRnKf4E0/lZj5iOPTYzXN4eHyCxuJq5Z/Xale1Top+doah8dZ6TByjdosjIvU7nZXuvglcDTgikrnvWNFWG1D+7ABq+QCFatEzsSA72A4ryywTPaXWwqFKaDFWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:25 +0000
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
Subject: [PATCH v3 12/15] iommupt: Add the x86 64 bit page table format
Date: Mon, 16 Jun 2025 15:06:15 -0300
Message-ID: <12-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:208:178::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: a178c90c-7630-4eb2-a746-08ddad0080b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Icf8JIiX04Q2eudxrsvfh+Y/dJOUcqRkqTbzc73/ZvrqFhTGbPH9Oa+W8TB6?=
 =?us-ascii?Q?FxbcFoglwykfBkzXKXJxtWHEQWFObHLLm2ch2sgHjK4cOcCIb6L9iWstLKRw?=
 =?us-ascii?Q?HqrifyVHA97ufmvZ4slMjZ+GY4SX09N/D+YCqlE8LXRXnzYvggqSSnpAwond?=
 =?us-ascii?Q?Hn94q7Si8rT9ULlkPOqnSLDEsvDlQDGo6TdN0Ze+uhTKJVcrix5pgW4CpBES?=
 =?us-ascii?Q?931YSmnLMd7SHrhikfm/W2mfWwNg4zN4TuBJHqZZF6dnuvuOHcvcVM2sZj2/?=
 =?us-ascii?Q?1RCcyZFKeOKdnbHlKKJVtHEVkqTwEsSBiXFaHANmjU6cPMTd21gFfQ5h45z1?=
 =?us-ascii?Q?aEWh5cNAayngewN2+CwiPbI5hAMick6jra3lMKKUX5lBjumHEroUUL6Ocs0+?=
 =?us-ascii?Q?ufFi/W/lxz9ctxKeVov/+k0wBkV6jpXJAMeCOyjGl4ASnaWMqdNIRwS5EzVU?=
 =?us-ascii?Q?HF13bJLfDsepMkMufIwyqdCUguuUnvg/pHeW/aiJSn5rcXadmNkxEcG2wj2R?=
 =?us-ascii?Q?gfmsNcxd1EfkfDgyf/Ggbbqtv9ROFEeL39u3yfqai0bouiThj/Q4KcgXlJGX?=
 =?us-ascii?Q?S75pawzS5jrLDBPfl0Ms60Jf15UN/K/+VaCT+/K/twxkbbgxXVsGktZmcx7X?=
 =?us-ascii?Q?JkAH8AIRjL3motIzUMDBm+Hl9EjMW/7GGp0aFtJrLVjvpSbc3BNRWgKMg/tl?=
 =?us-ascii?Q?RLg2VxoLrJgzZoUBSgIiUc50RA9mExia535wp7elLkI2wBhn3BY/LCsHy9yg?=
 =?us-ascii?Q?67/4Xfbz93UcEuzjChjs3qUY+iKq6GxyalFXwmIuu5oMrhChrPBIzKlvY6HM?=
 =?us-ascii?Q?1Zo3+IpbKkEE45qfEinC1oAqz6pfqGqhfJ4qBHo78DnoW095w7SBcV+80sL2?=
 =?us-ascii?Q?EkZLnbYlmeLO361Kj3JqoCI/bo5fq26eEah4yuBBRqb7oa5vovUdeapfOk+k?=
 =?us-ascii?Q?6nN8DVggumxy8136MKL7OvtPu7odRiQT+ZprDxloKk2IPEDIH6njPWxJmtLq?=
 =?us-ascii?Q?JEIm/0diwWb9pbGoH+4SVeIwI196ionL6CNEcT0FB/VTTh7L+OLDg4m0ubCi?=
 =?us-ascii?Q?Y+wJPNi4F4afInRBkF5dZlZBmNxQASbFyYTPUOWBhE5QalfQW9WPzopG5QyN?=
 =?us-ascii?Q?zQmZuIfPL85nfCahSUs9gumHoEPjJ0eYwupjmMoqxddHwWaG0u1sp4xBJJAe?=
 =?us-ascii?Q?FiQfToUkdnbhly5uadK/VjsuYMyTh5Rqqt7bk4rIY3IniverYVLdF01rM/Gr?=
 =?us-ascii?Q?3oU+jm5N8VXGey+45W+tCir7mDR9SKIRZT94wXKhwKdAwcAW/T2cVA19fpgi?=
 =?us-ascii?Q?ii+ac8JyWbasyBzifPkU+7dPynG0PD3pMfLvjC36iscm7sRXqLapzsitHkWW?=
 =?us-ascii?Q?bbInQJmvECKooOcJmgeeVZgNUv5RvPTmqevq6rOkQ6JIVs8POSSLTJ5uUcNr?=
 =?us-ascii?Q?e7KgD1OAuiBBmLYJ7450/aSaRi1zxk/H7jVvWUOWuW5hY5zxgPz6zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNv68mM4tEb+kiFd/QIPTx78ogoNHnZ03I8ubiVSXs9dflqMBOMCGaJ1+CMH?=
 =?us-ascii?Q?/2R2M9E4J+gy37S/IDJd8EHXJkNWejB28WPNP6HnHH+ENn5ubV41wKzYpteD?=
 =?us-ascii?Q?/6IwuzTpvFy3nHqXuCty3gH2dLIH5YQOW1FhZ+tCOcPlGRtyZcLVg2w5XXj1?=
 =?us-ascii?Q?ySQ4s0dL9P1AIQ0qox/Qbd5356ta+QZpoKmn0B2zWBJ8QAxpdtg4vfI++cBv?=
 =?us-ascii?Q?5oGb21JLOlpOZ83s2O+8hsnB2lVneLIyGOo5HYo19RCvzdMYkFs0BZRmkY1O?=
 =?us-ascii?Q?3cc0FjYd3ADj8qZFYczKSNiA4wJ9i2ArbO01jLYcPmo9J+c4b/ZD/vRYAfMz?=
 =?us-ascii?Q?M4YpLW1K2icXPVQj1lhaGkgUXVmEdfXlpsXcE8iJgHqEIbn7VsLeR68RijYZ?=
 =?us-ascii?Q?cQ6TJqdWxL+JEJWbYC1vSnuI84zGjEXkLYZomUTauPiaqJOqQDMneBhs4GXn?=
 =?us-ascii?Q?X2X+wazAwV1P0uTQcGYKCqPHs+1cGzboRaqGuLFQLLMGIxGNSv1HkeiNrKz3?=
 =?us-ascii?Q?QPjx6I77RSHu4VaIrscJdTq2GsYYjGgy1VNb+VK81a4zOjbuUPUDj7Ft4euX?=
 =?us-ascii?Q?MCS8bV+jdUFCzZPXN+jg61NPwc/Xd3ETONZ8K1pQ7qEz1mAq7lPEjizs1oH3?=
 =?us-ascii?Q?Zq/NfX7t3DoHn2RTymX9MwXc1PZpASJDNBbi3X7bZLx8NPtTLFLEtK5loQgi?=
 =?us-ascii?Q?9GWRL4pdzGimIS396Nfzf4dqnIYCVgsoq/cVUISaT3WSZkOnhNPauKP8gmPZ?=
 =?us-ascii?Q?ZszRU3lNyYJHYvXFt6DMxtX5OJrhI9dwPK9bnvGUnCh3jpRjpvrRxFI0b6CR?=
 =?us-ascii?Q?DEmNT+t/O9Z65q7MRkg1vzxheMI7V+tPX08XTIimJK9yXWXHdy8Q2hrNKxaf?=
 =?us-ascii?Q?htIjIzbHhG1tyzOuDDWfvDepRcOHVoExWvwG2B3TA6NUTvM7q1MbsYoB0Mp5?=
 =?us-ascii?Q?r0fKDli+VJvbFukbZqmXhe6hfZZB6npsRhgFWycrDOCV+8rdXPIWNPRm4lvP?=
 =?us-ascii?Q?kLBXCWBz5LLPE3S7xPcafo40AZomHd2/cFg59VtxdB5jgATvWQSiU+zIIR0U?=
 =?us-ascii?Q?cDxP8EyMz8ND8wJebXxtcdBDU8EnhAG8/4sB4/vz9U1rQl5CWbnM4vAdj2ZM?=
 =?us-ascii?Q?8tNIdTlYVmImyHUrDjn2n6bvBECFX/f5W6G1AAYt9a7wmpnI0BzlwiIH0PJx?=
 =?us-ascii?Q?XLhzihQp4IPSTPQOkYQvF/OnD71pjy0jFC/oGqgxFyrEvcFKt/Ps+hfQ6XMj?=
 =?us-ascii?Q?LOMQfiiVt2ouKikStlvE9prDhceEaDjlRf9vmj6yy47gyxEvEqOw8f9Sb8iu?=
 =?us-ascii?Q?OwdvRUW5cltsyYvfRHiF8Roe6akIx6AG6yQ4OrzLBxotrnb5vWG9VrF9dBP2?=
 =?us-ascii?Q?DFo6s29EhLZ53uWC7CXd3fupgKeSmVqCs6cocnnInV9duWD0TlVcnDegG208?=
 =?us-ascii?Q?L0Owf11+xqIQB9i9yG7MAn5AXaz73e/nezu3YlWsJpm2aZZpcBIC8eiFP1qO?=
 =?us-ascii?Q?R+IMTvW2h2yaeglY/qhHG+t3C3eUHnNuMvZY93pdZIWcmjR9mtL47vuoSlDe?=
 =?us-ascii?Q?pj7GIREpOHG2JODE6t5EmdGcY/OF79whhXRwn9WM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a178c90c-7630-4eb2-a746-08ddad0080b2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:23.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVV0ZK2Qjh9+MZejjAwyz6HCk4qfCQfDXt8wCPdVwSLJACwacVfxAxBQge/rBGGk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805

This is used by x86 CPUs and can be used in AMD/VT-D x86 IOMMUs. When a
x86 IOMMU is running SVA it is using this page table format.

This implementation follows the AMD v2 io-pgtable version.

There is nothing remarkable here, the format can have 4 or 5 levels and
limited support for different page sizes. No contiguous pages support.

x86 uses a sign extension mechanism where the top bits of the VA must
match the sign bit. The core code supports this through
PT_FEAT_SIGN_EXTEND which creates and upper and lower VA range. All the
new operations will work correctly in both spaces, however currently there
is no way to report the upper space to other layers. Future patches can
improve that.

In principle this can support 3 page tables levels matching the 32 bit PAE
table format, but no iommu driver needs this. The focus is on the modern
64 bit 4 and 5 level formats.

Comparing the performance of several operations to the existing version:

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     71,61    ,      66,58      , -13.13
     2^21,     66,60    ,      61,55      , -10.10
     2^30,     59,56    ,      56,54      ,  -3.03
 256*2^12,    392,1360  ,     345,1289    ,  73.73
 256*2^21,    383,1159  ,     335,1145    ,  70.70
 256*2^30,    378,965   ,     331,892     ,  62.62

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     77,71    ,      73,68      ,  -7.07
     2^21,     76,70    ,      70,66      ,  -6.06
     2^30,     69,66    ,      66,63      ,  -4.04
 256*2^12,    225,899   ,     210,870     ,  75.75
 256*2^21,    262,722   ,     248,710     ,  65.65
 256*2^30,    251,643   ,     244,634     ,  61.61

The small -ve values in the iommu_unmap() are due to the core code calling
iommu_pgsize() before invoking the domain op. This is unncessary with this
implementation. Future work optimizes this and gets to 2%, 4%, 3%.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/.kunitconfig       |   1 +
 drivers/iommu/generic_pt/Kconfig            |  12 +
 drivers/iommu/generic_pt/fmt/Makefile       |   2 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c |  11 +
 drivers/iommu/generic_pt/fmt/x86_64.h       | 248 ++++++++++++++++++++
 include/linux/generic_pt/common.h           |  13 +
 include/linux/generic_pt/iommu.h            |  11 +
 8 files changed, 319 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h

diff --git a/drivers/iommu/generic_pt/.kunitconfig b/drivers/iommu/generic_pt/.kunitconfig
index 936c327f0661cf..2016c5e5ac0fe9 100644
--- a/drivers/iommu/generic_pt/.kunitconfig
+++ b/drivers/iommu/generic_pt/.kunitconfig
@@ -3,6 +3,7 @@ CONFIG_GENERIC_PT=y
 CONFIG_DEBUG_GENERIC_PT=y
 CONFIG_IOMMU_PT=y
 CONFIG_IOMMU_PT_AMDV1=y
+CONFIG_IOMMU_PT_X86_64=y
 CONFIG_IOMMU_PT_KUNIT_TEST=y
 
 CONFIG_IOMMUFD=y
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 835aab50dde374..f3a851f2804b88 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -45,10 +45,22 @@ config IOMMU_PT_AMDV1
 
 	  Selected automatically by an IOMMU driver that uses this format.
 
+config IOMMU_PT_X86_64
+       tristate "IOMMU page table for x86 64 bit, 4/5 levels"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	default n
+	help
+	  iommu_domain implementation for the x86 64 bit 4/5 level page table.
+	  It supports 4K/2M/1G page sizes and can decode a sign extended
+	  portion of the 64 bit IOVA space.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+
 config IOMMU_PT_KUNIT_TEST
 	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
+	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
 	default KUNIT_ALL_TESTS
 	help
 	  Enable kunit tests for GENERIC_PT and IOMMU_PT that covers all the
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index f0c22cf5f7bee6..5a3379107999f5 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -3,6 +3,8 @@
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
 iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_X86_64) += x86_64
+
 IOMMU_PT_KUNIT_TEST :=
 define create_format
 obj-$(2) += iommu_$(1).o
diff --git a/drivers/iommu/generic_pt/fmt/defs_x86_64.h b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
new file mode 100644
index 00000000000000..6f589e1f55d35a
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ */
+#ifndef __GENERIC_PT_FMT_DEFS_X86_64_H
+#define __GENERIC_PT_FMT_DEFS_X86_64_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct x86_64_pt_write_attrs {
+	u64 descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs x86_64_pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_x86_64.c b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
new file mode 100644
index 00000000000000..5c5960d871a32f
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define PT_FMT x86_64
+#define PT_SUPPORTED_FEATURES                                  \
+	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
+	 BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) |                    \
+	 BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+
+#include "iommu_template.h"
diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
new file mode 100644
index 00000000000000..c01815b6229cce
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * x86 page table. Supports the 4 and 5 level variations.
+ *
+ * The 4 and 5 level version is described in:
+ *   Section "4.4 4-Level Paging and 5-Level Paging" of the Intel Software
+ *   Developer's Manual Volume 3
+ *
+ *   Section "9.7 First-Stage Paging Entries" of the "Intel Virtualization
+ *   Technology for Directed I/O Architecture Specification"
+ *
+ *   Section "2.2.6 I/O Page Tables for Guest Translations" of the "AMD I/O
+ *   Virtualization Technology (IOMMU) Specification"
+ *
+ * It is used by x86 CPUs, AMD and VT-D IOMMU HW.
+ *
+ * Note the 3 level format is very similar and almost implemented here. The
+ * reserved/ignored layout is different and there are functional bit
+ * differences.
+ *
+ * This format uses PT_FEAT_SIGN_EXTEND to have a upper/non-canonical/lower
+ * split. PT_FEAT_SIGN_EXTEND is optional as AMD IOMMU sometimes uses non-sign
+ * extended addressing with this page table format.
+ *
+ * The named levels in the spec map to the pts->level as:
+ *   Table/PTE - 0
+ *   Directory/PDE - 1
+ *   Directory Ptr/PDPTE - 2
+ *   PML4/PML4E - 3
+ *   PML5/PML5E - 4
+ */
+#ifndef __GENERIC_PT_FMT_X86_64_H
+#define __GENERIC_PT_FMT_X86_64_H
+
+#include "defs_x86_64.h"
+#include "../pt_defs.h"
+
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/log2.h>
+#include <linux/mem_encrypt.h>
+
+enum {
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
+	PT_MAX_VA_ADDRESS_LG2 = 57,
+	PT_ITEM_WORD_SIZE = sizeof(u64),
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 12,
+	PT_TABLEMEM_LG2SZ = 12,
+
+	/*
+	 * For AMD the GCR3 Base only has these bits. For VT-D FSPTPTR is 4k
+	 * aligned and is limited by the architected HAW
+	 */
+	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
+};
+
+/* Shared descriptor bits */
+enum {
+	X86_64_FMT_P = BIT(0),
+	X86_64_FMT_RW = BIT(1),
+	X86_64_FMT_U = BIT(2),
+	X86_64_FMT_A = BIT(5),
+	X86_64_FMT_D = BIT(6),
+	X86_64_FMT_OA = GENMASK_ULL(51, 12),
+	X86_64_FMT_XD = BIT_ULL(63),
+};
+
+/* PDPTE/PDE */
+enum {
+	X86_64_FMT_PS = BIT(7),
+};
+
+#define common_to_x86_64_pt(common_ptr) \
+	container_of_const(common_ptr, struct pt_x86_64, common)
+#define to_x86_64_pt(pts) common_to_x86_64_pt((pts)->range->common)
+
+static inline pt_oaddr_t x86_64_pt_table_pa(const struct pt_state *pts)
+{
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
+			  PT_TABLEMEM_LG2SZ);
+}
+#define pt_table_pa x86_64_pt_table_pa
+
+static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
+{
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
+			  PT_GRANULE_LG2SZ);
+}
+#define pt_entry_oa x86_64_pt_entry_oa
+
+static inline bool x86_64_pt_can_have_leaf(const struct pt_state *pts)
+{
+	return pts->level <= 2;
+}
+#define pt_can_have_leaf x86_64_pt_can_have_leaf
+
+static inline unsigned int x86_64_pt_num_items_lg2(const struct pt_state *pts)
+{
+	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
+}
+#define pt_num_items_lg2 x86_64_pt_num_items_lg2
+
+static inline enum pt_entry_type x86_64_pt_load_entry_raw(struct pt_state *pts)
+{
+	const u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	pts->entry = entry = READ_ONCE(tablep[pts->index]);
+	if (!(entry & X86_64_FMT_P))
+		return PT_ENTRY_EMPTY;
+	if (pts->level == 0 ||
+	    (x86_64_pt_can_have_leaf(pts) && (entry & X86_64_FMT_PS)))
+		return PT_ENTRY_OA;
+	return PT_ENTRY_TABLE;
+}
+#define pt_load_entry_raw x86_64_pt_load_entry_raw
+
+static inline void
+x86_64_pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			     unsigned int oasz_lg2,
+			     const struct pt_write_attrs *attrs)
+{
+	u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	entry = X86_64_FMT_P |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(oa, PT_GRANULE_LG2SZ)) |
+		attrs->descriptor_bits;
+	if (pts->level != 0)
+		entry |= X86_64_FMT_PS;
+
+	WRITE_ONCE(tablep[pts->index], entry);
+	pts->entry = entry;
+}
+#define pt_install_leaf_entry x86_64_pt_install_leaf_entry
+
+static inline bool x86_64_pt_install_table(struct pt_state *pts,
+					   pt_oaddr_t table_pa,
+					   const struct pt_write_attrs *attrs)
+{
+	u64 entry;
+
+	entry = X86_64_FMT_P | X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(table_pa, PT_GRANULE_LG2SZ));
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_set(entry);
+	return pt_table_install64(pts, entry);
+}
+#define pt_install_table x86_64_pt_install_table
+
+static inline void x86_64_pt_attr_from_entry(const struct pt_state *pts,
+					     struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits = pts->entry &
+				 (X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+				  X86_64_FMT_D | X86_64_FMT_XD);
+}
+#define pt_attr_from_entry x86_64_pt_attr_from_entry
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_x86_64
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_table, iommu)
+			->x86_64_pt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_table, x86_64_pt.common)
+			->iommu;
+}
+
+static inline int x86_64_pt_iommu_set_prot(struct pt_common *common,
+					   struct pt_write_attrs *attrs,
+					   unsigned int iommu_prot)
+{
+	u64 pte;
+
+	pte = X86_64_FMT_U | X86_64_FMT_A | X86_64_FMT_D;
+	if (iommu_prot & IOMMU_WRITE)
+		pte |= X86_64_FMT_RW;
+
+	/*
+	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
+	 * control this. For now if the tables use sme_set then so do the ptes.
+	 */
+	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		pte = __sme_set(pte);
+
+	attrs->descriptor_bits = pte;
+	return 0;
+}
+#define pt_iommu_set_prot x86_64_pt_iommu_set_prot
+
+static inline int
+x86_64_pt_iommu_fmt_init(struct pt_iommu_x86_64 *iommu_table,
+			 const struct pt_iommu_x86_64_cfg *cfg)
+{
+	struct pt_x86_64 *table = &iommu_table->x86_64_pt;
+
+	if (cfg->common.hw_max_vasz_lg2 < 31 ||
+	    cfg->common.hw_max_vasz_lg2 > 57)
+		return -EINVAL;
+
+	/* Top of 2, 3, 4 */
+	pt_top_set_level(&table->common,
+			 (cfg->common.hw_max_vasz_lg2 - 31) / 9 + 2);
+
+	table->common.max_oasz_lg2 =
+		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
+	return 0;
+}
+#define pt_iommu_fmt_init x86_64_pt_iommu_fmt_init
+
+static inline void
+x86_64_pt_iommu_fmt_hw_info(struct pt_iommu_x86_64 *table,
+			    const struct pt_range *top_range,
+			    struct pt_iommu_x86_64_hw_info *info)
+{
+	info->gcr3_pt = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(info->gcr3_pt & ~PT_TOP_PHYS_MASK);
+	info->levels = top_range->top_level + 1;
+}
+#define pt_iommu_fmt_hw_info x86_64_pt_iommu_fmt_hw_info
+
+#if defined(GENERIC_PT_KUNIT)
+static const struct pt_iommu_x86_64_cfg x86_64_kunit_fmt_cfgs[] = {
+	[0] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND),
+		.common.hw_max_vasz_lg2 = 48 },
+	[1] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND),
+		.common.hw_max_vasz_lg2 = 57 },
+	/* AMD IOMMU PASID 0 formats with no SIGN_EXTEND */
+	[2] = { .common.hw_max_vasz_lg2 = 47 },
+	[3] = { .common.hw_max_vasz_lg2 = 56 },
+};
+#define kunit_fmt_cfgs x86_64_kunit_fmt_cfgs
+enum { KUNIT_FMT_FEATURES =  BIT(PT_FEAT_SIGN_EXTEND)};
+#endif
+#endif
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index b127d8915d48fc..d14919f94a9448 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -150,4 +150,17 @@ enum {
 	PT_FEAT_AMDV1_FORCE_COHERENCE,
 };
 
+struct pt_x86_64 {
+	struct pt_common common;
+};
+
+enum {
+	/*
+	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
+	 * the page table pointers in the tree. This only works with
+	 * CONFIG_AMD_MEM_ENCRYPT.
+	 */
+	PT_FEAT_X86_64_AMD_ENCRYPT_TABLES = PT_FEAT_FMT_START,
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 58c9fa74fb0701..61fb398377e90e 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -254,6 +254,17 @@ IOMMU_FORMAT(amdv1, amdpt);
 struct pt_iommu_amdv1_mock_hw_info;
 IOMMU_PROTOTYPES(amdv1_mock);
 
+struct pt_iommu_x86_64_cfg {
+	struct pt_iommu_cfg common;
+};
+
+struct pt_iommu_x86_64_hw_info {
+	u64 gcr3_pt;
+	u8 levels;
+};
+
+IOMMU_FORMAT(x86_64, x86_64_pt);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


