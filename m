Return-Path: <linux-kselftest+bounces-10930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB98D4F98
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9361C219DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C394208D7;
	Thu, 30 May 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zi06SjkU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617BB208A7;
	Thu, 30 May 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085259; cv=fail; b=pEta/4owUu1LtHAQxe+pg7JnFqFo7kmlrtm0hHZ4YEkX1j0JTlDCkwlgUMXUsAGEmPPgzCdXyKs26k1v8rQ1F5gP/MaMMhRX7EtFahJnrAUx8aUqL84g2P3l+JgMCSeuZnbtmEaSucD1zemEaI3PuE/63CsHkvHAa3YYW5ERgfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085259; c=relaxed/simple;
	bh=5b1CdolNrcFaaQg6/en0sczm5uBS8fwXRChxqJUuDo8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CLwubgTfQ+nPGGFJW64uM3lZ1j1M5VqYW4ROLLDcic5lexSypw3/4heIV0RuhZFoGOKnkySmSZKYEizWQ/eHd4LiaCSSaD3Yj9KIIiIWn+MgeBvR+WbRxNVwXchxXqOlgiKNWWwGBPR698nBeD4Xh1ZNHg6XMaYnCTY/vSStmLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zi06SjkU; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxuiDjUXhYMgoqW3vfVyu8ZP6VtzSuiLNJt+dW9HJ6E06or1+ovumS5v1lyujlmhDM0Zl0gEbLc1pEn/3u74sHq9ZF/68xvcvtWOFqaJ4i7cztCWxhv/79Pyk9g9gfV7+Aug/3NJFAM3Dd0BzXitEZQLrBYlw7QLlpRM0wJQwp7k5w/Tw5GXxJ/ufXfYUGYqaMMiKqACOD302ndF0KhU87I+eyge6apyT+ZvFZEWCCS5PCkjvkbbo7ce2JDrEOD8WyXNgdOsW4P6tMI/RIQbAAApNaukQhDkPVOakdtM9dXaDaiOSKcU88+X5fjhs8Gu6LWmBi0l9efEXyXBNpqYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPXzCrqKb5LUmVxnQ2y4rEYQKGvFSMXnk11gpp9m+kk=;
 b=INt0GlSR6oMsV98CX4LN+yeIPDT3VVaUmBkEQRuhRDGRzhh1mZA30XRIH+ZJy8YAvtdYqh1Zzdy1ng/cPIjykDNp1g/nSleh3GYaZPlJHhQ7DexJhAW5gIYKZ97+DldkJV1+DZxKOeN/W/y5Xxj7AFzHwSOlQIU82gUO5jUOMjL2lsMNpkWsfC/4DKNdpA9WL0TeKipZ8uw8U2pAdTSVKeLz7wJDBddLPx0jEzYumSRBIgKnQUh0sFEotDdBmGNRf1eDNydxJ1TuYkoIdozuRjwnmTTXaAcT3I/7e5VJFiMMnTbKtwkUKGcuKkki58wOzmW2vq3Jl7NBokHm/RvY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPXzCrqKb5LUmVxnQ2y4rEYQKGvFSMXnk11gpp9m+kk=;
 b=zi06SjkUfVKC2o43qEeKYlA98i+cfZUXi5BEzQEPi7ZTrz95iV66pbIjigfS7AKIwsl65jncTuhdutLQqGXS6vGOsV7DaR5UfbhiXsGmMAAw7CGzXVYQ/p+5OmpH72aYKlu577QTl9yevRtWjkDSRqrGMGfcYxcmJ9Y8wAQMEVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 16:07:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 16:07:28 +0000
Message-ID: <5bb51f17-0eae-4af1-a2ed-5e9893fe6868@amd.com>
Date: Thu, 30 May 2024 11:07:24 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 1/4] selftests/resctrl: Rename variable imcs and
 num_of_imcs() to generic names
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <c81a31bbc9385091a2e6b9da0c935ff46687179e.1714073751.git.babu.moger@amd.com>
 <4545fff1-b95e-46dd-9c79-c6ae8fbb501a@intel.com>
