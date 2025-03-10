Return-Path: <linux-kselftest+bounces-28661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A001A59EC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56FF3A9596
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99DF233155;
	Mon, 10 Mar 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvMh2/OL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8718226D0B;
	Mon, 10 Mar 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627946; cv=fail; b=YqiBD7KJ88nyVhchPCZcJ0+ehJm63Vi1MLAzVMaw7XR5GsgPnc5OjLvh10exqM3+IdT0CNmyVipr/KEm2CtRDhIfUTxB8zdRg1rmCSX1xIqXu8O8Zw17yAB8QYxe0z08A7ujTtG+6xCtEDlyDZ2g4yRVq8wVnuHkXxIdf9luZw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627946; c=relaxed/simple;
	bh=sVF7oItdMxWaeEQjtT6vVAHowOHUusl4tfqETTioR+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V5n82DUBTcxk2+CkWbSZeijPQiP3Ou4gk20DDwzqLTQFQMQj05szdUuLBKaXp/6ZvBboQmzdMFiN15NhvUwuD7daCxUMM0hDORNNx1G1+52jjQUULqCRBA0ssOEWEodSa3NqTXNa+aB0q0iOsDrk9Zogy/HKdGWavOw4p4IzAwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rvMh2/OL; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyfy0bf5MfrLe5/ERJeWwDF3P27FPna+KshlupPSFozLPlkE+8ca99bjzJ8Bm5wrh9aXtAyv8I4cbjbF2zWZVd/pr2MchMQznh1nRJcXUyKKwc7AwzQ0KmYaTgVJPQgrCRH4GWUH597pBVx0N/ie/eZUsnN3L1E3skRqmnJ7rskY/p+v2pIz+dSZW3EK/cYF7e4Fg+c8CSftPRCr551Y9yLkc5jLiHf1SVLKmSMzYWpDXsjcKDKOF8y7ujQELDwd1HyEQVNV9MRlnFmNXkzOkYH+9q1v2exIjOizV7TqkX7j7KM4nzaQpLKH/vJMXAsjknnbzPjCwmqeRVcRsSXnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7cAkIIcgqn6lbSNC5oZ04SxkK2AUKgfYjwsa6hbSPk=;
 b=xSLsTdgdWK8cpDpTlO1hFGFllfu00a7RCZsBlPyz8yPu9PqzEe+qt9a0UxrEVxG1TIVXhddUff23fa33m5MMAwSMsX/jlSsJA3agMpSoo0sUJLzQ/jV1Bz1qPiKjpOCWHFoJ27Ti2hen28PPDknPErLgamTuhtdVTq1l1NgvaZI2NYbR5ACjIGiJcnB86+42ct/h7dsdSpBhjwPT1YCzaGFHQGs9zzdVWNQXai9bScNNvab4P4EUbZcqy0QFQ7ijMksNipLTH+3p0jGAtkGSkkE/tp8GcNS/Q3DEIGTcnnVJJFqkatFc0pVfC1Z8sIXN2L+ZkGVmQrKyjQL+wURFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7cAkIIcgqn6lbSNC5oZ04SxkK2AUKgfYjwsa6hbSPk=;
 b=rvMh2/OLgmWPdHTHDC12O8KbZWGGzxs7zwgRKb1Cp/r9QzJoVLfecDk9owGmyWGpyd9qNn8pEUq+nho56xF7m6iyxA7JlBfyMnzjGGk1dtG9FV0ebVSPJFoDltsd3KjrRCGXrpKRhXaThXxiGE3VWOJ9YOhcAouCV5M8kOgArBJAwyH4we3NqIz/P/Usp0QvC7zDprCNa79J65Fshd0S58OMpJbRWEu5J+doMN7pccQH8BMj7BFoFfgopF5qkGvRho0Pe3qmcMm+qfDmPRB/YqH4bnTwBPeccv7BpKymsNAm1T/gZQEbUYhC8UnrXULqsp2SX6e/OVWxQRwWH/HNOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 17:32:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:32:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Mon, 10 Mar 2025 13:32:16 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <0F15DA7F-1977-412F-9A3E-F06B515D4BD2@nvidia.com>
