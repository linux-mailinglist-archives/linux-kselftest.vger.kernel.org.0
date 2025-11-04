Return-Path: <linux-kselftest+bounces-44732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4145DC32A52
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991AA18C3F05
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A745337BA4;
	Tue,  4 Nov 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngsN+auJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13926F295;
	Tue,  4 Nov 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281023; cv=fail; b=X7FEoUfexrNTvxAw+jKVnBZyr1RuvoQtU8Uaz0YOSAYY53q7pdMaHpFbgfzkj+2KsAw83vaVbPWp26WyJOHHaL21pjRfLW6mACNXaakd3YIyVAmEJez9ZIQINwuxjg9Bu7Hhz4idCd3yFNiccyyx8qyvhcwP+0ZteaOEuCOOFc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281023; c=relaxed/simple;
	bh=XMPAPlefH8NcVKt4l5EbWOPj2MO1RfI5QfomTGGleIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=svR+qar3Jp5zHhtA5qcA0YuylPO32Gv/rWySS+kZsCMW/Vu4ZRw4+5StP0jQ6A0/3NAns5wMV7EhMPhPYGmp7gpMiF66mq7Nx1rCEYuUumnLGPKPyi+ym3vnHwd0bnhaFmV4/NiobWco+AH93ZoYSvtune2XARVNFaL98IF6gj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngsN+auJ; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmjneOty5ay3b+vwt+TZAA+CWa7iwUtXkNZISnjagnXhcKbn51/7MXg+aUiQVmtL1+hzC0C0OfGaEn/ltoWJrb7TkysussrYQKoU6OYQRd+QTt9lzhRSLfPgt9bRs5+lMV8jnZXU+dVXU3VcV4Y45JqgDKmS0mOE4ADYqoJHftqTXkoeSLRQ1i58Y5cV/GGGv96KnjooeAjGQtcMsh3smCetmNqaVM/PhFs3e7jIEFxWGsERKFyVbxvmdbS1M4q2HIZwUf81zU22rfhIeetnZ+VJB+s2KpD3vDd7BaZ1VuikXxjQiuky0/1kx+NoKchiq4qf0Kg0Ig800IjTaLr4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGbO0oHMRs4kOcsL1MpFT4oCGnyIn+m338RtGTwVDGY=;
 b=BxMZlASzQTInvXVrFZxs5SDJYZMqFG55GeTzpx6gUrqA0vrkFxZVwB0BLCtqrPgnsNeaBYwQRShro2vbVBA5phfn5BHlbOT68PSt3anPmWL6KlRJqJM7LmoEDnBciICrcnV/1K3beLLUrdjnj8XrDMJS9cwHP9HKFDe69yp5kqniqhXSgorYqX0X+r8xJFjALkOSmIYWyAqzxtsvcNR1IyShgYHLzKGawEkMzUsoXsdYtqGsIhu1is1I4dzaOxrqCaFNIMGdvWbNqdH3z51QulQy42LpmA/D+iXk7lfeoUf6+po8goM7aR+q9m1HZNEPfbaqClxgHwU95VxoJzU+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGbO0oHMRs4kOcsL1MpFT4oCGnyIn+m338RtGTwVDGY=;
 b=ngsN+auJuxDKpyLz2vtfTqEsf//n3+fw3IeBeAfeuRGdJXGiuxNtI3JULtjQGcBdbmwg1qFOGdLX+LgDgAx7S9jwoT1uJBgYjSBg436CNYWCoJqso+8utSNUCVtlzP7vnr+kkLyXELHbaeZ3OEUxjuXzyneU4zRVC+qQ+wOu6clPF0dEc6DWv+x3fZzbUDjgdxkMBpf3dSv0EMt3uBSCm6p1Rz179GfnEsiGY/mzyg1RzIMW0YUWVY8o0VYg3ML4GZdccQBwBYKAhqg+m7xesOlYYkZmtsQf5D8ZWGhpNTpCMBDilQuJ6kH2/aP2W0EC2PuoHANUonfxoekw7NMMFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:16 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:16 +0000
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
	patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 02/15] genpt: Add Documentation/ files
