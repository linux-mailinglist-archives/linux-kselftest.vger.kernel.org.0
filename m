Return-Path: <linux-kselftest+bounces-18963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD798ED9B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E44328160E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BCA1474B8;
	Thu,  3 Oct 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vy80CldH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56614431B;
	Thu,  3 Oct 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953727; cv=fail; b=EQ1EXt1LRM4s2jZbJJmqfmcANtxNrjZ9TNf4xhWV1stEuhrQ1J4PNYVNClgS+6rGR2uVvIKNhT7lvVLMdLhO1uDo3nsARc1PjUdjD8KJE18IonmwaSY5vv8g8spousRcoREsPtAsLWjauHtxwfbogEFtTJOmes4LOZprjunDFdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953727; c=relaxed/simple;
	bh=HzYJ2WP0mMXs+AlRgNp6XVtKs3s18t6/tuvqfZExKJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hiRjAPblezgLL3mGXbeG113T0U+mO/4eTupotdww/xRJ1pERLECuAtxTA4f7IBOTsnZO9xHxgqvTL6jIy5m01K3NcJV93zR4CKsGVhljBY2lNR0Cuj84OhfqiGF12vT2dU9B028BNVbu3nxKcBSxrA/Y/qaFkIP2GQLDpxWp9kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vy80CldH; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoTOLphHlLO+i9ZCncGKR8wt0iPdN6gUe7Iy7ftKP/0PIV46tPpfoDWR5jQKgcM9kRc0ZXJUkT26tsB6TZNG7XJlPvEakcbfgzUbE+zyGVhM/dClrFnDXdonB7ENhc0Zuo2Unw1H+k9McJ7PpS02TxHoguzIuAMoAnyCn3uAyVOH9Gmig68hP4nU3Qx83m50W1rGQAU04jVtrgsUTut0ew2TPGYLBGPJ/Kxp0YmsIPOPg63CHWJn/vAVURLy1WPOBaUVymBVhTBN+7+4ofTMHYpvbrU4kXJkIUrbVfU8FgubLx6IQp2PVdg8In/itoekFnmClNaH4MwmVayD28TzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMCRRFq2PYg412EIlRmokJEH3yZxX1ATO3ltuEJO6XE=;
 b=u4ESneXoOUe7SmYgeRBBciB3hjmOVvT1RYofFu/g+sv9lg5F+4w3tGOqj997iEi/CPwGUic2NY51QcSXuYPN39ZO9rSktXYEYQQZpK994I2lGeEQPxXPjFgA9Cv6y269tVqT5TG7bjT6zkSfPiSGiJYXz0nJQOGi4IGX9hRIPNSR/6ejFV78bakp2Yf6h0AyK0kQcjAF2OKAM7SzHDSFrYvnMXTAKuRqlyN3KGNvctpsg8sbxZsVUCJy6UYPVunVwC9nez3W4A+C7m27KG+8dqtPKGnRJCA3Q+z9q3dAPkWtOhuIa2xuOKaARY3fkY92x+t8W3niifMQqx2b7VlDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMCRRFq2PYg412EIlRmokJEH3yZxX1ATO3ltuEJO6XE=;
 b=vy80CldHwPZPUkvNUSNRZWAFsQmeHuD5rVctNnDrPtaTr21WNdtyWRupLD6ERgnH7XYRJU0ZuwzZynhh8BJyDNxrPfDJf9vwk0s++E+dIe+q36JuYPa7Z+9R41mS89MzZLt8phkx3dd7pNsAxZ8olpTI37fveO7MVVv2+AREyXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 11:08:42 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 11:08:42 +0000
Message-ID: <a4c77249-919e-4450-b41d-6b82dec032c7@amd.com>
Date: Thu, 3 Oct 2024 16:38:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] KVM: SVM: Enable Bus lock threshold exit
To: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com,
 Manali Shukla <manali.shukla@amd.com>
