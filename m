Return-Path: <linux-kselftest+bounces-31391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3714A9888C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC76189AB2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7C26FA6F;
	Wed, 23 Apr 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dbTE2j2z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44926E165;
	Wed, 23 Apr 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407615; cv=fail; b=I6jxg3tIAVqIOVHVr1JD6Fxt1UwOCxJ7jp89uBtsmEo6Ofb8tGZkgTVELnH325j2gCQl2eQhXFx12/7rX76qALVc4C2DUx6pLSRhej+OyeEyx+F/tAFpJob5DanqIMCQi4npmwVSJSjs0uqoJ5WOIRCI09jvOUdy4+IBwzZrCV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407615; c=relaxed/simple;
	bh=dY7wVzZ4Gu7f0He9qQajteXERp3jo+P3TBf8L9fy54U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hGzpXwVpC49UiQVGiZaznzgo1QALt4n8Zl+GpWv5iH6du7iWJxCRs04Z7tPydjYg9InelCUjhkYhY41+uW5Pltymwy8wI0F/q5wQ7PwqXuxOm0wWXqP6RaYg6jd28Pp3A4Wy3iUnxGbiR4mnQCSBLRyfdS7C0XNKHIny0L+ZRcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dbTE2j2z; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6C1TnrmLXluTuxGc1K2hwgzgoetd7AdyyH9VZwsSDTFjgro0Z3TLsStszcnJL8Y2OASMqTEC9Wr0cTmCcEA2yaIy/vpZscOsv2IsO7oTQnS2Vt/h5X8fWOL9kRIyp7dVuUPZdfuA8cLubUI5wDBl+Eyb9xhH76kI8PBXa55G/HBebOdEdyQtyVIrKTdN+W8YpncON3EX9TfpiZlWL2/8VZVngCXP1h8YyZLxWGKsljBLdKDT94e0+7t0HGh9ZCB/XdZoyANG520wenOfuFyzfYr8AGwLmXZtLS4SGqYb4H4OxWXiHt46/3vecl5+BEwW5LWFEu+QWVBgUttD5/rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylAHOxsOA4L07Vt66jESqPRO2fUlwHqG7wZ+/D53E5s=;
 b=wTQ+uipK+elYBGkIbLmJfRwVld3c4WLKETkb5wre2bj6NRx0f/9PehX9o/qs7B7+l4m63lfmpjMXY1pIqnJpTQF2jDHngPsPk9pOuMHDv9ELYri8rjyx59M7wyBVhYfsdSdz0yWbGOVG8EwsCWzbaESEvwNoyQTWyzAfBhXtboqnVF44i6V0I1g75pk8/4erYUWjTcKkBV9BRf/RputqfrzhQe68vehY58YOHiMt4BFCsfFghKJRU5nB8CxY/x6LJTCK3rVPeeIJuA2ejLm0SuwbdKB0DCawKbTotPErWbxYREKxXeB5RxA7FfvkSloO/8Pe8BvMbYNBvHudilLuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylAHOxsOA4L07Vt66jESqPRO2fUlwHqG7wZ+/D53E5s=;
 b=dbTE2j2z4gSJidTg/tDHl3JrBkHT6mxFpW0EOb+w+4fgCBYW9RbBLfxsjX/gLHGTWaKmSR/5x8JQjOSzo1jWM3mEuYT/uDcJ9e2oScVC2iSYQQOx6cY+RJexRkbMrgywM5HrhQHsCARmy+evUi+owba2IvTQF9ThxqMNo7yxH0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Wed, 23 Apr 2025 11:26:50 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 11:26:50 +0000
Message-ID: <69f2fd4c-cf1f-4618-a763-7b21050675a4@amd.com>
Date: Wed, 23 Apr 2025 16:56:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] KVM: SVM: Add support for
 KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
