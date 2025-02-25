Return-Path: <linux-kselftest+bounces-27525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2E3A44B15
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 20:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFD71885C56
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982DC1A7045;
	Tue, 25 Feb 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3vPw4W7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011B376;
	Tue, 25 Feb 2025 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510582; cv=fail; b=POYAE85kIVzVs/5lp86diWL5+Ve7yQYZ4uMmEytrrK4BbuZ22mXtR+mEJIEtHO4woXtfe7htiWuyWiuREovOxAk8Zj3nXK0dlre4UmKt/3ilhchMxucOUoIz6j/Lhgc8cTnGXMpxStiEar5Od1bXh+LpgXLxCS658dxXw+EJS1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510582; c=relaxed/simple;
	bh=fmh6sR0lSRuLt6AmGRRUL0o8QnceAEq91Mz3Uq+Opec=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=s9K3VaSTBzTLY7fCYD2Mt/ENI13L8OyZSdqGBY+sbD1/H+JM0imDuvzPJHz5WNiR5V5kJlYlRmhh4x7+ZOgX1t37bt/qb0kGXE07SAXv8V0ZXxMec0LZMU/tab9K+14ZWsYqd1hWfRY7SoW7+P7XhSvDpWktj9DFcJUvx5FOLj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3vPw4W7L; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMAVYRnA72C7N8OSCbTEmfEg/9PxTybpZWr9ipuojt/tbePjgohEZlG2Z88fN4SumhXQS4TjLxZrjTW+h3alco8JsAdtaYgx3fdgfK5X5k5u1PlVd/Ut+JT5gf4jldGsl7NmhKr2FQ/5FtO0rYCRtEhk5kCjg5oiwBVDh7srxGX08A7zB4o0FUssDSGOo9VGEcglf2ZGv3pXPygl0VmHwGGZ+LygvKrMv2ls8fBh2EpwmP9aeoFxSuv0fL4xV3xKtPK01FHIilWNZDbgcOPsIkV8luCsiW1uL5YrM4ugeDqYsYpJHP5PuFXfRFujFWkKcGTiINmF1zUVZjIPhS/DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8HiCzkCdGzNXNWw5xsvMnuYH4w+cZNKsd3g7xdYI88=;
 b=NehsQMKZkPhwoFdxYekLLfToryvtOQHsAPSOzJ6Ef0xproWA1jwrpXakkL4Y0UwkIbJLi+ExkBFfHcGPD7siigv2WcgGwiVVUczJeqz7c7X3r5/nOEFCefEBUUGs5g1TvzGwUk+DmcAJRXjrIff/ptoBCCV4UZeKj66KH1TJ55kyklrr4L5rgkrw4etLX4gxNqGShDmJnMxOJWIqzRHp5xiX8dPTZ29juxfvb/nKihFlHzq6acy8rKTB7eWvXahntAoxQIatFAQqjMK5eZPLnitbtNql/QhOsfUVr5R69gpQzLFsc1ACaMEpvW8o2cOUZZ+sJDbNPEcJNDTXtGqD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8HiCzkCdGzNXNWw5xsvMnuYH4w+cZNKsd3g7xdYI88=;
 b=3vPw4W7LKs2smzS7b8fmMEp7nDz7Iarn86GZIDJDRUrfspaPpmlbQQ1lwPJgrRYN7my4pwgJ/gqXifDoD3A7VZXuJ8C0dB5KucBHj29DMsAU5XQ3P2JLXQE4Js8Ie//EdjrdIV82azqXRS8887M478TfytzGJtUlNgUsbx1WHSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 19:09:37 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 19:09:37 +0000
Message-ID: <b0fe42da-b257-bf1a-94e5-77cd8c090341@amd.com>
Date: Tue, 25 Feb 2025 13:09:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250221210200.244405-1-prsampat@amd.com>
 <20250221210200.244405-2-prsampat@amd.com>
 <88fc49a9-d801-5d8f-f156-28fa06910cd6@amd.com>
 <9480ce1b-2c35-499c-b60f-1c02ea9cdc16@amd.com>
 <a84a3d32-9cf7-4c24-87db-99132a450557@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v7 01/10] KVM: SEV: Disable SEV-SNP support on
 initialization failure
