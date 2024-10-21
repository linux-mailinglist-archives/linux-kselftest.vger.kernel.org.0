Return-Path: <linux-kselftest+bounces-20242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D51059A5E42
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E171C21B07
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2931E1C00;
	Mon, 21 Oct 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSfE92UN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C5194143;
	Mon, 21 Oct 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498322; cv=fail; b=rzEPtqb3O7T48enMi9yJyTKy1hI5cnUl94xMVc1+wR44wg15l/mrkARHCcd3ag2HspMZTOBKHbLc7MtA9Q1D4DRTWTJwtwiUlMkMU1XUwJ2A/hSkciCY688DtC3dxy9qa4H725UdsRF0fVJN2gSvAwCG0TO280ZgTM80+MWGGQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498322; c=relaxed/simple;
	bh=CNG9L3FydJjuwK5YBq1IGdjhUL5T0EHNt9eScNjYMRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tUEfRWRIXUPCThAlVGYGyVeAz2jigaYauFfT2Kf6XooaADJtbPgVEJsWrT5G9uxDJDG23iR+7ZbKb3HSPxgm/T0GduWsEk4bX3tu98svv+OsGAw5eMHgFF+8kSvNBQavX6CAaiZkqxFZHp7cmfikElmyk6jiVVZhq/PT02tTjD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSfE92UN; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcMc+cdYxP2IplCr2vqGXOy8N5WEDWMIJ9rrjqQ+IttdfePhqli0OlP1Ank12ICAWrml4GhTLQF88DABswpFM3Gu88rivScNLoA+UYXfh5NYEts7spEPqUVjbQNwv0m/0Wf8p+bN80tzjwseaTPE4JskWNtBOCDAnrJCQoGJuwPFY4jDpQGG5L7Dy2JxebWswLZv5KPxAaJuqCdZZrSet1fz9FW9aTh8BENXEcV8xMa7bLbuMABRa1PNXnF7/iUh7HcezSNrKHpqZBOtApkVmoBoQOpf2Vj4Pb7/eHyMZ70V8zy/9FF0ffxnVnT0eDKJfEpGjJSDTdHk+hqCAswZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRyLdQkFI7Qs94FeE+cPr6DsgzfI5sIpS99lUSCl0DM=;
 b=EPXQToVRZkhV2Z6vE9/uOAUH4QJ0/VuPbr/TdHbIo2vmoneAbrL/IA9fntUIX2aO0zsIpt3ukO/1IqxU2gUl7fzs64PueDjbq/l/JQoAoPZQ7YMUpRBJlwGs7fgSHEd+Jpotq2iMsU/H2rVuMYrqOZpSSQ2/QE7vNdz9Yo0jwHUysNAEuSsEbB27QhCJj4IwaxvUBdCoCfR85lmgZqit13OUnDMgU9n+yvImPBXVB56EF6HEnyOXNjw+jFWkD0iYg2OxNYtGn2aWes4ZBaVmUlxi/JX7HFEqdmqK3ckscgeLRnx3VDXtROyKIO9gtV6O+t0MlKE29FZf5xUn0nWaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRyLdQkFI7Qs94FeE+cPr6DsgzfI5sIpS99lUSCl0DM=;
 b=WSfE92UNaTwB29Y57ls+ou7llRPp/Se53VoPdqOHvVd5WZheeVRaL5Xn4NiM0YIywxo2TQC2pxteTXwlbvpndmq/TRCBfe341MYYJQ31Jbk9ufGHkvGk+FqCcUxri6Lizkr3/fxjPslZz8AnyFwKbv05d4gPxJ68zdvxyjm5yUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 21 Oct
 2024 08:11:58 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Mon, 21 Oct 2024
 08:11:57 +0000
