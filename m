Return-Path: <linux-kselftest+bounces-9066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6628B61E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9061C21358
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A1913C8EA;
	Mon, 29 Apr 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="M8CMfpj1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68013C68A
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418367; cv=none; b=kMpg1f9H2mHjqniHVG5u/El1kpIIo1lb4pMiYoIGTSF8wTN0QdRX5qHCVtslv1DAwPYhKUI5xN0j8v3vOo+OAr+9IW3/0dlG3CCx8g+e9ZVgiYCRNTDy7jPRzhyjW0klelurA40qHPVtYI4/onZ/tQWEteboYsg6Fdl2bSUYz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418367; c=relaxed/simple;
	bh=3PXhxV7iXwVfyBsouE+oC23MF65qM+eZR7kMA49Oe2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKcIsQ8c167YAqXP1Eqo40qU1/7UGnKfR26USV/bhVNN+JGCYtgjn3ahBuM4nACoqCZeHorKBguXm5OJdrrfCQlLjYLAkOE+Wb15PYPe8DrhI0CWgFVOIbG4ZoolF+wy1XprfJxjxE9OW9geST8krmMZB1Dr7ZL6NkJh4iotqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=M8CMfpj1; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VStRv0dmzzCTK;
	Mon, 29 Apr 2024 21:19:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714418362;
	bh=3PXhxV7iXwVfyBsouE+oC23MF65qM+eZR7kMA49Oe2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8CMfpj1OT5bUx1X0iG6sJ409K/5jXoYP9l431ZQqVxYSgbIFO8GxqSowRMASLcmM
	 /D+uQppb1BHgHFBtunS1XH/NvP/Dk+syLdQMsAu/3QH0FqT9pXMifVwvOHwmRiiH1U
	 fsgm5Kwsys0ttBfdiunMjFerVtbMjxKUbP9Vgu4E=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VStRt3TLWzXPb;
	Mon, 29 Apr 2024 21:19:22 +0200 (CEST)
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
Subject: [PATCH v3 8/9] selftests/harness: Share _metadata between forked processes
Date: Mon, 29 Apr 2024 21:19:10 +0200
Message-ID: <20240429191911.2552580-9-mic@digikod.net>
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

Unconditionally share _metadata between all forked processes, which
enables to actually catch errors which were previously ignored.

This is required for a following commit replacing vfork() with clone3()
and CLONE_VFORK (i.e. not sharing the full memory) .  It should also be
useful to share _metadata to extend expectations to test process's
forks.  For instance, this change identified a wrong expectation in
pidfd_setns_test.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Will Drewry <wad@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429191911.2552580-9-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/kselftest_harness.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 201040207c85..abf2ffd2094f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -430,19 +430,17 @@ static inline pid_t clone3_vfork(void)
 			kill(getpid(), WTERMSIG(status)); \
 		__test_check_assert(_metadata); \
 	} \
-	static struct __test_metadata \
-		      _##fixture_name##_##test_name##_object = { \
-		.name = #test_name, \
-		.fn = &wrapper_##fixture_name##_##test_name, \
-		.fixture = &_##fixture_name##_fixture_object, \
-		.termsig = signal, \
-		.timeout = tmout, \
-		.teardown_parent = false, \
-	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
 	{ \
-		__register_test(&_##fixture_name##_##test_name##_object); \
+		struct __test_metadata *object = mmap(NULL, sizeof(*object), \
+			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
+		object->name = #test_name; \
+		object->fn = &wrapper_##fixture_name##_##test_name; \
+		object->fixture = &_##fixture_name##_fixture_object; \
+		object->termsig = signal; \
+		object->timeout = tmout; \
+		__register_test(object); \
 	} \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-- 
2.44.0


