Return-Path: <linux-kselftest+bounces-39984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFF5B3712B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D2B8E4650
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ACC2E7F30;
	Tue, 26 Aug 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxmxA4mk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DED2DBF69;
	Tue, 26 Aug 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228738; cv=fail; b=G/7G/DW2faxcypKR2rsNUbME2oHUIvev2nh3FaT/L6pTzSjN9iZaVQMp64NKS/76/7Uu87SZX0UanRGY2k/uWXtbNZxfSiePFyVnQQS+kWNmrJ5VPEh/S4UzQShRewhGNURufyg4h9ngB5TcxHCx/6CPNazwKZJCwCuKBRnHJEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228738; c=relaxed/simple;
	bh=nuZ1Rzalrn8FIJ+RrFZOE+sIwAwetA2HVmzgHHd0yEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mC+HMBQTsAua0nVw6aoghIrtmVh/y6PkvSJ9NVaMGqWyuLojGrrsKKBIWEJNOBsiWxsY/IDLSQ7UT6TzC591ZQ5s7H1BOGz9txqZZco0BRawzGZ1PKtIguZ1jGtldg83yfp+BdaJAXIUmspcu7lyMfIB8XzgVwZajAJv4eHe8jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxmxA4mk; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js66/8f5fDN8oHHC4qjyYu5cR63uIn2e3CX+3adpdRhFezkN3r7N5r3R8uLz5DJ53yzWZQol8iWo6fQ+Dk9gEp1lCGJVbb+uKKMPvBB1JOASD9uz3nsRcdMlYcqoHbjWkbAJd2TJTe0fErIozKTInTVBtZI0UZLp/x0KY2XDSs0wXI4arE/rj7reW6wS84VfMkCmdDaJR+spw7Deopj+bUmy3Ui08gdDkDFj4cVBrlT3hJDuV20xWWQ/bO0v0k1aq92j3JYnjP28eNQIxI7yPlEZdMzNcJGJ/rwH0M5xRkECNIQtNA0H4xuZiuoPJKeaDtB+67DLOX11tEmtJcuc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYP4dpweU+AFO1qlNvFOjw5vtpMkV+K9hmbDcsbMOG8=;
 b=lL84dhBqyOmf6dIYDCoaoCf8upiYIBPT/34c2cTxrS9TtYOR6F3cyXS40ZH0rtJMRhmadpdL1ugzLWFjLahWbYIFnLMUsDo+YjBzk8bANkdwmEwOryNlsYiesd6vNQkG5uNFcpZyjj0pWUswlGlEt9kdAD/jZfF7HvB96neCTrtpDIWayleQCRW0Mn0m4ygk1V51jW4jX4fxVdApMV4qWi/duc67V771YbZwmTVKrQrjXv3VAXk+8Ji0cec+cNRch+9vQYQu2ARYtIuVJ/lHSchXvgrUFrCCIWt7SqA1MHnAYmZaRx9RfOmph2hyIbfsNcdErZ4xneHQuAVjsZqjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYP4dpweU+AFO1qlNvFOjw5vtpMkV+K9hmbDcsbMOG8=;
 b=lxmxA4mkGpl9lEp33osN7tb/sQhD85j5UYiHdCeHk73+eu1bxr9kxW9IdfUumUOH8EvQGz+MI5FWfoSbLgsjWndVhjfOR28HzhZ06jD2J5CKYQNS9C/3I9UgoQHaUJBXDnsPBOZN+4ICHsFR26tUvFo92m9K2Ohd9yxtcj7hMH5TDUfJnrGJlm1IjDcG/jpW092pa+W4DEIlu5jLvqe+ToDYMNnOMoqQHy37m8Ob5otRpA2V26R1h6veIl0nO+2+vpaVz4z7UipmEiOW/q9vgq8bbzM8fUvxC4xqEJRsrhCM2kapasjqOrJIwZcwYu6g2j+/btbc5ys8B9DZzY4rLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:45 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:45 +0000
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
Subject: [PATCH v4 11/15] iommufd: Change the selftest to use iommupt instead of xarray
Date: Tue, 26 Aug 2025 14:18:32 -0300
Message-ID: <11-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:806:a7::23) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3700a1fa-01b9-4ef7-0847-08dde4c49aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3xFquPNGn2/xj15YH9RACBzVasnGy+r0Vpk/lalxQWbChtH4d0TlnVzEl62T?=
 =?us-ascii?Q?He8uaXalepOuyhnjR/kIt1bcXYmbJiGp8dEYU5GMyd+84fc2yJQxUYleVfM2?=
 =?us-ascii?Q?voNXV0QTFCYL2WIT4Rrt64ktbFv3d5Fg6F/sJgtElPsERX1SlnjaYsU0N73v?=
 =?us-ascii?Q?heoyL/il/cUaSVCkAPEjofzNFT+5Ts+njnjgDKVKPubIJu+SB7DcYIhf7G+1?=
 =?us-ascii?Q?kdYHtT869r9+/SQQHANXCWhweDDkz3D1de0iCK8WHeGMuhKnxAIJRJ8qFKu/?=
 =?us-ascii?Q?X77Zov8N4iIT2OjcOmYGSKRm6DL9i3qtq0sdmYuJ2aElJnn+MmZs3J2u8uBH?=
 =?us-ascii?Q?3qkgGr9GmsgzH1DyNt0I+iM6H/tLbHxc1Np8Nrwpby68pVqY8oyxMVgxgMjy?=
 =?us-ascii?Q?4M1+GelvOv4D+QuDqq5HRom0jpEUwNuFEOl0aJ+ytiA2UgZ5PLjHyBfzoLb7?=
 =?us-ascii?Q?R2LCa121cOEqXfadKUDHTYVBIE7neKXJbX0nf3wKcuX+/YNwhWo4B69iXmUj?=
 =?us-ascii?Q?Y+/s0LxwLaFLghtYHx/Sbc9Py7HgsxiHVBHcCHIRTllXkb4/0+J5BgEE3KEv?=
 =?us-ascii?Q?EHgpCOBuE0ktDzt+5e4BDWYVa1IxJraqhXxeZQxikrMpqGdY26r+9rEznl1n?=
 =?us-ascii?Q?ukZZC036Cp3ri51ymkk/ltdWBbDlUkHzmxBT8MIPAfGfAhREz7s9PAjRqqIN?=
 =?us-ascii?Q?RdvgNvyHS1xEm6TgwXnC+EyuVQEdR20vlMYTRqgbwn5To+sPxIXFbQnHTO+w?=
 =?us-ascii?Q?kSr7I0/Hm/cm/3wc6PzUb+BeCcvAYie++Ku74/xYHUj1cT1VKTuKyj3lUmPh?=
 =?us-ascii?Q?Kzjh1OGM1F6sz52xIts7o2JYKg9JzQVt/Fxy1xHLJL+EY6ufbIhm/e8fA2Zq?=
 =?us-ascii?Q?k+vFvcKtsu59P+WzRs3bK1g8ILx+1s/1M9ROXoW5KBsuv1zg/+MNaKKxUGwJ?=
 =?us-ascii?Q?2rDBQ3j0gRsOpOyvKoeSXMj3FGHwClPsUCajqMKfzYglxMZIG4wmyoiJ0OME?=
 =?us-ascii?Q?qJvrER/TPO7MXHcBCi0b46m6DTQdXouCUD7lSmgJ9pwpN7yNr2QzCvznlfMn?=
 =?us-ascii?Q?O7G2zvcVI5++iMNY4POeIvI+YORqAx71uKyT475GgVHF5o+y099FYQu+5kwM?=
 =?us-ascii?Q?jg5r/7/F9MZF+gzTn5Xjbtpqz2UO1f6WKBshiRueyvvMaduNU0meAMPI4voS?=
 =?us-ascii?Q?LAKpFe72STz65OXUJtdOSC7jzYnCrpHA946tAe5bF6S7aXzr16m/KuXLs8y6?=
 =?us-ascii?Q?xm9nPQGNSy53xB+qaLbYtllKtWEimIvsQHs6NDaA5TBLGrLfG/B9/rCEWCt/?=
 =?us-ascii?Q?AFiU99tKqGxZnMfpUSM10/erq5MzCHt9uqx6aA+9HMuP9LNGGPVCaH7F+qB5?=
 =?us-ascii?Q?+lpCPkkZNuVnJPSfGH++GO8TVL6lm85X3ZJQLQZemuoUOQ+TX8scMjPIkVkT?=
 =?us-ascii?Q?LOB58j8zXDhuFwzgv9bH/dOmxmUpIEzAVphjaerB58azuNUN6o3BHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjgo55Unpp+hnPgN7wbVMrEdn/uQyGvRoIXehzHxW7w2pA1oO3MGA5N8AX0u?=
 =?us-ascii?Q?/0lyZ1/WcHdINWJyRbCYac3V1gzvReZ3HyjGBoHoHHVIO2iYdXiyyEl6lgBZ?=
 =?us-ascii?Q?7mU/LF8Hj5Pyzt3wxEnbOLYYGKQkyR8nBvAG9y3viFZsftHb0V3O9ibE2p/o?=
 =?us-ascii?Q?e+RRZjBUnsa2wOnt66wxqoKsyIxReePMFJkOTYYZEeQ3HauFhVMz1icBNcbf?=
 =?us-ascii?Q?1t5B96TJ0nOo6J7SrZXUNqU20Xs+tNwrNbi5ymD6nb2s/Pzs4aIVHHAu1gP0?=
 =?us-ascii?Q?RAvxSRGQ7olDgBx5Ix7XVyxXZJnP3GrflVii1zwBlpw8p2K30kg9J3vg7gcU?=
 =?us-ascii?Q?+vl5rDXM0S76KYs09FG6cYYu1ugu5KLv7KolM/FkOsVN/NhAogcW7ApxIdY8?=
 =?us-ascii?Q?bZMW4urezRmpAnVZDqeKorJiP1ufBLqJJ8NoqY83OwW8m0cf43X3YyPpP7Z5?=
 =?us-ascii?Q?gyl5odL0fUMTXRge64FAMNk50R+kQobniQdB5m0aTUGol+T+94tR1Tmds0+2?=
 =?us-ascii?Q?OZ/A4POTRQBNssf55/xufyo3K/jqudDzsYyvMenRmWmr0FVIM/h9bTnQQgNR?=
 =?us-ascii?Q?TheytTZd3Hh+y3/zqeevuJiTQ5xnZxoG3EMBad3Jm8YVeM0005W6qtXXV1yK?=
 =?us-ascii?Q?iszJQGJirlIpra/u7KsRoB0TzP6GSuoIDj4rZ6/13WNFb4Y9OLgm6zpVrK9e?=
 =?us-ascii?Q?pAIeWrGzIMifx9We0j1KeHRYyjRHlKwmyVHl4oms2xS7GsdhZjaqFzjK8tch?=
 =?us-ascii?Q?tc+BQlv4lsTxfQiuOyfC9+224dIA47YLCPVc0TEOuKcs8O8BdLEOxJCmW8N6?=
 =?us-ascii?Q?Dj7Fsz6zpkBzasXmJnLDkjsxEr4FuHmmnHKTqD+PhVlNr23i3CUG6kzqxz0Z?=
 =?us-ascii?Q?v0OXIMtDTN+FO/mT+wuTd6JsQnGiJBG65vhUyry7ZlXNRU8Ec66S6BG+CT6D?=
 =?us-ascii?Q?TXLXHV9KgIKEIMQtvaYTkw6dUHeoQAZdUBiFuxIft3iH4pfPFPMwXlZv+Zi6?=
 =?us-ascii?Q?m8bzdDiv93A2T8fM4YdpwXLYF+jwof3K0oMNGBHdKaZR/zWUEs/43dh3CnDC?=
 =?us-ascii?Q?guTeQtvMlnnZAU1Q59SHsiDQ4FqKNBJOkZbBhvSXIiTa3QQZpk2DQB5QTeig?=
 =?us-ascii?Q?8UZh3PpjO3Y+hFbLh0lj1g/3tSzG290lGnTuyUhpQe0rykRQMqLVD7qocvxb?=
 =?us-ascii?Q?kvpyyd5zBGDiOz0YUt11o4f0bifpxYCfn//Vr0m7R52KaT/RwNu9xFUy96s0?=
 =?us-ascii?Q?f5ODdp4KGgR4Prnoa5Oi/ahIIhrm1Oa/bhR65AuWvKieGfz8qKJpTuUjh+9i?=
 =?us-ascii?Q?8hQHCJTUVI4x/YhP+Pa2tj4Kl4YKRJQ5oo+nDBXLvcojdLbJChquAaKLJCd8?=
 =?us-ascii?Q?cSiimhbrqgUkaCFli28kNbB6JMLGCGohkaUWERWWDv18d8gyBOCGcbib4JEv?=
 =?us-ascii?Q?TlqqZDf5Cd08aNOeSPebT46MSxbbkw/g1GZKoGqdxChu7Se5kxW/IKQAfm6J?=
 =?us-ascii?Q?6CfqjKvth83s1ZpfkfKDhN528+grumrlzLjy3M4POyPL4B9qjjwW19Po3cK9?=
 =?us-ascii?Q?dCi+uYVTju74GOAHdysv9SYiABXf8PkmBrM/5gPt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3700a1fa-01b9-4ef7-0847-08dde4c49aa9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:42.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6b4koDgDUDlrlSIjRyOZbcq28Xvmem5qR+YW2NhlyDuLAm730qtnrXb5Yr+HLjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Make it act more like a real iommu driver by
