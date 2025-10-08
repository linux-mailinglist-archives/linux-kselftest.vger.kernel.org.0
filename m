Return-Path: <linux-kselftest+bounces-42880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D38BC571E
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B2D189EACC
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68B2EC0B0;
	Wed,  8 Oct 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbXpI3Bw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270032EC08F;
	Wed,  8 Oct 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934239; cv=fail; b=Ark/wV0da7uywV5F3m7IDfjHefzWt/1qklJujOrMQaf4Xt06bpbY0wem92kE6iq/cmYTBB58OslLdkBIOV4FalD7oFCwQF6IuaA4+ZCV60NYMxwtVDppRO3klilJgve6gXnVWEBoO0cybgwQGLiayV4GT0KbhvsMTfckZM3z42g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934239; c=relaxed/simple;
	bh=3xGpiXypi/whgNjhnpC8Vt0S3rp8EvOaF5FqA7Jpsao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pp65tgmFY6cUoHHtr6RwrCWXd5AJswZlCKDVnw3DgmGrlWFZjAoU4buHLOoHVrPwhiC/EuSYPOSlczoZxgnLlLqYgoIEFMDIfY9JzAdfjYTJpi/ESCLCom95E12h2LOr5T5oFD0I5nBd1a2GquERKH5JNB3FSbdRHpR9Ig5Dt4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lbXpI3Bw; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWsmA4tXZIYwQ9qWGecOpCahO1WwDMrREq8PbdFypF5fBx5GaWP0O6Oi1rQc3JhXPS+cKq/oHKJA38+1zITXsKR5807tCF4oj6HRhWOXB7aBwFqbXJWddsk33EGiUzpKUSJYjLVkfJlSLDLKnM+l+cCnVAPLuCmV5AyuH6lUxbVw/3Ft5Y2yBLvFkcBP7EVLXHxFScbDdqWVniPAdzwTnEHCnPqKJXnJfsJ+wURuPNqMT/5Ybe7+/942o3ENIieb7Rjr7OIAI61ziOWdDkLhi0wnuVptQ/dSP+HRmN8aZIMqH/ws+dFgVm/KvZUonaYeiGbX6SCKlJuQhnhjPGRTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikOQbbzTEQipqOUY3jrKzzou3e2s6M2X7ERZi7b2ybE=;
 b=tyRUvVXvnHOtiBeJKXySj4KMPzrK5LwpDYU4dbri1zN0fzoFU2ZHcfIjEw4LzfSYIrfp0eUEOTxSwlgnk1q/iCn76fQH9Un+qPtAVjoh6ZZwrsAgcsGptrOYnLof5pejdRRixFl9ikaaFPuypYQoj8XSXuLIoFYVZhfLDV41k5pFm1cJsbpRcT24Ae9yu1CjLSK4T0KgeOiER39OkaL6dNHNIuSQPteYMzv5jemR16FdS/8gr/oICoMFb2z9zIhEMRtqLAyYKma4SwV2+cs+N3KFXKBW5mewIj+h7PNLukRHj+SpuVY0XAG9um5af2xPs7YTmx4rt26tQaEJ2RhbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikOQbbzTEQipqOUY3jrKzzou3e2s6M2X7ERZi7b2ybE=;
 b=lbXpI3BwpWzeDB56Jvqd2z6UevmCfcmjzFo63RqkV5Qqg3efaJc7UmblsRwGEeCfPT4jvec9wbWzj/srAfhPKZLlxSem8yLKNWYSi/C0Ki47QIOyd3cRfcoYIb9wvPcw7A0dFa0VVM+Cme0qH34IeaM/ySeS4yXMfPKH5iTQim7YiD983S39NkPeuNsVEyFm5SmGm1gXtFJblQwkWDFs4YAfm3NnKqPwGei7RQ1756nNI4RGTcWBeocmN+zPDtTOqebMhVGx3J3fR0NmwhEO31XCh+Yn62uk5nn55KYgsmFqpLFRY9A0Rggi3110A+rJcEkfsPlfV3myr52RKLIvRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 14:37:13 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 14:37:13 +0000
