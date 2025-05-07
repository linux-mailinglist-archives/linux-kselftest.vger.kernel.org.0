Return-Path: <linux-kselftest+bounces-32560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6514BAAD9E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 10:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C137AE140
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54E21D3F0;
	Wed,  7 May 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X26TXAn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5E213E81;
	Wed,  7 May 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605735; cv=fail; b=rMJjU8xKo+qifDHkRhaKKuaG5quDfMMXt/WmFDDnHZ62sBEXBDIu+WQHSeYQCRtB41fNCqGavHjS+IwfcCtfaeFZFkGq/YbID6rI7uQI4iOdn/yX8ewMWl8WFrrxIBBgRhJ6JYBzVFs6kw7S0YinV63zyTDgELL4UZAYCa3CNus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605735; c=relaxed/simple;
	bh=tIVCIfhHRD90oFudmfXljfwZUFzw4OwTvnS/9S1csm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDTpA8sT+oKPD7jPmxKdqPKd672cTfMrHfocY/v5Sgj2vg5IILrnVqvAIc51/YMljhKCG+mL3kdFt71EJgUjc90UmNJfbEUkjVL4390tzJTfqbzRXYR6+Kz6g8H0TjtWIkyO4+XmUGdYrzCRfXs/DOtEAkljsW2dBuQ/Aw6lm2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X26TXAn9; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+1ub/hRk87nSmZLAyVQykVFEtqxzjsVOaIvLxIVJLFB6oFktkUjDQ5nYvIsheQyKy6F3+MpQ3iUpTejBjz/w9DjZ6xoaRF58ruPqgNMbS66cM7TABsF4e45q6nF5NYIlfxOGi9oJiqiTxCI3dZMsmfu0WPuSXSSl7rrzEItXagyNIuva3WE8CEefzvEF6t9nXMp0PlIEoOYI8gC5uDNNqxWvpF6VlrCqyBov2QsGe70PnQRwvceXUfTi0q38r6hpqAxcASnzAdcRLWJcB7XCwBb61kG/O676Ag3wvr8E1fNATVq7T6dBo20d5iUzjroRBHEHqLq00Vay1Sz0hZurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT52PDRFGyxU337gEQSC6xvyX0MJVc1etclOWEp30HM=;
 b=O/frw19pK7ihnhPF2RDztLiPucazCxDHT5/Bw1ydLKiDMVZWZcnsBTFbUeSrQg0Sj2Lq8wsYCKI+FAaUOpPxU7XyNPtWAdYoYjL3+MwtIeJPA3aMJluv0jYF7/Pmzp/McQgxYanRHx1mozdi5EYtEn+m85tAagSxfFND9JBlQ7sY6GPBCkIi2o18xz1jqC68Jd4GFZ3ELa2krE3kh5hSOAYTgL4Uuh2PluEhmLFQ5AvSg1LZPEFY5yYEjh0nzwTx45P4f88M9Wjdxf6Y8xrk167ig9d0bQrZR+epV7EBAs0PY0I63T3PUPecibqvSnUelnQMYNzykzdAhSuvv+d8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT52PDRFGyxU337gEQSC6xvyX0MJVc1etclOWEp30HM=;
 b=X26TXAn9vD/v7GaOFGrg47vE7erdcN6uATDWqQxWim+c8HMtQyiaxxVlTOho2wNZHOwdMODbQ9b1fHn0b/jRg38edplAeNsCgvEdES7uweFC7lAVshVR1VsbmTy+eiXMod0guqhDOd9Q/apEhFBcK6fFCEiQs6jvpNsu8n/N8DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 08:15:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 7 May 2025
 08:15:26 +0000
Message-ID: <01e0e545-f297-466c-a973-e479fcbd934f@amd.com>
Date: Wed, 7 May 2025 10:15:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>, sumit.semwal@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, skhan@linuxfoundation.org,
 alexei.starovoitov@gmail.com, song@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com,
 simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com
