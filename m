Return-Path: <linux-kselftest+bounces-30731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF22A88756
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 17:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262F7189F180
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A940274FF1;
	Mon, 14 Apr 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKR+RszO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9B2DFA3B;
	Mon, 14 Apr 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644346; cv=fail; b=cAju+hu3rjNMbZPp54l7yXrAceymAl7s0H5Nz3sZIKtNhV20khiFqeKnoYo/GPyKxDcHHkExP024CHUM2kX+fWaFHm9MMVW1APSc736c2JsOOVVQ2OuJuA/H2I5o2lgtJ4AfsB9qDu1E6TylVfO7azhkPVQo2etTMouUqQVp4LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644346; c=relaxed/simple;
	bh=MZ2Lu3sVZ3RBeGRlYvrnKwR3Ow8Y3MSvQYMAoJCIWaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vj5V4WjpjMWCtZtp9SkXcbIcIqO8WzjYAbFBK34KtHjpjLmmT8I1Yaxg5nwK1JE633snfjag/pCPgFdl0a0UzE9MMicdguVpg3RLMYkpNwQ+ULB+LEAVl+vn2wTXYIRo7ifCR6cKcdsQOGm5zS7QyL/yxTz4iPXjvgU3SkkD9tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKR+RszO; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMA4rLmZ0sFtKr24P+WkRY5EybDYAZSpEcnfxneyf4YXOqN0m+VSvzChBu6BLBIQOrykeHp6L5TdpSNFK2UJu6JUIeouOj29oevdEP70vXg+ecSno5QPurwVC+D3ogwYyq4sild7+pUwe+QOTyFb4dQ7go6Md71W+uvKF6hmoscx3K4O3Xn1sV3ytamK1gBfyQN/xEqRqsPiDMUZ+TYnR8hXFAuI/14mdspacKS9A0M2KbUJlZZGca5V5qdntFwaBk4YA3KkS972q0AC2HmNX9UxJ+c81OUxWlCTPD3E6T24RiOX09YGrgfrr40LO/Wst3oSulRy96thBM4Adh+11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ2Lu3sVZ3RBeGRlYvrnKwR3Ow8Y3MSvQYMAoJCIWaQ=;
 b=Ab7z0wRrRP8brxbZQy4kWlfuJUxEdOAhhTjT+OWXoYzkgYnsU/tcHcLfhQrqbkYkm0vXmglkPDxPWIn5mLT0geqE9FZCPVYMAaAzT0a16Y/FRJiSdLM2Th72wRZKR9jYGKwDLK5D6w8yTSNl112cD9GdWtHl3pTZvMZ9SAfm9ZV/3uUotS+W8zOpoKBWp3WS42KeffdkelNx5J6uGDf2siLUIw5PVlQiG4QZU0da8lAQCi87R1LP5s82Kw8QV+2n1kC91V08nofnVWDXyZTfJaKBFC3qOj+ER0sgXVwyr5ftQ7plAr2F/8gZutkxQH0htWi/KDqulQTXDtdQE23yYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ2Lu3sVZ3RBeGRlYvrnKwR3Ow8Y3MSvQYMAoJCIWaQ=;
 b=mKR+RszO9j91HsAWgIK0dB7hx4xVitwHIkS7qejr5+9kNCBfOSytwaHl3fN8YwIKfZD1JCG+6CvWbh0sOxjGkyTVhwrtdObOOTya6hemH+glGNgMTY+a/GOlONQUgTIfO7iVSa/Bqyufa+7rwJJmuDpQ8XVrPbdYmeI5WQTDGiVobRUQ7Pruq2WU7jBrOD4S0/g94Y5+s4MG4Cp0HETMSzNPowGtKEAcRC8tHITEQ49ywAOtA2In0EKW70EyH0jlqyHnpshS/4/3cXazMd2yGbxGOXeXcxVXXkugEeM5Elz7TJJ5HnANSW+toOFcxZRLyD2eJqQuN8bdhdeHokNpgQ==
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:25:41 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 15:25:40 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	"corbet@lwn.net" <corbet@lwn.net>, Will Deacon <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 03/16] iommu: Add iommu_copy_struct_to_user helper
Thread-Topic: [PATCH v1 03/16] iommu: Add iommu_copy_struct_to_user helper
Thread-Index: AQHbqqxycY3zsiQC70qs19S+0CsyIbOjTY+A
Date: Mon, 14 Apr 2025 15:25:40 +0000
Message-ID: <86881827-8E2D-461C-BDA3-FA8FD14C343C@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
In-Reply-To:
 <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8897:EE_|LV8PR12MB9450:EE_