replacing the xarray with an iommupt based page table. The new AMDv1 mock
format behaves similarly to the xarray.

Add set_dirty() as a iommu_pt operation to allow the test suite to
simulate HW dirty.

Userspace can select between several formats including the normal AMDv1
format and a special MOCK_IOMMUPT_HUGE variation for testing huge page
dirty tracking. To make the dirty tracking test work the page table must
only store exactly 2M huge pages otherwise the logic the test uses
fails. They cannot be broken up or combined.

Aside from aligning the selftest with a real page table implementation,
this helps test the iommupt code itself.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h           |  39 ++
 drivers/iommu/iommufd/Kconfig                 |   1 +
 drivers/iommu/iommufd/iommufd_test.h          |  11 +-
 drivers/iommu/iommufd/selftest.c              | 438 +++++++-----------
 include/linux/generic_pt/iommu.h              |  12 +
 tools/testing/selftests/iommu/iommufd.c       |  60 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  12 +
 7 files changed, 289 insertions(+), 284 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index aa2c53a9625711..2a6c1bc2bc9be7 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -263,6 +263,41 @@ int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU");
 
+static inline int __set_dirty(struct pt_range *range, void *arg,
+			      unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, __set_dirty);
+	case PT_ENTRY_OA:
+		if (!pt_entry_make_write_dirty(&pts))
+			return -EAGAIN;
+		return 0;
+	}
+	return -ENOENT;
+}
+
+static int __maybe_unused NS(set_dirty)(struct pt_iommu *iommu_table,
+					dma_addr_t iova)
+{
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note: There is no locking here yet, if the test suite races this it
+	 * can crash. It should use RCU locking eventually.
+	 */
+	return pt_walk_range(&range, __set_dirty, NULL);
+}
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	u8 ignore_mapped : 1;
@@ -940,6 +975,10 @@ static void NS(deinit)(struct pt_iommu *iommu_table)
 }
 
 static const struct pt_iommu_ops NS(ops) = {
+#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER) && defined(pt_entry_write_is_dirty) && \
+	IS_ENABLED(CONFIG_IOMMUFD_TEST) && defined(pt_entry_make_write_dirty)
+	.set_dirty = NS(set_dirty),
+#endif
 	.get_info = NS(get_info),
 	.deinit = NS(deinit),
 };
diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 2beeb4f60ee538..eae3f03629b0c1 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -41,6 +41,7 @@ config IOMMUFD_TEST
 	depends on DEBUG_KERNEL
 	depends on FAULT_INJECTION
 	depends on RUNTIME_TESTING_MENU
+	depends on IOMMU_PT_AMDV1
 	select IOMMUFD_DRIVER
 	default n
 	help
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 8fc618b2bcf967..781a75c79eeaec 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -31,9 +31,18 @@ enum {
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
 };
 
+enum {
+	MOCK_IOMMUPT_DEFAULT = 0,
+	MOCK_IOMMUPT_HUGE,
+	MOCK_IOMMUPT_AMDV1,
+};
+
+/* These values are true for MOCK_IOMMUPT_DEFAULT */
 enum {
 	MOCK_APERTURE_START = 1UL << 24,
 	MOCK_APERTURE_LAST = (1UL << 31) - 1,
+	MOCK_PAGE_SIZE = 2048,
+	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_PAGE_SIZE,
 };
 
 enum {
@@ -52,7 +61,6 @@ enum {
 
 enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
-	MOCK_FLAGS_DEVICE_HUGE_IOVA = 1 << 1,
 	MOCK_FLAGS_DEVICE_PASID = 1 << 2,
 };
 
@@ -205,6 +213,7 @@ struct iommu_test_hw_info {
  */
 struct iommu_hwpt_selftest {
 	__u32 iotlb;
+	__u32 pagetable_type;
 };
 
 /* Should not be equal to any defined value in enum iommu_hwpt_invalidate_data_type */
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 61686603c76934..b60e7584123352 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/generic_pt/iommu.h>
+#include "../iommu-pages.h"
 
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
@@ -41,21 +43,6 @@ static DEFINE_IDA(mock_dev_ida);
 
 enum {
 	MOCK_DIRTY_TRACK = 1,
-	MOCK_IO_PAGE_SIZE = PAGE_SIZE / 2,
-	MOCK_HUGE_PAGE_SIZE = 512 * MOCK_IO_PAGE_SIZE,
-
-	/*
-	 * Like a real page table alignment requires the low bits of the address
-	 * to be zero. xarray also requires the high bit to be zero, so we store
-	 * the pfns shifted. The upper bits are used for metadata.
-	 */
-	MOCK_PFN_MASK = ULONG_MAX / MOCK_IO_PAGE_SIZE,
-
-	_MOCK_PFN_START = MOCK_PFN_MASK + 1,
-	MOCK_PFN_START_IOVA = _MOCK_PFN_START,
-	MOCK_PFN_LAST_IOVA = _MOCK_PFN_START,
-	MOCK_PFN_DIRTY_IOVA = _MOCK_PFN_START << 1,
-	MOCK_PFN_HUGE_IOVA = _MOCK_PFN_START << 2,
 };
 
 static int mock_dev_enable_iopf(struct device *dev, struct iommu_domain *domain);
@@ -124,10 +111,15 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 }
 
 struct mock_iommu_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu iommu;
+		struct pt_iommu_amdv1 amdv1;
+	};
 	unsigned long flags;
