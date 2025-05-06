Return-Path: <linux-kselftest+bounces-32518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F8AACBD9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15163A3A23
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC042836A0;
	Tue,  6 May 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PhksF7TH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5802222D5;
	Tue,  6 May 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551175; cv=fail; b=rKiHMYy+P7w7Ih6trqfQXoE5aEyCCOFj7kU9CDBcCwPepx1NwZpGF6NjABU2bSZupCGzFfwUmYxm7PlKMfDidhQC0WwrWNZuX0vEP1wGAa3GpiS5vXibxzWwLiWrE7m9UHcPYm6YV9ArbyHdUHxeonPjwcqXFGJCHD7rTThwE0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551175; c=relaxed/simple;
	bh=puO2D0S+s1UXjQAY0Cneno90FjX63GoTqlftRcq/ZEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1FBPG4YqKgQ7ulMeXSm0FVd31xMxxBenhkCcADIWCEC2t8uvKQNc2/f/3L9G9G8BzQ5uPmgMlaCplHVr8ftLMPRQyb15dly6/vRgOJmFs98qeQ4gPeaSmYiQ8LlU+H1nHIUvIHZ1AmCt+WWLCewziFlTDyduh6RNSFEUKj4WNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PhksF7TH; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJezoC+WZJdfe36qFnSx2tMkmXd/ailn/e+iWW0/6MO/uzi9NTP3IyHrdQ+tu5QN8cgThBixipu5i59XKcVwv/bkinYyOfFs/HwKhQqHuB83c3gfI2AFJYcI/+hjF7GU3fG3r5eMp0aKTqbkLSuvs0U2RfERim+ZamOjizQ3O2tpY63N2uKyYWE2LNyyIFjjptziVswoEQBJ3raanjnnYnTUTh8Z8cwNaTLnMiwl9yw4YjGB324XV295p9yOmGvdC3i6TfltcPlth+xb0Z7r7doLrJFs3wYgm79k73PWh4Hjh2CAX2eSIkO/KITNIph/AXtkSdvtSqlm+dttvwP5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXBdJ2j9CH60b4E9swarBMgP8a/iGX1XKeVJYNRqvnk=;
 b=uBaQAjJFO3/F1a2n8+UN2tnZob1HJKcbvP+G4WU+8rn6wmdf2vKIbmCUk1Cayddr1OZ5OeReCHV9UPA96W8q5lQfzNYSo+kbAgZdwD2YXA2p5zk5Z9h/BHBXRBSdfQrsOef+/9LEbfnMmDktfXQE7lh1vL9WFDekU66SUsclgZxFIJxtIqzMDyv5aipejKgcJDXMmTb3OiDeW+bReS+yROnxEFXTr/NcDpr97TLuZKal7OglQDCRXZCz0oeOL5w3vOMaPgKF41kehIZHdkaTsc9uTCHCa63910GlfJndxz/DZ3KJJF3CuBY47GAlhtc1xYWKE8qQBJ9DfJA+4kzn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXBdJ2j9CH60b4E9swarBMgP8a/iGX1XKeVJYNRqvnk=;
 b=PhksF7THAAety1JyMfWpznDHYDfk/sawp0RqWTXuV5E7SzI8YQFMEg20wKMy6023aalB+WR3tlNFfQwQt5pxwmMvOtONNGGK9Kq+gsYodqvGpoZIcRe1impBhwnn1BU9u5Lc+V2gl1MdKdivnLW2FhxgULoXgXSomZ11xMZxkNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 17:06:07 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 17:06:07 +0000
