Return-Path: <linux-kselftest+bounces-40394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1134B3DA45
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8615117664E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CEA256C8B;
	Mon,  1 Sep 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n5Ltocli"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012031.outbound.protection.outlook.com [52.101.126.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD3273FD;
	Mon,  1 Sep 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709543; cv=fail; b=mKKkHRFvUTs2U65/IIrdJudco7FljLa1jqmu3PFU6Ym2YpZRP5Qn1O0y7/EbLRLqVMgyy8m9tPZBdY74xNtMOO6rte56Ge60gC9dI2uFRrZ4YghXxbFfhSfndgRY5W80MDypuYO45niqnQ4nYuQkrhwN9rbEluv2Qa8IjtiFiWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709543; c=relaxed/simple;
	bh=KxmdaqS23bIFF+LgDyVHLbjdD9X47/okGjs/1mu/GoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wqio22hXVuz1BE94emMKIoazhwhDkVCH//HAnskysV5uHzE/iBMV0GH7zWFnJ18Pi/h+fW11eYbsNQKbhzX9/CvfCUJLZEDk+7sdqJYc5P74Ou1hd6p9cgyrSQI3LSys3JU7qHKonM1FaU5DKq1zjWhnDCEutnxJ0nmJs0//Dn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=n5Ltocli; arc=fail smtp.client-ip=52.101.126.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKfde3ZHDLdNdex4RtzJb7Oxi6jDW+/Fp91RWFYIq/HGGEZTLOFeBD7IC9OiytQFp4ioi9JuYtjwhLBjz+OJuVlTlUWieuUBrPiyNigsuYhbiITZ8HFjAOvLND5LM4y8m9ThwCKuj8wopiKUmc/gLP43lvnPII4Js1rMxI8yXxmpboaSxoj/4ifZMHBVNkXwJ+hCeCg86PsD56yPyJzd4DXw/5a6OKiB5Ao7tjoQxftYfgpLApCPQFdsEqlL0Fft3ahVDNqYoFFq1ho86v1O38Oq/kjFpV47f4K0PDrBv211R8eQXUBBns+4HHuJR9FwTpiPej15UN/oW0ZiQNCr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ5Oxa/DD4Qu0tedZC+qM7+pRd67/AyiiKoaBj6JCfw=;
 b=wSdnunl+z2xhBABzKysULfI0kLv1xWsTMbQQ2WnTC9QDBeJxAaNP203drq/NUqnv4leUvKGY3fO/47jN/AI4m+7RpF+d2ozoXAdHybn2yTe0fhVp2Z2H6of8WEUIaQTsYu+ymMHSgzOdC3ndQeGpp5VEl6Kr08XNDUm1lN3W5Qcs0y+hCishqc1bylsGzj7zceX8f8CgpZIIB4TcaLfeXDTFNOPcUd+OHFeygcs8pQqYPIITKXhFKPkgyUBEB/xlCbvGpMA7KlmeNgb77befAnLcMHVNIIudwkGUN7e5L2AsUJ+n1AS2eHYdLf/Vp1g3PbZfvJKAHwBmm0PbC6WGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ5Oxa/DD4Qu0tedZC+qM7+pRd67/AyiiKoaBj6JCfw=;
 b=n5Ltocli/iRRLDB6r+m0I3mUG2dL6Iep+LW8T+CFm0gMQGy+blzqg7B+JE3aSmmeNDkCNA8f6DFSEwWvRsF24awi/DfvluBoEVuP7E4Dn+ZnQaa+gNWeYfdjyCoh+UczUBFgznm0h0w5zaGFvCnA1v4tuHFIs4/jPR0GEyRbt3s/AKnekQ8ocFwvgck5UUkFNISUvoui068WUzV6fvrRwV3zGhQ2swvj+HTFW5x+JtSys+JCfD/DFmoZJvW5/q4i0VC6hqQvrIngO/LaFoxckC2vJjRjejW+Jchum33QYBFNnzv3kwZYqZ0buXB7IpDxVzWgOzPrhU9YOtey80Tz6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by JH0PR06MB7029.apcprd06.prod.outlook.com (2603:1096:990:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 06:52:17 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 06:52:17 +0000
Message-ID: <21b97e42-6681-42e4-b0c4-3718b169faa7@vivo.com>
Date: Mon, 1 Sep 2025 14:52:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V1 0/2] cpuidle, bpf: Introduce BPF-based extensible
 cpuidle policy via struct_ops