In-Reply-To: <a84a3d32-9cf7-4c24-87db-99132a450557@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:805:ca::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b35f42-193a-40f4-ae88-08dd55cff27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFRRYXZUOGxNNFhGZnFIY0NFOGFYRUJFQlhwR2JiMTZNWWg0Y1FMZlB4WTZZ?=
 =?utf-8?B?WDd0SFZEVXYrZHZtL3NuRGFjQjgzelN0VzR0V21SbStqNFZIcElWVFBCa0lz?=
 =?utf-8?B?ZnNoLzFlQVZLTHJ0V1FaUURSOW5FdC9sb0czRjlKUzA0MGh4SkVsbVVwVVpi?=
 =?utf-8?B?aDc3VXZyS2FITTY2RDFZeEY3Y2NZQW5MNEdiM2ZTcVAvaTlJdUIxT0hOTWxp?=
 =?utf-8?B?VWduZVJxQkpOZ0RjZ2doenRpV0JOM0YzWEp6eHFLS3AyNTAzdE9SbTFxRzRE?=
 =?utf-8?B?enh5WHZZd3pXcFJvNUdNd1FrbXFGWE9XQUI3MExreWFxSWttMmlhcTNSTUlB?=
 =?utf-8?B?anJhaDQ0ZXVjVVEwR09aNldDMENDRWRUMGxTYVQySmtyMDFMdzZyUHpLRVVp?=
 =?utf-8?B?Uk1UdDFJNU5CYk5PdytzZ0hHRHV1empyNnBMalFDOGVDU3RCbFdUdnlSbFNI?=
 =?utf-8?B?cDFJWEpCT0RNV2plclJjTXBJeGpIQXYzMklLdEFFb0t6U0lmS2dwVkhyOElB?=
 =?utf-8?B?Uk4zMk5YV2JHd2IxVUZmeWNWUEh5VHloV0xzRUh0SVlEak1YdU1STjV6aUNX?=
 =?utf-8?B?bG9HSDUvK0o1Smx0UHgwQklRNVhmQS8wUE9SN05ERE00MWREcXg4MHh3MHFr?=
 =?utf-8?B?RkFvOGFpa3RYUE8zTFNOU0JkblMvSVo4TkdmNzdPdjdrbkxTUWJ3MzFTREpz?=
 =?utf-8?B?N0p2OUtJd3hjVTRDSUxpMHlueDk4UVJGTnNDejRNU285aUI3MGd5dlByYS9F?=
 =?utf-8?B?UXZhQWYwUWJJMGtpT1pCRXI3RS9Fb2Y0QmF0bjJwRm8xS3ZJVjVKeDFDV1pH?=
 =?utf-8?B?TDlOK01aOURxS3paL3ZwMStubVVTNXRxSzF1dmUxVHd0TzBuU2lKQnZ2V1JZ?=
 =?utf-8?B?dU1sV3ZLM0lKN2l3Z2pHOGRvTzZOdEovQWMvMmtybjNzemVUNlNuaTFZeEty?=
 =?utf-8?B?UklWSkJDRnU1by9mM1VsSnZFL2F6Zy9tUzA4OXVsT29qRDFSU3lMYUMzWlRU?=
 =?utf-8?B?ZmRpWDFaMmFxUjlVUE01ZzlyUi9IbDdXNDlGb0NRVHRKcC9DY01CYUZ6NmtI?=
 =?utf-8?B?QjlQVEJmanEzNS85Rk5yYTdHb093M055UXYxbGJzaE9nL0VpakorMk40dDZW?=
 =?utf-8?B?OEdJcjV6Q3NsbmJOLzlYd3B2SDNBMmJkQ0p1Um9TbVlDOVhKQ0Q1R0F0Mk44?=
 =?utf-8?B?MTBoUGlhSVROekVZYUY5czNVaWIyV1pwRGlnaUprMHdYSEtCUzR3YTQ0Z1lU?=
 =?utf-8?B?VDM3cVZPQmoraHRtemxvc053YmdLZ2dxUkZZQ2hiZG9UUkswTVY1OVJyVnVB?=
 =?utf-8?B?S2Z1NldQai8xd2lsTWd4eHpnOFBZb0ovbVAyQ0MwSFcxTllGRjBuTitJMmZK?=
 =?utf-8?B?NlB4ajlGSEpQZVpOc2tvM3NrR05Bc01Pc2N0T3k1M3AyMzZOWjBYVnNmOE1t?=
 =?utf-8?B?aStiRWFXV0IrWEZlN01UY3FjT1RPS1BPU0tNVjRWZjZkVjU1dWx6MTd2SVda?=
 =?utf-8?B?N083SnA4YTBDLytxR21JWGdyd2VBa2xzVUpGVmxYUVdNY2lPNFh2bDlEMlpB?=
 =?utf-8?B?MWNvMDVqOVF1Y2MrOUpYem9vdHR6amlsWmZuQVBHcXhBSWs5NDRqK3RBWFZh?=
 =?utf-8?B?SDlKZyt6UElSdE1COG53cXljSC9qRUppUUpNdCtHUnZzaWdPeVpaMVc0Mm5P?=
 =?utf-8?B?Vng4ZzhRMEMvTVNYTGRwVmIvSHNQZ1FUVlJ3OFdzQzBmNWo2ZXpkVXNpaVl3?=
 =?utf-8?B?YVBDMWhzSFlyYTAzUWd2OVRnRkVLQndJZWlXdFpLNzVpSWVWa1JKZUIzNmox?=
 =?utf-8?B?b1NUd1JadFBsUXAyeXZ3TFprcStYV2N6ZHhVNmoxUjZwQkEwVnNwUjlUc0lJ?=
 =?utf-8?Q?Ha+JaitXZOvNb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnI0SVVOVmdKQzdESEZ5VFlnLzI2dUZDc1NGOXhlUHBTQzM2MzZIVUF3YThT?=
 =?utf-8?B?SXNTRHB6V09Ybk9rK1NnVkJsV2dWek1jWER5RmVwWTVVdXV0K051NW1yaDN1?=
 =?utf-8?B?T0pMaFhDN2RsMWhnWHU4MnVkTm01OWhJS1R3UnNxTWVkT3N3TXdEVG5tdVBm?=
 =?utf-8?B?NmVkOXoxUjJmRzhaQUZnSmV5c0gzWGUvazlZaGdTUDlJUmpvb0FwVWpXOUJB?=
 =?utf-8?B?MWpTTTh6R3dPSDJxSzloaEorMUhheGdyelo3TE1Ka1AvUVM1VHVuV1RBMXRl?=
 =?utf-8?B?VzlscXQycC9LS1pOV0JCeDNUZEFMNTZiL3MrRHJYOTM3WGlxN3AyeXhuTFRz?=
 =?utf-8?B?WG1ocXVIUStWWmFMZXZ3VGx2MjdCWThVeE1ZQ3lWMlBpcW5acWtXUm43bGd0?=
 =?utf-8?B?OWd6TjlpWnNLLysrcWtkN3pOVlY5eFIwK203cWdQeXMvK0lnNkR5QlBHZm9F?=
 =?utf-8?B?ckFLcVNndG9RdGpPL29hVjlSWWFBc2t1eEVMV3ljblgxQnVuc0I3OGtWejlP?=
 =?utf-8?B?NXBYeVpzWDJIcFFwbGFHUi9tTjRiYUk2bEcxS2FYY0hCT1ZSWVFTeEd3azJj?=
 =?utf-8?B?M21IZlJObzhmMjRpaVMwNElVRW96LzRyOU4zU3FyejIwUFdDbWE1ZkFhbldo?=
 =?utf-8?B?R2lDc0liQytjRkVLSzk3ZWNlMTQzakwyZjRqVXhSc2NvVC9Wb25qOFdUNW5i?=
 =?utf-8?B?TDFrUXI2VE5semhIa2E4RmxaN280cElySXRPNkRITCtET2ZHMFVYbWhudExN?=
 =?utf-8?B?UVA4ZnRYQUhDVWJMTWdJVGg1Q2lOTzhQVGx1NGQvMTZ2cHI5N2JrSEIyZXdZ?=
 =?utf-8?B?bjBsOVIvcDVaUWMvdm00RWF5aVFBVjlhT2RIbDkrSUh6ZWxJUFAyU3lCdWVm?=
 =?utf-8?B?SXZZaFNwdVl5cS9BWHFxR0w2cThwZ3JaNlVMSkFuV3lCNEZrMVBKMmhHKzJz?=
 =?utf-8?B?YTBiU0RVQnUzVmhRUFdQc1hoTUpLY3VzT0ptbVVKOHNldHB5YmFIM2hVRlJE?=
 =?utf-8?B?aENqWER5Z1VndndVMVVvTDB5K3hLQjNCbE9tY2FUeGxMZEpKSm83YmZzL0lp?=
 =?utf-8?B?SjR0U3p3akZnak1tN3ZMcURyZkNmQVIvT0xMQVJYV2I5ajJ0cWkvcnZYUkpC?=
 =?utf-8?B?UDc2UDlFT0tRb0cyWUNRd3Jiemx2OUxadHJuQjQxbGZrenRBaFhRd3ZWZUhZ?=
 =?utf-8?B?VHJNMGJ0SEoybk9rV3pZeUgvSUJ0cUJXZjY0bGVmS3Q1dWdnbkI3ejZ6L29V?=
 =?utf-8?B?RG5ZcitvdzZGRDJOZTVnOHRDSDdaZE10L2NpRXgzTGJubm1SMFhSR1hNRUJL?=
 =?utf-8?B?c0NQaGtsMktWSDVEOHFHaVVXVnBiWmlSNEM4S1ZKbFRiZXVQZ0x6WGl4OEJw?=
 =?utf-8?B?VGZrellwUDYvUkZ0Um9heWhqR1p1QTdhR0NucTFMTG5mYjFvNDZYWmFDV08v?=
 =?utf-8?B?NmtoeXJ1VXlua3hwaEV1QVgwUlJwS3JLOS9TdE1xNnZVOEtPVmVlL0I2TlEx?=
 =?utf-8?B?dGxtc3U1M0xaeG9PWDVJWFhoaDhBelRGQTBOTEdPdjAwRUdyeitWNlpPVGJD?=
 =?utf-8?B?dXpSbVg4ZmpqajBuVGR1d0hZNVNaaVFScXZ2c3RMY1lNUUpZUDFPRjMzUzh4?=
 =?utf-8?B?T1hwNFUwc2JHbmF4ajRSWDZDejNTbVVkTWVJRWdkdkdNWDBNRjhkZlJkeUZx?=
 =?utf-8?B?bE9HaGdsekZVd3JvNUw0clFRMFAzNmxUQ21USWNvYzZ4bnNjSUZiQmhuN1N2?=
 =?utf-8?B?b2NLVi9vOWVlQ09KNDBDZWFLVnlVV0JoMWxaek9aSVg4L2RoUXJ3clR2ZE1y?=
 =?utf-8?B?MWtKRUpyRlhoWnlKL3Y3UHBhVDRaanVtaFZoOWN1b2FqOUgwdXEzWGVRejV5?=
 =?utf-8?B?QWVWOUE0K0U2dldBQWVkbFhsMlN1OHFLRlVGZVc2QTNmeUJwQWNiSHA2OHB2?=
 =?utf-8?B?K1AxZVAyakxodG5mYU1FalZGaU5rTjdlRmhSOFJ1OVVoR1NMN0V3ZFpkVHJD?=
 =?utf-8?B?eTlQSHA2c2pweS9ydnJWVVJJUEMyM3U4ODNVL3dVMVRId2x6Mndzb3g0S2RI?=
 =?utf-8?B?VkJ5dmwyVE5LNXdvQ1E0c2M4TUdvRnVaOTRLWXRIVTZEbzh5MlczT1NYRk5t?=
 =?utf-8?Q?ImyEkCvPO4GnAyYY8LcXZkjlb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b35f42-193a-40f4-ae88-08dd55cff27b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:09:37.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5YddSw47JIZr0IaZ0xD9ignkT4MnmmaD8oaYKXdtnKj2/e8zHv5CtpHZzc0IbFB4ZXJsldW38+kWNt1OPXufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

