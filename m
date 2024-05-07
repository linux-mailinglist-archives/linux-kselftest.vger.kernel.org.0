Return-Path: <linux-kselftest+bounces-9568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32848BD879
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 02:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A051F23318
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 00:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE3637;
	Tue,  7 May 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iy3TuCbn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445BE19E;
	Tue,  7 May 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715041468; cv=fail; b=QAAh4rVs/sao18tXAHVQn2wbxyj5rTtVlBMV3woCRVNaKv397UvIHvfGFAcXrtVZyREFu46gG3qVADD4UtNwoVgT9NS+W1Pye1GEYDIrQm2GOfKIWg8OBLLld6FSTizMPGNZI8JyCGqXcBlRW9COiy2PqS1oA1TJiCCIw/ceQDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715041468; c=relaxed/simple;
	bh=umG0Wkit5JLv8Rfjapg+x/UmroSu3T5o8IeOc6JhZwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=apTXihqWZFNQlOBI+xxTeZEGZNUXuxfWzLjzJW9r+NM4Iw5zEsDJfOXzvGgE8r6o5qAuEMykrN2CHybctC6UY3+QU7KAUMhIgEEB6NHHjPvwpLC3Xzl1OpNm0VdEIzH1BHvGaZLiM/4T7m7/RXbfZlDpE3RAHgWJkCRg9CLR1do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iy3TuCbn; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsgcTn/mNXdc0Sb8C45YS25Fmnzut3da5R+3C1czY/c7ypY5pTj1MHtSWP8jCeITkI8JTlHeDPjRgL/x8qZb32nMC5eX+0gZScv8yMZAiOFWvNdxWC+WBIugrtppVNdXGIU3co0af4zg+ecOKQbMuWmBh4Uz6Wbxa7W4Z1Zivqd1yiRMyFo7aBkOdRZr72e8KXFgZxK/UhxiNPpSTO5lfgLczzx4BQYuP0N8/YiEryj6WncNczUyqnJRyaxQVd9qAm+kiQQ28bK7ov+y523W2VtwK2Y1Z+zVvxLkM7eyYhq+1dT3JuA/0l4WXn8b3es//gsrP4u538UjcuiAUzL26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGGOsFm9XeVTgPl/hnPK4I5/jcO4KwRvz/I35mzY1sE=;
 b=lQiAJFDh6eMQKRBJXwSDTsbNwAES1CViSK2+f+un7sV6kWQEB6hmRLyvJGhj9YtyWP3CKJ3cnXXAdAsYB6ULRwtj/3v2Gvp46RgSJB54lYm2TicnVyBzjRw7ZR0bUojBslsAzF8yTyobqZzhdZW0qtEekLcMxcnnKdAN/oPAzG6loB2R8bVgtDfs5w/Dz+n/whoRk4FmimkSvauPL9VfXb3RCVOUNz3h0KBjjjARm29Vp+E7AcjNRe3q1JOuWsfHs6lTaTyy7bkhMdQHmLxdVsdtoy19TdoQpsLGzng/YTkS/HjZ5J0U5fida+gpoKyPf/XyoxT8oRcreDdL0lmEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGGOsFm9XeVTgPl/hnPK4I5/jcO4KwRvz/I35mzY1sE=;
 b=iy3TuCbnXmYSpkE9s7DnzEyMAVW9U+eKzmCw2ivlAm5x0Q3S7h2iZ9WnHwyFG3SPrzaGUx0BknuNXqQworW9Nsb4pJ/EKUpm3wjeCXdDlijVHXF94/PEHWdr39MHMQPRcRnWBhBybNUDQtLR2ESwTB7O6cY01HRfEozhKmbq17RKX//qL23YdcrI5BfUwQGJHyavBR5XmeeMsE9jpgSO9Zc7EUrToMGdMdC+NM9Afk8NfQg10iQ9wMcNMFhY8KV5V2fVhlIHOy+GuP6Px90Hs/ioO0F6794fMyvDmCSlIpafgCtQxJ/831Qfn8vcxMFxwRcAF9PSAS1tzFL8+qMClQ==
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 00:24:21 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::a0) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 00:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 00:24:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 May 2024
 17:24:00 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 May 2024
 17:23:59 -0700
