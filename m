Return-Path: <linux-kselftest+bounces-28658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B4A59C01
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC18188C41D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC4230D14;
	Mon, 10 Mar 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eCUo2SkJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D9230988;
	Mon, 10 Mar 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626322; cv=fail; b=oeURRSqQgez0Z70mqwKejrbdxt2oUDnUhrvAASzBglkY5pqbmq4TQgK2Z0GSw2csiGkj4VMlL5FAY+rrb9Ti1dMMrSCURcIV56qOopOB8SQaVuK4ZRQln//JvdtXzj2ohwBHr2RaA9cKeZ5MNjZ5U35YIofB9t+s6b0o3Y5epWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626322; c=relaxed/simple;
	bh=24D5TMOD53OqqpRgWKa1n1MvVZnS+rAIdrqNR0tmCb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdv6MASTrFEzHWO07Kfj9Letn6ZL9TBOgViCF5vZb1wgPvzo+VPXmZ3sK3nOlZdA0cBuiibP0iET4hcXvCTX44tTi12d1BlzR3r4fW2MWT8aV2tNeV2wqQS+IzlStPEudE0sOKxqYGOVCeOu9kQKa9UO8UNBF9VMZo+Qqmp0Vlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eCUo2SkJ; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZwwn6RaXT85DuRkelUv4OllEn9Wfz8G9fmt4HQ5rwXkbq35kp2/8zAMZ8ih0tth2Yl/RKjL5mXNgwra1jrYIE4OhawJsMMiuITxy68xn6fJVlG4SL93nESwygOkxgO/5iuXMIk4bqmJ5mrFmgZM470K0EJAvO2NklThPCWNjU5BHJKKk4lae+tDBk2KqF/7CScuhTXRKrfd7hCH1UjWEqDB0FeAncRG4voCZx11OGfl2QW65KqMDMrf4GvxSc9rHdmILHOVvxRbt4PUIUooMskC+SvNVkFWxqVxw6Hwn8PUo7jgK0DZECPqJfqiZFEsM2vII6bHHORiGDE9mUUMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxC5jn6tK7pn8z921gyqoPShTD1xPnDDtJYBoHYQfuY=;
 b=QhZWaQXtP69uucj1KuKlu3SGdOHt96+xpvcYzbQFpf7RwwAn7ZN09rAuptj1cMxKPfwmCkviDeWZjT7ONlZVmVprJnBOqLbpsmj0eBWMsB9vSErRSUUpfuLyYmSwNDrhAsIUk5oi+K7ruzYMtaps8O1Xkl213NftiT3mLuNgIPUuu0vGuMThoGyIJQsCjdVO7vNQf21Y+W4yJL7SGZ5FHrfLFOPa2vrg7GTBh3nzKrZjRKnETIqghieUiX2NDzuO11cYmJ3CB3wof6poqN5jcHTYVEXyQze+Vfe2x38DsCiXQyt0Evw45ibbFCYtmfe1tthaC078XxG7eitVHwogdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxC5jn6tK7pn8z921gyqoPShTD1xPnDDtJYBoHYQfuY=;
 b=eCUo2SkJx6yUi1TgXh3+y4KIfDJXMEraZ+OjNB9W1dob5xClWyvh8DN5uV7/z3dzLwvm4i6jUw93NTJegoz+60kz7Yb5lbrw3e2fbH6CXq2TBXqwi8oRJTclJEUAw7Qz86xVpbjnVi1cwv6lmiRPoEiKRSxYQDLN2+u3SHAU61z0DWMucp+XcB2AhmPKIaqYXgyw7CfO4Vveh18tvzr3lZVoCaeZqjNdnkk7Wmt/Ovw0/EMvRqEO2mJeV2cLcpMGp76bRcupYoM1vd1HAr5+mGfdnVYKuIsV39dzWEKwDdhZK8SfwY93d0KSEX8s94AxEkN3PZsuMNGYQxbRUXSOEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 17:05:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:05:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Mon, 10 Mar 2025 13:05:12 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <534ACFEE-3FD9-47B2-B3A9-45F898BC9CCF@nvidia.com>
