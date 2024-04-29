Return-Path: <linux-kselftest+bounces-9011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8B8B599E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73DAB24443
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 13:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF754FAB;
	Mon, 29 Apr 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Oa1NumE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423D53E08
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396188; cv=none; b=Xh+BFJawbG//RC8ORUOe//tms4h5W2gliQdDEfZgvujoNB7AWeGLrkydBVWmXSiO3HLIS0aWGhTlctHI0BdIUim44YCqlVseQ5Egmnu1H34+n/NX0SVt9dNtE+rfdUyMxBsli7TD6QBZWfrPnH1YNxom2TXc4Fr7Cn9vRaFslks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396188; c=relaxed/simple;
	bh=jU/EetW3hME+8bN/y9Bc1UJ0jwLikMjBwMhwVsjcUPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoPKCMC485EdA05NXoSfb4Wd9jKSVOMcFmmEsFqp98ENrnTulp3h3kiZo8TzggV/wE+Ya1EEuryRsKnMyCMl4rxZO04JlTxNlRlN1ldnjQBpPXlDnDZZIPqs+tBGlHesfD9FUiqMoDvnwggUhzphFbM0nI+eRixOUDUxC0i3z5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Oa1NumE3; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSkFG6Nm1zD1p;
	Mon, 29 Apr 2024 15:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714396178;
	bh=jU/EetW3hME+8bN/y9Bc1UJ0jwLikMjBwMhwVsjcUPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oa1NumE3f0vHUhyXi3UuuMQJFN7lKI+CIfr0LYUX/MBskFe/uAgctxDHzS2jrRVJJ
	 +N0VoBP9u/lneyCoYVZBnoCkGCRGLKG/DRtwdDJ6L0WEUx/fJvHo22Dbzvu59HRXzg
	 ZmzTCCynzf66jEVrK1ovYuGp6u3fes5th2lGgX84=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSkFG2zc1zKXB;
	Mon, 29 Apr 2024 15:09:38 +0200 (CEST)
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
Subject: [PATCH v2 1/9] selftests/pidfd: Fix config for pidfd_setns_test
Date: Mon, 29 Apr 2024 15:09:23 +0200
Message-ID: <20240429130931.2394118-2-mic@digikod.net>
In-Reply-To: <20240429130931.2394118-1-mic@digikod.net>
References: <20240429130931.2394118-1-mic@digikod.net>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429130931.2394118-2-mic@digikod.net
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


