Return-Path: <linux-kselftest+bounces-16481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C2961CC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657162852ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 03:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346BB83CDA;
	Wed, 28 Aug 2024 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DVez4l5G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51F647;
	Wed, 28 Aug 2024 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814722; cv=fail; b=Z1SRuYT7PHaSN6tZrIWe5W+gbqeT22xYN+QKZjUneSU/iuLQLZ2ddlTjlhFjY86Y+SgpIvNJxq+Veri4vtZq2oph8PW4bnbYuNYsHz5rqDbHRaqVhRiupt1IK5ryLuuNlNVd+vqnBe0h852yp3KGm2+54oC9p+LFFHcaFA+uTvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814722; c=relaxed/simple;
	bh=5Qi6GYauwzhT0OOnE/lHe8A1ibUg9o02D6SjeEPecFM=;
	h=Date:From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version; b=muXtr7LTy9voV9FTHm9Weiy48oCi3xmKo3nmQUoVylbEdgsGDw2k2DD4g7ZVjMKjIY3LTr8Nm+dHxlKI79WjQMC1TrbzPgdZN9RDk+QzxRDfSOdANerCRixeuamXp1A1zBTTKnCUkexxnJ6GzIH4/R4KpQ5d9WfJaXoCayEl970=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DVez4l5G; arc=fail smtp.client-ip=40.107.215.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfnPLDHJN56BJ25hCFU9SnQLUmeHH3oZO6bizbvOoKIA+qw4XLCvKtx2gCeTgWa4uvFpQkIGWRd9taXRmNDi/tvd3S8fOv5dJ6osrwU1HTaBs/24Jf67ZjCkTDydYx50ln7cCjNKKmyChIOQUNwIwb091C9gyvyyz0t7sC58zGjpabnfbU3GZ1WHptryz3JaD1MTQXdXsHzkrQPZPFNkHozoygXHEAJ5nvaCu9UIkT0q+EXQSugvlIq16gPvkXKsJIK8efwuhqUYYqmxGQAx3HdbE57ur+k4Xj2plG2FWl3S0Lb1+TNPxZaVYXFWx3cbf7+ET8QqlzwnzJYf655ICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qi6GYauwzhT0OOnE/lHe8A1ibUg9o02D6SjeEPecFM=;
 b=gLFKyjZsIwqJuamcwPkDHF/HjWVYB/E06xtdztJG4B8bgXbsQwig15zYSSpqcSu9T962b+mKh9wILpRfY+L7Y32yUknrYI3SWqSvCgKVP2mywOLte4KGTPWhrVUWCEpplR/LdKrvxhem9zwbyG5MqXAknWUfh/Q3g5nI8I8XIHeGhbqLMEFdEY5JMC1CmpJgU2phF7V/iRV0ytsSUhgDhqeKESIDjhvC5El4TK8UmbTc5X+PP0IYdTr2qoX0fDCaxEAkzivCO0Gokvy2L1D1YOjbMwqw1wLGOzsxDFXIqTM7hyOHk4wNMx8tMWDaPLAVdprrXWsJT+W8Q671Ffaozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qi6GYauwzhT0OOnE/lHe8A1ibUg9o02D6SjeEPecFM=;
 b=DVez4l5GQi4aojVdwkHt6XqwwtGBGFWs0yPKKK2DuSHAygdgvzBOPqf1gjJQgvb5K6tTRflWGjrFqSwobhjrRvgfol+MrixFdzBHCOwfcTF+rQ5bjlvx/5/LfWEGX9bAtP+7mx4sfedj+VsYeiqKpZeRtETuzqqeJiIUQ6ke/QfUNckbLOGg/e34bBR9uix64hdf/P/qjzpjPRxkg6Ydml79SkOp8s8GbMx5oZKy+/iCmftYw44B4asZWqq1Amzva9HMSKThkTGO+TqJDLLspbdT0Yp3Bed00dBYztIL4RacJDC7/08ObA5t5Bj+ncFOhtfbESll1R7LLObaoMBx+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by TYZPR06MB5932.apcprd06.prod.outlook.com (2603:1096:400:341::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 03:11:52 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 03:11:52 +0000
Date: Wed, 28 Aug 2024 11:11:47 +0800
From: "yikai.lin@vivo.com" <yikai.lin@vivo.com>
To: "Pu Lehui" <pulehui@huawei.com>
Cc: ast <ast@kernel.org>, 
	daniel <daniel@iogearbox.net>, 
	andrii <andrii@kernel.org>, 
	martin.lau <martin.lau@linux.dev>, 
	eddyz87 <eddyz87@gmail.com>, 
	song <song@kernel.org>, 
	yonghong.song <yonghong.song@linux.dev>, 
	john.fastabend <john.fastabend@gmail.com>, 
	kpsingh <kpsingh@kernel.org>, 
	sdf <sdf@fomichev.me>, 
	haoluo <haoluo@google.com>, 
	jolsa <jolsa@kernel.org>, 
	mykolal <mykolal@fb.com>, 
	shuah <shuah@kernel.org>, 
	terrelln <terrelln@fb.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	opensource.kernel <opensource.kernel@vivo.com>
Subject: Re: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Update "vmtest.sh" for cross-compile arm64 on x86_64 host.
References: <20240827133959.1269178-1-yikai.lin@vivo.com>, 
	<20240827133959.1269178-2-yikai.lin@vivo.com>, 
	<f1dd704e-dfbd-496b-9466-83efe38c5287@huawei.com>
X-GUID: 734F4552-5ADF-42B4-ABE6-96129E751A63
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.259[cn]
Message-ID: <2024082811104609509515@vivo.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To SEYPR06MB5913.apcprd06.prod.outlook.com
 (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|TYZPR06MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 14243114-9051-4e0b-1b72-08dcc70f293c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1lyM1ovWHd6Z3J2U1lZaU5sRkdBTHVnaTdrekQrTGllRG5BdHNVUFN5bDlj?=
 =?utf-8?B?eHc4SXVDR0VzVWpyZnlsTXN6WGlSNmMydXcyTk9ucWxaNEprNGcwMzZUa2ZP?=
 =?utf-8?B?R1VSTFNjVXNjNlgzWkEwcUpMcFJXM2R2ZmRqR1ZPV1hBUWdIUzhLL1p6dVdr?=
 =?utf-8?B?cFZCcU5HdkZHdzhreWljU1Q1amlWdTAvcjlWa3hKUzU0VDcxVi9sL04xUXBj?=
 =?utf-8?B?UHRFTVVMZ21xMkdYUmgwNm4rRFVuckllZDljRGZRbHZ5OUVlY1dBdnFIWTRR?=
 =?utf-8?B?T3pQWlNwdm1BWUZ6UmlEcUw2K250R2VkcUtBNGNnL3JnTXFhVnlNbDMxdk1j?=
 =?utf-8?B?c1J2aFZseHhWRk1QZW5wY2IvNEVuZEdNQVA5cGxGbURua25PNE1vdmV1OGdD?=
 =?utf-8?B?cVl6M2lIOGw2TGQ5UGhySDBaZ0Nnd3FzT21Qd3IrclpZc1FYTWpVcFdSNVdT?=
 =?utf-8?B?Nm1uQ2NSZ2NJYk1OUTNDZ2hGbE5mb05JYWJGUU1CUCt2b0FpQXArS0xDTklR?=
 =?utf-8?B?RlVlVGRod2xvTWxNbmx3TjYrbHJhakdOeVovRDhZamdjUkdaSzZ4RVEzRDdN?=
 =?utf-8?B?MGJyRmNhSFlrY3NPY2RuanNkMUNaS3dQdUxMN3pqaUlVblc4MjJRek03MnRL?=
 =?utf-8?B?aW9Vc2FHSUlVaGprOS85UGxwMHczeGZZcXhyWWp1czFLZXNRYUlqV2RCaG9U?=
 =?utf-8?B?Y3UyRTdIU3hDb3A0M1poSWxnKzd0T2RLNVZUa3M0VklaN0Nwam5COEVpSHlu?=
 =?utf-8?B?TXZ1N2ZzbndyeXpmVmxFTUxycklpSGk4VDZYTkhXRHM1RE9vajc1YkNDTWRT?=
 =?utf-8?B?M1g4NFVrLzJJWExzNFhkSXo1cnBqSGxpWlY0NkliUXBrRHE0RkF0MUs1MmU3?=
 =?utf-8?B?TVJnMEIxREczditiUUNFUHREeTFLT0loU0wxTStseXBzN2cyUkV5NUthWU1y?=
 =?utf-8?B?cCt5SFFQd0tvTkRhamdlWUhVamtnVCtWUFEzeDRLaFRtbWVvT0NmZERRSTdr?=
 =?utf-8?B?cklOMGQrR1lha1ptN1FYZ0ZzaVNUaitPM1ozNEhqOFA0d1licGY2V01aZjB1?=
 =?utf-8?B?QmhqdkVZL3VXR1V2djJQSGJ6YU1ISmdSdzYybEJQY2xQTVV4T3hsVlVuWlA4?=
 =?utf-8?B?anBYKzdYMnhtMUNzZFhQb05CdFpnTkRhazQ2cGMxcXJOQkpTOEpqcDluQTZx?=
 =?utf-8?B?RG5WcWkwS0dqcDFxR3JFRy9uTm91OW1BTUZ0dTJ1bWF0MGIxZzAyR1hNai9U?=
 =?utf-8?B?QkYvR2RicW9wNVR5WXAyTW9ZcEJqUldrVlB2b0NJcW5XL3FlakZFQWJUSkxs?=
 =?utf-8?B?a2EzQzR0aUNoa3FlcmV6ZU5CU3JXb2Z0RlJxU2ZrZ2VaTHhGMS9pOHIvK1py?=
 =?utf-8?B?akY3b3pMaUNPUUdZVjV4YWgzTDRpdWYvZmNNNmhsZGgxaUxicTJXaTBEcitE?=
 =?utf-8?B?azlZb3FaSGI3L2FvdGd6Yk1yUTB1QVZOWkozeUN6QllkMmpGVVFwNHdYNzhj?=
 =?utf-8?B?aEljZ2FXekQ2SS85YlZGM1Y3VjAwUGNPMXdqbnJaUFdWZ1pyNTJPYVVHbEU3?=
 =?utf-8?B?ekJMT2JRWVVpaGFFTksxQW1UK3hkOVhDM2h2UlVkdWlSajlXcDZpVTlBSmdj?=
 =?utf-8?B?MGkwdkdIWHNmMG44NXA0N2tSZW1ZeUtIMC9JdnRJMDNSS1ZCZjIyNDJsbVBX?=
 =?utf-8?B?VG5PUkZCeWhuYW8zdkwwNi9CM2RmbjV1T1ZFRWN6REZRV3hQaS8rR0JWbk9T?=
 =?utf-8?B?bnlrZGpMRHlLZmJvcWlEV3E4T0pWckRLRm1xNW5uOTNFT3ZkdlBkSjNzSlk1?=
 =?utf-8?Q?jVk9dIKp7LTARtpHdjkrK5YRnw82uxPZkFORo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVJtRUZESkU1K0txQWdFUjQ2NE1QVDFkWlFXbGE0TkxtaUhuYnVjSmt6SWhC?=
 =?utf-8?B?MWpHSTFMclh4ZldXY3lFckJYT2RtVTdNWWhzMjg4VWxINkZ3K0VwKzJMUDFo?=
 =?utf-8?B?KzN1QTFBUktrUWFwODRrS0FVWE5GcVVKa2VCZUI2QVRaRmxBSTBwNzVsS0VR?=
 =?utf-8?B?b0JLRG9FMVJRQWVWcnErNktvaGVTRFltOEk4UzRmeUJOanZIWHVFV0hZV05M?=
 =?utf-8?B?SzR6NVBZaEg0NzNHVnlYM1BQYlNJS0lKMFQxaVJyY2l0WXZYK05XY0Jrd2RC?=
 =?utf-8?B?SVVWR1hEb21BbWYwUHF2N2xsUEJ6NVNNMG04L3cyWEFSMFZsSENZVkN1bVFt?=
 =?utf-8?B?bTIzY21RUmdzTmF4L0o4Y2FZS3BBM3ZPcFFjOU5ZWFJlZHQ5N283MEszWWFJ?=
 =?utf-8?B?RW5tS0pESm52ZkprckUrYXdLRXorY29OTmdxWktFZXBlT1JRUWNyZVE4N1Ri?=
 =?utf-8?B?OVZhSFNxM04wZyttRW1xU2hjM212Z0ZmYndzTCsxU3BONllRd3VaR0lhZENk?=
 =?utf-8?B?c29Xc1BrS2F0SzloMk94SlJnRG15eTh0LzFDMVp0WE5tY2VCRW9zWk1uUENh?=
 =?utf-8?B?MnVzSWdscytSeFQ1Q2RGUXRZZ3hmc1Qva2c2aVNiTXFFWUtQdVpZa1FrSTlS?=
 =?utf-8?B?ZlVIY0oxRnhrNE1aM0Fsd2FrNkhtMWJNMUl1bUgvblAxV2paUy9LQXMrUHFQ?=
 =?utf-8?B?eTM3UDZMa3NEUFY3RndJM2JLNjA0eStqZDFmbyt5V0lxNCtSU25ySHgxSWV6?=
 =?utf-8?B?blUyUUhxb29iRStxS3llQjM5b1JJbFdaZFI5QWZncDVvb3IxaGJ3dEdTWCti?=
 =?utf-8?B?MVNaVmlvNTByOWtabjlGaTJtTmFxTDlMN21uYTMwUHZlUUwwNm9XMXBiRE9t?=
 =?utf-8?B?SkpUcVZsQ3VSRmkzYTRTanhNRE0wdm42d3VLQm9RNnljWGlKV3lPM0s1bTJr?=
 =?utf-8?B?TzRkalIvMGdRMUE3eXkwRlNsN1ljU09nVnlDYkRVR3lzMzdrY2hhNVAxVGdG?=
 =?utf-8?B?M1VNUXFzdE9kTDVGQlgrQWFTTGl6bU1HV2lJdzlwS1lacXRmQi92WkwrdEJG?=
 =?utf-8?B?L05jTmVURzNXa0FRcXJIcVVJRTJIYnBjNHBoSTd4ZkEyM3lRVUtObW11M2FB?=
 =?utf-8?B?T1NrcVNTNkFNNzVDRXMybWR1eTkwQjI0eENGRzFLSTZpRWVoZHVHTmhyaEdk?=
 =?utf-8?B?ZEtDZ3ZOczhWNnVCanR2TlRRd3RpaUlVb2pUZ2p5MmNtNUpadnlZTGk1SDds?=
 =?utf-8?B?M3M0aEJRbk1IMGdtc1FwRGI2UUVHaklCRHdNUGtneS9zTWR5dGpmb0hWTzRv?=
 =?utf-8?B?Y1AvVm9lNjVTRWR4Zm9pWGVYMGJ6UEIyMzlObUIxKzd1S09qb1FwcG50R0s4?=
 =?utf-8?B?Wi82Rm0vYzVyZEkydVJxSHBnSExySG1kc3V0ZHh6STVKa20yUmFjYWRKSzVl?=
 =?utf-8?B?VkxpeldvUlZZTVJaU1V6UjBpNnpVT21SN2kwMlRlSDcvZVVuTkpxL2JUTnF6?=
 =?utf-8?B?N21sZU5DSjQ4RS92ZjZNdmI3Y3h5Sy9VU0JzOVJUNUJKNG5YSkRTcTMzRE9P?=
 =?utf-8?B?UXlwMUxJMXlyclFWYUszeVNrVTdiR25OYWhpM1lvUlNFT2lKbDZXbzBMWTZr?=
 =?utf-8?B?VEpCYzlUOHdtMGNqejN2MjBiQW1ob205VTZOVlNGdFlsT2ZndEFSRG9CUjlm?=
 =?utf-8?B?am1TZkRNWUpRMGxHWUFHQU1KZXRmZjlmTFE2cE1hRldXcG4vQ0Zrc0pYbXRM?=
 =?utf-8?B?anV5Q2haRTE5YzlzUzF6M0puMFE1UUQ5SnhHclM4U1hMYlpOcDJBZ09DR2Fp?=
 =?utf-8?B?Snd4ZWhROWVxdzBESGJjZ04xbklvSFIyZTVQdlk3VlpSWlBEZUJSRWpnYTVG?=
 =?utf-8?B?Y3RZbktwaXhxZkVWZkQwVTkxVXZLNytmb3NnNlM2QkptVkVNa0o0RlQ1L29k?=
 =?utf-8?B?bW9yRXc2LzdDTHk0UUpDbWM2MTFyL3FLREpuWGlzckZmcmlOUE16V2JHREs1?=
 =?utf-8?B?ZGhjaVVFOGwwTUIvbDkzcnJVUnJNTHRmVTJXdlZma2pXN0h0UCszeWRPV2xY?=
 =?utf-8?B?SGZJWjd2c2M1aFdMbjdNaU55citJbGRlQUw4SUlyUXZjRWhUazM1Yll1OW5E?=
 =?utf-8?Q?n7BYg2AAGP5vmDZEJ998mVf1W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14243114-9051-4e0b-1b72-08dcc70f293c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:11:52.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Q+BouccggCqFrvOmlyYY2KoDtW5ytO+PjFMF0mqW9R1WOhS8afpwGsq5cRIQbxbWw+uG98wL91iEpQcNTA/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5932

T24gMjAyNC0wOC0yOCBhdCAxMToxMDozOCwgeWlrYWkubGluQHZpdm8uY29tIHJlcGx5OiAKCgoK
Cgo+CgoKCj5PbiAyMDI0LzgvMjcgMjE6MzksIExpbiBZaWthaSB3cm90ZToKCgoKPj4gSWRlbnRp
ZnkgIiRDUk9TU19DT01QSUxFIiB0byBlbmFibGUgdm1fdGVzdCBmb3IgY3Jvc3MtY29tcGlsZSBz
aXR1YXRpb24uCgoKCj4+IEFkZGl0aW9uYWxseSwgdXNlICItY3B1IGNvcnRleC1hNTciIGZsYWcg
dG8gYWNjb21tb2RhdGUgdGhlIG1ham9yaXR5IG9mIFFFTVUgQ1BVIGxpc3RzLAoKCgo+PiBhdm9p
ZGluZyB1c2luZyAiLWNwdSBob3N0LCIgd2hpY2ggY2FuIGNhdXNlIHFlbXVfc3lzdGVtX2FhcmNo
NjQgc3RhcnQgZmFpbHVyZSBvbiB4ODZfNjQgaG9zdC4KCgoKPj4gCgoKCj4+IFNpZ25lZC1vZmYt
Ynk6IExpbiBZaWthaSA8eWlrYWkubGluQHZpdm8uY29tPgoKCgo+PiAtLS0KCgoKPj7CoMKgIHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9SRUFETUUucnN0IHwgMTIgKysrKysrKystCgoKCj4+
wqDCoCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdm10ZXN0LnNowqAgfCAzNyArKysrKysr
KysrKysrKysrKysrKystLS0tLQoKCgo+PsKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQoKCgo+PiAKCgoKPkhpIFlpa2FpLAoKCgo+CgoKCj5Zb3Vy
IHBhdGNoIHJlbWluZHMgbWUgb2YgYSBwcmV2aW91cyBjb21taXQgWzBdLCB3aGljaCB3YXMgYWJs
ZSB0byAKCgoKPnN1cHBvcnQgcnVubmluZyB2bXRlc3QgaW4gY3Jvc3MgcGxhdGZvcm0gZm9yIGFs
bCBhcmNoLgoKCgo+CgoKCj5MaW5rOiAKCgoKPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI0MDMyODEyNDkxNi4yOTMxNzMtMi1wdWxlaHVpQGh1YXdlaWNsb3VkLmNvbS8gCgoKCj5bMF0K
CgoKPgpIaSwgbGVodWksIHRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4KSSBub3RpY2VkIHlvdSBw
YXRjaCBtYWlubHkgdGFyZ2V0ZWQgb24gcmlzY3Y2NCBhbmQgYWxzbyBleHRlbmRlZCBzdXBwb3J0
IHRvIG90aGVyIEFSQ0guCldoaWxlIHRoZXNlIGNoYW5nZXMgYXJlIHRvIGhhdmUgbm90IGJlZW4g
bWVyZ2VkIGludG8gdGhlIG1haW5saW5lIHlldC4KCkJlY3VzZSBjdXJyZW50bHkgSSB3YW50IHRv
IHVzZSBhbmQgZXh0ZW5kIEJQRiBvbiBBbmRyb2lkLgpTbyBteSBmb2N1cyBpcyBwcmltYXJpbHkg
b24gY3Jvc3MtY29tcGlsaW5nIGZvciBhcm02NCBvbiB4ODYuCgoK