-	struct iommu_domain domain;
-	struct xarray pfns;
 };
+PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
 
 static inline struct mock_iommu_domain *
 to_mock_domain(struct iommu_domain *domain)
@@ -344,74 +336,6 @@ static int mock_domain_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static bool mock_test_and_clear_dirty(struct mock_iommu_domain *mock,
-				      unsigned long iova, size_t page_size,
-				      unsigned long flags)
-{
-	unsigned long cur, end = iova + page_size - 1;
-	bool dirty = false;
-	void *ent, *old;
-
-	for (cur = iova; cur < end; cur += MOCK_IO_PAGE_SIZE) {
-		ent = xa_load(&mock->pfns, cur / MOCK_IO_PAGE_SIZE);
-		if (!ent || !(xa_to_value(ent) & MOCK_PFN_DIRTY_IOVA))
-			continue;
-
-		dirty = true;
-		/* Clear dirty */
-		if (!(flags & IOMMU_DIRTY_NO_CLEAR)) {
-			unsigned long val;
-
-			val = xa_to_value(ent) & ~MOCK_PFN_DIRTY_IOVA;
-			old = xa_store(&mock->pfns, cur / MOCK_IO_PAGE_SIZE,
-				       xa_mk_value(val), GFP_KERNEL);
-			WARN_ON_ONCE(ent != old);
-		}
-	}
-
-	return dirty;
-}
-
-static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
-					    unsigned long iova, size_t size,
-					    unsigned long flags,
-					    struct iommu_dirty_bitmap *dirty)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	unsigned long end = iova + size;
-	void *ent;
-
-	if (!(mock->flags & MOCK_DIRTY_TRACK) && dirty->bitmap)
-		return -EINVAL;
-
-	do {
-		unsigned long pgsize = MOCK_IO_PAGE_SIZE;
-		unsigned long head;
-
-		ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-		if (!ent) {
-			iova += pgsize;
-			continue;
-		}
-
-		if (xa_to_value(ent) & MOCK_PFN_HUGE_IOVA)
-			pgsize = MOCK_HUGE_PAGE_SIZE;
-		head = iova & ~(pgsize - 1);
-
-		/* Clear dirty */
-		if (mock_test_and_clear_dirty(mock, head, pgsize, flags))
-			iommu_dirty_bitmap_record(dirty, iova, pgsize);
-		iova += pgsize;
-	} while (iova < end);
-
-	return 0;
-}
-
-static const struct iommu_dirty_ops dirty_ops = {
-	.set_dirty_tracking = mock_domain_set_dirty_tracking,
-	.read_and_clear_dirty = mock_domain_read_and_clear_dirty,
-};
-
 static struct mock_iommu_domain_nested *
 __mock_domain_alloc_nested(const struct iommu_user_data *user_data)
 {
@@ -446,7 +370,7 @@ mock_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 
 	if (flags & ~IOMMU_HWPT_ALLOC_PASID)
 		return ERR_PTR(-EOPNOTSUPP);
-	if (!parent || parent->ops != mock_ops.default_domain_ops)
+	if (!parent || !(parent->type & __IOMMU_DOMAIN_PAGING))
 		return ERR_PTR(-EINVAL);
 
 	mock_parent = to_mock_domain(parent);
@@ -459,6 +383,138 @@ mock_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	return &mock_nested->domain;
 }
 
