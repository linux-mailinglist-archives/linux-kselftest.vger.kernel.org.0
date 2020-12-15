Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115B22DB620
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 22:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgLOVxC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 16:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgLOVwy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 16:52:54 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE22C0617A7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 13:52:14 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i6so20956839otr.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 13:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=y0pQIv0bjGD3QvePMLeyVrdza3AA+Xqh6GT4Yuter9o=;
        b=IEbOU7boEJoNxHlRK4eMa6zcTtVMZYf7ctQ+RC4ZbGFJkE4hCN6pxt03pFzSRELblp
         ZVAktZBBwsZCTq7T6IttD3bhCM4R5I9YclaViKYKLLsS8GxCAKwA37I6D9g0t+rSPEA8
         TTLGTnOHz/z2B07RElmrwr3Ts3UKasvUYI0a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=y0pQIv0bjGD3QvePMLeyVrdza3AA+Xqh6GT4Yuter9o=;
        b=jvhw+/aKNV1h+PUkEQqM2OBQrFx6Wqxmsa0HxPTb4kXZ5dqPWkOJ50eUxK4KbCCUBD
         BebnDLR7k5N8EVArB5z/OoXL1fmp805oOgz4Qey+rbKknY6womF556XTxJRQ6WbfYzQJ
         /GmRnVIEuys+7fM6VLG4mASmJ+ue9lfU+fLGoTZRZGqQnz54BzvOMuATq/svQnMqA9b5
         EuF5d+D3wdFWu2kdtwyv3za9uZEaaf3UFr0ZLZWwhcQYA1xaBEX8v6yq0+jWsATOf9sk
         Z/+2IkHDx39fIrIjUotqjMtUtFUfEo0Mn/NTol64rbc/qtO23hEMvBOfj3hIdo1+YHuj
         UUPg==
X-Gm-Message-State: AOAM533e6HdL4rbPRFkCCPu9sAHyguw+YMNjBPLyGiex3hL3Jea/ZqEG
        zd9AP6rn3XjxW4+ql1mKffso2tQKfAJeZA==
X-Google-Smtp-Source: ABdhPJy7sFmEIvp9OgV2fz6oHRAWwDWRCNd1bOAP0w8nLN91p/eHo8VFilVtXBJHC+BT95GnKNbdyg==
X-Received: by 2002:a9d:1725:: with SMTP id i37mr24394331ota.258.1608069133645;
        Tue, 15 Dec 2020 13:52:13 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 5sm32880ota.62.2020.12.15.13.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 13:52:12 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.11-rc1
Message-ID: <e68b976c-0966-b26e-bb53-d80111eab8bd@linuxfoundation.org>
Date:   Tue, 15 Dec 2020 14:52:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CE588FB6AE3AA902452189F0"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------CE588FB6AE3AA902452189F0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.11-rc1.

This kunit update for Linux 5.11-rc1 consists of:

-- documentation update and fix to kunit_tool to parse diagnostic
    messages correctly from David Gow
-- Support for Parameterized Testing and fs/ext4 test updates to use
    KUnit parameterized testing feature from Arpitha Raghunandan
-- Helper to derive file names depending on --build_dir argument
    from Andy Shevchenko

Please note that fs/ext4 test change is included in this update
along with the KUnit framework support it depends on.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

   Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.11-rc1

for you to fetch changes up to 5f6b99d0287de2c2d0b5e7abcb0092d553ad804a:

   fs: ext4: Modify inode-test.c to use KUnit parameterized testing 
