Return-Path: <linux-kselftest+bounces-28509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05072A56F50
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5012416382F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206652441B7;
	Fri,  7 Mar 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sy/tMsa1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D924166C;
	Fri,  7 Mar 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369216; cv=fail; b=d9CtODIWdITQKcUyOc5+8xI3S1nKRNt+CybApIN/qGoETfPb84cQwuZM8WYz2cEAufM8d1GjrJBmSLWa6rCNwo+lt62T9sni2wkez0aHFbjtGPELEsTv96Sh0ah9ioZgfAtccgB8aIkjME2raUcdBHN7ePDWCr0RBdrzasl1Cww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369216; c=relaxed/simple;
	bh=NYkIvdAWiXsioMG9Wc9xGAsE5qFPNPe8IjRVeyejzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4Gt4dhd5ptTWa3bLtTdWsrxsw861C9E+M17C10v9q2UyLRhnSvTfRUFdiYtW1cBqAoKMymFC2p/PPig0AkD12jm3Mii1EK0/JaV83ZTzvge6PVJk9hOW4pzObbBw5CXLiY9fULVkf7pVCB143hkcibuh8bhIAyRVftU2fe4/H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sy/tMsa1; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6Kim043lkXQRPUwJ0vr8MZ28fbFB6pt5AP4K8I1nlg5THBwLvuYM79bqT4aUOyh2mUMVjcYuQzJ39MSvsiVB30bbMbLh8exoglvW3JZXh2pJrAO931EAJilMPWuRgc9luHjsYfvcQGUi2fS6UmxlTCZYOidlHbwn/Rqbtj7F0aaoY/FrtbAz44A7DWkyZUEFDABwz2BCqCXOqFZm0+RZ6fsiZE6cw/h2odSaSJ4JrzIY43YkMrXrnbu6OxMo+YyFhUXnZGyR8PyJXA5Xbry0r3+YFz3oSiVvljCG8fGHR4B+BsNFhVRNUfeQfLW7AvTME8EvxcuIb2K5inzW3oCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eykWjQF1YXBPjxsUA90+cJ6vRNVY7h+NYjEjvdbdz0=;
 b=ZdmeF1Q/peMAhEiwMNzxRtU4p7MfyVAywP3NV6PPzKDkf1j5+xKVCj67Yq+c7S6Xjy5SnXwbmYsDZ838+At1jlbkJBteyKPY/VWqqfhksJGVsdoS/U5kaLtoNAfeRCA4fEEpD9JnapXb2ezfm/JnDJNojLlUU+dtavqBMq48p/f/dOxKWwBGsKn16I94BcG5YX4xIjgV7TKwosXn/aeIp28z7t3Wcm4dPmSoGDdkZhgo9/NwWEXNx1x9jILt7bUxWP5kNgM60mL+FrMa1mPe2EtIOcJkDh4rGQ6sfUUaMCuj6gK0PcLWCZowtM1fVdbuRTXT9yME7604s2moWAlb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eykWjQF1YXBPjxsUA90+cJ6vRNVY7h+NYjEjvdbdz0=;
 b=Sy/tMsa14egndzRhHFq1X3sd8oC2GYO7laVBV/x3Gbvsu/sNdPNp0XUdyDIc02hOJKfsb9KRR2dhDuZlGyP8V++673APVRG3ZBmJr2Rk9XabIm7v4WYdT4zFlYqAL8xK8OeqXStZDl53kod5Nroy4+MCDdOViQIcgXPJuGb2XTUY5yHS5wbAcZ5l46mo9l1CZnKNuW+1V7bx8OxkQ///t9jNexOzkgCIJw4R+mUTENcRsztuIVW2X7Ed6NnW2BJd3AfLwYnVfQxBQQmrmUTBt3QPNCjcARWHSLg5+5mkgBsi/CEdGHmPtOKlPQ9Y+g4g3VL7h2o6lz/Z3wqfFCOK4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v10 1/8] xarray: add xas_try_split() to split a multi-index entry
