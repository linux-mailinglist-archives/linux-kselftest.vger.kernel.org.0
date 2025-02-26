Return-Path: <linux-kselftest+bounces-27658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA5A46CD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD08F3AF372
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6D2512CF;
	Wed, 26 Feb 2025 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oP47Lzba"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58052505B0;
	Wed, 26 Feb 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603519; cv=fail; b=lohdkl+HPXBnLEhvm7GccXwwl+ybdPgHxYso29ix0dQbbFUIm9uoGjJjkQ/hhV7VP54gs8zYwUQvMVpmt3CaJnkcuiCDSb/yNYb2d4jB4E398w0D1jjCLfuw4G1Fir3XzxgTOodfKKpK2pDSys+hm4acrBSKhiEzG/75Bcx/M0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603519; c=relaxed/simple;
	bh=Zauzl7D9KY7UZ6ie6wjatn7qeh00qXcsLGM5+x/BFEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HnVNYKzP9DqS+xPGseDzdo1s5WNZZ6pfXpRGneenrEp5BiVv2TvQAxpv5XtOqwrELpiPIDWvbj8HeRIh9T1QkQ4P9B5D3XNZk6qY3WWvC8hny9h0H74oRuKI0aApcPtRaUnfc7y5f6BZZ5y/HTobQbCDQ6tJtdakeXbly3RECug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oP47Lzba; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnMqemAWbKFbX/d9KILrl9ho9p/21ZZVOSb+1UK0AOdjURvPmPurKlIhIKTswaATngYJY9R8IvBzSGTeaOVL+I5AS5SYDPyfJBlisze47aX/e9Jrwatq5NALshGfgbIkvpwOPnn7T2H8Sx61VHjA1fBITJ9/a61En4pu1oMoic/rH57lQtsWgiR6N2OfdyGv83LaUidUflbQF2TgzHhiTRpM7BRu26a89Az5GLfe8+XnqLPiRToLDUNp4gANCnB2bLRNMqx6sW0yr2j3pChboCppUoIvCi00BmdjH3Ub2KTjASDyPbdEqJHIIhTDltUUd+EjlYb968ZAKLMyAXOeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS7cR0Og92s9+LwWb62Jw2gKHeRJ2nbLjD6ykMVERn4=;
 b=MOtk8WDYZ+9++veadHZ5/EHqnzLYN2KddxntPt8APWdgrfaILGtxCYy3eZ2bADbPl8UcVFDbSIZpFbd7M/XMWV2cJUS/XK+QE/sIRB/ittcnoimnO6VZ/ezqXIXilFVKfftJgD3oiSQQgL15Htw1J1kocYtDu4UImzhoZULsc9ULv2AOpsBvrrRquPiH+nzjSaG6fxmWJ0y1xkHqqj6boKpueOwWZGaVdIYTiXUP9QawZUmTMIM59aFyCZuJImZBO1REdDJYOM5SjxfTAYcPqB6GSUXqNyLmC+wBpTj+L0sgUEnWd2JsjxWLg9/giTAQQCpDc3gUWixEGc9iSGmqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS7cR0Og92s9+LwWb62Jw2gKHeRJ2nbLjD6ykMVERn4=;
 b=oP47Lzbahxlg4ZS0HphGnb1uJEqBlGP6yq3Vsc91E9rKKnRbJSt7kScjOLF4hYMZf0zhQBdowu7Vl3NslP0vkCBjb5RfmdHrtb4NRXRkDHAfaa+JB8jcPnC2VrrrIKKG9GO5T4Zy2b0qymO8KUBcLsKL2+BJqTzKhg4ZEUVkapkKxSgvd0bZ1Us4bXefK6QQVJU0l2WXtaT0q+hEvp7wMN5xybnFKwmVv7P0Fo45jOONP8tbWJkQ7Gi4kkyEomUGhAUQP4OeNCGaiJUFsCLV5kastEopNncMfQagrO3GF0B5o7LEaL8mUBzRUuAu9gjn6xiN9X2uDcCnRK34dPheXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ5PPF01781787B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::986) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Wed, 26 Feb
 2025 20:58:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 20:58:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] xarray: add xas_try_split() to split a multi-index
 entry
