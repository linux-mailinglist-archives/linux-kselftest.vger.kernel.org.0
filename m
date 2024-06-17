Return-Path: <linux-kselftest+bounces-12102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A922890BBCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 22:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2608E2835ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF92118F2E4;
	Mon, 17 Jun 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDUoWc7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA020322;
	Mon, 17 Jun 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655375; cv=fail; b=AwFil4XLi5zsJKPZ5CAjWgJNlmibRpH7TJVAbBPh6DqeCZ+Bb4eDNWN6XuhZ6S6SdXZb+Hj7CnAKdKxIY7fSBqqyUNJHSiqLm8NewxBWgBEXx6JluP2+CQm4cJi/5ya2Mzs3/KNIb1qzTmsYOX6dBTRgpuKdzF8ZUSRXsXqXMu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655375; c=relaxed/simple;
	bh=F0SOc4te4+9IjLL/leDaXaG4JNjYwHpwK2ObItNhHuI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=AEdGFkBD/PwV14zOnf3fVUp2sfOxgShcSUZV8FJu6rxRaWRgXnlRl1qfUaujKEpN3y0HbkPotOZF5ymrD98Tf84TALqoqq9uPFg4dNkWt6O6QTcg7kKd/IPKLqJ6hYVif1haUlukUBdMGpFMpSegHCy7sl9kj91DrwZ/SPe+mTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDUoWc7r; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exdU8q4Z+8wOa+O0IV4883aGD6VS4f8oJUIMjFA5C7ETovr/DxAmweb1aFLeuD2g0ZjIYHc9DRj9lm/MQML0BXz8+StZwysh9wTm3zDFNfsUzhj4tvODvY5KcXE8n3L+BTitM3QzlOO9aDoso+fzMxDJoKyptI+jBJOqhI2Es0/go8mjp6jMJHiALa3L9cTRqB1x0iQ1hDCQ7civcHsEflzeOiu9bAmnfVWsveHxkYjoIYMts/bY/8A1UOENaUBOAGxJsOn8S88D9wG4LPFg3NlvMfA5XEfYCkBl1c7DqiN5ePoBxAUhCnqi6kY63wOrv6Ux8/TLPkHxHvuTsaunog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfCpajZBwmzPJv7T92Q3BK31OqYuLwBi3bo4SV36yxo=;
 b=CM/+XVnmUK7mBIgPTixQTVmc2f4v/8NMf5e8l+iJ0QfZQXs+jRhEx+EivL0GFdWGZy7BG+k+33dbvlScaQRbDjBTiBqpf+SNzfzYBys0yxIokmTpNQm1tcYZOnUMem8qka5far9VhejaKdi62l7jGRv7Q0G2maDpUFFEesUoG4RUmv09ghgmAZ6alV2loiaWgqe4Z1XDi/ezQktx553EUtI/KrGyQABAWulAMRjF+I7CIQGMNOHFZfj3En4PWRp/fLOprfx+ZUUjwbva2BtoVs2HVemy4cS8HoYhLtjkyuP03o75V5nFU/TheMlQF0GvAtXH2R7c1nIAqaKAJdsmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfCpajZBwmzPJv7T92Q3BK31OqYuLwBi3bo4SV36yxo=;
 b=VDUoWc7r57OgRtqu4EMq6FZwb33XewX52SZ5bIPxU8WdvaCofVdZbuteJyVtaYizETnyiH+m1cFX8aBoWfaycVrUbnCkXhCU1y01clo6BGV4GPm57xeD4UMeNOnoCs54tNZFKIGaJhopOj8qe4e4+Qpi72F0YgJMDgIYiG+NVxwYs5umrvsqmbE6ZDXrshoA4hs85U66UIOWjKiTV9AKtlpvf6aE9KHFQRUwcNt49w4aGeX0oMpts6/rfHfAzTetp53YAjSrHQaV+uLyoPpOowvmbrTWkmOJvaEegIwu8vsuQJ2m3eTtLTVM42dDIkYevWWbRWxpzS6Xi/5JYmF1NA==
