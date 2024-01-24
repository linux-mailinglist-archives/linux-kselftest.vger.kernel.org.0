Return-Path: <linux-kselftest+bounces-3481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D583B240
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF3A1C219FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42808132C0D;
	Wed, 24 Jan 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRuw62mk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C17131E3F;
	Wed, 24 Jan 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124354; cv=none; b=uBh3qmNRQsLIaVajH0pEknZZUquB0fW9WHHJvQAf2lvxck0ihPgapGmvcfBEBQI2WXbReYugt0PyP4faGXIk2/qL7nSyN7/0iOcFlRIxNXZvCkbV4XW9cELRjy/JBqCC8e+g+Tz9ABqGUhpc7pBt2arLAlXt9kPdz8ZozZ1TUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124354; c=relaxed/simple;
	bh=s0tT6YeARUMeSVWDBo2GvEZiFbz1hvS2XDiB/nOEupA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sbt6DiyrOJx6Sbj4FTmKh6+5udDVcoNSf4sw9UNq7ctmzlTZI4cvLbkzst9vMsSLAlc2FiKIJznw3jDIRR9w17RTkvnViA0iIhAN3W2QwhZkt8kMQpzJkGKhS7bb1X9twccyz9hkmUAFp5u7IX1UF6nNfV13NfedP/sifKvF5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRuw62mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B5AC433C7;
	Wed, 24 Jan 2024 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706124353;
	bh=s0tT6YeARUMeSVWDBo2GvEZiFbz1hvS2XDiB/nOEupA=;
	h=From:To:Cc:Subject:Date:From;
	b=SRuw62mkeK9VUPZDrwNJIGyvTUyjI7y6dRbayPJGJvq65cBy9+Re7QYRXVlamd93u
	 1mtoXngGiI0EpLyfEVmFIx5Hh4zccDzWs/p2ke6mng+3sU9u+covddi6bowJtQaxW+
	 4ToXTXG90hiOqjoF5dQFp2tZUVWYafS1yMLcyvigze4KN0L7chNtzlcxZqkGBbgj/O
	 Mb/19wYvkONcQfqbn/TCuf96Y/NU1Y0Ne+8AByVtLAYxABeJ8kZ0b3hC4yjEHodM4w
	 EJVvrg2/y8++Kd8iaG10eLYSLJTfr2hq4RJmcyRI86cEFrNmbtt4J2s994yqNG3X1v
	 T6s0MKctu80Sw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	0x7f454c46@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: tcp_ao: add a config file
Date: Wed, 24 Jan 2024 11:25:50 -0800
Message-ID: <20240124192550.1865743-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Still a bit unclear whether each directory should have its own
config file, but assuming they should lets add one for tcp_ao.

The following tests still fail with this config in place:
 - rst_ipv4,
 - rst_ipv6,
 - bench-lookups_ipv6.
other 21 pass.

Fixes: d11301f65977 ("selftests/net: Add TCP-AO ICMPs accept test")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: 0x7f454c46@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/tcp_ao/config | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_ao/config

diff --git a/tools/testing/selftests/net/tcp_ao/config b/tools/testing/selftests/net/tcp_ao/config
new file mode 100644
index 000000000000..d3277a9de987
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/config
@@ -0,0 +1,10 @@
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_RMD160=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_VRF=y
+CONFIG_TCP_AO=y
+CONFIG_TCP_MD5SIG=y
+CONFIG_VETH=m
-- 
2.43.0


