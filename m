Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C9767357
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjG1R3g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjG1R3c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:32 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76D3A8B
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7748ca56133so23305639f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565370; x=1691170170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRetka3XmHjrduRcLx8auHl/RYMdUC7YkqhFVrnaMJ4=;
        b=bP89L6dvIsj5o9kT4HZvJTW4rK3q1szR6j8h5AZVFErx80ziNL/0QSsSH0FzC5C7fE
         8wIjQLGud6CG1XEsMSUDxjnvq+IAFaBOVMbtwQGI+2u3qnecAY8kMMCWGvEgOhIRthZP
         NQVqr1kjTFzatLhzQDTlaAfpvh91DjUUQYdus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565370; x=1691170170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRetka3XmHjrduRcLx8auHl/RYMdUC7YkqhFVrnaMJ4=;
        b=MSDp/c3VzO88zwEOlYnPA9xe2ahoZJ0nUl9P29/eDSMfrHH3BiKXRjZwZlhPQKuAqc
         dp731tf/E8jx1oDwjO+TLElI4gEExsoi0In2h03BxsSw6rlgvi54elFLUnxVvWTwldLq
         uXw+9AEhRze2rbthnXtvWLEjow/bKMVxsSl8VFxiDsXlp/a/v1t7+BUyHVsaHIl489w2
         PBPmgZ/CNOFdGHa/iuBJDh8rAjFD62bB/nGIIIHOokhjL4hci4l3vr3MsGLp7RR/cnXe
         C5yioHu9cV55F4GwtzbiJgOyoQl7OfmPuAXP5uxmGLBfeikhAZ+jyMRrI7gpMYe1Tu1n
         ez+w==
X-Gm-Message-State: ABy/qLbgzGc5+r7kKKSFA/E2GzZHMAN8WkJZUWOH9gdfCDLy1WOkLyL3
        2DdcTGGeYItL4jgmW6dshHVnhQ==
X-Google-Smtp-Source: APBJJlG++dQGjr9Fm6NWZbXMUUHRFA6B5WaaKhVtSvn74pz3s9HPc7XbjI4la4/GVLUyqkW+AyakaQ==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr248459iof.0.1690565370474;
        Fri, 28 Jul 2023 10:29:30 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:29:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, naresh.kamboju@linaro.org,
        kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, davem@davemloft.net,
        lkft-triage@lists.linaro.org, netdev@vger.kernel.org,
        llvm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next 0/3] Connector/proc_filter test fixes 
Date:   Fri, 28 Jul 2023 11:29:25 -0600
Message-Id: <cover.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This 3 patch series consists of fixes to proc_filter test
found during linun-next testing.

The first patch fixes the LKFT reported compile error, second
one adds .gitignore and the third fixes error paths to skip
instead of fail (root check, and argument checks)

Shuah Khan (3):
  selftests:connector: Fix Makefile to include KHDR_INCLUDES
  selftests:connector: Add .gitignore and poupulate it with test
  selftests:connector: Add root check and fix arg error paths to skip

 tools/testing/selftests/connector/.gitignore    | 1 +
 tools/testing/selftests/connector/Makefile      | 2 +-
 tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/connector/.gitignore

-- 
2.39.2

