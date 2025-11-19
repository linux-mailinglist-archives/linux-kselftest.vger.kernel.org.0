Return-Path: <linux-kselftest+bounces-46006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6FC70337
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65544F459F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439436923F;
	Wed, 19 Nov 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dt5B0i/l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F2366566;
	Wed, 19 Nov 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569753; cv=fail; b=jA0ZxW1LorcQjAqFhgSTVGxh9CRUgL/X3w7CkmQURdW4vRvD9JywFSJTgihlW9MSW3XbxqbiYTJOKbt8G/uLcDt7oYME3gHDZQDK+Ux481j7vZCWnkdxktUZrsGJOrwrZUDOJQSLWWhWP55FUj9b0LsmG1SLZvIYdla5/ihfAag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569753; c=relaxed/simple;
	bh=c4XkOst5u8djnWgv0wZCH3HLDy24/6XtebgE++5OZLM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UgX5/q6f4Q6bHbZ5xcSfCHWygHDOaZjHljPSyg2f5dFNN/og4QsInQi5CjRqF+ZKAlYjrkUmYaa2SVetvDHCxZCVohoa6efUhu3XvscaLkR+Kqkocxcsf9w2DF+cA0k2TcEh7cSD7OOlG+tUV1PxG3C58GYorVktJNBGYOHw+gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dt5B0i/l; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1OIonc9uYTJXUrHvJxArx1sp6MFOkXQKnlEI1hRN36gCASqxmm9m+KCs9PvpUgaTWp5DLnOsh0riOlYqnlm0JtN8HCG2uKtbp9Y0TE1xJtp9QNj+lRNu35N8L8OqqCFORHMuvgD5+mdo6r6M+4SK6furKVRMrLDBWogFri8s2HwGuD4w2tQlfQ95Dp4e/TKiRWBuC7S7nAfh1TQLCbLwQtZj5vFzjCgUH6o9YG4qTOaoC+i/Zs6sGqC07uCqoc8nLKRAzgZ3XgCL5HCZRIVB3F7q4+DErNMH7jdrIUSHKrD+zx0TK9NCaHaRxXuiScVoUtP0NX0AwrkWidJa1budw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IELE2Nw0W7Kpv7xID9qug/QA+i17s8/Len5qXQI/3ao=;
 b=BY9YEJsDJS7J9FaRgRzbYk7DFiaUmwjcWiBcS13KwlFeI+S4ZoN6tLH2mGBeNQ3OCg2Zv1yEPYhvjcMJtmT8BVS7WjQ7Ab5bKojya3m6Paskat+7swiSc+x3k37TtiDpNA78D5lNkW86mzReRkCS+zqj5zgKStNQLqhMrtvNbueVA7Z6vhbBiu4b0C/P0KI3D6lj2HfG6eYo0PuyVLOdCJeUNzhJKNKsQT06qaMZNOExmjWVVaV2vHocvdllLlZh698GEyPi1HGgm0wSVrc/5x7nJOIh242J9jN8i+IaNM4oBnVFSeVvpoFI5AXrB/m3XzKyzgpPThJuelE64jAAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IELE2Nw0W7Kpv7xID9qug/QA+i17s8/Len5qXQI/3ao=;
 b=dt5B0i/l6ynnqUqr8lLCn4sMaXT3i7zkTsiHF5AwJazvEK6dz/5Ci8lx1Pnts5ztY6jOGLG9fZxgFbltb58CqIFxmoKvpsSi7sqtU8hnVDjkHe+ZHCXdj/omdskKAYqw4spft23N/Mg/2o3iFMHt4YGQuzwG7XwDcOfN+mvRsqdF+XnoJTqgAZFODAYdQIaSzwtnAvIuUZ/zjP6PrssZuhxid9HLvf39fl5qwz0kv8phfXZUZg9Mx+hJ7hAIGAISXLLuc6cL0sOjE7HnDqZmSL7KCQkmocdBFP2hgCwaxdLQwuFjztMtjsHMScNmc3JyN4qiJhvnKwRbV2ddlf5ynQ==
Received: from MW4PR02CA0003.namprd02.prod.outlook.com (2603:10b6:303:16d::30)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 16:29:01 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::52) by MW4PR02CA0003.outlook.office365.com
 (2603:10b6:303:16d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 16:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 16:29:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:28:39 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:28:34 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-2-kuba@kernel.org> <87ms4icely.fsf@nvidia.com>
 <20251119063228.3adfd743@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 01/12] selftests: net: py: coding style
 improvements
