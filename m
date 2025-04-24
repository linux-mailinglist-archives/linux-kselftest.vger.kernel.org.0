Return-Path: <linux-kselftest+bounces-31536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC46EA9AB9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C53175895
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACF22576E;
	Thu, 24 Apr 2025 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D7W5BIEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E66221FA5;
	Thu, 24 Apr 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493728; cv=fail; b=S+ZbwGUtDDATM4cz5Hw8e9AvL6wh8r9O8Y7JM8o3CYrocabjcEmoS/phlRFtlzxqRl4VO8eamzsZikMkXfwHVsPdB70xMYn0O6KecxaMcTFtqdGAEgWi249/aH0WkjyV01KX7gpaG66qQEV5+1vSnRjfDNdWZjJ5k9BLyCNpj+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493728; c=relaxed/simple;
	bh=VkPOFTaNwwLRAOuKxrHHlLDgHiUslgaO74uf5Sit5ds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1tbNYFX9jjLeQnVXzy4dOGHZhpbIFtuu0rwloXEIuNjQBAZmV/udes5qLjULMjkcFSxQtuRnKMEX+3EkETzhwbt+dOJTRaLMVCiiq/ke5nNcu7EJc9Mp6KQdPZKyziZ8BoiOZmD6IclNOMs3XbrVClQZgN02tBag+maI0u1ATk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D7W5BIEo; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfnGVheLFSEsjnALUBSfQ4CWS0Bl/ZDtSm6QSaYzKDToExuyzNtzALChHnr5o+SS2pcWa0SKwgWSLXWXg7wajHksJoCdWG6ynTi+WsZWVBpzGczTbE8+/wsNrZ8184pfpXQu+rr+NoNzEeDZ4eneRNuqD92P7ciqxynA9bMz5ckwVkXIxCQ6tIymnPCqTBf5spZYm88M80OObRjt4HEALQrfGYa5Kwq5770yl7E/eTQ8BZvv6TvWWOnFS/NLP4ffrralrnJwYjWBmNC2II+ehh4m5QDzF/WhHXxMSw2VPCd5RbRpFB1saW7rAYfcnzL9gr/+j/zwxzymLVie50TNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N9qvmKlKUcH4UNe3dZodxTZAnAONhKL0ClOo5n+q2o=;
 b=gPKffut1lLu95BDzhvdDety57Ob60xzDrlhGjGU/76U8N53JW2JqWWoQ2q/XLrbdRuLAZasUrsBpKYePydssNOkjdNqIUbTIyCQt7vtOuPCwxQN01pO6LtMKVqzj3+U5FIUwcgOHrjFdWbTmD3aYcj0zifaEP0P6xOFfWTaQWcplACRgn9AIwUU9j9t0ezelNJOa3m8e/rtWoRXwcWUww8RfRZ54t35SFlhybXdnVf0BheUihtHEt6kdN8Q956Dzd4axOPgZheMnyBXD9GGtRLl/Y+Ed6UcqH9xQqPGIQKk3UUdC2DF3Y2wPPEk0614cXlcIlDTr11Qcvhrlm7072Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N9qvmKlKUcH4UNe3dZodxTZAnAONhKL0ClOo5n+q2o=;
 b=D7W5BIEoefuc/JnbwzYK0S90lBLfdkfHmWRD93KVTpoUClp4ibBgYn0oYjzzkNHCBduYWIl4+nIGUDylkb59EUYg7x5TacbWAcIX8X/g4DZBR5E1czUGRtgJlfYQC8/5DMYZk17hXry2YvQZJatIYaM1rB6N/NR3oC2Hovat5t8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Thu, 24 Apr 2025 11:22:02 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 11:22:02 +0000
