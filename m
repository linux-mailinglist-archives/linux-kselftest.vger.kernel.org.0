Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AB4DB959
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 21:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358025AbiCPU2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357945AbiCPU15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 16:27:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD81D49C81;
        Wed, 16 Mar 2022 13:26:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a14so2780052qtx.12;
        Wed, 16 Mar 2022 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dAbE+k1+P98yqhuKrp0KrJkICiaHBBC5LcqsK2Pq0c=;
        b=p7Y9YQbdUstS616K33S19Hr05EW4P9gxFQx2RLucq2/CPYGHgDE2L2LJsMeIBMZOTx
         EsXJNPWOVclZbVFK47j91jvxTyRPRPzSZ01MA0F2zY2mGGjm8zxptHBKAx8Wsa98XcBu
         ohvO290c1kWk1QiEVYiim8ulIZR3XNiMNf4qxDq6Bo3RPlEvoQcZAMg2YKLNn4q1l44U
         Bc8IvWxhTFEvvNBp/yFTbc0BBKK9t4x2jrC/UiMAHuF3wzy3vXft/PH/me3/EYoaWQ+q
         HGGqLfIDDnZ7sJPHHvhVrw9RiItHf/IpXTuyMx/wVxdp2NZKB5c+shGH3z3PCzfTP9VJ
         ZlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dAbE+k1+P98yqhuKrp0KrJkICiaHBBC5LcqsK2Pq0c=;
        b=0Rayb2EhMAbdsy+VSLAP/d1g3V0X/gKCsDJPLNOA1J2pEdoa85fFL40A7mTSiBGoux
         dIP7U6dlZU+o0arxhFCAnVf4iO7eX8mMxo37S9dyBvbEPMaRGaiIEKr0hHNv0w4gPnVB
         jfAzMLqolVFv7ZUvTm8LviqIvYA8YiocyaGHrOyJogqP9gJY2YG2YLMaMtsXwojIpWPa
         oXGlbcTSUx+vc2a4StqhdXvOT44OT0EMSqiBvHi8n89TNfw8XJJoPU+on51Z4/lZ9x+J
         KlaVDBwwKEVZqdaTG2jMRyoa1pDLKeGWIVEMAzP6YkFQL7dRsAAcgjs3XGrufUZ05dVk
         MBSA==
X-Gm-Message-State: AOAM530c/2agNY6JQFGAVKn/i1TkI+kB+cl3kVeIvxvbWg+jkVXFNpLz
        VzXNh0syzHeB5YI7Rxi6cFg=
X-Google-Smtp-Source: ABdhPJyOZuvvqdw8lZ0V5St11Nq8PN/ApbNqpDtJrOY4tS0BZ+6pQ/XOl0BefhkQJanz2o9LlHnyHA==
X-Received: by 2002:ac8:5c84:0:b0:2e1:ceaa:d134 with SMTP id r4-20020ac85c84000000b002e1ceaad134mr1307490qta.247.1647462401846;
        Wed, 16 Mar 2022 13:26:41 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:7488:f626:3f3b:5607])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05622a1b8900b002e0e86b8ac6sm1940074qtb.67.2022.03.16.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:26:41 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] Documentation: dev-tools: KTAP spec change version to 2-rc
Date:   Wed, 16 Mar 2022 15:26:21 -0500
Message-Id: <20220316202622.324866-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316202622.324866-1-frowand.list@gmail.com>
References: <20220316202622.324866-1-frowand.list@gmail.com>
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

Prepare KTAP Specification for the process of creating Version 2.
The version will remain 2-rc until the final commit to complete
Version 2.

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

