Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C782951B2F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 May 2022 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbiEDW6x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 18:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379520AbiEDW6J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 18:58:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13053A7F;
        Wed,  4 May 2022 15:52:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o190so3054250iof.10;
        Wed, 04 May 2022 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4IM2LeuBxLjZOXI4Ac+itNTVFMU+JztF68jOZmjG9Q=;
        b=q1aYKbBjaX3cEmdXnV9RE0f59cZqJopxNNmkQ5+M5CRU4vjlKL22zb2e66ZDJSSDFs
         tyBFpf7BAhvO2MyJ3tdgS392YiOk1hKSAHozAX6LDrjXtxZgXTM9adnM8/qANvw37Z2n
         NwkTxHvFAOV5ej3T0RHCBg60hUWy9Sspo4sN1XEZmCGbeuArKLs5DTejC/hnhJcd7juj
         R4uqcOs5S5EJuyz6rJhRxGylwpsbYjAs9kV4HesTFG1rL6Fxhh2pqpSxGq76c4Jtb736
         JpFQQI/R36/PglqCbmi9cEJf/K1woE2fMPRws/QkX2LKmHubgkt8V+yGytyhk19Rj4si
         70GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4IM2LeuBxLjZOXI4Ac+itNTVFMU+JztF68jOZmjG9Q=;
        b=k+0QvcsJ4m7oUNeRklPa+DWCf0yJKdumVsYI1R9YJgbvCbFTxNsOq/P6ly9KZI/9qZ
         6cRyu0Uiofrd+BPXRMiAcbpEyeaBhwZwPqPYArvPyGdMMbu6KQzrSUetBS2lpK9SXfuc
         lNoXxegZzfGQYdudD4wV9OOVNcUkHlrSARcH59GvARrFY9LpnEjMfomC9cKvyh5n1A+U
         crWygdaAaxBe+K1S4dVywsmaVRQSDOXcfJbOA+DhC2xK2KjcF9zfpooPgtqRcEhXpZ5m
         IBVpkEOB//bVmxkzNbdbUnlW24dX2AayBSRKkDI+TC+vWPdHQRXHE45zNPUNBDcCEVIe
         6EeA==
X-Gm-Message-State: AOAM531xmqqszg/REhLjGuZEIL3HhxirICPnudpAh0oKZK5Hw2yj4YXQ
        4EDvfgo9TH1Xeg1KnIHztBY=
X-Google-Smtp-Source: ABdhPJzriMH8Zg3BqmSxGLS9g9rQRt9WUwBzLpDDk8CXMJ4QPnos7XK8RBHz2OynQMhHnhCCZz/2IQ==
X-Received: by 2002:a05:6638:24d2:b0:32a:caa9:e679 with SMTP id y18-20020a05663824d200b0032acaa9e679mr10419338jat.41.1651704720842;
        Wed, 04 May 2022 15:52:00 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:94d4:5fe2:e117:e7c3])
        by smtp.gmail.com with ESMTPSA id i25-20020a02b699000000b0032b608e2926sm66372jam.9.2022.05.04.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 15:52:00 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ktap_v2: change version to 2-rc in KTAP specification
Date:   Wed,  4 May 2022 17:51:51 -0500
Message-Id: <20220504225152.1451440-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504225152.1451440-1-frowand.list@gmail.com>
References: <20220504225152.1451440-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Prepare KTAP Specification for the process of creating version 2.

The version will remain "2-rc" until the final commit to complete
Version 2.  Adding the "-rc" ensures that none of the development
versions will be mistaken for the completed version 2.

After this commit, Sphinx complains that we now need more '=' signs:

  Documentation/dev-tools/ktap.rst:3: WARNING: Title overline too short.
  ===================================================
  The Kernel Test Anything Protocol (KTAP), version 2-rc
  ===================================================

This warning will disappear in the final commit for the release of
version 2, when the "-rc" is removed.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/dev-tools/ktap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 5ee735c6687f..37b5dc61bfb8 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ===================================================
-The Kernel Test Anything Protocol (KTAP), version 1
+The Kernel Test Anything Protocol (KTAP), version 2-rc
 ===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
-- 
Frank Rowand <frank.rowand@sony.com>