In-Reply-To: <Z88ar5YS99HsIRYo@casper.infradead.org>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
 <Z88ToirSWa_meevw@casper.infradead.org>
 <A10312E5-F4CE-4CBA-B7CB-D435DFEA496F@nvidia.com>
 <D94BB56F-4BA0-4376-B5C4-7E38D2D92624@nvidia.com>
 <Z88ar5YS99HsIRYo@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:408:ec::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: ac199a2c-16f1-403d-f9f8-08dd5ff5baa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REFQUFlBR09zamdJUHhrVUFaRzQzUWJoVTA2Y2djNllMSUpDTVpvVUo0bjZX?=
 =?utf-8?B?azd5UGl1WnNOZU5pYVVvVXFSbGtzeUNUdmgyRU9QWmRwODh1azV5eXpzSXlY?=
 =?utf-8?B?aEVmcU5saEx0aC8rYmpodTdRV0FjTmZXUlhUMUc2cVhyUlVHaEcweitwazNr?=
 =?utf-8?B?UWpnc05CcGhpb2tPMzZaajRRQ0NYWlF0dXFITjhrbVA5cnVEWGVMc2ExTHd2?=
 =?utf-8?B?WmxucEt0V1BGK3E2alV3RW9GeGdzMG5TY2tkN2hjOFh0OGhmNzhSSlFhRVBm?=
 =?utf-8?B?SktENHR5eFd2V0pVdUgrdnJ5Z2hLTWY1V2hLVDJJZW92U2ZmYnFDczZNS0ls?=
 =?utf-8?B?S0lhbDhYZ3NBdGNpd05NNUVwRVFvQkRHZFZBYWdwL1RiRm1JWUFHdHF5L25E?=
 =?utf-8?B?cWFpbzA0WVRlcFowSnhUR2c2WVFOd1d3R2pBZWlQbjhUTG8wMyt2QkRuNk03?=
 =?utf-8?B?WjZpL3FZSFp2SDQ1MmhJZUtVL1ZkRjdIYzJPWHB1TmlSY0dPd1BaL3YwU3Zy?=
 =?utf-8?B?STZ6THJqaXVvT3dSTWZxNWg0ak9EOVE2b241RWtDNkhSWGxib1hYem1aRWtq?=
 =?utf-8?B?Tk9odEVmWjdLaXpRdkVUOElENXMrUFZoN0pSSm9pL3JFL1ZzYzUwbjNGS1U5?=
 =?utf-8?B?QS9yaXpEWnprQzRvakpBaXVCdVZENk9MODhubGxGam1tTzJHNWw2VEtNRVU0?=
 =?utf-8?B?MWRUWG1sTU94Z0c0VS8xNUdnOUR3TFllMVBoTUducUNhK0ppWDl2dGFreFFR?=
 =?utf-8?B?RTlQUTVWd0lJcVZQT2VLQ1ZVa1lzY2tXVGROdWZzNHFEMGpBTUcvdDI3RWM0?=
 =?utf-8?B?cURVQjJZSDI3N3pvN0tTTzBOdzd4ek14UXd3My93UExEL2UyOVpVTnFTb1Zs?=
 =?utf-8?B?R0xweVpxRVZjcUZpVTBEczNhYUtESFN4Q0ZWbTdtQkhUVjVrNHlvYjNuaUlx?=
 =?utf-8?B?TTJhUkdRTXpTRDNJZlFLN0VBNVp5ampmU1YwRnZaRVIxYTE2bC9lNm9YSHhZ?=
 =?utf-8?B?LzFLMU1SVHovTUNLa0JZOFhLSnppdDNUOGsydVAyc0VvM3BtcHg4Tzl4ak00?=
 =?utf-8?B?M3o0YmFpc2ZPNDJ2OTMzbGt2b2RlWUVNRVdaSGlxeTBkeC9WNU1FWVVJUXBm?=
 =?utf-8?B?TW1YR29Fam03ZFVRcy9sc3lFNDYvS21XUVBwWXJmZWMza3RieW9rWWZMclZM?=
 =?utf-8?B?V0xaaFJ4aWdWZGFZQjZwK1kyYVZWeVhqa3RvWXNLM2JHeklOVUZFZDFCeXE2?=
 =?utf-8?B?Zk5YNENpbmVud2Q5dGt2Zis5Q2ZlcXlmcUxGamF6dzJ2NjdYUmc5dXNDR1Er?=
 =?utf-8?B?eVRHY1kvanZGeStWendwN2JCUGVrZjQ1enJiYTZBUm03WHo3V2h4YUFucFNQ?=
 =?utf-8?B?bkY1eUdFV3ZyWGNUV3UvbjExMWdRSjhPS3FuOGhyelBkYkR1VDU2azNDSytG?=
 =?utf-8?B?MGs2alI3TytLWDAwWDl3amRGSk90MUVaOHUzRHZxaDArZjhSQUd2bGNrSitj?=
 =?utf-8?B?M085TnZyUS9WOWthMHdwYnFiVHQrWnNzbUU4OHY3YmJhTytLOXBDMkx1M045?=
 =?utf-8?B?aVc3QUkrdThCaDFuMzdGaTBubVpvR2dUT3R0S0o5dFJpUnU3V0cySzBIRTlh?=
 =?utf-8?B?cmxBNkFBcjk1U2ZsNEVTcUxkVmROcDhnTEprRlZPM2l1RFdEUVp6WGVNWGRV?=
 =?utf-8?B?QjdSc0xiMGVieGp0K2FCVUZNKzRNOEJpSWp1Q0k0S0FVV2lvVGh2NjNzdWNy?=
 =?utf-8?B?aW5abDdBenNOVjhSZGhWdFJ0WFpxQ0VKL21JRHRCWDBwSW56U2JaYXRmaU1r?=
 =?utf-8?B?R01TQnI0UVY3SHZmY0JPMldNMW8wb1c2Ky9qOVhlVUtCblJmbU5rdTlNSVpL?=
 =?utf-8?Q?yYRY6JZQyTKdt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekRNdW9iY2JjYkRaWnVPb0FmSXJuN2N2RDFhYUtkazc2dSttclMvNGtVeldq?=
 =?utf-8?B?TC9kZERNMWl4RTR0blAxUGJ1ZEs5VlFsN2pzRTczWWQ3UWM5aHZVN0ZDRU9o?=
 =?utf-8?B?TFNZdDI2d2ZQQU02RFhyL2lXeFFWOUMveFFWc3ROZytRc0RyUjlVaXp0cTBj?=
 =?utf-8?B?SmJoNlJ6R25LVWFCSEJjeXZKRzU3VzBnTkxKNWFhZ3l6bG96WEVYelVUTlZV?=
 =?utf-8?B?NFJZMXlGd3JsNHBKSkFsZ2Yyb3Y2c3ZReUlJNm9jZHdtSE5aVVI1cEUzdnRL?=
 =?utf-8?B?SnFrMi9ha1NpaTlJeTNkVTZOVFFmbzVaRG51R1B4MTRUQnZoek5BN090STRS?=
 =?utf-8?B?WTJ0Yi9BNk5STFg2VG1UNjJ5SFhzdndpRlZZbkFZMXYwVjZaOTNtSytza2Zs?=
 =?utf-8?B?SlhWTFRUb0xqTlN2K2dYdUZ6Y1VpU3QrOTdhb1pqYXJGUVZQbDZJaE1WNzM0?=
 =?utf-8?B?a3FHRjJKenNuRzcrSDZGUjk3NUVJREtTODNXSlF3Z1hrRzd0QTNPNjViYTlZ?=
 =?utf-8?B?RW1JZ1k0ZnFrNHptMDZxMkQzZGw2L2hDTlVKTEw2VUdnNVhmMDF1N2J6cjZL?=
 =?utf-8?B?MGVqYTFuYm0vbndTQnZDejJZWUZtYVhvOVVxNkxMUDFIaG9ISHcrTXBWR1dt?=
 =?utf-8?B?WXhkOWVFcGlMV0RNL1gyM3dXT2ZXd1A1dmRnbXlsNXl3L0RiUWJ2aHZ5d3kr?=
 =?utf-8?B?eEtELzJhelJsK0srbitqWHFkNEVpazJqQWJDYTNwb252ejVuTDhiVElwQ0cy?=
 =?utf-8?B?L0VoWVdHSVRIR01HTS8vSTZEM0dnTWdsQnUwZ2pYbVpCd0N4SDJPOXpRbldH?=
 =?utf-8?B?Vy9Udk9pZ3c3MlNaQ3R6eG9FNG4zR2NaQ3Rid1phSlVqcGJpcG5UNjMzbzFx?=
 =?utf-8?B?R2h2bWpybkdmV1RlNHlhZC9XM25VSzRwbEZVa0xBMkFjOFpBS0xkRjU1YSti?=
 =?utf-8?B?VDAySjJBa0EvZEhkQVQ5ZG81VjJwRUE1RGZleFl1ZmJUcmpmQmZLdzM0RGlh?=
 =?utf-8?B?MjZnVnBhQTJwaElhY3E1eWFWMlp5RldHektkRjNTQmJsMitBeXk0aTdybHlV?=
 =?utf-8?B?TDhhd0N0UndUNUQrMjh4SGY1UG54eDJ1UHJMZFgvendTTFgrMkRCZzk0ZnlT?=
 =?utf-8?B?SExmUkVBMHIrc1NiSzd3YlZQY3Awa1hqb2o0MFI2UEFwSndWR1A5ZXNpeHdZ?=
 =?utf-8?B?TUFueUxVSTFxb3lUZUgzbm5Xd1Qwd3Y4NVA5MC9UZFd1bDlkSXV5NThZY0hP?=
 =?utf-8?B?TWZwWGRJNUluWVJpR1RyYS9jYmVFOGxLNEZOM2owdjE1K3k5MVFDUDFsa3g5?=
 =?utf-8?B?MFVwdkJGKytGdWM4aWNnSUpvYkZFa2wzRUloSzFUMHorNWhhZGFMMXIwalFV?=
 =?utf-8?B?MDh0YUZxQktid2x5U1RDelZRekYrM21BL2w1TmpHVjZROUJZR1FwUWJhWjlG?=
 =?utf-8?B?UDdSN1lhbGZ2emxSQldGZ3N4eVl3OC9CbTNmRnRza3JvUVRSQlJ5RmMxdFpr?=
 =?utf-8?B?c0VUTUcyUDFGTlRXTStHaFFVQTRPMmc5WUJpK2Nyd2hmMmZ2ejcwaCtsVUJx?=
 =?utf-8?B?QlMxZ3pEaDdzaFdTaGs5RVlSdWxuNXVjVEl0ZzVmcC9tYmcwV0FzTUFKVmR2?=
 =?utf-8?B?UzI4Wm01VzUwdFNrRC9MY0RVNWowMkZ5dlZYVjhYSjExRTJjVU1PRnV4ZHhH?=
 =?utf-8?B?M0twQ2hLOFM5RmdmbW9GcW1iejVsRGhaMVNwdVNTWVAxclpSbk1GVEdiUVlJ?=
 =?utf-8?B?SzFtclVXb21UYzhDb05SdjdPaEc4SmxDSTB1SFVvYkhWblV2YnNheFh1dWpP?=
 =?utf-8?B?K1JIMlFzQVphUHdleWozMTNmL1A0ZHpHdHg3ZDdKZ0lyVGNvblQ1WEl5b3Bm?=
 =?utf-8?B?Sm5jWEZtSzF2WGZMTGRDU1pvUlROQjB0WnNzNDRRQUVyY212QlBDL0VYVDR1?=
 =?utf-8?B?NHdCMDYwWWQvdmQyVmdsZTNXUjM5UE9PdFByOTdVMDY5bUliTVdOTEczWjNS?=
 =?utf-8?B?a0t1VTdFS1o3RlJNcDIwQUxCSXBsV0xCckptdTMzQWZVS2g2OEszVi9Pcm9E?=
 =?utf-8?B?dlBXMmJOam9CM3ZEVlUweEw3NmYyZ09VdHBEcDJNcjlURFg0MzEra0NXTHlz?=
 =?utf-8?Q?K8T1RC1UxXuH6T1niqbz8Yzzl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac199a2c-16f1-403d-f9f8-08dd5ff5baa6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:05:16.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86Yq78Mgs3511OzqZLskeI21iao3QiawvKuST5dMzmqju74Jd5wvZU2s3gJvhaN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389

