Return-Path: <linux-kselftest+bounces-16691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9396499A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA96A1C20BE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66D1B1401;
	Thu, 29 Aug 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ppydx9MM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OnjMSvsx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C57194C88;
	Thu, 29 Aug 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944500; cv=fail; b=dAXQd7LlL+gP8nGcNMKIk+rc2mgNwnInG8T1kLWJHT2TVVdSP01KO77y9tOdoVzKzSK0yMh09xiw2U20CfH4+BA5SBChcF5REc0JQslQ3/jOXqvH29KWNjRwqfyvVtJPaTCJsQWwL3rYH8Riq04MjlhJLZs/A0evQNAq2N+C/Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944500; c=relaxed/simple;
	bh=HVm/gE4Qc25GRV1tjJqMzCH/DuqBfmHzVXYoZElLzEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uNRUbHgb+ReN47IoJcuMxlkKafZ4gB9e+dVts7PTzizPPTExHrMCzEKYcvoIfjV3SN8fYcKi825xHiES8t6wIdl39uHEwIqBFdOnSMVnT03QehZwHCIZ5tarYadJVZgQOSyzmz1wiReJ0F3odP7Se7N5Y0/w+PbdneZQkaz/VFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ppydx9MM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OnjMSvsx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDjfAI001974;
	Thu, 29 Aug 2024 15:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=zm5lrWi4YGM6SUI8X9gu0XNIrwm75rDNZ+zIn2XFPl8=; b=
	Ppydx9MMmR7y2N5HLHZ4ni/Dc6i46KyJzI9Fo7wdeWc8lZ8545Aruuv2ee3fRZF/
	QWaKxGQ3dznhS1hKaQz20QsUMrLRUTT9/Vfu/R+zl5Sc2wwqiDaZpOLZhBVq2cog
	wukNrqo6LRb/iPipAxjHrZKIBIY76XuWKEZ9lH0DYV/osPd97G2NphWjBpwKRV6L
	gsX9LTf3Xy3TzK241LepuckSHhetkjN8OW27bI3uFCQkVGJG7Ls9kJTZV7F+CxSX
	PWdS9xQUEXk4HqLSfCJbANk4MqFNpw0lKn+52DT7NJhiO4ziuD4OXIewz/fKOMSz
	eBMV4tKXVmyI5bagnI7Gyg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv4d9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:14:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEFm7f020342;
	Thu, 29 Aug 2024 15:14:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8qkn13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4x6YcgEwcIo5G3rrlrV7Kuk0IFOj4nkShMZ3daE6LfXNM7Z+mj/EGhGiWBOmeJApQgJ1/CLhbW2ml5cbWguu4c+Ui6IgJpoC3xI8oefPXoiW31/no+iTnpvDbKodDqDTgmp2ZDJNBQ2kOx7GsNOcxDE3FcQPfKjR9Ss4+oS6U0gbWGeyzW3YwjN2rW+daq1Q8/sUNU01k2TVYu04+jMghWHskt3XFsUAn7HRk7bXlihNDiR6X1FyxynxEiZdbzfHcEFpptCGswTh8N2fvSjMIuCNRU4qFFkvAWDt2nDSLIQASXVQ/7aMpiVXaqaUnGtr9DEhqohMdxoLNYl9M2LoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm5lrWi4YGM6SUI8X9gu0XNIrwm75rDNZ+zIn2XFPl8=;
 b=KlL4jK4Pbr7/2pFDaKAFxZly1VaUJorXQULnOdSKR+KU3cjeEHNl9Am1b/yq2kITKb2U423NOIsPp1Ney0sv4R4GVLAEYRTYe9//oLWK/vMEk3yteKSX9UKODmZGoLketgWsPgo/vXCCUMCVpzNpbAaF/qrVl1aJHCV6QWYYfg4eSgPlrQYm9bmI3B5aZGw38Tr4FqjmiON4zUpf5lVTmO17G8CHLbaV10lWlfFBuYPnvym443KpPF+Zm3Zw4rKw2zJGKTiIR/kpwebKluficNNtNriPU4diTKtjwVed19KOzm9PN4A6g8NxeTw/QG2lgySIpQrAoNTnxt2YjlJ4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm5lrWi4YGM6SUI8X9gu0XNIrwm75rDNZ+zIn2XFPl8=;
 b=OnjMSvsxdPPL05GurUzdOQ/RK/pE7INYJmCRc+QXjUC8uSceYRXVWGf7S9EOrgd7RcfKVH4l4MuRYEOXpa56Nuwx8e/kVj1XF9RldieL5Xwy7O++ee6zNWCiW/qLx6htJEccZkMtw6Lwr3BQIKDxxU8OG33SL1HVZ150D8PF4CU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB4993.namprd10.prod.outlook.com (2603:10b6:208:334::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 15:14:45 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:14:45 +0000
Date: Thu, 29 Aug 2024 16:14:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        pedro.falcato@gmail.com, rientjes@google.com, keescook@chromium.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
Message-ID: <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local>
References: <20240828225522.684774-1-jeffxu@chromium.org>
 <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c6a603-7561-4616-51d3-08dcc83d5084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1pqT3BESFljczhYVUpwUzYybHdTajNuTlZ4NmRNeHFpbXJ1K3ptVEJKM1hC?=
 =?utf-8?B?Y1BlVjZmVU1obWdUVEdTTG9RdFJrRlN0bWMwRHp4RGNkb3loK2sybXZIc2Fk?=
 =?utf-8?B?dThiREdZd0dBdHJqVnJOeDZSRDFRbXpxK01KRnl5TUs2TE9MUklqeDFyaE5h?=
 =?utf-8?B?bkg2VHVIaHU1WFRDTkVKNVlXY1BlT0xVOWl4TkdNY0xmdklVeVBjZ1FOTG5x?=
 =?utf-8?B?QlkzUFFSQjNZS1N1UnlpR3kvcEVLWWRoNHVnOGdOaVJuaUpQTCt1eWtLNzZp?=
 =?utf-8?B?V3R5MExWaWgxd3IwYTlNK282YVlRRG5XOXhieWJCYjRucWsxaEYzUWYwcnV3?=
 =?utf-8?B?VG16K29aVzYwNW41UFRVZHFBVXAyMnlMMEgreW4yL3Y3aUNFS1ZTUGJTTU5v?=
 =?utf-8?B?VW9aUzN6RUNQR0NxVmZGajg3TnUxWmRmTWJFVDR6NEpWSGdlN0pWeGJBTm5j?=
 =?utf-8?B?b3JJaUMwWm8xVUNjcmMyaXdlSm1mRFZENUQrYXZVS0tZWDQ5Um94SDlKZE55?=
 =?utf-8?B?Uy9SZ1I1RFRJb0FZM0FmbXFyNlN5SEJMM3FYbzJxUmxoVTlTWjdjQjY5WHpP?=
 =?utf-8?B?UDMvZWtOcGpEei9CUUkvM0pCaDhYNGc3WGtOTmY0cXQ4RldudVNpdTg5Z25U?=
 =?utf-8?B?elhRd1BwRVB3OGdwM0pYc3BnUnlxN2RXU3JBZFR3OXpoTy84MUhBUTFVTWRl?=
 =?utf-8?B?WXFNRHZXM0R6YlIwZGxEVER2U05QSWRqTXVMcHpCWjBNVm9UNVlzd1dQUTE4?=
 =?utf-8?B?a3NwR0pmRzNOK2VTVnZkRlZDZ2xwaExMZDF2OHdDNllwemJHNkVBQXJicnlF?=
 =?utf-8?B?ZGtkakdJSE9jTTAwT1BEbzhMQlZxOFZKTkxQemhiS3ZJV21LWEdQTDllSU1w?=
 =?utf-8?B?UkVlME9MUmt0M0EyVEpUNm9RRitqU0pTOEtGMTRsQXVEM3BHam9za2xONTlX?=
 =?utf-8?B?dS9TVm96ZDFMQkQzYnk0c1JoZEtYNk5KSkhEQ2w5cFcrTzMxVGd5TnRzTml0?=
 =?utf-8?B?cUM4elVRNEZKQ2xYWkFYVVJueW1vRDc2L3hiQ0ZoQ2hqbmFnVnpXbThwdkda?=
 =?utf-8?B?KzVESno0U01YeVhPN3NJTzRFMndkVHVWU2RVZytaZ3QvbkVnb2JSM1VvOGRN?=
 =?utf-8?B?Yjh1UXpKTExEMlpBSkF0cTJCN0pFa3E3bGVqUWU0UkpDMFdRWnp4ZzEwZERt?=
 =?utf-8?B?RlhWd2p3TWxnMFUvd0xXc3VRUkEzaklNRjVLbzBDS3ZqMHpnYUZlam5aVUVn?=
 =?utf-8?B?bW9oY3FPSUN4ZUIxcnVTbm42V1pCdU50cENBY1FaNkNsc1I3Z24wcE1QUE52?=
 =?utf-8?B?dFhvR1FjblNYSnZYU3pWQkpKbm9SNTl2S2N4U2hWcXhUVnlubGRJQ1U2NkRx?=
 =?utf-8?B?eEM1S2hHK1FnbHE2anRBZnZGU2ZzOTVJTHZKc01QVWZqeThDTDcvaDd2YWd4?=
 =?utf-8?B?TmhFMkk4SjZXdzFtL1FmZlRtRDJYN0kwUjNqTFd5TlNhZ3FFVXl1d08rWVlB?=
 =?utf-8?B?S3I5S09US2dwMUVIN3dIZS93SlgvVkdNVHhTV0RyQ21NQ2o5YWR4enhMZita?=
 =?utf-8?B?VWl6K3A4bHdoQjlHdXVUOCtLVVB6WTVLdi9pVUp2Zm16ekd3Y2NNLzA3OEVi?=
 =?utf-8?B?NlpPc3NRTXhmZ2c1aXMrQ3dreVBuSmVSSy9UVHA3dmtHeVhaZnF4dTJBZEZG?=
 =?utf-8?B?RGJ6ZGZKWllHNlRKd0FaVysyU3M2YjRRTlVXemRvcmhCZDBvUHZISXVrN2RL?=
 =?utf-8?B?dTlzbGJCM1VtNlptR0JnbHloR3VyTmJiSGFvenc1K1YvVEtjeG9MNGZKaW44?=
 =?utf-8?B?VG5mK25pSk9wUEJJeHlEZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWtMeFEyN01nNENqc09PN1M3SlE1bTA4TWdPU2o4Tk1HMkpGSmxTRU5xczJo?=
 =?utf-8?B?YTFkeVNJc2ZGZkdySnRadlZMa283bWJsdkJWa2l4aDFYUEMyTExRcTVNUkUz?=
 =?utf-8?B?N1Y0cEpWQmoxQThubEhDaCtaODZpbnFobnlTWnNnVUd3bG5tRGZHTGd1dlJ1?=
 =?utf-8?B?K1RwcUFTVnNLU3JsUjhXdjRscVlEeFY4MmpwWHE2cVUyMnBJdCtZeFR0SGth?=
 =?utf-8?B?UHExYVpJRDlMNlZrT2VXMktJTkxqdDBXaUdkTVdZRXJXSUU0TlZKdFozeDJN?=
 =?utf-8?B?am1lZ0lGU2RXVDlnL1J4K09tQSt3d3ZqMGxFd1Z5SU1nRmVCR1FnTmpnRUhG?=
 =?utf-8?B?SXZIM3ZRY2ZqYzJZeHZYazJkNjluQlpWNjNsaWNmSjZyMW5ia0I2NVp0aHU0?=
 =?utf-8?B?aGVRbEcxNkhvZmZQNVJqOWZkdTFaVEx3cWd5TXN6OEt6enJQQ3NHVEhtMUhQ?=
 =?utf-8?B?QzduWFZ4SXY3ZFhlS3lqWWV2ZEpnWHJrWU5SRVREeGdmcitYWmlBU28rOEkv?=
 =?utf-8?B?aUFmODlIdkQrVDFmVHJlYlNNTnlNTWZMc1pYRTRoWlBKZmszcys1MkFtMGF5?=
 =?utf-8?B?eVBiRkdZWUljSWszR1FwckNaaDRhRllxb2swWEhwbVdpMFlPdk5yYWFNRmxp?=
 =?utf-8?B?VVZsd2hFcjY2aUdQRWFxRExsQVJYL2d6dmhlb055d1RNOXpPaytINnU4NTBs?=
 =?utf-8?B?d3hmSnM3WkhEUGozRjl1dVVGQ1ZWY3hQaVlUQXZxUUxnelFFTWNSYnQzQlRD?=
 =?utf-8?B?ZS92ZDBycmhoUVFLWDcwZU9wb2RPMi9rcTZ6RndTdzhEcVVvNUQ3WUZHc1F0?=
 =?utf-8?B?Wno0QlF1RUNMbG4vZ0tnSnZ1dkh2cWlQUEo3ZnFWL052WHN6UEdpNWUyQjhj?=
 =?utf-8?B?eW5mWjE2VkZQY0ZudkkybXBqbytRQlFZVlM5Mi9IOTJjdFVVY1BBbEM5aDZi?=
 =?utf-8?B?RVRTdHZGQW5TZzNBd2dhOGNKdlA2ZEtSaHE3b3M4cFh3NEtBZThNV0dtSUdu?=
 =?utf-8?B?aDJxVWNlSFl0aTFoWVpBU0pzTWhGUkdDb240VXl6dTNKWlo2OWFHc2Znc0F3?=
 =?utf-8?B?aHh1RkUwUGsybXZKT2hRbGZNOFZzL3pvK1Zlakd1WThJdFRZamNyOENRK2FC?=
 =?utf-8?B?R090OTNhZ0FpdVRUc28rVXNPeWIyUGZaelFFZFRyZzBCMXdsNEc0SDBENHBJ?=
 =?utf-8?B?amVmN2tQUVVldFJQSHVRUkZBdzlubm1jZDlyWk9JRUIzZUZMSkE2VlV3WVdv?=
 =?utf-8?B?QU9ZZ2NSMUV0R1hGWHp2OVA0QkR6M0lYL1ZDSzFzaUVjSlkvMWxyVEpiaW1L?=
 =?utf-8?B?THZDb0FuTkI5c0R5QW1PanJ2MlFrTmpPeGZxL2hhRDNyKzVFQ3RhbFlKNFMw?=
 =?utf-8?B?NVczUGNwZng5allDS1dtZlF4aU1Bc0FzeE9nUGJudXp1NGpTL2E0MEx0Sk5L?=
 =?utf-8?B?MDhrTXdBNkFIZ3RzQmltb1pGbGFtTVN3Rml3NVFwVGxGSmZoS0Ftakl2L0RG?=
 =?utf-8?B?c011YXcrNkNrSXBBVlVDdWNKUzQyZ0J2aGdoUXNQOGFFeXd4ZHpBR3dCeHJB?=
 =?utf-8?B?VGtxNFpDU2M4ejdCdUlxdTJKczJmTkNWRnZ4anRwQzVoSkYvVXpFYUxaMTBY?=
 =?utf-8?B?VkRISWIxako2NkpEVDVmb2drZFFZTkpnQnkwbndKdjV3K2hBM0ZoNFE5L3Vh?=
 =?utf-8?B?VGNHelRqUmx5cEpYMmFxZ0xDV2NwYmR2bzVWS3JpNjdKRkJLeDMzRUhEdENP?=
 =?utf-8?B?QllMbVRNcVpIeUJ6NGh6UHZqMlBwWXIwVFNMYmpDTzZrSE8rNk5ZaUpneTho?=
 =?utf-8?B?d0puSmI0cGM3NjNuZlJRUG43VXRjSnlDZC91dW41WXpVT2srSnB1eS9TM29C?=
 =?utf-8?B?Q0FYaEV0QUhyMEMwdytFOHphbnVrM0lUNkJUaW9kckJzc0gxYnNUTW96N0NP?=
 =?utf-8?B?OXYzQ04rUFVXRllmSWlrMmY2UFc1eGFxZ0w1NVM3ZGg4Z093TW9VMFhCOG8z?=
 =?utf-8?B?VWhwdU1FSkJXNFZrSmU2aTdBYXFlV2pyTXB0MVF6bUR2SkxWZzhLdGRlRVJK?=
 =?utf-8?B?Ykg1M09CZXhRQW84ZTZFTTlHTzhDSllGNlZoRGdaNE5oZDdkRnluZm9yZnc2?=
 =?utf-8?B?SW0ySjdtK09NbzA3UTZIRnM3aE5NUFpmczl0OHovUEZDdnRxTlRCcFh3REVt?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uWAyPUeQiqIncbNICtAzqk7hudM9heFH0sDZcg9ee0LA17iHloEHFGJz0QPP7lhee1fdZHHqs0VOn8xk2FlcOrQ69akuzGZiosBqCSyFTt/GB17WSL3lmgMVsBJA1RMp3uRjyyplIA6Olt0AElzf6Pu9jg7i8be5xM6YtwUX4NavmtHoJwi/ZO8gk5woLBuI+ov4Um47BnOv0M8olvIH5SsSoSW/2/JpSR2q7q690Bdj69HHjGpvF8yNJeloxgCkrxC5EEyMSZBaq+5SGNxFdjVi4gnluy3QwnB16yMkUGDlNWNhY/4XwVJqOthvWhuMz1OqoKIy5zmiIAnL7/RxjaJG+1ez7Y50nddraQSZODHcQh3D84jemgr4rR9g0kO0i6TrJSsVjWzoAlzslHxnFaayXN8ljYMV800NNftd3fJPLipdqKN07GH1auMATOAQNVBlVOaWGVSzqkWuQmD/DCOiNPgDM+zAsrDXSdZ5AkTBzuO+yowNPBmdXLRRjFQJ238gW184Hd+J4I4n24bpB1zNvS90mmoklvCuTwRQXVj1Zuw9p48NxSVGXSLgB7qHXnR9DNvfh+Jks4bfPZCiVgyHR5kXc5uOmDRRSLVpe1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c6a603-7561-4616-51d3-08dcc83d5084
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:14:45.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEvqiT+WAXBjhldxsAVdhw5FoO+8CQDGFo3V6LcDY7duv7FrJoukAI4P+ycOiulEbOsLN3AieI4NIK3AVGgHL/Lceqa9DyO73X95p05c0LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=913
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408290106
X-Proofpoint-GUID: b1dNsDVsyA9IgepFYj1BqeYZRDzqgF7_
X-Proofpoint-ORIG-GUID: b1dNsDVsyA9IgepFYj1BqeYZRDzqgF7_

On Thu, Aug 29, 2024 at 07:45:56AM GMT, Jeff Xu wrote:
> HI Andrew
>
> On Wed, Aug 28, 2024 at 3:55 PM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add more testcases and increase test coverage, e.g. add
> > get_vma_size to check VMA size and prot bits.

This commit message is ridiculously short for such a massive change, even for
test code.

> >
>
> Could you please pull the self-test part of this patch series to mm-unstable ?
> It will help to prevent regression.

No, please don't.

This needs review.

These tests establish a precedent as to how mseal should behave, this is
something that needs community review, not to just be taken.

There's already been a great deal of confusion/contentious discussion
around mseal() and its implementation.

Pushing in ~800 lines of test code asserting how mseal() should behave
without review isn't helping things.

Also, this is a really unusual way to send a series - why is this a 2/2 in
reply to the 1/2 and no cover letter? Why is this change totally unrelated
to the other patch?

Can you send this as a separate patch, preferably as an RFC so we can
ensure that we all agree on how mseal() should behave?

Sorry to be contentious here, but I think we need to find a more
constructive, collaborative way forward with mseal() and to act with a
little more caution, given the problems that the original series has caused
I'd think this is in the best interests of all.

Thanks for understanding!

>
> The first part ([PATCH v1 1/2] mseal: fix mmap(FIXED) error code) can
> be ignored as Liam proposed to fix it differently.
>
> Thanks
> -Jeff
>
> -Jeff
>
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 826 ++++++++++++++++++++++--
> >  1 file changed, 759 insertions(+), 67 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> > index e7991e5fdcf3..4b3f883aae17 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c