Message-ID: <8dfb4ad6-5e98-4050-9cb1-888c01340ee8@amd.com>
Date: Thu, 24 Apr 2025 16:51:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/16] iommufd: Add vIOMMU infrastructure (Part-4
 vCMDQ)
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org, praan@google.com,
 nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
 jsnitsel@redhat.com, mshavit@google.com, zhangzekun11@huawei.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <a0c248f0-71ff-4477-98ec-1bbd52eda566@amd.com>
 <aAiaiomYczA22xik@Asurada-Nvidia>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aAiaiomYczA22xik@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d68c84f-9733-4d96-d138-08dd83223c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDltcVIvQlF3b2NEVFBsbUFLa1M3WjJnYVdkcmFBb2FrWVlmaVE4OEhJb3lu?=
 =?utf-8?B?ak1aSE1xRnA2WHVHcFpSVEY1a2RKYkV1cjNiQU9WaWtENEVaUjAzSUZsQzc2?=
 =?utf-8?B?MjFpK0duQXZWSzJ5U1pjUWVucVZWdlVuVjJDb2tqbzBLRXoveDU3ZGFadzZm?=
 =?utf-8?B?cG9PcklNUGswU24xdmVrMG9hT2ltOTliU25sck5BZW9mWDR1S2UwTUtCaE12?=
 =?utf-8?B?ODRPblZ1RDg5djRRSWU4a1V4OGFiaGFhaWovQmpsVDlOdkhzRTNLVFkvSkpi?=
 =?utf-8?B?eGl5YU5MT05VRjFhMjdPMXA4ZmVKQllIbzdLdUpsSXRxVGdWR3hxM1JmRVNJ?=
 =?utf-8?B?bDJvcW41MG53c2t1aXJuZ0pudTNidmloMW9pTUdocXZsWHE2RWdzUlJxV00z?=
 =?utf-8?B?ekw2UFhCY09od1dGWXlLaGkySkNTWnF3U0U5N2NtY0FpSitOcjJ4cWY0d0Rt?=
 =?utf-8?B?ZFc3MkoxTlJnVXZSdXpMZkxoMWNYZjgxUFpCNXBBNHVWa3ZNMFRCWnpkSllJ?=
 =?utf-8?B?Uy9VYmNhUHlwVmpGMjB0ZFA3L3FRM0E0ajU5ZWR3WkY2QjNtS0lzK2NMdGpp?=
 =?utf-8?B?WXRFZnJ0UkoyT1FoNVVqUWZsN1JyQVdJMDA2dExuWEZVUjJMcDZaVzByZHI0?=
 =?utf-8?B?ZEtZdGg3U0htTlRiQXJFT0h0K1IyUUplSWYzT2FiVVNHa2lRdGQ2ZHNhSkRF?=
 =?utf-8?B?SThWNTd3V2V1TWtnYVlyUEpXeXdsWjllTElaRmt1TDNHaXJrZE40QTFqdEp4?=
 =?utf-8?B?Si9xS2dza1hKYklrSDFKQ0R6dk80N05jZnlHaEljdGoyZDFCTlI0R0hxNkpl?=
 =?utf-8?B?QXljenR1V2NybFp3aS9SeHZ1WVVpd1dPOWdKVEMrR0RUVmpuYWptYWtmV0FG?=
 =?utf-8?B?QmEwcmw1YUFtZWRhelNzeDB1WE80cG1reXlucitqajh3RWthY3ZFVzJTZVFR?=
 =?utf-8?B?am83cjAyRENKT1JXbElxYlJSZ2R1dWZMZjR1SFZtcWd1M0U0dlR6QTRaa1Vl?=
 =?utf-8?B?bDIyUytrYXF1QVpmWHBWSkNtaEZkaFNvbjdCckFDcTV0WVJUcVhLWVBuUXJ2?=
 =?utf-8?B?OVVJQjIzNFpLcDJpL2VzcXNOZVhmNEJjeEZwQit2TkZ2cXJ6cHpFWFJjRjBN?=
 =?utf-8?B?aExLOTd0OW5HWXhNdTFWbVNiTm9zRFYzYThRSVlFZEFQZ2haeTcxQ3hXM3dY?=
 =?utf-8?B?aHk0TkpGaDdGbVZSTzlCRUFaWE44YjR6TVd0YmN1QnloSWZIN1I0ZmdZNG00?=
 =?utf-8?B?a2p0S3ZnSkJhd2ozaG1nTmVqNTVkcUVmNzRzUzBFU0hLV01xV0N3bFNtU0Jl?=
 =?utf-8?B?NWt3N3d6LytqMElUOS8zalh4MU5wNFF5NUNOOVZQZndKN2RxcmhKV0k2bnFZ?=
 =?utf-8?B?UjNQWnA5RGgyRTJXZnFtZithVVFka2NpOU9wNEhWb0hpWkRuaHp6a3JiSUZW?=
 =?utf-8?B?NDQzdmlZZVFPb2JhTzE2K0huSU0wTVk1V3pTNDJhS1hLSHBLMkhqdU9ndkdL?=
 =?utf-8?B?QndYaDlPUXZJdEV0ZUh6dUZDU2w4MnNSUEtJRUVmSEp4UTRBSUpBY2tEQnBr?=
 =?utf-8?B?RG9jVUNMeks3SFVDem82SG9mYk5tMitjaHYwOVk3QmNDTGRVM2V4SkZ1Slkz?=
 =?utf-8?B?SVlsNCtPTjk5Mm53RHVmRitkSnBrVkd4V2cxdUdPQ2NEazFlTDB2ZTh3YThM?=
 =?utf-8?B?WVVWTUszV1FUci9VT0VudlFnM3UyQ0loR2M0THhTbEpXV0ljL1BYRFcwc2x4?=
 =?utf-8?B?WXZNVXkzYTd1M3daVU9udGpBM3NOYnJJb1Z6ZXI3dWpYdlE2YjVTNG5vb0ti?=
 =?utf-8?B?VFZ3QzQ1eTVYWHlWbmZCeTBrdGlHTlZkb0NYdWg0aEdTWDdHL1dkWFZ6MVNE?=
 =?utf-8?B?NUp6M3VDQWNPd0NsREhSZ0RKS1JpRnRaVWVIZUVVTm1XcVpQM2hnTlg0L3BD?=
 =?utf-8?Q?aHWLdu2sMrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlJIYWU3aXc2Q1FKK0pJNnRkamV3RjZJWVNSb2k1dWdaWEM0akVmU0YzTDlw?=
 =?utf-8?B?VGQ1cjFqRk13bWlFQ21aZVFUcm9zZFZ6YmFFTkdrNjJHUVV2SlY2UktHeXB3?=
 =?utf-8?B?MFRpQkIyRk5oQ3Jna2pwVjJLaFpnWDZxUVRlaCttSG84RklhbGtabXpPRS9Q?=
 =?utf-8?B?YkEvbW96dXIvYVBvM3FoQU5SM0pFd1JvZ3I0QjVmY25GaG1RY3J5dEIydW80?=
 =?utf-8?B?YytTVHRLOEtsWjY3SU5PZGljU3ppV2NHbGtrVnh4NHBaNWxzKy9qSUdNYVdC?=
 =?utf-8?B?THk4YjlTZ01BSElibEFDcXptUGZZekxqKzd0S3BJSFRDbkhuYTc3d1VFYXFU?=
 =?utf-8?B?eHhLMXlBRUlEaUZMVFIrREpqNFhncjBtOHkxaDEvb09icGYydFNENHcwdVpy?=
 =?utf-8?B?N0YrbUxGMmJQSXJIVTZRYXJpanVDYk1MM1pVSWE0VWt6c05wQThqYWpHcVBH?=
 =?utf-8?B?c2pqVjFVN05MM1JNNWpLaHduR1RXakdpcE1vVEQ1UGFaT1o5UEdqUzNIQ1FJ?=
 =?utf-8?B?TUdPQmVqa2Z2UVBPbm9rUndoZTQ1d2dadllkeTFCKzQ5cTNNZXJUYmlSdnMr?=
 =?utf-8?B?bjkveDArSTB5RDBmZ2h3MGsxZnFrZGJvdi9SS0NqNVg1cGptZW9iS3luNXVH?=
 =?utf-8?B?c0F2S1JDYkpaeHdESUx5KytZWVhvaHFPc0F2bDYxRFUrRTk0ZXdBMllyNlJL?=
 =?utf-8?B?RUNOMFN5Z2xiMG0wZE9ZLzRsVjdOMEtQZk5VSmg0Y0Y0aSt5dU4vTzBHRk9R?=
 =?utf-8?B?RjlWc3A3OVMwd3BXZmU1VXBocHNXVDZYRUFRR0NLWXViTGpkSmgzMFN1QzF0?=
 =?utf-8?B?UjUzQ2NUL1IrdkIrVEZLT1VvSW4rNWxDNTVXK1dwMzZpNTlMMXY0b2FuaElR?=
 =?utf-8?B?SkJTOHhNOGR0TUpWbFU4bmU1czZwUEp2ajVleG9rZnMxRnZqYnE0bldxVExm?=
 =?utf-8?B?b1JSL2toY1MvTG9tTm41bEFEV2ZkdjVEOGlPTk9QdUVyQ0VtNmpmNzNReVRs?=
 =?utf-8?B?Q2M0RHpaS1puSnFHNGtJaEVFREtrbG5OTjhJNUszQ1J3dlVQb1p4YW0yNTJZ?=
 =?utf-8?B?MkJ3YURXNXlrdWwrY0piMGxaNm1oVFIyN0NIbUZhTFVXL2hIUmFTNE5nQ0hE?=
 =?utf-8?B?Y201N2t1SG5ScXdIT2pTMHZEek1IaE56L0pDRElScFRSQk9TOUJ1OFNmWHZi?=
 =?utf-8?B?OHExSlBkSGlzalYyQWtBcXRuK1NPQjd3dGxpSEs3U0N3QzNPcXpHcVdXVktP?=
 =?utf-8?B?S25yaFhzTVZscWVIbE9mVVorTlBmV0N3T0hBMVA1dDZUaTRJazdZOHFvSWRP?=
 =?utf-8?B?QkpBcmNKSGhxR0h5Tk1ySGZwaktFUi9vSWc0YXllZ2RGM29JQ0gyS2dKR0Rs?=
 =?utf-8?B?NEZjWUF0OExTSnRReTFIOVF6WjloMk1SaFMydjJSL05OMHRJS0VNUlpZdG1I?=
 =?utf-8?B?RGZxK0dHK2tYL1h3VG5FOWxibXNuNnlZbHR6V2pEVlpDWit1OFNJakZzTkxw?=
 =?utf-8?B?OFJmbFZRZzR1RzVRMElwbk5mS2o0M0FhdE9VV3E2YWZDeHdCK0xzZGMyNlpB?=
 =?utf-8?B?TkFtZEhZODFjWTdLUUwzWTVnQ3pzR0NsaEhINnM2elAxRTF2L0dPUkVHR3I3?=
 =?utf-8?B?ZTJ0R2E4bFlYSERKZ2llZ1VVMHlNUVh2dHdUNG8zcnlmV0hwVldpeUpJeEVH?=
 =?utf-8?B?cDh0dy9rME1DVjFvQXBnZ21rNE5IVEphZ0Z4bGNOaFVOUmt2S3VGeHFBMlhN?=
 =?utf-8?B?RlJ3bEs3RnlTT296V3ZmS2dkY1dYc0o5N0hTWlU2UlYyWkh1V1EzL0UzQ2JE?=
 =?utf-8?B?dnB6UWh1bGY4T0JzOEJ0VGRURGUvSWZBRWo3QTE5Mmc2SG1CWFdtREJwZXRo?=
 =?utf-8?B?OVIxdmVSWTFYZ2lhMkRGclJEaG51cVV2S1VDdzFOSGVTcUNVbnJnanpSK0pO?=
 =?utf-8?B?M2hQNG9HSzVMMTI2eDA3cTRWdUdGV29EbHVNVm1xd1dQekYwaThKMmFLcm5O?=
 =?utf-8?B?aStvcmpmSzNXNXJTaGgwT1MzTkNLRTByOGpZaEJoYnE5NWNYOUdIWThodXg2?=
 =?utf-8?B?aGRkbWJRZVk0Tm1LSFozZHdEckdlcEZxa0wxUmRNaGdpMFJtT0tSRDFnSTM5?=
 =?utf-8?Q?Y/kJVmNJPAIDSzoZ3pHL+CrDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d68c84f-9733-4d96-d138-08dd83223c46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:22:02.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMMU+WCQy+fAi3avr1eiZaDXlXY/KVw2RQvfLJf/etYmLPZeZhLdXAraHV2isDA4BH6wt2GkFCyeXXUX50biBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