To: Song Liu <song@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, zhaofuyu@vivo.com
References: <20250829101137.9507-1-yikai.lin@vivo.com>
 <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
From: "yikai.lin" <yikai.lin@vivo.com>
In-Reply-To: <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|JH0PR06MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 813f1cb0-605b-4f0d-ef11-08dde92416cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGNVV2didkdlY0J1VTh5TnBCckkySzRaVVVrejhYTUtlcW8wMzIrdndkMmJl?=
 =?utf-8?B?WTV3dWxVazkvb1QzNXlLWlg4T3RLMlMwWC9MbEw5R0M5b08rZnRsaldvc3hK?=
 =?utf-8?B?UERNclQ0eXdYRERMcDFuZDdBRkhpM09VanhQdFRZWVpOZ29EemFRZkk5bURz?=
 =?utf-8?B?VzloaXo1Zld2QmxCaWx1ckF3bkUwbVcvNHFuTi9sYTdVaGZBRWUvc1ZmUG9T?=
 =?utf-8?B?a2xNTHV1MEhUMGoxUjlFVDI5NGN2TnJweG9Zd05mc294RUZHa3UrSEhFUVB1?=
 =?utf-8?B?WmJORkZQcTdPUDdpNGZ2TnIyN1BoWitmblAxZDh1ZTZWVmNZSmlPTWFxNmgy?=
 =?utf-8?B?TVRHbkJrZTVhVjFYYWZPS1JxU2hkT1I5azcrWm5ia0VOVVpwM3ZHTENURXJl?=
 =?utf-8?B?N01iTGNCRTkzaUNWN3hkMGx3NEgvTXBWMnlqMFB2THNqVDlwYjJDUFFVT1dL?=
 =?utf-8?B?dnhwTEw5MzZlMlNSQzl4Tk5ZbDA1UWZYUlRYV1FSRzg5VS9ZZGkwUEI4VFlC?=
 =?utf-8?B?Q3lLVisyNjNQWmVoSE50WGdITXZVSTgwd0kxRkd5clN0SmNYRWdKdExJdTFu?=
 =?utf-8?B?bmhLWVBORmx3dmZjcDhxU3Nuc2d0aW92OWNLS1JVZjVSb1U5NlR3T3MzTTRi?=
 =?utf-8?B?aml6am9iVlJveFUyNlREcUtNTmhpZzVuL1ZNRkhHMjFyQ3FhQUdKWXlJR0M1?=
 =?utf-8?B?K2U1WjhtV3RLUnRhS1UrcVZjSG5GVGRMVHhOWHBQdC96MGRkczhJaTBaNEt5?=
 =?utf-8?B?MzdrcjBTQUJVWTFDckNZRkxCRE9WS1NoUGxMaTdmQS82ZTlkU1UzbDNVQVpZ?=
 =?utf-8?B?bEM3Z0dyWmR6enpaUFJ1UjR3Q2tlR1JZK01ITDR0RWM0R1NjZjVaanBOaTdl?=
 =?utf-8?B?ZWUyd0hHOWpHbFI5cUlBYTJFeDl3VHpWNGFlM2FWQkZZaFo3a3dLaU5wSmJh?=
 =?utf-8?B?QllvSm5oMm40cVNvVkhGYkRzeTNxVU1yNVVobnRrZXJySUdERTdkTjJGQit1?=
 =?utf-8?B?dzIwUFBCb2xuVGpkTHNZSUJxVVMwNkx4ZTdRSzdML2V0cU13cG51eCtHN1p4?=
 =?utf-8?B?dis5MHpQUUIxNFkzVVJod3B4ZVE2VEcvMC9nWmxhY3lhUVZOMUlLNENDYnN2?=
 =?utf-8?B?VTE1TDVBd1QzWnVqNzJlKzhHOTRyT040TDQ1c3RmYXFZYStYUzVIR3NqSXJZ?=
 =?utf-8?B?b1RKQnBsVE5DYndwR1lORlp2QUFEWU9zQkROMVhScW9zcUJmVjY2dGZzVnVw?=
 =?utf-8?B?ajExSWdNeVZxWjZyTWxiM3ppN3ZiUWlJRDUwRlBSdUQ4M2hUdU5YTENyclcy?=
 =?utf-8?B?MFpqN2JnV0tzc1M4SWJsOHgwYXk3bEFSOG54YzJoV2NIZ2dzbVpYSlFEODJO?=
 =?utf-8?B?UnNVcnVYZTk2cTl5REVUZlNjenE3c3FkcVNMMWJZN3VwaE0zVkZ3MVVlTjNO?=
 =?utf-8?B?WTdiU3VCTStiamtaeUI0cW5OdjVxcVBXQnZIbmJQRGE5eWkyakdRZjFsWWZy?=
 =?utf-8?B?QVRoQmlYTEZsUngyakZwSWlweGhkL01QbDdkc2VlUE4vbWN3WGhiVFpjMlZv?=
 =?utf-8?B?alpIUW1qZVJsT0NpN0hveGQyT1dDd3NZK0R4YzVTWmdJVmIyb01KNUQzTGZ5?=
 =?utf-8?B?bFFUaG9ub2Z1QnVWR2IzTDlVclF2QkNTQUxaT1JJMGFZRzdsQjhneS9MU3pQ?=
 =?utf-8?B?MTRIZlF2ODh4Z2MyUzlGekJ1by9UMlc0N1lGdDFlSGlSNTRkYkJhTFltRkll?=
 =?utf-8?B?WjRGTUd3bk41ZG93S3dxOWFvUlYyNkVaL1Q5RTZTU1RHd3l1NTRIRXM0b29H?=
 =?utf-8?B?cnhYUk45ZUk2WjJDM28rQWg1b01uRlYvSVJubUcyWXVlcy9NY0t4RllyaDFG?=
 =?utf-8?B?ZjczeS9jaWUvUUl6YzUyR1VMcFBJM08xdFV6QlI2Q21iaVgvWjFrSTR1dFBs?=
 =?utf-8?Q?GVFncpxog4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1RReVFUK29rUWJ6S0U2THNGbFdDQmFDNUtrbE1EaGwwanZHelZHcXVldlBV?=
 =?utf-8?B?eTRoeEFCemxJUENpRWxQMXA3KzViR2lLN0Nvc0dQbjlZTGU1ZStBb3BxUnhS?=
 =?utf-8?B?ZHJKMGwwVHZPYmNmS0JPaUNadmREZjJTeXhvaGVSYmsyTWlYbFA3Y2Y5dFRN?=
 =?utf-8?B?VzZhbWlBem44UUM2NVFwMkxEM295a2RoQWpHN0FyM2ZTa01haG9POVk1aWxw?=
 =?utf-8?B?RkYzOHJSK08rdzEyS0JjbzZEcGNJblNVMnhoRktHdUxUSm1kQTZieVR0R3Zs?=
 =?utf-8?B?OXRGSXIrQmVtZUkyZVJYV1Z0VHRhakM4Ymk1SEVvWGY0UGdyT1NGUzJrRUtx?=
 =?utf-8?B?dW4wU093TzBZUVZ1Q2VnSUo0alQwVUFNYkRhN0pWdmRDVFkyTU9KbGVybENS?=
 =?utf-8?B?czl6VFJ6ZlFQcmx1d0lWTU44SnBmN2JIL0h2T3dHbUYreFN5bVU3aitqeVRY?=
 =?utf-8?B?cjk5em1ocHcyaEJpUUhqZldIUEp5TDA3NnVYUFkzWml4TWorL1N4YnNRS2h6?=
 =?utf-8?B?Szh2RWVQM3ltVUpXRGRiQUlMdGpxejVEMWFuYnZlNXVuNGxhck1neis2SHVN?=
 =?utf-8?B?dTI0ZEhuUTZzam5rb1V1NWlRaFpSRzlKOWp0L0VPK1pWbzNoSjBzZE54aWRY?=
 =?utf-8?B?WCtYcTQ3WHg3TWR5QmNOSTU2b3M0Y3hiZW5acEFtQTlZNk52SDdiWGIxQmM0?=
 =?utf-8?B?bFBGWlZUcHN4VkhRc0xuNVB0dXB4MTM2VzJLdXdJdEg4WkVwQWN6MEtOVW1s?=
 =?utf-8?B?M3U0VlUvUVZnVld0T3M5bjQraGNRMmw1SFlvUys1YjZtSFRSelRjOUdHajVu?=
 =?utf-8?B?dlRxSUJONGZnenppYTJxbEVQdXFCc3c0Wk9vM2RtZTBxOG1vYVpGU2N6TExo?=
 =?utf-8?B?eW9saGdRbGJMb1JZTXZndWVXemcwb3pqSkZvWE1Ld2lBeE9ydk44dXRSVDg3?=
 =?utf-8?B?OWo0cFZMbjJpWEx1a0R3V3JjZkJmbFQxdkM0VDZjeS9vQVpFemIzdEJVT3NR?=
 =?utf-8?B?NTZOQVQ4TXF0VXJsYWdzc2o3TytJV0V4dlo5VTVJeHBPSUs3ODUxNG56Zjdt?=
 =?utf-8?B?WEtUd1NvM3NSVHJUWWdvOS9JcXc2N0p4V2dtM2diRjFnR3VrVktHU2RHK0ha?=
 =?utf-8?B?UloxTFAveExOZlBVNmo0RUJHZGdKOUJYNmtEc0tjK2p4dUtDaVAzOUg1WnpL?=
 =?utf-8?B?TWxtUWdVLy91dTY3WFVwdnNFanprcGgxSjgyaWZCaURTN0hTV0VGak9MUTJ1?=
 =?utf-8?B?aGJ2cHovS1lZQS9iK3NyU1VaNlJONm5CSUdVTHoyVUxZZ2FBQmlWWmFmL0dG?=
 =?utf-8?B?TVRQa3hxejFNK1N6eXRlYmlYZWpFWm1xRkRrSG5NZU8zZXlUbzgwRlRPQkF4?=
 =?utf-8?B?cmlXUEEwQTQ2TGFremM5RUlVL3NRYjNmejNFMDQwS3ZjSWVmOFRJR3hDVy9z?=
 =?utf-8?B?ZllRRHpJamZ3bk5YRzZnY0lOcXRTYlJjMnVvaVB3NllPQVdGU3JwL25DL1Mz?=
 =?utf-8?B?YjZ3NVQzb2JwUXQ2UGlNRytVdGRROWtadUlPUXhMZEZIbWkvaGp4MHlIaFd0?=
 =?utf-8?B?MkJlZzRMS1ZZN1ByTlJxbnUyUVh4c29pcHB1TUptamgzWnRSSlpaQm1CWlJo?=
 =?utf-8?B?T2Z0WlQ4ZTlSMVpualc4b0d3VzYydzNUaWF1VVpkeTBENFcrRnNKazhLOTR0?=
 =?utf-8?B?VnVIQlpBRnFjVU1lWVM1YnpQOStTa1VWb0NvYThsUDZuMHJQTlFwbGFCK3VR?=
 =?utf-8?B?OHBpR1RkWm81OW5LZXlQZ1c0NW9zUmoyNS91NDVJVzdDWHFNTEhnUHBBTUU0?=
 =?utf-8?B?ZGFZc1Fjd1lzaFB3ZXNvTHZad3Z6dk1xdHlSZnJjSEd6R2dDTWhTRWFhc01y?=
 =?utf-8?B?WmxXRHFTTE5seDFoOHVhSG1QSnc0QzF4cUtzLzFsZzZsekhldUJKbGhmVGpW?=
 =?utf-8?B?VWdmcnljZG5FUm9VL2FvbTQ4ZEExVlpjSEk4cTd3cnFaTWYrcitQY1hyakIw?=
 =?utf-8?B?N0pURytreVdHV0RTZ1VCVE04ZG8zYUJsMmhOUDhuR1RaTHJ5L0JtY1ZnTmEr?=
 =?utf-8?B?b1JCY056L1ZvWkRrcnpKWnpxUWtJRThTWkdEU1NZYnRMOW1xVWxIZHdlM0hI?=
 =?utf-8?Q?aQzlDlx+3PT7ySDAx5Ff3ZKdu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813f1cb0-605b-4f0d-ef11-08dde92416cd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:52:16.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Z1MN6YldEwPtTkMyaj4xqcnUlmDFdOLywDGVcb3XZO1i6ojL7PcQYpb4CFChKn3IU+YXQM8NcOiKQ8njUx3Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7029



