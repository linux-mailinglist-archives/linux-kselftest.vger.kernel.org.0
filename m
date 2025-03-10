Return-Path: <linux-kselftest+bounces-28650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D894A59A14
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8E5165706
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714922B597;
	Mon, 10 Mar 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvSOD0yA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42171C68B6;
	Mon, 10 Mar 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620957; cv=fail; b=TX4dSIqhMlVG29h7amcwU9OjQS/pFGPWsKgs5MxBjKC+EhCRQ39Iv8ztaZahsWBVGBlmp+M/X7ePzwr22oS4/YBr4AIwIiutqsfXsgRpx3FIKMRySKJ0WdxEmdesYyfnqFhtu+uBDTgzJhxxA6ULOW8qedTg6bDCUhDAZ8Vi1Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620957; c=relaxed/simple;
	bh=cS/2DhBqHKucw05yYFpr+SrWPKbel9G62aBv4mgXU2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7YBwHaREA4QoNtXf1yMFMwnztHSMU3J4mHul8ybdsLXdmaYvHL3ShogHniEbQe/q6L2q+dSzfgJGzFiJ+TbuA0eid1cXax4jqXJB0oVqtF2U5Xh3HwmLM5+wynVKG4XZCfFUVNikZ2QW39dsxy/CWmJgLFaJWrNk7+Z72ZHSy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvSOD0yA; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH93pRVUOwsCfB75zMVNq9j4Ti+1a1RvAP6YZyaykg2jq/e/4x6KQL8Mr9THL+LsM5t/jiBuJLTytO5AGYDzLTmRfNtnB46C8jM+ZZYb0g0UDgfLTUzRmUeXkR6Lj7R8UJVwfL0lTCusSu/WHJJuFXuokzu0R2ptfNJwlynkswhKUB0RbChc6o/O26AyJ4BPu3CEEhY+tWiCFKL7/Se0zQ/4TpgxmWAIv4X+afaGqvqIwfd890xRRe7NczvhqVvLBFmZJqcVb276N+Ome6RvMB/yXLwVyypWfvX4Dy/crE7SUIB999nsHROLb6gYYMup77Fg7dsxk2jBwqjo+Axe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fzD1wpdHVp8Du8IAngO23MxT0vkJhVEmtBflFPpKLg=;
 b=ZeKQ+U7fZ4469+L5hU9hCNY6ZbaVJeV2Voi77rP7ncnSeLr+G32SRpFMfbNnFkWDDzq7SWKMIQIYMZyXhjnSVQEpHGYkUG1Evzf3kbYZsl99Y7/P5j5pWvZA6w2n66IZ4aarFEExkthHd0l1i9X0q0VfmswXBZMbjiTf/gSS5IAjB2LAftpX7F7CXq1uLPLBVmRkAzUiEPPOfa2oyEdX3A0K1xOVTgnHORl8SYx8Qd/GzU1U4X/d1WVtKv7gm39dMvfsa3yQt9XxinC/cojBGHxyo0sKMB/8r9WM055TE35qEo8f0Ymku5uutDCdhU3MVdYcSz0wVTO3G3Fok0keew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fzD1wpdHVp8Du8IAngO23MxT0vkJhVEmtBflFPpKLg=;
 b=tvSOD0yAvpd3az4kGwuVlKH5cm39OQnII4SIaVtmenJAY+iNAJJsEj8dbCYJydliHUV4KXenEPfEe/Y8UNAIdK16XLWGJpWVEDOy0uU5dto1OuClUq9Y9cFY+ygUwvZEXMj34/yvvEUegECHWWyYKv4TS4/FFVFRMIB9I68PWpoiorkPrN2hnxka6K5d8slu0FQFy37BUq8D4WeEpN2kNmjKsbSqb0AwmCRovi0MTzA3fyQ0qT2rKEInIYsR+/2eehSdx/MRqaq8Loei8HUIg+LdK21vOnP5t2STBOKeApPjBhV05lW9RVt4CeKrURt4Qhd/seJvva/1nq+TTSpZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 15:35:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:35:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Mon, 10 Mar 2025 11:35:46 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <56E0A219-6817-419A-A58E-18C6FA418D77@nvidia.com>
