Return-Path: <linux-kselftest+bounces-1857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E34811F34
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 20:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28D2B211DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E368294;
	Wed, 13 Dec 2023 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNVPlWMr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E9F5
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:44:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ddd64f83a4so60446087b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496673; x=1703101473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7slFoawBCWkwzVSxACwTipDmNbMlYPdhOIzkAqH/aFw=;
        b=uNVPlWMr+Ahy/amoC39Sf5szLLwYzyOXxFBpwDI1N93AQEE1r4tL7KJUbF/aOipRsg
         cGY0zoNyX2H1G1E6+Wb5ZVjaCU3zjZyt84/xNVvKoS76CEpNov2kWuPqh+m3PZnMXXfa
         VRvyi7YRfNa07k9rLGg4e1KVoK3ggj0fDs/dPIOlh2DonBjwa+WpcNqo7Lj8D1I5IQfu
         UCZzFXlG0aFDMPoXtAhSLJV065Bom+ziG/LHPGWoNLtVtPm1/91aFBE2kUnrLP2oMjG7
         c/rn7Eqx0WyDa3JmddT6+KzX+AMax+z2eVRUEO4SJNzVfhTG4SLFZ1IgJkReeWdTXUeK
         PMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496673; x=1703101473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7slFoawBCWkwzVSxACwTipDmNbMlYPdhOIzkAqH/aFw=;
        b=viJTVT+yvzyWFRCnCzuTV7UioLMGiIaVoBGrmUhbHcnAAfS4LXpHGzSpOotOiKbBhj
         rwBY5dDrjh3MCMnHXcwJHNJj3MjD+RkFVyUdgm5jcQZuzMkmJ+jAxZjnmKMPEPJSgUOd
         oMJIbZDjGA/QHHTnI3bSyhtZlVjYK/VpsurP810+Pvf7+Dfjvl7KMsp4LY0AbEo607k+
         ExhmrFcY5UeEE+DuHvykHuIw5YLxFe26FwUjWf7OuOogpbD5IdoRcfboaZMYuSyys8jz
         OEwk9ZHXC+cJu5vDpmhCgrU3Sy5H9mCCMRsV5R6FPWPwTn5JfpzZlHDJ2+fl1pXnfw+M
         pLTw==
X-Gm-Message-State: AOJu0YxfGNKwGJiJUbX5QzD1ZxotM7r+XeDacCvNVaghS2Qv7jP8/TiS
	B9ibEdbi1JjfLiHjoW0JMYNgdaUOHA==
X-Google-Smtp-Source: AGHT+IF9ad/J/uSSD1qUN7zly9T8SGdMfHHvTDpxfYMPa9v+aOBcNTJrZmczyJwsCd+j/YbaPbNKoTsJzw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:787:0:b0:d9c:801c:4230 with SMTP id
 b7-20020a5b0787000000b00d9c801c4230mr84320ybq.5.1702496673391; Wed, 13 Dec
 2023 11:44:33 -0800 (PST)
Date: Wed, 13 Dec 2023 19:44:19 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-4-rmoar@google.com>
Subject: [PATCH v5 4/6] kunit: add is_init test attribute
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add is_init test attribute of type bool. Add to_string, get, and filter
methods to lib/kunit/attributes.c.

Mark each of the tests in the init section with the is_init=true attribute.

Add is_init to the attributes documentation.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 .../dev-tools/kunit/running_tips.rst          |  7 +++
 include/kunit/test.h                          |  1 +
 lib/kunit/attributes.c                        | 60 +++++++++++++++++++
 lib/kunit/executor.c                          |  6 +-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 766f9cdea0fa..024e9ad1d1e9 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -428,3 +428,10 @@ This attribute indicates the name of the module associated with the test.
 
 This attribute is automatically saved as a string and is printed for each suite.
 Tests can also be filtered using this attribute.
+
+``is_init``
+
+This attribute indicates whether the test uses init data or functions.
+
+This attribute is automatically saved as a boolean and tests can also be
+filtered using this attribute.
diff --git a/include/kunit/test.h b/include/kunit/test.h
index fe79cd736e94..b163b9984b33 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -253,6 +253,7 @@ struct kunit_suite {
 	struct dentry *debugfs;
 	struct string_stream *log;
 	int suite_init_err;
+	bool is_init;
 };
 
 /* Stores an array of suites, end points one past the end */
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 1b512f7e1838..2cf04cc09372 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -58,6 +58,16 @@ static const char *attr_enum_to_string(void *attr, const char * const str_list[]
 	return str_list[val];
 }
 
+static const char *attr_bool_to_string(void *attr, bool *to_free)
+{
+	bool val = (bool)attr;
+
+	*to_free = false;
+	if (val)
+		return "true";
+	return "false";
+}
+
 static const char *attr_speed_to_string(void *attr, bool *to_free)
 {
 	return attr_enum_to_string(attr, speed_str_list, to_free);
@@ -166,6 +176,37 @@ static int attr_string_filter(void *attr, const char *input, int *err)
 	return false;
 }
 
+static int attr_bool_filter(void *attr, const char *input, int *err)
+{
+	int i, input_int = -1;
+	long val = (long)attr;
+	const char *input_str = NULL;
+
+	for (i = 0; input[i]; i++) {
+		if (!strchr(op_list, input[i])) {
+			input_str = input + i;
+			break;
+		}
+	}
+
+	if (!input_str) {
+		*err = -EINVAL;
+		pr_err("kunit executor: filter value not found: %s\n", input);
+		return false;
+	}
+
+	if (!strcmp(input_str, "true"))
+		input_int = (int)true;
+	else if (!strcmp(input_str, "false"))
+		input_int = (int)false;
+	else {
+		*err = -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	}
+
+	return int_filter(val, input, input_int, err);
+}
 
 /* Get Attribute Methods */
 
@@ -194,6 +235,17 @@ static void *attr_module_get(void *test_or_suite, bool is_test)
 		return (void *) "";
 }
 
+static void *attr_is_init_get(void *test_or_suite, bool is_test)
+{
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	if (test)
+		return ((void *) NULL);
+	else
+		return ((void *) suite->is_init);
+}
+
 /* List of all Test Attributes */
 
 static struct kunit_attr kunit_attr_list[] = {
@@ -212,6 +264,14 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_string_filter,
 		.attr_default = (void *)"",
 		.print = PRINT_SUITE,
+	},
+	{
+		.name = "is_init",
+		.get_attr = attr_is_init_get,
+		.to_string = attr_bool_to_string,
+		.filter = attr_bool_filter,
+		.attr_default = (void *)false,
+		.print = PRINT_SUITE,
 	}
 };
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 847329c51e91..717b9599036b 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -300,6 +300,7 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
 	struct kunit_suite_set total_suite_set = {NULL, NULL};
 	struct kunit_suite **total_suite_start = NULL;
 	size_t init_num_suites, num_suites, suite_size;
+	int i = 0;
 
 	init_num_suites = init_suite_set.end - init_suite_set.start;
 	num_suites = suite_set.end - suite_set.start;
@@ -310,8 +311,11 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
 	if (!total_suite_start)
 		return total_suite_set;
 
-	/* Append init suites and then all other kunit suites */
+	/* Append and mark init suites and then append all other kunit suites */
 	memcpy(total_suite_start, init_suite_set.start, init_num_suites * suite_size);
+	for (i = 0; i < init_num_suites; i++)
+		total_suite_start[i]->is_init = true;
+
 	memcpy(total_suite_start + init_num_suites, suite_set.start, num_suites * suite_size);
 
 	/* Set kunit suite set start and end */
-- 
2.43.0.472.g3155946c3a-goog


