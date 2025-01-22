Return-Path: <linux-kselftest+bounces-24946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B387CA194D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 16:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9692C18859A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B17F14B08C;
	Wed, 22 Jan 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QDP3Ynsv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16761487E9;
	Wed, 22 Jan 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558988; cv=fail; b=pso//18buoRq3A2V3XL1eyN/ipKa1JMEPVxz7f9V5YtXkbzxSkezhRBy45UfxRmIPHwrJisKcUVZeer3GV6Ow2KVPDsiNJgsogm9m8fvBCR67HWHli2oY1pmp+aBOLTW7AX3a88n/EluaiLZB45o6xa2hNC3AClywnmfSV21nuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558988; c=relaxed/simple;
	bh=uQ0dy7uw0leQOhR28wgp4Yuk0dJjuGR18ZptxcCpeYY=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=jWuHYttI/Gkd3QPnfcGxMC7q85iiVK0ktm7XA9fDMHhIC/f/1VKtnXr26QGONH0lCRSL/DIyCH5z8ZWsHTXXzUUWGThn8k+H1xhwgGtbs+SO59GBL656h+eRbvC+N2YuqrEcIQrVwgkuP5lX+9pFAsYAu1aPTyfXw4S/OVTSCyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QDP3Ynsv; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOIrrgo8m8Xq7JBsnS4kS2P0WdgmYYguKuxeERN5h0gXyY23PjBvDHbzoJ1dW3DthrWqKZYPJkmgXP/sOl42GBhHqIAWEnE5oK1zwEbSKPMMdcgD6WxP41g5HdSpEi3POiohQlgH8fWyBfOcyOcPLaosHmpgE3ys7CTRQRSHPKypfhQXNuGXjGF+VGl4pTtkqWAPOP1hZ9XJb5t42Zray1o6qAc2I8JWTFyyQYJzem2SaZvg+ri3UtBky5ZHnQuJVx6IPUHgmy4R92YaQzlRp7Mb6yFTanXuCS6wtuS6kPzS2cTmBKoiB8yzrNRMCYxH+81d1NIy18snD1yqgZfHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ0dy7uw0leQOhR28wgp4Yuk0dJjuGR18ZptxcCpeYY=;
 b=Xeeg+9UXthrdjVotVIYJfvE1Ynslxx0fLsNovsGQYwTgKpFukwkMBtC5j1vyHNyXPbtaTlwifW5A7SYpD2IPj9GbSGjxp6fx9hdqAJelmEBCpdFwX+hTBKyRgZInnplJi94M1o59vks0azozt4BxT3/q3XLMmuDkhgedeOYb4QkA10oZ1rCqO4dJkJi9OnbWJz1suLA0Y/9Z0myBpOLf8jKcYzZGIcs+Dye9okN7HJ4cfxB6irBTv7xbGxFCBXbl0qu1ETAxUMohRY8OKDUKCoJGORb0qcLJj0e2fmdI5UaOgw/C7NUIdk3TGbQOT0ZRHFcMzkaeA0yWVk2TvOgfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ0dy7uw0leQOhR28wgp4Yuk0dJjuGR18ZptxcCpeYY=;
 b=QDP3YnsvMxZYRsJ/qIjZBgCAbhcrwOD9tj5N/zrOKCHjeduuDelXdko//m5iGk+XM8bpmwY8dahfZG0jIvB9q1VSfd8ViCJmR/TCSy0ixU7JOAD+irwEq9E/Tsire3Vzn4ruuY3/GV0ZO31aiUVA7i9iRI2EUmOnNndCigF+qIuIU02IkSUuXcHFjUbUVeHfOKf5GNTryQqQ57ZgQWuA12NgUgE5IQ3EdKzocGG3IQesBxisQNuVmAH7ZNAVy6zXDMSfm3wcin1n1utKwuUpnDJ5UmT8wBZXLyiQi0ANiSd4YQqLZzdGZSneHlVfmWzMgV7rY8h9tJm4O9em/ozYwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 15:16:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 15:16:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jan 2025 10:16:20 -0500
Message-Id: <D78P942WWF1O.IKY64R8JAIJG@nvidia.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Hugh Dickins" <hughd@google.com>, "Yang Shi"
 <yang@os.amperecomputing.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Kefeng
 Wang" <wangkefeng.wang@huawei.com>, "Yu Zhao" <yuzhao@google.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "David Hildenbrand" <david@redhat.com>, <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 1/3] selftests/mm: make file-backed THP split work by
 setting force option