In-Reply-To: <71414652-95AC-40C6-87BB-2B3B2E680C58@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
 <71414652-95AC-40C6-87BB-2B3B2E680C58@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:408:fe::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dae67e9-1adf-4f4c-44e6-08dd5ff9820b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlRHNVFLZHpleExjRC9ES3lYUE5FV1JQRjRGVjM3UTVRV0h4WkFUakhzQXhN?=
 =?utf-8?B?YUd0RUpCUWlEUEhobE9TRDRRV0YzSFVPMzhubjFSai9EZ3VoQW5CSGNBNWdS?=
 =?utf-8?B?ckdYR1hPMTZUMFdwWm5hVlYrR09zclJvbjZzRkQ1NkJ0NUtHbmlsQmtlRktt?=
 =?utf-8?B?YnRuT1VFNmZKWEFDS0wrZmpCei8rOElJMXNhQW9HQmZNY2VraTZRdTVoY0hK?=
 =?utf-8?B?QksyaGlzaFN2dnRMZWN0anlMNWFIVXNFaFR4Z21SNGZlQmkyRlpaaHZmZVg0?=
 =?utf-8?B?VjhCVk9NSGUwY1dnekxNd1pEeE1PNjVRWm55cTFxZHVlTTNaMzk0NEVZbVN2?=
 =?utf-8?B?c3NPM1ZrSFV6OFVQemNQS0thSE9NZFFWMUhrKzF0d3dWSGR1NlFBSHdTZVFY?=
 =?utf-8?B?bi9ranJKQWJCSDljNEtmZFFEa1NHaUdUS3ZxNENRejVjUkI3eUxEV3dGelh2?=
 =?utf-8?B?VG8wK0Q4QytEazhYenh0ZE1mM1lSTjV6WTJFYTVnS3N4L3BYYWdqcGxaNkdV?=
 =?utf-8?B?RVd5dFlySWNsUzJhQjZhc0pPaDE3d0prNjc0T3crZC8waUduaXNYR2lPVXhk?=
 =?utf-8?B?SVNEeEt6VVJjVXlBK0tOa2R5TUdHbzBZZTZhaGkzeEFGZEV3M05QcFFSUVpt?=
 =?utf-8?B?VFBhNmJuelFyeG1oeTZaYmxnQU5VR0N5ZFllRVVUSk9TRGF6N0M3U05USDBO?=
 =?utf-8?B?MU9MQXlEd2p2NlJobzkrUWRFWXI5S2tFUm5pNkNDVGt4b2pRVzdRTnVST0FQ?=
 =?utf-8?B?Y3N3azc5MXdQbWxQdmt2bGorTE1QUTMzdjlscC9VZm5jNEZyQjVyMWhyQk0w?=
 =?utf-8?B?VlUzUlNtWkNacGxyNFlyTDI4bFkxZXlvYnRKOWw5WHBZdXhsK0pGSEN6MHho?=
 =?utf-8?B?N0FzSG1oVzhFY0VOOUxTbDlqdFZYZkR2NG50aS9GZ09QL0M5N1I5dDhTL0lt?=
 =?utf-8?B?Mkkxa0kvQjUveTlKNS9zUWpFajNMaG83WEMva2draUtyZ1h5MDRqSEEzejNn?=
 =?utf-8?B?QWsvOGp4VXlCOXVSaGxzUjVoVVFOZUoyckFoZURqS3pqREd5NnNac2RPMkh4?=
 =?utf-8?B?dHBzYnphSHFuMjFMQ0NrOGRIWVJXWlpBdHc5QzRWTlM2S0FUd1YwZ0R0Rm5B?=
 =?utf-8?B?bmJLaE1SMU5tQ1VId0JJelRvMEtVR0djQzVDMzVqNWdURW5helJxcjk1V1Nv?=
 =?utf-8?B?UDQ2NjVlbGVZcmszcmIrWG5ZVEErK3FFdGZjcU1RS2Ura3Jha2t0NEx1cDg2?=
 =?utf-8?B?SEljZCt2a1FJMVc1RjdOanE5VnRkeGtjQ3RXeXEzc2NDTER3SklCdHh1dFBp?=
 =?utf-8?B?ZFVBMkV3MVVYbUJMd1ZnMlRseWFKSGFXTzBua0gvNk5YNUZhNTVKZ2NyMVJJ?=
 =?utf-8?B?M0E0TUtpdHlTYWRlS2tOaGlSRzNiL2ZldURrWExsNWhDdzgwU3d4cUlXR1p1?=
 =?utf-8?B?aGkwK1RwVkJnTWFYQnYxZk5SVlVlRU9SNEdSM1BHaXZNbjE3V0ZETllpMFJm?=
 =?utf-8?B?RFkxSDZOL3RIS3pwNnYvUlRFM1d0T0FkMmtPd0FUd1pxdzByL3pSNUdDWnJi?=
 =?utf-8?B?dEd6MkpDM3RPQVhTNzF1Q1VHK2VQS0k0UGQvZkRRejVoS1ZsY0xhdElFbjFO?=
 =?utf-8?B?TG9aVFhJcC9CRWxDQUpsTDQxenZ4NlhFT01EcU9GdmlraEc4V0Rvb0NaYjVN?=
 =?utf-8?B?ZjRpR3k5MmxZV2J3NVN6akltS29pQy9zNEQwYmJ2cWhsVWI2Y1VCcjh1TE9o?=
 =?utf-8?B?VzN1SUl2TlJvRFlDUVc4YjhGb0V3RnllMEdhdW02RHc0U0hLZXhybEFNMnNM?=
 =?utf-8?B?ampVeVM5NVFKOXpQeFhnbWx5Sk9aSEVPcWkzUkRHNmpiQm5ybmhQRjNXdHV6?=
 =?utf-8?Q?VvHBBBN/CgspT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHo1Vi9SZ051THJKYzJjT0R0bEU0UFY2ZE1mejJoY2tPL2JtSUVSZkNjemg5?=
 =?utf-8?B?TDBibXdoY0VlZkVaZnh4RnBhQnNlM1ppTXBBRDNuTUxBeTFlbWFBaWZmckpT?=
 =?utf-8?B?VldWL2lVdDROcGF0Y0t5MGo0bUJDdXkzK1NyRHlING12bXBIYjduYnNjK25i?=
 =?utf-8?B?VXBSOUhndm1Ra0ZEVW9YdGZDVDN4UzFWY2ppcnBIODlrWHVOb2M4NVhjOG1F?=
 =?utf-8?B?NkEwbyszOGFZNkxUZll3eEpsR2NKd1pmWlBXWVFZUGlHSWFrajlsZHoydEhR?=
 =?utf-8?B?ZTJwNFpZakhSandUV2YvRDBCdkkrR0syeW9OeTAxN2llbWR6WFREbkIrbzBa?=
 =?utf-8?B?U0pSWHNpMTYwdXNIUkFVUDlYZkVVelBJUlJBQ0YwVTBPaUpqQU10OGFEY2JR?=
 =?utf-8?B?TG40bjhJbkl5M2RFOEY3R2t4SVJDQW9RUDhwK1VMbkh1SzV6dDNIWUg3c1Rt?=
 =?utf-8?B?ZUlINzd1ZnUyV0lFU1dRWEhhMU44WUxtU1Y4bWx2ekRnSGdHZG1aaEdwbjJT?=
 =?utf-8?B?c3lLM213eW1BK0JwdGE5b2MzdldRd1p6c0JBUWlVelpGSUtnN0E2MDRUQnoy?=
 =?utf-8?B?WXp0RjBuZVlzYmxIbEErcWpzRUdXeldBSTRaa2RUR21Gc0ZJSFNXcmdjTCtu?=
 =?utf-8?B?czBRaXFSK1VxVy9xVGxJYURWdnJ1Q2R2L2lxQmdzenJ0ZWdIS1NWTHAza0Nx?=
 =?utf-8?B?RVBTODYxWVhNcUV4cXRMOWY1M3FmSGpPdzBmNjE2VVVpTjliSmU4YXNBSW16?=
 =?utf-8?B?aUU4enB5M2cvdkp1SDA1Q1IrS202OEVMTHF0SitSYjJPeFl4MUl6QTN1dThU?=
 =?utf-8?B?MEcwT2U0RXM2QXRLK1lTRGV6bXppYzBPRmU3Nlk1a3Z2dGxwY0FueU1PYzJu?=
 =?utf-8?B?QUNLODRPUTc4S0cxK3pjdnhSM3JFWHhKVXdIK0h3aFJzc1BnUjNFMVJzYld2?=
 =?utf-8?B?V05HWklGS21RVjhmbXlndW92YlFHblJhamt6ZmUyZlpyeGNvbTdjT2dPVGZ6?=
 =?utf-8?B?aHh2aUJnVDRSSHNMYVd1NUlZZ0c5V0MyOGZPVEF6Vnh3NXA2aXl3b3hUcDRo?=
 =?utf-8?B?ZkRYZzExYmt0TytZZm1aRGZlSkhkSTl1aThTWU1aVXpZVWtLT1JRcG0wZjl5?=
 =?utf-8?B?R3lPUG10Z09CYjZtUlZ5ZHhYOXVPN2pEVExabC9kbHhFaUJ5a1A2eWVqcTVG?=
 =?utf-8?B?cXg5cWM2Tjd4YmFPVDVQTEd3Umtra2tjNHNDenI0amNVVWc1eGwzY3VkdlFz?=
 =?utf-8?B?ZUpnZ0N1MGEyVDZGVFdxZ095dG1oMEw0Zk5tSTdTR29NUnoveXRkN2xQcUln?=
 =?utf-8?B?OGREZWN5dmNBV1k2WW5OWlJ1em44NTFUWkp3alRkVHVWUzlIcFRqOTBzM3BK?=
 =?utf-8?B?VHhqRk1kY2hBcERXbU84Sk1tQlFISUtqKzFPbEpGTjJ0YjlFcS9qNmNJbUtL?=
 =?utf-8?B?OHZsanpDeVpEbW5USUJPYldzdmFmRVNjUGxLVUZYSWdUMCt6bitESG9IYVlr?=
 =?utf-8?B?c2ZSeW55N1BNcWQ0WnVNUStDOGNGWHRYZ0I1cS84Nlo1WE42VHNhSGc0K2Q3?=
 =?utf-8?B?RlhtT0UzbnUvRnpkNXJoa2l3SlVkejN0UE9lL3RsOElTMTdwdG1xUkFxNFN1?=
 =?utf-8?B?cy8wWjc1SE1IUVFLZTl5dHRXZWFieFpTTzg2RGNOYzN0dk9LSUtaREtMemxt?=
 =?utf-8?B?Z2YzV2VncXdNekw0dEpwanlBZ0pMaTg0dWhjZmVrOHhGa2xSY3RkTkx4OTA5?=
 =?utf-8?B?U3hTRW9QTkR1dU5DM0dNR1ZPZE1GYVMxNWdQVEduRnMxd0hkWFFDd0dsSUNG?=
 =?utf-8?B?SWw2TDlKQzZ3RE4vV0NmdWVneU5Ra01vSUZkaXZDeTBpRWdsVk5Lek5pQVR6?=
 =?utf-8?B?S0syaFJOQU84dUE0cWxBNnJjYktqa3BlOE9YdDV3dmJVVHhYS29lVzUrWXpr?=
 =?utf-8?B?eHdNYWJvUjk5U0VoWDhTTVMwMmVUMVZXMjJuN0VyNzAzYTdlSmcvMFd6dHdO?=
 =?utf-8?B?SjBsb1BYZ3hFUkVOblhobXk0R2RZWGZReDYwUXJtdklRQjNzZHZXL3BXbVEw?=
 =?utf-8?B?ZFRJczdIckN4aEhCaUI1WDlsdmgwNXZMbWtCc3RsTWloSFpkaVQvVUIyTTFs?=
 =?utf-8?Q?8cTIIVmSTCEyosY1vH4cdwhXA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dae67e9-1adf-4f4c-44e6-08dd5ff9820b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:32:19.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvXT9nvvEja3LYA+KT9KDNL20xTsSx9inf8mQ3m6isdNFuK08O19zuPcDmnGtXck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On 10 Mar 2025, at 12:14, Zi Yan wrote:

