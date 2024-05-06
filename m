Return-Path: <linux-kselftest+bounces-9529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA98BD344
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7761C21362
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122A157498;
	Mon,  6 May 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="u4m10Blc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA1157465;
	Mon,  6 May 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014533; cv=none; b=eaMB4JdQzDN1vT8gTXGuX6RmqDqvRKf40UzIaCDtEmaIuRTU0f841c69ERd6cXqiIuPJcZDLPHO9CPbp3At4HCUJMbDJ3JZ3QMlTaabZGYCb7ZxjfPAf9MRl8FF915LIUhUByyzxkHVkp54758BNbsYlK6fyUOVuhwi7TltDa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014533; c=relaxed/simple;
	bh=iBCwj0t4GNIgeQmAIxt4IPx4WRGLjw0mHHhbCHHB17s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trXjz1u1JyQSndtl9EnjaedPeVr57Tb7gKMdbAMTeFL0meWp/uPlLsfBi18fhbc5zL0fGEzfUeQ07bL2/XeXpmYrrRETbVwRX9oZeNW7dqZEmX/hThLOGwwk3FSWC9imWZ//MhDwdPFhkPd/OLhKsV3yrCO1fb0yz+scBeNdz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=u4m10Blc; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VY6wX46Rwz6XB;
	Mon,  6 May 2024 18:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1715014524;
	bh=iBCwj0t4GNIgeQmAIxt4IPx4WRGLjw0mHHhbCHHB17s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4m10Blc8C6ZITGURDlqr0irNhrm8ywQ/NWd+C3TjuixHq4kek240XNW9Nk8syNJD
	 XV9d7239Qju+yykMu00UMyt5ic0QdfMezWcEzwzV6V1qdey+s2L8+udw70ugSOTnIG
	 nJBZ/vQqqBYOmapQPB2SQiL+cF2IZbUl7JnUKaAc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VY6wW5NpmzxYD;
	Mon,  6 May 2024 18:55:23 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 01/10] selftests/pidfd: Fix config for pidfd_setns_test
Date: Mon,  6 May 2024 18:55:09 +0200
Message-ID: <20240506165518.474504-2-mic@digikod.net>
In-Reply-To: <20240506165518.474504-1-mic@digikod.net>
References: <20240506165518.474504-1-mic@digikod.net>
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

Cc: Shuah Khan <skhan@linuxfoundation.org>
Fixes: 2b40c5db73e2 ("selftests/pidfd: add pidfd setns tests")
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240506165518.474504-2-mic@digikod.net
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
2.45.0


