Return-Path: <linux-kselftest+bounces-49224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40411D38C5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 05:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 113E1302AF97
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 04:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDD2FC02F;
	Sat, 17 Jan 2026 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKhTg11s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516A299944;
	Sat, 17 Jan 2026 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625725; cv=fail; b=rbxRNBNDuYgTfdkka7KNE6NNYBVoTY7yN5VyI6ozpO5ZsjlSx1OljDziphzy9t1NG4EqgCY6Ey/k1+vzPrqGjfr5i+zRFg/ipSNoSIbgAX9yATMKSbVBLzhSH7bHImYjuHKt7Z2BcvrEN0KlA4DIovCEg9RzUASOClhEQSRVZQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625725; c=relaxed/simple;
	bh=hneHsgUWZ3hMs8QXM43GkrUEJlq6UKDnznQZPN/qUI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMbiQIob1HZusUvBh4SfCCc8Kb5A6WondQUGDPdn4w2uDAgzGXDuA9IEDKRCLWMXoNlSvL/GRGZb2Ki+kKrvEHT1pg47nH1MYc/ER//i4/UAvZUltQ5M4qJmXqAzf8J14QBnPlHLxkt2S7EBcIIouMzIBOteVdbzxngupGwNbyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKhTg11s; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2E7EN8EcvRG/+5+S93IISwNkIbw9D/rj8SlfmO4BA7UyiuNbTwqBYCn/MGvkWJijZflURgOg/vbrfGXHdtoV7Mw3ex1Q8Fuym0RWlPRts5Ma456PixKuBpvBTMp6knUY0VgZRqZ8zZXWIBu9xNPag5sm7ADEKsPTZ0d+5FzsTHZEkN6uIXPz/dgPy7mYzYDPVPgOPw+WAEyFYGIp1CIAiOkNrrz4r2j2F0s5T1RRP+GhrxcahBA/RZbSOYbh8zJWB0zv1R6GleAcNqlTO9yu9Z3KvjwM7zkjspGIS1tdalxuYYBRfZ5LRiGbDnuQWLYug9fRf1TwdvPnwNulIAmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFfbZejIruY5kAZgwJ0L7F5Mfnwr5SuVCXtzbJD7pEM=;
 b=agEzhu4XWoCBZl0wvl0RK7F8gwpo+woUNvueqfMht18U8Ky9KUbpKbHpv1VUpYXqmCiNCyAfin05NAX2Pvqa3EMZ8lU4I1i1r9wcU9Mw2feM2kUGr6YvdbhY6UodhIIAflzzRe/GOwtDRMtpAQdpiyykXfcjBTDSquOtBJbMTOhVihh6il96usEql3jNGBYY70q+/Ftl+M5v+0v5D5PH7+fy9Pk+vZwJP+iv7ueQrid/MyMtr3eEO/BkIiqMSdjQ2BRqfW5z0jVonVpVjSyQcx7RNW4XHo4GlwJDeMDmqW6pmmEbmtWiP3w6KCfpdONCxBE7a56PincAreBNcYZniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFfbZejIruY5kAZgwJ0L7F5Mfnwr5SuVCXtzbJD7pEM=;
 b=EKhTg11sAU/8HNBN2tmARMPVc3dq0U5aupX/5cJuN+AbNhvi3k6HBwhdQLPPkbrdJ+62DeNdzQ0ED7c/7H8brzsIa1nIWXVzgpSU+nm+vZuBafi5Pj+EqNmc38KU4JgNEmtmmNJZsf0bTh1TsLoSakxPYIiX/Uctl4Qb+LvxT1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Sat, 17 Jan
 2026 04:55:18 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9520.005; Sat, 17 Jan 2026
 04:55:18 +0000