References: <20241001063413.687787-1-manali.shukla@amd.com>
 <20241001063413.687787-4-manali.shukla@amd.com>
 <728df37b-b162-8adf-8639-86233d0cf770@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <728df37b-b162-8adf-8639-86233d0cf770@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 007cc2b3-44fe-42a5-dd12-08dce39bbd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGNxQWhqclJNWXRJbjJ2bU9XNVVwZnR4RHZ0NFFLckRHcmdtN0N6SEM1TkFE?=
 =?utf-8?B?ZW5HRW1CYUkvNWxxdE1LeXE3VC84U3VwNGpPNnpMa1dxZmNaWnVBTVBkNlFY?=
 =?utf-8?B?ZVJKeHBTRVFSVFJnZWhtSklqelRyMjhTcGtndkp3NW5DY1I5SWhEb2l3QkhL?=
 =?utf-8?B?TnlkMk5KbVZLVi9NWmRtZWlYU3FjZ09DNlR2YittcHFPRG5EVmRHK1lWa1k5?=
 =?utf-8?B?V3REM1RzMDJldUsyT09TTndLeDl4aVFyblBIcDlUVGd1NEFMbXl3RmJGS2h2?=
 =?utf-8?B?aEJNMzNmYUMyMFNEQU44VkVPM1d3dVcxRGZwejJOaC9KU0xJOG9QSWptS3BY?=
 =?utf-8?B?WFdaZ0l3NVBHNW4xYWp5cFRkRVYwUDVWUmtVNVp2c0hVV1R6K2FLMWhWeEFy?=
 =?utf-8?B?YTg5NnFISE1pNXBxWlFlcmRRaTJmSUY2NHhmYmpGT1N6R05NZTJNU3FKOW16?=
 =?utf-8?B?eHZXZU5IVVdMc01kbTZRcXNrTHh0Y1QvN1NMencvTW9xMXV2WGlaM0pxcU80?=
 =?utf-8?B?bGV3TWZDazBQUHhGaVR6cWFXUWhSRmhvS0crUExhQVBEZDlWdDNWeVpvYzVR?=
 =?utf-8?B?VThNdVFBUjBmVmo3cndhOC9YNHlNMlZ0Z1N4YlltVEV3bVRIYWtSL2UzVGJG?=
 =?utf-8?B?UTVhMEhIVFgrL0NHNnlRcHJNZ3Iwa050QlJJNEFmbXBDb0NNWnpUOWVUcXJN?=
 =?utf-8?B?WWI1Z0M5NGpXcU45eUdmWEpxeHFJbkt0ZUs2dlVvNFJtNzNXTE05VDYralZo?=
 =?utf-8?B?Q1VxR3cyVElzcE1ZMTJPL2QyZDFTd0pOdEhPRm1sOUJOVytrWlJEcmlRZ0Uv?=
 =?utf-8?B?R0IxbUo5NkMvanRJN28rZGNXR3RxOEk1alphRzRuQ3lLOGx1bU5CdjhMWENR?=
 =?utf-8?B?S1JXdUliYXR4YXJLTEFBWVM0dzZ5bVpzQmJpWlBqdVNmRnpIQTFuYzNpb3A0?=
 =?utf-8?B?K0lYYkVhYU1RNjF2cnMwZFV4TzNMVEtEK0F2UWNoaVpwOHBHS2ZVd1Jhbk9t?=
 =?utf-8?B?eldLRStkamcyR1FEVkwrV1dyczdtb2UralFvZDk1djJ3M3pzM2FyQjhBblFM?=
 =?utf-8?B?Y3RRWlNlRm5mNTR1RDlUa2pQbWZMNUJzM1R4WjU3VHBMV1dtNE5RS2JaVDA5?=
 =?utf-8?B?Qm9YbDZXb3Y0THI5amVnaUJVNWpjbVZFZysvN3pwSUx1NGhlWUpleHBERHhP?=
 =?utf-8?B?UmZTV0RkcjdoZ3hndVZZV2VsMnExQTJoR3JwamhVblhPZ0lTeUxIQmoxTjBT?=
 =?utf-8?B?VEQ1TW5mc1dxdnRCQTdOQzRVU29lK3FqYmJWT2xINkF6eXZCdGwwL2lCR0Vp?=
 =?utf-8?B?c3Y1R3oyaFRQQUsvTkxlTUJIU3phK0poVGMyeURvc0dnOHFIRFFlOExlRGJn?=
 =?utf-8?B?L25KZnNOVXhsL3pKQlhYWEJneVBnemo3bzVabE5jcUhVbVgyS21Xb1IwS2FB?=
 =?utf-8?B?clNla2xja3QxdE9rQVNQVEhoZWpBQ3VCTXpBRU92RHo2ckllbUhZS0VPVjQ2?=
 =?utf-8?B?L285MmFPR0l3UUZKczVPQW84bDRHSXEzUGV3aU1Ea2FHbm03MExkOG56OHdL?=
 =?utf-8?B?ZEJBZDBpVmx2R0lnMDk3YTBzYndnWVJFOGtqL1hUYnN2RU1VeHI5bk9lVkNJ?=
 =?utf-8?B?Y2w3SkJkeHdWdnZHcFkzNE9sVVJJOGsxODhMd2RrV2NkZm5tbWI1cjdseS9C?=
 =?utf-8?B?VjRoazYwVngzVWNVN2pTODVLc0d1NEVVVTZQVFZBK3U3SXJhS3Q3VEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzZ3T01UaEFtSnZiQ3ZjcjI2YzlGWWVWRzAwODVlaGZVVjdsVE80SnphYzRV?=
 =?utf-8?B?SnExZGg4ZExjYzBGY3ZFSXVKeVVKR1BaaS93ek5GQllMN1psbXVCUUt6SzBu?=
 =?utf-8?B?bnZKZjZHOTNmQVZ4KzdnVTM4L2V4d1MrcXJvNis5cDJodVM3UXBMeHhWNnM3?=
 =?utf-8?B?K3VlTFdoejJwV2xUbW9WZ2dCckR6Q3dYR28zb0tqMXVtRmJxM21RR0lla3hT?=
 =?utf-8?B?anVKT1hhNzZHQmFSZVNWYzNtbkdhd1RDVC91WFp0dEZnQjg2ZnU5TGQ5WW10?=
 =?utf-8?B?S09mVFdYZ2JTc0NFdFpBUEtzM29mZHNBdkVzU3hxN1NaODgrb255bEF6cm15?=
 =?utf-8?B?WHFNeWN4TXJWeGwwUkpFWnBLUjdtRVhSY3IyYmNtenFOWVlxWmlJRUtEaDBW?=
 =?utf-8?B?OXY0enRmakVuSU55NTZJYVhMU2t0czRBZFAxVGsyNUhyWjM3ak1PUUdNQnFG?=
 =?utf-8?B?elM4cU52S2VVNFlNUW5HYTZFblgrTmdwZ2Z3WTFoNWtmZDh6WmRrazJtNzVv?=
 =?utf-8?B?MHc3YkNnU3JFVEViZnVMd1dlSGNZY2E0djR0VzNKSkxSTitKdEZTWGUrTVls?=
 =?utf-8?B?T203RXhncmhmcjFKdGIyMCtyM0pHZ0VXMDVuNVQ4enRkSlFHUFRscSs3MlBY?=
 =?utf-8?B?bXQvYmxIWDRyek95ZTlySmlpcGxHTjBORE42dm1vaS9vcno1RFpJSFQzbmFR?=
 =?utf-8?B?U3QwczZ2ZHNiSVAwSTdpTW94RXIvNXhaTFBscldCWnJ6c0RDNStvd1lEUDc5?=
 =?utf-8?B?c1gxLzI1VThVTzJWR0IwU2hsZSt5UEZjdnVVWnhFeXZ0TEVEaGVIcEJtNVF4?=
 =?utf-8?B?c2FzUVN4K292L2x6aW1RQzUyZjZxdFlJcmlveUpZKzVDc0x1NzVYc0tEOGI5?=
 =?utf-8?B?bFNrb0RaSC9RUWVLWTl6MzJaVkUwSlBsK0NvdkU1QVRYbm9meWlPcEk4MW5o?=
 =?utf-8?B?NDNEY1hNRVNVRnhFN2pIWlBOcGxKdGpjV3lML3cwbk5vdTcrdDRDMkhLZ3Iw?=
 =?utf-8?B?dnRJR0prdlozMEM3TE5MOFRZYjdXUVJ5OE42SDRBbmlTenZWd1MzRkhlQzRR?=
 =?utf-8?B?MVlkU0FsK2R0bVZGMlpHY0lqQTlJL3pETHZQUC9rUzJETk4xVUJOVDRRMjJz?=
 =?utf-8?B?c2ZTMGJsdVZjeHhhZFR2TDRPck1pL1NzaGF6eXYvcko3SDVZZURlZHBTZWVu?=
 =?utf-8?B?WVNYRUJidlVlbGtlb3loTXNMVlpJTVlxVnk1eWs1bVJ1dG14QjJIU1A0dDZh?=
 =?utf-8?B?WHVQV2cvZk9ZUVkxM2dUTlcrVVZKUEJLd1dDOTRnSVlCRE9EL0ZCV1M0ejhh?=
 =?utf-8?B?Ukl3NFN4b3FjbUc5aDkrUW9GS0U1ZlRUMVBCRE5oeDhHeFp6djZqaWR0ZEhF?=
 =?utf-8?B?KzQ2V3hJaFVaODBkdkZKQ0NpSDhkMHNHdXppMVlDcW1ab0E2cUNrYUNxMTJq?=
 =?utf-8?B?SDE5b2p2R1g0N3VMYjlsdXZSS3BiaW8rUTBoT0w2VkRLWjdsdlpzeURYN2RR?=
 =?utf-8?B?T3BkeHdReUdTUm1hR2lxOVp2eGFCMzRDaWZsMUkycFBtTU9FVmQ1dm9kZ09G?=
 =?utf-8?B?NWsyWFlTNmxZenZSM2lDcXFONFhZdW5hVlU2c25rRFQ5YVhhVjF6NlFuMG1K?=
 =?utf-8?B?QnBPaWltbHFqVGkvSVFBdVZQSFBUSm04RUVDY0FLSGg2ZWlEZVBSSXBFT2tR?=
 =?utf-8?B?cDVlRUpMMzMvTzBKYWx1WE1VTlloRmZabkpDWTYwRVFHaEN4ZDBuTmlGMmJs?=
 =?utf-8?B?YkxJR2FZNWcycVFnM3AvYThNOWVoNmI2RllWUnI0eHNaWmpCdkRGNVF0NEhw?=
 =?utf-8?B?L25TcjI5NHVzOG5jTVNNMmQxLzFVNE05L29HbHR4Q1c0TWh6YWtRV0VYVVQ0?=
 =?utf-8?B?TXhoT09ZSTRhbTRqRDhUVytuVTZCQ1l3TDdIdDVQRlBYeExtQktzQ1ZlZklN?=
 =?utf-8?B?T3BVK0ZxUktmaWQzbzBORmpIVmZvZVRXRDJSZklNZVdpTUJuM0dTaUpZckVW?=
 =?utf-8?B?bTB4aEdGVDZ6UTdES21Sd2hmUml1cTBYNzdkTzFieG9GbythRmJUc3RZYkFF?=
 =?utf-8?B?cTU2N3lvc1NOYzdhMlJpM1NRWC9ueU1SR1lobGxFcncrYUhIZ2kwelZGbVND?=
 =?utf-8?Q?f5hx43XpFDiPQpiXNDereEU3t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007cc2b3-44fe-42a5-dd12-08dce39bbd95
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 11:08:42.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj7kmWBK3+u62nlwmITlcg3LcPd0z3ED37f+kOk7hc8zUf69+j2/74KoN9/Nb+0XvHTlPmqzYM00pwMXuterVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

