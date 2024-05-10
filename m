Return-Path: <linux-kselftest+bounces-10019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B766B8C27E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432F81F21455
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162F1708B1;
	Fri, 10 May 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UiMLt0Pj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE712D219;
	Fri, 10 May 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355305; cv=fail; b=rv129kKXHJYWVA8SNUtbpqf1zlhMZ0DlW0QL0uDmZQxLU+lAMomZiv3cjelwNNQgsOqrP4KPR6RA+R0/u4qNLy3FgzPURddKE1BVbIaf0gII3sLvYXHhWOJXxRRrGfJE422SCIH7nmG/wIHkvmkH7Z5/wxq7ceIxlrIylf+gPac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355305; c=relaxed/simple;
	bh=vRyahkAsAok4LuIn0hLG2YuJxfTbO3jMxF+jtuF+Uts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aydnM46mfELPRDXzoqjAG8TOabiO2aakefFKnRVrZRYTGDv4G0epGE2cm21mXAh8h/ygUpkq3kuWdgztjUYTK+o/9TkcwjAAczDr5mL6YOCwJiua3/xTBN4KFcPXnXa2KTQqumCIXZfYdR6pe3lqokI5RvKduTu4fwu22D1pyfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UiMLt0Pj; arc=fail smtp.client-ip=40.107.8.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9EDhKVSz4TCr4MqPHntnkWztYT9YCdDR/pcspbltdAxeYZuwwLjVdEyLbynzW4/eTU4VFD/FrO2IaMoTbRwdN0GFZe2mExomaifNREHfQ2o4PjmCHbGE9HlD92PyoPC+0QG1k/Um12mwGE2iooa8m7SdjNYs4xxEvv29v4qNSGKB+IVkMzdySFmMAgD8TR3ax451AOPvTqVbAwompWDgWQb/WET7GhFNCt0Ci37TIhH2W2Xl/yj0YYdua8N+saWH36njn44HkpNx2sqkI9GJuAtEdEtsKea8NYms0iT48f0m1uD84bMlzXDYdYxZTK9RIZRU3GmaK4DkE+Fn6/L4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJa4vB4k5wE8b3Ylvvj5aKF1ETNyd++VUuCFvkBPLAo=;
 b=dYMOpkJEWP1S6Yi1eJzXA45NTAcnFaCiQNy00wBOE9leDWtVYCAenelukUixXFwPFBFJyIPUClQJx9tgf8jkWKax5FqX7sbXeUupOEpiQ/EAoZFTjn59Ax3FGTS5I4M8lm54a1jswxRSLRGvfzzN4ppxXZRD0+LoQ9dj/4Ajl6rGIoxvk1yoljdxRD1oWaeaoXDcxmzUlyysSqVZyE7EUYzQNn0ygyn0AvumoCsrgr/rRFwKEz+gOcAnhNMamZ2jC76vu46JHiVviSPuYObJsQ8pz1GNK2e0D/YUeb/cg/sZt83c1Kh7rxSuNhFNr7VJHtDjUKR5B7DT84ncLZR5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJa4vB4k5wE8b3Ylvvj5aKF1ETNyd++VUuCFvkBPLAo=;
 b=UiMLt0PjphjiGjwbE8hLM6Uq24e6/jDtCTrTbC4l2eHjqlTte1Ota3ETI0NWj0VAJbN8eQ6TIUGGWSpwwrBeVmJAEXiAVDnN72szTvs5ap4MZiGfR4XiKYE+e8zv0iqnqizdWSSINWsg6Pl/3tcPBxUUT82hFfLYD1+RpU8WiHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19)
 by AM0PR04MB6769.eurprd04.prod.outlook.com (2603:10a6:208:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 15:35:00 +0000
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::2bba:eb35:9ac6:9884]) by DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::2bba:eb35:9ac6:9884%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 15:35:00 +0000
Date: Fri, 10 May 2024 18:34:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-kselftest@vger.kernel.org,
	Joachim Wiberg <troglobit@gmail.com>
Subject: Re: [PATCH net-next] selftests: net: use upstream mtools
Message-ID: <20240510153457.wtaycdzg3iwbcq7a@skbuf>
References: <20240510112856.1262901-1-vladimir.oltean@nxp.com>
 <20240510072424.7c05850b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510072424.7c05850b@kernel.org>