Date: Wed, 26 Feb 2025 15:58:28 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <17AC91C3-4660-4559-A25F-EC64589AD7E7@nvidia.com>
In-Reply-To: <3cda74d5-ae82-4f7b-844f-b14e146dc60a@linux.alibaba.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
 <20250218235012.1542225-2-ziy@nvidia.com>
 <e5d967b9-fbc0-497f-a4a4-6f2bdc902400@linux.alibaba.com>
 <8FC0353E-EB2D-4C4C-B96D-8BEC06FE77F7@nvidia.com>
 <3cda74d5-ae82-4f7b-844f-b14e146dc60a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dc35a2-a1fd-4b01-0309-08dd56a8544a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDcxdWRzTUF1MllNNE01SDNkMktvKzdmQjRNVzJTV0E2RVcxQnIrekRxZWNX?=
 =?utf-8?B?VXZQLzJmOG5TZi9uYTZ6MnRJMkFvTUF3eHZoc0R6eFBQU0R5SmVyanlKZ1F2?=
 =?utf-8?B?bVR4bEF2eHJKWERUdUJkSDVndVp2ekEzZEVneTVJbEtYU1RXL2VKMVdtZXlu?=
 =?utf-8?B?YUNSZFNpYUVqS2hMUVQwL2RKQlFrckRWZFNuWSs5UVhFeDVaU01QZXgyT3Uy?=
 =?utf-8?B?M3hXQkFlMTN4UVZNaGhVdEJjUS9sQWg5cFY2MWIxRlc5ME4wOHk5bWcyNVlT?=
 =?utf-8?B?ZjZZOFk2SldPMCt4Rk04ZVc5UVpPcXRNNDdRcjNKZ3NDam56U01lQWR2eU4w?=
 =?utf-8?B?eHMvOXlJYU5ZdWd0U0E4V1EvenRWRkhEM0h4L1k5d3V2UjMyQVJwYXAyRVBi?=
 =?utf-8?B?K09JNHRDMjg2QUlLQnNqd2g2ZzdLdFlhM1Q0M21UUmJPWTA5M3VhOFRudEZ4?=
 =?utf-8?B?QzlWd2VDTzBDd1ROT216WWlReVNEcUZhSWNiNDZLL1lLS3VJMjZ0cGpReHBE?=
 =?utf-8?B?WVc5YXBNUHRIN3ZLeENnT1YybXAwRDE0bzhpb1JHSmJrWHp1MWdkdUZMMCtG?=
 =?utf-8?B?cW1DZkFYSjNVdUdOMTZYY1lZRC9XQjFkUFpIM2w4SENwc29yak12eUQ0dU9j?=
 =?utf-8?B?SW9JNlZLMVN6MFpHZ0ZIVWZHcmxLMDZON0F4aHdLdmxGYS9IclZDMExmb1NL?=
 =?utf-8?B?YktOS25UK20vbU53OUZhMDgveG5lZ1UzSm1ycCtCbnRCMEpyRHlRQVZ2YzFS?=
 =?utf-8?B?cERiUTE1VkY5NFF6M1dCUlUxTHlGRm02S1I3ZlZITnRmM3VEREdSUG5YZjc1?=
 =?utf-8?B?L3ljbU9JUWNHTXJ2dmJvVDlmdGtzMnVtZUdjZVlvZTVJTXFWTW5GUXFIVTg0?=
 =?utf-8?B?RU5Pa2xuMXJuZDBjSk9YUm9XcmZzTHRDYUF4N0NQU2w1VjRmdzNYOUJwTEhV?=
 =?utf-8?B?UDNyczZKU2lwNW1pWDBaNjRLQzJvN0dTU2JCMURVVG5uTUxMMzlmTTgvMUR6?=
 =?utf-8?B?MCtFSXJPMkMxRXpPWEh3RFZNeFMrYVlta2YwakthMUczejZDNFJlbmNmSHJM?=
 =?utf-8?B?UjQ1MmFyVXZMc2Z2S2d4UDl4dVhEUGZOR21JY1RETkVWZFN5MjFQL2NlN0tx?=
 =?utf-8?B?bC96MTVoKy82eHcvOEkra1BQTlR0S1RVc3YzRzd3blgzdG12WG1ibng5Y2lP?=
 =?utf-8?B?TGhoRitkaG5PNVR2OFh6dERDWW5KQ0lsMkxNb2Y2d1ZOSjYxOGpPcHk2bVp0?=
 =?utf-8?B?Z3BDWkVaYStZTUdQWGorK2hia2tadDVTTGlna3BSZXhMcTkyaWdNSGFjejd1?=
 =?utf-8?B?eEZFUVFsWE1WMkcwT2Q1L01lMnB4dWpPZCtvb0k2V1htTTFBbHRFQWRkVnNp?=
 =?utf-8?B?cDM0MGRSRG9KSlRUVEc3SDQ3NmtOS3RaanF5Q0lIemdycGNTZFNoSDFIVEFF?=
 =?utf-8?B?QlE4NFdhcWJNV2lQMEZkWTdzL2s5TW5CbGhjejBmSk52MW9nc1lqajc1aTRp?=
 =?utf-8?B?TVVyUGlxY3h6aithOVVDZS9sZWc4YXQwT3FtaGQ1QytsTitGYmY4bDI5eWxx?=
 =?utf-8?B?SUdnZFcwV1hDRUYzNVVnaFp2U2FRS2RzL1JLT1p6WEl5VkUzT0dnOHp0VVVX?=
 =?utf-8?B?MVJ0UUlpSDNmcjM3YUhMMXp5WU1hK2RYYVdqU3YxbUF6bzFtYnVtY3lla2ZR?=
 =?utf-8?B?Zi95NUc0R0Z2ZktOZHdjbDZYbjVWRjhiWmlxV3pIMm9kbkxudDJEalhiYWVC?=
 =?utf-8?B?OUJyTm5hZnhYZUU0a1BSbEdsdmpITDNLejJrUnhzMEpxMW1icm5UbnZpTk1q?=
 =?utf-8?B?Qi9wa09BZWJQa1M1QUQvdkljdW00cy9FbjNlM1pjWTJFbVFrYlpxRHQwZjZI?=
 =?utf-8?Q?ZS+xk7RBMwdtV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlhpWXV0Y2pnZFFKTHl0S1VWTSs0VUhESTFIbnd6a2tmUk1kbkJiYzlVc3U0?=
 =?utf-8?B?S2lrZ1IyaCs2OStVQytBb2ZoUyszV29GMnNCSm16a1dUbXJWL0FXNmN1MnVQ?=
 =?utf-8?B?Y2NRRTBZaUNDaWZGcFVaSUVyQllSUjRuYnk0RG0rR01pQ1U3eUExRERJamh5?=
 =?utf-8?B?Zm5peGxML2M4bWYrc3JhcHZrWnlsL0VXOUJFeVc3Mjg2cTRzeXA1TnUrRS9k?=
 =?utf-8?B?Sm1oRERpNW40YXloeXU1bXBiMkxHT2MrTUV3WlZvUUZvcnEvRzhtMGo1bUIz?=
 =?utf-8?B?WjloTU1PeDNlbWVFa2orcnFrWDRVQjlUeHVIdEpCV3VPY2F1dkhrSkhrcUZN?=
 =?utf-8?B?amVZZ0NIaFRuSXN3b29uL21lRWRZRTdDdW5KQ3pvQUJnUzVmWkxFTUpsSTYw?=
 =?utf-8?B?VGZNcXpjTnFaVmdXWnFaaVFYbDNoeGdxdk45SGl1cVNSWHl3K2t3dEpSUDZ6?=
 =?utf-8?B?alJubm5pVnNQRkpjcWY3ZXNQYWNlOUZmV3lsb0Vxc2gwdFV3RFh0RUR0elpq?=
 =?utf-8?B?d2RYajZBTGQ5MTZiTG9lSU1kQXhYOFBvQnRncUFKZE5LV0lDb0ZKNU5qNkFD?=
 =?utf-8?B?RkdNY0l2c0Q1aHNsYURxZnZjcDA4N01lenhBSEJJOG1YT2lwNmMvRzZKNnUw?=
 =?utf-8?B?cmVpVkREYnRaUnZFV2haZXRCVzhpNW9raHpKN0VERmxuUUtzOHBBTmtiSjNI?=
 =?utf-8?B?c2lpYXdMeDNGVktwUGFJUHQyMFVjMzRoTUcrVzJkaytHd3BTMU11UFZvV09G?=
 =?utf-8?B?L2xDRytCQm1IT2tiRzFiVTloeng3dGY0K1pZZThLc05hUldZWEUvYnlNTnBt?=
 =?utf-8?B?WnZlWUNkcVFOQW50NjlJbGg5enlsbWQ4Mlo1ck8rS1hTQW1CS2srT3ZVcURR?=
 =?utf-8?B?ME9kb0VFSjlzVDRUOTRsRUxHUW9Fem84cmZPdFBDR2lJMzU2Mk53RzNxSnB0?=
 =?utf-8?B?ZVF5NmJiQUE1YmxmVllrSUdLdGpDZ1ROOUl4NmdobXBQeFdYNUFKenRqaVZn?=
 =?utf-8?B?Rnp6R0l6QkJlR0RBcDVEQjlKZFhlOHV0S1IyZE9zd1kvMGRjL1JtOVU0UWZX?=
 =?utf-8?B?cW01ckN4ZVhLb0grYVFkdUp5b2dENERuNjRkTmFlVExvVWQ1OWd2MEg2SVhw?=
 =?utf-8?B?bHNUamxYK2VxQ0VVUEU5MXZXQS9hZHY3MlJSS2c4UXQ1L3krbGdIQy9VdFRq?=
 =?utf-8?B?dnJtd3dWc2FJM3BxQzgxVGhMV2JMMnhGSUJKQzdTVjRCZk55SFVPRExkNjIr?=
 =?utf-8?B?K1JYSDViSE1yV2pSbUlHQVpBeUMwc1UwcU1uUGxCQWhGNlJoaWFNUWh0ekVo?=
 =?utf-8?B?ampDR1IzaForVFcvVFM5QVcwbXhhR2RVb01iQitnY0oyazlYbFdGMXhITFU3?=
 =?utf-8?B?bmU3OUozMnJyRWR4ekpHdXNoYml3ci9iNjVVN0dsUWh0Ny9pMFI1TGRNQzZE?=
 =?utf-8?B?TmJQZm5OY29xOG9ZTGQ5VzlLdlRYTW0xcnZ3U2hFbmN0d3Z6ZTFrR1VtMTU3?=
 =?utf-8?B?ZmV0eUJmM2tPeEIwTmpyMVdCc0xxNXFxV3U3ZGxaVmI4L1FVem1ZNkVMeHVQ?=
 =?utf-8?B?WmpkcFF6bUpYdmg4eE1WQ05hL1FTM3Y0dDZjcjVtUGhiVWxycldNbWpqSzlQ?=
 =?utf-8?B?M054eS8rQUtZdVdneFJTcWJBSXF1d2tJYTdyVy80eUtqbys2OXhUMlRDYzJR?=
 =?utf-8?B?cEU2Zll0UjVENERKSFJOMjJGRW00aEIzbGgzTXpWT3daUXlobWJ2Rnk2YTJo?=
 =?utf-8?B?MENKVDR2QUdlVGxlM1U3cGI1MXpGUXNZSjlWd0xoQ2QwQXRTcHp2QWhjL24w?=
 =?utf-8?B?OFNoblcxbG9CMVVMTjNMd2tCZmRaVmtscDk2bGxzOGFIbHZzZ1pZeHlkRnJB?=
 =?utf-8?B?MXJCQXpwaU5PTGdWOWtwT2Z6amtSd1ltNDM2YVowd0pYVEpTd0t5b0E2WDQ1?=
 =?utf-8?B?QjU1QTJrbWI3VzZ6d1JBOWtwZGl2L2JFbnR0V1gwSkdWdmVFazcxWTgrUFpk?=
 =?utf-8?B?NmNDZit4MlVxOWRqeitESkM5Tm1Udlh1ZUU0SEVmUjc1ck5hRFdoYzh1ZVpM?=
 =?utf-8?B?VEVBSjR4cDlIbzZzTFdmT1g4eWVURlBUQnp0dWM3MlZheXhQNzkvZkQzL3dZ?=
 =?utf-8?Q?zAwet+bHyhHSIc8bTP5w2lddJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dc35a2-a1fd-4b01-0309-08dd56a8544a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:58:32.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWwiExY66jbGWMBPgA/5mXXh6o5j7LWLITEgX/xfQ4Lh/SdIcHl+Kh+SwtkeK1VK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B

