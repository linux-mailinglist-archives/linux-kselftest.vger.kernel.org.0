Return-Path: <linux-kselftest+bounces-10918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39598D4C75
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390B81F225C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5E1822E2;
	Thu, 30 May 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Lsb5Pro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01930172BB5;
	Thu, 30 May 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075212; cv=fail; b=RUeHjG/nPnQj3C/1o70/Y5I1Ga3v7ZefAJPwu8nfGALf5s/f8XNbHAbTAN548k45DXnkTQgqC69RBUD47BXgUQQ14dcgRXZS3tj8mNTtfCenC322SuGiLNY3ILEKAnszuEZ3EvkxAiShEvT7yk6Ppj+y8dtCM5QAiapYlbaWmBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075212; c=relaxed/simple;
	bh=AM8v09odSoexevCCipBL4oMuPBeK8hyEaRhgJ1674Ws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MVrQDNF/eo5QZxNCEAEwu71RgMsTwmLihpmyw4TV7oAsIhWHm1fAccE7Tf9oNOA48/KVKy2EDKB5Dl+pt0enSO4OMoHfPYriLlMSYgCOZC0JWtpigRgPcJB0AzHatYw5TmvrIuvFTCNn02KsprVq40hEyP7w352J1QCqD3P1IFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Lsb5Pro; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llhhOm1DssAuIS/3ZcpaYCP51leMTN0EZPztFwKsl5NdLpy1ou67gHIjogi8a4l07tYma6ek/XHl+4+pjYIIkgRhM8bpVghjkhmcsb8lYGfPs+6TkpFdDxdh0x3IinYS0qZ7VnbHSYB6XWIRmzyMFKZJ3cJnGDaxHRoPdhnyo2dUy0Xr9rDkLcggYofN6qcZpODY/qK1MwYQfm46POhQPIxoxSNtIOBiFYYXwFvEqGRPJvyh09TCQ/+21SeEAI8O2/Z2rJYL4OT6PBNZGJct5Bk6kjNaUR6pmhlbaNrpW+JMsHpDDjPeK+xGFZCRDGrVdZiL8iIvOd3gvoLtluZpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxrZ/qmoN8KBhl4C+fEWkVCKrfQylixa6X0kAeKfEUc=;
 b=bNqe7ifhQOBi2f4+/Xl4OaVogwRpDkIDtY6dD/jjQ/w7Th0TG/AsJJXgqa5V4ZjZ2JLum2BP8sAAB24vKDVv9g2VSOa54iOQL7V8g7Y4E73ZdCwVI9KfIkzAnTOthwmJaDrXAmCGzbmUNailGDjJHWu1EEyhErOfrz0dL6YSRMtZg5WfMonKZc58UKlG3PVCFt/hpRyHxx2X3mVTwhBKWqPhUjyhO6Inexjp6Uz3ImSxzFmSAXik4iXWKUMRndRJigpOHocQU/XKvdMyXLeC7hsDQZxzfh5aECnPv6xAvxxqg27bqv8UhkroP2uXWQsCQb2RSOFCR69E/bg3UNzr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxrZ/qmoN8KBhl4C+fEWkVCKrfQylixa6X0kAeKfEUc=;
 b=1Lsb5ProJQRue8wD9nc9YCFerejbFvQHKKcMvYmtv/tT50ym4kWuaYJ4icAavpO2Wodz6SPfw2W3/YsXqbTi0VSHIR6k5FpvsSKGb4U1vZFLkc4Lpkoex5POxHkZmB3wlzF+eHtmhrfqWs/o6DF59Gz29knZQSDqz602bbpGYQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Thu, 30 May 2024 13:20:07 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7587.035; Thu, 30 May 2024
 13:20:07 +0000
