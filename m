Return-Path: <linux-kselftest+bounces-9553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B98BD517
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBAB1C20E96
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7C158DC5;
	Mon,  6 May 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6PADBHC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B7158DB0;
	Mon,  6 May 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022144; cv=fail; b=SD3NdWsNu55OEVsS9beS15YvoYaXCVKHRwaOrROUTalfulaHVVRxXEg5BybagvvZNizRpdbOZHZE7im9DDTnLw3yzIAdSHhNh3svEbDiR8iNV0di7bW0F0QFjhGy7eoY7cnJ+bS68+xzM3B/n9cHYo6jaghvRgkht65nxtVqBJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022144; c=relaxed/simple;
	bh=D6Y0YBQ3003El4EDgEpOTTWJKcePHE4KIGyNWtfE4y8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lZVzkFEL8aO6/AJRBDoJXhHIFi4e3uUGozn0RVc/r1MFbpd68Wib7B74tHpIToxyLbTlIDoEYGbxQ3K20Nuye45vPvBG+79WQ0ac3GQHe66bmTSMz/1GNDA0lRVCYgcyzKFOQW07cdPYN6BQeWU0UAopt7FXdHj8g96EjxFUmJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6PADBHC; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2HaYNYTejmBNh5CFyI1++QsZbfOohRDVEyfC8lC0bNzlO4FzONKg6Rwy1cBsdpqY1ZOHZqbtr5/mXsPuXGmc51JHGENt8eCG5CY7LC0O+Uo44/a0LyXEZTxFBxzYlHyTmygXbBPizWxkG+6o9UjFLGTJJ6FooLPya2ZTQo37EwLc1nSaFpJjLsMEz3PDojmFDTJ1n4VYwgzbbly+zGO39HCXcRivk9rsLFB0Eo2Ne5itoL3OVbThnsuy8yJ9Y+Mcum3KPwrcC0WJ3kaJBr0HcHgX3sFmakzX++jfVCigRIcC4IAp+a9bbg5msbyXTYdx+KF1Ik7apRrhL5uIJMI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vq0M87NzhO/Rv4P5a1urdnmGSGGLoAXkZGrXTiy37b8=;
 b=n607H3mRcwrHA440j6iEGvm8axnCovDTkTRVLaD4f211DBIqZV+vhW5BuY6F4kx5RfE5HbZn2hnQ/NFPDZEIRxJr4L+lQk0g8oDGxT4/+SZ686HOEAjJ7/yYoIbeR+2rK/V8tuEGSrAK0Hq3x+vAMbmQa+VgDQZKwffWVfb9xGZ8e9sNNuyhC9XZmrng8QVSA+GPWyoU3E9qbOLmymsuVzvje6UsIW+F18uCuvOsJM9Gxl2P8FRextbJTdpU9xeFXgs9aGCCG+BQcciosMEhzBV2aMD04qQ7rctaW/baYeFFRL0Yjw8obmRa44l5ApBv/WW1tG7xmFksuv+kTnkuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq0M87NzhO/Rv4P5a1urdnmGSGGLoAXkZGrXTiy37b8=;
 b=r6PADBHC/+vDr01UdqmuCp2GDZhcEAngn7k6El3B6StZLJcgCiva25eTUlHlE1hbKsXQyrV13pnftrxKHTD9zSTkNusCZ4cFyPVAaz4WZgpVwkzwWD1FCLr2xNpMDtuJnlc7Ns+dhPwTeJgCfBYs19tMzHdJ3CiCCfIS2LjugO4aD5rkCPzlRCkCys3P8Ci/o9B/USpH0tS8i3dIPn/AeYBHGC2KAZOajROtGjXkLl+/6YONM4tFgWDyrtr16GtU9ulD10x6N3yXknl9NQtuO7XQQa9UleAO4H9Ias8/EeL2WDNCEZS9t+RLYHktZT/TbOWgsPiMeLwTQ3cPFG6ANQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 19:02:15 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:02:15 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	zhujun2 <zhujun2@cmss.chinamobile.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	mptcp@lists.linux.dev,
	dev@openvswitch.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] selftests/net: fix uninitialized variables
