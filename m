Return-Path: <linux-kselftest+bounces-32568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD50AADF3D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15871C249A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB227FD67;
	Wed,  7 May 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LsWATasB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FC25E448;
	Wed,  7 May 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621226; cv=fail; b=AuM3Yv0tIUOg0W+TDoGr8C7f6remephPm9u4zhY7qTQdoaICVbZ8RxCYsYxXkBY4f/rudcz5vx8Qn+GZ+KdotlxwEN1aPQpW0KfqPiyUd9qIKk7Q1Hvuk6x3Rnh4nlqZT/vRzTRSa2g8TE2nHZNe4IA5A0aUe5SB1c7GHE6WvTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621226; c=relaxed/simple;
	bh=rD6lzHZcTNVOwIuoSbN+pY/g0Nk8pSCgdtdH3jEjTek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlzCqn5Z7rnc8j/J3FKhJfji+DMHoDn4Tr6YKLlWxd9c2GXbyG714QRnDvJW5NlRXP/3++hYkcEBhQ9BACXbyNk2U7KDzj1P1QL5X7WcvJ5+nCxJTa8GWvZr/lQim4wjfk4xmE46zCgBggw2/Gfk49OMYhjsrWx/6/zry+ZMsuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LsWATasB; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwZAd99T+p6T7XP3Oqfo2oKF68Ia6C+ZIoMXOlNzGKV/9IjVLX7MifozcdwWmhgjCuS3/4c29Z+ZBOl58gdeORUM1gA1VvUVgqWH0tCiDK23Jlmjdz933l1KM7SpCIJsW6F+eI94RLG031qpaQhsi4OqTEMMNtm17rIPOTJWu2/5SoQScdwETdrhDBrco8VxdskD9Sos9RIZuyQQzbMsax92AhYNrDH58DMxuPgZ9r73HIKaDFjN4JwTimnYTbPKoDQAGMEHgGpV7oEyfLvD0PIX6ZO+TqvlEOtIZTiKFXgoU73S6a9hwQGVnbKmsJU9Ij7T/FDpo6DEImq4rDTdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qtDrnJXSemvrem3yXD1idPhMczguXkcPBb9Wk+4dKg=;
 b=vio5aIdFM7LV9QSFDv68rHvwuYQFWprUwJuaBJq1kDPbTxVIkGxdZT5PCMndDKaqBaCsC5FguEnzmSiq2RGYPZvpn48WlX5iNawImkfvGpu6Q8gbDo/CqYMUdOXNBhr7apI6167zuBNiMLmeBvfsWujeijIN3p765ZVqGxK94itjbYvFgrru4zNb7+HbeU4b0uSq/UFIewfcUDU3t4r8k6xqkf1bPPmYQc7ZCaEYCOZOe67i7gMukIqXd/Xo4mXQlglSZc8TuUd4QIJnQizv/xWnpUFlsyhA4EEizX8+7M42rAbMLakMR4apKq3EUbmDYUhgXmqj5IC+oOpb9vHg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qtDrnJXSemvrem3yXD1idPhMczguXkcPBb9Wk+4dKg=;
 b=LsWATasBB8I/Ia4RcLXK1ZUoliDZWlLXSt6knHBhoD9xXWsxQXSDvKv5b5sqvfv9rDbl/myAyclux05AwU6tKBwqQgnvQO32EZbGnJPAmTJSjLoBb4js5oXW3a3Hq1Ji4cQ92SaO/r2e3UGNrk0zllma2CoKydnqRiw8zqcCx6cIafAh8V+2DbH4z6f1/XJjaJyq2lH6W3tyYjnwwmeQj7BclhGM95HUv+S/woqGgoyf/2FLmxzeiFKHR215iBEtWi8x7jv+OJBPP8nIOtPxyqamOwU7XovVWHC6kwPPO2add6cagicoQkW2Ycp7xxvaK+Y/K25noWSJoFVpETdbtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 12:33:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:33:34 +0000
