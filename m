Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710CC6FD640
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 07:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjEJFiu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 01:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjEJFiq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 01:38:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD40273E
        for <linux-kselftest@vger.kernel.org>; Tue,  9 May 2023 22:38:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7c58ec19so8255499276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 May 2023 22:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683697123; x=1686289123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D21RSkoXuPIazsZogkwKEp2pOsmA6u55RxvLm4Pqyu0=;
        b=lPjEr4Y91YjA1DNPtgQa83pK7PbcyEl0pyuhZLNr+D/cRXObIpRBPlUEnuSxJD0dat
         cc9uF5IP+1FSE0JWzIbCDVH5NaX+zg1uIVxcUJ/OmfnkEBJ9ysUbl6tbjvwDi7BY/1HH
         le11hW04bhEyKovFflUg+lE3nLrPr4onNp7uVYyuvjtqtsZEICQ4i1FAk+Mv2wh5EAqo
         TxHhUuRFI/GRs+iIpWx/0jB5sbtHiiCZjO1575V3AN+lIxzVgz4qBoFa3qGGH+K9CrXq
         1TQp+VfVULgwLO4EPsVnPAasLSHyQ8EcYiA8UTj/qM8M3bV+4xCuc0CeWygjj9EyT/UT
         Cmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697123; x=1686289123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D21RSkoXuPIazsZogkwKEp2pOsmA6u55RxvLm4Pqyu0=;
        b=BthHHOafhOxY/hnsSNMIQJlDY62ZdPfmYlGo3RLbFWkYcd7n1iIpi4i1OKGeh30Qin
         qKKauSERauqdMJQZrSTvadEYfyY8Th3kxUTWRbc1ppNmxZt6LnIRNOWiQj9Ga1vmeurf
         6Ca2FQLaFm87rB1YxX+pLwR5Fq+7zOstwfHWene9zXBXHIDOnK/ZwALhtvMWjZOcx4tj
         omb8p5iyuubWm/uXnoMIXqdKkZAjmQe5kGH2AQiKSciiJRkS6G/hRDSgICpJCUsR12SU
         k0Cf0I+qamkfEXtBIJv9p0U1iG4NoRSDePBT9Qewx7QTLITuSTPbun6cGer5rNcAzwDW
         V2uA==
X-Gm-Message-State: AC+VfDwh040OFlTW80JVclHraOAoLtX1kRFTNvWC+gQ883KMEhuJ6lKG
        bH9KkXXpAb4/cyGiL4YmU8BMjCI7ETDscA==
X-Google-Smtp-Source: ACHHUZ5prhcsa2uKfRyYa70NkTmue+tLexFwGpYvoi5fvKb9TeMGfaJMHMNK6fm4cHpohQ01ySzPxykDD0BHfg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d6d0:0:b0:b8f:35c1:e63e with SMTP id
 n199-20020a25d6d0000000b00b8f35c1e63emr10524538ybg.6.1683697122908; Tue, 09
 May 2023 22:38:42 -0700 (PDT)
Date:   Wed, 10 May 2023 13:38:30 +0800
In-Reply-To: <20230510053832.438529-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230510053832.438529-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510053832.438529-2-davidgow@google.com>
Subject: [PATCH v4 2/4] Documentation: kunit: Note that assertions should not
 be used in cleanup
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As assertions abort the test cleanup process, they should be avoided
from within a suite's exit function, or from within resource 'free'
functions. Unlike with initialisation or main test execution, no further
cleanup will be performed after a failed assertion, potentially causing
a leak of resources.

Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20230421040218.2156548-2-davidgow@google.com/
- Add Sadiya's Reviewed-by tag.

No changes since v2:
https://lore.kernel.org/linux-kselftest/20230419085426.1671703-2-davidgow@google.com/

This patch was introduced in v2.

---
 Documentation/dev-tools/kunit/usage.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9faf2b4153fc..9f720f1317d3 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -121,6 +121,12 @@ there's an allocation error.
    ``return`` so they only work from the test function. In KUnit, we stop the
    current kthread on failure, so you can call them from anywhere.
 
+.. note::
+   Warning: There is an exception to the above rule. You shouldn't use assertions
+   in the suite's exit() function, or in the free function for a resource. These
+   run when a test is shutting down, and an assertion here prevents further
+   cleanup code from running, potentially leading to a memory leak.
+
 Customizing error messages
 --------------------------
 
-- 
2.40.1.521.gf1e218fcd8-goog

