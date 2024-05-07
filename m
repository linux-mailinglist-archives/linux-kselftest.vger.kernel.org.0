Return-Path: <linux-kselftest+bounces-9624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD738BE9A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED32E1F2193D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE916C871;
	Tue,  7 May 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wg6rYcWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99B433D6;
	Tue,  7 May 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100456; cv=fail; b=UHzF+f0LxDx3P0Nm0F7l73CpY+TAP/+2ScsnT8npp8BY0BCVWTffMNN5onLwgIE8TV3nYAPKb8NDN2MrdRGB78qyU6cETjHLumuqj1m1n2GTxbsjeZegGnRsPcTWLkQqwB9pHjzGUNjEe9+pU8pwKqZgI1NMFe3cqIX2zH/WB9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100456; c=relaxed/simple;
	bh=eX9TMvQxklQygD/emr1qSc8pzTvNxY0d/tpFhC0vuXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EMBCPyj6nnCMvoWa4tviaHFEUZRDZw2XvQyhpt0eucOYzMNijtwR7SEWUcbT8lr2cUgRUlWtd6UXJif1/DS99xe/M7OzD1nDq7BkV1ZbmiygO299VpReoC4yv20YIYQhUfCgkUjmOGMJMuFuowfYronSd7L7lDMrCUxEP9pg8eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wg6rYcWN; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoHOKfiTSXkXx/PhQAzvW3DSkuWeeJ8u+25qKqpQ0B1ePu37/xxfux+arPsSRZcmWhb9gI/S6cmOd6bRJY6qOuIyMllgb9wCkgdfubG9H9R57LzPQJuD213gy9oHoX3tfLBsE5H6IP8JR1jzvhICIiXskpCV+GUd0kiXrfg+T+n7N6BtK2/af+Jw5tQDbYmbeK/4EgxxpPuq1ZSKZMnckhyua8E+B7TQEmHSMQXkvHsG0zAg+ggeHnzwe9EWrxM7qp+H87fEySDnaaFXeqBpVW6hmUZ/GlntbpN8l3+SljnoqCs9YYVqeFS6aIfVHUrgYPczPzcAxXs/pZawCYUbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDJfyV4+gn4hClH8jaB2Qe8HdQYdhkCC1fR8KCV8g3c=;
 b=BHRsRqvlb8DS3po6cubCDKTpeXZLa1Zlug8c3hGa+p45wou3ZOcp14vXbdV8q6lljXJYAjU6293h7YTuHihd1rIK+NrzeV9Udkc7ES23/XqbUN0QUynXYVyb16+wOuG7wkTg7n3fbI6U5Bbnx5f37RAVSlp/BLoYC9tyi2onV3rTkkBi9zbDtOeezmv1FXUFvFb8yA4kULKMOcETjFkDf0TTneh3Jc+6GUitrmRVm04CgnbwZHje8f5ttJGSj27NHrMOemwfDDes1E9Q5OWOEt6FeuOoPlhrRv6FwSJFblDdQ/A/7r4XFk0PvB76B8l89JjnMJGZRteG7bD/lhOR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDJfyV4+gn4hClH8jaB2Qe8HdQYdhkCC1fR8KCV8g3c=;
 b=Wg6rYcWNIsZB8xPMBCD4WUYDOJSDskFQBw7LFw+z8WBtZCJfhaLm4nXD1+tCXBuvbrGA+42LR0xTosxzEWrAO+lUsK9dyut7odQgtWeLt+Wrgq7dyrIV4BsPxHB4Atty0MTBAXN+LnOTjELTBouH7liuwZHM/KWenNzc2M1bSYkgHp54v2ZNWoMhQ+l3DkN6naiQnLJE6wfuEvCCazT40VsNtRj2Zuj6IYUUel1cejyq53tDPVf5gTzL32r4AgS5k1pAkFdNQCfFNV3wHoySjlSXz6AvzRDEnRLnEY9TR9w35iBVFE7LSUkXqA6CgvDSkd43okMmXp6vKTR9vfgMew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Tue, 7 May 2024 16:47:28 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:47:28 +0000