On 26 Feb 2025, at 10:07, Baolin Wang wrote:

> On 2025/2/26 23:00, Zi Yan wrote:
>> On 26 Feb 2025, at 2:11, Baolin Wang wrote:
>>
>>> Hi Zi,
>>>
>>> On 2025/2/19 07:50, Zi Yan wrote:
>>>> A preparation patch for non-uniform folio split, which always split a
>>>> folio into half iteratively, and minimal xarray entry split.
>>>>
>>>> Currently, xas_split_alloc() and xas_split() always split all slots fr=
om a
>>>> multi-index entry.  They cost the same number of xa_node as the
>>>> to-be-split slots.  For example, to split an order-9 entry, which take=
s
>>>> 2^(9-6)=3D8 slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), =
8
>>>> xa_node are needed.  Instead xas_try_split() is intended to be used
>>>> iteratively to split the order-9 entry into 2 order-8 entries, then sp=
lit
>>>> one order-8 entry, based on the given index, to 2 order-7 entries, ...=
,
>>>> and split one order-1 entry to 2 order-0 entries.  When splitting the
>>>> order-6 entry and a new xa_node is needed, xas_try_split() will try to
>>>> allocate one if possible.  As a result, xas_try_split() would only nee=
d
>>>> one xa_node instead of 8.
>>>>
>>>> When a new xa_node is needed during the split, xas_try_split() can try=
 to