> On 7 Mar 2025, at 12:39, Zi Yan wrote:
>
>> This is a preparation patch, both added functions are not used yet.
>>
>> The added __split_unmapped_folio() is able to split a folio with its
>> mapping removed in two manners: 1) uniform split (the existing way), and
>> 2) buddy allocator like (or non-uniform) split.
>>
>> The added __split_folio_to_order() can split a folio into any lower orde=
r.
>> For uniform split, __split_unmapped_folio() calls it once to split the
>> given folio to the new order. For buddy allocator like (non-uniform)
>> split, __split_unmapped_folio() calls it (folio_order - new_order) times
>> and each time splits the folio containing the given page to one lower
>> order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Yang Shi <yang@os.amperecomputing.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Kairui Song <kasong@tencent.com>
>> ---
>>  mm/huge_memory.c | 348 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 347 insertions(+), 1 deletion(-)
>
> Hi Andrew,
>
> The patch below should fix the issues discovered by Hugh. Please fold
> it into this patch. Thank you for all the help.
>

Hi Andrew,

This is the updated version including:
1. Hugh=E2=80=99s fix on unfreezing head folio correctly,
2. Hugh=E2=80=99s fix on drop the right number of refs on tail folio,
3. Matthew=E2=80=99s suggestion on using new_folio instead of new_head and
using i instead of index.


