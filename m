Return-Path: <linux-kselftest+bounces-47675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50312CC9ABA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 23:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DFF0302A12F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81130FC22;
	Wed, 17 Dec 2025 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="stocsX0X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF33A1E63;
	Wed, 17 Dec 2025 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009366; cv=fail; b=HT3jYIhCkggZn5u74+x0g/8xlBhcdCDumIfWRJVrdnyopuq9dabtymx26N3FstiMviNoms438ie1uIw1OQRffkTadyFqYLoDp5deH3G+VbV67e9jUCbT4FyrfZ39c8Y4Ch/67K8rEA9Z99rA5fz1MbdIxaLEdZCzPom2EGsDII4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009366; c=relaxed/simple;
	bh=ENuIFlhk1uKa5xSdRD/6TGiUOA/e8EpaNQUkRmp33Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kpO7Aj0uzwkxQRZvhTYUGSFfzy4qbVfkBV59dq61+jIDGy3lXU7aNC9ofruvgy7n2zd9AdYGtji0NfhbjG0miJ6zuuDIwYqunsMLdtbOnmvkvvocnLTb+6ersoFJVa6jbZrQC5fDI52zei1b6aLfngpnyhe+21OBXbpxD2Lnt/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=stocsX0X; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH9APZm/23OiOuXTlAk8dEL6L1UK+PrLroOA7vH9C1dEozyQ8u6t5gFewxg4Y53dcgmvGQA0VO2JWFsK90OYlDmIUDNkWyaoCPVpEWzDKFBRodY/3Pwkgi0ZUn3dKFL746/ZOcPjPqzu5dP07+ndKSaNu5TK83tjwJMZsGeX+fhilXu4g9R1tuSRjqE5qwel4OVEE1BwKL2Te5ZeZ6db+o3t1vT9MELtmXswlCXHM2xbwFhSgwnkLGvN0lvouTCYtPPM8Po6bY6LW/Ox4/ObCM6xY+4k2h7FJp2lsx/mVaFd23CUb5b4YTfw6h8kXLg/pBRKqOi+gqKRHTJ//7EYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MVotEAhPgd1MYTmJ0EcWimLJkoNHWm3QfcwrBXYFJY=;
 b=RkEuN40A9I8vcBx0lJHDEF1ol8XrqKhvBMpdkMHBlyDjIUdR3I9tJQw1ZDRCrtBoeFwabc2jWHnH/GGHwRfFAzo0t6FX81sQzZ4/xiwVoYt55Z/yBEImxhFN18vcrD3NB7glfUoW72KmJMZi239KCnLerqbXAn36t63elGQg3nwEq069NRb2/qUuzkrubKkh5mn2lRV4o/qQsxPdBHkGhf3bW/wcBAvQo6qZTcsHnIb4MqfXzKtXmqRX362fBN4bQLAnLYaBMowEMt++/833DNBhKxcEzhroZQV6JqX2pi0MdU/8Kt0JmE9Wj/NYblirr+nmByDwLXD1RjftDvIWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MVotEAhPgd1MYTmJ0EcWimLJkoNHWm3QfcwrBXYFJY=;
 b=stocsX0Xfx0wB4n8JkRxfSV85tMCYnQbKdbSYNaxvSyHXhX1Sbn/Q3x23mdC5BhtlZPSajVAfRN8wW+LYm776ET+Vby7c00F0ZunRZ5SNbX0ZiBweD2KyygqfH7QpwF44C/OQQQiBftTRCO7KJhGWmzCFT1cB6+5xdmmE/PfHbGU6Uh7Bph1MMcY4h5ox0Z9tJmfVpYl+6tM1GYYuP86uF7oUaA4UwdJo0me9EyW8z8mgAtsK77+nR+ZfAjbE2jZVZZxbqYNXm72bEHCBBZeB3Y6N9y6eUgoJQwbdQzjcS87YsRR1qKV8++LsX0sEKY0sjSXCzt4CKsVG4Kdy7WJlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 21:55:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 21:55:08 +0000
