Return-Path: <linux-kselftest+bounces-28412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D029A55112
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF0F18991B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5521ABB1;
	Thu,  6 Mar 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPxiJGe/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6723C8C7;
	Thu,  6 Mar 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278460; cv=fail; b=PpDFDha6EABztdLQ3rD/TaelA8Ydq1bDrHQUnJgL7Q+j9RPn9ZX9EonF9sGF/Ezp03TF3ROxHBift07bNiOVPPv/wG4DgwNfgzM6NXpGm+oVDROIKwBVSG11+aIi/Ykjy3LmW6ubgGcNDw6tYuKZb813c9Lf27RIRTTM3ZRzZ6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278460; c=relaxed/simple;
	bh=RLnApVZntdMEFfpi2f+rCbFUCMQLTEl7TLaIUckqYgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzH0ACPxWNGxSbQHUJJ8wUB7t+mEx+Uv3TmbBMpe5y0SxGPsSpUxu21SjO6opo6MWoMXmKhiLJMD0ZX72x4fh4LNo12+Mwg+7WniooozajqJcypKTgdtvnFZM9izVAXPnDZIV9cnPxwEF2DYHvhAqyCzk2fh001iv+b3G1V33W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPxiJGe/; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xiex+oZXV9CJAR0sfmk01DSZTJ3bdVc3VgyK2wxwwWbbPGOVF9yuxsHBlOEcGGVprV9ef/tUSHl+7UOhz924An7O0NpvuKWFMe5knJUYYsKbpsJgqGZ4WUY2vOmATWRGTwQHkBE6bALXXTth8qEhjzDSL0w6Fg4M9BiOHuadDF/EbhYjnoWv1UfOkmvO6aA/c1WOlunNMXnL23cP7rs3BJOEyReBOLB+c5h0ZGbpUqxBM1grQbFv0dwO2pY5nFP+LWRE8h5ne3gi07lQ3yAY4F2hM8OuHwlTyDTrvYJV3FzpsVM2EAo86ROEC+Hk3OZJGlgSKvXAh5nqZ0VC+Xq2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i02xlHgtAQT79rI8JYqMdnotYQBkFFH+qayOl1W6HI=;
 b=N6r4OugpD6oQfLYn5n6l9UWYbZveQrVIudNurocmKoMt6ZKtpa35OnmzXjtxtoJ8Za+Y17CiuRUxkXujAMwME5zz/Mf1q1FasVmH1bZeyLHu5WSFoG6Mm9lU5fZmUAHkzPBgFS2mIyoyY9qgxGpK4Y8/H8DrQxOdJ4pALM9+4BBIXpGGFTzfQrl02HTXxaTczbU1Uq7HKB1zrKiNIZutyhgH4uRv/d1HvNNGueK7rwbmtBVlSowKrqszWrMlVGaDVZkb+4b4zs24POjASuEdMSxsqo8gWG0Po8Hvof8YCXNTQ+z1e3co1/8DHcgr4Mp2clkQD6/zPX5Rpu4AHAnjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i02xlHgtAQT79rI8JYqMdnotYQBkFFH+qayOl1W6HI=;
 b=aPxiJGe/yQWXxZSp+vmuBjdBccAFQcsV9PU9dGr04zlc9UE6bwcx0OQdN/qy4KMkZJ9YNpvgnrvezEfdzzVG8kM2mnYkredo0ZYLfYgXFHFFNm8oI3vXHzmpA5JBhGWrF4HXawsBsXlFjWFttlneAyNB5JABe7rRAJJoGeZfBdNsAd5ZX6qvbAVg1fv0tOVG3iOBtgfYMvJB0X00Q6GpV2Bbc3smUkwdm4icBGy13VXwJjFMlpMz75PuRWp6zOALjKAljzx7oiqPuaXzuePw3v7TLbhRxNJDCUODjhZgda8y5UGS3PrXG1UfGkHIGIUCTbHS/mN+eYn3+0W5NBPadA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 16:27:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:27:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Thu, 06 Mar 2025 11:27:28 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <3E7D36DB-287A-4CC5-9C1C-0E9A35A95B1D@nvidia.com>
