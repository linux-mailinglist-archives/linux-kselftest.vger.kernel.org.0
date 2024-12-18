Return-Path: <linux-kselftest+bounces-23473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 415C19F5D27
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 04:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D137A2610
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68F13AD3F;
	Wed, 18 Dec 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HqFBhd5N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018783CD2;
	Wed, 18 Dec 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734490804; cv=none; b=DrJSGE00oY3SFAiGn++bxzOn2Ll7uIbORX3AgnnOQmaOQjSLJEw/uTlO+wkM5LKzxPHECVNY09bkBewCpfpEmmDhZia1koKKBO9M3JW7KxYmPOeCz39ScjDHP/RG+JGgt2bbypmxEjGEQqjiNYJs1eTz1X4RVCwKvhScoZQ3Qb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734490804; c=relaxed/simple;
	bh=sWCNm7GtXZu0rAuQgCNsRCB6FD44Dpbggu8hcxTLg7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDszYzNHFZU3LUjvk33maDbIDfJc/6VD3zJU+EWuQSp7yjJiS6fTS5pev+cxxMkhpUuoCE+KP78SYvjGr7JbKp1BGuB8itl39WCaLbTLSmw7rTWfanfz7qPB4uKT3eX/p8xoXXV6Foa207aPMfm/w08Uojbgls5Qv+fctEqxySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HqFBhd5N; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734490802; x=1766026802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sWCNm7GtXZu0rAuQgCNsRCB6FD44Dpbggu8hcxTLg7s=;
  b=HqFBhd5NCPI7Tyq+vhd3c3jyTMtu4OHN4E8ooYuGjytkxNOtxPxpoMF7
   ron5o0AgkFkCLAPWS84pHuqBh/q4thOXIGZ7G9yVqQM9jtIT/afB1NZEW
   /+OZSLZuR0bsd2DpZIRdNpbqGhaOcAPhC3txZgymMpnF9mane1KAGC3J7
   Fml48fMOg4hN/PHBzgLLOJN+0zOstpTWWxxxGHBWQfbxagBd+2NjamR7s
   0EQQkllSpZvT7irtmKMFcwubyA2EWdSC7gFzKyVKfkMVflz5JE8SpvkdD
   IWnFBzlh7kaq3bHxezEv0IqyY9l2ryS5vGufgyIAwLgbwrfH6Q5EAOLjQ
   w==;
X-CSE-ConnectionGUID: aV5HgltyQF+xu20f+mXZ1Q==
X-CSE-MsgGUID: IfFqR4u/SDaqUXoJKU23aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="163047232"
X-IronPort-AV: E=Sophos;i="6.12,243,1728918000"; 
   d="scan'208";a="163047232"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 11:58:49 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D7214C2267;
	Wed, 18 Dec 2024 11:58:46 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id AAEDFD5B57;
	Wed, 18 Dec 2024 11:58:46 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 360B82007C3F5;
	Wed, 18 Dec 2024 11:58:46 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 34FF91A006C;
	Wed, 18 Dec 2024 10:58:45 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH for-next] selftests/alsa: Fix circular dependency involving global-timer
Date: Wed, 18 Dec 2024 10:59:31 +0800
Message-ID: <20241218025931.914164-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28866.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28866.004
X-TMASE-Result: 10--9.385500-10.000000
X-TMASE-MatchedRID: WJKewK3e/SCzMXLXYBHcMqEtILqFekmXEDnDEqNPdupM+b8yxBqvA5+1
	agqjkx7svO1JeTfAZ/1kFhZi8d5BgK88naeSWWBZoHDoEp2TszGDy+T4Lu/PHnhh5KUdlgWi/h7
	y6YgwyJ0JN0MAlHoa5DWfD65lvMkvoYY7KoErjW8ReM8i8p3vgFQQ0EgzIoPRmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1akthIh2XonG1rR6YWXAbZc1f6GUbOEOFV/rph4RkvB1p4hIGlA/PwQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The pattern rule `$(OUTPUT)/%: %.c` inadvertently included a circular
dependency on the global-timer target due to its inclusion in
$(TEST_GEN_PROGS_EXTENDED). This resulted in a circular dependency
warning during the build process.

To resolve this, the dependency on $(TEST_GEN_PROGS_EXTENDED) has been
replaced with an explicit dependency on $(OUTPUT)/libatest.so. This change
ensures that libatest.so is built before any other targets that require it,
without creating a circular dependency.

This fix addresses the following warning:

make[4]: Entering directory 'tools/testing/selftests/alsa'
make[4]: Circular default_modconfig/kselftest/alsa/global-timer <- default_modconfig/kselftest/alsa/global-timer dependency dropped.
make[4]: Nothing to be done for 'all'.
make[4]: Leaving directory 'tools/testing/selftests/alsa'

Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: linux-sound@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/alsa/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 944279160fed..8dab90ad22bb 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -27,5 +27,5 @@ include ../lib.mk
 $(OUTPUT)/libatest.so: conf.c alsa-local.h
 	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
 
-$(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) alsa-local.h
+$(OUTPUT)/%: %.c $(OUTPUT)/libatest.so alsa-local.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -latest -o $@
-- 
2.44.0