Date: Wed, 7 May 2025 09:33:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <20250507123333.GD90261@nvidia.com>
References: <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
 <BN9PR11MB5276A00FDB2685B394FB9D4D8C892@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aBptQO9VBnO2AG9V@nvidia.com>
 <BN9PR11MB527651D1ED8E6CA4677FD7678C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aBsN1ZDr+jJJ5EG0@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBsN1ZDr+jJJ5EG0@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0743.namprd03.prod.outlook.com
 (2603:10b6:408:110::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a1b46d-c1c1-4030-ff3a-08dd8d636240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+4h4Zy1fZrZzCkmJ12YME/+qVcS4kYcztk09Uhn73s5Y1BIt4tXZjVqj1pD?=
 =?us-ascii?Q?KSLOOod8fv5TrZ35uwcYusTIh5g3a6nDpg609GBODnyqFjatXoA9BLzr5q7K?=
 =?us-ascii?Q?fyty5xwX81WupsQ2aab2fwSEcntLKX1lrHxAVKWGa7j8Nog7woSf0h7NdLn6?=
 =?us-ascii?Q?nOGMjx7GMmHn2wtB6Y/OheEIHMwIX8TDTEXXvfmohtqCQTGHlV3x0MoXazSv?=
 =?us-ascii?Q?9HNsffVkFVd3i0uFWBgWRQeKb4mtU0ZjZ/arLOYOtDeWFuQHOuKWIg0Zs3Am?=
 =?us-ascii?Q?Zjvn1jir7Y4uIR5NOI7zjkpdO5bpAggCLpZ+QauJl1MaM3mHO3f5qkc3AesQ?=
 =?us-ascii?Q?H4K263KUqf0B6XyCNNfcfJ9k2u/qBqZnpWfEMaZ0UqbEIs7sxzg4SUZerxcs?=
 =?us-ascii?Q?CnYqHER1WHvIq7WX8Md9bkgKVp3cNS4YwooCaDsjNEV2LaVNiq5AAP/Z1deQ?=
 =?us-ascii?Q?6ZxnjFP3OyK7rX1hpWgiyK5ICAvsfPgJlDTMyL7cT5OxoyHLcCxmZTOE/g78?=
 =?us-ascii?Q?DPccaPUYuAQCJcSVlwKtt5IOefB4JTNoWaIuMLsMHVkxwB7Y4Sw4TbtSPr1T?=
 =?us-ascii?Q?84qATeO5hJYByTBNZcmWr7K4hPnaZRtk6bvIVZrWaigYQP6yixJRds/k8iT6?=
 =?us-ascii?Q?D5YYs497dV6xuSWnSTOHTJ8LPD8pjGEv99MKScyVeNzNt8GtlRyS7OlIrWMV?=
 =?us-ascii?Q?1Jo+6mnv12p38b2xg0SPXw6dq90AUaNa+4j7/RLM5eGtpq1TVN2Et1SVoNCi?=
 =?us-ascii?Q?doYWPXUdaV1WRfDIz4duo1kwnr7v/QDLcBh128VM9XxGIaeOq99o3gLFJPdY?=
 =?us-ascii?Q?vMtRPyX0WXLxGnTTWUehZ0acw9yDp247lFHLvmWsvRbcB8T6awNUYiu49wHe?=
 =?us-ascii?Q?0bIj+bgslBkIBPiLoMUK9mlvj4eTJLRdjGc7vHxpwMYCHc4O98rDToQRIZ7N?=
 =?us-ascii?Q?sAt7raFgWUsNZv5kZooh4fwipi793jwzsJVebLE/53BdGRXjMLSl8Y6FpXvF?=
 =?us-ascii?Q?6SNy0VsIh69+wf0PWLOSsOqPaNFZ2sI9Ue58kKNxtrnXINrlSglQoraXbgiA?=
 =?us-ascii?Q?YuuujnQf/rHGfFoc/IhO8d2AKVfCRlTgaAXzFSIWbJ7UkgbfkI3291TJQhgl?=
 =?us-ascii?Q?VmcNNyFMGbuL4FjNqO2oqs6iq/8kLopQW6UqbmOdolr6QgFy16bbSRFeWL6S?=
 =?us-ascii?Q?p2tXlbXNQDDETY0p0nkPYgeZ8P02bs09WzWlM3RihuWp4lCKY+rFD4bMULtq?=
 =?us-ascii?Q?UJQGYcxQ9ZMlaO6dvOV5WITiow63wv9YF3hTOT2YwQZl5xFfwPzZjvKm6LDQ?=
 =?us-ascii?Q?2Um/UG8QlghkUiY/MzNmnAlXdlvRwDyNNvPwHg53ToAWadS9zlMH4ZccFd/y?=
 =?us-ascii?Q?/0xfVdWVdsy7Q9/2pI91nHCuri0GE1PLX9ulpGTXbiUjzBq98Mhtt4TbP/tN?=
 =?us-ascii?Q?T5lsDX4hEJw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fUVCXm7lwwNW7AaGVhXJgpPg/mTliLr827BZZOpD6EL/hEH9JWujF2y+YNlP?=
 =?us-ascii?Q?cF3OMSy8Hjl962hYKPxZkoYJRfiAAZnANYdTxvzqZiiSvuCuEMh6Mc22x9jm?=
 =?us-ascii?Q?M0fSJeU2EvwJwORBeOiyRUosxNYRAAJuvc+b+ocDKAQPY9jHw+PMsTCtNLg9?=
 =?us-ascii?Q?KPjNvdeGBLqZLfdCmprEHImQOF+ONceEgJM0elMPvJCNCQvfHB33hFiJhGlD?=
 =?us-ascii?Q?xsRYV0cfGt4t+A5QORnTCeD7AgRXwEI64ZO7EmVRgyDAY6NLgNLyq4EpU8fa?=
 =?us-ascii?Q?yP7bsi+w2H7D8Faa9Yh6Tk1IyP0jNqXfOlx7VCmvPEQQSTY1A3d/qoCTtoLK?=
 =?us-ascii?Q?vOnZrYdTSLuUI7dT5n7a1DABDxc+YazS+7nGXll7T5zOsSzaypKjrSZ/a9x4?=
 =?us-ascii?Q?gzJqHRoWDSre/zYrWa0wkwtyrfS4jdiJKJLG4MoxNoNPzuEVmEMrR7bJUxOh?=
 =?us-ascii?Q?B6UJfdE6f7vquc1KT3iNeAgeNEp8bqCqa8hI53SSqiwNKRFFW66FBDwjPnYz?=
 =?us-ascii?Q?I/+k8Vv1brZmpFRXgJonHQNjIv591P9GandmaOeAoHmbTGhW1dIvMEmzZLHi?=
 =?us-ascii?Q?9IxOvKGezVm97s5NkyEW72Qkpjrn6pSQIRLgyF5HInYBBhqfmJbJW8bQRMTD?=
 =?us-ascii?Q?Kvv5uOGn3lh3Ai9y5KD/MlK7uSbQ0VtENRyxfxcCYeiIPXTZWOTaO9Tpe4bn?=
 =?us-ascii?Q?Epz/r0jKT8zY3W662s47Aa3f876JV5TWAqVXVeCH3CPIgLOwrdUjyfbvXlui?=
 =?us-ascii?Q?veQHvlFS6aEFRWciYd3TBnH3So1cW3tP9lSeBF41fg1/yQO95TsjdKtqZtRK?=
 =?us-ascii?Q?Ce/jxV9bDWpLWiU7KVc9EUFUGu+5xi/7xmZDGYXkmPY0E/7DV96yrA35pVWp?=
 =?us-ascii?Q?KrgZ4XDic1+h6L+bjAiVr0dqYSGgH97Ebw4KQitY9FrvwW3XJVCOCD/vRIPw?=
 =?us-ascii?Q?jrk5IMtjUX143PRUAz79l+cqh1HHOoipZUWf8kSL9auC1GdFl/OqJnMypBHB?=
 =?us-ascii?Q?1MjdOl9otOMGDMzOX9/Z1AXD931BCPguFheafgZFmaduWXAdchIDJ2AD7FTq?=
 =?us-ascii?Q?P84VYpeG9mor9fZr3j9eNYa5918tOV0tMbZ1bI2HzEfEV6HzCN1xL+4vg46P?=
 =?us-ascii?Q?zydyRiSdrDSbodZ78xqeF9GuVMqHpHhrYmZ04mkDwXnOWTjFHmLbpFmni+41?=
 =?us-ascii?Q?FAME5oEGfRPTZlXGtpxRAuZXdO+CdKdm8PIhocHguyZbanCzbAG998zOrJnp?=
 =?us-ascii?Q?SEFvwmHwWDp07mPTUcRfxUcB0ejkpHQjw0sIwQki4JedPa0m79dxrGqQYVDr?=
 =?us-ascii?Q?ZLJiFfeYy7DcXkbqAZSwSI3MJyXG0Zweh+8cToIwkDx+BAkDp7d1rC1aIdnc?=
 =?us-ascii?Q?taAJFyRA+1Z9DSbtQPxFVrS1i1z/AUWPuBa5tW7pnL0dMdraIp8gKka9qmzx?=
 =?us-ascii?Q?FY+pMCT//e5aWB6w5YRedqdDnWkIzcwBe7BPOStO2Kj5A4cKY+gl0Di1Vt8Y?=
 =?us-ascii?Q?o6Dt3gOMVRczldushCoRmp+3pIfTyIGSq9h6DCBSvHEA21WKrrORYR4StMsY?=
 =?us-ascii?Q?XGz+pIcpZ7r/tobD0ec9Hn8tZCxS1h61x0AUNht5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a1b46d-c1c1-4030-ff3a-08dd8d636240
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:33:34.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyfTz0F0QgDxB9UaJHICoVmyElzazeVu5R/kuqBPoWPP77xtN0iiW+aDiZe89x+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

On Wed, May 07, 2025 at 12:37:57AM -0700, Nicolin Chen wrote:
> On Wed, May 07, 2025 at 07:25:41AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, May 7, 2025 4:13 AM
> > > 
> > > On Tue, May 06, 2025 at 09:25:59AM +0000, Tian, Kevin wrote:
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Sent: Wednesday, April 30, 2025 1:15 AM
> > > > >
> > > > > On Tue, Apr 29, 2025 at 03:52:48PM +0530, Vasant Hegde wrote:
> > > > > > On 4/29/2025 12:15 PM, Nicolin Chen wrote:
> > > > > > > On Tue, Apr 29, 2025 at 11:04:06AM +0530, Vasant Hegde wrote:
> > > > > > >
> > > > > > > Will the hardware replace the physical device ID in the event with
> > > > > > > the virtual device ID when injecting the event to a guest event/PPR
> > > > > > > queue?
> > > > > > > If so, yea, I think you can define them separately using the> vCMDQ
> > > > > > infrastructures:
> > > > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
> > > > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
> > > > > > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
> > > > > > > (@Kevin @Jason Hmm, in this case we might want to revert the
> > > naming
> > > > > > >  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
> > > > >
> > > > > I think I should rename IOMMUFD_OBJ_VCMDQ back to
> > > > > IOMMUFD_OBJ_VQUEUE
> > > > > since the same object fits three types of queue now in the AMD case.
> > > > >
> > > > > Or any better naming suggestion?
> > > > >
> > > >
> > > > What about IOMMUFD_OBJ_HQUEUE to differentiate from other
> > > > pure software queue structs? 'H" stands for direct hw access to
> > > > the queue object.
> > > 
> > > I think it make some sense. There has been a concern of mine that
> > > some day we might need vQUEUE to deal with some non-HW-acced case,
> > > given "vQUEUE" is named much wider than what it actually supports.
> > > 
> > > Also, vEVENTQ and FAULT_QUEUE fit into the "QUEUE" category too..
> > > 
> > > Though "hQUEUE" would break the naming pattern that we have, 
> > 
> > what is the naming pattern here?
> 
> vIOMMU, vDEVICE, vEVENTQ, vCMDQ

You could just call it what it is, "DIRECT QUEUE" or something along
those lines to indicate it is mmap'd and so forth, vs being a SW queue
with read()/write()

HW QUEUE is good too

Jason