X-Mailer: aerc 0.19.0
References: <20250122124047.1216024-1-ziy@nvidia.com>
 <04002289-c78f-4e1d-b242-144dd53a62f8@redhat.com>
In-Reply-To: <04002289-c78f-4e1d-b242-144dd53a62f8@redhat.com>
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d0890d-3b51-4b1f-44f1-08dd3af7bad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUx2ak5aang0K2orQk1SVlFUTDZ1bzc5T21CYnd4Z1VQVzhWOHRNTTh6K2o2?=
 =?utf-8?B?UnpRS0FkV25JcHNhY1kySmQ3bllDdldKb0t5RkFMaGlkd01SeTJueGVsTk4w?=
 =?utf-8?B?OVZDWUVGTUtnMTJpL01DQjhGWW1CUnlZK1F4QmhoNWRSVWVSTFowV3ErWHRP?=
 =?utf-8?B?NklqZXRFSFBjN3RsMUNIc0R3ZUtGS1FTSkNPZ2Y1MktGNlJTeDB1NUt5ZmdE?=
 =?utf-8?B?SGN1RWtWcDJxRU8wRkcxdEFSbFJBdHY5bTBtUStTcnM4emFNRzc5UUFOT1lV?=
 =?utf-8?B?OUU3QTZLUnFDalZaTGhLTUhTZy9mcjJQby9QZDZuUlp2b1pDTjUyYi84eDJN?=
 =?utf-8?B?WXI3SlI3bnlTTE5mYnorcUpyemp0YkcrSmFGaXBvNkxaR1VGWUM1Vld5U1dS?=
 =?utf-8?B?WXdBVWtwYjljM0FQK3BwdFd0Y296UCtKRG0vajlBUzVZaUpUNmJLT2pzTzZ4?=
 =?utf-8?B?dlA1bXh0U20wZnNkUC9CNUlxNW0xVGx2Y0hVcUhQemFTQWtKcWZXY0ZRaUh4?=
 =?utf-8?B?MFhlR1dVbXB6UTlvMEdzTDJvMDZnY3JQN1plVDhFd1NKendVZFZMZnZ2Q2Vm?=
 =?utf-8?B?c3J6VS9vTHZJK0toU2JxV3FvNmdyOWxBSWltSm1OdTErNjRORGRQU0ZBRnI3?=
 =?utf-8?B?MEtHOW8yY05yMThKMGFLbDZ4ZlBMYlJpVlQzeE8rdk5pTlpmZkFqZGo2aElS?=
 =?utf-8?B?KzZLYTRkMW1FbWlRbzJkYVpsV1NzeUJBb1NtZEdnbjRwcFZ4aklZWmUwQ2Vz?=
 =?utf-8?B?cnk1eDNOeVNvL28yQk9IZjdncVRoNG5tL2dwVHNCSjdsWjlrSlUwMjcxdTBh?=
 =?utf-8?B?MkNtcE0zSm1WZWRiU3FlMExHSE1QUUZWZFpXN0xsTFRhVlNPQStEeDZUaS9u?=
 =?utf-8?B?NklwV1RPb2lXU2toRGdSeXMwV0xjWFFKVXNnTXJGTWRvKzdxZklROC80Nmxm?=
 =?utf-8?B?YmtvTGVwTE1KdUZmYllFTDNINWV4aStZSzNCRUJOOW0yakNzeVF0MmRnMDhr?=
 =?utf-8?B?VTd3ZWVINUJHNjh3RlVhUzBna0JZSWVTSHY4bFNXU01rREtzamtUZFgvOXp2?=
 =?utf-8?B?VjJqUDFoY0VsK1lIalhsb3BFQjhUeGFqZXJxVGhpdnpWOXlQZm9JRHJCekJE?=
 =?utf-8?B?NHJUN3k2K0xVUnVjcTlyNURUMVlBdC92QU1rTjFVeUxNUTArUkN1RXZaMU5I?=
 =?utf-8?B?R0xSTkVzOU5ET0s0OUpqaWt5cWp0ZXBiUFBxNnF4L25peEZUenZwcCtITVlB?=
 =?utf-8?B?T01Rcm15ZVFFSUVEbG9BdjZUTWc2ZXNHbEMvUHlsUDBFYTNVaXlJajR6MlJv?=
 =?utf-8?B?NzlNRng3bzdLMGZiLytvRUdUZ0xwMFRMMUtQRjVZcStwZHdDeFJIa3pwUExX?=
 =?utf-8?B?TVFjRStFb3ZzYkNMSTN1M3V3cTNQZ3dMaEF4WjkrU3RvdlFXSG5rVmpURUhw?=
 =?utf-8?B?dkplejlBVkhWbU5aV1d5WG1ZNGhFdVFnVEVjMU42TE55dCtyTmdhL1VPOVY4?=
 =?utf-8?B?bzdRVXRNclByTHd0MTVlVkJ4aW5RbDVhdCtNbTVNM2tIWHBGc3ZBaUdpQVBM?=
 =?utf-8?B?WEtEdnJYaG1McTM5ajRsM0daUXY5WlBXNFBGdDljQjlmZ3VDNHE3ay9KVEI4?=
 =?utf-8?B?dE81eEZvYTJWbHBPQnpFM1ZVMjZwbFpURG9oVitZVzdPRlNiZmMvMmZ5RVJM?=
 =?utf-8?B?ZWNQWE1xTHR1Unhrd21nb0QxSHlHUW9mWitGZHZtOWVGV3BnaDFpVFJEQTdN?=
 =?utf-8?B?RFFMemlHYm9YbTBaczlZNy9zbzBlN1JrUTlveFFpdHRWY2VyK3RIczNBQlBJ?=
 =?utf-8?B?Z205RGszVUZyeGRBSmNmZEg3OW5yNVVTUDVwRUNSa3VsYVdaM25IeHZ5WlJa?=
 =?utf-8?Q?N8K/9EH/RcP2Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUtwZmthcGtBOVRjRDE4RTZTbmJlQWVvenVqeVpTc3R1dTVQek1zdkQ3ZXVJ?=
 =?utf-8?B?eC9MRGNSVVd2aVZObzZZcHBMbng0S0FuRHhlcWY1ZjQ1T01pMmdMSmJDQVZj?=
 =?utf-8?B?UFg2TWI4clJuVzRMdm1BQ2U3Uk9seUEzRmdQRVNsOXczZ0hscFY2VGs1cCsr?=
 =?utf-8?B?cFlNb1h4dE9XeEVnRC9hczNRdHE3VkRtSDZHU1NJbTlaYXFSN2t1MUdORGQz?=
 =?utf-8?B?VkN4QnZUbTNGdHd0N3lVMGF2aFc2b0NiUTh5VEdUNE4vNzhiSms2cHp0bTMz?=
 =?utf-8?B?MjNBaEZ2WmUySmE5bGR6cVB3ZlY1QjVhZEV3WThCWnJvL1ZyamRKRUFRVElu?=
 =?utf-8?B?bDRyaTR4ZjJaaVNuLzFmRGdZeFpPNTd5T2lPQWNXSnJjNEpmYlk5RFp5NEY3?=
 =?utf-8?B?WXNBTWJ1QXg4WjBRdFBQN2p5S09ZVzd4M2VsbktDWnJTNGRiTDdYT0daZm91?=
 =?utf-8?B?dkdVS1hWRTNOZ29UemFIY1I0c1pUWWd3bTVLVjRKS0ZZY0R5QTZtV0VDRlJt?=
 =?utf-8?B?dDlDTmNNZ2psamxaYWpPbE5XLzhNYTFlZGl5T2tHTVJHSHZYM0pmSlRKSkdL?=
 =?utf-8?B?a3l2TysvWnUxd1FEVDVCMVhaaU1sNy9JSWR2TzVTUmVocXVONFEwVzd4Mnkv?=
 =?utf-8?B?VjhlRGM1OTRXVnRXNlVyK3RreHdkSWxNVEZEN0MxRkpUMW5lMnJMbHRGVFFC?=
 =?utf-8?B?NTFWWHIvWm5jcml4Rk9Id1Vta3dVcGFDSDkvNEZkVGxjaGFYQWtwMDVGelp5?=
 =?utf-8?B?dGdPV0V5ejBXWGdTSVR4WmdaRVJ6T0hlcDNFRDdDUzdEWTh0dmdCa2RwbDVH?=
 =?utf-8?B?K0h0TTVicmpxNk1rdElKZjBpZFlpTWducVpneWtwWXdpK2QvcTUxaHA2N3Yw?=
 =?utf-8?B?Y0IxRWx5WE1MTUpDOWlmWXlHbFNsT01acVJFS2l2ZE1PUVRTcDl2SDR3K1gr?=
 =?utf-8?B?clNhMGV4NnZLVkVuQ3ZSR3hKdnRsVit4QXozdlhGTFNkRVZPc1M1ejlXcGps?=
 =?utf-8?B?c0Y0Q2FKT01vTy9Ba2xjd3pzc2lWeGxDakpSY1lreUFxWGVBcy9IbXliWEJm?=
 =?utf-8?B?MlQrMnNaT0w0M0xtOTVycG1ZK2kxNG12dHIzdHhLb0pCOG4wWThza24vcm1X?=
 =?utf-8?B?TGhGZW1jNVlrcWF6YmVidUswMFdBZHZmR3U4S1dpeUNKN1d1V0NQQis3c25Z?=
 =?utf-8?B?cks2V3hIL0NlNS9hZU1tenRmMmd2ZDhsZHZvR1I3Q080R1hmYUlDWmZRN1F1?=
 =?utf-8?B?ZGlSZFBWQUNxWHdmLysxTDdnQmpsYURCUE1QVitXQU5IRnBXZDZMRGNvQ1ds?=
 =?utf-8?B?MGV6eXIxYjhmQWFoTTQyazIzWm9PdjJEZWozVjBWenpsQlZoTVhXK1M4eC9U?=
 =?utf-8?B?MWJ0QXB2d3FJL2NDMFBJaGRLVDlzaS9QaElyUGpnQmcydmxjSUxwL1VEUzZ2?=
 =?utf-8?B?TmRBVmRsQkpmOXBLM0IrVElKbWJBV2l5MzcrdjI2Ti9QTTBydDkzZnJ5NWxN?=
 =?utf-8?B?cnhGVnVUTWhlYWVCSmMxRHYyZm4vT3lCM2tCQXlYSFhiSHNQeG9hRDYrOVA3?=
 =?utf-8?B?a0I3c2RaajlKTTBpbTk2cjM2bWl2RXZScGNvbFY4a3RmRTN4NzR6cEtIaGtE?=
 =?utf-8?B?aGVTbFA0YWVxVyt6QU5zVVVKeWZnMDRLSmJkQnJhUXM2MVlhTU1HNW5JQ3c1?=
 =?utf-8?B?Ulo4Q1FSVTBOOU5TTTZ4cGh2dWNFbmU3NUQwYmtma241MkYrbkNWVDRqWUZO?=
 =?utf-8?B?YWkrSjgwc2FnU2tUNW1nVHhYb0JqOGVYMmszcjJUS0hoa0NNVmZmV2VCQ2s3?=
 =?utf-8?B?MjZ2MWhiUEFnZ2RTTWFIdVZ5R1dkVDZSQ1VXK3ZkbFYrNks2QmVpZ1NpbWZa?=
 =?utf-8?B?WFVqSnFYd2dLbGg1SXJxNDFoZ3dzaDVScmVad05LcHo5dWo5YS9mbDYyM1JK?=
 =?utf-8?B?dU1LWnpTWlVHSTU5M0ZLNk56R0VHamFJNmNEWUV3SW43VHpPaXdaMHZJVTVT?=
 =?utf-8?B?NFlhV1c1UDAvUWRmU3NjaDZGQnNsRmUzcmpKQytTbTcydzRwdnNGcEozb1A0?=
 =?utf-8?B?b3F3SUVjdDQwWk90Zkl3YTBSa283UnJWdFBoZ3lkYUwyTzZSczBjMi9kbDV6?=
 =?utf-8?Q?BJvuewOTVBLC6ozQHtFsUnWQc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d0890d-3b51-4b1f-44f1-08dd3af7bad0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:16:22.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n68IQI4938pDYLSA15Je8zepyHEUc3E8/HY65JiN1SVzTSZ0FrKAo+q1L2bS++FG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

On Wed Jan 22, 2025 at 9:26 AM EST, David Hildenbrand wrote:
> On 22.01.25 13:40, Zi Yan wrote:
>> Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>> changes huge=3Dalways to allocate THP/mTHP based on write size and
>> split_huge_page_test does not write PMD size data, so file-back THP is n=
ot
>> created during the test.
>
> Just curious, why can't we write PMD size data instead, to avoid messing=
=20
> with the "force" option?

It also works. I used "force", because I notice that it is intended for
testing. Using it might be more future proof, in case huge=3Dalways changes
its semantics again in the future.


--=20
Best Regards,
Yan, Zi