On 4/23/2025 1:15 PM, Nicolin Chen wrote:
> On Wed, Apr 23, 2025 at 12:58:19PM +0530, Vasant Hegde wrote:
>> On 4/11/2025 12:07 PM, Nicolin Chen wrote:
>>> The vIOMMU object is designed to represent a slice of an IOMMU HW for its
>>> virtualization features shared with or passed to user space (a VM mostly)
>>> in a way of HW acceleration. This extended the HWPT-based design for more
>>> advanced virtualization feature.
>>>
>>> A vCMDQ introduced by this series as a part of the vIOMMU infrastructure
>>> represents a HW supported queue/buffer for VM to use exclusively, e.g.
>>>   - NVIDIA's virtual command queue
>>>   - AMD vIOMMU's command buffer
>>
>> I assume we can pass multiple buffer details (like GPA, size) from guest to
>> hypervisor. Is that correct understanding?
> 
> Yes. The NVIDIA model passes through a Virtual-Interface to a VM,
> and the VM can allocate and map multiple command queues (buffers)
> to the V-Interface, by providing each command queue info in:
> 
> +struct iommu_vcmdq_tegra241_cmdqv {
> +	__u32 vcmdq_id;
> +	__u32 vcmdq_log2size;		// size
> +	__aligned_u64 vcmdq_base;	// GPA
>  };

Nice. Thanks for the details.

-Vasant

