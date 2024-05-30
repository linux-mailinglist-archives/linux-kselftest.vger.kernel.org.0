Return-Path: <linux-kselftest+bounces-10964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D98D5475
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687BF1C24B61
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B12145B3C;
	Thu, 30 May 2024 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZOpUEPr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52604D8CF;
	Thu, 30 May 2024 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103714; cv=fail; b=lCUN8lW2YLRwtydODAk/qqWduaJbNQzpME+GI0d8SFS2rbbsU04Ej15oaGT8G8qEF8jdx21qCZ5dX8JQrPJqneKpFa12aCdwKs7t+ArrJtzoHG4p3wEo/Wk6N6e8TtttgxkCbre3CkSZRQfNgYleQqr/31yrBID6bF9JkSs/3X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103714; c=relaxed/simple;
	bh=TvQGNfYjVd6EDqBYgzKmlSRue3S9J8bOfJhef/vHoSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+B9MGq/rkoIn9c2s+kh+6trUgAjKWCodVseUwsmNdglIKZ82EGG5z5u+Ow7d2oZgRR8LxX8mGa9Q14iDsUeBQDKv8+0xOSbmFgwmBjPJmxhSnp6m76D7HBlNB/Gil9gL0JM0x3DMjDqPDn3I2UX/+XB6qVrzF3ijTDAkqj3Crg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZOpUEPr; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzf6/XMjcfnSzxXInsBEi1CCfmkaxPHNLBl28XjW/8AjruXTmBlmmmx7TI1iS7bl/BUCn2sz4cqUnxkuMA7v8PppouMBZqgvaIfzS5RL14hfFPY1+8BPG+GObevpKr/i4ZBSPX8oEsaEj5Rpk+63LyKpyshLhALTmjddnf/2kSZ28gRQ4vwRpU3nrSMquLoleKdWcslIoYd/KpS7pXRWZsfyUiEGFZS6QlMJBE6Ney2cr+XS318QXe6edQGKxkNbPaqh/u3y0qjMTFLLU2VCnMTBHgxuaZql+c+apumHX98ty4awolN2JCOtmrzId1uF6W9Px8AALICe9xf3lQzYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMkrdeN+a/vs7ZvXa/HlVOIxAsEJpc+ma0EelA/FKQI=;
 b=Ta3xvz8M9/VnX+PXurKJ/XGqcwN+IQNAF2tF87v9KFjkDUZGynwnaq4JmLhTqEwELwzixoJ61FtDXHIRAhyJJOQkecaVuT2q/NuRQ+oOHJQNgH9/A1L5j2dZrdzQR8rZtbrPidqWAkBEHTc0t0KJS84+9BOYi9pfkAIJOzdqMlUEm83UF4mg7aKet3EfMMZuLI7lgvK7eMzzFUA4HutFpdkhuWdpkRqq/Dnr/gexa2y3hfvmRAyKvf9lDP74SryAb0G4slLnRIJFw6v9656Lyajos4XAFPv/monwx8BRQXh0O2D7HxWJAUo6n41hgJayhblP154i/aV2New3dZkLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMkrdeN+a/vs7ZvXa/HlVOIxAsEJpc+ma0EelA/FKQI=;
 b=rZOpUEPrYYDm0MIqBQLNXYwknrEsysc8QlJC3EK4E0zXSh3Dn/VeFR5xGYjQ4acSibrdvWbQ7tWGfwm6fJFJlsr2DJRwOg1OBWdGWM8ynXRdfRBTKL6eqdGtayikuBhESxFfoD5xwd2bcZD2gxxVxpWYsjG0tty338AOSMBr8EtFOKogXa9jUlR9r4A/ycgGWzE4eQ6+WRp4VjCtUncBHXMfWgp6sBK1/DXcl5MVuJ8BwCkFc09orhwvOA4gx8ZL0HlCmMHx2B+lz383KAnnaB63/6E8OxbeLrDzJ/mav0hseOzQcxb9BwyTaCgtDdshVqPzJ6KaxtcQQ1R6y+rp2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 21:15:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:15:06 +0000
