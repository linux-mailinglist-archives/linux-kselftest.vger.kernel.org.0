Return-Path: <linux-kselftest+bounces-38692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64234B21436
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD6E3E3E9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E02E2DF8;
	Mon, 11 Aug 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c6L2vNcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3DC2E2DE9;
	Mon, 11 Aug 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936421; cv=fail; b=Fi3VfOjZRShYHT1gw6NQXGmJ1ifwrjH528ylrM4CRvmNsuUC70bocksYMXN13o+kmMSPWJJsTQTjAL9JnEx13xPAIueB4L2QprsZ5RXh0iDR8J7DSG6oKmZFp84fADREsfsjlBqGiO0CFtNwfzOfIKnj0zrXSCl7whkDmYH56dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936421; c=relaxed/simple;
	bh=A7BSMvDxRCEql2ZCpVpM1vsR47VJeHpMXz8IZjQg9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tDMKCdMtuWV7PFoeYEIn42Hy4ucvs8xDQIKRpTD8n5VC2Onzj8jkMuwoEKl/9az36C7lN/kxR/QW0ABh517WIE5wg8jE8axpdfs40JK2Yy9tbTTIA01pCynSLG7AV9RBtRQdl1W8ieVXNfjBxg1yE5Qq2JzEU8I1v/6YibPsQAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c6L2vNcg; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8mAby9WDVYbGQeyRHDGbSwz9W3A3e6zNjmSzGG41t04eaIA6XYXr64mvYs9WAE0vFC0uqzORrD7hJ970lRfXXVeZUoChhbQDXV9dsX8LE+s8ynI8e1fWzP9N490a8DrcO5WYwOcmpT5EiaOSVqnpej/OWTan1nPTNy/CyT3lsHhhPmOMru+5jWqlWcfgEE9eQNoBGplHWBZG5eRzaP+LBfXzmeEJkLHD+K3O1LfSLh2nY3mFv3zGnmqRh+jxI/HkHSvzkmpIM8CTveWhnMg4Q6Tj16BlO87qRtRM77viQgDDnGP0fmcWOlwZQVs7va/QJtEqVU0iK5sTuZTh5CflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSv7Gt7bxe5lVNUVlmcPEywWk4j/K2cXpyicqjsF3PY=;
 b=xnBGAYE5F1bc6sSnFzWVPKq3n2KYFm7SgmS0fJgyiDk1TdVp9jdNFBbKqxG+HqBkRgQ/A0EYJXuAr/xTUSYJ8bcltS+9XFd167h0N/0VyQk/fKFz6t49KkeDrFQJ6XjfIq46Llh2aSCyC//Jq38muKaBf03xLW4gwt9HwMxjCqwT+qtFwshpVeqWbWQLUSyEL+YE2bx2NMtB3uHJLLnhpih/880tkDPZjXtf+OVllmxsUMz+GePnTxVW6UxwlQx+iVzodOdTtcjyoK8647eEUcv4UWl0JhxOInanXw1PLuXX0j9bzzIz/SjpvUdDm9XR7cEiZKfNR1Ansf6BAYH2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSv7Gt7bxe5lVNUVlmcPEywWk4j/K2cXpyicqjsF3PY=;
 b=c6L2vNcgqF2XWacylHDyB8VIwoPIyXbomnuVY8NMj5Tbr60e2z+aPwE7a5q9W46xBV2Wyvrwor8nXyBXqBoeYVmoVi4OzK2gSZ8p4SLueOLtuMzoW1U/AqOOE/qRU9fPOKLBNjxaGfWf7YIPC1knwU8+r1YFd2O1fY2hME3ZzTOcOMHY6kl57uoDOhM15wcHpzvVB3FXFwML4EU97NX0+nLSvJNIz+/N5vfhh3r9++4tvF187g/kCLRVhE5SjJ89FSMI8tHWldE/gCevBhDuZqFS9w9bBDSRgiN+GWM6sgHa/PL3jI/isQScRWEJ/4YDTryTy8LmVyakhZea0hgsZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 18:20:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 18:20:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] selftests/mm: check after-split folio orders in
 split_huge_page_test.
