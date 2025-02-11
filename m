Return-Path: <linux-kselftest+bounces-26359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD27A30D01
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 14:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA371887805
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E11FAC4A;
	Tue, 11 Feb 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0/mPYFNx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C092206B8
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280778; cv=none; b=V2z2zfWi2wjblJBvAfdAnWpA8jkrC3X03lMmeB+NQk97+6mfx5p1OnuAlAysDRmV2EuxBo989LPHGhRoiBDyURpz8n44AqQfs5lifqbPIf2Z0ZUmVlvwTW8D5uY6kFL8xLbfwntrjtV9O3R1xzgBSqkmhLVPJ5nBQbTec+6krEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280778; c=relaxed/simple;
	bh=foLtz4YAIIZIFxsL+bD71O1Y2wSQEYbhjmhB/7tGWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5xBbO4yt8wB2BZqQyP7QI9AfuLkSR+gXBqcYFv+FSLd2j8n96WK13kvb8afNYp61UqmDurQlL9IpUSZ5dEnDC/BSkH9z2BSLABATbg7q1AfX0Dfqr3DbVWNj/JVbFGjmY3k0ZhUR9nhRqbgdWwYIrWhLTWNFEE/x2HlfOsoZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0/mPYFNx; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YshzD21WVzpvH;
	Tue, 11 Feb 2025 14:26:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1739280360;
	bh=oEI1dLX3z3WnJRwXX4fVmgXzFsVcJphDLTIJHUJ5OaE=;
	h=From:To:Cc:Subject:Date:From;
	b=0/mPYFNx54hTAEE2qfyb6AIN2Yv/hJLqox9Y4CTypfHJpJlYTZLwS2QdivihjFr9b
	 T1c9jKE1H5gT0FZWNxQd38Gzsl5JaqIexJ8aRt60CErdlukY7gYDxJ43BK5m4v+ZAA
	 7ti0ZrOEoLZ2fGNSweznagWQZKo46EPXdMfhelx0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YshzC5mr4zCjj;
	Tue, 11 Feb 2025 14:25:59 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Florent Revest <revest@chromium.org>
Subject: [PATCH v1] selftests/landlock: Enable the new CONFIG_AF_UNIX_OOB
Date: Tue, 11 Feb 2025 14:25:28 +0100
Message-ID: <20250211132531.1625566-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Since commit 5155cbcdbf03 ("af_unix: Add a prompt to
CONFIG_AF_UNIX_OOB"), the Landlock selftests's configuration is not
enough to build a minimal kernel.  Because scoped_signal_test checks
with the MSG_OOB flag, we need to enable CONFIG_AF_UNIX_OOB for tests:

 #  RUN           fown.no_sandbox.sigurg_socket ...
 # scoped_signal_test.c:420:sigurg_socket:Expected 1 (1) == send(client_socket, ".", 1, MSG_OOB) (-1)
 # sigurg_socket: Test terminated by assertion
 #          FAIL  fown.no_sandbox.sigurg_socket
 ...

Cc: Florent Revest <revest@chromium.org>
Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 29af19c4e9f9..361f94f8cb0d 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,3 +1,4 @@
+CONFIG_AF_UNIX_OOB=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_INET=y
-- 
2.48.1


