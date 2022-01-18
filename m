Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C954930D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350013AbiARWfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 17:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350024AbiARWfO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 17:35:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A7C06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k189-20020a25c6c6000000b0061274ece35eso898164ybf.22
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 14:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wGX0SgG3zKXJcV46j/Y6+4p2WMGDSqGFtH4FJYdgcw8=;
        b=bwrxzsIaIgt7HiTRY9vyXV7xP/3VD5epRoVBl2SdP+/tnJ4C1q+jGrvTzsgUpQkuw2
         wdmY6nboth4HLo0aaUBc0u4j/LM86v9/c9R6+nK90cnh0c64ZnnZ0/mHdzqvViY5whe6
         dxwRK84lQnY8miw77jclVEgmHIH+XHCzi1dYomKOrllMFppaKubPCScJPYoJPOvfVl8u
         CCoWekSKyl8/4ZdZxhBEbP/zR/6joAyKF644z7zPy9N6NxR+bkkii4//dEajFPrpdeaR
         JO9WvUpaCHgX1U9m/AN9CzESYAnmrod0qBy0X0sYGpw2WPgvIrs/dqfOPNFfzzsnDzfv
         Py7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wGX0SgG3zKXJcV46j/Y6+4p2WMGDSqGFtH4FJYdgcw8=;
        b=prflMX1q7sI1LdKSReHsiI1BaOj/q6mWnMsdlyE+sX7EAYPLR8uMjp9ve0cddg8b4C
         kgNJ1PtUPm/G2wd7EiDCHz7exluO/IstrF99mBKkFlLPnyaMgAFtyoA2RXQG77XtBmlr
         IhLYWgcePuEddN9Wg+5ub825hCZXUofY2s6TiFPdh9tdFfbH+6PsWO/Mnhv7zLQU71wK
         uTYH3UL54Zg5ldA6gRZrGycx4wsO/JoFaIaTySgXkQvqPuk68/ICesuN/du3CqVzbfqZ
         Zeh1eRTHLJDEHtdk5xRTikxv5qzo+z4jTxmlJ9UXkz6dUShOpV7y+BKWeQShPUy6vj81
         DlIQ==
X-Gm-Message-State: AOAM530shWHt7ImbXDHBVb08m6L5iq+0cyGwZnsGz1pNvTQOuEu9WqIY
        ia/DmXgMlAFdjzMWPSl6+UWJ/ljISZgo+g==
X-Google-Smtp-Source: ABdhPJxX9W/k26DYxfe4M5MzZsB7Fnkt/0pntXM8jXL+lnZyejkumR5M4BiJsqorqpdpUjOSSqlf9rFxQHegRQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a25:654:: with SMTP id
 81mr33640131ybg.541.1642545313426; Tue, 18 Jan 2022 14:35:13 -0800 (PST)
Date:   Tue, 18 Jan 2022 14:35:01 -0800
Message-Id: <20220118223506.1701553-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 0/5] kunit: decrease layers of assertion macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Note: this series applies on top of the series reducing stack usage,
https://lore.kernel.org/linux-kselftest/20220113165931.451305-1-dlatypov@google.com/
There's no real smenatic dependency between these, just potential for
merge conflicts.

The current layout of the assertion macros is confusing.

Here's the call chain for KUNIT_EXPECT_EQ() and KUNIT_EXPECT_EQ_MSG()
  KUNIT_EXPECT_EQ =>
  KUNIT_BINARY_EQ_ASSERTION => # note: not shared with the _MSG variant
  KUNIT_BINARY_EQ_MSG_ASSERTION =>
  KUNIT_BASE_EQ_MSG_ASSERTION =>
  KUNIT_BASE_BINARY_ASSERTION

  KUNIT_EXPECT_EQ_MSG =>
  KUNIT_BINARY_EQ_MSG_ASSERTION =>
  KUNIT_BASE_EQ_MSG_ASSERTION =>
  KUNIT_BASE_BINARY_ASSERTION

After this series
  KUNIT_EXPECT_EQ =>
  KUNIT_EXPECT_EQ_MSG =>
  KUNIT_BINARY_INT_ASSERTION =>
  KUNIT_BASE_BINARY_ASSERTION

The current macro layout tries hard to reduce duplication, but comes at
the cost of a lot of intermediates that can simply vanish.

The same call-chain again, but annotated with the info we add:
  KUNIT_EXPECT_EQ => specify we're an EXPECT, not an ASSERT
  KUNIT_BINARY_EQ_ASSERTION => specify we have a NULL msg
  KUNIT_BINARY_EQ_MSG_ASSERTION => specify we work with ints, not ptrs
  KUNIT_BASE_EQ_MSG_ASSERTION => specify that the op is '=='
  KUNIT_BASE_BINARY_ASSERTION

We can see that each level of the chain only specifes one parameter at
a time. We've taken the concept of DRY too far.

The following is a full snippet of all the macros needed for
KUNIT_EXPECT_EQ, showing that a bit of repetition is just fine:
  #define KUNIT_BINARY_INT_ASSERTION(test,				       \
				     assert_type,			       \
				     left,				       \
				     op,				       \
				     right,				       \
				     fmt,				       \
				      ...)				       \
	  KUNIT_BASE_BINARY_ASSERTION(test,				       \
				      kunit_binary_assert,		       \
				      KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
				      assert_type,			       \
				      left, op, right,			       \
				      fmt,				       \
				      ##__VA_ARGS__)

  #define KUNIT_EXPECT_EQ(test, left, right) \
	  KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)

  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
	  KUNIT_BINARY_INT_ASSERTION(test,				       \
				     KUNIT_EXPECTATION,			       \
				     left, ==, right,			       \
				     fmt,				       \
				      ##__VA_ARGS__)

as opposed to our current DRYer version

  #define KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
				      assert_class,                              \
				      ASSERT_CLASS_INIT,                         \
				      assert_type,                               \
				      left,                                      \
				      right,                                     \
				      fmt,                                       \
				      ...)                                       \
	  KUNIT_BASE_BINARY_ASSERTION(test,                                      \
				      assert_class,                              \
				      ASSERT_CLASS_INIT,                         \
				      assert_type,                               \
				      left, ==, right,                           \
				      fmt,                                       \
				      ##__VA_ARGS__)

  #define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
	  KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
				      kunit_binary_assert,                       \
				      KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
				      assert_type,                               \
				      left,                                      \
				      right,                                     \
				      fmt,                                       \
				      ##__VA_ARGS__)

  #define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)              \
	  KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
					assert_type,                             \
					left,                                    \
					right,                                   \
					NULL)
  #define KUNIT_EXPECT_EQ(test, left, right) \
	  KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)

  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)                       \
	  KUNIT_BINARY_EQ_MSG_ASSERTION(test,                                    \
					KUNIT_EXPECTATION,                       \
					left,                                    \
					right,                                   \
					fmt,                                     \
					##__VA_ARGS__)



Daniel Latypov (5):
  kunit: make KUNIT_EXPECT_EQ() use KUNIT_EXPECT_EQ_MSG(), etc.
  kunit: drop unused intermediate macros for ptr inequality checks
  kunit: reduce layering in string assertion macros
  kunit: decrease macro layering for integer asserts
  kunit: decrease macro layering for EQ/NE asserts

 include/kunit/test.h | 660 ++++++++++---------------------------------
 1 file changed, 142 insertions(+), 518 deletions(-)

-- 
2.34.1.703.g22d0c6ccf7-goog