Message-ID: <eea8f995-cd9c-455e-82ed-a3d31b75f8eb@amd.com>
Date: Tue, 6 May 2025 12:06:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
To: Sean Christopherson <seanjc@google.com>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com
References: <20250305230000.231025-1-prsampat@amd.com>
 <174622216534.881262.8086472919667553138.b4-ty@google.com>
 <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com> <aBlGp8i_zzGgKeIl@google.com>
 <34890707-201a-44f9-afb3-b065ae71b246@amd.com> <aBleV3TlvA1QwcSZ@google.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <aBleV3TlvA1QwcSZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0446.namprd03.prod.outlook.com
 (2603:10b6:408:113::31) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: c9af78f9-c6ea-46dc-3cb9-08dd8cc04a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1E2ME90VGkzZXAvVVA1a3BzYkVKTk5JMDdSNWsyaDNTQmxiZitBenIrZnI2?=
 =?utf-8?B?RTUweGVtbXJvVEd5c1VpOXoweVJYaC9xNllCSjcyaVVKbmpCakhNSW9URVhW?=
 =?utf-8?B?ZnoyNVpaYzBWY2ROSFBGUEFHZXhLMkx6dDJnWWVhWmdRWm9yOHpsaWlHZndY?=
 =?utf-8?B?RldYYWYzVjVhV2pML0llai85VW00NWlaN2NSRkc3TEw0NjNmSENwdDRwU2I2?=
 =?utf-8?B?UlVBL1pjSDVXRkRLN0Ztc3luNjl4Q3dZYlZyOXZMZnhjTk5wRXdpS2ZudFdO?=
 =?utf-8?B?aWlsU2NsVUJ2cmNRRWFuYlZubEk5YXZybVltenk5elNkNkphRDNjNjFMbjNT?=
 =?utf-8?B?VUtrZUZvYnZ4SngrNVE2WXdhMktGeHdkM3NKVytpNittUjV1T0haUFBUTlVi?=
 =?utf-8?B?QUVsZWJUQnlRZ29QUFFJUlJvS3oyZXlzTjZHNXFNd1ZWaGhBRGpoMm82czUw?=
 =?utf-8?B?bE1tdUxQVUM5dUpQY1p5ODQ1djNnVGgyTHBSb0xxeFYrcjN2SXJYUFpZd2d6?=
 =?utf-8?B?dFhDR3dlMkc4S1ZpenFNdmlSME9ON1JTT2dzNUFBUHNDblZmNzF3SXZtSDNM?=
 =?utf-8?B?RHFuc1lLakg3c2x2WVlTd2pZaU95MTBVbWRUdVVwM1N6cEdXcXJYNTUrTnY4?=
 =?utf-8?B?a2ozWDQycUF5bXYvWG1haUhHTjdBc0pJNjRQWVpzcDV5NHR5OTRGbFpLVkpW?=
 =?utf-8?B?Zmhhc0o0ZEl4MFBZM1FvV0gwTVRaWlJFcmxCbXN6ZGRqQ1hPZmRvOWp3SXpU?=
 =?utf-8?B?b3IyYk9hRVc1eDBwRmxQSHh5clpQUmZEbUJsbGRjMUpXa1lrYUtrTFJwNy92?=
 =?utf-8?B?VlBNNjlvNk1BeW15SVJwcHRnbEI3TXRGQTg3bFdPNHRkdlJ2VGY1SDZiZkMy?=
 =?utf-8?B?ZzZkK2VyYWZXZzBsSDlsbjdPVC9wZytrcVErRTZWcGV5ejkxdzBHM1VhaFBC?=
 =?utf-8?B?SStNTDQ3ZldpYW0rQnJRaFlMb1Nma3JvZUE0azRNR2dmZktxZEQ5Sll3cjNI?=
 =?utf-8?B?dkpHMmo3Mlh3OGVGY0t5Y3VBQkRad2tuOHRUZDdKMjdUTGhIOHlaZkYyRS9t?=
 =?utf-8?B?cHlQYStZazNTTE81OUNnM3FnM3VhRXNDN2VuRUplSDVlYkpQYkpmaVI3dzF2?=
 =?utf-8?B?bjgwQ2ttRFZCT0hHNnJEeU1IbkVJMnl5TFBOSEhqd25Dc2xnaHErTXdhQ2JV?=
 =?utf-8?B?U2N6SC9Pd2kxbHdKbXdiZXErVVFYQUlKeHpZRFN2bEhJRWFKdGUraUd3V2ZX?=
 =?utf-8?B?ZS9Qa3BEN1RHby96NTlmcitURXhwaXRIdDV2UXpTQzhuR1V0ZzRURUpVUU00?=
 =?utf-8?B?QnJQUjlVdThHK1dCUFJpbUhyYlJCaXVvTmRMam5OYjJ2MEV0b3RoNFMzWmZh?=
 =?utf-8?B?RjRLTWZUczIvLzVSVWRMeHJhRDNhbHlZT3VYWHh2TXM0RDhsdzRZNFE1Q05M?=
 =?utf-8?B?THdPU3RuRzB0c2hBdTVWY0Q0bElGN1NnVXliRHVIamZZMjc1S2lIdnhyUEVt?=
 =?utf-8?B?bTY5N1JsYk9oV2ordSsyc1R0dUd4anZnejlPZUIyS25YbGY1N0h6dlI1Z1px?=
 =?utf-8?B?NXJIRmdlOW5nR0FKM2JkNVpUSTROWnpOTWxhSVZhVHVhNDh5c09odUZ4L2lK?=
 =?utf-8?B?L04rNUVDaXArUmJjeUJabTlwM05WTWJCK1ZmRmwyUkZlUGJZV1BFNVhSbGFp?=
 =?utf-8?B?NVpNT0srcnpjWk9ncWd3b204cTFTRmNaVFhVQ2dKN0JWQjUzUWRPYnpZdGl3?=
 =?utf-8?B?ZHkxNG5MelpWQmZsQlpNcnVHUHBjUjN1S2Y4cStrZnhOdllYNHd6QjRDNjlU?=
 =?utf-8?B?R0IvVExQMUR4bnVxQmlpcEt5UTYxTk12Ym9SL2hDVjhBRGxPSXhYM3BzektT?=
 =?utf-8?B?Zmc1dVk3U2hxa0FpN1NBbGorZW9kSjU5K3JPWXY5QzlwQmFGczBTSFp6NnNy?=
 =?utf-8?Q?IcJqkaaI67Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHIweXBReDIwbGNnTStadGJaRnMxdU81MmltcjFPVkRFMDZCcDZZRGYxY2Rn?=
 =?utf-8?B?b2tKUzRjNTlXN0FvTkNXSTR1TzlXWjNpK2dwaGZaTUZhVGVEWXUxaUJzd0JX?=
 =?utf-8?B?MElxaXdGeW5mdHBrNDFVYXJ1dVRQV1pOUUV4NEdkanMxcXkrWldNUEowYVJ5?=
 =?utf-8?B?TkpEVy9EN2labng5MlA5MUVvaW1TQkdaTWZnNWFjd0djSjdXNXJZSjBON3V6?=
 =?utf-8?B?OUNGTXpPSjhIMEFqMXlrK2VvVHdiRW5LQ0tiaHd6bkZtWnBpK3BBTGFJTGlJ?=
 =?utf-8?B?dlZ2dmdLWTdlRWZJMTdLcjc1RzQweXl2VXU2NXJpcTIyOVlpaEtWMmNzQVJw?=
 =?utf-8?B?WkFQeEQ1SHh1VWdUaW9LbnN0Z3RQa2tvUDNDaTVwQk44aVc2TXdENERiYVNO?=
 =?utf-8?B?MGw0dlFkajN5OHVvR1pwMmtndUtwM1JrQ0ZLVWhFQ0RtbWppL25ENURRRU5C?=
 =?utf-8?B?MlhqYUE1MHp0S0xRYlpDT2ppT0loNHRDRU5GUXorVG5mN3lTSWpBZzNSWG5x?=
 =?utf-8?B?eFc4d05Ybk1Ec1I5NGhnbGprOXhGc1NPalZnOHN3L09JVHRWQkpqaGJSMFhx?=
 =?utf-8?B?K0RLVHk1NXliVk9DMjRIS25kU1RwVC9jZktTcWJUTmFkOVFPOHMrU3gvaHhU?=
 =?utf-8?B?OC9zQ0VvOE5wcnlzYXNHNWdmaHlLVzgwNDN2Y1dTeXJ1NlF2VklPNy9FMmph?=
 =?utf-8?B?SlZ3R2ZNaGRvRk90b0hINjdxekVhUHdOZGk1UXRpbWhiaHQzN3pqQVJNODls?=
 =?utf-8?B?a0p3dWZoRmUyRmhTNzJwb3MxRUUxMW5yOTdLR1hERDIvSnJ1SE81ZTFlcVpL?=
 =?utf-8?B?WU9KbzVQOUYzOXBYWFZHcmZPK2o0bEhCdi9pbjduSlhvdGNZeHhDM3pkY3cv?=
 =?utf-8?B?TndDZXpzVUNwZUZiOXZJT3p6d2diam02Wk83L1JkWUJUTWtBcEgwZG1ZYXo0?=
 =?utf-8?B?WGpkdWZMempmNWdxajJzMDltRmRJSlFkb1R3QWRQQUk5eGZWMXdxQUt5OHNR?=
 =?utf-8?B?WTlTam1MRlU4N0kzLzhVdUVxWEtsUWtHT2hrY2NPeHlyVFErYnczeFRxejJo?=
 =?utf-8?B?Rm10aTFvSmxrY1pwYlcwSTVneGJEeWZVemxuMWpFdkExS3hLRlRyK2tuMjJ6?=
 =?utf-8?B?U3VrUTVBRGRvN29HK2hVUzNVbkxobTBCQ29mc3E5OXVzZHROZnhxc2xzRlZt?=
 =?utf-8?B?Z2d6a1FBUElVWGs0cU90aWYyd04xNkhPVitqZS8rSGQwUkNjYVB1akdwY1Rq?=
 =?utf-8?B?dEVYR2NvRW5TT1crbzhEMWtQdVF1NzROekZhK1h5amh0Mm5MRkV3ZFNLUlJa?=
 =?utf-8?B?U3pSQ0lHcm5pSHE4a1hyV1Zzb1NjU1FQVVE2QWY3WTRVb2FheFRGdTdkTERw?=
 =?utf-8?B?OVNxSUJLU1Vnblc3Yi9jMlVyVlNzTnVBb2tkSVVkK1Zwa0hKb1o4czk0eTNB?=
 =?utf-8?B?SUNrN0tDbHBOVFAwczJaZldtMWorTTc2RXE2REJzR3plc3kvdEpSSElidnA5?=
 =?utf-8?B?dDcySk1vZTN3d0xnd2F5amp4M2l0QmRxbGo3Yk94dEYraXhldlRHZzhoRXJM?=
 =?utf-8?B?cUE5eGx3bmluNWc1cTVzM0dMV2UvbExkTlMxTTdpT1hXNTJoaWZXUUZXUENR?=
 =?utf-8?B?YXNmcEdFaGZUSjNTV0xNTG1UY0ZYL1JQakRxVlVnMHFOeml1OVIrOEhnNXNT?=
 =?utf-8?B?QUZ1S283bWNTNm85dHYzenBzYkFhanJoWlZIZ0tDYzc3MVdwbGd4djZLY09l?=
 =?utf-8?B?eWM3TEwyZkI3R0hhNWMwR3FzYUR5YmJWcjk2VS96SEcxMDA3L2k3QkExYnk0?=
 =?utf-8?B?ZmVKVmlaNzZwS1oybnlSR0FQbHBYWmx3THJtTVI5WmdJNFFBZ0xlandHK0NG?=
 =?utf-8?B?MjBsZFZNenpRT1dpWVlHYUlBRkFzSjl6ZG5YSjk4Y1BtTTRXWDZmN2dsZ2p0?=
 =?utf-8?B?UWRCaXlYSXJ1OWxXTjBreHI1bnZSVERyRmVhZ0thRWFwbTFTUjlTdThBdDN6?=
 =?utf-8?B?VUVmRlRXdzBaZStvZFVMMDF0NnZ1VmdQWTE1emdZSEhsK2cvUWVmbjB2cGZU?=
 =?utf-8?B?a3hWc3FXQUdaZGF6a3ZoWUg4aVlKL3J4Tkw3ZEJoQ0VoODE5UVpBSHJFWEcx?=
 =?utf-8?Q?RnwhaBeq72w+Apj/Nkg/7J04E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9af78f9-c6ea-46dc-3cb9-08dd8cc04a7c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:06:06.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szbn1fkKMNYi3Gk3SnQnWu35yT4AQ3WyjmuLkJI9gSNiBoKrdTupWARibg4P0Pir7JHTuI4vI236Z8qu/Ck3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905