Message-ID: <6ac9e666-75c3-4cc3-beed-03295368294c@amd.com>
Date: Mon, 21 Oct 2024 19:11:47 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, patches@lists.linux.dev
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0006.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd49dd4-9438-40bc-6a57-08dcf1a807ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjZFcFkwemMzQWJ1VkpSNUhza2pNZk9TRWk3Nm8zMldIK24rMWhEeEY0bzBi?=
 =?utf-8?B?QWNtck5NU25oMXI5ZE9aMHhYTFJSUHpSV1F4RmlBQXBUa3d6Z3BjRUpGaXNr?=
 =?utf-8?B?VHlyVWgzZzk5WUNIYTF2OXZQMVZXTnhLazd1Z3dSUFYybjFudDVWTzBpc1U1?=
 =?utf-8?B?YzRRTHYxclZPZGh3RlU4NDdCQTJQZ0djVDVjSklEZmZuYTdlUzNnSnZYVnpm?=
 =?utf-8?B?TnRvN3ExVG4zbHplcWRSeTZhU2lvUktHNTBpRmtBSURjRmJ3MHVRV2FBNWMx?=
 =?utf-8?B?N2xvZ0dZRjFmOGUyb1VKUlhnaGJQTGczUDNLMlBOMi9rZS8xV0VrUU1qbWVD?=
 =?utf-8?B?WWVQWDcraGNCbnh0L0NtbnFQRnpJbnEwMmxkUmlUdTIyOVVnRENlbWwwUVFO?=
 =?utf-8?B?cUs0aXlCYWJCQ0RmNW8vdmhTQVc4VmRzZGN0R3ZZYWVMVURSUG1welhKTWpO?=
 =?utf-8?B?RzRyTVdvaWRuV0pWRm11c1hnN2p4blhlaTdoU3J5eVFPaHlMcFpVcXI4K0VK?=
 =?utf-8?B?bFlJTkZvdGwrOVJBSUs4dHZnMnhjUDBDeStIR0pOT2ZWeXovbFc5dXRrbHBk?=
 =?utf-8?B?bFRsaUZxcldYWnN3UHpvaHJCcmpkTUFueUNzKzdQUzNIUjRtUW82OHpXVTRU?=
 =?utf-8?B?RVF5d2NmRFo5Q2poazRjR0thS2hPcEF0Y2dtNGdINURaZDFBa3BoNGRITE52?=
 =?utf-8?B?V3lTWTFqdEZ4bHBUSTQyZTlYQXpVb295eWdjeXVubUhSeXZHSElueFVpY00w?=
 =?utf-8?B?T2lSZWZPRmJJeC8xYVF3b3o5eUFIdkdJWElRNElIRkpodmtpZ1BxRDVTRmFj?=
 =?utf-8?B?R1RBV1hVc2RWc1VqSU5sbFh0QUQvYWYzellrT2JXTk1TVEhOOEN4TElZSHdL?=
 =?utf-8?B?ZXFxNDZzYVU0S0ZZSUYrWmxQMUFBR1daVzlOL2FpVjEvZ1BRR0pTUHBhUG9o?=
 =?utf-8?B?d3pYd0hGL1VRYm92ZTlHWkgvL1ZWVjFRU1RpU0tlaG95U3NxbzNqcmJPYXZa?=
 =?utf-8?B?M2dtOURSYTh2MGN4QkhoWW9UenhUSlA2NExuaVFsVjNPSXhFWXhEeVoxWFFm?=
 =?utf-8?B?am9vS20vWVVSK2F1VHhTTmd1amFDMWpBYmM4ZkFFK2VmWkpKU0pYNS9qN1dt?=
 =?utf-8?B?UENXZU5VeVgyalFCNWo1WGZsYThPd3lWd3p6NXE1M0REeWlEYXlsbVB3bDZX?=
 =?utf-8?B?OWMvdUtzWlREcjNHbTJZWXMwL2Rjb0NyNit1QjZIZVQxbjBrVXJHeHpLenRv?=
 =?utf-8?B?cFVpYXpJT2pGZ05GY09LakZKY08rMll4VUg2TDVLRElPQldnUzRqbHNXZjBV?=
 =?utf-8?B?VW43dnBWUTRacjlZeXRYMW8vQm83cllkRWJ0WTJ4YlM2ZjZwZWZ6dlQ3Vllq?=
 =?utf-8?B?NXpiQ1FqanVJbVpPbkVDU1BrU1FQWFE5ZWx5aTFOc3VzZnplUGQvbVZpY3dl?=
 =?utf-8?B?S1hGK1NWS2dBY2thSXBpOFY3SW1nV3dic21zREtWUFRKcUxrV1VuUTIrNnl5?=
 =?utf-8?B?M282UG1tdk1ONU5DUjFGa2lTTzA3bWcrUDdQM01DWnZqak9XelhTVUFvd2VQ?=
 =?utf-8?B?SUtoeW5WYzNWaFovTUg2SEtQYzhWQVVWaVdlNDVid2RmOHFOKy8rLzNzNERC?=
 =?utf-8?B?RXBQYjVFYVhLeHA4UDZvWUptZ2lNeGhNTWQ1akcrcS9HUzVKUTV0K2tvWFpx?=
 =?utf-8?B?aVlVaFNYRUZLM0dtdXQrWndOMGVDR1JPTyt4T1JmZ29MZEVUVUMweUs2L3h6?=
 =?utf-8?Q?2i0fbSMfiZYwh1wZfKsBYtypR81oRnx0MYa+Xno?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTErTFFYTCtWeEl4ZUg1ZDZaT3hVOVRWUzlEcnlkWXRzWWkrUXI0S0RYVG1I?=
 =?utf-8?B?RUd5OTY5R1lYdThvSFpOVzlNb3BqSXg1Q28wVVovWTFkVHUzSVZvTFdQWmJS?=
 =?utf-8?B?Wkp4c2VyaGZuSmUybEFNV1ovRFU0dXpTZUJkQjR5OVhsME5rM2Z6QjF6bkRQ?=
 =?utf-8?B?WFAvK1ZMc3RNZFZUVDh4UzM5eGpEazM1bGxIV2FwQ3VlSWRpUlY0d2I1OXVl?=
 =?utf-8?B?K0xTc0RMT2dTSWFRRTlRZlkwMCtVdDZ0NkZZT1ZQMzd6dERtK1llY0F0SlhI?=
 =?utf-8?B?eDN2OEs2S0NtNXpwdXdzZ3IyYUJsRUNFSFZZUFlLYTljb3BNMCswS093UkRO?=
 =?utf-8?B?UW84TmFMbWZsVzlDL09VUjJkT0ZVSG1WeDFxQ01tZ25rZnM5WitLUXJlRWlZ?=
 =?utf-8?B?SmZ0NWFqQ3BVcXJISGdFaTFobXdHMFBsNUxZaVpkTm05cENldm5XcmNWcFFx?=
 =?utf-8?B?VkdYUlErUG9QbUhLeWthVG5FcGtuTitjZnVLRENRYUs4bzgwaVdnOW5TYUNL?=
 =?utf-8?B?R1VSZkhSOWRYZEVBWVlZQ1NRYnRLaXRzMzl0bzFheWxJZUtTa2ErSWRQYUgr?=
 =?utf-8?B?Vk5sOWdLamJNOXZrbEJaSXdvdTBGK29OT3ZwQ0pENE1UekIzY3VXSlhleEU0?=
 =?utf-8?B?WkwrZk91UkJjdHBpcVM0OFdaaXJ2UkNlK2VOZHhoRitzcDlhdWRuNlRSYTha?=
 =?utf-8?B?TkVYbldwSENrSDBuSDdrVFQzUUNjUFVkYmJTbmFRVXBsN2ViRzYzYlVjMWx2?=
 =?utf-8?B?WEcvc3ZRQi9LQW83Y3NnOEZmSzluYW9DS1NKZHIzbkhXa1FDekJBYm5kMm1S?=
 =?utf-8?B?ZFlpUUo3SG9CQVBUUWZmVmU1Z0V5QzRrR1J6M09IejRSdEs2MnEybm9reGdN?=
 =?utf-8?B?UWZZbzl1aHNnQkpXa0tXY25rUjNwUkNXQ21XUUxHQ1V6SGNTYWxFUmo5ZUxY?=
 =?utf-8?B?M093aldva3VxM3dvb3hsUDgyb21rOFNrZjlKUG0xTzhHNDlqTzVUVkpVRzVZ?=
 =?utf-8?B?bHh6amdkWE42MlJ4Yy9ibDZhaE1TckgyNUVGWndEQkNFZmtGTzFUN0U2U3Fy?=
 =?utf-8?B?cktYeFNLSXhmYkN0MEJwQW5XQUlmRFBTc3VpN2RoNll6Z0x2VlVjdjdPTDlY?=
 =?utf-8?B?MUlqN0N2amg0TmdvRFg2UEFVUGpDZ2xZdy9kSkFabTdLc2d2NmlFYlREOFA1?=
 =?utf-8?B?TUFnNXhHRzhXcFl2WDM0aWZsb256VFZNMzFMTHZXVmtYOGw5WjJsTWVsZjBZ?=
 =?utf-8?B?YkhlMm44VFVXUUhPd3RrUXN1N0R4Q1MzNzdvbTc2RHFTZkdLQmd1QjN6eGY5?=
 =?utf-8?B?dXY0UnVmNk5sTGhEdWNncTNscDB0dHRPRWxTenJsWmpobGlnZnV6cyt1ZTNr?=
 =?utf-8?B?RlNhcHg1TW9ZOUxmUjNVdHlVWDMrV0FEeWlTMFJ3cG9MYlBmMytoQkE1NUNr?=
 =?utf-8?B?cEoyTEltbnBxenh0aXdrSFkxWTRLSGJGOHBWbDZIRExKc1RUTmtJdXExTERw?=
 =?utf-8?B?MnVyVXZURk5aMnZaOWQ2ZzVIdmhWMy85TCtjL1lseWNqLzRrbHlhUzduR0tE?=
 =?utf-8?B?dHRCZmxBZDRuR21VdWY4UUtTWEEzMUFmRDlMaHBhMklxanNnajBoT3oxck5i?=
 =?utf-8?B?WUNGL21HRHNRWGJtUDRtNTAxbkVCRjNvanpRYzNIWHcwSHpkYjV0ZHA5c0lu?=
 =?utf-8?B?dGxtKy9LcEQycnBmdURhV3lGdkdsbUVQWXVTcEpYQ2hJUE9kTENsK2EyTkhZ?=
 =?utf-8?B?ZHNrdEtYWVhhUnlPMnMxMkxUSTRoaHR3RWM1NFFKV2pEazEzZlNieURza1lS?=
 =?utf-8?B?c0VGYmRjdWNiSTVtM09HZGZ5K243SzdXMjkvTUhJaGducE5RY09oNnY3U1hN?=
 =?utf-8?B?VXNGdXF6Ti9PY0lLdTdpc2Jmbi8veUZYcjIyZG1uUHQxeGYrNEd1VTQ3dE5v?=
 =?utf-8?B?QlFidFpQTi9XOVUxSElWUCtMSWFyUXhNMVRMTGI0dS9rcHJNQVA4d3IzMENs?=
 =?utf-8?B?Ly8yZmRqcWZDcm1veHRQbFhwOElxQXRvcG9DL3podUFEak05MVRvS1hQckZh?=
 =?utf-8?B?Yk5TcERQYWFIRDBZL2lpTXhpUmM5Q3RYelRnQzJOOEN6U0pOU3hpeXZwRlN3?=
 =?utf-8?Q?qIiOe8+OHmQ22g0i+v3moey1o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd49dd4-9438-40bc-6a57-08dcf1a807ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:11:57.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cumIIXBu+YdDiA7UvdCLOlE7BV2L5LfL9SjpVA7W2yPJF1vE9vwh4Rw7vqZga8rpCMU5jtx2HVNQQzh4/kGpyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

