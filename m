Return-Path: <linux-kselftest+bounces-9309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F58BA57B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B796F1C22057
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189AD1BF2A;
	Fri,  3 May 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l4pKjKO2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E343117C66;
	Fri,  3 May 2024 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705346; cv=fail; b=EOZ53BGuL6/87Ji7Y94N4vfAAjwl74qPwMn3EzNLELmNsXHrvv9vih7oU/wMCjcYr4hTmf5JMxfQUCvQ8YkuNQ4g1l80gnyXJ4gdYeb+pd46wYi9/gjB+6ZTjBsJy/f9qSaNt33r1tLKkssQt4koibY+b0XcA/Ngd5VSDA9HNGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705346; c=relaxed/simple;
	bh=EcilZbHOUxZUt2uzG3KUp+Oqnl0D6CdhLInHAwGhDEo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=emyaaxzY+wJE6MjfB9pqBBfmnUbYW1/1xgjMty58ag3zXIUqExD61kfko/GVMsO945GS9+9+W+3cPhOzu+uq3dzSglC/pI1gmPEdXJR2Knnof1OtdOpguTFKwrNGm/sGjSfZFW3oM0spmaVD025gZiNr4g17l/s095aB62f4B/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l4pKjKO2; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+4botJ+9AXNZpVm5PZGkVC6wTuArzSuX6IxGr/iXiRszdlrO1w++ixaXmB7p0WdXFp378JebgbtFev5sX/6ogLL9fGiYRFKWNmvISU58MYyez4q0L5FX2Ua4p30zConXRSAa/BPiwDfSLmf3u/Lt74kHhdsuvo6/oV5Ns/jVIy25flVDv2ahCiUvSNUNgQZPpdXiYiv2khL6NucCAsCyThZPT6tzpQyk3riq3MqVxy/EmpdfQBk5XHSfoF93u2VgdOF4qbs2dI3U9qqz4lT3KA4IMd44NSqe0cF34P/Qra2Td+dmFvqp0KNaXlEFI4+cSA8JaFvTZpxPlI/Orvhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCPp0AH97sb08pxql46P4dudrUaFEhhFGKmsZYyvLMM=;
 b=ET3eOSDUCp6rSLjxfz+boaiLihYCT0RRkVpHJ+Ra+zLOs6F0VcgyOjeudi9EEMkfl6lPpTeDqB83OOrgV8UytU/vf5DHUV6gB5nbk1zLotIki3x4xq0ubYMgK+gSDsN0qgdQA6vzcQ5NWBtreu1aSQfa7KxFI/AvAa7scBBgigvrvPuogNP/NbAJwJWT49s3xhfRuZUSF8t5oy9M2d4v2rzp+YhIQu5L55mcFpr9x8WhCnU0k5AEjSILhALbhkeRTlfu9IsuyrL9uae6foDb7Nx+WWrwJkGQ+EphmQoB91NLF3NTTUvNxBTf5fB/x3OLYRHU85bhOnxLljowxoftPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCPp0AH97sb08pxql46P4dudrUaFEhhFGKmsZYyvLMM=;
 b=l4pKjKO2EEFcPUvTK9j9f6G1gMUelm6cdXjdL/1UgHkYaG6uJ6yZfrsgFApAsbvgqqzbgDmC0HRSTzZpQGyT5U22Ekp+7lkXvBZNuAKYLAGPniJfdZgLl1qYJuTzWL+4+LtzO1DECMkO7NN+drZXIK9MHeIsSz7mMbrO1jfpO6lpuRNwME7V9nOL7rr/EO7DycjjDJ70Z0VKWZ7l8TvZL9EvYdjXShgKYkb7Xd8EzppG8RXGIRYgk+uaXcRTrUWxIIOKViGny7jR8FBlUuWMtyns4UBSREHm08x9iWj4aqrEcLVphnKaD1kvRe++gsRZXOD1YdjobJT77Ketjdxmzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:02:16 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:02:16 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/7] selftests/x86: fix build errors and warnings found via clang
