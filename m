Return-Path: <linux-kselftest+bounces-22670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0D9E00F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35709160875
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FA1FE457;
	Mon,  2 Dec 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HJ2xGDX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B731FE44D;
	Mon,  2 Dec 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140361; cv=fail; b=hB/kApt2Oyxjw9JFmAFoSlNiDWtFdUv6iWeKxUEViLIqfpfadK34BebW8ZxWRzXu8Pbh/gdWiVGYqIgPrl8ldgWTY6EE3jMt8c8JlPHmf28LiA/ljWqP/9e10k6/TxlYQG83jRaPcKHfhqKRTTHXVsFW+SfCS9sKarAIX6Mgcxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140361; c=relaxed/simple;
	bh=aTdGSf/0h0+qenmPR+C2rfrL4m25Lnql2eZkh3EcEdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qNzU+g4OFFlL5TlN2CUypy19LCYpyDpRI1dEfyBzpXsLjPW2vq1pThxGmX86q+wSQsQK4HGUcNBpqCbrmQeJcfYd1skhacwRfrp75nIsZO6ikYvUZ7AwTyGS9JySjh14XjytUHc6NP+6oWgdAtO0PKLRQXdl2UZXy8yMnZiBVAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HJ2xGDX5; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voFIewuP5Yr3wzYNZB0PeWNZx3ofcy0RB9XMKqfmwcX1XMgACfn63ckNp8jqgLMayIowZmcHfgS8MrZgTm2ifONR8ZcwI936SZD2+LMP7Pwd5AnagODtJI5S9CQCvXpY0rxoaQPuhA3QQzhfku/3FONMF//JkQvOIIrxsd4686ixy0MY0Hf6ksBmhnQ8zcLXnmxKHZgg7U3NxqIjk4RM1MF0xrd59G0zub8zv2k32nKpI36FqZy4rxW3KSAhCbJdYjesepxMIDbi2q8yV3H+pD7uQ6YVPs/u+L7VraAY7wIbJRz5fWTJncLkXhSVSpWSB0eLr9g5Y2uHHdg4FKAJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU/r13TB6cBCa3BJ+JLp8oM4REbQvqe6mlsotDZwEDc=;
 b=xO3Z+l5d3i6F+EBw8T0Hkgy43EUMF/1jF1qRYUUU3nxyAO3Kq4a/Hl4KVcCxltrtTi+wOIwjQtFC4vQ7Ru09ybLIBGclT1d0l7zd+/n5Fjnlato0LLb8T5u8tKSmklp1MhrgRlugEA9JFgHzvwJeAI61JU4JXDXBltIpw1LjA22F61LonfpW7tSqghiGH7Np10qXHmRFTGvdC+VYr/8WQNuk6mW29bawexuYgw/l89Ax6j8s2vksta0uWq0hm7hVQFrkJw1xtAo24k0IUCwgMj4qgc7n/ng0UujRtJgD2BfJ9qQIcWJ6j6kHcFsxoaTO1nUExjR8wd8631VNC87Ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU/r13TB6cBCa3BJ+JLp8oM4REbQvqe6mlsotDZwEDc=;
 b=HJ2xGDX5cjJyvpYcSOdzpmCUqZ0dkaq98107SqSjZDtwS4hCCdmxJrtiQeRNQYClKt9/tTTafx1cr7zrskMnOWUEfBVjtJ+xbMkVZ9oGRMiBpU8xRB9UTG+Kwu3VcEMid1a1O0ThTmXgcDKSTRU746t1C1knN3+oytfftKdeiQ1LDHQAzNMz2YqX5g7x39TN4utB1BYgRs/43eOaehqsLJTwN6+XvSHc80oVn3YCdtc2g3V/TJUec0G3yGIs6EAC21JDGR24rfBN6zZ1nAw0lVt7zxV6EfqZVEorYhMV5RLKN0SkDJ1Q47Z65C3UKF1pdn5QvAcrmbD0KNoWc/jF5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 11:52:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 11:52:36 +0000
Date: Mon, 2 Dec 2024 13:52:33 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [net PATCH 2/2] selftests: forwarding: local_termination: sleep
 before starting tests
Message-ID: <20241202115233.quxeapcw6g3uyj2x@skbuf>
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
 <20241130113314.6488-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130113314.6488-2-ansuelsmth@gmail.com>
