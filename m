Return-Path: <linux-kselftest+bounces-30177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A99A7D275
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 05:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71125188AC5A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438B212FA6;
	Mon,  7 Apr 2025 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ngjZvXaF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2066.outbound.protection.outlook.com [40.107.255.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354A212B0B;
	Mon,  7 Apr 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743996127; cv=fail; b=m1qTrCJ+MJu4SKP3kiKJkw7dCvEI+I4p5HXvUiAZOd9FXsvjxE14r4EYqchKYWG1pEm+cfG3oQrnRi8cMdNqjIrCa/KZ5CtHyScUmTD5xn2HEfzLAz+eE+d1uDo0ZkO8T7suG3QXrir2W+ghYLkF/R7gyV+RSUkOaB/FsXg7MrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743996127; c=relaxed/simple;
	bh=N+wnhn8fAsUgQ/owMQYfmlC8vMUeDuSmlD8HdC6NnvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9ruLTKzR1cF2wQA78sk2sjwvo7/eW6txmOszxfa/SiD7CT52ujc1Za8quSaW1yOEYYvQWAJxAXwJnhnu6TNVY/um+YOgupPw3hE5mm6whQtsZy0JznNpfPYsK6cwrnmvTk8VQotoH/U5qVpGT8JqnzGFvDDJp+nLKjIL99W+u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ngjZvXaF; arc=fail smtp.client-ip=40.107.255.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY1idXN8vE1diFf6LZxaVpitriP1p/kEmn8jyvIz9N28IhbQX4t+vsRljIfNswPO2u9Cei7y+yp1bIFUzpp9Bo7PYB50Gzrc+K9Ti/Hcy6p8barC7UQlZW0lsbCPyopyaneqrZdGQJ+03LH6D2w+ic7u9fzfUDWFupq60zRwnEpuODovPd43JzqA69agGjuGAcpKe/VEh6LKmFnnzOszPDFyUr1U/d07iVP2h9gfq02mmoL11iJZIT4xBdsIDOfGZCQPR4DgyCXO4jXidJ2DLT7aaY1DadueohM/yp+cRBAoEFzE2PgUMViImUUs0/CRB+9WW89kMplDbtclDfU7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV2aWFS85SlmP60+MfkyUFS2J2tB7KZ+Q2v6hTtdiQw=;
 b=f9JWArGG6cJK82ZAVM6TEpNkhpz2ctG86CAKiGc5smzNyl8hAYLXWTJSkHu2mYYmECTDznYkzJ1zWorCC7vJ1zW+TcY3wiuZLAMtZMWV+rPTaSXfGvjoRyEmVzHwAxf1qPlhHqrqY2+0VDgAy9asmE29Pz+QAyfF3phUI6bP2nE1oN2qWyLx9nEl9LDzMzWqA/HRguWWV4NlsGMUv554fjkbEEtB9huxN4X0nbCElkNfTiByVAc/CkLEsSzhic544dMq+j1T3CHC9a7XH5elWH8w8HEP4hscoKEOML/7bbA1MhjJwyuDw8m8snP48NH/tdGPhwLzxOn6GX+5e5Qk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV2aWFS85SlmP60+MfkyUFS2J2tB7KZ+Q2v6hTtdiQw=;
 b=ngjZvXaF1g3bKozT7kcWx0MCyD0MWtliTURpcX8uZf66JG8xnO+jgSGSGiAOcApXgt+XpoPWcePDyFJEeHLJMVzOdrJp8k/KkCbUPC6YTJQiaJr8Vvg22F75msUiB3pYbOk6RJ+OBeWDPdY/1KXJknSBhkehF3qjonHgq6UVaYxMTlsgy1k/IFxGj9lumIFS63eviJ2M1kU1F2FuCP2F2JABygQDvwnbCTORKXpbDO/tP0xcBq0RByJPBNT0oA/0PT+ZymB+ZcAtbyOhc7DHBegfvcdch+84lR1A/ZweSa3JGiFK0X3Eead1l8LJmAtWvABcVm86SuVcgasWgutR7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6017.apcprd06.prod.outlook.com (2603:1096:820:d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 03:21:58 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8583.043; Mon, 7 Apr 2025
 03:21:58 +0000
Message-ID: <6f76a497-248b-4f92-9448-755006c732c8@vivo.com>
Date: Mon, 7 Apr 2025 11:21:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC
 PATCH 0/6] Deep talk about folio vmap
To: Muchun Song <muchun.song@linux.dev>
Cc: bingbu.cao@linux.intel.com, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250327092922.536-1-link@vivo.com>
 <20250404090111.GB11105@lst.de>
 <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
 <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
 <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com>
 <E4D6E02F-BC82-4630-8CB8-CD1A0163ABCF@linux.dev>
From: Huan Yang <link@vivo.com>
In-Reply-To: <E4D6E02F-BC82-4630-8CB8-CD1A0163ABCF@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9e948c-13db-4a86-3a8a-08dd75835a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0NPMU9nd0NxM2NmdW1QU1Z1TnFBWHdPVkhwN3pjeldEU3ZrQlNLRnBiZFVk?=
 =?utf-8?B?Mjl1bkpGOGdoNGRyd29WbXFiZWIvUkpCWTd2Nlc0cmtrUVB3by8xcUdwWllj?=
 =?utf-8?B?N1ZCWGVXSnlBMEpDNlRQV0I5SXZpTDUvRWU4RXVlTlJ3aXdQQTJEWnZHRDRS?=
 =?utf-8?B?dnhoTUwyaldyejh4aE80Tnl1KzFYQjA1MDljM0RiUk00ZjFPMW9XclNzbk9l?=
 =?utf-8?B?ekRzd29MK3dJenA0Um5JOCtOcmJDYXlueWN4M3d3akxaQXJuOEkvcjQrWHB6?=
 =?utf-8?B?NkVudXU4RjVqUU8vQ2pKbWw1WlR1SDl6TDMycU5ISUkzbU5TenY1WFI4anFS?=
 =?utf-8?B?S3lCSk5GU0pBKytCVmJaK2R6cms2S2taK1J3ZDM1ZmFUTU91K3g4RjZNekRj?=
 =?utf-8?B?NnlWUW1hc0prU1dLalJIQjFpZ3BaMGVnNTRxc0RCN2VRUHFxelhMWjdyeE5R?=
 =?utf-8?B?Sm16d2hnZ0dmUDhTY2JXR25pQ1N2cGpSSGY0YmxPc0E4Q1BLRXZ6d3FSVENM?=
 =?utf-8?B?V1I4cEJUYVZ2dkJCZ0dLampWVkNPbHBRLzBYcnpKZjZneXJxSEFOWVZvNUcy?=
 =?utf-8?B?TjZUR0c1UUJoenVWOWtsYlZDelpLeGFsVWxwTWFXcE9tdGw3WmJ5U0VEbnB0?=
 =?utf-8?B?T2hLdms1VHFOZm5GWmFYcEFyZ0pvU1FtUjNGSVA2VmdIQlBEOUhMYjQ2VW5t?=
 =?utf-8?B?STVZTzNoZE40N1pvN2RCcjN0R3piRGtyTnQvWlJvQS82WlR6NnB4WXJBc0gx?=
 =?utf-8?B?S29zWjY3MGRERU9oRTY4TXZ2a1RTMThaT1NaVVR4U1ZXcjg1V3dJdFlHN0ZJ?=
 =?utf-8?B?Tys4N25RbDZlRmc0VTVGcDJLK1Jnam5hSXVFVVliMWVxa2NsWk1GNlJLdXVN?=
 =?utf-8?B?RzBHbDFtajdHMHErNHBqMnliMkdqOWRLUkE1VG90YWIxeEI4SUdRaExzRXd1?=
 =?utf-8?B?R3pRNE5POW55WndOb1dtL244VW14WHlaNERpMVVmcWl6SGQ0TUROK0xlRG03?=
 =?utf-8?B?OElOTWorbFVmT1lVRkVkUjJJVDNQSlhaYTZYSHZtUzcrbnlYeS9DK2NtTFJV?=
 =?utf-8?B?VHNEbnp6Zzk1NmdZdXJqMUxZTVl1T2cxZFRwRGlvb0dqQlR1MTcvSEV1cUd2?=
 =?utf-8?B?ZlZGUXBOZFl4V3dMTTMrRFNMNGVHRkhuWkVmWUU5aGdnSlg1anNnLy9pQklI?=
 =?utf-8?B?UnNBM01DeFM4WTJtNXo2NlBuN1lvdFp0dnBhQUtKeFBQOEdkTGhKYll3ZHgw?=
 =?utf-8?B?b0pIeXNiVzZObzhCVFRRSmF4a0w3eGpOS3cvOTg5UDM3QVNQSE5ESE9TREs2?=
 =?utf-8?B?RUJubTZ5S2NMUm03OGx5ZmJUV0RhdXhtRFlGb240OE9QdWlSSkNlZzZSaEM4?=
 =?utf-8?B?RlVmMWR2d3lPd0htblFycCtheEFYaFpoeEhXM0I3aHJzTXB3ZlJNYk1FQ0ph?=
 =?utf-8?B?MEoyN3FHMFVxRWlYUFliWUtpam9jcUhLM0VMS05yUHg4VTEwck8ycHdLQjhp?=
 =?utf-8?B?cWdxTEMrQXNad3dBMCtxeUVmSnl0Rjd2Q3pSSDZVelJYeE9BZW1zQ2Q0b1Ir?=
 =?utf-8?B?emJGa3JmRFZWc1pJUW9jbGZyY0U3Z2FCMFZBM2lPREdld2FvOTZhMXBFb0Fs?=
 =?utf-8?B?dm8xNE53MzJiczhjbERDQytoTjdSdGo5SVFBaWRsUHBVUy84aEVuVi91djJY?=
 =?utf-8?B?RnVIT2ZWczZibmRTU0JMNFRVVlg2SUxjL3JwbmR0TGY1TkM3Yzd4MlpSNjFI?=
 =?utf-8?B?OFljN1h5RXpaVDdOdVZKOXZFWmVydjRIb3Y4amNPZXhOc1VRSjJDZEl2SXhv?=
 =?utf-8?B?WEo1ZG9MWXhkRFZTUUozNmtjTzFEWno1VXp2ZFZ1aUhnY05GN2RGblY3MDlZ?=
 =?utf-8?B?bytkUDlZbXQxUTFDRm1JbnY0S3VwcmdxWXN4R1lyd1p0b0FOdEhJNllNQ0Nz?=
 =?utf-8?Q?3hHqYqC/w+QW32TUN6jIIPkrAhesMhk8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUU2Sk5HNGxKVG9kL2ZmeXp1UmVxME1zZVZPVmlkR1BxY2o2OFlZNTZTOUM2?=
 =?utf-8?B?TjhoSURTdVNNYUdzU1BIWTRGZUd4S3ZwQTJ0bGQvT1pmMmRRKzFXTitvL29s?=
 =?utf-8?B?cHRwSVE0SWU0STYwYzR4ZEVXYmhPWEdWelpzMFJmNEs2SHliOVFYTEZJWTFt?=
 =?utf-8?B?Um9ZaHcvZlFJeTArUHZxa1RZMGhpWGxEQjZRYXlCTTNMSU1tZTdRVVp1WWtp?=
 =?utf-8?B?Sk9SZ3RJSVB2U0xuWCtzK1BQY1RIdHRVTVlIbThkM3F6dkIycUZhUFMxQStx?=
 =?utf-8?B?am02U2pDNjB6aVJ3RUZobjhFZXprTE5NdU9nUDJFeDR4eStzTGVBOVJDUkNB?=
 =?utf-8?B?RjNNTERyQkZQRFZrSUhsUTh1Z0dLMUhOWmpTdVNnQllOSlNhMTZ3QWRJZm1z?=
 =?utf-8?B?SHV6c1FqTHFFaVRaKzY3QjR6d3pvN29vbjhreTRoanVJM2dZcU5WbkVJTFdF?=
 =?utf-8?B?dklKZVhJZ2VvVld5ZnBnajBtenY5TnFlQjRidk4weFBNeVo4aWFyRzNxYlp3?=
 =?utf-8?B?TDBRQWszMTlvNUE3Uy9Rdms1Ly95UmxFL0p0SFB0Y1k4NFhnNm9SR3Z1U25I?=
 =?utf-8?B?V1owcFk4ODNUVjJPODBOUHdxeW8rUHlUOFc2YzNmRFh3RUdINzdWMERJUlh2?=
 =?utf-8?B?ZDdBWVRNZ01mc3FvUVAyb3UyU2VtRktVMGNtZTNoZlRSRWVveGFxaXNkSjZz?=
 =?utf-8?B?RjE4OVhZQllUV0N5S2ZXeGdJMmhsOUovWk5nK3Y4bnh4eWh5ZWU4YVZSTEU3?=
 =?utf-8?B?VXl5UnNEODNKSXl4L2Nsdkp1OC8wZDJZWDdaVE1GMEVud2gwV3d2TGRUTGU1?=
 =?utf-8?B?bkM4M0IrNDRnQ2czc3d1clgyaFRLVVRDK3VqUE95ai9SRit4bnNjS1NVU09C?=
 =?utf-8?B?V3hLN3RiNHVvdW9IczQ4bk1OQVpjOUszQmIxWFZ1S2hHOGdJZmpuVXZDMGVN?=
 =?utf-8?B?bkE5ZW9MelZWV0gxa0ZEb0ZrbE90OS9iS2RHdTNQSVZFKzNia3pkSGlJdHJI?=
 =?utf-8?B?Y1VLTXgrVUk3MDNVRS9JSXVHUUZZZ1Q1L1o2T21sdzVGKyt2OEtHYjdYZWYr?=
 =?utf-8?B?TWpzMzJIMjNmOEtYa0prQXlKc1ZmRGpwblNBa2lXQ0ZpVGtLUVFhcUhxQkd2?=
 =?utf-8?B?VEJ6a21NZkQ5SnNFbmdqOWp0R1ZDaU9CbVppVUFSQ0MvdSswdWt6SUZndUl2?=
 =?utf-8?B?bzE1QXBPNlB5VWpGSEVkZHFIdFpaREJDL2pwS2QvQ2hxV3NwdTFwa2ZHWWhM?=
 =?utf-8?B?SWgxYWtFVVNLTGdnZFEvTFJUQzBpaFpGdFg4YnhPMk9wL3g0RzBnQ1dLWldX?=
 =?utf-8?B?b3I0cmdlaXhEaEJ3TkNHSmswb28yVlNOOE1jaEdldjVUb3JJdlBObU0rNXF1?=
 =?utf-8?B?MDZtS01POGRBNlFTMFFmNUNzMExaTkFyc1ozQ0NlR0dldXRJYldwemRhUEFv?=
 =?utf-8?B?U3Q4YkdkaE1sb01DQTNuWHVqbmladk12R3pSTWMzTGNsMU9CVDZhclF4WDhm?=
 =?utf-8?B?TXdvdnhOa09tZWJIQUJxNGdBeHVheCtzWnBrZVkzR2tRRWtPcVR2OUQ5cXlV?=
 =?utf-8?B?MzJrREROQ1AwZkYvWm45K0g2MHI0OVJ5SG0rMStiVjlheFFuVHhDaHpjbU53?=
 =?utf-8?B?KzZiSlZiOGYyOUZndW9pVmJoL2tsbTlNSUgwZVg2ZUFGanVyaWdwRTd6SWVt?=
 =?utf-8?B?dytjWFJEbWVqK0Q3bmxZa1lkRDgzRUhPbFpBZ0NGeFZvVzBUVVNOWGRrK1p6?=
 =?utf-8?B?VHl1SkpqKzMxR2RvUmRRNDFDaXNGQnlqS0pVemZEaEFhYmNFQXh0MDZiWDJa?=
 =?utf-8?B?NTFxUWw5M3EvQjFicDZQTzBkYlByNTdzTjc1VVBQSFZka3pzNHdxQUZNSmN3?=
 =?utf-8?B?dEFpcmVEOWRCeVU5TDkwMnd5Y2l0ajZPV1FWSkZHRHFGaEw2bHZuMi9qenkz?=
 =?utf-8?B?R0hSUGlUV1Faa2hpS0FHUmRhRE53NFVPb3Z1QjVaVjh3Z1V1V0FOOVE5OGxu?=
 =?utf-8?B?NVcvYXRQUCs1dnJvakxZYnBEeURPZXJCbUNqL0ZRaCtPRnBlckY2QzU4RjBQ?=
 =?utf-8?B?MWYxZDBtbzdmQVJucFd5WUtyOC9sZnYyM3pJeVlvVzkwOE5WSVVibG1WQnlp?=
 =?utf-8?Q?s/u1NignacClFXMC681qt9uyU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9e948c-13db-4a86-3a8a-08dd75835a8a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:21:57.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcMBy/93j7EZnArHSD0tbvDpZakQhZBvwcJ0eaDFJa6q2/e2M1ViyLOk35X0UnLPZwg199DmsRNF5MIbR93NpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6017


在 2025/4/7 10:57, Muchun Song 写道:
>
>> On Apr 7, 2025, at 09:59, Huan Yang <link@vivo.com> wrote:
>>
>>
>> 在 2025/4/4 18:07, Muchun Song 写道:
>>>> On Apr 4, 2025, at 17:38, Muchun Song <muchun.song@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>>> On Apr 4, 2025, at 17:01, Christoph Hellwig <hch@lst.de> wrote:
>>>>>
>>>>> After the btrfs compressed bio discussion I think the hugetlb changes that
>>>>> skip the tail pages are fundamentally unsafe in the current kernel.
>>>>>
>>>>> That is because the bio_vec representation assumes tail pages do exist, so
>>>>> as soon as you are doing direct I/O that generates a bvec starting beyond
>>>>> the present head page things will blow up.  Other users of bio_vecs might
>>>>> do the same, but the way the block bio_vecs are generated are very suspect
>>>>> to that.  So we'll first need to sort that out and a few other things
>>>>> before we can even think of enabling such a feature.
>>>>>
>>>> I would like to express my gratitude to Christoph for including me in the
>>>> thread. I have carefully read the cover letter in [1], which indicates
>>>> that an issue has arisen due to the improper use of `vmap_pfn()`. I'm
>>>> wondering if we could consider using `vmap()` instead. In the HVO scenario,
>>>> the tail struct pages do **exist**, but they are read-only. I've examined
>>>> the code of `vmap()`, and it appears that it only reads the struct page.
>>>> Therefore, it seems feasible for us to use `vmap()` (I am not a expert in
>>>> udmabuf.). Right?
>>> I believe my stance is correct. I've also reviewed another thread in [2].
>>> Allow me to clarify and correct the viewpoints you presented. You stated:
>>>    "
>>>     So by HVO, it also not backed by pages, only contains folio head, each
>>>     tail pfn's page struct go away.
>>>    "
>>> This statement is entirely inaccurate. The tail pages do not cease to exist;
>>> rather, they are read-only. For your specific use-case, please use `vmap()`
>>> to resolve the issue at hand. If you wish to gain a comprehensive understanding
>> I see the document give a simple graph to point:
>>
>>   +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>>   |           |                                     |     0     | -------------> |     0     |
>>   |           | +-----------+                +-----------+
>>   |           |                                      |     1     | -------------> |     1     |
>>   |           | +-----------+                +-----------+
>>   |           |                                      |     2     | ----------------^ ^ ^ ^ ^ ^
>>   |           | +-----------+                      | | | | |
>>   |           |                                      |     3     | ------------------+ | | | |
>>   |           | +-----------+                        | | | |
>>   |           |                                      |     4     | --------------------+ | | |
>>   |    PMD    | +-----------+                          | | |
>>   |   level   |                                   |     5     | ----------------------+ | |
>>   |  mapping  | +-----------+                             | |
>>   |           |                                     |     6     | ------------------------+ |
>>   |           | +-----------+                              |
>>   |           |                                     |     7     | --------------------------+
>>   |           |                                    +-----------+
>>   |           |
>>   |           |
>>   |           |
>>   +-----------+
>>
>> If I understand correct, each 2-7 tail's page struct is freed, so if I just need map page 2-7, can we use vmap do
>>
>> something correctly?
> The answer is you can. It is essential to distinguish between virtual

Thanks for your reply, but I still can't understand it. For example, I need vmap a hugetlb HVO folio's

2-7 page:

struct page **pages = kvmalloc(sizeof(*pages), 6, GFP_KENREL);

for (i = 2; i < 8; ++i)

     pages[i] = folio_page(folio, i);    //set 2-7 range page into pages,

void *vaddr = vmap(pages, 6, 0, PAGE_KERNEL);

For no HVO pages, this can work. If HVO enabled, do "pages[i] = folio_page(folio, i);" just

got the head page? and how vmap can correctly map each page?

Please correct me. :)