Hello Sean,

On 5/5/2025 7:56 PM, Sean Christopherson wrote:
> On Mon, May 05, 2025, Ashish Kalra wrote:
>> On 5/5/2025 6:15 PM, Sean Christopherson wrote:
>>> @@ -3067,12 +3075,6 @@ void __init sev_hardware_setup(void)
>>>  
>>>         if (!sev_enabled)
>>>                 return;
>>> -
>>> -       /*
>>> -        * Do both SNP and SEV initialization at KVM module load.
>>> -        */
>>> -       init_args.probe = true;
>>> -       sev_platform_init(&init_args);
>>>  }
>>>  
>>>  void sev_hardware_unsetup(void)
>>> --
>>>
>>> Ashish, what am I missing?
>>>
>>
>> As far as setting sev*_enabled is concerned, i believe they are more specific
>> to SNP/SEV/SEV-ES being enabled in the system, which is separate from
>> SEV_INIT/SNP_INIT (SNP_INIT success indicates that RMP been initialized, SNP
>> has to be already enabled via MSR_SYSCFG before SNP_INIT is called), though
>> SEV_INIT/SNP_INIT may fail but SEV/SNP support will still be enabled on the
>> system.
> 
> No, if SNP_INIT fails and has zero chance of succeeding, then SNP is *NOT*
> supported *by KVM*.  The platform may be configured to support SNP, but that
> matters not at all if KVM can't actually use the functionality.
>

