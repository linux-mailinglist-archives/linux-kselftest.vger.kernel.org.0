Return-Path: <linux-kselftest+bounces-36768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421CAFD59D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757B248538E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399D2E5B0F;
	Tue,  8 Jul 2025 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RA5la3Lq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BF21CFFD;
	Tue,  8 Jul 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996677; cv=fail; b=ikgKCW7CUYosxE4vuT+bDF56TR9O8CocLqG68OVNajBbU7EHYrbrPgw0pg3N/OXENnURqydTxK5ASfTLY4gBCQ80nnKoYYtVwWm0XUFVNiF6KHRsW4fugUtSnham5x2dApgNUtN+F5qDRtBo9Y3YbodFjMfKVgF3Wo4KH+B+3ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996677; c=relaxed/simple;
	bh=Pnj29fXGdtDfdFlIXwKEGzopAgTOxnrZPTz3hfkhgwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3KYFy/qPl3ewbjas3+Cksrhenue1hTYZWPgxmBPDU0HcmA0zSNsh3VkLF+j2xhAZSUrG6j6AA1AvN4IV+mdhVBnpEcERQjqleIk12vYZg2P1LEJF1aJ2fpuG2JCx2fr2YkMn3bh0fSN4Xv5xsIxynSq3sK8eLfsB0dTpPBvY7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RA5la3Lq; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFPR3ThmV8I4cNZFe1V8jFKMSjpQvQUMB2uI4YFW6LNcyHfZIPhGdMYEkX1SG5PyeSmwUptuB79DO20JOgxErZkYRdaOY52V26j++Dow0dvd27VTYWeQ7rfkxiapcCYqxOQB5+rr4/dzB/iAUrXSwPmjvKS/7XQ8qAZXX+VVPmPNF7aAIZm+mIfVt4zE/Cd4MRELcpZPBv4+PypgFfXGooYC9eXUMPQLVqi/LU4Yh9BQO6Md0d0LTAB9zqmf1r8LXEM/9ym4NEWzOVaj0uKKuz3JjHC9bcG5pFQiwsWxhk7weBHUqe14j2Bwn1Jn6L+HT6YV4xaQPIBmLmq67Tf0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU4co67gsUyH7vjOJAXo9r6G0M/qOJbLzzAsuS2qPVY=;
 b=G2Q3ZfAH+4QVUyjNXIW5FpQjnfRtqxLMWH7BB11FUDP0bj22Vxul/qGtElYAQ3rJ54XzSs9N7l0KdcMKdGs5heH9F30M/Qd1jaNxYdmazRVNoOjOm6DZGVzJhLT6A8lWbHg69C0QZUz76DRUlhXqRTAozZ5r/9kLtqebGxkHpsltklGQDYuRO8Gk+ydB00r4K2CicIT3dTz/1oWFOBW/DBLPHdoO8gY02RILenEjP3FacOJlGoovIMtr+0DBIobdJN15A4l4G9aJnDOt8CyPWd5rjsUfZcYWqKci2kP4wH2n6wrMesefcRS0/3T5XHSM7qeGCwoxHM3Y95hjJOl50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU4co67gsUyH7vjOJAXo9r6G0M/qOJbLzzAsuS2qPVY=;
 b=RA5la3Lqb/YJy64Vt88SU1MjxqwXfVfyRUJ8hXm0deh3GzNcrehxeW8aDUa45hvrqxJkwweJd6fioEaTZV3gi8wV932lo7ASZr1wmLxDGZcJ0mmiP0Tc8llNMH9Ku0oTKZeArygC/ANr+bukq43VonVo2SpscNq3GDn5/FqWVMHvTcpi2LnXmJSHiE9mWHi3NQsh2oxWtYu/Ko4fwa6Yn/FS5fe7BtdcQP9l7l+cV0HFiX57soAeWwh/3EuZKbh5zt5uRrOirrEPLq1GWl2qovhqm6Ak+GyoWKNAiVwun7swFTF3AKgulDneFc1Tdrz2ruQcOzldWZqaBPgnK7x4Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV9PR12MB9807.namprd12.prod.outlook.com (2603:10b6:408:2eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 17:44:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 17:44:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: wang lian <lianux.mm@gmail.com>
Cc: david@redhat.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, sj@kernel.org, Liam.Howlett@oracle.com,
 brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 p1ucky0923@gmail.com, ryncsn@gmail.com, shuah@kernel.org, vbabka@suse.cz,
 zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Tue, 08 Jul 2025 13:44:28 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
In-Reply-To: <20250703044326.65061-1-lianux.mm@gmail.com>
References: <20250703044326.65061-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV9PR12MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c6578f-5e20-493f-f1cb-08ddbe4718bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ti9OQzF4eG1JaXNRaWFEMUc0VFdkdzFrR3p1UmcyVGNtc3hMYXdzNHNYTDlV?=
 =?utf-8?B?WW9OTXc4UWVNTzBjRUhsTDRCbGovaTRpa3hiRmNsRmh5WEF5UHRFWGUzbFEw?=
 =?utf-8?B?c1dmQkZaNjFtU2I3aVVnQ1kwS00rMk50dkJ6MGxBbHFaOFZDWVFLTXp5SFNr?=
 =?utf-8?B?eC91ckVCTkJaRW9CVEhCTTU4MXZUQVpKMU9HWmZwSnFldVA3L3B1SkQ0ZWo1?=
 =?utf-8?B?dk9RY2VlKzMrd3B3T0U0VkhHU0FrWEVJM1BJZmIvR0kwbmlEaFZJelJiRHJY?=
 =?utf-8?B?WXYvTkliWWlpL0R6dEZOekVvbWY0Mm83TjMzSzByM1JHTTFBbHdZUDM5cEVU?=
 =?utf-8?B?NENoY3R5VVNUVGxrQWxUb3ZTVGdKZTlDaWU5ZXpGTDJZNzZubXlxVlJmUGdv?=
 =?utf-8?B?K0RsNnRMZEs3VUczWXVuNmE3eFVIREdmUllUMWZiVFNkZ0M3MXA5K0kyMkts?=
 =?utf-8?B?N0tKZC9qSjZjMTlaUjcwdUtxVzNnelcweXRMblhVMGdGU3BweXVCdTVGWnI4?=
 =?utf-8?B?bEY5bVhjRVBPdjlTQm1FNVFwWkI4SVIybmVFUDZ0d29SZjdodUNyLzZNVUd2?=
 =?utf-8?B?N1d1WDZPdjNKeUFrZkNaL1hzd1lISmQ2dVNEemJKZm5lZDBIdkJ0Sk5lakVE?=
 =?utf-8?B?QVZVd1dVQWpCZ3ZYUUR0bEdocDZ2bCt0aGZ3WVlSUElBcU1FYWVXK3lGS1Ix?=
 =?utf-8?B?VjE3VkhHdGt6LzhMaG5MVUJZclA4VU1Ib1ZLNTBhVmNSWVdGT0lHTkVBYjZ0?=
 =?utf-8?B?UWVySmxTSTVuODdLUGRSNE95ZjNDSzIrMU0vZVZBVzJhYkxNS3M3VEZBNk9n?=
 =?utf-8?B?bnk0RGR2YjF3N1lLamFjeVV6WGFyTEtQVlJlYWVLbW9TN3Y4YXNiUDFoTkhJ?=
 =?utf-8?B?T1V1ME4wWjFYN3hOd1lCcFNoMElKN2Y3U1J4OWhKdnoyT1IwVmZYcHJLUEVY?=
 =?utf-8?B?WWRMSk1aT0FqVFRGU0lLSndoeVFxMDNjQVExYm5jRGVqUW9Wb2JCOEFLcnZL?=
 =?utf-8?B?aWhLeTY4YVA0Mk15Rk51QUw4M25ldnBoUERJUzhPOTRjbVZndFJaUmlGSnpG?=
 =?utf-8?B?c3pSVFQ0V0FzaFVHeWkyTGI3QWRCZzJZU05FVTV2NWJjVFdiemNRQUhhS3E2?=
 =?utf-8?B?SXkyNmtQNkV4Zlp3bXk4TnJkR1pldnp1ck9iTDcvMkozTVFlbVNNa0hOem12?=
 =?utf-8?B?SnhOZTNZOTlXUVgxeEFVOXhZT2hPa2krN0xkdEY4RTFpSElhTW1Sc3MxakR5?=
 =?utf-8?B?VXNUSUNOT3dxa1hNMDRsck9XN0xUckh3ZnBxVitLZXB3VHBSZ05JYi9wR2o1?=
 =?utf-8?B?V01SeEFXY1ZzcUdWYlNHT0F3bG5TeVFUYTFIQmdZd0dWSGlURUZObnlrRk9W?=
 =?utf-8?B?elpGSFZWeUREWnlBWWxCaWMxYVdMZ0Q2WDJxR0JTWFEvUmswaEoxa3pGMHdk?=
 =?utf-8?B?bFpaRU1WcE1TVDN6TVFQYkhId3lpZDNibStCeGl6WWJCNGpzMU82NFFqUGhR?=
 =?utf-8?B?UGk5bnZ3YUJ3RGRJd3o0RU9aL2U3U2ZEQVZocG1PeTFEUVVDNzJ4MklhN2lJ?=
 =?utf-8?B?UFo5dUhVczA3QSsrN01WRXJwMTdlY2VqRWZFTVVWVllaNENrclFKYjFMeHkv?=
 =?utf-8?B?bGVWYUxxTVQwZnFZUFpjS29wdnFuYnNzNVJUbjN3aG53cHVjUG5ZSEc1WVhQ?=
 =?utf-8?B?dDR0elIxNFkrOGJlTWFlRDVtRHFFL0xmcEJXN0dHSjF6YmwvcDg0OXNzVFhv?=
 =?utf-8?B?VGE1U3V0WWhjNGY3ekNrR3B6eWdWTWlDQWFGOUZ1RzdZWFJuejRDUWhjMll6?=
 =?utf-8?B?UkJjOUZ4OGJWa1ZiYmVpdXUvejNnbGk3YXgrMkdQNFNuQmlJNUU5d1hxK3hS?=
 =?utf-8?B?OTBpQU83cmh0Rm9mOEEvUXI4UldyZDRxVk1YZ1dMeXJaamozM2I3d29IZXZ5?=
 =?utf-8?Q?Quq+VjHU8rw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0FFNFFxS1doN2ZVNnMzRER0SmNxc2pJZXNnY25UdWdYcFZVa2dueUZNVkQv?=
 =?utf-8?B?MHlzTzBpcnFBQmpCeWNyWWhEd3JuaXF3c1VkNkxCOVFpSjNnTlZpMThyY0Rj?=
 =?utf-8?B?cjhGc2taaWoxd2E4WlNoQkV6WXJyNldjc2Rxajc2RlExdmRaU1FqOVc3cGlk?=
 =?utf-8?B?Vis0cUE2VVNqNUpIV1ZBbkpuL2QzNStBWk5XT3VQSXdkeFB5SU82TEltVks1?=
 =?utf-8?B?WWQwUXZ4NGIyN2dCQVVhekI1amp2WDM5NWpWK1NxNU03UHYxRDgycEhKOTQw?=
 =?utf-8?B?bXQ1OFNwTnltSmwxWU91WnBabkwrVXEzaFNaajdEb1gvWUdVTitPY0V3RXQ4?=
 =?utf-8?B?M1ltNkt2cUk2L1BtazhpSC82UEExdTF1Mm5IVU9aTnB0M1RtUTN1bElwTXVL?=
 =?utf-8?B?enpLN203MVNieVFaQUFjaFlHSlFzNHBIZE9VNXd1cUtSditYcW1oSFJpQXpr?=
 =?utf-8?B?UGhKM2p3ZUhQKzJ2dGtlRlNXdkxSQm9HZ0o5ZlZ5aWtuMkFGaXFMaHExVDdJ?=
 =?utf-8?B?NmhYM1lOc3dCRE52dEhHUlBqTkczTTVYQmN5WVNocmVVWDdiMVNFdzNWMnlX?=
 =?utf-8?B?QWRJdmx0eGgwZnI3aG9Nc2Q5aWZqM2xSZ3VBUmVBeExpcUs0ZkFwaWdOZW1S?=
 =?utf-8?B?K29QS0VYZURZbHQ3d3BpYklIUGhQU3g4VE1VSktXVTBYT3dNZ2I1QnZ1ZUs3?=
 =?utf-8?B?N1hhNmNhaWliT2Yzc0l6dVdWb0NVRVhsbHRTQTBzejIvUCtIMVMvckVqUG16?=
 =?utf-8?B?cjJLNVg3U0RDdm8wVm9GRUNyT3pnaVZwWjd2ZEN3K1dBVnFGUUd6QW9MaGRn?=
 =?utf-8?B?VzlOaFUrZXZpOTdGc0g0TjFqZW1PNUd2ZDRUYWN3aVJFL3VMd2h4UUcwQTF4?=
 =?utf-8?B?R05WSUh1Y2NSR0FySCtPU2pmTGh1cGRHakxSWjZOT29SQmt2QW03VDFVOXZV?=
 =?utf-8?B?YjdwZnNWRm5taFdrcndGN3grVisva3JESmsyYlpBQjl4RG0ydGFnNVE4VHhz?=
 =?utf-8?B?dVRmMnh0SUw1Z1B5bUM3MkFNS3p6eXRNRTFjYWlXbzZhTldLTDZUSlMyaUdx?=
 =?utf-8?B?emRCU3ZzSzd3eWR2cG04L2Frbms3VVkrL0k1MmdVTHdqRTdYWjhaMmZweGJX?=
 =?utf-8?B?czF2MWNsNndxdS9qdHZNUk5BV0tRclhwdkF1a2doZVBYSjhsbFFzWDhGamlB?=
 =?utf-8?B?VWxWK3JpTEJTamRlYm0yOU5mRmQzR0JlWmI5NjVPODV1cGIrS09EYTdhbDA2?=
 =?utf-8?B?WkFSeXppSVVwMEdtUWthTHhkbHZjQmFJVi9xQVdMVGdXbmZZMlZtQUE2UW9T?=
 =?utf-8?B?MGRxTFE5M3BTRDRCSmQzNG9QTFgyMENsQUUrOGJGTmtVZWZvRzFZWVo0aHN0?=
 =?utf-8?B?aWk3UU9KajNIajlBbVZONnV0SmtNaWYralBJWTQ3b2dJaXZhUVhIVWhSTTJR?=
 =?utf-8?B?L3dYQW5GNldLbURVenl2di8wbENXbEJ2UGhSUmdSU2Y4bUorRVlUVEhMdWM2?=
 =?utf-8?B?TVI1eEpKTG8rZHRGd0ttZjQwWFpLR2Q1STY3Q0hYYkFPN0ZpZlFFa2Q5elEx?=
 =?utf-8?B?QUxWVnVNRUsvRXJCY0dGM2d3MVFPN0RKUXdqMGtQNmFQN0h2K21RY2pzZ2lh?=
 =?utf-8?B?MWVYMjJ3OEZreXIzUnR5aldxTnhKaDhrT0p6bHpDVWU2SEZ1aEFmamVEUmVI?=
 =?utf-8?B?NzlKUTRuM1pIMXBMVnVwbkRrZi9OOUZsa1FCeGc0SG54dVMrTHhld0NkemFR?=
 =?utf-8?B?dk9xL1VaVnBOTHZXRk1PVVdBZ2RpcWw4ck0xR0JxRHh2L3VqOGs4dWRzSnVl?=
 =?utf-8?B?NzFBc0poUm91K3RUN3pqL21mQmV4Z0g5Qm12TXpwZUtheGIydW5uNFB3ZzRQ?=
 =?utf-8?B?UFpwUmhZZ0wwOUczRkRYdjlieHdOUkpyY0RrVm9PdTBFdUVObzlUNkhPaUhT?=
 =?utf-8?B?bFR2QllKeklDNTcvYW4zZkZPY2txcXpGSjY0dXRZRXMwdGg1RlNGbWZSLzc4?=
 =?utf-8?B?UmFFSUY1NzdDeVFma3R6NUhsam51UUptSHVUMERlcXg4UVZoYmNJdFFvdnE2?=
 =?utf-8?B?dXhHSTJDOUM5K3Rmb1o2djN6V0lUNmZmV0luY3dIckZNaVN4bWxvOS9qQkMx?=
 =?utf-8?Q?foBJpn6LZgstnqgX0y6mcExGM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c6578f-5e20-493f-f1cb-08ddbe4718bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:44:32.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90Hz+rnZojvj5wB2FivsGxM2pal/Y9inBhdalpHb0SmT1hE7inUTzGXLHxTR6hx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9807

On 3 Jul 2025, at 0:43, wang lian wrote:

> Add tests for process_madvise(), focusing on verifying behavior under
> various conditions including valid usage and error cases.
>
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: SeongJae Park <sj@kernel.org>
> ---
>
> Changelog v3:
> - Rebased onto the latest mm-stable branch to ensure clean application.
> - Refactor common signal handling logic into vm_util to reduce code dupli=
cation.
> - Improve test robustness and diagnostics based on community feedback.
> - Address minor code style and script corrections.
>
> Changelog v2:
> - Drop MADV_DONTNEED tests based on feedback.
> - Focus solely on process_madvise() syscall.
> - Improve error handling and structure.
> - Add future-proof flag test.
> - Style and comment cleanups.
>
>  tools/testing/selftests/mm/.gitignore      |   1 +
>  tools/testing/selftests/mm/Makefile        |   1 +
>  tools/testing/selftests/mm/guard-regions.c |  51 ---
>  tools/testing/selftests/mm/process_madv.c  | 358 +++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh  |   5 +
>  tools/testing/selftests/mm/vm_util.c       |  35 ++
>  tools/testing/selftests/mm/vm_util.h       |  22 ++
>  7 files changed, 422 insertions(+), 51 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/process_madv.c
>

<snip>

> diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/se=
lftests/mm/process_madv.c
> new file mode 100644
> index 000000000000..3d26105b4781
> --- /dev/null
> +++ b/tools/testing/selftests/mm/process_madv.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <errno.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/pidfd.h>

When I was compiling it on arm64, I got the error below.
=E2=80=9Cfatal error: sys/pidfd.h: No such file or directory=E2=80=9D

I ran =E2=80=9Cmake headers_install=E2=80=9D before the compilation,
but still got the error.

It works fine with x86_64. I am not sure what I am missing.

Best Regards,
Yan, Zi

