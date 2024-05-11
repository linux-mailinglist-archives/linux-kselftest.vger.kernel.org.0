Return-Path: <linux-kselftest+bounces-10102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01EF8C32C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 19:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FB71C20DD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340CE53E36;
	Sat, 11 May 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yrDpfYn5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599321BF50
	for <linux-kselftest@vger.kernel.org>; Sat, 11 May 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447707; cv=none; b=VBqyikoMiTh66uV04Bg4Jwh+9c3D2796yV06ACkHnxGepPhkMr/zxIY7GeyKKnummFEQVwDPWv0/4x9LpB4XMwLAm1nz5ZVR0MCF+N4ubgG0d1TU8ChR73rRWcl3PKw2lpy+lPunGDY2vakuug5rjXEfZgYdCanNdW6KOUX7iy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447707; c=relaxed/simple;
	bh=6guh9BQ5rVONa/bVyJCE/mpvREYMTA6JDcfQf6vaLP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhevbsTspPduMke5DlwERT3ZWCtIuLzU6ld84lKKL0CdVYwtDDtOATz0gcGwFQQmv7yj98stA0d6om4uR9lh8jAVdg/LvIDrdiiD7ulq9TCXyAl6o2SH93T6FTD1EoMMF2Fp4GoweECbSlfcrjhZColoJiXUTZesIgCi9fkDfVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yrDpfYn5; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VcC6s2hVRzlMR;
	Sat, 11 May 2024 19:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715447701;
	bh=ItMTZYFsQr6hEmRCd+hw3M8K9T4Nec7f+7qfQcftklE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yrDpfYn5sBSTPp2UkPB4Uhtvy93ocHWXxkXIgH5aOxQpuhJhFd4X3Yk0NksyC6VeV
	 bQBRZN2nlNnP6Yie9El0d0KYRTBkqtH47MhExd9rLSiBGE4ON9C7JgmB1zNeRR+zFV
	 hEtC9AWfiMligrgX+qFyIi2DtUvYY20tndoaIPVw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VcC6r58Z8z9Rg;
	Sat, 11 May 2024 19:15:00 +0200 (CEST)
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
Subject: [PATCH v7 08/10] selftests/harness: Share _metadata between forked processes
Date: Sat, 11 May 2024 19:14:43 +0200
Message-ID: <20240511171445.904356-9-mic@digikod.net>
In-Reply-To: <20240511171445.904356-1-mic@digikod.net>
References: <20240511171445.904356-1-mic@digikod.net>
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

Because this _metadata is used by the new XFAIL_ADD(), use a global
pointer initialized in TEST_F().  This is OK because only XFAIL_ADD()
use it, and XFAIL_ADD() already depends on TEST_F().

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Will Drewry <wad@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240511171445.904356-9-mic@digikod.net
---

Changes since v6:
* Use a global pointer per TEST_F() and complete build of the
  __test_xfail object in the xfail constructor to fix XFAIL_ADD():
  https://lore.kernel.org/r/202405100339.vfBe0t9C-lkp@intel.com/

Changes since v4:
* Reset _metadata's aborted and setup_completed fields.

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/kselftest_harness.h | 26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 201040207c85..28415798fa60 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -430,19 +430,19 @@ static inline pid_t clone3_vfork(void)
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
+	static struct __test_metadata *_##fixture_name##_##test_name##_object; \
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
+		_##fixture_name##_##test_name##_object = object; \
+		__register_test(object); \
 	} \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
@@ -850,11 +850,12 @@ struct __test_xfail {
 	{ \
 		.fixture = &_##fixture_name##_fixture_object, \
 		.variant = &_##fixture_name##_##variant_name##_object, \
-		.test = &_##fixture_name##_##test_name##_object, \
 	}; \
 	static void __attribute__((constructor)) \
 		_register_##fixture_name##_##variant_name##_##test_name##_xfail(void) \
 	{ \
+		_##fixture_name##_##variant_name##_##test_name##_xfail.test = \
+			_##fixture_name##_##test_name##_object; \
 		__register_xfail(&_##fixture_name##_##variant_name##_##test_name##_xfail); \
 	}
 
@@ -1181,6 +1182,9 @@ void __run_test(struct __fixture_metadata *f,
 	/* reset test struct */
 	t->exit_code = KSFT_PASS;
 	t->trigger = 0;
+	t->aborted = false;
+	t->setup_completed = false;
+	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
 	if (asprintf(&test_name, "%s%s%s.%s", f->name,
-- 
2.45.0


