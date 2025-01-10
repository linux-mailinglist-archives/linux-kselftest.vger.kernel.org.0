Return-Path: <linux-kselftest+bounces-24179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F2A08675
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 06:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215DB168A26
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 05:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF11A8F97;
	Fri, 10 Jan 2025 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WuGCBRzo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3243A1CD;
	Fri, 10 Jan 2025 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486500; cv=fail; b=KF6XFDGZEq2iTfIYDQSz0enruu4OvH5y87DJorsSvU5CikGjCAcihYQve6rk0LVEDTFxyxfm92fbS9zo/wNZTY/8w9VNaQOxyEE/IPGkcf/444lxItoHPSrqFuLN0odUdyPqoJNH2Q4ERqNIQOTpSj9X1MKzU068BMSPgIMCYtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486500; c=relaxed/simple;
	bh=nAAJYfPeO7u5kbhyMYsqdWpj7PYr3YBXNV4e0OLclbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kdcql4e29HDInNHwyjWRz6wzxInF7s5AtUeRhbh7Gdepm0oOYj9o20vXmZhfapY9VImDmVpbKSnp4DtF69ywQ59ACmbcSj4eJGIzhpssyJtgGFg/3jn/iIBkcfOD/2R4frSlE8dx4f9c12wtMPEjGbuEs8wxCkcT5oXwVYOkB/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WuGCBRzo; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsC8dAY7aXj179e70r4ESEShMLHD5qbwKns3dyMwWWyXOyiMPrPnxmLkdzeOhz9uuS1ncW85NdVj/+sqeZbXmaID3obtJosJNjpp7uGEwe7NIe8dQmr6migpYaOT9/03u05oPW2hIg3aw09Ckd4rY5an6T6g3/TO80feMVV1jNnSIhtXorvjVdMV2KoU8V+bBNKJM2Nnoydjqv1+YCNz7YcmP+aK7K/hXCiHSzTxK38D4w172T8xK8ovhWXmg4Ih8iF1h7/QB42aqKfWXvxtfIhLlvwjfL1HMKvD52j87VID2BGRNtWPHgGoUJJphpv0ihN1zoa6yBr6UAx7ZkOPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAAJYfPeO7u5kbhyMYsqdWpj7PYr3YBXNV4e0OLclbg=;
 b=jF8ryySePiAEAwndMrdwSDD4YmdDRuBqkU9Ww7CP3efx4kZRG+N9Dva1j+l9Hcz9ex8wvaZOhpRglrfv8mvNJhUqghzEjI6Kt+u8G4Urijg6nC8T79uNPDfPkDOJbPwMV6zzZHlI3bz+feabnX/nZ2DDT+EkkJUk/J0F3hwlLQRdzP/XrXZXODGy5vhKTYBZMsJsPhtNdcT/ZHZGijF/4UU37f6vA7wkTaScntcNsE4UcV3i56pKaSTuNrfdq8MCwPnpIvX+F8bcKSMec0+8vnmzCZ+/EjojpMuB+XP5XZOuUubQGaFRXdotDpHW5RvCUInenoU6W11lyg4JVQVkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAAJYfPeO7u5kbhyMYsqdWpj7PYr3YBXNV4e0OLclbg=;
 b=WuGCBRzoRIuexprS35ENBeB9vIE3ZGYUgmoXc2cEHUUrksZ3nVgWWe8G1LVcLVlNcdxpfgU3zG9hMyHiq0W5c6AqcBvOTIGl3tY0P3i8bQdn9yo4QKBDBecztGYatnjSqrdYuXpu8bFQHWZigZfU1Lf4KsxVPV1btomXez11QTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 05:21:36 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%6]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 05:21:36 +0000
