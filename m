Return-Path: <linux-kselftest+bounces-46801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A1C979C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 14:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 665174E1564
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866CC2D5930;
	Mon,  1 Dec 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YN8jDPoV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD930BF4E;
	Mon,  1 Dec 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595782; cv=fail; b=Mciiqdy6xv07MNZVAsIQ3txsB68giJAZgN7kXTxrkL1m6UfJjgH4gI+1+a+1Xntp8x1TECe4UYStgju/WuqpHqt/sj0SKsmYG3JSFYCJze61ka9YrI3c8V3E2V34eSXoNzxkGgfy3j0wZHDHLL9dex7pOmIGNgRImf+BDMbGPgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595782; c=relaxed/simple;
	bh=buhbjNJ7DtTkoJbJf84uuwTJHo6SIUvN8bPhyG+GF2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lHS/2k+F2r4MkmT96dYTLfS2rg0T7SReii/QKi2fXCq3GYaNxTxXfzbXubxHe1fcL0OmYCeExAo12t1xbncN7b7MlLm+oQ0SEN1r+QMsZLNYJEpUGkp+plbCHmgCJ5L5iAeQNyYNtPnpfjeSGLHmjt8BBc88R1M2fLz+x8kBZQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YN8jDPoV; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKeQiQpj9gvjSB4oiKIS4xtvNcG+TXEjogysJFr1VUZzdf6UePWaJ6aDTaFjbKLFdwPPSV6VkxYz2OVMtAkBlygd/VaqXDlx9WsPRBopcyaocKC7Lpp04SOdz0ZzwnMuxNmxuRufiVq0zsgB3nrYr94K6ehxjF414Fws4vSKUVIvXA2Q053B6vtJQ0AG+pTtARfyOXgtI8aSOSqX0NSOfjyCczDZYWYP7jqVO5VxGlzD1xzTFgpOfLuHSboEkHem6RTscVEyyesY+fR7nP2JuM3+kiFexa0zf8CEkPC7YBQkEYwfs6lWZNyzy8wEwFYDdmaAnuhz4aEf2c5xG+QYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVbxE5Caqk2gt+45BinrVfObVitW/zhcKieKmepnxug=;
 b=jQDKe32PV56TgNIdJoDSS4bU4wWjYljOE+f6XVDZN/Mu4fKo7Fi7lWXhqVSoc61edKPP1YHkCMIKxCpko0ugjb3L5WuV9yr3ggNyWWB0F7Fu9us+bpt4pUwy2uOCQDNg6Si5AVnqh56MLc60je1s6xgBPvX4K8MZOklj5FuacOUQPbLvXpD1BN71wJve+8tBHezuS0jTgKNLCgeffCC8ZlY+c3Qb5q0Cd2S4OvrpWcfkRkEkx1e2JuNvXy/h/tmUB9bCUkdUnyenI/JYgepX1wkX8qdkCWzFM4fj6fCZukuUL8QMRbbwY+aZCmUpdvXdba9xL4EbiVf2l4BvkovXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVbxE5Caqk2gt+45BinrVfObVitW/zhcKieKmepnxug=;
 b=YN8jDPoVSB1FDtCy8OB3kR1ATOHI9T8ZdCUQUShlne4sqY+T2+UVfhClUi2u4GDaVmo8PD8Gd/6iLX+3egoJCiBr2g/nfB+APGorNqu+1E8LFUpNeZ0vh0tjopAXWmg7bT4z1Rbt2WJTN9ps5USKIesXVa1ioruux+hRz9ee5vGAq9PzU0KMkhHFcXyfDK0Bx2P9AXXNyhSADV+UHJVxweEQY+/zi0elCnPxeScaALWtfYeopCPE5CL162vfig1DaePD4PouXm9r+LXMIql+h0gKlzfbyTqo9I+TqnDCHCLiRGv/VIdvjVor5s/Fn+qTL+oIwJVR9bpBN6zHh5w3aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 13:29:35 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 13:29:35 +0000
Date: Mon, 1 Dec 2025 09:29:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Lukas Wunner <lukas@wunner.de>, David Matlack <dmatlack@google.com>,
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
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <20251201132934.GA1075897@nvidia.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
 <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