Date: Wed, 17 Dec 2025 22:55:05 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aUMmuRI-ZljfDuh9@gpd4>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
 <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 261614cb-0a3f-457a-d08b-08de3db6f1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?nkoI7b4qSmDQt6atZXY3ppipa87FTvokNQ+Sraut5zLk/gpAKvAJ98P9/sWM?=
 =?us-ascii?Q?0hV/HRoKHjbkLsGWtrNwwJeF+X06UJPxe2H2v31SJ5jLwZLMV2LlhyjRSoHc?=
 =?us-ascii?Q?hh0e0McakR9l2LJjv5y2uGRcm3kCytJY1vkyobiD90kvPQuCoxvntTK7R4gW?=
 =?us-ascii?Q?yjwBOOI3c3k+BKpGuSblTBmYiQqL0q4NnNjS8DD2WNZwiXpxwFtV3El7CwcQ?=
 =?us-ascii?Q?Y5AJT6AWFHu9THq+iuWDgRMRSuzpeqAx+k+LLjr5T4JFIEC/xZOjtzoRIWav?=
 =?us-ascii?Q?ADGUOL3NrNvnSKZz4/DnarTJlLmGr/7wOYnwp2jknuyncsdh0Yarkd3ImD78?=
 =?us-ascii?Q?4hev1M0poyK76BSQPSrShA6WtyN/QyjgVNcyhFj6CoAlnOtHlHWHNEhHuPDw?=
 =?us-ascii?Q?HFUNTzdp2+xEfoosOXcbfBlCUD+4EMPW+SbusGPigwrwCLnal2YeEXa+q8n+?=
 =?us-ascii?Q?tLK2XyKndqtGjRHVrNfSXM/or5+2comXRyQEPEY+2wTVLx1FL8zJ6VQ4+2/v?=
 =?us-ascii?Q?iN2xq/eZhhnaO8RhSMq0NWTlwl/VMR8JBTD24dKCfSePapInsK/hXejor73c?=
 =?us-ascii?Q?ZoW718IMn1secsYnOmIr6hNmEY6hkDzrBO9me94M6edoQV36B9rnrnZmMquj?=
 =?us-ascii?Q?fTrSH2Qg2hNorPPctgEa25xaFMlUtasUhFgbd97hUDEXTG5bMXxgZt5qWMOQ?=
 =?us-ascii?Q?eSh0QNXfbQMEhs1gjBUTC4JlatzJAaygDr5auN5jxN9LEknNYLS8Xjd7Rcnw?=
 =?us-ascii?Q?WFUN44Fcn8UZHEhwwsd+e1zS1ohVl+SbJX9IIv4L83byzJnUQMLfrAtKYyhM?=
 =?us-ascii?Q?cLm950n68nFl9iyfavJp6l/suEnb+LyRD2g7oZfh3H201L+uyHkK6wgysSiI?=
 =?us-ascii?Q?hYPpyuKgEFxYoYFLxRVirZKqo4K9wgCoY55XCyNDX/P1Yx9R5uex3JgrFdiN?=
 =?us-ascii?Q?NKd8eEYg79rwdML+WC3H9ixf/4NtZCYVw9Fx4TGpFEIhKXBxvBTd7ATE8ib7?=
 =?us-ascii?Q?AUq89TOVJ07+HhKwC7rB3sp/sN9HeovgnBXX8YaVjcIhVdGqlJKGvGhDe/pF?=
 =?us-ascii?Q?ei9VKggHLLgP3Fn8pQr30Z7DCztDKQEn7Mc8PWqF5sEX9U8zANTOnr0LMjJW?=
 =?us-ascii?Q?TUtE83exvBpKnYnZ30il6OIbmP1wSc5ieEdWZBotgtrFdyF7i25icc4/WXdF?=
 =?us-ascii?Q?ZODzT6HVaJdbtuK8zqkpzubE7BVTcM+e/vsuUFmGJvVjFScIZyBvIvW4QmkF?=
 =?us-ascii?Q?52/TVxlVDj3CTVYW1qZPH+PLjTesYMWf8IHZ/8ibrEDRsc6NfcwoFemSGld3?=
 =?us-ascii?Q?nQ8wsdunuYJ03rQcTtE8TtsF0q5kzpgR2FI/YDpRks8fyrdqFDJTe0K7fYFi?=
 =?us-ascii?Q?4MEANDFuFRTeLw61Ouwx1G86G8p8c078oZNlNFBxfuc2sDaLGLpY/lKRCEdF?=
 =?us-ascii?Q?jDzEsIneJLWYoEB5uSIiqIv6XxXgsmzF?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?zI4gRAd26nx+YYe/sZ0bM94NSrp/eY9DncnbOi1ZSqTfRxDdQ4WKtAZYK9Ne?=
 =?us-ascii?Q?7SzhS9/SJeSROiscCKOe8ZWCFJKM6Da5qDz8ATogtJ2uUrlQbpQxHEHASUiR?=
 =?us-ascii?Q?mpBCNzXFvs9lyf0+Nlp/KNyb06hIxOHJ1OOnE3Xfe3zpICPZCn+YZwnmI919?=
 =?us-ascii?Q?i2KuvA1gal5rI6IqbvO8Oy3mwE73WYBPA4OqlHvFCTGD9mGe2D/jnZWqCPOZ?=
 =?us-ascii?Q?iaJSRwflFRbsELiTLXuFv9QvyWDrELIsxfVb+XMqxR+mH5/STdG7oNWKpP8v?=
 =?us-ascii?Q?gpOgzzqBcBCgSDf0wVVEPT22b/NJv6X8kKXMbCqhW1G11WkXUKJxufRMaqg+?=
 =?us-ascii?Q?+YWUzSyB7fpyBOIJb09i99KFH/iWRc7cx81C4/yL2HiyyztFZ44W/pwIreiU?=
 =?us-ascii?Q?kcMxdbTS/DKNkQG9arRzIl+z29NevglrDvZwIUXK791EY6v2zm/WuQ5KVYq+?=
 =?us-ascii?Q?xxMX+8sAFrGMHbS8N7R8d/fvXv7bVqExL9xrtWjGvpPU8WyFimB6oNGzsDsX?=
 =?us-ascii?Q?okDhuxLeEH3lXhd+j/u+AmayKZbIpgSwKuMFy6N4O8Q79YLPUX0GF4La827u?=
 =?us-ascii?Q?+xXRGu6HyZd2iT0TGG5+24l4gyHzYQ47qA09koZMowNx/AwvXLWMPxq7me0P?=
 =?us-ascii?Q?oEKuzOlZuPueMbWgbGc5q8LMkkb75NywSLjrCTEUHLnCj+eoDcPYlkmRVCuz?=
 =?us-ascii?Q?i4HCz4hocpp9atil8Da7ZjSBckXKfe3UDwCxVFw8S1FOODT1SS89RZ07ifE2?=
 =?us-ascii?Q?bWMEZcFb2SZ4YDA1Wsrd3aNpULCMliA/xB38EApG4b0yBrbWYE+cpkdVdl2H?=
 =?us-ascii?Q?kahAN4ajSMPlZcvEdosQK5KkxdqNVIaFTaZiSQo/doANBnIz9K/7ysLygtSy?=
 =?us-ascii?Q?ow8JsPrQ/akt2krHOindrO4gvlPPkQCReSg1DnmJDjXiShG8jXlLLzwFt8GY?=
 =?us-ascii?Q?rap3U0k0BzS523huvaECjZ5Jm9fP/ERnDWeubcjH70ioC99QK0gOG00DTeIm?=
 =?us-ascii?Q?rvaUezDqVSvazw7FuHWSrNbKwSH8NR74gcE0PEEMAqKB8utj1JAPSpG71uch?=
 =?us-ascii?Q?+TmLuJjOv7R+3nUepA92YckSJN3T18sKqqQgba32TnvoPlW3BjP1kL4XISnq?=
 =?us-ascii?Q?V4MHi+QOkpozdBq4yKn0qrJYgHESIx2pky9XvTd1SJZpGlAiq9B3uTndcZj2?=
 =?us-ascii?Q?2dC0YLvxq5onZP282SH2Yt+5E4aRG2QDsX0093rRx9dmaPAnw6dkUMXFATxv?=
 =?us-ascii?Q?qmkQKdjn722bl0s2U852sBbLO0BeY71+Ueu/FGzO8lPZELXRbcRZbAlWTSz8?=
 =?us-ascii?Q?MmVvZAhaC/aiwsTQBnhM9vHXvLaXhngM1Au/qG1P1FAoYdscqgJuMMkkWCMM?=
 =?us-ascii?Q?kokfgmWaVYYMpt7WrmVvQHIcDaD04BFi5NyCmYleIt1zga3GcvcIEazwDAVu?=
 =?us-ascii?Q?7ivbNvnKXCsUQf7QUuB3qHOaCwMoMa5JmRLALtDoliSiH7dNPvvMx7rzygSm?=
 =?us-ascii?Q?x5GfdSlhq6cT1EkuB9R0tQE8s36YIOl73hAteE3QVsFihu9/dmN4t94Oy7rx?=
 =?us-ascii?Q?8z3BZPSZyJ+8kDIar0n+o6+JkeeWdKziO9ayrxhd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261614cb-0a3f-457a-d08b-08de3db6f1fb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:55:08.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgz4gyx/WXzPkORYhXeB6zbx/0opAgUwRln7OIkBvA5CMUTYGbjFNKRPWx7255XI8QJhuRVeVsVfXDE/Rlgr/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also included later to confirm that both DL servers are