Hi Tom,

Thank you for reviewing my patches.

On 10/1/2024 7:13 PM, Tom Lendacky wrote:
> On 10/1/24 01:34, Manali Shukla wrote:
>> From: Nikunj A Dadhania <nikunj@amd.com>
>>
>> Virtual machines can exploit bus locks to degrade the performance of
>> the system. Bus locks can be caused by Non-WB(Write back) and
>> misaligned locked RMW (Read-modify-Write) instructions and require
>> systemwide synchronization among all processors which can result into
>> significant performance penalties.
>>
>> To address this issue, the Bus Lock Threshold feature is introduced to
>> provide ability to hypervisor to restrict guests' capability of
>> initiating mulitple buslocks, thereby preventing system slowdowns.
>>
>> Support for the buslock threshold is indicated via CPUID function
>> 0x8000000A_EDX[29].
>>
>> On the processors that support the Bus Lock Threshold feature, the
>> VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit
>> Bus Lock threshold count.
>>
>> VMCB intercept bit
>> VMCB Offset	Bits	Function
>> 14h	        5	Intercept bus lock operations
>>                         (occurs after guest instruction finishes)
>>
>> Bus lock threshold count
>> VMCB Offset	Bits	Function
>> 120h	        15:0	Bus lock counter
>>
>> When a VMRUN instruction is executed, the bus lock threshold count is
>> loaded into an internal count register. Before the processor executes
>> a bus lock in the guest, it checks the value of this register:
>>
>>  - If the value is greater than '0', the processor successfully
>>    executes the bus lock and decrements the count.
>>
>>  - If the value is '0', the bus lock is not executed, and a #VMEXIT to
>>    the VMM is taken.
>>
>> The bus lock threshold #VMEXIT is reported to the VMM with the VMEXIT
>> code A5h, SVM_EXIT_BUS_LOCK.
>>
>> When SVM_EXIT_BUS_LOCK occurs, the value of the current Bus Lock
>> Threshold counter, which is '0', is loaded into the VMCB. This value
>> must be reset to a default greater than '0' in bus_lock_exit handler
>> in hypervisor, because the behavior of SVM_EXIT_BUS_LOCK is fault
>> like, so the bus lock exit to userspace  happens with the RIP pointing
>> to the offending instruction (which generates buslocks).
>>
>> So, if the value of the Bus Lock Threshold counter remains '0', the
>> guest continuously exits with SVM_EXIT_BUS_LOCK.
>>
>> The generated SVM_EXIT_BUS_LOCK in kvm will exit to user space by
>> setting the KVM_RUN_BUS_LOCK flag in vcpu->run->flags, indicating to
>> the user space that a bus lock has been detected in the guest.
>>
>> Use the already available KVM capability KVM_CAP_X86_BUS_LOCK_EXIT to
>> enable the feature. This feature is disabled by default, it can be
>> enabled explicitly from user space.
>>
>> More details about the Bus Lock Threshold feature can be found in AMD
>> APM [1].
> 
> You should mention in the commit message that this implementation is set
> up to intercept every guest bus lock. The initial value of the threshold
> is 0 in the VMCB, so the very first bus lock will exit, set the
> threshold to 1 (so that the offending instruction can make forward
> progress) but then the value is at 0 again so the next bus lock will exit.