On 10 Mar 2025, at 13:00, Matthew Wilcox wrote:

> On Mon, Mar 10, 2025 at 12:42:06PM -0400, Zi Yan wrote:
>>> Because of the =E2=80=9CCareful=E2=80=9D comment. But new_folio->* shou=
ld be fine,
>>> since it is the same as new_head. So I probably can replace all
>>> new_head with new_folio except those VM_BUG_ON_PAGE checks?
>
> Why not also the VM_BUG_ON_PAGE check?  I mean:
>
>> @@ -3364,8 +3364,8 @@ static void __split_folio_to_order(struct folio *f=
olio, int old_order,
>>  		/* ->mapping in first and second tail page is replaced by other uses =
*/
>>  		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping !=3D TAIL_MAPPIN=
G,
>>  			       new_head);
>
> 		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_folio->mapping !=3D TAIL_MAPPING=
, new_head);

We are checking new_folio but dump new_head, so it can cause some confusion=
.
But it might not be that bad.
>
> (or we could just ditch the assert entirely; it's not all that useful)

I am open to that.

>
>> -		new_head->mapping =3D head->mapping;
>> -		new_head->index =3D head->index + index;
>> +		new_folio->mapping =3D head->mapping;
>> +		new_folio->index =3D head->index + index;
>
> 	new_folio->mapping =3D folio->mapping
> 	new_folio->index =3D folio->index +index;
>
> (um, and that index + index looks weird; better name might be just 'i')

OK. Let me make the changes you suggested and fold it to Hugh=E2=80=99s fix=
 patch,
before Andrew picks that up.

Best Regards,
Yan, Zi