functioning correctly:

 # ./runner -t rt_stall
 ===== START =====
 TEST: rt_stall
 DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
 OUTPUT:
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1511) is 0.250000 seconds
 # Runtime of RT task (PID 1512) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 1 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1514) is 0.250000 seconds
 # Runtime of RT task (PID 1515) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 2 PASS: EXT task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1517) is 0.250000 seconds
 # Runtime of RT task (PID 1518) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 3 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1521) is 0.250000 seconds
 # Runtime of RT task (PID 1522) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 4 PASS: EXT task got more than 4.00% of runtime
 ok 1 rt_stall #
 =====  END  =====

v5: - do not restart the EXT server on switch_class() (Juri Lelli)
v4: - initialize EXT server bandwidth reservation at init time and
      always keep it active (Andrea Righi)
    - check for rq->nr_running == 1 to determine when to account idle
      time (Juri Lelli)
v3: - clarify that fair is not the only dl_server (Juri Lelli)
    - remove explicit stop to reduce timer reprogramming overhead
      (Juri Lelli)
    - do not restart pick_task() when it's invoked by the dl_server
      (Tejun Heo)
    - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
v2: - drop ->balance() now that pick_task() has an rf argument
      (Andrea Righi)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     |  6 +++
 kernel/sched/deadline.c | 84 ++++++++++++++++++++++++++++++-----------
 kernel/sched/ext.c      | 33 ++++++++++++++++
 kernel/sched/idle.c     |  3 ++
 kernel/sched/sched.h    |  2 +
 kernel/sched/topology.c |  5 +++
 6 files changed, 110 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41ba0be169117..a2400ee33a356 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8475,6 +8475,9 @@ int sched_cpu_dying(unsigned int cpu)
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
 	dl_server_stop(&rq->fair_server);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_stop(&rq->ext_server);