In-Reply-To: <4a9f102a-60db-475a-a933-975edb2fb1dd@redhat.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
 <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
 <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
 <4a9f102a-60db-475a-a933-975edb2fb1dd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:408:141::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 25918a4c-98c7-4afc-922b-08dd5ccbcb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGxCQlpTSnZIOG1HOC8zSDRRV2VLOXBHNTQ2TmM1UFlyd0piYVZuK09CT09H?=
 =?utf-8?B?Wmpob3VONDNWbkgzbEtaTXhoUE4rdkVpK0NUZ0RlTTZuUW5qVjFZby94eDR0?=
 =?utf-8?B?Yjl2cm5va2lkZTA0SXExYWszV0duSnd1b2x6MHVIcVFqZjh4Q1dSYWNrd0th?=
 =?utf-8?B?cGRuTlRacjN2QmdUMjBFb0R5bHBLZXVXbmJNMTVxN1FQYzRRZlhGT2Z4azdu?=
 =?utf-8?B?UTVQMUtuM3JLU0RRTGttOFpvM0pGZmNkSzVDY1JhQW9JTk5TYkZvVG1lSnZR?=
 =?utf-8?B?T1RsT28vU1pTdXh3TWtZMEYrWGJqQURFWFlSQ2t6S1diSndVYWJ5OUt4MWRN?=
 =?utf-8?B?Mk1KTlQzcjBzdGNmQmRocGNra0ZQbWlPVTBrU2tmc3h3YVd1aGs1RE1UR3V5?=
 =?utf-8?B?QytQSVo2YklaYytyKzJzMmxPZU1vb0dVVks3SjhDVjNkT1djMnQyY1VlalZD?=
 =?utf-8?B?MUZzeXhJaVVHVGM4c0ZPbnBOTVJsd2t0TGkybEZPejgrQ1d3WmNvRDVMcnF6?=
 =?utf-8?B?R0RBVVBPalVtajQraWd3TW1IeC94ZVJpUzM5T0NLeGlCQ3hDOXhyVndlUWdC?=
 =?utf-8?B?anJvVDFmVkhocllrOCtLb01yeHhpeXNJUyt4cWlicS80VWt4MDIwZmQ1WTJy?=
 =?utf-8?B?TlR3RDR5aW4xc0VENktodGYvTE9jVmw2VW8xSTRseFI5OHVHcVhmQ3JoeERo?=
 =?utf-8?B?TDVINzdvV1d1K1hLUU9BSmsvcGZ2ZVNLcHVwSlRTSU0wei81V3VUWVVCdHY3?=
 =?utf-8?B?TzFQalVJTmgrL2ZiZ05lcEFkeENKUGhQNlFKT3dObGtadVhDdy9HQ21QQ2JF?=
 =?utf-8?B?dXBpam0xeTdqL0ZoYzhTbnp2dWFXK0VRTmZzd1d5c29WdjBPcGgyRzZKQkM1?=
 =?utf-8?B?V3Jxb3BrUkg0VXBCM2ZmRy9IOTdFUzlvSDM2OTA1a3NJeTFmMC9ZS2NDWnVG?=
 =?utf-8?B?TmR5cUk0NjZ4S2kvUXh4Zk1yVU5jcXdSM1FaTTc4UlUxRlVwZ2lCRFkxMDYz?=
 =?utf-8?B?SnhselNiOElpTlpGZHpCeFNZNDBCc2pmdnJqOWdYV0Y2R09qUDJQbXBrNmc0?=
 =?utf-8?B?Yi9jMzR3V3FEYnFKM09Yenc4UlZGODgwVWJFYlhIWDlINEl1V2k5UDJmWWhN?=
 =?utf-8?B?eVdraTZOMWhVamJJcUpFcmtOVDcvNGY4aTd0eVZZY2RXRWVtNFgyRmxMazRt?=
 =?utf-8?B?VHpvRjZzRjFVaHVPM1VVWUdqMithTFJjYkhPbW94VjNOYncvMXJCVFNoSEc4?=
 =?utf-8?B?OHhDVlF6eVJWR1pFTzZ1M3plQzRQV284aGNKYlVTbk1XbThyVC9neTlMQmUv?=
 =?utf-8?B?dC91a0kxZ09jRUZCalRjbEJGNlpJUTFreE50Zmc0UWlHUHM5bjBDc01NNFBo?=
 =?utf-8?B?OFNJTmpjMkVPREJmSkc0eWEwa0pEaUMxNzdEV3cweG00MFRkTlhiOEpieTBt?=
 =?utf-8?B?Sko3TGM3SWg4bnQ5WGNDYVdBb1Ztc1pFcFNyRjJlYWU2Skx3cjBkaXkzVDJi?=
 =?utf-8?B?NWtmZkk0bkFQSmZmb0gvVjFiQlJnbWNrUTlxd3pFZzBVSHVka2gyeWk4dlFO?=
 =?utf-8?B?WmlJbUhNSk02RzFsVUowMzNhbG5pZzNhSmQvMklzamN1L3E2bms2NEtielVa?=
 =?utf-8?B?M3V0dDE3eEVLbFROZ3lDVkpHQVUvd2JESXppd2JlSHcrMzhEZHQ4MHFSUzd1?=
 =?utf-8?B?S05LNUxUdEw0d04vRE1JYVlObkJwdGhreDVDbnZHZVM3RTliLzdqdnVZY0JK?=
 =?utf-8?B?VFEvZXc3WWh6NHpqTms4YzNMOFliTU1SQkFlQWlyUGdLNW40RHF5MUlZR3E4?=
 =?utf-8?B?c3pQY0FHUDJCbjRYN0ppU3dRdUFCcStha2JLT0RJRml1YU1ZK0VaYlMySlQy?=
 =?utf-8?Q?mzuPdM7naipon?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXM2ZjNhdVJjazNLWE42dDAxbWxRZUNkVUNUMkcyQURVbGE1eVhTeXkwTGZL?=
 =?utf-8?B?WnBrRUtHK3pKRlU4aHZnQWV0NjJNOFFjc09ZYTFRNzc1UDhPY3drcFlqSktn?=
 =?utf-8?B?L2l3QVBlQWFqZElibDhrdUI1cC92aWIyQ1FKellkZG1LN2tFdDh0czc0dkFF?=
 =?utf-8?B?dVNDdEVCVjlNWTJHS1FPY00rOHdhQStqZlhlMnluekxkMm8xV2p3TjhUeXZ4?=
 =?utf-8?B?NzFkRFBFUWxVZzFVWUoyeUtiTFZHUjh5eUhnd1BFV2ZhMlIwVDcvcW1peTYr?=
 =?utf-8?B?VTdNeVBQeVcwdk5saXoyWUVleFFxMlIvd2xrczVBR0pjT2o3azJuYUVESmZC?=
 =?utf-8?B?TGx4Z2NPa3dDS3ZpaGlLekVZRkExMFcwejdoeDAvaytzNUx3QmxNTXAraHgv?=
 =?utf-8?B?K253VzN6L2pCNHIvT2FSZEd5Rm4xMXM5Q0VXYUhuOXE0TUl6SUV6d1FVYU9T?=
 =?utf-8?B?S0tHRmYwN2xaazlsTUZWZHdSeURnQ0xiZ1RyMDFVdTNlNmRrbG1wblBEYWh5?=
 =?utf-8?B?cG05QjF3RWwrVTlTdG9DaE85UWFiczBlQVE0dStsVU9veXZGaEMxbE1aS3dS?=
 =?utf-8?B?bFowZWhidzJyWENiam91dUczQ0JrWmpISktqTTB2RHFTSWZJTFVVWWlYK2li?=
 =?utf-8?B?OFRmRHA3OUppdndjdkVPZkpPTkU5S0I1cEtWdFc5WmVObEYwdzV4Z1Y0OTVY?=
 =?utf-8?B?Y0daUFY0MGhPQ0JrTlVHeDZLZ20wZENTQ2lQQlF6OGNDV1djWXhtY0U4V3dX?=
 =?utf-8?B?OXJWb1dXb0Zxc2JMaG1jSTVlUVRTYVQ2b1RuSmlXbXV4clFGWTZRYjhjSWZo?=
 =?utf-8?B?cWFQWlZzRWM5elJ4QkhPQXIvQ21pWE9mQUl6UjhHNjQ5TmZic0FFa0pqTkI2?=
 =?utf-8?B?NndRZUZYYVJRV3pUT25KR0VSeTVnbWl5TTlteGlhWUZ2ci9ncWZOWGhyekFn?=
 =?utf-8?B?Si9XVUY1VkViaGFHa1FvUmo4MmxOUkxIQkZYRkY3U3gvZ3djT0t0eUY4Wk8x?=
 =?utf-8?B?aUFGczI0d3hPY0EzTTh1NGQwSmhMUUVYMkZzK3hGRnFNUldyQXpwS2pGeTdJ?=
 =?utf-8?B?UWZ5dUZldXhQeHZkcEw5NEw1TkhuYTZPSXJad3VTUGlKVEpjRG1uSi9vMG13?=
 =?utf-8?B?d2k3L1phNWYwbnpMeVFvODhXWGhReWEwVW1CcHZKRlRYNW84c2tPQ1N0Mlh5?=
 =?utf-8?B?Qlk4NTEzTHhlejhhTCtGbTByL0NXdy9DZjZDQU5CcEtpTTdyS1hIenZsT3Ro?=
 =?utf-8?B?YUJEelNIYnBNbkpsUWZKM1lhUGpoZXAyRCtmN0IyMVFlWHBKR2cwc0xZcWtr?=
 =?utf-8?B?RjVHc0UrYytxLzJ6N2V4L1NlemFNbTFPQlpEZEJLaWxEaURpQ0NtbGdCOHRO?=
 =?utf-8?B?OUxxbTdWYktKSFp0VUY5U3lrWTF1VExVdHlaSEVpcmFCdWViemZTWkdkRjBF?=
 =?utf-8?B?b1BTcjJlTVQ5S1d2eHFrcDNjRXlvemZnZldKWGVQTGQxWVBNaFBlajV6N3V5?=
 =?utf-8?B?cUJHamFuZ3FCdk94R3p5bXNXeUIrWFRScnRXdjZOSDlmM1pQRUZDaHFHN0ll?=
 =?utf-8?B?M1AzSitFc01CNkUrOW5hNS9xVy9wUVBwN2JzODk1V0hLb3pJV3BUcVNUa0NM?=
 =?utf-8?B?RnJUNHhySXlVQnlwaDlIekpCRUFWQXRTWWVrUVEramgrbUlBRld0bDZUb1JM?=
 =?utf-8?B?bW5kaSsxMVdzSE5MaVFNY2p4THRLejdkYXFCU3FpTzd2S0dlaC85TkN5Ti9I?=
 =?utf-8?B?QmJtYmZiMmNsaFRvazdiNjJOek95M3o4NFUwdG1EU2xFWkNMRXpESzBXSEg2?=
 =?utf-8?B?TFJFMzlJRjZmaGNkSTB0amlFd3BaS2UzUVE1aHRyVnUvQnhpbURqNnp0bGdF?=
 =?utf-8?B?eENFeTlMOWRWZk81MkZibTRVdnh3MllSdnhmSW5VVzQzTk1xdTNWaEh2Yy82?=
 =?utf-8?B?K2tHYStwR252WWY2ODVYREZtY1R4S2ZjWDlNcnEwNzBoazZQYk1JQTVsU3lH?=
 =?utf-8?B?WVRuK2NVaFJ5eVo4d3l6RUJFTklEakxUd05jemFheXdZMkZwZ1hTdmlFL1Ri?=
 =?utf-8?B?WENqYmJtNERETXJTeTQyeXBDY1FyNnBSUFVIeWJkZ1VBa3NOWmk1SlhzNlA0?=
 =?utf-8?Q?SjKVVTuR2SsauRcge9VdZacGz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25918a4c-98c7-4afc-922b-08dd5ccbcb12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:27:31.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQJAmOxmVU8krvEaTrFGCsCNyTxSSFN8PXBTHWuZKQcCoSuEC/F5ZinFzndo77Xm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683