x-ms-office365-filtering-correlation-id: ae5d3336-aa03-4cdc-ad0c-08dd7b689d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFRsY3JaUXpidVlTZ0ZxQmFSY1pFTnRnUUlQc2NpMHpOSjc4TGpZWXMxWjdY?=
 =?utf-8?B?YkpKcGZCQ3BJWGJPRnlUZ2d5b2FHbUYxdmpodC9PRyt1aGRoMkg2cTJZOER5?=
 =?utf-8?B?TE5ORi9XelVpUjY4TGhseUxROXdMbzhES1k4Y0c1NnIrUUlhZXFzWXB1N2dS?=
 =?utf-8?B?Z2tRaWwrN2t2YnprTmN4ZkFocS83aHMyYzU0eW1PQnNOcjZTRGhBYnBxNjBE?=
 =?utf-8?B?YWVRRGJIVjBLdFNNNWRhVG5rNlRqOGUyNWo4Q2plQWNxaDdWL24yN3JFLzNS?=
 =?utf-8?B?Tk41dlhTeEU4bk5lK0RrSkQ3Z1I0MklORWhPQVBTeFZJSjhESzhuNk93bEUx?=
 =?utf-8?B?WERXZWFsUTZ0UFpNV0loNzF3dDBaalB4cS9ybkZTdjRjT2sram9RaDdjREZi?=
 =?utf-8?B?dnZxOU9BWjhlemhJTzh5VHVtQTRqSzNObDBzV1ExbFhFTFFRcGpXL1pYUWM3?=
 =?utf-8?B?SFhyckhMWWxVc3dGQ0oyWlFjNjJndlBycVVvb2ZzV2RXMUp6dFVxRGlwY0RG?=
 =?utf-8?B?RVlTNDU2OEpKajV3ZUU0Qm1Dc2VQcHRDeUsxUDc5cmdDRjNpKzhHa1lPbjJN?=
 =?utf-8?B?M1hjYlJpQjIvcU9Rd3YvUCtqUks1ejJ0eXRGR1QwL0srejNRZHFUcjNCK1Zw?=
 =?utf-8?B?d3R2dWM1cmdFYndub0VuNDA3U3BiVFBuODYrZ3Z0ZVNOYXlhUG1GZWVMOTlL?=
 =?utf-8?B?WWlSMHVNWXp2SjFFc0VOcWx6TmJ2c0N4azhveUhMcmpxWmhHd3dFUittQm1w?=
 =?utf-8?B?djhsWVkxZlo4OFBDK09UMWNGWVdBVVB5cktXek90clZoTG5Vd3JGd1pGRnBY?=
 =?utf-8?B?cWJDZUNwLzRKMi9zM1IxRDVMSHJQZzBvM3BOSGY1cHlnS20xRlpIemdGWjBD?=
 =?utf-8?B?SG53Zmw4V3k1dExPR3l0aVpmWW1HMXByU3pSUng5N2NFZEt3WUpIMEtSc2Y1?=
 =?utf-8?B?L2NEWVpjZC9oWWplNGJwN29BZzJBaWV4cVUyY3hnY1RicDVwTTBqMGVoMVcy?=
 =?utf-8?B?STRVeGhZR05XZW12YUc3dWEzK2RmMWM1UVlGaVFwTlNaRFVqRThVdkZFcDZY?=
 =?utf-8?B?cGp3b2U4eUNaRjB4UFhVeUxDcFFmaVZzZFUyTTZnSzVvcUY2bzh4bE01NWI3?=
 =?utf-8?B?NmRUa2M2Zytrb1NKRzhtK0xybUl6N0VNTDB4eGZtTTB4UW1ZZ1ZnN3hQT0hX?=
 =?utf-8?B?MW9jSlJ3dFZjbTNtcUxyYWVEREFvYmExbEprbW5PRUdod2hzanprSzkwNlZo?=
 =?utf-8?B?NUg4QmViVFdUM3FrTGdaeVJZemVpcFVZVXM5b045dWlYZEVWNUp6WEd4eWFS?=
 =?utf-8?B?UFZWNTdXdkZqUHFGaTFoZHRxQ0Q0V2w1NmRyM0Vxc2JxNlZiNExja2d6Z2Fs?=
 =?utf-8?B?azF3M0xPc3NYTmJBaGZWR2Q0aG41ajMzYXZwalNyNEUwUUNwRXlRNHJrNkEv?=
 =?utf-8?B?Sjk4ZzJZRnhJbmVhTldWNktNSG9rY2xnSWJQMzdpbzlvS28xK0IwdWtxazNw?=
 =?utf-8?B?aE14cXdxNFBWMEVReER3ZHhxV3F5TCtETFNVbVJGRWRrZUtudTdmeFBLVDdH?=
 =?utf-8?B?UHRBRFp4ZEFVWC9oV20raWRoUFhWcWJKRUx4NWIzcnVBazJJYUhCK1g4ajBI?=
 =?utf-8?B?YUMwYXJJZUY1V0FWb0ttKzRJUXVvK2dFcGNaankzVmYzZG0zSXBKdnJZNGlB?=
 =?utf-8?B?WFdiSFBvRjlrQzVxazVoemRUa1JuNm1SRkdWT29vVllZQ3FUY0xLY0RDRWRQ?=
 =?utf-8?B?Q3ZFNjNVeFhocElGR0VLb3hYNTU1Szg1TFA4ZFBzcE92bzR4U1dPc0JOVDlH?=
 =?utf-8?B?b2tqU1o1SVZrZDN6VDV4OFdtRE5BOGRCS2E1WDh6MEIranlzbFNaRVlWdmwz?=
 =?utf-8?B?VG1vYjBEUHZhcFZSMFdQTFU2bEloS2ZYM2tYV2JNZ2NpL0RQYXNjWmp0dVhG?=
 =?utf-8?B?ek1YR3RNcUhzK2NxTm4zd3ZuSTNySCt3VDRsQ1NibzA2ZXBKdlk2eHBlQlJM?=
 =?utf-8?B?bmQ3cERTZ29nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8897.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjdZVFJYeDJEU1B0eGJnWDd1V3ZLbnhWR0hlM0FtWEVVcEI2emU5SlAvWExj?=
 =?utf-8?B?UGY4MVlYNjFiWHg1R0hxRFVvaUgxVTVqcmFBYXhNWnR6VUpGbTNFdVRadHA1?=
 =?utf-8?B?V2NTczIzZjBiYm9hNlM4QUtFNDBEMy9temJyR0tXdEZkbDVuRC9LSnNORmg5?=
 =?utf-8?B?Q2g4cmdNY1ZYUXRqNFh4Y1FIcDhVYk5PM1lsaUhxYXRVOEFXWE1hNG00cTRt?=
 =?utf-8?B?OTNzL3JEM2E2dTd3Rm56Z3JQRlI5cEhUUlFxYWFBS1RRVjZHTWZETEUwcHlS?=
 =?utf-8?B?NFY3R1hieTl2T3k2UzdFODZIZlZPK3VFb2pFdFlBemI5NDBQR3BJRm5mQmxw?=
 =?utf-8?B?ODJHU1lLb2dhb2plWVlhQkc4WXVtbFdwSUt3ZlV1Nm9OZTRGL3NoZkdFaFhj?=
 =?utf-8?B?MDFzL0xPVUJOSmtjOGV0ZlFWeFlFeUp3dUs3NTJBWnJEajhONXdXZHlHc0Vt?=
 =?utf-8?B?bFc1VWtOZ01jQlhmZndUMisrOTl0bERoclpBS0ZNOEp4NGFYbHdaU2hvNE1l?=
 =?utf-8?B?bEdTaEtCNVh5bFV2U1FoLzB6QnJ3SVFUM05ZZ1U1bHBtenBkd2NvdjR6ckt2?=
 =?utf-8?B?Uy9nS3A3Mm5nb0RyTGtYRWp0cDFyd2I2NVRsM1lMSVIxV0RseHNQNXVlaTVu?=
 =?utf-8?B?Zk1DVmYvd0p2VWxOekdGSVFKejBBN0NhNmtkUGk3TGVOTGVTMDJjZTBob0lP?=
 =?utf-8?B?KzEvYWprRHhTMDFHK2NHeDdqTTU0dDBJQUswS3pJbmo3REsxS2x5RkY4c3ow?=
 =?utf-8?B?RjVFK0VKUXkrcmJKNk1qNVpUMnRTKytqZTBNdzA1MmNwZlFjZ2picWw2RGRB?=
 =?utf-8?B?ZFd3U3FKWmFzc0lScy9XQzhQRXBoWXdUMy9EN0RLaVRnb25PY2tXSXlZNVlX?=
 =?utf-8?B?M0ZEYytEeXQ5NDVRSHZjT0w4cTd2bmxWNXluQW15ODltTmQzdGRES25Fc1hm?=
 =?utf-8?B?NXpVbWRyVjJCYkpXZzlyMU1NVHZqOC80b0E0Yzc0dnlmMEdrUFJNM09RQ1pJ?=
 =?utf-8?B?LytsNTBkWUNBK2xFU0VicjBJdUdzNGQyUlZxQUFxSGhOQStsbHI0WUVMM3pM?=
 =?utf-8?B?RjlUNVhrd3hiNHBBMndBYVRjNHdCNFBDVG5iWFhVVVNDcjJUdGpPTjNnVVh2?=
 =?utf-8?B?N2RDQW9RTE5aREJWWG45V2FMRXJ2clRqd2RCbjFFdzBBa0tkQ3NXVlhaa2VL?=
 =?utf-8?B?dUhMemphaGViaEFsV2pGbUhVSVBMS2NodFRuN1VHZzFuQjRvMUdBT1VKVU96?=
 =?utf-8?B?RU1BMGFUWUk2NUJlZzlXRnU4ZmF6Q2czaVlybXFUZTlGTDBtWE01aEtMMGJk?=
 =?utf-8?B?QmxKcnRvaWs4c0FSMXZmbTNtSTdBbHBJR3V5U1VqS0JibGt4K3JLZ2xQNTdZ?=
 =?utf-8?B?cTVCSHNKSnNDak14cU1FT1JucWdQUU5hMUhOekVFRXE2SUNCTTEzc1dWY0Zx?=
 =?utf-8?B?N1JMZjNkb1JYV0d4UzY4RldPZjNHRVA4Yks0ejN6N1dKR2NkcGcxci9maUJT?=
 =?utf-8?B?SE9KaFJKRFpmMjJWRXlxSlpmK3FqdmtBNzJLVm9mTStSQ3dGQWJYQzR5NWFq?=
 =?utf-8?B?VFZVME5FQWdqVFpIYTBZTHlPOUVoaG1BQjk3YmNXM0lPR3FjN0tRV0hQQ2F2?=
 =?utf-8?B?Uy8xZ2l3QUhHQjk1dUNPL1BMempWVTI4UVVCYlJlL0ZRQlAwbUFxazhheGpJ?=
 =?utf-8?B?Sk9iZDlJWEo0QUs1T3RBZkptV0VFWmlrOFRPa3dWU3hQZ3RtejIvSjFkQVJk?=
 =?utf-8?B?TDhWVmN5ZDJIem44UXVNYlF5aGZRWGtYT3owMlAyTDZzOGxEYkk1TmNUb3hS?=
 =?utf-8?B?RVJzbEIvL2plY1lnbEp4MUU0TzE0VzM4SUwvSlVzdThDOEtHM0hndU5peUZQ?=
 =?utf-8?B?ZjZUc3o0cjZXcVRVMXhJK25hb0FaY3VYa0VvNWwvdlpKT2lyUDdONnBnTlZG?=
 =?utf-8?B?RnlFMlRHbnVjVjUvM1M1eTh2M2VtdnF3WDV6SW1icFhZSFhjSzhvZm1wSHN1?=
 =?utf-8?B?OUtvTGtFbVY1Z3RJbUhOSkVkR3Q2NHIzNVQwS0dNdGd4QUd0b1V3dzB6MkNY?=
 =?utf-8?B?R1lzQ2NpR2ZXUGdETW5oNnhibnpNZGl5dlo3WExFcmlmREQ5SXBIb2FFOFpr?=
 =?utf-8?Q?wHHEts+dUWop6r+9QOJqZNLX3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B96BC78D1A4DA4CBB02157AA0AEB438@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5d3336-aa03-4cdc-ad0c-08dd7b689d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 15:25:40.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYejHqIuvgbha7orDV8orosavfpaaLZ3n4dP5Xov8LPcTBtfGI2kV22AhppQWdqekBaxQ/OwF4X4I7YDHScVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

