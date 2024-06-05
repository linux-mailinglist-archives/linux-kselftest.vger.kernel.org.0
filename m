Return-Path: <linux-kselftest+bounces-11252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70348FD0DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD691C22C2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162F1B5AA;
	Wed,  5 Jun 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eonu0MHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57810A0D;
	Wed,  5 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597937; cv=fail; b=XEbKr9S2uVUuMzY9MImetZzD7NMsUwqC5/9QN3JH4LPFHUQLd9wYMYxiMPpTFEiDL3+9gHR3/Du/eT19PzIPHCLCFUfCjgTVgwFjpRlTonceEusCGUCM0jgWnyD02Kl7VnUHC2HC4w83Y5kISplMhKh3vvA6YOZ7WAsgHDECsIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597937; c=relaxed/simple;
	bh=d0ozntv+r2YZi1mbYTJFlQ6AJsfkFUGsrAngHbsJzKQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gJTWOgaTF426HaX+cqv1VenvTgiOUqZwxVcUUsLCCzpAmaTZ7H/sKYcWYcKQkEyBc8vc/WItQSPgoR2LXB5Y9316LeIEMfpEWoHTRRceA+WqGLe98JOxOXnrRJNC+XTDEmvkAY777Uajd/VzWxCXEe3EZlcOasqwrVlfHHgs4/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eonu0MHP; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpRY9gpT6V0GxznOs+xbgJkggXhD24otPgQhnsRann4aJbBpBT2PQ4rN2ri6+o2DbLo4C/Am3RNfXIrLykgl+ZSdMlvZGlelC3dLE9UDQWq7NfVMKgA96ugT/MBlFPLxNiMrtzXscAvC+Mo8YUi1KEqHOljMaJWQiMX4NST0LK2k2Cz5/nJtozDNeDJukK6TEjebHtrK1Lk3mWAJb/48faYUJBeGbsoMdn+YXaZp4EEINVB/8yOOW+9fEuDbbUoa3UIcL113ua3QElT45lNPXgXn05c/Z2DAMZS8r5rSqzrzAFrb3JVgHiXHMpZGTWo0FmhTdOWJT6x3X4hYQDJbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqH0MLEUhBx73uYk5Wtv7MGRx8kS7ienRjiKqbd7Z8w=;
 b=QSIJBitrzYahbrSvqsVqgclll4YkR3w9530rgADo25lbowIN/Xdks7HccRpHWCbSxUCAP0hDiOqg/CWqGh3yUByKttTGIOCwa5Biib139OREoKKDNTfiDfMolfYDTMzEI39kpxJ3TlixiTTEFgpAdj/ga0ScW3KYj8X6SGNOM/gYVTwExCrthYBi+j8l0wq2APICAkGNSJzGIiFekoVXchGGg7z7GPk7I6PJueac6mpLH+4k5/8qHuZq+JUoLt+lbUfYv/7buKE2HezRA1QO3catl1nTIAkdWSToSHQQgtPPsqk+5SbURCd2oINYIpHpWT4r3w7hm5n1ykskp+nxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqH0MLEUhBx73uYk5Wtv7MGRx8kS7ienRjiKqbd7Z8w=;
 b=Eonu0MHPLNFzOMDKa/01dbtyHzRgQW8Lb8ZCY8ENszWwCj+LoabnIn4kUUE7vfy5miZeYeujPhO1iba2Ct4QFdrOO1FK4bG7iocGWUTZVyum9L2amwCcC2f+oe+9FJlCmKqC9vVfxOcra06Xo2anWhcGhIYjDUL5R1hRgAIqGXPtyYqdg6SDNncceMQCcVAI+hY7PNBf1/vkCZY3RCxCIpgPGxPTwbis94vvYUuoHwr2GBDgL00qUVQa6Q4+eNKdW28q2VsSdZNuB3yeANuIbr8HhrNC+GXakza6LlXTDYuit6GYoYwNCkgeHcVkGDbGg070+gdtn9PScDRB0ALQ6w==
