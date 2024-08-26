Return-Path: <linux-kselftest+bounces-16270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F395F055
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876131F222EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C644158D79;
	Mon, 26 Aug 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JHfbwS8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3A78C73;
	Mon, 26 Aug 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673796; cv=fail; b=MApiISTias7hpdjCtouuSLBN9koxDpP8vr6eVLqOCZ4loiuqkWE5ni9eekcO8Zewx+8a0mEvmw9OHClLB6SCoIVF5/KMnVqN7TqAK9xL8Em5aw/1npMw/AxMC4jtbzEfcTvwfG8P9JTDk3DZbZn4NLKyC7eL/uvRpyfwgF9qHlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673796; c=relaxed/simple;
	bh=4YUs4aF6XlHM8NxHY0YKy7LiaGINJzzJ4WfmJQ0DSuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OG7AJP2hvbQIxaz5VnnO3mzzZ/E+XuV3ao77bVD3gojsBeY4zDCUOCdZSQe0gSBemP8sIij5mo/E8Y30TusuuxWXpP59PiQF5Fw2SEgI3MOgRmXz4g8W5pEjWNAsTx6cMJCGmmn/799zMXL+G4kGW0/fa07/s4BNbXswBZoKyos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JHfbwS8J; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yk76W4nCrK1WF9urn1L5rZ9d6lQ6785f8jlPcwr4G+HeIsyN+9qyfA4HF96Kc3y/wdm+PdBm0jAaCGzc9xLT54gRhRZ6FvGchxU9d0Jp8j7dPiCbm6m3Lw/1YItdKEVZINTUkIDWVXaNzGqMZKaffnzVuX43Ni/4SbpDAIbExVXtR2E12C/elLwK+D16skk8AJ5DiCEGXbgOX7U5Ofx2XgnHfB8njM2cpNn830XwCt348Q1OXvg4Mohafb4cpSG+OVwx1njUaHJMZawbQydsK7z22rAsg5aBfzBVtOyp407szKNCCjmWUj4eOFHuW5WprmXQFZ75mF/vFNx3pm4R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw7GhESWXENmbTIafKrCrFh8f/Zm5Gu8WcsfSJhtXtU=;
 b=HJvjZ33zmlA5PibEOSz4Gx8d6QcboRjh5LBpvqyeMNqdnLnTOKzes+HB9TADCa3OjrSzi/MxTq8052GV9VfAB4jVuXifnL0NNtY3tG4tvvWZM3upyPSJ/bD4G4y5vPMAC2zZFS0zRZsgvcmewd49+09vBbcFfJDfvoZyQMqI9I3v2sCiwC6x+HvLWOYC/C//nJvVIvD4rlyQE3JiisFj92wZ8efK5nb/d6DaU1fiqzgPhJw7lZv9fMqsODRjlSLkXYd+n1BZXEs2BUio2MlAuWWbbZuotHAGzJVTeFuKEB45YfCg0/IepvUjaa3F6BGSQDhrgJ63YP6b0gNyFlnLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw7GhESWXENmbTIafKrCrFh8f/Zm5Gu8WcsfSJhtXtU=;
 b=JHfbwS8JQ8fdv27aDY8iOKLJUyua/p/GDZ7LYBfaukAH97YKE8edsXlkheni2iglf8P+abNk0BnmXNW44eZ+YtFEMHtfA4o+1/Pa9azB+xrwZjRFVBEeQJ8xk57CCjQZMlIEGdOVz7Ae3vU3/IHnn4fbsx4hBGx/Ov9vX5x8u/Uh6NH6Q5J2+F4NxssmM605N+2AK1Mj3tlpngScEvu10kl+2dsWmarnwzdi0E9SGt21vqOR6JYcB5p4p9Tz536WXcprdt4aFAhGRgAvCNfo4P/T/o/O8lOb0vHmFtGNa0L/PHu5ZyqPkP9giNGuzzauz8FsdVFpLIkq2jcL0tQaCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 12:03:12 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:03:12 +0000
Date: Mon, 26 Aug 2024 15:03:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 4/5] selftests: mlxsw: sch_red_*: Use defer
 for qdisc management
