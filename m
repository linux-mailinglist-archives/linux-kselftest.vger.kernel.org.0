Return-Path: <linux-kselftest+bounces-21551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2489BF9BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCEC283D42
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66A20CCF8;
	Wed,  6 Nov 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hoY4B+mx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kYVLKA0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883B1D47B3;
	Wed,  6 Nov 2024 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934838; cv=none; b=Hc1FGMmkUSI0OwVUywQCU5PRrhQtPI/Y4Wml2uJLI36O0R1v7OPFLkKExvOW/v9BAAkY6gdBQ492sCYA/2FJIxocfsVSgMxYe1kqt6NNWVs26q8HJNtMHru5LOeGqNoT4LzsPlyUzuW7fnpU0FYubJnjirwPPx2LrzTB73pFzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934838; c=relaxed/simple;
	bh=B36VBDltIoRywAGblAfwutVOk3b/rxmBfwD8ZrH1yNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4Zbq7//kF3hYN1un5A3N4IzYUEtyG5KInTHVhIQKxdLYsSfunj/E0KBPM7wChnAnPjgyWUnMvqhDnljnnidOCh1YXO5stRaZWXDNUaBjVboFa2H2MPiYQaPxEWffyntDcJ6P9UUbL/fRM1Yy7YtcAnqp7kFVWxHVt1BxrwJvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hoY4B+mx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kYVLKA0m; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 3A9C21D402D4;
	Wed,  6 Nov 2024 18:13:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 18:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1730934834; x=1730938434; bh=lEBOJhqz1R
	S/g1V70UKSJGTy20U21lB2YXztTlSE8Vs=; b=hoY4B+mxiKdgfvtl1/AvUAh/Re
	SqXPyc/3JHoSYk3iq/8eXro5i5BIi3N74qyyKDnn1uCNz0NiYCyXq3JqD7koH7tb
	0fXRnIAa/CzBPbqLDyt97XeygEEdDQ0axsFvQtOC+kRTwVBNM70mXgRkFK/l4U8i
	qHyN47s22Z29NvFF0HipTq34zkWLPSIX7AvrhwnKDFwgqFZpg3NOY8Z6FmuTH61R
	oMvCvtcwiC/elSPRagIXCztgF9oVnww/p1CXkYV+WYCJXhwhO41JwGGDqp589DM/
	Q+njjx2AteR/i4BVGpPUF2yMso/+2xRUuk6Hq6uJ3g4MDToSZvWT+/gr9JWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730934834; x=1730938434; bh=lEBOJhqz1RS/g1V70UKSJGTy20U21lB2YXz
	tTlSE8Vs=; b=kYVLKA0m1JkPlC4MrJesPXIhAKe+t2xGCOMtT9eRorXzHD+oWgZ
	Tkfj5r177GAX0SL45QVdzWKujHx8KgUtNoOdrk6cKtIfplsWtpuSaxe2fcyPbFzL
	C9jyjZ7OVkcZy24d3zzvOdi0mXTTI7HRk5UzedCmZyoGSLUPJnZvoBhbf5SDk+iL
	xvbdNkc6T/9kG0Id0FtrN7jFYLyQ2ErOsemCLC4vAGDJiWFnmXr7Lj7vxHCeWv5+
	3d7/0hu4zXVmUuM5mGFFH8O70r8C26xLxIqIFmg6v2zwKyq8fjcAr9CfFj8CxmLx
	pvbIK4NFl9jON52u/ZfPDSIXeeV6qmLbLxQ==
X-ME-Sender: <xms:MfgrZ3kZU7xGh23nufvCPqyxwwKSULf1hdgTsAWlg4jgxbJ6k64yGw>
    <xme:MfgrZ62qxolztG3KWUzn8_PhmXjquWol2boZIKfrKt_toAT7w5oycdFdy8C89EhYN
    jLJ_QLvys-h44qIYY0>
X-ME-Received: <xmr:MfgrZ9pxynsMVdp9Q2wIpKN3ix6KuYkneD3ww5d5R11uc34ztvP1K9w-CmHv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhr
    ohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrd
    hnvghtqeenucggtffrrghtthgvrhhnpeejtdeugfffkeejfeehkeeiiedvjeehvdduffev
    feetueffheegteetvdfhffevffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhl
    rdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhf
    thgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MfgrZ_nBV93zo1Np4N58l2i2hf2yb7xfMVOuHAK0gUWrhtQdizg3KQ>
    <xmx:MfgrZ10RcxJO2Qw-5bn1YtcRORCrbBkzgloXtnr2pfFa3OTFd-XPcw>
    <xmx:MfgrZ-uOOmU1Ep9K3bmgznPpUEGKsGC--6tKJ5LhR1-xxXxZDP0H1w>
    <xmx:MfgrZ5WNl7OLpjCsQH6VVv6JvkoxY7SBezPOevxefGA_PUaAGWLtpg>
    <xmx:MfgrZzAN2toOIwaFulVSpthJUO-lImBFQPy29H3FKlAWlBm7e6-KdL0u>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:13:52 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/8] macsec: inherit lower device's features and TSO limits when offloading
Date: Thu,  7 Nov 2024 00:13:26 +0100
Message-ID: <cover.1730929545.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When macsec is offloaded to a NIC, we can take advantage of some of
its features, mainly TSO and checksumming. This increases performance
significantly. Some features cannot be inherited, because they require
additional ops that aren't provided by the macsec netdevice.

We also need to inherit TSO limits from the lower device, like
VLAN/macvlan devices do.

This series also moves the existing macsec offload selftest to the
netdevsim selftests before adding tests for the new features. To allow
this new selftest to work, netdevsim's hw_features are expanded.

Sabrina Dubroca (8):
  netdevsim: add more hw_features
  selftests: netdevsim: add a test checking ethtool features
  macsec: add some of the lower device's features when offloading
  macsec: clean up local variables in macsec_notify
  macsec: inherit lower device's TSO limits when offloading
  selftests: move macsec offload tests from net/rtnetlink to
    drivers/net/netdvesim
  selftests: netdevsim: add test toggling macsec offload
  selftests: netdevsim: add ethtool features to macsec offload tests

 drivers/net/macsec.c                          |  64 +++++++---
 drivers/net/netdevsim/netdev.c                |   6 +-
 .../selftests/drivers/net/netdevsim/Makefile  |   2 +
 .../selftests/drivers/net/netdevsim/config    |   1 +
 .../drivers/net/netdevsim/ethtool-features.sh |  31 +++++
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 ++++++++++++++++++
 tools/testing/selftests/net/rtnetlink.sh      |  68 ----------
 7 files changed, 200 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

-- 
2.47.0


