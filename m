Return-Path: <linux-kselftest+bounces-10799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1828D2693
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B7A1C25675
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D6179202;
	Tue, 28 May 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQ23/CvG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CF6A33F;
	Tue, 28 May 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929791; cv=fail; b=VHhlqP/JJgZKuK0daoH8SkDmx3fVH3P3hYFnnSvHVPsl51bydT5n/TsMraHIbCsC3uDpdO45Jb2+/bttLfgEo9RjgABa5dPceLTAdXqz2/6tO5jgf76lwCDLoJHOTQdk9Raypdsrm1TIcd2X2eboRSTBvlkoKzQ/QluhlKnrbRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929791; c=relaxed/simple;
	bh=Z5T31C1QoIY2lTqY2oo0uW6zKqtWTZE28NC4E0xgrpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QgA8+INuVdanMyteNKB/FV3Y2uKKDKdqQ7P/0d4bDPxvZ7SqfVbn/QCkFWL4Z9R0nMYuMqEJZ4/k6OhUI+SBpXD34LYoliyJC4+f/zlphcJFanE8xxJAINeS19MsWzBroUbM+6ngPjULuukJdEZ/LQMZLnqwlLexwxV6ExQfsvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQ23/CvG; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYe35ce8ZKH7eE+vFq3/bKANAxkivQbq6p8C/bzE3zQ2ni+fxq+WUC8Ih347My5C0qv/6LMgyGPbPdIZUK+vufJqgC2BJ/GYSXnwsk+e320E5AbUTmUpRwOfyb2dkMkdTnqSwXcSc1Sku6WNEUTpUnbZ+ut3pDmEYALsuMM0XCVqv83Xf7zaJhNsQneISWFm8A/568R5m7h6o7tQG+9IBCbALDOWmhsU2F5rqQdq8sFi8lyhCcfN7ueJ+OPwdVwk3TTrBzjH74h97rfJOTT8tf8xx9Y5posKJqWBEqqV3Xcl+AHwSDHHSSQXQsWFyqH7zKb31lEathVBR/ozpyQvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bozz+akYes5gGGflBokc31nCq5Z7ypuUTWmTbEJ1uY=;
 b=hGIsdO4f6HKV36U2wmH7oAJYL+FXlTE30x5FZ8fjaK9Hh3WMH02yOl9nxDHXlq22dxwUGuywzwhwZNAuSGkfwj7944D+L74cEwXPNrNy6nmpODmMQRHQvOy3ErwkFG8cH7gC/1vyLPRYp1/tC+ILFsY7TCTBeZO4k5Jpgs288OUupaq5MlprznIhZAJkMj0htnfxa6eXIHlNR6js6DxyuvhslxXbcFw13KP8ccm5eA3QrPfStIupo2lSVGztKbIJjMgoJdKzh5Ee48Y3NI9gj+xDBKwiNdXcXVZSQnh8cgd4YliJSy/nkdQdTQeBoGeVUL5XBhMfCYqmYRX7DaC+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bozz+akYes5gGGflBokc31nCq5Z7ypuUTWmTbEJ1uY=;
 b=FQ23/CvGb5SQL/jrfd3AzQVH4SWKQC5TmCPHBVbTy+mDIFz9vCITbx3HmjhSZVgoG7kpXpdwy3wDAaGkf08YEIOCp6GVn+omxxsbLf+NfCo3QGDFNtAinIs53JANy0lwoSuI6Ww9VpdyJduRHbsEamy4PB2XayXeKjxTJ5FeCOK1huR2nhPe1s3xjsba2+zAeE9sWp0p7vpP4l0aRKekAJRVQmM4AFtYe0ObkqaeqwwVVzjK+ilVKidT1khvzmw4lRp+8nXQngzqMeutGdrT8iDv+yypIF3+D2RxtW7ubcpUPtQrZh3upheCSWsSYW13iQ+zeGmdqNhv4Nuc4N3yXA==
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 28 May
 2024 20:56:26 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::4c) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 20:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 20:56:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:56:11 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:56:10 -0700
Message-ID: <612a0c4f-dd79-400f-aa3b-a4f8bf7dba0c@nvidia.com>
Date: Tue, 28 May 2024 13:56:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/net: suppress clang's "variable-sized type
 not at the end" warning