In-Reply-To: <fcbadb7f-dd3e-21df-f9a7-2853b53183c4@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
 <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
 <2D7DFB2E-DB80-4F6C-A580-DEBC70318364@nvidia.com>
 <176731de-6a3b-270b-6b5d-dfce124c8789@google.com>
 <D45D4F01-E5A5-47E6-8724-01610CC192CC@nvidia.com>
 <fcbadb7f-dd3e-21df-f9a7-2853b53183c4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 337a1ca4-bd1e-4088-5e68-08dd5fe93c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajQ4NFJXeTlnZm5oTXozSFMrWktPdnpvZWZ2UnZRSXZZaGRPS0hzSVNBUk9B?=
 =?utf-8?B?OGNoMzlIQVc1QVZFamhSYUZIV1kxM2pEUytvaU14UXJBYVdiTWhEUFhQNjlE?=
 =?utf-8?B?Y0dyajB5azZpOEQ5NXhUUmFtRFdmWEgxcjZTZGVaQTNtN3lnV0twYSszdkk4?=
 =?utf-8?B?TVRBTVFrYjFKWkxoa3Jrd1M2UWJrb2ZPTGYzelpYOVJYbzMxelRWQnJqc2d2?=
 =?utf-8?B?ZXdGYWxtcUFLdzQ1SFgzdGJWSzJOb3NHa2MreW9QOHdpajNxQTZPYm5kQzND?=
 =?utf-8?B?N2lGTWxkT3QrZEszdFpRTzFtWlZQZFFEOTJDUEZEREV1RzQxclBWNUN0anZh?=
 =?utf-8?B?N01vcFJ0bjQ5ckt5dXRVU1hOQjZyKzVqMUVqMlM3MzlsWEV6M2U0OG1lSDNM?=
 =?utf-8?B?Z21seWJMdkowNFdVRzBlQzUwelhKSXpwcDlBSUgyYlBHU1g1S0ZVQ252ejRx?=
 =?utf-8?B?RTc2QlBBNFNod2NsWVRqeFZyVjFUMDlmdklORWl6dkliR1ZxK0w4M1dDQ0JX?=
 =?utf-8?B?cUhZcTBRNXJNWm1KQkhsKzFlOTMrdC9PZlFtRGpTY3ZHbnpGa3VMYnRQODI3?=
 =?utf-8?B?cjh3VkY4NDRseFBxUWkrblhTY1FUbVU4MlhCSGtxVjJZZTV0LzhiVzRtTGhr?=
 =?utf-8?B?dkNOZWE1cUJEUnJnY0JJVHhFY0YxS1VDYkpoNWhQQ2ZxRmhndkFFUXFzdy9a?=
 =?utf-8?B?dWhEVS9OeVVyc1BPOE9lWEZPa2hLbzBKVEl2bWF6eSthS3ZMT25ZUVJ3TlE4?=
 =?utf-8?B?RWhOeGdoZmZDanA3WURmSkJxU2tCVndZMjJTdGNYUzlHLzBXM0VnMXcvZTdR?=
 =?utf-8?B?MjdEbUJYbVNLR01ldkNENU1xLzdwbFYyMDllYkQ5QWlsUTlxaEF6MmE3YkYy?=
 =?utf-8?B?dDNCTCtnS1lqdFBHOTNrWXdFbjZHci80WDRXTkJES2l2V0FLckFFZmRMWXN3?=
 =?utf-8?B?T3h6WXJ4NnF2RUZBUXhJTDJuTmxibE5rSCtOZ0VFUzlDaE00cXlWNUJodVJJ?=
 =?utf-8?B?Y21JbDVxVm8zOTVoUTNWM2ZSTDR0dzZRQ3VIWm1PZ2d4NW03STJFVExneTM4?=
 =?utf-8?B?MVJkOVRWVFpoaUNSelZWRzdFSmpsSkRhREJKei90MWVXclVBZkdkaWQ4cjE5?=
 =?utf-8?B?b2lkYk8yT3ZBNElqODl5dlR0eW1iY2RzaEVTR1h3bEs3QW5XS0t3dWxDekdq?=
 =?utf-8?B?OU5QbzkwRkdpenorRVczMm96T3d0cWRjeGN0V1Qvak1YdWROY2NINUdqcXdJ?=
 =?utf-8?B?eVV3TWVpT2VFRndiNkZGZW9jRzNuYm5idnJoNTZOWVpVZDFpdko0UkpvbGxB?=
 =?utf-8?B?Nms5SHlLbXVkZkVWaENFU0VlNmVOYTQ4N2wxMHFDbjlGKzVxZDNFeUQ4ckd0?=
 =?utf-8?B?L3ZjMGkxMUtnRElBdG9TcThwL1diS1ZQVDdEV3I2QVZPRjVndUtkaklrUS9U?=
 =?utf-8?B?SWg4SDBSMlFPTFFoZEl6cUxNUnFyb0taZ0IvKzVrSUxpQ0YvZ2tMNktWQlJJ?=
 =?utf-8?B?ODBXSkN6TUFxVCsvTTJkMWY2V1dPbjZLKzVsSCs2U1BiRDJnT3hrZElmNWVG?=
 =?utf-8?B?N2NoQko5Mkh2TkNHRUlqN3lqNk9ZN1VOYzhwd09HZlZQR0FNTE5tQVlwdFRo?=
 =?utf-8?B?cVdGZXc5Y3pQY3FTM09JOVMvaHhNQW9TOHllYWtMMlJUOU1hRVFzcWNuNkpa?=
 =?utf-8?B?QXRjaWZFOEZ3Y1o2dXFuN3JrWHVrTzU5cUtoYlRWNEdhbFoza3BHUmphOFcz?=
 =?utf-8?B?WDVKd3J6UTE4U2YraStXRFUzckhyb1dxbmhLQyt2a1dZYlBLSVlsSGR3aWpH?=
 =?utf-8?B?Uzg0S0oyWk5zbzZRMXozZ2hZeEdIN1VnTGFheWdlemR3cDVBMUFPY3ZjNCs2?=
 =?utf-8?Q?gzeC7vIxh0Znh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXNoRmY2cmVQVGxGcGc5L253MXNHQ0thQ0NXeXlmVzNmeGh4R3R2cXhSL1RC?=
 =?utf-8?B?QUUyaW1JdHNGV3R5cThhRDU3MVUvM25qaERkTnBqdVdDMFR2V0JJTlZlLzZO?=
 =?utf-8?B?VVgvNDVKTW45QmQxVVNuNytHU2FpZk5OMTRKWDZ5K2xpSXdMclR6SU0vbk0w?=
 =?utf-8?B?VG55TDRxblNTV3h4UEozTWUxTGtITVB5ckZsR1dSSFJXWnZRbi82S012ay91?=
 =?utf-8?B?b0l3SzVvTmZTVkEwUm1RRjlWM1lBdXVOcWZjYTgwM0dRNDJLM25pRVhtYm5t?=
 =?utf-8?B?blpCdTJTU3VmaGFZdEVFWUliZzR6eE5EbU1KdHkvdlpRMW5Pc0llWmwrVXVw?=
 =?utf-8?B?WnhmOW05L2dwSFc3Sm1xTUhId2xYdWN2KzJwWWRoU2FmRnlmR3FhYmV6QlZt?=
 =?utf-8?B?YzZGUkZWR25MeFFZQVB2Zk1JT1RtdzhvUE0zTmlvOGd1UHg3TUFWVjAvQ2RY?=
 =?utf-8?B?NEsxZ2ZDQUIrUGdHYWlhV3JrUm5TR2N6Zkl6WHYwUzlydzFZK05vS0ZJMjE0?=
 =?utf-8?B?emRXdEl3cEF3M0EveGZWOTQ3MWJTaHhSYlErMlFGYlNCaSt2bXdaL2U2TUkx?=
 =?utf-8?B?Tzd3SGhoTmpFYjhPcStUMm9OZkNoM0lRN21JcTNRRVJPVWVmaGdkUHNvR09N?=
 =?utf-8?B?UCtQRklxL1d0dnVCbFdGZk1yRERYamVLTlZkVDU4MEJPbWxFTUhsL2tQeXFL?=
 =?utf-8?B?ZWFueUduQ3c1NDBjWTVkV0JpVXFLTHVUZS9XUTFLTjIvVWROblZDZk5sdHZ4?=
 =?utf-8?B?NzVKampKb2d0T28rSWZ4WVpWUkVtMURhS2tjWjhYZW1nK3dJSGF0YS9nR1Jw?=
 =?utf-8?B?MURqbklUdW5HVjRpTTIwenNIdnR3d2RncTJlcG9GSGY5YW9VWmF0dVEwNjNM?=
 =?utf-8?B?THc0UVlFaWVUdUxhcEVjU2VGdnRweVp6UXlOV2pxblNabDZJMHVob1k0RGh6?=
 =?utf-8?B?TllIWXdIbG14UlNVa1JjUElzRk1OL1hmYW1RZE4rdXN5djAraURxalpWS2Zp?=
 =?utf-8?B?aVM5dU1mclJzamlDTTUyZUkvcW5qTUxmOHkweWlKT3RLVFZielo3ajJ6SUwz?=
 =?utf-8?B?TkRySTBIaFM1M1J6dzVLMkh5dFkzeHZkUnNlRFg1VmJGSVhwR2s5MXRRSHdB?=
 =?utf-8?B?QTg3THZPMDJiUkxlZkhwdXdIa2tWbm91aFpRcHdJRHFrYVNrQlRCOUlJZ3g1?=
 =?utf-8?B?NngxTkhseWhVdTdvNzRDVnRtK29VaVA2eU14MjM4VXBLckNQMWlHT3dyMXZs?=
 =?utf-8?B?VVh1ZytnYWFlTUpwN2dTaGM5UGFKRGRpTE1Ham9hWXJRQUxsZC85VzdSbXpz?=
 =?utf-8?B?aHZndkZGR1pNV09MS2YrM2dNdTBJRDAvWUNNNDZ0TjcwS1BNeWlNODRIbnUw?=
 =?utf-8?B?VE9SUnR5VUtrMzYzNFdTTWlzT2tvKzlBZkx6R0FQaDc2TjZFQ3BJWWJSZ0Y4?=
 =?utf-8?B?UFZVcys1ZHZpVmtzYjd1ZGtFYkY5U1krcjBvVk9hWDQ2RXhQOForUVRoUENW?=
 =?utf-8?B?b1p2cFYrNnBtVEs1N3ZVRjFCSE5OZkhOTHpYaTVJZ2FNV0N5cUJjZEtiU0Jr?=
 =?utf-8?B?emt4UWZ5c21jdmpoczZjaGxpUVBVM3B0YlR4MnBQRXlYQ1VZYkpyUE9WOVhT?=
 =?utf-8?B?d3RHV3loY3lIR09zc2JsWmI5aTNLZU44SE9BVkQzS0tkTGNQYjVhMEpRWkl6?=
 =?utf-8?B?RWhLMy9ZNGZCWXEyUEt6alRvN2pGYlFZYWtYZVZqQlhldnF5U2ozcEtDTzhW?=
 =?utf-8?B?WnJGTE9vN0J3ZkY3dHpHcm5wV0tTZ2EwOHNRSmNjRGthRTF0YUo3RHcyczBp?=
 =?utf-8?B?UjBvYTl0VTdkYTMzQlB0ejRrMWZjSStLQU9jZFNFTEcxQmpiR0x4Zi9FL1l0?=
 =?utf-8?B?MDdhVk9uYU42QTB0SHF3ZUszTDBpYzNPRzU2QWtDL3RRbVNQQzJiNnhHT3dV?=
 =?utf-8?B?V0ZpQVBWeVlPOWJkbTV6Skhsd2xjdU8xdFdDK25YRFRjK2xmS1V6OFNKdW5T?=
 =?utf-8?B?SUFpYjRqZGwxOStFZkVYU2I0OU03elBlRjdNaE0wT1JRczF1RGhKRXVGZENl?=
 =?utf-8?B?UklUbUMvVVVFSGVVQUZKR3hRWEhldVA2RTdrZGZOdEhaYkx1cWZtWlg2cisw?=
 =?utf-8?Q?ojUzJbQ91EqvBrB1j9EauFlrM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337a1ca4-bd1e-4088-5e68-08dd5fe93c4d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:35:50.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bjZxKn6wStHRWfw36YxVi83vkooPTmqohh69Ip3ctZjq7YR20vyJ3wXnirXr2hk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

