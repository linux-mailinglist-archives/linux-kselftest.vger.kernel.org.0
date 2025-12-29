Return-Path: <linux-kselftest+bounces-47995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F9CE7D00
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 19:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA01A300DCBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F927A904;
	Mon, 29 Dec 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="Z59y/cFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster3-host5-snip4-9.eps.apple.com [57.103.77.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864861A262D
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Dec 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033190; cv=none; b=BdUXeyClLwul1oAJs6thaVlsZzjOTT/CQV7hJzS/BelcmZbAFX8o5xy/s/Q6wFOLy8nSPRLiBtKwDVKAv4ICnJAU5AVKYk3W/ZzBwMQVCKu5/gSQFuB+D8lg2u3zuUwjE/u5sH9OQOoPj3tWbgDzu8fPq3afoYNjqDsGLs6VQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033190; c=relaxed/simple;
	bh=MHwfQHPauWIQT3+OqPNGY6gTOxGQ67ClhPkVTqTTuSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9Tc7maeo5zTJfxq8IegjA4Y1KwM4V6vEz8wZk6yUlHR3ODypmKpVelVO/W8OgFKjp1ra9Kt8QlYCXuFdA0JjijzcMnLYIkSn33Cj4SxI3mU2+Rysjc095aGsD/2RittuSxVAHfl6XJtPLS0KGGl3qvYUABmI0OURBhCMcVqk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=Z59y/cFQ reason="key not found in DNS"; arc=none smtp.client-ip=57.103.77.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id BDEC918000BC;
	Mon, 29 Dec 2025 18:33:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=3i6U+qqB5xO17c1ZdodwZtD/w2GvS71vzUwSwm30f6Y=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Z59y/cFQB1Cq3DiUDqDj3kz8cS0Q7w0D3hJckwr3u3pIDQoOcv5H0teSn6yIQcMHgwxLqaKpDk0qvfnvEfZ4ScuYiAck8P8vpOxLXpE0T3zdOg8BKa/jzfmCc7M3xfvoluShWLoV2Z7dYVXY/Yz5cJRwJeAWc4IWZXYpBkBB/Mk+gFjoBZu73S0ANHI02IebtniXuAnL/5F55Q8Ft7b8rlEIddxTmVZNZKxcb2KUzqvGZMT4UgqUoaiAnYuSIBsyRrtUXfQjNDMCLC1FvRGsBk58aG2r4Kl99ERbGLWNVdRRSBr7QBSdApXspgx1Vo/FYcFJbm9Iz6VG0LPoA5O7qQ==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id 7C29C18000AE;
	Mon, 29 Dec 2025 18:32:58 +0000 (UTC)
From: yk@y-koj.net
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Yohei Kojima <yk@y-koj.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/5] net: netdevsim: fix inconsistent carrier state after link/unlink
Date: Tue, 30 Dec 2025 03:32:33 +0900
Message-ID: <cover.1767032397.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: etIcuxVpL5yvXdFfMY-KSg9D8oCgXkyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MCBTYWx0ZWRfX5C+wfx2fyKpf
 lm6G8zE0PW7eRsBKacVYWLA4/V18grDmdQ0yMulZNa7GZSA5e3TuardLWKoYQgJcMIUPtXdkdIX
 uufNjF+B7Q2ZWZuRPx/R7kIYsWLj9ezPWp+OSjwf8y/6nvpUGB972ypp1LGmuezraac8iPExVjU
 c/Wvm7XMMMNhNkPUP7a6mb9TqNk6qWLYVbF+dRmGl2IaXAQ+T0WPJz/6zl9vMzffuuQOJ4FtncV
 5k8hmxTBikDZK3Z1oGE78xlR5g4GXI9CwLzaXrNqT4e2WF5Ki1j6zAYWsLi3VSRuPhol2eIp3lw
 Bj+fstCIJIxjlKGSEjp
X-Authority-Info: v=2.4 cv=LZkxKzfi c=1 sm=1 tr=0 ts=6952c95f cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=7STe8TXQyHsiQHg5nocA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: etIcuxVpL5yvXdFfMY-KSg9D8oCgXkyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 malwarescore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290170
X-JNJ: AAAAAAAB0oCq8TWCnumFUYxiunuWBHnwcvVcakQkvPzzzOIPYeQaIirEWtISyBwt8/dwpoxogTWJEHYr5IQvjgnU22HEL+3sd7FI7zWm1KYN1KhmrqMw+upAnz3LslAKpwmqTSUmqkkXFmR3UwfsNRBGNLepBO2Buv9s5DTu/moaPgBGTKdPUBbo8132xZp/Fj+kg30b56UgWmaIdg43K7Oo2U3SIc2JiZ1ZfeuZ1wObfRW1eDO9tvJAljEs3qyOmH6r5zuXq6V0LX4V8Ah2vxBM5rGnSH3aTOtx4VCVJq9APY7zuLQdkLUzmXL+KmzqlK446NHSgeixfyIVNeELKWwOPUDeOfM+BGWPMVzFE7PdCzTPib1FZ5RNmON8hgIC+GROoyH+drwfkX/Cif7kkgLnWVSxANATqUZW4CBVd41AGCr2lxRR7yS3BILPddoBFnz+Xj7J/fvi7g8aEybAW2JT/K+XBi6ePdQMXfqrmDlRm9w/L8IIGXilZbeVsPVe0Q7fMH+pC1P2sY3LveYYcmmei3zqce1ExiTTHL74RqW5qkDfRznnuEjtgJeNsNL31+NSH6sDvOzU+PlJiVRayjoA1cuZXYmWbr35uC4mSm7CNKBqWGXeEZjdKzDT3WD3PMKvyIXstDiPCQLXgHcopwacB0jl9+wp9JpjucOMe2TGCmaY8DKm0/I0CGHxWH36F5FYMhbADZeR8PXnA4o8RsEjqmoDtA==

From: Yohei Kojima <yk@y-koj.net>

This series fixes netdevsim's inconsistent behavior between carrier
and link/unlink state.

More specifically, this fixes a bug that the carrier goes DOWN although
two netdevsim were peered, depending on the order of peering and ifup.
Especially in a NetworkManager-enabled environment, netdevsim test fails
because of this.

The first patch fixes the bug itself in netdevsim/bus.c by adding
netif_carrier_on() into a proper function. The second and third patches
clean up netdevsim test and add a regression test for this bug.

The fourth and fifth patches improve TCP Fast Open (TFO) test, which
depends on netdevsim. In a NetworkManager-enabled environment, although
TFO test times out because of this bug, the test exits with 0 without
reporting any error.  This behavior implies that nothing would be
reported even if TFO got broken at some point.

The fourth and fifth patches are intentionally placed after the first
patch, because fixing TFO test without fixing netdevsim results in
a spurious test failure in a NetworkManager-enabled environment.

Yohei Kojima (5):
  net: netdevsim: fix inconsistent carrier state after link/unlink
  selftests: netdevsim: test that linking already-connected devices
    fails
  selftests: netdevsim: add carrier state consistency test
  selftests: net: improve error handling in TFO test
  selftests: net: report SKIP if TFO test processes timed out

 drivers/net/netdevsim/bus.c                   |  6 ++
 .../selftests/drivers/net/netdevsim/peer.sh   | 79 ++++++++++++++++++-
 tools/testing/selftests/net/tfo.c             | 10 ++-
 tools/testing/selftests/net/tfo_passive.sh    | 15 +++-
 4 files changed, 101 insertions(+), 9 deletions(-)

-- 
2.51.2


