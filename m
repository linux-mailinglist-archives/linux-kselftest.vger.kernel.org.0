Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD428A24C
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Oct 2020 00:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390282AbgJJW4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Oct 2020 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgJJTT1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Oct 2020 15:19:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B21AC05BD25;
        Sat, 10 Oct 2020 07:56:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so726678pgg.0;
        Sat, 10 Oct 2020 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGNQhmhArB3UYXjNX9OpITFlGmNkphwKVloKhJ0FzDk=;
        b=S0bHV9R8IhVO9EMs0iK7yrbR9/nG29nDS7qurazS5LxD8zbNK3TonOw+ODuwYkr0Xz
         iAz6LIcuk3FOv+wYDLTUYGdlgftQHT6fH4JA+X76wXWQzQNbuIfCB4pkkDfB11e/EXcS
         caPiNhdvF920dM+R+qVUOmbfG6kDe12QiytZyXlMmgMLBEnI62woruxD1K0mC+UiTHd0
         gN+Jq8PKyKrY2n6lL494N13JOjevEzTZbFGelaqVhCsw8NVJhTUkHotnbUGCG58qaWs9
         XaHEViNfP3r83XE3caXzP/F+2iRylYzLc4FhHD1DUBMleXO9DDAZAcvT6fDYhVHJQUGb
         lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGNQhmhArB3UYXjNX9OpITFlGmNkphwKVloKhJ0FzDk=;
        b=Cn8UeYjPCMTxCh5fDnjKFPbOzIpAyK966BViEDTCYxek01hulEN+DaHOXZ+X2Js+3l
         +nOF8QLtzkGi+NqbuuWVATL9TjRhPmv9+fFX2/PUDB4cMQ7qUKdp6X19sFxv2iKiBKKc
         KihSmOa3VbLJzjo03PUxKUtPRYAaET+zlGBxkAaIZiy5EyRC+bbNiDMCuWKKASUZLBBp
         M5IPFFTwMon1myn54jO6ssS/TakIDv8YJStLpW031aB8vJlK1DBmqKUGZ8w16q4kX+Ll
         XcCz8eilqCyJdShdeaqTh79Ev2rlG6OyI+yVGzblgPSy/Qm1MKysmPAi+ESGbyxEl1I7
         jmCQ==
X-Gm-Message-State: AOAM532lf2SfHE/vpGSskgZDbDgGl3T2oUgPGXbfOjtbXuqduyW91OoO
        7xsXaTMHyATb3RLIM+23JxI=
X-Google-Smtp-Source: ABdhPJwCEv+ay9FATziABv5KBkBcSRyRNFrawVj/C+EPxIiukIjt9wNklPDflMWdoEMYv4NU11s6cg==
X-Received: by 2002:a17:90a:b902:: with SMTP id p2mr10309905pjr.15.1602341768089;
        Sat, 10 Oct 2020 07:56:08 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([106.51.240.187])
        by smtp.gmail.com with ESMTPSA id j19sm14304252pfi.51.2020.10.10.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 07:56:07 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        yzaikin@google.com, elver@google.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs: ext4: Modify inode-test.c to use KUnit parameterized testing feature
Date:   Sat, 10 Oct 2020 20:25:44 +0530
Message-Id: <20201010145544.61034-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201010145357.60886-1-98.arpi@gmail.com>
References: <20201010145357.60886-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Modifies fs/ext4/inode-test.c to use the parameterized testing
feature of KUnit.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
 fs/ext4/inode-test.c | 64 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index d62d802c9c12..691ef0a4ffe1 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -72,6 +72,8 @@
 #define UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE\
 	"2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on"
 
+#define NUMBER_OF_TESTCASES 16
+
 struct timestamp_expectation {
 	const char *test_case_name;
 	struct timespec64 expected;
@@ -101,7 +103,36 @@ static time64_t get_32bit_time(const struct timestamp_expectation * const test)
  */
 static void inode_test_xtimestamp_decoding(struct kunit *test)
 {
-	const struct timestamp_expectation test_data[] = {
+	struct timespec64 timestamp;
+
+	struct timestamp_expectation *test_data =
+		(struct timestamp_expectation *)get_test_case_parameters(test);
+
+	timestamp.tv_sec = get_32bit_time(test_data);
+	ext4_decode_extra_time(&timestamp,
+			       cpu_to_le32(test_data->extra_bits));
+
+	KUNIT_EXPECT_EQ_MSG(test,
+			    test_data->expected.tv_sec,
+			    timestamp.tv_sec,
+			    CASE_NAME_FORMAT,
+			    test_data->test_case_name,
+			    test_data->msb_set,
+			    test_data->lower_bound,
+			    test_data->extra_bits);
+	KUNIT_EXPECT_EQ_MSG(test,
+			    test_data->expected.tv_nsec,
+			    timestamp.tv_nsec,
+			    CASE_NAME_FORMAT,
+			    test_data->test_case_name,
+			    test_data->msb_set,
+			    test_data->lower_bound,
+			    test_data->extra_bits);
+}
+
+struct timestamp_expectation *get_test_parameters(void)
+{
+	static struct timestamp_expectation test_data[] = {
 		{
 			.test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
 			.msb_set = true,
@@ -231,36 +262,13 @@ static void inode_test_xtimestamp_decoding(struct kunit *test)
 			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
 		}
 	};
-
-	struct timespec64 timestamp;
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
+	return test_data;
 }
 
 static struct kunit_case ext4_inode_test_cases[] = {
-	KUNIT_CASE(inode_test_xtimestamp_decoding),
+	KUNIT_CASE_PARAM(inode_test_xtimestamp_decoding,
+			get_test_parameters, NUMBER_OF_TESTCASES,
+			sizeof(struct timestamp_expectation)),
 	{}
 };
 
-- 
2.25.1