Date: Mon,  6 May 2024 12:02:04 -0700
Message-ID: <20240506190204.28497-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: ee76813a-3484-4c53-d19d-08dc6dff0b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhTRhNKXsoJ9JejY1P9hcabykamE0dREZkBbjsSIMP62T6sfBtBz4pi9A4Wg?=
 =?us-ascii?Q?TIaarkw/5Y4HM2fMyfq9cAE0D8d7ZmXYIp9kOJ4wXYHAwjo9P2YUpoeSS1wt?=
 =?us-ascii?Q?FnIza+badBf7ep3zO8iQkpwDq4ZV196YnsZbGxcA/W08SsZ2sbeFwoXbQvkm?=
 =?us-ascii?Q?i4yHey0tTuzwsd1s4CWLb0cq0zdCLUZQ8DmY4cV4SGGYSyCc3YH+TKKZLBx4?=
 =?us-ascii?Q?YGVgoWR1PR3XPiGCkf+iDJRp5tviuvVn96MnLyBDlilU75TOjIQqAgVTRmoZ?=
 =?us-ascii?Q?m3pkfLzIhJY2+33k8WSbJMcSre/DwQJgVuRYHO+YTKFNwDgUHNk8617G29oq?=
 =?us-ascii?Q?b89L59dPBRMdm8hweUMWN/b5Ragcna3I1HDwaRo7+rYegPkRsbR4xMCEdwUq?=
 =?us-ascii?Q?ZqY2pbCJlnzOdoJAtQengyMHaAG8vpqob6n7dqkxhE3yAayq6MEHJmf2hdM7?=
 =?us-ascii?Q?0/GO3SJ5NEeEnWroitpFey05oPJB16wm2ubNoJY/Bipajfvzuju9BkTjLgMu?=
 =?us-ascii?Q?UPgFHpadpLteEbCDmrHS2d39C0S8utfQyrB+uSFtIJQFTMKQ6LA0ZLb+pKpR?=
 =?us-ascii?Q?rZqkM8kok2a4RwCNDIBWD1VXO6W9dO5sAzB8WxrvQlutv6Fxwm32jVsImzgc?=
 =?us-ascii?Q?WIvbnIN+m7JhD3CAHK620eLb9Xt/7XzXbAjlUOlHjRmdlOZSu07gd7VhYVtx?=
 =?us-ascii?Q?SkVc0justT3al5U7+bDiP+XxuNEcsxRYP7wK6I0WEaSiwkjfPkTOqP2KXZYO?=
 =?us-ascii?Q?JHgOWKYMZFawG0rAbtcrH0+xlg9SVvY6BkbwYbRZBKMOGjypROeqTDlmwaj4?=
 =?us-ascii?Q?VzmRXSY1AA7YIFr4/Mz6m6+Emrn1Wy+jns6wrZ/0JYfk0EDH5YPWw2GRXNqD?=
 =?us-ascii?Q?UNu7VEyFdOaXye4FnE8I66BbHViKn7mq4Ur4lNVC2DFDs0si0M8WizsoIcSE?=
 =?us-ascii?Q?AQ6vyKOReLuR3UjBL9/Q0VqJ3vmlBrHv1Yu91GvXh6PoB6MEoBdTGRq/ZUG2?=
 =?us-ascii?Q?GON7QGJ1rp8//XouvIjHambSd0cVR0sPl7FH80dr7hWnn7e2c2oSZkZ2qd2F?=
 =?us-ascii?Q?v40lG5lMzOs7YsmlRDW5fREdLe9UqpH80FupEuKb4aEeaXB/P9SOt8jQEpzY?=
 =?us-ascii?Q?krgIpHkRP3bAxO6/K8cjfVLb5WuQYnZk+CIQync1tzBpPmo42qbEWiR/euPa?=
 =?us-ascii?Q?/m0OZehUkZa1GkSOo/bOqI+J8ESgl+mp5Cs+jM4DLZIBPmQWEXzuNP0x2jRs?=
 =?us-ascii?Q?jG+59JFZ1rZk4cK9A/EXstKFM6aQgDjASF+JE7dC/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qzpRpBfjibkMgWeT74gnfFe/NRMdmYmkSmEJOl0DundnIw7JPekEpy7HtWge?=
 =?us-ascii?Q?kSntY/R4sqW8PqMBpk2eQv7olZjTGjACfPtFKw08shmBgGkKOlPhf0NaSB3h?=
 =?us-ascii?Q?DDSH/36hyvCL4CNdLBY+V+l5zCCQOFhOLs3xeOu2PR5/AEh5NC/XvSE7Ysn/?=
 =?us-ascii?Q?lspcfwnN1LAZtXedaQv8OuW1Iwwpi/VEbKXBnvR0S9JmhmME5fN0XMt746O3?=
 =?us-ascii?Q?eUyC30Z8Hdk4PRRAGnveHdBqPBop7MwTDNWfxZoFZ9MA93HQOjOoepxAQoJz?=
 =?us-ascii?Q?d5Q1KdxdHSXtfT6WJRO0eUVXUbI/+NCPNj6TtcvsRlzA5jl1iZYrgrLXmQvy?=
 =?us-ascii?Q?93KnNGMibJUmI9fhKiD8Zqmnt2dywAcxHa8F3TADj0SV7LIqX6WXh3+kySHn?=
 =?us-ascii?Q?dnGfgIX0J8gXPxu2gR0GXlSXJXivtrU3zc7H0t/aMPiCDfrR3WpzBQ7E/DgD?=
 =?us-ascii?Q?+4OcRU0b92RhhAu2UY9AO+4ln2Q5aFlQ9mo6B3zGqTwYoB1kURGULxmtw0Fg?=
 =?us-ascii?Q?UEPiMZSNpwfspbJ3ZbeipPrwejhGvQ0dgJ858LqfyDBtDYy9xjgIMzHLXY0Z?=
 =?us-ascii?Q?eBpvhJ2LDyzYIoj0kRB163Fef9nwPa5kic+88gB/drrbQR0V+7OrpyQEfvnx?=
 =?us-ascii?Q?UIu/TA+sVmq0SN78jibV/zrSULhW19QaTz93grc4pyEfT2Ve15KgpqM7wUW8?=
 =?us-ascii?Q?iF5HacHUXJVJbqB90x00KECIrBiA49ozKQs3Wmq5UqHlO+36jV40lFjNJX/A?=
 =?us-ascii?Q?1053Y96Trmb7CjoIWgd7qh+OLE0q2U7ixHP9ytTg4UamWisyX/S5QJ1lz5ap?=
 =?us-ascii?Q?oY1dCZ+9P7m252Id6uVR4ISoj2QjXktW/eOUpxV5lwKAUNhN+k216E2gkUJ0?=
 =?us-ascii?Q?kCaNMGMQ4ikgVJpFtdfF45HBBwwftGf4SG7RLQl7iW5YMEHCyNPhClI0j46Y?=
 =?us-ascii?Q?soZZTUK1mL2pJWqJNlLI9nyB6DQiPAUN3O3u32YMkEl0YJtlagSImfhijtVm?=
 =?us-ascii?Q?D0GHqW3nEBRnx4rZ6Kzxd/wxqGxuqRzEs8TRjvtS18Ys+JBXRX3vHJrqiZGy?=
 =?us-ascii?Q?7TJvw4EXbXwnFuaS0NvizAYfFtn8wxtvF5HDK07nAZQl/sJ09KcY/ex5g4RH?=
 =?us-ascii?Q?KZ3YRqZIwQCj/mCjzPAzxuIF/XOSLDvBDQPqW137A3DKbKCfD+uIcPM3DgOU?=
 =?us-ascii?Q?L5r3Z0oLYakbIDw+/5nvieYdfEbooAgGlM0shSSFohIxs1q3jITQDJe4ypW6?=
 =?us-ascii?Q?hxWQw23CTJ1HVJiQhApOxR8APRcgtt1a6yxM55MrIf+J7zW44sXBogBo/L+i?=
 =?us-ascii?Q?Ry6Etf4c7VcFhYxy5QndCzXr+FAqy+VW8xenlg4pG/3dzNph0BsZn6bv6nK8?=
 =?us-ascii?Q?vq+CqqQkgg5BHrHPSc0NmyYxqlCsPm6kIeJJsHzlpOVfbjC9MlBLscpYhJ9n?=
 =?us-ascii?Q?DW0fJ0l1uc9273No4ojwSmBzUe0iHuqEBiqMuHBag6kJM8KNC1BtFin4jGGF?=
 =?us-ascii?Q?L8M6wLWS22vICHEqpLuRU/uxQ60Dj3+ZTKMnHquo+a1K/6YI0vB1uOEgP5OD?=
 =?us-ascii?Q?6UN0DC9+BuM31ate6v/WpepkWbpGbljEw1HpUEnNXx51DUJBA6Lakjm4Uri3?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee76813a-3484-4c53-d19d-08dc6dff0b21
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:02:15.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzddJ/OmsmtsPK4ktt4UchpGnqhTYrOfPRYB++pLQeg5cwVYqb3tCY6ntPdPo6t31fIE8ki0lA6NJPIPtrRWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about three variables that are not initialized in all
cases:

