Return-Path: <linux-kselftest+bounces-32744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940AEAB12B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 13:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C468527538
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237829008F;
	Fri,  9 May 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pCXCQn0l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAE28FABC;
	Fri,  9 May 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791553; cv=fail; b=YG64B+scdhUB0m/9CjNC96+x1h8oQo/n6qA4YlYPb5oICAJZhgaFmHeivI2u+ACTaAqjeRJrgNSX7VGGldgdt7HwT78zaJM6VoQdvDefEzQGA71Ghk8eymCdsq8T3Yoc5WXEwdClDjxuzYqa9XhvJpi+AC8h27WaqcicytFcJuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791553; c=relaxed/simple;
	bh=AUX9CwqEms0/jGngPUIP0Z6HRajhxb0z9d+sE5agwgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYhJJ0lb7R0ActkYZE9XQPqguWJDZVOpiJstNzb14RLe1hIKhDL8rIIB5asGjeXH1wtkNf6cEO0HqP1N0JVOXjNzftVmq2+SGTkzpP9JwungaU7M7iHSX54gRR9uMMDWzoDfSeZuPE9dVLPVFbZCdVozO8+B2XZGNAewV0S+tOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pCXCQn0l; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGRiq0UptcwKAtHGqb9vYfsWPsnLMDOCyAvEHKQrTGaMkK7aC4gTbN7Hjqp1nry4Z/TX6Uy+oKAhRs61FS6oGvQw3KfcliGsRjkInwkRLXDNQILHm2gHMdnTM0x19v94B/gUmnP+MzaANBzGkXowCZVQpmvLhlqtvDeZIV4d0sD+5kanPLZrxj6WAZxlIZusCCkW8kg55bg0jROcxmZWSMCg61L3WlPwfOWQhk5s/NTa/N7USdFqlXsFlquzwFgfIa6pnO4rxO9MILeLfGZKTrVS2+B0KEOmykTgY5OHJzCfLqPrHRrOZeMxgg5VLOSrdAzC4BE2Wm4oHMX60O/wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqFfW66VWx4jY4GXqEE775um6+UKni7fSgS6G1Dc+dE=;
 b=uRu4xoA4lNoYfce3xkyKPibjEuhEwxbVa+h3Pd6q0nO+JuJGU7PRgwW4fRb2bgI7ykJVqHTmOFGSpeUd6T86PqKWhLhZIPjZJ/T2MsghNPcUedHS9u74D121cu3g0Sgop9qf1XdQRJSq00xAxdWnzDbjfxP0CG0p6sEcXCpEw/2K55jr7CHU06Kahu3SpLSdeulUMXuxq1ewCLAADfn+KT9sJGxgE7Tl5JaHs5JJUXKd7fB/t3YPaZl1v0PF+iiOj4mw0D77xoftRnptFdRcDhSglGlP5o71gHs2esCAS8c3sEG4Yx+T2eB/k+5wl3TBjWH9oVjtKYdd2TeAt0Xm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqFfW66VWx4jY4GXqEE775um6+UKni7fSgS6G1Dc+dE=;
 b=pCXCQn0lbmXDLCcHEYmNxg2RG87Rj0yQI7/tBM1XLUHO8ENR0LOtx/rT3V9Cb7qcZWGLZG+fV7eLkM9rbrtC52qPpLkD0bAw8FGYtU3PRSx+k+8OWEMJ68Y64MS0YOPtqGuQfM20nHoEbIVtF4Vnzv1J8uYAvPcJpt+n9GHcJ9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 11:52:29 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 11:52:29 +0000