Date: Fri,  7 Mar 2025 12:39:54 -0500
Message-ID: <20250307174001.242794-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0136.namprd02.prod.outlook.com
 (2603:10b6:208:35::41) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ef5c3a-8798-464c-a42f-08dd5d9f1ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JGlpFc5IzAuwhuhnrixdaRFeaK3Xr9t0MthJaHakuELd/olCmWnlX9HSR0p?=
 =?us-ascii?Q?blCMx1HH0G5yOw9IuiVpeOvo3kJ6cUB37poOpQMUbnEWhLLJP4HYe9pKDZpu?=
 =?us-ascii?Q?U9/7x8sn2r/BMnkmpVGCmflT7MzvJ/+csy1Xk3GKBwETsGYB3mlr/G3iTL3R?=
 =?us-ascii?Q?pSa49THmNRiYyVA+RneHsLyz5v2jYpwsQ3W93Q9H2j/qxYxJKV6np76DDNXa?=
 =?us-ascii?Q?47u1x4jlmKBP3niDOPuzoljgnCmspjd6xfFKIOvk1AMNmjpRHEVCPiuvuhkZ?=
 =?us-ascii?Q?lAguXnB20hX0SidI191cizdGP+T6a3Ui0CaThosiTtBoqujj0mTA4ioH0A0s?=
 =?us-ascii?Q?SnlICarUIbKG5V3khzUyxjk/juIPMSdP9F0Znu9xZPolnQvdWeV8fiv0joqm?=
 =?us-ascii?Q?U+t9l3XVsnzWXv0Wrk5QaaNIYH1deCL64UmqLZ9kLIyfynAw6t+shMEOXIah?=
 =?us-ascii?Q?bkH3T15p1I3k1nDgqcDIg2aKDRRLEDYwmnke9S0UxsSEXpZ85XJo7dD1RrjI?=
 =?us-ascii?Q?c2R9Nfsn2s6dJbeXtdvIXic8w5Bp2mL7BA4onhoWze3pkCoGRnDG9eULTB6+?=
 =?us-ascii?Q?E2BWnnsVK+ubDmuGsTwhpYo63k6IH7+B/gpFgi9w90aObL7isPN6CHfx5oP0?=
 =?us-ascii?Q?ecM40fTb9YsUxdas2PvzXqD5QMPAskUahNXG/R7QTBzTnZ1hx1W3y9pa95zF?=
 =?us-ascii?Q?5G1RLHBTA0Ijb/zWDB6Tqa5hEOU278r7SuSImAaO4uxI5p7/rtUzmNN9FKjM?=
 =?us-ascii?Q?Td4QJPrt8VT1EoSBlL5fe916QFPUvhQpOD5HNh8k4sYaGKJvWSsf537WSGtH?=
 =?us-ascii?Q?IIGTkIk3hJrbtbm2/ZNLrmIcd71PK/wO0JWzN3wwHNceCfMnLJl8dn5OM35f?=
 =?us-ascii?Q?2dr1ylIOipPjH4L3U4GHcoqApnOtCP3qrH/x+aY90iGq9WQ0tLluXxkV4amX?=
 =?us-ascii?Q?nfkIfVtoU0AhAqwcI5rNtK6t1u+U9ccgdZ/WdTfzOe36upZze5ofLaHsV5qa?=
 =?us-ascii?Q?n59jpQvapOm7GSf5L4v2o25y2r7VoMDWtRCvzClEiGWF3yrZwf/AQXY6ie/n?=
 =?us-ascii?Q?3tILaRVK29a9SuasWEf04oUs1/lDPcNE4B2eWToNNdZeXskslWsONutkzkrA?=
 =?us-ascii?Q?ilzoY6eTIMAsWCKYNHwOQG5VR8sy3lzlj1Cxn48kGLddjUmRS1f+01xHieLY?=
 =?us-ascii?Q?WR4dtck0xCqy7lgV1eAntjx32qwXm+b1oT3Qi1nTv2jcuxKhOpmvUNdZ9Q+N?=
 =?us-ascii?Q?htMbPmlpomYF2wZPzM1t6wRpbqULVoYkHIRgiYwYYl96p3TbpFvkv50foBDd?=
 =?us-ascii?Q?dRUX+m8hsyOXL+3T3HxY7g+8w/seDW0K9OguiKAcaJGzsxXa7w7ruNztxHmb?=
 =?us-ascii?Q?XBEe89jklD53J1YPQQYAWCbqFgki?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzTMtRSbTFPNpmT5WN6WuMkv2YT2QTV09qiSaEkaPZH/MSJmRx4PHSQ6lKUl?=
 =?us-ascii?Q?oJZA3+rkUIy5UDYfeaeDonLBJCuwc+/ygUzfaN1RDNe9wDMH3zdkWORfQ7nR?=
 =?us-ascii?Q?yaejg6z8henbYbMf08n3iWO+ITDaAQbb5Lt/Y3oWT0x20cNeXKKlpfB3MPtW?=
 =?us-ascii?Q?RlrFd2n2KPMv8UxCExuGmkeWT5X7y6AFCK2Dp6qd2IJq/sDOZsgazOf+eIuS?=
 =?us-ascii?Q?3iTYefrD6zgmlcub4/L8d7u7XZgq6TMjn/mjQQYCiz7A8udBiXoA2q0WjnUN?=
 =?us-ascii?Q?9cpQ9Jm6LVloGRm6+CMu5QxXuGiQ/+ro+d82jw8v2by7nxkBRhuig9mwJygi?=
 =?us-ascii?Q?oQcRBSNKC7Sh0Y5nhDefc+5TqLcwIGvMI48aacAh52qcA9+ToQPLI+e4DaR/?=
 =?us-ascii?Q?oLrUNDYzKxIoxuEymJBn9lnvII3odSUEAT7wg7s/+gjyX+tyjA2mZr7oVmcq?=
 =?us-ascii?Q?PDqvpHw50pI8KWMiS7G9YptFialLUySCuMMAGCARxLprYuWZVS2ODDFoOHwY?=
 =?us-ascii?Q?r5EXjTpC5i3Da2QjGLTZc2d8C5sMBwStu2h5MH3fWgSWlTDTwyGA35uw0i6A?=
 =?us-ascii?Q?VfcPYWEu67zeUgtrkld7OdnMYXkm2EBQ9fGPCYP+ShUqYEUge2x10uRXRhj8?=
 =?us-ascii?Q?cu7o4FUVas8yoYJc/NI9PaRpUDoI8zMo6h25FrmVZBIBbHKbRAiwBz/wNlPM?=
 =?us-ascii?Q?CTqdPGtVr95gHKnNREqoUDWb2dcttzSEYWrNh49JLW9f04E7/Ircx/nJSk8c?=
 =?us-ascii?Q?OBUbEVWfhah3VihgIphdwJ1DwmhIc75g6n1aydaO7SJqrbGtF/mYC/Ek28Ft?=
 =?us-ascii?Q?7eQQSTBXDOZqeybmxnbIOv5vQPqAxIbllkl05mVaT7oEA9+xxpgzQDtwHE1V?=
 =?us-ascii?Q?j/Zuub8+lOaWJ9qMdw8G5LYZ8B/WOWKg6OM9+GJeJLTU+BlHgbtSE8EgjL+T?=
 =?us-ascii?Q?dkBB/GJJeB86WtSrzcUxaHuP7oHhVbDgndclFrLcn3dVDeulmu1KlK+audp3?=
 =?us-ascii?Q?XO44VirrwLeFiSiFpbCF2NBmqLuRFqNuY0cuBe6obrzsk/61vX5MDpRvmCGb?=
 =?us-ascii?Q?jPU0Wj11JIjGkEtZlpHu4Tdhav/H5jj2AMUOjh8DLGMDAjE9xiewSOdY3BgZ?=
 =?us-ascii?Q?vAXbVfX4kbbBPDUR+izD17Udd2FvgUItiKaLVslUm7lBROlhzS6ZyMLTDCq6?=
 =?us-ascii?Q?bKG3UPLG4ueRX4Cm4+PUCsgfLFs/+THKNPyWRIRgG3YjX9MBCxsdjzzoFxWn?=
 =?us-ascii?Q?REousiyDec5OZV5pheFxtFck+lXPkswtaUVnWMfSEIcuXxNzGQ3NjiXSYqPX?=
 =?us-ascii?Q?W77LNU+YM34IGSjZnGRjnxTl5E9LUXRVAJGDa4Hxpvc2BCJwC1wFl/WV5R/p?=
 =?us-ascii?Q?1YMYFqYDZvmd3+p9xp9FXkwT+Oo4cCJ2oKni32o5rjDLpneyp65kpKc5H56L?=
 =?us-ascii?Q?wbW05oOjjVhA9KPgJXonD7rDqalKA/NWhek46n+oadNySqkyiPjaXIx/mpEs?=
 =?us-ascii?Q?N3+WHQv4BHpFPjUjOSVwk4DD9knXJMAjfyPMg9zN79HZn+zS1DOnKfzfAmPy?=
 =?us-ascii?Q?heGgfpJVvy/xFsIBLpzqBR4LGc7Tu8EqidqmMDgl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ef5c3a-8798-464c-a42f-08dd5d9f1ad1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:08.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yys3Bu5h+OdrIlHU/rmJbgnOWfwmEEqxv2pvo8T0zEUmmH5GB8lsEv07FN5djD6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

