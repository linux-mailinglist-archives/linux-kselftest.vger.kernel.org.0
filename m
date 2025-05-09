Return-Path: <linux-kselftest+bounces-32766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C463AB1BC8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3C09E804B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706EE239E9C;
	Fri,  9 May 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VZ5dcoUW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731623498E;
	Fri,  9 May 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813133; cv=fail; b=BLAOXfH+cJKBnMYcBzda5jHam9Pp/IZ/1jjc6O175aNR5FFuhUMMd2/ShtywlvaU9YNdeqWyNqeDaLsJiwLyD3YPc1tUBGa9hGXhRNovCQfpEWWhLmpvsJZr+IY0riwCTCI+13YcNZmGsfnPExDFqhiHyxVHmZ053M5vDYQ+eh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813133; c=relaxed/simple;
	bh=E/lMnaiXSUygWzwmW+Wk+DJWx6Kt6skfjVTy4HbbLdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HLZeA0zbtBxgkAm/snF0SKEvtZqkjoQBAw4C6Pg91P8xBjzO8Yti4FvGxsZfL+ko+TrGW9LwjRUNxXfbFpaTs24Lc+CRTOE9NSyk2z/w+8rfK+pHYur0H2cKtj673R+rvxistS+4dtcsOuViixVZTeiMQgFlcEmLkJ4OsgtU1m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VZ5dcoUW; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjtdD5sRh40bEkK9A8t+38oCLNAVDBgG2XZuRgTSoJ0tedsQcYsq1ka8gmZoyGPGFadbbJtuZjo/gVKGo5YJPifjxtZ0Ys4j/u85Q/OqLerGxa019+0WqGwIKoawnxdzYWdi4BmE6j05dSbebEFFiJLcXdKA9sG2tU1LdThs3JtH+oeqb59ioc2OpiNb15xTgzjjmcgxiW32dNjBzcg+Ce6ECcrMSsyZkV2dMP8ui7SgDUB7ZRyHYDzoTC+dBPi3Mn7rFHe0bDmIfpakMwKal0vxQkRFAOuMU+/4GdGaGNKEgNTLUifxi+hIfa4wToT1hsu2GQF8wkIh5t+U3/rQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NXLGIwlFsF+ig80OQbWvyE6OSej4sgTCBG+dXkeHRE=;
 b=XcUA3lFSezKBC8qbLcCnvrDZamZlKYTu/8jh5WsHF6HqfuRYXKeyyN6CWFqHRRy0DZpYiKN3HuxJtyMO/2ZVHOIX28k0RPQKNsVVCJruJgAs12/JvpdJfxcwCUA8x9KbnJdW7qCdlQU5zYuueWneD8i4r56d6st5rdmjPqUl5z1qTHiEZZZ50//9wrOiJI14NnvdgxfzWeE20NQ+GDb9K8OaZPnOPUbxBMfm/rm9svXsARiffDIu6IYBnVzvMrimaktnwp4zqV+I+yO3LP5Se4jyc301tdekq4iFBlC7k+3SJsKedoDRH60ZnGj4FBO4sSGqCc4IIZjAD2f1FLkOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NXLGIwlFsF+ig80OQbWvyE6OSej4sgTCBG+dXkeHRE=;
 b=VZ5dcoUWuD55j5pbegskI9Ywnt6l5fVlnkokK53jhaTzRRns5cjUpDQrlC/KuEDHQebQd6yI7SRW7875fMZjpQJwkrWgJRgctD7m2Vx4AjL8yeu6J/PQi0p7VEE4NBXv6wwFflBk/upnQU4xgj5ptJekvSww5JQqZgiN4NsFAdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 17:52:08 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 17:52:07 +0000
Message-ID: <e71453cd-3d7d-4c7b-b763-3e47236ac955@amd.com>
Date: Fri, 9 May 2025 12:52:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: Disable SEV-SNP support on initialization
 failure
To: "Paluri, PavanKumar" <papaluri@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, thomas.lendacky@amd.com, shuah@kernel.org,
 prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev,
 "Paluri, PavanKumar (Pavan Kumar)" <pavankumar.paluri@amd.com>