+#endif
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
@@ -8678,6 +8681,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2789db5217cd4..88f2b5ed5678a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1445,8 +1445,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		dl_se->dl_defer_idle = 0;
 
 	/*
-	 * The fair server can consume its runtime while throttled (not queued/
-	 * running as regular CFS).
+	 * The DL server can consume its runtime while throttled (not
+	 * queued / running as regular CFS).
 	 *
 	 * If the server consumes its entire runtime in this state. The server
 	 * is not required for the current period. Thus, reset the server by
@@ -1531,10 +1531,10 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	}
 
 	/*
-	 * The fair server (sole dl_server) does not account for real-time
-	 * workload because it is running fair work.
+	 * The dl_server does not account for real-time workload because it
+	 * is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -1569,9 +1569,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * In the non-defer mode, the idle time is not accounted, as the
  * server provides a guarantee.
  *
- * If the dl_server is in defer mode, the idle time is also considered
- * as time available for the fair server, avoiding a penalty for the
- * rt scheduler that did not consumed that time.
+ * If the dl_server is in defer mode, the idle time is also considered as
+ * time available for the dl_server, avoiding a penalty for the rt
+ * scheduler that did not consumed that time.
  */
 void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
@@ -1810,6 +1810,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_defer_running = 0;
 	dl_se->dl_defer_idle = 0;
 	dl_se->dl_server_active = 0;
 }