X-ClientProxiedBy: VI1PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cf4673-a371-4489-b7af-08dd12c7d098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BglYl7rpzkQfQ3IIfnuvYWOdo6MWTeNT17xzIILAW7ruqpok1tWd+5KF0tES?=
 =?us-ascii?Q?aXDQg6pDnKisxT5jmqKZYjbmIikBa2kG8OvySBRrHEaqSnG8yqlnVjmQj27R?=
 =?us-ascii?Q?6W9boSiMNOVJcfFh1dWR9DTYeNLAm6OWPNIVXOZHOM6rhM/hyPKO4Avfe56p?=
 =?us-ascii?Q?kUtQ6nY9uv6fk4cTh2KqW+WrAo+S5+iL5PZSfZScoWz+3PQFWG9HyzlKghVB?=
 =?us-ascii?Q?LiMPop2BzmLNEijjiryfQOASxdqjl2R4LPHmBa1QftbRbU0aVv54nLpxFr4/?=
 =?us-ascii?Q?JW1H3Ezn9XBCjKE21H2JRHVsPCFcEpUcMXuh1MK1yftq4Z6pKnUtjvodO+NT?=
 =?us-ascii?Q?p610g+MGhi9h8r6FguXRtWKJgq0AzuGPjkB0v06dGBkI+wSvUPXDrIAjrB+4?=
 =?us-ascii?Q?S9H6DWxMGCcywyBTSrkJ68OuklFFP0O7uWXyk8JMWmjAWNosoG7623Fd2UxA?=
 =?us-ascii?Q?XgXYTcKsMgFwpleaXA0czccxC1mdjzg5cT4JdJN/n9jeAQj2r1lI5SlamnxM?=
 =?us-ascii?Q?5J/u0uTownq3DTnICJtkKJW9R9pJUuFCZ89SPb9wwqMF4pkvhfUhSTIVKJhJ?=
 =?us-ascii?Q?WNN1nUcDBBhI0krq+TUBL/GfV2KrYJoHty8k3P8xF2Uz4znXMBi75qPQbNAQ?=
 =?us-ascii?Q?KELQIeS4Bb8y5fDnoImfrvSYky6NjypbxNVW7eFpee8ATPryD/AreD7A+QpU?=
 =?us-ascii?Q?EH7CdCBCyHooDoLs4MzVsClGcVIgf2hShkvR+bi54uyQdHOSKoRFsnzEo8z6?=
 =?us-ascii?Q?jrpTMjMmyvtsL/a13M+gw+WGqiACAECYm2nIPqC8a8jL1U8qL8NeDDUEFkr6?=
 =?us-ascii?Q?U/SxGqRoh6YfS9T3Zcj+CmOO6wjocfJpdltaseMuqqiMvr3mx/tWmc5etMY7?=
 =?us-ascii?Q?4/hYanPR7eUy9wy7AmheeptVE11XimyH2k2ycTj+6d8ectQzzCgFBuB1hnh4?=
 =?us-ascii?Q?o5BL2qAQyI/8Pwh3o0vF7I0e3EBuKQO8OYHcfuZRakMQ2HhLqhuNtimsr+Yy?=
 =?us-ascii?Q?VOWNz5eVugLxrSaaXznF6rFWTQ5RTMCFHNZ25ZCGQ7c/tGJfuhX5qr9X9s9N?=
 =?us-ascii?Q?ZRm+Y7XCpynQsSoCbmPOMFOWgNxqEPHIjU+sGtD8SX+AZk55rJMpFsyHVieZ?=
 =?us-ascii?Q?MFcYaHPlhH0hxNVXQ8gUBI0y+efT8Gx9n13mni7xxFOMDTNt/JLjq5Tppxu8?=
 =?us-ascii?Q?CcxdP59PSfgQR9IF455HlYQu8Ift67pOW4okYdul5VCkZKVlD3kmCFHrLoz/?=
 =?us-ascii?Q?yzrLURbJxopy8fVmdYEtf94UFWs2nMNGTnQMAy7JeIpVwIAc45kBseMdTygj?=
 =?us-ascii?Q?bXLwACNyKDa6us7a5hoLdz6Ny61l15TvFqbGTxQ8hkqrPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Det040grnyDfnlZUKpyoQJz/L8TYwONEUiW0Xew8MxbkR+BmpcEnysXbUmu?=
 =?us-ascii?Q?fQwyOKcH7j3drHyZ5VLRAXUebtByoacyhyKoLHqxgGyWQbnvINfMyPB+IfHL?=
 =?us-ascii?Q?g+NZG3rqiv118NRzx6Z+TOKa85iYfTN6MsFe06axCe9LetRAxjiALXNKjDiC?=
 =?us-ascii?Q?BxVRzip6dfI4AqfI2cE6tn35VyaXShG/c4KSABwTfgdwwCRGCGcgQ+qqjCe9?=
 =?us-ascii?Q?HrorvIyjQI4XDM7qBdeidUxfREdPwiHI8I+8xy9X5/IQh1+rdzDw7E5O1oW8?=
 =?us-ascii?Q?JAX6YziKHy9HrS7KKJ7e6xjcDj9iUDS5ElklcLs2mYQ0kJAS2kb9QvJueF6p?=
 =?us-ascii?Q?G3oMWVUVnNW3bn4WiqPi1idZBNCt+0J0ty8iGauycdvIReAErHv3EAn/716M?=
 =?us-ascii?Q?MlizpLi1x9hSjKZk38XjE87BTTuUGpy0Z96dpxXL4DN4EC3Nn7XF9vg/XSqB?=
 =?us-ascii?Q?fTKCt8CnzqU5t2u0EupjiGOzGfBaqVxB5lU6Cybe4udZfN8UuifAr2sfXIWx?=
 =?us-ascii?Q?XKM3l9aguW/2uCd/3Gqj+3rGN9kefj8/1N+b4l6eNdbXtW8UbtrvwVkGa1im?=
 =?us-ascii?Q?0CtLN23g4n5QzYGY2p3KyROqy3Gx9UsEngZpg0YFgbUiz9J4TQnft0jcvtcc?=
 =?us-ascii?Q?oxRyJDA0Uj8noWj+qkSGlOCWaiGi/4jcgraCVM+iT4HXP+0cd9NShVTp/P2W?=
 =?us-ascii?Q?vrzLpqFYfiIqZLJc+tAtspDBGPXSqxxySvCHb9DGD9T9yl+oa5Qye7m3+VeB?=
 =?us-ascii?Q?KwjnPgtAEh6pzuvnry9Qe1qWlPRDz7WdPF7DHHxr7u8uEI085s4XSBSpSMZo?=
 =?us-ascii?Q?3zVP5ts8epw4MldvxHGiUDyw5DxwfFzEGPdSJLRnRhdWum0Wb4qnPHbqdItm?=
 =?us-ascii?Q?OMF0LQxsR06mgD1NEF7SoyED7AWxMJv3UkW6kcJRYCrKXHQir2/DUYrxg7JU?=
 =?us-ascii?Q?eUPPeRfIB1eVxPH8dQ9vm0g/XmQ/iZwuxThhxgyfLN28T+dstNZm/PG8vVeO?=
 =?us-ascii?Q?AwF7hD+c6pCL7j+RKm2jBKG/6cwdCeOjIxFHenQHT7kp9JFdaRimx4wD/Rl2?=
 =?us-ascii?Q?4yJfRDLee+204f+FzZ27yTvNWnCzZJX1Fpw3naq1dgEqzPyMIuWqlnrFZBLB?=
 =?us-ascii?Q?wtAbnSQzhtoNH+L7c/VqWd7dkFN7kyz5gOIkWdEGNeQq2vNkfUMyD29wmoGX?=
 =?us-ascii?Q?Qzu35c7QQmuac2C4syNgM4SlhnIZ/Sdwa/OESY+HIahgC9qiI8O14tVB3CXY?=
 =?us-ascii?Q?79cQeGFVjKiTaiF96mclB8fGKiZOFg0n5zG1jz9oLLoq/T7l174k28Qvrwpv?=
 =?us-ascii?Q?mkKooUs28gIYia040pUAREe1XgCJxWJsw+8Sb8Ol7jzKLizOr6yEYzmRuNis?=
 =?us-ascii?Q?Mx1Wr0RKMxzXjH03Dq31RvOaWXlHkPtwULbgwlWybLpvgAyBHrSZtH//nU/w?=
 =?us-ascii?Q?v2HNPAoz/w563Lk7Bi2a+LCACyxpTb+GJp4sVIBEjp07/waGBqKUI72BaiNx?=
 =?us-ascii?Q?loi+kk2qcSDYFDG8caTzQUYEtclx9iqG5GLhfG5GKgLleuoJju8txupjVpHH?=
 =?us-ascii?Q?WobOhO6en87L8JuhEGxix3hwuaOPbj7HDbleO0k1hjpCK1rIUqfV3rAEHHtq?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cf4673-a371-4489-b7af-08dd12c7d098
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:52:36.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfTpUCVLPD9R3ZoItyhijJhFntCpOVxAyxlu4V+2FuqdQ7acYfl7NAqWdjsWiQCoK1j2VX3YFV0wxbMdE39Smw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027

