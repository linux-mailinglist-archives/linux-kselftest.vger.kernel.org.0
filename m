Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95FE2202C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jul 2020 05:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGODL2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgGODL1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 23:11:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE01C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 20:11:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so598689qtm.10
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 20:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43tn4SCdUQPE+RtWwrBeE6OYYiz+sN9YblVYLrd3cSI=;
        b=r83DgT29XWRfj/E7kT6DQYKdCfnI9xI/0edg/bbFkV//C89wvNTd4nIGL/BjrPYIWC
         tvFQi2YYH4+gOuGYcFnVDui7pyAX77p2sV/fCKLn0+80JLmbDB8KYA2MYENTAN4mBcr3
         m3/1fScIkCh8vnuV2VqtumrP7DHivlE2HhB0zm+0VMZuQVgv1yXJuJ9hyZXZaU9bHYpq
         HHpIxZm3rtMT/yRX7tvMg7/N2m9ffCf6LD2oepP8UHxOcpq4DamHysbUISrm7oGUbKHc
         GnJEe4LUjs6ErJS+KTAhjR+Qer6Dsx/R1xoehGnGR1d0rOpqP4FUq8ZAqwSvPvsg1JjS
         TsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43tn4SCdUQPE+RtWwrBeE6OYYiz+sN9YblVYLrd3cSI=;
        b=ljalhU6zizTwycCyOkx9GEe5YoXjXLiYGQNJqi1W8jwgyzB3lUNaXqtQ5YuBBDpZzR
         0YIi2Lrw6aFFtUDCVOuOiGqjCzybBmodhftlaRRginj0k0NkWmhyTHLgzer9S/+YPUhO
         FaqYLAK+Rc2Sy+sYSH+YTa16B01kPfcpmSUbPSvicdRwN5YWolu/xXgn42zOCjE17lwM
         jina6DtoOJ/LG4yEDmhwxTiyeUOJk+ro4CzCs9m800RASDaiM8KXZFxElNRGhLTTI8c6
         uhN/Lgp1nXAVYQ+nhYQa0RtC2LzvjXMeOS1UgTasgrcRZx0C5Ee4iFr7gfdF/HIPMAW+
         5HQA==
X-Gm-Message-State: AOAM530A2wnS8OkgjHnFRtFbKkokUymeAr1RfnCkL8bdCdg61lZK3Mc7
        uel5k88Oa1hx05swQmib9bD1SA==
X-Google-Smtp-Source: ABdhPJz+ERBPdgPWk+4c+xiGhT5xApaA/bLt7Vj/xp0Mu7m61aF81TVotdoVo7ixAdGzSmR3E69gqw==
X-Received: by 2002:ac8:40cd:: with SMTP id f13mr7767036qtm.373.1594782686419;
        Tue, 14 Jul 2020 20:11:26 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id x29sm1269229qtx.74.2020.07.14.20.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 20:11:24 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC 0/3] kunit: add support to use modules
Date:   Wed, 15 Jul 2020 00:11:17 -0300
Message-Id: <20200715031120.1002016-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, KUnit does not allow the use of tests as a module.
This prevents the implementation of tests that require userspace.

This patchset makes this possible by introducing the use of
the root filesystem in KUnit. And it allows the use of tests
that can be compiled as a module

Vitor Massaru Iha (3):
  kunit: tool: Add support root filesystem in kunit-tool
  lib: Allows to borrow mm in userspace on KUnit
  lib: Convert test_user_copy to KUnit test

 include/kunit/test.h                        |   1 +
 lib/Kconfig.debug                           |  17 ++
 lib/Makefile                                |   2 +-
 lib/kunit/try-catch.c                       |  15 +-
 lib/{test_user_copy.c => user_copy_kunit.c} | 196 +++++++++-----------
 tools/testing/kunit/kunit.py                |  37 +++-
 tools/testing/kunit/kunit_kernel.py         | 105 +++++++++--
 7 files changed, 238 insertions(+), 135 deletions(-)
 rename lib/{test_user_copy.c => user_copy_kunit.c} (55%)


base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
-- 
2.26.2

