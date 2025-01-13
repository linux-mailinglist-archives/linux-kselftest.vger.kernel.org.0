Return-Path: <linux-kselftest+bounces-24306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00279A0AE1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 05:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B8F3A21FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 04:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0814EC4B;
	Mon, 13 Jan 2025 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="umJRLQwD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812CA14AD2E;
	Mon, 13 Jan 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736741421; cv=fail; b=Z4amXu9wk8z4W2vYstZpEukpT3OmNNRiMOBvULiwdFiH3cW6/J1CO0qxgiD8xV9/THii/x2BbFjo2kjTaWecnU+doc8eRumCNNRMIhNK6p3sThmrcSqzK2X9dMD+77qi7eptDUa8rxw7mcZHk4E/ORY28+7Io57KFZGjccMig8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736741421; c=relaxed/simple;
	bh=1Z6d13CHM4oUZBIY1BP+fhp9rVnlOmiHke+MGOFjy7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LFNrvRRPSJP6THsz6d4J3jQ0KiEQ+MNQ7AUkCFY6Xi8g9bIBoPhGOb9DVWdYT87n3WIbDj80aQvLS4xBFhfPak5TPdMJZHVrt9yE8MXeKssYrsybAfJ5T3yH0JeKJfdGqn8eE7R90u3OWK/Uho2X/G/jdTA2z5APvtm4+pqP92o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=umJRLQwD; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYqMqOzUZPsVwPfBY42R3qjKEA/9dF5KDOIqCWocbVWmt8t2yPZRC/AXgiVoDITv+6Wd9QsgsBcpsi77aghbrC+Zhv0gZOJZxoEKhs8HVdX8tyd3cHUDe+Zqg6C9kbot2C+PN/WMw7j4bIA56pUtBx8fdwjgsTl5Zre6jOSVNtsK4POhcL00Xhx276iImYT9B6OwZC+F/n9qlJsZBY6Ga0w6m2EFw8X5fC0pT0ogFeK4Vq5Vmns1Z3OSIO3Fwb3rdEWDxV1L+5fD8x6oFAECPEwvkQaq+MNi8Vt7cIdqoZ5NEzHqtQFd1CPiIt/uzwqwWQSxo5hCQiqFdiQNkY8s9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWm5GTrJSYRgoVGtg6jxqH+77YE90HqTL33/j8cuQcY=;
 b=PYQz7Bz7B/qaaq9STRW6zt/HoI7YPPFg5HUgsrmJICuBrn+tyhj/uK7hn6Cc8TJe4dshwwSPD310HBIeyLx8xSycrhptXRqnmzkq+1bM5RO/gWvhOTIvJKJd7MHT8F/xULK0hSH16COmtm5R6ZmR7Deax+2JvmaYaySAiasXl4It6+9L7Vi6nyac3SUr7GeLNaM9N8ayeBpHx4XCZ4a/2CJNWGLHA73VjCAF6z36eTIN1nsAIzkNqGCo9Tbqrei/0wDA8vKZn7S99hAbrcNsBvlNKFoi4pFHuxrbGjO5b/pewbwp8uTqzJLR6Q0SPxNi8kYCcoL10BHnTTHHXGWscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWm5GTrJSYRgoVGtg6jxqH+77YE90HqTL33/j8cuQcY=;
 b=umJRLQwDMd21ZqNR9a78w42JwWGIcVYvbkk+6d86a0Nm/WdV4fG3GJsgJkNhQ2FTmOb6BDa7Yz+oCRhUDGO3U5HJ6424d7fQ+1EywE0OmDyn1zMlCK+VxwDppSgoa07rz+fm0git6Sb4j22cn/2xsL34+VhSjjWYRo+umBLGlas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 04:10:15 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%6]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 04:10:15 +0000
Message-ID: <e2484cdf-2adc-49d3-8b5f-8c8ac3941b10@amd.com>
Date: Mon, 13 Jan 2025 09:40:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v4 1/8] KVM: SEV: Disable SEV-SNP
 on FW validation failure
