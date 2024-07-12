Return-Path: <linux-kselftest+bounces-13701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F0493027B
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 01:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAE61C20C07
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 23:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4D613210F;
	Fri, 12 Jul 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6+wL2YA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1917130486;
	Fri, 12 Jul 2024 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828318; cv=fail; b=c+ibP8eMoJI9cnJfJ04JLFAyhg5g3et5E5qQsm9yLJc94QfgE5N0u3DqxUDl8me1xN5IVEQw2V8R6QSYiKuy/qsIBmfN2TY/TI5SxI4nZVWR+xxxzmtMTmeCvejgUSBv/STZefVW825kXEDUkJEeZHOtvZ3IWaUJFRDPrDox2CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828318; c=relaxed/simple;
	bh=MQfwpW6IuVz8feSLcHMhQyS1igJwufD8NJb6Y9ZIBPM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bkgfq7U3qHua8sme1n0vUB8nyXa/LR61zWAvb9Lio8rzCvZKNJEaxjyY2OBgWFP4dR7/53x7W50Ix5g3hR94b7W2xs89BAxm89L+AkQyYSzpmtPw3mosIk9qMN9sg3653KY0l8xF3zVXCr2BuphMmOChB0WJOtkBltPTlU9+dxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6+wL2YA; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7BrbZSC+yfgjx+6aqRMeZXKKFIax1wvQG0zO+L/d7Ff0F39UIK8GqHt1JQingw0Qb5fHxOJ/rK7m9D8m/Um9xPXIr9T98Mf7OUm1seWRAIDf3IqAIMhd2TXQMKCOkbxGppt7Tk06lbPQUu3jFR+6fpqMgkEhzVI7nmDHEOLvq8FmzOEXnKnAsHeh5CkOZ/nhzIx7znMdj6PWWzvFkmonXbBFlMUYonQFmUWtqj3sfRTFDBvX9NvrSqgk7vRLhNqlK21i6t/+7asuXduA8eedHFD2qqBVi0CWi+EHUVi2xF1C/zzmqcaYF5SyTFqt3LJEOm715+35RX28DAqz8KA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6uPOmsFnTozwA1+FBGn+hiYp1e3A88XxbEQu+a7bC8=;
 b=WNQxL9+r/w5GaM5jj7LsPYfy5dWbblGwwXuVSg3J5tonl7pjfBtxImZGKBWsuu9nbmv2Z7DGVHachUnRnB759e80gBqti73tbc3HavSRrj7VdJ6pv7SqwE7z7mdIhkTQd5dLILnGeSprUcGFX63BjvM3sBo3+Ny4uUFe4jYNT+hxiYtT7+xFKsOJuf0gzbNf2RzbEVrfWPYpd7bsS7bAiWkHD/vOh2e0FB+e/gmu83Idb7yWGt0B+b65F8YQauQQHatUhrfMcrB7L4hMQA6oOjoptCtj0WJwLJSsUkLX5cqarBR3I3QZLWG+c8wbuwLDHq2bBnZaDdQkYCCRwynzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6uPOmsFnTozwA1+FBGn+hiYp1e3A88XxbEQu+a7bC8=;
 b=h6+wL2YAK+78FCGcKOqoNhYJ5Yi0+7npD1C6pCKc/Gd8KQkQq5/qlb02msbm2NszdeE84wDE9hSetJCxec47EV5Ac6Ksl/Z7tH+fZS6qLxE6qlFkR5CPXaskMLvFagpvdab+16cgVAxnVZIX1OD+kjCLcZVVDR32rChe+dxeQi8s+hZr53UCdZ4gkZw5yZYvNNSBYy/B/DRce53i7bBetC0Hoy2EL6ZSFhHaagNmbZm9e6WbOddN+dAMvezkqA2tdZooWp53qKe9W1k+OpwM3OgUH8TO2Wd4r+iGUUJJPrplkD8sdxeNFvuqjS90dk1U9JCtZ27+uqsPC8zffh5TJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 23:51:53 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%2]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 23:51:53 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
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
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	stable@vger.kernel.org,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH] selftests/net: fix gro.c compilation failure due to non-existent opt_ipproto_off
Date: Fri, 12 Jul 2024 16:51:50 -0700
Message-ID: <20240712235150.99175-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd68417-cbb9-4edf-abf4-08dca2cd9acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BuiszWAsB/zQ1q3D/bPbvXPmyZqJB88Tbpa6PLbv6QbE94zidvespP4JRJjQ?=
 =?us-ascii?Q?DMlfBnq1twxPn/E+wNG36FZWgaiOUqMQh+pPfqS86D4KpvB839WL30PeVkPv?=
 =?us-ascii?Q?3lrO7OZg8V0SepJafmOEhmcIYKxNZ3p47xpVq5HBlDsbOYGhROefNU66/fMh?=
 =?us-ascii?Q?P/fMvuY8kKl2FTJWZ6UItPLaCjm0x2xmOHqjEjzfauoaY0LvxCLEoJHCitfE?=
 =?us-ascii?Q?MLdmfD6VFi/jsk+1GCMrdBvou5iKUO2cS1CJKfwLa1MAhIREPGsG0xBEwDer?=
 =?us-ascii?Q?2O/y+7zlGDuueEYpE/zoeHVJrBrXq+qR7wef8NUxGk/KeCS5tPJ4KcyNSuQ1?=
 =?us-ascii?Q?ULQt9Lz3bL/+WnkPQUbzBWFNCzt2TKIQ/MX0og6QltDaxDmf+OCz6UTOnMOr?=
 =?us-ascii?Q?9hJsJKyg7INZ4TV18DeFZ/y0UvI9/iZMyqKRUrRLJl5wiqt8ZV592e1m/qri?=
 =?us-ascii?Q?p6hBtxe7m2jva8RE9rQQ6GD1P60xH7cCrbiTmTL71BP4uRsumi0DLX8d+dok?=
 =?us-ascii?Q?iVZe2IawdRpQXy+OGhApZqr1HyqEeUmgvGUcD8vKj2ftXxhFATOOINYo2rpw?=
 =?us-ascii?Q?CmUuONJtwznPsKxYusxzn8JROQGBsdW4u2PS98FS2Oqa95Ng8a0KZsH/80Us?=
 =?us-ascii?Q?ssXuOpervLSGSmN3ieZzKwsPjzUpiTD3bqlfWfJtsEpL9nBxYmPP+yS/fCFg?=
 =?us-ascii?Q?xOG8l9UB2lqdXY+N7VF+boA4WJZD/EVQDRXzZNsZhaMX0XB/xzIVSMW1P0kY?=
 =?us-ascii?Q?cSWSNCSuAGj2SUGFFE1hjiRnEipnPx5nUQy8O3HpxHCNbJ+gDExWW9MlUfzF?=
 =?us-ascii?Q?slDBrG+OHesIuxyb6wZN3kagoYgJDnjFBI1uskuBviJPLCireFWCQzZt3SZJ?=
 =?us-ascii?Q?4ExRSrW1Bdd2sSlgo9mHm9/f7yLNoSmwfyKvZXZa3WEa5zN68AsoZUVxeeWS?=
 =?us-ascii?Q?memmOM4lL7K2ti42nZLUKqf3uJ2P9dh1Pz1MFksrTe3vmPCxLDM9+kRnbZuH?=
 =?us-ascii?Q?1xZO63/NJJ7EqrzpZlrLYzQoVCCHZ9CHA+wiFQ6Y67IgNrtGraSKv1CiFOdu?=
 =?us-ascii?Q?AoWIBwzcHn5ifSdf/k94vXxt+jNjdAtTJAPuSAhDExKjLBu5PufImKDpLgQ3?=
 =?us-ascii?Q?4XAwZix67iiYY9ND72PCwYe6ZeU5BHdUpfmEVKL4jlLpJgQUgdPPmaCaOLHd?=
 =?us-ascii?Q?QWEPB5BVX6vSaweITHT2k4aK4oPO6ay9JSWGJh2sm06WQVmZWPANwjGE8G/K?=
 =?us-ascii?Q?Rc0Ir1pvIgHNbxFVS6tvTSFWRds1FINhQAR/YSjp6ue5pnUXibdP8zoU6z9Y?=
 =?us-ascii?Q?jqNzX3VvDH3eN4PSoe15mCj57xLtQahezJxKP7iuig4pYz7oPog1eIUOS4zD?=
 =?us-ascii?Q?ySQbM4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJR7ZY4Q0mLRsAOMQAIWK0pTctXkG2DpF0o0p9hdRFNOhDci5Sn7vRn873Eq?=
 =?us-ascii?Q?I9QaVXfBCCyJdlVeEn4V5oZiuvclKN7YPtuAaDaXeO5PHtIZ0VZKqEuXz1g8?=
 =?us-ascii?Q?KQS63XLD4QQam3EWivMaVoWRcmRYeMEvWgTg5Ho3g15I61GGsTrgOha1psWs?=
 =?us-ascii?Q?o3Ma9/9DFxYm8h6KiF/p0howaFx0ByjTd8JIykTyJzUdyxufxcKsQ+FOyDNl?=
 =?us-ascii?Q?yirSs+93tHMAcSJD3UUkpoBEsgGuJeNfkP9aFycaWi6vWnjbEj2xpxFzg7hG?=
 =?us-ascii?Q?2h4n0N2zLR53y3fNp57x35lLnJnMSC4/JTs61qUjb4GxsbOl5T8lS7ITedfD?=
 =?us-ascii?Q?H5FaD7Op8IKKPRuSNlvzS3+ECdcbjeVYeH0OdoLUrCiQzaiSfXGcHy0ZbZLz?=
 =?us-ascii?Q?P0wNo4CHIQJVgGTZhndhHb+Eb9gv/u3UXZFgHpR6mUpYwaGXGOVmiL5esNPM?=
 =?us-ascii?Q?HRS5B85PuqFwjc/4sL6phXGrkslWnUyegZBcKhgHl0aQJ0qNNm7V4KZ/WquA?=
 =?us-ascii?Q?I5YXFePNi0A0Hn35pqXkomi0dwn+He//yndOrdJ0KFyalUmWMEsSiNjNv6qD?=
 =?us-ascii?Q?anI4VoPqRDI7hQ4qzpETGYCAcLevq/L0Yhc0mwgojNDwRXh76pcG2mET1IyV?=
 =?us-ascii?Q?tMunOoAz9YZ64Dva7JuJqCJZYRU7BFbbEwuDWOmUqUDA7tMDtwyzPx1FmOMF?=
 =?us-ascii?Q?XlSrASyiLC+gRPz3geSYdJUPlTKamLmInAiuR/1rLR3Hk8NjucAtf7n/yUQL?=
 =?us-ascii?Q?5QbSAXKgC984M6ZVxFcaZtWt3j4AEPRaehNK6grvSMv7h8B1rXUiBE6vH/ol?=
 =?us-ascii?Q?gtF4LDesEfV7RR9vbF8wE8kNCSr02POT8AGXfyx2J8y7FMtJdxIDZutQkDor?=
 =?us-ascii?Q?ajODEXtHfQeDkNHbkwKNZU/eNQK0ZYtR6lmLGSMOLm2rRAmk8K38TUr80sNS?=
 =?us-ascii?Q?J8oOiTaeF7DJseg5Fgb+aIJHeWsuA0D8hi+9bRt3oawWrS9xHNPhzat4p5Lg?=
 =?us-ascii?Q?jchTeUUR7M7lQZuzxvGF9TLb+iJMzIGsSPZLYrgQZqNFKHU28xpGtcwC4hO5?=
 =?us-ascii?Q?+2TUSbAY4q1QOnY9IMpwjcKxdPouoWAL9BCcXkzzoC7C1l7QGtQdY+/L2YWY?=
 =?us-ascii?Q?b0T6W5eE8l5m1F5pbrR68YbpBvA1QfOCuBgLEuKED1YkUyOpLnAgEOM0J4LB?=
 =?us-ascii?Q?sCPkgtXOblw75+C3Z/5PVTZryHMc25kgLvlfOrGLMS8bpe8zXp5SKAq1xDz+?=
 =?us-ascii?Q?xBb+EIzpIGqs8zTXxgc89gHlctHZRqz/CQcTE8YeDeO7QQt6zeKZiyNTm+vL?=
 =?us-ascii?Q?DkaPGaMLamNoigiUNRL2a+2xLfeRtMNn0ISaX5XVsnlJcTGGCVxKymD9tGiH?=
 =?us-ascii?Q?uJPVbpy2gRfONiDpctsgXQazOyA47RFjoLiJlmOksTp4enQvS5aII94ChMtI?=
 =?us-ascii?Q?BkQPg45iP4s4I8+lhNJyrWTodOxj4NdIIhRmDv9MCD79DJsQnl/SPyP7TWlY?=
 =?us-ascii?Q?FhHkNnbxfdm5bI8svP2IZP/w317fQK+kbPR4SKJnyG2seVsK68b4pCzhR7Bj?=
 =?us-ascii?Q?PyWV0iNZSKWFYlsKqKjhRyntdAPvQvMg7C0NK7Sm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd68417-cbb9-4edf-abf4-08dca2cd9acd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 23:51:53.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJ1JN8s+a3eknzIZtyJpbPVNCwWmiqjwD5XGA3q9krkzapSXz4Ns3cCB7avFECv3sD1B9N+nrliNN4tXxIOPXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247

Linux 6.6 does not have an opt_ipproto_off variable in gro.c at all (it
was added in later kernel versions), so attempting to initialize one
breaks the build.

Fixes: c80d53c484e8 ("selftests/net: fix uninitialized variables")
Cc: <stable@vger.kernel.org> # 6.6
Reported-by: Ignat Korchagin <ignat@cloudflare.com>
Closes: https://lore.kernel.org/all/8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com/#t
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/net/gro.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index b204df4f3332..30024d0ed373 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -113,9 +113,6 @@ static void setup_sock_filter(int fd)
 		next_off = offsetof(struct ipv6hdr, nexthdr);
 	ipproto_off = ETH_HLEN + next_off;
 
-	/* Overridden later if exthdrs are used: */
-	opt_ipproto_off = ipproto_off;
-
 	if (strcmp(testname, "ip") == 0) {
 		if (proto == PF_INET)
 			optlen = sizeof(struct ip_timestamp);

base-commit: 2ced7518a03d002284999ed8336ffac462a358ec
-- 
2.45.2


