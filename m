Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70760591895
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 06:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHMEVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 00:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiHMEVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 00:21:14 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A413F7C;
        Fri, 12 Aug 2022 21:21:12 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id v128so2592057vsb.10;
        Fri, 12 Aug 2022 21:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=l5QhBCqddlI8zFFrJ6dcczGUo8Zl7BOnJTXXcuz0uf8=;
        b=WJiQS057etU5y+OyF038aIuWP9cX9WQOTZwBr9UJi3KtmszMNw5IexdnCKZWXQdTti
         Qg/ldDtMIeY6BNxefmyVJrASeMdoVfBVNl9HVQwKnDGciNgVYbsRzbqBnv6feowrVUB1
         GHEEk3ZmqTLbXLuEAnQp6D0DzswbcN2rzXVXVagz8cEg5wjVdlJcsMiBUTNQLxwT7m4m
         sYahmHM5hA9/HrulVNRtNJGGxo6WsJU+ulNWTTTXsRTadfsQCTNWrCFRqSwIZSlLXtNf
         xwrUrtItE7SZKEBCuMyk3iaxZb6vBe9AczgARTyZIhAbSFVbZRpuCPupy0O7RdYphu7S
         hj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=l5QhBCqddlI8zFFrJ6dcczGUo8Zl7BOnJTXXcuz0uf8=;
        b=JSTS926yl5dfTb6HJT/eqZlMwppJ7FDFU37gDCsfByUI7jVa5dVWhLFVR0BRvryD39
         fzW2Q3QwUBgvx7fVUaldFQeA8e6RIm6G9we5j+WVl9tUERaR6UiUuzVhdjy70ff1Oj13
         aTT36/Nael4HFfv2Wg4/z/emNLiNoDsQUMR+MXZEKoqUN4mVbK0jH8JVxwlwdY7z7umh
         M5BJ0P43GRM8le8hV8nKQcY6jqaBPvu2d7IC6CXv8X14BYlbt5BykIATr9o5WWTPjafA
         kEC9AtMyVp3Plo1v3UiCcVFPfcNiyCUjvvULvVR0TCD3NTx4JC4z0+TEEqS2Idi6TSrQ
         ccxg==
X-Gm-Message-State: ACgBeo0xRVw7VpQE1WgUvBfLzZPJwcyB+PO/xEdEyb88xuuV2wbCVB0a
        s4XDF5VKRc1ISsspHIQ1uYg=
X-Google-Smtp-Source: AA6agR5bnQsjAGqCfJAxx71BLEzy65LTcK/4akPQkEdVFyalH+weqqqM2Z1OESZ1T7LAi7OCqwn3fw==
X-Received: by 2002:a05:6102:512b:b0:387:cc8f:a0fa with SMTP id bm43-20020a056102512b00b00387cc8fa0famr3061872vsb.3.1660364470775;
        Fri, 12 Aug 2022 21:21:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056102290a00b0038712af0dbesm2434646vsb.22.2022.08.12.21.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 21:21:10 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        corbet@lwn.net
Cc:     Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Documentation: Kunit: Fix inconsistent titles
Date:   Sat, 13 Aug 2022 01:20:53 -0300
Message-Id: <20220813042055.136832-3-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220813042055.136832-1-tales.aparecida@gmail.com>
References: <20220813042055.136832-1-tales.aparecida@gmail.com>
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

Use the same wording when citing and describing Kunit parts.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/architecture.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation/dev-tools/kunit/architecture.rst
index cf9e6e3eeae4..8efe792bdcb9 100644
--- a/Documentation/dev-tools/kunit/architecture.rst
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -6,8 +6,8 @@ KUnit Architecture
 
 The KUnit architecture can be divided into two parts:
 
-- Kernel testing library
-- kunit_tool (Command line test harness)
+- `In-Kernel Testing Framework`_
+- `kunit_tool (Command Line Test Harness)`_
 
 In-Kernel Testing Framework
 ===========================
-- 
2.37.1

