Return-Path: <linux-kselftest+bounces-26696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04308A367FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 23:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E923B091C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4D1DD866;
	Fri, 14 Feb 2025 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohVwlYqw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E81DC9AC;
	Fri, 14 Feb 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570627; cv=fail; b=dvljZRlTZ4qY6MPRS5QbLG0iLThCPfvf5fCKI2QoLZk9MO0Aq5OBcu/sFOKVf4HgPN+L5nhXbf8hH5hJE5tTH2ZTQIKYee4w561W9vUfU5ZH4NjiWGaytJ6+l6NPa02GNkY0gK+b23nteH+Vm0j1lyx5XlMWZgjNXZUFOGS3uwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570627; c=relaxed/simple;
	bh=iLRIUET/2WL4ObqGwYzr3JQnycgWVoFrOMc8nOSC6pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYo/VvK5s9KBPcymIvMfvKEUnEbgeIE4fG/RxnjTeUia8oCiPfQRqsHxR6RGEyD13NQ2NNdMSAHFkPwzWl2nGWjb80bYKM7u8SZlB1mtpeSju78cioEFDyKKri1yqUclh2R0uegWi7pitN864NF2SxFV4nL/Uj1CagBr901RKCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohVwlYqw; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5rjqTSTRAV+eMsZGc3Tta1EHhaBeCvwkyAUQNGvfcCMydMVtOg9H4Z6dXe9T7Nl+0A0u5JqJNRUaRconl/9d2r18oRyNH4MK7HwtmL3Eka+96mPpy+hd55jkgiRZi+/qjSWgLmAPFKikr/czvqzitjj8Z/5TrSIhRND9xKP+I2hw1CGVRJigiBXI4si9XQP3YQ6gekr5Es0hJ7kOcMJECU78BdrBZ7rvmkDeNK4ZsFiTTO1WoqXsIpqI4RYCIplGdCImvV2u/p4s4hn1HXmS89Nj4KFtdrs5aQ/FQ6J0VHdOyCNuOhpWPFToDj48PiIR+w8nuccs0JNp0d9i6o8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyloZyEq03GWXlHAmpAgkUCaT6n40iNlTxRINeIDsu0=;
 b=ETrIYdH1/FgC99BuwoYFswDinxTdbc0VIBdenEd40TJ9NI/kxOfllYpYUgrSNDdLH4iG0pChXQo6DlGhZRZupF3/iuEyimQ0Q7PRN7/uoGoSS8CA6RGYMpCw+ijnuvlBZD597X9dJ56G1xfe2zMpWiVOrXsic8qYA1nc/DbSvtHq0EWHZtkHRhcl/uI0LTeY19EDaEeVw4RarYFESQJDJIWWffZvY27qKM7LfXrmvYj4CwhYfmKmJTI4j0hOc93wJJMU46+WB5zl8z5KwFtOWayE+3dhe0JSi3DghwXNMuwFoGG+AVRMQNWQM38KpjVRPn4Xg4BbiLDhq+HV04ZN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyloZyEq03GWXlHAmpAgkUCaT6n40iNlTxRINeIDsu0=;
 b=ohVwlYqwsx4OmJcxAmPT5iWa00D9xRWIw4qTN1SF/oRnAe4s/CJ27Xhjl4kQhoGcLGHJ+v9pmjwn46Wjn1fcIUs6JOkG4AT50mSHIzcsdKSkLOVLmljOuqatV3EfgZI08orjibvBIHwVtF4n0OB8Kfh5bX1qbjppbtw5Eqx0FVTPQ74eLnDMZ+s1F36AMeRxMs7gD2vGVIj/4mzqXoyGJ70fQrqImCy2fiEEltpJDlsXjuME/KlH+hKJQlF66SPpxOb+gAsCSnUg7ClSNlg07oiYr3cs7ySLX8l5rvRwixR0lyevl0mc4qDkrX3Oy3OhVaXfRlZggeYKFIC1pgK6hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 22:03:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 22:03:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Fri, 14 Feb 2025 17:03:37 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <03F6CCF4-EE7D-4259-AF85-455DEA721098@nvidia.com>