To: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, nikunj@amd.com,
 thomas.lendacky@amd.com, bp@alien8.de
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-5-manali.shukla@amd.com>
 <5fb4f5f8-55d2-44a7-808e-76c8a452cd2f@intel.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <5fb4f5f8-55d2-44a7-808e-76c8a452cd2f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::9) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5c3ff-39d6-4fdd-dccf-08dd8259bd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VaUlE0cFJvWGZIU3g2Z0VlMVVDQnVyczFrTzVaazZ0WURpRXBaL3NHWkNP?=
 =?utf-8?B?eDV5V3RVZlZMZkJab3pFbjhBUEdzS2UvdVMxK1VJdUlHOTFtV1RGV083RTlJ?=
 =?utf-8?B?S0ZTYlFFZkY4NVdnZ2lPK3dVRnRab3F5TmpCRy9wem9rVU9BajZFV2VFcjNB?=
 =?utf-8?B?aDZrYzJIL2ozZjRKZ3FKNFo5ZE5Ra3RIS0I0NlMvelk0d2tSWHBVQnB3U0R4?=
 =?utf-8?B?SXZFM1NtRW5FbkpmNHdML0pNbm43KzRVV3NzUUhaMEx4cnNIaVlpZCtrVW9j?=
 =?utf-8?B?RzBGdS9mcWJEVFhmZkcvV3dxSFJhN21UNjhyVVBTY2NtQ3FvOUkzM1gxZEdG?=
 =?utf-8?B?b2kwd2ZhSC96N285MWNJMTQ1eXYyWEVVbVd6Z2pBWm5rd3Jpd0xRVmI3OVNF?=
 =?utf-8?B?SWdnRlAxS1pjQnNvbXVrMURMMFl0cDRJbjVBaVdKUnBQWGE5RXRsQXdVWjNh?=
 =?utf-8?B?aHJKcW93UmN3MUVTSkFlcDJoSUlKdWZWSFZibkN1cEVvOVMrS0tBbDVRY2ta?=
 =?utf-8?B?L0ZvNm9BaGlkMXpXWnlGQW9mOW9mNUgrZkdVVVVWQ25xbEZhb3lsRjdnZjZz?=
 =?utf-8?B?Z3VLaTVsdWltNmRlc2JsRWt0eG45bTQ3Y29nTEp1dDhFS0JVK2k3N0hiYXNQ?=
 =?utf-8?B?NlFUTGtkalF5WUxNYzNJRnJRZFVrdnZPNEV3UGVxNjIyWFhLT05uTldaSk03?=
 =?utf-8?B?UTZBbEtoc01yTkJKbDBIN1pIYUdGQmpwYXlFL2E5SHJ2dXQwMGR5M1RFSHVH?=
 =?utf-8?B?K3NBTWo4YUtFbnpQaHZ4b0ZWdDdJVXdnWWNURi9ZbGx1T2ljRWpzQ1ZmR0R4?=
 =?utf-8?B?YmpBem9RODJ4R1RDTWVERXAvSnlBczNmOHozWlY4TzBuRk8vMkVFOFllUVdt?=
 =?utf-8?B?QUxSaWw2akV6akRmd0V3ZWNyTTAyUEV6OS80eEt6aGg0OUZrbjlwSmovT2NF?=
 =?utf-8?B?alNjY256SnVnK3BNQlh5c2psWklNOXkycEludVdzSUtVME5zUGxZWUdQWTc4?=
 =?utf-8?B?c1owaVNzNzEwT1hpc25OYnpOcGVEM2FBWFF5aHpRYlZjazB5dE5iRkFhUTd3?=
 =?utf-8?B?L2hpT1pTVFp1TWdiZzNxZ1VQUDY2emwvQXp3WHdxSENvRkx4akJZbGlhbXky?=
 =?utf-8?B?U2tKeDZmZ1grUm5pdUpMelFQck5tQm5aaytiWnFxcUJqN3pnUjhtL1dKREpq?=
 =?utf-8?B?QitoZzU4bnV6UzQrTGhLRFRRY3pRcmtOK2lUeGFFNFVIb1FzSy9oWFZUQTln?=
 =?utf-8?B?aldVZmNGUmpGVG02NHk1Q21FdkdvSDJHOHVBOTdRNTFEdGJZYlgreEN5aTBU?=
 =?utf-8?B?MFVVTlpsWjB4dmFNV1ZLN01TUGFnenNBdy9YTGZLZXR2ditUZi9SN09GeE45?=
 =?utf-8?B?elpHbjkxQlVhSnNwcjYxdGpwa3BNYWtmdDBFdUtnTCtCN0l4LzNvbHlnSnox?=
 =?utf-8?B?V1hrTndBRmdZcWVORDRBK0poTklTMFhyRHhzTDhUZFhBZ0Z4cGpPUndhZzRw?=
 =?utf-8?B?Wm1BeVNRMEJYN3N6Vlo5V3ZtSndZajh4TElNcGpIMll0YzczNG43ejQ4ZTJK?=
 =?utf-8?B?akp1dmJSTmNHYXVHWEdaZzdadUU0dWEySHM4SDRsOHl1djJQd09reE5uaGV5?=
 =?utf-8?B?Rk9MZUtwY0NtNDZmMnpLVDNhblhSUXpOSmNzM2lhUXA2WHV0M0FQZ3gxZWVx?=
 =?utf-8?B?MEdnRm5qd0NGSTBrYkNsUVJlWUsrQmhtQUo2UVZSRVhVNmdpeWZLYlFTVWJ0?=
 =?utf-8?B?dFpidUk2eWh1M0FUWWpUTXFCeW13TXFFUFp3UHZGV29JVi9YZHdlMjIyajl0?=
 =?utf-8?B?SE9FVnVTRVpPbTBld0ZLWTdnRHNFeG5qTzJlck5OL0VlajduZzlMSlFPYWFJ?=
 =?utf-8?B?ZWw0QkNxOUVKTnEvZjF4NDkrNlVlMGpMaWJocjZGaWdXWFZmT1B2TTVSd1ha?=
 =?utf-8?Q?mmQdNsE5XTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlhORmJicVhWYWhQbU8xSTMvYnppNTB1WVZiNGNSYllOZWlrQS9oK3o4eHAw?=
 =?utf-8?B?c0t1amJIL3ExMHBpNHhKNTUxSzVBTzhWY3NrWlRHdG02c2c2SWpFRm85RytB?=
 =?utf-8?B?NTJHVGN6OXA2MkJCMTFxb2x3ZCs3UGxWRVhneFpnTTd1Z3hzUEZ4VEt6RFo1?=
 =?utf-8?B?RGpqOGl1aGorY2R5REdxVFVCTjRpQjdLYXRTWmZ2OHZBSTNUZmFpNTdPQ2V0?=
 =?utf-8?B?Vjh4RTdHUDYxR2dwTjhaQVQ3MW5hVWNWYjNWNHZ6ZVB0RU9KTEgxNEtra1hZ?=
 =?utf-8?B?VHNYeWw3OHJvOXNTU3hzNSs0cHZtOU1RUjFKdnBtVCt6MVFZN3NFaDNqcWo1?=
 =?utf-8?B?UnJkanR4VVY0NWh2WlhQMWg1dFNRanZPTVRuWDFxSk4zcEd5c2RTL0pwQXNY?=
 =?utf-8?B?WUtDREZjQ0ZISm5CSEpGOUxQTWN5TDhFallCMk1jOThMckNVMzdnbklnTVB4?=
 =?utf-8?B?S25qM1BWNEl6SWRhc0dwQ1o4dlJHZHZDZE9CVVc3RS92VVExd0NDUVhEdjBD?=
 =?utf-8?B?bU9GNkd5djQ0MUxYMmh3REVJWFJQM2FBMWYxQ1kvSlA4ZGY5MFFGK0dmaktR?=
 =?utf-8?B?aWxUSnJhaFIyU0tXd01WVGpVaEZFMGdtZG9LaWpRYko2RlJSODVUQ0s2Z2da?=
 =?utf-8?B?c2lKdGpWZmhkNUxBcWMxM29rcXEvakY5dGNMV1ZocGkyM09iVWhwZStQRzF0?=
 =?utf-8?B?SDJYcW5vNjdRUURBUDVOcHdtVERKd2NJUGViNnFndEMxTE8wSnpSWm14Q3F5?=
 =?utf-8?B?WlpHRlVmcFl6WVU0NmE5aTZtaFBFQlRiS0JqbEJzR0VyVmg0Q0lXVWRZN01O?=
 =?utf-8?B?RXYzTTVxM0pXZmxzRkx2R2w4SkRDL3FwbVIxYzJSa2JJTGJDa1lkZXN6TVli?=
 =?utf-8?B?SWNyM3lrTUt0U3I0MTU5WmUvbnI3dUVKM1dGb2haQjhFblVLUkJrNkl1Z2J1?=
 =?utf-8?B?Z0ZHZWpHbkh4WXA1YkJyNTV2UWk5Y1B4b0t0MmNsZ2xWQXFGcjRIZjNobC9E?=
 =?utf-8?B?WmlHYTEvUFJkU1JPV0UrK0RaVmF4OHZCVjdNNHJoN0ErNHFWRXRha04rR3Vm?=
 =?utf-8?B?NDdWVnFuM2lnblQrejVSMG1jWnA1a001WmxqTGFCREROb2hOZVZmak5OWk5i?=
 =?utf-8?B?WkJxQ0tQTmNRQ1RTbzUxbjJFczdFY05pYzJuSVR1alNnZ2FyVDBDa05Pc0hN?=
 =?utf-8?B?ZHlvRGFqRjIxekQxYmJsbHRPODJYVEszNi9vcFdzU3FIZU1ueUtwOHRPUjV4?=
 =?utf-8?B?c2NKNHJGM0d6NVR6TFVKZFExTWtjUytBQUx2aXdUMHFCR0JBc3RBd3lJK3Rh?=
 =?utf-8?B?QkFodnJ1a2d1WVE1elVGcjQ0d1NNRDg0N29SZldUYjZTVW9pOUZMZDMxZk1Q?=
 =?utf-8?B?VCtuS2dyRWdMVU5vYlhRNTg5Zi80S0R4Z0RJUjU0bzlzcXAvWnRtUEFWQ0Ra?=
 =?utf-8?B?NjhTMk9KdlhLV1VqWmlNWmRnS0t0OGlOdjBKT09jY3cwMVJVamMrYms4OXJk?=
 =?utf-8?B?aGkzY2orZ0U0TUp5SkJtRkIzS2psWFVjN05SY2htYTZYK09ENlRWdGllNTRR?=
 =?utf-8?B?YjYwRkJMZFlEbVpxYzBFY0w5bXpPWDIzSDRYKzYwMG05bDVrY2I5anFPQnlo?=
 =?utf-8?B?TlRwNHVnYXV3SXpvNkVWZCtlZC94YmJTcU5DWmVRK29UTEJlR3EvQ1lBOTBX?=
 =?utf-8?B?SGNYM01lSlc2QmVGY0RtS3ZZYnFUZXFpOFRtb2dFUFRQeFJWbVlSSmpWd2xH?=
 =?utf-8?B?dWtOOW9KNHVjUnJvalNIeFJhNk9RQkNyZFNua3VyZjRaUXVqNFJ5OWJuQWFn?=
 =?utf-8?B?bjlaWG1uNk4ydmN5L3QzWnBlN3BKWG5YLy9OQjJzMHhWUjU4TVlBNG1kdENv?=
 =?utf-8?B?dmRBOWxCMm1DK3V4blp5MGt1b1prejArN0MxWnp1SFk1clExZTBZN0tHN3BY?=
 =?utf-8?B?NmM3S2hKbXJEa2ZLMHNGZFhpK3NRZWNNdncwZTNjalZyK3ZiUnB1Z3JrVWZz?=
 =?utf-8?B?U2ZCbU1icjNIKzhjNFlDNTdHQnFOcm1yUkh5bHNMNmlKQ2JiK25kMlExYkZC?=
 =?utf-8?B?VjRaVTFFUEp2aFhtSDZqVk9wTDdtY1ZtbXV1dU14YS9WekhPUXVTRWJXNjV3?=
 =?utf-8?Q?lpeHdZdy2k+NTQf7adftHGtwQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5c3ff-39d6-4fdd-dccf-08dd8259bd91
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 11:26:50.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOQlG6X7zp04FFII/z9WJfH18dDUrTE2TUbPrzgMFeYt9mozaSxVuMKZqlwhffYPGA/knNc2sw9x12zLrl7MHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