Message-ID: <c1ff82e6-4d6a-4680-925f-5f0226ba32c4@nvidia.com>
Date: Tue, 7 May 2024 09:47:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
To: Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <8fdefaa9-675e-4b37-9456-896b9989d18f@arm.com>
 <9e346b64-0a7c-4eb9-88c4-8fb6cf65b33f@nvidia.com>
 <518dd1e3-e31a-41c3-b488-9b75a64b6c8a@arm.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <518dd1e3-e31a-41c3-b488-9b75a64b6c8a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: f548d293-cd2b-4096-e0e6-08dc6eb561ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVhnT0U5czYxM21lRG1heXFMR3pQRWVaaUdpa1c3ajZQT2lFQzUrSWNJaEVM?=
 =?utf-8?B?UkNCaWdLdFNCbzEvM3lCeFd1bm9yeE9ISHA5cGcrZGI0SnpXMG16MVpPZkxZ?=
 =?utf-8?B?bVFqeDVxcFdTc2V4R3hxdWN3aVViSjNVcjl2ZENob0hpdTVDOWU4cjU5ekxm?=
 =?utf-8?B?anlQVGxIYU54cmVoSmQyaVBZdm1VRjlkTnlmMUl0T1RRb29TV1pGdXB0akZR?=
 =?utf-8?B?cXJoZ2RZZzcvK29Wc2R6amxackUrY0dWYklUcVA5bFAwb2JQSi8yN3ByYUxx?=
 =?utf-8?B?R1ZOVTNCUC9uTjJuZDVDY3o4QzVaVm5XckY4NU9USDFGbnFYNHVoUkU2NnYv?=
 =?utf-8?B?TWdKTVBoNCtLcFlYd2wyb2FySGhlbURrZmtCOWdCOFJNdlJCek90OEE0bVJk?=
 =?utf-8?B?RjJSNlRDclYzb2hxZ1dtM0VuRmYvbG9semkrRnVSQUxUZzlPa01xbUN2NjlK?=
 =?utf-8?B?cTJiOVB5UkpCdUF6OGNuRTdickJaa3hrenZQcHNNUmUyQmFEaVdwM1hyV05u?=
 =?utf-8?B?N0ZVZmc5djFaV0VvVVFKZVJkR2k5Q1Fxc2dROHJUc3ZoTjdYWVNaaysySzRx?=
 =?utf-8?B?NXE3VHdpTTlKUkFKU2ZXTjVURHphL2F3dmluQi94SUdWd3Y0bGtReDVmQ1Q3?=
 =?utf-8?B?ZW4wT1BOalYvaTdwQXlkbVJmbFQ0VnNjS3M3WlE3b3pDaExYOXpkTWVXSUdG?=
 =?utf-8?B?RDVmRy9JVkpsK1lxbFdrb1Ruc2RkSlY1L2ZDSFpEWkhJWVBXK0FjdTI1UWJF?=
 =?utf-8?B?TEMrYU5rVUtKMGtpTENWdXJoblpQSDVPV0tyNmNxRm1XZkZsb092MmhKdG1u?=
 =?utf-8?B?UjBSOE44cUYvczhRWU9Cd2NSV3lzUkRiMGRMWkI3alpIYkN1YlllZjNZbEYx?=
 =?utf-8?B?anRDTUh6MjJTajY2RTZWSFVKNzJNb1dBYzhHMERCbmgza0lnN3A0WmtjNUU2?=
 =?utf-8?B?OWtsemFpNDk3OUpNdDR6cVRZNmZhZTZzMk81eE8rU0tRdHVlTGlZaXYyZ3pk?=
 =?utf-8?B?WnB6dlRGQXR0MGJVYTJmSkVXVno4dnBaWVJ4Z0pXM1V6UDkvRnIwdmRJU2g5?=
 =?utf-8?B?OHJYRUIyTExFbTBQajZwdzR2ZWg2WEV5V2NFNTQzRUxTSURUcnlHRTlzU0NE?=
 =?utf-8?B?NVpIc0l2Ly9EL2RlYWEvTlVjWDVzV0p6aUdpU0l5TnNhaVVxbTNSNU5QMkVR?=
 =?utf-8?B?aVlPNitzRTVVZ3k3ck9DalJTamtnVlBteksrMlAvc1ptTXpVWlJ6YVZkeXdC?=
 =?utf-8?B?Q2lJTW5tTmNuUnNDSWNHd0RjQ2JsenFFeTZRT0pGL1A4eXdPVUZyeUdTazRz?=
 =?utf-8?B?SFNTSU91enp4MVNWZHBxN2hLM0dxaVZiZ3lZM01mRE1UNFdjVDZOMFlxMnhT?=
 =?utf-8?B?cnBCeWUwZnFkVU1qYkc5ODFqT1o2MGZGWElzUTFuMFBwK3BRZlJKSE9qaFVW?=
 =?utf-8?B?UFU5OXBCNnJtZDlDWEdXVjVuS1pYY2YrT05tNUsrTzFDN1JKbVRnNWtBaVpS?=
 =?utf-8?B?T1M2ZlpJSkFzSlpUN3g5VDhncjUzVE8yd2ZBcXV0dlZqWXVPTFZFSXdXMlhI?=
 =?utf-8?B?ZzBSc29SajB6V1ZtOFg4RloyeTlETzRwdFhZRTd3aXU4UUdmaFBoa1gzSXBh?=
 =?utf-8?B?Nmc3Vk5WNXlFaGdrUlMrcThzdzFUU2NsNi9KdjJiV0pJUzh5U3hZRzRoNU5x?=
 =?utf-8?B?blhqbWhFMHphTGl5NjBuNlhxY2JqeXZUd3JFaDBPRG8xZmdINzlLRmhCUHRT?=
 =?utf-8?Q?XQFhmsGmUJc/Ubzigo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTFIbnlhczF6VENET1lNai9QT1FGa0NmWTdqTi8vZTVPZmlvUkYxUkFkbUM1?=
 =?utf-8?B?YnFMaUY5ZlcxVkhSTGpiWm1OR0d5bU44QWJLVjNid2Z1OVVVTXdncm5OL1ha?=
 =?utf-8?B?d1AwdlQ1VXpPdFhYaWRWZUpacTgvMzNEVUs5N1VlTHgrc3pTMHluK2lJd1My?=
 =?utf-8?B?ck5xS3lqb3k4L2w0VnVYZmxOSXJORFZ4QysyT0UxV1hRbnpxTlVLNkpUb0dF?=
 =?utf-8?B?SitHNmlWaTRhRCs1dlBheTNmNzVDU1AvU3cyTDh5cktUdDUwQTBRS0xJWkhr?=
 =?utf-8?B?b2luaTBNM0VCdGMzTVhkWnd2Y0JmR0NvZ0NJZVpkbGo1NjlvNzNEejRFRzc2?=
 =?utf-8?B?elduOVgwejhpVWdKSFFYRW83b1FmelZUdTBaOSttOW5Zc2p4WFkvQTRMWGNx?=
 =?utf-8?B?ZDNnTEdsUC80eXlmdnc1VWo4MlU2SXZRTUZyaEJ5RjErSGNJeVdSdFJwZDBB?=
 =?utf-8?B?QW5WaC8rTVdoKzVPSklwaEpPZCtuVkdNNmJEZVFCZzFmRmRpTk9XWllYTkRN?=
 =?utf-8?B?T3QwY2JJcWk4UWhwWTJMbUxNU2UrWkRsUm9oZVNsNDdjdDJZcnhxdGM0bkRo?=
 =?utf-8?B?K0dKdmxyMFF0THdyQnVLbTRDT2hGUjFBaFU5aGFJL2VTdUU2MEJSUmFObVNh?=
 =?utf-8?B?bTEyOVVJQldyWHdNaCtQTXBaNitVYzdqYUl6ZDd2UFJQZGp0WmxFWWk4eTdy?=
 =?utf-8?B?QjN1TkdkNWFjUncyTGlpdjFoVk80MXpINGNPdCtpQUNka0JrYjN6THNFalBM?=
 =?utf-8?B?cVl5NG5OZ3oweG41SXpQZmRMMENhaGVLYXhnNjBBSVlMY3NCcUtycm93a1dy?=
 =?utf-8?B?dTVma3J2T1pRbDZZWG1NMlFQYjhMZDdzSHVOTklhVE9WNkxnQTJZRndWY3RU?=
 =?utf-8?B?UnpRWUMrZ2RYTXdQY2VkbjhlYVJINXZMV0ZOa08wL0pVKzVDZzNiTjdmdUhq?=
 =?utf-8?B?ZGxoNHJEYmVOR2hmdDJ0VUY0ZndSK1MvOWhXNUlSWUl4ZGhYUjNCQXNKZ1hW?=
 =?utf-8?B?M1NaUzlGV0Q4OUdCSG5YSUNWMTE5TmNHajNTS2xjenBuTGQwT2dSbEc5TzZI?=
 =?utf-8?B?bmJrRnkvckJoT2NFbm84NHdxcml4Q2YrS0R3T1QzNUNETU9jM2g3MVh6Sytw?=
 =?utf-8?B?TnRVaUhQaFVwOENjWWxXMUNSNW4yNE1haHdLd0FsdERzNHNBZGpWUlZvbG54?=
 =?utf-8?B?OUFsNTAwM0luN1BVVDhtSEhEWjJlb2QvcGhaLytpd3FtWlcrclJwemRpTmlr?=
 =?utf-8?B?S0JoNGtCaTlqMW9qTk5iak50QWNEWFpZdlVYSzA5Ukpya0l5Q2RvQVZzN3Jp?=
 =?utf-8?B?TFFwNmhrelRxUWFWY29WTTk5LzV5VVdtdGdrS3JFWjM1RDhyTERHbFdpNWxi?=
 =?utf-8?B?OFlaVVFDTWJrNXpFM3gyR1BkY0w4T0FwMGt1aHBSUFFiaFdZMGovVXI2NE84?=
 =?utf-8?B?N0V3NTJaRlQ4b0prSzZmS0VkaHdvR1pzeGp4UWQvdGxxYjllV0tiZW9XVGxV?=
 =?utf-8?B?Nm1wdm56RWxGTWVhY1JXZFdoaDVldWUrQlRWY2IybEdCSTR4aHFSREFyb2N1?=
 =?utf-8?B?Vkx3Mm4xNmw4S2k5UGVKQjRXTTNFaC9nZkZ3YWdHbitJYlpPd3JnV2JYUE1C?=
 =?utf-8?B?alRpTG9rMDg2ZVQ0WEpyY0JuS2JtQjVFeHZNTDFZUmt6WG1CREk4ODJoajE5?=
 =?utf-8?B?VWVwc0k4S0k0QWdJWUU5NjZsbEZjRTN6bmExNlh3LzNyTU91clZGWnJlTUZH?=
 =?utf-8?B?dzJYejZSMW5saGxkemlGVFA0N1c4ZGVGOHBUV2RzaWlIamhTRzBQWE4yblNy?=
 =?utf-8?B?ZEplNk5SYTlpSjdaSG5SaDIyNks5NzRtMVhNMmtNZmFHcnhmblk3RStTU0dT?=
 =?utf-8?B?VUY5ekhwRS9ZSVMzcHFtczMwSG1vaEJkOWRTSHZaQW5MdVZGV2l2WmdqMGdS?=
 =?utf-8?B?RmdXZ0YwcjREVERWcWNPVVlhZXBTS3c0Z01ieGIwblcrcmppZGNkQXpRTS9R?=
 =?utf-8?B?NFpxN3N6ZUxLQnJySThRT2IyRi9qdEhaL0taaExicjFhZjlBOEFaWmMzL2p6?=
 =?utf-8?B?ajFidVJkR28wdkpkODg3T01PTFZ1VmlDUGUxdFQwK0FuaFdOTlFodmsraFFK?=
 =?utf-8?B?TER3dGt1YzBxUDcwVTVxVlBmU0xqN2xOalpUT1FBaFoxTkJUdUNXcmkveE1G?=
 =?utf-8?Q?d3TkZX8NSEYfbiGnM9XjdhE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f548d293-cd2b-4096-e0e6-08dc6eb561ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:47:28.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDB7w3y+UlDwIIBEG29HQzmBJrGuiXS1oxvv9JELZfENlFMcXcg4Cw0OMR0iC5zLRvhzk+fIoPLXwWpj85Oezg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