On 6 Mar 2025, at 4:19, David Hildenbrand wrote:

> On 05.03.25 22:08, Zi Yan wrote:
>> On 5 Mar 2025, at 15:50, Hugh Dickins wrote:
>>
>>> On Wed, 5 Mar 2025, Zi Yan wrote:
>>>> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
>>>>>
>>>>> I think (might be wrong, I'm in a rush) my mods are all to this
>>>>> "add two new (not yet used) functions for folio_split()" patch:
>>>>> please merge them in if you agree.
>>>>>
>>>>> 1. From source inspection, it looks like a folio_set_order() was miss=
ed.
>>>>
>>>> Actually no. folio_set_order(folio, new_order) is called multiple time=
s
>>>> in the for loop above. It is duplicated but not missing.
>>>
>>> I was about to disagree with you, when at last I saw that, yes,
>>> it is doing that on "folio" at the time of setting up "new_folio".
>>>
>>> That is confusing: in all other respects, that loop is reading folio
>>> to set up new_folio.  Do you have a reason for doing it there?
>>
>> No. I agree your fix is better. Just point out folio_set_order() should
>> not trigger a bug.
>>
>>>
>>> The transient "nested folio" situation is anomalous either way.
>>> I'd certainly prefer it to be done at the point where you
>>> ClearPageCompound when !new_order; but if you think there's an issue
>>> with racing isolate_migratepages_block() or something like that, which
>>> your current placement handles better, then please add a line of commen=
t
>>> both where you do it and where I expected to find it - thanks.
>>
>> Sure. I will use your patch unless I find some racing issue.
>>
>>>
>>> (Historically, there was quite a lot of difficulty in getting the order
>>> of events in __split_huge_page_tail() to be safe: I wonder whether we
>>> shall see a crop of new weird bugs from these changes. I note that your
>>> loops advance forwards, whereas the old ones went backwards: but I don'=
t
>>> have anything to say you're wrong.  I think it's mainly a matter of how
>>> the first tail or two gets handled: which might be why you want to
>>> folio_set_order(folio, new_order) at the earliest opportunity.)
>>
>> I am worried about that too. In addition, in __split_huge_page_tail(),
>> page refcount is restored right after new tail folio split is done,
>> whereas I needed to delay them until all new after-split folios
>> are done, since non-uniform split is iterative and only the after-split
>> folios NOT containing the split_at page will be released. These
>> folios are locked and frozen after __split_folio_to_order() like
>> the original folio. Maybe because there are more such locked frozen
>> folios than before?
>
> What's the general concern here?
>
> A frozen folio cannot be referenced and consequently not trusted. For exa=
mple, if we want to speculatively lookup a folio in the pagecache and find =
it to be frozen, we'll have to spin (retry) until we find a folio that is u=
nfrozen.
>
> While a folio has a refcount of 0, there are no guarantees. It could chan=
ge its size, it could be freed + reallocated (changed mapping etc) ...
>
> So whoever wants to grab a speculative reference -- using folio_try_get()=
 -- must re-verify folio properties after grabbing the speculative referenc=
e succeeded. Including whether it is small/large, number of pages, mapping,=
 ...
>
> The important part is to unfreeze a folio only once it was fully prepared=
 (e.g., order set, compound pages links to head set up etc).
>
> I am not sure if the sequence in which you process folios during a split =
matters here when doing a split: only that, whatever new folio  is unfrozen=
, is properly initialized.

Got it. Thanks for the confirmation.

My worry came from that after I rebased on mm-everything-2025-03-05-03-54,
which does not have folio_split() patches, I see a crash saying a buddy
page is hit in __split_folio_to_order(). It turns out that I did not
add the changes from your =E2=80=9Cmm: let _folio_nr_pages overlay memcg_da=
ta in
first tail page=E2=80=9D patch. With that fixed, no crash is observed so fa=
r.


Best Regards,
Yan, Zi

