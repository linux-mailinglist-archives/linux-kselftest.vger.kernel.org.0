Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D41F69DAEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 08:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjBUHIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 02:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUHIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 02:08:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA62A27B
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 23:08:45 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e9so3256355ljn.9
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 23:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW5OTipyHanuMGGEr19+SfAUNI4fh6TQoQ0SKxiVbds=;
        b=xPFad2O3o2T7JjjqimSZr5bDzhsCKNA/ZkT84IvIGWjisfYMVY8ez3JcB+xGEpxfzH
         gzirFObAQN+Ea1riiRgJJHdkV60VszkVhQ5ytQBgoncx5bHNah9foz2MkmgJvH9rJoiN
         d6tn2jmty0h7uLUWzB07Njf46FAaTlNyEzn9BLtanEX3CXGHtAMFNsW1ruwFyhQ+KwDd
         ygE+DhlYQOCkxiy7y5GaQpMsQYTHikXVAIBNl0xtMndF5GNCHqKtF9YGZzi0KBl+t0lG
         bHzSDsMIdnKH9n22w8OfOrLDZgR4nTLts+MKO+3nKWe575Ub2BfB5D+IwyVIcN864IWy
         i/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW5OTipyHanuMGGEr19+SfAUNI4fh6TQoQ0SKxiVbds=;
        b=e2+51p+A6Nsy0jPvo3CySk0WyA14Wmt49rug2IOD0BA3JY/0PdE/G9K9augqrC88Yf
         NGx5klty8MtfreVNBwGVqMrKhYE3fA9u7LtRwjAiQ0pGCz5v0PP8BEt3lwIH7OKEXTFd
         lcVetysQpomuQc0czh+JeAfCxHb6wzUNbsNx526gAZW63EsVuDj6Ajc8ifN6tGvMypai
         /aWRSB3P8JXHisWErKKjAL1XF7pk/8G185aFdIOoTfVdqGMEKCrjuL9tGPmn9mHt/ENE
         3UClus2jWkaiPUvG+up5LREWqzoYdr8E38jn8+bbUOBmYqczLnnZFG6BT6GUHjhi7iui
         GkJQ==
X-Gm-Message-State: AO0yUKX4Yk27lFV1LaZXuG3qLpbjCJrLy3F5X65r7MNeVQEGOh11Iewq
        w/EhXryVnbtPRhnG+QTfgtY/dQ==
X-Google-Smtp-Source: AK7set9MVl9dE0Gqmud9UHGJXFGDa+7JeOO8MZD8yAHqxQi9OKB89/YMGpoENiqGS13QSoc5sBuOfQ==
X-Received: by 2002:a05:651c:1214:b0:293:5359:79e5 with SMTP id i20-20020a05651c121400b00293535979e5mr1539070lja.45.1676963323899;
        Mon, 20 Feb 2023 23:08:43 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9611000000b002934ed148afsm1809964ljh.52.2023.02.20.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 23:08:43 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     sj@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests: damon: change scripts to be executable
Date:   Tue, 21 Feb 2023 08:08:37 +0100
Message-Id: <20230221070837.1502935-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221070837.1502935-1-anders.roxell@linaro.org>
References: <20230221070837.1502935-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running kselftest-damon The following issues shows up:

'# Warning: file debugfs_attrs.sh is not executable'

Changing the scripts so they are executable.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/damon/_chk_dependency.sh                  | 0
 tools/testing/selftests/damon/_debugfs_common.sh                  | 0
 tools/testing/selftests/damon/debugfs_attrs.sh                    | 0
 .../testing/selftests/damon/debugfs_duplicate_context_creation.sh | 0
 tools/testing/selftests/damon/debugfs_empty_targets.sh            | 0
 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh    | 0
 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh          | 0
 tools/testing/selftests/damon/debugfs_schemes.sh                  | 0
 tools/testing/selftests/damon/debugfs_target_ids.sh               | 0
 tools/testing/selftests/damon/lru_sort.sh                         | 0
 tools/testing/selftests/damon/reclaim.sh                          | 0
 tools/testing/selftests/damon/sysfs.sh                            | 0
 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh  | 0
 13 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/_debugfs_common.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/lru_sort.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/reclaim.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/_debugfs_common.sh b/tools/testing/selftests/damon/_debugfs_common.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/reclaim.sh b/tools/testing/selftests/damon/reclaim.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
old mode 100644
new mode 100755
-- 
2.39.1

