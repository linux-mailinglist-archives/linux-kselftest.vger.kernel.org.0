Return-Path: <linux-kselftest+bounces-26438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8206A31A87
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 01:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A660167576
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B817C2;
	Wed, 12 Feb 2025 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OTiVoSFc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GaW6kkHi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC378B65C;
	Wed, 12 Feb 2025 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320410; cv=fail; b=mgxW0ZmPFCH15Q9R2WsO3x19Hs2M9Vzu6C2oJzMXbtegnVmNcBprv4993gwxPb5p1KxuqI2adUYs6sL/NHeMPSsLbGAeNA1uVGqfp2KcnslskWCfcMWyvP99zSvWnS6CtIWLb1T03Jwd4MkU4uPGwDticMdAecVNbPPE3QMfJaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320410; c=relaxed/simple;
	bh=QYsF5peesXJ662rXGojzessww4p4ClVH5b3eBdXjeo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pkT7Nf//m4tYQH3P5ecNouuI7u8e2Z70YfN1Cct+SyHn+nKUCCuOBV4VccYGhNOnPXHiwiIqhCUe4Tlhnb7qVgbJHSXvc+M3kTgzlTnN07zBrdnvGGJyMTgralUBe2TyworKxNG/ky5HhYs8kIeOJUY2G0HNOkJesJCYMqO5gfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OTiVoSFc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GaW6kkHi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLfevv013160;
	Wed, 12 Feb 2025 00:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QYsF5peesXJ662rXGojzessww4p4ClVH5b3eBdXjeo4=; b=
	OTiVoSFcbknO9Zpbeks1254fnDt7pi5dciefk/xZRAH/+qW/TSAGFXXLmun2JJAa
	dt8gopu8QLhNY2RBQ87Q9Tow86+bnmUSCQztXhBlSWCbgfDBcJqKOqI/0XwhYdkR
	QnMW3UamgyPBMRFnu5wj/9kwBY6MaY4ozw+Epp93ombbKSNcAU6AGM5i+LGYET2P
	czNaDCqDNXzvrxclm5A3eJCKeVC+src/Xf2dHNCsnGOVheTSRiayViLek3izPgMr
	LYAZa0/UtDopGKukRYmrORtNwrnM0O1V49sihDNdefxPD6Xqj8Ko6e+lUFuc3MLU
	4dUrDTiZn2nuxO1B7308xw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn6bw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:33:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51BNps7M012532;
	Wed, 12 Feb 2025 00:33:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq9htr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2rgmGTsNyBUCS1IeZ0nCVHMZlZdGxBZnhm5v1xTCtT9z9f7NslE6dukv9NBI0OqHEuOQ0M2a5c2H8/eDjgvqX+9VDfScRdW5P4JqBW0uPyvNx66oFT4BSoQG7uEKqGwgSrRCYc5fJ6x0T2WZNerLY7Lj4ssP2L6J8FlpZTB0+hxS+8OiPKuKqXfMrvTVfcVQzA3vMKGwOmDUkYEl05BvLxO12tf7A1EYZ6BYRPJIhrl46q1kglSzO+QqZJJfxqgt2GSs5OGZoHBozw2V1BrfotYpwpawObXXbkW1Hg+36mAiWb7OkDHHntfLML1UnnuCwhBa0BWgtqUxRYGxb5M8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYsF5peesXJ662rXGojzessww4p4ClVH5b3eBdXjeo4=;
 b=uM8ztTaSff4f7jDl/jSGOvNX9nSKpI0EdbH3gkHzNfJUpAV+JZmk73OzImC1GNh5KXjvxanNchGqsoIFVG/ZP0B577r0Ftf6+JEdV8Olr7nLQWNHITeSWw4k90dR5i9Pk8imX3bl9WqacIkOPWQ4SKa4S+vqld5J61dzVylSK6Cg2UEOZo0CKcEXf7fRuG+TBN9BaK1rLGL48PZZx7ZH+IX6JB2YDru9SsbJC4qd5RIc+YCqoBDZlz+HBbNIE5Qbgb+T4m0/1QYRgVot9OPkqjwinkBhrT9+KGYQiXN3un1MSEYkKLsyZrBC6M8faCzT98P2fxQRsBAQsqnT0aV0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYsF5peesXJ662rXGojzessww4p4ClVH5b3eBdXjeo4=;
 b=GaW6kkHi0zBTu30+z1eHyRzOMSl6GOER8+cbN1FAq1OuIjackc2nzBLMr01YM2fnp3Lh4FAaG/rK/mMoE1REtGz3BiafM6SiNZbzUnS2sHcivgXz/zNPXKdGNz5PSe6kbLf4g03AQnS5ae+Nj2v76Hnc65kAkVZ6KIx3pakgGKs=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by SA6PR10MB8016.namprd10.prod.outlook.com (2603:10b6:806:442::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 00:33:17 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%4]) with mapi id 15.20.8422.011; Wed, 12 Feb 2025
 00:33:17 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "kevin.brodsky@arm.com"
	<kevin.brodsky@arm.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Thread-Topic: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Thread-Index: AQHbd1CzXVXDkvdxj0SWfa9FkUurILM4oICAgAhIQoCAAMP0AIABMAYA