X-ClientProxiedBy: VI1PR0902CA0029.eurprd09.prod.outlook.com
 (2603:10a6:802:1::18) To DBAPR04MB7368.eurprd04.prod.outlook.com
 (2603:10a6:10:1ad::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7368:EE_|AM0PR04MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6e9378-a857-43d1-86a1-08dc7106c10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aCSSKZ5mUmxFik/Rxz5KxSFfJfDGBKqwXwR2K2H+D6uN6BblR7XX4FEbjohb?=
 =?us-ascii?Q?oS6Gsp74xu8hVhI0xrh9/pQNDBu4O0XbifWSxiNWCiYaJH9+kF/69uMzlYY1?=
 =?us-ascii?Q?RVpx/UIrAM8Zfqks7+IiCOIXpG6KTX8Y88KYqM0IphF+oaHNJM91kN0LiWWu?=
 =?us-ascii?Q?YcAUoFs7gHXTulXbD6zzKc3PhD8hu/EgMFz06y5FpDOOG7t0Ldgw4lEfXB8Y?=
 =?us-ascii?Q?+U6tVgjQ5UwwLsrXIYprLNyjG00BILE64G4rf7GHs3VFnFgTBHi+dG9mtl69?=
 =?us-ascii?Q?8UMlrwRrz+h5PNnxdM4TuIypvqgaeqBUsXXE1AmGR5h8Npli5axwyaRqvvyf?=
 =?us-ascii?Q?9f+1Q009Ed64gGLnUFEuliaR1J5WLdIYM0q1MJfZHXrh4vMAPtDnUlrxkOVl?=
 =?us-ascii?Q?Kw6p5dL2iVscId42Jfrt96yduB03+k7M4lxDzZhtgUb/d5pkj99b63r5a80E?=
 =?us-ascii?Q?O2+I/gJfD8Nh1bUrZ66G/ab50JbQW5bPQVY3PkiuTFcZ0xXQ82OmmV8+EZsz?=
 =?us-ascii?Q?8f5K5cnQqtGBXarWcSoqf7ORbqWmy+ThB8tO78SZeS2C8OQyWBeI6fcLn7t0?=
 =?us-ascii?Q?XFnHenIva4hSR8iD2kq9mXZE2KVy7C91IEtyXjwTbY4TO81cJIYAI/nUVQyH?=
 =?us-ascii?Q?+0wOU+HGkn1ca+k/sjwxd3ngk86q95oW6Viyf9XJXzvuuhxNgbZcR8nzxXDO?=
 =?us-ascii?Q?qlW15jSvPMICLeIc5gs5+9U9YUUB0D+cojxpEstRFtnmpFUIpsUB/EekLWK1?=
 =?us-ascii?Q?qLYmuHi92s9pfPWRt4Hsjrxcuk8aruAX4cq+HhgRdz9hdRL80OT4ANq0nR8m?=
 =?us-ascii?Q?1vGHoXGzPROUD5Smqqd8tNlwOPwh5OAGIfwCRAQOlJ23M+JZ2J9xK8ebCsY8?=
 =?us-ascii?Q?bYlK+2wM4w0tBFEoNSTw1IEajp9u068tkuRMXflyVGxPDfVm9m4/hkGqxh2V?=
 =?us-ascii?Q?HPifCzshjLqpEUPQAQLyDOiuDYHsWIrAT/+I9KNs/+gbPgf4ZkrhgQOyRJrH?=
 =?us-ascii?Q?mc+TBU6JPHNE5TV170ZFm8y2Cm6VqiW/hyKLIzVyyT4t3G6llyCGB4W1RbB6?=
 =?us-ascii?Q?RPTbN7dsI5idadSlGft3sfWf6A14nyE4EGF1rMYewrHq2+M2KJyab7NJ1o3y?=
 =?us-ascii?Q?A5vsimCDUzOyy3qNaHrQZpKMrdNylwcHvH5SZgXFXaH5dBDsNKNlPYo1PRo4?=
 =?us-ascii?Q?m+buqRoB3V5Ck3TwbzINpuUU5e6xd+54H1yk3toLioXdC7hmVDqlZSN8E928?=
 =?us-ascii?Q?3G7AscgsDJjHyBZgyX2aTGNoOmAZpkNQRgpOIwWpYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7368.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwVEW3OulfrBdXsUGVKqPg3g3l79wqscnwJh+ZlkfNp2l9EABhTeA20AJ3z0?=
 =?us-ascii?Q?u2cGbe/SD/r0G0l40velngE2qJNf1oQKnSj6qveBcO13nfxjyRHfMoVgHgIO?=
 =?us-ascii?Q?XVR76pfOzwFcRXnpa6lrMOho4YbTD9m7Rg553mCXQNgA5Jwl2QjR0ZTt+QZS?=
 =?us-ascii?Q?KxM3T1L7xsmU65GkpLbmchfEoBoQ7YRperCe05IORRZB4q8fjOnl46WHY9aV?=
 =?us-ascii?Q?GiqpN5RrFNjiQuATjut59oBxEquyOXrBoAx5sApZr2JmU4IM1Og1NS8jSCFj?=
 =?us-ascii?Q?FygBU3ZPyaqFAPIiBJEg+Z/TsyD6cSS0hfcFummc6vezrSUI5tliNaG6rpfr?=
 =?us-ascii?Q?JJkdJ/Un/H6fpCp29cCgMY8XwzZfaZROdSMGD+263xoTZ/Vii+w778j+zAN7?=
 =?us-ascii?Q?YkiP6DXs4rur5rVZco8/ktRw0afq2l3LOSYHFfj1RKtzOBnccgKwOu6BkI4o?=
 =?us-ascii?Q?PSliEi6HXKPcqHwXIPOpusbel5PgHjPqwfOp5UBSgSxX0sPPtTftSp/vbToo?=
 =?us-ascii?Q?1luJdEog1cq6WLL+r4g3+H627ys+5yPZss1SbqykYvdHWQsjqgvKXdjE/LdK?=
 =?us-ascii?Q?wMU7iG4FElOTFlHoAs7/dHRcRJ728FWrC9kCrzhM/k8bW3fh/IfclORWwdzG?=
 =?us-ascii?Q?DXMVc8ELVaoss14zcwbmWXiQHKBRluqmff0dJ16ipla0PG6L4qvWRIy3k1ei?=
 =?us-ascii?Q?zzNxUJ+PnGUMQDo99ZWFNI4USKITPs+dJ8fz0Y2QwWskkq6ZGV3y15GpY+XM?=
 =?us-ascii?Q?ugurNNf+Wni3zwltow0N+18n2z4U00/oG2+FOekmjD9ySYQvX2RPCFDFcbhG?=
 =?us-ascii?Q?xk1MeJM73/7zWAF/3yGy1iRmRxL9Exs5B7oj0wmceFs/ySWPxAp+JJvYMn9m?=
 =?us-ascii?Q?vnGpw79lXq8vPVNV+++/13o2Rrnu7a0vrHWvKzS66pe+TdrFfMT4vcjQ0/ks?=
 =?us-ascii?Q?J1xVFP5wokHI3KMFa139aDuQBAAmF18Jdp2KJQr/+PKjDwIj7gYM4kUXNYvn?=
 =?us-ascii?Q?DdzZ/+UoBIHvQ1VSEbvoxnYTqnumXIsMFqecbCEQ7IXzD7Us60xcgZhvJxGw?=
 =?us-ascii?Q?kmTCPEBlptempF+jl/Dnc9PHwUtIJcVHMeyW5uPS6UI/xe5snBf9PMlfL8mL?=
 =?us-ascii?Q?fsO59owkdrZs7U6yjwXJEGte7SQLF71OEq3nTNmuTDv1YX6MwLLV7JYUZYPa?=
 =?us-ascii?Q?Ib84YIO1xOpY0T0VXPiPBaiBJy5qgZcPmGD6zykshKY9WpM7YsbVpVRvkqEX?=
 =?us-ascii?Q?EBlp+0tPTYx9CUGCWsrLO7iG6ExfNB8GXPGBJQkpmJiztkdA1U2SZNmYCkOQ?=
 =?us-ascii?Q?VlqJpStBT1iBB0FgWTzYo1oIpxbd1dTGZUf3q/CSsy/3jVRy7MoU8jWen1+C?=
 =?us-ascii?Q?ItCZWosAu/WswFVfke+zr90rZ1j/pcK4rxr1QtzeT9/bFcZJFQGrSxryyMAG?=
 =?us-ascii?Q?atGqHuB7LwXOLnc0G+JLYpP91buxfL28smFxhnZI3RfkO7l5lM3TXnntXqhd?=
 =?us-ascii?Q?+4udiGxJwLihqivVmf0f9nmoxhs6gHLGKhcMTEZHoFTX60NNAJim+2UfAPKp?=
 =?us-ascii?Q?j809AVo+xGRnnVg8O8XxMtTpRUuXCBEi19HmppCu+UqUk2YMgxa4PXXi4a64?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6e9378-a857-43d1-86a1-08dc7106c10d
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7368.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 15:35:00.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5xNEj9CzBNkWm49xtyOquOlodNvIE6RrkZ6HD51jV8mr7JST537AEaB+kpKOiS65fbZRUr+fBI4Rd1nWN9Sdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6769

On Fri, May 10, 2024 at 07:24:24AM -0700, Jakub Kicinski wrote:
> On Fri, 10 May 2024 14:28:56 +0300 Vladimir Oltean wrote:
> > Check that the deployed mtools version is 3.0 or above. Note that the
> > version check breaks compatibility with my fork 
> 
> And Joachim's tree from before the tag, the PR was merged a while back
> ;)

Yet "git tag --contains <the pull request>" shows "v3.0". I have no
other reliable way of determining whether IPv6 is supported. Maybe look
at msend -h | grep '\-6'.

> > where I didn't bump the version, but I assume that won't be a problem.
> 
> Agreed, no point accumulating more bespoke checks.
> I updated NIPA, next run should have tagged 3.0.
> 
> Speaking of requirement checks - I run the test on a fresh Fedora
> install yesterday and it was failing with no indication of why.
> Then I realized tcpdump wasn't installed :(

Huh, for me, "why isn't this running properly?" ends up being answered
by the following Kconfig options not being active:

CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_IPV6=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_VRF=y

