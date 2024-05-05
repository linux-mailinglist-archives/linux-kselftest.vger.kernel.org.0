Return-Path: <linux-kselftest+bounces-9493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7C68BC480
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 00:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C506B217AC
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 22:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335F13775D;
	Sun,  5 May 2024 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgpnvpL/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FF136E30;
	Sun,  5 May 2024 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948021; cv=fail; b=d0SYZXai8wsFzvT6Ze1ze4pXeB/U4Q3XocoBz6q+pWkKUT9yW5nFYNgtu0C6fMVMJVbFwogpgPaUux8A6TrCV0/oVp0DuxQhAP/4MEawg7IqyViG7l8RBSWJj8qA8PgASBCxIDIDWEWXFol+8XqYwTYUbzpsJxYeGSCXtOY0bhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948021; c=relaxed/simple;
	bh=YIDlVeUcX1hpo0ENcbSTwOgNMago87sLaHNRSrzpe78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CgV254XYvfTQ9QU+Pp3eVtwn6Yo7pqZ5pZ6b+AmYyo9mgQDhBJQvy/GMfMIJO/J1ly75FDAEgPp5EuClse5efaCXOgyAe2XiEMoxTcaMlLnsTlCitMx4LIV7+sTx2pFA+wn2yNzZIMIFq8HmQl5dIcyXOr/P8q6nNxT1gtk4mis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgpnvpL/; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUEbmV68KqYXYDhjqDvhqN/WNKUjsI5tydxyRSt6TgIBjfsVuH1dHwusXqIUzO55X9oOMEiLxrw1NGv1onwoiL9aEynWfJL5byBqmTIlPSBoXZ+JbBeVEcoTiN/UkK0E27eO8J+4SVqAx/UErtOM9mtsxQgGhTm1jJ3eKsaHTZ3rWOw839Q3rI1+0ACIQSfziyfsQv2BK/HOwZ+lHEgfvtvLoKzAc4YMMgxGOZTIXWnT3da7Xu8cYbJFGtacdtQRlSlBLUFYHBwsRql+uKB9uqCARijGF+V4lEC/LVZErivRGS8BRwFziy8HWfq7pr7PaoDkouJvihoe1FCln5EnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJFaU0fX6xsAABqscsOe9hOEw5DXjUg4rvL5JAjutjA=;
 b=Z8ZERVODRtexbnTOW2w90twebV+85Gc/cNQ1NiNig0c/0FQtVakjboobI1dWu7rvVyVtCbsNn3tChdsY2Q9cueuIFbjf0awQZSri6JdIkPvGHV3+lli9GW42OdDocihk5JJ8/KE2MXKBTNSVog04WdUXZvAI9l3eVSjj/s4XKsH5d4K4zXqjXX2fjGSaaChRKfeJVTblYn3ZIus5OH3hlTebRxOTH3Y1xIbSVz0E92F8FTE6vYAVfjxMUV7o/5k00BqkKBR3J/mu2FGc0hJnWldee+Nl8Uls/UjCFxDsCaOuSdHVez06aI2dF7cZw4VuCcw4d6ZNHHDrMbzBOCUIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJFaU0fX6xsAABqscsOe9hOEw5DXjUg4rvL5JAjutjA=;
 b=kgpnvpL/DA1+kuySK/09KFIbovfyBKGEFd9bt1R8jqdIZfEnKGUdGySSAeZZh5gvCXcE0+wQpz1+hjw7Ew2ciyfLgguJvuyNyhsQWjgWvh8S0y1MnC2mGdv6he12vi+0Qt0b2CUPXWpWSTLprPJWdGLn63ndzjo4krIyHOpgVWE2t/6KmFKvREYKqlBGUChTh5Rg2pwVS0U7Slfo4bhHuLVCCjCSl+JjRkHbPmIZb/eEzPA4yYMWDqdXQU5aW9zOaMnA31vfeWCfDXLW2spaWj+OMu/NUC5fiFr/wpo05K+8DrkWnR+PaK1dXp7KDC1yb/Yxf3qMjGiOH9p9sXHUWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 22:26:53 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 22:26:53 +0000
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
Subject: [PATCH 2/2] selftests/net: fix uninitialized variables
Date: Sun,  5 May 2024 15:26:39 -0700
Message-ID: <20240505222639.70317-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240505222639.70317-1-jhubbard@nvidia.com>
References: <20240505222639.70317-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: b94f5363-a362-4b80-c5c4-08dc6d52770a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2OavAG9Y17gAEX8zwo3tzyvSRVry9/4lIsEM6kTCQfgdgDZLcJkyta1E/Y6M?=
 =?us-ascii?Q?0nTQNJV7/ChKoEray2pJox5QnU9HPp2hdZjg8Uz/UY86zd7ilzX2KffM3uIB?=
 =?us-ascii?Q?7ytxJ6FJlAqU6KrSb00bAv4Lia1Pt96rNtDo2G/w5gTH8Gelzm+6E0OzdMzU?=
 =?us-ascii?Q?szTQ8fkVSDsEPINFttCO5+eI89YdTIkNriHTGjbhsHGozdqvMIEhyuJBdGnK?=
 =?us-ascii?Q?JLVpcibwQgYy7CLj4+YpezzIedidnnHVoPryNcXcWkrfgFjNPJ2IxY0PErQ/?=
 =?us-ascii?Q?fR7fuHDObO3qdwK/Pvrqph2YzN3OFOzuFEObuHGEICyGuGRca7TrjdJg72g3?=
 =?us-ascii?Q?K09j0YUPU9LjXVDw9vDRlR8P7nZT9CM/Ib03LfdZnbpIF7Vohi29KEIIq/wW?=
 =?us-ascii?Q?j6DH6i8sd+iCSv023neGWynmStoxHKr67Uedqb1jCF/RRgqxOuLB3btdhQ42?=
 =?us-ascii?Q?oLmruO1ZKHA6nanoRIOiMgfyw9VTC/h64ZpoZR8VCu5HCMoowRktD1oYF8c8?=
 =?us-ascii?Q?AJXiuMdp4+H8zZt0KIDghhKJ2NZlgBusRhEtEzPP1qrlZyG7+pS/kd0hRFx9?=
 =?us-ascii?Q?Yr4+EgmmR4JlAZjdV8ifO6gwEoHSbs5iUdQ7QBEmLnkwYgtEremu5P7Q2cuz?=
 =?us-ascii?Q?r3af3z3lsOzPgccOUaCYFv/Em28dXhxFwcXBRR39AkTl+QkS4w/sObIWiLHr?=
 =?us-ascii?Q?Ob/nzEOSFDWjec24Ji+QQ2Hvlcw1gkBmasgFLAo/BHmtykmqyYgZz1RBbCej?=
 =?us-ascii?Q?T7kNHSa74u78eof/FDSnQPpFPnN/Ib3KCF3reBjGZhVIIUTKdQhXA1iqyG6F?=
 =?us-ascii?Q?Bpa9VAjyu5Z7ciW+3YSGj2yWkoIPRywnHUcmw4ChcEMe+/9qD0D2yuos6VHa?=
 =?us-ascii?Q?Ia/SD8SSjggvbYn3HhRNv5WbXASmnd5fFXjiZLkjP0GW1657hT32DwDYjdPz?=
 =?us-ascii?Q?aOrkQRhGyIG8mW4GiNTNCUpLjl55GJsDFx8a+ekrOt0mzOO6y3bxV6ayjU3v?=
 =?us-ascii?Q?Zo+ycgac0jEe/TmdbOKBwMKx7tU6Oxp30O5eoZfDycs7TbF+mSJqlaDKdjc6?=
 =?us-ascii?Q?NQO59Jq+xj4x3/rNzJWDKLkjC4nuKSNBkfH4hOFXM6+dLEmiXny9xszWnO+f?=
 =?us-ascii?Q?0Enpo2NCL+r7hkB+sPl5uG3QMkSs2sw7qMnd7Sqf4J5liQqCk39vYw3aL6Pe?=
 =?us-ascii?Q?G/wO8V2zysHQveKxXOaPkJtXPNZfci+RO41F9ACTWZdOIJgdgRZIK7O2RAK4?=
 =?us-ascii?Q?gbrHCuyDMJUJ2+8zibzr7aX85FIZFjTk1km9GF3Yfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//lCP/aehVyyQezTpkiEsQ77cISxTTa7r2KVLjcxSZqiBKUkon7fuzAhMT6h?=
 =?us-ascii?Q?RLxE6O8lYkjFIr5zinmrrh4UZGMxF83U2vJ190YBbw5e7v9Q3Gw6An+B0n47?=
 =?us-ascii?Q?4HcyIB2zaYOYVL3V9lzIXJSWegPJ4Hie9O9Js0g/OKyuGSkoqyLfKELa+pVc?=
 =?us-ascii?Q?oz7yIeSLMuspcoI8lFNp7CJdqjgSfXcrb8/3ubguk4sYMB73rKdJ4GZmm2s1?=
 =?us-ascii?Q?0lqc9TK/Qft+9ojx/UZdCRTcdYDnLwUye/DZ5bGUyH4QoObHdmthtimvBlz7?=
 =?us-ascii?Q?6XIRTilIcFqF5n13EkW7LHQQ/2cisYXQXiyIetTSNTlWG+NCek9oid7MY+1E?=
 =?us-ascii?Q?Y59T8hw8E6VCo5G85yZu8wX/uImg6/KhS9Zq2ZHPm26K7zC/29rMKVbumZS9?=
 =?us-ascii?Q?phEEG2ztXnnejAWbCrN5FIv3FAfR7aXZFr4rWbe9ZOsiAlpKoFgjfH9zqK9c?=
 =?us-ascii?Q?KLVJJ4/n1r0NjL+xysf4zF9tjgNTrPOxXRjPcsm8OVEtA5plKFSCSAvcZvW6?=
 =?us-ascii?Q?+e56ATSk0BGXroHN4N6udrq7I2IMJqBIZKxcjFpOQy4T3BuF2Xf8zZzLdMPV?=
 =?us-ascii?Q?yd7suLbTsekzq1NIPK42HkQ3PzlmXY04ZMB7h12m1hNhiOLyqhYC8ILrKmJC?=
 =?us-ascii?Q?+tA4BhBFAs4RKwE4C06jMI8eT3kBk9ha1Sn746rAFe0/VPLFTzNzKC4Bl5vY?=
 =?us-ascii?Q?I87IsLdqxYtJ2ESiydjuZE7lTc7FtfUiRiagw97OOyUZK0OlUk565xXV+m54?=
 =?us-ascii?Q?rDzWZ2Js9fxf2k9rz3sdYzQQOyHW6rFi14XwXk4op0uI7NAaullUDlrpLYeG?=
 =?us-ascii?Q?8uwCnqLX7yCFUnkXBUBfe0vva8v5Oi6brOeYwu/5Ib4H3gCnYWZWaYJJM8tC?=
 =?us-ascii?Q?LdXTj2BaLtfcuURJhMxaRQIvMp8M0CSFNbhE4byUWh83xmrw9oBLNWhIK3vn?=
 =?us-ascii?Q?pXSnNavQGzCyjpJfnH5FKtvNtk3JrLGMT88Z7ahajZJGfd7JdXL/W5mFJSEC?=
 =?us-ascii?Q?hEeFUvyCfQOccel+M9+VVya/b5UBPL3NW+myPhmBAaQKqAiw3IEBBZtifZOj?=
 =?us-ascii?Q?FfTMit3IHJsMCrlRi81AmQP8NwYQhqBwmlNzVQNQcT+YlaZ9AJtti0VFv/2G?=
 =?us-ascii?Q?JZSfbqUF7HEGwHtZKVobN4XOGLmCV6iHiJ238I/qa5Swa2J+dt/YJyHNNQJR?=
 =?us-ascii?Q?FIvDl0d2Inikiibt8n4u7xYQ4SDmN0EBcXZLdvmbap7VZngEFKLBfpb79ZRI?=
 =?us-ascii?Q?rYZZQyqM3KNm+kzqRvHNBi5gHifQLvx/AcYRBIqm+wgxDKh4Gv9p0hXKIktw?=
 =?us-ascii?Q?EgyV5ehoOC5jXeQx4SXP3uw6AMDvSxysgjazGuRXti5lVGMjuKLyMeN9aHf4?=
 =?us-ascii?Q?cRsqCco77KXNtQmIH9L3GRJHd1d/U9q7nxfz5TAPA9OBqTZhnOAupD1TDScp?=
 =?us-ascii?Q?cFMyJTjlxOwxju2tkfdk4IErnp7VahxSBzjVEpCYtEfGcNsMyHHgFiBM/oz6?=
 =?us-ascii?Q?80OYYfq90Xla7w1s60v6+7GOsa1aYtzfPIPNkv60ZCvmEN1uit6/a0hLdNs6?=
 =?us-ascii?Q?X/zp+MfTYzhIW6EdJIVTEwJRnzdpdrCGKSDz6t7EoRqWKXHKKdYYJukDuUD+?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94f5363-a362-4b80-c5c4-08dc6d52770a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 22:26:53.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a06CbJcNcMRNi+W+xpdXAIbhbLvp9iBDHlnLDxtMxpFajFT4804Lfqz0eo3U95pxmqVRI97SlDnuRJ5Ky3FAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about three variables that are not initialized in all
cases:

1) The opt_ipproto_off variable is used uninitialized if "testname" is
not "ip". This seems like an actual bug.

2) The addr_len is used uninitialized, but only in the assert case,
   which bails out, so this is harmless.

3) The family variable in add_listener() is only used uninitialized in
   the error case (neither IPv4 nor IPv6 is specified), so it's also
   harmless.

Fix by initializing each variable.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/net/gro.c                 | 3 ++-
 tools/testing/selftests/net/ip_local_port_range.c | 2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 353e1e867fbb..0eb61edaad83 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -110,7 +110,8 @@ static void setup_sock_filter(int fd)
 	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
 	const int ethproto_off = offsetof(struct ethhdr, h_proto);
 	int optlen = 0;
-	int ipproto_off, opt_ipproto_off;
+	int ipproto_off;
+	int opt_ipproto_off = 0;
 	int next_off;
 
 	if (proto == PF_INET)
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
-- 
2.45.0


