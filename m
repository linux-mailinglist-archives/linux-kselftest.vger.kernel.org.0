Return-Path: <linux-kselftest+bounces-38018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEECB12B45
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164EDAA199A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A96254846;
	Sat, 26 Jul 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHCDniFl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A11DD889;
	Sat, 26 Jul 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545233; cv=none; b=ODaYvTlh7i7KyfG+9iDjhoZLO76jFePRDBJqwc6Uqdd9OwHbosIT1GHnjqpQbtbnMPXwlDT8UNxXzP3XwXEf+rGs4K7b47QlPOuycKF6RLy3eRxnIBR2DN5cyOBWVypzI+Nt+RFo2nh0Ugtu4+Yxcm8vX7Lmahu/u7B3kuERg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545233; c=relaxed/simple;
	bh=UBc+BZmaMOHH7cTVN1EGrbdqthdjOH/VQjkGtqKtNCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYudaygoCMGnHzRGu6tE/zS73G5mirWV2SNEDaZECKCsBBjUjRgntC5Zh06uM1mJwFDfNbtyUIOEk5z0GBmthLrzUsnECUfRESEiHEmY8QAycX4t9CmIu64mH2T/pOCEUL5Adt2cGeh5v/16Y8pA3ZVkmjNCjMgLjxcgGyDtK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHCDniFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF07C4CEED;
	Sat, 26 Jul 2025 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753545232;
	bh=UBc+BZmaMOHH7cTVN1EGrbdqthdjOH/VQjkGtqKtNCU=;
	h=From:To:Cc:Subject:Date:From;
	b=RHCDniFlzoCJRm+a1vKsqj47hOGKq3YK74Q3k8ldgmPDRyWCgD8P8HOVznuIxBHV3
	 cs/YD1iJH0dH/M4MCU2Bi9gvF4WhH9T1947vBLmBV84pYig64y1t0AJl1KIYsEFF9N
	 zpQZjZHzlwkDE8QZ2j7WeCgTIVvEQCCn79UEMsGTHBUvHFzl972vqvQr+i5PYVV98k
	 MePVquesowwpVZ8foPMoidCT4Ts/BZDmoqDCbh3Fw5ajzcBwyFY5iUdpPO3LAULjuQ
	 xFPYpONa+g76mKlag+kxxVQyX2Lve74DQMhNZpYvH0ipgAkeQvK03+nIrqqh+nAeP+
	 AlOp404kPPtEw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	pablo@netfilter.org,
	bigeasy@linutronix.de,
	fw@strlen.de,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: bpf: fix legacy netfilter options
Date: Sat, 26 Jul 2025 08:53:49 -0700
Message-ID: <20250726155349.1161845-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit to add NETFILTER_XTABLES_LEGACY missed setting
a couple of configs to y. They are still enabled but as modules
which appears to have upset BPF CI, e.g.:

   test_bpf_nf_ct:FAIL:iptables-legacy -t raw -A PREROUTING -j CONNMARK --set-mark 42/0 unexpected error: 768 (errno 0)

Fixes: 3c3ab65f00eb ("selftests: net: Enable legacy netfilter legacy options.")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Targeting net-next 'cause that's where the bad commit is.

CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: mykolal@fb.com
CC: shuah@kernel.org
CC: pablo@netfilter.org
CC: bigeasy@linutronix.de
CC: fw@strlen.de
CC: bpf@vger.kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 521836776733..e8c6c77b96cb 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -97,6 +97,8 @@ CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_NETFILTER_INGRESS=y
+CONFIG_IP_NF_IPTABLES_LEGACY=y
+CONFIG_IP6_NF_IPTABLES_LEGACY=y
 CONFIG_NETFILTER_XTABLES_LEGACY=y
 CONFIG_NF_FLOW_TABLE=y
 CONFIG_NF_FLOW_TABLE_INET=y
-- 
2.50.1


