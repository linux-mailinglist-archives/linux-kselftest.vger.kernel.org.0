Return-Path: <linux-kselftest+bounces-21558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718029BF9CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097A1B226BD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE420E320;
	Wed,  6 Nov 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="tX4lKF2z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FfkEXb0P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680920E316;
	Wed,  6 Nov 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934852; cv=none; b=Uadz+YzTsHmjOxYgTOkltoejqPQtYZZC9ERKyMWRV4PdN0Im+g8YqyVAqHRTdkptdgrQN0ZmpuevAeGiz992lfmP9wxi77Cv1/5/WJzUklC40WKUW8HdETZxXtesR1rOKmgroaS3Q34OnAYsYLSsFwyztMWGe1/dDaMj89KU2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934852; c=relaxed/simple;
	bh=4gb/gbi3saGF9hAAEDygH2QZETTJ36quaU6eqU4lrFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWabVmQ1H03c+UjC8VWgt7ep3CTP9O2WvjU0OCVCXpeOlmjqUi8yW6+sfXtwQZZ8LZ7zqNq0dryL1cL6Pr9eMI1fRV9lUNRNFdYLldK3X6SOwJk+F+F5ZJHiV7bOqGalrujQh6Y6Q+UrOsWsafUMXK5guJ5Gu4nf02WqrGWXz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=tX4lKF2z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FfkEXb0P; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 4BFB81D402E5;
	Wed,  6 Nov 2024 18:14:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 18:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934850; x=
	1730938450; bh=q8axz2qeRVg6/09lyj5JIPOpYVYojGA+p3Ijmf7/xTE=; b=t
	X4lKF2zys85AAL04d/9kQ5k7uFOJApuinQwoF76xA08ZN8aW/MS1OZUrW4FdhCCd
	Reu8tdgo0u1pGJe/5Rwg5YGibOkS8H6eKH6t6Fj3jP6OyhL9mRT83uYEC7C0AdVM
	Vyee0z4yHXJO1+2UDwcef2dBil+1DWPuIlvMqbb949wbI+sD0J7xuKofcYAzki6C
	1WHjN8OOVm2fpfQ2AFN9v0NdeXPWCkWn72t+Kr5XLCYnPz00pD6iIl0aSw4E3WRh
	lsyxAUIYBmUwXGWec7MBIJj1WWPao4spwA83EUZQK/PML6U6du/VJ19vi1Sio7L8
	eW6gZMcrc2mm33OjOEQZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934850; x=1730938450; bh=q
	8axz2qeRVg6/09lyj5JIPOpYVYojGA+p3Ijmf7/xTE=; b=FfkEXb0PckLHydn1K
	FeuFtPN7CjvPiKzeSY5VQ5iXfPrXsCXxkhtp+nMS9hDUw0C702VH3iAOhQSDuPe2
	c7H1w50/sXFhI5YOMEfoU6yhKx5y6gyJrbMs3p67Qj4yt5h+5SwfI3rq3dShmLYx
	sPzxmfQD6Ua+HxzCqFln8CEDkPmh8dF17bzMbvCbZA3FIf/JXxouZPEay/6CtHfq
	6gW/Za1fLVcVYCJ+Pwl2usBFGUoFxEqrqDiAVZELl1QyoKG0nzE8IK8CXMsfb4rs
	KD4vF/EiCdp4Zhx0/yT+MfFlcpdpmyntTGRQtvCZkRrUH5OTqcgmWTsyJEQc8Foa
	jXktA==
X-ME-Sender: <xms:QfgrZ0eVC4AG1A9JN_9lkxbaFKnXRE_fXsEXDsPyBMzUvpKtKxJY9A>
    <xme:QfgrZ2N1dmR5weBGSDfpRnnlvjSvC_h4pBUaJ3lF0DmwrC3oAHpfAYqvi5rIFJM21
    V4GYIIpJjYOj7aNkbo>
X-ME-Received: <xmr:QfgrZ1hFizxwEn8mj6vxUiyJ6f3TW5xs2gldtSRUjabMumkDlss4A4xRGe7a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QfgrZ58CnWnD50wotA7NL0w4G5_wB8XXJQQRsBpuwUfLORWh_Fq_Ww>
    <xmx:QfgrZwu8DJEvTHOYTtFOAWv6iC4yZqwH6B7eOICn8m_fLZWyxV3dfg>
    <xmx:QfgrZwGPaJjzjwXVj8rSqHGZ76o45kA4kyVJHHnS9D__B6PTHHZHzw>
    <xmx:QfgrZ_NaifofatOlCcnQ3HujAY4LOq7YDNc3Ij_qerLNdzrfw6zt_w>
    <xmx:QvgrZ54f0Vr1k1PNxkwhVVPHQ0kLd2zkC3J2M8rGDIKJvU0FiMQ1pj0o>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:14:09 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 7/8] selftests: netdevsim: add test toggling macsec offload
Date: Thu,  7 Nov 2024 00:13:33 +0100
Message-ID: <bf8e27ee0d921caa4eb35f1e830eca6d4080ddb2.1730929545.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730929545.git.sd@queasysnail.net>
References: <cover.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test verifies that toggling offload works (both via rtnetlink and
macsec's genetlink APIs). This is only possible when no SA is
configured.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 .../drivers/net/netdevsim/macsec-offload.sh   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
index 7babcfd76b22..1f2775846ea0 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
@@ -48,6 +48,27 @@ check $?
 ip macsec add "${MACSEC_NETDEV}" rx port 1235 address "1c:ed:de:ad:be:ef" 2> /dev/null
 check $? '' '' 1
 
+# can't disable macsec offload when SAs are configured
+ip link set "${MACSEC_NETDEV}" type macsec offload off 2> /dev/null
+check $? '' '' 1
+
+ip macsec offload "${MACSEC_NETDEV}" off 2> /dev/null
+check $? '' '' 1
+
+# toggle macsec offload via rtnetlink
+ip link set "${MACSEC_NETDEV}2" type macsec offload off
+check $?
+
+ip link set "${MACSEC_NETDEV}2" type macsec offload mac
+check $?
+
+# toggle macsec offload via genetlink
+ip macsec offload "${MACSEC_NETDEV}2" off
+check $?
+
+ip macsec offload "${MACSEC_NETDEV}2" mac
+check $?
+
 for dev in ${MACSEC_NETDEV}{,2,3} ; do
     ip link del $dev
     check $?
-- 
2.47.0


