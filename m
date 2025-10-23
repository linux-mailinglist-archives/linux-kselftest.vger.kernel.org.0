Return-Path: <linux-kselftest+bounces-43938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B4C02E2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2AD94F5AC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE602749C7;
	Thu, 23 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDVElLML"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61E273D83;
	Thu, 23 Oct 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243675; cv=fail; b=MN5+SWkahUoPkN1e7PK8MO2NVLPo+gN2EBw2ScMOCClt/iJG4tQUswWyifxB2eu/8gNjckcRj+4OVrGm9CTZCTeYxNtmEvsbM0Y8man48acXtaqughukKUE/+u9AR7U9X4e7Hx/pkOWk4XzvCs17j0FMLfiXR/5t0gfPpHyUoac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243675; c=relaxed/simple;
	bh=CzIlTWDHZto6kUbIe/Om8zAfs3Xi+xbfiRr7CHlheJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uknkdhq804cyWFYjzulGzxzACFMonnftz7Cgyw2L5SJw+3qsa3lSgv2sq7Z862dxnLM4HC8LyhHQbSwgBnlb0D4F0DPOlRNqoupP172cbTzwJXtH/yNScTJ6cv1djVGEGIpN+Yl3C/ItBFNiEKByQEhMP+X9kpS2QYATP39//CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDVElLML; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgjRft6HpU3Z5cfVwnyUjQZPy4sR9JytP5eC79SsmeN2oLpjGLzqCjt82RwuoP+VPePDeK2deLVA2a1yV0D6DuaqhuWXUYDTJtlaKn/aky6t3uXXCSDyQ3otKYCjVzFRXytjBxLcp4v6fCgIYjZelcnrw7QEx+ihkqkGwi7t+eJGFLbSA0fNbdZ1sFwn5jBEvkUunl3D6zIbe2tPnbuH+fl8Ded3gNOKJWszm7oQHnqDbfq1THEcQcEi23YESAtEk8hzkfxlZ+h0W8T0IuGjbEtO6lXUg5OClE2TzqYYKYPUF7e0uBZEof2U0i2Dt/5b0OVaeb+bUnozDWRlaNeZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe8hkc31OIs4HFyFe8UBe3EBC09WWQnZyuiWvMe4Glc=;
 b=Bb45rZQHnyCBUX9bNmn97a58QS7z2L/euHzghpZaXoxoKlyVqSWeGdTzlUO6YvCYJkRebkE3XSxDkMtNc9PIAGmRf+c7y77yVIXMCTYwJLXIZToxyppE9uoBhTl/2W2zVxCSBTiKWD3cIXE3ora5cCUmCsYBMmjAeBK5drlPy2IYyXmqeDFzbT2/eHuL6AykdUScJDyABfDK5b1k3goHDeWEbY8SDBx5/ozfh9qyvyIH2h02/bITFZK61nW5sJJA0ekXwnptgRDEWFU/WlblAB3azyP5ki3sPEujMmMSG3e70+xchtJlyg/kadXTSl8f1kaYdcV6nqlBpGBpccjypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe8hkc31OIs4HFyFe8UBe3EBC09WWQnZyuiWvMe4Glc=;
 b=dDVElLML43nAQAWYowQHGcgHIQG2ZR7xmqp/FMwKvIUKG6U5BWFFo1sCklEXpQk/4jsm15zUoHEjiw8Bja5n6T2dTBbxDQV6lpLufHpByZBlJUTEYsh3lyZI9W7gVVe5E0g35JDa4+zyUSypV9Pt9Tey+wND7YjP1sgodHZD+tz7nuIfHBDegiAcgxHulPkDz1IjlM34ORfuvxtmJYMtKwktxYx0TYBycVMlI1PxKDeQ2443PHFOCK44lmPq4Vo0Kvk/4xrloixFs/yEAjdrKgGMvWshHgfypsGqUwgUq6OhE1q4mewxDuZstinCVIedseK162qAfTcZJByVW6fk2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 18:21:05 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:21:04 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v7 12/15] iommupt: Add the x86 64 bit page table format