Sure. I will add to V3.

> 
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>      Vol 2, 15.14.5 Bus Lock Threshold.
>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/include/asm/svm.h      |  5 ++++-
>>  arch/x86/include/uapi/asm/svm.h |  2 ++
>>  arch/x86/kvm/svm/nested.c       | 12 ++++++++++++
>>  arch/x86/kvm/svm/svm.c          | 29 +++++++++++++++++++++++++++++
>>  4 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index f0dea3750ca9..bad9723f40e1 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -116,6 +116,7 @@ enum {
>>  	INTERCEPT_INVPCID,
>>  	INTERCEPT_MCOMMIT,
>>  	INTERCEPT_TLBSYNC,
>> +	INTERCEPT_BUSLOCK,
>>  };
>>  
>>  
>> @@ -158,7 +159,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>>  	u64 avic_physical_id;	/* Offset 0xf8 */
>>  	u8 reserved_7[8];
>>  	u64 vmsa_pa;		/* Used for an SEV-ES guest */
>> -	u8 reserved_8[720];
>> +	u8 reserved_8[16];
>> +	u16 bus_lock_counter;	/* Offset 0x120 */
>> +	u8 reserved_9[702];
>>  	/*
>>  	 * Offset 0x3e0, 32 bytes reserved
>>  	 * for use by hypervisor/software.
>> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
>> index 1814b413fd57..abf6aed88cee 100644
>> --- a/arch/x86/include/uapi/asm/svm.h
>> +++ b/arch/x86/include/uapi/asm/svm.h
>> @@ -95,6 +95,7 @@
>>  #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
>>  #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
>>  #define SVM_EXIT_INVPCID       0x0a2
>> +#define SVM_EXIT_BUS_LOCK			0x0a5
>>  #define SVM_EXIT_NPF           0x400
>>  #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
>>  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
>> @@ -224,6 +225,7 @@
>>  	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
>>  	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
>>  	{ SVM_EXIT_INVPCID,     "invpcid" }, \
>> +	{ SVM_EXIT_BUS_LOCK,     "buslock" }, \
>>  	{ SVM_EXIT_NPF,         "npf" }, \
>>  	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
>>  	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index 6f704c1037e5..670092d31f77 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -669,6 +669,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>>  	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
>>  	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
>>  
>> +	/*
>> +	 * The bus lock threshold count should keep running across nested
>> +	 * transitions.
>> +	 * Copied the buslock threshold count from vmcb01 to vmcb02.
> 
> No need to start this part of the comment on a separate line. Also,
> s/Copied/Copy/ (ditto below).
> 

Ack.

>> +	 */
>> +	vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;
>>  	/* Done at vmrun: asid.  */
>>  
>>  	/* Also overwritten later if necessary.  */
>> @@ -1035,6 +1041,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>>  
>>  	}
>>  
>> +	/*
>> +	 * The bus lock threshold count should keep running across nested
>> +	 * transitions.
>> +	 * Copied the buslock threshold count from vmcb02 to vmcb01.
>> +	 */
>> +	vmcb01->control.bus_lock_counter = vmcb02->control.bus_lock_counter;
>>  	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
>>  
>>  	svm_switch_vmcb(svm, &svm->vmcb01);
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 5ab2c92c7331..41c773a40f99 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -1372,6 +1372,11 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>>  		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
>>  	}
>>  
>> +	if (vcpu->kvm->arch.bus_lock_detection_enabled)
>> +		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
>> +	else
>> +		svm_clr_intercept(svm, INTERCEPT_BUSLOCK);
> 
> Is the else path really needed?
> 
> Thanks,
> Tom
Correct. It is not needed. I will remove from V3.