References: <20250508225257.9810-1-Ashish.Kalra@amd.com>
 <03114e3d-ff0b-498f-8aec-00a26276785b@amd.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <03114e3d-ff0b-498f-8aec-00a26276785b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::35) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: d95d0538-cccf-402f-bbe1-08dd8f223747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGNqN1JRcVZoVlovQ3lFZ0hZRVlSazlhZlNXR25aUFFzeTBlM0k0d0M4d3lp?=
 =?utf-8?B?Rlc4WHR2R1YzbnR0eFRacis1YVpYa096TEtuZ3VLaURRQjJqb2dMQjRJa1B4?=
 =?utf-8?B?d0NDK2JBVXhheWphTUpRRDgzNXNPK2V3ZVRrbjR0MTJQWnJtRzNpdERkNmNm?=
 =?utf-8?B?dWZXSFp1MUx3RXN2OXdrMFcxQ3ZUSUdiMGtVTVZ3dkRtRm9sSTRZeENWZlY1?=
 =?utf-8?B?NTlEdlFEeTZjR1BtcGRqYUJseDZrcE8rZW9pN2tuVlZWZlNEbnVsM2xuenV6?=
 =?utf-8?B?NmpTQTRiWEs5UGY1RHh5ZFpmV3hOK21hSlBRWU0wcDc0MEJ0dWs5aHQyV0lp?=
 =?utf-8?B?RzYzR2k0azgySWtFOGdya09wTUpyc0hvbnZlM3RDVlBCZGJmNnBBNkMySzVr?=
 =?utf-8?B?ZWtiR0JYQzAyS0xMUnVlL1JKWmQwdnJPV0ZvQk5iZSthYzFWUGdYamdUbm9k?=
 =?utf-8?B?NnRyZlhxRThxVDl6Z2RjSW1RRVZVdG5TelJ4akhFbUdHWjVGMzZaeDRiUGVJ?=
 =?utf-8?B?dWxqQ2lEei95UE9hdnFha203VG5QT0hvdnlWNFlWdkFPaUc0em1CUmJJM0dL?=
 =?utf-8?B?MXFaWjkzcUFwNUlQRHk0Y0R5dEVnZ3FWUFUzanMyZjRaNlFQQzA4S2JEZndT?=
 =?utf-8?B?bnNkTjJ1NzYreno0NWllbzRCZG9NZjZEajQrNzJYK0FndGNzWFluWEloanRH?=
 =?utf-8?B?UkQwRjM4QnRzTTZ1RzBCdSswK0ZzZklOcUFPQmJkZXpvZkZXNW1EYnI0UFE2?=
 =?utf-8?B?UVJHRUJFZzNHSkNFTm9SbVhveFJvSERDcU5kQ1lpU3RSUGRnQ1c0Z3IyYlRM?=
 =?utf-8?B?NkpSRzBKZjB0MlhUUFNxU0liTGUwSjQ1TXNXeGZzUkNyc3FzcldWTXJQbDhp?=
 =?utf-8?B?SDdPcHRRclV1ejRiVUxVdHdFSlJqdUViUndVNEV4Z2FWclN3MnBrVk4vYWdy?=
 =?utf-8?B?ZlhRaUJkVTV4Z0hwT3JlaVNySVl3amUwU1NjMWU3c3lXTndFbEc0MThGM2tP?=
 =?utf-8?B?d1RzWVZVMFhYTHZveENKclFlRDRuS1BxVW5VNmZSMW9VWDlLSjQ4ZVlwelpN?=
 =?utf-8?B?dVdzUGcyaThPMHlpNVFvYXR6L3VTN3NINHNDZTF5NG9oQ2p3VXZQOEprdnJJ?=
 =?utf-8?B?eDVRdFcyaWZkcHU0OEVyQ2phTGlJY0pHNFVoT2Z3c2kvNWxWT1ZFRVR5SzBO?=
 =?utf-8?B?WnVBZlN6cDM5NVE4bFVJeWthaE53MDNhRTh5VE1lWWdOd1V4SWkzb2tOcjIw?=
 =?utf-8?B?bUVybytvQzEyc0VPV1REZmlKaldiSHZGWllydFZ3TVJ4eVd5MWN3K1RRMDVL?=
 =?utf-8?B?aWFMcVFWTWRyb1dlNmtoNE5DeGlHbWw3YndKRFNkSFlZNHhISXYwRXNmQ2Nz?=
 =?utf-8?B?NFpMUlBtTk5adVJ0NURjV1dBOGN5NmVWMW9aeDZJTHlsZVVXK0RMMUcvT0Zz?=
 =?utf-8?B?UkVRZ3VyVXQrUlR5aHQ5NXoyaVFkblRabVc1TXUyVlJ4RTBYY2R5SGtnQmtC?=
 =?utf-8?B?TTUzUW94OUJUcmxIWDJGT1dZTlNlNG5zd3BrWG8zZk96QVJQNjNHckFtOHlB?=
 =?utf-8?B?ZWNYTXNaRlI5VlpaOEhIWVZRVmZNcnFiV2NKUWFoRnJNT1hOZlZPMmt5ZmVM?=
 =?utf-8?B?cW9YM1l2WTRKWEVqYTZzQzU0WW9IajAzYU1qQjV6Q25uK09WNkNMY29qd3kw?=
 =?utf-8?B?M2dtQStVWnFxTERtOGVYd0JFNE5vZllZQTgxT3JiWWEzR21xTDNVdXQxWnBk?=
 =?utf-8?B?T2FIZWdYc0JBSVBLRHJaWEYxUUFST1liT3Z5aUZuZjhid2dIaGVDVkg5eDUv?=
 =?utf-8?B?TGp6aTZzbDVQRzRPYWtKK2JBTkJrMkkyMjY4WE45UHZFSlpNOEEzZEs3dWd6?=
 =?utf-8?B?cjdOOHZaa3k0NU1TYjdwV1VCenYyNE05Ym9CanNhMWdZNlRsOHU5c2pUUUhz?=
 =?utf-8?B?T2RUWDdwWDhId0g0UUROaVNWRUorQU1tN3o3Sk0wY01rOENOSXVNUHZQcXNI?=
 =?utf-8?B?a1NicjhtQlVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzB4QW9QRDZLZnVCc1psS0NtVEhFM2J3UDhNSXBBQWhmRTJPTGQ1YXo0K2h2?=
 =?utf-8?B?bzI1dHNoUnc3Y0NoTFlySjJDZElTZ1NSVDJDWDd1VFNwclJJeEQzd3l5S09E?=
 =?utf-8?B?eVk0Q3RUL1Q5ZXg1R0lpVnpwREpWM091enlHbFJzQ2pBUm4xL3pWL2QzeUZX?=
 =?utf-8?B?MHpzak9TRUdJanM0VGdkdmMranE1VUMyMzdqaExlNEZMN3hubUljUWdtcEdP?=
 =?utf-8?B?eTBBcTZjdW9Obnk2enpEc2N0MmZGVGp4RThqK2loVXJIbGQ4RGZnVVlvUXZY?=
 =?utf-8?B?Z2tKUG14NGd0WGkwbzc3akJDaE9qRDFzK1U5eDJ0RnQ0V2Irc3Vnb3VaTkoz?=
 =?utf-8?B?V3dacTJwdHEwYUZ6OUZ5NjdXNktnVTJ1RTBDUzdCTXhOd2xJd3pEVjRYQXlY?=
 =?utf-8?B?RGx6cXgwOU9vL3VhaGRRV0tEOXgzWDdTT0p6U1NXcklyaDhFMDg2cGFYU2Rm?=
 =?utf-8?B?Y3NZbjlwU0RheWw1YWtxc0EwVDNNYmsxWUFUTmFSKytyRC9FOGg4UGlRaVNo?=
 =?utf-8?B?VVNsY0RWYmlxMmkwM3NheGNFMjgzYmpYZGtXVXhsS3BwbU9lSEtiNGpCeUF6?=
 =?utf-8?B?YVEyNnVrZllwWVU2MmFLVFhJckViY1pDRG15a3crUWVXaDVsZGg2VkpxdXJj?=
 =?utf-8?B?N3E4ZVA3QUorQ3RhT1FGMytIdUZvUVpzVmJvd3dLZGZWU0tVRXZ2aUVGOTAx?=
 =?utf-8?B?bXd6dW5ZMFZBVWdNNXNwZW9NOWYyb2pxWXpabDVJeEdEYXBheC9LaHZOc2VW?=
 =?utf-8?B?Vlc5QmxKWTlCeDBWYllBbmtmWnRaOGFTdW1XUTR6Rm5TVzZJZ1FyTnMyUFJr?=
 =?utf-8?B?ZDVBcmZTa0pMbFUzaG5zOFRNa29yK084VmFGTjloQTJRT0daVFVxZ1NpT21X?=
 =?utf-8?B?UmpTNHhLUS82NXRMdnBrZmxiZlFKRU0vSndLYU1JZ1MrRDZVODVMaG5rcWE3?=
 =?utf-8?B?RU85Y3NDeHdFc2dSOXRmTVhBc2JtYUhYSURUWVZ2UTNPM0lLUDlnbnVrNXBo?=
 =?utf-8?B?THZ0bjEzb2lIT2hkTWdtUlQ3cnVoSml1K2FEdWQwSzl1akFLb2E2Z2wwcHY0?=
 =?utf-8?B?K2p6T0YrQVV4SjZaZmZLTUVaaEZyNFhlZ1haR0ZQZXI1dUUxbTN1ZmNGSUN4?=
 =?utf-8?B?NE1URmZyUnBjSHhpYmV1aGRvbkRoK3RlNXNiU1VCOEplS1FrK1hZWDZsekFo?=
 =?utf-8?B?MWZkZnpaMVM1M2JmYkR3RkxhdUtuc0twVTNqMlhjSENtaXdJeFg5eWxiVDV0?=
 =?utf-8?B?d3JUTlNwUnRoM2VheUxlZ1RsQTZQeHIvL2pLY0RoNVV0WE5jNnFKSHdHOGtp?=
 =?utf-8?B?c0x0dVpxRWl4b1ZIbms4SHZWSjdhV3RMN1FFM1pVK2lPM1NrQURxem5Hb2c1?=
 =?utf-8?B?YlpkZTl6V3BlSVdiMUVDUjVCdlUzZytETEJ1MEFwR2RvTXMzS1prcmRmUlds?=
 =?utf-8?B?UkV2WHUrRm5CR3p2VmxuYXFmS05VMGhIRFBNcGVFMVllVlBjV1J4alVXV1BQ?=
 =?utf-8?B?L3NpbW8vWmNOd0J5SHNWdEFMRjgxdFFPVFR4MkxMOUcxWFhJbDdTZGQ1NnNl?=
 =?utf-8?B?REFJVTVrKzBvdU1IL0wvd25EUk5GUGpCdENvR2hWMTRzcjVDL3RwcTFoNnY0?=
 =?utf-8?B?SjRDcVJRU3J5TnRiUkF1RU9HWU56bGk0NEd5MVBSOUhoYnVtdGd3QjVFSDQy?=
 =?utf-8?B?VE5ic3RnMCt6QzFvWUNkSElCQnhjS01CTnZ5UWIva2U1ZTFHZGp4b2NaMEd0?=
 =?utf-8?B?NDFrb21BVlYvamJpWldxaXI0cEpaQXBzWlRUVXpLaG44RWNUbng3ZVRuaEVo?=
 =?utf-8?B?cUdBV2lUN0JOUTUxUjBXTjU4eVJwVUlqN1YxekpPRWljQURBbVFiZGlJSCtG?=
 =?utf-8?B?VVdCYzNqaTNDa1VXaGJvUkJvZG9BN05QVXNLOTRoZVpyYWZ4WE54OGJ6NGMz?=
 =?utf-8?B?UThVVS9rQ1ZsSzQzT2xLZFMwVGxYWEIraDRBMi9qUFVoWDMvTU5wNjVmeDlV?=
 =?utf-8?B?azR4WnFVWlFYdVhhbFQzN2JNalZaNUsyL3NGak5teE0zY1l1YXQxYWNpVlJl?=
 =?utf-8?B?VlhPaDVpNTB2ZFpzOFpJY1hBZUtyZVl5US83Tm1mSE1ZSlFZdkU0OHc0TFEw?=
 =?utf-8?Q?eC5ZaJdocDH0CuveefHaQdneT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95d0538-cccf-402f-bbe1-08dd8f223747
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 17:52:07.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C41EMX36inpOqswgzWEvc29F9cUNa2oaXzK5uPvb0as2x4BnXz37/+KO8VHGHqeLl9z1OwjgcgTU/7xkngbHyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272


