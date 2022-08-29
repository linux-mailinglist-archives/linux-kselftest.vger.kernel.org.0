Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE65A5799
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiH2Xcl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2Xcj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 19:32:39 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3282848;
        Mon, 29 Aug 2022 16:32:38 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11c5505dba2so12935167fac.13;
        Mon, 29 Aug 2022 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zCCrxwttgbjoHUFJXgo6b/XsRuRpmo/BC4fXPdswmEY=;
        b=kz3FwI+wQpYmECto1j3t7UVr+XwvZi9hNcExNwUFXNxa5r/hFFG8/DswIEPj7xVSBU
         qWHiaRhMEEy8z+D1svO+bGldvLZBTRjbdJj0LfL3ty+A5jPOvT8jVKz456ZHzjWHTuGR
         bP1Wv/vTiqQWYfOxbuKUaHvtuCpG624OILzqCkvUDCf6kuZ/IHpYWkf0odGha8jhEy2C
         DKPmqH8/bKMF/54p0eEG89FDEDV9vAbqihLxosQm9+YQDNmQLSSY6+N6KlYygsigO1ZO
         WK5uLjfq2po8cSa30xwtujNdvGLU88SAfjT4tNAtohSQNupNKdP7Bf+R95c95/8R6qKn
         z7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zCCrxwttgbjoHUFJXgo6b/XsRuRpmo/BC4fXPdswmEY=;
        b=P+7OWO/Ei4h5KpTG7Iy2Qk8I3LzebePF8lx+/mcMg5UxwDdkAlj75x/pQCCHzobnwC
         kPJNM8a0AV4096WP/7HA0x9E/Q/iHBqxBov2gVUwhNa4QMR9fpq0yDY/BeFFZ9+uBBLO
         4oAkX3hRyZ+q23UwH/Gr6VeRM4vLgrxaBd4Jy6gTxhcZR66OUryxxt0QAf4f+eYwdsZZ
         6Uh0fOMMvIqwEla1e69fnfQQjD8IH7hwWfKGLHLhuQ9lqJVuGM4XLY6Qh59RDbrun/1e
         eHgtgW4jgsZkG3ebh0WIfz0tjvC6nmwcznuD7pTGgypIR2vTKaO7fakgPEEcJpYqGOdx
         Jl3A==
X-Gm-Message-State: ACgBeo12o2OD7D8sUbv7+s3oLzweXkIU7staKSDY9c6hA9bTNJ9wUcAH
        sTT+w7RN0nUwgA1KTvZb5iObOkS0368=
X-Google-Smtp-Source: AA6agR4Xp2gdmkaqUZy4gjFgnGcMvbPg7exr/0seoU1LHcMYmt7U8xiB6w5TKWzNoQSGQ5UCZPW0cQ==
X-Received: by 2002:a05:6870:240d:b0:11e:ff35:5ce8 with SMTP id n13-20020a056870240d00b0011eff355ce8mr3069268oap.232.1661815958106;
        Mon, 29 Aug 2022 16:32:38 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:dd06:f7b4:b579:6561])
        by smtp.gmail.com with ESMTPSA id bu28-20020a0568300d1c00b0063b24357269sm4183611otb.13.2022.08.29.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 16:32:37 -0700 (PDT)
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
Subject: [PATCH v3 1/2] ktap_v2: change version to 2-rc in KTAP specification
Date:   Mon, 29 Aug 2022 18:31:49 -0500
Message-Id: <20220829233150.3564612-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829233150.3564612-1-frowand.list@gmail.com>
References: <20220829233150.3564612-1-frowand.list@gmail.com>
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
index d0a9565b0f44..b9a57ceddd4f 100644
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