Date: Wed, 19 Nov 2025 17:06:28 +0100
In-Reply-To: <20251119063228.3adfd743@kernel.org>
Message-ID: <87o6oyaswg.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 5295226d-038c-4f65-38d5-08de2788bf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dy9VVFBnRlhFVWxVOG9BZmk0dkRKL1docmJmWC9QdlV3MENsb0E3YVM5SFIz?=
 =?utf-8?B?MktyRGtKT0xPNmxXeW51SUExMDlQazFhdmFxU1h5NktVNjhqTjUvMExNK2xm?=
 =?utf-8?B?enp2VjgwODd6T3U1bTdSenFJZmFjSjdmODRPTHJYWno0YkpKcmp3a2ROd3hq?=
 =?utf-8?B?d3cyYXJOSTFpamx0VGRvNm5HOWFMZVZVcVg5Q2FHSzRjUFR2V0FPZDROekp4?=
 =?utf-8?B?ZStJekpIOC94b0duVkNzR1poZlhiYWZQbUpzblF5bkRiWmhjWWVXQkViaDZS?=
 =?utf-8?B?d29nRWc5SUk2NjNOeG1POTBzbkhESkFTcWkzejU0NmRXeUZsVktqdjdpWld5?=
 =?utf-8?B?VkF3Q0JrQngrd0ZteEYxUFpyWWVST25pbU95SlJQRVkwNTM4SGVpVUo0UklL?=
 =?utf-8?B?WHNZR3lBdWtoakdVWE5yOVBZS2pQaTRXVHZFRVRJT3R0VURqSmNzOEk0d3Fr?=
 =?utf-8?B?NnRhUEU5ajQvMHNCSEg2a3I4Q05mN2M5Y1F4YU1KR1UyTWtLcjhMM1h6ZmxO?=
 =?utf-8?B?anJyeWx4d1lFcm12TFo0c3FQS0JzVXc4ZXd1c1dRVStpTzh4bjgvVVNWNmtm?=
 =?utf-8?B?TzFTb3MyZ3hZS3lwVmpDczR3SS95NXl1THBtRDI0YnA4V3lwdEJxWmdhYjhQ?=
 =?utf-8?B?cXZMTzJzRHNkNlNuUzZ4TU1OenJ1bVgxUG1kOGhwZGRHT0gyN0ZLQ2xUS2NG?=
 =?utf-8?B?a1NYSVdWc2ZHWnVoeWpPckRGQUVpME01TzlXa24rV0FWWDg5ZFc1TkxQcUVs?=
 =?utf-8?B?NG1mNXVNdG54SzBJYkk5QnpHLzJGYkQ3NCsranpaVWsxcTJ6MEpjTDVQVDlC?=
 =?utf-8?B?a2lZaE5odEpyekRuUDdrb3dKczRENytWd2w2OHZ4Y2xrTjBPeFZKNGdEelhE?=
 =?utf-8?B?akc4N2JGSFpXWXh4RlR3SDNMRy9tTnJIejlydHNlMEl5WiswUS9XVGc5WllZ?=
 =?utf-8?B?bUEzV0syZTdnM25ITmpBdXdQRWg3L3hoekw2N25XUXExR1FvNzI4RFNSMmMr?=
 =?utf-8?B?Q2xjUDVlQktYVnpaL0lkbW1ORFI4SU9NNWIwNzRCc2cyaTBBMEJaMTVmTXo3?=
 =?utf-8?B?dVZGMkcvMWFaV0oyYldKU0EwUXl3MklqZmFSQ2l3QlVKMHJRRnVDdnZicVpK?=
 =?utf-8?B?ZnJLYWM4bWxqcjZBbk05bDlzbEczaVNGR2FBTyt5V3ZSdzFwNjVUODlKTjBU?=
 =?utf-8?B?R1dBYkpHRXFHaEtwTFZVVGhIaHJENzJjREZ4L3pqeUlVa2tKRW5GNkRpTSsw?=
 =?utf-8?B?S28wcTBpRStJWFZQK0QzSkhQTTdkc3dvLzd6bGZ4dnNkMzI2Qnp6SCtlR0w1?=
 =?utf-8?B?aEFSVXhiMEhFcDJqbWpFYXduRldmdHBZeExBNkxkamFmYmI5V1hOY3ZzQnB4?=
 =?utf-8?B?Mm9tZEdtVzFnN3NUaDJUOGVGRWJNQVlIWnFXdmV1YmtHdy8wdUp4T3RNTkhk?=
 =?utf-8?B?OHA0TysrZWFSaTQxQjBGQkx3V3pqVElrWHR3dW9IejlNYWg5ODh1d1hYVmhq?=
 =?utf-8?B?Y2pBMzIyb01SSVVSRnM5UWdidUJITzVFV0pkc3ltODk2SnE4dUhUMUZqTHNE?=
 =?utf-8?B?RjBIMWRyRXUyUlFHT2xVRkZkc0lpODBvcVRWMDh1djVuZ1hNcWFrcis4OG1V?=
 =?utf-8?B?ZUpZbFIzcENCa2Q3UXh3M3o3UWdoZlYyRjJ5Y1hiYlREZE9rSVN1ejkwVGRP?=
 =?utf-8?B?S0lsZzE3bm5vQlJ5MXNaMXhPb2NCZC9YSHJXTXhkOFBFUStGUFJTcUMwbmQ0?=
 =?utf-8?B?ZFNTV1JGZFM1eEw5V2JRalY5c0ZWUE9jTHRzOE9OaDl4ZUkwOTJtZEJKYXJj?=
 =?utf-8?B?aUdnNXVGaXNHUXgyYUYxMm84U2VsZGxpbVNSQnlpN284N3FON0NoMFNnMGxD?=
 =?utf-8?B?alNhYldlNDIrRWkxSEFaQ28zQ0d2bDBPWkJGWDF6TnN5QWg5YnYvcE5RTGxa?=
 =?utf-8?B?MWorVjl5RllyeUhrWS9lYi8rL0lrajBZaGtsejd3STZNK0I0Nlg5TjNuam4r?=
 =?utf-8?B?cEhSa3ZyUnJjZitZQ2NCY2duRDlzdkVPT3ZtUG1mM3VBVEozaHNRUUtCVUJI?=
 =?utf-8?B?ZU5GZFNSWlc4eW1YTm02R2ZEalZuVWU5d041V3hFbUFOZ3ZnSXpUQ0ZXRzZv?=
 =?utf-8?Q?tlcM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:29:00.8769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5295226d-038c-4f65-38d5-08de2788bf2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 19 Nov 2025 14:40:41 +0100 Petr Machata wrote:
