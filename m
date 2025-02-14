Return-Path: <linux-kselftest+bounces-26677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC4A3657D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 19:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CD2173736
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB3269821;
	Fri, 14 Feb 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lnD6vtlj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153F2690ED;
	Fri, 14 Feb 2025 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556560; cv=fail; b=R2NRw69qizLep1n0+ozhMBNFL/73JbUh1nNQJ/h6szEVewp3t8mA5M3jNXp2KVvMsaBdvFM5lMG8A8v0yT+E//Dn1qMdm98uO5fEMdBV8Qxxlg3myonWKXMBz4rwtjgf6cw1+DqXM+iXOpbNsDuZ4cffTIomzgOW54ndeQCPxFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556560; c=relaxed/simple;
	bh=hYqaj7gllMDjt+fmDBA7DAiXiIMg0ZHRNtwcZq2yae8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LeaOpMXDVZkNVPl+rell5DdIcf+d/zb0K+pep3nR87wmmJbV0HY4h8Blukf9A0b6UUj1VJrlsifpYQ8Nfls2stF1GUvkqkH/rSM36NDs2gXQUI1VKQ9Lpnny8xzPJfW/a++WxBpZQ3+/RoBhgCfkI5tGWWCw2hrsAPunAdcxj/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lnD6vtlj; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylrMPhNKtfKKGc0QyYa8QShHm0bcgYcrnTkF2eF7twE6VOD77ou2+iKtlNR5HL1GEpk4A3LAn2ErYgkhZcJu+RjQIkr/ND0fpliwVoH89/BbrKYXh0ZnDlSyE8vwJJcsI1Uw/c3pK8Zr2akV2+oInUjuT3lf/1tPbGAzuTJUmUKVUa8Ix00qOTZ0IMN2K4CN0i/Xwq13gm8XnnC8kWv4CXr+9MUEWwlUmVnNiFpss7C6lf6NDy97K34cJimhCkVTardwekWcbuCmigASPdfLnzQedoj9/Q81weD2XipCnD81i2iBHpmbjR4Wy+bmWK/gIhFIlI1Dq+Kk7H8blVY1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAP9hkVo8GPi4hQuN2LCeUt8iJYcvGFKXnI5MkXYHB8=;
 b=N/zQilimhsWjFLrzIsrsbb20lv3tAZroKFFZ2diL5LDTb1X/ULm0Bl7Gl6R289T5PL2o1J+0dtl4krpsiO8nXRukcuid7CLc85vsma5yVBnrfPnK/yG761N6w5e05NsGgSAiHdNIYwcTXPuhgOEg25ihD/D7ODIOZNWHKVpX4JR+Bc+tdpciEEjbDNfQmMB8itQNYM9i3PSnYRXn/0twqasyrmoUYW7Ijl0xQxDVgUheb7VQIbJETqhNgyawHx8muUYBJsFDYEo0LDJXWhEcx48pd3tdvu5PrMw7dDGYDPyRRBH7g7UYLbmrFighp/bAjorZgaN+5uM3qszB5HoRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAP9hkVo8GPi4hQuN2LCeUt8iJYcvGFKXnI5MkXYHB8=;
 b=lnD6vtljbZwZS1QORezGyL84AsPhGe6ffQyRJAMAw2yU/t8ISIlP265GzfXLr4WcMCDpbb0JMJsnH3M88GYh1BsVhY3Snedf2bzXoVi06NhfccvWwXzwU/pvJWVhemrS7IJgFaGt9IIuhRDOsrQRgKJhHPZY//tUNdb2eyYjTMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 18:09:15 +0000
Received: from PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f]) by PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 18:09:15 +0000
Message-ID: <0b99e313-cf5a-46ef-b82c-a813eeb31f4d@amd.com>
Date: Fri, 14 Feb 2025 12:09:13 -0600
User-Agent: Mozilla Thunderbird
From: Pratik Rajesh Sampat <prsampat@amd.com>
Subject: Re: [PATCH v6 2/9] KVM: SEV: Disable SEV on platform init failure
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250203223205.36121-1-prsampat@amd.com>
 <20250203223205.36121-3-prsampat@amd.com> <Z6wANGkZb7_HK8ay@google.com>