Message-ID: <fc4f0354-4e6d-452d-abfb-fe24e53253a2@amd.com>
Date: Sat, 17 Jan 2026 15:54:52 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 07/15] iommupt: Add map_pages op
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <7-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <7-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0051.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS7PR12MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1500f033-0e93-4c52-ef2a-08de55849bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bENyVHBoUDFhc3R1SlQveW1oVVZmY2ZmdXdKK0Y3bFd5OUd0cDB0NnIzWERC?=
 =?utf-8?B?WUE5NUw5VXIwZURuZWhyQVAwblV5NnpITGNvZlhsNTJ0cU40U1E1elVzZFdJ?=
 =?utf-8?B?QTUyUmVqem1kS0gzMlpIcHVxSlhuY0RCRnlmQ0l3KzUxVlVWOEF4M3FCMG4z?=
 =?utf-8?B?aFBhUXhGOTFhcjJkMFdvQVVnRkw3RUh6cGtRYzBKbGF6MEFIZ1NTam5ZWFBO?=
 =?utf-8?B?UUU3TURram5vb2dpVFNKME5aWjhzL1VjcHRnZ0doQlhCZ29jaFRmaW1xZWcz?=
 =?utf-8?B?Rnk2Z01tclFpVjNNYkY4aldhUDNQRVJyelcwVjgwOFVGNDRuSHEzTXRUUms0?=
 =?utf-8?B?WjZkWGdYa1BONTZtbndFUU4yUlBZQlljSlE0dEF2SVBqV2ZjS05YLzd4N0lJ?=
 =?utf-8?B?U0RhRHp2SUlSMVlMaWl4dW5RSisyWXVBRTVRWU1TMVB2cTJieVREN2NCNWhz?=
 =?utf-8?B?MzJ4czArMUR0YUpERG5JMkhlM3pUd1J5SWtrdHBpSDcvOGJ3b1pnQ3I0UHhy?=
 =?utf-8?B?bHJHNlM2Zy9DT0Nsay9aYzE3SWd3aUVlbDRGeDZrMnVDL3dHeHppUmI2SjE1?=
 =?utf-8?B?UGRuUUlrTkhrWmhQQmdHSmNqTEM0U2FSWU00L0R1UU1jdjEvdnM2c2QyQVRv?=
 =?utf-8?B?V1kyYlA5SU41dmhwSmtaSGZRQ3h2UEhYQzh2T1R4WHBYODNzcjVveWVIelho?=
 =?utf-8?B?WjF3VVpwUThOQkhjUXRLWUZPVVNGTllmWlprSGc4SThJdmNQVytUWG16V1pm?=
 =?utf-8?B?VU1lbGhkWU52Y1lxYUJndzJMemZXMS9KOHVzMGpaYlI3cXhvUlRwTkwyKy9x?=
 =?utf-8?B?T1BvelR6MjRPZW56Zm5BVHBudFppeUxBMlpNMEdVM0l3TjJxdmdRV01uK0U4?=
 =?utf-8?B?L0dmNXQwNmN0anBNUk1jZ3JLcXJ4Q21JV1g1ZTExaGgvOUVZTjY0Z2plcEND?=
 =?utf-8?B?RHZoais0M0RFU0ovOTE5MGlhcXh1OGlROEFJbzk1ck5Qc1d5OXliQVk5ekhB?=
 =?utf-8?B?cmNwMFF3YmNiV01OV1UyTWtHc0wrTXRwcFhrYVc1V0ZDK0ZuMTFtUDJwb0Rt?=
 =?utf-8?B?VzFyZ3g4eHBzUEZzeXd0VE9iSzBBTzN1eUdvWGFEdzMwVnUzdGE2TGhoU3V6?=
 =?utf-8?B?YVZqWGhEYTlmYUJUa3lKekt6Vzc0cXY3MVI5Mjc2SDMzRGQ3WXMvdTBteklL?=
 =?utf-8?B?RDZ5ZlY5dHA4VG1acHkrdmpKa0MwNi9IQTdNSklwekNyaEhlaTlsa3NRclN0?=
 =?utf-8?B?M2xHMktCV0dhL0d1ODZYY3ltd3ZZWnpJdi8wTmdXZURjcVdoVUVuUUJZNHUz?=
 =?utf-8?B?TzQyM0lsaDJHZEN3YncyazdFaHRlSUxlRS9lSEt5RU92ejdGdGNtYWZyK0Fz?=
 =?utf-8?B?QWQ4RlcvSTVhcjZERkhCaVFkQUlHWnlNbDFxUWxLc1NDSHRwcVQzZEg4ZkQw?=
 =?utf-8?B?R05EYTFGUnVGRzJDQ2IwYzQ1NzNRWEIzUElUL2xNY3MzQjlyRUZ1V0RZRGJT?=
 =?utf-8?B?UGtxY1U4VTVTL0JFQm5ObHNwSWs5NEgvb2l3bDZtN25zWmViNlJQRWhCNSsz?=
 =?utf-8?B?UWJqNVBZT3d5V0taU2VtSThjTVZ3WFdFbWs1aytMOFI4RXE5bGpQVEtHbSt5?=
 =?utf-8?B?c2RrMmxsK1lnQTBudUZxalZZblNZci9EUE1aRGNKNDdYQy8rRFFjMmV0Wjd1?=
 =?utf-8?B?eGJ0cDNvbmVTUlR0aTNPbVdQSTV3L1RVVFQ1OStJWG8zMVhGSC9yTEVSWkpH?=
 =?utf-8?B?cFkvVU1IMlVVbU0rUkZ2UEc5ckZXLzBCa05xbVNuclgraWI0ZTNkbzlaOEtV?=
 =?utf-8?B?S1puZzVucUMzSXVQTU8wdmIyZkVoeXNGbHpqazVOZDYvYW56aDJHNU5qY3M5?=
 =?utf-8?B?Vk84eS93SFRxMm5CUjhidGwvMHF5Y1lKVERRTWpQS0tsWS9RYlc3MEhaZ3Rs?=
 =?utf-8?B?TnNnY2wvUVMvNXF6V1JPM1c0bFpFbkVBdmF6S1pXU1FYSll5NDg5cUh1RHNY?=
 =?utf-8?B?T3N2UWNyUXBraGo5NVlHcVFMRGpCTHBXVHpoNGNUb3dlMHhvYjYwN2wyazBL?=
 =?utf-8?B?N1dHcFdSUDg1YjVEV1NtSHBIa2xrbEdibCs4cUpEUXFvSlIrUW05eDBaMkVt?=
 =?utf-8?B?aWVNODFqNnpOd0dWeFVUakZhbzdZWU1NNnh2NzZFaFB6U1RsRGxJKytQQ3lB?=
 =?utf-8?Q?huEnOA3BkjbCr0nPPqg1BbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFh0N1ExNGMxdnRBbW14U1NsTzdMcXJEa2pnb1FnLzZYRDlvVi9aQTdlNkYz?=
 =?utf-8?B?cW9lUEhZWW00OG9aV2Q3d0M0WHdMS0hwSDhBbDhwY0NUcHE2R2I2dTFYS0tX?=
 =?utf-8?B?K2tVaUVkcHVNeFowMVlGTEE4emhTclQ4Y0dmRVg5bUpKMytOMEFOWjlvR2lO?=
 =?utf-8?B?WVdmSTNEaUFOcklvSkJReE1ETVRYalVrREF1ZHZDL0pYYVFhQXJKTyt0SnVH?=
 =?utf-8?B?NmNock9QWU83SjVUWlNXdytRTEtVMmZUTC9WNVZ3K2tGOE04Vk5DalNMNDB3?=
 =?utf-8?B?VXBPZlZKaGYyUVhNMXRqbXkxYWZFa0NqSFhCK3JPOVdTV21JTkIxbGFzWlow?=
 =?utf-8?B?aG5ray9CWE01SjFnWExOS3hPbkU5RmFlVWN4c21JZ0ZsMENnM0NsanBWblhs?=
 =?utf-8?B?bmdvelV1UkkxbGIzSzI5dm93bGVDZnUzYlZCR2lPcHQzaTcyUXh2anNOeXUz?=
 =?utf-8?B?aHZHU2JTQnBRKzgrdWNiZ2UxRk9RK1BHTHRvRHhpTWRqbWY5L1E2M3I0QzlL?=
 =?utf-8?B?WUxJN3pMQWEwNmlpeU04WUZEZi9QRTJZZVoyMlB5dEN3RktuQ2ZEc3hvRVBL?=
 =?utf-8?B?NnBQWXBvMklxdzRyT2E1cS9INFFaT0dSWVdMeEVyTXpRUUFSQ1Iwbk41ZzRw?=
 =?utf-8?B?djRoK3NWbExsTkJCaFRkNnkybW9qclJzaWZScXUrbmV0b2swWUs5TkhUMUR2?=
 =?utf-8?B?QVFCN1F5Mk9pTGlBa3lpNkMzLzRORkxjUTlDR1RPS0wwMW40U0k0Rk81bElU?=
 =?utf-8?B?L0FRT3NRRGZPNGVxSFdDUisrcSt2VFlJTWxsOHBudzl3eUVZUkJON1F0MXBJ?=
 =?utf-8?B?cEZ2UHVHVm10Rlp0OFd1WFBWYy90MjAya0xRNVhObTk3djBISkRySFhvQ0Ri?=
 =?utf-8?B?RTlGV1dma0RTd3NZSnRZZGczU2x4dkRVc3V3YnM5L3Jta1c5YnQ1dm1jRkhJ?=
 =?utf-8?B?NHM5T0VTb0ZoaHIvbGc5MjZ4QUVXZm5aOUptV2ZaaVpzMnNIUTZ5Tit4QUxB?=
 =?utf-8?B?MzlGdkhpa1V4bDRMQWs4cjA0UzdGZU42cGRtRWFIMG00RC9MNnJySXFBcVlD?=
 =?utf-8?B?cFpuclJwaWtFNGtrWFNoUFZqem96ajBRd2JvUVBiTzV5TU02SUJWenh4WnNQ?=
 =?utf-8?B?ZVNWZi9TZnVHMUlLTTRaNjg4NHVPWUJJTk45M0FMYVFIaFRBQUw2TVhuL3gx?=
 =?utf-8?B?VkxwcG1hK1RldjdlN29PYTlBRGQzR0xBN09XcmlCNVI4QWpMdHRqY25sTDB2?=
 =?utf-8?B?ZlU1SkpyWXBLL0x5RTFFN2xQVXFIMkNjcmFOK0d3VjJWeG5uZWRJanZhODJ3?=
 =?utf-8?B?SzRRSUdTVVdGemFNRFJyWHoyVVpXcXVFQUgrRlJFT1VHNWVGMG1URGxXYjdF?=
 =?utf-8?B?Vml3dG44WDdXcVozSU9pVElZUXZKZ0R6ZmZHYm9kdlUvWVFNV1BvNncrNWha?=
 =?utf-8?B?M1hFM3lGTDNmUTg3VFVEVUR4a3ZuS3h2UGtKNHFucWtqbjhJdThsWXRoYlEr?=
 =?utf-8?B?SFdrRk9EZ0JhUVlnaUdzcnlSV3ZlanoraTBIdzYzeVYvR1RmR0ZCaFlkQUpw?=
 =?utf-8?B?RmJsVjhDa1ZqYUszaUd0Q3pHNVRSeWtQU1NQUWJSMm5nM201aDdhNmg0UlF4?=
 =?utf-8?B?MGZXRXBEd2tFWG1aUDdpbCtla3JDUlpWaGFnODhvam1xbUFuZFZIcGF4NVha?=
 =?utf-8?B?Zkwwci9COHBObDJrYlZKOGNhVXVpbmhNNDRqNVBPZ3lIQTI5WVZaVVFxcGJU?=
 =?utf-8?B?YlNyNWFzZ25JSDQrYUt6M2QxaFBrd3NsalV6Y3V2M1pmMVpLR2JXcW5yUWRn?=
 =?utf-8?B?VHd2UUYvRlNTVGVJeDZYTFI2dEg4RjZIb1JuSjBtMC85M0M2NEZlT1VMSzBu?=
 =?utf-8?B?YllGM0trd0FsQ1hLV1JXcTlFekRUeTROY3dabFhmYlhJNVJ1T1gxaGRJRXhi?=
 =?utf-8?B?VmpKUXVZZDhDS0sxV041ZE1XUnNTdG5obHFUQUJvTWhQOWtVRjEyUFpSWDJZ?=
 =?utf-8?B?UUp5OWdmVjQ0MEFiNWNCVVI3ZW5RRmVIYVA0ZGd4VXFuTEJ4d1FQd1gzQ3lO?=
 =?utf-8?B?TTBuOHJkQ2IzSGlvUnlJcW0wc0NuZ21velEyWmpEYVcydFg0YklaSnVWdnVy?=
 =?utf-8?B?RmJ4clB2bkdRQ1pLcWRkdzlqYWR1TmtNZHg0Q21lQi9PSlNiWWFhZUtSYjY2?=
 =?utf-8?B?eE1MdnNlSmFrZDZ6YWRHaXJZdTFrNHUvRTcvTDNUTm1uZkp1U2ZVMXhhYTlv?=
 =?utf-8?B?R09GUGg5czlyQ0xwS3drRjB0K0hibGhOUW5Rbk9RUGFaN1JEK3RoQ1dHTUx5?=
 =?utf-8?Q?VbItD11OrTgpQfm/F0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1500f033-0e93-4c52-ef2a-08de55849bfd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 04:55:17.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnFMW9oG7fmTONdnIwSe5kgJN+nsfCaqGITMBatNTAWGAcM2vXQToyHdCwtAM0Jcya1FPOonOBpZZaA2Nz5CwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525