Message-ID: <b45bc797-9087-4456-ba18-463c3f638096@amd.com>
Date: Thu, 30 May 2024 18:49:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept
 test
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 ajones@ventanamicro.com, manali.shukla@amd.com
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <20240528041926.3989-6-manali.shukla@amd.com> <ZlWLupfpODawPX3P@chao-email>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZlWLupfpODawPX3P@chao-email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b3faad-51ff-4974-211b-08dc80ab391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHJkYlZXMzVyQ242bEdZTm8wNCt5Y3N4bnJGTm0wRU0wNmxNT2d6MGkrc3E1?=
 =?utf-8?B?OTBVVWEwK3F1RGV0Y253LzZiNGVxOTI1MldwQnlaTlhpY3ZORlBsc3l6R3Js?=
 =?utf-8?B?YnlJNW9JMU9KbHEvenY1M09xL1JhZzYwUnA2eThpays2U0Rna3ZRVjJqVjlH?=
 =?utf-8?B?a2ovYWJXRlBxNDRMQWV4RWtDeTVyT2ZMSHQxWm1TMTM2UjZOdzdKbUx4ZEV3?=
 =?utf-8?B?OWJrbUJTczZHSzRsaytEcVhKWkQwUW0xUjhCaFpNOGNuOFExV3RnVnNuNXBq?=
 =?utf-8?B?NFF6Z3UvV2dSbHh3aGd5NGpSWjNJTE5HOU5PaDI1ZkRFSThwNmFFVmlRY1Zt?=
 =?utf-8?B?OVVhVWlFYThkTWhkNE81dm10YWFJTS9OZmRSd0x5TW5oL2sybm5La3ZMQXF1?=
 =?utf-8?B?c1BlMkZ4czBzYis3M1FCUUpXcm1kQnoycXNTSmNWSkdiRzR6blRlRmRmVlFY?=
 =?utf-8?B?TVZVU3RybzdYcm1oaTYxWlVjWGplbG1NeXdYQ2Rxbzc0elVHNDVVN1ltU3RQ?=
 =?utf-8?B?SmFGQkRHS0xoQVlMTWk3dFVJVFVaQ3NCT0xDWnNnd2ZkdjlobVpQb24yZW1o?=
 =?utf-8?B?TDF0QjVZOFJucU9qbGxJWGsvdm9zT0VPSlYvUkR3d1I1VDVmRVBiOTlBc01x?=
 =?utf-8?B?SXhla3p2eDJ4R0J2aGN1ZnhHTzJ3NTMyYmNIY0ZuTUtQT09vY2htOG9GbDhZ?=
 =?utf-8?B?UWc5QzZtaklsOUFhMUEvdk9ueXBqNTA1WDEwdlpqVUw4OG0yNFBRbWRTT2p6?=
 =?utf-8?B?MVQ3Yk9qTGJIcHVQekE2ZlVnSHV3Tk51N3Y3NXpZcnFlZ1B5ck9OUUthU1Zl?=
 =?utf-8?B?ZTBERnduclFQVnFvNmYwdmJyQkY3akMyeUhEYk92S2RMZ1IzdGRjVkZSUFRK?=
 =?utf-8?B?R2ovb0pPZGR6bUdwcHpkK2ptNk1WOElkNmVYeW5nbHg0N2tNTHllNmFIZWNC?=
 =?utf-8?B?Y3ViVHlCd1BDekN3UDRDMGhyQWtUSGlPSWdWZ1UwQ3R0L1hzazlRWUN1WDVr?=
 =?utf-8?B?eWlJMzJOL25JOFhOZEVlK1FFenhxWk5Vd3ZQZnhWSUpUM2VVTFlxN1l2cUNo?=
 =?utf-8?B?eXMycVhYVEsvMkx1L204cjl5SGZsUnBWYUg3aXVBaFJpUlJIb1Rqb044bTQw?=
 =?utf-8?B?UTNnUTY3KzRwSEdsWGpFeUp4LzEzTXphK3VkYmFjd3VpWUx5b2JBa29zWEsw?=
 =?utf-8?B?Y0xBa0g0V1JyeFhSU2tocTI5TEFmR29KYnd5N3VqRTVxZDJtWUxuM1JoTGFq?=
 =?utf-8?B?ZWwrNFJWdlBHK0x3aFRzWkp3SXN5b1VOU0ZJL1VWVWIrNm9hd29IVitkbnJY?=
 =?utf-8?B?UFg1dWNMcmFvWmI0VUxDN2JQc1FQWGRDRXRsend5N2tWbXVvOE9mN2dVSjEx?=
 =?utf-8?B?R1JUeWNwY3pNaTN4cUtMbTVmYlBpcWYvK28za3NjZmthVnEvSUZjQ1gwdjg5?=
 =?utf-8?B?Uy9wVitmUVdUT1ZkNE53N3dmSXFtUTRMNXhlYmNvdEQyd2pQb0RCL3pRdUtl?=
 =?utf-8?B?ZkhWem1nWEVmOUxUZW5xWWFTNE00N292Yll4bjJEc0NXNEthdWl2cmgrU2ZS?=
 =?utf-8?B?S2FnRzR5SEdtdld2dEQ3K0kxUVArZEIxcUFQT2wrajlUTXJnRHdLUUh5cFoz?=
 =?utf-8?B?WXNiblpCT1NONVdKd0ljcE9SNENkWnJNTWlqclJxSEJwYTIvdlpCV0hMa0Rv?=
 =?utf-8?B?UVRnaHdGQWl3T1N1NGFXS1hCeVVFUWtHQ05yRWNuV09ZUk5lWG5NeWFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUM5WDBXeUVoYmdTeWJPaHVjTFhQb3RCRnhTa2dIT084QlVrN2t6RnRsdUdU?=
 =?utf-8?B?ZDFIYVFKUWlFMnQwckNPNm5zbHlGaEFKRkRVZFQxem92UEQycWFXbEgzSDlJ?=
 =?utf-8?B?Z2toZXlNMGlsNGY3MGhpQnBkU0x6Z09LUEdnbDJyRkV3d29pSzlsMVNHTVF3?=
 =?utf-8?B?d1lSc2QxMFVNMVJWSkVYSGlOUk90UnFpVkFyL1M2SVpUcVF5SHlpNU1YTUt6?=
 =?utf-8?B?bjFYdXh3cm5CcFZ2OVk3bm96Y3VlNWxvWHJsbmw1clIzdUJlbEExQ3I1WDdQ?=
 =?utf-8?B?NXlMdENXL0tHenhQRGs1OWkxOThRd1VSOUh0WHQ1dk5pRUswaVRqbmRHNjQz?=
 =?utf-8?B?cXBCL1FMZFhWR0NiZlc4VG5PcFpuZVJ4SmpDU2M5TnJZMnhsb2JKb2hRVmpr?=
 =?utf-8?B?czR4b25Dc2FIdjdsNitMVU5LNzljaVpkM1R1Sy9pNkJybmR1QjZNWmFwRG1j?=
 =?utf-8?B?ZXhUbTN3V3N2RjhJMzVZUHNtalRRYkxRVnROTG1OZGdQMnNMZlF3SzR5UmZE?=
 =?utf-8?B?c1JOdVd5TllSZFkzbXZtWWR1NFlydTdCdUZvTWV0WmJ4N2ZUdkZMaTR0U2hE?=
 =?utf-8?B?VFhoZEdzSU54dHdHMzhLVHVmanNWWCswdHh2dERaYVBadndLTklCUFBra0h4?=
 =?utf-8?B?aHhPSUJyVlF5OEE3Z2ZPdlNyRC9xZS91ZG8xRy9USklhbXp6QnFzSktjbE5I?=
 =?utf-8?B?R3IwWldlZkhRdEwrdjdiNnhrU0FKSkVkT3duTDVRYkFlODBFbUljTzY5L1Ra?=
 =?utf-8?B?ZFRmOTJqUnE0c0l0L1daYWV0dDdKTk5oRFA0UDk0cDJCN2htUnFxTWNtRXcx?=
 =?utf-8?B?YmRoblZnZks4VHcxUFVnYURFc2ZsY01ieUNaUXNLeEgxc3FhblV5MFRoWk1X?=
 =?utf-8?B?YzgyNlgvNlNhWTlUZGpGZU55dmkzckN6QmFJUUFad3kzM2swVWlETi91SGFZ?=
 =?utf-8?B?Y21jdzloNlRvU3NSY0FIM0l2SjdQZnpzU083bEZ2YVMzQ2wrREtBN2FuSmV3?=
 =?utf-8?B?L04vOWkwVjE0bGdNSHhPWWh3d1I3MjBIdDBJWXdqeE1GWkhrSDNrL0FFR05N?=
 =?utf-8?B?TnNuZXdSTHMzWEtYVmQvSFliVnErdk5MSEluZCtsd1Q3Zm5NUG8rNmIzZUJK?=
 =?utf-8?B?K3V0VHFnZ1loSzZ2QUlSc2dhYVpSU1dpZmhXRTIyeXpScW1RODFUWm9sVjVX?=
 =?utf-8?B?K1I3ellIYTVzUWpLZmNTRTQ3SHRTNk1FTTloaVdVNGgyV2VqOHRPQS9aNjM5?=
 =?utf-8?B?ZU9nWmY1NlIwcGk3em9NbkIrNjB6d3daam1QQWl2VkV6WFREdXpUcmRjTkFO?=
 =?utf-8?B?ZXB1TUQvYU5HdUpKc1ZydGtEVHNuQzJxRjNVMWdnL1dDM08vaDVWS2ZOdDdy?=
 =?utf-8?B?SmdVVXd0V2QzbDhuaDJhNSt1SUlwbDZkdFN4VHBqMW90VnFoUFoxdXE3STJt?=
 =?utf-8?B?TnV0cjdpd25xRHVYV2JHVGlUOVM4Q3lkUFpjQ05BZHpWNkkzMHdrWnk0TnJG?=
 =?utf-8?B?UHlMUHhsZzRUYlIva09uT2hVZllEM2tweWJwUThYVUlBU0FveGRYWm5oUFcx?=
 =?utf-8?B?bVJ2Q0puSzhibFUyTTJ5U2ZVUW01OXJqVm9Zc0pUQnhXTTZJN0tZMnM3RFI5?=
 =?utf-8?B?c05tenJnS3Vhc0JHRWFjVjE3Y1o5dmVOQnZvKy9pbURwcFh3UU9jbjhleVll?=
 =?utf-8?B?Zy91TUt3TEJGUXFpbXI1ZjV6eDVqTUt5L2M1Z3FkZWdLbW5zdU14ZDNqcDZW?=
 =?utf-8?B?Tkk3aC9abEZxbHh4NkVsV3FVQ1MxTlJrdTZnZkNLRWJBT0JXRU5BUStURGtn?=
 =?utf-8?B?SGFvS0tuVmZnbHFPNXpRd1ZUWGt1RHIzaEhTOUtJeERRTXozci9qOWI5M29u?=
 =?utf-8?B?c1oxd045OEJWVkY2T3NRaVRhSWsrYVlZZXZGT0tEQms2eE4xTldNUGRONXhu?=
 =?utf-8?B?NWlxN3haMnlPVjRTM1BDcjFnd2VuQ3ZncmxHS2g0ejZ4K09XMTMxOFM4Z2FP?=
 =?utf-8?B?ZDFZa1Q4QUxVRXdINlBTTnlwaXZQQzFzVEZjWnY5QVNDYkx2VmhsQTFTUkd4?=
 =?utf-8?B?SmlSR3FVODFiNms1Sm5GaVhBcVdDTGVUSDB2MlY0bm1iUzBSaSttUjYwcURm?=
 =?utf-8?Q?k4WoP8D7B0FR58snlLzLhtg8n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b3faad-51ff-4974-211b-08dc80ab391a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 13:20:06.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqL7518mdrXfFhKVoM8T2s99T3RKRGrYL6vJTZHBmRJiALcMlXVcI5NJwcNe1y6MR3uWmC5UdU86iUvuW1JC1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

