Return-Path: <linux-kselftest+bounces-24929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5CA1913F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 13:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB397A1D15
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEDE211711;
	Wed, 22 Jan 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JNav9gDe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09093D6A;
	Wed, 22 Jan 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737548518; cv=fail; b=fS/KLCZ+Y6t8I8bqdtD2e/gYDu01v12Lbe/t1yIw1S/Mq5VvQ2BtYIw0gsG5zcGriJ/bbjjjHGJYPBkypDsLITU1h5LNo1r07ktAOUHq0a1tEzRsMbLCyUEHz47EkkA+N70kgSTYUpaS+wRLwLwntKFGECbvSytOzArlwQtBE60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737548518; c=relaxed/simple;
	bh=BsgnRkPutCK+m6E5UwiZi1QB5MT0yDFyFpOIhefCYow=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=pzuYFSE/MTe3CfX0NlAKTZckVQbtT67EE7O6oFW+UzzS7J26Ma5fnK7lqEHHgPvQxz30SG3mwvQgija2loefVBvcDuv50lgxirr/DyXEZy+mtbeekYPrO6hDZcbg1mb9a6fKdtEH7AHUVGa5iB5250nZljNBvEd+Msyetle0VBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JNav9gDe; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqfADlaui2y+LBIfMh6UrFOM0/WDUntISWI65JnLEhMulk0XR6SgIoZRyDcuv6xtZnQVwGBQ80VoFgv6BkR4chyxcrVgtm49nYsGt5XyyBlyqc4T56iQFw0lL5I5hqPeSmB4g2wnP0d5BqHMCJ/cshJDCnl9qvU3W9Uv4oGNQl+qKYWsOPf5cBHwGZnLoB+tvYzbtxPBwasgoY9YLq1tiOfBREW5cif9kHsGpMwjGsL6vqTWktkxqz+TJYC4ojW7nvUUWplmBPYhlHKotkyMn9rEaqdEkCHpWZUl3tdbOjfUY5sCkOFzy6a4PBj10UnnnVSQL8HgYIkoFMFUWfT0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gEEE9agQT0LWYUQaEHasgRW+EK0vEaJTMzZ27EFd/k=;
 b=kaQTKb70E5JmG/RaKlFoEpfvJBzaJM5b5PeeK0Jv0BWdyE+MCKfRaTn7/FBpx5URj3r8+SP/dw8VBJ/p8bin7FXj/Ihe6hsT3EmQ5r437cocBCVrfCo9m7fC/4L7CzbPs7EQsG7Fi/A4cZFMaeuU0RWz6hBh1oe2BnHWOxtfq2EueIbX8kTOqMZBChAOM03CUTSpi/tzRfAaWMVKRKo6cKOo5m4kE4y8EwhVOYVsfE1RVVWFk+149hzpLw17P3/jJL3RDl1IyijiiUvWprL1jkI15f1HBoP0gWKmz3gGOJcuH/AjUjtj2ZQnAAMiRK9eEUdkmYMELKcpksI2buFZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gEEE9agQT0LWYUQaEHasgRW+EK0vEaJTMzZ27EFd/k=;
 b=JNav9gDewonnhZLNVrEmtmwo2oNYlaYA9e/C11kWo+ARGFcGmKr4lmb8Yf+xQFQCiFctQCjuRODTb7vzltyZhtX2Tk4ZoOWmlR1wLjIT9KRGPc3eNJ5kXuSlDppbJauQibfIOdnINv3CKA6tLGPkUzm7/1wyv6Y1FcBdvi16cd3rNLFJuroGesdF712lxPwqVPnDipZbpqDn69KSRLEmnSjK4etY4fHf8i8KKjrDjidYXqhHPDMwbqrh4BzXtCWd6PpqrLYEYBvMvshSuOaVZ7DQYMfoTBz1zu3jpzALHlKegJjMCN9lDJIcTSVD7eWWxB3AUhy5e3qzj06rX0b89w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.17; Wed, 22 Jan 2025 12:21:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 12:21:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jan 2025 07:21:51 -0500
Message-Id: <D78LJIQA2NHZ.27PP8LS863YMB@nvidia.com>
Subject: Re: [PATCH v5 01/10] selftests/mm: make file-backed THP split work
 by setting force option