References: <20250507001036.2278781-1-tjmercier@google.com>
 <20250507001036.2278781-3-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250507001036.2278781-3-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbcdf73-86e1-4e12-d4f3-08dd8d3f523f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFFXbHZWVXM5dUNnOHlwWHlwaVJuMWdMbDkxOElPc2pGTnN0WitmQXJQYVlL?=
 =?utf-8?B?c1ArNUNGdEN1aUUyY0tUdEF2UkZjd1ZydHZMU2VpV3ZrRHZiKzl2OVZIUDVM?=
 =?utf-8?B?YXpZSW82M1FPK0pVV3lSbUlyVGptOWN2N2tGb0xJejNnRjlYWWQ0cFpPOXVs?=
 =?utf-8?B?elZSQmhKU3o3WEd6WUs4b0RsblMyTlBpcWpTRUJnSEpuZjhhbkphenJOUnYw?=
 =?utf-8?B?YVZUUkJ5bmNEbDYyQjlpanRRQ0YzUDVPalhIZUFRY2lJbGN1L0lZMkdhS0kw?=
 =?utf-8?B?aFdiNUZUTkxmSHV1TnVJWEVkQTZramNRY2ZiYU1XamhHd3dBTnJzd2RLcU9S?=
 =?utf-8?B?a1IxTGdFTHNucllyOGhzYW15a2xJK2YvRkVQR2JXRUh4SnQyTGhmcGZKdy80?=
 =?utf-8?B?T0t0R2dIdVkvU1pOczQrVHJVUjJKaTUzUUpnalhKQ09xZGpyZUplcEtydjBM?=
 =?utf-8?B?akVtZ28vK3VCbGlEZEhzRVFWWU5sbFhHdGcxU1A2SFFIS1kzU0phb3o1MWx1?=
 =?utf-8?B?alF6YWtWWnZSMUdHUmVlZUNPTXRmVjhWNm5VSXhpWVc0WnUzNXFkUURDS3pL?=
 =?utf-8?B?NVlNZFVSYkNhNHJhWUdKS1ZEK21DL21Na05hSEkyMnpMSTlVcXQrWDRPaHBm?=
 =?utf-8?B?ck91UEdibHpZN25aaUtXRldNT0NpUTlPMndUbnJHRVF2UHprUnovdlRmUGNB?=
 =?utf-8?B?K0xZVDRGakhlYVlLb2RhM2Nrb1QzQnFSNC8xUW9uSFQxWGdlRzJRQlEwaHdZ?=
 =?utf-8?B?bUVWaXgxMlZvOUxiYm5KVmpMKzJWRlFJWGIyeE05QTQwRjVDYUNycFZQVmxS?=
 =?utf-8?B?cysvVkVNVnBXSUF1aUdnbXNXSG1aRzl0aFJ3UXVhQk5QbmxieGxMZUxBTmVY?=
 =?utf-8?B?cWNVbkJLcm0xSk9KR2l3bDFET2tuSEkwOHNzeTVCR3Q4d2pPS0ZoTFlWTVlK?=
 =?utf-8?B?aTk0N1h4UC8vNHh3aDNyV253MXBRWkNpMlQraGdHZG9KdmVsZm5rTFM0UUIy?=
 =?utf-8?B?SXRPcnc0SER6Q3hHWmwyeGVSY21lTUZ1QnhRaDZpb1BYRFV0Q0orME9BRFZM?=
 =?utf-8?B?TXM4dFcxRDNGM3pXeHlFOHdNNjdKc3YwdzFJcEN0d1NGRnhSNzdVUmJ2dHdu?=
 =?utf-8?B?dWNESWlUUG9oQlVDbHB4bEVBSGhtbUVKOWcraEJjaEsrTkxxcVplWnpwcGJW?=
 =?utf-8?B?eE0rVzBVV3hLVHZzc2xEWDA4T2FnaHRheS9IbEV6OVlmVXZQVkJYcVJIVDFw?=
 =?utf-8?B?QitIT3JOaHI4RE40bEYrV1l2Z1lkajB3ZC9oZU5KOHplOVNJT3crNUVjbHpT?=
 =?utf-8?B?MzZHNzdWR3ZVTDBvMGRPckR3MndBTS9ZZHlZMW50VjlmRlhGUTlBMGkzaFdG?=
 =?utf-8?B?aEZ0RDB4N1ZDb2dHK0xGblVJNWRoc0t5eUEza1NNMzgvaUxUZ3NSUE5mdzZK?=
 =?utf-8?B?bW1FR1dvS3pGWXVPajZleUJIalI1ck4yT3FTcFJRaHphcTZGdVJxUHVPWHB3?=
 =?utf-8?B?QVplZS9KL3B3VzMvNDMrV1dscUZWSWNtNjBCaVYrdEdXQnNndHN6OWw1VHZH?=
 =?utf-8?B?TmRSN1lvOFR6VExKMEh6TjcyVlhVQXMzQlhZdUZmZ2w2NkxDZ3FERDV4cThV?=
 =?utf-8?B?cTk4TXVsU0JodllZZkZ5WGtTMStZdExNbXhIazk2OFhMSER3QkIwZzZ1YVZP?=
 =?utf-8?B?bjVjWm4wUzVmY2tIU2FlODZuSU5JeDdUT1U1eDltQlZtRHNoWDVmb3V3aGt5?=
 =?utf-8?B?MU1mb3lZOXJ3SlJXcFptUTJ4ZGFUNWIwMUIrSkc3b0ZjQ3RCekFucjBrak5l?=
 =?utf-8?B?bUc5dkUrRmxEYUVGeUtXQS90SUtoSmpUY2FBYXVKZjFWdXF0MnRoanorem1W?=
 =?utf-8?B?b1VicEYvN2FWaUZrRUxhdm1WR3NqYUF2bzgwTzNBRUxLWXVqZ29pdG9YVTgv?=
 =?utf-8?Q?IqOZyMDRzA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJKckZ2TGNXdXRwd0lFdnFsWDhsVmVreFN6UERVbENwSEtvem9YS0U4TXpN?=
 =?utf-8?B?NUlZZkZXYVphcnVwZlZ5cWVJQ1ZCY2NGbm1mRjZpSlg0d3UxY04wRTd6TExX?=
 =?utf-8?B?c05BNFM5VzNjN09lSnErNjBkQTN3bDNNMXNoa3B0VHVyT2xJb2JxNkRUamc4?=
 =?utf-8?B?RmlaSjlSaXdOM2RHSHRObGdMa0Q0VFJBeWV4TmN0Ym1lS2NaSHA2ZDhvMGJ5?=
 =?utf-8?B?VE5aNFJVWjdIUVppTWxCQnJjMkUycFBIKzVEUEJlSVo2THN4WTNsejcrdURu?=
 =?utf-8?B?SkJiT1BLOTFRUkczaXBZSVArYkxzakFkbjIxWDAwMjRxZ0pEN0lERlJiNzdL?=
 =?utf-8?B?M0JtWVA0SFZuNWFYaU9hbWJzemRWdDNRcHdYUDE5ck0yUGFwSElwN3NiR0E0?=
 =?utf-8?B?b1ozbVdiUklPMnVRVnhTTHYycDVJY3REZFlhUHcrS3phOXlIb2luNi9LSmZV?=
 =?utf-8?B?a2E3K1FEWkpnWFJPSm5uc0dVMUlkVEVDMWZtQ1JROWJLNFlMNUU5dlBBeWQx?=
 =?utf-8?B?UDFhSVZSbUlFNGU3WDcwZlp0YW1uTEhxSEpoclVwWTlNRFAwMjl4eDE5U1dF?=
 =?utf-8?B?MjVjL0VJUGtSSFNBNWZ5bEZkQUw0MnlIV2dlejZTMzNPK1R1czUvN3dzZXN3?=
 =?utf-8?B?ZzlOSk5ZRVZXamZJVFJESUJjQVFqa2dxVjhSSWw1QmpOZnE2OVI4cmc4Q2JB?=
 =?utf-8?B?bi9kRG1QempBSW9oOG1tS0xWWVNCV1JtaXVXaEdxT3NXT3V4N0Z2eEJXU0tl?=
 =?utf-8?B?b3FEV1VBUWlma1JyOHhMOEgzZ0QrOXNtNmNXbzYwbDFrQTVVQU5SNXJoSVdU?=
 =?utf-8?B?N3NrRlZiZkRaV0ZRNWI3SHB1T0FHaDhNNkRtSVpTMk5hNEpBNFllblBFNC9S?=
 =?utf-8?B?Z09zb1FnVkpPV2pmcFpjWFBTYjFscFUvV0NUMnZNUVJKMnd5R2NpekI5QVJW?=
 =?utf-8?B?b2ZVL1VxY3Y3d2hiQ3pMK2xLbkdVTFVnUjJiZGJoU1VDckhUdU1BQXQwV1pY?=
 =?utf-8?B?by9CTzNUcWFyMThjSTI0R1dqb1l0MzRKeXNjN2Q5MHhwbStybGc3amM5dWRy?=
 =?utf-8?B?ckNxL05ySTROTEhMVHFKK1R3cFk4Tkp4dDVBTUExQ05wOVVQcytLQy82SGRG?=
 =?utf-8?B?N0lHalZrN0lNdWxTZDRDUk5JOXpVK282SGFIUFloTXpkcTBaZ2Q5a0Y5VjVH?=
 =?utf-8?B?U1QySitTbitDNDJOaFkxdFBHL0kvZWRvTXI4enRzTXIzNTJFclR1c2JYeGtI?=
 =?utf-8?B?OFYwS09oMlUyUVczQUt5bTdHUEhZOXRPeHBwNDRzTmMwcmtoVzZKSlQzeGhO?=
 =?utf-8?B?ZW1rSU1kdnp4dzF0MlNlNnpNdWhsRzA3VWR4TWF3UVFWbVJPK3VCWG1IWFpI?=
 =?utf-8?B?ZVl5NzBwd3pFTkR5dnd5Q25kV0N3UFpZUTdPOXk1aUpZRFA3UFFPM0Z6cGZx?=
 =?utf-8?B?MWNSSlYrQmV0ZmYzOFRreVpodzc2UXZyYUFpa3MvbG5pQm02OFpVSWhORnVG?=
 =?utf-8?B?L3hjL0NZcmYzMUNUMFdTTm51QmxUVHl6cURVWkQ2Vzd1ZzNEdjVSb0tadHNE?=
 =?utf-8?B?cVB5OURSK2VQY2ZiM0VUSjkwWHl0ODloMHQrbnlhdlRTRURCeEpNTFFoQVFj?=
 =?utf-8?B?M1ZTMEpWQXlXbUhjb2syQitLOTErUEMvemxpY1VuenhtRS9PR0RYdDVCWGRy?=
 =?utf-8?B?K0RKTlV5YmFrNGZMY0REYVVCK1UxRU9tZndHa21CclJ3REhNZkFkaTRLaEc5?=
 =?utf-8?B?eGcyTDZYdUVZL0dPWjdDTUdtNmxhWWhUQTVVNzVZazBNZWE3cFVpTFZ4ZmE0?=
 =?utf-8?B?Y2wvREJyREJqYjVTRkJqeWRxOUJIRjJaVWdVNnoxTEU0NU43dG9LNFNSSGVJ?=
 =?utf-8?B?N0pNcGZZVTZqZzJVcDd0N3orT2dUSVhNR0k2SlhYOTA4WS9xQ3ZlYjN2S1lF?=
 =?utf-8?B?Skk4dXpXL2M3dkxCdHI1UUdMZlM0dDVRSmJ4OGlROVBKaWs0R0xIYkx3U0pG?=
 =?utf-8?B?aS9jL1dVM1J1Qm1oNWtsMzAzWVZtRC9RSFZuV09sakpQWko4MkZGeUJSU3p0?=
 =?utf-8?B?QStRU09jdmI1aXpGeVp3U0VqRy9tZ3ViOVlHRDJ0RjRTV082RktwRTY1Nmxx?=
 =?utf-8?Q?UDNY36fgA/qZlhTuNKzvPuWrc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbcdf73-86e1-4e12-d4f3-08dd8d3f523f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 08:15:26.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYetHo7SawAU/UyX2dR4xUWkz7ELM9euNNSbyI+1FUT8GNXj8EFq0w8GtYK5JqfP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