A preparation patch for non-uniform folio split, which always split a
folio into half iteratively, and minimal xarray entry split.

Currently, xas_split_alloc() and xas_split() always split all slots from a
multi-index entry.  They cost the same number of xa_node as the
to-be-split slots.  For example, to split an order-9 entry, which takes
2^(9-6)=8 slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8
xa_node are needed.  Instead xas_try_split() is intended to be used
iteratively to split the order-9 entry into 2 order-8 entries, then split
one order-8 entry, based on the given index, to 2 order-7 entries, ...,
and split one order-1 entry to 2 order-0 entries.  When splitting the
order-6 entry and a new xa_node is needed, xas_try_split() will try to
allocate one if possible.  As a result, xas_try_split() would only need
1 xa_node instead of 8.

When a new xa_node is needed during the split, xas_try_split() can try to
allocate one but no more.  -ENOMEM will be return if a node cannot be
allocated.  -EINVAL will be return if a sibling node is split or cascade
split happens, where two or more new nodes are needed, and these are not
supported by xas_try_split().

xas_split_alloc() and xas_split() split an order-9 to order-0:

         ---------------------------------
         |   |   |   |   |   |   |   |   |
         | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
         |   |   |   |   |   |   |   |   |
         ---------------------------------
           |   |                   |   |
     -------   ---               ---   -------
     |           |     ...       |           |
     V           V               V           V