Cc: "Ryan Roberts" <ryan.roberts@arm.com>, "Hugh Dickins"
 <hughd@google.com>, "David Hildenbrand" <david@redhat.com>, "Yang Shi"
 <yang@os.amperecomputing.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Kefeng
 Wang" <wangkefeng.wang@huawei.com>, "Yu Zhao" <yuzhao@google.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Baolin Wang" <baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.19.0
References: <20250116211042.741543-1-ziy@nvidia.com>
 <20250116211042.741543-2-ziy@nvidia.com>
 <d1a5f942-0c43-475d-854a-9e4a34d04556@linux.alibaba.com>
In-Reply-To: <d1a5f942-0c43-475d-854a-9e4a34d04556@linux.alibaba.com>
X-ClientProxiedBy: MN0P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b57a379-d424-452b-07c5-08dd3adf5a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFp1dnRzdTMvQmQzMlpraDlJMjJwRmFwZURKU2tLNDVqb1ZxbjRvbnV6Z05L?=
 =?utf-8?B?cXFSb25ldWNoVXJvUVlHNW9QU2lUQjF1K0Fjalp2Rzk5SEEvZDNkZXlWeTZ1?=
 =?utf-8?B?Q3VTdGU0RFJzcHVLMGhIOHMzSnB1N2Z2UmpkUnhFV2JOd243Tlh2eTZ6S0l2?=
 =?utf-8?B?dnNEZ0VpRnAwUzFHR3NlU2hsZEY3a2hFK2JxUGxuNzFaWTNxMm0xT2FIcCsw?=
 =?utf-8?B?b3VxZTRSRW8rcVRaTUh0TEdPVkxCSjFZU2NJY1BOd0hWNUovSnFHWG1rQ3Vv?=
 =?utf-8?B?ZWJtMHV2ZjJuQitHY2FSRlBRVFRuVzhMNmxqVWpmMjFabjVxYnZxZE8wejFK?=
 =?utf-8?B?VkN6VFgyVDNNU0ZQRTdFNjRVSWdGbzVJS3BLWUw2dTN5VU1GSUIwaHRnTWI0?=
 =?utf-8?B?dnNsQ29HRGM4ajRHbVN4b1Z6bWUyTVlYc2NpQ3FZbk9xTlRkb2hHczByTGN3?=
 =?utf-8?B?YnAwS09neVZpVkUrbkp4bE4rVHlDVUNBMytoK0U2V3Eya3lUb2cxalZEZG9j?=
 =?utf-8?B?K3UyNURwOWNjMkpFMmwyK0c4S3FSckxiemJWemNBNjNsaFo3ZlJCRkpOc05C?=
 =?utf-8?B?QkFQdGpOTC9LN2p5aVdiR2VDOThOcmJ3bGZUYnM4QVVuRkMzMUZESTZEdzgy?=
 =?utf-8?B?eGtteXo1NnhMTlRRNGpieTJhbGw2Ui90RzFwb0FWRGdtN04yNklRdnBjdDdL?=
 =?utf-8?B?dFgwQzY2dmFwcFA5d1FIWElNVlBkQUprd1BpbENmT2tlNjh5cEFkeVQ2dkV4?=
 =?utf-8?B?dXFaY2VzY2ZtbkxzdC9wNERYVCszcGp3N3BUdHJkSG5oejZiYzA1K1NlV0hY?=
 =?utf-8?B?emR1M2hQakk1M2RLSDRmd05HNFlhZXVRQjhVbXdHa1VYaDJtZXRXSElBNDR6?=
 =?utf-8?B?QVhldXplb28xSzlnTFR2cFBMRmRvTy9JKzQxUWwySXZjSjRwUCtmRFo3SVBP?=
 =?utf-8?B?Zi84aGtqTldzY1J2UU9sWFBSclJPQmRiajdsK2w1NE9yRU1TNFBoYnNpK3dM?=
 =?utf-8?B?VzBCQU1KeXd1eTk5RWM5U05qeThJQnpxUlZMakMrdmdBZTAxdHFwRmtLY2tZ?=
 =?utf-8?B?QmFNRlFEOFM1ZWpLWUpZZDdVbzJ0ZHFrTHBWdXgvSm1ta01aeHRuSkNIWXNQ?=
 =?utf-8?B?aktua1JKNHpOcS9EWnZoaHRMa3IwMWJycE5IOEhTVTdSVnJkbUxmZUozVW9R?=
 =?utf-8?B?VkJCVHkreml1L3dlaklUZnhTLzJYVll0d2hXYmhkeFdMZDgxWmMwaE9JZnRO?=
 =?utf-8?B?VDl6SVlURGg4ZnBCLzdjTHpIR1JyZEtZTlh2R0dkVkhkSlNGL0p4L2FONnpl?=
 =?utf-8?B?OWQyYXF0K1RjV3pOMzErQmc1ZVNybnEyQlRJRzFMa2hzWEhSZkltckh0cEJW?=
 =?utf-8?B?eG94L2VhSzhrNWNzTi85MzVURmE4dFVWRE92TnVQYnJmYWZQUHh2YjNWWEZE?=
 =?utf-8?B?cHpqbWpwd2NRRFhTUm0vcEFabldobmg0Vm1rbFhUYjRuME03K3RCQzFSbVFi?=
 =?utf-8?B?bTN1MHdBN0FhamtTNHQ1SVYzcTl5ck1PREdzV0ErNm9tbG0yM3lVUUF6eUVj?=
 =?utf-8?B?cTd6NTFNbTdxOUFCRHppU0xZbmd6ajhIUTIwcU45MkZmazYrU1FGQWFtUWxy?=
 =?utf-8?B?bkE5TVBEY0R4VUpNU3dxVG92ZU9tUEh6M09SWUtIMzRCcklKTHUxZUx4U0Fi?=
 =?utf-8?B?TVpidERWRnQ0U3BQQzRseWQ5b0ZEd28yaHpiS1FuWCs5amNrTGFGZGVjeEFP?=
 =?utf-8?B?TjFUQkVIalB2MklJTmt5WFgxMXFuQU1DYnVBTmpTUU92OU4zOVk3R0lUWDJq?=
 =?utf-8?B?NnpNOVdRYnh0MnZpQVNaZUN6L0hpQVhpMzJmTi9Jdk5HMXBVRzBtVFdKc2sx?=
 =?utf-8?Q?i0ZVIPysdeO1R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3pHM01BRk5ZeW1FQkpxdWpqRzNzaE5YdmRBUXR5azVWYlZTVHBxY0xTV2hi?=
 =?utf-8?B?TTNHQ0R6NS80ZjB0dTJNbUVHMkl4TEo2Q2NGVGhNUlJaSUpoSjQ5UjRvK2xy?=
 =?utf-8?B?a00zWXpOZEEwOFo4bURtM3hYTWJoa28xbHJhclF0OGI1L0drUmlBTEhBWnh5?=
 =?utf-8?B?VTlFZkRRSGd6cUdPc01YOC9NY0lud09xNW02OVVKTy9VZmp3Ky9vQ3RuOGw3?=
 =?utf-8?B?dTYwN0pBYUxFeGRpWlI0WVR1Y3poL1BWWFRTTE9TYnJwZTYxbE1xWFBqVFdr?=
 =?utf-8?B?V3dpSUdVQ0FPcUh3UCtxTVlZTjZzWWlVRlZIcFVGa0I1WElXSVI1eUMya1g5?=
 =?utf-8?B?b21FZ092OStSM1o2ZlByMEdkekJjbXBQUDFER0xVSEd3WmlSaE5IUVhyUlVh?=
 =?utf-8?B?UVRrSVFhYzlVbHZCeGg2MkVDeU5SME1YR3ZpUWFpNXZ5RGhFb01Ba3RGa3Q2?=
 =?utf-8?B?QUJQQ2dtMmdyTEJsNHBHZlFEeDJKTkoyZHdhNCtYWjRqcmNYTmhjTUV1b1l4?=
 =?utf-8?B?ZE1BZXVlZ2tVT2FXaHpPdVZNNmZJS20xSGZHd0NJQW05KzN4Z25TS1dLaDBz?=
 =?utf-8?B?dlc2V0NFd01JbWQ4UDFqS1dIWFdBRlJmSE9yUVRyL1p2dnFFTjFaRlhta2xV?=
 =?utf-8?B?NFlPUC9VbFcxbEJOYWhidm4zUWIycDE2Nnd2Nkpxb1N0elRSQXNOTjV3dnJI?=
 =?utf-8?B?Q0lGdFlpQVRkMmxPdjVPR0hpd0tGSHV1NVBNS3RLTnpYWGJxY0NSK3lMS0tj?=
 =?utf-8?B?RVRqcVB4NnhYVlhBNEJEeXFxRnNrc28rYi9PMStza1dxZTNzcjN0dVFpMDlJ?=
 =?utf-8?B?Ym9LNGxmU0laUG9nMVozaCtxQStSaTg2MmpNWDBuMHErSUs4NGY1ZytGWEdn?=
 =?utf-8?B?UWl6Yk4ybitBcitvVUtWdUJhWTB0NE5wSkV3UFBmdklBUEJyVGZhT2JnZi9D?=
 =?utf-8?B?TC82NzhKZXRhWkNMY05iY3hTRG9jTEhaV3NmOUpGTmprVXBUK2NuNnhTeC9M?=
 =?utf-8?B?cW45ek5TN01HTWpIQ0hlSWJRZUtNUUpZaEY3SllKY1JlbzBMS1Rjc1EzRk9B?=
 =?utf-8?B?RUMwWEE0NFRtRUdjcTBtRzMzSXRkamJMZ0JrcGQvTnN1bGIxYm9ab0FQN1Fv?=
 =?utf-8?B?SDBLWVdISDlDRXlIT2pjWGlRU09SMmplclJjR2xjRFo2eDFNSk12T21XZkxy?=
 =?utf-8?B?NCtJRkg2SlUvQlhGSXYvV0s5TXRvQkVnclFSa2hWN1UxSHArTlQzQW14VzF6?=
 =?utf-8?B?eG1YRkxyT0lhbEMzK2VFdGhQcms3V2ZhOFhlSnhTdTNwTENDQWJpMXYveWps?=
 =?utf-8?B?OWxqdEU1OU5XMXR5eWN4U1MvclUxUERRRjVwVGV0dEtpRE9vK000UmJ0elov?=
 =?utf-8?B?UDQ3Q2VYWUhML3YvR0FFbXFGajVISDNwWTE4dWUwWms0SXhCcXk5YTZnMy9G?=
 =?utf-8?B?UnYxNGROT3pHMnB1OHZxTnpQZ2lkRlpRV29JUWZFUURTR1Zoa2hxYWN6LzN3?=
 =?utf-8?B?dndyZU9pd3lwTmNkVS9jYlJVUC9UNlNtQzNJdlMySE5KM1dXc0tRaWk4cWox?=
 =?utf-8?B?OXhzR1BrRTNLM1kvcWFJMjFnekxKaDg0MVVSN010L1liMDZrM0NTM2F0RWJP?=
 =?utf-8?B?UktPRDkyc1ZzOStVS051UUZ0dDVGZGpOYzQ1VS9lWWVKSG5LV25zZEJsR1Z3?=
 =?utf-8?B?VHFXOVZuVEE3QTlOOEJBMXlGbkRLdkY1clNQRWRldmY1amthaXpqSU9DVGgz?=
 =?utf-8?B?M21EZVNHSGpTOFcwOGttTGhPdkptWmw3VUhsU0pqOUsyUVRIZU0zN0UzNWMy?=
 =?utf-8?B?eTJnNTllVUJjaEhLRk16dlhOV2NNOXdBbVdYdGk2NVdvWk9uSjFld2h6UEg2?=
 =?utf-8?B?bmFOeElHa3RxL3RpajNXRjVHOE9oNWVoL3hFTXo1QWZMc1hhS080eGNOYzJP?=
 =?utf-8?B?TjRSZVNWeUVXSVQvWXM0b2VIYnFtYUo3ZFdkeUYyZEg1ODZrQWNsd2xlWDYx?=
 =?utf-8?B?amU1T0pIYityd0ZMNzBpeTFRRlpGSm4zK0dGM0djWnJrT2Z0SU1keEZEM01W?=
 =?utf-8?B?amJYTlBRbnRoSGpiaDZMTEZyaGMwY0hhWm55SEFZRzhIcnR6SStNTHpmaUNv?=
 =?utf-8?Q?ew4c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b57a379-d424-452b-07c5-08dd3adf5a91
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 12:21:52.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfJsxN2VmjVvmWOigYxioNeurInLkBNorOCmftZIUmkAompE6FWtVI7k6WG7boHv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