Date: Mon, 11 Aug 2025 14:20:11 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C15363CE-F4DB-4747-B51C-A8B5673DEBFF@nvidia.com>
In-Reply-To: <d90d8aa9-0e19-4098-ad3c-1c8069167538@linux.ibm.com>
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-4-ziy@nvidia.com>
 <d90d8aa9-0e19-4098-ad3c-1c8069167538@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0784.namprd03.prod.outlook.com
 (2603:10b6:408:13f::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba7183d-618c-4071-e70c-08ddd903b76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXBOdnhnYTN2YjI0a00rQVd1cUtlaS91QlFjamVxQ20yZzFzVzhqYVJpb1lo?=
 =?utf-8?B?NTdhMThVVzBCVkd1QXJ5dUpFaFU5UFlacytkRjcwdFo3ZU5NSXhVcmxQajg1?=
 =?utf-8?B?NjJ5NklITmlGbjN3c1Ztd1JnK1ZoT2pPeEtJeVV1MlJhbmdHdzFxNnpVcjFl?=
 =?utf-8?B?U3dXUlU0QXlWZlpPRVMxUW45Q2JXTzN0Q2hNV1NSb0FKVXhTSTl3M1pYdVl4?=
 =?utf-8?B?Y0F6TUl3eS9WZ2Z2aUNpaDR4S1o5K0tkYU16ZHlvUXUwU3FSdXhlZlJVV1pi?=
 =?utf-8?B?Umxsd3BUY05HWjlOckJoVy9jUWx6clFETWt6NFltY2dQNFJLbUN1cExNWE5L?=
 =?utf-8?B?RzdMYVFRSlZMS3dhT25xMlMyb252VEh6ejZmR0xxT1N1SEM2Zkp2aUZwa3dy?=
 =?utf-8?B?aWdtbTFpTCtSaTFmc2pjU3hENUtTUW9NSlBJd3pTVkhsQlhhaWdiTTZ0R1lX?=
 =?utf-8?B?ZzMzMnFJeDIxUGZiYXVMS2E0c2xncEFGY1dmQlpoaUxUYklvMkVpdXJRb2ZL?=
 =?utf-8?B?c3A1NE1RVDgrRm9FY1FyQkMrVU0wMGRlbWVjU1pkY3hZZDlvVWJVcVNPd2Jl?=
 =?utf-8?B?dGIzRFpLVVJJYkt5a1dNK0RkdFRxMkhGRkR5bEx6TjVvNS9VVlBzZ0lGSG0w?=
 =?utf-8?B?L09DZ3ZzZnNnL1VBQlZiTkpteU1mMFphMWtOd2t3K0IrTXgzbjhOMTY3V1ln?=
 =?utf-8?B?S3g1K0EvU2cza2QrV0pqQ0FwWC83RVp6ckpsb3IvYzl4bmF5K3lCNmUzY0kv?=
 =?utf-8?B?RSs5K2J4cnR4emVoYVVrazluSktDMkQvMTZqY1piQm9rRndib3l5R2IvVWtv?=
 =?utf-8?B?OU9aYmR0RXNWVk1tM3hrUHpCYnZrTFZIRm55VThPSVd4SS9IMG96OGxjd1ho?=
 =?utf-8?B?c1ZJdTFpNWFiSVRGeEViOGdJSjA0U0NTZldGdHNDTGZzZ0pLNUorZkFCajBF?=
 =?utf-8?B?U0tSVVlRcXduNURMMGZ0bmR6TVFXMnQ0ZUpNVjRPK1d6dGNEcFJIaDRacGpy?=
 =?utf-8?B?SlZRS0p1cFU5QURkeWlML0x0R1VTUVZ0alJpOVFkTWo0QmVnUU9iZ1lnTzZa?=
 =?utf-8?B?RWFiY1pheHl3amg0dUJIbVpPQTBoZmhDWTFYTFFWdEo5cEs1UkxGNHczclhT?=
 =?utf-8?B?VXpMMzRuODZwL01jWDRhMGpXcU9ZOFhqWEZUUVdJZGg3VGJCSGlwWFVMTGJn?=
 =?utf-8?B?UDdKZXpSZ0x5ZDBYUUNvRG96dlF0TEo5amxvUkNqbTJ3TlZIb1FGejF6UURF?=
 =?utf-8?B?ZnlxSTQ3YmlxeHNqaURHYjZUYmtEczB6UitNaDIyMUVZWUFOcnM5SU9vK1Bz?=
 =?utf-8?B?eE5VdlBORC9sbXNIdGk2cys2N0NHRzJRNG90M05xL1N6Nk11clZqbGZYSUFC?=
 =?utf-8?B?Q0JHVXVPV0lkeFg3bkVqa2xmNkRpbUxmNWtRck5Za2FlazFuY2wySnNiZDI3?=
 =?utf-8?B?aFQyd1pQRGhkMWtUMCtDNUd5MVVYcFNJYWdrVHdmOTE2dkk4bEFQTFhpRmQv?=
 =?utf-8?B?MVJ0YkVaUjJKZGszUkNZemZrTytwQVRMVTE3Skxobml6YzcwdDRIV3E5V0dI?=
 =?utf-8?B?TGpCVHc3ODBFc29Ucnl3OEZHK0pyb3UxV1lCQ1cveEx5TkhjMVprTDhxY0Jz?=
 =?utf-8?B?WUd0dTI4NjVXZW54SHJNUllpbHpVNnRJcExmUGZKckFUOWNUbkRCS05QdkIx?=
 =?utf-8?B?NzVHWTlEdFJrZzJiNzhWYTR3aWE5S3JoVzFMelZKTnlydU5KUlZQVkQvQW9n?=
 =?utf-8?B?VnVkUitwY0FBTDB6ckVWNVljaE5sYUd1bm9WUGU0dWpCOHN6NG1TTDVhT1Rq?=
 =?utf-8?B?eUxONjg4RURnbmNpV1N3cDNweUpXYXBsT29yQ05GTGR4alNwZUlxalptR1dZ?=
 =?utf-8?B?Z253dlc2NUw0d2puYjNDRmxsdUJVYmtpSGl2elRwMDM0YzlVYm05Z2Z0YUo0?=
 =?utf-8?Q?AQw2aQUXo4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVNkcERkaS9waFIyYVpJZjRQVzM4NDJnZWMvTitLcjg1VTQwOU45TEVMaTh5?=
 =?utf-8?B?b3dUVUU2elk1NHNHazQrUndMb0c1UnJLb1cwbXF2ZFY2UkdMNGJNb2ZOU01I?=
 =?utf-8?B?RnFRekZZT0xzQkF5WXFiOHp5MWlvc1h3a1FkMVVXTXhCR05RbWwvcVg3TDlY?=
 =?utf-8?B?NkNtY0FZQmNoWjRua2wrdURnQUJnRFVxK2RISldrbFU4bWNBcVNvajlrK0Rv?=
 =?utf-8?B?TUhZSDNIRHhGVDJ0dFF3TVBBSyt2clBDWWp2Y2N6QUhiS25rK1JoZFMyTVA0?=
 =?utf-8?B?eTd1TFBPRmlFaHVNcXp6VFBNWE5pUGhuM0t6YTh1bTlXMGFURUt3Y3FVcHlm?=
 =?utf-8?B?Z3F4VEJHWjhIUXBIQ0JkNzBnUW8xQzFPMFYvWml5RFI1eitWSnZVd1hzdDBJ?=
 =?utf-8?B?bExXN2pJRWVMSXhJVjRoQzNUYml3SmpOTFlINFQ5T0pUV1E3T3lRVEdxQWhD?=
 =?utf-8?B?UzlxTm1RNGZiU0orclNjM29ZZEpDb0h6TnEzeHhYQ3NVVi91b2lNdUtRSmcw?=
 =?utf-8?B?K3ZIbDQ1YlZaZyt2VUlqT1FCbDdaRHlldHdValc5a3lHdUsrMmRMNWlnMXho?=
 =?utf-8?B?ODFocitoS2p0T0h4Z1pqSEU0bnUvQk9NOUJEdGdxbHlmQkZ1SDVNL3VLMkQy?=
 =?utf-8?B?QTg5dmhvSXNKbFlpYy8wZVVrQWhRVDVQN3AyaFJJVmZGKzlCcjVCaEZRZzhX?=
 =?utf-8?B?eE8yRmg0MmVUSDd1ZFc3ZjFGSVFtd0h0SVpWbUtTUjNicTJEYm1GSm9ZSTFY?=
 =?utf-8?B?RVhOT0JXRFZBazlZVVNubzQvN0dUNGxNc3FpdklOYVJEWGdIa2xiajZET211?=
 =?utf-8?B?eC9vMW9mS0paQ0dwMnc1K1AwSEM4bk4zVnI4amJHWGVIemVxaENEOE0xbzBK?=
 =?utf-8?B?dDR0ZkIrcG5lSERZRi8rbWtVcC9ZWDJPWlA0SzdvdkdYR0pGRkgrMC9jbm9o?=
 =?utf-8?B?bjB2TWxnNzNORFg0aWdUTFRjYmxWdVJ1MGcwdXZjODlCd0FWQ0pCc1R6cXVF?=
 =?utf-8?B?RFptV0JJckk0aXpHQlNHclVJcnIxSXNIZTlRdzMwbHI4Z2V5VmdiVy8vVXAy?=
 =?utf-8?B?aUhHbm52YnFHYmgxREdjR3lvd3dBdUY4Uml5dW42ZnoxTDM5ZnJwb3J0c2lM?=
 =?utf-8?B?OStGWGU0Q0JVenlyZVU5N2hPdHVtTFNKbU9HWUp1dWFNTTNheUI0SDkwOVBu?=
 =?utf-8?B?Z1BtRDRNOVprSlZSRDFFbHlUWmZ1dkJ2NDA5UUxoczBTVE9VNWhwUUNneC9R?=
 =?utf-8?B?WVBUeThwTWpxNmRlS3o4SjIzSWZxc2hFSWpkM1VLTlZka01JL1JobUE2Zjhz?=
 =?utf-8?B?RnRXRkdMaVM3MnpsdzhlejIwM2Yrb2R2eWpEVWE3dUZmdXU3NW9vQ0NuMGJz?=
 =?utf-8?B?WENaY3I4Nk1EamtrYlNtL2NrZkQva2ZmOVBNSHVrLzBTOHVCRVI0c1YySWpj?=
 =?utf-8?B?a3ZubkpGL3JBd0ZhSmYrRW0wVXA0c1B4Nk1GN2dmK2swa2hYOFRtcmN6Sy94?=
 =?utf-8?B?NmdzSWJqMkg0bGNjb25Hck1sVktYSG5EVDlZOUM3a2pyQitIWWl2ZUdWZXBu?=
 =?utf-8?B?T1gxeWQzbFRvamQ3TXRCS0krYlJPTXNiNkF4dk9aZ25VeXN2Q0ErejZ2WWlM?=
 =?utf-8?B?bGpueUlGZHEvd1RwSzRBaWRYSmJYQkIwN0hmVW9vRm5aV3czbE02RG1PVW5w?=
 =?utf-8?B?RThlWVIxM0xyb2xCN28vSVpidnFlVU9BV0tDNHFMOENHUHp1anBXVml3cldV?=
 =?utf-8?B?N2g5VzBrZEpwTmtpUHg3SHhxUS9tUFNCNzhuaE4vQnBlZDhhdEVocEtuYU1F?=
 =?utf-8?B?MFhnYjYzemhkWDhWS1p5Ylhkc3lBY1lXaDB5V1pHbEoxMFlYN0MraUZmNUN2?=
 =?utf-8?B?NitRamNicEFsYWtiNXBTTmkzZUlFYVRWSjA0bEF3V1NvVGN4QmdCK3ZxblNW?=
 =?utf-8?B?Y2tOOVQ4akpldk9WNHEyUThTbjIzY0lXaEZsRmdWdkVJK0s4S1Nic1QwSGNB?=
 =?utf-8?B?MTBuemdTZ1F5d3NGVUVNaXRqVC9DR1VQNlpSbGJRQzBYcytybnZseC9aZ2l5?=
 =?utf-8?B?NkVoOERSVnc1clZmdkFVK0R1NEdIVStVOG9ST2VzMUttd3pHTDZ2Y0ZnYnVR?=
 =?utf-8?Q?sNOvhYbnvrpgmL9hFiqqEjhRw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba7183d-618c-4071-e70c-08ddd903b76a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:20:14.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/i16VUMJmwfemO3yhY1h07cHDje9KLWRSJ2hVwFcD1TCosafQS5jOQz8h5ePbC/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On 10 Aug 2025, at 12:53, Donet Tom wrote:

> On 8/9/25 12:31 AM, Zi Yan wrote:
>> Instead of just checking the existence of PMD folios before and after fo=
lio
>> split tests, use check_folio_orders() to check after-split folio orders.
>>
>> The following tests are not changed:
>> 1. split_pte_mapped_thp: the test already uses kpageflags to check;
>> 2. split_file_backed_thp: no vaddr available.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   .../selftests/mm/split_huge_page_test.c       | 98 ++++++++++++++-----
>>   1 file changed, 72 insertions(+), 26 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/t=
esting/selftests/mm/split_huge_page_test.c
>> index 5ab488fab1cd..161108717f1c 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -25,6 +25,10 @@
>>   uint64_t pagesize;
>>   unsigned int pageshift;
>>   uint64_t pmd_pagesize;
>> +unsigned int pmd_order;
>> +unsigned int max_order;
>> +
>> +#define NR_ORDERS (max_order + 1)
>>    #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>>   #define SMAP_PATH "/proc/self/smaps"
>> @@ -36,6 +40,11 @@ uint64_t pmd_pagesize;
>>    #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>>  +const char *pagemap_proc =3D "/proc/self/pagemap";
>> +const char *kpageflags_proc =3D "/proc/kpageflags";
>> +int pagemap_fd;
>> +int kpageflags_fd;
>> +
>>   int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_fil=
e)
>>   {
>>   	uint64_t paddr;
>> @@ -151,6 +160,11 @@ void split_pmd_thp_to_order(int order)
>>   	char *one_page;
>>   	size_t len =3D 4 * pmd_pagesize;
>>   	size_t i;
>> +	int *orders;
>> +
>> +	orders =3D (int *)malloc(sizeof(int) * NR_ORDERS);
>> +	if (!orders)
>> +		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>>    	one_page =3D memalign(pmd_pagesize, len);
>>   	if (!one_page)
>> @@ -172,12 +186,20 @@ void split_pmd_thp_to_order(int order)
>>   		if (one_page[i] !=3D (char)i)
>>   			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>>  +	memset(orders, 0, sizeof(int) * NR_ORDERS);
>> +	/* set expected orders */
>> +	orders[order] =3D 4 << (pmd_order - order);
>> +
>> +	if (check_folio_orders(one_page, len, pagemap_fd, kpageflags_fd,
>> +			       orders, NR_ORDERS))
>> +		ksft_exit_fail_msg("Unexpected THP split\n");
>>    	if (!check_huge_anon(one_page, 0, pmd_pagesize))
>>   		ksft_exit_fail_msg("Still AnonHugePages not split\n");
>>    	ksft_test_result_pass("Split huge pages to order %d successful\n", o=
rder);
>>   	free(one_page);
>> +	free(orders);
>>   }
>>    void split_pte_mapped_thp(void)
>> @@ -186,22 +208,6 @@ void split_pte_mapped_thp(void)
>>   	size_t len =3D 4 * pmd_pagesize;
>>   	uint64_t thp_size;
>>   	size_t i;
>> -	const char *pagemap_template =3D "/proc/%d/pagemap";
>> -	const char *kpageflags_proc =3D "/proc/kpageflags";
>> -	char pagemap_proc[255];
>> -	int pagemap_fd;
>> -	int kpageflags_fd;
>> -
>> -	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
>> -		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno));
>> -
>> -	pagemap_fd =3D open(pagemap_proc, O_RDONLY);
>> -	if (pagemap_fd =3D=3D -1)
>> -		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
>> -
>> -	kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
>> -	if (kpageflags_fd =3D=3D -1)
>> -		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
>>    	one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>>   			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> @@ -259,8 +265,6 @@ void split_pte_mapped_thp(void)
>>    	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>>   	munmap(one_page, len);
>> -	close(pagemap_fd);
>> -	close(kpageflags_fd);
>>   }
>>    void split_file_backed_thp(int order)
>> @@ -463,10 +467,16 @@ void split_thp_in_pagecache_to_order_at(size_t fd_=
size, const char *fs_loc,
>>   		int order, int offset)
>>   {
>>   	int fd;
>> +	char *split_addr;
>>   	char *addr;
>>   	size_t i;
>>   	char testfile[INPUT_MAX];
>>   	int err =3D 0;
>> +	int *orders;
>> +
>> +	orders =3D (int *)malloc(sizeof(int) * NR_ORDERS);
>> +	if (!orders)
>> +		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>>    	err =3D snprintf(testfile, INPUT_MAX, "%s/test", fs_loc);
>>  @@ -474,16 +484,32 @@ void split_thp_in_pagecache_to_order_at(size_t fd=
_size, const char *fs_loc,
>>   		ksft_exit_fail_msg("cannot generate right test file name\n");
>>    	err =3D create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
>> -	if (err)
>> +	if (err) {
>> +		free(orders);
>>   		return;
>> +	}
>>   	err =3D 0;
>>  -	if (offset =3D=3D -1)
>> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>> -			      (uint64_t)addr + fd_size, order);
>> -	else
>> -		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>> -			      (uint64_t)addr + fd_size, order, offset);
>> +	memset(orders, 0, sizeof(int) * NR_ORDERS);
>> +	if (offset =3D=3D -1) {
>> +		for (split_addr =3D addr; split_addr < addr + fd_size; split_addr +=
=3D pmd_pagesize)
>> +			write_debugfs(PID_FMT, getpid(), (uint64_t)split_addr,
>> +				      (uint64_t)split_addr + pagesize, order);
>> +
>> +		/* set expected orders */
>> +		orders[order] =3D fd_size / (pagesize << order);
>> +	} else {
>> +		int times =3D fd_size / pmd_pagesize;
>> +
>> +		for (split_addr =3D addr; split_addr < addr + fd_size; split_addr +=
=3D pmd_pagesize)
>> +			write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)split_addr,
>> +				      (uint64_t)split_addr + pagesize, order, offset);
>> +
>> +		/* set expected orders */
>> +		for (i =3D order + 1; i < pmd_order; i++)
>> +			orders[i] =3D times;
>> +		orders[order] =3D 2 * times;
>> +	}
>>    	for (i =3D 0; i < fd_size; i++)
>>   		if (*(addr + i) !=3D (char)i) {
>> @@ -492,6 +518,14 @@ void split_thp_in_pagecache_to_order_at(size_t fd_s=
ize, const char *fs_loc,
>>   			goto out;
>>   		}
>>  +	if (check_folio_orders(addr, fd_size, pagemap_fd, kpageflags_fd, orde=
rs,
>> +			       NR_ORDERS)) {
>> +		ksft_print_msg("Unexpected THP split\n");
>> +		err =3D 1;
>> +		goto out;
>> +	}
>> +
>> +
>>   	if (!check_huge_file(addr, 0, pmd_pagesize)) {
>>   		ksft_print_msg("Still FilePmdMapped not split\n");
>>   		err =3D EXIT_FAILURE;
>> @@ -499,6 +533,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_si=
ze, const char *fs_loc,
>>   	}
>>    out:
>> +	free(orders);
>>   	munmap(addr, fd_size);
>>   	close(fd);
>>   	unlink(testfile);
>> @@ -522,7 +557,6 @@ int main(int argc, char **argv)
>>   	const char *fs_loc;
>>   	bool created_tmp;
>>   	int offset;
>> -	unsigned int max_order;
>>   	unsigned int nr_pages;
>>   	unsigned int tests;
>>  @@ -539,6 +573,7 @@ int main(int argc, char **argv)
>>   	pagesize =3D getpagesize();
>>   	pageshift =3D ffs(pagesize) - 1;
>>   	pmd_pagesize =3D read_pmd_pagesize();
>> +	pmd_order =3D GET_ORDER(pmd_pagesize / pagesize);
>
>
> I think max_order is also same as pmd_order
>
> =C2=A0 nr_pages =3D pmd_pagesize / pagesize;
> =C2=A0 max_order =3D GET_ORDER(nr_pages);
>
> Can we use one?

Sure. Will rename max_order to pmd_order. Thanks.

>
>>   	if (!pmd_pagesize)
>>   		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>>  @@ -547,6 +582,14 @@ int main(int argc, char **argv)
>>   	tests =3D 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4=
 + 2;
>>   	ksft_set_plan(tests);
>>  +	pagemap_fd =3D open(pagemap_proc, O_RDONLY);
>> +	if (pagemap_fd =3D=3D -1)
>> +		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
>> +
>> +	kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
>> +	if (kpageflags_fd =3D=3D -1)
>> +		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
>> +
>>   	fd_size =3D 2 * pmd_pagesize;
>>    	split_pmd_zero_pages();
>> @@ -571,6 +614,9 @@ int main(int argc, char **argv)
>>   			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
>>   	cleanup_thp_fs(fs_loc, created_tmp);
>>  +	close(pagemap_fd);
>> +	close(kpageflags_fd);
>> +
>>   	ksft_finished();
>>    	return 0;


Best Regards,
Yan, Zi