To: Pratik Rajesh Sampat <prsampat@amd.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-2-pratikrajesh.sampat@amd.com>
 <9b7d7abd-ce7d-479c-89a3-7f305c0e732f@amd.com>
 <44f88f85-b74b-4426-8105-b942e9a854b8@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <44f88f85-b74b-4426-8105-b942e9a854b8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 50672454-d964-43c0-6a55-08dd33882eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZVb0ZjSWEzUmJEeTJXVUtvNWt6eDE0V0JUbUtQSTkyTDI4aGJMK3MzVjJn?=
 =?utf-8?B?V0Rvd293YXpMZ1FIcDZFaFZGK1Ayd3BoN25JWVNkd0tvMUl0ajgvWDlsdkM5?=
 =?utf-8?B?WXl5dm1OTnRrYWZwN21PQUtnV3c3YnowOURnYURXQnFxN0VvNElyaFVTVlJr?=
 =?utf-8?B?S1duaTRNbDA4WmJPNjgxRjFUSngwRnY2T1FzVzliVjZMMlk3YzRqVGV5VFFD?=
 =?utf-8?B?NjF5YVZQbDhqTVhLSjdjNEg2SWZabFFYZW0wS3dmZDQ3eWM1MXRMdUYvTy9z?=
 =?utf-8?B?SHgwaUdhNmY1ZERXc3crcFN4MW1vT0NzRjNDYU1vbitwYjBRMGphbjFLdnhq?=
 =?utf-8?B?VGx2cEo1NFo1OU5vQjh3K0plVHJtS25UUng3RnIxajFod21sbVhDaFd1QmIw?=
 =?utf-8?B?bml3SDZxVWlOTFJ5YmJQaHNVMVVyMEpxcjIxVzBLeXhhakc2Z2x0T3J1d0NP?=
 =?utf-8?B?cDdpSWplcXZ5V1ZGZlNTUW12ellIQ3pPaWxJOTNLTUhnVHNHcUkxcmFxbVhn?=
 =?utf-8?B?R1dYVGIxdTZQSzJNdWFicWZhd0tsQkZneTNPbnFudXBQcWQzQ0s0Tkd3Y0Ux?=
 =?utf-8?B?RWtMNERLYXRHOFVldUcvUkNSQUpCL2l1VGFVTzVQd002SUJYL205alU2U2Rs?=
 =?utf-8?B?V0dOYk9aSldKREl6R3FjMkFRRlkwd2VBUDlodS8wSmJlSkZjQ2xKeVZ4dDla?=
 =?utf-8?B?TDlmRUpOS083OWw5YURNUVhwZ2hLVUN6SUVxMExVbk9SemlkUlR4TnVSckwy?=
 =?utf-8?B?REM5T25MYnJKOWdyZUxPRVhOMjlqZWtqSUZZQzNwZG5iUVVoM2N5R0NIbFRj?=
 =?utf-8?B?OWxhTlk4VnFjb3V6MERLclhSNkhwa2ZqNTRaWHhjSFVDK0E1VUw2SFBPVC9T?=
 =?utf-8?B?THpnNldEWDdVaGlHSXRHUDh5V3pGVXlMckdxZnZSUE1yaHJ3ZXJaeWF5bHpn?=
 =?utf-8?B?cjFrQjRFY3A2NTZXSS9TQ0xVMkVVY0lnM1Z3WDc4UTgwNnNqbGlVSlJPcTNV?=
 =?utf-8?B?Um4xL1cyZitUaFJ5YWE1MnBaQVNSMXg3SDdGVkZ4V3dSeWl1VExMWEVMZzV2?=
 =?utf-8?B?T1QrbU5jME1XRG0vZWJnWURHbGZkcFZBZXBDQzAyL0RVUm8xSzVaSUlYdW1P?=
 =?utf-8?B?MSs5VnByYTA0U2IzdHBIVVM2TE1TUlk3REYwOXNvc1hQVDdTeGNYRWt3QVVU?=
 =?utf-8?B?R3U3ZGVZbi9zeGJGSjZTMGlJYWlxZkxxMlNJZnEzSjFEbkI0cEZDaDdDU3Rl?=
 =?utf-8?B?RWltVXlyZ09IN2MrTnFGTkpvbkNHR3FyQ2JieVJnWUFGSWxzeFpxMzRjdU9G?=
 =?utf-8?B?TkdYeVJmd01pSitSdW0xd3hNOTVRTVpXdHA5aGdEWnZJZVV2RHo2WGU1THpV?=
 =?utf-8?B?S1A3NU44NnE4dXkxaTBmV0VMcWFvdWtpenQrbjNCeHVuTk5DblN4c1l2UHhE?=
 =?utf-8?B?LzFHWUVBOGpkUVQ5REw2aXJabFBPZ1BXM09sR1BVUUlXaDlUa0c2VkEwL25a?=
 =?utf-8?B?cjd6Rnhwb2pqaVpGOXp1UitLeHlsNWJ0Z25ReHJZRjZDMDdyRlFaVFlMUmky?=
 =?utf-8?B?MGhpWTdnNmtsZUlicXdwN09QK0QxbDZGdm9VMWlEU1lsVEZOaXIvSVk2eUN2?=
 =?utf-8?B?SzRjR3liYU9jNEdHVmI3M1YrdjZzdCtKZzBVMU5zeGR3aEx1ZUl3cVkya2hG?=
 =?utf-8?B?V2k4alRPTDFYYnhMUkVyQjVGVThpSnFoL2tMOHZTWk1pTVgyUUFDN2E0M1VP?=
 =?utf-8?B?RjFJWEN4ZXZZTmp1c3V0RmxaV1VEZzFtSExiUXpoQUN5R290R0lmR044VEhj?=
 =?utf-8?B?RExKUW9pUDN1RjlEVzdZdjExUTNPdTU5a1BUZG1NaEl5OWM4bTB4cG5qRGVJ?=
 =?utf-8?Q?tp5xdt9gC77R5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THBiUmd4bEdwTU5DYWJWWmQ5a29lUkZDWGdPdnE4NWkxWmM4U1crNWZNaHpM?=
 =?utf-8?B?MGFsN0kzelBsczFlK0VxYzMzbUZwcDZ1bXhEWkNhUlZZYlJveXZ3MVVLNHVN?=
 =?utf-8?B?RXdDbm4xMDI1RTVWZlZWaXE4SkU4OUVjMjQwL1d1UktOcWRtQXZUSHFnQ3Zz?=
 =?utf-8?B?WStNU0hGLzdQVFVWKytGMnRLQmtldVBMMldheWJJeHdwTjV2TlNtSllUK1FP?=
 =?utf-8?B?UnFobWY2UndydjBBRXpsWUZyRXVGOGFNVDZIYXA1ZkZIbmRXNmZGNEdlVUxU?=
 =?utf-8?B?d3BMd2JQRlkwWHljV2QwZUhldldVM3MxOUNSOURGenhIVUZYdXh6SXN3WjFS?=
 =?utf-8?B?SmlUSzdsaXpXOTFjL2hxeUNXT2c4YWpOVURkUFNNZ1VKVVA2NldxWmtmVkRr?=
 =?utf-8?B?TWhkRW9YQ2g4SlJIbFVaT3JBR3kxOHhtUkZzbFJGcUcvQS91RTJyTGJtc2o1?=
 =?utf-8?B?a3JabHc5enhRU2hEQm5CT0JtaE9raSt6anVoL2h4TVhrcEN5REdURWI2TUJt?=
 =?utf-8?B?V2hVQXNSK091a2puN3NvcG0rNFg5a0pRbE1HQjdnZGltYjhOdll0V0RjVXkw?=
 =?utf-8?B?cWcxc2xyNWMwUm9FaVJqdGt1MjJkMW4xdng2Qm9SZmErOGdYa09udm82cWR4?=
 =?utf-8?B?eVBRUWoxWVdjZExDOWpmTEhQODNHeURWdFUzNUhjSzBoVVIyamx0enBQSEZw?=
 =?utf-8?B?THUrTDFGcWc2SFBkelhGSGM0QnMvODF4SUxJRzVpbkNkbEtJcHFiN21BaFBV?=
 =?utf-8?B?ditlaTNUWTFsSjZzYll6c2tDOGtYWWpwVHc2aEtScGkxUURjZUlsRXRrSWp2?=
 =?utf-8?B?bXBXd2d6a2tPSnhtZEFnV0lxNTBiendmbnlHRG9CQm1ZczJTUUdsY0UrTjRl?=
 =?utf-8?B?Um1mSHhpWTFIUzZ0WEtxVGlOS3hPUTBjVStEN3NiRitVSVMwUUR6M3ZPcXp4?=
 =?utf-8?B?VzJmOGFGTFk1ZTUrSmVZWmtUMndUWDhOR1U5Rmdjc2ZVLzVJVHNlZ3lhWnBr?=
 =?utf-8?B?OG9GaFh4SGRpWmVHOUdHc2tNeWZFdW8vdVkvRUVFR0tsSmowMXpwWkJ2dDJ6?=
 =?utf-8?B?d2dmQmNuWkZzQllHc08vMUdzMUZ6Q0pNZ1U4dlJGZjM5Rld6M1BvOHNLU0lV?=
 =?utf-8?B?WkRDODZqaGN1Vzc5MiszSFRUR2dzejZHWDBtK00zYzVlb3p2TFBoOUVuTlFw?=
 =?utf-8?B?NnE5OG9aNmk1ODZVdXRQcWpuV25Ib3dlMWRlTkgrVi96dXRwbGF6dGt4QUlw?=
 =?utf-8?B?c09WTlg2aUdBNnZDQlZ3YXVKeHBiT3Z3S2U0eDJrUE9ieUlBUFFrT3Ircm5K?=
 =?utf-8?B?enMxYzFnalF5ZnFwRVRIc2RGcFFLNkRlVENGbDhDQ25yNGNmRkIwVXE3VjRU?=
 =?utf-8?B?TnRidW9ESEtlbkUwWktMeXFXR0h0dTdsK1c1TkNXNks4bmRhcHo0aFlRcVVN?=
 =?utf-8?B?SElVc3JuVHBkNTdBdEhZRUhObi9VY1owNnptQTFjUXVRUTZCZ2FNMStIRnVG?=
 =?utf-8?B?MEczeStqNE96UFZiS3BXL2F1TWZ2VCtBQjRPOFhEVTlJTTlaWW5jd1lqZUpU?=
 =?utf-8?B?QlhVb3Eya0xPYUl4aWdDV3Y1UFhsOElWYjVHYkRKNmlybld6Qk1HdWxTZmU4?=
 =?utf-8?B?YUJHeG11OHQzVFp5aEUwUnFoa0VHWTZDdnNzVW1DQ1hKV1lSUmpwWWhaWnhh?=
 =?utf-8?B?SFFISEUrL3FJcElDNnNLUFM5RGhVck0xZmJ1aklyUXlnMWZTcWJIZlZXZWw5?=
 =?utf-8?B?TXZTVVpGSE9SbmxVSTlSUVJxbmNvdVZmaVJnT01IWHdoVlBPbHoxZ0Vwd2tu?=
 =?utf-8?B?Q0VCNS92M0xpKzFpRmp4VmF4dEFtUHFxSldMeGJ0Z1QwMUhYZ3Zvd0RYT3hJ?=
 =?utf-8?B?OCtLYmxDOXRldGxRc28wREFiMnZNVFdWZ05seVdpdjQxMTRpRnZRSVkrcDNj?=
 =?utf-8?B?ZVpIcWk5SzZIOVVNL081MUIwbisrUWpSRXpaRmZVRTZkL01ZOWZJM2x2dVBN?=
 =?utf-8?B?YVd0TmUrRFVyZU1aSnN2V2V0czV6eENPMGRuZHdsSkg2eUZlNFRSc2xJSmhr?=
 =?utf-8?B?ZzVaYUcrTlpNWnBqWm9XemtFMWlBUFAyTE5iVUZ5dHBlVGNIQTZ1QW9oRTg0?=
 =?utf-8?Q?6hqEzI7zSwMh3WSdiDTgYdSxb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50672454-d964-43c0-6a55-08dd33882eb8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 04:10:15.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9J5dgArmila3wu92f42cUBoJsfJ2enzsjQLD02EbeXoZ3l7WHeOgI1Ehx6k6DpRyeFbsBUCuxuphJ4iiz6m4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288



On 1/11/2025 3:20 AM, Pratik Rajesh Sampat wrote:
> Hi Nikunj,
> 
> On 1/9/25 11:21 PM, Nikunj A. Dadhania wrote:
>>
>>
>> On 11/15/2024 5:10 AM, Pratik R. Sampat wrote:
>>> On incompatible firmware versions, SEV-SNP support is pulled and the
>>> setup is not performed. However, the platform and subsequently the KVM
>>> capability may continue to advertize support for it. Disable support for
>>> SEV-SNP if the FW version validation fails.
>>
>> Additionally, can we ensure that if sev_platform_init() fails, we do not
>> indicate SNP support?
> 
> That sounds good to me. Although if the platform initialization fails,
> I think we should not be advertising SEV, SEV-ES as well.

Even better!

> 
> If that makes sense, we could do something similar to before by
> exporting another function from ccp that returns whether the platform
> is initialized. Then, within kvm's sev_hardware_setup(), we can check
> this to ensure that none of the capabilities are set if the platform
> initialization has failed?

Yes, that will ensure we do not advertise any of the SEV capabilities
if the ccp driver has failed loading the firmware or initializing the
platform.

Regards
Nikunj