+static void mock_domain_free(struct iommu_domain *domain)
+{
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
+
+	pt_iommu_deinit(&mock->iommu);
+	kfree(mock);
+}
+
+static void mock_iotlb_sync(struct iommu_domain *domain,
+				struct iommu_iotlb_gather *gather)
+{
+	iommu_put_pages_list(&gather->freelist);
+}
+
+static const struct iommu_domain_ops amdv1_mock_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1_mock),
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
+	.iotlb_sync = &mock_iotlb_sync,
+};
+
+static const struct iommu_domain_ops amdv1_mock_huge_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1_mock),
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
+	.iotlb_sync = &mock_iotlb_sync,
+};
+#undef pt_iommu_amdv1_mock_map_pages
+
+static const struct iommu_dirty_ops amdv1_mock_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1_mock),
+	.set_dirty_tracking = mock_domain_set_dirty_tracking,
+};
+
+static const struct iommu_domain_ops amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
+	.iotlb_sync = &mock_iotlb_sync,
+};
+
+static const struct iommu_dirty_ops amdv1_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1),
+	.set_dirty_tracking = mock_domain_set_dirty_tracking,
+};
+
+static struct mock_iommu_domain *
+mock_domain_alloc_pgtable(struct device *dev,
+			  const struct iommu_hwpt_selftest *user_cfg, u32 flags)
+{
+	struct mock_iommu_domain *mock;
+	int rc;
+
+	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return ERR_PTR(-ENOMEM);
+	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
+
+	mock->amdv1.iommu.nid = NUMA_NO_NODE;
+
+	switch (user_cfg->pagetable_type) {
+	case MOCK_IOMMUPT_DEFAULT:
+	case MOCK_IOMMUPT_HUGE: {
+		struct pt_iommu_amdv1_cfg cfg = {};
+
+		/* The mock version has a 2k page size */
+		cfg.common.hw_max_vasz_lg2 = 56;
+		cfg.common.hw_max_oasz_lg2 = 51;
+		cfg.starting_level = 2;
+		if (user_cfg->pagetable_type == MOCK_IOMMUPT_HUGE)
+			mock->domain.ops = &amdv1_mock_huge_ops;
+		else
+			mock->domain.ops = &amdv1_mock_ops;
+		rc = pt_iommu_amdv1_mock_init(&mock->amdv1, &cfg, GFP_KERNEL);
+		if (rc)
+			goto err_free;
+
+		/*
+		 * In huge mode userspace should only provide huge pages, we
+		 * have to include PAGE_SIZE for the domain to be accepted by
+		 * iommufd.
+		 */
+		if (user_cfg->pagetable_type == MOCK_IOMMUPT_HUGE)
+			mock->domain.pgsize_bitmap = MOCK_HUGE_PAGE_SIZE |
+						     PAGE_SIZE;
+		if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+			mock->domain.dirty_ops = &amdv1_mock_dirty_ops;
+		break;
+	}
+
+	case MOCK_IOMMUPT_AMDV1: {
+		struct pt_iommu_amdv1_cfg cfg = {};
+
+		cfg.common.hw_max_vasz_lg2 = 64;
+		cfg.common.hw_max_oasz_lg2 = 52;
+		cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
+				      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+				      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+		cfg.starting_level = 2;
+		mock->domain.ops = &amdv1_ops;
+		rc = pt_iommu_amdv1_init(&mock->amdv1, &cfg, GFP_KERNEL);
+		if (rc)
+			goto err_free;
+		if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+			mock->domain.dirty_ops = &amdv1_dirty_ops;
+		break;
+	}
+	default:
+		rc = -EOPNOTSUPP;
+		goto err_free;
+	}
+
+	/*
+	 * Override the real aperture to the MOCK aperture for test purposes.
+	 */
+	if (user_cfg->pagetable_type == MOCK_IOMMUPT_DEFAULT) {
+		WARN_ON(mock->domain.geometry.aperture_start != 0);
+		WARN_ON(mock->domain.geometry.aperture_end < MOCK_APERTURE_LAST);
+
+		mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
+		mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	}
+
+	return mock;
+err_free:
+	kfree(mock);
+	return ERR_PTR(rc);
+}
+
 static struct iommu_domain *
 mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			       const struct iommu_user_data *user_data)