Date: Wed, 8 Oct 2025 11:37:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v6 01/15] genpt: Generic Page Table base API
Message-ID: <20251008143709.GA3833755@nvidia.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <1-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:806:126::28) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 680c57a8-eb7b-4ed5-1685-08de06782ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQpFH4yvtDxQCsS5+Vemn/8EDsPgg0KCV6wIrjZj/mko9NDppGA9yVly5g/0?=
 =?us-ascii?Q?e+nf7JWOmbpA/hnL5UEy9TApBICVjQjeT5jCE5OHwx+UOs7BHsbfUdlkZuHY?=
 =?us-ascii?Q?7PvjoDlzjhG2P+vDVJMeAusHbCbdd3ErpwZgPsWIt9asp89/BEjKr0WKdDK4?=
 =?us-ascii?Q?M0A6blwQ4lOrrpbdJ9eaT96wnci4ZzpH4n9/FDP9F13M8/p7mebWHciFfdAf?=
 =?us-ascii?Q?7wysP5+38uq86i7NbvCl4vZntHrMj2pl9Nl4sSBm6a6TxhSUIX2ysi/CjBod?=
 =?us-ascii?Q?kHUkHPkSmynNgoWLxYlDrNP0pvXPJn0w3F3VR3eRRvrq9R4XYiqf0Y0YlYIQ?=
 =?us-ascii?Q?bkpzoKtj/JAP8l8n9T4Ai8HWoIFnofXoBw7F/Rob6Sr2ZJnBbbSDpsS2MdfE?=
 =?us-ascii?Q?rdSHEf2LJBfFl1i6DMeCHhbNP1v1+M8ng0dxPWWwf0xby64NxzTqIIFuw/95?=
 =?us-ascii?Q?iFe5pqwWblH3Nk1u1B24CFviacuOwaTW/GeS7Dg3LfzSR+Ul6kbDFRH2FgiT?=
 =?us-ascii?Q?EAmz1ROwL0Teu6tRAG+sYnOstQbxPmrihmTOv9SSmy8srtpWex+9YZu1o08P?=
 =?us-ascii?Q?NucOxsJbRURHv7rtvEBd8Ge0PTFS22CSjrrU3rfmuj6O8RN+pTf6WSuUKJX0?=
 =?us-ascii?Q?Ou0v+q7IKFDcCe4Q//2ByfXZZWyEUQ2qJEU8GhNAmk5V8mbS1rm5JobXjzE8?=
 =?us-ascii?Q?Ht8PVVZ9l6CMMgK/j95RhDFMeEPqo5sKTVfNoPZuvpZvW3D5XlK1dG2e+GZm?=
 =?us-ascii?Q?b3iqDvysUEeckbqAWmaqymKi5+sqQ+86rkEEBRr5nnUpgO/gjwP0c+q5vQkc?=
 =?us-ascii?Q?99UWYUJme6ABQRUdcUclvy+W9F1lovZRTkhiilAPlrdKHUaoIRKp+RnAM0Xg?=
 =?us-ascii?Q?eyNqHD5qlOLJYBhPyihhoUHB6wx4HFY1dKoTBFzkyH1+gbqcDXn6qfDXZiiF?=
 =?us-ascii?Q?5Otk5kipqzqiOL/ORXtNsIeZYHYizTVoSQbXXGxIP2KJjw9D4HtWDhuvGvuo?=
 =?us-ascii?Q?eUP+paZW3395G9HaRLgdrHSPWIpGzDfWNx/8Gw7/ecp1s9qH/qSbmmUMwDgR?=
 =?us-ascii?Q?rsPcl95hoXrkGUluTWIYt02XDVLwd7IbLq0REmiYvrjiDrtkLO3n2xnMdFNT?=
 =?us-ascii?Q?1HZYBq7uMlT81DU6kiiRzEx3M/nvtYcHETI/vSa/iBkguJA1n45D4TywPXCy?=
 =?us-ascii?Q?G1u3sDKKwiEfetrUDJdB7wgmvSy9FoApz9crYqQjEu/iuMKbf8noiFHlYp5i?=
 =?us-ascii?Q?Og1LpruvXgXEl4kwJTqoY4zeRMTBXKwzkM9cmW9OpUt7DSP5TW/XofhEvHmZ?=
 =?us-ascii?Q?/KmthPGA0S+CQo5Vk+hQ5hIY7bokl1zkvkA5tUlyxlpzDHix2Hjx+QQPPs68?=
 =?us-ascii?Q?kFfy+boBqBrQIrGOhQmoITvqFwQAxxyDJHsOir7olBmkq5fmqylrrkWUTIiW?=
 =?us-ascii?Q?VFEELgdWBR2vXSnMj58qdptXD2PwCJO/ii9VCRtRS6T01lBIs0ICstndlxtC?=
 =?us-ascii?Q?8Sx67w2MwCsIN+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYb/t56tag2fJwD6Ry8p47BFv+PDgJX7ShVRd05Hhr0OtJh6Do9ivd2g32Ux?=
 =?us-ascii?Q?6VUj+9fgmr+UOyV3oNPZ1ED9xUDnpzqh+vuxF2S2/I/hycUneLQcJcrYpi6x?=
 =?us-ascii?Q?wFyCGs2tCOPUyvWNwrFfYTNL3xyoMfg79eV9NDkiY7hY2nP4eXa1uIdhJKQD?=
 =?us-ascii?Q?BtbuSe8YAUUxhWbglXdTlH1qRTKLq6piuscb9+paYEQR98g0n1ISt/qPj5Un?=
 =?us-ascii?Q?Dm4PyOIrWtViVgkp8LZKKqPSkqc5ahjBdFfm9RqqFgBrz4hor9oU0wEZmZc7?=
 =?us-ascii?Q?vYCScI6pPgol4nYkdX2ToragQpaqiqjVX04uHD65SakX62Tieo5qcpBE37Be?=
 =?us-ascii?Q?5WYxrh78GrykBXtn77YWw59dEQB/Zy5pgT5QVJ0uS+iHirT+N4bCYmdMuzys?=
 =?us-ascii?Q?aqTn7cBpX6fIIxfQ9IZkWhByNPDMwg+l5HZsJEllxJj2uXOwgzA6Rjz7TiXZ?=
 =?us-ascii?Q?vMAYwEaj7E+OjrWSnIKevNQ25yy0d8ablMz84bCE+XKbGHOj5PjyKW2/leBb?=
 =?us-ascii?Q?/3r96K7B9yskjBC2b3PPIxGKgK5bNcCbOpnsdcJ48zicbqSaGQZ+5f8PqxVs?=
 =?us-ascii?Q?gyn0QFLm36eGJBIOquimLLpyUdp9EBfxNQntn/po2KwupFsJv5tUKI4qclBv?=
 =?us-ascii?Q?fM7hZqnVPQU0X5bHsnKy+MSOUZpu69nl2d51taVxtTGLLv3KS/UAb/g4auvc?=
 =?us-ascii?Q?ZaqcwPC9mHcJLIf6Er68f4i8sgoYgsZwCTN63O3LMWpPEMfj/xVORMJHm10K?=
 =?us-ascii?Q?MTnlpeahdpi2UmpE3fglFKCVKqrODWJbBl6VMjFcxzhzafwzhFTsGsck82tk?=
 =?us-ascii?Q?FG7fMGGNfwTdCERls9BkmDtr5/FKOkRCdC1pU83A8LPucflHA2xhD0hD40cw?=
 =?us-ascii?Q?DUqbIahGAz+yhdnupTcLghK5ranJUNcQdnBbjxCqPL8llDhMSxMEafWyMjKx?=
 =?us-ascii?Q?lCCihGv+Ai1OIwESKJgKex75AsFHszSJyGzLmsY8tjtm2gMrh7EOaqkdXfWG?=
 =?us-ascii?Q?x1l6kyviYlrvU42TxOb0BrjbvHFryCBCyimNnK9tGUkl9EsSXZ6iIQjkkWy2?=
 =?us-ascii?Q?ed9rCODLQduwrhx/GqtAYDXRSH23+sQ2l9bH/EOqu2Se1MEO1KbnKKq4ChMR?=
 =?us-ascii?Q?vTCK0cQ5FRA8Ebj3uM0z1dRg5/dLwIgt6cS4p068DGrYBCWucaTqMPvglSNa?=
 =?us-ascii?Q?+8SsPFRMHZM/ruoEwo+W46C2HfRuFSmO1ilFg5qMkJ/eyH1sN/6tFo4IWjgV?=
 =?us-ascii?Q?NBjK4YW71tFn/r6scv69lTTCfPleM01pimUwrhv11rOBzLGFUfq3UYfNS6VN?=
 =?us-ascii?Q?wmwtgHg9bQkq5w3MK8ql/vQoi3iKeeywHYZFvLjCu7WYa+EScKcD4KF1geHD?=
 =?us-ascii?Q?hF0FdySR6pE17tUNiOnWQnbvC637i+4QdlJ/vLBBb0ao3u0nXAcgAbTSzvqY?=
 =?us-ascii?Q?3/Oaqt/0SpkBgPAgUSlDgk77dWGbGmcdSrXeNvseZuFeeOkzjbHj2yR77mvU?=
 =?us-ascii?Q?q2NQz5regBDkCwkAbHcAbCRd1f2xezA3aaWGgCRQtfMduD1OEzh7wYFttjWh?=
 =?us-ascii?Q?B6ex16bfkakSlmGCbMaNWVGkuECv0gtUTRra9MPX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680c57a8-eb7b-4ed5-1685-08de06782ab6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 14:37:13.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2FVT3cfWddSEIHPxwjCBaxwjFQnv1oTfR1XFbfJOUT7/c7mydQlPSCRRSKc1qwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384

On Tue, Oct 07, 2025 at 01:11:46PM -0300, Jason Gunthorpe wrote:

> +/*
> + * Return the highest value such that:
> + *    ffz_t(u32, U32_MAX) == UNDEFINED
> + *    ffz_t(u32, 0) == 0
> + *    ffz_t(u32, 1) == 1
> + *    log_mod(a, ret) == log_to_max_int(ret)
> + * aka find first zero bit
> + */
> +static inline unsigned int ffz32(u32 a)
> +{
> +	return ffz(a);
> +}
> +static inline unsigned int ffz64(u64 a)
> +{
> +	if (sizeof(u64) == sizeof(unsigned long))
> +		return ffz32(a);

This should be ffz(a), it breaks everything like this. I must have
run the kunits out of sequence to have missed this.

I updated the github

Jason