----------- -----------     ----------- -----------
| xa_node | | xa_node | ... | xa_node | | xa_node |
----------- -----------     ----------- -----------

xas_try_split() splits an order-9 to order-0:
   ---------------------------------
   |   |   |   |   |   |   |   |   |
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
   |   |   |   |   |   |   |   |   |
   ---------------------------------
     |
     |
     V
-----------
| xa_node |
-----------

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kairui Song <kasong@tencent.com>
---
 Documentation/core-api/xarray.rst |  14 +++-
 include/linux/xarray.h            |   6 ++
 lib/test_xarray.c                 |  52 ++++++++++++
 lib/xarray.c                      | 132 +++++++++++++++++++++++++++---
 tools/testing/radix-tree/Makefile |   1 +
 5 files changed, 192 insertions(+), 13 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index f6a3eef4fe7f..c6c91cbd0c3c 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index entry will set the
 entry at every index to ``NULL`` and dissolve the tie.  A multi-index
 entry can be split into entries occupying smaller ranges by calling
 xas_split_alloc() without the xa_lock held, followed by taking the lock
-and calling xas_split().
+and calling xas_split() or calling xas_try_split() with xa_lock. The
+difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
+that xas_split_alloc() + xas_split() split the entry from the original
+order to the new order in one shot uniformly, whereas xas_try_split()
+iteratively splits the entry containing the index non-uniformly.
+For example, to split an order-9 entry, which takes 2^(9-6)=8 slots,
+assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() need
+8 xa_node. xas_try_split() splits the order-9 entry into
+2 order-8 entries, then split one order-8 entry, based on the given index,
+to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 entries.
+When splitting the order-6 entry and a new xa_node is needed, xas_try_split()
+will try to allocate one if possible. As a result, xas_try_split() would only
+need 1 xa_node instead of 8.
 
 Functions and structures
 ========================
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..4010195201c9 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1555,6 +1555,7 @@ int xa_get_order(struct xarray *, unsigned long index);
 int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1576,6 +1577,11 @@ static inline void xas_split_alloc(struct xa_state *xas, void *entry,
 		unsigned int order, gfp_t gfp)
 {
 }