Content-Language: en-US
In-Reply-To: <Z6wANGkZb7_HK8ay@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0089.namprd12.prod.outlook.com
 (2603:10b6:802:21::24) To PH0PR12MB7093.namprd12.prod.outlook.com
 (2603:10b6:510:21d::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7093:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: d9afdd26-f956-4b99-9f48-08dd4d22b131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R05uS1RvWDcvYlpZQVI0dVJtQ0dOU3JxblpEaGRUS2o4a1JIRCtJVk93R2xO?=
 =?utf-8?B?TmZPVXloQ2lLM2xySVdFd2Q0bnVGRi80RVRadzlNWUUweDR2eHpacGNwNURt?=
 =?utf-8?B?Y05KL1RPQkZubzdZQjhZOE4rbjA2bjhPU0kweW9MbVdRWnM1Y1JnNGMvU00w?=
 =?utf-8?B?WVNiM1JhRjNEQXRmRWxGM1RaMldKUkpTUmNtNUYyVVB2RmlTdllhS25sQkNO?=
 =?utf-8?B?amw4SVVETlVpdG1tYWlHbjhqMzZIcWJhYnFKOVdvTUJMTC9jclZPYi9JQUxj?=
 =?utf-8?B?WmdxUkFWNXRVUTMxaWg2MUR5YlNGKzlVQ0x6UVBhTktNK05SY3lxaGNOSktS?=
 =?utf-8?B?RTd6MzVQb3NQelpDRFJjSlJ5aW9KR1ZnMGdZKzhOR0xCdmR3ZFU5NjU3K3RG?=
 =?utf-8?B?S2t6MHl3dkhWaG44NVVYU0hCM0lUWkk2QlNoaE56VnBXMUkzdWQwS08vd3BL?=
 =?utf-8?B?RHJOQ3lHYVB3Y2p3Uk12Z05FTXhNbmQvci90YzJ1L2RhQ2tpeStyQ2xsYld4?=
 =?utf-8?B?ZFJrY1lQQS9paElyZXgzeWtjZHBKeDJkd1hHeEtKNW5HZkE5a0pCczZ4VTgv?=
 =?utf-8?B?bG5WUXNYZ09HTE1BUlhXdWc1anNMU1pOV2RoK3FFK1JpM3QwUXByOWNwSzBm?=
 =?utf-8?B?YnUycE05dnMzcGYrcDJ4WUFBaUlPTlUyT25BNUJYbkNUUTgxT0tzNGxPK1Fv?=
 =?utf-8?B?TFZZbVg4NGE1UzdjVjQ5SUQwZWdYV08rem96dUJyWmJ4K2t1QVpGMks5dnhZ?=
 =?utf-8?B?b2xzeVJ2MGhjNk94R1o3YlBQRmUwaSs5MWRNMmZkKzliOEpIaTZRTkdvNkox?=
 =?utf-8?B?b21ZWk5xeS9VZjBaTm1CK3Jrd3ljNEpzcmY1V0I0REU5WElON29QdENoVFNp?=
 =?utf-8?B?VEJjbzM5dytxTk0yc2VKK0NtaFFMaCt6RFpNTjVXZCtSVndWM0doSis3WUpO?=
 =?utf-8?B?dnBocno0TzJFMk5hWE11b1RiSFo5S0NpSm9abkFJRGgycU5WMUFNZVIvbTM1?=
 =?utf-8?B?b3d4UnFRSzdvQ2xpTkZOYUgrRnkzQ2ZEMS9TNkZSamJxMy8wSExSUzBTaFF2?=
 =?utf-8?B?Q21FZFZMeU1nNWloNmZlaUF2ckNCYWhvc1hWMVJuaHVMY0l4cFVCZWJGQzlX?=
 =?utf-8?B?eU9hR3E5bkM4KzZUdDkyS3RaNlUxNEZQRWxmdjdKR2dwYWh4dVFpSW1hclJz?=
 =?utf-8?B?ZmFZK3lWaU1aRFFTaWtCTEJpdFZrWUNxRTU2bFFYemN2TlRMOVYwbFhkeGJw?=
 =?utf-8?B?K0FFbFZ2elgraUNMNmhXNFE1THh0cThQVTBiK09Gd2ZHb3A3QzdCbjRIZnhJ?=
 =?utf-8?B?U2ZVSzEweExPTnQrSGdOWFhNd1FPUmViZnZDYnhkUXFBaWVuVjRJdlJ3a25x?=
 =?utf-8?B?V2tydXFzRVdQNmp1L0xwd2t5UjlJUDMrdVZqYnp4QXp4dmlyeW9adG85R2JZ?=
 =?utf-8?B?MC82Y3RBaElEeUxKdjNwalN6dzA3bUxBZW80OVVtWTJyM0tFVnhVZkhUTTRK?=
 =?utf-8?B?ZUhPRVg5eUNIUWdPelJXOE5pTDNjeURNTXR3U25KRXJBMTd1YmtUTXcvckFp?=
 =?utf-8?B?cm5Zd3FQYmtuYlkxcmt5d2JnYlEwKzBlYVVhdDlxRWtVUURocHF6bjhsUXdN?=
 =?utf-8?B?SlBFRk8yb0QvTEFCMHN2YTB6SVQ2MVdlRnY0Ym1HMm9xNG1YaXlEY0ZNdncy?=
 =?utf-8?B?VFdVdWpVd25rYVZYcXYwa1dxREU2dFpWOVZvcEpEaUZzMDdRUnVXaTBpeStI?=
 =?utf-8?B?T29FRDhndmR6NWVXYXpSQUQ4d2JURWw2QjFyQzNBZDBVTXdYdnNYR3grbWFu?=
 =?utf-8?B?NDU2bmxWd1lQeGZaT2twUkNxTEwwams1OUR5a3dlRitjUHBabVZsaDhEVkZN?=
 =?utf-8?B?MllYSVBSQ1VraloxOURvVHkvVTVIaDZlNE9vOExUM1M3OUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7093.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFHMzhPRFVjWWNYeEJOTWdtRzl5SGpaQ0JVOEZub05NZjFNRWlSa2FRZ0Vn?=
 =?utf-8?B?VFczTWt4ZERRT3Ftc2xqeE9Xd0d6SHh3SzA5c2krTVZRd1EwcGZqb3g4Yk1S?=
 =?utf-8?B?VjRmQXJYUDlwUGtwcGY1MFVLZE1CZXVKcDBFb01iUXVQQjQxVSt3Rkp3ZDdU?=
 =?utf-8?B?L2Zsbi90SURrbHN0S2hFWGU3Nm5nWWFlQVFLU3ZiOFJNSW1MYnBoTHBKR3dH?=
 =?utf-8?B?V0pmbkNSU292Y3A4UFp6SFBIY2FUMXJqcGxPOFRaMU4vSlNjWm5OQ3pjbDY5?=
 =?utf-8?B?MUdiWTZPQlpDYXVKZThITmkyTjNpcHE4b1lPRW85aVovdDV3TTFZRzNzZmpE?=
 =?utf-8?B?bGxxMG85Y2tteE1rMHVvMGZHbC9qVGRlY25ZbTlsUjU2RzZLTlBnM1htbW1B?=
 =?utf-8?B?Z0M2dnhHcXVndkc0b3FwdkpkbkhuZC9Vb1REYzdCR2RlT3NRMGZZc25LM3N4?=
 =?utf-8?B?NU1ZaVdPdk9oQW5mK2g5TmFRNUxZYm02SlNjQlNlNnl6b3VQSlkvUUdhd0NB?=
 =?utf-8?B?Y3pqMTVRcHJkVExJZFUzTFRqakE4K0ZGdW5NYUdFU010L3NZcURYRk1mTGl5?=
 =?utf-8?B?MWkwNDVFdmNxYjVTcm5Ed3RFUXoyWm5OUCtEWG9hUWpjWEloVmp0UVg3Skxj?=
 =?utf-8?B?UUgwTlBzTjM2cjRxRzVISUpaL2JwMS9vcVZ0UVV1b01LTnZ6RzNOYzMyVldz?=
 =?utf-8?B?aXRKeW5ob2xwT0xJTzl0djhjcHF1cktuOWlyR1dKSEgwNzZsOTFpK3oyVFdK?=
 =?utf-8?B?d1h5QVNNMzBZdUd6L04xZjRwTnlHNTMxQVJNRlRzU1dHbDFmdDFxM25XZlNE?=
 =?utf-8?B?a0IxWENEK2c3M2kvendJdDhkWVhMekJSdGY3RjNINkxwNTNaYUpUMWxtdncz?=
 =?utf-8?B?NFc5Zjl6VmtHNUpSMUJrOXVCbDk1aTFCckUxSElxMHZXRXdHQ0dkclI3V21Z?=
 =?utf-8?B?M2FkQUdiZnlKbm1OTHBMRExsalhCMjhUTkJxOHN3aDI1azdOL0VIbjFTTFZQ?=
 =?utf-8?B?dWtJaDY0ZktNOENLK013bHA0bEFrdFBJWFVNTzZXR3JIY3ZlcllMeEpSek1l?=
 =?utf-8?B?SkhrcVl2ZWhkQnRISFBYTlJ0NGJpRTNzS0FndEpkUlZxQlVaZysvVkxnQjBu?=
 =?utf-8?B?UFdodWF6WWVkNzRhUklIVmdza2Q1VWxValAvN2Y5SC9zSHpESjdmMlM5ZkR0?=
 =?utf-8?B?TU1ZRjNvU2NlV0k5SzdXVG9sY3ZRYVpzY21TQklXenNheWVRc0RqZEdjWG1D?=
 =?utf-8?B?bVFPNXRnSXpmQU5SanppaDg0dkJ4VHB5RzFORVFjejhpSzRsWnBNMFlrUHB0?=
 =?utf-8?B?VkhpWjVoam5FYlUrUlBIbXZKSTl4NmwrZXVmdUt3UXVGNWIzY3FHMm5PQnRv?=
 =?utf-8?B?UTJJOFlvQzd6MGl5YWxKcFlUYmxPb2xFaFE4ZUhkVWRNbW55MS90S1NlYmxQ?=
 =?utf-8?B?Mmxiem43Sjc3U1c5ZzB3NkhGVlFGZnlNMGxQL1ZYL3dOT2RKVjRUdEFleXZ6?=
 =?utf-8?B?dFNYNWN6RlZGM09TOUFkcnhkelBhRlRYb0JLbjd4clVxSFFIMjBxYjBMMFRo?=
 =?utf-8?B?ZjU4c0h6ZkdtdDFSQXdOZVNuayt4SGYrektjTldURDZIN1M3dmsrYnEvWFh6?=
 =?utf-8?B?UC9VRHZQY21zZTc5TE1nejZTeUw4WHhYdWNaVDNHR2ZJeUdkaWNtTG4rUG1M?=
 =?utf-8?B?YnJxRzdjQnp4cFRZMXRhYXBkc2xZdlVzMmVSMHVDWFlxRFpMQzlwdHlDd2tN?=
 =?utf-8?B?TlI3NWJwMVBwSFdwUFNyZDJZdWt1VGVDWlphT2UyQ1laZ1VObm01amZTcVpG?=
 =?utf-8?B?NG0rTjFqRkhlVVZFb0NYL3Zla3J5ek1wK3RRcFFlQTAzemgvN2RWUVg3SDlx?=
 =?utf-8?B?MEdDczZXekZ0VzFlZ0phYVJhRkMyamt6MjJxOTNVN0dudFozUkVHd2d1enBQ?=
 =?utf-8?B?eDkvZUhNN2dHRUQrK29wKzV6Vmd0NVdnSE50Z3poUW8weUFKR2ExZ0ZwQm5Y?=
 =?utf-8?B?V2J3TGR5Q09RUHdpQmloYldONWRaUUduaWs3QSs0VXF4dE54aklOMkRERzhX?=
 =?utf-8?B?RXFFcEgxK1dyS2c0Ti9vMm5ZSi8vMkphQ3lqS0M0NTltV2hNOHp3SS9EN2hi?=
 =?utf-8?Q?begu3OSPMfKmyQZ5KfZE0qQbW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9afdd26-f956-4b99-9f48-08dd4d22b131
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7093.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:09:15.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii9GhDu4w/7V7eS3CaownZawczhWuNlGYZwmtx+4NKR7rUZQb5dWG4pRrYB5sf18AW81yLYjA6avg2B3D1UfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

On 2/11/25 7:58 PM, Sean Christopherson wrote:
> On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
>> If the platform initialization sev_platform_init() fails, SEV cannot be
>> set up and a secure VM cannot be spawned. Therefore, in this case,
>> ensure that KVM does not set up, nor advertise support for SEV, SEV-ES,
>> and SEV-SNP.
>>
>> Suggested-by: Nikunj A Dadhania <nikunj@amd.com>
>> Tested-by: Srikanth Aithal <sraithal@amd.com>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>> ---
>> v5..v6:
>>
>> * Rename is_sev_platform_init to sev_fw_initialized (Nikunj)
>> * Collected tags from Srikanth.
>> ---
>>  arch/x86/kvm/svm/sev.c       |  2 +-
>>  drivers/crypto/ccp/sev-dev.c | 10 ++++++++++
>>  include/linux/psp-sev.h      |  3 +++
>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index b709c2f0945c..42d1309f8a54 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2957,7 +2957,7 @@ void __init sev_hardware_setup(void)
>>  	bool sev_es_supported = false;
>>  	bool sev_supported = false;
>>  
>> -	if (!sev_enabled || !npt_enabled || !nrips)
>> +	if (!sev_fw_initialized() || !sev_enabled || !npt_enabled || !nrips)
>>  		goto out;
> 
> Me thinks this wasn't tested with KVM_AMD built-in[1].  I'm pretty sure Ashish's
> fix[2] solves all of this?
> 
> [1] https://lore.kernel.org/all/d6d08c6b-9602-4f3d-92c2-8db6d50a1b92@amd.com
> [2] https://lore.kernel.org/all/f78ddb64087df27e7bcb1ae0ab53f55aa0804fab.1739226950.git.ashish.kalra@amd.com

Thanks for pointing this out. I hadn't considered this earlier.

The combination of both of these should solve all of the issues caused
by a failing SEV INIT. I will remove this patch for the next iteration
then.

Thanks!