feature (2020-12-02 16:07:25 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-5.11-rc1

This kunit update for Linux 5.11-rc1 consists of:

-- documentation update and fix to kunit_tool to parse diagnostic
    messages correctly from David Gow
-- Support for Parameterized Testing and fs/ext4 test updates to use
    KUnit parameterized testing feature from Arpitha Raghunandan
-- Helper to derive file names depending on --build_dir argument
    from Andy Shevchenko

----------------------------------------------------------------
Andy Shevchenko (1):
       kunit: Introduce get_file_path() helper

Arpitha Raghunandan (2):
       kunit: Support for Parameterized Testing
       fs: ext4: Modify inode-test.c to use KUnit parameterized testing 
feature

Daniel Latypov (1):
       Documentation: kunit: provide guidance for testing many inputs

David Gow (1):
       kunit: kunit_tool: Correctly parse diagnostic messages

  Documentation/dev-tools/kunit/usage.rst |  83 ++++++++-
  fs/ext4/inode-test.c                    | 320 
++++++++++++++++----------------
  include/kunit/test.h                    |  51 +++++
  lib/kunit/test.c                        |  59 ++++--
  tools/testing/kunit/kunit_kernel.py     |  24 +--
  tools/testing/kunit/kunit_parser.py     |   7 +-
  6 files changed, 351 insertions(+), 193 deletions(-)
----------------------------------------------------------------

--------------CE588FB6AE3AA902452189F0
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.11-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.11-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9c28c518e6a3..d9fdc14f0677 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -15,10 +15,10 @@ project, see :doc:`start`.
 Organization of this document
 =============================
 
-This document is organized into two main sections: Testing and Isolating
-Behavior. The first covers what unit tests are and how to use KUnit to write
-them. The second covers how to use KUnit to isolate code and make it possible
-to unit test code that was otherwise un-unit-testable.
+This document is organized into two main sections: Testing and Common Patterns.
+The first covers what unit tests are and how to use KUnit to write them. The
+second covers common testing patterns, e.g. how to isolate code and make it
+possible to unit test code that was otherwise un-unit-testable.
 
 Testing
 =======
@@ -218,8 +218,11 @@ test was built in or not).
 
 For more information on these types of things see the :doc:`api/test`.
 
+Common Patterns
+===============
+
 Isolating Behavior
-==================
+------------------
 
 The most important aspect of unit testing that other forms of testing do not
 provide is the ability to limit the amount of code under test to a single unit.
@@ -233,7 +236,7 @@ implementer, and architecture-specific functions which have definitions selected
 at compile time.
 
 Classes
--------
+~~~~~~~
 
 Classes are not a construct that is built into the C programming language;
 however, it is an easily derived concept. Accordingly, pretty much every project
@@ -451,6 +454,74 @@ We can now use it to test ``struct eeprom_buffer``:
 		destroy_eeprom_buffer(ctx->eeprom_buffer);
 	}
 
+Testing against multiple inputs
+-------------------------------
+
+Testing just a few inputs might not be enough to have confidence that the code
+works correctly, e.g. for a hash function.
+
+In such cases, it can be helpful to have a helper macro or function, e.g. this
+fictitious example for ``sha1sum(1)``
+
+.. code-block:: c
+
+	/* Note: the cast is to satisfy overly strict type-checking. */
+	#define TEST_SHA1(in, want) \
+		sha1sum(in, out); \
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want, "sha1sum(%s)", in);
+
+	char out[40];
+	TEST_SHA1("hello world",  "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed");
+	TEST_SHA1("hello world!", "430ce34d020724ed75a196dfc2ad67c77772d169");
+
+
+Note the use of ``KUNIT_EXPECT_STREQ_MSG`` to give more context when it fails
+and make it easier to track down. (Yes, in this example, ``want`` is likely
+going to be unique enough on its own).
+
+The ``_MSG`` variants are even more useful when the same expectation is called
+multiple times (in a loop or helper function) and thus the line number isn't
+enough to identify what failed, like below.
+
+In some cases, it can be helpful to write a *table-driven test* instead, e.g.
+
+.. code-block:: c
+
+	int i;
+	char out[40];
+
+	struct sha1_test_case {
+		const char *str;
+		const char *sha1;
+	};
+
+	struct sha1_test_case cases[] = {
+		{
+			.str = "hello world",
+			.sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
+		},
+		{
+			.str = "hello world!",
+			.sha1 = "430ce34d020724ed75a196dfc2ad67c77772d169",
+		},
+	};
+	for (i = 0; i < ARRAY_SIZE(cases); ++i) {
+		sha1sum(cases[i].str, out);
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].sha1,
+		                      "sha1sum(%s)", cases[i].str);
+	}
+
+
+There's more boilerplate involved, but it can:
+
+* be more readable when there are multiple inputs/outputs thanks to field names,
+
+  * E.g. see ``fs/ext4/inode-test.c`` for an example of both.
+* reduce duplication if test cases can be shared across multiple tests.
+
+  * E.g. if we wanted to also test ``sha256sum``, we could add a ``sha256``
+    field and reuse ``cases``.
+
 .. _kunit-on-non-uml:
 
 KUnit on non-UML architectures
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
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index df60be7e22ca..49601c4b98b8 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -94,6 +94,9 @@ struct kunit;
 /* Size of log associated with test. */
 #define KUNIT_LOG_SIZE	512
 