+
+static inline void xas_try_split(struct xa_state *xas, void *entry,
+		unsigned int order)
+{
+}
 #endif
 
 /**
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0e865bab4a10..080a39d22e73 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1858,6 +1858,54 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	xa_destroy(xa);
 }
 
+static void check_split_2(struct xarray *xa, unsigned long index,
+				unsigned int order, unsigned int new_order)
+{
+	XA_STATE_ORDER(xas, xa, index, new_order);
+	unsigned int i, found;
+	void *entry;
+
+	xa_store_order(xa, index, order, xa, GFP_KERNEL);
+	xa_set_mark(xa, index, XA_MARK_1);
+
+	/* allocate a node for xas_try_split() */
+	xas_set_err(&xas, -ENOMEM);
+	XA_BUG_ON(xa, !xas_nomem(&xas, GFP_KERNEL));
+
+	xas_lock(&xas);
+	xas_try_split(&xas, xa, order);
+	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
+	    new_order < order - 1) {
+		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) != -EINVAL);
+		xas_unlock(&xas);
+		goto out;
+	}
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	xas_unlock(&xas);
+
+	for (i = 0; i < (1 << order); i++) {
+		unsigned int val = index + (i & ~((1 << new_order) - 1));
+		XA_BUG_ON(xa, xa_load(xa, index + i) != xa_mk_index(val));
+	}
+
+	xa_set_mark(xa, index, XA_MARK_0);
+	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
+
+	xas_set_order(&xas, index, 0);
+	found = 0;
+	rcu_read_lock();
+	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
+		found++;
+		XA_BUG_ON(xa, xa_is_internal(entry));
+	}
+	rcu_read_unlock();
+	XA_BUG_ON(xa, found != 1 << (order - new_order));
+out:
+	xas_destroy(&xas);
+	xa_destroy(xa);
+}
+
 static noinline void check_split(struct xarray *xa)
 {
 	unsigned int order, new_order;
@@ -1869,6 +1917,10 @@ static noinline void check_split(struct xarray *xa)
 			check_split_1(xa, 0, order, new_order);
 			check_split_1(xa, 1UL << order, order, new_order);
 			check_split_1(xa, 3UL << order, order, new_order);
+
+			check_split_2(xa, 0, order, new_order);
+			check_split_2(xa, 1UL << order, order, new_order);
+			check_split_2(xa, 3UL << order, order, new_order);
 		}
 	}
 }
diff --git a/lib/xarray.c b/lib/xarray.c
index 116e9286c64e..3bae48558e21 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -278,6 +278,7 @@ void xas_destroy(struct xa_state *xas)
 		xas->xa_alloc = node = next;
 	}
 }
+EXPORT_SYMBOL_GPL(xas_destroy);
 
 /**
  * xas_nomem() - Allocate memory if needed.
@@ -1007,6 +1008,26 @@ static void node_set_marks(struct xa_node *node, unsigned int offset,
 	}
 }
 
+static void __xas_init_node_for_split(struct xa_state *xas,
+		struct xa_node *node, void *entry)
+{
+	unsigned int i;
+	void *sibling = NULL;
+	unsigned int mask = xas->xa_sibs;
+
+	if (!node)
+		return;
+	node->array = xas->xa;
+	for (i = 0; i < XA_CHUNK_SIZE; i++) {
+		if ((i & mask) == 0) {
+			RCU_INIT_POINTER(node->slots[i], entry);
+			sibling = xa_mk_sibling(i);
+		} else {
+			RCU_INIT_POINTER(node->slots[i], sibling);
+		}
+	}
+}
+
 /**
  * xas_split_alloc() - Allocate memory for splitting an entry.
  * @xas: XArray operation state.
@@ -1025,7 +1046,6 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp)
 {
 	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
-	unsigned int mask = xas->xa_sibs;
 
 	/* XXX: no support for splitting really large entries yet */
 	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <= order))