Date: Wed, 12 Feb 2025 00:33:17 +0000
Message-ID: <1D84255C-D49A-4056-9299-B1E6099154DE@oracle.com>
References: <20250204214723.1991309-1-yifei.l.liu@oracle.com>
 <2025020544-preview-worshiper-8539@gregkh>
 <C8A5840D-B312-40DC-A75D-3BA14614F8C4@oracle.com>
 <2025021143-limes-babble-e137@gregkh>
In-Reply-To: <2025021143-limes-babble-e137@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|SA6PR10MB8016:EE_
x-ms-office365-filtering-correlation-id: ff9e4380-4e89-4cb1-eab5-08dd4afcd810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlhLcU9YM3BOQ29BWXBZRTA4eWdacHphR2JhTWJGeG1WRTltTmdqbm8rV21m?=
 =?utf-8?B?TUVBWWZkalo2VC81U1p6UHpkbTlWNC9UcTRLNkFZSTVwaHNibEFTMnplNXhV?=
 =?utf-8?B?b1FZbi9laGNveHBna1cvUkMwUG1LcUNtU25naXVMekJRQTA1K0pNVnByOG9y?=
 =?utf-8?B?UWFBcUFXcEovZVp4ODRYR3dIdFZkV250MVpnRlZtZkNtR0NtajZ3VmJiU3lT?=
 =?utf-8?B?U3dmWjk2NmhKMnRxQkZhbW1palFxa2R1SG1PdXNtWk9KZXdNYjIvaEk2TkVo?=
 =?utf-8?B?dU5oNWpoMmlGUktWQ3BlTzNvNnQvMEE5M0pGSkVxTzZEM2d3Sk5BdVFOZkVu?=
 =?utf-8?B?Nkswejd5RDNxRHNNZEJIeHArdTlhSnlaQmxtMHYzdjdwbEsxUHhYMERmQmpn?=
 =?utf-8?B?NzREYWpvWkY5ZThYK1h0T1c4MTRpRHk0dHM5bnZkNlplTnNMWndlclQraDFS?=
 =?utf-8?B?Vy9NYXl0bjltMEg3UE9JZFJ3K1k1NU1YU29OWVFIQlVSQTZJMnVxazV1MXpo?=
 =?utf-8?B?VTQ0VCt3dW0rbHdYNEN0ZDZxRzc0bWl3bVgya09sSzJXck16Z0l5cVRnOFVL?=
 =?utf-8?B?WVFxNDI3RDhqM0Rac3RXb1J2dTNpTFJ2YUFlOVpZYWFCNXh1cllrSnlUUVRM?=
 =?utf-8?B?UW5XRGExMTlYU0tkSDdZMThMNFh4VjhPb3F2MzQwY2ZlV2FpZk91Z0thZDJS?=
 =?utf-8?B?U2ZHZ2VRMXdNS2w2YWpXTk04Snd5K2hVR2MxWVpjeXlZZ1BpL01RWURWbXp1?=
 =?utf-8?B?Q083VklGd2p3UHlHZ095c3Y0cXRGZmJBWUsrTnlhR0ZFK1VqNFNCam94NXlC?=
 =?utf-8?B?MHozZklYcTR0V1JrTlRhYkpPSzM2c0hlMVZMZU5sWVRVQVVrbTI4Wng2WHRJ?=
 =?utf-8?B?QUJtcnljRWVhQ0VzTzNkUWF3Nng1b2NaRFYzd0xyQ1JsK2lONy9LQk0zQUlL?=
 =?utf-8?B?RldYaW51WGVYS0drNUQzdjNCdEx2YkwrTzkxcE5vSUVoT2NrbnpBSmI0MHBI?=
 =?utf-8?B?clNvd0xPWlR0NUpiclU4MS9SQUxuaEYyS1FPakJQa0Uxa25ncDFBREJpU1Rp?=
 =?utf-8?B?WksrVHh6S3pLc1hZTTgxWkp1eU1LcVE0b3F0ZlhWZWh1TkN6SUJXNTUxV0du?=
 =?utf-8?B?TkNveGxUbkxTamE0OVdiblh0YlR6MElkRzBZZjBIOFcyckk2OHlYTzd1d25a?=
 =?utf-8?B?RUU4dnVzcngwWGxXdStsYTNyV1B5Skl6NUo0RDQxQU5wVEFaemdGMC9iMTRy?=
 =?utf-8?B?eVlNZU9NUWRoNGJQM0NoOWJSSUhXK1Z4d3Q4ay9US2hWLzJ2TUV4bk5OR1d2?=
 =?utf-8?B?bHVFd1E3YWpGcFdONW9YZmRabVkrbndPY0JhT3NSQ0c2OGxIenpRckNGU2xE?=
 =?utf-8?B?S1pKNG9GcGNNZmZ4bjJyYUM3R1VkNzkyOGg4dG52MDR5dWtLR2cxTXJ1aE9W?=
 =?utf-8?B?K0l3ekd6cFdpOGprTFRsQ0RwNXdqTFlHWmREVmx5cDlDS2RlTWRYYUpoeTNH?=
 =?utf-8?B?RzE1WHJzR3l2TkFkaE0wQWc2S2hmanE2ZCtOV3FsWW55ZElMU0Z4WXFpVlhP?=
 =?utf-8?B?WDZBejFqQmdiS2o1MjdNcGZmWS9vNUZOMVF6aFJtdkdKSGdiR0FtYy9sNS9F?=
 =?utf-8?B?dVRROVRBN0FkYmlRRDRzVEdBY0c5WENoakltVFUwOGMzdTBVcmlUUUxVOENr?=
 =?utf-8?B?d2VJaTdpY2cyMmYwb2xjR28vRHdOV0RhMXZicll1aFR5RUZ0UllQSXRiM2hG?=
 =?utf-8?B?Tm11Z0RxdnJzK1gyclcveWFRY2wzZHRpelBGTU4rbm9Pa2tQTHozaExTSkMz?=
 =?utf-8?B?OVA4bjNraU96b0Y4WmwwVXhzamdlcTBPcjNhd1dqeW1EY0tFOTJQSk9PNCtx?=
 =?utf-8?Q?PWFJYdcjwtmmY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mk5Rb1pqSDdrK0Qrbi9RWjJNb2x6TER3TTFPMGVxdTBkeWpyVnFmZHNBU3Q3?=
 =?utf-8?B?NEk3ZFhSL0UzSzhiZWJ2Y2tYM2VtaHBaM3F3TzgzWlNvMmxIcUZ2akxSbUh2?=
 =?utf-8?B?TkJIbHJNd3lrSC9LT3V5amJZTFpuSnVTenh1ZDJ2TmdRR3R6OFpHRUw3ZmNm?=
 =?utf-8?B?WDZnVSs4aTh2L1BQWWlUZ29lSDRtNjcwcUJjR0NiZG5qeDJ5RHppN2tQSHh1?=
 =?utf-8?B?cHY4QTg2L3ZadGUvVjUxRDJUUnhaMjU2TWhpc3V2OTQvZGpndld1SFo5eFdk?=
 =?utf-8?B?eC9ENFRFVG4xajQvZHdqWDVuVXg1ZitBZlFVTWRlUDY4RzdRcGpoUnlkWWh5?=
 =?utf-8?B?a0NGNEFMaFJuZDdSOTV1aUYzVEo3K2hERERmK25ZT0VhaFprcjdSNDNNbjNx?=
 =?utf-8?B?M1dWVUtKanB2azMwS2llT3IrQ2NKVzNwMUpjRFZHOGg0eDlqQTRKM3duSUwx?=
 =?utf-8?B?eWNwVW1SRHVjVCtkSW9kVitMV2NpMGNzRjFLS0RabEJjRnU1clIyN2JqYjFW?=
 =?utf-8?B?THNjR2lWOHlBUDFzSjBPSFFwTEZFeHNtaCtnRjRDTW1ZWXZVdmoyT2pERUVB?=
 =?utf-8?B?bnZHZks5SHVVdE04Qms0S0pHZTFLaXc4dlVGM2s5TzlKSG9QeUt2VHNaTzZH?=
 =?utf-8?B?N1lRZFJsOWxsemNwVi91aW04N05OUU8yb0M3RHdHOHVzYXlPZHRVZTlpakJB?=
 =?utf-8?B?M0kvR2tBQXpENHJvN1VrQzlrMi9kS0hmME9aREZnQ2U0TEdmMS9sSmx1dXdV?=
 =?utf-8?B?TGFWY3dLdGZ1a1VrUWJhYnVhaThGckJ5V2Zla3Q0TlpRTUxWNndoNjZzT0Mw?=
 =?utf-8?B?Y05LMEZRVzBFQVNkNnByZ2NWMDhyeWx5cXpuaW9qTC8xV1hxcU9UbFVOVFhr?=
 =?utf-8?B?aTVlSCs3bXhzM2w1KzQvaEQxZDJhMUtlTkJ2bEJkWmRqWlp2elJ6cHZvUDVl?=
 =?utf-8?B?U2tTSkZKaWdNL2hQTVYreVg3MlBwd2tPMTE3MmVrQlViTXROVTJ6dHhMK3pE?=
 =?utf-8?B?K0JwWnZuZnpZL0x3M05vbTdTQ1dVZFFNcXU4RnZjMzdITEhJU3ZITHY4eUpN?=
 =?utf-8?B?azVYVWJuREN5ZUN3Z2hnOTl2M1RJWlNqcE81dmZLYmpya3hhdEhJRUhRNWlP?=
 =?utf-8?B?L0wxTlU5d2g5VVpDS2FLbW5BTDVNdGROZVhzNENjUUNaa1pGMWE1bnJOOWVv?=
 =?utf-8?B?WDZDQ3BWT29LRERlcHY3Nk9NUlJaNmlVUHBxL2lKSnVCK0hTQWZBMU1XMWxD?=
 =?utf-8?B?MkZtbVRKeHR5dGZXaUlLc0NDU2pid0pvSHZBTVZXZU9wUzczdFYxLzNVSVUx?=
 =?utf-8?B?aE1ZeHRvK3lIRzRtdEhNVFFodTIyTFJEb1FYYkc4WXduTkdLTHg4dmxNNmQ4?=
 =?utf-8?B?VWs3bElVaGdXV2Z1bk1QbzRHSjEvYU54aldMTFM3OXJ4SkhqQ2NjNWVnb0dq?=
 =?utf-8?B?NEtaUzN5N2duV3RxdGN2NUs0RkpMRzdrMzZZenJ0YmpsMm9pU25XK0VnWjBm?=
 =?utf-8?B?b0I1Q2pQRzR0dWdBVFI1R1V5UUp2d1FlbDBBTTBlTk4ydzNEMDNjYjducHR2?=
 =?utf-8?B?MFpQUk9ZVkJYYU5sNFEwQXBXZkhDVU1tQkhtZjU0UFB0TUlMMHZlN2NZSUNn?=
 =?utf-8?B?Ui8xZ1JzN3Yxczc0WFdCNFY3eTFzOEhjMHBrL1JZQnllM0dWM1JlTHFmWGln?=
 =?utf-8?B?Um4zQ3ltL3VUamhVM3cwd2JJV3B3Y05LK0xiNlNZR2s2d01jbDBBeElROGs2?=
 =?utf-8?B?NFdUNDlSWnZFdzQwbjBBRndPZlBsZzBYMWw1VGM4dkhNSm5rdmFHN0RTeDRo?=
 =?utf-8?B?R1YwTm9JamwyNGFuMGI3S0tRdGk4aGNWbVZPSktjc0Jvc2RVVGxLamkvV3J3?=
 =?utf-8?B?MU81c1I3UVVTbXgzQ0oxQnpWZCs5TllvQUJhYkRnd3lqR2VTVE5Sdm40dlAz?=
 =?utf-8?B?emU4Sk5PT2V4WTl1Z3Z3dGNCempxQ0pRdnhoUy9ZV2hMRUthY1JtUHlYUnJi?=
 =?utf-8?B?Ny95TUN3VTBCcy9ySlo4bFhGaHJQTXpYaTg0YjRsZy83OGVhN3Q0NVlSaFYy?=
 =?utf-8?B?bEdnSmpVem1qcHdSK3hCQlRNNXlyTGhrM2NkejBEWkIxdEwzY1FSQUZtOURt?=
 =?utf-8?B?c2FyOFJSTW4wQ1c0UnM5QzlNalovT2tlbzRTTThDMDN0Y0RzWWtTcmcvZXZY?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F095DA69424504881D0B3B5DD7B5C5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WCUmB2ThvlulxEkOun7omyfQU4vHsq+sWHZw4CDOXZdesOyoAGxN2C0fvrbiW6y1Rq6s0IIbfroS8pUDa1JX3siunoPHoo22iI4nDhWTF5p7iY1mndqTCysPtRUNeabfXxBPYEe5bsPD5k7q0uz0gPahZMKKfKMAoeXkhkttKs/bfx4KSECLsGch/o+/FnSS2x87h20QSa6Jxi5J+dnQn7hZL6WF02Jl/6b9/nirKMlanks8o9X2HxUPTTBe0I3dmA3OCSAvYq2VY+kMJmXjIr94unUjZYxtvCfu2Dn5dkQkM9+7FJr0ZkDtv0sOE8GB8VOlF+MBMQtgKYPrzO6RQwwE0qC/+OV6ck/8Hc+1rE5s8AKcQu2ynldYUC2nEJJ6YnIWIj7zpstC1gVJMcOo4LmalO6a2vXeIhjl1dj74U/Rl/QtUqhP7gZ8lzlc3RmbVv8AOgmiR8skzbG+fLnQqk2iNkiBMvibQzNAs86TUQ/yJA+FjN0S9SczWwHqh3YzXK2Jc4q0ixxYLu6RMf00QIBp8GEGeHoaKjX336wpRF1BvTgMejLcnpTSFA8czX+iqz/4oA8DAQqIA3hOYBaAt4nxpIbnkm9EdufLtyfZbEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9e4380-4e89-4cb1-eab5-08dd4afcd810
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 00:33:17.3599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqRORnGfxVgAi5SMR03SbXWpF+Glm3bV+BYF+afa2zwip3YPQSrAfZCHVgWxz31JDJ66fBxt/YropUAWNJm6jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120003
X-Proofpoint-GUID: RKjUcYJJPhSTA_V4mbgJRAEUgGoOSV5J
X-Proofpoint-ORIG-GUID: RKjUcYJJPhSTA_V4mbgJRAEUgGoOSV5J

