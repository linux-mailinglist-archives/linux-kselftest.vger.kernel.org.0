Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6114AA12F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 21:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiBDUc7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 15:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiBDUc6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 15:32:58 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153ABC061714;
        Fri,  4 Feb 2022 12:32:57 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b35so5729310qkp.6;
        Fri, 04 Feb 2022 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnHGInZ6R+GWHhomNWuA/pIrXH/uUnktXFDBquqwRgg=;
        b=aRUCRPIN1LlaTCOY17aSWSkQtaZAPbO9+ojImnVMYW+oCz+ebggUzkHNqmvr7Zcc/x
         NrhA9iEVtOWGmFcnrOJ7wqXwv/y+gH5ftr4VJi5G/KyNKVlzKijGncZz/O3lpLw2PgxF
         Ga93IUcjGWE2q3qpSq6KqhcuqqcIllfkvhXeP0s2sKKF1MQMOVfDcGugffMlDd9oXrr0
         dHd70J0mCLBsG1GrSlky7M92a8QwLx+JtIoDFnhItVI4az8jjhykhl0TKXeRureROTcw
         7KnGoE+G7BnemSKzPQffNB9gUsFmwdnzLp06Ko4sCHaH41I9v6pSXDPZWyUXHHcwi3YY
         WM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnHGInZ6R+GWHhomNWuA/pIrXH/uUnktXFDBquqwRgg=;
        b=NJpLsMuWc4uYLuRPlVVk4JLomHzozVeSSUBTigqIVkD9NMrbs+Pqgf+WrIe8BoHhWD
         conzLUSZEoasD9M6iG+6qM3O2kGiKN+NYlGNHgcnIB13sEbY7d9mFrLzxa/1hK4MtpAh
         Szq/b1T0nz5OC+rt5pZwlnr0SfiGvQlM4ipl9PUkfCfhV/k4W6NhF9Wo/tZSprSsCR6z
         kqPj6jcf/jlUjnv+geDSjYxCLPKZyfcGjpdNf9ss470c5lh8ypiDA91f/uM1ckZ7Fkj+
         bxvNaLdYOnJfXzDhc3cfeNWTVaHDaqmofctEqRD4KYBg/NNb30JmRnkzenccZ05IOvBf
         zN5A==
X-Gm-Message-State: AOAM533K72B8NrdHho9qHtBLFLhzsOt5iUE8AnoU3Av9Qf+LKDtIPbvl
        fSh0YjZoPhaow89KPq9MvPo=
X-Google-Smtp-Source: ABdhPJyDfHo1hWpBTzBZ8xr7fDzsCWtv1R0BLdSzd7telz52hrIUDaXIjNR091Be5fsVjtFlXnFmrg==
X-Received: by 2002:a37:6896:: with SMTP id d144mr511563qkc.549.1644006776236;
        Fri, 04 Feb 2022 12:32:56 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id j14sm1686057qko.10.2022.02.04.12.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 12:32:55 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Documentation: dev-tools: clarify KTAP specification wording
Date:   Fri,  4 Feb 2022 14:32:48 -0600
Message-Id: <20220204203248.2981902-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Clarify some confusing phrasing.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

One item that may result in bikeshedding is that I added the spec
version to the title line.

 Documentation/dev-tools/ktap.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 878530cb9c27..3b7a26816930 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-========================================
-The Kernel Test Anything Protocol (KTAP)
-========================================
+===================================================
+The Kernel Test Anything Protocol (KTAP), version 1
+===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
 by a number of projects. It's website and specification are found at this `link
@@ -186,7 +186,7 @@ starting with another KTAP version line and test plan, and end with the overall
 result. If one of the subtests fail, for example, the parent test should also
 fail.
 
-Additionally, all result lines in a subtest should be indented. One level of
+Additionally, all lines in a subtest should be indented. One level of
 indentation is two spaces: "  ". The indentation should begin at the version
 line and should end before the parent test's result line.
 
@@ -225,8 +225,8 @@ Major differences between TAP and KTAP
 --------------------------------------
 
 Note the major differences between the TAP and KTAP specification:
-- yaml and json are not recommended in diagnostic messages
-- TODO directive not recognized
+- yaml and json are not recommended in KTAP diagnostic messages
+- TODO directive not recognized in KTAP
 - KTAP allows for an arbitrary number of tests to be nested
 
 The TAP14 specification does permit nested tests, but instead of using another
-- 
Frank Rowand <frank.rowand@sony.com>

