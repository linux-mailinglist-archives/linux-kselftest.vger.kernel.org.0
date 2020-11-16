Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D322B3CAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 06:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgKPFm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 00:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgKPFm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 00:42:29 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BA5C0613CF;
        Sun, 15 Nov 2020 21:42:28 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 35so3706488ple.12;
        Sun, 15 Nov 2020 21:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvBDzmZb6vZCHjnko71GYI6zLHOjPymbNBV7fgs8wm8=;
        b=qygZstds6rKXAo5O3oZavyKulbUB2FJvSsvG+JAFCLWU8Ka7Q91O7ryAvXzPFkMXYV
         U7oV34ngrXRFzh2rPXFxd0UUeii3UOBv1DsGobqCMYEUZVKTVVlZWikpcauflghBcki1
         bbRhIxrzpb3Bv2eXOGdEKElCwpjov2LeWv+ZxL4aDyFC9+FzBAt5wFVBSupo4wfQv+YI
         4kpAx2rXY8OvvTtekN2hSw9JrhQd5wP5b7Jg9yL/nqiw2XU14iLDdWNisHqZP5oibCXL
         FSP6XyjR79+6otkyNZf6SWE4b9OxekqSf00mcgYTrMcruVASvE12j+ymPIEjxoKpf0PK
         P2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvBDzmZb6vZCHjnko71GYI6zLHOjPymbNBV7fgs8wm8=;
        b=UwzjonYXKIv3P7Lg2VJbEKuRbXm7bLvRCFDqYFFdUh6ZsnJqmmMnG6WXV8PEO6AhoZ
         asaGQ+dPZBnrRTtijya5b5pWYcNakbC6xl7+3hrXA5oYw5WpuPM2Jc7TeYdJFlIx26EU
         vDzc2etVjGFost0UpoxQ4WLHpnZrP77RCKxzE73R9wBBYaYgEWPQiygPt5wK5tDFewpf
         6c+85HrCUwKEBxBtYOqUIzmNdG/qw5HPdgiY+AhmyUwWFRlyIfgCN6fs0SLzdKGK+LU4
         /5l59WsUsOdWG/wjdt6ows3e0wn5nZD5QJSWMFErT5w4GF03YPvb5lc0izCR35UWdibF
         eIjw==
X-Gm-Message-State: AOAM5334SOZOjcEgyEj5DS9Kttiaxli2C8FmehlTJZ+h2zi9oiml6r5r
        NcpzE9jTbCxvb5tCVyQ71Oc=
X-Google-Smtp-Source: ABdhPJwi3ZS7kW3wzWjMHH3DlRm/jSYvcttno2ZjPLpQvSyMLIAthWqfufIYrNc7stn50POXJr3XRg==
X-Received: by 2002:a17:902:8ec7:b029:d8:e603:304c with SMTP id x7-20020a1709028ec7b02900d8e603304cmr5332514plo.85.1605505347534;
        Sun, 15 Nov 2020 21:42:27 -0800 (PST)
Received: from arpitha-Inspiron-7570.lan ([106.51.140.48])
        by smtp.gmail.com with ESMTPSA id s18sm14807987pgh.60.2020.11.15.21.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 21:42:26 -0800 (PST)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        elver@google.com, yzaikin@google.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, Tim.Bird@sony.com, davidgow@google.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v9 2/2] fs: ext4: Modify inode-test.c to use KUnit parameterized testing feature
Date:   Mon, 16 Nov 2020 11:11:50 +0530
Message-Id: <20201116054150.211562-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116054035.211498-1-98.arpi@gmail.com>
References: <20201116054035.211498-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Modify fs/ext4/inode-test.c to use the parameterized testing
feature of KUnit.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
Signed-off-by: Marco Elver <elver@google.com>
---
Changes v8->v9:
- Replace strncpy() with strscpy() in timestamp_expectation_to_desc()
Changes v7->v8:
- Replace strcpy() with strncpy() in timestamp_expectation_to_desc()
Changes v6->v7:
- Introduce timestamp_expectation_to_desc() to convert param to
  description.
Changes v5->v6:
- No change to this patch of the patch series
Changes v4->v5:
- No change to this patch of the patch series
Changes v3->v4:
- Modification based on latest implementation of KUnit parameterized testing
Changes v2->v3:
- Marked hardcoded test data const
- Modification based on latest implementation of KUnit parameterized testing
Changes v1->v2:
- Modification based on latest implementation of KUnit parameterized testing

 fs/ext4/inode-test.c | 320 ++++++++++++++++++++++---------------------
 1 file changed, 164 insertions(+), 156 deletions(-)

diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index d62d802c9c12..7935ea6cf92c 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -80,6 +80,145 @@ struct timestamp_expectation {
 	bool lower_bound;
 };
 
