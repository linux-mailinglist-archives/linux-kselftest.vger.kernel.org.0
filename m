Return-Path: <linux-kselftest+bounces-37744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB7B0C387
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 13:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9211AA2F22
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C32BE7B3;
	Mon, 21 Jul 2025 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jIrSfzKc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFD29B8D2;
	Mon, 21 Jul 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098208; cv=fail; b=FCJLI2uSWJF5TBUKsHSh9T3++Q7b+MX1VIz4j0q4JwgXYFyumalfxtrRaM8XydKrbGynTdRy0+iOg5dfph51V2uz6T82W7X7qA9ychChHoG5ANQ0xoSCUN5hM/q9Ii9e6lPIDmDwa5fw+wLnPTNjytZKIRwGpSkI0oI8x8I825g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098208; c=relaxed/simple;
	bh=RS3ZueeNDnh+ZlNqR1PGC6NLeaP7YF4+7ZH5cNZnvw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwKuusrBp/IchUEV7qol3A1bVjWMvWcT0SeNzB1r1rXOTEKKpG60sQ3X/+GefNsWbSDAR7tcSX8taNDQY1y7h21bRGaAdVd5BZq9MCawVsZ8/5SbXAXfoBpEkUtHF+44aLXvobc7Cyf639TPVmaRslc3NQpOdnkzskTL0FP3xfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jIrSfzKc; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RisA38GCYel4YWbTn78gOKZGgmEfH5dYa5PNqOqlsNrbhVnIBT9ffFZJb3CPlh5B1nsHb/VvDCB4LJ022qa/aJgQXMFb1v9K90j7409CvlOywLgwnSpzUSDvvdFoOPpbNcJMG87HFS7cIXHM1nZFu0AjCkcJpQBXlKIxLy5xHpbnr+ZOzY3ljzZA3LuE/2SCeaixF7maKJPNvueOc/Pdqw3vzlg+2QMZXDrwduV0i+rmpOX2EnB0SBJMA0tWZFLUersmm0xWSXg7vDMaYtoTZRj5ANX2t7UPsgr+HW33U5xn0Sad5ndCV+Anbb0xRBGJhTEjCEurEdbEEojEbMzRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYQd9mERupsxs0DspFIiC37KUe8HOPtoaSA2n4Aa5ZI=;
 b=ysNpGp1EoJbsyWSBzjA1t2+GnbS27rGQdVmxJm4qbW1XUohD1bTqN4Mji0sodObtEDnOnuU/RcMww7+inx4ViD+Sih17jZaSeAJOdeo4wusq9S8BmXRAP2qk8I+WFyR1EMGDsZwP8b/GHk5qi7jJm6GoNXKZ+VgLNQ0NbiDuCAH4mJOvHQaxzjMwkXmGuvVGka2T5MItzgsBpdXKW9aBnQjN2ONTbFTV/IPHqIpDGM5CnnxSj2JXs+twDz7KW9doYs+6PEZF7lb3vcmfdPPzbxpBfR3FdYZ5i1GVU8GdnwcF3yeAbLrPg6ZcqxPxCfyoXHqJCyl2PQmO9PqkQpmpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYQd9mERupsxs0DspFIiC37KUe8HOPtoaSA2n4Aa5ZI=;
 b=jIrSfzKcHgf51xbfhxzUKa7zZJPNSxkqEDZ+D7zNEcmCjHBUTdTB7/zSMnDaLMJfS0wSkKhVbEagPxzaY445tOdxzS1qFezqB5iD0phPwWT6O2LBq3sNjCAR+Y00bu97jvygJ2jYCa8vxAyiJKirFMZf3iHcizt8GtVLGzNpkfBFprDm8J61aDFCMBqXRvIiqrq8w7JBUuZxaCpU8U+AB6kYEDYdhdenXcC8VJjkjHu8jPZ1eho7qbLiKoGs5pqIIn51fCEpBlK3mHP0J6JR5hnkVwaKJ2k88s3CQGYpzv8sgqH3LvgGAtJn6Dq2LPbZQab4VKMNCmxJgQGFk7u/Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 11:43:24 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 11:43:24 +0000