In-Reply-To: <db77d017-4a1e-4a47-9064-e335cb0313af@redhat.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-3-ziy@nvidia.com>
 <db77d017-4a1e-4a47-9064-e335cb0313af@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4c0815-ab60-4cc2-ca38-08dd4d437179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm9BdlBQZGlsYWdaWGpwZEhJa3J2NmJvUHVzaVZ1UmNlTk5tZndWWTNMOGMr?=
 =?utf-8?B?VzkyeEhFRXA1ODE5RE12cDBvcDhrV1VtL1dWc0ZIZkhBb1U5RWlGNnlpZDky?=
 =?utf-8?B?V0F2UTk4d0ZmMWlSTi84UmJ0MXp0NFhPKzN2aDc5R1RVQTN4R2RmNVh6NWd5?=
 =?utf-8?B?WGZPRU81bW5KUWFSb1NMNnZaZmhHcTAvaUZlQWxJTDV3azNIeFBERTBRSUtN?=
 =?utf-8?B?dlhuUDZ5MEQ2WDlZUUR2WmY1Tkt6OTlVNnhzdXBuc3lkVUQxbmFDdTdrOCtt?=
 =?utf-8?B?dnZhNXU0Y1g1eGxyZTViUkZoSW1lTnlIN3k4Z1FpejJNZjJ1bGVRK0VPdUdF?=
 =?utf-8?B?ZVEzMFBQZHk4eXlYdFkyTzVNSDZiOHV4d3hrcDJjanNtNWs3ODJrZVhXZHNi?=
 =?utf-8?B?N3RxaVlta3BZK3VFdGhyR25tTzVpeW85QVlYQnVoQ1g1bEdMWEJUT1RUaFJk?=
 =?utf-8?B?bHExR3pGUzBwTjFhL2xpTk9aZTk2UTBnTHJJblNiSkM0YTI4TnRTSXMzd0ti?=
 =?utf-8?B?TG54dGZ3Rkhnc1NNRjFOZXA0T3p6RnNCL3UvRFcvL3N5R0RJandzWjJySjdx?=
 =?utf-8?B?MGZwRUEwcUFVTmlXaTdGVUpmbUhQamU2RFFydVZhenlHY0xuTEJsd09xVzdG?=
 =?utf-8?B?dmczeXlkNmcvUGxxcnRDaXVocFpyRUIxZUNadmpsNmdlV0wzN1hXUjFwYi9B?=
 =?utf-8?B?MG9TV3R1QSs1NDBhUzlrL3J3V3NLcGI1aXkwVk9wMllhTEdCYmF2MDQ3b3lP?=
 =?utf-8?B?ZW9aUE9ZOWZyZ255QlFsSGh5YWx4RUdkUWFvY3hUa0hGZXJadU1OeWNrdHRm?=
 =?utf-8?B?alFvcFdpQzRYZFJCRHVqd21JeXhIZ1M1THRJbEJYQysvQ1UxdXlMZmIxL1F1?=
 =?utf-8?B?VUxONCs4WlpuRG5KQ0dFSnZwdVJYUXZaR0xzSkRvSzNBcUVHaUtTTHZGb1Mw?=
 =?utf-8?B?U1piTXl3NlJjTXh1Y0xYek9xVHBpZVJxcmxzOUZFN3dNK0E4dWlZQ2xFMjlk?=
 =?utf-8?B?VTVVTzdoVVNtcWRJeEU0ZnNETEZ0bUhBQlJWeFhVWEE1aXNraDlkS3psUHJX?=
 =?utf-8?B?OGdYeGdSMUNnRVJqeTJGajk1SkNRMVZFOFl6NG45MVE5cXkxNkFhdGdORUZa?=
 =?utf-8?B?UHBGVHprNW5rdWw4ZkFnOVdiSmlpWGlxOVVSNjlCNkNMeFlrYktoYU1lWEoz?=
 =?utf-8?B?N2U3OWVJZU9DVUpFS1kvWHBES2Fza0swa3B0M1JpOExiWndOZUZIazBGa0NM?=
 =?utf-8?B?TEhFSHFNWUF4M2ZpdlgzNThPSFFXL05TSFpURHRVS1F4TCszT05pdTVNMThl?=
 =?utf-8?B?U1pTeFlocUZCSy9ZVXdTMEtYK0lSSWVOVkZud2x3eHBFZWJtQ1I1d1hXTTZS?=
 =?utf-8?B?TldabDcrL1c5cjFYei9keDlUNk1LRUFBZkh4U2MwOGExbm1xUHkwQ0gvRXRY?=
 =?utf-8?B?bTNkVFE2eTJSV0lYMm44ZWFINlpxYnRsaUhEN3dXSlNZaFNhM1IzMGFkTVFa?=
 =?utf-8?B?MWI0OE1ZK042QklqYlNGYlNLQnFPOE1tR0l1U0FTQWpDY2habXlGdHJObFBU?=
 =?utf-8?B?YUd1R2k5am5zWVpXTWFhUDdNckpLTlFCSHhXbU8yM3F0RVVoQ3ZIazZzWWJJ?=
 =?utf-8?B?dndxN0cvY3hEa05EU1Ewa0dIc1ZHZTJYV0ZUMmpiZTNTcm02MERsS2paa1pX?=
 =?utf-8?B?T1BOL0U3OHMrQ21XcjkwK1R2ZjEwTGRtQ1BzL0NqSE43VjVpODhXNDB2QnBi?=
 =?utf-8?B?b3RaVXZxdlQvSXRncmh4R09TUDlIcHNZUkY3SjV3Um9mRnprMGNVaVpjTk55?=
 =?utf-8?B?TzRidjRJUzhNM01qdC9LZVpGbDdhTi84V2l3SlcvMlJHcGtaMTFyQnFmdU96?=
 =?utf-8?Q?XNnlTH5ReBLF+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHNXOTVybjYrQmZ0U0kwNEdVZ3ZGSG9kUXhxQmdzK0ZkMkZMS0FkbmlXNWo1?=
 =?utf-8?B?YjRFUlFCdGhlZ1RFWFFERVRDbFd0aUl1TXEydHYyOUxEeWphVVF3ZnpTVGxU?=
 =?utf-8?B?LzUwOTFxSVkyZFdSK2lZOUtYS0NPcmlXZHFudWk4Vjh1ZjBZWGV5SUYvN2lI?=
 =?utf-8?B?OTJqOEZpcEFjTzNBMWt1bEhXa2wxcVVXREZuQlpDb3o4VlNDOEdzcEpmTlJu?=
 =?utf-8?B?V0NXbW90Q1pYeVBnMHFmTlJXVUlnalk4M3BqSkNheUlUS3hPWkZNR08vSXJI?=
 =?utf-8?B?QS8wUWZTOGxtZW9aTFdTSzh0ZDhjNG8zelo1eWc4L3Z5dXlTT0hQSGpNUVo0?=
 =?utf-8?B?M01lVmpXaC9DS0YrRC9MWHByNmZONXZNejIzS2d2RUg5ZDlEcnkySkpsMWRk?=
 =?utf-8?B?Mzc4cUcrUzdDQWs5VmpjUDhmN3IxTFBVN3Rrd1BiRkRES3RhN2owZTJUb1BS?=
 =?utf-8?B?QlM0elVEMm9SRWVWLzA1cFlJQUJVUFJ1bi80dzVLMmUzTXpYK2VYUHRVWEJ0?=
 =?utf-8?B?V0M0ZGswemVZNDF6TWhOc3R2czVmb0NmV1dUdGMvMG1NTkFEUCtlRUNOcnNi?=
 =?utf-8?B?dmlXN2RINVorVkxQQ3Ntb0lFelBMYmlMaXk1N1kxZE8vU05QdWl3Snh0UWxv?=
 =?utf-8?B?TDZ1aWNNLzhpWk8vcnRRRFpid1NKODRsdEE2bllxY0lvaDJudWxmd1pqdVI2?=
 =?utf-8?B?cFRRb2k5ejM1ZkE4cG5EOFdiWW1mT2d0M0FhSHFBMGdJMTFZak8wZ1RlVnlL?=
 =?utf-8?B?QllESjkrT05WRXgrRVJYa3U1N09vM0lwbnBmUTZjS0RjMnA2dFlLR3dGbm9N?=
 =?utf-8?B?SXZla1hmdTVBejNjZnF5cmN2di9MbzlOR2RhRWoyTWk3dGR2S0MwMStMTm1N?=
 =?utf-8?B?Unhma0d2eEprUFZkc2ZoL0JKMUZTRW9oSXFYeDdLenlGMHNzWFJRRFQ4eFhq?=
 =?utf-8?B?WmQyU1dOZytHTHIxTnpHbHJocms3bko2d0J5NjlnSXZhS2ZVUTV1b000Uktz?=
 =?utf-8?B?ZytlbUF5clJWNS9jTm1LWm55YWo3QS9sek9JME9RWE1WRlVxTmFtKy9GTE1S?=
 =?utf-8?B?Snc2dVBOYUd1RFhwc1FZa1N4MnVabStvUjFkZ3V6VmNQemgrYzBRRE1mdzJ2?=
 =?utf-8?B?WGgrOEMwcktGRnJTM2xqa1JEUTRGOGxnNmNBZnFTQnp0ZmtiM29rLzNLb3Bs?=
 =?utf-8?B?Ym5BSHBKaGo4OW9IV09EdTk5N3NsdnBMRTJUNG9MdVBDT24zMU4wOVYxQ2Ix?=
 =?utf-8?B?MEpGcVhpcTkyUnJYcVlEUTZIZnZCc0JMaFpyNStlMkdUNUtSRzZKekM1dzV4?=
 =?utf-8?B?aUcwWHBlUklNWmFqK1Fqd0Jjb1VVL0JtV2IrWldKVnQrTC9FWkswaVF5M0E2?=
 =?utf-8?B?bUF6UGxJdzZsYTcxWHdnWkN3Wm9SMUdGMEhDYi9iaGZsZ0cwZGs5NWFFS09p?=
 =?utf-8?B?QURYS2p5Mm41Z1VvSW81VzlBalUxMS9IdWdweXVOV3Z1V000QmxPZlJjSzJ5?=
 =?utf-8?B?WTQyZ3pNYTF1eDNIeDJieWdna2xKQURrWXpLZTZuQmlXYWdJRHp0UnhSSUto?=
 =?utf-8?B?V2trM3lHcHFhZ0t3MzBETnFjbTRwN1duQmNPL251UzVKTEh0REZ1OUk4NVJM?=
 =?utf-8?B?YjM2NWhKOUp4VzN5V2JPWFlWSjFYcUhEZEhJR2RHUmVORW9ua0xubGVBZkpG?=
 =?utf-8?B?SURTSllBWngwTTVJazVKU2hTWFdLVkpvS3JaMU42MVgrK1czcmQzMk9KNzRq?=
 =?utf-8?B?eTZEL0RFZDZxWkVPSThGb2JocWhSQlpONmJWbEJMVUFJWnN0ZmZDbnc1YkNk?=
 =?utf-8?B?QjdaWEM1eWtnWTlKcjQyYWZZL25TRWRIUmd2dUFsMkYyMTZCWHAzbUxSN2pI?=
 =?utf-8?B?bTZLRGpEOGk5cEtCazZ3d3JzUkVZYTR2ejZib3NnRDNpc1Z3R2FjVEg4WVRz?=
 =?utf-8?B?MDdkRVRONGcrNkQ0MERWNlR0K2pSSGtFVUpoZXE2TU1abXBLcUFuOUJBbksx?=
 =?utf-8?B?UmlCK01wY3BveVIrRG55WkR0UENVMDRISGtldjdqU21UeFNFcG5JcTdGZjl3?=
 =?utf-8?B?MktZWGY5Kzk3dUgwQUc4ZElwQWpZSktadGc1S04rci9KcTFMdkdtNit0UXlq?=
 =?utf-8?Q?vEOYPPS7fU7Q32w2R8HTX8is6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4c0815-ab60-4cc2-ca38-08dd4d437179
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 22:03:41.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjKy02lEzGHzXFYc1Qaz5C+oEKq5njibd7EHANA4IgIY44xqqAytTYmCE6LRo/6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

