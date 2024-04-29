Return-Path: <linux-kselftest+bounces-9065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2268B61E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A8A1F23B63
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518013C691;
	Mon, 29 Apr 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HkFsXhyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78A13BC0B
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418366; cv=none; b=IeBqiKFHqvPd7zesMjr3jkJyN6PY1VIMJ9vC7wL5AWJ29o+/muARFoSFNI+YQt3/P4dqnhFzLT3zqHrInQcUsaxNC9nAqt0VIozim9qwE2xsWcUmpKXPzRKLUsZAk/ZAFugY/sFxTydpoV5V1zesOrsgQiluzg+vm1cq6Xo92ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418366; c=relaxed/simple;
	bh=8sa48kjmxhX24SgrO37sT/zldbxAU6rathoZxgt9xR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj702YJchfng7zJ8I0hYMh73qz5tcBwcfk23AZZuzxHGjHzjVZhWnibjJmCLVuXQDF2syxobcTdwZgYIVveW34Yx5+lkRX1N1MQUT9hO09+W9LJNTBT5g1gatYHHXk2KuvpebNt0QrUWiiy+VylBxaEbWZLC5gNECZKXgqd53ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HkFsXhyp; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VStRs56WfzNkn;
	Mon, 29 Apr 2024 21:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714418361;
	bh=8sa48kjmxhX24SgrO37sT/zldbxAU6rathoZxgt9xR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkFsXhyp2LfRAwGPsD1wHqfeIFW3ltVU0A0bxstCX5AB+xPr8IRid8BDNtKdpXGGc
	 KPJkE55WCKEYsHnGfkfG4PGFrAzTMAuIhvXXfDAd9yzSM1+GDQYt10VdZk1fyyNArA
	 RAUBr1FgJLtcqofeaQcdT/UQf3vRtHYeNg6WgVMY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VStRs15cNzGVt;
	Mon, 29 Apr 2024 21:19:21 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 7/9] selftests/pidfd: Fix wrong expectation
Date: Mon, 29 Apr 2024 21:19:09 +0200
Message-ID: <20240429191911.2552580-8-mic@digikod.net>
In-Reply-To: <20240429191911.2552580-1-mic@digikod.net>
References: <20240429191911.2552580-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
which will be actually tested on the parent and child sides with a
following commit.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429191911.2552580-8-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 6e2f2cd400ca..47746b0c6acd 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -158,7 +158,7 @@ FIXTURE_SETUP(current_nsset)
 	/* Create task that exits right away. */
 	self->child_pid_exited = create_child(&self->child_pidfd_exited,
 					      CLONE_NEWUSER | CLONE_NEWNET);
-	EXPECT_GT(self->child_pid_exited, 0);
+	EXPECT_GE(self->child_pid_exited, 0);
 
 	if (self->child_pid_exited == 0)
 		_exit(EXIT_SUCCESS);
-- 
2.44.0