Message-ID: <Zsxu9nf5PTNGdTJk@shredder.mtl.com>
References: <cover.1724324945.git.petrm@nvidia.com>
 <86f5621c15804eddd7563d0ead0cf3c75c08fac0.1724324945.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f5621c15804eddd7563d0ead0cf3c75c08fac0.1724324945.git.petrm@nvidia.com>
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2a2e74-47e3-4e43-c29a-08dcc5c70ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Mxb72442G76ekrLCiFGk6HTHrtBWnAau5AQAR/H1Qda3aeI12LqMOul8hw/?=
 =?us-ascii?Q?RMaCmzEVv7TXuqwTURGZfkEmeu8Ufg3nVeEZ64S/vrB6Nl26pQaZIDziqWGo?=
 =?us-ascii?Q?ymrsG2vlpHVLvbMnOWcBGyk81wR/DaGiCvZC/DO0w0PfiJTOeH4Ghc7/BSV7?=
 =?us-ascii?Q?CTV4FZYAzDWbr+WZ+aMa4bQlTotSZsdpCuwj2tFW6S7r5EdW8O0I+GvJSbEF?=
 =?us-ascii?Q?yutbUFrU6lvRh2vfDUJkxue+HDih+AFh5FnQL5kqkONQ3GZjdR55fcxmz8Fv?=
 =?us-ascii?Q?XzTsGcjZTEy1nYyAjQZJZ3eRxBza3SQXmLZ9YABeApjvYZJsId88sQuJVZQL?=
 =?us-ascii?Q?M4FEM2Od1dKkaH1vHRGwybV6hq4N0Zdq9KJNVjl9RLgm3Q0nfRpPtllknEpw?=
 =?us-ascii?Q?NvYsGMSVYNKxYW+Kt+X/M0a+biEjP4w14jmug2Vaol6/6Fe8RvJVERWiM+Ou?=
 =?us-ascii?Q?CyWVInYgHGddtQQpr4XIVD5b5ioLGyDREkmsspib580ayaQjBsmlaVYPKoqY?=
 =?us-ascii?Q?mFcgq/utJLSvHlxVtWI/HbHSn01TdgPPntelaqJynOTuKnoDGqKItS95GGtN?=
 =?us-ascii?Q?hsD/jah04LiMr8m0K2lLZI1SPGYPnuEeNiicF5hpYZXp6WTRv6DX7CK+Hocl?=
 =?us-ascii?Q?hJC+802wg/UAEK/NAQbaYb1A23AWgfEm/a9oQ8P1OcZ9lKBhAJ/js/vkcft3?=
 =?us-ascii?Q?8qLDxI36vi7G0QqbMD+gtqpGrfaoBtRqq3egcoSIihJNQcyICxMg/zXIGyEn?=
 =?us-ascii?Q?KgwnneOAAHG3UTrhDjVLm1/LQ8ZdPmpsc1myMgE5lcN4CVUlD+3BUebRnxpp?=
 =?us-ascii?Q?Py1tFE3hQ6hryoBweJVoGYxazVvRHO52I8vm4t4y+cYn7Lm7jJDMCIK2w7Me?=
 =?us-ascii?Q?fKWTOHXRMbPeERo9eQ7Kolf2uWORzTrucPJkwNapkbtvdkUARiOcZ0BtR+T3?=
 =?us-ascii?Q?e+/D/M9JfMgI0msTzuhpHDG9Z2SiEdnu5j2rM9LnW0+ylbSrfwXcn/CF9VhA?=
 =?us-ascii?Q?e8szHWH2Jz0QC9/ijw4FwdDNx6JfEvU9URcFaFNmRy2h+lkoH8cCwGGfaHse?=
 =?us-ascii?Q?948IlY4q6jz9VaoF3a8D14N8v9Y/psxqSYxbmB7hxRvVKod+8qXdYRTDEHFz?=
 =?us-ascii?Q?jhws/2jUSDsq6798lXQxbgL+gQjQArLNYRRnNLfLew+MCZQiAdE0eBOi+5Oo?=
 =?us-ascii?Q?kIP+k0czWejdLpq5lW5/jiqm8esfT7DJ6isKiiaIZEHGVDfeyzLU+7VXlRvF?=
 =?us-ascii?Q?LWbcrVUy91mCyLOmCI+7v8+LRApZLI3z04OxYm6WpJJ4AIM4IxZtD0gslsm4?=
 =?us-ascii?Q?PgT7CZWcwllVJe5Mvsd2CHIkJIZkB15rCsz2nUwcIH8dqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8h+V9VvSft6esEtWKIvJNH6tHn/bbJH4SnazrR6Bciz6g/TMSziz1+zWiFQs?=
 =?us-ascii?Q?1EBKrKJRS+6VhWiwk5enn1pc35B52d1hQihR1l++B3T4R4zaXF61TlDFE+6F?=
 =?us-ascii?Q?/C6WS6p6whrWXU/3CjNZgm8qTXPpBg0Xtzrh9qTEDWpWglt6wrbnfFvtBEcN?=
 =?us-ascii?Q?Onc1fDFQeZ0SbJ8JcQRuRhqj860BrfnGsLWhus3DYI+wlQUJV3mpzUT0jK9e?=
 =?us-ascii?Q?P3WunPdL3YA3lX+fdoei53NQTaNSDQV/URbH5GdPbHiwlfWSa4FecDt5+6e5?=
 =?us-ascii?Q?jImbYWHA1ZevqEMylO0hvPXMuG/0poCNNmuB4r1HfLMCHfrB0ocKWPBBkm1E?=
 =?us-ascii?Q?yFpSYUcrztaNhS32QzDuayq12x+cFvjCwUk+mRZHxJRyk0L92CynYXAWQtC5?=
 =?us-ascii?Q?yYdkLu5wVZoVWY0qPqjJ3siHQciDCQ4Jme23ct1Gb/oUyxGKl4v6r/rhiiCi?=
 =?us-ascii?Q?xyw3DoqMUpAUW2MEErtD/tKjIaM1o1LWjRmmwMWhPWIWwlFYyYUVeIVfbbe5?=
 =?us-ascii?Q?EA6XcjjTAapl+gcu+s+CgpSyADHTNGY4f7k007SjeC8/9gD9otl6JDPUBVKG?=
 =?us-ascii?Q?tFdEp9vEoMhC2n2vsCCNv9RAh8cmi6kfP0IFsUrETobl1L2namoJa3bv+6w7?=
 =?us-ascii?Q?QXYIVBFxrMQiO6IZ+YW0mtbKmZ/TVLTA4U3gVwZy5c0Wc8YTFmgl4jESdz+S?=
 =?us-ascii?Q?IV0mMBETp6KWldmzYkMk0rB33SdGJ9ulxPmo0utDf0IPmnwHpW7+iVTI55G0?=
 =?us-ascii?Q?1xRx2oJpQqlMLYSikOv/EIJl04d1aPjKRrh+xCh9JIH/QMvcEeFDLf0U0RR+?=
 =?us-ascii?Q?6OokRVqiUQeYKznNzokBNdXvdRdU/xnWjV6IS7xxBDT6t8l/zFj7lA4mQuO1?=
 =?us-ascii?Q?0FEdeRQTDnw2Htuw8sTtSZcoLwq+61n9U0NKqEssONCE80I/m1/dGTnWjEav?=
 =?us-ascii?Q?v9bffhf6jBHd+Zfp0aWxwtgBDRM3HeGdutq3GrHe0+ix9eFgKTaPGnF/1WOB?=
 =?us-ascii?Q?Ymyjdyd7tQ1iOH9ddZDzX3aPGmNLNbOHD7MFlwwVrmXZqEvW2Gk7h14McyEd?=
 =?us-ascii?Q?1DebC495O00H4xW7oiQG8LCdANN2TYP9LLhIYjROlw8IbOJhVrqX5jPfXBpl?=
 =?us-ascii?Q?hA58os2zOYgdpthFB0sYuRimpBhduJrOJkMpfa6eSr4iga3PLG8S9pFvMnBQ?=
 =?us-ascii?Q?MGQCuGAZsj8UMA+/o3T5N3+O+2vyYzb6uB0OCGVG4EDJbT9pZNggOC6/g+y4?=
 =?us-ascii?Q?3Ziv0DtaLcoHebox1W6nioQlygUnOZW+8+5Kb9k8RAOQuPwxYFAM/+qpl02j?=
 =?us-ascii?Q?XjT5m58f1DHwwJX+UtnXqOeOL3g3rFrRBvFs9uvqq5hZjaIGdcsIwJ/ovmTd?=
 =?us-ascii?Q?Y812FSViQzdhZIYyy16FSneQXBPz9sJn/HD5hfdXbQ4Ty1uETt9O7b0jbYux?=
 =?us-ascii?Q?pvMfFeMqwe4SFR0N0fQrLq+9VMn342B2I9UD1HI4ZlqffuKD9IlygjWnXFVq?=
 =?us-ascii?Q?Z8pddTquGXZQ3oof22+f/S50CoA7Hpv7m6YTBMys+ZjpTs9BSsTuzyECYl1e?=
 =?us-ascii?Q?X8ahO30iO6HOcLnbD1p5SOonWCOHW7sprdPF5TAO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2a2e74-47e3-4e43-c29a-08dcc5c70ef2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:03:12.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81wE2I9HtPMEAfgK0Ah7/PIQHfRaSsn5BYko5FWRIlowOWOoTtKZHUbHP4Q0mLV2W8G2AEZaBjwKjWv0UvNnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Thu, Aug 22, 2024 at 03:49:43PM +0200, Petr Machata wrote:
> Use defer scopes to manage qdisc lifetime.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