+/* Maximum size of parameter description string. */
+#define KUNIT_PARAM_DESC_SIZE 128
+
 /*
  * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
  * sub-subtest.  See the "Subtests" section in
@@ -107,6 +110,7 @@ struct kunit;
  *
  * @run_case: the function representing the actual test case.
  * @name:     the name of the test case.
+ * @generate_params: the generator function for parameterized tests.
  *
  * A test case is a function with the signature,
  * ``void (*)(struct kunit *)``
@@ -141,6 +145,7 @@ struct kunit;
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
+	const void* (*generate_params)(const void *prev, char *desc);
 
 	/* private: internal use only. */
 	bool success;
@@ -163,6 +168,27 @@ static inline char *kunit_status_to_string(bool status)
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
 
+/**
+ * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
+ *
+ * @test_name: a reference to a test case function.
+ * @gen_params: a reference to a parameter generator function.
+ *
+ * The generator function::
+ *
+ *	const void* gen_params(const void *prev, char *desc)
+ *
+ * is used to lazily generate a series of arbitrarily typed values that fit into
+ * a void*. The argument @prev is the previously returned value, which should be
+ * used to derive the next value; @prev is set to NULL on the initial generator
+ * call. When no more values are available, the generator must return NULL.
+ * Optionally write a string into @desc (size of KUNIT_PARAM_DESC_SIZE)
+ * describing the parameter.
+ */
+#define KUNIT_CASE_PARAM(test_name, gen_params)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .generate_params = gen_params }
+
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
@@ -208,6 +234,10 @@ struct kunit {
 	const char *name; /* Read only after initialization! */
 	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
+	/* param_value is the current parameter value for a test case. */
+	const void *param_value;
+	/* param_index stores the index of the parameter in parameterized tests. */
+	int param_index;
 	/*
 	 * success starts as true, and may only be set to false during a
 	 * test case; thus, it is safe to update this across multiple
@@ -1742,4 +1772,25 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
+/**
+ * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: array of test parameters.
+ * @get_desc: function to convert param to description; NULL to use default
+ *
+ * Define function @name_gen_params which uses @array to generate parameters.
+ */
+#define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
+	static const void *name##_gen_params(const void *prev, char *desc)			\
+	{											\
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		if (__next - (array) < ARRAY_SIZE((array))) {					\
+			void (*__get_desc)(typeof(__next), char *) = get_desc;			\
+			if (__get_desc)								\
+				__get_desc(__next, desc);					\
+			return __next;								\
+		}										\
+		return NULL;									\
+	}
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 750704abe89a..ec9494e914ef 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -325,39 +325,72 @@ static void kunit_catch_run_case(void *data)
  * occur in a test case and reports them as failures.
  */
 static void kunit_run_case_catch_errors(struct kunit_suite *suite,
-					struct kunit_case *test_case)
+					struct kunit_case *test_case,
+					struct kunit *test)
 {
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
-	struct kunit test;
 
-	kunit_init_test(&test, test_case->name, test_case->log);
-	try_catch = &test.try_catch;
+	kunit_init_test(test, test_case->name, test_case->log);
+	try_catch = &test->try_catch;
 
 	kunit_try_catch_init(try_catch,
-			     &test,
+			     test,
 			     kunit_try_run_case,
 			     kunit_catch_run_case);
-	context.test = &test;
+	context.test = test;
 	context.suite = suite;
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
-	test_case->success = test.success;
-
-	kunit_print_ok_not_ok(&test, true, test_case->success,
-			      kunit_test_case_num(suite, test_case),
-			      test_case->name);
+	test_case->success = test->success;
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
 {
+	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
 
 	kunit_print_subtest_start(suite);
 
-	kunit_suite_for_each_test_case(suite, test_case)
-		kunit_run_case_catch_errors(suite, test_case);
+	kunit_suite_for_each_test_case(suite, test_case) {
+		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		bool test_success = true;
+
+		if (test_case->generate_params) {
+			/* Get initial param. */
+			param_desc[0] = '\0';
+			test.param_value = test_case->generate_params(NULL, param_desc);
+		}
+
+		do {
+			kunit_run_case_catch_errors(suite, test_case, &test);
+			test_success &= test_case->success;
+
+			if (test_case->generate_params) {
+				if (param_desc[0] == '\0') {
+					snprintf(param_desc, sizeof(param_desc),
+						 "param-%d", test.param_index);
+				}
+
+				kunit_log(KERN_INFO, &test,
+					  KUNIT_SUBTEST_INDENT
+					  "# %s: %s %d - %s",
+					  test_case->name,
+					  kunit_status_to_string(test.success),
+					  test.param_index + 1, param_desc);
+
+				/* Get next param. */
+				param_desc[0] = '\0';
+				test.param_value = test_case->generate_params(test.param_value, param_desc);
+				test.param_index++;
+			}
+		} while (test.param_value);
+
+		kunit_print_ok_not_ok(&test, true, test_success,
+				      kunit_test_case_num(suite, test_case),
+				      test_case->name);
+	}
 
 	kunit_print_subtest_end(suite);
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2e3cc0fac726..57c1724b7e5d 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -23,6 +23,11 @@ DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 OUTFILE_PATH = 'test.log'
 
+def get_file_path(build_dir, default):
+	if build_dir:
+		default = os.path.join(build_dir, default)
+	return default
+
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
 
@@ -97,9 +102,7 @@ class LinuxSourceTreeOperations(object):
 
 	def linux_bin(self, params, timeout, build_dir):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
-		linux_bin = './linux'
-		if build_dir:
-			linux_bin = os.path.join(build_dir, 'linux')
+		linux_bin = get_file_path(build_dir, 'linux')
 		outfile = get_outfile_path(build_dir)
 		with open(outfile, 'w') as output:
 			process = subprocess.Popen([linux_bin] + params,
@@ -108,22 +111,13 @@ class LinuxSourceTreeOperations(object):
 			process.wait(timeout)
 
 def get_kconfig_path(build_dir):
-	kconfig_path = KCONFIG_PATH
-	if build_dir:
-		kconfig_path = os.path.join(build_dir, KCONFIG_PATH)
-	return kconfig_path
+	return get_file_path(build_dir, KCONFIG_PATH)
 
 def get_kunitconfig_path(build_dir):
-	kunitconfig_path = KUNITCONFIG_PATH
-	if build_dir:
-		kunitconfig_path = os.path.join(build_dir, KUNITCONFIG_PATH)
-	return kunitconfig_path
+	return get_file_path(build_dir, KUNITCONFIG_PATH)
 
 def get_outfile_path(build_dir):
-	outfile_path = OUTFILE_PATH
-	if build_dir:
-		outfile_path = os.path.join(build_dir, OUTFILE_PATH)
-	return outfile_path
+	return get_file_path(build_dir, OUTFILE_PATH)
 
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index bbfe1b4e4c1c..6614ec4d0898 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -135,8 +135,8 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# .*?: (.*)$')
-DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
+SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
+DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
 
 def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	save_non_diagnositic(lines, test_case)
@@ -146,7 +146,8 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	match = SUBTEST_DIAGNOSTIC.match(line)
 	if match:
 		test_case.log.append(lines.pop(0))
-		if match.group(1) == DIAGNOSTIC_CRASH_MESSAGE:
+		crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
+		if crash_match:
 			test_case.status = TestStatus.TEST_CRASHED
 		return True
 	else:

--------------CE588FB6AE3AA902452189F0--
