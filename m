Return-Path: <linux-kselftest+bounces-16951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C15F9685EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC001C22783
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1571D54C1;
	Mon,  2 Sep 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBnh1xSm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3F1D47D4;
	Mon,  2 Sep 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275604; cv=none; b=pD8ih0E5D73eHFRW/iS/S5qIhHkeerxvP2PLu4shbHUdMXz8htsi2Rt2FeuukPAQTBXljpPvwKIWaHQ9fl/5WVye809DGWdsMeCYJMStiedwLqdKC2c6F3WIjJPEGBhp/A9PBBtC3vZQigzP1GSGNJVJiHtK72gHJmOFFUmZyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275604; c=relaxed/simple;
	bh=3niV5QJ+FLaZE6yS8KXgq89EOVs56xOq4guNfTe9XTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgtlrbqwArKb36s0ia+Sd09N2/ws3/qD/ZM3HCeboMB3pfdqzyNHhDonWKXb8kxLo+xwTl00BZ4MdorUI7vna1Nmbh2xt7XHsBSxCNSph0iOJIw7hhZDneGpLYkyUvHjICSzEqZkbQe7/EvJUZ06C/85AGxfcgFGaCijeVNT1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBnh1xSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC8EC4CEC7;
	Mon,  2 Sep 2024 11:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275603;
	bh=3niV5QJ+FLaZE6yS8KXgq89EOVs56xOq4guNfTe9XTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vBnh1xSmWc4iyTjnbAdEa9Ms4RK2Rh3lz2gZZ6sn6c77o8OuuAdOC/DUm2N2xEZyv
	 HtW2QMws6Pt1Krz2fCan0/AflYYOl0LxdhWUx2zw2boYR82fvBZk43sGYf6W1tuLgt
	 NCTSlz+CgtWjRvdFtjqGmXN3hdLB27E3cA98wxuD3CSRtDNYjk3QJa05gZ67kg1CJS
	 5hy2UR8585mIHtAYS8OliD5OhtOZHQSYxUrwQd1F+yCtNhQzLThTAIF2E2OmVmFU+C
	 n5fGG3CjWeMcFYXEw9KUZtqPJ2753xHag1ah9DAsz/YR72nYKAcGhbgYX99xviwxU7
	 Td/S6czRph/HQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 13:13:05 +0200
Subject: [PATCH net-next 2/3] sefltests: mptcp: connect: remote time in TAP
 output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-ksft-subtest-time-v1-2-f1ed499a11b1@kernel.org>
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3niV5QJ+FLaZE6yS8KXgq89EOVs56xOq4guNfTe9XTI=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGbVncuj7jO3nIUjtHWA6OuZgrlbfYngci9mUJuvqc/WMwOwT
 4kCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJm1Z3LAAoJEPa3gk9CaaBzsLEQANcu
 Hvfxab83PYRzaCvvqLz0rFuKh2DEKwA1i5S6jpWYcwdQDisfYb5fiKBuDdATi8p2MJHH9KH1x0U
 O6k1zmd+kd+PYKoDm8UeRif1olMoUkOADQ5za5cWWBVZz9WMKXdENw9rCbgNHHJx64GCFbpxoZb
 yd+/3DFVPvOXGy8SRUn2c2x8QjPSqAIsy2c+6U0m4Yxdke47yY6mZGxjGFkCLTX8+UtymmyXfio
 P5R500C/kMPUgZY0RlhJIouct7JvJgDKdXWIG7QsrM21KIlltRVNHBnlzRUIpimTveHYD1gR/Nu
 J/XSHyBep04m5eSUVs+u1wM6kRI+q9vAfUnECeOm+aVL5/gLelOhEHZ+vKhyhXrBdWgHG/QQ12v
 xLxIO3aROocz09OaWOna+xPxselfsdV3cWUVW0DI6BD5ZRuL0wSsglknkDblA8gmJkYIsparFIc
 dOc9BCElYZS/3jmwKcypdM9tTycYmCsd7RlKgpQ3rwoACFVV4WkUFCUijB+GOSNl5X0ZH+aN+6g
 G7LS2HXWFQ+fAzNIxA+tRU89/sp28dGPSLN8Brw7UMc5kSEppj8jumxyJYecEaJWzP8xkr18AOn
 b5AQVCo2ye2t6mQayGcIhetDNPXIirSYpOPbmhzs1nd90KMstruJOOotSkebaSdgDLkvnkw3Fin
 m4D5p
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is now added by the MPTCP lib automatically, see the parent commit.

The time in the TAP output might be sligly different from the one
displayed before, but that's OK.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b77fb7065bfb..f61e2f5870ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -431,7 +431,6 @@ do_transfer()
 
 	local duration
 	duration=$((stop-start))
-	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"

-- 
2.45.2