On 10/10/24 03:38, Nicolin Chen wrote:
> Add a new ioctl for user space to do a vIOMMU allocation. It must be based
> on a nesting parent HWPT, so take its refcount.
> 
> As an initial version, define an IOMMU_VIOMMU_TYPE_DEFAULT type. Using it,
> the object will be allocated by the iommufd core.
> 
> If an IOMMU driver supports a driver-managed vIOMMU object, it must define
> its own IOMMU_VIOMMU_TYPE_ in the uAPI header and implement a viommu_alloc
> op in its iommu_ops.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/Makefile          |  3 +-
>   drivers/iommu/iommufd/iommufd_private.h |  3 +
>   include/uapi/linux/iommufd.h            | 40 +++++++++++
>   drivers/iommu/iommufd/main.c            |  6 ++
>   drivers/iommu/iommufd/viommu.c          | 91 +++++++++++++++++++++++++
>   5 files changed, 142 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/iommu/iommufd/viommu.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 93daedd7e5c8..288ef3e895e3 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -7,7 +7,8 @@ iommufd-y := \
>   	ioas.o \
>   	main.o \
>   	pages.o \
> -	vfio_compat.o
> +	vfio_compat.o \
> +	viommu.o
>   
>   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>   
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6a364073f699..4aefac6af23f 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -521,6 +521,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>   	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
>   }
>   
> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
> +void iommufd_viommu_destroy(struct iommufd_object *obj);
> +
>   #ifdef CONFIG_IOMMUFD_TEST
>   int iommufd_test(struct iommufd_ucmd *ucmd);
>   void iommufd_selftest_destroy(struct iommufd_object *obj);
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index cd4920886ad0..db9008a4eeef 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -51,6 +51,7 @@ enum {
>   	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
>   	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
>   	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
> +	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
>   };
>   
>   /**
> @@ -852,4 +853,43 @@ struct iommu_fault_alloc {
>   	__u32 out_fault_fd;
>   };
>   #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
> +
> +/**
> + * enum iommu_viommu_type - Virtual IOMMU Type
> + * @IOMMU_VIOMMU_TYPE_DEFAULT: Core-managed virtual IOMMU type
> + */
> +enum iommu_viommu_type {
> +	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
> +};
> +
> +/**
> + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> + * @size: sizeof(struct iommu_viommu_alloc)
> + * @flags: Must be 0
> + * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
> + * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
> + * @hwpt_id: ID of a nesting parent HWPT to associate to
> + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> + *
> + * Allocate a virtual IOMMU object that represents the underlying physical
> + * IOMMU's virtualization support. The vIOMMU object is a security-isolated
> + * slice of the physical IOMMU HW that is unique to a specific VM. Operations
> + * global to the IOMMU are connected to the vIOMMU, such as:
> + * - Security namespace for guest owned ID, e.g. guest-controlled cache tags
> + * - Access to a sharable nesting parent pagetable across physical IOMMUs
> + * - Virtualization of various platforms IDs, e.g. RIDs and others
> + * - Delivery of paravirtualized invalidation
> + * - Direct assigned invalidation queues
> + * - Direct assigned interrupts
> + * - Non-affiliated event reporting
> + */
> +struct iommu_viommu_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 type;
> +	__u32 dev_id;
> +	__u32 hwpt_id;
> +	__u32 out_viommu_id;
> +};
> +#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
>   #endif
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 92bd075108e5..cbd0a80b2d67 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -301,6 +301,7 @@ union ucmd_buffer {
>   	struct iommu_ioas_unmap unmap;
>   	struct iommu_option option;
>   	struct iommu_vfio_ioas vfio_ioas;
> +	struct iommu_viommu_alloc viommu;
>   #ifdef CONFIG_IOMMUFD_TEST
>   	struct iommu_test_cmd test;
>   #endif
> @@ -352,6 +353,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 val64),
>   	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
>   		 __reserved),
> +	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
> +		 struct iommu_viommu_alloc, out_viommu_id),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> @@ -487,6 +490,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>   	[IOMMUFD_OBJ_FAULT] = {
>   		.destroy = iommufd_fault_destroy,
>   	},
> +	[IOMMUFD_OBJ_VIOMMU] = {
> +		.destroy = iommufd_viommu_destroy,
> +	},
>   #ifdef CONFIG_IOMMUFD_TEST
>   	[IOMMUFD_OBJ_SELFTEST] = {
>   		.destroy = iommufd_selftest_destroy,
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> new file mode 100644
> index 000000000000..3a903baeee6a
> --- /dev/null
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +
> +#include "iommufd_private.h"
> +
> +void iommufd_viommu_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_viommu *viommu =
> +		container_of(obj, struct iommufd_viommu, obj);
> +
> +	if (viommu->ops && viommu->ops->free)
> +		viommu->ops->free(viommu);
> +	refcount_dec(&viommu->hwpt->common.obj.users);
> +}
> +
> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +	ops = dev_iommu_ops(idev->dev);
> +
> +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_paging)) {
> +		rc = PTR_ERR(hwpt_paging);


iommufd_get_hwpt_paging() is container_of() which does not test for the 
value and just does a simple math so the actual error value from 
iommufd_get_object() is ... lost?

Oh well, not really lost, as "obj" and "common.obj" seem to be forced to 
be at the beginning of iommufd object structs so container_of() is no-op 
or is not it?


> +		goto out_put_idev;
> +	}
> +
> +	if (!hwpt_paging->nest_parent) {
> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	if (cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT) {
> +		viommu = __iommufd_viommu_alloc(ucmd->ictx, sizeof(*viommu),
> +						NULL);
> +	} else {
> +		if (!ops->viommu_alloc) {
> +			rc = -EOPNOTSUPP;
> +			goto out_put_hwpt;
> +		}
> +
> +		viommu = ops->viommu_alloc(idev->dev->iommu->iommu_dev,
> +					   hwpt_paging->common.domain,
> +					   ucmd->ictx, cmd->type);
> +	}
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu->type = cmd->type;
> +	viommu->ictx = ucmd->ictx;
> +	viommu->hwpt = hwpt_paging;
> +
> +	/*
> +	 * A real physical IOMMU instance would unlikely get unplugged, so the
> +	 * life cycle of this iommu_dev is guaranteed to stay alive, mostly. A
> +	 * pluggable IOMMU instance (if exists) is responsible for refcounting
> +	 * on its own.


"Assume IOMMUs are unpluggable (the most likely case)" would do imho, 
all these "unlikely" and "mostly" and "if exists" confuse.

If something needs to be guaranteed to stay alive, may be just call 
device_get(viommu->dev), with the comment above? Or it is some different 
refcounting which is missing? Thanks,


> +	 */
> +	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
> +
> +	refcount_inc(&viommu->hwpt->common.obj.users);
> +
> +	cmd->out_viommu_id = viommu->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
> +	goto out_put_hwpt;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
> +out_put_hwpt:
> +	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
> +out_put_idev:
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +	return rc;
> +}

-- 
Alexey