X-ClientProxiedBy: BN0PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:408:ec::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3528500b-b544-4a90-914c-08de30ddab23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZldPTEdJdFFKdmxnUHU0MGVKUTh0dC8vQW5QNFRkN0VWMVhqUGJwQkkrdk54?=
 =?utf-8?B?alh4VGtNcFVPLzNneUd5OWMzKzVNbTZaTFcwNVRHT2Zvd3A4R0o3TVEwcUdz?=
 =?utf-8?B?ZWc5WnBhcWRyTWtmWUVYd0lXeGpvOUU4a3MycFlvbDdXYS9yOVRPd1JMbTg0?=
 =?utf-8?B?WnBjdHYvK0RaaHduQTZ2MEJDRzNEaklQSkM3Tzl0dkllOTl4YXdXTHUxeHpB?=
 =?utf-8?B?THlCa0RXaVB4MFc0Nk5Oc2s0TXdPNm1OQ0FLVGJFcUx5ZkFyUzZhZ0tKbnFr?=
 =?utf-8?B?MmRwUHRncDJTKzJlbmZMeVN0a3Q2QjBKai9INVpKQTUyUStmcXZ5OUR3YlYx?=
 =?utf-8?B?TWJtRHpqMHJ4Mm9PeUhGTnRZSldCVFZ2dUNZUHcrRFlCcStJZFJkUjJ5T1Zv?=
 =?utf-8?B?YVRwRGx0WVFuRWN4ZG00MlNjK3JrZkZITzkydE8xaHJRYzZzZFVqWnR2T0t2?=
 =?utf-8?B?SnZLR3ZIekV5WkdDdE9JQ0VPL3RZWGxXM1l4dE5HTUROd1NnMEZORTFqOER2?=
 =?utf-8?B?cGpCSTJjclRSZ0hmbnNGVE9UWWNoWnZCdDlCZ3BXUWpEZHhoeWNpYXNyQVA0?=
 =?utf-8?B?TTd1bktva0RJOWpVY25tN0k0NWROY1pzSllWV1dzc0FqTmhXSkRNTDlaR3pj?=
 =?utf-8?B?MG9QL0hYTGpZaUlrdHpaTDZXZnM3cERna0NsV3BPNDlvaWR2VlRaK3dSekk3?=
 =?utf-8?B?UkZ4Ny95ZldlR1FSYlprMnN1L0tWeDBkZUl6MW5aNnFMZHNwS2g5dlN4S2Yz?=
 =?utf-8?B?enRBUHZTYmJWUjNQTWFOYlNBdTYxUEFnNzVQdUEvSis3d3BEc25iKzRSTHFt?=
 =?utf-8?B?cGs1MFlJL1hNelVkcmVIUENoTk9ZRTVGaGNwUEhiTExxOFJTSndTaWp6TDQv?=
 =?utf-8?B?enNSbzdxWVNkUVd1V3BOb0VqUWV3MTI0aTAxTnF1Q1hxdnN6Yi85ZFR3eUtZ?=
 =?utf-8?B?RkhNMlRZSVFXU3NiR0k5Q0VvSERqdVg4a1JBYVJuR1lSMERPTStQNk5QQzJ0?=
 =?utf-8?B?eG1BVXdvM1VmNmIraE0wbGQ3TlhsQmJKandkblVwdi9COU04Y2tCdmZoUzJq?=
 =?utf-8?B?dVdFMVU4a1BNUnVwT3Jrc2hiOVUwdUR4dS9VZWpueUV1dnNNRU5MN01CL2pr?=
 =?utf-8?B?RnZNRlNTbFAvV1k0QVpnYTNEUU1RdEI5ZWZERW5XTlUrNCs0UjdYQW5VNUNq?=
 =?utf-8?B?MWlFQ29USE1TYUUrVjBleEJoQzJYMTBLWk0vZTZmQS95MkVXU0g5VFpzMEp2?=
 =?utf-8?B?ZCsxWE9mV1VvZXlJeUs4ckhObG95T25PSnRlSVRlTEJXaTkzcHk0MHVnQ3JN?=
 =?utf-8?B?YWdJd0JWdGVVZHJudnVHSzZCZ20za3UzVW9kdmdJdkNiV245d084ajFLZU5R?=
 =?utf-8?B?SkRTWWMxTi82WFd4MGlUb0NzRlNmaE8rRVk3N2hvbzVKWXFVZi81UkRkVllS?=
 =?utf-8?B?N1JKRFplL2J4VDV3QktnYk9sTDVucXlKMWNOVWs1Y1ZnV0dKRnVzdUhnUjR4?=
 =?utf-8?B?emRtWVFiRnRDN0NpQThpUWM1aUVRcm5tUGI4RVRiTk13VVc4YU4zN3hMekpa?=
 =?utf-8?B?czhpd3M3bFM2M1JvNXJhWkJEZmdBS0p1alU4bnptMmdWZmNMNjVpRFBqeVI5?=
 =?utf-8?B?d2VvMUxJelJIZUxaTk85UHU0bHBYejN4MWFxYlQ3MnZ2SWczRlIxSzRQVlBS?=
 =?utf-8?B?SEVwMFBXb0JZRmhGdDJnSGxkdTI3dWVLb2hzQmtrbW9nU0ZLMGduS0grbmcz?=
 =?utf-8?B?VVgzU1JsQzkwWmNVbkE2YUtEV2tBc3ZBRFkzYTdzaUozbnVIampOdFVNb2ZJ?=
 =?utf-8?B?SmxGQ0tjUnFDWm9YZXFkazM5dm96SGdvaFdmeUVDVTlKZlE2eXpqekIyNlVE?=
 =?utf-8?B?QXhsWWxoUFdQRmcveFR0bmlXLzM5WEkyTlhDQndXaGpzZTdWcDlDK3pMVndm?=
 =?utf-8?Q?Lxjk7MclKc6iFwdM13YDO977snvPZbga?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjZBZTB5amMxRlZiZWdvbW85ck9waW9ZUWlkaENIZldkMGo3VEJCK0FjTkZw?=
 =?utf-8?B?dk40amdXWllJUDhheU5UWTNSWldpbnJVU043S2t6RHdBZFU4WkQrZmJVc0xj?=
 =?utf-8?B?dmZtNFZlUXpmS29DYXYwLy9JSkdhVGNSZ0h2TnR0SWpSS3BRRUhXWVc5OHZE?=
 =?utf-8?B?NndZOThaQlllTTJaeVVJRmljZmlwTlVqRTVWV2dPNFNmV09lTmEwQThwTUpK?=
 =?utf-8?B?djVIbzBrUXB5L1Y0RXA0S2xncGYwU0ZOdnNZSWpnMXJEVHErY0RoY3NRNHJZ?=
 =?utf-8?B?N1ZvY3pCOFR6TndlUWR6OFBUU2E5aVBWK3dUNkk5R3dvLzhHNkQwWnorZW54?=
 =?utf-8?B?dmlrbWk2QnlOUVBHT1FsY3JWVVB6bnVBb0UwM2laRmhuL2paU3I3eHJDYmlt?=
 =?utf-8?B?KzVKZE1mLzdPYTFJYm9zRGZxY2pmWGhjNDNtUG4yRGFvVWRYTUZrT1p5ZVhi?=
 =?utf-8?B?aWZZS1NGY3lucmtUc0U0TEU2Yk4zMWM4R1FpcmVRVG1lSnFTcThSTFB4Nkha?=
 =?utf-8?B?b29wN2Q5MTNhUC9JSHVCYnBGZVhMMVVJSDJnYUUvaEJSWHVReVZMS3hmSThV?=
 =?utf-8?B?WE92STI3bkpUV2ZZeVZXa2dGbHFybnlwRHlvdkVjQ2Z5bHA5OGZGTnlqT2Jy?=
 =?utf-8?B?Nk8vUmxJM1JKcXNVQUVpcWlMQTVpb1YxREk4Z2o4Qlo0b1hPeWlKN2ZteGJv?=
 =?utf-8?B?M1h3a3RMVHJKWk1DL1N3WTZxNTMwSXBlbFltVEVJQ1Q1QXdvYVBBazk3WHVo?=
 =?utf-8?B?elZqVVZDRlJhT0U3K2JlL0JOU2l1MWkzOGY4V0taaDJhZHF3bnYzUFRuTllH?=
 =?utf-8?B?a3AvRThoYWFPbFhJUnpUVUxKVHdMZE1wYkZURlBwblF4TjlSenNnSms5QXFH?=
 =?utf-8?B?SmRGRmszV1h4cGRod0lVYVNWV2E0YmhmaDM2N0FrWENlTllLMXYwTHRCdWRP?=
 =?utf-8?B?cGRhVDJlbTZaQ0FXcTJNYlNKQmJYUHJiQzgwa3JyK3pTL05BY2ppOWNuSkxy?=
 =?utf-8?B?T1NzRVBaL1owakxUT09jai9LVExRQmlsZG44ZDUwSFNNQzdXVG5yMyttMldL?=
 =?utf-8?B?Vit0RkUyd3IzOXRmZTB4Z3VCZnlBbjRoQTE2TUtJbk1YZ0tTZnp3Rk44Y09C?=
 =?utf-8?B?aUM0aUh0cmJKWEpPS2pURDZCT21iakVGS0owaUV0QlYyZnBnRFpjVjhCcDFk?=
 =?utf-8?B?UWJiYzlQU1lFaGsremFLamNLUHUwb3VZTGJGaGFJemF0ckdSbkpYTmVPUGJp?=
 =?utf-8?B?dUpvYnFSSTB1Um1Tc3NSaE16RHpjY1N5UUJnV3BWNzFIRzdGKy9EVDVtbkxk?=
 =?utf-8?B?Nm5HdkNtRnUxcFFHM256Zi83c0NVLzAwbVRSTWRwakV4RFNDTU5MSGUrWFVi?=
 =?utf-8?B?bytiWWwzaSs5S0NtaE1ENXQ2SGVWRytCNnppV3VMU0N4SEFHaUZyTmRTamY0?=
 =?utf-8?B?K3kzbWV2UlZyaStqSVFwc0UwQUU3Y202TDlpeE5qbUIvNlpWNHp4a0RpNVFy?=
 =?utf-8?B?NnQxc1Z0WExVUjFLNFJPeFAvdWhKcHJKcmpTL25OVXhSWXZNdDBWY3hOVjFx?=
 =?utf-8?B?Z2pDWTBXNTJHeEEzZXpuWVNORDN1MlRNY2RnWDNRUTBFN3ZEaDNGYzRJZk1F?=
 =?utf-8?B?ZklKYjZUTTVTc0huMDY0R0NVTGJKSm02dTYwaEFwQzYxVVo1SG5aU1E5U1c4?=
 =?utf-8?B?WCtQWGxpY0IvdGtVdXZXcTVJZmttOS93Qzc5K0RyT1MwRWZEY1dWSVpMYllZ?=
 =?utf-8?B?Y2QybXBlc3VUckI2Z2x0SFVlc0ZWUWw1TWhhMFhzTkNPSC82NkxUaXlxMHc4?=
 =?utf-8?B?elZpWW14dEl6N25WMEVwSUhOUU1TUGFzNERIOHVRMFNqMVpLUm93MDBGWUUw?=
 =?utf-8?B?WnJHQXpGZTFwdlRHRkhHcEhQeEdtMGkzQkZGc1ZMdmNaVzVxbFFiRjNsQTQv?=
 =?utf-8?B?a1RPZkY3QXlCZW16ZUpGNmhLRUZzV2pqNXd6dWc5Q2tuclN3T0VlYmQ3YjJn?=
 =?utf-8?B?N3l6eDdUb2twMnVqRGp6U3ZOMHp3MjNmUjlDZjcyMjhuZmg4U2N4SFdPbEkw?=
 =?utf-8?B?TkJPTDlkNWFIQ0tDR2hLWkh3Z0ZMN016NTQzbEpMai85QWh0TnErMDhYU2lG?=
 =?utf-8?Q?XVLs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3528500b-b544-4a90-914c-08de30ddab23
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 13:29:35.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOVLYRHHaMACFFK2RxXe+319B4XNJJ9vOetaDR5gx/UeCPDD5whlVi5meCTNOdcW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156

