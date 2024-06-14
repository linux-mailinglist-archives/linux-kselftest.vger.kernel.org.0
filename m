Return-Path: <linux-kselftest+bounces-11988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC39094CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCCC1F21FC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D3185093;
	Fri, 14 Jun 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRyWFjav"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC219D8AF;
	Fri, 14 Jun 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718408121; cv=fail; b=egSO5sJvO/vNLsjXfCVp93mOxejA+5X5O0Za5qzH7adStzd+ogVYyEAbJ6ChcTCKlfGGW69FluJhMLa0ANFVyJDDlaXoxnLfob5F18MBoRyis9TZMOqX45ulGjhg9OU9oqhcddLQVfvr+QevlukiMvCcG5xklGM3aIT8AMEqq2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718408121; c=relaxed/simple;
	bh=zGBh62uSVxe5qmM78bihQ+sNicFaSARBgW2KFsU/sfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PcIZ3REpVOopvJtTiS+PTO58AO6CXu/5IWG+PB2KSQrTOI7QUsPxmnSxouVDW73yOcQV3HYU6JbqtSVarF2cwRcVYoni29ughsmMgGgGF19Rt8taORN4JB79SAfC75hRRNKcs+9SK6+QUT+5lSiCE7gppLkOl/d/jIkMbXDXr6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRyWFjav; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpGpZghpMH774hEDiAtvGRiC7WWcv6m+2bUETAWIqOBp5AM5PvFSszSpYp1TipLP6E2lBxV211RsKpBZ/wy6SRB9rQ0+FBAyJ03kc9VNY77qI408Zz16WcYBoUfcySpEkXNTXyWu2zU1b1jAMOC8LcNov3qkthCNbpLrRyeKvW7/obCVlmaEBSdfgYUbJ0FXCKodvtyg9EiuVKpk/vIevNQqRZmg7CycYeM4XYKBcdJpWxvGubGB/TS8YBxrv0dM/44FEj0T3xJlhNyY5BgccjlmAry9XDxJEzQ8stKV71I75fwep83srzsFq/aj7dSJGupcArgZjU6/7fak8Muqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhurIqvlXHPs7jjtPhlJnLY9B1D1VScNay5FgNiJvac=;
 b=PcOY7AVuVzqo/LCi717WOkQuJplwq8yMwQgn2oKfnlzrFP7C4/TRA3ldEC1W+BBLOA+azl0SW5+P0TbwvUnqievb8RUb5K9eYUpzz5sQCOu+aIzvNzpZHQb1idBtl05SXaPehWIKnLhuaavWeFO5u5kCjRBxI6BwKxXfPc+e/uLzV/dm2xB1QiT74VzULFHOfJDsKvtRUbNElmlBjZ3pylobm94Qinndgt0KCkW91oRUX3AHtkBn3rmooeqRv0zIRnE9lNmoREtT0VSzPG5wd555VBGta8Yj9wMyPM0geoyXHmV+OuyB0br8ZT3W7hn2WHOa3ydYPuJDKXFJsAaM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhurIqvlXHPs7jjtPhlJnLY9B1D1VScNay5FgNiJvac=;
 b=gRyWFjavT+OUjUf1fYLv4h1wvKQqWWGuL2pzIEMBoQrnji71JOY7EvkO9zyhNcYH72wf2ftDbJ4BI4T5xlu/nA83+osmqyo1OEQclqtoZjNwv3cn4m1J9yFGE7+B1Edd7AH76TQjT2l1w6UurNPWPmNU+mDMAU/8TOLQwPi/f7BfqjVjHqCEF3FtwAh7VljMpmX5paAGOdpVrq+Rcg5v3JauOFC+IeFQhxbL0BdBhIr3X3p+TMo31pdSZ/UxskTRN39DMYX+mGnOhOU7OX4LVZVitxCj0iQDusp7R1quPWCereLhBIBG0cDjSRf650CKRYWeXZi3WK8AOOGfAPEnMQ==
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 23:35:16 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::c7) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 23:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 23:35:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 16:35:06 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 16:35:05 -0700
Message-ID: <102e70cd-3979-4ea5-8df4-d3b2ea01003b@nvidia.com>
Date: Fri, 14 Jun 2024 16:34:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] selftests/vDSO: fix clang build errors, and
 Makefile cleanup
