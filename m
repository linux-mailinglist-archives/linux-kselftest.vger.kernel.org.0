Return-Path: <linux-kselftest+bounces-47207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBACCA9183
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FDCD30117BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459FF2F25FA;
	Fri,  5 Dec 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHdP6ZLc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE10218AB9;
	Fri,  5 Dec 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963554; cv=fail; b=YZToTf4qROyognDv3Wni2PkbeU0RvvDsLOyiF22WT7o73dB8JFfOR8ItMnI6RSnKFugtlmZuvkyVCEE2gu5wItZcjxpFqnYEacfZEFvhCVMieQ+lMDoVl46tJte6B5II0gdBugGjhd/qRytZRJ6CiludKZBdgwEZgKy0G/vjPm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963554; c=relaxed/simple;
	bh=AsgKbSK00BlDLl+bQoeINYUlkCLAnm4CpScK33oeqb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fd1Hl3eUnYlokm65pNq6/v+phodPHavi/CpTvTXJGU+hmZgW1qt3umChWUaNFSaQJ6Iim5BbFP9nNMYVmDf5PvLtogdK2s5xlBwNfy+4OwVHc+qYGTrHkEQaPrStVJIJ7eDANLQYgXAqG8ukaXXvGBzNRL9BsoSsCJE/3sRO3Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHdP6ZLc; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjqz98EUUf+KBIp77R92fps+8LsXNW+DW4tA3Gz3uTgnn6VQFhridkG1ejU7o0zD9prphgfavx9lYkoVi2n6c+RP5OhiiAQmDz0l4vec6Wz09N1N8/OkxvHDg/J4fTE+QO3PWXqIZP5m8ywxD7IpISGna0X2C60jXBieNrTOJPIWUV2NVOP8rKI0cB1a+GBRXHrUbzBR5GrDG3CBOH4B6nhfXr4NDLVZcljjpBqYtlxEtU0nhTkZ0NGHQ6EAAA9oUSS+vjFzg6EYbVQGForrSvNpC7IgHPjoV/U0b6JVzGuJxsMR7YM8s1IZzXP4DaThh5OGMbwIybk1WxEYehcKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/b/62baneSxVIqbIefJS4jt4BM5/WLtRN2jaH13GEA=;
 b=dJkBakbDdMBuI+UgL88LRttLYOBiA2LnOzLaqdT0DkHARtZ3MWKl8ex3dZSn3Z6JKbdV1I9lmzAJUsFdkEa8BccAqZbOmo2klHI0jNuduNAz25QLXg4mzMEtLLuVVtgevekhyfjEESmOdTB87BonmDWQKPBSzyVdllaOB3tguw+2gfSWU/kljnyTNlBewZmxMMY3NpZN5IadjnCN8EAZyAluOAjUTwIMn+ibe4lk5LV97GZtaajOyPvqD25VBqrA5seexsE4SexobILBeBtnyRzU3Pq64ug3kkx5EGv4qEBUe1hGShPqrYOsA7cDhjXLsBYL/N91MQTX2kywzyB8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/b/62baneSxVIqbIefJS4jt4BM5/WLtRN2jaH13GEA=;
 b=tHdP6ZLcde90nS82ZCltQDF8SmLon96MhKL0QpOhnGuZuSpMsKMCwrVkyrnnOAGFEBjVxyaLdwzznWJo9yyMB05H0R1fn+SfEUmhV8a07n/Z3RbRQv1JICOG3mJCy8SW/VytvyieqwSrQ9IKt7qDApFGe1O6zB7d1AypY75Ynyn7s+qfuRCzSOBrotqelqEfYIV5T3ZQjraV8/BFyfK0pZ+DDVbC2I/Jo34Op1CsWoCGoWZGphQlGTK+IoVrGnRZgnzt+qIElRNaWZ4oaOpvzcxX/9Zd2EwqAXm0rXh1wXs7LdPPAlEUVMqYBPExBnkcealN3RNJo1vjuGjYN8/8HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 19:39:08 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 19:39:08 +0000
