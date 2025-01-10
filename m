Return-Path: <linux-kselftest+bounces-24181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA04A08825
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 07:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F893AB8F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 06:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D089A2063FB;
	Fri, 10 Jan 2025 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZRHnIIoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E72063D9;
	Fri, 10 Jan 2025 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489244; cv=fail; b=CUSXCPwf7xR6tyg44kO5b75IU8r10zyza2bWXYdMc85jc+1ItFOvq/XjorlJNZAPfT8oP7fuNBJREruaPxkP8gLBrdTRiIXP6N8wUuLDWdfALUsgfq5cqXn0s9Bdg5diiGxmYyQqUsvob+hmg/PlHZaUqXZKYMoR4ItR0oSv5Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489244; c=relaxed/simple;
	bh=ONxJvjTcbKB2v0s7sOhcl1nLLtmejsLf2U5X9uy6Yj0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qpJY205M6R3OXhyaUFuHizdO6+BVtUVNnt5yMzhoHhpUPLnmVGkKW7EG/V9Em3i1rE/RAcPbD6PQ+vqRmXb/o4Oqww/Ho0T4Ks3f/0VCdp9p9tQGOBwdZPGam8tfpc+TgszlX7bKrfbG7pU9iYu3tmfr7o/1ZyGSzpolIZCpWeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZRHnIIoX; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQKmpQJsMVuEOD3Eoz22AZ+Z/1nfvrQobQ0tpEdIXTj0rsuK7m6RboUBxYlDmXW4+3g1e4Jg1QUqAbwvwcbgCuLekRk+SgIDK8gpIsg+4KEbq09V+8Fuw+4wHvlVjz8+sDSHaGHTbKXqX//gn25NETsuZamf1UuO4uiOoTif7RiYLNbqEdShoRcTUXYODRJk4w4Sus4YLmDimf+hWpDA+Xs8wA61hDwRuIQ6ayzEJT6Q6UN/fTfcxaGacuSimwN4kJUXO+vhieTkD4iYHdlIgpVZxi2Hqj/JYrdCx5bbvl8uETcIjPitgNmYphg+oHhtj/HDjshnTBCoQwDPRgD80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MbjNEovoMy5pnsrnRWhDO1XInWLAq8EQIu3Dvfnths=;
 b=fi9fsk9CvykSP2/wts6wGlehGrJTx8frOw9v1PNhxolkqsUx4ZbwbdIzVvfOQXcSdyJPfXfNF24Cueh4eQ8LRN3nn4TtPTlk/+3cQCWtxI8QCDF55gMKvKhoSEmnSPK5aIEdQArh7lSkuHHUzouK3Ee1/yRui4HlEG/GRkvDyYUJcLueFKH79lhCNtmQeChuZodLvx6JaCdJYLM0TJvP4gaW2CecShvtn2HwywB4AXC2tD1utHki2+FhtIJPUAqAHMCP8r1UBEwoFDJW5K6/mE0UhHD5IF0EQz2i7c0EZT818Scj/aqzMu1Kq86hDIRCW0C4vX05Cte9HSv0vUwj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MbjNEovoMy5pnsrnRWhDO1XInWLAq8EQIu3Dvfnths=;
 b=ZRHnIIoXxfg+bVY5kIue892RZaruoB7XQ9HtNsWfdOrR6yoNuXZRPhb/KpMzFJubyS5DndcfRkS5LwzdrXKA/xWCIrJiHerO7+FWySk3wfSAiK1e48B2MghYrON3KJA2fICrryTELJFol958DFwbLXh9rzfHItha+RzeuqQRQNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 06:07:20 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%6]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:07:20 +0000
Message-ID: <7b0b8f30-235a-413e-8b9b-439cc0bd03b3@amd.com>
Date: Fri, 10 Jan 2025 11:37:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v4 2/8] KVM: selftests: SEV-SNP
 test for KVM_SEV_INIT2
From: "Nikunj A. Dadhania" <nikunj@amd.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-3-pratikrajesh.sampat@amd.com>
 <bc5650c3-e759-42d7-b993-1af838fd6a80@amd.com>
