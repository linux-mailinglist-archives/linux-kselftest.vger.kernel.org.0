Return-Path: <linux-kselftest+bounces-14442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A379406A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 06:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16327282329
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424E15699D;
	Tue, 30 Jul 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DQYj2X0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D913B780;
	Tue, 30 Jul 2024 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315168; cv=fail; b=lPNr+1UA2GA6BYbR/tNlrAXJo2CYDNWKlyCus9C9Eeo+8uZBHoM2lojPnG1mlQE9oCCKbsWPhz2rLt1/ggV9jMOXdCPl4hl8p7XvchJg0+juN33T7vqWYzNVPr1/wXs0OtLyehxr5KqReelgi+UrLrE1O9Ra94rcrnC8SBQUZgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315168; c=relaxed/simple;
	bh=a+XFh8ZrCV2kc28ipuuHeGzpAxSGuw1gmcku/BN6TZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cXfb46KA0XnJ1DAFyucPm1PKSfKEvQRJhQvUZEZJw4gWJfWtI1pJ9Qh5O29gWmTosLkPMk+6pOSM5DXHDM4sIkPTviVqNW1ZKivE3Ynyrv+gDf7xDI0mjQtKz1pvXZeO97olpWKZcewzuZq5O1K2wy8pOYwyDtQgGuR6VAtJtgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DQYj2X0M; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHhnsphCTNTTeWSH1LgaijN48runxfD47H7IdIk17iztzxBEME2XakC3rTWsBlXPb4SHzFA0DwVR95Yay9PVAxW8BnDzLqKS4I0FOetFJUSz6eEGI3tG2PXTiUDcYNNUaQeiTDcUb9g5Ie8a3TwGY9UjWmF7zdzeVxEcs69FvtDXDrqLJJYMNRdWqDKMbJxlr7GfWfRmDCkVpZ8sLUy/dNX47TVOkdcj9lJtonsCagCiz1CBsgVigwpuWETzEcMvbgSE75WqSNDXe0/mGDIYqeBWzn1WGq3eHWc2Ebnb6hC3UPmF3gvUsTRMcFOmH7PiWQdujVCrVTt1pjPglN2Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgQdOndBxZSU8dqyPVgFkw5UJFL0GirdE0hDs076bwk=;
 b=S3KH8L9+ZjAP3/coOvTFu7M0now2Wno6hiUFvZtAToLpuCKuFYKapqPLxpnEUPFIfWhp2mNhJz1rsGGRsGNbpTPn8t19t9T0K6w0BT0IO+hhySdQsoGj6AA2F77BhTFmp5eNmpS486mWrGojj98KDRsLONfqo7Nb0LviViGxODHm9V0ln394w3D7aUGlCWf5QNVxd+STlG4ckI6rQNk4bAsBoMyG0mHme4KC3XEqGCE3L95RZBeTwyug7gB/HDUDd7qsVECoFbhccbctzc6hfuQed+K4tXq9/YKL3TOChH65quNd9cMVv1BiyY/aoXY6E/hdfwUIEniKzfoNEorW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgQdOndBxZSU8dqyPVgFkw5UJFL0GirdE0hDs076bwk=;
 b=DQYj2X0MEhTRZDcDl50Av7lORfZKK5UjFim4Q2vpDgioUH8ch+Rw+3sCnRNpxV/0f+JZX5ta0VLn5yz9UAqNeAKHLOr/1K5FJ7+sbRUUZFyyP1p2CPd62vdKUPSNEy0+hz/QxyJXkch2Y0O5HzuVaGTWKhs3A1qU2jffaPljga4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 04:52:44 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 04:52:43 +0000