On 5/7/25 02:10, T.J. Mercier wrote:
> The dmabuf iterator traverses the list of all DMA buffers.
> 
> DMA buffers are refcounted through their associated struct file. A
> reference is taken on each buffer as the list is iterated to ensure each
> buffer persists for the duration of the bpf program execution without
> holding the list mutex.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  drivers/dma-buf/dma-buf.c |  64 ++++++++++++++++++++++++
>  include/linux/dma-buf.h   |   3 ++
>  kernel/bpf/Makefile       |   3 ++
>  kernel/bpf/dmabuf_iter.c  | 102 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+)
>  create mode 100644 kernel/bpf/dmabuf_iter.c
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8d151784e302..9fee2788924e 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -19,7 +19,9 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/export.h>
>  #include <linux/debugfs.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/seq_file.h>
>  #include <linux/sync_file.h>
>  #include <linux/poll.h>
> @@ -55,6 +57,68 @@ static void __dma_buf_list_del(struct dma_buf *dmabuf)
>  	mutex_unlock(&dmabuf_list_mutex);
>  }
>  
> +/**
> + * get_first_dmabuf - begin iteration through global list of DMA-bufs

As far as I can see that looks really good.

The only thing I'm questioning a little bit is that the name get_first_dmabuf() just doesn't sound so well to me.

I'm a fan of keeping the object you work with first in the naming and it should somehow express that this iters over the global list of all buffers. Maybe something like dmabuf_get_first_globally or dmabuf_get_first_instance.

Feel free to add my rb if any of those suggestions are used, but I'm completely open other ideas as well.

Regards,
Christian.


> + *
> + * Returns the first buffer in the global list of DMA-bufs that's not in the
> + * process of being destroyed. Increments that buffer's reference count to
> + * prevent buffer destruction. Callers must release the reference, either by
> + * continuing iteration with get_next_dmabuf(), or with dma_buf_put().
> + *
> + * Returns NULL If no active buffers are present.
> + */
> +struct dma_buf *get_first_dmabuf(void)
> +{
> +	struct dma_buf *ret = NULL, *dmabuf;
> +
> +	/*
> +	 * The list mutex does not protect a dmabuf's refcount, so it can be
> +	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
> +	 * caller may not already own a reference to the buffer.
> +	 */
> +	mutex_lock(&dmabuf_list_mutex);
> +	list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
> +		if (file_ref_get(&dmabuf->file->f_ref)) {
> +			ret = dmabuf;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&dmabuf_list_mutex);
> +	return ret;
> +}
> +
> +/**
> + * get_next_dmabuf - continue iteration through global list of DMA-bufs
> + * @dmabuf:	[in]	pointer to dma_buf
> + *
> + * Decrements the reference count on the provided buffer. Returns the next
> + * buffer from the remainder of the global list of DMA-bufs with its reference
> + * count incremented. Callers must release the reference, either by continuing
> + * iteration with get_next_dmabuf(), or with dma_buf_put().
> + *
> + * Returns NULL If no additional active buffers are present.
> + */
> +struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
> +{
> +	struct dma_buf *ret = NULL;
> +
> +	/*
> +	 * The list mutex does not protect a dmabuf's refcount, so it can be
> +	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
> +	 * caller may not already own a reference to the buffer.
> +	 */
> +	mutex_lock(&dmabuf_list_mutex);
> +	dma_buf_put(dmabuf);
> +	list_for_each_entry_continue(dmabuf, &dmabuf_list, list_node) {
> +		if (file_ref_get(&dmabuf->file->f_ref)) {
> +			ret = dmabuf;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&dmabuf_list_mutex);
> +	return ret;
> +}
> +
>  static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
>  	struct dma_buf *dmabuf;
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 8ff4add71f88..1820f6db6e58 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -568,6 +568,9 @@ static inline void get_dma_buf(struct dma_buf *dmabuf)
>  	get_file(dmabuf->file);
>  }
>  
> +struct dma_buf *get_first_dmabuf(void);
> +struct dma_buf *get_next_dmabuf(struct dma_buf *dmbuf);
> +
>  /**
>   * dma_buf_is_dynamic - check if a DMA-buf uses dynamic mappings.
>   * @dmabuf: the DMA-buf to check
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 70502f038b92..3a335c50e6e3 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
>  obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
> +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> +obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
> +endif
>  
>  CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> new file mode 100644
> index 000000000000..80bca8239c6d
> --- /dev/null
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Google LLC */
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/dma-buf.h>
> +#include <linux/kernel.h>
> +#include <linux/seq_file.h>
> +
> +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf *dmabuf)
> +
> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	if (*pos)
> +		return NULL;
> +
> +	return get_first_dmabuf();
> +}
> +
> +static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct dma_buf *dmabuf = v;
> +
> +	++*pos;
> +
> +	return get_next_dmabuf(dmabuf);
> +}
> +
> +struct bpf_iter__dmabuf {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct dma_buf *, dmabuf);
> +};
> +
> +static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_stop)
> +{
> +	struct bpf_iter_meta meta = {
> +		.seq = seq,
> +	};
> +	struct bpf_iter__dmabuf ctx = {
> +		.meta = &meta,
> +		.dmabuf = v,
> +	};
> +	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
> +
> +	if (prog)
> +		return bpf_iter_run_prog(prog, &ctx);
> +
> +	return 0;
> +}
> +
> +static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
> +{
> +	return __dmabuf_seq_show(seq, v, false);
> +}
> +
> +static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +	struct dma_buf *dmabuf = v;
> +
> +	if (dmabuf)
> +		dma_buf_put(dmabuf);
> +}
> +
> +static const struct seq_operations dmabuf_iter_seq_ops = {
> +	.start	= dmabuf_iter_seq_start,
> +	.next	= dmabuf_iter_seq_next,
> +	.stop	= dmabuf_iter_seq_stop,
> +	.show	= dmabuf_iter_seq_show,
> +};
> +
> +static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info *aux,
> +					struct seq_file *seq)
> +{
> +	seq_puts(seq, "dmabuf iter\n");
> +}
> +
> +static const struct bpf_iter_seq_info dmabuf_iter_seq_info = {
> +	.seq_ops		= &dmabuf_iter_seq_ops,
> +	.init_seq_private	= NULL,
> +	.fini_seq_private	= NULL,
> +	.seq_priv_size		= 0,
> +};
> +
> +static struct bpf_iter_reg bpf_dmabuf_reg_info = {
> +	.target			= "dmabuf",
> +	.feature                = BPF_ITER_RESCHED,
> +	.show_fdinfo		= bpf_iter_dmabuf_show_fdinfo,
> +	.ctx_arg_info_size	= 1,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__dmabuf, dmabuf),
> +		  PTR_TO_BTF_ID_OR_NULL },
> +	},
> +	.seq_info		= &dmabuf_iter_seq_info,
> +};
> +
> +static int __init dmabuf_iter_init(void)
> +{
> +	bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id = bpf_dmabuf_btf_id[0];
> +	return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
> +}
> +
> +late_initcall(dmabuf_iter_init);