Date: Tue,  4 Nov 2025 14:30:00 -0400
Message-ID: <2-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e127d9-807c-4244-d964-08de1bd032b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FvxfNKpQ8bNA5t5expdDkqQxw8XnYjz32rw4V3P9XVAs0SlMsqtwxAlXunj?=
 =?us-ascii?Q?swYAv3kOReeruEXha8c2C0Tzw60Zo9SZF2f2ovIAuXiofWaC1Vk7ocbL2F8r?=
 =?us-ascii?Q?Ov9iSOj5T/Sos7bJJnYx0p+3BAVbKs8uvbTQGMdOTlZzTu2GDKT13fsi0nRJ?=
 =?us-ascii?Q?PtUx98YURc6wwVQk1IhU9KiJ8w/zBMXOtvoEF1YUdMb1SWLSb337Xox3PPGy?=
 =?us-ascii?Q?yg4txq8Ii4hijNkNUrAPE25NEMrB6jdw6G6meKFiVEuetdy87Q5+I2jb4M2u?=
 =?us-ascii?Q?8aakfPpUl472hZUMK0mFuINagDril9hS9OuQ3tV/2xn4oN2totUT1t6H0P03?=
 =?us-ascii?Q?EyYjLATehTWDVAJ8zPKUfp08ExF/jkk2s1eHNmNuORH8h6rWN2rAXNtn+wT0?=
 =?us-ascii?Q?YZOpoEUtW7gWz1AVlW+Pa6VUFnP/mN9Xbu2SY6DpPn38JAKo4VZoqo+wP12f?=
 =?us-ascii?Q?EnLizRuM7i6q+p0uXdbOyoriOkuLl2dDjXC2kZF3Cr71qZbe/i4rO7QGHEzc?=
 =?us-ascii?Q?3kunJZK33SbyYFiOjLYnomFgVMtqr7o0+Os8P7zwhkV5jVgRVEpuuBcUnZtF?=
 =?us-ascii?Q?OKcVJ6G8IDtO1EpZnwc4efp2FKsg0M9PAjUjmPiEl5eNrVJ/NktWVxcDvSrF?=
 =?us-ascii?Q?lWsvQWe5f0pc/O2ynwH42DqWXpZwc95oz0RGBgHT6g0MNzxvuKUhFQj+IWvy?=
 =?us-ascii?Q?TI4eRJtGzEV3YGlT/m0J53UwNpuwtyDkP0JX/eu6ME4xyhy14vKGox3Ai6m4?=
 =?us-ascii?Q?8ZR1G5ZKgqJpGgNr2HXYSaV255uhMejCLufRHScLxqL8TU3fC6Igwtt5jwfu?=
 =?us-ascii?Q?n1aOGEBQHKLFvEo3FJOLp8aTdHYfBce4Ge3a715oBqkpeb+IGAC2uFL84juT?=
 =?us-ascii?Q?Yx11FM/P/EGR3c87EwitP4nVdLzG7kOdhoQRU6MwMzYexwaDyO7cm+uixAgf?=
 =?us-ascii?Q?eXydvG6Lw6W9TFKu2xLiYSkX8L+NwGyXHHs1dXsIWcOHZLr4cIomQXK7ety4?=
 =?us-ascii?Q?E9VzN9FcSMZQVhBR9Pj4rAqPp4d9QOpkhk2ekjQo1UG1sDIKwDFF5u74G68E?=
 =?us-ascii?Q?nnh2H1c3WMQ1INBE/S9UHJZ/XjfI0PiITXmQ6NrRIZb1PKtegg3t/2qbE6od?=
 =?us-ascii?Q?dyorIU+c8TKNF2RynRHTw59syNDIQm6TUVJFw7GtElgtxzd/x/KmZerBjljw?=
 =?us-ascii?Q?sD/QQCGlFhh8swlGizV6DgeX/L5qoppPNSZvzEH+GSnPa+uuM/iiMmaepsYy?=
 =?us-ascii?Q?GG1vmWHA4zF4kCUAZGQU6c63xD4PkXMYuKLtmtYQyyALCzZJTwQxy1B0Q/Wh?=
 =?us-ascii?Q?NwLNqPofROrdgTrv2fIPz6xG9ZB+PgzY3E8Kisw8uAOvYrMhENQrzBeSpQxU?=
 =?us-ascii?Q?RlIyEfCQMdOJ4il/O4TQw2nEYnSBpjcydEFAx+Asp8g26FJbONwhBBtnLaZ2?=
 =?us-ascii?Q?nPt6+ECKhQ5XLMB7GcspVdLMbW4iTpsaHC8zjf/crbsG+J8+bk5Ky6bRDG/h?=
 =?us-ascii?Q?1ZsvJF2RU+swG/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPcVZHaCfxCZr9K+xb9A+PS0Hd+w6zYpVsuw2pRTJntCsBo/47k3xJdPakIM?=
 =?us-ascii?Q?UBmN7A2TtxtviMCbmvFZYY12ruGSPZNwQd3/+9qzlb8oHNJvqdxyJ7ivoCMV?=
 =?us-ascii?Q?vhuDy10wymA0ngky5ztWlppFyl3isYD9Chr3pDIt6wIBufkVi5CJxI72hL4Q?=
 =?us-ascii?Q?a5g0cIaN/tjGDMpVrdwpkxr8ZsXKGP2Bjzbqe9Sr36QRM/TMf9DLUOLgk5Ye?=
 =?us-ascii?Q?w/KsWbqFM8CvYy9Qk1z7tdmKwo2UzKtq0no9TdlgOxuT0INe3/qSD3ce02XZ?=
 =?us-ascii?Q?FLN5nDYLix+yyAUha0Fz6koctSV5KBzrEB2s86rzPgCirNgfJPzUkjkHcAgd?=
 =?us-ascii?Q?50Fog4F6TuoNOYCmxb24AJEhkPHTb/QjtL2lPj0/BJyCaTxtBfpYeDc7XbyW?=
 =?us-ascii?Q?VSeYxbqfSpMivL4WsU1LqlXkRWRrF2o1toAh7/9CR/dgAX60YgspIq7yhm0U?=
 =?us-ascii?Q?sst6B8OpF3uLGkbzW8JUqgMmaq/kLu9XZ4yy1lWqKJ+k9a9G6HcvjwUOPQNc?=
 =?us-ascii?Q?XueDg10Y4TB/uyslbiYFEVFFP7iWX+hIjioIJTcgq4u8LQsZNQDDupKB4EYK?=
 =?us-ascii?Q?GV9heVmykthjTCUUSQmw7GgMin2Agt0ajE69gUGiXBjhKitvQB5ZrtlbcXjQ?=
 =?us-ascii?Q?fKKc1/lZ6kF02WYiM9YOLnAei+RP/4PwSX1wKYQAsMny7lD2XcQQj3jhGkB6?=
 =?us-ascii?Q?qYWu9zwZLEMW1oTtHo9tFFHCwsrVLQ59ku13v1VHJJ+RLL+DZJo7KiDxdlw0?=
 =?us-ascii?Q?kan2Xt4zyMUNW2SiMiAKCLf/Jz4uWyVEKYGzbVVOlmMPnx5VTzI8UUw0zrYt?=
 =?us-ascii?Q?W6LBADkiY08IgJ1OCy9exSnztziF31gQG/U8MC7CxjDfYkZUOqgwaLbT13Gp?=
 =?us-ascii?Q?C0isAkkEaha/tyWbyhFxwAqYkI8iziV7eAMO1aQdhKVFwZpEFHF7iQDP3NWV?=
 =?us-ascii?Q?aPsegfJ5QLyRHchnqnmjwl/x4g20pAPubrXNFHxmWAYmStZG/uJcoxx5hBL0?=
 =?us-ascii?Q?CkvtdvDlPP+zpbg2dJsasX2ZBLd6U4wui3MMa6Eptyr92JgmBo7SSkGTzcCy?=
 =?us-ascii?Q?qeOOgEHaDNlPbrY9c5sebJCsgEwQJPMC6IoilysQfYxOp44zJ+oR/QFr8/+T?=
 =?us-ascii?Q?yRjDTHkopNtUNb6Ud7G3Aj1Xhem3CnCzZtW1pmylxoAGJsEm5vzfy+PudK+z?=
 =?us-ascii?Q?h9R+VWCLxF0Yyqf+AOyEcSRwm7gd3gwQwSnOkRnI1Tx4XqGcCIJ8VAE4ENBn?=
 =?us-ascii?Q?M8/KAJw4IbEAiYTwh1mk4IXdCSXMmgp91aAi04KpWkfi8VqUfFbEDjwU84fh?=
 =?us-ascii?Q?bEoZMuhzXNGW2wY33a2/heJY8n8dx4OukGe8B77jQOg4hrFJQJnDdmvhkmqm?=
 =?us-ascii?Q?+0hGLboH9i3LzqAcUiROWjZPqdl6rCE2ZZoj12mxARQZgvXhqhgGOLWlhXI6?=
 =?us-ascii?Q?BKGmCoV8p18AHMp81wKbuZnK0IsOceix2nTk6/bR596Xy8ltt7iDXWV6aTqP?=
 =?us-ascii?Q?L/wqPzxl0M9X3IwS5zSapyf8ImwMYl2ycwOBKbvtCmJuhYwUIUMSWHgyZxMJ?=
 =?us-ascii?Q?qSpOIRgXsjyCeBcAqFY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e127d9-807c-4244-d964-08de1bd032b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:15.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJPCpXgjWa/ozj2ZIBXP5MrijoOr7s1yXdLzFIo9bqfAJgscT+Y7DV78rmTpKgzP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