Message-ID: <0bd5614d-81f7-4b06-9dc0-c757e6a401bf@amd.com>
Date: Fri, 9 May 2025 17:22:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
 <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
 <20250507123103.GC90261@nvidia.com>
 <2356ff85-6651-47d9-90c7-f8cbf43b053b@amd.com> <aBxHgf4llBd7vA5w@nvidia.com>
 <20250508121456.GB5657@nvidia.com> <aBzl+mn+N4bnUsPN@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aBzl+mn+N4bnUsPN@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a211b1d-fc67-4d22-626d-08dd8eeff935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTJ5b2Z5cVU1V1Z3SGhsQmVMZmZOWVgvN2VBTnQ1alU5WjVwdExqVEtJYnRw?=
 =?utf-8?B?cjluRjJXejRpaUZwL09ldFJkQUFJdmhBT1hZclZXcFczYVN5bXpzRjBzUS9r?=
 =?utf-8?B?d2RDMENuRWl6S2V2Umk5MzJqT042QkhVWnhWUXlpcGduOHYrUUEvSW1vZGpS?=
 =?utf-8?B?YnhXMVRsY0tXZjNiMjE5alZuMEw0WUtOeGx5S0RMcGszbjVOcFEzOVVrSHQx?=
 =?utf-8?B?OVlpNElZZ3RBa1YrUVU3QzVNYVloeTYxV1VFYnBQUit3RWZOZElUcDlHNUFm?=
 =?utf-8?B?OEo1emZRc0JEejlvV1VFK2FCVTI4VHdudm5OdUU2Nm5aWkxQeFE4Ym41eHZi?=
 =?utf-8?B?NUJlRDJqOFhPMnptdzdWb2dTbWJvbTU3SjBzamJqbUcwVzBramdaNUVSVkdM?=
 =?utf-8?B?dytWNWl6Rm9tNXVVVldETXZ6enlpV04yQll3c2xLMGVMK05FTi9VQVlTSEpI?=
 =?utf-8?B?RnZtU21zdWd4NVlJNWVyWDJxZDdhdHJndSsrNFVrQks2bWk3WkFEajFzbEVN?=
 =?utf-8?B?cGZJMmJocWh3SkZ2M3UzR0FVUzZheGxURDV4VHU0S0dQazh6KytPWTBoaCtl?=
 =?utf-8?B?bHgxeW8wOEkrQStLWFA3SWIxR0JvWlpLa3psalBQZ2J6em1hK2JFWWtSTklI?=
 =?utf-8?B?VmE4OFJtUldFV2d0bkZwZndDVkY4K05DKzcxejhOTHFqNXR6Tk8rVklIR1BJ?=
 =?utf-8?B?bXNmaUxxcTlaaTBPUHU4dFI5TDZ2UUplZmRhN3BmTTJ2Wkh6bEZ2VmxoeGRF?=
 =?utf-8?B?V3p6SWFEalVNTGtRUjJaMytTYU5ZWVRxeFFvRStjK0IrTDRwbVhHRDhpK2dX?=
 =?utf-8?B?WnZZS012WDd3emVFZmowOThzSTBWKy9lNnB4bTJnSlJqaE0vQnpMWTN4OXda?=
 =?utf-8?B?eC9jQVRMYnRoNTNPWEl4T2xtY2c4Y0dKSy8rdDdDRDdRM3VaaDJaL1BTR1NQ?=
 =?utf-8?B?alJFOVpYOGNvL0F1aXplSUZKWGxUeVloc2hvRDVPWEpDaURaanNKZzRLbVpC?=
 =?utf-8?B?dSt5ck12S3dxaWRtSk1RYnkxcytOT00xWmlyUnZQRzQ2S2oxOWt3QXVsV0ZP?=
 =?utf-8?B?SGVQdExxZmxKRUcwcW82dFk5KzZieEUzeEVPRmFiM2pnVkpsVFkvYXkyRDFj?=
 =?utf-8?B?bVlPUEtBQjd3RCtHNTVna00yRWdiMmJHeFB2b2g4alY5TmZvZjgrbUE0Vi9m?=
 =?utf-8?B?UEJYRUZGZVROM3NJc2VueHFmU05BRTN3SFNWeWxyUnJ4cVdpRkphVkgwZWl1?=
 =?utf-8?B?a09XSUplT1FKdnRFakp2d0VDanNaRTQyc3lrZTAzVzBUUDZKbmJ5VlMvdTVT?=
 =?utf-8?B?MUVDWjZJWUhITnBsVG5lcCtiR3RZZlUvZjBTUEI2R1E1eW1JNVUvdHJBcXY4?=
 =?utf-8?B?NElvNEJYcmhJS2JGbjZVZlRDWk13TlA3bm05UlpHL2dPRjBVTTROcGNpRytz?=
 =?utf-8?B?STlUeUo0VnBBbHkwbnVrVGw1WS91clBkMmZDTEtDZkgzc3ZxRGU3bzVleWF4?=
 =?utf-8?B?VkhDTUJFcGpaRFEvcTluUVVoZXR3T0xkMkhLaTdmcE9lMi8wdkpaZTAzdGRw?=
 =?utf-8?B?RWJkaXZqOFdBcEhGSmRFYU0ya2E3UUh6NGtrbnl1dEpDUGoyQ0R5VEpTaDFW?=
 =?utf-8?B?aW4vYUVRb0YrOEpVSU1yVWlacVNhYkE1d0Y5aUVsQWNFY1JFcVZUYUpLNXND?=
 =?utf-8?B?VzZnWlF6cnlxSytLNUlFc1RsazBUTk1pc0liRFFDNDFnS1l1K0Y1K0RUQnlP?=
 =?utf-8?B?VE5yVFF5dUt4WUdhb1ExSXBzejJpbFlRSkZQMG1oVlRWc3UvaG1TRGtoUG1z?=
 =?utf-8?B?Um94NFNvcmJ5bEpaNk1ENHMwY1ZpUkpVOVhJcVRIV2FtSm12THNyUHN3Z0ps?=
 =?utf-8?B?TDJ1czAyb2pWVjF4VVEwSnQyeFY5NHlSc1BXcitSdUxNcUQyQVBMeEU5b3Rq?=
 =?utf-8?Q?G869z8YXaDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3BXRkhWK04vb2hFVHN3TFVXano2OXpURTIwUUZnZTV5cFRuemJnZ2NIQmhj?=
 =?utf-8?B?dHF1NkFVTm40V2VYaWhQNzVqalQ2UXF2N3dOb2lraUZsS28yQnBhcDR1cnVV?=
 =?utf-8?B?dmdTZVJLUnpkbjNuczFYN1BjU1pTQWorQnAzMytubnpjVUFvaTJnYXQyelkr?=
 =?utf-8?B?bllZdFI4MUZDdGt1d1d6aGt3ZUd0MWtFa2JCbzF0bXBKZGpTdjI5Y1dmMitL?=
 =?utf-8?B?ZmVOUkVqdnNqSjYzWkczc3ZWemtQcU5GaGV2dG85Y3BLS3ovcU9QZmIxU3VH?=
 =?utf-8?B?ZVlhZmdCK0lzOERmNXdvVnZQRUQ0RDZwZk9aVnJFaHNMaTFsZERDVHM2SCtE?=
 =?utf-8?B?RVNHaC9VK3JnckxoREJHRC9xWG1SUno3ME1OMXhDNzk5enVsbGJHMVAxc1hm?=
 =?utf-8?B?TW5tNzlUTGNwWTVoZ0diaW5HVDdVN09lNlNCc202R1VUMER6TldKNXFQbEsy?=
 =?utf-8?B?RHBNclNBNmdjUkJSb004NVc5RFpFdytsTi8xdVRVL1BUdnFsR1BSUmNKdXB2?=
 =?utf-8?B?Y09CWDAzVXNkc1NGQUoybWgwUlRuNTdBTlIxc3l6cWtsQ3dCbVN4WUZTSGx0?=
 =?utf-8?B?SytjakdyUkNQUzVpVzF6d2xyZm5OS1RtQzlMQlZEWVlkWGZtVEROWkNPYSt4?=
 =?utf-8?B?NXZSRUU2V21MVThack11NGdsb3NXL2E0WjZxeFhqK3hDa1F6aDN3UjhGWjM2?=
 =?utf-8?B?RStYZmhXaEJiT212Z1ZEdVF2R3JVTXNVWGxRSU1BWnpoanBTeVNqK2hqQ0pM?=
 =?utf-8?B?WENMTlZLY1UrbTFwQVphQThkWnFra1BWcTRIdCtSVThjclBxODl1UC8rSTJl?=
 =?utf-8?B?QWY4bTVwSyt4dXZWS2x3NWRWTGVnMG0vUmQ5R2lRY0V5dTlWbDF2VjFKSWVF?=
 =?utf-8?B?Z3FrcE1Vak5pcVdlRjJVTXh4L09DSG1KdmYrdDYyQzJpVjhONTNTQWhTVi9l?=
 =?utf-8?B?c1BaSlVMK2JlNVNybjdGMVVpQ1hKMHVjZDgrWXdITW1RK1FraDNFRDBnN2hy?=
 =?utf-8?B?a2p4R1BZM0lIWUllSG9jMmJubFRNNm55OHgyOWR3UXFzUWVxNUNzdmhTM0lO?=
 =?utf-8?B?Nk5sdWJwVlBEaUxScVZEZGgvU0xpR3l0MGpNNk9Kb1FIZGxIcTZqVmNYVTBS?=
 =?utf-8?B?RmVVR3Jkb1FMZHZISEF2MXhMQlRBejBvMXNwUGFaVncySWF3aUtsbGE3eHox?=
 =?utf-8?B?VUdRK3Yzc3hIemR5REozekNoMGhONTF2T3pPNW9oaU5kRnN0TVFjOW9rRnNp?=
 =?utf-8?B?OUVGcUZvTi84clBKaUZCWTZZUno5bDZQYzArRHp4b2hEMEFvN2M2Y1FSWFNN?=
 =?utf-8?B?bFJncmVjNC8rUndxTnRuU2c5ZkxydnJjSFR0Wk1SZFE2eDVGbVpIdUxjelBy?=
 =?utf-8?B?ek16ZUg5TUsxUXh2MitJMDAwSGRudkZQWlBnRjVGU0luUWxQUDFyYVEwakQw?=
 =?utf-8?B?Z2phVGZOZDc5bVNwRG4xdzl3L1AvbjhqM05EaG1EblNReHVYd29CNEtJOWJ5?=
 =?utf-8?B?SjJCQzBiL1BJZUNpTCtta0EyOFNFdWRId0NyWnFkdjNFOWNSNXhQcXhKczg4?=
 =?utf-8?B?UzZxelQ3eFUzSFRBRjAzNlg1bGM0dmYwSDFKM3N2K3UyRkZMd200MDNOSzlE?=
 =?utf-8?B?d3ZicHc4NWdHUmhtWEdIQ05SaEZ2dkxTK2psVGZaOEkvbktnSjUzekJTWncw?=
 =?utf-8?B?S1J3V1RmektUZThtRHBqOHJ4K25mbnhpcHZ6UEtXOW5rNWxkLzlheEFCbm5h?=
 =?utf-8?B?YnNjNlprZGhzRnZoT01KR0VxcFlDcWxWRjJIaFh4NDM4TFBQdzVNUlFpVFI0?=
 =?utf-8?B?NUcrL2F5OG82cUkxYm9iTjVJdFZPbWxsdkw1ZlNiYWF2ajJUcnFkREZWU2Iy?=
 =?utf-8?B?M0IvRXV0VVBZRmM5Ykhia1g2Tk9NSXBwOWxyRldUNnRhTk53NDVUU0k4Y1dy?=
 =?utf-8?B?aU4veitlTHdGOFRiZGh5a2taYzVSWFdTemF0b0h0TVQyQmhsZXVQd1NmTmpY?=
 =?utf-8?B?elg1andlU0NWMDBUNGVMNkFPT2R5eWhhYms0UWVXWmFYTVdneXYrTy9Dci9M?=
 =?utf-8?B?bFNSU1BrcEJKejR0ZUZzWlJTWjliZWM3WWRCckNTNkEybmVnd2gxV2MzaXk5?=
 =?utf-8?Q?MpgN47XoTqnpb/0hxC8v0XCew?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a211b1d-fc67-4d22-626d-08dd8eeff935
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:52:29.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxTiBY9R9kiCljtkWk7VYhCLLEkitGJwFmc313NHK3jiTpHi8QNeV0FhZvWvsLiMDpowVn+BSK4+4zsXlHc8fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