Thanks,

Huan Yang

> address (VA) and physical address (PA). The VAs of tail struct pages
> aren't freed but remapped to the physical page mapped by the VA of the
> head struct page (since contents of those tail physical pages are the
> same). Thus, the freed pages are the physical pages mapped by original
> tail struct pages, not their virtual addresses. Moreover, while it
> is possible to read the virtual addresses of these tail struct pages,
> any write operations are prohibited since it is within the realm of
> acceptability that the kernel is expected to perform write operations
> solely on the head struct page of a compound head and conduct read
> operations only on the tail struct pages. BTW, folio infrastructure
> is also based on this assumption.
>
> Thanks,
> Muchun.
>
>> Or something I still misunderstand, please correct me.
>>
>> Thanks,
>>
>> Huan Yang
>>
>>> of the fundamentals of HVO, I kindly suggest a thorough review of the document
>>> in [3].
>>>
>>> [2] https://lore.kernel.org/lkml/5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com/#t
>>> [3] Documentation/mm/vmemmap_dedup.rst
>>>
>>>> [1] https://lore.kernel.org/linux-mm/20250327092922.536-1-link@vivo.com/T/#m055b34978cf882fd44d2d08d929b50292d8502b4
>>>>
>>>> Thanks,
>>>> Muchun.
>>>>
>