Yes, i agree.
 
>> Additionally as SEV_INIT/SNP_INIT during sev_platform_init() have failed, so
>> any SEV/SEV-ES/SNP VM launch will fail as the firmware will return invalid
>> platform state as INITs have failed.
> 
> Yeah, and that's *awful* behavior for KVM.  Imagine if KVM did that for every
> feature, i.e. enumerated hardware support irrespective of KVM support.
> 
> The API is KVM_GET_SUPPORTED_CPUID, not KVM_GET_MOSTLY_SUPPORTED_CPUID.
> 
>> >From my understanding, sev*_enabled indicates the user support to
>>> enable/disable support for SEV/SEV-ES/SEV-SNP, 
> 
> Yes, and they're also used to reflect and enumerate KVM support:
> 
> 	if (sev_enabled) {
> 		kvm_cpu_cap_set(X86_FEATURE_SEV);
> 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_VM);
> 	}
> 	if (sev_es_enabled) {
> 		kvm_cpu_cap_set(X86_FEATURE_SEV_ES);
> 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_ES_VM);
> 	}
> 	if (sev_snp_enabled) {
> 		kvm_cpu_cap_set(X86_FEATURE_SEV_SNP);
> 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SNP_VM);
> 	}
> 
>> as the sev*_enabled are the KVM module parameters, while sev*_supported
>> indicates if platform has that support enabled.
> 
> sev*_supported are completely irrelevant.  They are function local scratch variables
> that exist so that KVM doesn't clobber userspace's inputs while computing what is
> fully supported and enabled.
> 

Ok.

>> And before the SEV/SNP init support was moved to KVM from CCP module, doing
>> SEV/SNP INIT could fail but that still had KVM detecting SEV/SNP support
>> enabled, so this moving SEV/SNP init stuff to KVM module from CCP driver is
>> consistent with the previous behavior.
> 
> And one of my driving motivations for getting the initialization into KVM was to
> fix that previous behavior.

Sure, i will test your patch and post it.  

Thanks,
Ashish