On Sat, Nov 30, 2024 at 12:33:10PM +0100, Christian Marangi wrote:
> It seems real hardware requires some time to stabilize and actually
> works after an 'ip link up'. This is not the case for veth as everything
> is simulated but this is a requirement for real hardware to permit
> receiving packet.
> 
> Without this the very fist test for unicast always fails on real
> hardware. With the introduced sleep of one second after mc_route_prepare,
> the test corretly pass as the packet can correctly be delivered.

I think the analysis is not very convincing for the following reason.

To wait after "ip link up", setup_wait() calls setup_wait_dev_with_timeout()
which waits until "ip link show dev $dev up" reports 'state UP'.
This comes from IFLA_OPERSTATE, set by linkwatch.

I remember having this conversation with Danielle Ratson a few years ago:
https://lore.kernel.org/netdev/20210624151515.794224-1-danieller@nvidia.com/
but the bottom line should be that, since commit facd15dfd691 ("net:
core: synchronize link-watch when carrier is queried") AFAIU, an operstate
of UP really means that the net device is ready of passing traffic. Failure
to do so should be a device-side problem.

Then I thought that maybe tcpdump needs some time to set up its filters
on the receving net device. But tcpdump_start() already has "sleep 1" in it.
I admit, that was purely empirical and there's no guarantee that tcpdump
has finished setting up even after 1 second. If you increase it to 2,
does it also solve your problem?

Or do you really have to place the sleep call after the mc_route_prepare() calls,
and any earlier won't help? In that case, it isolates the sleeping
requirement to the multicast routes themselves?