>>>> allocate one but no more.  -ENOMEM will be return if a node cannot be
>>>> allocated.  -EINVAL will be return if a sibling node is split or casca=
de
>>>> split happens, where two or more new nodes are needed, and these are n=
ot
>>>> supported by xas_try_split().
>>>>
>>>> xas_split_alloc() and xas_split() split an order-9 to order-0:
>>>>
>>>>            ---------------------------------
>>>>            |   |   |   |   |   |   |   |   |
>>>>            | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>>>            |   |   |   |   |   |   |   |   |
>>>>            ---------------------------------
>>>>              |   |                   |   |
>>>>        -------   ---               ---   -------
>>>>        |           |     ...       |           |
>>>>        V           V               V           V
>>>> ----------- -----------     ----------- -----------
>>>> | xa_node | | xa_node | ... | xa_node | | xa_node |
>>>> ----------- -----------     ----------- -----------
>>>>
>>>> xas_try_split() splits an order-9 to order-0:
>>>>      ---------------------------------
>>>>      |   |   |   |   |   |   |   |   |
>>>>      | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>>>      |   |   |   |   |   |   |   |   |
>>>>      ---------------------------------
>>>>        |
>>>>        |
>>>>        V
>>>> -----------
>>>> | xa_node |
>>>> -----------
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
>>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Yang Shi <yang@os.amperecomputing.com>
>>>> Cc: Yu Zhao <yuzhao@google.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    Documentation/core-api/xarray.rst |  14 ++-
>>>>    include/linux/xarray.h            |   7 ++
>>>>    lib/test_xarray.c                 |  47 ++++++++++
>>>>    lib/xarray.c                      | 138 ++++++++++++++++++++++++++-=
---
>>>>    tools/testing/radix-tree/Makefile |   1 +
>>>>    5 files changed, 190 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-ap=
i/xarray.rst
>>>> index f6a3eef4fe7f..c6c91cbd0c3c 100644
>>>> --- a/Documentation/core-api/xarray.rst
>>>> +++ b/Documentation/core-api/xarray.rst
>>>> @@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index =
entry will set the
>>>>    entry at every index to ``NULL`` and dissolve the tie.  A multi-ind=
ex
>>>>    entry can be split into entries occupying smaller ranges by calling
>>>>    xas_split_alloc() without the xa_lock held, followed by taking the =
lock
>>>> -and calling xas_split().
>>>> +and calling xas_split() or calling xas_try_split() with xa_lock. The
>>>> +difference between xas_split_alloc()+xas_split() and xas_try_alloc() =
is
>>>> +that xas_split_alloc() + xas_split() split the entry from the origina=
l
>>>> +order to the new order in one shot uniformly, whereas xas_try_split()
>>>> +iteratively splits the entry containing the index non-uniformly.
>>>> +For example, to split an order-9 entry, which takes 2^(9-6)=3D8 slots=
,
>>>> +assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() nee=
d
>>>> +8 xa_node. xas_try_split() splits the order-9 entry into
>>>> +2 order-8 entries, then split one order-8 entry, based on the given i=
ndex,
>>>> +to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 e=
ntries.
>>>> +When splitting the order-6 entry and a new xa_node is needed, xas_try=
_split()
>>>> +will try to allocate one if possible. As a result, xas_try_split() wo=
uld only
>>>> +need 1 xa_node instead of 8.
>>>>     Functions and structures
>>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>>>> index 0b618ec04115..9eb8c7425090 100644
>>>> --- a/include/linux/xarray.h
>>>> +++ b/include/linux/xarray.h
>>>> @@ -1555,6 +1555,8 @@ int xa_get_order(struct xarray *, unsigned long =
index);
>>>>    int xas_get_order(struct xa_state *xas);
>>>>    void xas_split(struct xa_state *, void *entry, unsigned int order);
>>>>    void xas_split_alloc(struct xa_state *, void *entry, unsigned int o=
rder, gfp_t);
>>>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int or=
der,
>>>> +		gfp_t gfp);
>>>>    #else
>>>>    static inline int xa_get_order(struct xarray *xa, unsigned long ind=
ex)
>>>>    {
>>>> @@ -1576,6 +1578,11 @@ static inline void xas_split_alloc(struct xa_st=
ate *xas, void *entry,
>>>>    		unsigned int order, gfp_t gfp)
>>>>    {
>>>>    }
>>>> +
>>>> +static inline void xas_try_split(struct xa_state *xas, void *entry,
>>>> +		unsigned int order, gfp_t gfp)
>>>> +{
>>>> +}
>>>>    #endif
>>>>     /**
>>>
>>> [snip]
>>>
>>>> diff --git a/lib/xarray.c b/lib/xarray.c
>>>> index 116e9286c64e..b9a63d7fbd58 100644
>>>> --- a/lib/xarray.c
>>>> +++ b/lib/xarray.c
>>>> @@ -1007,6 +1007,31 @@ static void node_set_marks(struct xa_node *node=
, unsigned int offset,
>>>>    	}
>>>>    }
>>>>   +static struct xa_node *__xas_alloc_node_for_split(struct xa_state *=
xas,
>>>> +		void *entry, gfp_t gfp)
>>>> +{
>>>> +	unsigned int i;
>>>> +	void *sibling =3D NULL;
>>>> +	struct xa_node *node;
>>>> +	unsigned int mask =3D xas->xa_sibs;
>>>> +
>>>> +	node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, g=
fp);
>>>> +	if (!node)
>>>> +		return NULL;
>>>> +	node->array =3D xas->xa;
>>>> +	for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>>>> +		if ((i & mask) =3D=3D 0) {
>>>> +			RCU_INIT_POINTER(node->slots[i], entry);
>>>> +			sibling =3D xa_mk_sibling(i);
>>>> +		} else {
>>>> +			RCU_INIT_POINTER(node->slots[i], sibling);
>>>> +		}
>>>> +	}
>>>> +	RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>>>> +
>>>> +	return node;
>>>> +}
>>>> +
>>>>    /**
>>>>     * xas_split_alloc() - Allocate memory for splitting an entry.
>>>>     * @xas: XArray operation state.
>>>> @@ -1025,7 +1050,6 @@ void xas_split_alloc(struct xa_state *xas, void =
*entry, unsigned int order,
>>>>    		gfp_t gfp)
>>>>    {
>>>>    	unsigned int sibs =3D (1 << (order % XA_CHUNK_SHIFT)) - 1;
>>>> -	unsigned int mask =3D xas->xa_sibs;
>>>>     	/* XXX: no support for splitting really large entries yet */
>>>>    	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <=3D order))
>>>> @@ -1034,23 +1058,9 @@ void xas_split_alloc(struct xa_state *xas, void=
 *entry, unsigned int order,
>>>>    		return;
>>>>     	do {
>>>> -		unsigned int i;
>>>> -		void *sibling =3D NULL;
>>>> -		struct xa_node *node;
>>>> -
>>>> -		node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, =
gfp);
>>>> +		struct xa_node *node =3D __xas_alloc_node_for_split(xas, entry, gfp=
);
>>>>    		if (!node)
>>>>    			goto nomem;
>>>> -		node->array =3D xas->xa;
>>>> -		for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>>>> -			if ((i & mask) =3D=3D 0) {
>>>> -				RCU_INIT_POINTER(node->slots[i], entry);
>>>> -				sibling =3D xa_mk_sibling(i);
>>>> -			} else {
>>>> -				RCU_INIT_POINTER(node->slots[i], sibling);
>>>> -			}
>>>> -		}
>>>> -		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>>>>    		xas->xa_alloc =3D node;
>>>>    	} while (sibs-- > 0);
>>>>   @@ -1122,6 +1132,102 @@ void xas_split(struct xa_state *xas, void *e=
ntry, unsigned int order)
>>>>    	xas_update(xas, node);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(xas_split);
>>>> +
>>>> +/**
>>>> + * xas_try_split() - Try to split a multi-index entry.
>>>> + * @xas: XArray operation state.
>>>> + * @entry: New entry to store in the array.
>>>> + * @order: Current entry order.
>>>> + * @gfp: Memory allocation flags.
>>>> + *
>>>> + * The size of the new entries is set in @xas.  The value in @entry i=
s
>>>> + * copied to all the replacement entries. If and only if one xa_node =
needs to
>>>> + * be allocated, the function will use @gfp to get one. If more xa_no=
de are
>>>> + * needed, the function gives EINVAL error.
>>>> + *
>>>> + * Context: Any context.  The caller should hold the xa_lock.
>>>> + */
>>>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int or=
der,
>>>> +		gfp_t gfp)
>>>
>>> The xas_try_split() may sleep if =E2=80=98gfp=E2=80=99 flags permit whi=
le holding the xa_lock, which can cause issues. So can we add a check for t=
he =E2=80=98gfp=E2=80=99 or only use GFP_NOWAIT?
>>
>> You mean only allow gfp to be GFP_NOWAIT or GFP_ATOMIC?
>
> Yes.

After discussed with Matthew, I think it is better to use GFP_NOWAIT in
xas_try_split() and user can use xas_nomem() if xas_try_split() fails to
allocate a xa_node. So I will remove gfp in the parameter.

I also discovered a bug in xas_try_split() when a xa_node is allocated
from xas_nomem(), during my refactoring. Basically, the xa_node from
xas_nomem() is not initialized for split, namely node->slots is not
set correctly, so using that node in xas_try_split() corrupts xarray.
This bug does not affect this series, but Minimize xa_node allocation
during xarry split series.

I will send out new versions of both series.


Best Regards,
Yan, Zi