On Sat, Nov 29, 2025 at 08:20:34PM -0500, Pasha Tatashin wrote:
> On Sat, Nov 29, 2025 at 7:51 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Sat, Nov 29, 2025 at 11:34:49AM +0100, Lukas Wunner wrote:
> > > On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> > > > Add an API to enable the PCI subsystem to track all devices that are
> > > > preserved across a Live Update, including both incoming devices (passed
> > > > from the previous kernel) and outgoing devices (passed to the next
> > > > kernel).
> > > >
> > > > Use PCI segment number and BDF to keep track of devices across Live
> > > > Update. This means the kernel must keep both identifiers constant across
> > > > a Live Update for any preserved device.
> > >
> > > While bus numbers will *usually* stay the same across next and previous
> > > kernel, there are exceptions.  E.g. if "pci=assign-busses" is specified
> > > on the command line, the kernel will re-assign bus numbers on every boot.
> >
> > Stuff like this has to be disabled for this live update stuff, if the
> > bus numbers are changed it will break the active use of the iommu
> > across the kexec.
> >
> > So while what you say is all technically true, I'm not sure this is
> > necessary.
> 
> I agree. However, Lukas's comment made me wonder about the future: if
> we eventually need to preserve non-PCI devices (like a TPM), should we
> be designing a common identification mechanism for all buses now? Or
> should we settle on BDF for PCI and invent stable identifiers for
> other bus types as they become necessary?

Well, at least PCI subsystem should use BDF..

You are probably right that the matching of preserved data to a struct
device should be more general though.

Jason