From 82b40c8d0fb3959d0d438929a3e4166f0785fe56 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 10 Mar 2025 11:59:42 -0400
Subject: [PATCH] mm/huge_memory: unfreeze head folio after page cache entri=
es
 are updated

Otherwise others can grab the head folio and see stale page cache entries.
Data corruption can happen because of that.

Drop large EOF tail folios with the right number of refs to prevent memory
leak.

Also include Matthew's suggestion on __split_folio_to_order()[1]

[1] https://lore.kernel.org/all/Z88ar5YS99HsIRYo@casper.infradead.org/

Reported-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/all/fcbadb7f-dd3e-21df-f9a7-2853b53183c4@go=
ogle.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c10ee77189bd..220a6e833003 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3525,15 +3525,14 @@ static void __split_folio_to_order(struct folio *fo=
lio, int old_order,
 {
 	long new_nr_pages =3D 1 << new_order;
 	long nr_pages =3D 1 << old_order;
-	long index;
+	long i;

 	/*
 	 * Skip the first new_nr_pages, since the new folio from them have all
 	 * the flags from the original folio.
 	 */
-	for (index =3D new_nr_pages; index < nr_pages; index +=3D new_nr_pages) {
-		struct page *head =3D &folio->page;
-		struct page *new_head =3D head + index;
+	for (i =3D new_nr_pages; i < nr_pages; i +=3D new_nr_pages) {
+		struct page *new_head =3D &folio->page + i;

 		/*
 		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
@@ -3541,7 +3540,7 @@ static void __split_folio_to_order(struct folio *foli=
o, int old_order,
 		 */
 		struct folio *new_folio =3D (struct folio *)new_head;

-		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) !=3D -1, new_head);
+		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) !=3D -1, new_head);

 		/*
 		 * Clone page flags before unfreezing refcount.
@@ -3556,8 +3555,8 @@ static void __split_folio_to_order(struct folio *foli=
o, int old_order,
 		 * unreferenced sub-pages of an anonymous THP: we can simply drop
 		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
 		 */
