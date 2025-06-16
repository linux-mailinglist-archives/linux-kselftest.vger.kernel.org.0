Return-Path: <linux-kselftest+bounces-35073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF57ADB26E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176907A3D06
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F68285CA7;
	Mon, 16 Jun 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="crkPv32w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB68A31;
	Mon, 16 Jun 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081651; cv=fail; b=dpAqNIanmBVmbA9P12iYiLqskKT91CYjETmNA7Hs/eDQz1HNKJ1UW+DUsJTH2+YT+NYcHAYzFh01M86B8gNbJShpwhTrzRE/HwxFZDgvcvLmnDyABVLAtlBcihiYKhJgPmfuaPILLsqG3viXIrK/B3jNqDs5REVgdRz9L2R+FtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081651; c=relaxed/simple;
	bh=Bs7n09o0XCQO6pyFxw2go6DpD47i0CPQWUiyqeSj5iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ohf7OvOIJwFR+SBoAeJlhtSXLgmClHPdEZczcd3St1eAToD5rMc4IIETFiurbULYb7tviqvkYiF4EoqoLPavCZxqvaGtvc+yKGKMJsM/xOoR9Xc1D5Ye2n4M8lqTfqTfCNrh9qBdJcn6q0HNL5SGIPUi4HpvUWl1TITjCdkhj2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=crkPv32w; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW76ZG88c1zgsyRvro5FPLqV3ykcMwFeOZ6qaJ18/3LtZ1md52R5yjc/im2oa0R30wR/5HrLwQRYJfg495TSYzDK2wqCb5ii/kjfjL3L7qfpHCMmiwgMnK9dr0BOfbjh9VQvckigMyisjNZfxIRO8InaYKwNDHeIBogWVhLRHgGXQEOsLPrAIpth9IRSCEjU++Ar4rdex+x1rtFk2KYuXS9CUomXqx4EGso4m2BhSz+DKDU4FO6ec2k6iCrPpsrsVSL0N/M0nlo70zU17ew2YahXdBwSQJrLUkp6P482Wttq061VyLyjquDd1Vgyjo9OjgWS9pnys3gR3qU5hSCDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np6wCo0jW8PQoDpiUxXB6QVgB+qxzNID39Eq5/M7EUY=;
 b=ZvyP8COMFT9gGt7o7YfK2qsOxpG7z/MdB64B6R2RUCY+sSNXeOwtnj3YIiT2olQ6jShUkcvZL4IQC/Y/NAQutFboRaTyifvXz5OkdyKBXCMay8/EmZUsGqcesqrRFasae8HKtrwpCTQLI0s69F0NG2heFY8mCed/ofHDG/HaX+6DnDWTic6Ac4t/NpZw3/R62hyQhI+rimBXZmXH6uS0RtiOGF9xSQp2OkDC3cEbXlCmzNpW8K4H43OTGE3zdCv4+p4LnKTJ3VVTbLAUeWrL+VPGAPS1IQQmzWJFM/pzzWb/9IK8UCvh+QfiUXLL4jcKemBqfBDNFGeXJNQhuOJb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np6wCo0jW8PQoDpiUxXB6QVgB+qxzNID39Eq5/M7EUY=;
 b=crkPv32wx7umQRqngnCiYBwEhiQFPTk3xq5gDBecIWP07jMi5YD9fE5e1S3sUv0NKAVVYzyXQDO/NdplEBy6i/eIHtOjnXSHMkS8zkYIZQhW0mXikpzTkNwDoOa3yG7HdgFA49eXfqPk3sfk8CzL1sXvzYI2Mc6D1j3i45lcdzoBp+u+xUlmPAJlDOm2voXBZRM6PRI1JR4luX4HdGXLRGgqp9WY4KfGBS7wWSAJUjMu22Or8yQBZSa8w/MqIauzlggHtIZbSgfM9gW4ShGqt7p1bhNKUx7TZPRlj9LREBiD2wnVJnUwSOeW79ghRIC5h/XQJOOM0dZiXdViCDLKfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 13:47:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 13:47:25 +0000