Received: from DM6PR04CA0012.namprd04.prod.outlook.com (2603:10b6:5:334::17)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 5 Jun
 2024 14:32:11 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::2) by DM6PR04CA0012.outlook.office365.com
 (2603:10b6:5:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 14:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 14:32:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Jun 2024
 07:31:48 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Jun 2024
 07:31:43 -0700
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>
 <877cf38yg5.fsf@nvidia.com>
 <0f85551f-dd67-4d88-abc2-cdf80293a604@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Matthieu Baerts <matttbe@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <mptcp@lists.linux.dev>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Geliang Tang
	<geliang@kernel.org>
Subject: Re: [PATCH net 2/3] selftests: net: lib: avoid error removing empty
 netns name
Date: Wed, 5 Jun 2024 16:30:51 +0200
In-Reply-To: <0f85551f-dd67-4d88-abc2-cdf80293a604@kernel.org>
Message-ID: <87h6e7796c.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 7400e2d1-0fbc-474b-e4d3-08dc856c4952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l5Od9Bqg6QVNiTWhlPZoQiWWpp2RVnbWfGckh0uizk28ATdGX9hpyqh2Fxvb?=
 =?us-ascii?Q?GfkZf8qbmxiWQLo85+THtLCnxs0BYhvPep2Qqj7ae/m5ETSuPmJOmlUmJnYq?=
 =?us-ascii?Q?t5E4VMn9yelMOLJGkKv3hjXMVqFcuHq4n7KKhqvOnq6kGm2HIEoJ0jcUSFac?=
 =?us-ascii?Q?mUCQSv0fSodg/kGo/lPSlNp3dZLYUZRfIH/hY76IwJ4HIKK2505xYShcDx/B?=
 =?us-ascii?Q?mLoNdt+95qrSb/qYnN+1MVyodctxqvDu2MC1e7rRDxMgx2CdkI0mmq6hqryU?=
 =?us-ascii?Q?Wtz5teG4tzRHvDF2JqExY9Op4AlJ0jILf1hJ34ghmEvk6n8Brm4EUIqSY4dh?=
 =?us-ascii?Q?AVF6l5dnBqCxagRplk/O/9qG5pYgdmEAWbBJJhP4V3fySnX0lhRkjZtLUjG6?=
 =?us-ascii?Q?uYlhS5zaEF0Kjui9jmM1LLq4/2HxM60sMNeKOJJyZ51fzqlmKl7y4BRnGHuF?=
 =?us-ascii?Q?oAZj4A1TBMKsPOne6u+vgsq1Qd8Jhmt4FF42fQQqULVP+EPTl5wnPvMOXQIA?=
 =?us-ascii?Q?t9BUAarOWiAUNPMD+gKNQKzfv9LSn/ixUJLzdmiQV4WBNejxahohdRYgherF?=
 =?us-ascii?Q?o0R8VW6aX+9uIFegX7z7YgEV325B7TYG0saamAW72OUyNgn4kElq/V3S9Pxi?=
 =?us-ascii?Q?WHo9TiXjWW1DtOlEm6uHGR42h9kOipFFYVMhuzpcQ6OHL6MCsSxGLGGINDtS?=
 =?us-ascii?Q?xMMj2ynE0G2MwYpHRxfMng1Qia/x175XdbpyUw169bN77n6K7ECNLSj2Zyhy?=
 =?us-ascii?Q?qI9tWPJcyOzUK/cqKloCyI2oONwfKvhmxMMHKrXLHZw/ApX/VeSLvUBKNGBa?=
 =?us-ascii?Q?awCtywuJbiUbZ7y1srSfgkx1Lf1fhhWOjUWNtiX2yi++FZWOuRdwQX9Tut1A?=
 =?us-ascii?Q?tLwmYVpgUzodyBfmKIT7YzGRU8tDltKyhl6UiyYSAqb/1HxMs4B/1Lmw44oR?=
 =?us-ascii?Q?3QiZxL8N4oh2e3LApf4F7Hxg/XDWlxqrEyLLUkyCXAkxSiJJaxX1wwUuiIpl?=
 =?us-ascii?Q?2we4C3hkbylGCl5etGyn+UEww1TjUK5mvebJIDp0FGnw3VNePwQYUe01Qomd?=
 =?us-ascii?Q?gMF4mfv8b0hyAhlGajm33wrIK+aX9n8GbFuXDNDTH2bgBegVU4w4coJByRjr?=
 =?us-ascii?Q?gIArkv9T5O6InO+nA780IkbbtqN6FkZ1+ie2BIwl9k8uUrlbJi07KrXBUeO7?=
 =?us-ascii?Q?gFPNJ0DgvpWIBrUIr026o1UWdGLcqFDVqkRPXDvCYhUX9SLBlFw04GFoYPiB?=
 =?us-ascii?Q?G+1nY9h6bfLhBMFAKZCpjCGvXwTO97IQgPEivN3qvCDRc8hnIJZKIQquRlHp?=
 =?us-ascii?Q?NkyKV5JHfwRLMPF2GhWukAp+lUs2brPm0pixcw5W7fMOQ9MYR3oU6R2QjOZ6?=
 =?us-ascii?Q?zpLRn0ciFpdoEDy8jHsXU7SOl/lz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:32:11.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7400e2d1-0fbc-474b-e4d3-08dc856c4952
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391


Matthieu Baerts <matttbe@kernel.org> writes:

> Hi Petr,
>
> Thank you for the review!
>
> On 05/06/2024 12:38, Petr Machata wrote:
>> 
>> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:
>> 
>>> If there is an error to create the first netns with 'setup_ns()',
>>> 'cleanup_ns()' will be called with an empty string as first parameter.
>>>
>>> The consequences is that 'cleanup_ns()' will try to delete an invalid
>>> netns, and wait 20 seconds if the netns list is empty.
>>>
>>> Instead of just checking if the name is not empty, convert the string
>>> separated by spaces to an array. Manipulating the array is cleaner, and
>>> calling 'cleanup_ns()' with an empty array will be a no-op.
>>>
>>> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
>>> Cc: stable@vger.kernel.org
>>> Acked-by: Geliang Tang <geliang@kernel.org>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>>  tools/testing/selftests/net/lib.sh | 13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
>>> index a422e10d3d3a..e2f51102d7e1 100644
>>> --- a/tools/testing/selftests/net/lib.sh
>>> +++ b/tools/testing/selftests/net/lib.sh
>>> @@ -15,7 +15,7 @@ ksft_xfail=2
>>>  ksft_skip=4
>>>  
>>>  # namespace list created by setup_ns
>>> -NS_LIST=""
>>> +NS_LIST=()
>>>  
>>>  ##############################################################################
>>>  # Helpers
>>> @@ -137,6 +137,7 @@ cleanup_ns()
>>>  	fi
>>>  
>>>  	for ns in "$@"; do
>>> +		[ -z "${ns}" ] && continue
>> 
>> I think this is now irrelevant though? Now cleanup_ns() will be called
>> with no arguments for an empty NS list, so the loop does not even kick in.
>
> If you don't mind, I think it is "safer" to keep it: some selftests are
> using 'cleanup_ns()' directly, not via 'cleanup_all_ns()', e.g.
> netns-name.sh, cmsg-*.sh, fib-*.sh, etc. which can call it with the
> variables not set if 'setup_ns' failed during the init phase.
>
> For the moment, all these selftests are calling 'cleanup_ns()' with
> parameters added without double quotes: so it is fine. Until someone
> changes that to please shellcheck, like we did on our side with MPTCP
> selftests. So this line will be useful soon when we will publish the
> rest of our patches to use 'lib.sh' [1] :)

All right.

Reviewed-by: Petr Machata <petrm@nvidia.com>

