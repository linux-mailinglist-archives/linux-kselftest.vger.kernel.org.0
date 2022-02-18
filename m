Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1D4BAE08
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 01:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiBRALN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 19:11:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiBRALM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 19:11:12 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53F85A080
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 16:10:51 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id 9-20020a170902c20900b0014dc0faf52fso2712535pll.14
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 16:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ul9ql+iTTqhmnlSj4FQU1B61ZnFvUpp625JIDr00zP4=;
        b=iH0hw9sZO5T5mXF+KYFTa+2aLpNRgCpfDuQHrqWxG2sXpZp0YnDim2M8RFWV9YtzML
         Ow7XdaKDxc3G36WtKpfkpAUfP+JbaGhPsimDgGaDpXYx7jGjs7ptvrE7FAdQ0/Yk7Tlx
         DYNS4mPJnrfuu+KnlCGhQeMAkBig8Gr1G/D0fZm1CeEY84pksOYTZ9y3mYeqptRY/8eQ
         AcAPz2OhNF29ULrSA3t2VuT/lyxxzeJURYrIqRsV2f7PSjglFuZDMg/CDy2miYl1piRz
         mIpZbbPrBULZ26/YvB7Oh4OaI+Lvt0R9vz5b80Vk72uTShY2r7HURgyGiX5YArlzvner
         I6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ul9ql+iTTqhmnlSj4FQU1B61ZnFvUpp625JIDr00zP4=;
        b=U0dF+ZpNKZD4yQ4JPOfDJKIIlt47hS0MTcuPu3fOjvyp15NkwuBN+dFSceTnGNMTbe
         VY/fgqZLxYn/elohMoczH7+iHNJMv3etqzCA3rnpj6rd2kraBXS6vX3LeDJRGCLtHuIP
         deAbLvDfz+tCuAiWx7TGV//7TWXlWY25nfzW6Unz2nuJnFR+vzUr6sLb5BWnTudlu5tx
         1njrKkVQ65wTkPllbqi6q012CASVvDaRMdrsFpzqwcHzAyg7NWl5JbagDSyJaO6ZRJBx
         N8MMWDEgLgQLv+fUYl7kkLcQFAcSdwol4ND5Noz5vjC8AP1pcfGb7ObIYckVtkiCjyYj
         wYjw==
X-Gm-Message-State: AOAM531kvubsg4atVfeg3cuQQwN/g5tTYhim7VMaQV92Z3Al5to0zAZy
        fhjJCJS/Fcju0kFswJtY+bXhImNEIFjA
X-Google-Smtp-Source: ABdhPJwJx6GIX6LgiSK01ZSWDh5SGAPZYM15TgQTkYGKEeBrUyiZ5+c7zaNW6Fh2AcMdFSwgXC0DE8F64Xj1
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e51])
 (user=yuanchu job=sendgmr) by 2002:a05:6a00:8d1:b0:4c9:f1a0:e0d0 with SMTP id
 s17-20020a056a0008d100b004c9f1a0e0d0mr5396873pfu.53.1645143043680; Thu, 17
 Feb 2022 16:10:43 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:10:15 +0000
Message-Id: <20220218001017.3500673-1-yuanchu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 0/2] selftests/damon: trivial fixes
From:   Yuanchu Xie <yuanchu@google.com>
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches fixes trivial errors with building
and running DAMON selftests.

Yuanchu Xie (2):
  selftests/damon: add damon to selftests root Makefile
  selftests/damon: make selftests executable

 tools/testing/selftests/Makefile                               | 1 +
 tools/testing/selftests/damon/debugfs_attrs.sh                 | 0
 tools/testing/selftests/damon/debugfs_empty_targets.sh         | 0
 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh | 0
 tools/testing/selftests/damon/debugfs_schemes.sh               | 0
 tools/testing/selftests/damon/debugfs_target_ids.sh            | 0
 6 files changed, 1 insertion(+)
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh

-- 
2.35.1.265.g69c8d7142f-goog