Add some general description and pull in the kdoc comments from the source
file to index most of the useful functions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/driver-api/generic_pt.rst | 142 ++++++++++++++++++++++++
 Documentation/driver-api/index.rst      |   1 +
 2 files changed, 143 insertions(+)
 create mode 100644 Documentation/driver-api/generic_pt.rst

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
new file mode 100644
index 00000000000000..210d1229aa1c1f
--- /dev/null
+++ b/Documentation/driver-api/generic_pt.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Generic Radix Page Table
+========================
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:doc: Generic Radix Page Table
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_defs.h
+	:doc: Generic Page Table Language
+
+-----
+Usage
+-----
+
+Generic PT is structured as a multi-compilation system. Since each format
+provides an API using a common set of names there can be only one format active
+within a compilation unit. This design avoids function pointers around the low
+level API.
+
+Instead the function pointers can end up at the higher level API (i.e.
+map/unmap, etc.) and the per-format code can be directly inlined into the
+per-format compilation unit. For something like IOMMU each format will be
+compiled into a per-format IOMMU operations kernel module.
+
+For this to work the .c file for each compilation unit will include both the
+format headers and the generic code for the implementation. For instance in an
+implementation compilation unit the headers would normally be included as
+follows::
+
+generic_pt/fmt/iommu_amdv1.c::
+
+	#include <linux/generic_pt/common.h>
+	#include "defs_amdv1.h"
+	#include "../pt_defs.h"
+	#include "amdv1.h"
+	#include "../pt_common.h"
+	#include "../pt_iter.h"
+	#include "../iommu_pt.h"  /* The IOMMU implementation */
+
+iommu_pt.h includes definitions that will generate the operations functions for
+map/unmap/etc. using the definitions provided by AMDv1. The resulting module
+will have exported symbols named like pt_iommu_amdv1_init().
+
+Refer to drivers/iommu/generic_pt/fmt/iommu_template.h for an example of how the
+IOMMU implementation uses multi-compilation to generate per-format ops structs
+pointers.
+
+The format code is written so that the common names arise from #defines to
+distinct format specific names. This is intended to aid debuggability by
+avoiding symbol clashes across all the different formats.
+
+Exported symbols and other global names are mangled using a per-format string
+via the NS() helper macro.
+
+The format uses struct pt_common as the top-level struct for the table,
+and each format will have its own struct pt_xxx which embeds it to store
+format-specific information.
+
+The implementation will further wrap struct pt_common in its own top-level
+struct, such as struct pt_iommu_amdv1.
+
+----------------------------------------------
+Format functions at the struct pt_common level
+----------------------------------------------
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:identifiers:
+.. kernel-doc:: drivers/iommu/generic_pt/pt_common.h
+
+-----------------
+Iteration Helpers
+-----------------
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_iter.h
+
+----------------
+Writing a Format
+----------------
+
+It is best to start from a simple format that is similar to the target. x86_64
+is usually a good reference for something simple, and AMDv1 is something fairly
+complete.
+
+The required inline functions need to be implemented in the format header.
+These should all follow the standard pattern of::
+
+ static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+ {
+	[..]
+ }
+ #define pt_entry_oa amdv1pt_entry_oa
+
+where a uniquely named per-format inline function provides the implementation
+and a define maps it to the generic name. This is intended to make debug symbols
+work better. inline functions should always be used as the prototypes in
+pt_common.h will cause the compiler to validate the function signature to
+prevent errors.
+
+Review pt_fmt_defaults.h to understand some of the optional inlines.
+
+Once the format compiles then it should be run through the generic page table
+kunit test in kunit_generic_pt.h using kunit. For example::
+
+   $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig amdv1_fmt_test.*
+   [...]
+   [11:15:08] Testing complete. Ran 9 tests: passed: 9
+   [11:15:09] Elapsed time: 3.137s total, 0.001s configuring, 2.368s building, 0.311s running
+
+The generic tests are intended to prove out the format functions and give
+clearer failures to speed up finding the problems. Once those pass then the
+entire kunit suite should be run.
+
+---------------------------
+IOMMU Invalidation Features
+---------------------------
+
+Invalidation is how the page table algorithms synchronize with a HW cache of the
+page table memory, typically called the TLB (or IOTLB for IOMMU cases).
+
+The TLB can store present PTEs, non-present PTEs and table pointers, depending
+on its design. Every HW has its own approach on how to describe what has changed
+to have changed items removed from the TLB.
+
+PT_FEAT_FLUSH_RANGE
+-------------------
+
+PT_FEAT_FLUSH_RANGE is the easiest scheme to understand. It tries to generate a
+single range invalidation for each operation, over-invalidating if there are
+gaps of VA that don't need invalidation. This trades off impacted VA for number
+of invalidation operations. It does not keep track of what is being invalidated;
+however, if pages have to be freed then page table pointers have to be cleaned
+from the walk cache. The range can start/end at any page boundary.
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS
+---------------------------
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS is similar to PT_FEAT_FLUSH_RANGE; however, it tries
+to minimize the amount of impacted VA by issuing extra flush operations. This is
+useful if the cost of processing VA is very high, for instance because a
+hypervisor is processing the page table with a shadowing algorithm.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 3e2a270bd82826..baff96b5cf0ba4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -93,6 +93,7 @@ Subsystem-specific APIs
    frame-buffer
    aperture
    generic-counter
+   generic_pt
    gpio/index
    hsi
    hte/index
-- 
2.43.0


