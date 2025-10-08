Return-Path: <linux-kselftest+bounces-42867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57EBBC43EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE7D3A8AC8
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32ED2ED866;
	Wed,  8 Oct 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1fckGmf1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09038221FBB;
	Wed,  8 Oct 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917960; cv=fail; b=bRMVQd5LMs4/HLqSinMn3OwWDjBM4xQmdK3PZ4v7SF1ONg+Fbhl+2Rpb7KgxM714bDhsTCib1zUYRZLs5XzmRGlhuu2kyNl4BGth0nfJe0rkJwDgSs9n6lRybmWF/QvO1BXOm0VVUQ9utQ2LqHY4f5GAx/jSbgQ4HEzrKDPItYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917960; c=relaxed/simple;
	bh=DCnTXGRP1CPDIoX++/4+w60o6lELJ1jNCwFO9bu0Dko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s/57Sa2ro2fJKqkifhLuuiUin3PMzkKl7NuQVUtCj3BJMMagrmAYQzZEuomKCUbHmbo6Ee/6Rl19R3pgsDgBRLsAOxB+lvuIEssVLv9r/LZzsU6RIfaI8GC635vT3RhDuEkBueG1bWXKsDRKcYvyBSxgpYQ2R3giOufBW7yaXpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1fckGmf1; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBPyaIxWdrRRhTd9vR9ZB8Jb4eesjK957/5n1JuE+zOwoaYsBNbvW+kVz8kKx/RP3rpmBGd+oyFoYHtE83c0BJ5E1iipJ72shUeMgEclrjdcWvOwmxqOwwiE6rhfmbkQjTGw6FS087rw4SKIVSfEIfHTCB+2SwDooENKY315aqDdcxwrE99ULvE64RgLZZAIrS4J3RpS9YJg8T0OlNfDDm4Z/NVLLanmL3KbToJuwFt0+zjpb8P7zFKPfZKrhrmZVGpEDjzcgH/zob8QiugRBe4tRDR4FhsiJ6QtAE5RGreTlLE2MXJfVey4Q8Y7fLPgWeBIsSrQI6orrQmKV4Ep8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvTd54g/qCW2ay/cd4s+cj1iGgikQGAFnRms3KMsAbI=;
 b=Gva2QsQHCIChAV96RBksiW9ulcwftpaV3J19TWUFLEXGlKhxYsluyywtoFnR/BGpaWje8yRyL+5+3Ha3vRrXjkEkHGRKBBU2YJJkA+2FiyiOX2ROk9H1FPIPeebqBbIy+ATFoAdIGDRROWOGtb08XAEbJKDfoxDXSTWXlju+CIZRV17afgnon2y0AijAJX2tXrzJwke9Y68AqF5WGANzltCO5bIlUdkcRK45uUz6PpnIenwPdXqt6ce04yUvl/1urSUyRCJ1ogvCG9bo9SyPQmmrk41GKzJL3RcVL128vJfsw58OqK5YQKwAkg8JPVehyUE/pA36D5roarlLL8jJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvTd54g/qCW2ay/cd4s+cj1iGgikQGAFnRms3KMsAbI=;
 b=1fckGmf1IMBhgg12ZURkl0E3MF4Yy5dog9zQ1HJYx3iX+3Q2bZoW7cCD52PnfoVzB6RIqbQxrPbKvQeP8zrxzj2YpTjMOF9dFEp9eZJ6Pu8dAc+lv9rwzQLAvxX/51DOZ2CMr6gU6xJ8J95Cfy+L/n3zRhIFIFJRKHeUjPlm0Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 10:05:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 10:05:51 +0000
