Return-Path: <linux-kselftest+bounces-9361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2008E8BAB39
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93B628367F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373C15445E;
	Fri,  3 May 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RfmW2Yhl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6D153832
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733924; cv=none; b=XonDpBzexfm1bFSl9y2bApmGUVu2lvKVHjnkbFVdxvC928rnqbCsKO4Y2oj8we/kx/gRdXcJpZVPoC6Vp8MAisz52V/XsN3B8exCHRoeyJzjSr5AQlgptx2/gPZMhAHvA1KOpPZEsmuhwlFXoQXEPznFmvxJM1rKfW8s7ORtses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733924; c=relaxed/simple;
	bh=2Y0nOVcRkIUq7/FBVt+wFbHUgDdz1Cx5Myja8BL91y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mC3lc587Scc3CYR8OpHpP+elwk2/nbSbEPETqhyBRrMEODCwZQuVFkhxA3t9n9XBvR17klI9tQSy/NBBOpvAEAn1RRQcFW9VqFmBQsMJqqPt5PGnQO/g1cnxbMFtZzMd18KuWdjHoMWlc70ZoVzZwUpgvwPuwzWwSSvK2p5B+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RfmW2Yhl; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VW78H4xfMzNjH;
	Fri,  3 May 2024 12:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714733919;
	bh=2Y0nOVcRkIUq7/FBVt+wFbHUgDdz1Cx5Myja8BL91y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfmW2YhlSvEvMhJ1eDX70f4rrmeBcgAdpNHcyq1KkAX4TpL7R0dTCy8vKfAw1nf2T
	 5RxGRCqOePu6j8kPEUc7KkiKnw6jjHSTXyIft9MaZM/ayY6Wdkjzs2zbt2WgDXFeiu
	 9XRKeMapi1lsAOmDHn1nVfnFGp4tee+jlmWl4+oU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VW78H1XrYzcTF;
	Fri,  3 May 2024 12:58:39 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 08/10] selftests/harness: Share _metadata between forked processes
Date: Fri,  3 May 2024 12:58:18 +0200
Message-ID: <20240503105820.300927-9-mic@digikod.net>
In-Reply-To: <20240503105820.300927-1-mic@digikod.net>
References: <20240503105820.300927-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20240503105820.300927-9-mic@digikod.net
---

Changes since v4:
* Reset _metadata's aborted and setup_completed fields.

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/kselftest_harness.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 201040207c85..ea78bec5856f 100644
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
@@ -1181,6 +1179,9 @@ void __run_test(struct __fixture_metadata *f,
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