On 14 Feb 2025, at 16:59, David Hildenbrand wrote:

> On 11.02.25 16:50, Zi Yan wrote:
>> This is a preparation patch, both added functions are not used yet.
>>
>> The added __split_unmapped_folio() is able to split a folio with
>> its mapping removed in two manners: 1) uniform split (the existing way),
>> and 2) buddy allocator like split.
>>
>> The added __split_folio_to_order() can split a folio into any lower orde=
r.
>> For uniform split, __split_unmapped_folio() calls it once to split
>> the given folio to the new order. For buddy allocator split,
>> __split_unmapped_folio() calls it (folio_order - new_order) times
>> and each time splits the folio containing the given page to one lower
>> order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/huge_memory.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 348 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index a0277f4154c2..12d3f515c408 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3262,7 +3262,6 @@ static void remap_page(struct folio *folio, unsign=
ed long nr, int flags)
>>   static void lru_add_page_tail(struct folio *folio, struct page *tail,
>>   		struct lruvec *lruvec, struct list_head *list)
>>   {
>> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>   	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
>>   	lockdep_assert_held(&lruvec->lru_lock);
>>  @@ -3506,6 +3505,354 @@ bool can_split_folio(struct folio *folio, int c=
aller_pins, int *pextra_pins)
>>   					caller_pins;
>>   }
>>  +/*
>> + * It splits @folio into @new_order folios and copies the @folio metada=
ta to
>> + * all the resulting folios.
>> + */
>> +static int __split_folio_to_order(struct folio *folio, int new_order)
>> +{
>> +	int curr_order =3D folio_order(folio);
>> +	long nr_pages =3D folio_nr_pages(folio);
>> +	long new_nr_pages =3D 1 << new_order;
>> +	long index;
>> +
>> +	if (curr_order <=3D new_order)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Skip the first new_nr_pages, since the new folio from them have all
>> +	 * the flags from the original folio.
>> +	 */
>> +	for (index =3D new_nr_pages; index < nr_pages; index +=3D new_nr_pages=
) {
>> +		struct page *head =3D &folio->page;
>> +		struct page *new_head =3D head + index;
>> +
>> +		/*
>> +		 * Careful: new_folio is not a "real" folio before we cleared PageTai=
l.
>> +		 * Don't pass it around before clear_compound_head().
>> +		 */
>> +		struct folio *new_folio =3D (struct folio *)new_head;
>> +
>> +		VM_BUG_ON_PAGE(atomic_read(&new_head->_mapcount) !=3D -1, new_head);
>> +
>> +		/*
>> +		 * Clone page flags before unfreezing refcount.
>> +		 *
>> +		 * After successful get_page_unless_zero() might follow flags change,
>> +		 * for example lock_page() which set PG_waiters.
>> +		 *
>> +		 * Note that for mapped sub-pages of an anonymous THP,
>> +		 * PG_anon_exclusive has been cleared in unmap_folio() and is stored =
in
>> +		 * the migration entry instead from where remap_page() will restore i=
t.
>> +		 * We can still have PG_anon_exclusive set on effectively unmapped an=
d
>> +		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>> +		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>> +		 */
>> +		new_head->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +		new_head->flags |=3D (head->flags &
>> +				((1L << PG_referenced) |
>> +				 (1L << PG_swapbacked) |
>> +				 (1L << PG_swapcache) |
>> +				 (1L << PG_mlocked) |
>> +				 (1L << PG_uptodate) |
>> +				 (1L << PG_active) |
>> +				 (1L << PG_workingset) |
>> +				 (1L << PG_locked) |
>> +				 (1L << PG_unevictable) |
>> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
>> +				 (1L << PG_arch_2) |
>> +#endif
>> +#ifdef CONFIG_ARCH_USES_PG_ARCH_3
>> +				 (1L << PG_arch_3) |
>> +#endif
>> +				 (1L << PG_dirty) |
>> +				 LRU_GEN_MASK | LRU_REFS_MASK));
>> +
>> +		/* ->mapping in first and second tail page is replaced by other uses =
*/
>> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping !=3D TAIL_MAPPIN=
G,
>> +			       new_head);
>> +		new_head->mapping =3D head->mapping;
>> +		new_head->index =3D head->index + index;
>> +
>> +		/*
>> +		 * page->private should not be set in tail pages. Fix up and warn onc=
e
>> +		 * if private is unexpectedly set.
>> +		 */
>> +		if (unlikely(new_head->private)) {
>> +			VM_WARN_ON_ONCE_PAGE(true, new_head);
>> +			new_head->private =3D 0;
>> +		}
>> +
>> +		if (folio_test_swapcache(folio))
>> +			new_folio->swap.val =3D folio->swap.val + index;
>> +
>> +		/* Page flags must be visible before we make the page non-compound. *=
/
>> +		smp_wmb();
>> +
>> +		/*
>> +		 * Clear PageTail before unfreezing page refcount.
>> +		 *
>> +		 * After successful get_page_unless_zero() might follow put_page()
>> +		 * which needs correct compound_head().
>> +		 */
>> +		clear_compound_head(new_head);
>> +		if (new_order) {
>> +			prep_compound_page(new_head, new_order);
>> +			folio_set_large_rmappable(new_folio);
>> +
>> +			folio_set_order(folio, new_order);
>> +		}
>> +
>> +		if (folio_test_young(folio))
>> +			folio_set_young(new_folio);
>> +		if (folio_test_idle(folio))
>> +			folio_set_idle(new_folio);
>> +
>> +		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
>> +	}
>> +
>> +	if (!new_order)
>> +		ClearPageCompound(&folio->page);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * It splits an unmapped @folio to lower order smaller folios in two wa=
ys.
>> + * @folio: the to-be-split folio
>> + * @new_order: the smallest order of the after split folios (since budd=
y
>> + *             allocator like split generates folios with orders from @=
folio's
>> + *             order - 1 to new_order).
>> + * @page: in buddy allocator like split, the folio containing @page wil=
l be
>> + *        split until its order becomes @new_order.
>> + * @list: the after split folios will be added to @list if it is not NU=
LL,
>> + *        otherwise to LRU lists.
>> + * @end: the end of the file @folio maps to. -1 if @folio is anonymous =
memory.
>> + * @xas: xa_state pointing to folio->mapping->i_pages and locked by cal=
ler
>> + * @mapping: @folio->mapping
>> + * @uniform_split: if the split is uniform or not (buddy allocator like=
 split)