On Wed Jan 22, 2025 at 1:32 AM EST, Baolin Wang wrote:
>
>
> On 2025/1/17 05:10, Zi Yan wrote:
>> Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>> changes huge=3Dalways to allocate THP/mTHP based on write size and
>> split_huge_page_test does not write PMD size data, so file-back THP is n=
ot
>> created during the test.
>>=20
>> Set /sys/kernel/mm/transparent_hugepage/shmem_enabled to "force" to forc=
e
>> THP allocation.
>>=20
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   .../selftests/mm/split_huge_page_test.c       | 47 +++++++++++++++++--
>>   1 file changed, 43 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/t=
esting/selftests/mm/split_huge_page_test.c
>> index 3f353f3d070f..eccaa347140b 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -264,15 +264,46 @@ void split_pte_mapped_thp(void)
>>   void split_file_backed_thp(void)
>>   {
>>   	int status;
>> -	int fd;
>> -	ssize_t num_written;
>> +	int fd, shmem_sysctl_fd;
>> +	ssize_t num_written, num_read;
>>   	char tmpfs_template[] =3D "/tmp/thp_split_XXXXXX";
>>   	const char *tmpfs_loc =3D mkdtemp(tmpfs_template);
>> -	char testfile[INPUT_MAX];
>> +	char testfile[INPUT_MAX], sysctl_buf[INPUT_MAX] =3D {0};
>>   	uint64_t pgoff_start =3D 0, pgoff_end =3D 1024;
>> +	const char *shmem_sysctl =3D "/sys/kernel/mm/transparent_hugepage/shme=
m_enabled";
>> +	char *opt1, *opt2;
>>  =20
>>   	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() =
for more info.\n");
>>  =20
>> +	shmem_sysctl_fd =3D open(shmem_sysctl, O_RDWR);
>> +	if (shmem_sysctl_fd =3D=3D -1) {
>> +		ksft_perror("cannot open shmem sysctl");
>> +		goto out;
>> +	}
>> +
>> +	num_read =3D read(shmem_sysctl_fd, sysctl_buf, INPUT_MAX);
>> +	if (num_read < 1) {
>> +		ksft_perror("Failed to read shmem sysctl");
>
> You should close() shmem_sysctl_fd before returning.

Ack.

>
>> +		goto out;
>> +	}
>> +
>> +	opt1 =3D strchr(sysctl_buf, '[');
>> +	opt2 =3D strchr(sysctl_buf, ']');
>> +	if (!opt1 || !opt2) {
>
> Ditto.

Ack.
>
>> +		ksft_perror("cannot read shmem sysctl config");
>> +		goto out;
>> +	}
>> +
>> +	/* get existing shmem sysctl config into sysctl_buf */
>> +	strncpy(sysctl_buf, opt1 + 1, opt2 - opt1 - 1);
>> +	memset(sysctl_buf + (opt2 - opt1 - 1), 0, INPUT_MAX);
>> +
>> +	num_written =3D write(shmem_sysctl_fd, "force", sizeof("force"));
>> +	if (num_written < 1) {
>> +		ksft_perror("Fail to write force to shmem sysctl");
>> +		goto out;
>> +	}
>> +
>>   	status =3D mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=3Dalways,size=
=3D4m");
>>  =20
>>   	if (status)
>> @@ -317,13 +348,21 @@ void split_file_backed_thp(void)
>>   	if (status)
>>   		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
>>  =20
>> +	num_written =3D write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) =
+ 1);
>> +	if (num_written < 1)
>> +		ksft_perror("Fail to restore shmem sysctl");
>> +
>>   	ksft_print_msg("Please check dmesg for more information\n");
>> -	ksft_test_result_pass("File-backed THP split test done\n");
>> +	ksft_test_result_pass("File-backed THP split to order %d test done\n",=
 order);
>
> Seems the patch set split has issues. No 'order' variable in this patch.
>
> Anyway, I've fixed these issues in my local tree, and it works well. If=20
> you fix them in the next version, please feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Sure. Thank you for the review and testing. I will fix the above issues
and resend another version. First three patches can be merged first.
>
>
>>   	return;
>>  =20
>>   cleanup:
>> +	num_written =3D write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) =
+ 1);
>> +	if (num_written < 1)
>> +		ksft_perror("Fail to restore shmem sysctl");
>>   	umount(tmpfs_loc);
>>   	rmdir(tmpfs_loc);
>> +out:
>>   	ksft_exit_fail_msg("Error occurred\n");
>>   }
>>  =20




--=20
Best Regards,
Yan, Zi


