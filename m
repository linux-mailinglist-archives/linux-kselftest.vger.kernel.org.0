Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04B34E7F2D
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 06:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiCZFrM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Mar 2022 01:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCZFrJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Mar 2022 01:47:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB521D59CD
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 22:45:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y193-20020a25dcca000000b00636d788e549so6608437ybe.5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qN7PPyAD3cWtp7y6x5pkKRSnvoKWxjZvZ2QYdbya07E=;
        b=TBCh0di89ZfALXGMXBpUVGg0fAv8Gy28zwNUD40Z/FornCimph1nfwEBUOwacbauv+
         kx61OsjhyZ/p36DoE4AsfEitgcSnqkEr4kA6VTJzesYYVlKlKXYuctOdJ8e8b9TeVqmW
         RVCPRQ7vXbD8+sZzSkpBlA+4Nly/MjAcR24AsaQnRTTrmvkCh8/FAw/uM+43us8h8W8A
         hICFKPfG7+ZkMPHnLBEFfpwGDu4/ka47padYJsCH95Mdt6gnrZNXVY2OEL7mNqOIy7mL
         QaUd+uJJhJ8NfG01kqd9r6qQqpZUNhcDfWyC011g59bKk/pJ3ErgSlvquP3Ri4nIdfUK
         07tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qN7PPyAD3cWtp7y6x5pkKRSnvoKWxjZvZ2QYdbya07E=;
        b=u8abs75A/bx+gmfR+ou2xVuHd/rhLBzO8WLJ2khYAnr8J+fU9hOagHJTNsp6+yRDKt
         7jmdUjEhy4eP+F2lh/O2U4u0lrr86DZ9UdD0wdYNprpRu/O0vz9LdPdnujjQMHYxvNk1
         xB/esBO0UJY3oR8iwsaUpYJ7SWi4xj4CXkDV1NzpZrnV8wphdjbVnYMlUeIG+R/Nww0X
         KRajdpNP7/uC8KSLeeeDa3HqzLzekB3eq6G30yto4ys5k0p3h4SFRZEsRNcR9QfgixMj
         k9WIq4G/8imYR28BIfW7ZVijB2gjxKjX+wgziIxTyN/VS/Vh4h/CV9E7R+7saahA4Gm1
         ushQ==
X-Gm-Message-State: AOAM532va90g9BrcS2gB2b+w0biuf9Mne0/Rhp9awHN/uXLSnt8pTpEx
        jh/+lQCl5mjYpA1x3laSfeQx7TMucvl0dw==
X-Google-Smtp-Source: ABdhPJytqTjPcEOZKK8Jgisj6nVlpurdGAlE5lcmf6T7OizSCc+ZaskC6et3Ca5PiLgrITBG5Yeui84nb2VLbg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:3756:0:b0:2e3:3db4:7de1 with SMTP id
 e83-20020a813756000000b002e33db47de1mr15199705ywa.458.1648273525753; Fri, 25
 Mar 2022 22:45:25 -0700 (PDT)
Date:   Sat, 26 Mar 2022 13:44:15 +0800
Message-Id: <20220326054414.637293-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] Documentation: kunit: Fix cross-referencing warnings
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Architecture chapter of the KUnit documentation tried to include
copies of the kernel-doc for a couple of things, despite these already
existing in the API documentation. This lead to some warnings:

architecture:31: ./include/kunit/test.h:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
Declaration is '.. c:struct:: kunit_case'.
architecture:163: ./include/kunit/test.h:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.
architecture.rst:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
Declaration is '.. c:struct:: kunit_case'.
architecture.rst:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.

Get rid of these, and cleanup the mentions of the struct and macro in
question so that sphinx generates a link to the existing copy of the
documentation in the api/test document.

Fixes: bc145b370c ("Documentation: KUnit: Added KUnit Architecture")
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/architecture.rst | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation/dev-tools/kunit/architecture.rst
index aa2cea821e25..ff9c85a0bff2 100644
--- a/Documentation/dev-tools/kunit/architecture.rst
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -26,10 +26,7 @@ The fundamental unit in KUnit is the test case. The KUnit test cases are
 grouped into KUnit suites. A KUnit test case is a function with type
 signature ``void (*)(struct kunit *test)``.
 These test case functions are wrapped in a struct called
-``struct kunit_case``. For code, see:
-
-.. kernel-doc:: include/kunit/test.h
-	:identifiers: kunit_case
+struct kunit_case.
 
 .. note:
 	``generate_params`` is optional for non-parameterized tests.
@@ -152,18 +149,12 @@ Parameterized Tests
 Each KUnit parameterized test is associated with a collection of
 parameters. The test is invoked multiple times, once for each parameter
 value and the parameter is stored in the ``param_value`` field.
-The test case includes a ``KUNIT_CASE_PARAM()`` macro that accepts a
+The test case includes a KUNIT_CASE_PARAM() macro that accepts a
 generator function.
 The generator function is passed the previous parameter and returns the next
 parameter. It also provides a macro to generate common-case generators based on
 arrays.
 
-For code, see:
-
-.. kernel-doc:: include/kunit/test.h
-	:identifiers: KUNIT_ARRAY_PARAM
-
-
 kunit_tool (Command Line Test Harness)
 ======================================
 
-- 
2.35.1.1021.g381101b075-goog

