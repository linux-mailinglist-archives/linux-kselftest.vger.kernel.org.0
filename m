Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449CA203EFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgFVSQ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgFVSQ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 14:16:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D89C061573
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d8so7899574plo.12
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs1TzbVWJcRX8QIkepO+whzfzA7CjoIqZIBpgLWkg48=;
        b=mNyAXwzXxYYhNCAHgqFwOMl8/f3f+cfn9sRi1jO3ptYqEqq24+KHoJqcbDFhKS6Yl6
         Y5vq/Ru0pZsrqwsvcYpi9Sj4/h1lSCo6+QSOjSuZdtgsOk7zIw652Hw6W4gLHEEpugGG
         cKHE+ab+jFSL2sZBEELNtSMkajV+8MeXa2wRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs1TzbVWJcRX8QIkepO+whzfzA7CjoIqZIBpgLWkg48=;
        b=awRiTzsNz6V4crLNucpIlwQK0HyvSplMduHGhicUv8giaqEWuB6NMhrPC6PU4BAFrw
         EV00P7bz1Ef8a2rsU4/RuRu3fYNj7aeS+5joBe8MLV7jRWK5I7zgDxdKWfv9K7eqKPIw
         8YnXijLVqOlGsZ3vmb67AlPph9HQ9tlf3JhQjBwVYPJbjHLToMpTTWiXm5YBw8VkakXz
         UqB3rAeCRMFLcldr210yCgU84bnmDsvhg5u+r4/MADPswavNlYO809DDKLkAu/ItX8bg
         maqHji9izFUOlBp0yb5Eq3Qv7XqFB3dpcTGvtgywMyhmHR0La0P2TXBmLjXd91IVcgKW
         Vs1g==
X-Gm-Message-State: AOAM530arsn3HcrHb7zzL32VTR8WXMfxPR6ZhzCmrGqS2CpFjltyxjSo
        OSCH/m4mDfaNacNP8ru3mHPQoQ==
X-Google-Smtp-Source: ABdhPJx4Xvw8G70Ihu9eJfSDjh/kyqUe3WotbHQ6CsslNUCxNiCGGS9DgOCH6cVeGQ6wSyyWHbjT0Q==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr21132209pls.304.1592849815700;
        Mon, 22 Jun 2020 11:16:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k26sm11732375pgt.90.2020.06.22.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] selftests/harness: Switch to TAP output
Date:   Mon, 22 Jun 2020 11:16:43 -0700
Message-Id: <20200622181651.2795217-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

v2:
- switch harness from XFAIL to SKIP
- pass skip reason from test into TAP output
- add acks/reviews
v1: https://lore.kernel.org/lkml/20200611224028.3275174-1-keescook@chromium.org/


I finally got around to converting the kselftest_harness.h API to actually
use the kselftest.h API so all the tools using it can actually report
TAP correctly. As part of this, there are a bunch of related cleanups,
API updates, and additions.

Thanks!

-Kees

Kees Cook (8):
  selftests/clone3: Reorder reporting output
  selftests: Remove unneeded selftest API headers
  selftests/binderfs: Fix harness API usage
  selftests: Add header documentation and helpers
  selftests/harness: Switch to TAP output
  selftests/harness: Refactor XFAIL into SKIP
  selftests/harness: Display signed values correctly
  selftests/harness: Report skip reason

 tools/testing/selftests/clone3/clone3.c       |   2 +-
 .../selftests/clone3/clone3_clear_sighand.c   |   3 +-
 .../testing/selftests/clone3/clone3_set_tid.c |   2 +-
 .../filesystems/binderfs/binderfs_test.c      | 284 +++++++++---------
 tools/testing/selftests/kselftest.h           |  78 ++++-
 tools/testing/selftests/kselftest_harness.h   | 169 ++++++++---
 .../pid_namespace/regression_enomem.c         |   1 -
 .../selftests/pidfd/pidfd_getfd_test.c        |   1 -
 .../selftests/pidfd/pidfd_setns_test.c        |   1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c |   8 +-
 .../selftests/uevent/uevent_filtering.c       |   1 -
 11 files changed, 356 insertions(+), 194 deletions(-)

-- 
2.25.1