@@ -1034,22 +1054,13 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		return;
 
 	do {
-		unsigned int i;
-		void *sibling = NULL;
 		struct xa_node *node;
 
 		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
 		if (!node)
 			goto nomem;
-		node->array = xas->xa;
-		for (i = 0; i < XA_CHUNK_SIZE; i++) {
-			if ((i & mask) == 0) {
-				RCU_INIT_POINTER(node->slots[i], entry);
-				sibling = xa_mk_sibling(i);
-			} else {
-				RCU_INIT_POINTER(node->slots[i], sibling);
-			}
-		}
+
+		__xas_init_node_for_split(xas, node, entry);
 		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
 		xas->xa_alloc = node;
 	} while (sibs-- > 0);
@@ -1122,6 +1133,103 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 	xas_update(xas, node);
 }
 EXPORT_SYMBOL_GPL(xas_split);
+
+/**
+ * xas_try_split() - Try to split a multi-index entry.
+ * @xas: XArray operation state.
+ * @entry: New entry to store in the array.
+ * @order: Current entry order.
+ *
+ * The size of the new entries is set in @xas.  The value in @entry is
+ * copied to all the replacement entries. If and only if one new xa_node is
+ * needed, the function will use GFP_NOWAIT to get one if xas->xa_alloc is
+ * NULL. If more new xa_node are needed, the function gives EINVAL error.
+ *
+ * Context: Any context.  The caller should hold the xa_lock.
+ */
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order)
+{
+	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+	unsigned int offset, marks;
+	struct xa_node *node;
+	void *curr = xas_load(xas);
+	int values = 0;
+	gfp_t gfp = GFP_NOWAIT;
+
+	node = xas->xa_node;
+	if (xas_top(node))
+		return;
+
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+
+	marks = node_get_marks(node, xas->xa_offset);
+
+	offset = xas->xa_offset + sibs;
+
+	if (xas->xa_shift < node->shift) {
+		struct xa_node *child = xas->xa_alloc;
+		unsigned int expected_sibs =
+			(1 << ((order - 1) % XA_CHUNK_SHIFT)) - 1;
+
+		/*
+		 * No support for splitting sibling entries
+		 * (horizontally) or cascade split (vertically), which
+		 * requires two or more new xa_nodes.
+		 * Since if one xa_node allocation fails,
+		 * it is hard to free the prior allocations.
+		 */
+		if (sibs || xas->xa_sibs != expected_sibs) {
+			xas_destroy(xas);
+			xas_set_err(xas, -EINVAL);
+			return;
+		}
+
+		if (!child) {
+			child = kmem_cache_alloc_lru(radix_tree_node_cachep,
+						     xas->xa_lru, gfp);
+			if (!child) {
+				xas_destroy(xas);
+				xas_set_err(xas, -ENOMEM);
+				return;
+			}
+			RCU_INIT_POINTER(child->parent, xas->xa_alloc);
+		}
+		__xas_init_node_for_split(xas, child, entry);
+
+		xas->xa_alloc = rcu_dereference_raw(child->parent);
+		child->shift = node->shift - XA_CHUNK_SHIFT;
+		child->offset = offset;
+		child->count = XA_CHUNK_SIZE;
+		child->nr_values = xa_is_value(entry) ?
+				XA_CHUNK_SIZE : 0;
+		RCU_INIT_POINTER(child->parent, node);
+		node_set_marks(node, offset, child, xas->xa_sibs,
+				marks);
+		rcu_assign_pointer(node->slots[offset],
+				xa_mk_node(child));
+		if (xa_is_value(curr))
+			values--;
+		xas_update(xas, child);
+
+	} else {
+		do {
+			unsigned int canon = offset - xas->xa_sibs;
+
+			node_set_marks(node, canon, NULL, 0, marks);
+			rcu_assign_pointer(node->slots[canon], entry);
+			while (offset > canon)
+				rcu_assign_pointer(node->slots[offset--],
+						xa_mk_sibling(canon));
+			values += (xa_is_value(entry) - xa_is_value(curr)) *
+					(xas->xa_sibs + 1);
+		} while (offset-- > xas->xa_offset);
+	}
+
+	node->nr_values += values;
+	xas_update(xas, node);
+}
+EXPORT_SYMBOL_GPL(xas_try_split);
 #endif
 
 /**
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 8b3591a51e1f..b2a6660bbd92 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -14,6 +14,7 @@ include ../shared/shared.mk
 
 main:	$(OFILES)
 
+xarray.o: ../../../lib/test_xarray.c
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
-- 
2.47.2