Message-ID: <9b7d7abd-ce7d-479c-89a3-7f305c0e732f@amd.com>
Date: Fri, 10 Jan 2025 10:51:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v4 1/8] KVM: SEV: Disable SEV-SNP
 on FW validation failure
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-2-pratikrajesh.sampat@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20241114234104.128532-2-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: f331303c-a16e-4962-cde9-08dd3136a73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y01VN0pmdlV0VExaTnFHUGJOa0tLMFRHSGVHSElsN2k4S0ZXV1U4WWg0Rkti?=
 =?utf-8?B?VkdVNDZCZVMrMkFJWGEvNnd4VXZ1QVhmS21ESXJOQU82MjJ3YkRCcXl5YXFJ?=
 =?utf-8?B?c29OdXZWQ0lhNW5UK1NyT1dnOW4xQm5vTUpWdWNralo1c1VEUDFnb25Qc05E?=
 =?utf-8?B?RVZZakk0U2huNTJxR0JoMGI1NFZFc2J5WlpPZTJMV3IrTkY4RXhIaU5ZUUlo?=
 =?utf-8?B?ZjBGYlRTTzBqRXJkelBoNzJWMWwxZ3h1V085YmZQakpDZmIxbUtybmFtbi9r?=
 =?utf-8?B?S1pmdFpScHNQdFRJaVBFdHJ2Y2ZXWVRnK1ptRXowTzZrUkdOaFVFUEZjQ3Qr?=
 =?utf-8?B?WTF3LythVDhCMFVuMkdlL3VrcUkvL0pKamJROVZwMFdFV2hFOUQ0TldHcERR?=
 =?utf-8?B?bjFGamtWVU5ENDlMcWRiclBtbGlPalBnUW0ycXJVOEFadElDV2w4b0lRNjN0?=
 =?utf-8?B?elRLdHNRYlExUC91WGdWTTBKU2hQblpobU4ycnN1ZWZ3VWNpM0I5aG5DMW41?=
 =?utf-8?B?ZjJmU3ZPSkp3UWhUbTdYMW9wSm9xcVNQK0ZIOTFGWmxNSzBkeS9iOFNZdFNs?=
 =?utf-8?B?RTNlMWk5RW4wS0Ezenk0MWhCbTRyUE9hSU5HekZSNWE1TGZxREpsR3IzMlR2?=
 =?utf-8?B?d0dDbW1rNVdINjVuS0RQUG5DRnNmTTBRejJPVTB0Um9NbkxUMXlMNnBaWE5J?=
 =?utf-8?B?bGNhMk81bzMxeWJOSjY0YlVJeWl0VnZQWTMwRGExTGYycC9QVi9HWWZCc1Fm?=
 =?utf-8?B?Y0cvc3ZvS0tUTkpnbG9EbGtMODNQVjM1cHNkUEExbElwZjE5bDZqQW5MOElV?=
 =?utf-8?B?b1NPR0Znc3FmczcwSHhFZ2xaTko4WFU1OFpFNTBuOVp6M0VGMTh6eUNyZUxM?=
 =?utf-8?B?R1VveVhLc3FMdnREL0k5b2g3cVBVUUVXQnBVd0dZVldRYW5rdXM0bnkyNUEv?=
 =?utf-8?B?MXRpOUxhNHRMWUJ1bmRqU0pxaWEwdjhFS3czM1RsdHZ6UHZrVXREMjdPS3Ax?=
 =?utf-8?B?aXRMRjNZeHM2cFo2VUc5cm9IRGs0OXJHU2pDN1JUQmNielJqRFBsKzBUR2pl?=
 =?utf-8?B?NEJPWEFZQ1ZjM0FxWUoxempJdE5SaUVMbWpTMmFDV1pWMzJoVC9pQ20xVi9B?=
 =?utf-8?B?OHcxWmp1S2h5M2poRXl2TUZ3WUtvNkdDMytuK0pqelNRckZLNHRKOFVUQzRv?=
 =?utf-8?B?SENEWDYyNGIzQ2xoaHJ6cExhNkphbU9Qaml0cVlVejh3Skc4WVhuOW5nUzFu?=
 =?utf-8?B?WEFGQnJqUTV0Vmhpa3hJRHFLSTRVY2VMY1NVcXJxbnNnZllXeHpVUlllZUxD?=
 =?utf-8?B?ZHZ2SlpiZzlxTFZPZktjZGNQb09TMGkzWlR4WlY1bUdrR3NCNVAxOWNMZnJ0?=
 =?utf-8?B?QWp3dXRMVEdnZ1RseTMyRmFZTnlHQkljM3B0ZmRnVHpwTWlPSHAxbXdQKzdu?=
 =?utf-8?B?cjVnditDblhVUzVwNS9CMk5yTmkzeHViTlQvOXFEVWRYN3ppREpDblBkNVVk?=
 =?utf-8?B?SlFaV3lkM0Y1b1lXVDZmVzZERWVzbFpjVVpTclZ3ckhOeDdkNlR3R1hnM0to?=
 =?utf-8?B?dUNaSmRMeWZtL3hQbWp6RkVoUUk4RHZjaVJYQUlsV1NvMWt5bGtRcFVCVTlG?=
 =?utf-8?B?N0JJdS9HeElFZzJPVnhvblpzd204TVB6akpOYkRBeVlhWEhjV011eXRBK29h?=
 =?utf-8?B?RGR1ZThBVTdLbEV2QWx5RW94bGg0eCtmWm5pTXNJR2MvdCtsZkEyTUZaQVN3?=
 =?utf-8?B?bTl4WEpoSXNyT0JyeGdKVi85Mi9nakI3MUM3Q2pab1JFcnRYUGxuZng3ZGxW?=
 =?utf-8?B?aU9sV1gvUy9ZT0doakpNL1hVSzI5L3hYSU4xQjRjSTI0Y1ovR2dsQzRscUxD?=
 =?utf-8?Q?1Xzz3XlLhu3kQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0Z6a2NGVlZNWnRmVUl4WWcyb2xGSG8vMkI1NlhlNjdyNGtNMmc1U01YQ2ZV?=
 =?utf-8?B?aGRZeHNLaUtmWGEzcVRQLzN0N1FrWmkvWks4a1RVSjZlRTAyaWhUWHdMUThn?=
 =?utf-8?B?MzdBZ1BSMHRJWHZLT3dTbDZ3UXorVWIvNEJ1V09BRWZQWGVMR3BPRlkxMmVE?=
 =?utf-8?B?WkVIbXhpS2RCQXlyR211VXAxYnZNU0ppOU93aE5JTXhOdDYrcU9zYk1NMHNF?=
 =?utf-8?B?a25QblpoZHllZHhvS01HU3IrKzFBSXRKMEFoajhqMzJqdnhvQ1BRVnExMm45?=
 =?utf-8?B?bFpKU3NqV0JEWFVzc2V2cUdmdEJzeFVsS296ODZSM3JkK0JabG4yWXBKOFZj?=
 =?utf-8?B?YXp5c3I0bFBtNnlrUDhjZ1NVWnBTcm5GcUljVmU0UENqUkl1b1BQL3VGOFJD?=
 =?utf-8?B?MkJjTHBQOFlZcFhkVEw4VkIxa1BxWEFDRzB1U1dpTjYxUXpNZGF3dS9MU3dw?=
 =?utf-8?B?L3JNNi9McVR2UUVIQkJsK3o3NDg2S3RJa05KMElFS0FMR1ZvOHJYblk5RjBR?=
 =?utf-8?B?dUtQdTJkbWVjOHk5NWYxUGFjeEZ1M3Z2eFdyNVJPQm5ZR0ZkbDcwYmlmRnlE?=
 =?utf-8?B?aE9IelJzUGc0NXVTOG9Rc2V6YlFOcVlRK3U0TUZLUngxcEkrajFyZGFVMU1x?=
 =?utf-8?B?Mko1RHo1cVFaemxDV1pOMGdVMUc3d3o2U3c1UnRpUVQ4bXlpbHhINlFGN3F0?=
 =?utf-8?B?ejNuNkRCVVJFRFlDTWhhblFvNEZhcDNKMVlsYTVzTlRCSGNUTjJCNWp1cWNW?=
 =?utf-8?B?VWxKdm1YOVJ1NDd5VVErc2lwUzdONWlsQVJKNUMvUGN5U1drSWNTSFUxL0tT?=
 =?utf-8?B?NitUMkdYYnJIcGh6c3dGMStvWE5DNFFCc0xSbDRORDFLUG1OQUIxaENpcDVx?=
 =?utf-8?B?eStiRTJ6QVgyYnF1bXRHWDVwVmZaU1hKVUVkQ0tWT2plRjlzWS9OVmhMSkIx?=
 =?utf-8?B?M0d2Ymdna3FLcFBpM05XdTBKYXIyaEVOaklydEZjVjRtQVZOM2s3RjNBWDA5?=
 =?utf-8?B?bHlwSCtkaXdHV2JaZWRyZi81alo2SHA1eURPRE5UeGZ4ZFdCWlV5N05ScUsr?=
 =?utf-8?B?dmc3QmtyMTFmVUhMc28wcjNUY1prRlZuamU0TGhtMUJnVy9MMlZYUmlJaXBp?=
 =?utf-8?B?T21UMTEwdHBCT3p4eU5iM1FsTkZ1TG5EVmpTUkROaWFURXpVTVhsbCtVTmEv?=
 =?utf-8?B?cE44Vm9hU05HL1RTSXhodVI2RTZLTjBjeEVjZmlUcXpGekhpYU43dmVkbWFh?=
 =?utf-8?B?cGVLL3FmQmpuUDZsaXBWeG1VQ09vb3pBSDZja0p5Z0Y2RzEzWUxvaFBwUDJ0?=
 =?utf-8?B?eDNRR005WjhBa21sSEtqbkxhY0tFZDhETCs4Rm1jLzVpNWZaTjY3YnkzcTNV?=
 =?utf-8?B?c0UzQ3RVbmRoWEJBV0NId0owRFdWdWVIcWxQRjY4OEdpdWZ0TTNpdTZBem9w?=
 =?utf-8?B?alloWTRBQm4xTWoxQU5ib0tkNFprdDFPQk16MGw2Z3ZrUnB6KzM4WHBtZGhj?=
 =?utf-8?B?S2hQQ0dmbm0xNWJQQjVGMHlIVzg0dFRDRFFqM2RaMzk2eTNTT0FkQ012bVJr?=
 =?utf-8?B?eWEwRkdRalFydmsvTFg5OWwvWm5BUzA4S3czcVMzL1NDYlhXUDR0WndFY0pH?=
 =?utf-8?B?d2NFUitvU05MVG9PekQ1Z1A3NzVQVmJ6cnRybFRJdVdsSVc5dGlqVWhQMVlv?=
 =?utf-8?B?R1RHOHdvMG9hUHpPNmpZMWl0U0N3bUlBUDJoa2hpWUpab0R1Zi82Z3dUWjhw?=
 =?utf-8?B?L2V6UDJXbW5wdEhiRXpORGd3a0FaTkhkMTJSWDdYN3VGZkNUTWc1YjVlZ2VI?=
 =?utf-8?B?SmhoVUFvcnBJRDFrc0NXaEIzUmtuRDBTU3VPV2RJUWNYNnF3NWc2dXMwR01Q?=
 =?utf-8?B?eDVhZHpvYzRzVVBQR0FmWUx5K1dEVlVRUkl5L0lPMDcwR2Joc05EWjh3NC9o?=
 =?utf-8?B?Unl3U3F6d0p3MEFxWDFGeVhKMmRyZ2k1cG15dGcwaDUwU2hWVmhIQ0s0WjYy?=
 =?utf-8?B?d0MrVEJsejBTY2NWeEFOT0I3WmN3SXoxMCt4UHVjRXIybnJQNlh3YTZqSXU5?=
 =?utf-8?B?U1k0RlhXNXA1U1FUWEtVc04xdEs0Q1ZLNWIwN0UxbkNLdk5UUzgyVEF2cnF5?=
 =?utf-8?Q?MN1Ke/cpGHqsOxGijhZ7IKD20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f331303c-a16e-4962-cde9-08dd3136a73d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 05:21:36.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3nCcYJaHdYp4K+CELas5YVolJbJHCf70fILcwe9iJImQd1YWmJBnzjnmMWvny1sKQwc1Ca9PACLlNFQ7IfwBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078



On 11/15/2024 5:10 AM, Pratik R. Sampat wrote:
> On incompatible firmware versions, SEV-SNP support is pulled and the
> setup is not performed. However, the platform and subsequently the KVM
> capability may continue to advertize support for it. Disable support for
> SEV-SNP if the FW version validation fails.

Additionally, can we ensure that if sev_platform_init() fails, we do not
indicate SNP support?

Regards
Nikunj

