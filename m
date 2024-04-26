Return-Path: <linux-kselftest+bounces-8932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F988B3E41
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 19:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F6B2649A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1016F0D4;
	Fri, 26 Apr 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ybaW9O92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E742115CD51
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152652; cv=none; b=gOJ/roMPnqHkCOK7ZQEw79Feu8OYbnsyyPvIUQ2LhHY85/cGd+suOC/dR+zv7dL672NhLxtdwq4lMjO6BzLVhPiDRkqUzysOUoq2HfJj8NGjSkkrOxRwDchSGA8o71Y4gNE7zXl/az53rnkyZheI7SwcNSJh/mQoPpCSQqOWyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152652; c=relaxed/simple;
	bh=XmyroCOnmviDu4Ck4ZtK15VVLAuJClkARAyXC4T8ES0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEGbC5jddSA4J91ZUBXdeFOtOrpM9x0//qqplbVvIlkahZYjox3BkD+u+iQy715WQEvylPib0oiCaF+StaEA/Y8BJvezWEHbsDRP34xIeDKiE8XCxnzQWeQh3X7MJ2g9Dqk4o2tPAgTXa4o7IvK8nBM88kn0Wz0rPcdp6n8Pwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ybaW9O92; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VR0150jMtz8QN;
	Fri, 26 Apr 2024 19:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714152184;
	bh=XmyroCOnmviDu4Ck4ZtK15VVLAuJClkARAyXC4T8ES0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ybaW9O92jMrO9fZeWdXMslpug+ijbruA5Vzjynavgy5KJICYZsnZePbTVT9ZXpech
	 GUKr96JbQGfadFMuaKTNbNaOlMfD7ZyGpzSElvOCPIj0vzVkJ7TrEihC02+aLSRphb
	 u+SweEFJO0UnezdX/vTvUbf+Zn+cszBf3O2i4Nl4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VR0141kwvzdNd;
	Fri, 26 Apr 2024 19:23:04 +0200 (CEST)
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
Subject: [PATCH v1 1/5] selftests/pidfd: Fix config for pidfd_setns_test
Date: Fri, 26 Apr 2024 19:22:48 +0200
Message-ID: <20240426172252.1862930-2-mic@digikod.net>
In-Reply-To: <20240426172252.1862930-1-mic@digikod.net>
References: <20240426172252.1862930-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Required by switch_timens() to open /proc/self/ns/time_for_children.

CONFIG_GENERIC_VDSO_TIME_NS is not available on UML, so pidfd_setns_test
cannot be run successfully on this architecture.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Fixes: 2b40c5db73e2 ("selftests/pidfd: add pidfd setns tests")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240426172252.1862930-2-mic@digikod.net
---
 tools/testing/selftests/pidfd/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pidfd/config b/tools/testing/selftests/pidfd/config
index f6f2965e17af..6133524710f7 100644
--- a/tools/testing/selftests/pidfd/config
+++ b/tools/testing/selftests/pidfd/config
@@ -3,5 +3,7 @@ CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
+CONFIG_TIME_NS=y
+CONFIG_GENERIC_VDSO_TIME_NS=y
 CONFIG_CGROUPS=y
 CONFIG_CHECKPOINT_RESTORE=y
-- 
2.44.0