Message-ID: <6bca860d-2189-40a8-9588-11edd3b3840e@nvidia.com>
Date: Thu, 30 May 2024 14:14:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/futex: don't redefine .PHONY targets
 (all, clean)
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-2-jhubbard@nvidia.com>
 <ceb9182e-b6d4-4f6d-bb53-87efe5337230@linuxfoundation.org>
 <20ebb3a6-cdbb-4ffc-9ba2-c9eaa4d6ec74@nvidia.com>
 <3db9068e-9f95-4ad9-86fa-e24b06da8828@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <3db9068e-9f95-4ad9-86fa-e24b06da8828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 6683ac54-465b-407f-dd0e-08dc80ed9420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ei9JWFY4S05WcnR6SEtsdGJaNXFadzZPdW1WalB1T0NLNnZRSWhuUTZBQU00?=
 =?utf-8?B?MTgzZEVvbjdkRStVYm1XNkJLN25zSWsvekFrdmRubHBORm9Rb2FlMFFXUGRp?=
 =?utf-8?B?d2dwNW9RMW1odFRadkxVdTN5RTVyUzdGdFQ1c1Q2TXVsTmh4cThDclpmcFBs?=
 =?utf-8?B?LzNmWUltMlZDTW9xWWVhK1N2ZzFQeWgxQXdYNU9ld0VGL24xc3kxWU1ZTENa?=
 =?utf-8?B?NzdTaVhNRDlkdzI0a2RFMzdmYjhjcm1LV1pKSFRDL3JXT1FKRVpuQ3l0NGt3?=
 =?utf-8?B?WmFDVWFSL1c0a0d3SkdXYldPa0xycjFiUjYxbzVGN0hwM3hkRjY4RTY2djg0?=
 =?utf-8?B?Mm9HaE92N3NJNGhPa3ZmZEtwOFBmbm84VStSZzltN0s5VUlsNTh0SFl1eWpk?=
 =?utf-8?B?WERrbkJqbmN2aFpManozMThJdnA4MUZpNU9DcUVVeG9URHJUQ3V1MUpyWDNi?=
 =?utf-8?B?elUrZkJBVEVqazB5L1NPR3pCTU5IbWZUM01FNFI3Tm51RjBQMGJrcmp6VWVv?=
 =?utf-8?B?M2kvZzVMVm5hWFBuL21CMDBIVFBKRENhN0xWU29FNlZWQXlqUkUyeUV0SHBn?=
 =?utf-8?B?cDdTTHNNMGFJckgrZ2pZTHFtZytveXI1R0lCZGh4RXZaL1FRNFN5dEcxai8v?=
 =?utf-8?B?WE4rTDJUTkZUSXc0NHJnZmFIWkxSRmRXdVZNVlRVbk5td2JwS25wTllGTldh?=
 =?utf-8?B?ZnlYcXUybXN3aE15OVhDZmNIWUxsWjJsWW5lRXhSVGNGSFhZMTNZbUljYkdQ?=
 =?utf-8?B?VERlUzVUMlhLZnhrbTYvYVNxNWJCZ3crTXRuUlYyaWM4YU80Vm5sNjUvZUZv?=
 =?utf-8?B?OS9kUnBNay9NanFELzlCbkF3dU01eC9mMUIyYUY0enl5UW13TitJWXF6bERC?=
 =?utf-8?B?amRtNWpMbzc1M0tUS0RML1VBV1A0VGw1WHR0Y2lRYUYvbXYrcHY4NGZQc1NE?=
 =?utf-8?B?K0R2NGw0a2VaS014c3FhV1lqQld0WXc0K1dYZE5UK0RYb3o4bVRHdmMzUkVJ?=
 =?utf-8?B?ZFV3elR1a05uK2RYQmlIWWdtaXA1cTROMHI3bFVwcEFKaERFWEM0L3gwNUha?=
 =?utf-8?B?Y0sxTGtPeHZ1OVJOSnR4cFB3T01lS1ZvcHpWcDBOQVZSN3JnRmJybXZ0N3Fl?=
 =?utf-8?B?NlZrRjQyQVVFQWZ6c1pNbURSZ2xwL0phYzNHeVFZaG5MbDNldWZCVzNTenp0?=
 =?utf-8?B?bTgzYnZENXVvUlRxM2s0bFJ2aHN5ckZseG1sUWpXR0pRc3JDMUJkTmJmK201?=
 =?utf-8?B?VnFPUmVlYlc3MDR3RlRxUHMxZUNGSjlwUlZsb1A4WTdOOHhTRGJyT3NDbU9K?=
 =?utf-8?B?ZnBWdE1GaURQUFVDTUsreDltcXY2S3NBeTIvcjNPSXI4QlF0YVMyQkdFb3Va?=
 =?utf-8?B?cFZuYjdGT2QrS09Rd0VwNnFrLzBkcUJzSHBSQStwL21kbm1ESTVaa2dpN1hN?=
 =?utf-8?B?UDI5NStRRGM4OFhmczJSZXg4V2V5TEVSMHNvS0JYazY1UmFoNnRHQUVrWm11?=
 =?utf-8?B?cUtFVk9iazh0aFBIODdjOCs1eHZTZGFSVzE0M2lPVXVhcXZoN3hDTnAyNXkx?=
 =?utf-8?B?U3g3UmxXQ0crcHkxNklISkQ3N2pnWnd4aFNScWxSK0ZId1hBWGttWDh1MC9D?=
 =?utf-8?B?MVRPOVBoV1pDcnhQK0l2S0lITjZTay9wTWZRelBXY29HMmVydFd4VUhUY1Vy?=
 =?utf-8?B?TWw4dkhCUkVjOHFQRmxvbUZMTGo5bXhNdERkT2ZrODZTNWpPYUlpdjRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFEN2xVV1RGRWRnWEVkak52ODJ0NHF3UHR6UVNQZWNLTDkyUTFVVVFBOW0y?=
 =?utf-8?B?UmFhWUZEMHVORENGYUhWT3FxSVYxNXJqb2lndGtEOVphVm9ZS0pzU0g0eU5h?=
 =?utf-8?B?Z2c2NWZiL0Jtb3Y5UFJCajNLeHpLVFREb0VmYS9NQ2l3aVcrdmdCcjB4NEFu?=
 =?utf-8?B?RlBvVU9iNXdGeUhIMy94dksydm9NME5kTzh4OVoyUEsyaUFya2dSanFqd3A4?=
 =?utf-8?B?OVlHM2FYZnlSbmdNVkRoRUNxVDFIZXpuRjZ5Zi9SZ1U4RWRwQXdQQytodnlu?=
 =?utf-8?B?OHBWTmhSbWJQMzAyVnRlNjR2OVF2cndXdWtPZmdRQ2xwbGsxaDdJMkdKb0Z3?=
 =?utf-8?B?ZnFHTXNjcUdlWFBCZGJibVF2TW9yd0RreVhTN1BLWUtad2l2RC84eGFYVzlx?=
 =?utf-8?B?UnVRSVlsbGh5TTQ5S1Vqc29OYlNqVXFaYWJpejFOWGcrK3labk4zVXNmL1RF?=
 =?utf-8?B?NWMrSEZnc3VQZ1RscGxCcHZFKzhIRmZVeTQ3Mk0xZVNvWHJ2VzhTZjQxZjB2?=
 =?utf-8?B?NmFYamRaLy9tek5xc2lmMEVaNTNDYzZ0UGhISW1XKzZyemtuWVVNT3NSWmZH?=
 =?utf-8?B?RW1CSmVWNEY0R1BITTh1VXR6eFJjcWVLVi9wMUg3ckg0a2ZuakFOd1NhYXJW?=
 =?utf-8?B?SlIvUDVQbjd6RWRoVEJEVEVsS1l6eWdJWDRIcnBVVXhaaVQ2dWx4K0pPenFs?=
 =?utf-8?B?eHUvMFNtR2M5L2ZMcHB5SllSc3N6cmRDYldBTWRyQ0tidWRpWjZMaVpPUk1I?=
 =?utf-8?B?LzFEQS9sMkR3alcrMWIxaVBhWTVNVnFmQVUzUDFabHhvcEpUcXI0Qkd5ZVMx?=
 =?utf-8?B?Tko1akhYaGdrQVBCVVNTK0hHeCtFLzdpVjlTSEhBYmNXZXhzMHpkK0sxV2Ux?=
 =?utf-8?B?djlsZnI5MHFrR2FsZ0FmeEZwMllweTc3ak1tYXJGNFVWRko3SGY1V09mTG13?=
 =?utf-8?B?aWd3UVYzY2hMMGJsQ25LNFZReHcxMHFUV1AwbkE3L3UxNHJpdXlMK3NNWERW?=
 =?utf-8?B?TktGWGZUWDBHWnhTUGJralF1Z3JQVG5EWnNXcjhpNkR1bmFIYkpIM2FxVldX?=
 =?utf-8?B?M01wNytxOFBQOFkrRTJ4UzJKU2JGRU1NMi95VyswTDlqVTF1VmZwU1pHZmht?=
 =?utf-8?B?Q21NdFJrMldTRkJEVTM5dk8raHpxUjNnOU9GZVBtK1hQUnhEVzQ1bFhTa2ow?=
 =?utf-8?B?WlFlNHJqOVNLRTVSQmpNK3gvRXFKS0hMcmFNUHVVSUpjdlNKQkRTV1IxRjNv?=
 =?utf-8?B?NFgxbUoyYlAxYkttOHorSkNMZ1g2b0hZZCtHM1JNRVlrcnFEWGcrTStSZ3I4?=
 =?utf-8?B?Mm5ScnBmZXhvMTlGT09iZDhDelZ2TmVOL3Qxdm1tVG9qYTZGcjBEcVBPR0lV?=
 =?utf-8?B?eldUNWRtSWNicENhY0hHb3Jsb2liVDVucVFyTlJQYlEwK1ljVzJtMTc2ZzFh?=
 =?utf-8?B?TE5tYW5rZVBmV1JzSVBLVlBVMlMva2M0TzRtcGNUWFRCVURBeEovU2ZQR2RV?=
 =?utf-8?B?UWZyWldIeHk5aDBEZEIxRFdRb1BPaC9JWTQvWUtGbi8wMUZOblM3dzJXSnZr?=
 =?utf-8?B?cUl3T1JkcGNid0hOYUFGQUdYNU9MY29BTmNWbER6OFUvNm1lbmpVWGRMVFp3?=
 =?utf-8?B?cG1MQkNpT25aTHpUT1l4NlNvblhtajZpajBUSEtGM3FkSGJLT1h5MnRHd3pP?=
 =?utf-8?B?Qk9nUnhXaWhaaytJSk9LQ0prY0lmTXZ1UlAyeExNSnpHaGpTSGN4dGc0WFAr?=
 =?utf-8?B?V0c1K2N3U2FKeWl1RFdvNFJoK1ZOSGEyZGMrL1FlQVkzVC94NHowRzZRZmFn?=
 =?utf-8?B?YnZUSm5jZDZ0TEcwcWREMmxOa3dXUURmbmR6SkJPMnpzajVFZDdtQzFIN3Jh?=
 =?utf-8?B?N2Y0dCt5RHZPcHNWUkxmZUR6OFRQSHJaNFdSRThuZTJ2TlEwQlFHN0NJQU1p?=
 =?utf-8?B?c2xMMmRIaHg3M1RYUklmZXh4ZVI4NnUzMkpNUUZMR0N6YndRSmdJMlI0OCtY?=
 =?utf-8?B?aUJNVEMwWHJWclRUdFVrQWFTNVhGYnBvZ3RLU1FzVks5VmJtMmNTTXFZMDA3?=
 =?utf-8?B?OXBzb3BONmNhVDE4MUIrWkZTM2x3QXV4ZTRiZXNPNm5LM1hvRmZXVFZjdmZi?=
 =?utf-8?B?Y0pXWjloM3JydEw5bTlXSjF0R2QwV3B0cTZTNXU5bnE0TTl4V3E0bWxjdXpl?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6683ac54-465b-407f-dd0e-08dc80ed9420
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:15:06.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mScYNzIzwPy2XcCF/IEACiRpzS23ZfZ/irx2CV7cIh1CcKUeoagIVY5Ue1g7iAn6WEOS9VcuYlxPb2aGSdI+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906

On 5/30/24 2:12 PM, Shuah Khan wrote:
> On 5/30/24 13:13, John Hubbard wrote:
>> On 5/30/24 12:03 PM, Shuah Khan wrote:
>>> On 5/28/24 20:29, John Hubbard wrote:
>>>> The .PHONY targets "all" and "clean"  are both defined in the file that
>>>> is included in the very next line: ../lib.mk.
>>>>
>>>
>>> What problems are you seeing without this patch?
>>
>> Code duplication. It's a sin. :)
> 
> Please mention that you are removing duplicate code.
> 
> futex Makefile overrides CLEAN - just making sure it

(Overrides of Makefile things are per-item, so to speak, not per
file, just to be clear.)

> does the cleanup correctly.
> 

OK sure, I'll update the commit message and post a v3, coming soon.


thanks,
-- 
John Hubbard
NVIDIA