>> > @@ -163,7 +162,7 @@ KSFT_DISRUPTIVE =3D True
>> >          entry =3D global_defer_queue.pop()
>> >          try:
>> >              entry.exec_only()
>> > -        except:
>> > +        except Exception:=20=20
>>=20
>> This used to catch KsftTerminate, which we use for SIGTERM handling, now
>> it doesn't anymore. I think it could legitimately appear in that context
>> if SIGTERM si delivered while exec_only() is running.
>>=20
>> IMHO it should catch BaseException, like ksft_run() already does.
>
> TBH I haven't thought of this. Are you thinking that we shouldn't
> interrupt the execution of deferred cleanups when SIGTERM arrives?
> Fair point, but I think we'd need more code to handle that properly =F0=
=9F=A4=94=EF=B8=8F
> Right now we ignore SIGTERM which isn't great. After this patch we'll
> no longer ignore it and have the whole test exit. Neither actually
> catches the exception and sets stop=3DTrue in ksft_run()..

Well, previously at least the rest of the defer queue would be run, now
it's skipped. Which -- OK, likely if you SIGTERM in the middle of a
cleanup, chances are the cleanup is stuck and the sigterm then skips it,
which is what you want.

It's a pick your poison. Ignore C-c or ignore deferred cleanups :)

Given this is supposed to be a cleanup patch, it would make sense to
just s/bare except/except BaseException/ and leave the behavior broken.
The commit message indicates it's a NOP make-linter-happy patch, but
then it's not really.

> WDYT about leaving this patch as is and doing this on top:

It's a good stop-gap.

> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/s=
elftests/net/lib/py/ksft.py
> index 83b1574f7719..5a667ad22ef4 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -268,7 +268,12 @@ KSFT_DISRUPTIVE =3D True
>              KSFT_RESULT =3D False
>              cnt_key =3D 'fail'
>=20=20
> -        ksft_flush_defer()
> +        try:
> +            ksft_flush_defer()
> +        except BaseException as e:
> +            stop |=3D isinstance(e, KeyboardInterrupt)
> +            # Flush was interrupted, try to finish the job best we can
> +            ksft_flush_defer()
>=20=20
>          if not cnt_key:
>              cnt_key =3D 'pass' if KSFT_RESULT else 'fail'


