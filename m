Return-Path: <linux-kselftest+bounces-18965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF44198F154
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911981F22898
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7719E827;
	Thu,  3 Oct 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0BHyqTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5B13D245;
	Thu,  3 Oct 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965420; cv=none; b=arm5iF4HFIuUFsq7xIpBRGhbUJLYmO5dCG4QHEE1xLc4RbQp6jZOx4c7JFkOG0KPFL7Ot+HT28GARw5r9nNLnBBXkZxiBj30IjYpC48Cdyr8mWkxwwmn3NK/orMsSJk8lu/HRvypGY36IBNTyUuP37PxA0f/pQ1e3scQG6J6AcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965420; c=relaxed/simple;
	bh=BKgB/5lFO1xe6yu9KKgAu+74BzMb6DlNrjtTZ4KyA7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ha3eoK6itBJ3io8KY8/FnPJfhyfv4V9KQnR14c8PlTqiPyjRtsfTrCOkOHat6YRJ4QWuB+fQpwMmWqi6e5CrtG72NXp5hWvC4DxvL8s19rxE/+J9c4qG4beYvVvN+HDqQHEGoa+kXUL0DuVlLmkl2hLk8MeyMJBxncsu6zmm1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0BHyqTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3476AC4CEC5;
	Thu,  3 Oct 2024 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727965419;
	bh=BKgB/5lFO1xe6yu9KKgAu+74BzMb6DlNrjtTZ4KyA7s=;
	h=From:To:Cc:Subject:Date:From;
	b=f0BHyqTcZufojAj0RzUY92Ljm5WkiXniyc+JndxGa8B4O5g74zFBNMnzzmWM/vz2T
	 Rh96mO+Qil0BSvD1VoNwQkR/kW3iJS+P+TJJRhy+iWryKBteCguRBmUoAa4wBMIa6v
	 BMMaWm21n+QXLHpZgPSC754hB9yVQmlw8TUNEHU+gdtYFhFpTGlIbUrtaUuPWQnF/t
	 B2XckER9Q6lwx2tMhkoWx+wW/eVDZmGgHnNYPMYjPDywgWjWAV/96krD4jLtXTZlEQ
	 WQP716e8n6a/9jtzUVQjIS2EUoeJKxWa314GkLtYcPaQ2o9MLI2g3WqOMNi7oWIOix
	 rqKG6i4w4y5Ag==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [RFC] MAINTAINERS: split kselftest entry into 'framework' and 'all'
Date: Thu,  3 Oct 2024 07:23:28 -0700
Message-ID: <20241003142328.622730-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The testing effort is increasing throughout the community.
The tests are generally merged into the subsystem trees,
and are of relatively narrow interest. The patch volume on
linux-kselftest@vger.kernel.org makes it hard to follow
the changes to the framework, and discuss proposals.

Create a new ML for "all" of kselftests (tests and framework),
replacing the old list. Use the old list for framework changes
only. It would cause less churn to create a ML for just the
framework, but I prefer to use the shorter name for the list
which has much more practical use.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Posting as an RFC because we need to create the new ML.

CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: workflows@vger.kernel.org
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..9a03dc1c8974 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12401,6 +12401,18 @@ S:	Maintained
 Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
+F:	tools/testing/selftests/kselftest/
+F:	tools/testing/selftests/lib/
+F:	tools/testing/selftests/lib.mk
+F:	tools/testing/selftests/Makefile
+F:	tools/testing/selftests/*.sh
+F:	tools/testing/selftests/*.h
+
+KERNEL SELFTEST TESTS
+M:	Shuah Khan <shuah@kernel.org>
+M:	Shuah Khan <skhan@linuxfoundation.org>
+L:	linux-kselftest-all@vger.kernel.org
+S:	Maintained
 F:	tools/testing/selftests/
 
 KERNEL SMB3 SERVER (KSMBD)
-- 
2.46.2