Content-Language: en-US
In-Reply-To: <4545fff1-b95e-46dd-9c79-c6ae8fbb501a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:408:e2::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 467b683d-8533-42a8-e83e-08dc80c29a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUJvZm5VdFNnSEVwNEErYS9lM1hQR1RXTCtHZ1N0ZEdWYURaRElkTjI0YlJx?=
 =?utf-8?B?QzhnWHpoNHFQcmN6bzBOUCt6d1BtbjdSV3dGam1mS3RiSWQ5NUZFSUhac04r?=
 =?utf-8?B?S3ZUQTVraWRKUEZCSzYyMisxdk5OL01kUnBzaVp4eGtZeEhoS29qYnRWZnEz?=
 =?utf-8?B?WUtKenppUlhjeUNOOVliS2NGM04rdUlLNU5xUFprY2FqQW51OHVlUklHa2dT?=
 =?utf-8?B?eVF1TFV2SG84bHNIRHBHZzJWcExPNFpoT1BpRjFSQUhPaTJDczZFWmF6d0NY?=
 =?utf-8?B?ckxQUm9QUnFCT1BubStpM3VQdzRPa1UydytiMTA0dWlDTkpOZ25qRVZYYThB?=
 =?utf-8?B?WmVkSkY2WlQ0b3hWbmhNTTlUM1RTdHhuVHRIWWdjU3VKcy9jYW1ydThzRGRC?=
 =?utf-8?B?NkFjWkR0SkhTNVNYbVdRYmx3bzJWU25ZWGgwUW9GRHdrUmhuc1dyQUxFeGRq?=
 =?utf-8?B?VzFYU2VWcCtTSG5ncXkzOVlmZnNrMkgrVXNONGJUQWlYV0ZlbVBkMU1ObTBE?=
 =?utf-8?B?M2Y5TFRZc2o3ZnE1cG9XdGNFMS9ZOTJTSU5Cc0xrUUloU2xOK2t0dVBrS1My?=
 =?utf-8?B?VWNFbXBWQlVZTklsVFp4T2xaY1ArRmxRUm1NS1UwSGNkZGFiODhiTlJjNUJW?=
 =?utf-8?B?NE42cUUvY3cxeEhjMXZWdjJteEJWdm82VFpKam1zNW5RQWdCUVdQQ2hIVEVL?=
 =?utf-8?B?dEdZdHIzMjBRM3ZRV2kvc1dENTZsQjdiMHpHOEhPZHl0VExPczJEeGdGZmhl?=
 =?utf-8?B?aEV4TFYxajdFUmJkQ3Rkbk1jNnRpOHBseEVOclJkYlhhMDczNmdhZnRaL08w?=
 =?utf-8?B?TzJYNzJoZS8zWkkrOVhzS0ltM3lWYkxrTXA1QkgwMWwyVjEyMm9ERnhIOTl6?=
 =?utf-8?B?WEx2YVc0K0cwQUtmSm91V3hVdzhMLytQQ2ZzSGJnOEZoQzRWS1d4UE1iYUpG?=
 =?utf-8?B?b2lNS25GQ0NZOXdxci9JRUZ3WS9JTVNZTExZTW5CbEJ6ZXU5VDM5UnhhTStZ?=
 =?utf-8?B?VDZSeVFJZkd2U2J1bW1hNktoWVhDWUpJdEQzYitvb2JVaHNEdy9oeTRtbXJr?=
 =?utf-8?B?T2NKY2JpNDdJRksrSmNlSEY4ZldTekp0Wms1OGw1QzNidU9iQ3U1WW1oeVBZ?=
 =?utf-8?B?SW1TSTc3Y1RZNHp3MHpKd055bGNNRHRkYi8yVE0xeWZBTWhpNE1EQ05nbUV2?=
 =?utf-8?B?SVo4TS9DN3d5TTYraDJUSlNuQjAvNTdod3krRGJadVlmRkNTTlJITE1WRVB3?=
 =?utf-8?B?bzNlNFF2alpvR0dOenFtN3FIT1poVTNRWklSM0x0V3VLc2JtMG1WTGo0RDJH?=
 =?utf-8?B?YnBqRDJmc3lUNEt2clJ1REg5TkFmR0Rkb3pDWkhGZ1pNYlhTRlYweVFqRFQ1?=
 =?utf-8?B?ZnlydlpDK3hlWUFWQmRud21wd25pc1NWeDFGd1ZQSXFiVFBXaE5vSmxoSWFt?=
 =?utf-8?B?RzhmTTduejZSeklmSjEvZ2xzZ2V6dFR0Z2FLRXVBc1g1d1p5Wkx4SU1RNTlP?=
 =?utf-8?B?K3lIUk1wK3RIVkthZVYwV3VKbGxVcGloM2h6ZmR1V3FOS3huSDdDdkZkL2VW?=
 =?utf-8?B?czBvcTlUaUZrMnV5eXJrNFhRcVV4MDkyU012bGE1ZjBjRHBjQlh3YnlSRHZi?=
 =?utf-8?B?MDR1ZDk4dDJoNlBqWjFSMG9tVVdNVWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXpKMExjeURDbXlQUThVN1lMU3V0eGNrcHIvUlkxK1dkWEVma2psVTB3cUo5?=
 =?utf-8?B?Y21ueTdBQzRRZ1h0V1B4MGVUS0FobzdSa21ic1JFZW5oWHlBNG9FRDMvZnEv?=
 =?utf-8?B?enpmcVl1WjM0YmtIS3VuSjNMR09KL1VOcC9UVW9RUFZvQjdmY1JSc0pya0xL?=
 =?utf-8?B?OG1LWUtZSzJnRkhrdzMvTnNJU2NGbVVpeTRDRTBiSmQzWTNPQUwyUnhpT3lL?=
 =?utf-8?B?NkZ2VnlJV2pVMm02WFk2U0wxY3dCcUVIUzQzRUE0K2tpVk1Hdm9CYklXLzMv?=
 =?utf-8?B?aTZmWDhNaU1qV1F1TTNiSUZzenJObVNJaW11cjIzOVVLdWY5emYwL2JhZlAy?=
 =?utf-8?B?dHMxcmgrWUQyckFqVGpaOVBqUVQ1OHNLa3FkY0licmpXZ0pyN3N5ZHk0cnNr?=
 =?utf-8?B?Q2R6cThrY1gxZU9kMTNYL3dKdmMyYjJYRkpva0VUdVV3TFdody9haG5Lb081?=
 =?utf-8?B?NzNzK0x5eVd2VG1HZmRQU1Y2OE5HYUZ0TU5BemhMZ0xId1FlNXZGaWxHVmdn?=
 =?utf-8?B?U0VTQVNUYWJTbnFsL2hObitidVJWOGE4NGJsY1hSNnloUThBRldjdC9BRDF0?=
 =?utf-8?B?RVpNMnBIWURvZmdoV2x0c0c0TkpoRXprdkdwbmc0Rk5VOS9VbFNPcFMzbGRt?=
 =?utf-8?B?eWhLZTdra3VLSE5yRTIwUmpsSXh1SHF2ZmZCNE1ZdHNIdERBb0RHU1I5WTZ3?=
 =?utf-8?B?bmZHejAycnZwakpKekltazZpeTlIN1FpM1lOUEFUSEVPVFo0U1I4UndTbHBW?=
 =?utf-8?B?R1U3alUxRWg5VWpJRG55MlBscjMxdGgzZS9CT3dkY2tja3VlaUYwWjFHSkxV?=
 =?utf-8?B?MjIyWWxTQ1FNZHB3Z0RDbC8rbHZoSURGV3lMeVptS3NFT29LbStXeWZMVlhW?=
 =?utf-8?B?VTRlTXlQK0ZSVElDTFV4N3F5N3M1Sk9TN0tjUnFFVFliWjIrQlJMVGZNMTJZ?=
 =?utf-8?B?YTZMcUNFaVdwODFySDh5RnByNzc0RTlLekZSbXJWOG04NGRrSGtMRFYrYmJ4?=
 =?utf-8?B?eDd1ODBZSlJQT0FPejRxaEdiQWNPOWw3d0RLcnYxVUdtM0w1c2tUNFRsMkFk?=
 =?utf-8?B?SXcvQXI5cmJMS0c1ODNEbTR5MUw0blhmME5tWWF6MVhNRkpkTkFqLy9MQ2lh?=
 =?utf-8?B?VXhYa09CWGYxT2V2T1NBYjdOaUtjSGJuRjVGdWVhZlpacy8zZ2ZFNTRRc2tr?=
 =?utf-8?B?bWR0VkNaV3ZKeTZLTlN4UzVTblNtZXlvQURBWXRmQ0NYNTNJK2tBTDN3aFRi?=
 =?utf-8?B?cWVtdDlXZUx6djgyc3BHaHowWHNPSzRtZWpHOG0zQ3pmS1RuUjBsMHo4UkFJ?=
 =?utf-8?B?Z29TUGo0S0NNOStRNWNobU8yY0JEcElDcGRsUVFDcUNnYkJKdWhkeXBpSVll?=
 =?utf-8?B?Mll2VWprVVlCd21aNWsyZjMxbWlEekplZEphQUdJVmowaVFDeUl4UVNWNzBq?=
 =?utf-8?B?c2tjeE1uS2pucGJsVldad2pZUld2WDBhcFVCYy93dnVLSVlEVmlXZ0JJak84?=
 =?utf-8?B?aEk0VlROVVdac1NaREY1OWNMZ09JQm5sWFpQMEtUZkJLWGZCSzlXT2ZUVjVp?=
 =?utf-8?B?WFhFZ1ZCckE2bmdZeWdTbWtlb2xDZFVHTVRCK05UN3BmK2xLUlVJV0tnb2Zx?=
 =?utf-8?B?K0tYN3FCcmJTQmUxK2hZZ2gxN1JYeDczYU1WVkR2R1g4YStsQ0RFZXFaZ3hJ?=
 =?utf-8?B?YTYwMFNpWXNENXBSYWVFV2o2OWtsNUh6OVNFYnprckt4ZHVIUmEwQ3NrRGo3?=
 =?utf-8?B?ZlpidHpwRStBam12Y1E5ejVOT2diSDJlemVVb3UvcWlpY2s2WVU1WEdoQjVi?=
 =?utf-8?B?a1JZQ2VhaEF6MUtaUWV6ZHZkbGxKc2U3emRpU0lwS0l3V3dNQkZvZlVZczlQ?=
 =?utf-8?B?blBMbnZyNVZKc2RkQy81NDJscXRxaHBabi90WmF3K3VsU2Y3WWwrbmgvS2ZJ?=
 =?utf-8?B?MWhnQjh5bEQydWFIU1lBelB4TmF5b1V2ZGxQR0ZHS1l4bHplSTQzVmQzcUs1?=
 =?utf-8?B?eEc2WklGcEF2ZmE4WWgvS25zTUlUZERpdzlxQzloRFhneGliZ21qcWtBNFZy?=
 =?utf-8?B?Uy9OTitMbU4vNlVCcHdmSXc4dXBEZUNpWldMQ0puUHpzTk81ajNtVTJjL2pI?=
 =?utf-8?Q?+KFk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467b683d-8533-42a8-e83e-08dc80c29a5f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:07:28.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +R5eGLgYgPifWUAMCL4/OgRX7tGvo0GQfx9bDO/NWDgnGv3aw8H63t/HGBtbBjlj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