On 5/7/24 9:34 AM, Ryan Roberts wrote:
> On 07/05/2024 17:19, John Hubbard wrote:
>> On 5/7/24 12:45 AM, Ryan Roberts wrote:
>>> On 04/05/2024 05:43, John Hubbard wrote:
>> ...
>>> Hi John,
>>>
>>> I sent out a similar fix a couple of weeks ago, see [1]. I don't think it got
>>> picked up though. It takes a slightly different approach, explicitly adding
>>> -static-libsan (note no 'a') for clang, instead of relying on its default.
>>>
>>> And it just drops helpers.h from the makefile altogether, on the assumption that
>>> it was a mistake; its just a header and shouldn't be compiled directly. I'm not
>>> exactly sure what the benefit of adding it to LOCAL_HDRS is?
>>
>> Ah no, you must not drop headers.h. That's a mistake itself, because
>> LOCAL_HDRS adds a Make dependency; that's its purpose. If you touch
>> helpers.h it should cause a rebuild, which won't happen if you remove it
>> from LOCAL_HDRS.
> 
> Ahh. I was under the impression that the compiler was configured to output the
> list of dependencies for make to track (something like -M, from memory ?). Since
> helpers.h is included from helpers.c I assumed it would be tracked like this - I
> guess its not that simple?