On 5/11/25 05:30, Jason Gunthorpe wrote:
> map is slightly complicated because it has to handle a number of special
> edge cases:
>   - Overmapping a previously shared, but now empty, table level with an OA.
>     Requries validating and freeing the possibly empty tables
>   - Doing the above across an entire to-be-created contiguous entry
>   - Installing a new shared table level concurrently with another thread
>   - Expanding the table by adding more top levels
> 
> Table expansion is a unique feature of AMDv1, this version is quite
> similar except we handle racing concurrent lockless map. The table top
> pointer and starting level are encoded in a single uintptr_t which ensures
> we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and use
> that fixed point as its starting point. Concurrent expansion is handled
> with a table global spinlock.
> 
> When inserting a new table entry map checks that the entire portion of the
> table is empty. This includes freeing any empty lower tables that will be
> overwritten by an OA. A separate free list is used while checking and
> collecting all the empty lower tables so that writing the new entry is
> uninterrupted, either the new entry fully writes or nothing changes.
> 
> A special fast path for PAGE_SIZE is implemented that does a direct walk
> to the leaf level and installs a single entry. This gives ~15% improvement
> for iommu_map() when mapping lists of single pages.
> 
> This version sits under the iommu_domain_ops as map_pages() but does not
> require the external page size calculation. The implementation is actually
> map_range() and can do arbitrary ranges, internally handling all the
> validation and supporting any arrangment of page sizes. A future series
> can optimize iommu_map() to take advantage of this.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/generic_pt/iommu_pt.h | 501 +++++++++++++++++++++++++++-
>   drivers/iommu/generic_pt/pt_iter.h  |   2 +-
>   include/linux/generic_pt/iommu.h    |  59 ++++
>   3 files changed, 560 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index e3d1b272723db0..f32e81509f4f09 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -91,6 +91,23 @@ static __maybe_unused int make_range_u64(struct pt_common *common,
>   		ret;                                                     \
>   	})
>   
> +static inline unsigned int compute_best_pgsize(struct pt_state *pts,
> +					       pt_oaddr_t oa)
> +{
> +	struct pt_iommu *iommu_table = iommu_from_common(pts->range->common);
> +
> +	if (!pt_can_have_leaf(pts))
> +		return 0;
> +
> +	/*
> +	 * The page size is limited by the domain's bitmap. This allows the core
> +	 * code to reduce the supported page sizes by changing the bitmap.
> +	 */
> +	return pt_compute_best_pgsize(pt_possible_sizes(pts) &
> +					      iommu_table->domain.pgsize_bitmap,
> +				      pts->range->va, pts->range->last_va, oa);
> +}
> +
>   static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>   					     unsigned int level,
>   					     struct pt_table_p *table,
> @@ -147,6 +164,8 @@ EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
>   
>   struct pt_iommu_collect_args {
>   	struct iommu_pages_list free_list;
> +	/* Fail if any OAs are within the range */
> +	u8 check_mapped : 1;
>   };
>   
>   static int __collect_tables(struct pt_range *range, void *arg,
> @@ -156,7 +175,7 @@ static int __collect_tables(struct pt_range *range, void *arg,
>   	struct pt_iommu_collect_args *collect = arg;
>   	int ret;
>   
> -	if (!pt_can_have_table(&pts))
> +	if (!collect->check_mapped && !pt_can_have_table(&pts))
>   		return 0;
>   
>   	for_each_pt_level_entry(&pts) {
> @@ -167,6 +186,8 @@ static int __collect_tables(struct pt_range *range, void *arg,
>   				return ret;
>   			continue;
>   		}
> +		if (pts.type == PT_ENTRY_OA && collect->check_mapped)
> +			return -EADDRINUSE;
>   	}
>   	return 0;
>   }
> @@ -187,6 +208,477 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
>   		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
>   }
>   
> +/* Allocate an interior table */
> +static inline struct pt_table_p *table_alloc(const struct pt_state *parent_pts,
> +					     gfp_t gfp)
> +{
> +	struct pt_iommu *iommu_table =
> +		iommu_from_common(parent_pts->range->common);
> +	struct pt_state child_pts =
> +		pt_init(parent_pts->range, parent_pts->level - 1, NULL);
> +
> +	return iommu_alloc_pages_node_sz(
> +		iommu_table->nid, gfp,
> +		log2_to_int(pt_num_items_lg2(&child_pts) +
> +			    ilog2(PT_ITEM_WORD_SIZE)));
> +}
> +
> +static inline int pt_iommu_new_table(struct pt_state *pts,
> +				     struct pt_write_attrs *attrs)
> +{
> +	struct pt_table_p *table_mem;
> +	phys_addr_t phys;
> +
> +	/* Given PA/VA/length can't be represented */
> +	if (PT_WARN_ON(!pt_can_have_table(pts)))
> +		return -ENXIO;
> +
> +	table_mem = table_alloc(pts, attrs->gfp);
> +	if (IS_ERR(table_mem))
> +		return PTR_ERR(table_mem);
> +
> +	phys = virt_to_phys(table_mem);
> +	if (!pt_install_table(pts, phys, attrs)) {
> +		iommu_free_pages(table_mem);
> +		return -EAGAIN;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
> +		/*
> +		 * The underlying table can't store the physical table address.
> +		 * This happens when kunit testing tables outside their normal
> +		 * environment where a CPU might be limited.
> +		 */
> +		pt_load_single_entry(pts);
> +		if (PT_WARN_ON(pt_table_pa(pts) != phys)) {
> +			pt_clear_entries(pts, ilog2(1));
> +			iommu_free_pages(table_mem);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	pts->table_lower = table_mem;
> +	return 0;
> +}
> +
> +struct pt_iommu_map_args {
> +	struct iommu_iotlb_gather *iotlb_gather;
> +	struct pt_write_attrs attrs;
> +	pt_oaddr_t oa;
> +	unsigned int leaf_pgsize_lg2;
> +	unsigned int leaf_level;
> +};
> +
> +/*
> + * This will recursively check any tables in the block to validate they are
> + * empty and then free them through the gather.
> + */
> +static int clear_contig(const struct pt_state *start_pts,
> +			struct iommu_iotlb_gather *iotlb_gather,
> +			unsigned int step, unsigned int pgsize_lg2)
> +{
> +	struct pt_iommu *iommu_table =
> +		iommu_from_common(start_pts->range->common);
> +	struct pt_range range = *start_pts->range;
> +	struct pt_state pts =
> +		pt_init(&range, start_pts->level, start_pts->table);
> +	struct pt_iommu_collect_args collect = { .check_mapped = true };
> +	int ret;
> +
> +	pts.index = start_pts->index;
> +	pts.end_index = start_pts->index + step;
> +	for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			collect.free_list =
> +				IOMMU_PAGES_LIST_INIT(collect.free_list);
> +			ret = pt_walk_descend_all(&pts, __collect_tables,
> +						  &collect);
> +			if (ret)
> +				return ret;
> +
> +			/*
> +			 * The table item must be cleared before we can update
> +			 * the gather
> +			 */
> +			pt_clear_entries(&pts, ilog2(1));
> +
> +			iommu_pages_list_add(&collect.free_list,
> +					     pt_table_ptr(&pts));
> +			gather_range_pages(
> +				iotlb_gather, iommu_table, range.va,
> +				log2_to_int(pt_table_item_lg2sz(&pts)),
> +				&collect.free_list);
> +		} else if (pts.type != PT_ENTRY_EMPTY) {
> +			return -EADDRINUSE;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int __map_range_leaf(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	struct pt_iommu_map_args *map = arg;
> +	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
> +	unsigned int start_index;
> +	pt_oaddr_t oa = map->oa;
> +	unsigned int step;
> +	bool need_contig;
> +	int ret = 0;
> +
> +	PT_WARN_ON(map->leaf_level != level);
> +	PT_WARN_ON(!pt_can_have_leaf(&pts));
> +
> +	step = log2_to_int_t(unsigned int,
> +			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
> +	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
> +
> +	_pt_iter_first(&pts);
> +	start_index = pts.index;
> +	do {
> +		pts.type = pt_load_entry_raw(&pts);
> +		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
> +			if (pts.index != start_index)
> +				pt_index_to_va(&pts);
> +			ret = clear_contig(&pts, map->iotlb_gather, step,
> +					   leaf_pgsize_lg2);
> +			if (ret)
> +				break;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
> +			pt_index_to_va(&pts);
> +			PT_WARN_ON(compute_best_pgsize(&pts, oa) !=
> +				   leaf_pgsize_lg2);
> +		}
> +		pt_install_leaf_entry(&pts, oa, leaf_pgsize_lg2, &map->attrs);
> +
> +		oa += log2_to_int(leaf_pgsize_lg2);
> +		pts.index += step;
> +	} while (pts.index < pts.end_index);
> +
> +	map->oa = oa;
> +	return ret;
> +}
> +
> +static int __map_range(struct pt_range *range, void *arg, unsigned int level,
> +		       struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	struct pt_iommu_map_args *map = arg;
> +	int ret;
> +
> +	PT_WARN_ON(map->leaf_level == level);
> +	PT_WARN_ON(!pt_can_have_table(&pts));
> +
> +	_pt_iter_first(&pts);
> +
> +	/* Descend to a child table */
> +	do {
> +		pts.type = pt_load_entry_raw(&pts);
> +
> +		if (pts.type != PT_ENTRY_TABLE) {
> +			if (pts.type != PT_ENTRY_EMPTY)
> +				return -EADDRINUSE;
> +			ret = pt_iommu_new_table(&pts, &map->attrs);
> +			if (ret) {
> +				/*
> +				 * Racing with another thread installing a table
> +				 */
> +				if (ret == -EAGAIN)
> +					continue;
> +				return ret;
> +			}
> +		} else {
> +			pts.table_lower = pt_table_ptr(&pts);
> +		}
> +
> +		/*
> +		 * The already present table can possibly be shared with another
> +		 * concurrent map.
> +		 */

[1]
See the comment below.


> +		if (map->leaf_level == level - 1)
> +			ret = pt_descend(&pts, arg, __map_range_leaf);
> +		else
> +			ret = pt_descend(&pts, arg, __map_range);
> +		if (ret)
> +			return ret;
> +
> +		pts.index++;
> +		pt_index_to_va(&pts);
> +		if (pts.index >= pts.end_index)
> +			break;
> +	} while (true);
> +	return 0;
> +}
> +
> +/*
> + * Fast path for the easy case of mapping a 4k page to an already allocated
> + * table. This is a common workload. If it returns EAGAIN run the full algorithm
> + * instead.
> + */
> +static __always_inline int __do_map_single_page(struct pt_range *range,
> +						void *arg, unsigned int level,
> +						struct pt_table_p *table,
> +						pt_level_fn_t descend_fn)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	struct pt_iommu_map_args *map = arg;
> +
> +	pts.type = pt_load_single_entry(&pts);
> +	if (level == 0) {
> +		if (pts.type != PT_ENTRY_EMPTY)
> +			return -EADDRINUSE;
> +		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
> +				      &map->attrs);
> +		map->oa += PAGE_SIZE;
> +		return 0;
> +	}
> +	if (pts.type == PT_ENTRY_TABLE)
> +		return pt_descend(&pts, arg, descend_fn);
> +	/* Something else, use the slow path */
> +	return -EAGAIN;
> +}
> +PT_MAKE_LEVELS(__map_single_page, __do_map_single_page);
> +
> +/*
> + * Add a table to the top, increasing the top level as much as necessary to
> + * encompass range.
> + */
> +static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
> +			struct pt_iommu_map_args *map)
> +{
> +	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	uintptr_t top_of_table = READ_ONCE(common->top_of_table);
> +	uintptr_t new_top_of_table = top_of_table;
> +	struct pt_table_p *table_mem;
> +	unsigned int new_level;
> +	spinlock_t *domain_lock;
> +	unsigned long flags;
> +	int ret;
> +
> +	while (true) {
> +		struct pt_range top_range =
> +			_pt_top_range(common, new_top_of_table);
> +		struct pt_state pts = pt_init_top(&top_range);
> +
> +		top_range.va = range->va;
> +		top_range.last_va = range->last_va;
> +
> +		if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
> +			break;
> +
> +		pts.level++;
> +		if (pts.level > PT_MAX_TOP_LEVEL ||
> +		    pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
> +			ret = -ERANGE;
> +			goto err_free;
> +		}
> +
> +		new_level = pts.level;
> +		table_mem = table_alloc_top(
> +			common, _pt_top_set(NULL, pts.level), map->attrs.gfp);
> +		if (IS_ERR(table_mem))
> +			return PTR_ERR(table_mem);
> +		iommu_pages_list_add(&free_list, table_mem);
> +
> +		/* The new table links to the lower table always at index 0 */
> +		top_range.va = 0;
> +		top_range.top_level = new_level;
> +		pts.table_lower = pts.table;
> +		pts.table = table_mem;
> +		pt_load_single_entry(&pts);
> +		PT_WARN_ON(pts.index != 0);
> +		pt_install_table(&pts, virt_to_phys(pts.table_lower),
> +				 &map->attrs);
> +		new_top_of_table = _pt_top_set(pts.table, pts.level);
> +	}
> +
> +	/*
> +	 * top_of_table is write locked by the spinlock, but readers can use
> +	 * READ_ONCE() to get the value. Since we encode both the level and the
> +	 * pointer in one quanta the lockless reader will always see something
> +	 * valid. The HW must be updated to the new level under the spinlock
> +	 * before top_of_table is updated so that concurrent readers don't map
> +	 * into the new level until it is fully functional. If another thread
> +	 * already updated it while we were working then throw everything away
> +	 * and try again.
> +	 */
> +	domain_lock = iommu_table->driver_ops->get_top_lock(iommu_table);
> +	spin_lock_irqsave(domain_lock, flags);
> +	if (common->top_of_table != top_of_table) {
> +		spin_unlock_irqrestore(domain_lock, flags);
> +		ret = -EAGAIN;
> +		goto err_free;
> +	}
> +
> +	/*
> +	 * We do not issue any flushes for change_top on the expectation that
> +	 * any walk cache will not become a problem by adding another layer to
> +	 * the tree. Misses will rewalk from the updated top pointer, hits
> +	 * continue to be correct. Negative caching is fine too since all the
> +	 * new IOVA added by the new top is non-present.
> +	 */
> +	iommu_table->driver_ops->change_top(
> +		iommu_table, virt_to_phys(table_mem), new_level);
> +	WRITE_ONCE(common->top_of_table, new_top_of_table);
> +	spin_unlock_irqrestore(domain_lock, flags);
> +	return 0;
> +
> +err_free:
> +	iommu_put_pages_list(&free_list);
> +	return ret;
> +}
> +
> +static int check_map_range(struct pt_iommu *iommu_table, struct pt_range *range,
> +			   struct pt_iommu_map_args *map)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	int ret;
> +
> +	do {
> +		ret = pt_check_range(range);
> +		if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
> +			return ret;
> +
> +		if (!ret && map->leaf_level <= range->top_level)
> +			break;
> +
> +		ret = increase_top(iommu_table, range, map);
> +		if (ret && ret != -EAGAIN)
> +			return ret;
> +
> +		/* Reload the new top */
> +		*range = pt_make_range(common, range->va, range->last_va);
> +	} while (ret);
> +	PT_WARN_ON(pt_check_range(range));
> +	return 0;
> +}
> +
> +static int do_map(struct pt_range *range, bool single_page,
> +		  struct pt_iommu_map_args *map)
> +{
> +	if (single_page) {
> +		int ret;
> +
> +		ret = pt_walk_range(range, __map_single_page, map);
> +		if (ret != -EAGAIN)
> +			return ret;
> +		/* EAGAIN falls through to the full path */
> +	}
> +
> +	if (map->leaf_level == range->top_level)
> +		return pt_walk_range(range, __map_range_leaf, map);
> +	return pt_walk_range(range, __map_range, map);
> +}
> +
> +/**
> + * map_pages() - Install translation for an IOVA range
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @paddr: Physical/Output address to start
> + * @pgsize: Length of each page
> + * @pgcount: Length of the range in pgsize units starting from @iova
> + * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
> + * @gfp: GFP flags for any memory allocations
> + * @mapped: Total bytes successfully mapped
> + *
> + * The range starting at IOVA will have paddr installed into it. The caller
> + * must specify a valid pgsize and pgcount to segment the range into compatible
> + * blocks.
> + *
> + * On error the caller will probably want to invoke unmap on the range from iova
> + * up to the amount indicated by @mapped to return the table back to an
> + * unchanged state.
> + *
> + * Context: The caller must hold a write range lock that includes the whole
> + * range.
> + *
> + * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that were
> + * mapped are added to @mapped, @mapped is not zerod first.
> + */
> +int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
> +			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			 int prot, gfp_t gfp, size_t *mapped)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	pt_vaddr_t pgsize_bitmap = iommu_table->domain.pgsize_bitmap;
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct iommu_iotlb_gather iotlb_gather;
> +	pt_vaddr_t len = pgsize * pgcount;
> +	struct pt_iommu_map_args map = {
> +		.iotlb_gather = &iotlb_gather,
> +		.oa = paddr,
> +		.leaf_pgsize_lg2 = vaffs(pgsize),
> +	};
> +	bool single_page = false;
> +	struct pt_range range;
> +	int ret;
> +
> +	iommu_iotlb_gather_init(&iotlb_gather);
> +
> +	if (WARN_ON(!(prot & (IOMMU_READ | IOMMU_WRITE))))
> +		return -EINVAL;
> +
> +	/* Check the paddr doesn't exceed what the table can store */
> +	if ((sizeof(pt_oaddr_t) < sizeof(paddr) &&
> +	     (pt_vaddr_t)paddr > PT_VADDR_MAX) ||
> +	    (common->max_oasz_lg2 != PT_VADDR_MAX_LG2 &&
> +	     oalog2_div(paddr, common->max_oasz_lg2)))
> +		return -ERANGE;
> +
> +	ret = pt_iommu_set_prot(common, &map.attrs, prot);
> +	if (ret)
> +		return ret;
> +	map.attrs.gfp = gfp;
> +
> +	ret = make_range_no_check(common, &range, iova, len);
> +	if (ret)
> +		return ret;
> +
> +	/* Calculate target page size and level for the leaves */
> +	if (pt_has_system_page_size(common) && pgsize == PAGE_SIZE &&
> +	    pgcount == 1) {
> +		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
> +		if (log2_mod(iova | paddr, PAGE_SHIFT))
> +			return -ENXIO;
> +		map.leaf_pgsize_lg2 = PAGE_SHIFT;
> +		map.leaf_level = 0;
> +		single_page = true;
> +	} else {
> +		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
> +			pgsize_bitmap, range.va, range.last_va, paddr);