On 2/25/25 11:45, Pratik R. Sampat wrote:
> On 2/25/2025 10:41 AM, Pratik R. Sampat wrote:
>> Hi Tom,
>>
>> On 2/24/2025 3:28 PM, Tom Lendacky wrote:
>>> On 2/21/25 15:01, Pratik R. Sampat wrote:
>>>> During platform init, SNP initialization may fail for several reasons,
>>>> such as firmware command failures and incompatible versions. However,
>>>> the KVM capability may continue to advertise support for it. Export this
>>>> information to KVM and withdraw SEV-SNP support if has not been
>>>> successfully initialized.
>>>
>>> Hmmm... rather than creating a new API, can you just issue an
>>> SNP_PLATFORM_STATUS command and see if the SNP is not in the UNINIT state?
>>>
>>
>> Although reading sev->snp_initialized is probably cheaper to do, it is
>> cleaner to query the platform status.
>>
>> Querying SNP_PLATFORM_STATUS requires the pages to transition to
>> firmware-owned and back, and the helpers for it are implemented within
>> sev-dev.c. So, similar to sev_platform_status(), I'm thinking it is
>> probably better to create the snp_platform_status() API as well and use
>> that within KVM to check the state.
>>
> 
> Although I am guessing the initial intent was to not have an API exposed
> at all from CCP and only make the SNP_PLATFORM_STATUS call instead?
> 
> Since that may not be cleanly possible (we have helpers for page state
> conversions such as rmp_mark_pages_firmware() in ccp) without
> duplicating functionality in KVM as well, I guess the question really
> boils down to whether we export the cheaper snp_initialized() or the
> snp_platform_status() API instead?

Taking a closer look, we do already have APIs that KVM uses to allocate
firmware pages (output pages for SNP APIs) that can be used:
snp_alloc_firmware_page() and snp_free_firmware_page().

I think that should be enough to use sev_do_cmd() to perform the
SEV_CMD_SNP_PLATFORM_STATUS command without exposing a new API.

Thanks,
Tom

> 
> Thanks again!
> Pratik