This can be done, but it is not automatic with GNU Make. You have to 
explicitly
run gcc -M, capture the output in a dependencies list, and track it. 
Which the
Kbuild system does, but kselftest does not.

After just now sweeping through kselftest to fix up the clang build, I see a
lot of mistaken or partial use of the kselftest build's Make variables, 
because
people naturally reason based on what they know about Kbuild, and it doesn't
always translate. And LOCAL_HDRS might need some more documentation too.
I'll keep thinking about how to clarify this, I have a couple early ideas.

> 
> Anyway, on the basis that LOCAL_HDRS is the right way to do this, let's go with
> your version and drop mine:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 

Thanks for the review!

thanks,
-- 
John Hubbard
NVIDIA

>>
>> The way it works is that lib.mk adds $(LOCAL_HDRS) to the dependencies list,
>> but then filters precisely that same set *out* of the list that it provides
>> to the compile invocation.
>>
>> The other way to implement this requirement of "some things need to be
>> Make dependencies, and some need to be both dependencies and compilation
>> inputs", is to add everything to the dependency list, but then use a
>> separate list of files to pass to the compiler. For an example of that,
>> see $(EXTRA_FILES) in patch 1/7 [1] of my selftests/x86 cleanup.
>>
>> [1] https://lore.kernel.org/all/20240503030214.86681-2-jhubbard@nvidia.com/
>>
>> thanks,
>> John Hubbard
>>
>>>
>>> [1]
>>> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>> ---
>>>>    tools/testing/selftests/openat2/Makefile | 14 ++++++++++++--
>>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/openat2/Makefile
>>>> b/tools/testing/selftests/openat2/Makefile
>>>> index 254d676a2689..185dc76ebb5f 100644
>>>> --- a/tools/testing/selftests/openat2/Makefile
>>>> +++ b/tools/testing/selftests/openat2/Makefile
>>>> @@ -1,8 +1,18 @@
>>>>    # SPDX-License-Identifier: GPL-2.0-or-later
>>>>    -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>>>> -static-libasan
>>>> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>>>>    TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>>>>    +# gcc requires -static-libasan in order to ensure that Address Sanitizer's
>>>> +# library is the first one loaded. However, clang already statically links the
>>>> +# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
>>>> +# -static-libasan for clang builds.
>>>> +ifeq ($(LLVM),)
>>>> +    CFLAGS += -static-libasan
>>>> +endif
>>>> +
>>>> +LOCAL_HDRS += helpers.h
>>>> +
>>>>    include ../lib.mk
>>>>    -$(TEST_GEN_PROGS): helpers.c helpers.h
>>>> +$(TEST_GEN_PROGS): helpers.c
>>>>
>>>> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
>>>> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
>>>
>>
>> thanks,
> 


