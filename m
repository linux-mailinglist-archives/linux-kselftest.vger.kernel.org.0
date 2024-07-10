Return-Path: <linux-kselftest+bounces-13416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A6C92C6D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 02:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BE11C221F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 00:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2CD2F29;
	Wed, 10 Jul 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC9Lqqoj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F524381C4;
	Wed, 10 Jul 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569745; cv=none; b=OlcLDS4dMla9Kr1SgtowNuknqIcNVKg1TM9LcTlbnFSoxyvuVnHNc+2ui7tSZopLlHqgbGGhYn3rFbS48sYENiJZ51fsDZCJRNzCrOhv97mILG6e9ughaZ8+KAgmes8xtYfIyu0A2PumJJUEgOiZYCTosWkZPGUpD64y9w2+E6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569745; c=relaxed/simple;
	bh=dNkV6tukVgBwu5V2LMKcR/mlV+qm2kWi8I5WE8thKuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKehZ4YKaZLu4iyljbNj0dw8XVSxHUkezo5n28YvDW3M8/nyfEPvr56LxmxAVzEBd41abNBYxWK9jUhwOE/jAvNbJGsyd0oKS9DrZuAiS01+Cr4XEyDI28vsuxC81rP/NvlkVlacPJGjZ0Zn4UYbOnJsiZrizpq+PQ+bOuX0Exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC9Lqqoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23224C3277B;
	Wed, 10 Jul 2024 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720569745;
	bh=dNkV6tukVgBwu5V2LMKcR/mlV+qm2kWi8I5WE8thKuw=;
	h=From:To:Cc:Subject:Date:From;
	b=pC9LqqojU87wv5uf7qin8GD0jKwBd4pPReW6XGz1G6Nr7dj2R3kzY3QAREejXjo4G
	 ys+OsZ998graE72eGMTSh3NRMYVxk/AVy5VDMf4bTryGyQqQRt7eKOvPNnWoaoACuc
	 oDVn+pU2P3tUK2cs/JFsahwdc4LpMa6v1ToKOam827lgqVRIhlyBFyg6Wc3uylVYub
	 qul4YuECKKxjJ/VJd0ke9uXEf60KYKbHsnZnsjSzpNJT+NVUclDhsYJ33b9mQ7HNUN
	 wlR42AfciBCE9rTzUtZ85gvIxRGw0shgpoDZTRe9PgXfapBrF6OC5DiO7/oj09kp2d
	 Wa0T0sMPKf9pQ==
From: Kees Cook <kees@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kunit: executor: Simplify string allocation handling
Date: Tue,  9 Jul 2024 17:02:24 -0700
Message-Id: <20240710000220.work.852-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517; i=kees@kernel.org; h=from:subject:message-id; bh=dNkV6tukVgBwu5V2LMKcR/mlV+qm2kWi8I5WE8thKuw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjc+PZXJJxRbINPefVtIME+9yZdeKBzJ1iW3C1 eyTnqWYXv+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo3PjwAKCRCJcvTf3G3A JsktEACKVc0OYnuXoXkPh2yb8Fr4ex1k37Ezhl9eRNlb4NQVk6k8oN/0XFwbab71eNM51R4f60w RLoi4J7xBLL6Ne8k0NrEftneM2Gt8ESEH7o5rxtLR33biHZ7401jxXjwWMM6WdQbwrqjUARmntu WBaG/Ejzuy1SkeZFatHPYIUHO1BMHLnTgsiTqiCdnW4LcTcX7M1nuEeJvoLx0VxblwWYYdHMzj9 eow2m4n2jpZWZajZBE1tmAlyi4jjqERMMVBs8w4ehLFHrQvbuobjyJv3T/AV6edIGMEQkgr37br aD0y323b8Q8zCjBtBRaGVue4AqpuYpwHMd68Vl2D00Sb8FCdKfiTawxU5dF5VfjswhDSaFYv2k1 HV2wTpFC5+jc3JMBaF4HOw8dDrMnWF7xymP9dZgk+ZqQt+lpWNDYtgQp1DbWSsS6MuXE4Y6y/cT plVLC4THbNAUInTPTSmBMHGwlSyyX2w6MMZoGxJcLu5sDPv31pM/EnhoBUw2Q1xL23KIq2NpW7K y5ERKXqvD/17uX9APz33dS4diZN4oNG7Dua5PVR7rXjyu2swmcTJ7KoSGH8QKCwocmY9O8AkYEH fSj+yvz5+Ikp6GheeY8N3TlM0lxBSkS00BEp4zvZDSrPYm1XLIPi78rgkisVVNwdR/XrMug8ave BRtStD7wdi/l8
 +w==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The alloc/copy code pattern is better consolidated to single kstrdup (and
kstrndup) calls instead. This gets rid of deprecated[1] strncpy() uses as
well. Replace one other strncpy() use with the more idiomatic strscpy().

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
---
 lib/kunit/executor.c      | 12 +++---------
 lib/kunit/executor_test.c |  2 +-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 70b9a43cd257..34b7b6833df3 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -70,32 +70,26 @@ struct kunit_glob_filter {
 static int kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
 				    const char *filter_glob)
 {
-	const int len = strlen(filter_glob);
 	const char *period = strchr(filter_glob, '.');
 
 	if (!period) {
-		parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
+		parsed->suite_glob = kstrdup(filter_glob, GFP_KERNEL);
 		if (!parsed->suite_glob)
 			return -ENOMEM;
-
 		parsed->test_glob = NULL;
-		strcpy(parsed->suite_glob, filter_glob);
 		return 0;
 	}
 
-	parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
+	parsed->suite_glob = kstrndup(filter_glob, period - filter_glob, GFP_KERNEL);
 	if (!parsed->suite_glob)
 		return -ENOMEM;
 
-	parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
+	parsed->test_glob = kstrdup(period + 1, GFP_KERNEL);
 	if (!parsed->test_glob) {
 		kfree(parsed->suite_glob);
 		return -ENOMEM;
 	}
 
-	strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
-	strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
-
 	return 0;
 }
 
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 3f7f967e3688..7191be9c4f9b 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -286,7 +286,7 @@ static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 
 	/* We normally never expect to allocate suites, hence the non-const cast. */
 	suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
-	strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
+	strscpy((char *)suite->name, suite_name);
 	suite->test_cases = test_cases;
 
 	return suite;
-- 
2.34.1


