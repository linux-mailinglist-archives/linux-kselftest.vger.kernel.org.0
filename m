Return-Path: <linux-kselftest+bounces-49050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BDFD26CC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 18:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C901632E4819
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B83D1CCA;
	Thu, 15 Jan 2026 17:28:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2A3D1CCB;
	Thu, 15 Jan 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498133; cv=none; b=GtyJ1i2ydMb/RWwAuhts9HDM75pjEPu1KpCuxHmwaPY+vTnCfjh8q6G+xr/8RmU+ZRTpQVAxYO6nrOXFMdcDiox3lcr35g8Oy+t/3+JaDZShJoJ6It2oAUlcDQZTYWZAraTu9jzjGlWY6QCVtjyZfQx1nb4uA3EvQXKjODCAuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498133; c=relaxed/simple;
	bh=f6jB26jzU7LFG/GILymYwWHxRrZklpfv2A08qDAVcE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnx92A7ca/KFyXKXgUz/hO+I72PuL+lk1PhvX4a3iVOGa+DUhyvbQf44/oyNlX0uDtGa0Nr6/DS9OPhMwZ5LxMKVA/YNNKeFO8uW8YtBZTVPrrW45TUcrPbYQNnDiRsvI2WmLrCw+9N6mMeq+vj7aBFbpNgU8S98zvMStKvkUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH RESEND] docs: kselftest: remove link to obsolete wiki
Date: Thu, 15 Jan 2026 17:24:44 +0000
Message-ID: <20260115172817.7120-1-bacs@librecast.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the reference to the obsolete kselftest wiki.

The kselftest wiki is marked obsolete and is no longer updated. The last
edit was in 2019, and the information is outdated, referring readers for
support to IRC networks that have not been used for years, and to kernel
versions that are no longer supported.

If there is any relevant information left in the wiki it needs to be
cleaned up and moved into the canonical kselftest documentation here.

Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
Original: https://lore.kernel.org/linux-doc/20250824075007.13901-2-bacs@librecast.net/
---
 Documentation/dev-tools/kselftest.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 18c2da67fae4..e13aff7a80b5 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -15,11 +15,6 @@ able to run that test on an older kernel. Hence, it is important to keep
 code that can still test an older kernel and make sure it skips the test
 gracefully on newer releases.
 
-You can find additional information on Kselftest framework, how to
-write new tests using the framework on Kselftest wiki:
-
-https://kselftest.wiki.kernel.org/
-
 On some systems, hot-plug tests could hang forever waiting for cpu and
 memory to be ready to be offlined. A special hot-plug target is created
 to run the full range of hot-plug tests. In default mode, hot-plug tests run
-- 
2.52.0