On 5/9/2025 12:01 PM, Paluri, PavanKumar wrote:
> 
> 
> On 5/8/2025 5:52 PM, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> During platform init, SNP initialization may fail for several reasons,
>> such as firmware command failures and incompatible versions. However,
>> the KVM capability may continue to advertise support for it.
>>
>> The platform may have SNP enabled but if SNP_INIT fails then SNP is
>> not supported by KVM.
>>
>> During KVM module initialization query the SNP platform status to obtain
>> the SNP initialization state and use it as an additional condition to
>> determine support for SEV-SNP.
>>
>> Co-developed-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>  arch/x86/kvm/svm/sev.c | 43 +++++++++++++++++++++++++++++++++---------
>>  1 file changed, 34 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index ada53f04158c..a6abdb26f877 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2934,6 +2934,32 @@ void __init sev_set_cpu_caps(void)
>>  	}
>>  }
>>  
>> +static bool sev_is_snp_initialized(void)
> 
> s/sev_is_snp_initialized/is_sev_snp_initalized looks better.
>

Actually the convention is sev_is_xx(). 
 
>> +{
>> +	struct sev_user_data_snp_status *status;
>> +	struct sev_data_snp_addr buf;
>> +	bool initialized = false;
>> +	void *data;
>> +	int error;
>> +
>> +	data = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>> +	if (!data)
>> +		return initialized;
>> +
>> +	buf.address = __psp_pa(data);
>> +	if (sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error))
>> +		goto out;
>> +
>> +	status = (struct sev_user_data_snp_status *)data;
>> +	if (status->state)
>> +		initialized = true;
>> +
>> +out:
>> +	snp_free_firmware_page(data);
>> +
>> +	return initialized;
>> +}
>> +
>>  void __init sev_hardware_setup(void)
>>  {
>>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
>> @@ -3038,6 +3064,14 @@ void __init sev_hardware_setup(void)
>>  	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>>  
>>  out:
>> +	if (sev_enabled) {
>> +		init_args.probe = true;
>> +		if (sev_platform_init(&init_args))
>> +			sev_supported = sev_es_supported = sev_snp_supported = false;
>> +		else
>> +			sev_snp_supported &= sev_is_snp_initialized();
>> +	}
>> +
>>  	if (boot_cpu_has(X86_FEATURE_SEV))
>>  		pr_info("SEV %s (ASIDs %u - %u)\n",
>>  			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
>> @@ -3064,15 +3098,6 @@ void __init sev_hardware_setup(void)
>>  	sev_supported_vmsa_features = 0;
>>  	if (sev_es_debug_swap_enabled)
>>  		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
> 
> On what kernel version is this patch based on? I do not see the below
> diff in 6.15-rc5.
>

This is based on linux-next.

Thanks,
Ashish
 
> Thanks,
> Pavan
>> -
>> -	if (!sev_enabled)
>> -		return;
>> -
>> -	/*
>> -	 * Do both SNP and SEV initialization at KVM module load.
>> -	 */
>> -	init_args.probe = true;
>> -	sev_platform_init(&init_args);
>>  }
>>  
>>  void sev_hardware_unsetup(void)
> 