Message-ID: <2daa4e59-f5ea-43ca-bfc0-4a29e904e29a@amd.com>
Date: Wed, 8 Oct 2025 15:35:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/15] iommupt: Add the x86 64 bit page table format
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3f79da-0e57-41e2-009e-08de06524281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkFicjMvQWQ1R3kzbnBYeUF0NkNGalpaNitvWVpiQmZwMm9qVStEK2c3Tko3?=
 =?utf-8?B?aTlMa01kbDhDQjVYV2l4dzZ1ZW9SUVdPS3pkUTYxL0dnR0J2N2FiRy9lTUZn?=
 =?utf-8?B?a3BVdlRmeDFIMm8rWVVpNENJKzJyNERPZlJKbmJwNTVoTkFXYlhyNm5sTFNv?=
 =?utf-8?B?a1hDMVpPRFVKQnM3UkFEV05jSEtlaFphYjc0akJuQmVGNy91YTYzYm16RDlR?=
 =?utf-8?B?N3gxZUFyODlnKzlIVmtXWi9nSWRnL3AzRVZUdDFKcUYrMGgyNTlXbko3c0Z4?=
 =?utf-8?B?cVFud290TzZuRkNwK3dzNmpKdU9kckcwVlZuZmphOXlyaEhGUzJkZHhqa284?=
 =?utf-8?B?bFVhTUhma1ZqS0tPVU5KSWtDWEFQSjA0QzM3K3Q0M2JrM3V3cWp3cUtIbHVK?=
 =?utf-8?B?ejVDMXhxc0NkU0dZUWtQN1FwTFV6YkEyZE0xOVdEM0cvTGpHMktSN0NFNkMy?=
 =?utf-8?B?emxzaHcyR2swYmxWMGpWbjNQS28vTU9vYk5tNjBjSUs3QXc2OFhyTUtwZzlk?=
 =?utf-8?B?U1hFaG1ROWFMUjdMR2JuMUhXc2pRYzRhcU5PWXV5emhRaW9uOWVDaGJuamJ5?=
 =?utf-8?B?U3N0WlAvb1RzempNVnRhaFBoUkdvMlRyNStxdDJmTWg5UVBkTHorTndJUzha?=
 =?utf-8?B?RUI1NEtsUFdYRzh1T3dYN0pQcmluNVpyaDVXaUFSNjU4RU1BR1pjZW9tNnht?=
 =?utf-8?B?SVJZVThwQmxJN3dQV09kWGtBaEphTm41MFNTSE0ySTlVbERlazQwV1RRYlh6?=
 =?utf-8?B?OGxtdnZEYXdjaTVnbHBzcmhHb2NuZElpR3E2RU0rcld0alNUdmJLMzBvRkNi?=
 =?utf-8?B?bXE5SklReFJqT3Q3aW8rMlVxajgwT1dtclovSzNEaEF3ZU16dzZBaSszK0d6?=
 =?utf-8?B?ZUFhOFFYdWY3d2pFVmwxeXpOZVMveGhoa0tBVUlDM2ZjNGtZUmJiY3VoWkUx?=
 =?utf-8?B?R2pkWmwwTXlYMXRWMFd6Tm9Rb2M1VWJySC9GSFRuUTNURWpIOTZqRmptNXNU?=
 =?utf-8?B?YTZZUXFBZ2d2MEp4RUpUSlBxbkpGaEsyRVFvVkEwNnlrQ0puZFN4ODRWY0pR?=
 =?utf-8?B?blZaaTNYZHdRaWpJc2xDWlh6UkpFeG5hamVIZ2Q1NXhUai9Dc2FwY3ZlbWRK?=
 =?utf-8?B?dGx3bkp6K0JMOW02OVpoYktDN0ovR1g3a3NFUUdIdGcwekJSaENTaWNxcldq?=
 =?utf-8?B?UjZWai9nNnFRWXg3WFFOWHRnc3dIcmYxWUJFUHM2bjVuckZyVFB0ZFpTUmNB?=
 =?utf-8?B?VmxwUFdPNXVnMHBmbUwrd0g4VGR5TkdPR29wRklIVjY1VVVRNkNuRjk0ZmhY?=
 =?utf-8?B?b2hmZStkbWM1dkVlMVhTbngzUGc1dEdzYjluUGJ5cTc5T1VxOXVlWjRiSFBC?=
 =?utf-8?B?SkxURE00TVdUSjgrdnJpeFVoYU9jYUJ0VDYvcytjb3BjVjFlZTduTHRNRHJq?=
 =?utf-8?B?Z3NucVJRK1JERExYZVF2NE9BVWllWHRQUHB6bTNqSkV4NjVMbVNmM3pxbUJr?=
 =?utf-8?B?SVZYckc0T0NIZ1VoK05IZHAreEFkanpLVnF4aTlRZlEyK0hpamFVK01kY0tz?=
 =?utf-8?B?dTFMYzJJdFIyeTEzOE5CaE1NQjh1b1JkVS9zc2FmRFJOK3h1Z0k0dk42Y28x?=
 =?utf-8?B?aENGanRmVWI2cVB1ZUhQZldKbGVRaTJicTNzTFZDNUpZUkFBQ0lCYVdYSG1K?=
 =?utf-8?B?ZVFuTGhlNDJ4MTlYbGZiaHhBMSsrNmZIWTdURGRNM0NEc0FXZ0F6a0pLSWtx?=
 =?utf-8?B?dVVBT285akl5WnBadkZJV29VYktRbnUzc250Mkl6cnY1OEJyK0xIQnpBZFo4?=
 =?utf-8?B?Ulg3SmhQQVNVdjNvVUdjL3hzbm91a2hFN1hxWDNaRVJGbzF5Zks3RndjK2h0?=
 =?utf-8?B?ckN3TG1PdVJpR2sxek9lYWVPVnNsdnF3Z01SaFlRWG9RTTQ0WXhGZG5mRWpC?=
 =?utf-8?B?SGdBWnZnK0RLOVVrWGppSm5LUllHQThPOTZSdEtXSWlxMm5JTmNSN1NuZHBP?=
 =?utf-8?Q?KxfJ2DHeVeTFb/spjYIjb2RHgVcXjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGZ2Ui9kZFBHRGoxejFEVmxlREVydHdES0dCK1VXejlHa1NJQlA2WXZyMnc5?=
 =?utf-8?B?RlNIRE5nQlQxTll0RDRXdjF6VHE5ZngrVkFGTVhPSnZnejRzM003QURQVnBl?=
 =?utf-8?B?TGNoQkdDek16dFJwY2cyZ2p0aU01bjhMOUpSZ3g0OGk0UklMMVI0OUVrVys4?=
 =?utf-8?B?b0FMYVUyUmQvdndTYnVERE11OFBuKy9wOTdoNmIzbDIzS3B1UTIzNzJnaTlk?=
 =?utf-8?B?aWw4SFhZb3hvZFI4SjNzSGxvUFRSYXliTmtSWHJzQ1BKNWtXZ0tDbnNaUUg4?=
 =?utf-8?B?ZllFOTYzYjJ2MjlHdnR5SGV1R2dBYTlrdGZVZDRQc1NncWt4OTJCL2Y2KzVu?=
 =?utf-8?B?K3h3SzBld21xYyt5T3hZOUI2VVBMMEc0QTR1bFlWVGVLcjdEd2ZLYTdhVDNF?=
 =?utf-8?B?QW5oZ2lLMmxkMnFOVlB1UGNNLy9LbWxLcEdnSUtJTUZFeDZ2cXZTdTEzUER2?=
 =?utf-8?B?WUk4MDRFUmd5K0xxU1VBZkRHUEpxRXM2WkVqSTM5NGR1OHNDVldadVBQdnFk?=
 =?utf-8?B?cmNmU1dVYW9mc1VOK1hBK0lxWG9BQXpsR1lXMk5XRDRWaXhER3J4VkF4bjVF?=
 =?utf-8?B?WDUwejZTREdYZU8vZW5VTWVlT0lrbTNLVHBjejlpcVpoVDZwS3VXdGVXekor?=
 =?utf-8?B?QUU0YXN1VnhHYnpjemZQVFRERkpBRkYwenlSamJqZ3BjbjBsZjhIMVVEclVI?=
 =?utf-8?B?QThhN0wycWEwL2lVRGNMSlZOWTZ4Ny8yQThSY3B4VlJsQmpxWG1WTG95L0Jz?=
 =?utf-8?B?TnFVNnFRVk5rS2I0K2JzSjNiSHF2S2YwR0FjbjY4WWlMbWFpMVFtNmNxWE9U?=
 =?utf-8?B?K1lHSlg5bHNnbEtCQ1ZDcmVwR0NHL0h5TWlsV1BKWHdaYzZMT3VaZ3dUWXpv?=
 =?utf-8?B?RHBYQm4raGlNVGxZdmNGTEYzTDZnZC9vWHJXTWFLNjJtREFka1o2RHdHT25j?=
 =?utf-8?B?V1ZCb2JobUthRFo3Z09tMkpkalNLMWh4elVKTi9aTzluanB6eXkwYWNvTCtw?=
 =?utf-8?B?UlNuL0s4NWJ3eDh3OW5YZFVEZUZJb1RHdnVyNy9acktBYy8xOHg1dldPQktM?=
 =?utf-8?B?dkMwelFNN1dmNTByaXF2d2hLM2RMaGtJNXZ5Y3lSaXAra09ieU5NUUFzK2hr?=
 =?utf-8?B?WUtEQTFJTHltdThPSXBHNDg1ak5GbDF0ZjBoOTVWUUNXNWZFRFhWRjBZVGlY?=
 =?utf-8?B?SzhCWjRwV1NwUldkTGZxZDR1bHJhUUMrUDJ3cmc3Mk01S0ZXYVZReGtmald5?=
 =?utf-8?B?SW5nTEYyYU8xUEt5ZHhFbWlBQkFiUzY5R0M1bFdTTkJwaXNsZ2o0cDdlNlNY?=
 =?utf-8?B?cGNPRFlMa0h1bWV2T3BmbnFUMzVhcW1WQzRHYTlIUkdFdzBYWHN2Vm5UK2dz?=
 =?utf-8?B?M2cvYmRoRU1iVzlvODIxTG9sVnhwaDlQM1RTVmR1Ylc1OEtmNVNHSUUwYkVo?=
 =?utf-8?B?VFZmSWdNaDRDald2UGd1SC9PVWQ2NkdQTitrZkFCbDIwTnRhYmkvWFBrdmlY?=
 =?utf-8?B?MnNrVHJBQjdEVlhIaTFGWitWZnI3bWYxWnRhaTNvZVdBcSszWEI1aFBwc2FJ?=
 =?utf-8?B?dXg2RlpvU2FNbVNySGNaMUwyL3hYMjE1SWU0UUxrQWoyME0zYXNmNkhBekFJ?=
 =?utf-8?B?MDJNelV0UjQrWHArV0I4UDhyKzlUM2RyL3ljcUtwVGcrU2h0anpwNmVNVnda?=
 =?utf-8?B?SldqbEd0NFF6WnlRMGpmektvYThqS1FpcExyZ2ZIRGUwQTZvQ2FYRE56ZUJP?=
 =?utf-8?B?MTZoRnBLcklEd3N4L2VZRFh3eThKWTlhVkt0OEVLbVdsY3R0a0ViNFFvTzRT?=
 =?utf-8?B?VGJYYkVHZ1JwTzMwWmRVL2FrRnpnOUxreHdZeFlrTUlTZ2tOZy8rcU1RMUNz?=
 =?utf-8?B?ZTM5TzdxTSswaXcyZmxzN1R0ZzhnMEtXbk1UcjYzUUtvOVR5N21PVGNpdDVs?=
 =?utf-8?B?ditRVkZZNWxRejlMNVlOL0hpSk1qUlQwTnJzUFZQRnpXRGxEeXRqUWVYTVJj?=
 =?utf-8?B?Ulc5OEtQVDJJMEZNb3YxNlk5S28yOTNVY3VMMG1TWFBORG9zTFV2TFpwb2lt?=
 =?utf-8?B?REdqajVxNVQ1dDlGcDRDb29FY3dhRGtPUjltVnBVcVhSaU1KTkFlcmI1KzBC?=
 =?utf-8?Q?RcfOePpTcLkp+vrX4M1BsvOTu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3f79da-0e57-41e2-009e-08de06524281
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 10:05:51.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWZjz7eGwYt19o4gp2tSv8Hosnb1Q35AKS557dOdl0Wh/NNdNwwiAC/7Bc9u29E9v9WXBA/0AagDujQu6l2qUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

