Return-Path: <linux-kselftest+bounces-46882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D98C9BE16
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605B73A85CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC42571DD;
	Tue,  2 Dec 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MlTSnyBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A8248F73;
	Tue,  2 Dec 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687572; cv=fail; b=JHqyLVn+r8yeMZ9vt+3fO2zyp85yzxwWKS2uCp0uf/RWbTouUD8eGrX8pPNO8727N6WxxZjFwfYrvm2kqbSuyT8LwhXkWnP+fAjgnHzecYmXKI1Mx7zjhEDDYqskWaZyZWefD6c+6BtzWz08nSwTK7jbYP/V0yAd/3UuJZaZDcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687572; c=relaxed/simple;
	bh=ANvP3YygzIFG/JgM4yNRyC5FSE5XEmlIme13oEFURYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hfGLlN9z8Y8c15RD/9YFKu/j4kLeUVmR/rXpQheis+Cfxyg0S0rjlj+w/4LyaAPbjxtx8gPk03f5oXdQi55NFXRv/6q2+E+obTXTmoYXGuMuhGopKD3hXSGxmedLz9FrkDix78268vZ14kxrmcYvNBcrSTXqaIPMgRWLcc5mTTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlTSnyBC; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvpiwrekuKx+vs8oyfoo3TMt5Mro73jUIObTrYfRq70TpWYLJUbemySVmH7/pOIzs1uW0RLic/vWR6NGOsm4P6yWX1TfwE55tboOzntjBD+dgjhnp+m7Gi3GVnMq7Is7qHZmed3I0hscdEQYb/BDFC+RmA0UcDr+z0DM92F6EXYESkMowpzuugylpb8Ke4i/r3hBTJ6GlK4jWvoOk150o+RYv/7kEfjtWPy7rk113ug6GXPnuJ6kaVNxCRSi9APME+yjxNDe2yGrczlW6i6oiJPrY+uegCJGmoEBnzI7dxMv+XsjBx2Q+I2meUBvMK3ghu6tjT3Dx8hmaD3TcAnZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANvP3YygzIFG/JgM4yNRyC5FSE5XEmlIme13oEFURYU=;
 b=ufbYqsOowqWo/GqMlgwAvzJcrhKWJrHIam77JTzOnHV+tBP4gFIVqZA2JR+M+l1XtWM1feVYpMTBw3AJI6TLNeIiehK6hwcZU3oyEjNuM13LzEjK6VUOuhE/uWLGOY3JM0VMPXpq4i/cnSw6ju/pY+/gPNREL+gMu4YV+BNpJOD7GyEpiVZA8mjxux4CHI0C2vuANvP8WawwnJ/rzxRh+bihoAs+bTapRI20wFgvIZ2zFIk09bL2hmBYUYw+yZDGrkB4rPTPtrop1FARUQmGOMi1Yl5a5R0y0hM6cwP2LORyq0i/zb6rnPYVIpEqwUQ1dmTMWlH0s5Wf17crgMMtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANvP3YygzIFG/JgM4yNRyC5FSE5XEmlIme13oEFURYU=;
 b=MlTSnyBCGc1IY88E4vMXyxOwLfGVLkr8u9sw9hKL8q82+VMslojGH+0dMBhd2mkRjYn8pfQIYRXkCQlizde5U06Y6/9UWs/pBJpLXwb3hY8m8P9hjTxYE4O6pRj9Wtmia+qzMQIVqiCOVV+WeL4NArhtZ9ZnlVZaJyMYIsvmmQQ9WUit8tEkcyViWk0IpLJO6CuNfi8P8We/ZZxtVfkI8wwFEyc2E9f7SrpJoGWjvDDDemratbFYwSedUNSh69yjsvVCQKsn+EGH/d22mjvWG6lUOvWBI5ji/FtW/4eXyJpImP3mk4kUGTBt4mxT+cgP190coS0D2Yv2/ttr3hOuVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 14:59:27 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 14:59:27 +0000
Date: Tue, 2 Dec 2025 10:59:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <20251202145925.GC1075897@nvidia.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
 <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com>
 <aS3kUwlVV_WGT66w@google.com>
 <aS6FJz0725VRLF00@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS6FJz0725VRLF00@wunner.de>