Content-Language: en-US
In-Reply-To: <bc5650c3-e759-42d7-b993-1af838fd6a80@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 09006b06-e465-4acd-0039-08dd313d0af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHE1TFhSajM5NStGUHN2MytROXlVVjh0M0xHMUNxRUxWSEdkTGlzVGNIN2pF?=
 =?utf-8?B?Qlk4K1B2c1BTbG1pSnpZZzJteTcrYzZPcnZoYlYrYyt3WUhHdi8ydUdUTHIx?=
 =?utf-8?B?cUNPc0xVRGNLb0dDcEVGZ0hRVkR0eXpwYWpJSzNtSnFWZ3NaR0F0TkRZZmEv?=
 =?utf-8?B?Wno2UEdkRVN5czBaSEh3VmQ4YmVDcll5UUpackRZdzlwekhiRUVIbkJNZUJT?=
 =?utf-8?B?enJ5a2FoMitEYTdzUGs5SUNkQ2N4TmllOTJXUVR2eDNocFQxdm9KRytNd1p2?=
 =?utf-8?B?ZG9oSHZSNmZoV0ZVSnNldkQ3RHJUSG16SXEzQTEyL1VRNUZSWVVIWllWQ3Rl?=
 =?utf-8?B?TnN5ZlpQaVRzVkpQem9MMXAyRVFBZWh5UGdjVTVzVE12blJWS3R4ellVNFhU?=
 =?utf-8?B?Q3BPSWt3bmNEQWNPdHJBREJHTzIwTDNhZE9hNDNveDF5M0VwY2NBRGJZdG5U?=
 =?utf-8?B?N2txZkZsOTVlMEdiNUdOcFpzYVFzZ3YycUg4cDBIMTI2ZzlCenhEMWpDeERJ?=
 =?utf-8?B?aWdCVFgzaCtMaUcwU0NuYXVnTE9ockNYbnhaLzdKRzRVcHJmV1Z1R0Z2QWhO?=
 =?utf-8?B?ak5rc1Brc0FyZm9SWG1VMm9Db0NSeHNKK0VJOUptVDVkdWFSZVA3a3kzU2tG?=
 =?utf-8?B?eDRuSkFQaFVSdUFFUUhhNU5IMVJHNHhkZkFZaEFYZW5lc0l1T0h4SElSM0dP?=
 =?utf-8?B?aGxtaXkrVWZjajBTYTgvRHVEOTlUdjZlRUFJeTY5RU0wbDlIcktZaEdWc2c1?=
 =?utf-8?B?TmUxakZtZU1lUGwrMC9jMWErWndPNXliZi9icGFEVnFCNHBXMzhvNHpFU00w?=
 =?utf-8?B?SFZwK3FJR2d5d09KQzM2TmxlV1FYd2pTS0ZNSHFkOUhUQW5pZ0xaRGRUUnI1?=
 =?utf-8?B?VUdqcjVUNkxFK3VFT2VwZ1h3Q3kzWWo4WjUzYUdaU3plVmVzSEZuUkcweGc0?=
 =?utf-8?B?djdZTjR2aEpPTGgxdnNhTzlJRmRzcjNCdlU3Smdja1ZiS2poQzRtWC9nNkJV?=
 =?utf-8?B?dXdKc1oyWnJlck9hTzN1NWM0NjdvdEh6NkhCcE9KQjdPWHpxaGRBdm1vMlRM?=
 =?utf-8?B?RWcvWkxoajdVSVVUMTdoa2dKbS84SDJob012ZWk3b2Q0SGRtYURpNmY3L2JP?=
 =?utf-8?B?VTF4TWtRL0dmK3BuT0c0ZDA1d1dGeUx4aC9HWGJYTDBWbWtWdUR5bWRsamJC?=
 =?utf-8?B?bWpGRGdSaHBIVlFkVkZIa0s5VHJ5WlhTbDIvWFJDYkVJdmllejcxWm1keG1v?=
 =?utf-8?B?MkQzeCtrMXhOc1BGUUh1MG1BNnFuUm1hS1prVURPMUZMWWVSRHFiTUpkeFNr?=
 =?utf-8?B?TTQ5djR6ZHcyWWlxVHQvQjFFcThYU1UvdVhUOXMvcHFSd0k2bzdGT3EwUjB4?=
 =?utf-8?B?L3Z0ZldlK0JyZk9VUmtJZXdhUXF1MDEzbUc5RlZDdkxoY0I2cDVuTEpQZzR4?=
 =?utf-8?B?NzY4Q2VHNHNWb1RRUThhNGF2Y1VLNzdPSFhTamducVdpamJPWXFQV3dWYzB5?=
 =?utf-8?B?S3BhT0hsRW1Td0Ziay90S3BoOExQUTFpMzNIeHR2NVRGdVQvNWowWnVlZ1py?=
 =?utf-8?B?UkoxVkFNcmw1N1ZHbTJUdDRLY2lQUkx3RFVzZUhvbTBJZ1NiVFdSQmI3S2JK?=
 =?utf-8?B?bk94VmZOMUZFejc2UUZrYmtxNXVST0U5TGR5QVBIZjR5eTZnV0dTbUxxdVA0?=
 =?utf-8?B?SHVjamFFM2NSS2c2NUQrTFp0TVVnVzh2NjV4MXVvQXVBRy9FeVQwRW1KdUdK?=
 =?utf-8?B?UVc0NzdYVjdZMUJHS3FjNUhRWlVxRUc2MHlUMkJLMVlpR1dOaHlpODFQWkNz?=
 =?utf-8?B?aFJiaStERlNtcUlpelJhbVZuSWpsNEhSdjJ2ZDBIS0pQdWFld1BPc25nQTdU?=
 =?utf-8?Q?O6P9DCi4U8uDe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTEwa28ySmxvb0RvWHkwdFdscDM2U3FTRlBSdUxleGErWDh2cDVGNHNQV0NC?=
 =?utf-8?B?NEhrSVo4Ylo4dGZvT0NaZXE3WUd6WVNUQ1BVTjlhM2VubEh5WGtQeHhCZ0Vo?=
 =?utf-8?B?UXlXUTRJQ3NTREx0Y1B3ZUVOZ2MzK1RIOEFCdy81eVJtWDBtaGhKT2hlVE9M?=
 =?utf-8?B?OHNvdmRSSktzc2FjWVBDTHJHTGlmMjdXVUEzK1htc1lSVGMzV3NiYU8xdWU4?=
 =?utf-8?B?M1VSWTBWNDg0bmJtdDFpOG5LWVMrenBRaG5xLzFlOHlDbjQ1UVl4RlAvNjVH?=
 =?utf-8?B?aTJQV2ZNTzU4ZkRhN2tnYkQ4YWlLSG5nRk1VNzJXaEtKN2RNMk9Lczc3TzZv?=
 =?utf-8?B?UGh3N05yZkVMVHFTd05xZEZTMm14QThwWXZnVWx2VlY2VlNSdms2N3BFSTlE?=
 =?utf-8?B?b3dMZmI5bGdDdWhrQ1djalljZDhNQnZlNmpYN2VGVVZXZGN0WXlDMkVTWFBF?=
 =?utf-8?B?YVAxZTcwQndWVDBGRnhqdEE4eU9qNmpSQktzTFg1KzZaKzdXaVlKMmZ4Q0Jv?=
 =?utf-8?B?ZitjWmZrQkJqUUFOb2crWWNTWDh6M2VVYTV2OWZPQXVEUVJtRnlpeEp4NzVy?=
 =?utf-8?B?SDJzaGM4WkVNenMwWndLcFhoK0FZWnpDOUpOUGRiMldRQk00UkowVGpCUGth?=
 =?utf-8?B?aGxvcEJEeUwrL3VyNVUxa3pDcW5CUjhwblBVbUpiT2E3di9pdjlDdWpHeERF?=
 =?utf-8?B?TkpKZ1dzYWdxQ0tWVm9PT1JjR1Q4S1RUc2ZKTnVzRWNueTF3Ym16VkptaEFD?=
 =?utf-8?B?RjBnSVVndEhmenBtMmlmL0lHa3J1WmVlM09nT2lTTlZ4bXd4OW9Pa0FMZjIx?=
 =?utf-8?B?OFFzeEhiY1JCN0tRM1NOSUF0azFSWm84Z1hVS0xGcUR1QTA2VGExa2RTQWpn?=
 =?utf-8?B?andId3VYMklYOW5iYk5ZZnZvUkowaGRqTWtDRENITUkvYThqT3hHdGEyL3ky?=
 =?utf-8?B?N3djWWZtVHJ1eEhMQytHempnK2FtSkFZcndQR0lFc2RTS1VqUXYrNjlqbFYz?=
 =?utf-8?B?SEJiZHFGUExQUHUzOVBrYTZzd1VOazJ1TnVqSDhpdy9weXdqWmh1dnM3S2pC?=
 =?utf-8?B?endYVXNjbmRtNGx0TFZ1eW45QVJHai9nMHk0cGdTL21EWElKekRRSzJNWU1o?=
 =?utf-8?B?WEFsUmI3RERVOE1WVCthQ3RJOUpXUU9NV1dFTXZLelBYYmtIT0V3cml6dmpW?=
 =?utf-8?B?Rm5iVG4rZFcxSk8reXRQWlNCNTFSMmJxdWo4aUtIa0ZUYUFuZXdnTCtZYUdo?=
 =?utf-8?B?U2dYOVNVdUgrNTFCcmt2cXZYRHJxWitoZFNyWnZFcU1WTDQ0VHZ3RkRyNCtr?=
 =?utf-8?B?UFA0T0FBQnhiK205c0dQL2dQczVnQWF2b0dnSkx0NEcvL0RQbnJPOWx1anFw?=
 =?utf-8?B?UTN0UE90ZTZoTWpjc3l2V0UyYjRCKzNDS2NtSm5IdURqQURvRmRqY3lYNEhY?=
 =?utf-8?B?NHhFQVJhcFNWbmZ3aDNQRWoxbFhSMFdvWjBJMloydlB2S1NQSGZscDlnOTUw?=
 =?utf-8?B?d1JzZ3dQMzBoMTJ3Tk5QZS84eHJoc0RIakZZTWdJeUNvSG5QQVAxR3oyazBu?=
 =?utf-8?B?YVVXVS9mRWhPVWRETnpBQzY1ei9EU05OeVpqNG9VSjJWcFNRNXZuSjgwSFFL?=
 =?utf-8?B?V1kwMHpNTFNnYllTUXM2M09QbmM0Nkd2bU5tOFgxYzI5akM3YXc1dnFzak82?=
 =?utf-8?B?WU1iSTBVclNOQ051N1ZadjBJak9YaFVOSGpDY1h6K3pYVkxFbnlnODhIbG1G?=
 =?utf-8?B?SkgvNG9GVEpITUFBWUFkZzF0NVl2bGI5RHBqOWQzaks2RkxiYWZQSTZkdUdR?=
 =?utf-8?B?dWNZemJQYWpFKzZ1MzYrb2w3TzFOcjlkSDFqVkVUZU5selZQY1hIaUdtWmR4?=
 =?utf-8?B?a1NZL3UwRmhUdVV6MGh3VE10MmpvZ1dwNzFHc0FEcUpZdG9qcHp0L0YwczFQ?=
 =?utf-8?B?SW5OY0lJZktEa1Jwd2tZR3VBRnpiemFtMk5hdjZ2ZFVqZGRLM3hVMVNPQkNv?=
 =?utf-8?B?UUVEQ0pudHg0R3AydXg2anhIdG9QNnI1OTBTVldrd01qQU5NaTQxamdCVXJh?=
 =?utf-8?B?cXZGTlRjYmVWOEtlUkU1eURNS3Vha21yNU1taXVPYU5yNGY0MW5PbnlMZ2Q2?=
 =?utf-8?Q?HkHVxRnbh51K7+olmkTh7JZxw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09006b06-e465-4acd-0039-08dd313d0af8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:07:20.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48rXLmL3HVRb+luyK+GnaCFCfJFR+BkfafdPsbjxddTRURfW5hMNkbnRJYObZGQxWwdOsA4D2X/RaOVAh9m/ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748



On 1/10/2025 11:22 AM, Nikunj A. Dadhania wrote:
> 
> 
> On 11/15/2024 5:10 AM, Pratik R. Sampat wrote:
>> Add the X86_FEATURE_SNP CPU feature to the architectural definition for
>> the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that the
>> SNP test is skipped in scenarios where CPUID supports it but KVM does
>> not, so that a failure is not reported in such cases.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  .../selftests/kvm/include/x86_64/processor.h        |  1 +
>>  .../testing/selftests/kvm/x86_64/sev_init2_tests.c  | 13 +++++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> index 645200e95f89..c18d2405798f 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> @@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
>>  #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
>>  #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
> 
> Unrelated to your patch, X86_FEATURE_SEV does not match the KVM API definitions,
> 1 is used for KVM_X86_SW_PROTECTED_VM 

Scratch that, I got confused between the KVM API definition and CPUID naming.

Regards
Nikunj