Hi Reinette,
Was doing few other things. Sorry for the delay.

On 5/9/24 16:10, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/25/2024 1:16 PM, Babu Moger wrote:
>> In an effort to support MBM and MBA tests for AMD, renaming for variable
>> and functions to generic names. For Intel, the memory controller is called
>> Integrated Memory Controllers (IMC). For AMD, it is called Unified
>> Memory Controller (UMC). No functional change.
> 
> This is a resonable change yet the actual changes seem inconsistent to me.
> Per the changelog the goal is to switch from "IMC" specific naming to generic
> "MC" naming in all the code that will be shared between AMD and Intel.
>>From what I can tell this patch only changes *some* of the shared variables,
> functions, and data structures and it is not obvious to me why some are
> changed and some are not. This makes the code inconsistent.

Agree. Will address it in next version.

> 
> There are many examples of the inconsistencies in this patch alone that
> I will try to highlight what I mean without considering areas untouched by
> this patch.
>  
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl_val.c | 59 ++++++++++---------
>>  1 file changed, 30 insertions(+), 29 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 5a49f07a6c85..a30cfcff605f 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -60,7 +60,7 @@ struct imc_counter_config {
>>  };
>>  
>>  static char mbm_total_path[1024];
>> -static int imcs;
>> +static int mcs;
>>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
> 
> Global "imcs" is changed to "mcs" ... but why are
> global imc_counters_config[][] and its struct imc_counter_config
> not changed?