Message-ID: <963feb08-18c9-4891-b85e-e9e4667e40d8@nvidia.com>
Date: Mon, 6 May 2024 17:23:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: exec: make binaries position independent
To: Fangrui Song <maskray@google.com>, Kees Cook <keescook@chromium.org>
CC: Muhammad Usama Anjum <usama.anjum@collabora.com>, Eric Biederman
	<ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Yang Yingliang
	<yangyingliang@huawei.com>, <kernel@collabora.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240416152831.3199999-1-usama.anjum@collabora.com>
 <202404161027.63F4D4FDEB@keescook>
 <CAFP8O3Jjkh0U94CbS=epXELMtCBpYt4fGejX3spH4=GdF7zVSw@mail.gmail.com>
 <202405061704.DD3AF674@keescook>
 <CAFP8O3Kx+bVCVQpQJVBrPkjrQO9d5rdcxGGP-Jn6t_Mpc995RA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAFP8O3Kx+bVCVQpQJVBrPkjrQO9d5rdcxGGP-Jn6t_Mpc995RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b221c9-650a-4ac0-caae-08dc6e2c0a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGVKYnUreDdNdHZHaFM2d0NIL0xBaUIvVnVHOHI4WENFUTN1NGUrZTEyZnJJ?=
 =?utf-8?B?ZDFucUV0UzZKWk1xNjAvcjExRktQbDZ3cWFYakFnK3F5dDZwd2tUR3FHczB3?=
 =?utf-8?B?RWxxSHpsWU5pbUxOenh5L0xmOEFsS3hHNm9ZNDhKdjlvYnRWZmpQeFRXM25q?=
 =?utf-8?B?ZjYva0pub0Rtc2xSYTZydUJHNHRqZXpzVzNta3dKcDVtMFFnalNTcHd5MWh3?=
 =?utf-8?B?WUlSclc1R0xCK3VyK3c4aU5WdTlRQWJ6SytvL1UxemlDenZRaXRpemJDeHZ4?=
 =?utf-8?B?VzgwSEN3MXdOcG5mZW1MYU9DWCtVc3gxOEswLzdpTGhRZkZ3TUJmK2hnOGtQ?=
 =?utf-8?B?ZkttTUZ4V1FMeWs1Zjg2cmR3SE1VVGRnbDcrTHpnVnNzM2x3WDNVaG5Sd1FL?=
 =?utf-8?B?K0QxdDg2Sk00QkFyNExndzU2dW9XQkY3S1B3QTBGeFZlOGlkWDNzVkZpWk5j?=
 =?utf-8?B?WkdEMThjQUV2UFhDcXpYY1VlL2UwWGpPbVlNVUtibWJWMVdqT3ZVU1hIRXA3?=
 =?utf-8?B?UUFHQVg0TjRYbE8rdHA0TFhTZ3NkRUg2SENOSlJtMFFTRDRzYVZNaVhYWXRU?=
 =?utf-8?B?dUpEb2ZnTmhRWnNDdi9GUnEyb09BRDh4eUxSYW9YT1pzWkVVY0prSDJGbGxH?=
 =?utf-8?B?Qi9HaFhpbm1TZStxUmR5WEQydU5lMEY3UElPNmhGanU4TG1WaTBBWmpnaXpt?=
 =?utf-8?B?WlE2akdFZWVVWVA3Tm4weGtXZUxIVEh5Z0JsTERneThLQW1MS0VydG5JQTl1?=
 =?utf-8?B?UmlTMzgyUnVVK2VxcytrSCtzZEZ5Vks5a1JuOHQrcTJBREtkdldJNHNDenVs?=
 =?utf-8?B?MG5ZeW1JMXBUL2FWL2VpVElBY0RmYzh6cFdmSkd4aDlmQWNiRjQrQ0Q2dm8v?=
 =?utf-8?B?SkxocFZzWHpiSGZ5MGZ4VjJUU1d6aEdvUXlHQUtFWHZrOXY3cWM4b29LRGRE?=
 =?utf-8?B?RDE2bGJ6Wjdid1haWlUxQUgrT0poQ2R6OXdob1FmWTEyMEhqQ2wwaHNNendI?=
 =?utf-8?B?N3Rna2Y0NTRRRlZQajdJbk1kVDdYVWpLQ1FxUDhGdi8rZEsvM2lKbGllODFW?=
 =?utf-8?B?ZTN0NFZ4eDFFVHE4V3phRVdzWkV0KzZFaEpVZVhjWjVrM1JQQWhZaERVbVV5?=
 =?utf-8?B?UmEwRG1jQ0t6ZFF5Q1ZVWW5qcUo1b0dYc0VlL200U3hHOUxLNjZId3lLRmQr?=
 =?utf-8?B?WFlGUTI5NlVXSE1sYWt5ZnBCRmdvR202Q1V1cUYzcTEwaHVMUWxMQUh5eVJN?=
 =?utf-8?B?UzJneGRoa01QRDFsdmgyQXpoWWV1aVk1M3prR2dSVGNGUGREbmdkclU3SGxo?=
 =?utf-8?B?SkFQeGRQU1hQdy9kTWdnSEtDNVQvRkdtQ1NpOFhLVFZ5QzU0YUt3Snkwb3BV?=
 =?utf-8?B?U0pJWE9TMStLdlBVZGlzRm1ENXpvREpJSlhCb0IrQXUxcm94anhSc0tZU0cz?=
 =?utf-8?B?WDlUNjBPQXJOZVdiUEdPUFZ5NGpwaWl2eVh6WEtXY2xEOFdYL2xHMVNXL0Vp?=
 =?utf-8?B?WWkzM2dwMmhNdWpuN3BhajJLUDdKc2tzZWVrZThxb253clZ2MDkxWWh0dHha?=
 =?utf-8?B?QTU1UzdFZlgvL3piSnVWNlR6Mm4wK2xqbDdwVnVPTElyN05icjgxT0QrUGQw?=
 =?utf-8?B?NXlNT0hYSDNLdjlxbTdRNDd3S2dDU3FRTGZxRS9MUW9tSlVobnRXckdTSFVH?=
 =?utf-8?B?Z2g0Sm5hTm9pU28rcUI5OERUZVNjc3pqTXFJNE90bFFFUU5FSkQ5Q0hJcnJR?=
 =?utf-8?B?ZlhDV0hEcjRReHNvcDdtL3ZyNWpDdU9ZQjdzcXhySTBjKzVpK1R6QzJVblVJ?=
 =?utf-8?B?TzhENWFxS3JBNFNQSGtmQVZ1c3Ntd3JydVUwaXhQZFpKaVdnbDM1QnZSRmV1?=
 =?utf-8?Q?q8Wa8SbuIP6aS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 00:24:20.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b221c9-650a-4ac0-caae-08dc6e2c0a28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917