-		new_head->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
-		new_head->flags |=3D (head->flags &
+		new_folio->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
+		new_folio->flags |=3D (folio->flags &
 				((1L << PG_referenced) |
 				 (1L << PG_swapbacked) |
 				 (1L << PG_swapcache) |
@@ -3576,23 +3575,20 @@ static void __split_folio_to_order(struct folio *fo=
lio, int old_order,
 				 (1L << PG_dirty) |
 				 LRU_GEN_MASK | LRU_REFS_MASK));

-		/* ->mapping in first and second tail page is replaced by other uses */
-		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping !=3D TAIL_MAPPING,
-			       new_head);
-		new_head->mapping =3D head->mapping;
-		new_head->index =3D head->index + index;
+		new_folio->mapping =3D folio->mapping;
+		new_folio->index =3D folio->index + i;

 		/*
 		 * page->private should not be set in tail pages. Fix up and warn once
 		 * if private is unexpectedly set.
 		 */
-		if (unlikely(new_head->private)) {
+		if (unlikely(new_folio->private)) {
 			VM_WARN_ON_ONCE_PAGE(true, new_head);
-			new_head->private =3D 0;
+			new_folio->private =3D 0;
 		}

 		if (folio_test_swapcache(folio))
-			new_folio->swap.val =3D folio->swap.val + index;
+			new_folio->swap.val =3D folio->swap.val + i;

 		/* Page flags must be visible before we make the page non-compound. */
 		smp_wmb();
@@ -3788,17 +3784,18 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
 			}

 			/*
-			 * Unfreeze refcount first. Additional reference from
-			 * page cache.
+			 * origin_folio should be kept frozon until page cache
+			 * entries are updated with all the other after-split
+			 * folios to prevent others seeing stale page cache
+			 * entries.
 			 */
-			folio_ref_unfreeze(release,
-				1 + ((!folio_test_anon(origin_folio) ||
-				     folio_test_swapcache(origin_folio)) ?
-					     folio_nr_pages(release) : 0));
-
 			if (release =3D=3D origin_folio)
 				continue;

+			folio_ref_unfreeze(release, 1 +
+					((mapping || swap_cache) ?
+						folio_nr_pages(release) : 0));
+
 			lru_add_page_tail(origin_folio, &release->page,
 						lruvec, list);

@@ -3810,7 +3807,7 @@ static int __split_unmapped_folio(struct folio *folio=
, int new_order,
 					folio_account_cleaned(release,
 						inode_to_wb(mapping->host));
 				__filemap_remove_folio(release, NULL);
-				folio_put(release);
+				folio_put_refs(release, folio_nr_pages(release));
 			} else if (mapping) {
 				__xa_store(&mapping->i_pages,
 						release->index, release, 0);
@@ -3822,6 +3819,15 @@ static int __split_unmapped_folio(struct folio *foli=
o, int new_order,
 		}
 	}

+	/*
+	 * Unfreeze origin_folio only after all page cache entries, which used
+	 * to point to it, have been updated with new folios. Otherwise,
+	 * a parallel folio_try_get() can grab origin_folio and its caller can
+	 * see stale page cache entries.
+	 */
+	folio_ref_unfreeze(origin_folio, 1 +
+		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
+
 	unlock_page_lruvec(lruvec);

 	if (swap_cache)
--=20
2.47.2



Best Regards,
Yan, Zi

