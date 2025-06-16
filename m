Return-Path: <linux-kselftest+bounces-35090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F4ADB60C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485DB188DF58
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F76283CBD;
	Mon, 16 Jun 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZ3LwvWn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAA1D90DD;
	Mon, 16 Jun 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089740; cv=fail; b=TcQ9txevWwshvH9+/u9L9pU/hNkaickPIqT1xACpPUIFBCZ2zeWXia4xZZLcsOPdNf571nZ29ETngLRkFdfbOv4lrIu/nIjBqT8HJGXa2r+y+eGgpnnVVKLtpahmyuM1Jm4fmY3MnerSwWdBzNWv2eMQ1E51pctY8b8BYtKfSOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089740; c=relaxed/simple;
	bh=MP8fswQiB7UGjX3N/KA87t9cpUbOqtzVy6zjqy3O/xg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=of2drK4zNnqovh/N3+yUtcYj/lDKyZnG+DqCq0qfYPd/g6lrOgp63m1Dosh2U3i+eLe+V1D5frJvjxFVuoAlP0jFqwupg+jVUZmrWKGTu/qkkcgvNOBKaD+H20po8da5nJb/Q6QjEScA2rWn3zsKD52M+5OFS1qHodp3UUFjeoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZ3LwvWn; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6NbHBQGTm8C4Oj0fuZ3CIKjXOtKQt1SuIXExL7e4TS3XQgI2Q+jSgHRYDDTwrrrPUC6XodRuW594WiOsnCaYgflyEVMeoJR0+MtRJYAdngP9oGHJfTxdBOdmNZjsRmEjAfXeO+cile2qVu1St4ncK8PLeUMYvLjOzy7r/etTUA4z86GVWrd3Z7CFozRZ5uiCyp9EPr4N03moAu+JkVUNwqRtHVLH76CixdIjHp7eOcTfW7uGeXnr7+VWJS9q3wNLlnxahFR24MO3cp6ngsgTNXRLSerjjh0rzLRCPETJRVc+f/UzcDWFlmo5slu0jV/jGbuIKCdMbmFI34JL60NEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfapTED6IudVnVbidPVgybqez+AcvIQmMb/IznybgQA=;
 b=fyZerun6Umqkajzilihi6rNEz/+63cShfIbyJOIE9nlubtkOMvfAiFXQkVgOf7WGa1+x2kpQmiwvFD6EDuh8SFau1Mh+lUSQ2MM+uTz8kBtzU4GoGwZqMMRR0Pi+O3zgsHhfDe0sYRlrXzCmkvpjEIU9IqAysiOeH0CU/8d9QeMixRCiZdSu40UvJ9mt6BMOGaKB2OQNx8fKTqrqdcP9RoJlKRnXZ0kioQTWrDB4F/RubFqJok63fawSDgODn7EpsnP/6ZYLet7J7G/mRZXfcyqNJakiCMw+uGt5icevpZkZHBIuZKpmlq4dRYuJ8zTQExBXDoNMvZNBfJJ49oPPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfapTED6IudVnVbidPVgybqez+AcvIQmMb/IznybgQA=;
 b=XZ3LwvWnNdJ3QJOeQu82o2QUPWD9H9dtic+ICOQFWGaYLgxHqtiOjMB3gkRYhTXs840HFYIYCK7SdG9P3TtlNZoEDdtAzF32KAS44lS7JOyZRM+eg60slsuPHGUWAP7ROoGLvjHMgvkHLq579+NdvkLa8akp9L2nCpiDr85RUK/hlqRnNRhpFxC9rYcRlCIAtB0kYJ9E5W4kunhe+XXNv/JOZ/zLXEvai+KA75qbvu242XRCARQSwghILgDLt0t9gdPpjI8Q6cmispdfgBJuU6TAWr8OxN1p8Aha1Gq+OWO3cPTD5MXw0S8FDsG1WyUcP5Hn0W+XmEu9speOKmERUQ==
