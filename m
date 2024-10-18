Return-Path: <linux-kselftest+bounces-20156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D79A43DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39846B219E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9F202F83;
	Fri, 18 Oct 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n1RjF9DQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9C201273
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269083; cv=fail; b=lpl7cHlmT6v+I4mtB06T9C+gz4ajLwgFJr6yL9pOv5xnXFLjme7kalF02mN4IiGl4W3Glbo6zeM+6OTj4BwT5moC46VI64rMLFKblPPGjt2v5KefufnUdQTZsP7OUOXiCjHuV5cpO9mrvtI7bDGnJlfAsPhyEDhvGFTZzEjgNOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269083; c=relaxed/simple;
	bh=+tgOKbCmcGgoficNKSUvmLnY4PM5NBlWIOWbcH+Ztjg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DaysXqt8LTxlasFj3u6r/YrHk7r6iIFcMHgABLuPka37g8YJ/8sj29LxcbBKhx1wxCfQaIYJvvmtoMa9pUBrwMfbLJjCG/4E+RYJTTDSmdckpkbR082cKuCR8cu/I3txosOS1hcMnwoWx5kkdi5tj4DMY63nwvWMtf+ISGM8OkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n1RjF9DQ; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGl8IN8je2P8YeTIo8amxI2vel5A+RLBetLv29/m3j7kEZxLRwSJTfQwzx/v6vjuNUnkYOqYjdHliHNXYU5LBrP73bgiXr9IrfJAA4bN0Wly3qh5EymtcpTArzzKg8vIet1eckX81HBf8B/d/jki0ySU1GKQXcnDevMZCmmo9RFsBGNiNC4H25b66LWL5d7INlS9064mfkE2kwqnhAYuJfejhRyWxccwGaq90MIG1y4t2ekficVk68yzKGn4/LLCXjpy/42GMHtTvyQUY8lH9k7zebbMA8qsvF3zqQwANDQuEemdvfVinSZTgSO+R9w+eJzI364Tj4VgMgvZVDwlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs1ECvGTFSekFx2J+unCO5Wmp/IISQsh+xcysf6S6nw=;
 b=YgbvOnfRReWIk/qVyY8q+UurmV2wyX1LpnOHWLRWyXcTVINdaexOXLZ7scGbooOvjvYqJJF+i1VUmLbzrfDipeo7RB/dxG2d02qDHRREZbwOTCWtds6GNAlQES076gGs1jzMNgnW2BU3WFuCuK9HGLFkA2FaWwawE9UqQKb8QJYAlBOmOCajc66G2X6s6HnamwFLxiAOVoLhl87HmY4QXIdoyvcdhZja+INLRlz4QE3DF+IuvcvAHZsYBcpCYsJW0JWOUrh/X+EN/0d3WFzA4JBV3T4eVKGKAh9fHmWoB9EsM+VJBSJiNq3MirXU8g5tb/ov7DvP3RbqL70sSp0lLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs1ECvGTFSekFx2J+unCO5Wmp/IISQsh+xcysf6S6nw=;
 b=n1RjF9DQR9/xUnMdcCBJTpEHaEF96CiRdt4wt2lt8ohpDF3+bfK/+0rd1C8q+JuoSTU7Cz7nVQL9Wqsb2Y/JVmkXC2eFxa9F9DyBhrw7VFl/braJ4SIECxbiwM8G4cdFyw1EROeDbeJYtnPHW1ZGzKMsre9bUWs3KH9Pgvq5R2a1/vCuqbIf/nJ6Bxx/zh6pVT8uuCAvl6QcGkJiaubnew2HwSHQh8qB2OWKLsNVK73gADrwDXKjx6CpC77oZBOQAvdxo+z0SeO3Vw97R5dzVJxVzXOEuK7skCKqXnWzeSsxfYqKRmH6MbbswTw3ff2Xq1dCRwrlFM7lciZK3chgkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 16:31:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 16:31:15 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Rae Moar <rmoar@google.com>
