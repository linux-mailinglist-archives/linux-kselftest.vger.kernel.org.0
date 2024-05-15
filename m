Return-Path: <linux-kselftest+bounces-10248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A538C63D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAD3285413
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47A57C9A;
	Wed, 15 May 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CCrRCzp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2B5BAF0;
	Wed, 15 May 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765826; cv=fail; b=SoW1OEoRd+vIRtCcJnUS8ZKdT2veoO6xDTcHmHlRgBunKfGN+G5ZtvoenAouYbPzdJEyn86+mRr824hD9kgnugwnU8KtE87Ndu/2uBhJENLT5w4Se+aNCk0u4RV7SmylxNB6xpGGJ2RZ+LevzyfXf8GqaZWmLoj3yDJVE5ly8iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765826; c=relaxed/simple;
	bh=NIMhgKE910cmVmaoxuOtrnwRMcxGnt1f6bc9o265fdk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=T5Dy2RvT3iyolQNM7Y1QhICBVti12yvDOXyIdaWwNVnDanChf5vJGhIrnU4S+Eyc4b8+kMLvOMmKs6mr1xK0MZ0BopOJECB4hhA1GOR1ldTKFdpGolLHI9boRpQnVS/dk0x2C0xEn1pxL3s6NizFRe3UdCPsvfYvf2wQHjB8NI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CCrRCzp5; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An9qO/F1TU7Rt4JLDQhyLKoa0OPRYQs1B+1+EKczAoKBqxCBZzgrZE9ihrTLqh0WSrlKQ6umC6rvl5yyM2kqlt+EsOJFkloXYnbxf9jlnVOZpKNs6piLSZJkEBExDQ37ZVFpSJ2ohoqeWb4k+3QeCBKkI/d75eEA2DSS4zPS58AD86Pe23NQk0fPlYlW2useYJy+mcEgAUO449zZhJMA44LRJXs6JCi4qRZnMfYKMB1+swNLhjWFkvAGKoelvhtqc5V3QHPYBoD/93udnF0eVsktzbdU3uEh0QgG9NeAp8kuDidHe7KgTxCBxiIucVms8fLLUJp0nn26vEWnkItFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeVmD/ysNeCWIFcZRDGstsaR+yu0PB1p99d2i23mw3w=;
 b=oYHVYo8S3DwMaTz6RrBDlQxZ9Y51Ff5yiWhNppxKj803Y8yk5Ke6t5ZbEfBquRNSLjE3YyrGbmdWNVHCk7bOpW7xhynNDt74ndDJ+2fX7kSRyZMedluVasQBRFq8TxhaamEor2zms0v9ODMlnhBrKgP6vUq6FAEefYrDFkHSibgAWVI1Rz3F4P35Bmfer7je/kdVe/fo696liCf4pyfLvKJWJhLRqeAWzFRhYrwISKydDulj0gH1uqz3PXPj/6lsCLocRXVYjc6T0BGuGbNXfW/LdOnFk3yffOyXPmKFWHOynPVGCmsV/xXodFHBkii8/Ao2u5DKvtv0+B+jRxoExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeVmD/ysNeCWIFcZRDGstsaR+yu0PB1p99d2i23mw3w=;
 b=CCrRCzp5FEKl3Dj27cQPQGOWteAFqpFObFFA8SUjgy4EoEtWezgABrneihrPmCrEBi3WRv3Qxb0W8RqAHdAcTUpchTDYhKP7lZYi+GpG45jV1hNlep2wHd6HTOaVYLtNIppPcuXv1dBFRbEu3gmLGZFDT1CMrQAiJyO8AcVpwrFKPKDwg58QmH9uzKtXsSBR7DM8Y+SXyoZDWCmox3v9PxSbBo6FO2H+i/KOLWhMJBm7Pn95kE3sKqH7KOoGMTOeqOlwJUTEzJqEU9892O2Z1o7nFTTugNleHuxZe9yA26ZqPGJo4TTaK0vJzt9b9N7xIRjIt5XLne+56GgazsRSCw==