Yes. Will address it.
> 
>>  
>>  void membw_initialize_perf_event_attr(int i, int j)
>> @@ -211,15 +211,16 @@ static int read_from_imc_dir(char *imc_dir, int count)
>>  }
>>  
>>  /*
>> - * A system can have 'n' number of iMC (Integrated Memory Controller)
>> - * counters, get that 'n'. For each iMC counter get it's type and config.
>> + * A system can have 'n' number of iMC (Integrated Memory Controller for
>> + * Intel) counters, get that 'n'. In case of AMD it is called UMC (Unified
>> + * Memory Controller). For each iMC/UMC counter get it's type and config.
>>   * Also, each counter has two configs, one for read and the other for write.
>>   * A config again has two parts, event and umask.
>>   * Enumerate all these details into an array of structures.
>>   *
>>   * Return: >= 0 on success. < 0 on failure.
>>   */
>> -static int num_of_imcs(void)
>> +static int num_of_mem_controllers(void)
>>  {
>>  	char imc_dir[512], *temp;
> 
> Similarly, what about imc_dir[]?

Yes. Sure.

> 
>>  	unsigned int count = 0;
>> @@ -275,25 +276,25 @@ static int num_of_imcs(void)
>>  	return count;
>>  }
>>  
>> -static int initialize_mem_bw_imc(void)
>> +static int initialize_mem_bw_mc(void)
>>  {
>> -	int imc, j;
>> +	int mc, j;
>>  
>> -	imcs = num_of_imcs();
>> -	if (imcs <= 0)
>> -		return imcs;
>> +	mcs = num_of_mem_controllers();
>> +	if (mcs <= 0)
>> +		return mcs;
>>  
>>  	/* Initialize perf_event_attr structures for all iMC's */
> 
> Note comment still refers to iMC

Yes.
> 
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (mc = 0; mc < mcs; mc++) {
>>  		for (j = 0; j < 2; j++)
>> -			membw_initialize_perf_event_attr(imc, j);
>> +			membw_initialize_perf_event_attr(mc, j);
>>  	}
>>  
>>  	return 0;
>>  }
>>  
>>  /*
>> - * get_mem_bw_imc:	Memory band width as reported by iMC counters
>> + * get_mem_bw_mc:	Memory band width as reported by iMC counters
> 
> Comment still refers to iMC

Will address it.

> 
>>   * @cpu_no:		CPU number that the benchmark PID is binded to
>>   * @bw_report:		Bandwidth report type (reads, writes)
>>   *
>> @@ -302,40 +303,40 @@ static int initialize_mem_bw_imc(void)
>>   *
>>   * Return: = 0 on success. < 0 on failure.
>>   */
>> -static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>> +static int get_mem_bw_mc(int cpu_no, char *bw_report, float *bw_imc)
> 
> The intent of the function is to "get" bw_mc ... so not renaming "bw_imc"
> seems like a miss. Especially when considering that its caller does just this.

