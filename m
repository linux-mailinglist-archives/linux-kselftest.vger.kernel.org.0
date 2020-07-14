Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04221FEC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgGNUli (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 16:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgGNUli (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 16:41:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D7C061794
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 13:41:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h4so13870636qkl.23
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q3rrVuP9UcmnEc3sFtdze+zW9FfErqo0k9Y3L17GKQE=;
        b=hYirHOdzI0sQFji9qH7roDn0LxGicKlGTxMz2qOWPolOluUbgars+R3ttiDM2N4DMH
         YOers1ca1QTctawzrEGsx9GDMOi0hYSQytUtBQyndWskw/iNZNombd6ldqho1wOu5vr5
         r/KbpGk1kthb4SfKnhtgRNWosVFE9GoLYxiZ63Q3QowMjKMRa5WpW8KpbDCKAnDluOpC
         9uDWcDFgIu+zmzs199k/Y2Kfykz6EFKNRsvWVmu3ChmRbjz7/fGaQq3ffwWuSk7itBqc
         vHVzLJYYb2quazJvK7I4AXOAtzD3pSMfT1gKur4haF60DwD35BZX6gG+rm/lucPztw2j
         Dzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q3rrVuP9UcmnEc3sFtdze+zW9FfErqo0k9Y3L17GKQE=;
        b=fJzZ096m8sfQkC/oKTRqPTHNCEQifhv1ku5x7nkMmhrgQK4dB0+15ixuZQmGa9T8ta
         2ERYW4QZS/wIKzMS/RqFmd6PzayYFG3417e43ZE3SOIjcTnRexlKXVzmRg0ai8HY8lJO
         57BzJAsupQ7GE7V9bzQ3oqPnVprUvsbAmU511TZ8SvlsjzEFHbDbhGK5tjkiwlGliiOF
         oeIF9OCaqqahDHZRXEa++UTxY4UjGgbMcW7v0UGm8ISldHYp0nw6Ts87v3iSlQaDYUsA
         puaPn4uNR0L9ksANZElOFSAeUPqxuCdWtkeqmmZVn2K8Eph90lmGiZzVP7VxKGm4a69z
         5J7A==
X-Gm-Message-State: AOAM530tD3rklR3IzufE8oe1igcLu7pLKbppMkHmFQwAbSsaMoAYotw8
        /yQsttOd+gQJIViVuvghBSW/fzDYRyswOfugrIZj/w==
X-Google-Smtp-Source: ABdhPJxjEriJNkfflDAtJ6oQdSMaIhOS/i3pb/+Nqu8CMMkXiwelLWUdnwm3+uOX+eRbCCDp7ZoW9QJPKNtEH3OoiCnoAg==
X-Received: by 2002:a0c:e008:: with SMTP id j8mr6522255qvk.87.1594759296996;
 Tue, 14 Jul 2020 13:41:36 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:41:28 -0700
Message-Id: <20200714204130.54729-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v1 0/2] kunit: tool: fix kunit_tool unit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, vitor@massaru.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Apparently we haven't run the unit tests for kunit_tool in a while and
consequently some things have broken. This patchset fixes those issues.

Brendan Higgins (2):
  kunit: tool: fix broken default args in unit tests
  kunit: tool: fix improper treatment of file location

 tools/testing/kunit/kunit.py           | 24 ------------------------
 tools/testing/kunit/kunit_tool_test.py | 14 +++++++-------
 2 files changed, 7 insertions(+), 31 deletions(-)


base-commit: a581387e415bbb0085e7e67906c8f4a99746590e
-- 
2.27.0.389.gc38d7665816-goog