Date: Thu, 23 Oct 2025 15:20:42 -0300
Message-ID: <12-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: b259fb20-4ede-4220-f740-08de1260e750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?378RI2uZVc2LPbReeqopoNnhMGWiAzVVxoIc+J5cTbQc5tjeyldaWvm0864X?=
 =?us-ascii?Q?ItBWOjGfO2uOYqg4AbfklOPF2v9KVoJkiZwlwPyt9ENXCvbVNuVI1f493umT?=
 =?us-ascii?Q?+iKKgOX4rAdxcFSnnFwQILNUoG4mWIaiLH4iCJLZW1DCVdkPLBaWHUI4pdz0?=
 =?us-ascii?Q?XjPLvb2lumHf52a8M/LVVSt9DYlzYpmk5ZC2AvcLbLF3RgS2fiRLQqHPjZvD?=
 =?us-ascii?Q?XwVKxkZr1YF/JnuXNDl9ht2eRyPU+D2CuGxWknmWIuyOJ+S9LsSCBFdwaEdJ?=
 =?us-ascii?Q?NE+LydiBa/mJ/UI8Zyj46PH4BSFiB7sN8uK9JLHDzzmZXqu/X59Qmo29tym8?=
 =?us-ascii?Q?9gSUK5l3lMjyGU5PBtSqEzIFXJA2+9BKtQawS8jNHMNanIhTwUAtm/AkPv4s?=
 =?us-ascii?Q?1zX6IYLzouYa8bq//qhqKtQwl7TWPA8YIiE6o6s1tKs432Uz3RrI84sT/MsI?=
 =?us-ascii?Q?owrVVwLATDr3XnCMmuz4NVXVg+VuJiYOG88+hY8uKzJOueXwpADkxJVlLBo9?=
 =?us-ascii?Q?lkCDqC0n2Q8Uu+tdSrgAwJBYg2lnavWZIsrkFMryCulzv3AzrwAIaaEBLARR?=
 =?us-ascii?Q?ZOGNNZho9SlWTp1DrPP6i8wwGyfDSRj5CUW/4vyfXbh7YX2Dt2jm+0o+eCOu?=
 =?us-ascii?Q?LbHVQC3gWz75NTZaa8+yZsIvSPY14prwAZs8nAH7N9XmbL6025L1UdzqgbpS?=
 =?us-ascii?Q?mLoJpR4h086PYfCA0UsMZfGCE8UXNUoVG33R9JoSy0lgYOxkVRfO/CLIj7jL?=
 =?us-ascii?Q?SpbWvNDddt+kxoy8SKRgTdjPZDYjEi/Wv1Psac+usbOVo3nBdD/XNpLOBdAN?=
 =?us-ascii?Q?/og3cDvUff1NWxdwmTfk1HnJ9/ZBh8YbVpvvmYbIBIkmmfKSFJ/vVydF3DYR?=
 =?us-ascii?Q?JkzhdeZFHZh9vTfa9bBqHXfWOvKAgDt4FA0FCDdCpsus/quJReklIaf82DX0?=
 =?us-ascii?Q?ktEGBGxzU7RcvVvhhk5e2+Dqn/tZ+UeqnpAH9v/NjIKDeiUkSBsxOPbs8esI?=
 =?us-ascii?Q?e9f2knaBLRYlmwTlSJILDfbgVNnsu25DyYV3DA4H3tLT/94ZN+Zs7VYfj2Tq?=
 =?us-ascii?Q?EcYRYNDt7IcHDghJegM/214W/T9Gos/6BJnduOpoJVu7Qdw9bzCOq0lQ2I/7?=
 =?us-ascii?Q?4b7cxeijOxNMRNsbQSWz6AZGanOLgaJvXW0Z9bDs2XmigwmmnEhy6p7xOAhT?=
 =?us-ascii?Q?poLCd4GCP3lyQtz7qGBEM1DyTDm3cTMIUH72ifz9GjmAs6LTyna8hxxl9ZnR?=
 =?us-ascii?Q?8H4DsJi1mAOMhkx3TlN4F1dp9TkbHOluxyWVJQ2GkbE1F2TRJ7G17gNjw6Oa?=
 =?us-ascii?Q?uRXaIF9j0ZOaIVs0OJ7lGKbTcewZQ9NWVVPV5VcZXieD3JO2KGSXA4JhwBor?=
 =?us-ascii?Q?4+5YBAZwsXL15ASjYufUa9i+Li1libizmYYSB3k3Pxza29lZbeezAJMlb65b?=
 =?us-ascii?Q?5bQQkuWJve0eYRFd2kKq2XOV0auStPAyM/0u+uKFcpc4w2XZhoefnlMeJU9V?=
 =?us-ascii?Q?k4ju0jxERJVF0e4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prp3iNGMKrgN/cgvjAWg6zx+ldQbW0PzhbTQJezSJ1f+nWnEwj8oURIGfs4Y?=
 =?us-ascii?Q?30FCUavEex6zvpAgYQ8cXVpB3ymjNR4Rv3FnGClTWoYTqMmGc9OFnVpLm2NV?=
 =?us-ascii?Q?StuMxVhcNReSQ1az8Kz23dhhDI22z6pYNGl8eBzx7++V1YCEtkgqfQeyzvM1?=
 =?us-ascii?Q?IBrtSOcr/sXBwqLHzsYuIGIsT3n6EViJVR2Vh+GCgWvvIgm8Hu+O44AZAJhD?=
 =?us-ascii?Q?yFy3FYMPZeV8DI+qWGbHJ+xQmwahitajIWhT2DIBhm/1KvzA35lN+FyaGjFj?=
 =?us-ascii?Q?ZtDn1RrlSpx+Ppz52WOONC/EPzxYcD1qnkCVh7ChVYaYgeh9iLjFXoVp4KHN?=
 =?us-ascii?Q?rpFhb2AoaFbjyIh5lFNKvPDiMKKJNSjz/ihq9Cs1+rqteH6qg9PiEhWIPXEI?=
 =?us-ascii?Q?o2orvUql2/r/zm3cSctGRxhQllkiidzYgfvLKYWOKyfdI5JsRZ7NNGFsJJP2?=
 =?us-ascii?Q?dGTJLVLewqMfSwOkik1TczAyUNfPhUCy6/3pPDoX6dfaZq/yF2rcE6VcCbIH?=
 =?us-ascii?Q?TCxnJB3OkSPp3aBNr8a3cC5cEueenOWdX3TFUCmHSEb9AD7AX4+TOHqwzh9j?=
 =?us-ascii?Q?hcL3OlY62S7urfaUFYJ5MeBoEcHplRv33GxcNeVJosB45r2PUccvx6kuYzuR?=
 =?us-ascii?Q?Mernxo5XfJneQ3Tu3NAQ/ymURIDCStp4aMq6inoKILYcPmKHT5OryP1ihYP2?=
 =?us-ascii?Q?vH5TWN85VYLZozBdm9v2KX3Q84IEPAGpN8V4mQhMvjYKewE5eMK6svCAnHyb?=
 =?us-ascii?Q?T3vs19o4IzEM5O/SFy4wUqSmoCIVPLbsp1qGpSw+mcotjAXy5aaZlubI7p8A?=
 =?us-ascii?Q?zO7nttK9oIeexM4yJoivL3z1K4M6KXaGIMHzUxUSv9ndChbLb7y1b4KzivMp?=
 =?us-ascii?Q?CkIXAsr12MUKlgloZx3DvlSQMuhtRrsm9OhojOtoNg+reH1v//JEW8yMjyrE?=
 =?us-ascii?Q?l3QihpgGpvSq3CShDYt1ncvxxnv2aT6OsJXL/JrfPMQyduUtevUw4W10Fj8W?=
 =?us-ascii?Q?S/CvVeIhxnpPm3T7Wy++bvPY5wYr6NX4tEM88yqLcxEkc0/XS88wAg53yvMD?=
 =?us-ascii?Q?u6ibATEJK8u7HjYA2ZnIchTnLgp3K8MRear3FcO20fvLHj3evFoymY2sXGLV?=
 =?us-ascii?Q?zONyTdNA2jOmAJ5WnJ/5YTfVZPawoy/2rvFDVikuxZ18KHAHX5rNJEPat5Yb?=
 =?us-ascii?Q?0LeAenQMkWAMbAcpjaY8sX3VEkU/IBXvN6cNXW7/PHIRT3hhQxFZVFUQH1ML?=
 =?us-ascii?Q?DZOU4gj+M9b/gLc8levqIud7ekrJ3gc8K8hT5x87VnCstfCfv1mIoYz3FeT0?=
 =?us-ascii?Q?VSoYmCiP6OOmZOCI8w/BE3cWMiLL0d72Uo36Lbtk5LBdKh7jsc0zNY4UDaMX?=
 =?us-ascii?Q?Z91FvHrc9CfD0z2O0+B75Ofo18vL1suKm4X7lmnA+HGfUSm4RfpSFOw4B89a?=
 =?us-ascii?Q?NaRdFR6wIcjUGH78Ek6hnMVzgSIsy73q6r5N3V8wJGNoDWD6I/Zlg4QRBN9s?=
 =?us-ascii?Q?0CfcwoV1QtXy6B6YaTkDBh2/bfwqq6njNf/PTPXzQAY7w9tT5OSYJlR51ATE?=
 =?us-ascii?Q?t06oZ86SCqhdC01fuoMeA+abXY9FAgM1zkFdT5Kn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b259fb20-4ede-4220-f740-08de1260e750
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:54.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7N26TJ6vZE0mgXPC5jq371MZPxDoW8uKrAfqM5EkCeVM373wgLxprmgR+Zgif+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164