To: Nathan Chancellor <nathan@kernel.org>
CC: Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
	<afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Pravin B Shelar <pshelar@ovn.org>, "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, zhujun2 <zhujun2@cmss.chinamobile.com>, "Petr
 Machata" <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Benjamin
 Poirier" <bpoirier@nvidia.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-actions@lists.infradead.org>, <mptcp@lists.linux.dev>,
	<dev@openvswitch.org>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240527213641.299458-1-jhubbard@nvidia.com>
 <20240528203941.GD2680415@thelio-3990X>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240528203941.GD2680415@thelio-3990X>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 1427a889-8ae1-40fe-bbd5-08dc7f58a40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1R4MzNaeUxyU3pXY29MeVYxUldINTBOeHBLWTVTbHhVR3RTb3VWZ2Y0M2Nr?=
 =?utf-8?B?N0RqbjhONjk4WE5ITk5YRWNGeEo0NnlFQ0RSOFhyTUZFZENzZllNUjVKWmVk?=
 =?utf-8?B?K3FvL2JHdGpIOWxJTXBncVpBU0ZiU0Q2MlAwRElRV3U1bHVsbVk4UGhqR21M?=
 =?utf-8?B?Z2FkUEZvNFVaR1Q2VzU2N3p5OUZvV21zbjNNdmhjemZVTWJVQS92NENXa3Jh?=
 =?utf-8?B?bFR3THdKeGx2bDBlY0I0elhtWjdSWEI2SFRHUW5SNUxyeHViRWhuSDgwOFhP?=
 =?utf-8?B?cHJxN0Z2MTU3VDhKMERqc1FpTHRGdXprVldzNWpaYlhHSlhkdFRGYWtRTFpB?=
 =?utf-8?B?TUtpekNqcVJmSUs2czI0czR5VXE0N2dlVzEyR3c0QzlVNDZOZi8rZFo0VlZV?=
 =?utf-8?B?eHBxdUVKa1VwZXV0MEc3RnZCT2hhdmFZbmhMN01qR0JCa1gvdlQ5OUg0azlh?=
 =?utf-8?B?Ny9iSkVpQVZvZXcvRzNLSTYvRTM4QzdSekdXQjZtMHlvaFBuYy93cHRYdzA5?=
 =?utf-8?B?S1RaSmdDVDl0SHRsQmU4YmkrY21hT08wMk00SzZ5SklDWHNvT3Foa1hIdVZx?=
 =?utf-8?B?dkhvalNoNkV6aXJiRFAzalI0Q0tUM1Q5MGhXaU02d0RPdldlcE5pV1hpak5E?=
 =?utf-8?B?SGZiWCtidGJJZFlLcGtQWTUwRDlUZm8xaXU0SUtCK1owSGs1WEIxV0pNY1lO?=
 =?utf-8?B?N01Kc2ZlUVFIbEtBSWd6SzhTTGZXdWNyV21NcklqaHFaWUVrN0FBSkxsY2Ja?=
 =?utf-8?B?OExBamdoVDJmSkRLZ0QzUUhEN0gzVDNPRlBON20rUUhQbVRPZW4xRURsd0Jw?=
 =?utf-8?B?T2ZyL0k4Z0c0QXk0dFo1cS9QTzVDRUdIeHpNSEk0QnFWbjAxRzJSY1NES1dB?=
 =?utf-8?B?KzlmMXYvWXRwNnUxT3JJRDRPUTVkaXprUDV2MzNVR1FDQ2V6Wlh3cEYwNDg0?=
 =?utf-8?B?YmJkNERZcWFBcm5neGZaUjZMZXpscDJtK1E5cHZPenEvRDhEWnV0Y1p4Rjc3?=
 =?utf-8?B?VGVIRE1JdTZmSFlXZEtEMkh3cktHdzRCRW5RTXRVbWtxRmhvVkFlb1pnYXVU?=
 =?utf-8?B?dDVyMW9xd0gza21GdzRxMUVCQ2ZxbDRaRk9iWUJYblpzMXc1SExhV3R3ZXVN?=
 =?utf-8?B?NGJ0R1ZTQmFJZG80KzNuaXBYMWNSbDY4aEIvQ1hvbWVJNHphYWF2WExia1or?=
 =?utf-8?B?UFNGWjZpYmZLbFVGNEx4U1RCeXdNeUp1bERweEd4WHhzbkVoWHk5dkwwQ3Ni?=
 =?utf-8?B?cWJzYmV1Z3VwcjlHeTc4WWRIbjc2NjhWNkdPdmhscDlDSTNnUTlUK0g2akZt?=
 =?utf-8?B?OHpCS3pvK3Y1d21tZGkrdWlsdzlXajBQQlVtclRIRzE2Uk5SOTIvaG1ScWE1?=
 =?utf-8?B?VmJidmJ3bm9iaFhsR294Zjd0d3RoOHV2aVBZQkxmWTgzcUZmTDQ5S0lWN3JD?=
 =?utf-8?B?bEhGVCtnY1dTOWZjWE4wQ1ZqbWVWc0JZUEZKWXZYd2hVVC9UTllPdVpVRktQ?=
 =?utf-8?B?bVBZVkpYVDZIZlptbmFWKzFxNVREL0sxUGRUajlibUp6cWlta3lzb1Q2SE1O?=
 =?utf-8?B?Wk14UTF6SG9JWTQxbEtLVDZJY3l3NnZjcXFXanNKUXErVDZiOEMrWjBwSFJC?=
 =?utf-8?B?VXNFRjV5TGJOU0dzd2lTSnJOYnF6dHNCNnZTV0R3WlRRZ2xzdmRPeFIzRGk2?=
 =?utf-8?B?M204Y0V6djN2Ym9heDFwYklqb09DVzJnYkdJYnRJdnNKZW1DNGNpUTFQTmxs?=
 =?utf-8?B?WlkxYU5BR1ZEcnVjR1luelhmRDRkamZqTlJKWkdNVXNkODV6amlVS0UzZm1N?=
 =?utf-8?Q?7r35cM84uf0Dwf3MR2llVPJJvPSsRcj4YIwR0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:56:26.4509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1427a889-8ae1-40fe-bbd5-08dc7f58a40c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

On 5/28/24 1:39 PM, Nathan Chancellor wrote:
> On Mon, May 27, 2024 at 02:36:41PM -0700, John Hubbard wrote:
...
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index bd01e4a0be2c..9a3b766c8781 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -6,6 +6,10 @@ CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
>>   # Additional include paths needed by kselftest.h
>>   CFLAGS += -I../
>>   
>> +ifneq ($(LLVM),)
>> +    CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
> 
> For what it's worth, the main kernel has -Wno-gnu because there is
> little point in warning about the use of GNU extensions when building
> with '-std=gnu...'. It may be worth doing this anywhere that uses a GNU
> standard in the selftests but I guess it depends on how noisy things
> are.

I think there might be one or two other cases like this that I haven't
gotten around to, so yes you are right, this probably should be moved
into lib.mk instead.

I'll do that in a v3.

> 
>> +endif
>> +
>>   TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
>>   	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
>>   TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh
>>
>> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
>> -- 
>> 2.45.1
>>
>>

thanks,
-- 
John Hubbard
NVIDIA