Message-ID: <86ee2c6d-476e-495d-b36a-6a72a1c98b69@nvidia.com>
Date: Fri, 5 Dec 2025 11:39:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/resctrl: Fix non-contiguous CBM check
 for Hygon
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-4-shenxiaochen@open-hieco.net>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251205092544.2685728-4-shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f2089a-389e-4bb8-16f6-08de3435f4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1hvZTQwT0xOczFieG0ydWtFMm02WStVY2tnS1p0UFhrc2w3WElGRmh3cTEv?=
 =?utf-8?B?Vkd3bnNKR3MxZTNXeVNvYTBaVzZjZXRYeEl4anNjR1IrS1pISUdvd3RocVd4?=
 =?utf-8?B?L0xXWFRvR0orUHZWaFRtNFd1YXoyZkxjS2NCVHRhMVg2QVlRY2Z1dVlCMEc2?=
 =?utf-8?B?MEdpU3dKSkVHZkpRQk91dDc5dmdXWElUMFV6N2lYUUh5YXlKaEtFbVd1ZmFP?=
 =?utf-8?B?RFNoWC93aTZmTTROMkdQdmZnL0RXZGdTeEJGSng2VlpzY3RZMFExYXFRQUNx?=
 =?utf-8?B?SFNvTjlPaFBvNEh1WFk4QmJtUUZBRTEydlJuTnBJSkVKSU5mMVNMRm81M3da?=
 =?utf-8?B?SFNYbjYwM1BYaElEVm8vTS9SNnpqWStJZmF0bnAxSEVQdGN2NG12Ny83bkpl?=
 =?utf-8?B?anN4N1dzWVdhdUxFRVhScVZkempaYklQY0xZTmloOFJVd2g2QUR0cXRQNENP?=
 =?utf-8?B?bWl6bHpBVGxjLyt5eTlQemVnZXF3VTZFQzFDd0dsOG45M09CeWkxUDdQUXJh?=
 =?utf-8?B?emJnRXcvUk4yck1GRzBiUkR3R3lOWnIvU3c3eDd3cEFiektVUkRzS2s0S1dE?=
 =?utf-8?B?U2NONnhxY2tONXdRejBOZVFPTVpiUTZxbTR2c21jVVI2cHJCdTFrWGNNd2Y2?=
 =?utf-8?B?Mi9pNGMwRXpPM29UTG9GYS9rNXB3MUhsc2NUalRFbDN3b0U1QVRVRkk0OGxC?=
 =?utf-8?B?MzMvdE1CQUh5QVFXeTQ1NzY0V3I3aVlNN0phMmVWN0ttMGJaV2ttRFpXMTc1?=
 =?utf-8?B?NVovM3FqSkF5N3FlSnNrdFpYd1kzYXArdDRBT2JlaElNYmZwczZXZXh0WHdP?=
 =?utf-8?B?d3R5VWtQdENuZjRkVnBCSm9QSWd5L3VhVWlISVp4QkRmOFdCQTFQV0ZaeDhm?=
 =?utf-8?B?TGtpdFQ0aEV5VERoUDZ6MklVd2ZOb2w2MnQ5KzBvTlNsSWpPRVpLdlRPT0lZ?=
 =?utf-8?B?T0ZoOExpMm1FVUlOS1RFL2ZFeTRKU1NYZkIwZEpHbUYxdUt0aTNXQ3FLbWRh?=
 =?utf-8?B?VTFUNldXRHRUTi9lUDBjTkFqbjViTmxZNGdwa0NzREt4SXczenEwbnIzbndI?=
 =?utf-8?B?MVYvSk9XWnppdWFqS2c4WGRBQ2FDaFAwRENlZ0tRZ1hBU0x5TkVOa2QwQkwv?=
 =?utf-8?B?ZGFGLytvdVZIWVVrS2YzRmNzdHIxcHJ2cDhDVTVjRHZUNEdQU3UrOHZqdDA0?=
 =?utf-8?B?MmRXek5nY3hYSXVPL0doelhpOTRqZ3dUVVgxYWJGZzhUT1lNNTdZR2sxaFZJ?=
 =?utf-8?B?eXpqOTc1bUFiYlNNWWpmVDFkaGRmRnEyN2xNUDhRQW84b0piZE5uam9DNlAw?=
 =?utf-8?B?OGNqaEtrZ3l2Sm44VEUzTmtjbk1OR3FkczZrVlpVTEgvcWsycnkyWmQ0NXFE?=
 =?utf-8?B?YklNcVlnRUVoU2F2Vkl0bmgyMTlwcFFXYzZOc2RGbWlKdW9Rc2pXZDJJUitK?=
 =?utf-8?B?bCtjZWxka20vUmhzelpKQjh3UVpzZnNiUG1uMnpmVTF5MjdhdzJtNFVMTzVp?=
 =?utf-8?B?RTBkUmpTMlREdDViSlYrUzZna3E5R2VSVEdlbkF0cFgycGY4aXlUdnBGZllq?=
 =?utf-8?B?RGs0TW5WbmF6MU9MS1lzc2N5ZW0wdEROWGpVcTcrb25WbHNpNTRTU0lMdXdv?=
 =?utf-8?B?U2wrTmxlQlpVTGFDRHFWY0Q3QmZleHB3NC9IcytXSml0SGRva3JiR3phU1pJ?=
 =?utf-8?B?MnpBS1hUZHdTK0ZqQ08xNk1NTk1GUklTdmloYXpzTDFhaEoyMG5tZDd0YmhE?=
 =?utf-8?B?M2JkZlRscEVTbGZjeUhGdTkvU2Y1bDNaczVDZm5vb3lRSEg2TnczeFJaZm9x?=
 =?utf-8?B?RHA0OWhjWUZDVXlHNU9FaEpkeTBGUXc2RFpWVHhMY0JodFpBUFRRMXkrQkdR?=
 =?utf-8?B?Sk9OVU05enhTUEVzTjV6UXMxSkMyaG4wdXNiRlJoY0cwWUo3VEhaSjdNb1Qr?=
 =?utf-8?Q?Z4+Tji1Tf0KkGLoMJNfK3viYh5IHTrmY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WER0WE5IanpaUTBRVWhMaVRseVA1Rk9yWlg0UldHczR2dW1jSXZPVVBjbWdE?=
 =?utf-8?B?dytvVForL0FxNHkwWGdsU3p4VmZKSmE0RTZFZlFjWHRTbDJzdm5DMjF2MG1m?=
 =?utf-8?B?cTc3ajFKVU5laDZtaDIxQkJ2aTlZUnVaK2lOckZIK0s4dUhFcWRVYXQweldS?=
 =?utf-8?B?TVRydE9GWVNKU3dQalJ5Q01hWnZicmVUakdPOXFaWkVoQXFsUFBadFdlR0NK?=
 =?utf-8?B?MzduZVI4UlFJZWhoSUpXaU5adUJvdDU3eDRzNlJxUGpUNVEzUGQwZHMvZVpT?=
 =?utf-8?B?VHpSbDJsczhlZlQ1WGJDTEtkb0UxMmtILzFEOTRmdDVZMXE0Tm54NUhkaG4x?=
 =?utf-8?B?bHVGdjdxdkR6VTAySTR1bEQ5OTZlRitJanVqbzdJZXdhcER3RGhWUVA1ZkxJ?=
 =?utf-8?B?eEpQVHl4SDlHWE1MZkMvdkxPK1dUVGs3OUNjcm5oMkExbC83M0NSSlg4K0t0?=
 =?utf-8?B?ZXQvYjk5MFpxZjNyN3BVYTI3NVlGVWpvYXBWcUVWcWNpaDNlMTZqR2ovUHJz?=
 =?utf-8?B?Qm1kb1k0YkhVaUN3cWI1ejVLaXc5UHRzMXUyVVFicnQzRnk0T2xiS3B2WEFR?=
 =?utf-8?B?MElEOXR5VDZTMlRMZ09Dc1lYQ1dhNEo4K212enIyeE5oRXNFQWtuaEREWXZH?=
 =?utf-8?B?SDJNNFF2MktUYnZ6Q1hnR05uVHV0dlNPOGczdjlYYnZ4NGQvTTU1ejFwV2Mz?=
 =?utf-8?B?QzN5b1lJZmVIZXN5TjIxemRDcHYwOTVVTmhsK201eWtlaS9EVk1HdHoyMlVJ?=
 =?utf-8?B?aUhraDZ4UjRRQU5pSEs0NGw3MDFQd1RYbkRRVFBZYmthejlaMm16aVR5MjlJ?=
 =?utf-8?B?SU05dHlQSnd1RUJpZU0rUEVQbVQ3bkRxWFNIU1B4UzlsSkxYUmpYNzh2Sk9E?=
 =?utf-8?B?R2hXM3F0VjN4dFh1aUlLWHR4b210WXMyeVJkU1V0U1dBckIrZnFnN1I2U2ZZ?=
 =?utf-8?B?YXk4a3ZPUzRkQVk2YWlOeHZxR25MZFdBNTQ1cW1QR0pxTFNxR3hveVkrZm1r?=
 =?utf-8?B?Y1BCWFEwRll4eWgrUWlKNmlrT1F1Slpud3c1dHl1cmlaTGV4WHZlYVZSbzR6?=
 =?utf-8?B?aGNCclZlcHVMWTVlSjJBUm9salgyOGNzZ2g4cE9YVlF0UDZlWDI5OS93d1l6?=
 =?utf-8?B?ODNmdGlCY0RhZTQ3WVh5TlRXTXMxbC9wVkZLTG1TSk83K2g4WGw3SmVVVERV?=
 =?utf-8?B?OUpBVHlweGpja2Uvb1k3SmhoQmRGVk1vQ29tQ3h4YURQK1REV0J4TVZmYUVL?=
 =?utf-8?B?NnJUam9JTjVTWlkyT29JZ2R6eG13TTh4WjJZcjNRRE9EQ0puY09uUnZaL1p0?=
 =?utf-8?B?MFJHVG1GbFRTY2xOY1h1Q3pjTWFEa3pZQ2ZtR1lMejc0SjJHL0Rwa3RXbnVx?=
 =?utf-8?B?NDI3dFY2Qm1uRVNza1J3OVpoaWR6b25xMDNZckp2N2N0a2p6WmJ1ZC85bmZU?=
 =?utf-8?B?Zlk1MnVpS0psUU5LWnRrSXV5b1p1TmRtMGVNNmJpNC9sVGlVb2FnOTVUZjkw?=
 =?utf-8?B?T0FzNis1c05VNElxVTRMNVVkSHJ6ZWlXVWFXU3dIV0dBblNMYnJvQ08yMWRY?=
 =?utf-8?B?QzBIOFVCb1pZWS91emNoZkxpcTNtTWJDbE9Ha1pWWUhYWGdXVEttRFJvVGNw?=
 =?utf-8?B?TUNyM0pOYk13N281ZUlsV29qVDMxV2FhMWo1Rk9PV0FpQUtvZGsyUzBzWUhO?=
 =?utf-8?B?Zk13bkp6ZU1oR1oyWnBTUHJnQ3Z3UktNbzVuakI4NnhmTTRseHdnT2gyWTZt?=
 =?utf-8?B?ZExKelRhUE5BdVFDS2t1MExEYWZMalBuS3FGK1dYNThEejBwck1uVG0zZjda?=
 =?utf-8?B?TmpQeEFWSEtZK1QrVWlXQkJ3REViTi8vYVZLT0xxbHRTbVVSUGNuTkliMy9Q?=
 =?utf-8?B?d1ovRGF4ZGRoYWE2K3dzZDA0UmxiaDlPbGRaNzBUTkZZZFRtWXRkUG5sbFQ0?=
 =?utf-8?B?bnlVYm14NlVWRFNxUFJXems3aENiOVoybkJRVlVteEt5N1dTVFFBUWpXZC9o?=
 =?utf-8?B?NjFOYmFwRWE0azVtQjkwRE1odzBlQlNBZjdWM0ZrVHZ1ei9zV3NYdmZBTDRP?=
 =?utf-8?B?Ty9xYXN4cXJaTjdoYUFVUy9CWHQ1cVgxazNCdUxlbjR4d0w0aGVXcFdlWVky?=
 =?utf-8?Q?GdxqPO6bC/hCcXUksmnc+9Dfi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f2089a-389e-4bb8-16f6-08de3435f4e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 19:39:08.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVujnwrZDkk87aCdssnyyVi6q/F1MhSlErZY5/hPfRChj/Ddn2gXrLA2u5IUMdMBJzOrHD7canZ/g1HrWhYsxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663