PiBPbiBBcHIgMTEsIDIwMjUsIGF0IDE6MzfigK9BTSwgTmljb2xpbiBDaGVuIDxuaWNvbGluY0Bu
dmlkaWEuY29tPiB3cm90ZToNCj4gK19faW9tbXVfY29weV9zdHJ1Y3RfdG9fdXNlcihjb25zdCBz
dHJ1Y3QgaW9tbXVfdXNlcl9kYXRhICpkc3RfZGF0YSwNCj4gKyAgICB2b2lkICpzcmNfZGF0YSwg
dW5zaWduZWQgaW50IGRhdGFfdHlwZSwNCj4gKyAgICBzaXplX3QgZGF0YV9sZW4sIHNpemVfdCBt
aW5fbGVuKQ0KPiArew0KPiArIGlmIChkc3RfZGF0YS0+dHlwZSAhPSBkYXRhX3R5cGUpDQo+ICsg
cmV0dXJuIC1FSU5WQUw7DQo+ICsgaWYgKFdBUk5fT04oIWRzdF9kYXRhIHx8ICFzcmNfZGF0YSkp
DQo+ICsgcmV0dXJuIC1FSU5WQUw7DQoNClRoZSBOVUxMIHBvaW50ZXIgY2hlY2sgc2hvdWxkIGJl
IGZpcnN0Lg0KDQoNCi1tYXR0DQoNCg==

