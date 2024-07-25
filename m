Return-Path: <linux-kselftest+bounces-14227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F372093C098
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 13:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF27C282524
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BE1991B4;
	Thu, 25 Jul 2024 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O61oRigc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA913C907;
	Thu, 25 Jul 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905763; cv=none; b=LYsPvI6lIwIeVP2WmG8pb2R5drP2C3ipw/nERGgV3fVOP2nVjQLQlaV+lmJ5ATUbZ59t+7uwNojilwivt3Ap82j7TYDdZDy6CBrm2W3fr1lW4YoC6g13sxlmY77zWOqW4L8lRVJcLvrCdgk4K83abPMfv5YdRx/hE4Psc4ogxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905763; c=relaxed/simple;
	bh=w73AVOrhHboNOTGCoxQ0nXk68FgJnFYHdRw6SkLlevA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgTQlyaGiPjbswwNUYZU2F30OoklCgb4or/otQv4O9kNXvIfc631/8xpll9amuwKHvW9UZAISzZ05/OmHYi4ccZs5xNE4NvcRf01bHdH9JgvqALyP1BvcELN4adWrojU8SpvbGb+lDvu/zPyJ4pUsClVIhVEB3lRiE4rrskRUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O61oRigc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721905760;
	bh=w73AVOrhHboNOTGCoxQ0nXk68FgJnFYHdRw6SkLlevA=;
	h=From:To:Cc:Subject:Date:From;
	b=O61oRigcM40qDe71FQWWpk9SUV2VPtXO5QB0vCcWMXnC+a3uk9l2GxD3NQv3fsxqy
	 4fqDxHQhMlG+P7cfVZYfZwbIMjqS5Hza5wvzpfI/Ctcx345B1b+QjUQ3IVpCSvfvGa
	 j2y4GCJtTPZgfwZe1NKKUpt2e55Y6Ds53grWKJEabdjm8iwpwoIhiTHmc6wA8hiugH
	 S6FqdCeCciNHv7vLGEufqyr+mdO58g9U2SVcj+5+hS+6udly1ZgPlPwCsQ27AFILg1
	 r39mpSGOCQ2pfBz9aV39LVIT+3BdQvabHxEBXkUkc6+UgmsxyjLWfRAvB3kV4k8feL
	 azv3L28uy9pdw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1807B37803EE;
	Thu, 25 Jul 2024 11:09:17 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: lib: remove strscpy test
Date: Thu, 25 Jul 2024 16:09:04 +0500
Message-Id: <20240725110910.662147-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strscpy test loads test_strscpy module for testing. But test_strscpy
was converted to Kunit (see fixes). Hence remove strscpy.

Fixes: 41eefc46a3a4 ("string: Convert strscpy() self-test to KUnit")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/lib/strscpy.sh | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100755 tools/testing/selftests/lib/strscpy.sh

diff --git a/tools/testing/selftests/lib/strscpy.sh b/tools/testing/selftests/lib/strscpy.sh
deleted file mode 100755
index be60ef6e1a7fb..0000000000000
--- a/tools/testing/selftests/lib/strscpy.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-$(dirname $0)/../kselftest/module.sh "strscpy*" test_strscpy
-- 
2.39.2


