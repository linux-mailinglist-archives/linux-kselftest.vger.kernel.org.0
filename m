Return-Path: <linux-kselftest+bounces-9535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D218BD367
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0391F2148B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F415A4B6;
	Mon,  6 May 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="GgZMq+yo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725E1598FC
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014542; cv=none; b=YmJz9d+h2+CrIQSIzF8XfHghRv6h+NXkh6oDvp1zLMoWm5QXs6xID3HkSuIykwmfFWxurXONdjTaNp/HV0JqMuqtEcS1yjb4fJ6v6TiqXqHFMkeimTFl6nnk0OuOqSyuouxqfsvvHQ6I61KGxO3Gogm5nSSKBJXnboWQIn0jNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014542; c=relaxed/simple;
	bh=bX9I1ibW0C+6EYQnikkxNXNDSRcbJnaxyC+EsmTnLbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU7Td6RInmymzjuiZAYWleBZTWtGUvXrJUlBnBkYA2HOEBvR+9BgesPkxmNPJC9jgsdh1fvPs7lmpnPeJ+I7BYL1jaDl2ru7nDwc7qg4amYlXYkomHDbMwibN3WOLbKFRY9dIlaLSmBwuXjctCcTchNypzutwN+2XTjBbABs+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=GgZMq+yo; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VY6wj0j4Pz3Z6;
	Mon,  6 May 2024 18:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1715014532;
	bh=bX9I1ibW0C+6EYQnikkxNXNDSRcbJnaxyC+EsmTnLbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgZMq+you18f3OijPouZ8Kb9i0I5C0sjg2brWBqEk4YAZOKX18dXhzstmE6JmN0RF
	 uPxkrKWErq3spxuBQy3W9iq6KbRJyv1H5oQfjfY7rrEBMt55Lw1CWCy4BP8RhCC6cg
	 wed2FQPCzm+aUz+rOgNmiPmy2Mrnwq99gWMCOlys=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VY6wh29ZNzQFb;
	Mon,  6 May 2024 18:55:32 +0200 (CEST)
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
Subject: [PATCH v6 08/10] selftests/harness: Share _metadata between forked processes
Date: Mon,  6 May 2024 18:55:16 +0200
Message-ID: <20240506165518.474504-9-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20240506165518.474504-9-mic@digikod.net
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