Received: from BN9PR03CA0160.namprd03.prod.outlook.com (2603:10b6:408:f4::15)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:16:10 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::75) by BN9PR03CA0160.outlook.office365.com
 (2603:10b6:408:f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 20:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:16:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 13:15:50 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 13:15:50 -0700
Message-ID: <e9de90dd-c541-45bf-a364-0e7aaf320314@nvidia.com>
Date: Mon, 17 Jun 2024 13:15:49 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Shuah, Andy L: [PATCH v3 0/3] selftests/vDSO: fix clang build errors,
 and Makefile cleanup
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
CC: "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Lutomirski
	<luto@kernel.org>, Mark Brown <broonie@kernel.org>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, Thomas Gleixner
	<tglx@linutronix.de>, Carlos Llamas <cmllamas@google.com>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
 <102e70cd-3979-4ea5-8df4-d3b2ea01003b@nvidia.com>
Content-Language: en-US
In-Reply-To: <102e70cd-3979-4ea5-8df4-d3b2ea01003b@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c39ee5-c41f-4db0-8efa-08dc8f0a5403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNTY2Q4K2dJRkJwTlBUbHEzSDcyK3F5Z1h0bGNHakVDMlNQVk1Gckg5bmo3?=
 =?utf-8?B?a1ZBRGFhUEVYR0s2bHNHYlk5LzRsdUJJUjF3VFJzcTFOL3BlTlkyT09LMi9W?=
 =?utf-8?B?MHk2UGJZbXhqbG9JcU1QenZ5WCtkbzh1eU12eXRMOHh2ZlJzY3I2NDYwRUhu?=
 =?utf-8?B?dC9SMFRtZ2ZKRUkxakpDY1NuNHVjVzN0TEhORUh0czdzY3BJTGxyTDI5Ny9Q?=
 =?utf-8?B?Y3NXbUdtdjdJc3o0Nlh1OUh1S2JHK3FRR1BhTjJIZVVuWGdZeXVaQ3hTSWJE?=
 =?utf-8?B?elNkMSt6UjdNUTNKOThJZVFSY0JHTy9WY0ZkN09HU0dSTDJybUJwVDFGNFkw?=
 =?utf-8?B?NWphWWg0TTR3Z01sUVh5Rm1wRjVPR2o0d1Zvd2tuRGg0OXd2V1NYNkNqUkh4?=
 =?utf-8?B?VmxobzJiTUM5NTYxSkZGS2hjWEd0d1FscnlpdUU2TzBVdXNCcVFBVUNZNXVK?=
 =?utf-8?B?aytLTmtrTGJQSnlqeHYyekxadEJrNm9HN1NNd05OWWtINEREOFVpbGQ3eVpy?=
 =?utf-8?B?TXVjVVcwSzI1RDd2dVRpWVBJWEVSWDcxT2R3alFOTmd6c2pHQTlMMkRTUUln?=
 =?utf-8?B?Qy9VcDRUOXpIZkVVYzBRTHQ2MEtjZkR4d0xLeSt3V3lqZkxCbDJadDZpeERF?=
 =?utf-8?B?T01URVJTUGpIUURrekxIeEplRDZia2EvdzdVa0xFelcyYTRua1RpOXNsaFZP?=
 =?utf-8?B?TkUxVmE1TzRUL3JrTmxFUTAvenlTQ0hsYWlkb05lemh0cUJSTGs1RHo0OUg2?=
 =?utf-8?B?cHFLV0Y0SEZ6VnlHaTQ3cjR4UWw0dFpoRnFxQzl0RzlGUWlDYldhdURuZy9J?=
 =?utf-8?B?SE1KdFpyZElFTnJCN1pkbnlwckIwcW5keU1FRkJjR2Z4Y25IdjJlVEdlMDlx?=
 =?utf-8?B?UGZ4ZC9qdUduVCsvMWpYMmpPNXowREN6c3I1V21wSHkvSlRKWWkwUGIxTVdr?=
 =?utf-8?B?bVAwM1hkeld3SEZueUVMWk9sdHBZZXFsdjZnd2VtZzhGVS9lS2tiendZb3VM?=
 =?utf-8?B?cHNmUjJxYTl2U0UxTURMOTU3QUNIQnoyNFlLNnVORXRmMDJxc2dBVFNPMTAr?=
 =?utf-8?B?andrNDgvcVlyVzdQUlNzVkFrUkU0ZjFMZngzRHRtcUsxZFVqelFnODNHdTlX?=
 =?utf-8?B?WjBKaVc4VTk1WXA1cXhjalQ4V2Yyei9ZRi9VaGhVV3ZuUFJLaXk5T1E4NjNz?=
 =?utf-8?B?L2h1YTJEaG4yK0I2V3ZRTmpVNXFScXVIdkVmUERHL0t1YWNNVzQwRjJ1bWZq?=
 =?utf-8?B?SERQeHk3eW9VVUpSdUtHbXpvT1FGQ3dvYXQ3NURSMkYwWFd4eWJnZWhFRzlY?=
 =?utf-8?B?cnRoZll6Q0h5VFk3eDR5aVRxcExNd0k2aDk0b09WVUo0YzQ3RGhOQklaSnZR?=
 =?utf-8?B?anRGd0ZubnZ3OXl1TngvdGd4OVF5V0pOMkhsb28ra3orRTVLczJVT2J3R2Rs?=
 =?utf-8?B?K2xqVWhiWTExUU9QdHdSeXlnK2JzYmZWRmJycnlqK0FVUm1QelNydm5VTjJ6?=
 =?utf-8?B?WFNEZkRneUozdG5nR1ZLaEM0U3hIYzNSM1N0WUc1MjI1NHg5TWQyZ2xZOWN2?=
 =?utf-8?B?TXp4MS9WRUN2YXFuYW9JWjJHZzYwTmJ1czRlVkhIT0RxWlRVTWViMExNaXc2?=
 =?utf-8?B?M0RSWDdJaUFoYWkrQ3V4eDhyTjhxaVp1YjVOU1NNelFzTGYyNmpvNkpxeVph?=
 =?utf-8?B?cWFEUkhxMGFTUkNub0JtZElEOTR6UDA4by9jUERKS3NMdTB2RVQxVjh5K0FP?=
 =?utf-8?B?NHpkbFNNT0FhaUpWVXB2VUpIK2NKZFMyZnJHdlJTaGhuT3NNbWVpdE4yVTlV?=
 =?utf-8?B?WGx2clZjdGY5aitpZlhmU3NCUTVTNFlPRG4zWTZDM2dWL3JreE5RQU5wbzJJ?=
 =?utf-8?B?dFhpaVc0bXR6STFwcWRhMlgyT21HTDBkK0hvZEtQVTNCeHZPakxPT3JrQ2E2?=
 =?utf-8?Q?qDM8PdPFlyA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:16:09.9700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c39ee5-c41f-4db0-8efa-08dc8f0a5403
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979

On 6/14/24 4:34 PM, John Hubbard wrote:
> On 6/14/24 4:31 PM, John Hubbard wrote:
>> Hi,
>>
>> Jason A. Donenfeld, I've added you because I ended up looking through
>> your latest "implement getrandom() in vDSO" series [1], which also
>> touches this Makefile, so just a heads up about upcoming (minor) merge
>> conflicts.
> 
> Belatedly adding Carlos Llamas and Thomas Gleixner to Cc.
  
Hi Shuah, Andy, Thomas,

Patches 2 and 3 fix up the Makefile, and I'm particularly eager to get
those merged into 6.10, because the existing Makefile is leading people
astray. See the thread in [2] for an example of that.

As a result, Jason Donenfeld is now waiting for this, for his "implement
getrandom() in vDSO" series.

The Makefile is more of a kselftest infrastructure thing in a way, so
maybe Shuah can pull this in? I'm casting about for ways to move forward.

[2] https://lore.kernel.org/13483c92-cac5-4a3a-891f-22eb006c533b@nvidia.com


thanks,
-- 
John Hubbard
NVIDIA

>>
>> Changes since v2:
>>
>> 1. Added two patches, both of which apply solely to the Makefile.
>> These provide a smaller, cleaner, and more accurate Makefile.
>>
>> 2. Added Reviewed-by and Tested-by tags for the original patch, which
>> fixes all of the clang errors and warnings for this selftest.
>>
>> 3. Removed an obsolete blurb from the commit description of the original
>> patch, now that Valentin Obst LLVM build fix has been merged.
>>
>>
>> [1] https://lore.kernel.org/20240614190646.2081057-1-Jason@zx2c4.com
>>
>>
>> John Hubbard (3):
>>    selftests/vDSO: fix clang build errors and warnings
>>    selftests/mm: remove partially duplicated "all:" target in Makefile
>>    selftests/vDSO: remove duplicate compiler invocations from Makefile
>>
>>   tools/testing/selftests/vDSO/Makefile         | 29 ++++++++-----------
>>   tools/testing/selftests/vDSO/parse_vdso.c     | 16 ++++++----
>>   .../selftests/vDSO/vdso_standalone_test_x86.c | 18 ++++++++++--
>>   3 files changed, 39 insertions(+), 24 deletions(-)
>>
>>
>> base-commit: 2ccbdf43d5e758f8493a95252073cf9078a5fea5
> 
> thanks,