Date: Mon, 16 Jun 2025 10:47:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 09/25] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <20250616134723.GD1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9ce52fdbcc7a049b6e27e93875fba4cbc516220.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ce52fdbcc7a049b6e27e93875fba4cbc516220.1749884998.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 99991c63-0829-4e08-5d09-08ddacdc5335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z0LEamv9luGEQV34viA+avzZ1QiQDljS4viF9nOo1GLsQrykFofbsfA/kCrs?=
 =?us-ascii?Q?Z1b+8t2Ibw2Gft4Kchk8qn72Ou5CttB0OE8j84yYoIlzKto3D1EAVUTN1vVN?=
 =?us-ascii?Q?/Rc3ZtB1evCg4gXgTMsP9Mavm1wq9AzueF7V6kztGtVoXfX8R6xz/1QWquTs?=
 =?us-ascii?Q?wWrGAvb1FZeF5AXTJkVpEAL9WTMrSqOu98SgMriqpwMuBPSZBa+wKlA12d3j?=
 =?us-ascii?Q?Rn7V4v3XYFRcTWp2Ds6yRl/CywjpBa7YXd2FpFhJU5mzsNQTba8EcbZoQx0+?=
 =?us-ascii?Q?RZY7L6AsIwGjeR6AY6jAUEBRzhvjELHbLZLEq8TzJT1QS6crIsmY0EMN8thl?=
 =?us-ascii?Q?NxiWpC0M61Ivxgt9TCYL9i4P60AclMtzdKCFQ8/U7cEoa8/XZXrE9RarXISZ?=
 =?us-ascii?Q?cSq6Rlu59hRUg0JN4xBOyqVDgg5BAid2CHxtcxSMCQd+/+9jKHDLD8ipCtI6?=
 =?us-ascii?Q?KIWodGgl3P0dgKFeGYqSY6h2919Pt29MhnYYUToXIHDw/O9xhD6myTwHUbui?=
 =?us-ascii?Q?Fo5WzfGLmitaFp68bHuPkd6n1dT3vO1jKAYDv5/M+TvEvd/MTcGFsO/V4Vor?=
 =?us-ascii?Q?a4S58xIDXq9Np1ha/HAC/AjnTVMddm6EP+YuNj8GMIHrlPOkC3eajbMku5EP?=
 =?us-ascii?Q?oLbiP/tDEnT0nMFp+feZfIKss6dRha3kYgpOZ6x9UCgayK/Zu6UQpTLOnUQg?=
 =?us-ascii?Q?OJYgMlmAYkEN45s58gfJJxdSlDBod7Jj+UideghsRhKCVkgU6lUxmdhEvMTN?=
 =?us-ascii?Q?GgY+z/Mi53JzNHrjrA2jj4NFcjW6fLvnzgc6Q/2m6c6eSTvPhbC0JVozbGdt?=
 =?us-ascii?Q?sJutR+VXbMBBB22d5VIgwqWa/w6a4nS3xXNQWfXIPnsidPZW7l9cRoFlXcj1?=
 =?us-ascii?Q?fRnFNFdQeNa4c+BfsAq73duxvq59PPueYjnxxvYSkQfsMq79HouDVxxAPOn2?=
 =?us-ascii?Q?Resx065IhF97Iw0c9ZCtxlKPuMPNTBYbvJl0e0g3KfY81t1sSMYhr7LEBuHh?=
 =?us-ascii?Q?N4doyNsWQ3UF7+peMyJxdAvUC/WK/KBhFF4S7+MPqUpXMvOgHKvmtH64eGbJ?=
 =?us-ascii?Q?MXjD4euhxqBJ4D1+Eq9l8cUAWA/iskTldGsZ0omeXafL32/mrLzO1gZJ4TIg?=
 =?us-ascii?Q?ndMhlX+CtK+csXFSFtTO2zIyafRy98wEPFrIYE3s9W/drCNJtIOvfeC6BN9E?=
 =?us-ascii?Q?FbMWDC7c6Q9uz/OHtpKz6f9FF1UDYrBxMvHIZOHrqGfA+1dzsa7lzTPHpg9r?=
 =?us-ascii?Q?qxrpXkJw108ukX5kUJNZwyQ9LvtDMgOtcqAbgQJHHeca/TJuYQvdfsnhgR71?=
 =?us-ascii?Q?HU1FtUnSriB6AGzkhuyJqsHyFWG/yoaLcnVuG5ptrT+gk8X/S+TgKVcVHXWH?=
 =?us-ascii?Q?5EJDXVWkkFKWaA0CL/CcfYgB7zJiMWvCFoOGKglMcYUqFSv2ujY+jRP7BMFf?=
 =?us-ascii?Q?e6AGdVjYK+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJV63Vlb2WVTqzgHg14DWAY7iMvdFQCRiet5DYpeRaowADK4ryVAiwXnVYVe?=
 =?us-ascii?Q?elN6FEXY9AygtTiKR4zPHqELCVVbbDXUnIFtL0zFrV6u5KuQxKsMCparQe5P?=
 =?us-ascii?Q?f4CRAkCMevKIjWIa+G8QCiWZ3OiukSpdM6HyjxcEGARUSd3cJ1gh2k4CbMV3?=
 =?us-ascii?Q?Cjl3r4Kj/00ACpbqqtXy2M5cYPYpsJ9zWw5l116t7ggXfTV2Ociuc95q194P?=
 =?us-ascii?Q?qxE9PaookAysIuTisietqXg7Bihuo9oOva2rp/sxpphHKE5ZppWwiaq/Hg2G?=
 =?us-ascii?Q?YrDDBuYQR3KfMFxqkRZDkuionOdl3PLbCGUGgy6f5g0j46C0/+UdV1fsbY13?=
 =?us-ascii?Q?NjQz48lGFpvOYnXtqLdXAmAYgf2h66cyCLDI6K8VZeY7o+hikcRq/OxpTa1r?=
 =?us-ascii?Q?vl1NVhU9fvt8+HYZZWCT9kWLxI3vmTEdIacG23oO7DwRjZu9ukhxYhBEwAMZ?=
 =?us-ascii?Q?EpbKwLoqkrjobRWq/DeA5uQhJ31kGoHpKTmDd9v8ntPvJhQS1EfBVhQzCLSr?=
 =?us-ascii?Q?42FiOOCww7Y+XHfyddl7RTLvOgC4B0bNXSOtb2UyKskI+MrjH9Bzaernm8eP?=
 =?us-ascii?Q?fJrZ/hucPR2PWQMdpwzzCro8/LducCY13bzlfrHegDBMUfVGtuNPA98j0cpX?=
 =?us-ascii?Q?gG6B69cmaTZsg3rodjVEJidZAxi7wSmJu6PJ0+vXAPXnE6FNNfT+Yfz+9NXS?=
 =?us-ascii?Q?+AEIjL3O5Mn0FEyVGlaoSD39vQEUPZBKSjUYxfGCYfD6+cRRiptyCRi4Z/rI?=
 =?us-ascii?Q?FVCwiUoaOXK9Zx57ED17R9281Gvee/HeTPj5uTjRWGwdwamvbMKOnnohzGer?=
 =?us-ascii?Q?gMw6N/DU8fHpTn+nOT4fEfMbYkSID+ucf4dfgB99AVVokjBLQziLrsjld6wF?=
 =?us-ascii?Q?eBQ2Qd5n7EY6lROe7Herz5j908HXPbJO2mteCuGzZi3uMy1y74j9GrmNCCFO?=
 =?us-ascii?Q?JrXEd69L3IqJoSxcElxaKmV4CnGmZDb2PExWjG0oLrlqPgbfS8eg5be9QmqS?=
 =?us-ascii?Q?mpTOeXuL6Dqt+nP4sgsRr0r9hjX2euFKMl9s0qybaEMe/EY93hyayLloLysF?=
 =?us-ascii?Q?5ykg19SneJqURdl5KtcKeCPGRl/8wFH0pzEvNUAVUljfOz6azHZwjceTpcn6?=
 =?us-ascii?Q?mMEyT4QOTPoKFYbcZfF0khylocxQKC6VQTpCgxyxRntJCDkGJMV3oHnX89Pi?=
 =?us-ascii?Q?T8tYs5KNYsbHo4Oz7J10PHXvph3Jh2DaLMA3Gm3Qn8/VZQZfrBjP11yD7yxu?=
 =?us-ascii?Q?2LiyMN5RDJziYqs9WbmPzUxMawwSYuraiLvbtuIaE8yaEIEtZm8n3lWCQ+wR?=
 =?us-ascii?Q?sdyaYUK7l+CQC5xlaG+nDEJ828AVhBPWbuzb29FSn2fFPlrvQVltFWWAS55v?=
 =?us-ascii?Q?v5KgD/JlTbkG6GnSiWSRAk4TEAuyGhPVAbhHOjwR9Uf4jGOTW7H93IZpwsZc?=
 =?us-ascii?Q?Ci3sxOO39LEP5SUx4j8kf2qpYZjabXhxsxNbZk10Ok/b2Ye2vUCqR3OCZ5o+?=
 =?us-ascii?Q?J/8tXDtaD73mf+EACndmstbTv3zBbIZ+UaiVli3F+aw1rZXwsLYSmc3fodey?=
 =?us-ascii?Q?fSmCDpAJLyqvoikC1kB3JwNCnClpCFKKbQ/9AcK7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99991c63-0829-4e08-5d09-08ddacdc5335
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:47:24.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocp9yz+0mcR5p+uCso+MX74XTI9zRQDtHdyfRrfM475y5WD4HSCkDcN2nAYIBFDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

On Sat, Jun 14, 2025 at 12:14:34AM -0700, Nicolin Chen wrote:
> +struct iommufd_hw_queue {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;

Try to avoid this if we don't need it

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