@@ -469,151 +525,30 @@ mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				 IOMMU_HWPT_ALLOC_PASID;
 	struct mock_dev *mdev = to_mock_dev(dev);
 	bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
+	struct iommu_hwpt_selftest user_cfg = {};
 	struct mock_iommu_domain *mock;
+	int rc;
 
-	if (user_data)
-		return ERR_PTR(-EOPNOTSUPP);
 	if ((flags & ~PAGING_FLAGS) || (has_dirty_flag && no_dirty_ops))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
-	if (!mock)
-		return ERR_PTR(-ENOMEM);
-	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
-	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
-	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
-	if (dev && mdev->flags & MOCK_FLAGS_DEVICE_HUGE_IOVA)
-		mock->domain.pgsize_bitmap |= MOCK_HUGE_PAGE_SIZE;
-	mock->domain.ops = mock_ops.default_domain_ops;
-	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	xa_init(&mock->pfns);
+	if (user_data && (user_data->type != IOMMU_HWPT_DATA_SELFTEST &&
+			  user_data->type != IOMMU_HWPT_DATA_NONE))
+		return ERR_PTR(-EOPNOTSUPP);
 
-	if (has_dirty_flag)
-		mock->domain.dirty_ops = &dirty_ops;
+	if (user_data) {
+		rc = iommu_copy_struct_from_user(
+			&user_cfg, user_data, IOMMU_HWPT_DATA_SELFTEST, iotlb);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
+	mock = mock_domain_alloc_pgtable(dev, &user_cfg, flags);
+	if (IS_ERR(mock))
+		return ERR_CAST(mock);
 	return &mock->domain;
 }
 
-static void mock_domain_free(struct iommu_domain *domain)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-
-	WARN_ON(!xa_empty(&mock->pfns));
-	kfree(mock);
-}
-
-static int mock_domain_map_pages(struct iommu_domain *domain,
-				 unsigned long iova, phys_addr_t paddr,
-				 size_t pgsize, size_t pgcount, int prot,
-				 gfp_t gfp, size_t *mapped)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	unsigned long flags = MOCK_PFN_START_IOVA;
-	unsigned long start_iova = iova;
-
-	/*
-	 * xarray does not reliably work with fault injection because it does a
-	 * retry allocation, so put our own failure point.
-	 */
-	if (iommufd_should_fail())
-		return -ENOENT;
-
-	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
-	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
-	for (; pgcount; pgcount--) {
-		size_t cur;
-
-		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
-			void *old;
-
-			if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
-				flags = MOCK_PFN_LAST_IOVA;
-			if (pgsize != MOCK_IO_PAGE_SIZE) {
-				flags |= MOCK_PFN_HUGE_IOVA;
-			}
-			old = xa_store(&mock->pfns, iova / MOCK_IO_PAGE_SIZE,
-				       xa_mk_value((paddr / MOCK_IO_PAGE_SIZE) |
-						   flags),
-				       gfp);
-			if (xa_is_err(old)) {
-				for (; start_iova != iova;
-				     start_iova += MOCK_IO_PAGE_SIZE)
-					xa_erase(&mock->pfns,
-						 start_iova /
-							 MOCK_IO_PAGE_SIZE);
-				return xa_err(old);
-			}
-			WARN_ON(old);
-			iova += MOCK_IO_PAGE_SIZE;
-			paddr += MOCK_IO_PAGE_SIZE;
-			*mapped += MOCK_IO_PAGE_SIZE;
-			flags = 0;
-		}
-	}
-	return 0;
-}
-
-static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
-				      unsigned long iova, size_t pgsize,
-				      size_t pgcount,
-				      struct iommu_iotlb_gather *iotlb_gather)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	bool first = true;
-	size_t ret = 0;
-	void *ent;
-
-	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
-	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
-
-	for (; pgcount; pgcount--) {
-		size_t cur;
-
-		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
-			ent = xa_erase(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-
-			/*
-			 * iommufd generates unmaps that must be a strict
-			 * superset of the map's performend So every
-			 * starting/ending IOVA should have been an iova passed
-			 * to map.
-			 *
-			 * This simple logic doesn't work when the HUGE_PAGE is
-			 * turned on since the core code will automatically
-			 * switch between the two page sizes creating a break in
-			 * the unmap calls. The break can land in the middle of
-			 * contiguous IOVA.
-			 */
-			if (!(domain->pgsize_bitmap & MOCK_HUGE_PAGE_SIZE)) {
-				if (first) {
-					WARN_ON(ent && !(xa_to_value(ent) &
-							 MOCK_PFN_START_IOVA));
-					first = false;
-				}
-				if (pgcount == 1 &&
-				    cur + MOCK_IO_PAGE_SIZE == pgsize)
-					WARN_ON(ent && !(xa_to_value(ent) &
-							 MOCK_PFN_LAST_IOVA));
-			}
-
-			iova += MOCK_IO_PAGE_SIZE;
-			ret += MOCK_IO_PAGE_SIZE;
-		}
-	}
-	return ret;
-}
-
-static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
-					    dma_addr_t iova)
-{
-	struct mock_iommu_domain *mock = to_mock_domain(domain);
-	void *ent;
-
-	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
-	ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-	WARN_ON(!ent);
-	return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
-}
-
 static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