Cc: patches@lists.linux.dev
Subject: [PATCH] kunit: tool: catch warnings generated by the kernel
Date: Fri, 18 Oct 2024 13:31:14 -0300
Message-ID: <0-v1-60207444aa55+22-kunit_panic_warn_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:408:112::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 6570868c-48cd-437c-7920-08dcef924960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Hw4uiTUWPrkQV9uQiaRjbC1aY0slm1/IHCWfFOWBxZfn13LQvFzLmyhY2Tj?=
 =?us-ascii?Q?aI08GYdlKh3+EN5BfbkL2VOXpfKt88Mp8uC0HY9MoVpHC2tOp3KWBRDF8wXs?=
 =?us-ascii?Q?4Pbj87iwkegYA8jNc3qKJk5DvnSwE6+qyV028Mki/wAdsFRLxFWpqKdA6NOF?=
 =?us-ascii?Q?BS5nKKUR0hJZf0ECMyb1YXykwj3TD0s5X+QfQfBgE0ELC37/6vCT/nwtIM8U?=
 =?us-ascii?Q?ILVH9p2NfYWgSG0YUwORtCn62rRFOJd93+8nZ13izCnQ73gYwLBAwadUaCmQ?=
 =?us-ascii?Q?remu77qX54eYX01D0P7/HOQzqQ9EomKiCXohkHYK7F/HhC2AcxWfv9+lUted?=
 =?us-ascii?Q?W0pz5u12SK6jHmvKDqZrJ5xlSXCUfcqDA/jMGB2cGu6ueIb7JpPyMnQDrQ+X?=
 =?us-ascii?Q?na3UsQyGt7zSTeCLUWCI45InEKkYfEbmS9j2LKxOU7XE8B64vPG6xd++TitW?=
 =?us-ascii?Q?nIP3qUHidX6vxn142ot9nm9BQQ31tv71BMzeOe6yllC+yz1ia5r16z1WKWSO?=
 =?us-ascii?Q?gihR5OqzLPJMvNj4oxUmwtYJyBSh6J2LWt7J8UwArhGXXObclveDWutIjwGR?=
 =?us-ascii?Q?qzzSdPneuLEM2XQNTfs6WueNztD/H4m1GW+/Brr2OjVhNPoMNfGowP6FbxbB?=
 =?us-ascii?Q?5mLI48mgc8UfVfHSsBTxZW6oNPaclHZMwWHZkvOTE6kmRl8r0MIwDIKk4wpA?=
 =?us-ascii?Q?G+DiOLVYbnPDXvm9Pbv5H4+lYV9iumQp8BvhaxMbiEgLiZT1kjWcnTK35PWD?=
 =?us-ascii?Q?iUJQKAVzlZGpwk1lU/MRCbkrmDpSjnCM8Cub88TxAOwdrSj2kfVNgGF95uyr?=
 =?us-ascii?Q?twxzTLwdlCiRgk7n7KbNoESYEvrdXsYIbR+ofyUJqiGq0j+5ch5dpB2lKHaD?=
 =?us-ascii?Q?1cjRvxMwt+s/LV5KsSiISzCTtD/Npv3D6EkxUl8gBtowfLK+LrhGPkOMJDah?=
 =?us-ascii?Q?H/x8dDt6bj0VzIFk//3cCoCVu9//4wt3BWCxftpJOpHTfAg11PBlPraAwLIm?=
 =?us-ascii?Q?71kAp2/AgzmyOmbkinjVKkWvGe+Wmblntbgw1LnqYFrHWpdTGmnWJTkKMb+c?=
 =?us-ascii?Q?A1/BbNqhrxLMrjrGtv/cGl57XXmMsGAmpJgML6eEYYwDVnEYpjjEpTNnXf7w?=
 =?us-ascii?Q?S+3tG6010cPvf3pvvmRJI4FBd4WhF/bgkpu02EmhSPEnyJe8VUP6M/O8pwbZ?=
 =?us-ascii?Q?JMgPLw56lbg87xTKduqvpskoVuqkcIFRq03WGPFm29E+ck9eZSl9iCQfFArJ?=
 =?us-ascii?Q?XEgHuULNdbPYbufOICikF4fN3xxkwxtNGImS1iFDN0RUYXqquN7gLPYq1Fs+?=
 =?us-ascii?Q?GvnO52+dJUxhhbINNWaaPYlQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M9sooGLriBbHSgqF5L01yferRdSPSIlVfsip9uDbWyAKTdzOwUI+JUSV1U4D?=
 =?us-ascii?Q?OPhJ8PdyKwb4DHK76oC1ecuDplRPu0QMbSXoX/HUekl6mVxC4FdLoMGlDjcp?=
 =?us-ascii?Q?6UXrrQDzeq7SlDTH2aAzhAAGmeDqnLaF6R+bsfZ9LsWXD82xcukjtKAt/FBj?=
 =?us-ascii?Q?PeWq6gZzbI3HS5CQBK3j1CN0kCBF0dXuAI8v1IU15IID/J+3g1UZNp6xK94n?=
 =?us-ascii?Q?Cix+5S+xK6DyC/7eRHb++oEuWHZRjvwENRGqDo7e/N6gxCUiN2k5HYikRygG?=
 =?us-ascii?Q?FHR61rUhnxtJw89pKLFS7GV+BOhb5eFVxsMtH3DwBnPvu297yBhyAubaXhWq?=
 =?us-ascii?Q?2PXXYvyeUaUdHBKdH7ickET7KUxLOw/XWjOJ6UZ2tKNnJSWDyr+0pbeLZNfw?=
 =?us-ascii?Q?AmwZAdYXgB/9iodJxH62C/RyJN2RV/ZDyLVLDLVZGoFniLmlU7j8yq2gt87i?=
 =?us-ascii?Q?TmMjxl9hqmBdTIrlYoKv0+nRclrghtZr6CrlUKAcqLrKbaaQOphk/x4lgZbe?=
 =?us-ascii?Q?m7n/gTgW2834u+5jnblNNKTY9dbS90W1DIzdN7G+NQBLtzx+5rlHBB4SGdCt?=
 =?us-ascii?Q?ofbSi8D5sVn3gqxTqftR3AijAHQQ9j8U9tgiV6eIB+xvOc3vFdaB23dDtMOF?=
 =?us-ascii?Q?as3sMTkTeRUGCfrxtFnfyicnRgLw2/Mewo4QwEcta/TqOolehYmbAe5lNnPw?=
 =?us-ascii?Q?n1FqYr1vcjD6t+Z3HWUrnYmK8qpAqvrJrW1ar2iQMx8XIEzZA4VR+Us+Izob?=
 =?us-ascii?Q?gEncmquyic3796GFbMup7eZlyK2PXnXJtUga20q1lWFh0BTfLLZ1pW99ahTv?=
 =?us-ascii?Q?giUb8ZHZd7T7tf+iBZThPwBVm7J4R2Us6RBpSnw2rcr76rxPfXLvf+6ISEzF?=
 =?us-ascii?Q?5IlFYPNnYfXkb1LI7YiRZ6ZMaC6s/5J4DxQIH7D1SKGf6X9lTIOTn7yQzVYw?=
 =?us-ascii?Q?Zd8mcRyRZWokeM46eNS2cG9TwLPQDh2B4nEPgxVdQ4TkSc4DmCCSK8nzswLl?=
 =?us-ascii?Q?km9bOe+Bs34o61c4KOyBIOEKpzPb0tG0c0PStKdB4SgCgFnd0/Z1tDDujVEO?=
 =?us-ascii?Q?JRTpJk3tenyiq8p1cHiDr98ZAZuQn0R0G7atuqeYRS/4luQwgYLJCS0SmqO+?=
 =?us-ascii?Q?fKTQbizZRJcpLGukAErJukv6PoNRRp3U6KJb7xTWB5emVUB/OyWKm9RyU4YJ?=
 =?us-ascii?Q?0UYIZQAYp0u0P9M1pJo7yzTaQIetCLn5PoplpZc5kQPJO2KrXMDaYnvKdkcm?=
 =?us-ascii?Q?mCnUaRmXdxdKTTHAY/Yj36fX6QWyuwHnlCkH2mqBl6w36XPe6YMV3z+lXhiV?=
 =?us-ascii?Q?RBy6q2mcwUTCbWDyCo+s1LSIf+/lJePZL4sLkq37ZqL2X127J2TnLFAXD3Em?=
 =?us-ascii?Q?rrTXlV5e/NUXkOMjxZagFy0L5D7XsmJAhAM2SlZ075z+JAjoCQ6Q6lbu9VV0?=
 =?us-ascii?Q?secu4fsHm+Ry2JtF0/jqwPoupVpCMMJsquXS3BKiqLU4xsjBpdvq+0dqyzuV?=
 =?us-ascii?Q?AQFxl1Gwip93hQzsbZxL/S7Q9XFC96u4S7HW4c4NWB2rQIkpiF2yC8v+pNiN?=
 =?us-ascii?Q?8koMNuUVbqUTAyRKkaI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6570868c-48cd-437c-7920-08dcef924960
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:31:15.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltctrKx6oGOwR6q8dSkGtL3Qz1uaUVm7M39pq//Pb541VaHTktfeGkvVCclTapda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107

If the kunit being run generates a WARN for some reason kunit.py ignores it
and declares the tested PASSED. This is very much not desirable, as tests that
are hitting WARN's are probably actually failing.

Take the simple approach to reducing this by setting panic_on_warn when
running the kernel. The kernel crashes and kunit.py shows the WARN and reports
the test fails.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/kunit/kunit_kernel.py | 2 ++
 1 file changed, 2 insertions(+)

I saw there was an earlier series working to make tests that deliberately made
WARNs not do that, so this would be consistent with that idea, tests should not
make WARNs, and WARNs should not be ignored..

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 61931c4926fd66..7a4228568dd73c 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -342,6 +342,8 @@ class LinuxSourceTree:
 		if filter_action:
 			args.append('kunit.filter_action=' + filter_action)
 		args.append('kunit.enable=1')
+		args.append('panic_on_warn=1')
+		args.append('panic=-1')
 
 		process = self._ops.start(args, build_dir)
 		assert process.stdout is not None  # tell mypy it's set

base-commit: 2872987b1d009df556c0061ecdeede6a5f9bf42c
-- 
2.46.2


