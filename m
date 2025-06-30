Return-Path: <linux-kselftest+bounces-36112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AF5AEE29E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8C166B51
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55028F53F;
	Mon, 30 Jun 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKoyOmU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/f4PDK8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EB24503F;
	Mon, 30 Jun 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297626; cv=none; b=hmpXiZ74O7f4RXAMdBp4h2dydDye9EsDn62/83MN/4hAG2xDQ9XVb4f5DJJvGdB/vLNVvw1OSWZJff31NDqeH2nX0dPzu7fyNHAduKGBlhPjpu8q/YgtO7cbFTpwYtYtAfKi9bVErx03QqD/W9z+nqBQV5aWCok4u74J4voF568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297626; c=relaxed/simple;
	bh=aTCWkLwi+CtG92KLSxHM3rbUvvoD4pC+7AK/RGo+FQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i/eb/F1zw4Rrj35mLK3Bj3CSUCz5sk0n6FAfm3nfoCDQIMtwRpFu0a5ZLwOxNM972c2mcP5sEtJYVrR4DFNFuPs79Z8n+K+RVj+saqlGqC1czDlirNG+0AkbOzcgo0a4sYqB3yHAbpfIBYXs8zpuYJvK8U3EAMcZ+SSWwJaHyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKoyOmU2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/f4PDK8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 17:33:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751297623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cxiu0ZRDOamv5dWbxC+oQlVwTHqvEsO05LOM+OvHFdc=;
	b=gKoyOmU2f+xVUKMrphwmzSGIYh3WgYHKIDWD0octaxXmXA3hnMKA2MyMssmgo9i7Qqlqtl
	gkc2Xc38VPF45VuykPDhlHgm/jqzftvIEPWTeePbrnbcINQcWk3GgFRkbEMm71bzZ0lrgO
	Ed7tPqMt+KJ3lR/VmuNQ5oMTtANV7JSVG14kMVqOxNLizPhxfi5ZmjjJFlJDicXNpgRBzD
	3fKOOrRAyaOmlFYA/SEH3wm9iB3ILcPiiHV/LhU8eMCaOtlrkhBY9kvIx03DH0ES375GYu
	4/6pDkPeOta7wvwe+75o8svVGUN9y5JaIYOVzuffyk4xSxbdpgkE6UKWu06Csw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751297623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cxiu0ZRDOamv5dWbxC+oQlVwTHqvEsO05LOM+OvHFdc=;
	b=2/f4PDK8/NoKiZcoyKCFPbovyCH3vRrlJuFonZBIDV50Fxk2acj5jnAAeJ3YM61lKE2SjU
	Db9w1UTL9iNO5yBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next] selftests/tc-testing: Enable CONFIG_IP_SET
Message-ID: <20250630153341.Wgh3SzGi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The config snippet specifies CONFIG_NET_EMATCH_IPSET. This option
depends on CONFIG_IP_SET.

Set CONFIG_IP_SET to be enabled at part for tc-testing.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index db176fe7d0c3f..8e902f7f1a181 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -21,6 +21,7 @@ CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 
 CONFIG_NET_SCHED=y
+CONFIG_IP_SET=m
 
 #
 # Queueing/Scheduling
-- 
2.50.0