Date: Thu,  2 May 2024 20:02:07 -0700
Message-ID: <20240503030214.86681-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: eb379dc3-9a14-4508-437c-08dc6b1d7071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Hytt919sBQT1n//ACZBmRN1IJdnvTZ+NUvu6JcoKJp4ikIC242xIyLc11Ha?=
 =?us-ascii?Q?mBRp3Dv7C2wLOEOzpmTORD2N8CmLtHWuwM3nM/yZvuzwzjJGITPgUqKoqmEC?=
 =?us-ascii?Q?zrysv+3g8yVrvJC/PbhkibmlOYh0IfOCNbUhXtgTAyV9wLNYCtmFquu54CxI?=
 =?us-ascii?Q?nFblUrC/7AESLejl1waGYFKvMwcsP4yhcU1U+0ylh0FUrt2QKj6DdLBfsACw?=
 =?us-ascii?Q?h+BelUxcjXWbgKRNJP0TMGziqBUssZpfwZmrLjJnkZgypNkF1uwf+TAmSgRU?=
 =?us-ascii?Q?aecDkrjf9LvJKEnGeuR2+dC9xO9/bfih1QSkUUkrowLArH3N628th/G+M5Mw?=
 =?us-ascii?Q?2R9tO9lYEenbaxVbI/7tkYSfud8pS37zX7L2G2CD20SDvQppBfjQZqW5plmn?=
 =?us-ascii?Q?6DgBhZ5APTrzml6raUrnysKASdS9KkuSSWgiYH7pBSmEx/cRFHiIXgvDm8MW?=
 =?us-ascii?Q?wruuvAsEbbsOjRIBXI65TVXuascNCTNnE78gvgpCrsyiqTBkzAX32GIC/u5o?=
 =?us-ascii?Q?ce3WKTXavPihqZHFGJhMfYDVByIuYJ18b5j0BiygBLlgmidG+7JBbOYtnxq7?=
 =?us-ascii?Q?8mXTQwZ6iRvwlO3fRxCHf7QQU9jMsivlSI+dKxGtKNrnbiwCFk5z2kutdsNj?=
 =?us-ascii?Q?EXb34E6j/hT8YnQsVer+HmQk0Bgqijjg5lMDucbv42wpZR4Wk7QaUTF5KVqs?=
 =?us-ascii?Q?+Ygc7szTM5DQlKWiPaJHNb7gDp7rWYPD7qA0UNSiadfb6IawwsHVjFp8uwjM?=
 =?us-ascii?Q?OzhH+6fHFlOkykzRqGjMDl43+yyYECKMxabsUlLMRpNMdSoyW13zviwOezu1?=
 =?us-ascii?Q?1736TAl/pZe6kQ+Uom4TSH/eliErEVfJYH215OAgc8oeCfUvzkTpQaBh+VsC?=
 =?us-ascii?Q?N5EpdkDEemXf81XpbaQ2w7WSB2lbaLN47WUaXKmejwOokh3FF4yzx4GK89Bu?=
 =?us-ascii?Q?JTk4BkVgT5ysSs9XGjZkk+4ytoyA6d81UFfyM3w3cf0IES6vqgr4NxbaWc1f?=
 =?us-ascii?Q?/R2S0UJvOzroJ0qrVHLvPqYcA7pRltKr+uJybZH1DMiQpiO885rBBBGZOjhQ?=
 =?us-ascii?Q?ScVuM8A5/ER8y8cq+lIgq9VgZcPTAnBmPdGGBMz1bL3UzHX8dLGUdJ43n2jV?=
 =?us-ascii?Q?lzrGCiVX3f5pnlHZoYPYfR6/miGVP7X9DTZD0rNmEVHd6OQKO1qnYW8yjRWa?=
 =?us-ascii?Q?3izldFlokl1utma5Ft9jLgmflwW/09UPuvJliBG60AhIo61PRlwba/7nl6Uo?=
 =?us-ascii?Q?fE2LwjF78oOjhQDZXJ4D/9B6ZweBIPxEMHg3GhN7qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFi27EFDskmwlKKewR034T1ebnvLF7rlD5ecQLqx+3Cgwtm67xpR2ViIL0rb?=
 =?us-ascii?Q?MRQZ1L6uyQi+sK8vKmTF897Sti2FI7t+1q/TEYUjwVIFrXT0p/OlufsTQhK0?=
 =?us-ascii?Q?YUSE4edBBcD8tOLGRynM2RXSDrdmyvAtbyr5xi5kbREfFKTUAUlLq5gRD1Qa?=
 =?us-ascii?Q?p61iUyN1QiGq/2aWdhkvp+/SzH4GCS0ao+f4WFxwdzcfq8k5e9W+HXdfsF+W?=
 =?us-ascii?Q?1ku8aotqCa58iLiqXfmhohhCr4NhgGfE8cmlAIzjhqYjVy11QbUV7UkUy2HJ?=
 =?us-ascii?Q?LicZVtXWhiPWnJ/VWLFzedOwdbMSfmkQ2gJwIaoQjWjk/1bBUg0ehGOUCXNm?=
 =?us-ascii?Q?CFyH9cjJwGRiEGgcpyNfJ8XN1aTwFjpRo/2QDzHImKTHJTNhkcf0xQrsrJBX?=
 =?us-ascii?Q?OKk3O6ArsHAPfE1POkRF1DY8YWMn1L7u+ggQyzqbgMaCpITc15mwJ6TYjaZ5?=
 =?us-ascii?Q?e6at/jdDvjxJ3yjq2SC7DsDEflPXdYDK8JoyHUM+Sh+cwSh4LibB5AJeN++e?=
 =?us-ascii?Q?h52z+68yAsbyJaZHKRl6ctFK1telbpzeF4IoGG1/fGThVueMJtf7HxCob7e0?=
 =?us-ascii?Q?khFDjtTlv4hQ69UeodfGp0OuPFqt70BklSG79YV00TskKG1eBoS5qduOYEJ4?=
 =?us-ascii?Q?LLp7fleu+3Fr2WnRDLBCMlvv/O/caESWeh+D8BVh+39IJgDPqIEx3pWkyhY1?=
 =?us-ascii?Q?X3Yz+voMGjYmZyJrtO/BF8XmZzx8Uyffo83dxyOR3skUgsU/CA4LHUU18qzA?=
 =?us-ascii?Q?Dtc6UQ9nAQecT+zawlI0FRP1r9Ieja18dJPQ/AHK1C7j9UvxfA1ZvBqD3um3?=
 =?us-ascii?Q?kT1505PKRgOJtZBZjXIDrSV6BP4NlIKoW4CA1UFd6PD3bkAHFineyghbt7Xc?=
 =?us-ascii?Q?AXhbe1M8JFeZrzOvkXBblRGwjyvUNAP45Rbo7vTyzPzU58nqHP5LHWuizA1k?=
 =?us-ascii?Q?/dWVTi6LJttyEd1nAqlJgYdED2V9UBecoCF3vZ8i5M4De2cnez6tQDX03ATN?=
 =?us-ascii?Q?z21goBBEREIVRFZlpjXlTiqwyeWMB8sh2imn8JnPDfhwKt5zB0WtjWbO3382?=
 =?us-ascii?Q?Fv6iaatFsIyKdMExS5j4HSGE6sqO9PzpC1uwFj5R8oWa+fn4fK+j3+6Wbfh3?=
 =?us-ascii?Q?SUeqgzznvK6Jc4aVdnAC4uG8HfdjPlwLuP230JOld8uE1XLfP8dijlj7CxCj?=
 =?us-ascii?Q?kk2rHmmpJFK0O2kBWsssclSBk20AkSOeQ5PNqbEnVbJSNJLJ10Kf9DdBTPGc?=
 =?us-ascii?Q?+4mSHcs7hSdPzyhmD2J4NqsCjIMfdVsqMQUwi8lCa+fnZ7e+PBGw5J8QXggM?=
 =?us-ascii?Q?QvQ+d4U0syUrOQ7pOyY8EtiMNLlLvzzEsSRJRdOK20PYn+5Rqn9dpAfzun2v?=
 =?us-ascii?Q?PpptNoZvL1ih28NRJqrGl7tBk/Qy2cO5K03UEI+i6XgfjT1PXbWIPSOu+2eh?=
 =?us-ascii?Q?ReuB0cK/gkZpqPdTc7tNHKRdpo/89f5Y3eUVG0D6kINnlzUvwFYdfw38J+kX?=
 =?us-ascii?Q?zk0ZguGqdiTggXEPNHb7w5n7ICp6qkAciE1tjEqEKZDpg6Px+xZfBZDy0oqo?=
 =?us-ascii?Q?huuewpbyFqhay63Y+FG449H1hlxlxtb6ZV5DaOdo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb379dc3-9a14-4508-437c-08dc6b1d7071
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:16.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/rcDqWdWAm9j2pqVbEwkhomQaHMQZPXv+nZBsrbzafdi1AojUdDtt+dJ/oQCIc5ImvwiWP5pPhl9Z0aiw20Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