On 10 Mar 2025, at 4:54, Hugh Dickins wrote:

> On Thu, 6 Mar 2025, Zi Yan wrote:
>> On 5 Mar 2025, at 17:38, Hugh Dickins wrote:
>>> On Wed, 5 Mar 2025, Zi Yan wrote:
>>>> On 5 Mar 2025, at 16:03, Hugh Dickins wrote:
>>>>>
>>>>> Beyond checking that, I didn't have time yesterday to investigate
>>>>> further, but I'll try again today (still using last weekend's mm.git)=
.
>>>>
>>>> I am trying to replicate your runs locally. Can you clarify your steps
>>>> of =E2=80=9Ckernel builds on huge tmpfs while swapping to SSD=E2=80=9D=
? Do you impose
>>>> a memory limit so that anonymous memory is swapped to SSD or make tmpf=
s
>>>> swap to SSD?
>>>
>>> Yeah, my heart sank a bit when I saw Andrew (with good intention) askin=
g
>>> you to repeat my testing.
>>>
>>> We could spend weeks going back and forth on that, and neither of us ha=
s
>>> weeks to spare.
>>>
>>> "To fulfil contractual obligations" I'll mail you the tarfile I send
>>> out each time I'm asked for this; but I haven't updated that tarfile
>>> in four years, whereas I'm frequently tweaking things to match what's
>>> needed (most recently and relevantly, I guess enabling 64kB hugepages
>>> for anon and shmem in addition to the PMD-sized).
>>>
>>> Please don't waste much of your time over trying to replicate what
>>> I'm doing: just give the scripts a glance, as a source for "oh,
>>> I could exercise something like that in my testing too" ideas.
>>>
>>> Yes, I limit physical memory by booting with mem=3D1G, and also apply
>>> lower memcg v1 limits.
>>>
>>> I made a point of saying "SSD" there because I'm not testing zram or
>>> zswap at all, whereas many others are testing those rather than disk.
>>>
>>> swapoff, and ext4 on loop0 on tmpfs, feature in what I exercise, but ar=
e
>>> NOT relevant to the corruption I'm seeing here - that can occur before
>>> any swapoff, and it's always on the kernel build in tmpfs: the parallel
>>> build in ext4 on loop0 on tmpfs completes successfully.
>>
>> Thanks for the scripts. I kinda replicate your setup as follows:
>>
>> 1. boot a VM with 1GB memory and 8 cores;
>> 2. mount a tmpfs with huge=3Dalways and 200GB;
>> 3. clone the mainline kernel and use x86_64 defconfig (my gcc 14 gives
>>    errors during the old kernel builds), this takes about 2GB space,
>>    so some of tmpfs is already swapped to SSD;
>> 4. create a new cgroupv2 and set memory.high to 700MB to induce memory
>>    swap during kernel compilation;
>> 5. run =E2=80=9Cwhile true; do echo 1 | sudo tee /proc/sys/vm/compact_me=
mory >/dev/null; done=E2=80=9D to trigger compaction all the time;
>> 6. build the kernel with make -j20.
>>
>> I ran the above on mm-everything-2025-03-05-03-54 plus the xarray fix v3=
,
>> folio_split() with your fixes, and Minimize xa_node allocation during
>> xarry split patches. The repo is at: https://github.com/x-y-z/linux-dev/=
tree/shmem_fix-mm-everything-2025-03-05-03-54.
>>
>> It has ran over night for 30 kernel builds and no crash happened so far.
>> I wonder if you can give my repo a shot.
>
> Thanks for trying, I hope you didn't waste too much time on it,
> I was not optimistic that it could be adapted easily.
>
> You appeared to be suggesting above that I try your setup, which did
> not reproduce the corruption, instead of mine which did.  And later you
> appeared to conclude that all is good because you saw no corruption.
>
> No. I continued with my setup (working on mm-everything-2025-03-08-00-43)=
,
> have now root-caused the corruption, and have the fix: as so often,
> it is obvious in retrospect.
>
> After looking at enough of the fixdep failures and their .o.d files,
> I found them consistent with seeing the head page of a large folio
> in place of its first tail (presumably while racing a split).
>
> And the debug patch to filemap_get_entry() below (not something we want
> to go into the tree, but good for confirmation - maybe it will even
> show warnings on your setup) confirmed that - well, head in place of
> first tail was the majority of cases, but head in place of any tail
> in general.
>
> There's a race between RCU lookup of the xarray and your splitting.
> That's something that normally the xas_reload(&xas) check guards
> against, but it was not effective.
>
> I wasted a day getting it exactly back to front: I thought the problem
> was that __split_unmap_folio() needed to __xa_store the former tail
> before unfreezing it; but the patch reversing that ordering still
> issued some warnings.
>
> No, it's that __split_unmap_folio() must not unfreeze the original
> head until all the xa slots which used to point to it have been
> updated with their new contents (as __split_huge_page() always did).