Message-ID: <782a2791-b9bd-4cba-a734-eb673f8bc24d@amd.com>
Date: Tue, 30 Jul 2024 10:22:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Add support for the Bus Lock Threshold
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20240709175145.9986-1-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::14) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6729392e-f268-4350-7eb0-08dcb05372ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTVlaldFT2dvYm5HSUoyb3B3blZIVGNaUm9VLzZlTnpUZ3FGNWNZais4aGx3?=
 =?utf-8?B?TStnUTdrWXVJRkplZW5OUUk3VTAwUFZlM2ZYcW1FbExHS0Y2bTlzM3RmZmU4?=
 =?utf-8?B?ZWZjODYrMXlwUzVRSCthdlNTZGplU0FYNkR3VWpObkJvdkFjVGd0akczRFkr?=
 =?utf-8?B?ckFnelNub3dvUk5mcnRmN2lhRHhackQ4b1g5MUt0VkQ3bkNHdlhYUXRYNkhY?=
 =?utf-8?B?SFQ5UnI4emQrYllLL1YzWEV4OFhxVm01b3doUy8yTUxjWWt4aXlJNWxrTklK?=
 =?utf-8?B?eU1pOU1CV3VLQlVpV2hKNDk5WG1OZE1laVlZd1h3NVJrL1dEVVRaKzB4amdF?=
 =?utf-8?B?RTZjelI1bGdjaE1od254a0hWUlVQQ1RCc0xjMmp2L3hoK3g3RElLSDVYTnpR?=
 =?utf-8?B?SHI3UXk1eExYSzNOSzMvWjZUeEltb092MEtRV1U4OGt4b0h3ZGNxcnpTaGNo?=
 =?utf-8?B?aGRYaUZGNDhEYmNhUzBEYTN3a1piOVFOb1BJMlJHQzdxdVF6QmNtd3dSWS9O?=
 =?utf-8?B?N3YyVUNmSVJKc3MyTWxxNGgzSk5rRXZUYnk3cHYzZ1MxWjZacVBRN3dqRXln?=
 =?utf-8?B?RnJwbjk5RW1aRE1va0taQWZ5TEw1d1p2QU5NZkVWWlN1UGtLR012M2JCbktF?=
 =?utf-8?B?NVRud0VoeU56YW9HTGJoSy9zTzNOODJ4NlBZK2ZVUG41Q1dJdFRqYnFPT3lQ?=
 =?utf-8?B?VHd4VTRlVTlXcVBhcUFRNnJxYXlHUndxdVg5OU9YbGtSMHpOTUpQR25JMnJv?=
 =?utf-8?B?VzJPcEViYXNyRHQrU3VMd1ZRTW1VRGVjNXg2UU1vRnFEZGM2Smo4QjZFSkNQ?=
 =?utf-8?B?M2xkZ2VZajVnQVhucnYrclBnZnllR3p3ZGdNbFdnYVBLVnVWU3E4RjA0V3My?=
 =?utf-8?B?dTRsVmIyRmhYWGVCWDdWRFpodXJpdnpWL0hTYno3T0w1Q2NtRzFiYVVDZUlN?=
 =?utf-8?B?U1FqRzl0S3A5MjhYcThydGdPeWVheTl0dDF6RFJZeW44bGF3SXhvUGZLWm4v?=
 =?utf-8?B?bFBXTG5OU2djYVA0Tnd4Nm5TcllrVDNhWnIzNmZJUHcyb0Z6a0VNTmJhNU5D?=
 =?utf-8?B?eEhaVnBCRFkyMTFpM0lBRGJiVG11M3VOcjRGSFpRMFhKQnRpVklTcnNGT3ZG?=
 =?utf-8?B?TUFyZTVIZHdHTXFpaG52cGhyazlFVVU1cVNPdTVxSEhTaG0xbUVUaHQxSmhr?=
 =?utf-8?B?c3V0TWgvWGNFV3o3cHZUcDkzZURHTEVZNUI5Y2tHZ1hmU3lyUFpJVkpTTU9Y?=
 =?utf-8?B?L1JCMC9ieXNiVzNrclI0ZS9aSGE5QzV1N3ZPMlBkY0NiUUJLaUkwTlhsdVh3?=
 =?utf-8?B?WDcrYlgrbER0YXYxd2J5VFB0YXVBOVh2R252anJmTkV4L2NCLzRyTExlUWsw?=
 =?utf-8?B?Sjk2Z0VmWkhTSjNablNlWStibHRBZXpySHIvcUJtYkpXMjQvZ1NqTTQ4bDgr?=
 =?utf-8?B?cHh5NERseVRjOFVaMjRQUzhvR2dPVHhMT3JBajFYY0ZYZVY1SFFBcmtJY0Nh?=
 =?utf-8?B?M0FWb0hCSEFkalNWQ0RhcHNlMG9ZaVdvcTNVUWRlNE1XZnFkUUpMY05SWmUx?=
 =?utf-8?B?RWJPdXQ1NVBmQkNQK3VQdVpJNStCbWJxNUUvSDhUVnA2OCtBdnBlNFNQYkZz?=
 =?utf-8?B?dVZvWmQwRHRCRjZ0QnZiRmNjZnF2TVZKeEptKzBaRG01S1ExejY1dE5oWGxT?=
 =?utf-8?B?a3ZuYnRWUTZyd0dLSXZvc1FQTXhLei9MSFAybzFvT0xLcEZlZHBmbmFYSHdU?=
 =?utf-8?Q?BquG2xRV/Hboqhdu/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjdIaU1vYnh6Yy8yWHUvWGVUSjgwNlpJeGF1QmpLYms1WGJTRitaNGZEREQw?=
 =?utf-8?B?MndpSWhLamtCZUlyR0FKZXhXVE9NTFpoUENLVDMwM1JvUjNDWG9KWWRTNlZm?=
 =?utf-8?B?SFg2SG1zWWxEQ25Ha1lhYmJERHRpa2VNMSsyQXN3KzNweWZHSGNHK1NLbTRM?=
 =?utf-8?B?dDg2Q2p2amNoRDdna3MwcFcvWC9jNGVXZE5jOVBZcXhsa0hyOTNaL3Y3SElF?=
 =?utf-8?B?WGRTWGxxS3Q0dkQ4aSt4UittZGRqNTdSRzZtbjFTeEhGSGZ5Uk9wZ29QN1FT?=
 =?utf-8?B?MTlwMDhIaVpJOUNmYzJUZ0VseUZvNnNSTER3aXdSRkVzenRISzlYUllLaThD?=
 =?utf-8?B?V0djSkNMcGxTSDlwUkdNbjM0MVNWd0UybjlpS0VvSDg5OTdmREhjMWxyYlY4?=
 =?utf-8?B?ejU1ampZRU9weFFSWUhJTG94MEFpOW5NNkkrYWhqaHlwVHVCSlJPUmg2VGxE?=
 =?utf-8?B?czNhSnp2Qms2NFYyZ1RGblliNmlIb2FZQzV6cnR1NHlHOWVhbjhHNW0vZDBU?=
 =?utf-8?B?MFlEc3czZHFiNHc1TThmRzdKSS9kMW1ET1pmWWhtNktXT1BVaFNKNWl1dnNV?=
 =?utf-8?B?U2RiZERGQWpUalF6Q1Jrd2s4d012K0RaNkNGNWQ3Q0tTdGhNR3RYczgydTNM?=
 =?utf-8?B?WmZYTk5UMkNFMzMrT2VjcldIYXh0SldEQm1BRHIwY1d0UXRsK3ZQbFBIOTZ6?=
 =?utf-8?B?ZlBVYlg1ZWVOOUR0RExSM2FONlUzZHljeFFiR09pdzFaWnBBYmpvcThQQnE0?=
 =?utf-8?B?V01ERFVVb2l5UmhRMVQwNDhORnRMUnZaSHh2Wm9PeW5ZZjNKbW9TN3RESFZB?=
 =?utf-8?B?VjAxbGd1YjYrTE1hNGxxdCtaQmpneWN5cXhVUFpiT09VRmVxbGF5bUhUVFpk?=
 =?utf-8?B?ZFlrY1d6Z3hNT2FJelkxUWVnYk1ValFyK0l5cE4vWXJzSzlucUYyWFI1V3Z4?=
 =?utf-8?B?SWhJREdsYTNVL2ppZFZ3N2x2UmdYRXlManZvZUxnZlh3blFha3FrTHRUcUNr?=
 =?utf-8?B?ZzVlcTJmMGRuaE1SbDlUTU4vRWlNdkMvWFo4T2ZLVWRGWkZOQktlcEh0T3h5?=
 =?utf-8?B?N0Irc3Y0d0JITnhad0l5M256cDM4bnJnM3AyQUhEVk0wZFRsRnM4VXRFSkJS?=
 =?utf-8?B?SFBUNk1mMkl6d01raHhqWmxIZUJ0Rnd6MytKY0dQZWR6b0lqTWt3dmc2ZnFW?=
 =?utf-8?B?bmpIeEo5YldWTGlTQ0t6WlhtMHZDbTFFMzlBZGZaWnVpSHlZdXBJMWFOV1dT?=
 =?utf-8?B?bS9WU2s0TGM3aGhJTGNEMmpoNlJ4OEIrOG5jZlBNOThXMXFNSXk4SzVTMjRE?=
 =?utf-8?B?YUtacUNTZnd0SmZaNE00aUlyV1kwMVQ3WUNlTWRaUVptekE3d1FSME5iME5L?=
 =?utf-8?B?SXdYNWlUZ09QTXJHZWtySTJIUUhuaHp4RUcyaDlSWFFhcmJMd0lySmNBeFlT?=
 =?utf-8?B?Wk5CT2ZublgzSEJydXplN0pZY0NkajFuUjlkeEVxSVY1WThqeVhrbUE3TlhB?=
 =?utf-8?B?SmxqczJCbldpdEZSV3BXS2NCUXU0azNZR3h4OWdPTW91L3FsR3NIMkxjZWZX?=
 =?utf-8?B?Mlh0UXlQelZzMDNMZWF3cjY4TEZnSDZYTkd1UjJoSmdoekovZ1lCa0g0Uko5?=
 =?utf-8?B?b2xjKzZHdE55UEdVSzdGbjlzNFowbjRXM2lCVy9uK0pQK2ZJbllnbTBHZFhK?=
 =?utf-8?B?elhTUUx4TE52am5VeUJxK2dhc1VtN3owUCtiZ1Z4R0hacld0ZXFvK0FCeCsr?=
 =?utf-8?B?WnVKZXN5TDlOUEdvaXEwMDZpUUdUWjM4Zm50dENIOU9McEd4cjFQOXhCSG5o?=
 =?utf-8?B?T0NLb1JZUTh2Z3dWMEl0cE9pOXZSZ1Q2WnhEdlhvZmF6azNHL1pVa3JOeVFE?=
 =?utf-8?B?WklENWtMQk44cnFLaWlhUEhvdVdZbFRVQnNjNjREV0tpa0YyUFFJYTBOc0FB?=
 =?utf-8?B?YjFxN3VtLzAzUTFIOU8xNnNQTkN3TVVMWTZpMHdWMCsxRTJjQ0NSUXRWZ1hI?=
 =?utf-8?B?Tk9aaXI3eVlaZzkvUksxbHU1T0w1ZCtEM3A4NmRSNGRyaGhXeTRwajZkZ3Bk?=
 =?utf-8?B?MXdlaWQ0MWpxTVJST0NQKzNoSmJJZzhZZWkxQWRoT0Y3aFUxZE5oNzJFcjl1?=
 =?utf-8?Q?JdcCki3gQmuwAkB5geK08P53Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6729392e-f268-4350-7eb0-08dcb05372ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 04:52:43.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s5pcHE2tDmi9nCspDPGOeJikrVqjGkisEadUhRyJntwTaBzj2GtdqRk6465Hejh3Hl9og5SRybH+xgrLj7VXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