+static const struct timestamp_expectation test_data[] = {
+	{
+		.test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+		.msb_set = true,
+		.lower_bound = true,
+		.extra_bits = 0,
+		.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+		.msb_set = true,
+		.lower_bound = false,
+		.extra_bits = 0,
+		.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 0,
+		.expected = {0LL, 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 0,
+		.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
+		.msb_set = true,
+		.lower_bound = true,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
+		.msb_set = true,
+		.lower_bound = false,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
+		.msb_set = true,
+		.lower_bound = true,
+		.extra_bits =  2,
+		.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
+		.msb_set = true,
+		.lower_bound = false,
+		.extra_bits = 2,
+		.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 2,
+		.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 2,
+		.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 6,
+		.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 0xFFFFFFFF,
+		.expected = {.tv_sec = 0x300000000LL,
+			     .tv_nsec = MAX_NANOSECONDS},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 3,
+		.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 3,
+		.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
+	}
+};
+
+static void timestamp_expectation_to_desc(const struct timestamp_expectation *t,
+					  char *desc)
+{
+	strscpy(desc, t->test_case_name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(ext4_inode, test_data, timestamp_expectation_to_desc);
+
 static time64_t get_32bit_time(const struct timestamp_expectation * const test)
 {
 	if (test->msb_set) {
@@ -101,166 +240,35 @@ static time64_t get_32bit_time(const struct timestamp_expectation * const test)
  */
 static void inode_test_xtimestamp_decoding(struct kunit *test)
 {
-	const struct timestamp_expectation test_data[] = {
-		{
-			.test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
-			.msb_set = true,
-			.lower_bound = true,
-			.extra_bits = 0,
-			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
-			.msb_set = true,
-			.lower_bound = false,
-			.extra_bits = 0,
-			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 0,
-			.expected = {0LL, 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 0,
-			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
-			.msb_set = true,
-			.lower_bound = true,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
-			.msb_set = true,
-			.lower_bound = false,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
-			.msb_set = true,
-			.lower_bound = true,
-			.extra_bits =  2,
-			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
-			.msb_set = true,
-			.lower_bound = false,
-			.extra_bits = 2,
-			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 2,
-			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 2,
-			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 6,
-			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 0xFFFFFFFF,
-			.expected = {.tv_sec = 0x300000000LL,
-				     .tv_nsec = MAX_NANOSECONDS},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 3,
-			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 3,
-			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
-		}
-	};
-
 	struct timespec64 timestamp;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
-		timestamp.tv_sec = get_32bit_time(&test_data[i]);
-		ext4_decode_extra_time(&timestamp,
-				       cpu_to_le32(test_data[i].extra_bits));
-
-		KUNIT_EXPECT_EQ_MSG(test,
-				    test_data[i].expected.tv_sec,
-				    timestamp.tv_sec,
-				    CASE_NAME_FORMAT,
-				    test_data[i].test_case_name,
-				    test_data[i].msb_set,
-				    test_data[i].lower_bound,
-				    test_data[i].extra_bits);
-		KUNIT_EXPECT_EQ_MSG(test,
-				    test_data[i].expected.tv_nsec,
-				    timestamp.tv_nsec,
-				    CASE_NAME_FORMAT,
-				    test_data[i].test_case_name,
-				    test_data[i].msb_set,
-				    test_data[i].lower_bound,
-				    test_data[i].extra_bits);
-	}
+
+	struct timestamp_expectation *test_param =
+			(struct timestamp_expectation *)(test->param_value);
+
+	timestamp.tv_sec = get_32bit_time(test_param);
+	ext4_decode_extra_time(&timestamp,
+			       cpu_to_le32(test_param->extra_bits));
+
+	KUNIT_EXPECT_EQ_MSG(test,
+			    test_param->expected.tv_sec,
+			    timestamp.tv_sec,
+			    CASE_NAME_FORMAT,
+			    test_param->test_case_name,
+			    test_param->msb_set,
+			    test_param->lower_bound,
+			    test_param->extra_bits);
+	KUNIT_EXPECT_EQ_MSG(test,
+			    test_param->expected.tv_nsec,
+			    timestamp.tv_nsec,
+			    CASE_NAME_FORMAT,
+			    test_param->test_case_name,
+			    test_param->msb_set,
+			    test_param->lower_bound,
+			    test_param->extra_bits);
 }
 
 static struct kunit_case ext4_inode_test_cases[] = {
-	KUNIT_CASE(inode_test_xtimestamp_decoding),
+	KUNIT_CASE_PARAM(inode_test_xtimestamp_decoding, ext4_inode_gen_params),
 	{}
 };
 
-- 
2.25.1

