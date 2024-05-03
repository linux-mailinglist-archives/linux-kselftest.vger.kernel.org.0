Return-Path: <linux-kselftest+bounces-9307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BB8BA53C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9015A1C21009
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 02:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EC6F4E2;
	Fri,  3 May 2024 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KspJLjRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6F12E78;
	Fri,  3 May 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702643; cv=fail; b=U6iL2zuYjwDaedBNXRQ4j7ODcPkEQ4dfrIABGpa75JxwS16Nbe+NeDIqz9tUh4zH77LJ3XqyJH5GFSZZhAYroTxEe7PqiwEzlKaK4OmUyesi9EBLCJY/Bi+vtPZqxHIDF5IWptYyuWHqdIRKcwvI7oqqzrOWAPq9BVf9QhZFPco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702643; c=relaxed/simple;
	bh=GKQSQpSsQIbrFPMvq4wKgUVSariZ5F4nbSPtjfdxdu4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ubu7/RfpZCTJ8Xn2fbhl7G0AFoGkVD9Qnp6l/ZaqJFUp/LW8Sw9U4wOdZ2eWfvsNwUqFw2FMCbYf/Mj8u7Gkwx6hr4vwxyftfY6a/nCpSKSbL7Otks0v6/GueFyhYazx1XGeUwC3goSwOTxHubTo/rHh8OhKzsRPO1TewRH6VL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KspJLjRw; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb3G2RyDY4gfoi8mE+sNxM6M5uG7B1VRLggRmSjUUw0GFBUQtAiof9jvzNNe4aWLDzQPQkW9hc5++zNbOwCpYlYcozTHr1iISwnzJ9JDWbL+NTnoRJyuKMy0GFcBTfX5FWuesz3amiuQ4SP08BE71He495Vf7ORsAd0f+ilrIEm8MGWQT9KNtn2zCaZ+8Sx9+nDIIDP/nh9V3adJS/eweJBY+v+Q8y4r3MyWzd6J87Ca3YR2/L/WEGMfb7KaEimPtlZzTRnl14FO2SZ8SESJXEDwv6vRmcjAylnE1SNvDes48jV825T4ufctDPtFX6gicv2jy7gADw8L6FNXiQnkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz3JLq8t9dYTnRm7SrWcGnUsXa5CNjXpayypHgo3a58=;
 b=RMY8Lv3JI9OwdghXyXQsva5/zCz7ogT2OoBGzP32V3shTbz6cN1Xmrim3PkkU5k03kyeSWqPx+vxZLEJU6eAMXxZpqPc1hyUxPWWHvFYhd0O1u135yE3pYq5Otx+AcmrxIvrJsoyFwLQshxBNiFnZbJhq2QOiELrIbfG21EbV1DW2ozKLs+7H2ae8m+eYg+R+l9VceaopnJuMoxz6oR1Saw6KIgmQQfEO3zvZk3Ivn6C7+T9LZQU/1awNnENtXriPLo58O/ZeHN6WkRcbavUkq2Z0YRetp46vJHY9mCpJZsA1vQ+08aKNYBs3AGc8wk3UPciDCCCZfRN0V8VkmDlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz3JLq8t9dYTnRm7SrWcGnUsXa5CNjXpayypHgo3a58=;
 b=KspJLjRwPPXHiw3t4ciQPGtmzqwhYyCLTORIOXiMmdvQ/g9p3n0SheVMS1PVhuqdrdZ0uACID85DaLsOqQlW1sVWuJh5HetZx+cyP2s8J0yvhxFXwP6c8X0GEV5wsBANs7S18aoEdgbMpF8eu0fQ7QmDLZjWcj8M605An5ldS1rtKcCNWeVCuip/+NFDS8Wj11ANyAK/UTMHO3PDuwt/oA++eOTH7zfOg4KaMK1RrZIMJExGmDIAVAn8xORUkv+4ovEzh8DTa/KGx+TPVTc9NSNPIsnsBZGgG6DjYHNQiPoL6GBHrs+HIzzRwybSAqk9HyfGMUaqslMsA7aMJee6xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Fri, 3 May
 2024 02:17:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 02:17:14 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] selftests/resctrl: fix clang build failure: use LOCAL_HDRS