>> + *
>> + *
>> + * 1. uniform split: the given @folio into multiple @new_order small fo=
lios,
>> + *    where all small folios have the same order. This is done when
>> + *    uniform_split is true.
>> + * 2. buddy allocator like (non-uniform) split: the given @folio is spl=
it into
>> + *    half and one of the half (containing the given page) is split int=
o half
>> + *    until the given @page's order becomes @new_order. This is done wh=
en
>> + *    uniform_split is false.
>> + *
>> + * The high level flow for these two methods are:
>> + * 1. uniform split: a single __split_folio_to_order() is called to spl=
it the
>> + *    @folio into @new_order, then we traverse all the resulting folios=
 one by
>> + *    one in PFN ascending order and perform stats, unfreeze, adding to=
 list,
>> + *    and file mapping index operations.
>> + * 2. non-uniform split: in general, folio_order - @new_order calls to
>> + *    __split_folio_to_order() are made in a for loop to split the @fol=
io
>> + *    to one lower order at a time. The resulting small folios are proc=
essed
>> + *    like what is done during the traversal in 1, except the one conta=
ining
>> + *    @page, which is split in next for loop.
>> + *
>> + * After splitting, the caller's folio reference will be transferred to=
 the
>> + * folio containing @page. The other folios may be freed if they are no=
t mapped.
>> + *
>> + * In terms of locking, after splitting,
>> + * 1. uniform split leaves @page (or the folio contains it) locked;
>> + * 2. buddy allocator like (non-uniform) split leaves @folio locked.
>> + *
>> + *
>> + * For !uniform_split, when -ENOMEM is returned, the original folio mig=
ht be
>> + * split. The caller needs to check the input folio.
>> + */
>> +static int __split_unmapped_folio(struct folio *folio, int new_order,
>> +		struct page *page, struct list_head *list, pgoff_t end,
>> +		struct xa_state *xas, struct address_space *mapping,
>> +		bool uniform_split)
>> +{
>> +	struct lruvec *lruvec;
>> +	struct address_space *swap_cache =3D NULL;
>> +	struct folio *origin_folio =3D folio;
>> +	struct folio *next_folio =3D folio_next(folio);
>> +	struct folio *new_folio;
>> +	struct folio *next;
>> +	int order =3D folio_order(folio);
>> +	int split_order;
>> +	int start_order =3D uniform_split ? new_order : order - 1;
>> +	int nr_dropped =3D 0;
>> +	int ret =3D 0;
>> +	bool stop_split =3D false;
>> +
>> +	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>> +		/* a swapcache folio can only be uniformly split to order-0 */
>> +		if (!uniform_split || new_order !=3D 0)
>> +			return -EINVAL;
>> +
>> +		swap_cache =3D swap_address_space(folio->swap);
>> +		xa_lock(&swap_cache->i_pages);
>> +	}
>> +
>> +	if (folio_test_anon(folio))
>> +		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>> +
>> +	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>> +	lruvec =3D folio_lruvec_lock(folio);
>> +
>> +	folio_clear_has_hwpoisoned(folio);
>> +
>> +	/*
>> +	 * split to new_order one order at a time. For uniform split,
>> +	 * folio is split to new_order directly.
>> +	 */
>> +	for (split_order =3D start_order;
>> +	     split_order >=3D new_order && !stop_split;
>> +	     split_order--) {
>> +		int old_order =3D folio_order(folio);
>> +		struct folio *release;
>> +		struct folio *end_folio =3D folio_next(folio);
>> +		int status;
>> +
>> +		/* order-1 anonymous folio is not supported */
>> +		if (folio_test_anon(folio) && split_order =3D=3D 1)
>> +			continue;
>> +		if (uniform_split && split_order !=3D new_order)
>> +			continue;
>> +
>> +		if (mapping) {
>> +			/*
>> +			 * uniform split has xas_split_alloc() called before
>> +			 * irq is disabled to allocate enough memory, whereas
>> +			 * non-uniform split can handle ENOMEM.
>> +			 */
>> +			if (uniform_split)
>> +				xas_split(xas, folio, old_order);
>> +			else {
>> +				xas_set_order(xas, folio->index, split_order);
>> +				xas_try_split(xas, folio, old_order,
>> +						GFP_NOWAIT);
>> +				if (xas_error(xas)) {
>> +					ret =3D xas_error(xas);
>> +					stop_split =3D true;
>> +					goto after_split;
>> +				}
>> +			}
>> +		}
>> +
>> +		/* complete memcg works before add pages to LRU */
>> +		split_page_memcg(&folio->page, old_order, split_order);
>> +		split_page_owner(&folio->page, old_order, split_order);
>> +		pgalloc_tag_split(folio, old_order, split_order);
>> +
>> +		status =3D __split_folio_to_order(folio, split_order);
>> +
>
> Stumbling over that code (sorry for the late reply ... ).
>
> That looks weird. We split memcg/owner/pgalloc ... and then figure out in=
 __split_folio_to_order() that we don't want to ... split?
>
> Should that all be moved into __split_folio_to_order() and performed only=
 when we really want to split?

Yes, or move it after the status check. In reality, __split_folio_to_order(=
)
only fails split_order is bigger than folio=E2=80=99s order, which should n=
ot happen.
But still. I will fix it in the next version.


Best Regards,
Yan, Zi