Message-ID: <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
Date: Mon, 21 Jul 2025 14:43:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, tariqt@nvidia.com,
 thoiland@redhat.com
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20250719083059.3209169-3-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To IA1PR12MB6186.namprd12.prod.outlook.com
 (2603:10b6:208:3e6::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: d76da9a8-61a6-4393-b0ba-08ddc84bccb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmt3VmNjby9Td3FmSmNPTWFiZEl4ajgwYTVubGg1ckRzckMrVmJESDUySFRa?=
 =?utf-8?B?Qm1DUDhqeVFGYnNzR0dYNXZ2cnhyeFE3MkhPUkFLTDdBVWN6YnpPL0JUb1hQ?=
 =?utf-8?B?dkE4UTRGNVhJZnkzN0hqMUNWOHRIcGx1RG1XKzJQREtoK1NCbG1YRU9iTzhY?=
 =?utf-8?B?WkpBQW1JY0pIeVd6eWtWNVFIUm8rd3ExT1BLL2phQ0tDQzk2MlN0TVpsa2ov?=
 =?utf-8?B?Q0tLT1lxQkpNL1FrT3dIMmplLzl5M1d0dTJxQmVTL3pNenphSk1neU5yK1Qr?=
 =?utf-8?B?aHNIaHhlTmNIcm5XaHJpWTI1cGliaEFWOGp2RTEweWtRZ3pVeWNtVXpWTnBj?=
 =?utf-8?B?ZUMvRkNwL09KTjVPUUFLb1BLUVpaS3ZIemdRRUJJRTlPS3FoVURQZytxUUZV?=
 =?utf-8?B?a0V4eEw5bEpJSnRDeHFmaHBKMG1TbHkrU1haejl0R0R5ZTJ6YnMxVGxsS3JG?=
 =?utf-8?B?OWlMbjJBVWovcVBza2FiRHBLanpHN0tCaGJ5MC9Zam16aFpJMG1CUjNXOU5B?=
 =?utf-8?B?QncvdDBHWjBvVHd3eDcwQWZBekJoRGdaUEttNGlaR3F2WHdBZVJ0OWJWR25H?=
 =?utf-8?B?UndPL1l6VG1YRHNzdmU5N2IySGVvUXp1ZDF0T1ZIODZNYUNMWUdZMnBvcTRK?=
 =?utf-8?B?MlFlWGRiNkQ0a3RUcGRrQlMrQmNGdXcrMEUvSzU3K1EyZHBRU2t6SEZMOGpD?=
 =?utf-8?B?NktSVEwyREQwUEhhckowMjM1cTk0WG16TFlNU09ObDVMZFNvZjhrek8wcEhH?=
 =?utf-8?B?aWlHZ1lia0FCdHFZcGdrYzhhWFo0RE5UVXI3eTZQU0lUNlhXSGxLdE01UjY0?=
 =?utf-8?B?eDVORzRGRXJvUEdzQ3VGeWVYQ1kzeU53R043b0piT1BRdVFadm9veTNucWpi?=
 =?utf-8?B?TUFUV3FwNXJnOHJMZTZBejFXTmM3NTI1a3NheGgrQzFGRU8xNHRPclRsdGpt?=
 =?utf-8?B?QTgrbzQ1bFdsTEdsSXlJSTV0MlU5Z2E0eExvVzhuOVloaEVFc3hKS2FYdklS?=
 =?utf-8?B?aDhMU2RoTkFzWHhBbWp3WWZVZWplOFRXVzBIbTAvTXJ3VlhwWU5oUm5WUFU5?=
 =?utf-8?B?RXZZdlVPWUNBTTJJcnJMaHVQK2l3SlNzcTFzamdGVEVKMGJBY0xuSHJ3SzlI?=
 =?utf-8?B?UC9oZVZQZ0l6V2FsazBYbHFDWFpVN2Y2S0dWOWtyK0xtWWlieU5PY1RFUDBl?=
 =?utf-8?B?KzJaRTdhNC9tMmdSMko2Q3ZvdXcrUnVhSXRNdzNlT2xhb01vSFF6MlNweGRE?=
 =?utf-8?B?aEJtV2VIU3NsT1Q2b0U3a21ZMXNkeWcvbXR0ZXFTVnRtK0w4Smd5REZtMTJI?=
 =?utf-8?B?ZWNMeDhDVUhoQUc4RDd4Qkc0QWRLUWlwbUIvWFRLV215L1hvVURhSVdhYTNL?=
 =?utf-8?B?ekpsOXpiQUYyb0hSY0w3UUJRemFXM3B4ZHQ5bjViM0I2aVdoWG1OSnJOUzA5?=
 =?utf-8?B?OTFrN3FHdENRYXhVcEFqeXd0NGVDVXMzMitIUTk2bUczQVg3dGtKcjB4cHdx?=
 =?utf-8?B?M2g0aUFtS2gxRXBmUG1JandxL2FsNTYraHFkRDNaNDJrVTZ3OEFIeTYxVW5r?=
 =?utf-8?B?eUpqME1ML1N0TXFEMGpUZW41TUQ0VGx1bmc5a2JZNTI5QmhNR2xsczZnMFd3?=
 =?utf-8?B?TDJuSEpPeFVSTk9kQUFNQkxUMHRRQVNjTmpCRmg1M3AyMkRBN0plNTM1cUpY?=
 =?utf-8?B?Y2tJeDcvaGQ0VmE3MW1zZlVyV1B3a0hYSHFKREtzVkZzU2pyNy9BUER2RXUr?=
 =?utf-8?B?SEJobGRMTzZDQUhKMXdWK2xIQ0JBWnZTRG5Pdks1N3k2eUNOaWhmYlpObXdR?=
 =?utf-8?B?dkEvWXpBTldMejM1TS9BRnhSQVluN1EzZkp4cU5oK2dZd0ppU2FSdnl4UUFp?=
 =?utf-8?B?VFptMkdvZENxbE95ZnBDc3FNNEI1WmtwR1Q1VS9hWHdqL0xjdytzaG9QNUlT?=
 =?utf-8?Q?+Vkm5A0rTxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3gzZzRxcjBPdXdRUkE5UnNlaC9zS21MRzMxQmZyRGNrRHlseEcwdkFuZnkw?=
 =?utf-8?B?Y3RmeWpTRk5mNWdKWTFSMnZhaWl0UjZQNUR6aEkyZEtDeHRCemJSRHF1QkVx?=
 =?utf-8?B?WTRlSTV3aG1WMjlCVWNvZVZiQXBzNTV3YmcwSHBpbGxFajNiSHkxRHU3U1J6?=
 =?utf-8?B?d1RvVUhxcE93UW9Xclo2NXByOURIblN5d0hSSGJWVng0QTk4TDg3Y0lVR3pN?=
 =?utf-8?B?RjVSOSt5Y2ZRbnJLaGNDQ0ttTng2Ujl0Rzh5WlVsZXJadUd3QW5qaW5LTWxX?=
 =?utf-8?B?TEpkdG9URFMrWG1XNWJjTmdZTktMcXBjdkhZcUl4UlVoTU1IdmVoSld6ZVV3?=
 =?utf-8?B?OWUzNC9TUGxLbjA0VWtjdFAvcXEySXpCMGlvRXRjcks0aHJlb1Z0T2RqZ2ky?=
 =?utf-8?B?ZTdzeG1HQmRtQUJaeXlFOWcrNElKOXZyRlpGczdpaHBOYVFrMCs0N2FGU2J2?=
 =?utf-8?B?dC90b3UzTEt5OVBzT0lJQmozVllIeGVuMjE1bmdOaEdMdVBWUzU2M1prMmE0?=
 =?utf-8?B?YUJOQW1JMWNMUml4ZjZFVUc3MG5HOU8wV1hha1pqR011eW8rc0IxYUlxcjA2?=
 =?utf-8?B?TjRGMjF2NEMvUytOWk90R3RlR003bDZnVzMxb3BKUHIzMjNBVXhUUTFmL0N5?=
 =?utf-8?B?K3VOYzM0VC9LQmZuZmJXSXcxVGNLVW93WitFYVZCdThPWGlwUGVsN0Vkay80?=
 =?utf-8?B?ZnFpTFhSZHMwZzRtNEFGZTVhdkpTcWlENmRQdFJJZGFKOXg2Q2dtUU5BdlhG?=
 =?utf-8?B?NmJxblN6UlFDcjN1MEVqZUlmK2ZTVXhTQVZuckV5MjBRRGVwZDh4L0hMMnpt?=
 =?utf-8?B?R245bTgyc2RSVjJmYmhHRFJrcFNQSmMrZDgvZWFVbWNrZ3UzdTQ0bjJUczBV?=
 =?utf-8?B?RnVmWmRPd1pqNldxelB5Tzg3Vm5mM3dZQ3duaHpUMzlYR2p2Qk9aazdzQ0NZ?=
 =?utf-8?B?SU15emREc1puV3p1T1VXM3pLbnRHYWxFN250WXR3Q1U1ODBjc0IyOWEzMUVx?=
 =?utf-8?B?RHFjaml6VlhTTFVDOEY3dnQwZmNPUkx5T2gyVUNJbkJ3cmdVekpVNC9HWnFu?=
 =?utf-8?B?dDMwdG9tdmFjNy9XeW5WR3BJTTlQcWNUcEZBaXU4TXNIa3N0NkpMc3ZiQnF3?=
 =?utf-8?B?eCtVVVg4cGExSExYbTVUeGpkUnFlUkt5ZktFRmNoWWJBaEY4RnpFSCtIbDZo?=
 =?utf-8?B?VTF3VHhJaU9sZFpvZXUwc0FkeUJ4S0NzS09VVFcwWUdEempWd1FLK3cxR1JD?=
 =?utf-8?B?Uk1VUnZtQ0lycjVQMGQ3TUxFYlZFcGR2UGRBczhxdnlwTmtQZEIzYWhXbWlH?=
 =?utf-8?B?TTAvVWNXKzg4OHp0TVlNbHUwSk4wMGJtVTdITDJQVm9Ba1A3YlJpdVE4Qm1W?=
 =?utf-8?B?Ly9BMldQYWFpQlFYZWJsWVFBVEpvUWlpZnppOTAwZGdYQnlOMFhaclFGTkEz?=
 =?utf-8?B?TkRTQTllVE41Q2JGMTZhVWJSYitSOWxMRFdMdXFPWVdiVmQ0N1Rsay9nV3JH?=
 =?utf-8?B?TDRGL1hxNGZGUVFNRG1tZGhvc1JtajM5STNIK1ZMNm9INUNPWmtxSUlYZFl3?=
 =?utf-8?B?djVGZHAxZGtrWXpUQ0Yyc2dpcHNQMndQNkdOdkN2WFpVMFVxbk0vM29SK1Na?=
 =?utf-8?B?blJpUXpxLzRkMHF2SGMxcHpFemdmOGxPbjJUNHFsRHRZQWVLOHhDM1I2WUwr?=
 =?utf-8?B?NWpiRlc0blBJQnJxa0hPeUE3UFhsdjZTNXlPY0NQejd5TGlwOHBUNStaOGJl?=
 =?utf-8?B?NzJYVzRBVXlacnRqMCtXbjFaMjJabG4vRGVoU21WOHhvZ2k4dXcyN2tSbXFI?=
 =?utf-8?B?VWdySjNHWEpES093U0MvZzJiNE8ycXpXaGl0d2ExY25STnNqNFg3eDJzV1o4?=
 =?utf-8?B?V0V3ZklPaEJGd0x3UEVLOS8yeTJXeU9uVFVvYWdXSHZZdFJPRXpQRmtveE8z?=
 =?utf-8?B?ZjUybzRvMWlpYWRrTktaeWM2KytSSTFBS0lUNzFUTy9UNFg2d0lVTDlFaFdD?=
 =?utf-8?B?VTQydFRRNnFhMkQraUtVVjNQWCs0N2dVNzVZVzM5WFMxOU0rZy9YSDFTREV5?=
 =?utf-8?B?UFUzMjZybjljU2ZhV1ZsdmsxQjVLSG1lRCs3aDViOFVpczZscUt3ckh2NzN5?=
 =?utf-8?Q?XoThAA77pZXpgKA8i70u806Ot?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76da9a8-61a6-4393-b0ba-08ddc84bccb7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:43:24.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnjg/0BXNSAOMVuCa0hiuBGC6YNMpUvcOB2K5ZzIQ7DOyTvhbkdVsEbpSCVDOlecu6/AJuWxnIzOsRm8Q1EkOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

On 19/07/2025 11:30, Mohsin Bashir wrote:
> Test XDP_PASS/DROP in single buffer and multi buffer mode when
> XDP native support is available.
> 
> ./drivers/net/xdp.py
> TAP version 13
> 1..4
> ok 1 xdp.test_xdp_native_pass_sb
> ok 2 xdp.test_xdp_native_pass_mb
> ok 3 xdp.test_xdp_native_drop_sb
> ok 4 xdp.test_xdp_native_drop_mb
> \# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/Makefile  |   1 +
>  tools/testing/selftests/drivers/net/xdp.py    | 303 ++++++++++++++++++
>  .../selftests/net/lib/xdp_native.bpf.c        | 158 +++++++++
>  3 files changed, 462 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/xdp.py
>  create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c
> 

...

> +
> +static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
> +{
> +	void *data_end = (void *)(long)ctx->data_end;
> +	void *data = (void *)(long)ctx->data;
> +	struct udphdr *udph = NULL;
> +	struct ethhdr *eth = data;
> +
> +	if (data + sizeof(*eth) > data_end)
> +		return NULL;
> +

This check assumes that the packet headers reside in the linear part of
the xdp_buff. However, this assumption does not hold across all drivers.
For example, in mlx5, the linear part is empty when using multi-buffer
mode with striding rq configuration. This causes all multi-buffer test
cases to fail over mlx5.

To ensure correctness across all drivers, all direct accesses to packet
data should use these safer helper functions instead:
bpf_xdp_load_bytes() and bpf_xdp_store_bytes().

Related discussion and context can be found here:
https://github.com/xdp-project/xdp-tools/pull/409

> +	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
> +		struct iphdr *iph = data + sizeof(*eth);
> +
> +		if (iph + 1 > (struct iphdr *)data_end ||
> +		    iph->protocol != IPPROTO_UDP)
> +			return NULL;
> +
> +		udph = (void *)eth + sizeof(*iph) + sizeof(*eth);
> +	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
> +		struct ipv6hdr *ipv6h = data + sizeof(*eth);
> +
> +		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
> +		    ipv6h->nexthdr != IPPROTO_UDP)
> +			return NULL;
> +
> +		udph = (void *)eth + sizeof(*ipv6h) + sizeof(*eth);
> +	} else {
> +		return NULL;
> +	}
> +
> +	if (udph + 1 > (struct udphdr *)data_end)
> +		return NULL;
> +
> +	if (udph->dest != bpf_htons(port))
> +		return NULL;
> +
> +	record_stats(ctx, STATS_RX);
> +
> +	return udph;
> +}

