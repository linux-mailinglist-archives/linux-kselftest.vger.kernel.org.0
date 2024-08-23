Return-Path: <linux-kselftest+bounces-16198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4547D95D924
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 00:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE521C21B68
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA4F1C7B93;
	Fri, 23 Aug 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bi2oDTbF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0886E15098A;
	Fri, 23 Aug 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451398; cv=fail; b=Sa4gDQO/E0gM2l68+u3y/Fv4CdVZCGVuTu/rg1QtwAHOlK0vIo6Ovx0x/TRc3GXSzNSEYbeEMYmBWF3BEyoI1jDX7MPUH5nHW8ZxeaF0Kr2lOgqpaT5BTG5p80ecA9IizvNMRFRPABRWFmaZJgV6IIiC1a5aS40mZN2NkRUWDsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451398; c=relaxed/simple;
	bh=iix4Yy+PlFeCI6SeHobPedV7eS2o0OvGA5lkzgtVo9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XLZqzO/Z2ShekAcSrCW+mRUcmVFFIZqGzGvb6e2DKZjKP2fQTThpIUX6RTSYmbuNXh6s0hxqhmrFiPh4geEnhrN2TfIQXRHay9vDmIM4cfSOmSSsaGYXiYevhZPwu++h3zO26sinrCrPZBOtFEEjEa7spM5+g5AdMGDxBsqVNAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bi2oDTbF; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kULme4T7tdTsJhdN1BKiUROxRjV08gJPo+h5SY7aai2PEHWhYhR36tEk/JuhHN7YZXJAwrfeYCz0DT233LQldYoo5Yy6E0krzdHMU2cn4hsgs7CsK6yeQM2/YsA90FtatoQmYawRJpFkuTF/0sZoKvXeIxyJa8hOr44pA/i1vOZ8UGIQSpaVy65KVoPaEbe4mHVQV4ggS6wE2oxNtwvm9rkmQr1wn5kdRK5c0JTKXajYxgbVConAX3VPIY4aWgIvlIZS8FR/2f+m3dkaciT4Zbkakg5IxlfbH42D5f0ATfjdlBsuk8lmWmkDz7pFMr3DHkychf04OHpiTAI9ugQAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0ynk2pS4y48G0T26ya/rtutNTCq1rc5gUieQcSaGrw=;
 b=hJAE6/gjsa6ZMavrINDhd5LVygARV2d5viWzNnexCo/Rsa0TtrOEeCrZV7lMxO7HrPiJ4mIUH30b1mf3+8eJhauVB4eAQfS7khx1lCj6aYaJZ7yZPT6vrjyfLXx5s+rY/Ftt1s/3yVW7kyxD63fInQUyzTizkZz99T9v0Q+5mjYYKCa5H608TvkAmxwRBabZOU7nKhuyL9VXhjT4jNZLqZibXtrUHExs4vdUDh6UMnM0gnaiy5IRsluOu+TUh8tT5B7rk7nYktavbleJfaLmxjAUl4y6Uu5bOQX3s6ZqWizFID3NgHLvXugISwg0mddfFXfep3lXpqIHdN7jgwC8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0ynk2pS4y48G0T26ya/rtutNTCq1rc5gUieQcSaGrw=;
 b=Bi2oDTbFl418QT7f/1Oa/uGiT7BGXn+jBAjWVhQccc349WE2oG/uTD5tYiEa9294OoMKWEGFZ8kZZnW7C5bkfRslQvT0yO3mJeXesnyvkMbBct9zWMI12ohfkj9WaB5eila/Qr3y5OPjv8gI//CcLS3a6cuF0HDF9DHc3FYff8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 22:16:33 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 22:16:33 +0000
Message-ID: <9079a7e7-17e6-72eb-3510-b07a60ce78df@amd.com>
Date: Fri, 23 Aug 2024 17:16:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 8/9] KVM: selftests: Add a CoCo-specific test for
 KVM_PRE_FAULT_MEMORY