On 12/5/25 01:25, Xiaochen Shen wrote:
> The resctrl selftest currently fails on Hygon CPUs that always supports
> non-contiguous CBM, printing the error:
> 
>    "# Hardware and kernel differ on non-contiguous CBM support!"
> 
> This occurs because the arch_supports_noncont_cat() function lacks
> vendor detection for Hygon CPUs, preventing proper identification of
> their non-contiguous CBM capability.
> 
> Fix this by adding Hygon vendor ID detection to
> arch_supports_noncont_cat().
> 
> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Maintainer note:
> Even though this is a fix it is not a candidate for backport since it is
> based on another patch series (x86/resctrl: Fix Platform QoS issues for
> Hygon) which is in process of being added to resctrl.
> 
>   tools/testing/selftests/resctrl/cat_test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 94cfdba5308d..59a0f80fdc5a 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -290,8 +290,8 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>   
>   static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>   {
> -	/* AMD always supports non-contiguous CBM. */
> -	if (get_vendor() == ARCH_AMD)
> +	/* AMD and Hygon always supports non-contiguous CBM. */
> +	if (get_vendor() == ARCH_AMD || get_vendor() == ARCH_HYGON)

nit. Better to avoid call get_vendor() twice (or even more in the future)?

unsigned int vendor_id = get_vendor();

if (vendor_id == ARCH_AMD || vendor_id == ARCH_HYGON)


>   		return true;
>   
>   #if defined(__i386__) || defined(__x86_64__) /* arch */
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