Hi Nicolin, Jason,


On 5/8/2025 10:42 PM, Nicolin Chen wrote:
> On Thu, May 08, 2025 at 09:14:56AM -0300, Jason Gunthorpe wrote:
>> On Wed, May 07, 2025 at 10:56:17PM -0700, Nicolin Chen wrote:
>>
>>> What I am not sure is if the HW allows setting the ComWaitIntEn bit
>>> after CmdBufEn=1, which seems to be unlikely but the spec does not
>>> highlight. If so, this would be an modification to the HW QUEUE, in
>>> which case we could either do an relocation of the HW QUEUE (where
>>> we can set the flag in the 2nd allocation) or add an new option via
>>> IOMMUFD_CMD_OPTION (as Kevin suggested), and I think it should be
>>> a per-HW_QUEUE option since it doesn't affect other type of queues
>>> like Event/PRR Log Buffers.
>>
>> The main question is if the control is global to the entire VIOMMU and
>> all its HW QUEUE's or local to a single HW QUEUE.
> 
> Oh, that's right.. I recall AMD only has one Command Buffer,
> but can have dual Event Log Buffers and dual PPR Log Buffers.

Right.

> 
> And the EventIntEn or PprIntEn bit seem to be global for the
> dual buffers..

Yes. But there are other bit to configure dual buffers etc.
(like DualEventLogEn).

> 
>> If it is global then some "modify viommu" operation should be used to
>> change it.
>>
>> If it is local then some "modify hw queu" operation.
>>
>> IOMMUFD_CMD_OPTION could be used with an object_id == VIOMMU as a kind
>> of modify..
> 
> Vasant can confirm. But looks like it should be a vIOMMU
> option.

I think CMD_OPTION will work. So something like below?

if (cmd_option_id == IOMMU_OPTION_VIOMMU && cmd->object_id == viommu_id)
	iommufd_viommu->ops->viommu_options() ?


-Vasant



