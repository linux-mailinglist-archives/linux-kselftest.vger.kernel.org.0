Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240F2515932
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 01:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377965AbiD3AAS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381866AbiD3AAR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 20:00:17 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE9B2CE19
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:52 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g5-20020a62e305000000b0050d2dba0c5dso4846786pfh.8
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BD5WA6bauZesMK8L9CoGy0AKOI0erqqwU4MraSAGeVg=;
        b=KC787m2yrK/4rLkdWRx/+Z/w4mAjsMKoeKngidspZ9dHlIHRq6gdEmnWA3POjsB1Jn
         6DotCipbzlzyIf+jGHKA9tAfz9NitVOm7w7zZNri9IVO775pKXr/q1iz44T5oive8xbV
         ttrt651fYEkDc1LjapUCmjNV/Ja+TEBSNyl0/2ONChGpEvc66MDRMW8/FoqF4sAwXqhJ
         gvBo37fIJxB0fsdZE2nS0ZbedHiQK1VYnk8K8fvKrzSUCKApGL7LMW0MkQJAFiB3tkPa
         ulnNjXO717TPkFj3BunWrL0+v0DRgeqmbl9FZO5PmBS6AKDGWH+OeZhQqdqwxA2+0t3g
         H+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BD5WA6bauZesMK8L9CoGy0AKOI0erqqwU4MraSAGeVg=;
        b=BKPWWlkiPxMWpyxV3jGzjZm0WXUzVEbFFoFWViE05mNh7iyF0nWtNMa2Jyg4nO+uAn
         6lFdn9+3GZ08rIoAA7qvoEqubpYzNpxUiX6Q5uUCwzV5jg/m4TE/hdNnWzPWFlAvgnlk
         nPt8wnKN2aUzbQhRwbyoHMskADKWsPYtxVaJkSQVAwVvEjaOHhmbrN3LPKU2Vp8/Z2eg
         hkQJ/XS+Qk5OgOEioTG3OwnrKbrKO0vYeaIu6RQTkwBrFAbhI6B9ZxJJvGgf0A9DOVxE
         oLyo/BtZULr5AhUXmS8QXNpAxo3OQK4ConZg3jcsMBTkKnMuDe1V6JXzYm1qQOYHWsig
         siEA==
X-Gm-Message-State: AOAM5337hGTfvhpSneL2bIaf/dA3lt25X4OpDKqxVVneYZ5SEsW1l2de
        pFgoTTRz3TkSERRFl2zR4GRZjX5cc74BXw==
X-Google-Smtp-Source: ABdhPJzYujVQxvDh1+eW1IXNrWZfE7ZGesdLVTY1zCk/VLegWqK/K1vHrC+wxz3Br7qZJH8yzsaQkgpZLrmbtw==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:1d84:b0:1d9:9f02:bceb with SMTP
 id pf4-20020a17090b1d8400b001d99f02bcebmr6654802pjb.98.1651276612168; Fri, 29
 Apr 2022 16:56:52 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:56:39 +0000
Message-Id: <20220429235644.697372-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 0/5] binder: extended error and logging enhancements
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a followup from [1], in which a split of commits was suggested
by Greg. Additionally, the following changes were removed and not
included in this v2 version:

  - dropped the binder_transaction_log_entry->strerr[] logic
  - dropped the binder_transaction_error() do-it-all function
  - dropped the re-work of current binder_user_error() messages

[1] https://lore.kernel.org/r/20220421042040.759068-1-cmllamas@google.com/

Carlos Llamas (5):
  binder: add failed transaction logging info
  binder: add BINDER_GET_EXTENDED_ERROR ioctl
  binderfs: add extended_error feature entry
  binder: convert logging macros into functions
  binder: additional transaction error logs

 drivers/android/binder.c                      | 153 ++++++++++++++++--
 drivers/android/binder_internal.h             |   3 +
 drivers/android/binderfs.c                    |   8 +
 include/uapi/linux/android/binder.h           |  16 ++
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 5 files changed, 165 insertions(+), 16 deletions(-)


base-commit: 8013d1d3d2e33236dee13a133fba49ad55045e79
-- 
2.36.0.464.gb9c8b46e94-goog