DQoNCj4gT24gRmViIDEwLCAyMDI1LCBhdCAxMDoyNOKAr1BNLCBHcmVnIEtIIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBBOiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cDovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Ub3BfcG9zdF9fOyEhQUNXVjVOOU0y
UlY5OWhRIUk2TzBFY0JZTXVuNXp5N3BLMzlaRzlhSllyYnYzVXk3SWFKWWwtZktPWEpmbUltQmJ6
ZlhERmZPV2VZWTJvMUp1dEhQQm9Bb0lfYjd4SlF5alE1bm5mZ3YkIA0KPiBROiBXZXJlIGRvIEkg
ZmluZCBpbmZvIGFib3V0IHRoaXMgdGhpbmcgY2FsbGVkIHRvcC1wb3N0aW5nPw0KPiBBOiBCZWNh
dXNlIGl0IG1lc3NlcyB1cCB0aGUgb3JkZXIgaW4gd2hpY2ggcGVvcGxlIG5vcm1hbGx5IHJlYWQg
dGV4dC4NCj4gUTogV2h5IGlzIHRvcC1wb3N0aW5nIHN1Y2ggYSBiYWQgdGhpbmc/DQo+IEE6IFRv
cC1wb3N0aW5nLg0KPiBROiBXaGF0IGlzIHRoZSBtb3N0IGFubm95aW5nIHRoaW5nIGluIGUtbWFp
bD8NCj4gDQo+IEE6IE5vLg0KPiBROiBTaG91bGQgSSBpbmNsdWRlIHF1b3RhdGlvbnMgYWZ0ZXIg
bXkgcmVwbHk/DQo+IA0KSGkgR3JlZywNClNvcnJ5IGZvciB0aGUgdG9wLXBvc3RpbmcuIEkgd2ls
bCBub3QgZG8gdGhhdCBhbnkgbW9yZS4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwOi8vZGFyaW5nZmlyZWJhbGwubmV0LzIwMDcvMDcvb25fdG9wX187ISFBQ1dWNU45TTJSVjk5
aFEhSTZPMEVjQllNdW41enk3cEszOVpHOWFKWXJidjNVeTdJYUpZbC1mS09YSmZtSW1CYnpmWERG
Zk9XZVlZMm8xSnV0SFBCb0FvSV9iN3hKUXlqYW5TTk9oeiQgDQo+IA0KPiBPbiBNb24sIEZlYiAx
MCwgMjAyNSBhdCAwNjo0Mzo0OVBNICswMDAwLCBZaWZlaSBMaXUgd3JvdGU6DQo+PiBIaSBHcmVn
LCANCj4+IFllcywgbG9va3Mgd2Ugb25seSBuZWVkIHRoaXMgZm9yIGxpbnV4LTYuMTIueS4gTWF5
YmUgd2UgY291bGQgdXNlIHRoZSB2MSB2ZXJzaW9uIHdoaWNoIGRvZXMgbm90IGluY2x1ZGUgdGhl
IGxpbnV4LTYuMTMueSB0YWcuIE9yIEkgY2FuIHNlbmQgYSB2MyB3aXRoIHRoZSBsaW51eC02LjEy
Lnkgb25seS4NCj4gDQo+IEFzIHlvdSBrbm93LCB3ZSBjYW4ndCB0YWtlIHBhdGNoZXMgZm9yIG9u
bHkgb2xkZXIga2VybmVscyBhbmQgbm90IG5ld2VyDQo+IG9uZXMuICBQbGVhc2Ugc3VibWl0IHRo
ZW0gZm9yIGFsbCByZWxldmFudCBicmFuY2hlcywgQU5EIHRlc3QgeW91cg0KPiBwYXRjaGVzIGJl
Zm9yZSB5b3Ugc3VibWl0IHRoZW0gc28gdGhhdCB0aGV5IGRvbid0IGZhaWwgb24gb3VyIHNpZGUs
IGFzDQo+IHRoYXQganVzdCB3YXN0ZXMgb3VyIGVuZXJneSA6KA0KRm9yIHRoaXMgcGF0Y2gsIEkg
YmVsaWV2ZSBpdCBmYWlsZWQgdG8gYXBwbHkgdG8gbGludXgtNi4xMyBkdWUgdG8gYW5vdGhlciBz
YW1lIHBhdGNoIGFwcGxpZWQgYmVmb3JlIGl0LiBDb21taXQgZDllYjVhMWU3NmY1ICgic2VsZnRl
c3RzL21tOiBidWlsZCB3aXRoIC1PMuKAnSkgZ29lcyBpbnRvIGxpbnV4LTYuMTMgd2l0aCB0YWcg
djYuMTMuMiwgbGFzdCB3ZWVr4oCZcyB0YWcuIEkgY2hlY2tlZCB0aGUgcXVldWUtNi4xMiBhbmQg
ZG8gbm90IHNlZSB0aGlzIHBhdGNoIHlldCBmb3IgdjYuMTIuIEkgdGhpbmsgd2Ugc3RpbGwgbmVl
ZCB0aGlzIGZvciB2Ni4xMi4gQWJvdXQgdGhlIHBhdGNoLCBpdCBmaXhlcyBhIGJ1aWxkIGlzc3Vl
IGZvciBzZWxmdGVzdC9tbSwgd2hpY2ggaXMgYmFjcG9ydGVkIHRvIHY2LjEyLiBUaHVzIHRoaXMg
cGF0Y2ggc2hvdWxkIG9ubHkgYmUgYmFja3BvcnRlZCB0byB2Ni4xMi4NCg0KSSB0ZXN0ZWQgaXQg
b24gbXkgZGV2aWNlIGFuZCBpdCB3b3JrcyBmaW5lIGFuZCBzb2x2ZWQgdGhlIGZhaWx1cmUgb2Yg
c2VsZnRlc3QuDQoNClRoYW5rIHlvdQ0KWWlmZWkNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcg
ay1oDQoNCg==