Received: from DM5PR08CA0056.namprd08.prod.outlook.com (2603:10b6:4:60::45) by
 CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.27; Wed, 15 May 2024 09:37:03 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::3f) by DM5PR08CA0056.outlook.office365.com
 (2603:10b6:4:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Wed, 15 May 2024 09:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 09:37:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 02:36:49 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 02:36:45 -0700
References: <20240509235553.5740-1-kuba@kernel.org>
 <875xvhu97r.fsf@nvidia.com> <20240514174321.376039a5@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<vladimir.oltean@nxp.com>, <shuah@kernel.org>, <liuhangbin@gmail.com>,
	<bpoirier@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate
 the expected failures
Date: Wed, 15 May 2024 11:02:28 +0200
In-Reply-To: <20240514174321.376039a5@kernel.org>
Message-ID: <87y18bju1n.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f65612-522d-4001-959b-08dc74c293c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3uONqEyn+LW3EawJisj2g3kfll8BYzhpTtjj7+SKvhAS+hskHjpyLBr5neJ9?=
 =?us-ascii?Q?RcLh7V5MXz+7b09aedsX5gHZPuJP56Pwb41bE6oRAyEOJ778fShmnu413giE?=
 =?us-ascii?Q?vPX+JyNj2uEXI+zUY6vGWXWHWXQJ1c/rJR6zi1RMEDQ3Q6GGPAkwoelTbJFD?=
 =?us-ascii?Q?kJSOq/LR/T6HCUNa3qo2OzT8kF6KsjQPYqyRMSgK13mF7ETs4448gTTZICGB?=
 =?us-ascii?Q?YMql0zo4xlXQF4yvzkdxsUYIu5sTpWpO26ka/Ow7cW/b1LExUb/Wg4RmLU3s?=
 =?us-ascii?Q?o7NVt/zRnFYCoOQ3el65aNrSK0EsPWyT4mDqRsVlrjot4MOBN/4eCESfWd6z?=
 =?us-ascii?Q?fGA4zVQN4yJhY810zUa7aeQZs786j+FQseBDYZe3mOlY5qeFVJ+YORtPKOQ0?=
 =?us-ascii?Q?hHMHtfSkhww0C59ABxqP7b1r421v/krxPMu6zwczg6TKwdQZa/oxiudMRicq?=
 =?us-ascii?Q?bI7sTWqQ7cBqvIRMMPN7Cru7T3WyF2NlbNKme+iqfkfXT8CXyy2GA1g+JCys?=
 =?us-ascii?Q?hbTKL4zhlX6mOqfnUjEg+nOPwGxX0CedvFrVUwgCH4VAU/LHxdles5JI3UBX?=
 =?us-ascii?Q?ksudosV5OYFemMjGrDZbN2wD3il5XKYm0EYwaWrZ53XEkurDyreOGnH1WyYy?=
 =?us-ascii?Q?j3Pnuc7hY4vk5cJC344NEAaKlMzdL/3rx+ZNaIkYL3MeRg5UlRIpps4BY/26?=
 =?us-ascii?Q?4EGFsD0yILSpFh0od7WqguHgi3NfA4d6wqln5EZCJZSoAtJoEbZqpRIHd8vo?=
 =?us-ascii?Q?hfqQsUMHAeuL+fHYZHTEN7DzPaTPDYlq/vX0bCw/MqKosAoRlOSq8aXOoixA?=
 =?us-ascii?Q?xq14WpfY97OXF7miiTH3BUKoE5iYAhv1E77nptn2XLW196vsLy5FskT6PK9G?=
 =?us-ascii?Q?D0lVS4h+y253iWvYZGNYSRj6bF/2q/6cUXw7G5OYm1m7XNUqO9nBrsewt7Lm?=
 =?us-ascii?Q?TxD5s1Dy10rXgb5rn8UkhsXorjWHItgxLp19So23J4yVHEQj4n7SQ4r3f7zN?=
 =?us-ascii?Q?MyEW37rGTvl/3NT3GKBppIyUmaNhpFGZboXPaLa+OIZPkwnfKDmVpvyy68/2?=
 =?us-ascii?Q?tB0WaYxjyGbm+RJXLosAz158c+nVuJ9EX6vO71njyev21uA3AjSHE7UJMiZ4?=
 =?us-ascii?Q?DiSDOGSK0LGFHLbGIY2OmJieCEw00rAaG5JwhOXBwSOg3m2xv1mbhKqwHpIL?=
 =?us-ascii?Q?jKZEgC3CNpTrO3oS9om2OOEG2nNq+kpusZBs5bSzgOWi8DEZjPek/k5OZkvH?=
 =?us-ascii?Q?tlMQ55M2YEa+RRYh3gruMNoxEHdYIF/s/QfK4ctr+doKttSEW2WkII4VYi3N?=
 =?us-ascii?Q?MlmyTf7SIT/V/ZKV46D14YpYjX1+9MXkjK+7UBYeW7fPz7gu+TYZH6j8DpEW?=
 =?us-ascii?Q?qTqbg/MieHLZr1tKUyRBbJwcTLHz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 09:37:02.9554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f65612-522d-4001-959b-08dc74c293c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 13 May 2024 15:25:38 +0200 Petr Machata wrote:
>> For veth specifically there is xfail_on_veth:
>> 
>> xfail_on_veth $rcv_if_name \
>> 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
>> 		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
>> 		  false
>> 
>> Which is IMHO clearer than passing an extra boolean.
>
> The extra boolean is because we want to only fail particular subcases.
> I think that's legit. If the other cases regress we want to know.
> Otherwise running the test on SW bridge is only useful for catching
> crashes (so less useful).

Likewise you only annotate with xfail_on_* the testcases that you want
to xfail. The FAIL_TO_XFAIL ought to only be set for that one subcase
and then revert to its former value. (That's the intention anyway.)

> So we probably need to reset FAIL_TO_XFAIL in this case.
> Any preference on how to go about that? I'm tempted to:
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh
> b/tools/testing/selftests/net/forwarding/lib.sh index
> 112c85c35092..79aa3c8bc288 100644 ---
> a/tools/testing/selftests/net/forwarding/lib.sh +++
> b/tools/testing/selftests/net/forwarding/lib.sh @@ -473,6 +473,13 @@
> ret_set_ksft_status() # Whether FAILs should be interpreted as XFAILs.
> Internal. FAIL_TO_XFAIL=
>  
> +# Clear internal failure tracking for the next test case
> +begin_test()
> +{
> +    RET=0
> +    FAIL_TO_XFAIL=
> +}
> +
>  check_err()
>  {
>  	local err=$1
> diff --git
> a/tools/testing/selftests/net/forwarding/local_termination.sh
> b/tools/testing/selftests/net/forwarding/local_termination.sh index
> 65694cdf2dbb..0781ceba1348 100755 ---
> a/tools/testing/selftests/net/forwarding/local_termination.sh +++
> b/tools/testing/selftests/net/forwarding/local_termination.sh @@ -76,7
> +76,7 @@ check_rcv() local xfail_sw=$5 
>  	[ $should_receive = true ] && should_fail=0 || should_fail=1
> -	RET=0
> +	begin_test
>  
>  	tcpdump_show $if_name | grep -q "$pattern"
>  
>
>> Not sure what to do about the bridge bit though. In principle the
>> various xfail_on_'s can be chained, so e.g. this should work:
>> 
>> xfail_on_bridge $rcv_if_name \
>> xfail_on_veth $rcv_if_name \
>> 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
>> 		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
>> 		  false
>> 
>> I find this preferable to adding these ad-hoc tweaks to each test
>> individually. Maybe it would make sense to have:
>> 
>> xfail_on_kind $rcv_if_name veth bridge \
>> 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
>> 		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
>> 		  false
>> 
>> And then either replace the existing xfail_on_veth's (there are just a
>> handful) or convert xfail_on_veth to a wrapper around xfail_on_kind.
>
> I think the bridge thing we can workaround by just checking
> if ${NETIFS[p1]} is veth, rather than $rcv_if_name.
> Since the two behave the same.

I don't follow. The test has two legs, one creates a VRF and attaches
p2, the other creates a bridge and attaches p2. Whether p1 and p2 are
veth or HW seems orthogonal to whether $rcv_if_name is a bridge or a
veth.