On 8/30/2025 4:00 AM, Song Liu wrote:
> Hi,
> 
> Thanks for the patchset.
> 
> Some logistics:
> 
> 1. Please prefix future patches properly with "bpf" or "bpf-next", for example,
> [PATCH v2 bpf-next 1/2].
> 
> 2. Please be specific with the patch title, i.e. "selftests/bpf: Add selftests"
> should be something like "selftests/bpf: Add selftests for cpu-idle ext".
> 
Yes, I'll update for them.

> On Fri, Aug 29, 2025 at 3:11 AM Lin Yikai <yikai.lin@vivo.com> wrote:
>>
>> Summary
>> ----------
>> Hi, everyone,
>> This patch set introduces an extensible cpuidle governor framework
>> using BPF struct_ops, enabling dynamic implementation of idle-state selection policies
>> via BPF programs.
>>
>> Motivation
>> ----------
>> As is well-known, CPUs support multiple idle states (e.g., C0, C1, C2, ...),
>> where deeper states reduce power consumption, but results in longer wakeup latency,
>> potentially affecting performance.
>> Existing generic cpuidle governors operate effectively in common scenarios
>> but exhibit suboptimal behavior in specific Android phone's use cases.
>>
>> Our testing reveals that during low-utilization scenarios
>> (e.g., screen-off background tasks like music playback with CPU utilization <10%),
>> the C0 state occupies ~50% of idle time, causing significant energy inefficiency.
>> Reducing C0 to ≤20% could yield ≥5% power savings on mobile phones.
>>
>> To address this, we expect:
>>    1.Dynamic governor switching to power-saved policies for low cpu utilization scenarios (e.g., screen-off mode)
>>    2.Dynamic switching to alternate governors for high-performance scenarios (e.g., gaming)
>>
>> OverView
>> ----------
>> The BPF cpuidle ext governor registers at postcore_initcall()
>> but remains disabled by default due to its low priority "rating" with value "1".
>> Activation requires adjust higer "rating" than other governors within BPF.
>>
>> Core Components:
>> 1.**struct cpuidle_gov_ext_ops** – BPF-overridable operations:
>> - ops.enable()/ops.disable(): enable or disable callback
>> - ops.select(): cpu Idle-state selection logic
>> - ops.set_stop_tick(): Scheduler tick management after state selection
>> - ops.reflect(): feedback info about previous idle state.
>> - ops.init()/ops.deinit(): Initialization or cleanup.
>>
>> 2.**Critical kfuncs for kernel state access**:
>> - bpf_cpuidle_ext_gov_update_rating():
>>    Activate ext governor by raising rating must be called from "ops.init()"
>> - bpf_cpuidle_ext_gov_latency_req(): get idle-state latency constraints
>> - bpf_tick_nohz_get_sleep_length(): get CPU sleep duration in tickless mode
>>
>> Future work
>> ----------
>> 1. Scenario detection: Identifying low-utilization states (e.g., screen-off + background music)
>> 2. Policy optimization: Optimizing state-selection algorithms for specific scenarios
> 
> I am not an expert on cpuidle, so pardon me if the following are rookie
> questions. But I guess some more detail will help other folks too.
> 
Thanks very much for your comments.
The cpuidle framework is as follows.(And I'll add it into the next V2 version.)
  ----------------------------------------------------------
                 Scheduler Core
  ----------------------------------------------------------
                     |
                     v
  ----------------------------------------------------------
| FAIR Class | EXT Class |           IDLE Class           |
  ----------------------------------------------------------
|            |           |              |
|            |           |              v
|            |           |      ------------------------
|            |           |          enter_cpu_idle()
|            |           |      ------------------------
|            |           |              |
|            |           |              v
|            |           |   ------------------------------
|            |           |       | CPUIDLE Governor |
|            |           |   ------------------------------
|            |           |     |            |           |
|            |           |     v            v           v
|            |           |-----------------------------------
|            |           | default   | |   other  | | BPF ext  |
|            |           | Governor  | | Governor | | Governor |  <===Here is the feature we add.
|            |           |-----------------------------------
|            |           |     |            |           |
|            |           |     v            v           v
|            |           |-------------------------------------
|            |           |           select idle state
|            |           |-------------------------------------> 1. It is not clear to me why a BPF based solution is needed here. Can
>    we achieve similar benefits with a knob and some userspace daemon?
> Each time the system switches to the idle class, it requires a governor policy to select the correct idle state.
Currently, we can only switch governor policies through sysfs nodes, as shown below:
   / # ls /sys/devices/system/cpu/cpuidle/
   available_governors  current_driver  current_governor  current_governor_ro
   / # cat /sys/devices/system/cpu/cpuidle/available_governors
   menu teo qcom-cpu-lpm
   / # cat /sys/devices/system/cpu/cpuidle/current_governor
   qcom-cpu-lpm     <===Here we can echo governor name to this node to switch it.
However, it is not possible to change the implementation of this policy through user interfaces.

> 2. Is it possible to extend sched_ext to cover cpuidle logic?
> 
The cpuidle governor decides which idle state to enter each time it switches to the idle class.
The sched_ext is used to determine the scheduling order of tasks,
whereas cpuidle is invoked after switching to an idle state when no tasks are present.
They are not closely related, so it's not feasible to implement kfuncs or other extensions via sched_ext.> Thanks,
> Song
Thanks for your comments.

