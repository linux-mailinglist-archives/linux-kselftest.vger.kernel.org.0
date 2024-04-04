Return-Path: <linux-kselftest+bounces-7204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA5898BA4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520371F26DBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46612AAE2;
	Thu,  4 Apr 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rFNTx1IP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9112BE9F;
	Thu,  4 Apr 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246089; cv=none; b=F7LujGShVo4fn6bsN8eaxrkQgUr+FZTPTcoydEoyMjzWvCSe8oyISyjO0MmUvliYXOlxFBHLgOzA0Nr66nZ4JWawOj/NSsP8cqjsi4l0Kv/LBVsA+WuTYu4LGWMKawJ9rSeOOdTKxazxqI2UKYHgpIMuTcORZdgyfVv2CsoGh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246089; c=relaxed/simple;
	bh=gbv4deGLNeHnzvm1cogU/uZ2YEN+fZg5LG8jSOtYOM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMVCF+oLolN6FpfM6mlyL6hH7qNtSvFRl2LvxFn3zZrRYHTfclBuElRHh1aBEM0u99NayYok5Ss1YHFr2R3DgJUqnui4vzdv3skC5On4j8Hf92YHTzClnXbKIdfZBOxrD74yQsN9ifVG3bNq5feoQGpV5Q/jAV9o7eGbnA90PrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rFNTx1IP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712246085;
	bh=gbv4deGLNeHnzvm1cogU/uZ2YEN+fZg5LG8jSOtYOM0=;
	h=From:To:Cc:Subject:Date:From;
	b=rFNTx1IP/PTqD5Pmf88Js4KyrR4SnGDJZy2+x4Lm/O8DTryGJJy0MxcK3DiGE1SIr
	 HwSnldLrKFBdeTL5XWd5jUlmvOCzrSIXlm0N24yp0mZB9Kb5DTSSnVinrFfnhtQaNb
	 gSus+03b2cbetbaQfduk1IOzAcDk3kz7augOeLI4m7rQ6IXP6f4fFu14Ar1umCO4xE
	 gMk8ysNA4V+Rq7BphV0trm83Pqowv7YKTScDp9Ayvz79m2LFb8mbg4VCgKRZO3ve8G
	 xwE0jRnlTPa9hk9+DzfaOF34zzbtkIMV1W9i4Ui8nOSZgJgOujrI+pMcmrl4BBYMLL
	 FAIgbaaMbJL0g==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4CB0937813A4;
	Thu,  4 Apr 2024 15:54:44 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest: Add missing signature to the comments
Date: Thu,  4 Apr 2024 20:55:10 +0500
Message-Id: <20240404155511.57502-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment on top of the file is used by many developers to glance over
all the available functions. Add the recently added ksft_perror() to it.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kselftest.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 7d650a06ca359..159bf8e314fa3 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -16,6 +16,7 @@
  * For each test, report any progress, debugging, etc with:
  *
  *     ksft_print_msg(fmt, ...);
+ *     ksft_perror(msg);
  *
  * and finally report the pass/fail/skip/xfail state of the test with one of:
  *
-- 
2.39.2