I am trying this with TEE-IO on AMD SEV and hitting problems. Say, I run a VM with 2MB pages and a passed through secure device. The IOMMU code calculates 2MB page size above and maps the guest memory. Ideally the RMP table ("Reverse Map Table" from SEV-SNP) also uses 2MB entries.

Now, from time to time the guest will share 4K pages which makes the host OS smash NPT's 2MB PDEs to 4K PTEs, and 2M RMP entries to 4K RMP entries, and since the IOMMU performs RMP checks - IOMMU PDEs have to use the same granularity as NPT and RMP.

So I end up in a situation when QEMU asks to map, for example, 2GB of guest RAM and I want most of it to be 2MB mappings, and only handful of 2MB pages to be split into 4K pages. But it appears so that the above enforces the same page size for entire range.

In the old IOMMU code, I handled it like this:

https://github.com/AMDESE/linux-kvm/commit/0a40130987b7b65c367390d23821cc4ecaeb94bd#diff-f22bea128ddb136c3adc56bc09de9822a53ba1ca60c8be662a48c3143c511963L341

tl;dr: I constantly re-calculate the page size while mapping.

I could have another temporary @pts with leaf_level=0 in [1], for example. Or have __map_range_leaf() error out when RMP size is mismatching.
Not to mention this very AMD specific and should live somewhere in drivers/iommu/generic_pt/fmt/iommu_amdv1.c or drivers/iommu/amd/iommu.c.