Received: from CH3P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::9)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 16:02:15 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::f4) by CH3P220CA0020.outlook.office365.com
 (2603:10b6:610:1e8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 16:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 16:02:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 09:01:58 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 09:01:50 -0700
References: <cover.1749757582.git.petrm@nvidia.com>
 <78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
 <20250613095755.54381628@kernel.org>
 <ccaf0784-d7a3-41e2-b3e0-65b9022f15a6@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Matthieu Baerts <matttbe@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Date: Mon, 16 Jun 2025 17:06:00 +0200
In-Reply-To: <ccaf0784-d7a3-41e2-b3e0-65b9022f15a6@kernel.org>
Message-ID: <87wm9bu13q.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f8fcfd-54c3-47d8-28cd-08ddacef2a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zP1vdvCkVeH2Y0mOpGlZaL1z+FoIs8aqqNqWHp/l0ltOXin5QQZEIBHTZC2l?=
 =?us-ascii?Q?4ANUxg5rokKUAdXrGFwJkVQjGADA9arxrI5Df1LvEUAlj7eCmEd09s4f/9Qe?=
 =?us-ascii?Q?MmZ084x2DiU1bUNLlhP+0AbgGjLaY79WDChVc1jwhnzHccmt0XG7uxec3rRw?=
 =?us-ascii?Q?FJ8HiCBfWwXtRQcMKev3S+CIc8sws8frCOkFcUsu4HXBbn2k3ciHhzLc5JpZ?=
 =?us-ascii?Q?kUNPTh96zJyOlK/IlyFRAlxdEev20BVB9psvvq/Mko2fDtCrt1Dn5fo4Ce3T?=
 =?us-ascii?Q?qMwxZl1ykvk4YX19F9m29ZTqwLnjFUkc/NFxdnam9V+buroy4n9f2N4Npchh?=
 =?us-ascii?Q?ZbeH9N7+d19q1wg/VEiaYxYBD2rr7CXQfCAp6Ybok6neNP5hA8+1QU/+WQzz?=
 =?us-ascii?Q?3ZPoL+AVXqJJGPZZWFOR8J1M3MpuS/qgY3SedUwicxa8noJ0n5ZKD0K3Q93d?=
 =?us-ascii?Q?PusBegcgiZ0ao1cYop8OVndNA7dbd2DoLCguc/VXmCL8n1B6XVIFLHVXY8NT?=
 =?us-ascii?Q?ErhkML/YcQvDQPuo96gC5Q5Tsg6HCCEZdsc6v2/nF84WXBJJ/nx8QMClh5Tn?=
 =?us-ascii?Q?QJK31YztkDNyza0ZQ5kTsrbGvDojDz65NG2ofmubNf2s8VXqCewU3E7zssD9?=
 =?us-ascii?Q?d57Pd6ESVMAboShp5babon1zEcjFj9bsxXUozGMRTOdxTW/3Tsi6OJmmxocR?=
 =?us-ascii?Q?ALMaz9ZC2z6jMyj/wm6CdE2uaR4fkdwbIvNT5I/v2wrpHW1HFWobHJjuY+Bs?=
 =?us-ascii?Q?copu89WOawAsGbwQxePfx3TwnsMXRVkCHnGT+nqJPzr61BAXwqzgNTY7lBHg?=
 =?us-ascii?Q?/+EsDHjzRpLP091FdUpLXGI2sNNpj3MAFeHMz8n1Mpv+WA+bfzSVafw+0K/s?=
 =?us-ascii?Q?T0FEWr5nVpISsxIgURm5N7aaXPF1BLjKvPFqLJLYyGmfZGICciAwyS+n2HJr?=
 =?us-ascii?Q?WMkk4IUwzKWS9bNq4aoRkoTVvFEr3ncN7XneWFgIH8sF0PLHYVMuKvbVFQkN?=
 =?us-ascii?Q?U2iuUXf0rp6VOpjNN4D6wXpLmAR1KEyZUX2BSwHCuswIRzTpTK8/ZG64vLR5?=
 =?us-ascii?Q?E7SEZxihvJtorrxIhNwiIf9dqPo1OUcZPoEXNjvr3bHbb91H2srSknmSpH5Y?=
 =?us-ascii?Q?Cfc3qRA66nS+VNVTNeSXeykS5XKQSxtYRwwUiXB8LDtANDBMTu5Q+iMVoVHp?=
 =?us-ascii?Q?0Kv96gGo01hnH6XMYVScvaHMWXok5QPd2fGnm40v8GLk7yWRR3bdLF+DMhA/?=
 =?us-ascii?Q?r8z/CHt7ZxV0drnme/tCH8C6JuPfVJHJ5mOTT9+pajdPcfbj9wHz86cEbyI0?=
 =?us-ascii?Q?GQpTGBangmprHuPHH6GwcJkRsse5K72f3/TJXuksXOeA1NaEFvRiay/V+g4J?=
 =?us-ascii?Q?uCGE2zoCPDNqWbw4MtQBE4XL1WoIdzQlEMHMT3BcvNvQTSliRSgoKXyvgno1?=
 =?us-ascii?Q?eN7gjBSVJvhP635sYOcE+VOrYR5SPbnstmEn67ugbd6TkneH8CbwyYOwKQwW?=
 =?us-ascii?Q?93tCNvFXNFGTSyYfUAfwTLAQrgpwSxpPiMs8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:02:15.7217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f8fcfd-54c3-47d8-28cd-08ddacef2a04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772


Matthieu Baerts <matttbe@kernel.org> writes:

> Hi Jakub, Petr,
>
> On 13/06/2025 18:57, Jakub Kicinski wrote:
>> On Thu, 12 Jun 2025 22:10:48 +0200 Petr Machata wrote:
>>> Add tests for MC-routing underlay VXLAN traffic.
>>>
>>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>>> ---
>>>
>>> Notes:
>>>     v2:
>>>     - Adjust as per shellcheck citations
>> 
>> Noob question - would we also be able to squash the unreachable code
>> warnings if we declared ALL_TESTS as an array instead of a string?
>> IDK if there's any trick we could use to make shellcheck stop
>> complaining. Not blocking the series, obviously.
>> 
>> CC Matthieu, I presume you may have already investigated this :)
>
> Thank you for the Cc. Yes indeed, I already had this case.
>
> I don't think declaring ALL_TESTS as an array would help for this case
> -- even if it looks clearer than a long string -- because I think
> shellcheck will simply check if all the different functions are called
> directly. As mentioned in Shellcheck wiki [1]: "ShellCheck may
> incorrectly believe that code is unreachable if it's invoked by variable
> name or in a trap. In such a case, please Ignore the message".
>
> That what we did with MPTCP, see the top of the mptcp_join.sh file for
> example [2], where we have:
>
>> # ShellCheck incorrectly believes that most of the code here is unreachable
>> # because it's invoked by variable name, see how the "tests" array is used
>> #shellcheck disable=SC2317
>
> If you add this at the top of your new file, followed by an empty line,
> shellcheck will ignore this issue for the whole file.

The ALL_TESTS issue is not the end of it either. We use helpers that
call stuff indirectly all over the place. defer, in_ns... It would make
sense to me to just disable SC2317 in NIPA runs. Or maybe even put it in
net/forwarding/.shellcheckrc. Pretty much all those tests are written in
a style that will hit these issues.

> Note: regarding the other issue you have:
>
>> In vxlan_bridge_1q_mc_ul.sh line 766:
>> setup_wait
>> ^--------^ SC2119 (info): Use setup_wait "$@" if function's $1 should mean script's $1.
>
> I guess you can also ignore it, or use "" as argument. If you ignore it
> -- which looks cleaner -- I think it is always good to add a comment, e.g.
>
>> # shellcheck disable=SC2119  # arguments are optional, not needed here.
>> setup_wait

I'll just pass "$NUM_NETIFS" to get rid of the warning. I really don't
like these shellcheck annotations.

I'll send a patch that changes the calling convention so that SC doesn't
get triggered, because I really don't want every new selftest to have to
deal with this.