@@ -1844,6 +1845,18 @@ void sched_init_dl_servers(void)
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+		dl_se = &rq->ext_server;
+
+		WARN_ON(dl_server(dl_se));
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
+		setup_new_dl_entity(dl_se);
+#endif
 	}
 }
 
@@ -3183,6 +3196,36 @@ void dl_add_task_root_domain(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
+static void dl_server_add_bw(struct root_domain *rd, int cpu)
+{
+	struct sched_dl_entity *dl_se;
+
+	dl_se = &cpu_rq(cpu)->fair_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_se = &cpu_rq(cpu)->ext_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+#endif
+}
+
+static u64 dl_server_read_bw(int cpu)
+{
+	u64 dl_bw = 0;
+
+	if (cpu_rq(cpu)->fair_server.dl_server)
+		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (cpu_rq(cpu)->ext_server.dl_server)
+		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
+#endif
+
+	return dl_bw;
+}
+
 void dl_clear_root_domain(struct root_domain *rd)
 {
 	int i;
@@ -3201,12 +3244,8 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
 	 * them, we need to account for them here explicitly.
 	 */
-	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
-
-		if (dl_server(dl_se) && cpu_active(i))
-			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
-	}
+	for_each_cpu(i, rd->span)
+		dl_server_add_bw(rd, i);
 }
 
 void dl_clear_root_domain_cpu(int cpu)
@@ -3702,7 +3741,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
-	u64 fair_server_bw = 0;
+	u64 dl_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3735,27 +3774,26 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		cap -= arch_scale_cpu_capacity(cpu);
 
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
-		if (cpu_rq(cpu)->fair_server.dl_server)
-			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+		dl_server_bw = dl_server_read_bw(cpu);
 
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - dl_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap, dl_server_bw, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94164f2dec6dc..d8c457c853aef 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -957,6 +957,8 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -1500,6 +1502,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	/* Start dl_server if this is the first task being enqueued */
+	if (rq->scx.nr_running == 1)
+		dl_server_start(&rq->ext_server);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2511,6 +2517,33 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 	return do_pick_task_scx(rq, rf, false);
 }
 
+/*
+ * Select the next task to run from the ext scheduling class.
+ *
+ * Use do_pick_task_scx() directly with @force_scx enabled, since the
+ * dl_server must always select a sched_ext task.
+ */
+static struct task_struct *
+ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+{
+	if (!scx_enabled())
+		return NULL;
+
+	return do_pick_task_scx(dl_se->rq, rf, true);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_pick_task);
+}
+
 #ifdef CONFIG_SCHED_CORE
 /**
  * scx_prio_less - Task ordering for core-sched
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe1dd177..53793b9a04185 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -530,6 +530,9 @@ static void update_curr_idle(struct rq *rq)
 	se->exec_start = now;
 
 	dl_server_update_idle(&rq->fair_server, delta_exec);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_update_idle(&rq->ext_server, delta_exec);
+#endif
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6870f5f..28c24cda1c3ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -414,6 +414,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1151,6 +1152,7 @@ struct rq {
 	struct dl_rq		dl;
 #ifdef CONFIG_SCHED_CLASS_EXT
 	struct scx_rq		scx;
+	struct sched_dl_entity	ext_server;
 #endif
 
 	struct sched_dl_entity	fair_server;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cf643a5ddedd2..ac268da917781 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.52.0