> 
>> +
>>  	if (sev_guest(vcpu->kvm))
>>  		sev_init_vmcb(svm);
>>  
>> @@ -3283,6 +3288,24 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
>>  	return kvm_handle_invpcid(vcpu, type, gva);
>>  }
>>  
>> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>> +
>> +	/*
>> +	 * Reload the counter with value greater than '0'.
>> +	 * The bus lock exit on SVM happens with RIP pointing to the guilty
>> +	 * instruction. So, reloading the value of bus_lock_counter to '0'
>> +	 * results into generating continuous bus lock exits.
>> +	 */
>> +	svm->vmcb->control.bus_lock_counter = 1;
>> +
>> +	return 0;
>> +}
>> +
>>  static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_READ_CR0]			= cr_interception,
>>  	[SVM_EXIT_READ_CR3]			= cr_interception,
>> @@ -3350,6 +3373,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_INVPCID]                      = invpcid_interception,
>> +	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
>>  	[SVM_EXIT_NPF]				= npf_interception,
>>  	[SVM_EXIT_RSM]                          = rsm_interception,
>>  	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
>> @@ -5212,6 +5236,11 @@ static __init void svm_set_cpu_caps(void)
>>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>>  	}
>>  
>> +	if (cpu_feature_enabled(X86_VIRT_FEATURE_BUS_LOCK_THRESHOLD)) {
>> +		pr_info("Bus Lock Threashold supported\n");
>> +		kvm_caps.has_bus_lock_exit = true;
>> +	}
>> +
>>  	/* CPUID 0x80000008 */
>>  	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))

-Manali