On 5/6/24 5:14 PM, Fangrui Song wrote:
> On Mon, May 6, 2024 at 5:05 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Mon, May 06, 2024 at 04:30:27PM -0700, Fangrui Song wrote:
>>> On Tue, Apr 16, 2024 at 10:28 AM Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> On Tue, Apr 16, 2024 at 08:28:29PM +0500, Muhammad Usama Anjum wrote:
>>>>> The -static overrides the -pie and binaries aren't position independent
>>>>> anymore. Use -static-pie instead which would produce a static and
>>>>> position independent binary. This has been caught by clang's warnings:
>>>>>
>>>>>    clang: warning: argument unused during compilation: '-pie'
>>>>>    [-Wunused-command-line-argument]
>>>>>
>>>>> Tested with both gcc and clang after this change.
>>>>>
>>>>> Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>
>>>> Thanks for this!
>>>>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>
>>>> --
>>>> Kees Cook
>>>
>>> GCC versions before 8.1 do not support -static-pie,
>>> while https://www.kernel.org/doc/html/next/process/changes.html says
>>> the minimal version is GCC 5.1.
>>> Is this a problem?
>>>
>>> If not, and CFLAGS is guaranteed to include -fpie/-fpic/-fPIE/-fPIC
>>> (PIC), using -static-pie looks good to me.
>>
>> Should we use this alternative, which may be more portable?
>> https://lore.kernel.org/all/20240504022301.35250-1-jhubbard@nvidia.com/
>>
>> -Kees
> 
> s/-fPIE -static/-static/ then it looks good to me:)

hmm, maybe that is better, considering that -static-pie is relatively
new (as you pointed out in the other thread), and would break the
minimum kernel gcc version requirements.

> 
> -static creates a position-dependent executable.
> It doesn't matter whether the compiler uses -fno-pic/-fpie/-fpic
> codegen, so -fPIE can be removed.
> 

This is something I'd have to take your word for. The whole PIE
story not completely clear to me, but if you're sure it is not
required here, then of course leaving it out entirely works nicely...


thanks,
-- 
John Hubbard
NVIDIA