On 9/3/2025 11:16 PM, Jason Gunthorpe wrote:
> This is used by x86 CPUs and can be used in AMD/VT-D x86 IOMMUs. When a
> x86 IOMMU is running SVA it is using this page table format.
> 
> This implementation follows the AMD v2 io-pgtable version.
> 
> There is nothing remarkable here, the format can have 4 or 5 levels and
> limited support for different page sizes. No contiguous pages support.
> 
> x86 uses a sign extension mechanism where the top bits of the VA must
> match the sign bit. The core code supports this through
> PT_FEAT_SIGN_EXTEND which creates and upper and lower VA range. All the
> new operations will work correctly in both spaces, however currently there
> is no way to report the upper space to other layers. Future patches can
> improve that.
> 
> In principle this can support 3 page tables levels matching the 32 bit PAE
> table format, but no iommu driver needs this. The focus is on the modern
> 64 bit 4 and 5 level formats.
> 
> Comparing the performance of several operations to the existing version:
> 
> iommu_map()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     71,61    ,      66,58      , -13.13
>      2^21,     66,60    ,      61,55      , -10.10
>      2^30,     59,56    ,      56,54      ,  -3.03
>  256*2^12,    392,1360  ,     345,1289    ,  73.73
>  256*2^21,    383,1159  ,     335,1145    ,  70.70
>  256*2^30,    378,965   ,     331,892     ,  62.62
> 
> iommu_unmap()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     77,71    ,      73,68      ,  -7.07
>      2^21,     76,70    ,      70,66      ,  -6.06
>      2^30,     69,66    ,      66,63      ,  -4.04
>  256*2^12,    225,899   ,     210,870     ,  75.75
>  256*2^21,    262,722   ,     248,710     ,  65.65
>  256*2^30,    251,643   ,     244,634     ,  61.61
> 
> The small -ve values in the iommu_unmap() are due to the core code calling
> iommu_pgsize() before invoking the domain op. This is unncessary with this
> implementation. Future work optimizes this and gets to 2%, 4%, 3%.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---


