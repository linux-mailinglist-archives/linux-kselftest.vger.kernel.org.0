Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639FC3248C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Feb 2021 03:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhBYCPf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Feb 2021 21:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhBYCP1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Feb 2021 21:15:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0DC061756
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Feb 2021 18:14:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f127so4368186ybf.12
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Feb 2021 18:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=d7qjpU8XKEfBqlMiCyPh8nFPbvWh1eJ63+H3QFuie5Y=;
        b=UMLqTstxNUBx26sg6GLN6yLQPAjd2tgC7PtHCBbHKD4iSU1KIibkTuyxM4iqtkGaCg
         Ir5emR92f/9DRcZXi+gQ01lXg0qFQy1IjrPYgogIJyIzp/E/dzz+RuR4G4xHh4rpFSjE
         KxRt4gnRJ0ElbEoeuEI1i3RJ0Svq53VVxRgipBXKZ7oUcdEIDkZjEmqnhG9Z4/by8xpb
         uhmiPiMYSHUi2h34aYQdi73+ZbPCms3CJAaw/DEiQB5utN3e7pP0npwWSMuGcu0Q1DRK
         IL8TaM0PNMCbmKdnu6yJ9/5IVHqXEzbuNYDLaEagmMRZl+VZ3N6UNqlAJRaP1ZOfpxl3
         RCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=d7qjpU8XKEfBqlMiCyPh8nFPbvWh1eJ63+H3QFuie5Y=;
        b=g0hdyqqy7hQHRxnnRk+i8RhrOFiqhtCHq2gNj+H2R8HCGweHCgusDjbQLN9T+BeIrP
         1D18Me7GO6llzIrCHzU7qTxUQvPSTim0clP22fqcxkFwVVJI9PWwqWB03xKGL8sBAmr8
         LBH56ijp5VXVWwMJxBOFHnURrp9nhwlZ4E/N4PP8TK+BE7U77M6iMu3ZwBSk8kGN5NwK
         D4tbIkAgAZseuORQnETzkyitvskeI54iVaGy5PJVubYBqLLGj2qyKQXeGzmaF0NOZuGx
         Glz9yJWCMbSbKGzEQkC8Ul5edAEDwDwgtLXQ6qgK8u/xgwKMFVwcs/3jYudJtclf6gVo
         CLsA==
X-Gm-Message-State: AOAM532Cd9Hv13CBlshOSiahJkzqXJmjqxRekDjcnO7GxMnPzka9gYse
        mrQtE1XBtc2N+0fsCL9nsyTTiPwE/BDtQzJ8GYYj
X-Google-Smtp-Source: ABdhPJw98ig0Yji2QsABXFSreCF+ogXsubw5CFDtC6GaaoOwFYEUFPOQp0YULt8aO2A/kWa9cWqMeli63FZEp52R2m/7
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8112:: with SMTP id
 o18mr902059ybk.208.1614219280483; Wed, 24 Feb 2021 18:14:40 -0800 (PST)
Date:   Wed, 24 Feb 2021 18:14:15 -0800
Message-Id: <20210225021420.2290912-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 0/5] userfaultfd: support minor fault handling for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Base
====

This series is based on top of my series which adds minor fault handling for
hugetlbfs [1]. (And, therefore, it is based on linux-next/akpm and Peter Xu's
series for disabling huge pmd sharing as well.)

[1] https://lore.kernel.org/patchwork/cover/1384095/

Overview
========

See my original series linked above for a detailed overview of minor fault
handling in general. The feature in this series works exactly like the
hugetblfs version (from userspace's perspective).

I'm sending this as a separate series because:

- The original minor fault handling series has been through several rounds of
  review and seems close to being merged, so it seems reasonable to start
  looking at this next step.

- shmem is different enough that this series may require some additional work
  before it's ready, and I don't want to delay the original series
  unnecessarily by bundling them together.

Use Case
========

In some cases it is useful to have VM memory backed by tmpfs instead of
hugetlbfs. So, this feature will be used to support the same VM live migration
use case described in my original series.

Additionally, Android folks (Lokesh Gidra <lokeshgidra@google.com>) hope to
optimize the Android JVM garbage collector using this feature (a paper
describing a somewhat similar approach: https://arxiv.org/pdf/1902.04738.pdf).

Axel Rasmussen (5):
  userfaultfd: support minor fault handling for shmem
  userfaultfd/selftests: use memfd_create for shmem test type
  userfaultfd/selftests: create alias mappings in the shmem test
  userfaultfd/selftests: reinitialize test context in each test
  userfaultfd/selftests: exercise minor fault handling shmem support

 fs/userfaultfd.c                         |   6 +-
 include/linux/shmem_fs.h                 |  26 +-
 include/uapi/linux/userfaultfd.h         |   4 +-
 mm/memory.c                              |   8 +-
 mm/shmem.c                               |  88 +++----
 mm/userfaultfd.c                         |  27 +-
 tools/testing/selftests/vm/userfaultfd.c | 322 +++++++++++++++--------
 7 files changed, 293 insertions(+), 188 deletions(-)

--
2.30.0.617.g56c4b15f3c-goog

