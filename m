Return-Path: <linux-kselftest+bounces-1777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E618810730
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036AB282341
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4A19C;
	Wed, 13 Dec 2023 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="012TB4M3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C69A1
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:22 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e2aa53a692so2559067b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429342; x=1703034142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfjrfaL0BTdFLEXX617pYnIT5bq+UfvN0h2MwzqxRag=;
        b=012TB4M3JqhrqJe3aHxlkb3DMPWqzzglnP9QkBZ5E6tkX5Ga/5UwMR8tegmkxDJr7j
         ybxLsL/Ba1HRYyxcAb1S5mN3drKEOt2u/fulzw5Vvp5xDPAraFGDp1VcMd1aM0rg3pnO
         SmE4Dv/mkn0J0+ZGOehRzhThlFU0VEUsOXzELdZoqJaRicgTxtnmodTpiQFlU8WGW6rz
         QJogVYIbTXMYcbfEkH+utGIJz/ELDGODJab5AKy8BAzO0OqNB0Cjcl/QydzBKAzhU9a8
         i4pQxWVzvPnvSDIWJSPlBNvDocqIiBfdfTCBwEh2kGMVJWVTBCrJ0Wl6k+Rscln0WUEt
         wgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429342; x=1703034142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfjrfaL0BTdFLEXX617pYnIT5bq+UfvN0h2MwzqxRag=;
        b=qgNmrby/oQosK74knfhOLpaLy5IIkCV1zz+HHad/9VTuunpyjFBG/bMbVz7m6FqR9s
         s5ViUXWfTrW8suW4ykNxyRFo+W5JrxjdJEz8NfVzBibZ4URe8/cYpej9hHk6+AwvsZVe
         izqsjaLIaV+WroGWvay24m+uQIsySTBAjAqQs87/PJq0zan6XqVlLe5auoRy+NKgT1le
         j7JLzslHvC4CLEZqGe/MtoT+PrWDO8Dg4lzAdAmwAeKPUY3Bv3vz8oAbxGawn6UTqV0u
         gzImOSDdLg45C9N/K508meIgMte6HDd7HjZcjFlgoDaZ2ccD+Nl2+FwiqHkdT7uJgOOi
         xrwQ==
X-Gm-Message-State: AOJu0Yzf5gpDD/zk+SW21vIFeVy1+MjlQfgM3uMTcppnqPFw9IbML5+n
	MfAON0AJZardSuMocRXZ+T/RVyx6gQ==
X-Google-Smtp-Source: AGHT+IHKS8I7E7al7xx+DrXZ1bHsOziWBRsHSWQY2crhQrHV4i/fuJxM2jEl001gihDtdyVtDetpU7vuMw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:fd5:b0:5d6:daf7:b53b with SMTP id
 dg21-20020a05690c0fd500b005d6daf7b53bmr60192ywb.9.1702429341847; Tue, 12 Dec
 2023 17:02:21 -0800 (PST)
Date: Wed, 13 Dec 2023 01:01:59 +0000
In-Reply-To: <20231213010201.1802507-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213010201.1802507-4-rmoar@google.com>
Subject: [PATCH v4 4/6] kunit: add is_init test attribute
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

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v3:
- Move the attribute from kunit_attributes to a suite field.

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