.../...

> diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
> new file mode 100644
> index 00000000000000..c01815b6229cce
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/fmt/x86_64.h
> @@ -0,0 +1,248 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * x86 page table. Supports the 4 and 5 level variations.
> + *
> + * The 4 and 5 level version is described in:
> + *   Section "4.4 4-Level Paging and 5-Level Paging" of the Intel Software
> + *   Developer's Manual Volume 3
> + *
> + *   Section "9.7 First-Stage Paging Entries" of the "Intel Virtualization
> + *   Technology for Directed I/O Architecture Specification"
> + *
> + *   Section "2.2.6 I/O Page Tables for Guest Translations" of the "AMD I/O
> + *   Virtualization Technology (IOMMU) Specification"
> + *
> + * It is used by x86 CPUs, AMD and VT-D IOMMU HW.
> + *
> + * Note the 3 level format is very similar and almost implemented here. The
> + * reserved/ignored layout is different and there are functional bit
> + * differences.
> + *
> + * This format uses PT_FEAT_SIGN_EXTEND to have a upper/non-canonical/lower
> + * split. PT_FEAT_SIGN_EXTEND is optional as AMD IOMMU sometimes uses non-sign
> + * extended addressing with this page table format.
> + *
> + * The named levels in the spec map to the pts->level as:
> + *   Table/PTE - 0
> + *   Directory/PDE - 1
> + *   Directory Ptr/PDPTE - 2
> + *   PML4/PML4E - 3
> + *   PML5/PML5E - 4
> + */
> +#ifndef __GENERIC_PT_FMT_X86_64_H
> +#define __GENERIC_PT_FMT_X86_64_H
> +
> +#include "defs_x86_64.h"
> +#include "../pt_defs.h"
> +
> +#include <linux/bitfield.h>
> +#include <linux/container_of.h>
> +#include <linux/log2.h>
> +#include <linux/mem_encrypt.h>
> +
> +enum {
> +	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
> +	PT_MAX_VA_ADDRESS_LG2 = 57,
> +	PT_ITEM_WORD_SIZE = sizeof(u64),
> +	PT_MAX_TOP_LEVEL = 4,
> +	PT_GRANULE_LG2SZ = 12,
> +	PT_TABLEMEM_LG2SZ = 12,
> +
> +	/*
> +	 * For AMD the GCR3 Base only has these bits. For VT-D FSPTPTR is 4k
> +	 * aligned and is limited by the architected HAW
> +	 */
> +	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
> +};
> +
> +/* Shared descriptor bits */
> +enum {
> +	X86_64_FMT_P = BIT(0),
> +	X86_64_FMT_RW = BIT(1),
> +	X86_64_FMT_U = BIT(2),
> +	X86_64_FMT_A = BIT(5),
> +	X86_64_FMT_D = BIT(6),
> +	X86_64_FMT_OA = GENMASK_ULL(51, 12),
> +	X86_64_FMT_XD = BIT_ULL(63),
> +};
> +
> +/* PDPTE/PDE */
> +enum {
> +	X86_64_FMT_PS = BIT(7),
> +};
> +
> +#define common_to_x86_64_pt(common_ptr) \
> +	container_of_const(common_ptr, struct pt_x86_64, common)
> +#define to_x86_64_pt(pts) common_to_x86_64_pt((pts)->range->common)
> +
> +static inline pt_oaddr_t x86_64_pt_table_pa(const struct pt_state *pts)
> +{
> +	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
> +			  PT_TABLEMEM_LG2SZ);

Same as amdv1.h , we need __sme_clr() here.

> +}
> +#define pt_table_pa x86_64_pt_table_pa
> +
> +static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
> +{
> +	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
> +			  PT_GRANULE_LG2SZ);

Also here.

-Vasant