On 7/9/2024 11:21 PM, Manali Shukla wrote:
> Malicious guests can cause bus locks to degrade the performance of a
> system. Non-WB (write-back) and misaligned locked RMW
> (read-modify-write) instructions are referred to as "bus locks" and
> require system wide synchronization among all processors to guarantee
> the atomicity. The bus locks can impose notable performance penalties
> for all processors within the system.
> 
> Support for the Bus Lock Threshold is indicated by CPUID
> Fn8000_000A_EDX[29] BusLockThreshold=1, the VMCB provides a Bus Lock
> Threshold enable bit and an unsigned 16-bit Bus Lock Threshold count.
> 
> VMCB intercept bit
>     VMCB Offset     Bits    Function
>     14h             5       Intercept bus lock operations
> 
> Bus lock threshold count
>     VMCB Offset     Bits    Function
>     120h            15:0    Bus lock counter
> 
> During VMRUN, the bus lock threshold count is fetched and stored in an
> internal count register.  Prior to executing a bus lock within the
> guest, the processor verifies the count in the bus lock register. If
> the count is greater than zero, the processor executes the bus lock,
> reducing the count. However, if the count is zero, the bus lock
> operation is not performed, and instead, a Bus Lock Threshold #VMEXIT
> is triggered to transfer control to the Virtual Machine Monitor (VMM).
> 
> A Bus Lock Threshold #VMEXIT is reported to the VMM with VMEXIT code
> 0xA5h, VMEXIT_BUSLOCK. EXITINFO1 and EXITINFO2 are set to 0 on
> a VMEXIT_BUSLOCK.  On a #VMEXIT, the processor writes the current
> value of the Bus Lock Threshold Counter to the VMCB.
> 
> More details about the Bus Lock Threshold feature can be found in AMD
> APM [1].
> 
> Patches are prepared on kvm-x86/svm (704ec48fc2fb)
> 
> Testing done:
> - Added a selftest for the Bus Lock Threadshold functionality.
> - Tested the Bus Lock Threshold functionality on SEV and SEV-ES guests.
> - Tested the Bus Lock Threshold functionality on nested guests.
> 
> Qemu changes can be found on:
> Repo: https://github.com/AMDESE/qemu.git
> Branch: buslock_threshold
> 
> Qemu commandline to use the bus lock threshold functionality:
> qemu-system-x86_64 -enable-kvm -cpu EPYC-Turin,+svm -M q35,bus-lock-ratelimit=10 \ ..
> 
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>      Vol 2, 15.14.5 Bus Lock Threshold.
>      https://bugzilla.kernel.org/attachment.cgi?id=306250
> 
> Manali Shukla (2):
>   x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
>   KVM: x86: nSVM: Implement support for nested Bus Lock Threshold
> 
> Nikunj A Dadhania (2):
>   KVM: SVM: Enable Bus lock threshold exit
>   KVM: selftests: Add bus lock exit test
> 
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/svm.h                    |   5 +-
>  arch/x86/include/uapi/asm/svm.h               |   2 +
>  arch/x86/kvm/governed_features.h              |   1 +
>  arch/x86/kvm/svm/nested.c                     |  25 ++++
>  arch/x86/kvm/svm/svm.c                        |  48 ++++++++
>  arch/x86/kvm/svm/svm.h                        |   1 +
>  arch/x86/kvm/x86.h                            |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/svm_buslock_test.c   | 114 ++++++++++++++++++
>  10 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
> 
> 
> base-commit: 704ec48fc2fbd4e41ec982662ad5bf1eee33eeb2

A gentle reminder.

-Manali