1) The opt_ipproto_off variable is used uninitialized if "testname" is
not "ip". Willem de Bruijn pointed out that this is an actual bug, and
suggested the fix that I'm using here (thanks!).

2) The addr_len is used uninitialized, but only in the assert case,
   which bails out, so this is harmless.

3) The family variable in add_listener() is only used uninitialized in
   the error case (neither IPv4 nor IPv6 is specified), so it's also
   harmless.

Fix by initializing each variable.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/net/gro.c                 | 3 +++
 tools/testing/selftests/net/ip_local_port_range.c | 2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 353e1e867fbb..6038b96ecee8 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -119,6 +119,9 @@ static void setup_sock_filter(int fd)
 		next_off = offsetof(struct ipv6hdr, nexthdr);
 	ipproto_off = ETH_HLEN + next_off;
 
+	/* Overridden later if exthdrs are used: */
+	opt_ipproto_off = ipproto_off;
+
 	if (strcmp(testname, "ip") == 0) {
 		if (proto == PF_INET)
 			optlen = sizeof(struct ip_timestamp);
diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 193b82745fd8..29451d2244b7 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -359,7 +359,7 @@ TEST_F(ip_local_port_range, late_bind)
 		struct sockaddr_in v4;
 		struct sockaddr_in6 v6;
 	} addr;
-	socklen_t addr_len;
+	socklen_t addr_len = 0;
 	const int one = 1;
 	int fd, err;
 	__u32 range;
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 7426a2cbd4a0..7ad5a59adff2 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -1276,7 +1276,7 @@ int add_listener(int argc, char *argv[])
 	struct sockaddr_storage addr;
 	struct sockaddr_in6 *a6;
 	struct sockaddr_in *a4;
-	u_int16_t family;
+	u_int16_t family = AF_UNSPEC;
 	int enable = 1;
 	int sock;
 	int err;

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
prerequisite-patch-id: e81ae5ca6c427dde802acd4c1442c82e170c251a
-- 
2.45.0