Content-Language: en-US
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 michael.roth@amd.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
 <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
 <607e76c0-6e9a-4961-873b-0b952b51faff@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <607e76c0-6e9a-4961-873b-0b952b51faff@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:806:22::34) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bbba122-a72f-4b05-aa62-08dcc3c13ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1NJcURwMmhUY0NFRjZHOEI0dXhvYUlSd2lhNENDNjNzdGRoMndyM1Jsd0pX?=
 =?utf-8?B?aXJvU2RSSitaN21wSiswY1dreWp4Q2lIVDRJVmF0dmw0NDJLRXpZSHpvblJV?=
 =?utf-8?B?bG5EMjZKQ2UwRW8wY3BzbmsvZ2MwM1FOMjBycnZwZS9QWGxqcVhHYzQyK0x3?=
 =?utf-8?B?bTdTaUtidDZYNWJ0VXJRdW9aNGtEeTRWYXk2ZjlTWklGR1pLdVltT2FrTXpq?=
 =?utf-8?B?R0dKenA2MUdJVGM5aTJ3a0N3dENuVEdCUzhQVTUvbnlXYnl0VXhwNkFkZXQ3?=
 =?utf-8?B?dGQyYWdSRWdZM202akZ3dFdCTkJGWXhsMzZTSTJDK2ZYRDN2T3RJUmFEWkY5?=
 =?utf-8?B?dmRDeGw1ais3OWRUbHl0TnBvRVpMNnBtWHBHT09ZaTN3cjEvbWh0c0VjYUZ2?=
 =?utf-8?B?cFBGeTJVZ0FMb2RrLzFWc1FwMi9ZUjBKT1pjOWhLYk5jZy9YUHRKRU8yVDJh?=
 =?utf-8?B?cXFaNTVCQzdhQXhNemQ5R2grTG05eUF2NEt0OHZQU1FRNlhKV3RqcnFtM1hq?=
 =?utf-8?B?bGFGUE9PclVGSXMvTndhWEFQMGFrbGFPT3IzendLY2R5MTNTaFdXT01yRERk?=
 =?utf-8?B?MXNxWFNJNWtqa1hKdng5QjEzaG5QWVljQ0pGTGZFeUxucS9hbXJzU1gvcFVa?=
 =?utf-8?B?YjlNYXo0WklBRmU1Vkw4Z2dJMU5PYWY3RWtvMkwwM3VWenIwb2NBQUtHcE01?=
 =?utf-8?B?QUVZbFp4TzZnREJjemRpQXFSUVRyYWRySkdIL0NiVzBjTlFZK2VZNmh0NmVV?=
 =?utf-8?B?dnlnUHB3aTNJc25UeU93QU5UYXBNUHBvVE9UbHIwVllaaXFMYWFZSXNHZC9k?=
 =?utf-8?B?aFQvQzZBNXdTUjZzTkZTS1RCTnRpdENqQStQYzl5Y1NoeTRjN3ZQcmdmWUdQ?=
 =?utf-8?B?T3h4M0VIZ2t2UFBoQWtrYXdaR1VUUFNLMWg5RmJVLzlnZndEZEFWTUpiZXJO?=
 =?utf-8?B?VEZlbm5HWTBFRFVDMDdWZVlzNE10UmNETm5VSTI5amt2RUllR2pYSG5MN1Rs?=
 =?utf-8?B?dCtmVFduakRpMWZEbUJrY3BMZkMrUnd3czlxTXkwWldla1hmSkxDS0dyNGlY?=
 =?utf-8?B?T1RkSDRIek9IWHdlQWtCTWZpUnRLUjRCZlUvUmRhWDllMzRjYjRsWGwzN2dY?=
 =?utf-8?B?dEZJQ0Zwd0RZYnBkRGRJZy9VMXhrU2lkZjlaVTVDRjJpNGpDMWNJL3Qyend4?=
 =?utf-8?B?WGFRSHc3WVVxcVdWQWdYakJCTUcrUnBBK3pTUno0bXdjbE92VlBkWXI3a2dH?=
 =?utf-8?B?cVBPZElVUG8zZHA5MUYwakFuUHRzRm9HK3pmcjhJeWZzam05OHJBVE5MTDBZ?=
 =?utf-8?B?QTRmVzBZWVhLVDFiTndQRWtjMDZmRjhGcjJFeTFmUTU2SnhqS2x2U3dCMW8y?=
 =?utf-8?B?VWczQWVFSjZPN2ZhYmZzcTN3WE9FZ0ZyVmZveTJLODZzd2U0NlhwTGhSZG92?=
 =?utf-8?B?VlBlLzFHWXVyWUtFY2IwRkFzTGJzdXRRVml1Si9ldnI0U0lTdUJ0dG1OaHVN?=
 =?utf-8?B?KzZKMkp3dVdOMUN4ZjhrL0tLMEZSZFQrelBCSUNLZUljVW1udlNqVlYxeml4?=
 =?utf-8?B?dlN0UXdkNVlhWTc5ZmxIWElOa2tTb3pKSUlhREsza1JXTnpFR3oyTGd2ZW1r?=
 =?utf-8?B?YVQ0ZWlGZkFPM2JHSUVyT3NhUi95NkNjUDdBeUZqdGpZRHpZNVluZWV0dTJN?=
 =?utf-8?B?WG1GSzRPK0hzQStvQ1BVQlV4M0J4Uy8rWnkyRHpoZFdBOThVK3hFeFZHMjZO?=
 =?utf-8?B?Wk1zSW05cEN5aWxUWmJPM2ZpMEVUL3pvTVVFUVNZQ0Q3ZFZWRVdaVHdqNTdj?=
 =?utf-8?B?M2laM1lSMktXbzY4Q0hqdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azA2dWdJUE0yQ1R3Q2NlMDJLVFpDSWFMU2JxMmkxdEVmOEhDVFBrTFZ3MC83?=
 =?utf-8?B?TXdDYjlSTTFuMW9MNng1TFliTWJjclpDdjFDV2I4K3lycXluRUhTeFZ4WEN6?=
 =?utf-8?B?WEFocUZ1QzBwc3lQRktFZ1JMSGo2OCtFRk5obUw3SEZDSVdaL0diUkNmZUo5?=
 =?utf-8?B?MnEwaFhBdGhrVXQ0TCt0MHhZWkkva21QQUs1Qnd0Qkl2MlFFRGtPQ3pKRXVY?=
 =?utf-8?B?NnlJWGtYOENSOFU3MmU3aEw3dW9FZy95cmRqVUF5Q1FTMHlWaStpYnVnKzZW?=
 =?utf-8?B?Y2NDOFNWVDZ2L2F5azZyMDhoQ1IzbkZNR3dEeldKekRtTTZlRzMzeVBUdCtF?=
 =?utf-8?B?RUtUYTdkZDYyZFdYdWZETDFzelZLUC8xSXI3SkV4UzhCbDN6blhaeWEyc2c5?=
 =?utf-8?B?dTlXZHFnRmU5bmRRRUZZZXZqaEN1MU5CbHlQa0QyK05ycnpMaXJ3alJhOG1w?=
 =?utf-8?B?a09SWUxCS0xCZjZidmdRek5pVDg2WWg0U2h1STd2eC9waStQa1NmdFhueU5D?=
 =?utf-8?B?dndJR1BnSS9WQWVwbVJsMlhrb3RJZTkyNnAvQ1NTbVlIK1BIVG9Ub1Y5c1Iy?=
 =?utf-8?B?a2VFNlNTV0hhV2RDNkxXTWUvSjd1NGZiN2hOZG9WVHJLWVZlZlRNd3gvVHF4?=
 =?utf-8?B?S1Z6bTEybmRjMjlGRVZOWFVzT2xia1pOVmVtNCtmaDltU3ZXM2Y4ako4MVRx?=
 =?utf-8?B?TXhEZmhDaWV1ZTZqT3ZaVXk1c3NiU09qalhDQU5oWEJVQWFBRldPQmF6WGxv?=
 =?utf-8?B?QmJpaDNjdGx0SFdoQ1Q5MmhTQUhrRDZWblpIbG1xR2NNb2dqc0ZrWm1PNUdG?=
 =?utf-8?B?K3c4RnhXVkdLVzdSTlhLdWQ2bzJ5c0dVSDJRZXMzTG5wMVhpYytSRVZKNlFH?=
 =?utf-8?B?bnNiM0kxQllSb3NDSndoZUNaNzM3ZjVYU3lmbFIxSzQvUDB0MkZuQW5DWkw0?=
 =?utf-8?B?eTFoc2lhZVVwcDRyLzVKV2RIWkRpRTM4Ym1iLy83cTZnRGd1VVNxZWpER1lI?=
 =?utf-8?B?Ym9zQ1UyTXhmeFJkeWlNQVk3ZkFTM2c3UlIwazRBTGpQS0t5dnovYUcwUkxI?=
 =?utf-8?B?cFBtUlVXTThzdEFib1phdlVuTmx0a1NVNi8ydGhQK1ltelVQZEQ5OVJZQlJB?=
 =?utf-8?B?N0MrTlVMTUlKbm5TNDJoRGJ6UnZaRjlGQXRiQlNNMkZMZDV2bjJCa3VHNC9j?=
 =?utf-8?B?L251NVo5MzhjNHFWNnVGQ0d1bGxMRHh0YXZhc2FZODVlN2dnMnhJMGNTYjQ3?=
 =?utf-8?B?MkVXRmkzNUF4VTRDaEFoT3owdmtQWDNYemtTMm0wcEpUMUkrRWsxYk1NWjdj?=
 =?utf-8?B?RE1nTTdpYmk5bWFibW1oYkVaU1BQaG5Pd3VOeENscGxtOU9nMDJORWJRcEFG?=
 =?utf-8?B?c29NVXhlZ3hvci9sMVFJZ3dZTndVTSs3VkF1RCtnL3NMSG1ERUVmNXNtOFpl?=
 =?utf-8?B?eU1zRm1XMUJNcXd0RUR5ZVhhZG1RZzYrYXpsRkRMc0VLb3V6Y0dTUVBsbHFy?=
 =?utf-8?B?b1VkY0pPaUFkQlluMlc1ZG5FaHhxTkN2aFc5azJob084M2FkbVdpT01GRVQy?=
 =?utf-8?B?TEhWMEs5MGVMSmRBbXJ6a21Nak5FYnBqR3p1RDFDTlp0ZEhma2REblRubXh5?=
 =?utf-8?B?RHlueCtGR1lCRXB1TWFRa0NPc29SMTNWZ2hlZEZFcjYyL0dDTmVodFN0RVpy?=
 =?utf-8?B?U2djTTZxa0dEQkRoOWtlZ2JlemFSUjRiNDFMUTB5d2lKaExrbVNLbmhlOENR?=
 =?utf-8?B?bFJQamVuQXcxcmN2UU9FOFB2WWhMV1czSTVUcXJSVmhwN0s4akwvU2MrVUt6?=
 =?utf-8?B?cGVHNGFhQUJaQ01LY2NtZHQrbnNsTnNKT2QrUmtzV0ltbzVSdTJlZ1A3TG1M?=
 =?utf-8?B?Q1l4Wld0TTVmNDRXWDhuRmZVc01RSCtQU1dKTWF0RndIRXRtL1B5UFN4emU4?=
 =?utf-8?B?bmpVZkZ2R29xSk0xTFNYNUdqZTlpYS9QOXE3MHROY3FxWHJud3VwNmVVSDZS?=
 =?utf-8?B?QXVtNUlMV1lsSzNCM0lyaVFjOGlXOEFmU0ZsTFFwZDJ2YjNwV25BK2dzTFRN?=
 =?utf-8?B?Yi9ZT3Q4RGNqT0NENjFoejhqOEsvajJuNkF2RWFqak9nekxxS3VpZGxqYURX?=
 =?utf-8?Q?/fxl8JrAku61ojyJ8RgktdVqB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbba122-a72f-4b05-aa62-08dcc3c13ec3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 22:16:32.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmhRQvLZGAqmWTJSjuTiAq655laJhI5AmNDfhFQpLZ3xruhWOUBWmyoSYUt3Qnb2BnxkolcNjWS43kpUMW4PIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