@@ -955,15 +890,6 @@ static const struct iommu_ops mock_ops = {
 	.user_pasid_table = true,
 	.get_viommu_size = mock_get_viommu_size,
 	.viommu_init = mock_viommu_init,
-	.default_domain_ops =
-		&(struct iommu_domain_ops){
-			.free = mock_domain_free,
-			.attach_dev = mock_domain_nop_attach,
-			.map_pages = mock_domain_map_pages,
-			.unmap_pages = mock_domain_unmap_pages,
-			.iova_to_phys = mock_domain_iova_to_phys,
-			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
-		},
 };
 
 static void mock_domain_free_nested(struct iommu_domain *domain)
@@ -1047,7 +973,7 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	if (IS_ERR(hwpt))
 		return hwpt;
 	if (hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED ||
-	    hwpt->domain->ops != mock_ops.default_domain_ops) {
+	    hwpt->domain->owner != &mock_ops) {
 		iommufd_put_object(ucmd->ictx, &hwpt->obj);
 		return ERR_PTR(-EINVAL);
 	}
@@ -1088,7 +1014,6 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		{},
 	};
 	const u32 valid_flags = MOCK_FLAGS_DEVICE_NO_DIRTY |
-				MOCK_FLAGS_DEVICE_HUGE_IOVA |
 				MOCK_FLAGS_DEVICE_PASID;
 	struct mock_dev *mdev;
 	int rc, i;
