Return-Path: <linux-kselftest+bounces-42834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA8BC20D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E501A4F657E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E962E764A;
	Tue,  7 Oct 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWUtoEPh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910C2E719D;
	Tue,  7 Oct 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853543; cv=fail; b=h1R46fjYqUmQBrnwV65HOWaPoSn3ITV6tydshUFzNqe+2fLPznTxo65Kw78AS1kBGWvUxF8Yy8obKsQKUoGIQTS8hZazyxguU7T2OWw/a7uZHG9v9bN4lRrKW1TqDiTDhiV+LBxa9LnfhXXO3ldHkLTzU9bB4nNlluvezhZ5//g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853543; c=relaxed/simple;
	bh=TgPBt14kDd+f7apDI1jOtceVXhtRJ2g/uUd5iddvOQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MIR7zqL8N6QFyTOAQy3nOUy8SK4fpvPrmrnZPbgyR2EBWDNmGJSK3SFryBFnnAARHNaMHL9ftX0EHTfodYFp5fhj+DSdSw7ffoE7KC0v/ofEoze4HEyHWwtPSTtg8XQgBKO+HoEr7O23xNCib3aYp0t3J9Ww/V8dynHGXYAB2lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWUtoEPh; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzBP72GgHu9NJVKBiZ6pwWl4SoK9NB2/01MPtGA6FsZnFZbdx281mkmjX7IuX3ZoKBhNwcDJ138nqUX8IMr4nAtcoxEkVkxttiJECxGh168LZHiPpRny6d+mbAEWfO20IGrqI9SyTXDrYJKGah7lJ1dogJgznhNh8zXDIgzuKZWTw6UUnVyZUTxAilAmKI0r9MNaEKLbpBLOxhcDdxZa0vPMIWT15+dKs/SUGCVYSB3P2VA+nqFduEoOANJhHvdu8Pxa45gq/zszKCk56No31a1c3sAymwxtnW9zBtR65/o+rBEp1TSFPRDmtgZayf/cb/RXYK1z3Pj3xklKVaonlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiYWWSGwTlxVPlU8arGnl1NUvE67MQbst4H7BRkfHqc=;
 b=qJ21tJiaABVugVEayx4tSyafagGxMrnb0mQUQdMxVK0sZUswKdcq1ozJBP1HtgK5v7bOIVmmeJmkHry2K2X51L3mR7AE7EzT61YpcSPLePavhgY9+64PA4OPtFLjxc92e0ncSrNFrnkzGyig6jJzGElL/tPKQeTmW3CCwcGPCNNrNLmOCclLhm8bvSzC3alW8xk3cR7Gab+TsD1OJIJQ+J/jmchzvYRDXdF8OByp9K1aO84dySbD2J9V5l2nNR6Ydp4Xylvw9THvQmgKSrOstOAIBIkPR7XHXRsqGrnYFxdOmeZZcGcEVPgjKjMIm21BMMnEylZMLXprgdDqA1oFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiYWWSGwTlxVPlU8arGnl1NUvE67MQbst4H7BRkfHqc=;
 b=HWUtoEPhosQIPIA01bymxAWuSJbDhh2nueESFH77j6dmVrFrtx6BZLgXk3Xm9+rbhBz56acZA49V2mTQwkxQuyEDO1uGbhoBAvfVbqEK4TYsNEx517z7gjNOjMF2PScqy9XqDlTn0e8ugztrpxINYRreHmliF6km+JvKOCOkyXUbg1fLtba8tyXUBoElFGrjZtJEkn5wt5vQSYTgWlQ9RKFG3LebmsDYMvAl8Nb55SnO12qDJwLlj5+bCeNe6OR9mBKdm2XNMQcJA8Pc/uXhwOqnIvq6jLpEm4aabMftG1EYzk0iZ9Z/cHMoC2AUUFQ+i/+cbLEFc4tArc1lOmENcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:12:10 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:12:09 +0000
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
Subject: [PATCH v6 02/15] genpt: Add Documentation/ files
Date: Tue,  7 Oct 2025 13:11:47 -0300
Message-ID: <2-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0362.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec85e40-2cb8-4128-ac42-08de05bc41b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bG/la6WOarNcBRMdzdcYoARPwxCzwlrqQQOg7m6e/N3CoCIU5w5G68RqDMMy?=
 =?us-ascii?Q?YgPdOjs6TMXmTOhglqSxap5+nYQJtfLH8jvPM2M4nkKt6LEz/U/l3z/Vxsy7?=
 =?us-ascii?Q?m2PsWtQfGz6N985DtEeJT6FH/S02HdwWF3TGIxV+riKvhL4+Dz8GcYYUb8W/?=
 =?us-ascii?Q?C5L7OWOa9333qxk5OEvhaMdWKwkJBV0y9qOsPcwLYfmjahVaR3HXcEmIQfQ7?=
 =?us-ascii?Q?AUoOeCBIqjnBYTV1NsE26g7Kyv8tmECrOgJ69//JAVKX8d0n2N4D2o9BDRyw?=
 =?us-ascii?Q?zWwaXTQLzJkznZ3lCkv05HFkuCIwd/ljF+h/9KHocoP86vZvN8jMtwEcYwVL?=
 =?us-ascii?Q?tPNRaR+hoKKZtqLo6m06xIOYaB4XjlIh1xpuW1q/Co/emtcqCbwnKPja5VNj?=
 =?us-ascii?Q?Q+eaX0qaUqX+QT74FkqpmhY02j5O/lESPy9E+voelU5oWtyZvRBqHZNQQftj?=
 =?us-ascii?Q?lXcy1Tha16WrUPDmDTw31pMHbYrO+mGT5dP3eXZdPsbhCsMWpNV7kOMPiXxI?=
 =?us-ascii?Q?8mQ0dvtQvIqrBXnVxZabV5/HtL9F7hfnVY3XHYpIm5aLs7/Hip/iRikCpnXX?=
 =?us-ascii?Q?ikQ+84KyyeAPAIvt3ufaNsaVSOMrHCxQWVssz/YL1eKwp9p5/Lt/LakEUwkQ?=
 =?us-ascii?Q?Cm/cIKQ4g4E77VqdqOIo+jvLh6vsPEpv5yeRwcJwfmullIuqnP0W9H8ZkwAO?=
 =?us-ascii?Q?1Apq2m6lQjRO7f91JZ8H8xWx1ZK91zXxP6eLcNZWeLSytEs9qSRQ8GfmUtWf?=
 =?us-ascii?Q?qeLIDijHOiZYnJYFn+BKaK9kJ43ZuW6nsH/GZG5KxzPhs+GFxwLoHEwGz/US?=
 =?us-ascii?Q?njjMA+hvk9k1TTxp7I3pMfUo08bsMKwr7QY22BK+1oLJDibffDf93w0EFXe1?=
 =?us-ascii?Q?aX3otPRkmYrjYC4eiTNjp56/Mic+kZ2CmhumK078G+ZDL/QAuoIA8KiG8qR5?=
 =?us-ascii?Q?k8QN3hsrueK2GxOXVeANVzyAlrJgdd806AZBZ6AiwoCrs7w3VQDmZSFnWUES?=
 =?us-ascii?Q?p1nnVVfN1JHsnfuTl3tW2DKsrVN+1HbyoNXatIKRQnlTRmQ/NiidWWWjkFnM?=
 =?us-ascii?Q?JnO9PB/uVnIy90fiMiA21YMuK9l5b2vEti9M0cNJ3AxbrZ+gpcJEC9trTz8X?=
 =?us-ascii?Q?EjEYkeW3r7x319jw+nQfjGlU9aJZ/Fi+fweLndAz9TJSlh7P1/LAPhoGLNTQ?=
 =?us-ascii?Q?bJU+V23pbVfRTrpIpkNEx6tC3uWg8HXRr24pU9Wh9vBQD5WKDDED5r71e6h3?=
 =?us-ascii?Q?JIXgySR4wP96B4XII08GPwVzYCYuwfE/TPy/nc0ibu42coA9HHiXKw86RXLT?=
 =?us-ascii?Q?uqnpjtw/OsPsa5KX95pXkTyTkuaVbl0zAILGH0fOTFEuyClzEvdtVyEg5cks?=
 =?us-ascii?Q?xImQs8L6NdG0XINR6W6rBqxRlXrH2UzOj4i7SyNvrJNNje12WrSrgR3h1v/v?=
 =?us-ascii?Q?eE/lu1XHuRuozUCdBKPnXEM4mJ6iwpqHREXv9eh4q4MEQX3vi4A+FjpflWxT?=
 =?us-ascii?Q?P7qBtOvb4LApGzk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MlAasf93ZcrqFHn+t8FeheM83K1ZDd1oPPF/0ruMHF2sh/69DTzN6RGypfcQ?=
 =?us-ascii?Q?VtxVI7y8aCxsoBC8/Bbi3KtfPZ//x31xQo44QcNug1KOJmwi17yx9wwRtxAp?=
 =?us-ascii?Q?PH+c3Fj9iFHHmEnw1dOBxUXn4hTXkXdg2M82jO7CwqpNDTaohL0roXg6t0YX?=
 =?us-ascii?Q?KxgWmQ6HhEx3pYbqkTc5HWSsnUPVcVvcMZf1Sj3RldkDGjB9QrK/+i00yjB0?=
 =?us-ascii?Q?k7o7+KkOexPPhmCH6fD3QNFkU0OloMcavfdqwYMwYbWpfM6nsYpv+23oU+DQ?=
 =?us-ascii?Q?iQdzvrllLdOfS3BN9B4SDasyJEjgnPqRTBWL3KZ0lMAfMBDq6ML/c8RgfNEb?=
 =?us-ascii?Q?Iq5iY8iWFJDBoz7cesjK9PSMSFvFEOXUFCgSMXryJe9d+Y7ZNLBqSgmwugDE?=
 =?us-ascii?Q?sSEGiTcxfEtmKkYbDQRIBRP4RVecz21X1Q7dRyNHP0ySkH7NyEWI6iVM/iAr?=
 =?us-ascii?Q?1lRzIq5+y+EHKm7WTAC1x7WN2V06Bqjhlc2Ht9QEh4buDNNpD8UKv7t/Eg9H?=
 =?us-ascii?Q?9pyrSGMPoKX26fjAVgg/yLmxiDNCU7VHlpzyblz8VaMCAl3DFosaledsZ/Q+?=
 =?us-ascii?Q?q8CGWzPEMm+AFE132fk01DpNZSiGhgtp4Zq9jVyO8RXubkYmmiqsuBdQkCg+?=
 =?us-ascii?Q?brUfqkC9GSq86j5QUKTI6u0JO5JNOJ7uugBBf9vfn7C7qbW9Qe0ILutNJf8D?=
 =?us-ascii?Q?4cdzSSDv32m4xrCQ27XQ2qLAhF+l/oUK0teoxq08Fr2vzsvHz2KPP0+dIbjt?=
 =?us-ascii?Q?tAVf087fBb3abnVRAKkSiXtUs0zsKBOYlyUaAsQ716YIts2iQeFEZ7oFGDuh?=
 =?us-ascii?Q?wkrGGl6AXj5zJs12f34qnKLiTKeFpq2v5xw9JOUUYulHbJPMvl5qc2Hmp0Ep?=
 =?us-ascii?Q?jiFXS0n7swX399M4luljV9uhqHElYN84ifYH+GeYHg+tsVp+lEyIvbMe4UEA?=
 =?us-ascii?Q?OueaA2X36MImLuQagxzMr0zvUVDAJEIOV4ZOeI84TVy3aWf1wGqy9NrE3jKE?=
 =?us-ascii?Q?R9VpLCoAYScXnN0YN4gCVZAkM3Q917GtATm41vNuYMD8I+wHpb2qLl6/RTLl?=
 =?us-ascii?Q?zR9wIEtZr3eyf5U2N5HcbF9MK1n7voV2Nakmbt5OQol8FVhw0zorBKNgHWhu?=
 =?us-ascii?Q?frh+8Z9t4Mw0xWMCu9K7yqqJkJ+99fN2eJJm3ArKwtmijhAkddtMV2g0ywuC?=
 =?us-ascii?Q?vx1gk9ThaQrHyv7NziIl85EWN3KzQGrDzD+kWa7N8XJxqAE4KiUW+cqwvouv?=
 =?us-ascii?Q?xfK91xsb7RugJKrS6MkOlqAo0YfnkZSiK9ERXDsGEwKTmxIBVyR7YUX1fvmF?=
 =?us-ascii?Q?N64iqidJF94Kp69VZff7qMqDw/g142JbaAXywN3YVhk/uJ+ApYRQJYKXxLv3?=
 =?us-ascii?Q?t5q3UD7zrOezk56/2sBiLa93CjfHboE+ChlAPEMqa6g3/HIbOqnOtGZuDOqg?=
 =?us-ascii?Q?rKdcfwmqMsH531W/k3SufSK0pQe+ZBVBchN1bxyVnnXDtLUYxnFfRNQwg5Hj?=
 =?us-ascii?Q?9Y8get+4pIETj40KTuGVvCDs/Cri1X9mv3cremqItPcyJlMbKB+Z7ReqJQ2h?=
 =?us-ascii?Q?SsNn7ssguJb0Fw2pMQ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec85e40-2cb8-4128-ac42-08de05bc41b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:12:05.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9Q/nzQgWKeuEK4KEE7C0pPv2LNdKidDk3/PB/JYS54qMc7XUaLv4AflQZbvmTgj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

Add some general description and pull in the kdoc comments from the source
file to index most of the useful functions.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