Right. It becomes very clear after I see your debug code in
filemap_get_entry(). The folio_try_get() will get the origin_folio
after it is unfrozen meanwhile the remaining after-split folios have not
been inserted into page cache entries.

Thanks a lot for teaching me about this. I will add comments with
your fixes and send a patch soon.

>
> I've taken the liberty of simplifying the unfreeze calculaton in terms
> of mapping and swap_cache, as we did elsewhere (and after fiddling
> around with the comment above it, just dropped it as adding nothing
> beyond what the code already does).

Looks good to me.

>
> And there's one other, unrelated change in there: I've changed the
> folio_put() after __filemap_remove_folio() to folio_put_refs().
> I believe that is what's correct there, but please check carefully:
> I'm a little worried that my testing (which I expect to be exercising
> that "beyond EOF" case plenty) has run well both before and after that
> change, whereas I thought there should be a noticeable leak of memory
> while it was just folio_put().

You are right here. I will send a fix for mainline as well. It can be
only be triggered when a filesystem, like XFS, with a block_size that
is >page_size for mainline.

>
> Or maybe my testing is barely exercising anything more than uniform
> splits to 0-order, in which case there's no difference: I imagine
> your selftests (I've not tried them) will do much better on that.

My selftests might be able to reveal it after tons of repeated runs
due to leaked large tail folios.

Thanks again for all your help.

>
> Please fold in the mm/huge_memory.c mods if you are in agreement.
>
> Signed-off-by: Hugh Dickins <<hughd@google.com>
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index f7281ad22743..34b4fdafec40 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1871,6 +1871,15 @@ void *filemap_get_entry(struct address_space *mapp=
ing, pgoff_t index)
>  		folio_put(folio);
>  		goto repeat;
>  	}
> +
> +	if (mapping->host /* filter out swap cache */ &&
> +	    /* !folio_contains(folio, index), but that requires lock */
> +	    WARN_ON(index - folio->index >=3D folio_nr_pages(folio))) {
> +		pr_warn("Mismatched index:%#lx\n", index);
> +		dump_page(&folio->page, NULL);
> +		folio_put(folio);
> +		goto repeat;
> +	}
>  out:
>  	rcu_read_unlock();
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3e05e62fdccb..be0c9873019c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3787,18 +3787,13 @@ static int __split_unmapped_folio(struct folio *f=
olio, int new_order,
>  						MTHP_STAT_NR_ANON, 1);
>  			}
>
> -			/*
> -			 * Unfreeze refcount first. Additional reference from
> -			 * page cache.
> -			 */
> -			folio_ref_unfreeze(release,
> -				1 + ((!folio_test_anon(origin_folio) ||
> -				     folio_test_swapcache(origin_folio)) ?
> -					     folio_nr_pages(release) : 0));
> -
>  			if (release =3D=3D origin_folio)
>  				continue;
>
> +			folio_ref_unfreeze(release, 1 +
> +					((mapping || swap_cache) ?
> +						folio_nr_pages(release) : 0));
> +
>  			lru_add_page_tail(origin_folio, &release->page,
>  						lruvec, list);
>
> @@ -3810,7 +3805,7 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
>  					folio_account_cleaned(release,
>  						inode_to_wb(mapping->host));
>  				__filemap_remove_folio(release, NULL);
> -				folio_put(release);
> +				folio_put_refs(release, folio_nr_pages(release));
>  			} else if (mapping) {
>  				__xa_store(&mapping->i_pages,
>  						release->index, release, 0);
> @@ -3822,6 +3817,9 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
>  		}
>  	}
>
> +	folio_ref_unfreeze(origin_folio, 1 +
> +		((mapping || swap_cache) ?  folio_nr_pages(origin_folio) : 0));
> +
>  	unlock_page_lruvec(lruvec);
>
>  	if (swap_cache)


Best Regards,
Yan, Zi