@@ -1277,23 +1202,25 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 {
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
+	unsigned int page_size;
 	uintptr_t end;
 	int rc;
 
-	if (iova % MOCK_IO_PAGE_SIZE || length % MOCK_IO_PAGE_SIZE ||
-	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE ||
-	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
-		return -EINVAL;
-
 	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
 	if (IS_ERR(hwpt))
 		return PTR_ERR(hwpt);
 
-	for (; length; length -= MOCK_IO_PAGE_SIZE) {
+	page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
+	if (iova % page_size || length % page_size ||
+	    (uintptr_t)uptr % page_size ||
+	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
+		return -EINVAL;
+
+	for (; length; length -= page_size) {
 		struct page *pages[1];
+		phys_addr_t io_phys;
 		unsigned long pfn;
 		long npages;
-		void *ent;
 
 		npages = get_user_pages_fast((uintptr_t)uptr & PAGE_MASK, 1, 0,
 					     pages);
@@ -1308,15 +1235,14 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 		pfn = page_to_pfn(pages[0]);
 		put_page(pages[0]);
 
-		ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
-		if (!ent ||
-		    (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE !=
-			    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
+		io_phys = mock->domain.ops->iova_to_phys(&mock->domain, iova);
+		if (io_phys !=
+		    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
 			rc = -EINVAL;
 			goto out_put;
 		}
-		iova += MOCK_IO_PAGE_SIZE;
-		uptr += MOCK_IO_PAGE_SIZE;
+		iova += page_size;
+		uptr += page_size;
 	}
 	rc = 0;
 
@@ -1795,7 +1721,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	if (IS_ERR(hwpt))
 		return PTR_ERR(hwpt);
 
-	if (!(mock->flags & MOCK_DIRTY_TRACK)) {
+	if (!(mock->flags & MOCK_DIRTY_TRACK) || !mock->iommu.ops->set_dirty) {
 		rc = -EINVAL;
 		goto out_put;
 	}
@@ -1814,22 +1740,10 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	}
 
 	for (i = 0; i < max; i++) {
-		unsigned long cur = iova + i * page_size;
-		void *ent, *old;
-
 		if (!test_bit(i, (unsigned long *)tmp))
 			continue;
-
-		ent = xa_load(&mock->pfns, cur / page_size);
-		if (ent) {
-			unsigned long val;
-
-			val = xa_to_value(ent) | MOCK_PFN_DIRTY_IOVA;
-			old = xa_store(&mock->pfns, cur / page_size,
-				       xa_mk_value(val), GFP_KERNEL);
-			WARN_ON_ONCE(ent != old);
-			count++;
-		}
+		mock->iommu.ops->set_dirty(&mock->iommu, iova + i * page_size);
+		count++;
 	}
 
 	cmd->dirty.out_nr_dirty = count;
@@ -2202,3 +2116,5 @@ void iommufd_test_exit(void)
 	platform_device_unregister(selftest_iommu_dev);
 	debugfs_remove_recursive(dbgfs_root);
 }
+
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index cbe6433550f380..58c9fa74fb0701 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -73,6 +73,18 @@ struct pt_iommu_info {
 };
 
 struct pt_iommu_ops {
+	/**
+	 * set_dirty() - Make the iova write dirty
+	 * @iommu_table: Table to manipulate
+	 * @iova: IO virtual address to start
+	 *
+	 * This is only used by iommufd testing. It makes the iova dirty so that
+	 * read_and_clear_dirty() will see it as dirty. Unlike all the other ops
+	 * this one is safe to call without holding any locking. It may return
+	 * -EAGAIN if there is a race.
+	 */
+	int (*set_dirty)(struct pt_iommu *iommu_table, dma_addr_t iova);
+
 	/**
 	 * get_info() - Return the pt_iommu_info structure
 	 * @iommu_table: Table to query
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 3eebf5e3b974f4..595b0a3ead645c 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -13,9 +13,6 @@
 
 static unsigned long HUGEPAGE_SIZE;
 
-#define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
-#define MOCK_HUGE_PAGE_SIZE (512 * MOCK_PAGE_SIZE)
-
 static unsigned long get_huge_page_size(void)
 {
 	char buf[80];
@@ -2058,6 +2055,12 @@ FIXTURE_VARIANT(iommufd_dirty_tracking)
 
 FIXTURE_SETUP(iommufd_dirty_tracking)
 {
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_SET,
+		.val64 = 0,
+	};
 	size_t mmap_buffer_size;
 	unsigned long size;
 	int mmap_flags;
@@ -2066,7 +2069,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 
 	if (variant->buffer_size < MOCK_PAGE_SIZE) {
 		SKIP(return,
-		     "Skipping buffer_size=%lu, less than MOCK_PAGE_SIZE=%lu",
+		     "Skipping buffer_size=%lu, less than MOCK_PAGE_SIZE=%u",
 		     variant->buffer_size, MOCK_PAGE_SIZE);
 	}
 
@@ -2114,16 +2117,18 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	assert((uintptr_t)self->bitmap % PAGE_SIZE == 0);
 
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	/* Enable 1M mock IOMMU hugepages */
-	if (variant->hugepages) {
-		test_cmd_mock_domain_flags(self->ioas_id,
-					   MOCK_FLAGS_DEVICE_HUGE_IOVA,
-					   &self->stdev_id, &self->hwpt_id,
-					   &self->idev_id);
-	} else {
-		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id, &self->idev_id);
-	}
+
+	/*
+	 * For dirty testing it is important that the page size fed into
+	 * the iommu page tables matches the size the dirty logic
+	 * expects, or set_dirty can touch too much stuff.
+	 */
+	cmd.object_id = self->ioas_id;
+	if (!variant->hugepages)
+		ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	test_cmd_mock_domain(self->ioas_id, &self->stdev_id, &self->hwpt_id,
+			     &self->idev_id);
 }
 
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
@@ -2248,18 +2253,23 @@ TEST_F(iommufd_dirty_tracking, device_dirty_capability)
 TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 {
 	uint32_t page_size = MOCK_PAGE_SIZE;
+	uint32_t ioas_id = self->ioas_id;
 	uint32_t hwpt_id;
-	uint32_t ioas_id;
 
 	if (variant->hugepages)
 		page_size = MOCK_HUGE_PAGE_SIZE;
 
-	test_ioctl_ioas_alloc(&ioas_id);
 	test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
 				     variant->buffer_size, MOCK_APERTURE_START);
 
-	test_cmd_hwpt_alloc(self->idev_id, ioas_id,
-			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
+	if (variant->hugepages)
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_HUGE, &hwpt_id);
+	else
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_DEFAULT, &hwpt_id);
 
 	test_cmd_set_dirty_tracking(hwpt_id, true);
 
@@ -2285,18 +2295,24 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
 TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
 {
 	uint32_t page_size = MOCK_PAGE_SIZE;
+	uint32_t ioas_id = self->ioas_id;
 	uint32_t hwpt_id;
-	uint32_t ioas_id;
 
 	if (variant->hugepages)
 		page_size = MOCK_HUGE_PAGE_SIZE;
 
-	test_ioctl_ioas_alloc(&ioas_id);
 	test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
 				     variant->buffer_size, MOCK_APERTURE_START);
 
-	test_cmd_hwpt_alloc(self->idev_id, ioas_id,
-			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
+
+	if (variant->hugepages)
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_HUGE, &hwpt_id);
+	else
+		test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+					    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+					    MOCK_IOMMUPT_DEFAULT, &hwpt_id);
 
 	test_cmd_set_dirty_tracking(hwpt_id, true);
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3c3e08b8c90eb3..6d426fa52f860e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -215,6 +215,18 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id, __u32 ft_i
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 0, flags,   \
 					  hwpt_id, IOMMU_HWPT_DATA_NONE, NULL, \
 					  0))
+#define test_cmd_hwpt_alloc_iommupt(device_id, pt_id, flags, iommupt_type, \
+				    hwpt_id)                               \
+	({                                                                 \
+		struct iommu_hwpt_selftest user_cfg = {                    \
+			.pagetable_type = iommupt_type                     \
+		};                                                         \
+                                                                           \
+		ASSERT_EQ(0, _test_cmd_hwpt_alloc(                         \
+				     self->fd, device_id, pt_id, 0, flags, \
+				     hwpt_id, IOMMU_HWPT_DATA_SELFTEST,    \
+				     &user_cfg, sizeof(user_cfg)));        \
+	})
 #define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id)   \
 	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(                      \
 				     self->fd, device_id, pt_id, 0, flags, \
-- 
2.43.0