This is used by x86 CPUs and can be used in AMD/VT-d x86 IOMMUs. When a
x86 IOMMU is running SVA the MM will be using this format.

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/.kunitconfig       |   1 +
 drivers/iommu/generic_pt/Kconfig            |  11 +
 drivers/iommu/generic_pt/fmt/Makefile       |   2 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c |  11 +
 drivers/iommu/generic_pt/fmt/x86_64.h       | 259 ++++++++++++++++++++
 include/linux/generic_pt/common.h           |  13 +
 include/linux/generic_pt/iommu.h            |  11 +
 8 files changed, 329 insertions(+)
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
index 81652cd9c69fe8..6dcb771b3c582a 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -42,10 +42,21 @@ config IOMMU_PT_AMDV1
 
 	  Selected automatically by an IOMMU driver that uses this format.
 
+config IOMMU_PT_X86_64
+	tristate "IOMMU page table for x86 64-bit, 4/5 levels"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	help
+	  iommu_domain implementation for the x86 64-bit 4/5 level page table.
+	  It supports 4K/2M/1G page sizes and can decode a sign-extended
+	  portion of the 64-bit IOVA space.
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
index 00000000000000..8727e74ab4804d
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -0,0 +1,259 @@
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
+ * It is used by x86 CPUs, AMD and VT-d IOMMU HW.
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
+	 * For AMD the GCR3 Base only has these bits. For VT-d FSPTPTR is 4k
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
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
+			  PT_TABLEMEM_LG2SZ);
+}
+#define pt_table_pa x86_64_pt_table_pa
+
+static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
+{
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
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
+	if (!pt_check_install_leaf_args(pts, oa, oasz_lg2))
+		return;
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
index 21e33489cbf20d..96f8a6a7d60e10 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -151,4 +151,17 @@ enum {
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
index f2a763aba08846..fde7ccf007c50c 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -255,6 +255,17 @@ IOMMU_FORMAT(amdv1, amdpt);
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


