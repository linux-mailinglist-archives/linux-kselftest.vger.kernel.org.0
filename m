Return-Path: <linux-kselftest+bounces-40698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D332EB42834
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9760C4E2B2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1032A828;
	Wed,  3 Sep 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jrfAvzEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25932ED2C;
	Wed,  3 Sep 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921622; cv=fail; b=rcOBR6vYQf9VouJwATxSSBnAMCUFgXKtHJ+my7o+LbABPhybIh8iWkj1EQv0zxf5uHquo558/yQs2hdQ5Cs92bJmg86nluWAtn0KgA2eiw2JoXa1QTuoSimkM3YbtTVybCrFK+jfG2bRqOFh84DwrGZkLWAk90JAXVSrFcL/8aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921622; c=relaxed/simple;
	bh=Dn9egbUZL1yuQtGgjyVeWRX+m0OdulbcaxNAlO5LPbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pCO0JaC6HqsJ84VFlQkpzPPV9xUYW3IAI/2xw2C/EVj8VBe2Xz5abvFOhHKqlLx2qY3VFsz50jODZCgF1JVKiMVM0V+hG13l8kwUBjZTWL+h3uPVV6M0GPCgA7in6HKsHRAZ/xjmuGSJ7vk8rgehcrB5w1u1HPIEe1c4FQBYDxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jrfAvzEJ; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqZpBax+mVAU7sJX6FWP34uKjKMJkZA7xu1OOOxAw+mRclcONJORJ58ZaPkBeo9+OXaZ2XFu/R0c21JLlAiWkjsj6zyYlIC3BW1utnkKb6Hdvalbhv5+1kBHnILj3a04wi3ifYhiXHZdnL11yAB+A450IW/D5jJXmLIAwp7yjvN7k6+SCKhgi6yDjhANASUNPbLUtzaUGaCtsXNbylvAeBYIk6AlshfZG9ImQP3i0WKRn0iImUxF9bMcjjMzs1Kk/qnnF4IXp/nDnr8lsvfvw5nBUYKsvRP4cMfguiMZdRDIkBTvxjd2DvZAYNtyf8LOCvAfUmSqm4/JgZEJAocNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq2pTih5+iutUxHSY1Vk5+kNRPZWao0TEEoUNfRzxqw=;
 b=hcr4Am5NYuT5KQvE5tSh3UYF8+b2kswLgJ8cTIdwnYK6doEhzMCz0ulPVgRgKhdVHKAbIGDXBZl+6XMkwjMnkch60jFAqTI6WIpLOV3i72kFbsDTUS7NERAXfeTDy+8RtnuKXghRgQDXu0jMMYtADDhgAclWyulLTYpaT+tQgY2hi3X6W8bMTnTq6UQaHgXZj2dpwH39I9/66CaYPyFod3uEqfzsBHWsO1wXGgstGN2n5Fr2EwjT8JW2w66t4EY8b09hosbPCR3Y5/fIB0qSWCk7nvfreQUMqdXSyK7eXqKNWZbGvGuOZhlKVvJmGwzSnwX4OCxKuL06qvKyw1+9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq2pTih5+iutUxHSY1Vk5+kNRPZWao0TEEoUNfRzxqw=;
 b=jrfAvzEJ+C8j0dSgkJ6+R8EV982iCNY2cFx7JREi6kdv4S39Nr0t3+d2+8/LzfUatUgqXtENKeeUPBO+FXhXORh5fqjR4LwvyLtrjeKf4LDFOL45siuoytkFgUiWAac4wvZrJyv552Yk4UtLajx3qCDU2h+Rxv77axxLCD5oVrQMaPxEHxJyk6QzdSGhdLwr/KXrAS0Xz5htdFiH+YY5CqjW7Xu8esvsNyMy29vMqicm4BMCq2pTH/pnLAiMJWx7t2r19R+4kTuSczu0at5qymCAS0mB+4Tj6vnrdlSGwvefitNs+qBOrxCy/5JqXIlvHIX1/b74niC0rQkWg9exbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:49 +0000
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
Subject: [PATCH v5 12/15] iommupt: Add the x86 64 bit page table format
Date: Wed,  3 Sep 2025 14:46:39 -0300
Message-ID: <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e75849c-3606-414d-ca13-08ddeb11d914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30F1UQHyl0unjZsuiiKXlpBmf62QBRCaz9dWJhT5wwwd3HyAytFIK+wDJ3gs?=
 =?us-ascii?Q?llQvA7I9anhajHlCcibgVrgBaULe5xMx4s9bzjpi4APgFklWPt3wttiuNtjV?=
 =?us-ascii?Q?yczrs//j+/Mg/QNMf+MEJnUFMFtW2N0uC9nMSxX6wb4N9DPMgXrGBjJPlWXW?=
 =?us-ascii?Q?GU9+OryufMpdHkJJh+ea4ES5a5dafMJEXpxDmdncjgvo9bIueMv4N++insku?=
 =?us-ascii?Q?Xa0wZSVaf9jR5ak2eH6+Z2vejZdu+Qgn5ZMRygKy0lwSZGRt+ueK3VN7lzRm?=
 =?us-ascii?Q?cGWBQFgxSJE5tnxhbCLfX002TTDz06tSPzuKPnoWSWAyVdMPhHgye/0phPNT?=
 =?us-ascii?Q?aQRkyEyxL4yauKq+XNL9vt+VKUryhDr/S/58diX+FpqwaUqL+DdfD0xm/ZPK?=
 =?us-ascii?Q?qbfPVq1fCYXTMrEdQvN/YvoYI1T/vsDFX+el76IsgmWqWPlL2/YfqmXGWTuh?=
 =?us-ascii?Q?OUt36RLYTMFiLsytHIE8eepwvmBZQFJZOByivYhzCHl6wWEMFDKrfzOWbR1h?=
 =?us-ascii?Q?EQcuXAFObg0tC5nMdtcdVbFLnkA0d6JFFZIfpqrktSgANa+GZJvnJfoo3qUI?=
 =?us-ascii?Q?xEzk7sFr8UtHQ5S5HR1PoQJL4P8gI8PlLCylxWC7ZZeDRUDC3km4MCIRd221?=
 =?us-ascii?Q?V0sDQR6Z0f6appUCt+98vta1i+7AITA7txZIa93vgaEiSR5+vuzwKpjxADPw?=
 =?us-ascii?Q?0LpLfyMS+bTWlNTNzWKHKEEBGOtygrdDTSAF0oFw8ECJXTpXn+Yiv5Ai+EeB?=
 =?us-ascii?Q?7KIMcXxib9i1dVGnHHA1QQmjXd1DM1OD4MIQui3SOYTS7J4p6Iep19y9ARHO?=
 =?us-ascii?Q?JMrlB4s57cB3xkN6jkF8kRVXZ268JTHkfx+hLbt84C8X5gH7XjAIi4kGQP9g?=
 =?us-ascii?Q?Po4C7SgvHV/rHnXYsIY5XCuf1EPpwtGoRZjE9MBLXVjNOPzJameWGniCnA6Q?=
 =?us-ascii?Q?I1qSctgcLgyKB05CC3zvvrkx01wYQqx6mZLSQ24C1g+QJGo1FA/c1dl/p93M?=
 =?us-ascii?Q?WtfyQrm64pxsYDaB3cC++QAlgP5dWweZKoZRctIOuViIcmVc9hx09Dao1Gm9?=
 =?us-ascii?Q?h0LFKAkBlwcsXfVuFxg8erW4YsY46BHo/UTEW8ubCjxEKURyq1Z0KL7CcAPy?=
 =?us-ascii?Q?bxiAj7wLuAshZAdgXWIb1RgCQCAG6ek8ooYuJL6R4Fv7bzzEA+igUYFbfgcK?=
 =?us-ascii?Q?2ZmRGHTjTdT6jnEEhX249NZEwIC/hPbpdc27ns6RPfYPg7MCdDwd+ovCbSxK?=
 =?us-ascii?Q?JTYHZed31IpaH6A8KI25R4jeWN7Sdj88ZQS48NHJZhHAiEJbKrIyphc8Wgw4?=
 =?us-ascii?Q?6kuF06ic/vzIfeT+fP8ZRL1kMFruDjGI5eexa+7TUyrjFEPxhwY9uADIQqrX?=
 =?us-ascii?Q?sHmnqGd7GtpdL9GAQohIZbZDzX99VVL9lqmIfNVzxjn4iXWMEJhFM4DlsHFu?=
 =?us-ascii?Q?9egB7PtLTBqjVurVpwBHbIM0TJRZnMHHpY54BXjE2Bw+/Fdx3tidwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9h1thtbk2K3ePTaiOiC7klDptguKC0LrNV4waQemZY2Jq4JEh82oU8sF0kO?=
 =?us-ascii?Q?I0YsBv8/BcDoc6KGiIhYx63j5vC2NRCaRlFAvxFME/cG+oM4rNxXRwMNlBle?=
 =?us-ascii?Q?A503k+BjVTWja70k6klAst3hLhNQgBx85Ux81NLZaYs+fR0QJE8D4wittXHz?=
 =?us-ascii?Q?JlQd8Yr5Ej8TGxWMkyK03MwBqsuVk5+vvVKGQwnP14TGZjF9COUHhWgZU1QU?=
 =?us-ascii?Q?PvSbIx4wj/WJNVaAIKvGZnPOcV9xLle5KrqCDVuwZqA1+/o/ESOQ1g1p/4/v?=
 =?us-ascii?Q?skF4W8ZunYpCXxOhWzM5+p/R9wa+0OwiQuZd8JSawjCBcxJ7UM/fiu+Mm35u?=
 =?us-ascii?Q?8FakGG2O/XqDIdgUnYnyGNQd1B/yhBJ8JcPzQ8kRG/xtMqCijGKW2DwFbLPC?=
 =?us-ascii?Q?HfnzemBvnYQJYd2du8Oco/4rJ1O3R5XbpiatNeigmqATYRQ5VJ28rAJXOqsC?=
 =?us-ascii?Q?dsaQYAewnFZjqrpPSGL9k4qSjQQuA0cSQG6W43ZDFKZw1+/XAxlHsdavDHXC?=
 =?us-ascii?Q?KWw1ChkudSgghDm7kTAMc52nfeeKYDmqN5Wpjlk6SQYSXvyQIOOg0XoSZmJd?=
 =?us-ascii?Q?yBasLqK+ZTE+0kuTJSPsZMIbqbDI3lIWaqy2Ukt82/gJB+c3TdC1llZgHdzQ?=
 =?us-ascii?Q?uIGBLmsYrb+dOwjm95AzXD5VyNmwSQsKcWmFz8yzjw3Dt4rt8ckS1n24p+9J?=
 =?us-ascii?Q?mb3T2ly3iFeNSzFzee4iCtPybHveJsnM0/k5iLfgYHNsx/a8r6m/AIdRx7E2?=
 =?us-ascii?Q?4XCSalUsNANq/HuNkUwaKZLnTIxg0Om6xVcGwLegGxZ7l9OjmQhU8HzFgEKi?=
 =?us-ascii?Q?29VAJpqWPz5qQmnseS8lNNnpBQI9MC9wrhN+S3UfvG8XmYivsFNOGza8buSr?=
 =?us-ascii?Q?mlrAZ9gng6jLGioFaSIf7veHamhHiZPxLA3L2Gh0KrWu1W3HqWriWWK7G86R?=
 =?us-ascii?Q?xy5+wRreixNJWBUuynX1wCUtcNWtEeyVkE4PC1HFekFWu7g4EdmTSMa2B5/j?=
 =?us-ascii?Q?hHZ6tdT9g4GsB7r55j+oemM8TxHEddyaBB95DXBOvywycLPYbprpdB+0G0Oz?=
 =?us-ascii?Q?ZpWTHxstCOYf9wCrqNzfv1PM35h98+wzMl84BxGlcM81iq1kStV0PoY+HfO0?=
 =?us-ascii?Q?PZwZShQUlj/k67l6y/R8hwmHw1WWMTVOUSaDO/ovNSJCHUyXR8GqX4uQaIO4?=
 =?us-ascii?Q?44KFq5tcDzFThuogbIFdPduR+Ewutv3plXKzv47RF9L6IqYYihld5CTPusHe?=
 =?us-ascii?Q?uIDML+m1e4WzR3Zb0YZ27rfhHPEI16VG8bVVl9W4xnKfkCZNtG44gGJyBIM8?=
 =?us-ascii?Q?1Yng5aTzPzmVfwq0kJi/KMzHWb3RoN3dKsnj7EwCB3ixcZWlqMnH8vAPLEnm?=
 =?us-ascii?Q?qcL/uRRoyk6OBpFIy+3UEHZMD1b8mAzBfpLPYYO6Mg78QSfxX0vCrNKsf6OR?=
 =?us-ascii?Q?vs4OVTukidVtKyjHmiiQayztA4P4qK8UUrJ9YzJsK5ZyEF7SSExBHoE1J3CX?=
 =?us-ascii?Q?ys6DO+CXP63r1iAbJFqYygoyurXHAfL/QqnyuVZcLCuJZr0i8qSRcngz+Nb8?=
 =?us-ascii?Q?i2FscGm+qJXCfYC9l1E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e75849c-3606-414d-ca13-08ddeb11d914
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMekEm1b1XQmhM0lTk6U4AS4aOVfwziviFZlWBr7iZXTWOmu1xf7hchGhYMzgnc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

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
 drivers/iommu/generic_pt/Kconfig            |  11 +
 drivers/iommu/generic_pt/fmt/Makefile       |   2 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c |  11 +
 drivers/iommu/generic_pt/fmt/x86_64.h       | 248 ++++++++++++++++++++
 include/linux/generic_pt/common.h           |  13 +
 include/linux/generic_pt/iommu.h            |  11 +
 8 files changed, 318 insertions(+)
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
index a117cc23a1c328..5a93df987e8728 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -41,10 +41,21 @@ config IOMMU_PT_AMDV1
 
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
index ff4da1ae95087b..1cad7b16013a60 100644
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
index 8b48e374d983f9..3e0bc7938d954d 100644
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