On 8/23/24 15:23, Pratik R. Sampat wrote:
> 
> 
> On 8/16/2024 2:23 PM, Pratik R. Sampat wrote:
>> From: Michael Roth <michael.roth@amd.com>
>>
>> SEV, SEV-ES, and SNP have a few corner cases where there is potential
>> for KVM_PRE_FAULT_MEMORY to behave differently depending on when it is
>> issued during initial guest setup. Exercising these various paths
>> requires a bit more fine-grained control over when the
>> KVM_PRE_FAULT_MEMORY requests are issued while setting up the guests.
>>
>> Since these CoCo-specific events are likely to be architecture-specific
>> KST helpers, take the existing generic test in pre_fault_memory_test.c
>> as a starting template, and then introduce an x86-specific version of
>> it with expanded coverage for SEV, SEV-ES, and SNP.
>>
>> Since there's a reasonable chance that TDX could extend this for similar
>> testing of TDX, give it a "coco-" prefix rather than an SEV-specific
>> one.
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>> Co-developed-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../kvm/x86_64/coco_pre_fault_memory_test.c   | 314 ++++++++++++++++++
>>  2 files changed, 315 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 48d32c5aa3eb..65d19b277b06 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/coco_pre_fault_memory_test
>>  TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
>>  TEST_GEN_PROGS_x86_64 += demand_paging_test
>>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>> diff --git a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
>> new file mode 100644
>> index 000000000000..e16fe185fb5a
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
>> @@ -0,0 +1,314 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/sizes.h>
>> +
>> +#include <test_util.h>
>> +#include <kvm_util.h>
>> +#include <processor.h>
>> +#include "sev.h"
>> +
>> +/* Arbitrarily chosen values */
>> +#define TEST_SIZE		(SZ_2M + PAGE_SIZE)
>> +#define TEST_NPAGES		(TEST_SIZE / PAGE_SIZE)
>> +#define TEST_SLOT		10
>> +#define TEST_GPA		0x100000000ul
>> +#define TEST_GVA		0x100000000ul
>> +
>> +enum prefault_snp_test_type {
>> +	/* Skip pre-faulting tests. */
>> +	NO_PREFAULT_TYPE = 0,
>> +	/*
>> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping non-private memory
>> +	 * before finalizing the initial guest contents (e.g. via
>> +	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>> +	 *
>> +	 * This should result in failure since KVM explicitly disallows
>> +	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
>> +	 * initial guest contents.
>> +	 */
>> +	PREFAULT_SHARED_BEFORE_FINALIZING = 0,
> 
> Just spotted that I have initialized both NO_PREFAULT_TYPE and
> PREFAULT_SHARED_BEFORE_FINALIZING to 0, effectively running the latter
> test type twice. I will fix in the next iteration that I post.

Enums start at 0, so you can just eliminate the assignments.

Thanks,
Tom

> 
> Thanks!
> Pratik
> 
>> +	/*
>> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping private memory
>> +	 * before finalizing the initial guest contents (e.g. via
>> +	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>> +	 *
>> +	 * This should result in failure since KVM explicitly disallows
>> +	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
>> +	 * initial guest contents.
>> +	 */
>> +	PREFAULT_PRIVATE_BEFORE_FINALIZING,
>> +	/*
>> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping shared/private
>> +	 * memory after finalizing the initial guest contents
>> +	 * (e.g. via * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
>> +	 *
>> +	 * This should succeed since pre-faulting is supported for both
>> +	 * non-private/private memory once the guest contents are finalized.
>> +	 */
>> +	PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING
>> +};
>> +
>> +static void guest_code_sev(void)
>> +{
>> +	int i;
>> +
>> +	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
>> +
>> +	for (i = 0; i < TEST_NPAGES; i++) {
>> +		uint64_t *src = (uint64_t *)(TEST_GVA + i * PAGE_SIZE);
>> +		uint64_t val = *src;
>> +
>> +		/* Validate the data stored in the pages */
>> +		if ((i < TEST_NPAGES / 2 && val != i + 1) ||
>> +		    (i >= TEST_NPAGES / 2 && val != 0)) {
>> +			GUEST_FAIL("Inconsistent view of memory values in guest");
>> +		}
>> +	}
>> +
>> +	if (rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED) {
>> +		wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
>> +		__asm__ __volatile__("rep; vmmcall");
>> +		GUEST_FAIL("This should be unreachable.");
>> +	}
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void __pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
>> +			       u64 left, bool expect_fail)
>> +{
>> +	struct kvm_pre_fault_memory range = {
>> +		.gpa = gpa,
>> +		.size = size,
>> +		.flags = 0,
>> +	};
>> +	int ret, save_errno;
>> +	u64 prev;
>> +
>> +	do {
>> +		prev = range.size;
>> +		ret = __vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
>> +		save_errno = errno;
>> +		TEST_ASSERT((range.size < prev) ^ (ret < 0),
>> +			    "%sexpecting range.size to change on %s",
>> +			    ret < 0 ? "not " : "",
>> +			    ret < 0 ? "failure" : "success");
>> +	} while (ret >= 0 ? range.size : save_errno == EINTR);
>> +
>> +	TEST_ASSERT(expect_fail ? !(range.size == left) : (range.size == left),
>> +		    "[EXPECT %s] completed with %lld bytes left, expected %" PRId64,
>> +		    expect_fail ? "FAIL" : "PASS",
>> +		    range.size, left);
>> +
>> +	if (left == 0) {
>> +		TEST_ASSERT(expect_fail ? ret : !ret,
>> +			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
>> +			    expect_fail ? "FAIL" : "PASS");
>> +	} else {
>> +		/*
>> +		 * For shared memory, no memory slot causes RET_PF_EMULATE. It
>> +		 * results in -ENOENT.
>> +		 *
>> +		 * For private memory, no memory slot is an error case returning
>> +		 * -EFAULT, but it also possible the only the GPA ranges backed
>> +		 *  by a slot are marked as private, in which case the noslot
>> +		 *  range will also result in -ENOENT.
>> +		 *
>> +		 *  So allow both errors for now, but in the future it would be
>> +		 *  good to distinguish between these cases to tighten up the
>> +		 *  error-checking.
>> +		 */
>> +		TEST_ASSERT(expect_fail ? !ret :
>> +			    (ret && (save_errno == EFAULT || save_errno == ENOENT)),
>> +			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
>> +			    expect_fail ? "FAIL" : "PASS");
>> +	}
>> +}
>> +
>> +static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa,
>> +			     u64 size, u64 left)
>> +{
>> +	__pre_fault_memory(vcpu, gpa, size, left, false);
>> +}
>> +
>> +static void pre_fault_memory_negative(struct kvm_vcpu *vcpu, u64 gpa,
>> +				      u64 size, u64 left)
>> +{
>> +	__pre_fault_memory(vcpu, gpa, size, left, true);
>> +}
>> +
>> +static void pre_fault_memory_snp(struct kvm_vcpu *vcpu, struct kvm_vm *vm,
>> +				 bool private, enum prefault_snp_test_type p_type)
>> +{
>> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +
>> +	snp_vm_launch_start(vm, SNP_POLICY);
>> +
>> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +
>> +	if (private) {
>> +		/*
>> +		 * Make sure when pages are pre-faulted later after
>> +		 * finalization they are treated the same as a private
>> +		 * access by the guest so that the expected gmem
>> +		 * backing pages are used.
>> +		 */
>> +		vm_mem_set_private(vm, TEST_GPA, TEST_SIZE);
>> +		if (p_type == PREFAULT_PRIVATE_BEFORE_FINALIZING)
>> +			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +	} else {
>> +		if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +	}
>> +
>> +	snp_vm_launch_update(vm);
>> +
>> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
>> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
>> +
>> +	snp_vm_launch_finish(vm);
>> +
>> +	/*
>> +	 * After finalization, pre-faulting either private or shared
>> +	 * ranges should work regardless of whether the pages were
>> +	 * encrypted as part of setting up initial guest state.
>> +	 */
>> +	if (p_type == PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING) {
>> +		pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +		pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +		pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +	}
>> +}
>> +
>> +static void pre_fault_memory_sev(unsigned long vm_type, struct kvm_vcpu *vcpu,
>> +				 struct kvm_vm *vm)
>> +{
>> +	uint32_t policy = (vm_type == KVM_X86_SEV_ES_VM) ? SEV_POLICY_ES : 0;
>> +
>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +
>> +	sev_vm_launch(vm, policy);
>> +
>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +
>> +	sev_vm_launch_measure(vm, alloca(256));
>> +
>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +
>> +	sev_vm_launch_finish(vm);
>> +
>> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
>> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
>> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
>> +}
>> +
>> +static void test_pre_fault_memory_sev(unsigned long vm_type, bool private,
>> +				      enum prefault_snp_test_type p_type)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +	struct ucall uc;
>> +	int i;
>> +
>> +	vm = vm_sev_create_with_one_vcpu(vm_type, guest_code_sev, &vcpu);
>> +
>> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
>> +				    TEST_GPA, TEST_SLOT, TEST_NPAGES,
>> +				    (vm_type == KVM_X86_SNP_VM) ? KVM_MEM_GUEST_MEMFD : 0);
>> +
>> +	/*
>> +	 * Make sure guest page table is in agreement with what pages will be
>> +	 * initially encrypted by the ASP.
>> +	 */
>> +	if (private)
>> +		vm_mem_set_protected(vm, TEST_SLOT, TEST_GPA, TEST_NPAGES);
>> +
>> +	virt_map(vm, TEST_GVA, TEST_GPA, TEST_NPAGES);
>> +
>> +	/*
>> +	 * Populate the pages to compare data read from the guest
>> +	 * Populate the first half with data and second half as all zeros.
>> +	 */
>> +	for (i = 0; i < TEST_NPAGES; i++) {
>> +		uint64_t *hva = addr_gva2hva(vm, TEST_GVA + i * PAGE_SIZE);
>> +
>> +		if (i < TEST_NPAGES / 2)
>> +			*hva = i + 1;
>> +		else
>> +			*hva = 0;
>> +	}
>> +
>> +	if (vm_type == KVM_X86_SNP_VM)
>> +		pre_fault_memory_snp(vcpu, vm, private, p_type);
>> +	else
>> +		pre_fault_memory_sev(vm_type, vcpu, vm);
>> +
>> +	vcpu_run(vcpu);
>> +
>> +	if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
>> +		TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
>> +			    "Wanted SYSTEM_EVENT, got %s",
>> +			    exit_reason_str(vcpu->run->exit_reason));
>> +		TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
>> +		TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
>> +		TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
>> +		goto out;
>> +	}
>> +
>> +	switch (get_ucall(vcpu, &uc)) {
>> +	case UCALL_DONE:
>> +		break;
>> +	case UCALL_ABORT:
>> +		REPORT_GUEST_ASSERT(uc);
>> +	default:
>> +		TEST_FAIL("Unexpected exit: %s",
>> +			  exit_reason_str(vcpu->run->exit_reason));
>> +	}
>> +
>> +out:
>> +	kvm_vm_free(vm);
>> +}
>> +
>> +static void test_pre_fault_memory(unsigned long vm_type, bool private)
>> +{
>> +	int pt;
>> +
>> +	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
>> +		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
>> +		return;
>> +	}
>> +
>> +	switch (vm_type) {
>> +	case KVM_X86_SEV_VM:
>> +	case KVM_X86_SEV_ES_VM:
>> +		test_pre_fault_memory_sev(vm_type, private, NO_PREFAULT_TYPE);
>> +		break;
>> +	case KVM_X86_SNP_VM:
>> +		for (pt = 0; pt <= PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING; pt++)
>> +			test_pre_fault_memory_sev(vm_type, private, pt);
>> +		break;
>> +	default:
>> +		abort();
>> +	}
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
>> +
>> +	test_pre_fault_memory(KVM_X86_SEV_VM, false);
>> +	test_pre_fault_memory(KVM_X86_SEV_VM, true);
>> +	test_pre_fault_memory(KVM_X86_SEV_ES_VM, false);
>> +	test_pre_fault_memory(KVM_X86_SEV_ES_VM, true);
>> +	test_pre_fault_memory(KVM_X86_SNP_VM, false);
>> +	test_pre_fault_memory(KVM_X86_SNP_VM, true);
>> +
>> +	return 0;
>> +}
> 