btw just realized - does the code check that the folio_size matches IO pagesize? Or batch_to_domain() is expected to start a new batch if the next page size is not the same as previous? With THP, we can have a mix of page sizes.

What do you think would be the proper way of doing the same in the new code?


I know, ideally we would only share memory in 2MB chunks but we are not there yet as I do not know the early boot stage on x86 enough to know how easy it is to allocate guaranteed 2MB page to use as a pool for 4K shared allocations (and that may not work for all cases but probably will be ok as we won't be DMAing to pages adjacent to those special 4K regions).

Thanks,


> +		if (!map.leaf_pgsize_lg2)
> +			return -ENXIO;
> +		map.leaf_level =
> +			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
> +	}
> +
> +	ret = check_map_range(iommu_table, &range, &map);
> +	if (ret)
> +		return ret;
> +
> +	PT_WARN_ON(map.leaf_level > range.top_level);
> +
> +	ret = do_map(&range, single_page, &map);
> +
> +	/*
> +	 * Table levels were freed and replaced with large items, flush any walk
> +	 * cache that may refer to the freed levels.
> +	 */
> +	if (!iommu_pages_list_empty(&iotlb_gather.freelist))
> +		iommu_iotlb_sync(&iommu_table->domain, &iotlb_gather);
> +
> +	/* Bytes successfully mapped */
> +	PT_WARN_ON(!ret && map.oa - paddr != len);
> +	*mapped += map.oa - paddr;
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
> +
>   struct pt_unmap_args {
>   	struct iommu_pages_list free_list;
>   	pt_vaddr_t unmapped;
> @@ -445,6 +937,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
>   	memset_after(fmt_table, 0, iommu.domain);
>   
>   	/* The caller can initialize some of these values */
> +	iommu_table->driver_ops = cfg.driver_ops;
>   	iommu_table->nid = cfg.nid;
>   }
>   
> @@ -478,6 +971,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
>   	if (ret)
>   		return ret;
>   
> +	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
> +	    WARN_ON(!iommu_table->driver_ops ||
> +		    !iommu_table->driver_ops->change_top ||
> +		    !iommu_table->driver_ops->get_top_lock))
> +		return -EINVAL;
> +
>   	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
>   	    (pt_feature(common, PT_FEAT_FULL_VA) ||
>   	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
> diff --git a/drivers/iommu/generic_pt/pt_iter.h b/drivers/iommu/generic_pt/pt_iter.h
> index 87f4a26c1a417a..c0d8617cce2928 100644
> --- a/drivers/iommu/generic_pt/pt_iter.h
> +++ b/drivers/iommu/generic_pt/pt_iter.h
> @@ -612,7 +612,7 @@ static inline int __pt_make_level_fn_err(struct pt_range *range, void *arg,
>    * This builds a function call tree that can be fully inlined.
>    * The caller must provide a function body in an __always_inline function::
>    *
> - *  static __always_inline int do(struct pt_range *range, void *arg,
> + *  static __always_inline int do_fn(struct pt_range *range, void *arg,
>    *         unsigned int level, struct pt_table_p *table,
>    *         pt_level_fn_t descend_fn)
>    *
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> index ceb6bc9cea37cd..0d59423024d57f 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -11,6 +11,7 @@
>   
>   struct iommu_iotlb_gather;
>   struct pt_iommu_ops;
> +struct pt_iommu_driver_ops;
>   
>   /**
>    * DOC: IOMMU Radix Page Table
> @@ -43,6 +44,12 @@ struct pt_iommu {
>   	 */
>   	const struct pt_iommu_ops *ops;
>   
> +	/**
> +	 * @driver_ops: Function pointers provided by the HW driver to help
> +	 * manage HW details like caches.
> +	 */
> +	const struct pt_iommu_driver_ops *driver_ops;
> +
>   	/**
>   	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
>   	 * may want to set the NID to the device's NID, if there are multiple
> @@ -84,6 +91,53 @@ struct pt_iommu_ops {
>   	void (*deinit)(struct pt_iommu *iommu_table);
>   };
>   
> +/**
> + * struct pt_iommu_driver_ops - HW IOTLB cache flushing operations
> + *
> + * The IOMMU driver should implement these using container_of(iommu_table) to
> + * get to it's iommu_domain derived structure. All ops can be called in atomic
> + * contexts as they are buried under DMA API calls.
> + */
> +struct pt_iommu_driver_ops {
> +	/**
> +	 * @change_top: Update the top of table pointer
> +	 * @iommu_table: Table to operate on
> +	 * @top_paddr: New CPU physical address of the top pointer
> +	 * @top_level: IOMMU PT level of the new top
> +	 *
> +	 * Called under the get_top_lock() spinlock. The driver must update all
> +	 * HW references to this domain with a new top address and
> +	 * configuration. On return mappings placed in the new top must be
> +	 * reachable by the HW.
> +	 *
> +	 * top_level encodes the level in IOMMU PT format, level 0 is the
> +	 * smallest page size increasing from there. This has to be translated
> +	 * to any HW specific format. During this call the new top will not be
> +	 * visible to any other API.
> +	 *
> +	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
> +	 * enabled.
> +	 */
> +	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_paddr,
> +			   unsigned int top_level);
> +
> +	/**
> +	 * @get_top_lock: lock to hold when changing the table top
> +	 * @iommu_table: Table to operate on
> +	 *
> +	 * Return a lock to hold when changing the table top page table from
> +	 * being stored in HW. The lock will be held prior to calling
> +	 * change_top() and released once the top is fully visible.
> +	 *
> +	 * Typically this would be a lock that protects the iommu_domain's
> +	 * attachment list.
> +	 *
> +	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
> +	 * enabled.
> +	 */
> +	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
> +};
> +
>   static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
>   {
>   	/*
> @@ -120,6 +174,10 @@ struct pt_iommu_cfg {
>   #define IOMMU_PROTOTYPES(fmt)                                                  \
>   	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
>   						  dma_addr_t iova);            \
> +	int pt_iommu_##fmt##_map_pages(struct iommu_domain *domain,            \
> +				       unsigned long iova, phys_addr_t paddr,  \
> +				       size_t pgsize, size_t pgcount,          \
> +				       int prot, gfp_t gfp, size_t *mapped);   \
>   	size_t pt_iommu_##fmt##_unmap_pages(                                   \
>   		struct iommu_domain *domain, unsigned long iova,               \
>   		size_t pgsize, size_t pgcount,                                 \
> @@ -142,6 +200,7 @@ struct pt_iommu_cfg {
>    */
>   #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
>   	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
> +	.map_pages = &pt_iommu_##fmt##_map_pages,       \
>   	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
>   
>   /*

-- 
Alexey