Hi,

Just a bunch of build and warnings fixes that show up when
building with clang. Some of these depend on each other, so
I'm sending them as a series.

Enjoy!

thanks,
John Hubbard

John Hubbard (7):
  selftests/x86: fix Makefile dependencies to work with clang
  selftests/x86: build test_FISTTP.c with clang
  selftests/x86: build fsgsbase_restore.c with clang
  selftests/x86: build sysret_rip.c with clang
  selftests/x86: avoid -no-pie warnings from clang during compilation
  selftests/x86: remove (or use) unused variables and functions
  selftests/x86: fix printk() format warnings

 tools/testing/selftests/x86/Makefile          | 31 +++++++++++++++----
 tools/testing/selftests/x86/amx.c             | 16 ----------
 .../testing/selftests/x86/clang_helpers_32.S  | 11 +++++++
 .../testing/selftests/x86/clang_helpers_64.S  | 28 +++++++++++++++++
 tools/testing/selftests/x86/fsgsbase.c        |  6 ----
 .../testing/selftests/x86/fsgsbase_restore.c  | 11 +++----
 tools/testing/selftests/x86/sigreturn.c       |  2 +-
 .../testing/selftests/x86/syscall_arg_fault.c |  1 -
 tools/testing/selftests/x86/sysret_rip.c      | 20 ++++--------
 tools/testing/selftests/x86/test_FISTTP.c     |  8 ++---
 tools/testing/selftests/x86/test_vsyscall.c   | 15 +++------
 tools/testing/selftests/x86/vdso_restorer.c   |  2 ++
 12 files changed, 87 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
 create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S


base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