To: Shuah Khan <shuah@kernel.org>
CC: "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Lutomirski
	<luto@kernel.org>, Mark Brown <broonie@kernel.org>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, Thomas Gleixner
	<tglx@linutronix.de>, Carlos Llamas <cmllamas@google.com>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240614233105.265009-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 34606e1f-3a54-498b-cd28-08dc8ccaa52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnRFL0lCTW4yNVN3R1IrdjVjRk5ZWnNldkR3akkxN1lIQ0paWjJUNVRleEtP?=
 =?utf-8?B?cTRrUThwam5md2xuVlBXdTJnbDY0NDJISXZyR0JjZnk2RjJ6M0J5aElic1Nn?=
 =?utf-8?B?QXQ1WnZaTGJvQlR3V25lTkdaK3JDMjIzbGhZQVJNcGUvNFppR3k4UncyVlJq?=
 =?utf-8?B?WG93YllZTkx3cW1PRjVGSlg4QXRsWDhxUXQ3ekErRnFuZlBFWDl4UVR4NlU3?=
 =?utf-8?B?NXpNOEhDNFJ3SVVLcFRMY3VRa1ZsMUxicjRhZnFucFg2MXJ2NTFLMTRLMUUr?=
 =?utf-8?B?K29RN3luYk8wWEpoVjE2TForUjA4K3ZMRzNzVWk3TkVUN0RjeVZnWEdabFE5?=
 =?utf-8?B?MjJiN2tqUlpVQmpJV2FaRWM1NXRHTDRJWmUwSVRwc0N4RjhVcjFTTG9iZDNp?=
 =?utf-8?B?NnRoS2JjdGJYN3A3MVo2Si9wSkNieEVsRTBWaml0bHJsa2Y2ZkdLVGdsMS9x?=
 =?utf-8?B?akhra1M2eXBkMUpEWWVZeUh3NmJXM0M2M0syNCtJU0cxWVhWMis3RWxmWEZH?=
 =?utf-8?B?UlVnanlsdHdoK0xremFjQUlNbW9YQjFaYjczQ3NEVnBvZy84RFFYQXNFaGdm?=
 =?utf-8?B?Y29BM1IvRUJVY2ludEdyMGhtUExLN1lPTy9FM0RWbXBtWmxYVS9hV2dqc1Zn?=
 =?utf-8?B?aFVDMkUwTmIrK0IzOGxxVGY0TEgvT3BscHBjS2UyS0ZIMDJuK3prUWlpbG9r?=
 =?utf-8?B?ck0wTFF6TUNZQXJFQ0RoLzlRTVhpNU5EdHErMGNSeWZmU1RjZ1FXWm16N05t?=
 =?utf-8?B?WFRYU3Y5dnNNOUlyV3pHMnhrVEdlNTVyVnZiQUxJbUQ2OTZLSGlIMTRDeU5T?=
 =?utf-8?B?SkdQdk42YlZuRFd5enNjbmxmNXVQSVM5NURhYjNiRk1sbURIZmxyMUNRejBw?=
 =?utf-8?B?QWZSRmJMYk0rQ2xLeHQ2QjUzdk1uSEZmMVVUZHRyL3huNVo2U2ZNdkRmWlZK?=
 =?utf-8?B?aFcrVVRXd2MwR0JCeTFKWFlXUENCcGRLRHh5dTQ5MnZUa2x0U1htOVhkSUFz?=
 =?utf-8?B?Nzh5OXM0UWFjY2Nhd2EvVFJLM3AybngzdC85TitmaGxmUFVjRDVibXczRWFj?=
 =?utf-8?B?SFEyUFFhOUJCL0hTYlVZb0I0ZmpJa2xSUHp6NWhMQVREampISzRtdnRxMDJs?=
 =?utf-8?B?ZkZvcnh4cnZ1RHppZ0xjb0tUdzdHeEp5RVVrY2hvRWdOS0NFVURPaE5oOC9v?=
 =?utf-8?B?WmJDWldIU1p6d3c3RndiVGhhL2NYTDJVdVZpWGN0blY1ME0vUUJwSzdmUGRz?=
 =?utf-8?B?Ly95TnVyQk5GU1NiVXcyNk9XZFBJZGk2RXBSa3U3ZDIrK1FOOFpaVkQzT3lk?=
 =?utf-8?B?VjRrRm9TMHd6TlJZK0FQcW9jQ3FBdUVqdVpFYkxqaHFXN0V1eXYzdDd4QUl6?=
 =?utf-8?B?OTRPeHBETzRvb082di9xcTNoTGs5K09taEQycmRUa0FIY29iRnR0YU8xQ1ds?=
 =?utf-8?B?ZUNNc05EK1Y3emRYUFVTZlRWbEdxTjAxR3BxanZ3TnA4STBhanZxQXdaREdj?=
 =?utf-8?B?eWNyUnU2bkxsUlNuYnEzZ3hDOGNuY1BQTGxDcHFWVVhyTmlRTGxFUXIraURs?=
 =?utf-8?B?VVE0ZXZoUi83ODMrRERBVmNKY2hxY29qelEzOVpUN05VSjFxTHRUcDFzSjRC?=
 =?utf-8?B?dUo3MkZNSUFZRVJkM0RtSmhLbTVib2VKRnhFcnlBZTlqREtEVzdQNkN5ZXlD?=
 =?utf-8?B?UjZITHdQQXhjcWl6bGZoR1pWR0UvRndhdUtieGJGdk5QaTNIZVI2alczaHBa?=
 =?utf-8?B?cEViN24wRHdjUHk0KzZUQ3JqbTRlM1BBb2tTU0p5dHkyenpyTEIwZSthQzlr?=
 =?utf-8?B?MXh4b2pMa1NaY1VtL3V3TlFzQzRqM0FMbG1iZEVaV0hhZU1GSTVEMzhVeW5a?=
 =?utf-8?B?N1pVYUZQVmo4ZGd5Y3orK1RlTG5HbUhlaGNzaWNqK3VFbUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 23:35:16.0417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34606e1f-3a54-498b-cd28-08dc8ccaa52d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228