Hi Xiaoyao,

Thanks for reviewing my patches.

On 4/16/2025 11:44 AM, Xiaoyao Li wrote:
> On 3/24/2025 9:02 PM, Manali Shukla wrote:
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 5fe84f2427b5..f7c925aa0c4f 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -7909,6 +7909,25 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
>>   KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
>>   to KVM_EXIT_X86_BUS_LOCK.
>>   +Note! KVM_CAP_X86_BUS_LOCK_EXIT on AMD CPUs with the Bus Lock Threshold is close
>> +enough  to INTEL's Bus Lock Detection VM-Exit to allow using
>> +KVM_CAP_X86_BUS_LOCK_EXIT for AMD CPUs.
>> +
>> +The biggest difference between the two features is that Threshold (AMD CPUs) is
>> +fault-like i.e. the bus lock exit to user space occurs with RIP pointing at the
>> +offending instruction, whereas Detection (Intel CPUs) is trap-like i.e. the bus
>> +lock exit to user space occurs with RIP pointing at the instruction right after
>> +the guilty one.
>>
> 
> 
>> +The bus lock threshold on AMD CPUs provides a per-VMCB counter which is
>> +decremented every time a bus lock occurs, and a VM-Exit is triggered if and only
>> +if the bus lock counter is '0'.
>> +
>> +To provide Detection-like semantics for AMD CPUs, the bus lock counter has been
>> +initialized to '0', i.e. exit on every bus lock, and when re-executing the
>> +guilty instruction, the bus lock counter has been set to '1' to effectively step
>> +past the instruction.
> 
> From the perspective of API, I don't think the last two paragraphs matter much to userspace.
> 
> It should describe what userspace can/should do. E.g., when exit to userspace due to bus lock on AMD platform, the RIP points at the instruction which causes the bus lock. Userspace can advance the RIP itself before re-enter the guest to make progress. If userspace doesn't change the RIP, KVM internal can handle it by making the re-execution of the instruction doesn't trigger bus lock VM exit to allow progress.

Sure.

-Manali