Yes. Will take care of this.

> 
>>  {
>>  	float reads, writes, of_mul_read, of_mul_write;
>> -	int imc, j, ret;
>> +	int mc, j, ret;
>>  
>>  	/* Start all iMC counters to log values (both read and write) */
> 
> iMC?

Sure.
> 
>>  	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (mc = 0; mc < mcs; mc++) {
>>  		for (j = 0; j < 2; j++) {
>> -			ret = open_perf_event(imc, cpu_no, j);
>> +			ret = open_perf_event(mc, cpu_no, j);
>>  			if (ret)
>>  				return -1;
>>  		}
>>  		for (j = 0; j < 2; j++)
>> -			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
>> +			membw_ioctl_perf_event_ioc_reset_enable(mc, j);
>>  	}
>>  
>>  	sleep(1);
>>  
>>  	/* Stop counters after a second to get results (both read and write) */
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (mc = 0; mc < mcs; mc++) {
>>  		for (j = 0; j < 2; j++)
>> -			membw_ioctl_perf_event_ioc_disable(imc, j);
>> +			membw_ioctl_perf_event_ioc_disable(mc, j);
>>  	}
>>  
>>  	/*
>>  	 * Get results which are stored in struct type imc_counter_config
>>  	 * Take over flow into consideration before calculating total b/w
>>  	 */
>> -	for (imc = 0; imc < imcs; imc++) {
>> +	for (mc = 0; mc < mcs; mc++) {
>>  		struct imc_counter_config *r =
>> -			&imc_counters_config[imc][READ];
>> +			&imc_counters_config[mc][READ];
>>  		struct imc_counter_config *w =
>> -			&imc_counters_config[imc][WRITE];
>> +			&imc_counters_config[mc][WRITE];
>>  
>>  		if (read(r->fd, &r->return_value,
>>  			 sizeof(struct membw_read_format)) == -1) {
>> @@ -368,9 +369,9 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>>  		writes += w->return_value.value * of_mul_write * SCALE;
>>  	}
>>  
>> -	for (imc = 0; imc < imcs; imc++) {
>> -		close(imc_counters_config[imc][READ].fd);
>> -		close(imc_counters_config[imc][WRITE].fd);
>> +	for (mc = 0; mc < mcs; mc++) {
>> +		close(imc_counters_config[mc][READ].fd);
>> +		close(imc_counters_config[mc][WRITE].fd);
>>  	}
>>  
>>  	if (strcmp(bw_report, "reads") == 0) {
>> @@ -598,7 +599,7 @@ static int measure_vals(const struct user_params *uparams,
>>  			unsigned long *bw_resc_start)
>>  {
>>  	unsigned long bw_resc, bw_resc_end;
>> -	float bw_imc;
>> +	float bw_mc;
>>  	int ret;
>>  
>>  	/*
>> @@ -608,7 +609,7 @@ static int measure_vals(const struct user_params *uparams,
>>  	 * Compare the two values to validate resctrl value.
>>  	 * It takes 1sec to measure the data.
>>  	 */
>> -	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
>> +	ret = get_mem_bw_mc(uparams->cpu, param->bw_report, &bw_mc);
>>  	if (ret < 0)
>>  		return ret;
>>  
>> @@ -617,7 +618,7 @@ static int measure_vals(const struct user_params *uparams,
>>  		return ret;
>>  
>>  	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
>> -	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
>> +	ret = print_results_bw(param->filename, bm_pid, bw_mc, bw_resc);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -795,7 +796,7 @@ int resctrl_val(const struct resctrl_test *test,
>>  
>>  	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>>  	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
>> -		ret = initialize_mem_bw_imc();
>> +		ret = initialize_mem_bw_mc();
>>  		if (ret)
>>  			goto out;
>>  
> 
> Please note that this patch conflicts with other in-progress work [1].

Yes. Noted.

> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/20240408163247.3224-1-ilpo.jarvinen@linux.intel.com/
> 

-- 
Thanks
Babu Moger