On 6/14/24 4:31 PM, John Hubbard wrote:
> Hi,
> 
> Jason A. Donenfeld, I've added you because I ended up looking through
> your latest "implement getrandom() in vDSO" series [1], which also
> touches this Makefile, so just a heads up about upcoming (minor) merge
> conflicts.

Belatedly adding Carlos Llamas and Thomas Gleixner to Cc.

> 
> Changes since v2:
> 
> 1. Added two patches, both of which apply solely to the Makefile.
> These provide a smaller, cleaner, and more accurate Makefile.
> 
> 2. Added Reviewed-by and Tested-by tags for the original patch, which
> fixes all of the clang errors and warnings for this selftest.
> 
> 3. Removed an obsolete blurb from the commit description of the original
> patch, now that Valentin Obst LLVM build fix has been merged.
> 
> 
> [1] https://lore.kernel.org/20240614190646.2081057-1-Jason@zx2c4.com
> 
> 
> John Hubbard (3):
>    selftests/vDSO: fix clang build errors and warnings
>    selftests/mm: remove partially duplicated "all:" target in Makefile
>    selftests/vDSO: remove duplicate compiler invocations from Makefile
> 
>   tools/testing/selftests/vDSO/Makefile         | 29 ++++++++-----------
>   tools/testing/selftests/vDSO/parse_vdso.c     | 16 ++++++----
>   .../selftests/vDSO/vdso_standalone_test_x86.c | 18 ++++++++++--
>   3 files changed, 39 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 2ccbdf43d5e758f8493a95252073cf9078a5fea5

thanks,
-- 
John Hubbard
NVIDIA