X-ClientProxiedBy: BL1PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:208:2be::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f57ed32-fa1a-43d1-872a-08de31b3634b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFnQS+M1xLKX4D5Fo++grYiP+3F+ML9jsYKn9QGmTxq9mpfN8+s5UHPTM102?=
 =?us-ascii?Q?IpMSwZaC4AiaVON8iKbSmybP/RAM7v/c0oDoeGsmdRluUh+sqIsLrWIb6hr8?=
 =?us-ascii?Q?TCqKqlHjj6RsS9B8T9gZfKNCc3+atAjadMgvEdNqwVQ/NO5BdPgw817SJckj?=
 =?us-ascii?Q?XRijw400GN9apuzlcSiCooPcr9P/rqbJUGUpgWcMbfkVkHd/LknVcHBMdotc?=
 =?us-ascii?Q?X4OeqShvTHtE11iicVK8sEFuDgWUz3Yt0YZdx2ZvUOaWqeTsifrgnaJ00nQR?=
 =?us-ascii?Q?qAmqHhS5xSb3B7M+UDeJlVQYH5JAI+SR3KIdISjEjbaRnxbCZ18BBZ5HKiHE?=
 =?us-ascii?Q?t8SQ7ULVMhMzTFFBXbISezXZpfvhkEYwCqwtkC3XlPCqvQnBvPFXl+1pGUZ2?=
 =?us-ascii?Q?36gGMXFJTNeRxFnq2JYrC7yQ0rVKopemd5og8npbdBHDQ0qUPjATt1wo2swA?=
 =?us-ascii?Q?9miMPqG4SNC2oddG0OnQYpuQrIhoGqB9LCxPbRy7yM8ebIEyKq6yWBlt9cQO?=
 =?us-ascii?Q?MCaHofpIM0vxhcfB/pD9+H2VyH7C00XkxQyVDwB7P5o1kFVf3XfAfcfg2JtT?=
 =?us-ascii?Q?N4E3razSescZhjULU9PeyVx/1NrCwfwE7PeZxZlj3rtJ1HJI2HAyS/wL9b4f?=
 =?us-ascii?Q?bzpnuZU7OiYpbIYtBLjwmgQTLQvxKBzCkK2sUz9mRIFc4IeyaAR/w03i5qJe?=
 =?us-ascii?Q?KyeazVEJkDcn9wvGUdL0BxFP1WxZyWxdJ6VES7yX5I0iSAsMukaZGRf0Fb40?=
 =?us-ascii?Q?rGgUI/a/1GUqL5HQi+/3wxMfIYPfAq3tcTKqVrKnPXpfeWwWunkF+8kbxjDo?=
 =?us-ascii?Q?d7R2KnHVyHRtmLHdgOtRyPzkWwIDrhUrScGtv3MZsEP3ecdwYjopmjD1t8hx?=
 =?us-ascii?Q?tl0i1wEHEou7RwdmgylM4qrDkAaEVKJIt1VrEe/MaQaiU1joz5dL2Z8OrW2n?=
 =?us-ascii?Q?fenafwYIK3ujbG3ZSsvgQsgQvDjF/PkEbJ1Qb0U3pylVMvjRrgja91mt2ZYF?=
 =?us-ascii?Q?8YMOEq9SVKga8oWXf2hZ+1qiIU9j0hiUuGjfm/tJrHXJTS1Uel5CgaeO/1yJ?=
 =?us-ascii?Q?nkXM4z9B5SZYduU4LEBWLF5aopmkuj2aQacsZHv5/xFGheoyK0I5XohKz5cE?=
 =?us-ascii?Q?8XSXirxxHtc/gMhMvlme1AwMwPNvRpvETR33HARuAJsjlRRQZ/fV0oB2+Gx5?=
 =?us-ascii?Q?7ufMW8n5+TyTybNFM8FNsMwlQbiFDTWbPCBNNYYRJx142GBZvOwnnfhSguIF?=
 =?us-ascii?Q?uqTeWtGjIqYCBZSQ1/lWnIBJKNyNAptJrKyhIfT3nFRe7dJScAUaJgDAS7Nb?=
 =?us-ascii?Q?X71OvoCQ3qSjbGxvg2j+uJulbpC+7RKQyi0y/j2LIg0+uGgzIXbiu1Kb4nhg?=
 =?us-ascii?Q?HAFZrBMywLSSq4mZmnTniymLAQ33fCsjkeBx2q/YtLbHtBQnkNOXc+tMmtBa?=
 =?us-ascii?Q?T6ls4U0/IVa9ZkrlbLZwzSYlvtXzb5lH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3heZVoRmcmlOM4RYvGRH/brSX3zFRhTaadd/nvVobOWd5Y3lDxS0D8YlhqS7?=
 =?us-ascii?Q?6nw954PW7JOAwiibOE9pHrn+IfBcev6gjbaWT3hjrCIYEiGRasqFbbBr5Iok?=
 =?us-ascii?Q?MOXD2h0Opds6sJis9qrtKvcijGECLfB5Q9KYktrLr8vOl5JTBL3ZS3QM3/nS?=
 =?us-ascii?Q?T6AbOLsLLm+kOkaiUf4khYRZZTUqI5+GPhYJkSpJy/bzjVudM1sZ9xuZs+84?=
 =?us-ascii?Q?vYRirR5D3hiWcAl1Xg7vPihPibYGYZagfBIik6j1yh32vQCz7xgq9tDW3jrr?=
 =?us-ascii?Q?gz3kl8zT+8vKNJpDbJhwVSkCOm6OIyhHl9IzJq/IQstV9M1wG8RxWMI9Zm7m?=
 =?us-ascii?Q?5vKRggoZ2rDo5nFIGT6wmeKq8AOeW+XuFm1ypP2swOweE4Wk8nO2K0OgufFG?=
 =?us-ascii?Q?5zoFfTf5X4BOvpI2cr+f11nqB/j+k1JglbIptqzEOZSQRfvFhtdnb1ihQzlN?=
 =?us-ascii?Q?UwwOCbvscSicloE4aDInNVqFdb5hsymBmuIiKRoQIBz6uhMRIAXWDH7rz267?=
 =?us-ascii?Q?B4r7AtVvqa4VY8xvtHCeATIaMnka+00lzbON6BFlJuONBqzrjAoYKXMQmhQE?=
 =?us-ascii?Q?KtlkQSDKWJoKrIgFtB1a4JR8Ef6Jqm8wBsLDH3h1Jc07G94EHT3W/fE11pf7?=
 =?us-ascii?Q?RlvxBWv0xA/z3AAytfzs6uKO5GUUyVU75wzt6cTPW92/hoUkA7emTdCXL+YV?=
 =?us-ascii?Q?46358RZf1BefZCyaY5t4l5GZmRoSavIwDgq2yArHroqxXXhrQgz1LBbf85kj?=
 =?us-ascii?Q?m5AST73k6/aayt3JO6xi/vJhbIQ5YmPiwJDNfvWFW8UWnsISDyRHEuF/WtKl?=
 =?us-ascii?Q?EPoY/DBE71/79Y+Igzkf92CjxMZaPPG7FADNHkzL0r1zso9Xw7CH4TWObxrE?=
 =?us-ascii?Q?PvOWKj1FptckAqkTtWMRNlosbsLVh5ZiE9nJItNQsk8nIjNn9/KNKmgI2+HF?=
 =?us-ascii?Q?vKy9kWlkAltgR6+N2fBplsC3v04KniEr0SYz4f4qlV6hDZlK3X5xOujQZkST?=
 =?us-ascii?Q?38kLSTJYiKM0xsc4vPeQBIOPRdQdoP2vwCp0igPSzzY/hwTYae6xS1EgdUCc?=
 =?us-ascii?Q?ZMQIb73dS+lm0yyvwLEVi6cYMyzTtIvLDh6PB8et/6sYBrL4L9S0Mdt3G81r?=
 =?us-ascii?Q?rxwFjwaDk5PeYpx4qtaP9GlzupwcdSHEABtL61urTz/IzFSIG9DJ6EAHdqZx?=
 =?us-ascii?Q?kvBibWuIuEx4p7kvz55IocrOMK5ign8A+DWOZIWA6s6pNSDNidWKx/l/7AFe?=
 =?us-ascii?Q?to2TySu4ipOq0VYh8nIBb3cgJDvdz7UmsE1NMHicgryURkranLxXpOvF7Knl?=
 =?us-ascii?Q?+kXLEvDudFSK6n0Tn9Zs66UMjRg8qwNxwEKnQixQr+E61goObZP3LPxiFbff?=
 =?us-ascii?Q?neb3NRmN9ay765E+/hNlcx5HPNX7t9npAl3UsDrqnSzcgFn5ACAtlTvm0ZWV?=
 =?us-ascii?Q?TxutM58JLmnZMYWCzrFr/0LHnOukHDSII46hGUcnl1OQ4pl44EdO7ZGx3c7Q?=
 =?us-ascii?Q?EL+Gs0y0cdFv46ti1RinXNzsKsXtMUjgzwuJ5J9Txvyq7cBAG67+oy1f4sQP?=
 =?us-ascii?Q?sIRpDeBmaps8+GzGu2s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f57ed32-fa1a-43d1-872a-08de31b3634b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 14:59:27.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eu32qSThj/JV6arCvUETdTjBR7Sfa3r6lA6G4Aj4tAm12f4WoKT3ppTLvaJ7xLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

On Tue, Dec 02, 2025 at 07:20:23AM +0100, Lukas Wunner wrote:

> But you do gain a bit of reliability if you don't assume bus numbers
> to stay the same and instead use the "path from root" approach to
> identify devices.

Again, that's not reliability it is subtle bugs. The device is active
during KHO, you CAN NOT do any resource reassignment, not bus numbers,
not mmio. It must be fully disabled.

Jason

