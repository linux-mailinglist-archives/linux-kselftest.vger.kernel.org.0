Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A7E4DB95C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 21:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbiCPU2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357944AbiCPU15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 16:27:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74BD3F8AE;
        Wed, 16 Mar 2022 13:26:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v2so2821712qtc.5;
        Wed, 16 Mar 2022 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYynkwQ+j3b/YGx/TNtwPxZ5TKXzPPLTT7lPgCZm+48=;
        b=DzH36QZjHNcrZ0UH3XWqpH7SBIvo6qxszr0gTMibyuzJMeuva7mRN9TFl0oiYdnYUE
         FGF49z9z6uzwT68tr/hmHPEiExZSm/gPs0gxTgq0Hs8H7RvhCGWM+ambf3f3LOqxguVU
         yPZO5j+UrdUUl1vkAOwvBK3jvEKbMHD9GnVo5fYaLHTy5KGuZvWEOEY0qXAFIss+GTuF
         UZlMsSDenY9IG83XPNN4FsEGIqeGzMZphQKVqqVch1wF9GR1sbzZyjbCrTAmgdKvpVbV
         63x9+aXkKCwhfqF/sk+fBURf0uoLkIh6JlHhQ8YIWW/a32CSj3o1NH4rEuUhJNKOKS3f
         EIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYynkwQ+j3b/YGx/TNtwPxZ5TKXzPPLTT7lPgCZm+48=;
        b=FrDn/n8DWgIh6adtm5uVePd+Q4g0vT/PQzz/fUFYc38S57u+yxImQOOUPuZil9xRmS
         05SWvTy99/pO6XumJ5cGGihpglCsi03eA3fOHebkM4yceDXIj2V2cIwyIySKU9oRuod9
         gjgEeUFABurkGIX2J6aJnUifiNd6Su5Xq1fD6rdhGBCu6KkkSsptj0cJdrXKr9+dtY0t
         InG09egxumpbxO/Rg7b47niLXiEkbyT0xXZQ5ZUg2neiSBG7aPVsSvKI1/GkUtyu+uOj
         YawWB4QP/9al4Roal1i55YfuQgqLRMAo0RhuoRbCbWlfcHqHJjBiqogS94q2zG4O/0w/
         KtkQ==
X-Gm-Message-State: AOAM531f3lwgOdvoFlDPackbt7fx1S4o/wTYAjcsXNgUv9CrKKN7Fi9r
        wSRwEvaC+jKYsIzGOUH3uB8=
X-Google-Smtp-Source: ABdhPJyUyCHgYvLQH1YEBa8eWojwkGpa42X+W5njt6/tHky6i+6enBnVEZTswalGWe4gbYUBQV4BYg==
X-Received: by 2002:ac8:5711:0:b0:2e1:cde2:6922 with SMTP id 17-20020ac85711000000b002e1cde26922mr1383558qtw.116.1647462400814;
        Wed, 16 Mar 2022 13:26:40 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:7488:f626:3f3b:5607])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05622a1b8900b002e0e86b8ac6sm1940074qtb.67.2022.03.16.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:26:40 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Documentation: dev-tools: begin KTAP spec v2 process
Date:   Wed, 16 Mar 2022 15:26:20 -0500
Message-Id: <20220316202622.324866-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
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

An August 2021 RFC patch [1] to create the KTAP Specification resulted in
some discussion of possible items to add to the specification.
The conversation ended without completing the document.

Progress resumed with a December 2021 RFC patch [2] to add a KTAP
Specification file (Version 1) to the Linux kernel.  Many of the
suggestions from the August 2021 discussion were not included in
Version 1.  This patch series is intended to revisit some of the
suggestions from the August 2021 discussion.

Patch 1 changes the Specification version to "2-rc" to indicate
that following patches are not yet accepted into a final version 2.

Patch 2 is an example of a simple change to the Specification.  The
change does not change the content of the Specification, but updates
a formatting directive as suggested by the Documentation maintainer.

I intend to take some specific suggestions from the August 2021
discussion to create stand-alone RFC patches to the Specification
instead of adding them as additional patches in this series.  The
intent is to focus discussion on a single area of the Specification
in each patch email thread.

[1] https://lore.kernel.org/r/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com
[2] https://lore.kernel.org/r/20211207190251.18426-1-davidgow@google.com

Frank Rowand (2):
  Documentation: dev-tools: KTAP spec change version to 2-rc
  Documentation: dev-tools: use literal block instead of code-block

 Documentation/dev-tools/ktap.rst | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