Date: Thu,  2 May 2024 19:17:12 -0700
Message-ID: <20240503021712.78601-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6155da-4ae5-4fb1-6361-08dc6b17261b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVNtbUFtcmlpeVIyS3VZY2RnZU5pSC9EMjhBZmFodlI3TjlTREZTOGpoUEt6?=
 =?utf-8?B?WjBocmIyQzcrNGVKYkRVOC9GbVVOT3Y4cjBRYTU4WTFNelZ6MDdKcTVHaGZD?=
 =?utf-8?B?a2p4R3ZNWU1ES1VaUkxuSUJiL3had0huWGtmMGwvZDJOcVZpNXpwRkx6V2pQ?=
 =?utf-8?B?b25RMERMSExXSVlieGtoRjRFT1V0TUFnU2ZhbmNlcVRUQXVxR3Fyd1dMTDFp?=
 =?utf-8?B?eG1TY2dZSTc4YVFHR1Y3akJud1p0MmRKMWtUQnhiN3RYdStBVmU1WEMrRWlV?=
 =?utf-8?B?UlM1TG9UQ2I0RU5WU3dMSkhFa1BIeXk1N3oxRVhJYmRoM1Fmdi9VUnFBQksx?=
 =?utf-8?B?a2kzOWtVTlYvY2ZKbG1Kd00xelZibnAzZWhEampYbnZET0N2eFBkYXpWbjhV?=
 =?utf-8?B?VTQ1Zi9WL3JpYzJpWkw4UktKMHF2c3NwRFBMT0ROWGpiaml0R1VKTFJMSHpz?=
 =?utf-8?B?UTNuNjlzYWF0VjVaRDkyR3ZNWm1MQUc4RktxMDV0QXg2eU1LbGFpYmNJNENP?=
 =?utf-8?B?dWNIUEpLN0lXRHh0WEV6Z0h5NnEwVCt2U1IyZTVwU0h2WEMrcWJSckZ4WHhW?=
 =?utf-8?B?QzlTNEVlSmRiZ0lwV0p0M0hqRm1sblJMTnAxb1ArNStSWjUrU0lHK3lPMjRa?=
 =?utf-8?B?b2dYM1RCZXlRdDVtNlZOdFFaNWsxVk9VQ3hCblF1MS9uR0IvKzJkSWdsQ3JF?=
 =?utf-8?B?aGdUaWhMZXR5cS9wSThkTkNKM3JpdUc3cWtuNUZuOUwzNG1qWmdmTlNwNkJI?=
 =?utf-8?B?VytIRmxYNFNYUUtiUmY5Tk11NWduWEJiNHpiMWREbk83SHFHK0c1YjJiUkp4?=
 =?utf-8?B?VzJtVzhaN01MMlNBb0kxbVBrYSttNWE4c3RjaGtZTURNVy9LZFJ0aWRRWXdJ?=
 =?utf-8?B?U2s1bUFBa1dmVi9VU0JKNVpDM2JYOWtrV1M5eHpTN0hGZVc2YTZtNzFsbTdv?=
 =?utf-8?B?SEdiVGxyL0VPV1VvTzhmRi9UcVF2b01KNHZNVkUwYjBvOHlsbkpKbE8reXF3?=
 =?utf-8?B?d1E1OWdrMUg5QVJVd24yRTNwT1VQcXIxSkxMNmZ6bkYza2s1NVJUa09iL3RM?=
 =?utf-8?B?Z2lMaFV1TU93bStZRjR3T2czSGRBVGE3Y25tUFU0WCtUNjY0dW5RUFlwSVZj?=
 =?utf-8?B?dTRHT0ZGaEx3SkNCMnV6TlI5enAvS2xGaGxvcjlmSHVlK3pyLzNqTm5uamVq?=
 =?utf-8?B?SnZQeU5TUTJRdzZ5dHRNbWtiTGUwR1dkUENCZlg4NS94bTVRaTJ2SVVoaFcw?=
 =?utf-8?B?aFdYWGIzTUtFWms0Vy93VjVYU2trWk81RCtQdURKdDc1WXZqN2JjMnVSUmFF?=
 =?utf-8?B?dEd2eXRURzV4cDNxZytKU0kyTkJXT3ZhMjY3M0J1WWk2Y3BhR0tBTzkwQmNT?=
 =?utf-8?B?clpBQUNIeWpteUNsaHJRVEJjeVlkRHU0eWZyaG9OZlNxMDZVVXNFbnYrc3Ex?=
 =?utf-8?B?QTUwSDByK3pLKzVvZU4rRHdiUU5xMXpielk0ZUFmTnFrS2tiRk15OVdPYkRF?=
 =?utf-8?B?YWk0N3pnZFZHdmhTWndqeG4rT3ZCdThrSEk5QlJ2WGt6allYTGhETTN1WEVr?=
 =?utf-8?B?NTV6MHdseVNXWWttWVd4TElORXNHNHBORUNmOW5TU3NTNC9DbktnL252bDZS?=
 =?utf-8?B?dzZKTnRucnI1RGZhbllVNEdZb0FkK1R5Y09paDhOZzdiRFdINnN6M3N1NEow?=
 =?utf-8?B?Q09UK3FCU2NxSGtlYmFxYWhmVk5Id093VnRVbVpLRExVYm9KczZuNmxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VndPVmRuSG43YjNiRDEzU2x2YkZ5Mm5HSTlyUkIzNTBtQXB1cGZYNzhSbmZ2?=
 =?utf-8?B?UkFKYTVpcWdSOWNqOGV6M1NwcnFLT0ZmdHpyVGtTZ0luWUlsNERpaGZMdXZj?=
 =?utf-8?B?OUhSNGN2MTVwNHZ6aXFNdWQ2TTMwUVhIWGRjYnlRSG1YVEdRaSs2MnNIYWtL?=
 =?utf-8?B?d1VuQXkzRmR0SmNZUklwT21DSm96TUExYkVDTHZTMU9sc3dvYXozdUtVSHA3?=
 =?utf-8?B?VGRuR1pYU3p4VDhMbDVFOHM5L3M1VTcwYzM0UlZtL0RQc0MzU0UrbHFDMGRl?=
 =?utf-8?B?U2p2eVF3Wlc0S2U5bXlmcFJKS3Z6K2lFQzN6SS93OW84WDJ3YXo2WjdXd096?=
 =?utf-8?B?NnV4c1MzRDZYQTlKMzllekYwQkRXenUxVk1vMUZHNzhwMVY0a2thMmFZeGZu?=
 =?utf-8?B?L2ZKOWs4MmViSE5EUVVneCt3UkxneXFXRjF6U3VUUDFQRFJhTmtuTG5uaFVz?=
 =?utf-8?B?ZXZxSFZQb0Z1RUVnS1ByWTVUQVgzVVlzcVJMRTI3ZTdwdWRTLzFqbXhFbHU4?=
 =?utf-8?B?aUxjVlNrc2d1dU1Lc29pbzdlY2xYWGtSSzRXekRqeFJ3ZnJ2anVUbmhsZDNr?=
 =?utf-8?B?MmJBVVBsMzN6UXR1eXJMNDN1K0M5NGF1UjBYM1FKUWFUUGhtQ2FjUG1nZG1l?=
 =?utf-8?B?OXdLV3ExdEhGWGdVVi9obExKK1ZzK3ZtS0l0MjU2MWpIOEtxN2s3VEJvUXBl?=
 =?utf-8?B?c280bEt5UVZWeE1CSzhMQm9UQTFHL28wa3VITlZ5bWZEM0xtaU5NYzNGUElW?=
 =?utf-8?B?L2Vxd2VCVzB2QkYwa0FhdTF2NFFMRnMxdGZEdUhUVVAzT2xwelV6QzFxcExH?=
 =?utf-8?B?c1gwQlRBcFUxcHpDcjNwL3o1SlcwUEZXL0gxa2lIaE9HcGNQKzFBOWV4cGlW?=
 =?utf-8?B?MFlBMFZoRE9QOWlDTVpXbUVzbzBzbWJYam1PeklvZWNZNWdyYS9TSVMvUm1W?=
 =?utf-8?B?RVA2NDRQakordmovMFowWC82SVNNbjJKWmxwQjBRd0tzMjB3b2pEek1oYnJG?=
 =?utf-8?B?anliS2ZScDdxSWJBajhra3JEc0phWDdMaldrVVUvOXE5MDZTbi95aWhnTUcz?=
 =?utf-8?B?NFpXbmc5emdoZW41WXZ1OWNRb2hqcnY5Tk9Pb1BGUUxJMy9oMU45VzA5Nkhw?=
 =?utf-8?B?M2NSUCsycGNQNTR2WkNCbFFQcExFZHFlK3hKaHRIa3Byd1hrcWwydlNLMXh4?=
 =?utf-8?B?d25sNEdiYk5sNGJtT05tdC9TcVplYjA5amhWSUJjRno1bU84Tmk4WktXK2VU?=
 =?utf-8?B?aUxZclFhWFlGYnp4WGlzSk1LUlg0dW44MXZwUFNjR3hLVW5yeGFjZWJDdjNi?=
 =?utf-8?B?L05nK2htOGptbXRjUDZJT2tNOTQ5dEZRMmRVZ2p0V2tIb1ZUQTBZSXlZSzhk?=
 =?utf-8?B?RUg3Q1FXUWs3dGdRdkRieVdYMTlVSktFaEk1ZEl0RWxUaGFXZEt6dzZhbkgr?=
 =?utf-8?B?NDJQdTFEd0hMUlJqRmRuT21yL1JURllBdXIvMWhBY2IwazMzNDIrUkU1RzFX?=
 =?utf-8?B?Sm13QUI4SUdVQTdpRFFXVkVJZDN0cndIVlJydTBRNjZPNCtsb3FpaGtwN2d3?=
 =?utf-8?B?QUFWRDBmbUJWN0ozRndtQXdGSmxRdjZZOWpiSldWV1lUb2tQWGZManlNK09U?=
 =?utf-8?B?dEpLOUJIS0IxVzF0WmVuUVB4SXRoSnVPL09qSDdWRVZuVWp1K0VLMWpHRFRw?=
 =?utf-8?B?M2ExbWoycS9XcTNxSWtKRWZkYk1YMlhCWng4dEdJOXRDY2ozeWd3OCtMejI5?=
 =?utf-8?B?VmxpQ2RlMFNBWVRtcnZENG5adGlUd21SVEdQSFgyWWhXSEV4QVkraXNHNWhz?=
 =?utf-8?B?YklPVUVtREJQYlA5Zk5URnN1Z25BY1U3WGpYZE93QXJLRmdkR0QxbElqalJw?=
 =?utf-8?B?WFRkeE5wZ05hT1JXUG5MYXUrWWpNUEVFaytZTlBncjVSdWh3ZUJxYmFXL3ZO?=
 =?utf-8?B?VnVTaGZhZVZ0NFVCWGVkWmRZWldhUFFiMUdSa2Q0dExnaDBmVU42bGdsdW16?=
 =?utf-8?B?R2h5aFd5bzFhNGJuUE8xMDc4YnBkcmxySFBnbklIYjQrN0kzeHJxTi9zL2tr?=
 =?utf-8?B?ckZJL2VDV3dVRjJMQ0tXZ2VUWFJMcVE5bVlreDZMSlZxN1YxZWx3KzFGVm1n?=
 =?utf-8?Q?GQgX3mLj/h5JNXfJ6VMvV8XSj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6155da-4ae5-4fb1-6361-08dc6b17261b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 02:17:14.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZJ6ZyNF4XnfV1Ppgg6F25nPm1jAizC4PIThigT3QwSvULbHcwk13Sm7wKngG+DemHFfGAv471fiQ18EaFm07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the following error occurs:

   clang: error: cannot specify -o when generating multiple output files

This is because clang, unlike gcc, won't accept invocations of this
form:

    clang file1.c header2.h

Fix this by using selftests/lib.mk facilities for tracking local header
file dependencies: add them to LOCAL_HDRS, leaving only the .c files to
be passed to the compiler.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Fixes: 8e289f454289 ("selftests/resctrl: Add resctrl.h into build deps")
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/resctrl/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 2deac2031de9..021863f86053 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -5,6 +5,8 @@ CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
 
+LOCAL_HDRS += $(wildcard *.h)
+
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.[ch])
+$(OUTPUT)/resctrl_tests: $(wildcard *.c)

base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


