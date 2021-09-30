Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6689841E34C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 23:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhI3VZB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhI3VZA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 17:25:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C0C06176C
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 81-20020a251254000000b005b6220d81efso10417777ybs.12
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CzR1tKPYxsGrhthMkcPeA5o22pdPd8tz6Qctx/cVYlY=;
        b=gWIUXo1GdYI/2/V6Rr0Wcg/w/YTCaQEWkjRdUxQleTXkOlKZoiyug35UB8njWqwc6N
         Sd8W8Xmk66GFnN6D6r5b5/zz+7i6TDEK1IY7LROn/GarYUXH7jOiR+N0kqZejScVN8v0
         1JsSHVa99roHMJQY9Wvb7OaU+3AIjLtjCFm3HXKKfxI5ORI4dwR0wFjvQbMLfp6FGZkT
         zwND7qotqTvMzSTUuuzdeWJAGuRhO+D0r4kVe9v9lhsFIWcbTDJGT2m9WVaetBIN4xWe
         y2mMalw2He5t5A/H5Fyt6RQiRlieDHoKS2g3NmKS5NEgR++Q0WSFpGVmy/tg7vaI7DPq
         H8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CzR1tKPYxsGrhthMkcPeA5o22pdPd8tz6Qctx/cVYlY=;
        b=RayAlRYUxmuBNLJNeIOdd92k2I+CeQVTmxXSfC1fekoT9r+lu1PQXzw/xbC1JYbhyI
         tQnBZPWzR2dNxy+FD8aGVETRIlUlaF16ztT/6rslA+3I8bm6P+VaTGeAfRCU4dkF1hxu
         QCfBKA/duQTw6bkYfumF9ua+wyswRZgH9DX9zJCnI61YQs4EtgMXTOHLNpRdLecQORpX
         puXu5oztchSHXowRyqD40urhHzLvcN7UQE5IS1fcieuZlX1BqpJTdTf6OTljdft/lT9A
         qHsGRODeus6yoTGBH/Mc/u+Pv81WL1YhZ8ZRc1UCabGoIj1LCQOcSgQb/PjJXsTynwCN
         E3Xw==
X-Gm-Message-State: AOAM530r730/iPt315s3OeXThC6uPuZeRHHtNkFU9UTrV5oLE67RwZ1S
        sBN8xFZXEZxdwV7A0oU/lU54R6wyAd0525Cbn+5E
X-Google-Smtp-Source: ABdhPJyqGFnp6gcLABO3XZ/sJo1FcUdnzqjMRKQS555L9bpcOLELdLIvGzrLuAxjw5MiSpIQdd2Au+KnI0Hv5Q12xu9/
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:fa06:3b29:d3c:37e6])
 (user=axelrasmussen job=sendgmr) by 2002:a25:90b:: with SMTP id
 11mr1685537ybj.192.1633036996833; Thu, 30 Sep 2021 14:23:16 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:23:06 -0700
Message-Id: <20210930212309.4001967-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 0/3] Small userfaultfd selftest fixups
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes from v1 -> v2:
- Substantially rewrote "fix feature support detection"; previously, it tried to
  do some larger refactor wherein the global test_uffdio_* variables were
  removed. This was controversial, so it now simply queries features in
  set_test_type, and leaves the rest of the program structure largely the same.
- The "fix calculation of expected ioctls" patch is conceptually the same as v1,
  but changed slightly to fit with the modified feature support detection in v2.
- Moved patch 3/3 to 1/3, since it is uncontroversial and could be merged on its
  own. I don't want the other two to cause merge conflicts for it in future
  versions.
- Picked up a R-B.

Axel Rasmussen (3):
  userfaultfd/selftests: don't rely on GNU extensions for random numbers
  userfaultfd/selftests: fix feature support detection
  userfaultfd/selftests: fix calculation of expected ioctls

 tools/testing/selftests/vm/userfaultfd.c | 157 +++++++++++------------
 1 file changed, 73 insertions(+), 84 deletions(-)

--
2.33.0.800.g4c38ced690-goog

