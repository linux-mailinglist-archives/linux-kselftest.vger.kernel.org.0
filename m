Return-Path: <linux-kselftest+bounces-48016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB5CEA200
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 17:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591E130056D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336312E0401;
	Tue, 30 Dec 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="3TLWBP7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster3-host3-snip4-10.eps.apple.com [57.103.77.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EE2264D5
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110621; cv=none; b=ecQXlC5Awsvkcnz7gRto+vZEH7hLVvilGOEyheg6li5w5C2+PgdpSPw2OK6vBkYLrZv+kkcU5JO3MUpFvS55LmsGAe+F0vjbdqmdmg2q/nG5bD+s1CVAzoqbeDeSvgTouAr20rf8yzmDuuYrZa1Hq9NqIAVUONIX4/lRbENHkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110621; c=relaxed/simple;
	bh=jZ5wrB73KdrvQzKfloURZ+MtB++6n2OMN0nUcYwqCy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEYwYsnMJCe8tXwvg4j9McM8ez6kOkshKe8DKYfeWKVtOTm+B5vU8up+lz22gfPTl1b5hA44cGjDQhe9P+uk6jNRnvtwhJg9w+VqTaHP+oRb+mrs5oMii9S3VNt9pJcU6f8KaPbAC8aj8fBAIJwfgQJ9sWHMym8nFkz+OThOioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=3TLWBP7H reason="key not found in DNS"; arc=none smtp.client-ip=57.103.77.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id 716DA1800BCC;
	Tue, 30 Dec 2025 16:03:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=ozeBeREBzR3JOVi2UxPUVOx3sVJ2H7KJAHTuW3q9vZ0=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=3TLWBP7HGvqbIDZMRylEHCMVA5UXVz5QI1o0KUmtLZS1cVf+UV9msiwlRtLgFaghEDN0Q/ngZx1T49feXA43p0vlBlwGoOcKQpctYvk9TYEQH95SAz1Cc7ZEQJZaCfafQtZLa11TsARdVt7zGEZ97gVZSuP8Rxd9lPD163rp1Fd7DLvjObtnNXiA/7e7nXL+ODJVs8JUkwdF7nrXCPfK4YzS7hT4qJG262XP7yAqRb0f6wTFNlo26ni8KJ6/fJY9IDcvQR9mLZSe6Gm45coxb7XketNFbqlCOTcIcPBavdndriUjnh/G8dzl0xSdLMq4ZuNH9KVGelFmK/CucOPCEQ==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id 2E16F1800BC6;
	Tue, 30 Dec 2025 16:03:36 +0000 (UTC)
From: yk@y-koj.net
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Yohei Kojima <yk@y-koj.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/2] net: netdevsim: fix inconsistent carrier state after link/unlink
Date: Wed, 31 Dec 2025 01:03:28 +0900
Message-ID: <cover.1767108538.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Huh26dr2RGitJIM98C2ZoLyHpuzFh53D
X-Proofpoint-ORIG-GUID: Huh26dr2RGitJIM98C2ZoLyHpuzFh53D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE0NSBTYWx0ZWRfXxsml2XQtfkHW
 YO9ksQ5rOnBibJpzmG8pZmOuyrOskx/s2+EsapkqUMjguXxCtDpuU3C9Lsi+Oc6qcBQXBCGmTLB
 hcPl4dT1rhSIjW7G6SFOphu29pFx68rHNLMj0qLDGGjdjt+yLw2RvSkusWQWLU3y2QgLdEG0QzH
 qxt3VbLAgMzw85NkOC2Qw8sY3lg9s1Upuv1JyNjg596D/oXYk3KzFLxsFOyySc+rI+RlHBnJGNR
 pCKKopBqahkQ9KceclQYX3G4r138h3g5Zn1VmHisrc2PyRIihkMyqnLM2PdbsTmaFa88JnpS4Dy
 Q9LDAS6UUlxIL/Xx1Wz
X-Authority-Info: v=2.4 cv=eeMwvrEH c=1 sm=1 tr=0 ts=6953f7da cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8
 a=7r5JYaH8yVXzpy3mEmcA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_02,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxlogscore=840 bulkscore=0 adultscore=0 clxscore=1030
 phishscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512300145
X-JNJ: AAAAAAAB+/gZoBu8u0f/6IECSBQDulEFBV3bqj36pDUZVy7wVvfI2V9VPF8IT8kYheh6CAHgt/YCT38XpMb6kbuFvWo07TtUanqjqqpArrBIO9BPNJLxx5jFJoXJsFAni03oGFhTFSHgmCChDkIFp0uM6i8be8DQxiaOD3eRmZfNFo8czrQtQoWWn/QVFgI3psT5Y2epOd2Xxhml763e5h7ESGd9uTi8X1SeyV3TDadcNxdAtiYkt7z6VPST+Jzpopdku73b1td4lSXdYq79KnTp25dra/LzWpgvqzlvLMXLgc0YqA6WAzd7OwjJ7DpitQD5TEYFu4A8NNCTIPWIyW8kGVvL9J3xo+gSOyVSLtqaWIzH4nnBeLhI9SA3jMBQ3XpG/Jcw3Vkp/DCmS4ARCCHLFrIHZqnDWFw7ddFAvnL1btNCIwecMQafCyKP0pv2oA+JWmass5wOf+CZSF0ZH1MZhDiyfKhggdS230Z9xT064TlgLgnMm1JR48TjkEq38iqv0vY6QjvZSlbLCtMdzsREgR7p1nkJLtTNHZ6PsC7o+iPww+kRnmUVC2rfc24eTLmawIwUPuwK2RLmAMZLK4/u2wZAG5jCzM6KfNG30HSncILYdjNmbXw0XNLeQQ8CuRsq0TU3E0vRa7apb0/nz0Vxe2NeAr8AQkj8moxN6t9oOalry0/difYlKWrLL64tvGy4sQRAlN1KdjWTBNAv22YXzfRCl6oY93P5QsU=

From: Yohei Kojima <yk@y-koj.net>

This series fixes netdevsim's inconsistent behavior between carrier
and link/unlink state.

More specifically, this fixes a bug that the carrier goes DOWN although
two netdevsim were peered, depending on the order of peering and ifup.
Especially in a NetworkManager-enabled environment, netdevsim test fails
because of this.

The first patch fixes the bug itself in netdevsim/bus.c by adding
netif_carrier_on() into a proper function. The second patch adds a
regression test for this bug.

Changelog
=========
v1 -> v2
- Rebase to the latest net/main
- Separate TFO tests from this series
- Separate netdevsim test improvement from this series
- v1: https://lore.kernel.org/netdev/cover.1767032397.git.yk@y-koj.net/

Yohei Kojima (2):
  net: netdevsim: fix inconsistent carrier state after link/unlink
  selftests: netdevsim: add carrier state consistency test

 drivers/net/netdevsim/bus.c                   |  6 ++
 .../selftests/drivers/net/netdevsim/peer.sh   | 63 +++++++++++++++++++
 2 files changed, 69 insertions(+)

-- 
2.51.2