Hi Chao,
Thank you for reviewing my patches.

On 5/28/2024 1:16 PM, Chao Gao wrote:
>> +static void guest_code(void)
>> +{
>> +	uint32_t icr_val;
>> +	int i;
>> +
>> +	xapic_enable();
>> +
>> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
>> +
>> +	for (i = 0; i < NUM_ITERATIONS; i++) {
>> +		cli();
>> +		xapic_write_reg(APIC_ICR, icr_val);
>> +		safe_halt();
>> +		GUEST_ASSERT(READ_ONCE(irq_received));
>> +		WRITE_ONCE(irq_received, false);
> 
> any reason to use READ/WRITE_ONCE here?

This is done to ensure that irq is already received at this point,
as irq_received is set to true in guest_vintr_handler.

> 
>> +	}
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_vintr_handler(struct ex_regs *regs)
>> +{
>> +	WRITE_ONCE(irq_received, true);
>> +	xapic_write_reg(APIC_EOI, 0x00);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +	struct ucall uc;
>> +	uint64_t  halt_exits, vintr_exits;
>> +
>> +	/* Check the extension for binary stats */
>> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
> 
> IIUC, this test assumes that the IDLE_HLT feature is enabled for guests if it
> is supported by the CPU. But this isn't true in some cases:
> 
I understand you are intending to create a capability for IDLE HLT intercept feature, but in my
opinion, the IDLE Halt intercept feature doesn't require user space to do anything for the feature
itself.

> 1. an old KVM runs on new hardware
> 2. the feature bit is somehow cleared, e.g., by "clearcpuid" cmdline
In both the case, the test case will fail.

In General, if the feature bit for the Idle halt feature is cleared somehow, or new KVM runs
on old hardware, the idle halt exits will be replaced with halt exits.

If the old KVM runs on new hardware, the idle halt feature is never enabled via KVM.
So, the presence of a pending V_INTR event during the execution of the halt instruction
won't result into the idle-halt exit; rather, it will result in a halt exit followed
by a vintr exit. 

-Manali

> >> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>> +
>> +	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
>> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
>> +
>> +	vcpu_run(vcpu);
>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>> +
>> +	halt_exits = vcpu_get_stat(vcpu, HALT_EXITS);
>> +	vintr_exits = vcpu_get_stat(vcpu, IRQ_WINDOW_EXITS);
>> +
>> +	switch (get_ucall(vcpu, &uc)) {
>> +	case UCALL_ABORT:
>> +		REPORT_GUEST_ASSERT(uc);
>> +		/* NOT REACHED */
>> +	case UCALL_DONE:
>> +		break;
>> +
>> +	default:
>> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
>> +	}
>> +
>> +	TEST_ASSERT_EQ(halt_exits, 0);
>> +	pr_debug("Guest executed VINTR followed by halts: %d times.\n"
>> +		 "The guest exited due to halt: %ld times and number\n"
>> +		 "of vintr exits: %ld.\n",
>> +		 NUM_ITERATIONS, halt_exits, vintr_exits);
>> +
>> +	kvm_vm_free(vm);
>> +	return 0;
>> +}
>> -- 
>> 2.34.1
>>
>>


