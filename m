Return-Path: <linux-kselftest+bounces-29867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B10A735AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3957D189D2D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4C1990CD;
	Thu, 27 Mar 2025 15:33:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693E126BFA
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089601; cv=none; b=AcbX96NTknGwDUjmgD7lb30lRIq3+7N90sDlERXC2aDLDi2o4ZNvLVVajnFp2bUAF0f5E+kS89uOSMz5kH84qpmFrYMlF4oWq25+QJYZYBqWsLzEoiMoadu9xDfHkio5etyVVmLgwXG1jRfnUbsDK8WtwjzxuWY8ocQpc6ShZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089601; c=relaxed/simple;
	bh=erlXei2sBYo5h7v1S6Syq41Q79Vj69yo6grMNUihDdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkhPGqQapfogLr9toiSjl4Y8UT+t8V22KsUAhaqZZiBD0NR8Bl9ep+p12XTkXLCTSb1cQZBO+JiBjKlWS7XLfy+jLJ89wqseF6BSGJ9e1nmpiRstPTqfwgNfAaCn8eTD0f++slpHRQC2y/teFYelii4kgJ75J4JKrnPDuJXGlzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4ZNnjf3CBZz4xt9W
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 16:33:10 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b1ef:107c:7814:6642])
	by xavier.telenet-ops.be with cmsmtp
	id VrZ32E0025Szt1p01rZ3Wy; Thu, 27 Mar 2025 16:33:03 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txpE6-0000000Fsh6-1v3j;
	Thu, 27 Mar 2025 16:33:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txpE6-00000006DBv-40wM;
	Thu, 27 Mar 2025 16:33:02 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] kunit: Spelling s/slowm/slow/
Date: Thu, 27 Mar 2025 16:33:01 +0100
Message-ID: <1f7ebf98598418914ec9f5b6d5cb8583d24a4bf0.1743089563.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling of "slow".

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 58dbab60f8530588..9b773406e01f3c43 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -67,7 +67,7 @@ enum kunit_status {
 
 /*
  * Speed Attribute is stored as an enum and separated into categories of
- * speed: very_slowm, slow, and normal. These speeds are relative to
+ * speed: very_slow, slow, and normal. These speeds are relative to
  * other KUnit tests.
  *
  * Note: unset speed attribute acts as default of KUNIT_SPEED_NORMAL.
-- 
2.43.0


